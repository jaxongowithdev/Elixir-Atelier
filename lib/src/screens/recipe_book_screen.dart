import 'package:flutter/material.dart';
import '../widgets/ingredient_visual.dart';
import '../models/potion.dart';
import '../models/ingredient.dart';

class RecipeBookScreen extends StatefulWidget {
  const RecipeBookScreen({super.key});

  @override
  State<RecipeBookScreen> createState() => _RecipeBookScreenState();
}

class _RecipeBookScreenState extends State<RecipeBookScreen> {
  PotionCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryFilter(),
            Expanded(
              child: _buildRecipesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF7C4DFF).withValues(alpha: 0.2),
            const Color(0xFF3F51B5).withValues(alpha: 0.1),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.book,
                color: Color(0xFFFFAB40),
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Recipe Book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Discover and master potion recipes',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryChip('All', null),
          ...PotionCategory.values.map((category) {
            return _buildCategoryChip(
              _getCategoryName(category),
              category,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, PotionCategory? category) {
    final isSelected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
          });
        },
        backgroundColor: const Color(0xFF16213E),
        selectedColor: const Color(0xFFFFAB40).withValues(alpha: 0.3),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFFFFAB40) : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected
              ? const Color(0xFFFFAB40)
              : const Color(0xFF7C4DFF).withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildRecipesList() {
    final potions = _selectedCategory == null
        ? Potion.all
        : Potion.all.where((p) => p.category == _selectedCategory).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: potions.length,
      itemBuilder: (context, index) {
        return _buildRecipeCard(potions[index]);
      },
    );
  }

  Widget _buildRecipeCard(Potion potion) {
    // For MVP, show all as unlocked
    final isUnlocked = true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getCategoryColor(potion.category).withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isUnlocked ? () => _showRecipeDetails(potion) : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(potion.category)
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(potion.category),
                        color: _getCategoryColor(potion.category),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isUnlocked ? potion.name : '???',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _getCategoryName(potion.category),
                            style: TextStyle(
                              color: _getCategoryColor(potion.category),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isUnlocked)
                      const Icon(
                        Icons.lock,
                        color: Colors.white38,
                      ),
                  ],
                ),
                if (isUnlocked) ...[
                  const SizedBox(height: 12),
                  Text(
                    potion.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
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
        color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
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

  void _showRecipeDetails(Potion potion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              _getCategoryIcon(potion.category),
              color: _getCategoryColor(potion.category),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                potion.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                potion.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingredients Required:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...potion.ingredientIds.map((id) {
                final ingredient = Ingredient.getById(id);
                if (ingredient == null) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: ingredient.rarityColor,
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: IngredientVisual(ingredient: ingredient, size: 34),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ingredient.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              const Text(
                'Brewing Details:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Temperature: ${potion.temperature}°C',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Stir Speed: ${_getStirSpeedText(potion.stirSpeed)}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Brew Time: ${potion.brewTime} seconds',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Reward: ${potion.reward} coins',
                style: const TextStyle(color: Color(0xFFFFAB40)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
        return Colors.deepOrange;
    }
  }

  String _getStirSpeedText(StirSpeed speed) {
    switch (speed) {
      case StirSpeed.slow:
        return 'Slow';
      case StirSpeed.normal:
        return 'Normal';
      case StirSpeed.fast:
        return 'Fast';
    }
  }
}
