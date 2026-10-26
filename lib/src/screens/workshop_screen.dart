import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ingredient_visual.dart';
import '../models/ingredient.dart';
import '../models/potion.dart';
import '../game/brewing_game.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';

class WorkshopScreen extends StatefulWidget {
  final String? initialPotionId;
  final VoidCallback? onPotionBrewed;

  const WorkshopScreen({
    super.key,
    this.initialPotionId,
    this.onPotionBrewed,
  });

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  Potion? _selectedPotion;
  List<Ingredient> _selectedIngredients = [];
  bool _isBrewing = false;

  @override
  void initState() {
    super.initState();
    _checkInitialPotion();
  }

  @override
  void didUpdateWidget(WorkshopScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPotionId != oldWidget.initialPotionId &&
        widget.initialPotionId != null) {
      _checkInitialPotion();
    }
  }

  void _checkInitialPotion() {
    if (widget.initialPotionId != null) {
      final potion = Potion.getById(widget.initialPotionId!);
      if (potion != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _selectedPotion = potion;
            _selectedIngredients = potion.ingredientIds
                .map((id) => Ingredient.getById(id))
                .whereType<Ingredient>()
                .toList();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: _isBrewing
          ? BrewingGame(
              potion: _selectedPotion ?? _createCustomPotion(),
              ingredients: _selectedIngredients,
              onComplete: _onBrewingComplete,
            )
          : _buildWorkshopContent(),
    );
  }


  Widget _buildWorkshopContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCauldronSection(),
            const SizedBox(height: 24),
            _buildQuickStartSection(),
            const SizedBox(height: 24),
            _buildIngredientsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCauldronSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.ornateCard(
        borderColor: AppTheme.goldPrimary,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.cauldronGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.goldPrimary.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.science_outlined,
              color: AppTheme.goldAccent,
              size: 64,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _selectedPotion == null
                ? 'Alchemist\'s Cauldron'
                : _selectedPotion!.name,
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.goldAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _selectedIngredients.isEmpty
                ? 'Select ingredients from below'
                : '${_selectedIngredients.length} ingredients ready',
            style: AppTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (_selectedIngredients.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _selectedIngredients.map((ing) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ing.rarityColor.withOpacity(0.2),
                    borderRadius: AppTheme.radiusSmall,
                    border: Border.all(
                      color: ing.rarityColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ing.name,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIngredients.remove(ing);
                            if (_selectedPotion != null) {
                              _selectedPotion = null;
                            }
                          });
                        },
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedIngredients.clear();
                      _selectedPotion = null;
                    });
                  },
                  icon: const Icon(Icons.clear_all, size: 18),
                  label: const Text('Clear'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    side: BorderSide(color: AppTheme.textMuted),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _selectedIngredients.isNotEmpty
                      ? () {
                          setState(() => _isBrewing = true);
                        }
                      : null,
                  icon: const Icon(Icons.auto_fix_high, size: 20),
                  label: const Text('Start Brewing'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldAccent,
                    foregroundColor: AppTheme.bgDark,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    elevation: 4,
                    disabledBackgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickStartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Start Recipes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Perfect for beginners',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        ...Potion.starter.map((potion) => _buildPotionCard(potion)),
        const SizedBox(height: 24),
        const Text(
          'Advanced Recipes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'More complex brewing techniques',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        ...Potion.advanced.map((potion) => _buildPotionCard(potion)),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.stars, color: Color(0xFFFFAB40), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Legendary Recipes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Ultimate alchemy challenges',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        ...Potion.legendary.map((potion) => _buildPotionCard(potion)),
      ],
    );
  }

  Widget _buildPotionCard(Potion potion) {
    final isSelected = _selectedPotion?.id == potion.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: isSelected
          ? AppTheme.ornateCard(borderColor: AppTheme.goldAccent)
          : AppTheme.glassEffect(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _selectedPotion = potion;
              _selectedIngredients = potion.ingredientIds
                  .map((id) => Ingredient.getById(id))
                  .whereType<Ingredient>()
                  .toList();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(potion.category).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(potion.category),
                        color: _getCategoryColor(potion.category),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            potion.name,
                            style: AppTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            potion.description,
                            style: AppTheme.bodyMedium.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(potion.category)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _getCategoryColor(potion.category)
                                    .withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _getCategoryName(potion.category),
                              style: TextStyle(
                                color: _getCategoryColor(potion.category),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      ElevatedButton(
                        onPressed: () {
                          setState(() => _isBrewing = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldAccent,
                          foregroundColor: AppTheme.bgDark,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text('Brew'),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.thermostat,
                      '${potion.temperature}°C',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.timer,
                      '${potion.brewTime}s',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.monetization_on,
                      '+${potion.reward}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.bgLight,
        borderRadius: AppTheme.radiusSmall,
        border: Border.all(
          color: AppTheme.goldPrimary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF7C4DFF), size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Available Ingredients',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: _showAllIngredients,
              icon: const Icon(Icons.grid_view, size: 16),
              label: const Text('View All (52)'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFFAB40),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to add • Long press to remove',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 12, // Show only first 12 in main view
          itemBuilder: (context, index) {
            final ingredient = Ingredient.all[index];
            return _buildIngredientCard(ingredient);
          },
        ),
      ],
    );
  }

  void _showAllIngredients() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F0E17),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'All Ingredients (52)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: Ingredient.all.length,
                  itemBuilder: (context, index) {
                    final ingredient = Ingredient.all[index];
                    return _buildIngredientCard(ingredient);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIngredientCard(Ingredient ingredient) {
    final isSelected = _selectedIngredients.contains(ingredient);
    final selectedCount = _selectedIngredients.where((i) => i.id == ingredient.id).length;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? ingredient.rarityColor.withValues(alpha: 0.2)
            : const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? ingredient.rarityColor
              : ingredient.rarityColor.withValues(alpha: 0.4),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedIngredients.add(ingredient);
              // Clear selected potion when manually adding
              if (_selectedPotion != null) {
                _selectedPotion = null;
              }
            });
          },
          onLongPress: () {
            // Remove ingredient on long press
            setState(() {
              _selectedIngredients.remove(ingredient);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ingredient.rarityColor,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: IngredientVisual(ingredient: ingredient, size: 42),
                      ),
                    ),
                    if (selectedCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ingredient.rarityColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            '$selectedCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  ingredient.name,
                  style: TextStyle(
                    color: isSelected ? ingredient.rarityColor : Colors.white,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBrewingComplete(bool success, int quality) {
    final gameService = context.read<GameService>();
    final completedPotion = _selectedPotion ?? _createCustomPotion();

    if (success) {
      // Calculate reward based on quality
      final baseReward = completedPotion.reward;
      final qualityMultiplier = quality / 100;
      final finalReward = (baseReward * qualityMultiplier).round();

      // Save progress
      gameService.completeBrewing(
        potionId: completedPotion.id,
        quality: quality,
        reward: finalReward,
      );

      // Unlock ingredients used
      for (var ingredient in _selectedIngredients) {
        gameService.unlockIngredient(ingredient.id);
      }

      if (widget.onPotionBrewed != null) {
        widget.onPotionBrewed!();
      }

      // Show success with rewards
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✨ Brewing Complete!',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text('Quality: $quality%'),
              Text('Coins Earned: +$finalReward 💰'),
              Text('Experience: +${(quality / 10).round()} ⭐'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Brewing failed. Try again!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isBrewing = false;
      _selectedPotion = null;
      _selectedIngredients = [];
    });
  }

  IconData _getCategoryIcon(PotionCategory category) {
    switch (category) {
      case PotionCategory.healing:
        return Icons.favorite;
      case PotionCategory.mana:
        return Icons.water_drop;
      case PotionCategory.buff:
        return Icons.trending_up;
      case PotionCategory.defense:
        return Icons.shield;
      case PotionCategory.utility:
        return Icons.build;
      case PotionCategory.combat:
        return Icons.flash_on;
      case PotionCategory.legendary:
        return Icons.stars;
    }
  }

  Color _getCategoryColor(PotionCategory category) {
    switch (category) {
      case PotionCategory.healing:
        return Colors.red;
      case PotionCategory.mana:
        return Colors.blue;
      case PotionCategory.buff:
        return Colors.orange;
      case PotionCategory.defense:
        return Colors.green;
      case PotionCategory.utility:
        return Colors.purple;
      case PotionCategory.combat:
        return Colors.amber;
      case PotionCategory.legendary:
        return const Color(0xFFFFAB40);
    }
  }

  String _getCategoryName(PotionCategory category) {
    switch (category) {
      case PotionCategory.healing:
        return 'Healing';
      case PotionCategory.mana:
        return 'Mana';
      case PotionCategory.buff:
        return 'Buff';
      case PotionCategory.defense:
        return 'Defense';
      case PotionCategory.utility:
        return 'Utility';
      case PotionCategory.combat:
        return 'Combat';
      case PotionCategory.legendary:
        return 'Legendary';
    }
  }

  Potion _createCustomPotion() {
    // Create a custom experimental potion with selected ingredients
    return Potion(
      id: 'custom_experiment',
      name: 'Experimental Potion',
      category: PotionCategory.utility,
      ingredientIds: _selectedIngredients.map((i) => i.id).toList(),
      temperature: 65, // Default temperature
      stirSpeed: StirSpeed.normal,
      brewTime: 40,
      reward: _calculateCustomReward(),
      description: 'A custom experimental potion created by the alchemist',
    );
  }

  int _calculateCustomReward() {
    // Calculate reward based on ingredients' rarity and power
    int totalPower = 0;
    for (var ingredient in _selectedIngredients) {
      totalPower += ingredient.power;
      // Add bonus for rarity
      switch (ingredient.rarity) {
        case IngredientRarity.common:
          totalPower += 10;
          break;
        case IngredientRarity.uncommon:
          totalPower += 25;
          break;
        case IngredientRarity.rare:
          totalPower += 50;
          break;
        case IngredientRarity.epic:
          totalPower += 100;
          break;
        case IngredientRarity.legendary:
          totalPower += 200;
          break;
      }
    }
    return totalPower.clamp(50, 2000);
  }
}
