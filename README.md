# Potion Works

**Master the Art of Alchemy**

A premium alchemy crafting game built with Flutter where players master the ancient art of potion brewing. Accept orders from travelers, academies, and wizards while building your reputation as the realm's finest alchemist.

## Overview

Potion Works is an immersive alchemy simulation featuring a unique golden medieval aesthetic. Players use 52 distinct ingredients to craft potions through an engaging 4-phase brewing system, earning coins and experience to unlock legendary recipes.

### Category
- Alchemy Simulation
- Crafting & Brewing
- Casual Strategy

### Platform
- iOS (iPhone & iPad)
- Android (coming soon)

### Framework
- Flutter 3.32.0
- Dart 3.4.0+
- 100% Offline

## Core Gameplay

### Brewing System
Experience an immersive 4-phase brewing process:

1. **Phase 1: Mixing** - Add each ingredient to the cauldron one by one
2. **Phase 2: Heating** - Carefully adjust temperature to match the recipe (±5°C for perfect)
3. **Phase 3: Stirring** - Tap to stir until progress reaches 100%
4. **Phase 4: Bottling** - Pour the completed potion into a bottle

### Quality & Rewards
- Brewing quality ranges from 0-100%
- Higher quality = Better rewards
- Earn coins and experience with each successful brew
- Unlock new ingredients and recipes as you level up

### Game Flow
1. Accept orders from 5 different customer types
2. Choose ingredients freely or follow recipe guidelines
3. Complete the brewing mini-game
4. Earn rewards based on quality
5. Progress through levels and unlock legendary recipes

### Session Length
3-5 minutes per brewing session

## Features

### ⚗️ Unique Golden Alchemy Theme
- **Medieval Laboratory Aesthetic** - Warm golden colors with parchment textures
- **Ornate Card Designs** - Decorative borders and glowing effects
- **Immersive UI** - Top tab navigation with professional polish
- **Distinct Visual Identity** - Completely unique from typical mobile games

### 🃏 52 Unique Alchemical Ingredients
Four elemental categories with 13 ingredients each:

- **♠ Minerals** - Earth-based materials: Iron Dust, Crystal Stone, Diamond Shard, Dragon Ore
- **♥ Plants** - Mystical flora: Mint Leaf, Rose Petal, Phoenix Flower, World Tree Seed
- **♦ Liquids** - Magical essences: Pure Water, Mercury Drop, Phoenix Tear, Elixir Base
- **♣ Creatures** - Rare components: Bat Wing, Spider Silk, Phoenix Feather, Dragon Scale

**Ingredient Properties:**
- **Type** - Mineral, Plant, Liquid, Creature
- **Element** - Earth, Fire, Water, Air, Light, Dark
- **Rarity** - Common → Uncommon → Rare → Epic → Legendary
- **Stats** - Purity (0-99), Power (0-99), Stability (0-99)

### 🧪 14 Potion Recipes
**Starter Potions** (3 recipes)
- Healing Potion, Mana Potion, Stamina Potion

**Advanced Potions** (8 recipes)
- Greater Healing, Greater Mana, Fire Resistance, Water Breathing, Strength Elixir, Speed Potion, Invisibility Potion, Night Vision

**Legendary Potions** (3 recipes)
- Elixir of Life, Phoenix Rebirth, Dragon's Essence

**Categories:**
- Healing - Restore vitality
- Mana - Magical restoration
- Buff - Temporary power
- Defense - Protection magic
- Utility - Special abilities
- Combat - Battle enhancement

### 👥 5 Customer Types
- **Village Healer** - Simple healing requests (Easy)
- **Academy Scholar** - Research potions (Medium)
- **Knight Captain** - Combat preparations (Medium-Hard)
- **Royal Alchemist** - Prestigious orders (Hard)
- **Ancient Wizard** - Legendary brews (Expert-Master)

### 📊 Progression System
- **Experience & Leveling** - Gain XP with each successful brew
- **Coin Economy** - Earn coins based on potion quality
- **Statistics Tracking** - Potions brewed, perfect brews, orders completed
- **Recipe Discovery** - Auto-unlock recipes as you use ingredients
- **Ingredient Vault** - View your complete collection (all 52 visible)

## What Makes Potion Works Unique?

1. **Premium Visual Design**
   - Hand-crafted golden medieval theme
   - Ornate UI elements with glowing effects
   - Professional parchment textures
   - Distinct from generic mobile games

2. **Engaging Gameplay Loop**
   - Free ingredient selection (not pattern matching)
   - Quality-based skill progression
   - Multiple brewing phases with mini-games
   - Order fulfillment with varied customers

3. **Deep Crafting System**
   - 52 ingredients with unique properties
   - Rarity system (Common to Legendary)
   - Element types (6 elements)
   - Stat-based ingredients (Purity, Power, Stability)

4. **Complete Progression**
   - Experience and leveling
   - Coin-based economy
   - Statistics tracking
   - Auto-unlocking recipes

## Getting Started

### Prerequisites
- Flutter SDK: **3.32.0** or higher
- Dart SDK: **3.4.0** or higher
- Xcode (for iOS) or Android Studio (for Android)

### Installation

```bash
# Navigate to example directory
cd example

# Install dependencies
flutter pub get
```

### Run the App

```bash
# Run on connected device/simulator
flutter run

# Or specify platform
flutter run -d ios
flutter run -d android
```

### Build for Release

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
```

## Project Structure

```
lib/
├── src/
│   ├── models/
│   │   ├── ingredient.dart      # 52 unique ingredients
│   │   ├── potion.dart          # 14 potion recipes
│   │   ├── order.dart           # Daily order system
│   │   └── game_state.dart      # Player progression & stats
│   ├── screens/
│   │   ├── splash_screen.dart   # Golden splash screen
│   │   ├── home_screen.dart     # Tab navigation
│   │   ├── workshop_screen.dart # Brewing interface
│   │   ├── orders_screen.dart   # Daily commissions
│   │   ├── recipe_book_screen.dart # Recipe library
│   │   ├── collection_screen.dart  # Ingredient vault
│   │   └── profile_screen.dart  # Stats & progress
│   ├── services/
│   │   └── game_service.dart    # State management
│   ├── theme/
│   │   └── app_theme.dart       # Golden alchemy theme
│   └── game/
│       └── brewing_game.dart    # 4-phase brewing system
└── potion_works.dart            # Main library export
```

## Technology Stack

- **State Management**: Provider (ChangeNotifier)
- **Graphics**: flutter_svg for ingredient cards
- **Game Engine**: Flame framework
- **Architecture**: Clean separation of models, screens, and services

## Design Philosophy

### Unique Identity
Potion Works features a completely original design system:
- **Golden Medieval Aesthetic** - Warm, inviting color palette
- **Top Tab Navigation** - Professional app structure
- **Ornate Visual Elements** - Decorative borders and glowing effects
- **Parchment Textures** - Immersive medieval atmosphere

### Gameplay Differentiation
- **Crafting Focus** - Not a memory or matching game
- **Quality-Based Rewards** - Skill-driven progression
- **Order Fulfillment System** - Unique customer interactions
- **Interactive Brewing** - Multi-phase mini-game mechanics

### App Store Compliance
Built from the ground up to meet Apple's quality standards:
- Original visual design and theme
- Unique gameplay mechanics
- High-quality user experience
- Complete feature set
- Professional polish

## Screenshots

*Coming soon - Golden medieval UI with brewing interface*

## Roadmap

### Planned Features
- [ ] Sound effects for brewing phases
- [ ] Background music
- [ ] Particle effects for mixing/stirring
- [ ] More potion recipes (expanding to 30+)
- [ ] Achievement system
- [ ] Daily challenges
- [ ] Cloud save functionality
- [ ] Leaderboards

### Future Enhancements
- [ ] Custom potion creation mode
- [ ] Workshop upgrades
- [ ] Seasonal events
- [ ] Additional customer types
- [ ] Rare ingredient discovery

## Version History

**1.0.0** (Current) - Initial Potion Works Release
- ✅ 52 unique alchemical ingredients
- ✅ 14 potion recipes across 3 difficulty tiers
- ✅ 4-phase interactive brewing system
- ✅ 5 customer types with varied orders
- ✅ Complete progression system (coins, XP, levels)
- ✅ Golden medieval UI theme
- ✅ Statistics tracking
- ✅ Ingredient vault collection
- ✅ Quality-based rewards
- ✅ Free ingredient selection mode

## Contributing

This is a proprietary project. For bug reports or feature requests, please open an issue.

## License

Copyright © 2025 Potion Works. All rights reserved.

## Credits

- **Design & Development**: Flutter Framework
- **Graphics**: SVG playing cards (public domain)
- **Concept**: Original alchemy crafting gameplay
