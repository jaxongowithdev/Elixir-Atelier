enum PotionCategory { healing, mana, buff, defense, utility, combat, legendary }

enum StirSpeed { slow, normal, fast }

class Potion {
  final String id;
  final String name;
  final PotionCategory category;
  final List<String> ingredientIds;
  final int temperature; // 0-100
  final StirSpeed stirSpeed;
  final int brewTime; // seconds
  final int reward;
  final String description;
  final bool isUnlocked;

  const Potion({
    required this.id,
    required this.name,
    required this.category,
    required this.ingredientIds,
    required this.temperature,
    required this.stirSpeed,
    required this.brewTime,
    required this.reward,
    required this.description,
    this.isUnlocked = false,
  });

  Potion copyWith({bool? isUnlocked}) {
    return Potion(
      id: id,
      name: name,
      category: category,
      ingredientIds: ingredientIds,
      temperature: temperature,
      stirSpeed: stirSpeed,
      brewTime: brewTime,
      reward: reward,
      description: description,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  // Starting recipes - unlocked by default
  static const List<Potion> starter = [
    Potion(
      id: 'healing_basic',
      name: 'Healing Potion',
      category: PotionCategory.healing,
      ingredientIds: ['2_of_hearts', '2_of_diamonds', '2_of_spades'],
      temperature: 65,
      stirSpeed: StirSpeed.normal,
      brewTime: 30,
      reward: 120,
      description: 'Restores health. The most basic healing potion.',
      isUnlocked: true,
    ),
    Potion(
      id: 'mana_basic',
      name: 'Mana Potion',
      category: PotionCategory.mana,
      ingredientIds: ['queen_of_diamonds', 'jack_of_hearts', '8_of_spades'],
      temperature: 55,
      stirSpeed: StirSpeed.slow,
      brewTime: 35,
      reward: 150,
      description: 'Restores magical energy.',
      isUnlocked: true,
    ),
    Potion(
      id: 'stamina_basic',
      name: 'Stamina Potion',
      category: PotionCategory.buff,
      ingredientIds: ['9_of_hearts', '6_of_diamonds', '10_of_clubs'],
      temperature: 70,
      stirSpeed: StirSpeed.fast,
      brewTime: 25,
      reward: 110,
      description: 'Increases endurance temporarily.',
      isUnlocked: true,
    ),
  ];

  // Advanced recipes
  static const List<Potion> advanced = [
    Potion(
      id: 'fire_resist',
      name: 'Fire Resistance',
      category: PotionCategory.defense,
      ingredientIds: ['10_of_diamonds', 'king_of_clubs', 'king_of_spades'],
      temperature: 85,
      stirSpeed: StirSpeed.normal,
      brewTime: 40,
      reward: 280,
      description: 'Grants resistance to fire damage.',
    ),
    Potion(
      id: 'invisibility',
      name: 'Invisibility Potion',
      category: PotionCategory.utility,
      ingredientIds: ['8_of_hearts', 'ace_of_clubs', 'jack_of_spades'],
      temperature: 42,
      stirSpeed: StirSpeed.slow,
      brewTime: 50,
      reward: 350,
      description: 'Grants temporary invisibility.',
    ),
    Potion(
      id: 'strength',
      name: 'Strength Potion',
      category: PotionCategory.buff,
      ingredientIds: ['10_of_clubs', '9_of_clubs', 'king_of_spades'],
      temperature: 75,
      stirSpeed: StirSpeed.fast,
      brewTime: 35,
      reward: 220,
      description: 'Greatly increases physical strength.',
    ),
    Potion(
      id: 'poison_cure',
      name: 'Poison Cure',
      category: PotionCategory.healing,
      ingredientIds: ['2_of_hearts', '4_of_hearts', '2_of_diamonds'],
      temperature: 60,
      stirSpeed: StirSpeed.normal,
      brewTime: 30,
      reward: 180,
      description: 'Cures all poison effects.',
    ),
    Potion(
      id: 'speed',
      name: 'Speed Potion',
      category: PotionCategory.buff,
      ingredientIds: ['7_of_clubs', '5_of_hearts', '5_of_diamonds'],
      temperature: 68,
      stirSpeed: StirSpeed.fast,
      brewTime: 28,
      reward: 190,
      description: 'Increases movement speed dramatically.',
    ),
    Potion(
      id: 'night_vision',
      name: 'Night Vision',
      category: PotionCategory.utility,
      ingredientIds: ['8_of_hearts', '2_of_clubs', '7_of_spades'],
      temperature: 50,
      stirSpeed: StirSpeed.slow,
      brewTime: 32,
      reward: 160,
      description: 'See clearly in the dark.',
    ),
    Potion(
      id: 'water_breathing',
      name: 'Water Breathing',
      category: PotionCategory.utility,
      ingredientIds: ['4_of_clubs', '5_of_diamonds', '6_of_clubs'],
      temperature: 45,
      stirSpeed: StirSpeed.normal,
      brewTime: 35,
      reward: 170,
      description: 'Breathe underwater for extended periods.',
    ),
    Potion(
      id: 'regeneration',
      name: 'Regeneration Potion',
      category: PotionCategory.healing,
      ingredientIds: ['king_of_hearts', '10_of_hearts', 'ace_of_diamonds'],
      temperature: 72,
      stirSpeed: StirSpeed.slow,
      brewTime: 45,
      reward: 320,
      description: 'Slowly regenerates health over time.',
    ),
  ];

  // Legendary recipes
  static const List<Potion> legendary = [
    Potion(
      id: 'elixir_life',
      name: 'Elixir of Life',
      category: PotionCategory.legendary,
      ingredientIds: ['ace_of_hearts', 'ace_of_diamonds', 'ace_of_spades'],
      temperature: 80,
      stirSpeed: StirSpeed.slow,
      brewTime: 90,
      reward: 1000,
      description: 'The legendary potion that grants immortality.',
    ),
    Potion(
      id: 'philosophers_brew',
      name: 'Philosopher\'s Brew',
      category: PotionCategory.legendary,
      ingredientIds: ['ace_of_spades', 'king_of_diamonds', 'queen_of_clubs'],
      temperature: 88,
      stirSpeed: StirSpeed.normal,
      brewTime: 120,
      reward: 1500,
      description: 'Transforms base metals into gold.',
    ),
    Potion(
      id: 'dragon_essence',
      name: 'Dragon Essence',
      category: PotionCategory.legendary,
      ingredientIds: ['king_of_clubs', 'king_of_spades', 'queen_of_clubs'],
      temperature: 95,
      stirSpeed: StirSpeed.fast,
      brewTime: 80,
      reward: 1200,
      description: 'Grants the power of dragons.',
    ),
  ];

  static List<Potion> get all => [...starter, ...advanced, ...legendary];

  static Potion? getById(String id) {
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
