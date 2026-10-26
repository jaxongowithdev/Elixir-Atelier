import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'workshop_screen.dart';
import 'orders_screen.dart';
import 'recipe_book_screen.dart';
import 'collection_screen.dart';
import 'profile_screen.dart';
import '../models/order.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameService(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedPotionId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleOrderAccepted(Order order) {
    setState(() {
      _selectedPotionId = order.potionId;
      _tabController.animateTo(0); // Switch to Workshop tab
    });
  }

  void _handlePotionBrewed() {
    setState(() {
      _selectedPotionId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WorkshopScreen(
                    initialPotionId: _selectedPotionId,
                    onPotionBrewed: _handlePotionBrewed,
                  ),
                  OrdersScreen(onOrderAccepted: _handleOrderAccepted),
                  const RecipeBookScreen(),
                  const CollectionScreen(),
                  const ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Consumer<GameService>(
      builder: (context, gameService, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppTheme.parchmentGradient,
            border: Border(
              bottom: BorderSide(
                color: AppTheme.goldPrimary.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  shape: BoxShape.circle,
                  boxShadow: AppTheme.goldShadow,
                ),
                child: const Icon(
                  Icons.auto_fix_high,
                  color: AppTheme.bgDark,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elixir Atelier',
                      style: AppTheme.headingMedium.copyWith(
                        color: AppTheme.goldAccent,
                      ),
                    ),
                    Text(
                      'Master Alchemist Lab',
                      style: AppTheme.caption,
                    ),
                  ],
                ),
              ),
              _buildStatBadge(
                icon: Icons.stars,
                value: '${gameService.level}',
                color: AppTheme.mysticalPurple,
              ),
              const SizedBox(width: 8),
              _buildStatBadge(
                icon: Icons.monetization_on,
                value: '${gameService.coins}',
                color: AppTheme.goldAccent,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: AppTheme.radiusSmall,
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            value,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
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
            color: AppTheme.goldPrimary.withOpacity(0.2),
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
        labelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(
            icon: Icon(Icons.science, size: 22),
            text: 'Workshop',
          ),
          Tab(
            icon: Icon(Icons.receipt_long, size: 22),
            text: 'Orders',
          ),
          Tab(
            icon: Icon(Icons.menu_book, size: 22),
            text: 'Recipes',
          ),
          Tab(
            icon: Icon(Icons.inventory_2, size: 22),
            text: 'Vault',
          ),
          Tab(
            icon: Icon(Icons.person, size: 22),
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
