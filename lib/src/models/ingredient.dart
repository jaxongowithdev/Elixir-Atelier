import 'package:flutter/material.dart';

enum IngredientType { mineral, plant, liquid, creature }

enum IngredientElement { earth, fire, water, air, light, dark }

enum IngredientRarity { common, uncommon, rare, epic, legendary }

class Ingredient {
  final String id;
  final String name;
  final IngredientType type;
  final IngredientElement element;
  final IngredientRarity rarity;
  final int purity;
  final int power;
  final int stability;

  const Ingredient({
    required this.id,
    required this.name,
    required this.type,
    required this.element,
    required this.rarity,
    required this.purity,
    required this.power,
    required this.stability,
  });

  Color get rarityColor {
    switch (rarity) {
      case IngredientRarity.common:
        return Colors.grey;
      case IngredientRarity.uncommon:
        return Colors.green;
      case IngredientRarity.rare:
        return Colors.blue;
      case IngredientRarity.epic:
        return Colors.purple;
      case IngredientRarity.legendary:
        return Colors.orange;
    }
  }

  Color get typeColor {
    switch (type) {
      case IngredientType.mineral:
        return const Color(0xFF795548);
      case IngredientType.plant:
        return const Color(0xFF4CAF50);
      case IngredientType.liquid:
        return const Color(0xFF2196F3);
      case IngredientType.creature:
        return const Color(0xFF9C27B0);
    }
  }

  // Alchemy ingredients grouped by type (minerals, plants, liquids, creatures)
  static const List<Ingredient> all = [
    // ♠ Minerals (13 cards)
    Ingredient(
      id: '2_of_spades',
      name: 'Iron Dust',
      type: IngredientType.mineral,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 80,
      power: 30,
      stability: 90,
    ),
    Ingredient(
      id: '3_of_spades',
      name: 'Copper Ore',
      type: IngredientType.mineral,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 75,
      power: 35,
      stability: 85,
    ),
    Ingredient(
      id: '4_of_spades',
      name: 'Salt Crystal',
      type: IngredientType.mineral,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 95,
      power: 20,
      stability: 95,
    ),
    Ingredient(
      id: '5_of_spades',
      name: 'Silver Sand',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.uncommon,
      purity: 85,
      power: 45,
      stability: 80,
    ),
    Ingredient(
      id: '6_of_spades',
      name: 'Coal Fragment',
      type: IngredientType.mineral,
      element: IngredientElement.fire,
      rarity: IngredientRarity.common,
      purity: 70,
      power: 40,
      stability: 75,
    ),
    Ingredient(
      id: '7_of_spades',
      name: 'Quartz Stone',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.uncommon,
      purity: 90,
      power: 50,
      stability: 85,
    ),
    Ingredient(
      id: '8_of_spades',
      name: 'Crystal Stone',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.rare,
      purity: 92,
      power: 60,
      stability: 80,
    ),
    Ingredient(
      id: '9_of_spades',
      name: 'Obsidian Shard',
      type: IngredientType.mineral,
      element: IngredientElement.dark,
      rarity: IngredientRarity.rare,
      purity: 88,
      power: 70,
      stability: 75,
    ),
    Ingredient(
      id: '10_of_spades',
      name: 'Mithril Powder',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 95,
      power: 80,
      stability: 85,
    ),
    Ingredient(
      id: 'jack_of_spades',
      name: 'Moon Ore',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 93,
      power: 85,
      stability: 80,
    ),
    Ingredient(
      id: 'queen_of_spades',
      name: 'Star Metal',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 96,
      power: 90,
      stability: 82,
    ),
    Ingredient(
      id: 'king_of_spades',
      name: 'Dragon Ore',
      type: IngredientType.mineral,
      element: IngredientElement.fire,
      rarity: IngredientRarity.legendary,
      purity: 98,
      power: 95,
      stability: 88,
    ),
    Ingredient(
      id: 'ace_of_spades',
      name: 'Philosopher Stone',
      type: IngredientType.mineral,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 100,
      power: 100,
      stability: 90,
    ),

    // ♥ Plants (13 cards)
    Ingredient(
      id: '2_of_hearts',
      name: 'Mint Leaf',
      type: IngredientType.plant,
      element: IngredientElement.water,
      rarity: IngredientRarity.common,
      purity: 85,
      power: 25,
      stability: 90,
    ),
    Ingredient(
      id: '3_of_hearts',
      name: 'Sage Herb',
      type: IngredientType.plant,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 80,
      power: 30,
      stability: 88,
    ),
    Ingredient(
      id: '4_of_hearts',
      name: 'Lavender',
      type: IngredientType.plant,
      element: IngredientElement.air,
      rarity: IngredientRarity.common,
      purity: 82,
      power: 28,
      stability: 92,
    ),
    Ingredient(
      id: '5_of_hearts',
      name: 'Red Flower',
      type: IngredientType.plant,
      element: IngredientElement.fire,
      rarity: IngredientRarity.uncommon,
      purity: 86,
      power: 40,
      stability: 85,
    ),
    Ingredient(
      id: '6_of_hearts',
      name: 'Blue Petal',
      type: IngredientType.plant,
      element: IngredientElement.water,
      rarity: IngredientRarity.uncommon,
      purity: 84,
      power: 42,
      stability: 83,
    ),
    Ingredient(
      id: '7_of_hearts',
      name: 'Moonflower',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.uncommon,
      purity: 88,
      power: 48,
      stability: 81,
    ),
    Ingredient(
      id: '8_of_hearts',
      name: 'Night Moss',
      type: IngredientType.plant,
      element: IngredientElement.dark,
      rarity: IngredientRarity.rare,
      purity: 87,
      power: 55,
      stability: 78,
    ),
    Ingredient(
      id: '9_of_hearts',
      name: 'Sunfruit',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.rare,
      purity: 90,
      power: 62,
      stability: 80,
    ),
    Ingredient(
      id: '10_of_hearts',
      name: 'Golden Herb',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 92,
      power: 72,
      stability: 84,
    ),
    Ingredient(
      id: 'jack_of_hearts',
      name: 'Spirit Root',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 93,
      power: 78,
      stability: 82,
    ),
    Ingredient(
      id: 'queen_of_hearts',
      name: 'Phoenix Flower',
      type: IngredientType.plant,
      element: IngredientElement.fire,
      rarity: IngredientRarity.epic,
      purity: 94,
      power: 85,
      stability: 80,
    ),
    Ingredient(
      id: 'king_of_hearts',
      name: 'Life Blossom',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 97,
      power: 92,
      stability: 86,
    ),
    Ingredient(
      id: 'ace_of_hearts',
      name: 'World Tree Seed',
      type: IngredientType.plant,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 99,
      power: 98,
      stability: 88,
    ),

    // ♦ Liquids (13 cards)
    Ingredient(
      id: '2_of_diamonds',
      name: 'Pure Water',
      type: IngredientType.liquid,
      element: IngredientElement.water,
      rarity: IngredientRarity.common,
      purity: 100,
      power: 15,
      stability: 95,
    ),
    Ingredient(
      id: '3_of_diamonds',
      name: 'Rain Water',
      type: IngredientType.liquid,
      element: IngredientElement.water,
      rarity: IngredientRarity.common,
      purity: 90,
      power: 20,
      stability: 93,
    ),
    Ingredient(
      id: '4_of_diamonds',
      name: 'Honey',
      type: IngredientType.liquid,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 88,
      power: 25,
      stability: 90,
    ),
    Ingredient(
      id: '5_of_diamonds',
      name: 'Spring Water',
      type: IngredientType.liquid,
      element: IngredientElement.water,
      rarity: IngredientRarity.uncommon,
      purity: 92,
      power: 35,
      stability: 88,
    ),
    Ingredient(
      id: '6_of_diamonds',
      name: 'Tree Sap',
      type: IngredientType.liquid,
      element: IngredientElement.earth,
      rarity: IngredientRarity.uncommon,
      purity: 85,
      power: 38,
      stability: 86,
    ),
    Ingredient(
      id: '7_of_diamonds',
      name: 'Fairy Tears',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.uncommon,
      purity: 94,
      power: 45,
      stability: 84,
    ),
    Ingredient(
      id: '8_of_diamonds',
      name: 'Magic Oil',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.rare,
      purity: 91,
      power: 58,
      stability: 80,
    ),
    Ingredient(
      id: '9_of_diamonds',
      name: 'Void Essence',
      type: IngredientType.liquid,
      element: IngredientElement.dark,
      rarity: IngredientRarity.rare,
      purity: 89,
      power: 65,
      stability: 75,
    ),
    Ingredient(
      id: '10_of_diamonds',
      name: 'Lava Essence',
      type: IngredientType.liquid,
      element: IngredientElement.fire,
      rarity: IngredientRarity.epic,
      purity: 87,
      power: 75,
      stability: 72,
    ),
    Ingredient(
      id: 'jack_of_diamonds',
      name: 'Starlight Dew',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 95,
      power: 80,
      stability: 78,
    ),
    Ingredient(
      id: 'queen_of_diamonds',
      name: 'Moon Dew',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 96,
      power: 86,
      stability: 80,
    ),
    Ingredient(
      id: 'king_of_diamonds',
      name: 'Sacred Blood',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 98,
      power: 93,
      stability: 83,
    ),
    Ingredient(
      id: 'ace_of_diamonds',
      name: 'Elixir Base',
      type: IngredientType.liquid,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 100,
      power: 100,
      stability: 85,
    ),

    // ♣ Creatures (13 cards)
    Ingredient(
      id: '2_of_clubs',
      name: 'Bat Wing',
      type: IngredientType.creature,
      element: IngredientElement.dark,
      rarity: IngredientRarity.common,
      purity: 75,
      power: 35,
      stability: 80,
    ),
    Ingredient(
      id: '3_of_clubs',
      name: 'Rabbit Fur',
      type: IngredientType.creature,
      element: IngredientElement.earth,
      rarity: IngredientRarity.common,
      purity: 78,
      power: 32,
      stability: 85,
    ),
    Ingredient(
      id: '4_of_clubs',
      name: 'Fish Scale',
      type: IngredientType.creature,
      element: IngredientElement.water,
      rarity: IngredientRarity.common,
      purity: 80,
      power: 30,
      stability: 88,
    ),
    Ingredient(
      id: '5_of_clubs',
      name: 'Spider Silk',
      type: IngredientType.creature,
      element: IngredientElement.dark,
      rarity: IngredientRarity.uncommon,
      purity: 82,
      power: 44,
      stability: 78,
    ),
    Ingredient(
      id: '6_of_clubs',
      name: 'Frog Skin',
      type: IngredientType.creature,
      element: IngredientElement.water,
      rarity: IngredientRarity.uncommon,
      purity: 79,
      power: 46,
      stability: 76,
    ),
    Ingredient(
      id: '7_of_clubs',
      name: 'Eagle Feather',
      type: IngredientType.creature,
      element: IngredientElement.air,
      rarity: IngredientRarity.uncommon,
      purity: 84,
      power: 50,
      stability: 82,
    ),
    Ingredient(
      id: '8_of_clubs',
      name: 'Snake Venom',
      type: IngredientType.creature,
      element: IngredientElement.dark,
      rarity: IngredientRarity.rare,
      purity: 86,
      power: 60,
      stability: 70,
    ),
    Ingredient(
      id: '9_of_clubs',
      name: 'Bear Claw',
      type: IngredientType.creature,
      element: IngredientElement.earth,
      rarity: IngredientRarity.rare,
      purity: 83,
      power: 68,
      stability: 75,
    ),
    Ingredient(
      id: '10_of_clubs',
      name: 'Wolf Fang',
      type: IngredientType.creature,
      element: IngredientElement.earth,
      rarity: IngredientRarity.epic,
      purity: 85,
      power: 76,
      stability: 78,
    ),
    Ingredient(
      id: 'jack_of_clubs',
      name: 'Unicorn Horn',
      type: IngredientType.creature,
      element: IngredientElement.light,
      rarity: IngredientRarity.epic,
      purity: 94,
      power: 82,
      stability: 84,
    ),
    Ingredient(
      id: 'queen_of_clubs',
      name: 'Phoenix Feather',
      type: IngredientType.creature,
      element: IngredientElement.fire,
      rarity: IngredientRarity.epic,
      purity: 95,
      power: 88,
      stability: 80,
    ),
    Ingredient(
      id: 'king_of_clubs',
      name: 'Dragon Scale',
      type: IngredientType.creature,
      element: IngredientElement.fire,
      rarity: IngredientRarity.legendary,
      purity: 97,
      power: 94,
      stability: 82,
    ),
    Ingredient(
      id: 'ace_of_clubs',
      name: 'Ancient Crystal',
      type: IngredientType.creature,
      element: IngredientElement.light,
      rarity: IngredientRarity.legendary,
      purity: 99,
      power: 99,
      stability: 86,
    ),
  ];

  static Ingredient? getById(String id) {
    try {
      return all.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }
}
