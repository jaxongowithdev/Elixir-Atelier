import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildProfileContent(),
          ),
        ],
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
      child: const Row(
        children: [
          Icon(
            Icons.person,
            color: Color(0xFFFFAB40),
            size: 28,
          ),
          SizedBox(width: 12),
          Text(
            'Alchemist Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAlchemistCard(),
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 16),
            _buildProgressSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlchemistCard() {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A237E).withValues(alpha: 0.8),
            const Color(0xFF311B92).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFAB40).withValues(alpha: 0.2),
              border: Border.all(
                color: const Color(0xFFFFAB40),
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFFFFAB40),
              size: 60,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Master Alchemist',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFAB40).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFAB40),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.stars,
                  color: Color(0xFFFFAB40),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Level ${gameService.level}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickStat(Icons.monetization_on, '${gameService.coins}', 'Coins'),
              Container(
                width: 1,
                height: 40,
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
              ),
              _buildQuickStat(Icons.star, '${gameService.experience}', 'Experience'),
            ],
          ),
        ],
      ),
        );
      },
    );
  }

  Widget _buildQuickStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFFFAB40), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.science,
                    '${gameService.totalPotionsBrewed}',
                    'Potions\nBrewed',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.check_circle,
                    '${gameService.state.completedOrders.length}',
                    'Orders\nCompleted',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.book,
                    '${gameService.state.unlockedRecipes.length}',
                    'Recipes\nUnlocked',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.diamond,
                    '${gameService.perfectBrews}',
                    'Perfect\nBrews',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFFFAB40), size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        final nextLevel = gameService.level + 1;
        final currentExp = gameService.experience;
        final expNeeded = gameService.state.experienceToNextLevel;
        final progress = expNeeded > 0 ? currentExp / expNeeded : 0.0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF16213E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress to Level $nextLevel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFF1A237E),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFFFAB40)),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$currentExp / $expNeeded XP',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}
