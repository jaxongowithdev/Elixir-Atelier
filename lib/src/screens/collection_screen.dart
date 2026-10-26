import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ingredient_visual.dart';
import '../models/ingredient.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMineralsTab(),
                _buildPlantsTab(),
                _buildLiquidsTab(),
                _buildCreaturesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.parchmentGradient,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.goldPrimary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.inventory_2,
                color: AppTheme.goldAccent,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                'Ingredient Vault',
                style: AppTheme.headingLarge.copyWith(fontSize: 26),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '52 alchemical ingredients to discover',
            style: AppTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgParchment,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.goldPrimary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.goldAccent,
        indicatorWeight: 3,
        labelColor: AppTheme.goldAccent,
        unselectedLabelColor: AppTheme.textMuted,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'Minerals'),
          Tab(text: 'Plants'),
          Tab(text: 'Liquids'),
          Tab(text: 'Creatures'),
        ],
      ),
    );
  }

  Widget _buildMineralsTab() {
    final minerals = Ingredient.all
        .where((i) => i.type == IngredientType.mineral)
        .toList();
    return _buildIngredientGrid(minerals);
  }

  Widget _buildPlantsTab() {
    final plants =
        Ingredient.all.where((i) => i.type == IngredientType.plant).toList();
    return _buildIngredientGrid(plants);
  }

  Widget _buildLiquidsTab() {
    final liquids =
        Ingredient.all.where((i) => i.type == IngredientType.liquid).toList();
    return _buildIngredientGrid(liquids);
  }

  Widget _buildCreaturesTab() {
    final creatures =
        Ingredient.all.where((i) => i.type == IngredientType.creature).toList();
    return _buildIngredientGrid(creatures);
  }

  Widget _buildIngredientGrid(List<Ingredient> ingredients) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return _buildIngredientCard(ingredients[index]);
      },
    );
  }

  Widget _buildIngredientCard(Ingredient ingredient) {
    final unlocked = context.watch<GameService>().state.unlockedIngredients;
    final isUnlocked = unlocked.contains(ingredient.id);

    return Container(
      decoration: AppTheme.ornateCard(
        borderColor: ingredient.rarityColor.withValues(alpha: 0.6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isUnlocked ? () => _showIngredientDetails(ingredient) : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ingredient.rarityColor,
                      width: 2,
                    ),
                  ),
                  child: isUnlocked
                      ? Padding(
                          padding: const EdgeInsets.all(6),
                          child: IngredientVisual(ingredient: ingredient, size: 68),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(6),
                          child: IngredientVisual.unknown(size: 68),
                        ),
                ),
                const SizedBox(height: 12),
                Text(
                  isUnlocked ? ingredient.name : '???',
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ingredient.rarityColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getRarityText(ingredient.rarity),
                    style: TextStyle(
                      color: ingredient.rarityColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  String _getElementText(IngredientElement element) {
    switch (element) {
      case IngredientElement.earth:
        return 'Earth';
      case IngredientElement.fire:
        return 'Fire';
      case IngredientElement.water:
        return 'Water';
      case IngredientElement.air:
        return 'Air';
      case IngredientElement.light:
        return 'Light';
      case IngredientElement.dark:
        return 'Dark';
    }
  }

  void _showIngredientDetails(Ingredient ingredient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ingredient.rarityColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: IngredientVisual(ingredient: ingredient, size: 64),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredient.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _getRarityText(ingredient.rarity),
                    style: TextStyle(
                      color: ingredient.rarityColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatRow('Type', _getTypeText(ingredient.type)),
            _buildStatRow('Element', _getElementText(ingredient.element)),
            const SizedBox(height: 12),
            const Text(
              'Properties',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildStatBar('Purity', ingredient.purity, Colors.blue),
            const SizedBox(height: 8),
            _buildStatBar('Power', ingredient.power, Colors.red),
            const SizedBox(height: 8),
            _buildStatBar('Stability', ingredient.stability, Colors.green),
          ],
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

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              '$value',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: const Color(0xFF1A237E),
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 6,
        ),
      ],
    );
  }

  String _getTypeText(IngredientType type) {
    switch (type) {
      case IngredientType.mineral:
        return 'Mineral';
      case IngredientType.plant:
        return 'Plant';
      case IngredientType.liquid:
        return 'Liquid';
      case IngredientType.creature:
        return 'Creature';
    }
  }
}
