import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/ingredient_visual.dart';
import '../models/ingredient.dart';
import '../models/potion.dart';

enum BrewingPhase { mixing, heating, stirring, bottling, complete }

class BrewingGame extends StatefulWidget {
  final Potion potion;
  final List<Ingredient> ingredients;
  final Function(bool success, int quality) onComplete;

  const BrewingGame({
    super.key,
    required this.potion,
    required this.ingredients,
    required this.onComplete,
  });

  @override
  State<BrewingGame> createState() => _BrewingGameState();
}

class _BrewingGameState extends State<BrewingGame>
    with SingleTickerProviderStateMixin {
  BrewingPhase _phase = BrewingPhase.mixing;
  int _currentIngredientIndex = 0;
  double _temperature = 20.0;
  double _targetTemperature = 65.0;
  double _stirProgress = 0.0;
  int _timeRemaining = 0;
  Timer? _timer;
  late AnimationController _animationController;
  int _quality = 0;

  @override
  void initState() {
    super.initState();
    _targetTemperature = widget.potion.temperature.toDouble();
    _timeRemaining = widget.potion.brewTime;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() => _timeRemaining--);
      } else {
        _failBrewing();
      }
    });
  }

  void _nextPhase() {
    setState(() {
      switch (_phase) {
        case BrewingPhase.mixing:
          _phase = BrewingPhase.heating;
          break;
        case BrewingPhase.heating:
          _phase = BrewingPhase.stirring;
          break;
        case BrewingPhase.stirring:
          _phase = BrewingPhase.bottling;
          break;
        case BrewingPhase.bottling:
          _phase = BrewingPhase.complete;
          break;
        case BrewingPhase.complete:
          break;
      }
    });

    // Call completion callback after setState completes
    if (_phase == BrewingPhase.complete) {
      Future.microtask(() => _completeBrewing());
    }
  }

  void _addIngredient() {
    if (_currentIngredientIndex < widget.ingredients.length) {
      setState(() => _currentIngredientIndex++);
      if (_currentIngredientIndex == widget.ingredients.length) {
        // Add quality points for successfully mixing all ingredients
        _quality += 25;
        Future.delayed(const Duration(milliseconds: 500), _nextPhase);
      }
    }
  }

  void _adjustTemperature(double delta) {
    setState(() {
      _temperature = (_temperature + delta).clamp(0, 100);
    });
  }

  void _checkTemperature() {
    final diff = (_temperature - _targetTemperature).abs();
    if (diff <= 5) {
      // Perfect temperature range
      _quality += 30;
      _nextPhase();
    } else if (diff <= 10) {
      // Good temperature range
      _quality += 20;
      _nextPhase();
    } else {
      _failBrewing();
    }
  }

  void _stir() {
    setState(() {
      _stirProgress += 0.1;
      if (_stirProgress >= 1.0) {
        _quality += 25;
        _nextPhase();
      }
    });
  }

  void _bottle() {
    _quality += 20;
    _nextPhase();
  }

  void _completeBrewing() {
    _timer?.cancel();
    final success = _quality >= 50;
    widget.onComplete(success, _quality.clamp(0, 100));
  }

  void _failBrewing() {
    _timer?.cancel();
    widget.onComplete(false, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A237E),
            Color(0xFF0F0E17),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildBrewingHeader(),
            Expanded(
              child: _buildPhaseContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrewingHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.potion.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getPhaseText(),
                      style: const TextStyle(
                        color: Color(0xFFFFAB40),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.red, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_timeRemaining s',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = _getPhaseProgress();
    return Column(
      children: [
        Row(
          children: [
            _buildPhaseIndicator('Mix', BrewingPhase.mixing),
            const SizedBox(width: 4),
            _buildPhaseIndicator('Heat', BrewingPhase.heating),
            const SizedBox(width: 4),
            _buildPhaseIndicator('Stir', BrewingPhase.stirring),
            const SizedBox(width: 4),
            _buildPhaseIndicator('Bottle', BrewingPhase.bottling),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFF16213E),
          valueColor: const AlwaysStoppedAnimation(Color(0xFFFFAB40)),
          minHeight: 4,
        ),
      ],
    );
  }

  Widget _buildPhaseIndicator(String label, BrewingPhase phase) {
    final isActive = _phase == phase;
    final isCompleted = _phase.index > phase.index;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isCompleted
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : isActive
                  ? const Color(0xFFFFAB40).withValues(alpha: 0.3)
                  : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isCompleted || isActive ? Colors.white : Colors.white38,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseContent() {
    switch (_phase) {
      case BrewingPhase.mixing:
        return _buildMixingPhase();
      case BrewingPhase.heating:
        return _buildHeatingPhase();
      case BrewingPhase.stirring:
        return _buildStirringPhase();
      case BrewingPhase.bottling:
        return _buildBottlingPhase();
      case BrewingPhase.complete:
        return _buildCompletePhase();
    }
  }

  Widget _buildMixingPhase() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Add Ingredients to Cauldron',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ingredient ${_currentIngredientIndex + 1} of ${widget.ingredients.length}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            if (_currentIngredientIndex < widget.ingredients.length) ...[
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_animationController.value * 0.05),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: widget.ingredients[_currentIngredientIndex].rarityColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.ingredients[_currentIngredientIndex].rarityColor
                                .withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: IngredientVisual(
                          ingredient: widget.ingredients[_currentIngredientIndex],
                          size: 116,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.ingredients[_currentIngredientIndex].name,
                style: const TextStyle(
                  color: Color(0xFFFFAB40),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.ingredients[_currentIngredientIndex].rarityColor
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.ingredients[_currentIngredientIndex].rarityColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  _getRarityText(widget.ingredients[_currentIngredientIndex].rarity),
                  style: TextStyle(
                    color: widget.ingredients[_currentIngredientIndex].rarityColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _currentIngredientIndex < widget.ingredients.length
                ? _addIngredient
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFAB40),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add Ingredient',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      ),
    );
  }

  String _getRarityText(IngredientRarity rarity) {
    switch (rarity) {
      case IngredientRarity.common:
        return 'Common';
      case IngredientRarity.uncommon:
        return 'Uncommon';
      case IngredientRarity.rare:
        return 'Rare';
      case IngredientRarity.epic:
        return 'Epic';
      case IngredientRarity.legendary:
        return 'Legendary';
    }
  }

  Widget _buildHeatingPhase() {
    final diff = (_temperature - _targetTemperature).abs();
    String status = 'Too Cold';
    Color statusColor = Colors.blue;

    if (diff <= 5) {
      status = 'Perfect!';
      statusColor = Colors.green;
    } else if (diff <= 10) {
      status = 'Good';
      statusColor = Colors.orange;
    } else if (_temperature > _targetTemperature) {
      status = 'Too Hot';
      statusColor = Colors.red;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Control Temperature',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.thermostat, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Text(
                '${_temperature.toInt()}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ${_targetTemperature.toInt()}°C',
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTemperatureButton(
                Icons.remove,
                () => _adjustTemperature(-5),
                Colors.blue,
              ),
              const SizedBox(width: 24),
              _buildTemperatureButton(
                Icons.add,
                () => _adjustTemperature(5),
                Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _checkTemperature,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFAB40),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureButton(
    IconData icon,
    VoidCallback onPressed,
    Color color,
  ) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withValues(alpha: 0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(icon, color: Colors.white, size: 40),
        ),
      ),
    );
  }

  Widget _buildStirringPhase() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Stir the Potion',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Transform.rotate(
            angle: _stirProgress * pi * 4,
            child: const Icon(
              Icons.refresh,
              color: Color(0xFFFFAB40),
              size: 120,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '${(_stirProgress * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _stirProgress,
            backgroundColor: const Color(0xFF16213E),
            valueColor: const AlwaysStoppedAnimation(Color(0xFFFFAB40)),
            minHeight: 8,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _stir,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFAB40),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Stir',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottlingPhase() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pour into Bottle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          const Icon(
            Icons.local_bar,
            color: Color(0xFFFFAB40),
            size: 120,
          ),
          const SizedBox(height: 32),
          const Text(
            'Your potion is ready!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _bottle,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFAB40),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Bottle Potion',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletePhase() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFFFFAB40),
      ),
    );
  }

  String _getPhaseText() {
    switch (_phase) {
      case BrewingPhase.mixing:
        return 'Phase 1: Mixing Ingredients';
      case BrewingPhase.heating:
        return 'Phase 2: Heating';
      case BrewingPhase.stirring:
        return 'Phase 3: Stirring';
      case BrewingPhase.bottling:
        return 'Phase 4: Bottling';
      case BrewingPhase.complete:
        return 'Complete!';
    }
  }

  double _getPhaseProgress() {
    switch (_phase) {
      case BrewingPhase.mixing:
        return 0.25;
      case BrewingPhase.heating:
        return 0.5;
      case BrewingPhase.stirring:
        return 0.75;
      case BrewingPhase.bottling:
      case BrewingPhase.complete:
        return 1.0;
    }
  }
}
