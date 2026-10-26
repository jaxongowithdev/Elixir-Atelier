class GameState {
  final int level;
  final int coins;
  final int experience;
  final List<String> unlockedIngredients;
  final List<String> unlockedRecipes;
  final List<String> completedOrders;
  final int totalPotionsBrewed;
  final int perfectBrews;
  final Map<String, int> workshopUpgrades;

  const GameState({
    this.level = 1,
    this.coins = 500,
    this.experience = 0,
    this.unlockedIngredients = const [],
    this.unlockedRecipes = const [],
    this.completedOrders = const [],
    this.totalPotionsBrewed = 0,
    this.perfectBrews = 0,
    this.workshopUpgrades = const {},
  });

  GameState copyWith({
    int? level,
    int? coins,
    int? experience,
    List<String>? unlockedIngredients,
    List<String>? unlockedRecipes,
    List<String>? completedOrders,
    int? totalPotionsBrewed,
    int? perfectBrews,
    Map<String, int>? workshopUpgrades,
  }) {
    return GameState(
      level: level ?? this.level,
      coins: coins ?? this.coins,
      experience: experience ?? this.experience,
      unlockedIngredients: unlockedIngredients ?? this.unlockedIngredients,
      unlockedRecipes: unlockedRecipes ?? this.unlockedRecipes,
      completedOrders: completedOrders ?? this.completedOrders,
      totalPotionsBrewed: totalPotionsBrewed ?? this.totalPotionsBrewed,
      perfectBrews: perfectBrews ?? this.perfectBrews,
      workshopUpgrades: workshopUpgrades ?? this.workshopUpgrades,
    );
  }

  int get experienceToNextLevel => level * 100;

  // Workshop upgrade levels
  int get cauldronLevel => workshopUpgrades['cauldron'] ?? 1;
  int get burnerLevel => workshopUpgrades['burner'] ?? 1;
  int get stirrerLevel => workshopUpgrades['stirrer'] ?? 1;
  int get storageLevel => workshopUpgrades['storage'] ?? 1;

  static GameState initial() {
    return GameState(
      level: 1,
      coins: 500,
      experience: 0,
      unlockedIngredients: [
        // Start with common ingredients
        '2_of_spades', '3_of_spades', '4_of_spades',
        '2_of_hearts', '3_of_hearts', '4_of_hearts',
        '2_of_diamonds', '3_of_diamonds', '4_of_diamonds',
        '2_of_clubs', '3_of_clubs', '4_of_clubs',
      ],
      unlockedRecipes: [
        'healing_basic',
        'mana_basic',
        'stamina_basic',
      ],
      completedOrders: [],
      totalPotionsBrewed: 0,
      perfectBrews: 0,
      workshopUpgrades: {
        'cauldron': 1,
        'burner': 1,
        'stirrer': 1,
        'storage': 1,
      },
    );
  }
}
