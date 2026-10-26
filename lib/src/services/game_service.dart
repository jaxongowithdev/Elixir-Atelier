import 'package:flutter/foundation.dart';
import '../models/game_state.dart';
import '../models/potion.dart';

class GameService extends ChangeNotifier {
  static final GameService _instance = GameService._internal();
  factory GameService() => _instance;
  GameService._internal();

  GameState _state = GameState.initial();

  GameState get state => _state;
  int get coins => _state.coins;
  int get level => _state.level;
  int get experience => _state.experience;
  int get totalPotionsBrewed => _state.totalPotionsBrewed;
  int get perfectBrews => _state.perfectBrews;

  void addCoins(int amount) {
    _state = _state.copyWith(coins: _state.coins + amount);
    notifyListeners();
  }

  void addExperience(int amount) {
    final newExp = _state.experience + amount;
    final expNeeded = _state.experienceToNextLevel;

    if (newExp >= expNeeded) {
      // Level up!
      _state = _state.copyWith(
        level: _state.level + 1,
        experience: newExp - expNeeded,
      );
    } else {
      _state = _state.copyWith(experience: newExp);
    }
    notifyListeners();
  }

  void completeBrewing({
    required String potionId,
    required int quality,
    required int reward,
  }) {
    // Add coins
    addCoins(reward);

    // Add experience (quality based)
    final exp = (quality / 10).round(); // 10 quality = 1 exp
    addExperience(exp);

    // Increment counters
    _state = _state.copyWith(
      totalPotionsBrewed: _state.totalPotionsBrewed + 1,
      perfectBrews: quality >= 90
          ? _state.perfectBrews + 1
          : _state.perfectBrews,
    );

    // Unlock recipe if not already unlocked
    if (!_state.unlockedRecipes.contains(potionId)) {
      final newRecipes = [..._state.unlockedRecipes, potionId];
      _state = _state.copyWith(unlockedRecipes: newRecipes);
    }

    notifyListeners();
  }

  void unlockIngredient(String ingredientId) {
    if (!_state.unlockedIngredients.contains(ingredientId)) {
      final newIngredients = [..._state.unlockedIngredients, ingredientId];
      _state = _state.copyWith(unlockedIngredients: newIngredients);
      notifyListeners();
    }
  }

  void completeOrder(String orderId) {
    if (!_state.completedOrders.contains(orderId)) {
      final newOrders = [..._state.completedOrders, orderId];
      _state = _state.copyWith(completedOrders: newOrders);
      notifyListeners();
    }
  }

  void upgradeWorkshop(String upgradeType, int level) {
    final newUpgrades = Map<String, int>.from(_state.workshopUpgrades);
    newUpgrades[upgradeType] = level;
    _state = _state.copyWith(workshopUpgrades: newUpgrades);
    notifyListeners();
  }

  void reset() {
    _state = GameState.initial();
    notifyListeners();
  }
}
