import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/potion.dart';
import '../theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  final Function(Order)? onOrderAccepted;

  const OrdersScreen({super.key, this.onOrderAccepted});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Order> _orders = Order.generateDailyOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Commissions',
              style: AppTheme.headingLarge.copyWith(
                color: AppTheme.goldAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Accept orders from travelers and earn rewards',
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildOrdersList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(_orders[index]);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    final potion = Potion.getById(order.potionId);
    if (potion == null) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.ornateCard(
        borderColor: _getDifficultyColor(order.difficulty),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showOrderDetails(order, potion),
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
                        color: _getCustomerColor(order.customer)
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          order.customerIcon,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.customerName,
                            style: AppTheme.headingMedium.copyWith(fontSize: 18),
                          ),
                          Text(
                            _getCustomerTypeText(order.customer),
                            style: AppTheme.bodyMedium.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    _buildDifficultyBadge(order.difficulty),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A237E).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.science,
                        color: Color(0xFFFFAB40),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Requested Potion',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              potion.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.timer,
                      '${order.timeLimit}s',
                      Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.monetization_on,
                      '+${order.reward}',
                      const Color(0xFFFFAB40),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.onOrderAccepted != null) {
                          widget.onOrderAccepted!(order);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order accepted! Go to Workshop to brew ${potion.name}',
                              ),
                              backgroundColor: AppTheme.herbGreen,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldAccent,
                        foregroundColor: AppTheme.bgDark,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildDifficultyBadge(OrderDifficulty difficulty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _getDifficultyColor(difficulty).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getDifficultyColor(difficulty),
          width: 1,
        ),
      ),
      child: Text(
        _getDifficultyText(difficulty),
        style: TextStyle(
          color: _getDifficultyColor(difficulty),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCustomerColor(CustomerType type) {
    switch (type) {
      case CustomerType.village:
        return Colors.green;
      case CustomerType.academy:
        return Colors.blue;
      case CustomerType.knights:
        return Colors.red;
      case CustomerType.royal:
        return Colors.purple;
      case CustomerType.wizard:
        return Colors.deepPurple;
    }
  }

  String _getCustomerTypeText(CustomerType type) {
    switch (type) {
      case CustomerType.village:
        return 'Village Request';
      case CustomerType.academy:
        return 'Academy Order';
      case CustomerType.knights:
        return 'Knights Order';
      case CustomerType.royal:
        return 'Royal Commission';
      case CustomerType.wizard:
        return 'Wizard Tower';
    }
  }

  Color _getDifficultyColor(OrderDifficulty difficulty) {
    switch (difficulty) {
      case OrderDifficulty.easy:
        return Colors.green;
      case OrderDifficulty.medium:
        return Colors.yellow;
      case OrderDifficulty.hard:
        return Colors.orange;
      case OrderDifficulty.expert:
        return Colors.red;
      case OrderDifficulty.master:
        return Colors.purple;
    }
  }

  String _getDifficultyText(OrderDifficulty difficulty) {
    switch (difficulty) {
      case OrderDifficulty.easy:
        return 'Easy';
      case OrderDifficulty.medium:
        return 'Medium';
      case OrderDifficulty.hard:
        return 'Hard';
      case OrderDifficulty.expert:
        return 'Expert';
      case OrderDifficulty.master:
        return 'Master';
    }
  }

  void _showOrderDetails(Order order, Potion potion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          order.customerName,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              potion.name,
              style: const TextStyle(
                color: Color(0xFFFFAB40),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              potion.description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Text(
              'Reward: ${order.reward} coins',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Time Limit: ${order.timeLimit} seconds',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.onOrderAccepted != null) {
                widget.onOrderAccepted!(order);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Order accepted! Go to Workshop to brew ${potion.name}',
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFAB40),
            ),
            child: const Text(
              'Start Brewing',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
