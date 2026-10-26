enum OrderDifficulty { easy, medium, hard, expert, master }

enum CustomerType { village, academy, knights, royal, wizard }

class Order {
  final String id;
  final CustomerType customer;
  final String customerName;
  final String potionId;
  final int reward;
  final int timeLimit; // seconds
  final OrderDifficulty difficulty;
  final bool isCompleted;

  const Order({
    required this.id,
    required this.customer,
    required this.customerName,
    required this.potionId,
    required this.reward,
    required this.timeLimit,
    required this.difficulty,
    this.isCompleted = false,
  });

  Order copyWith({bool? isCompleted}) {
    return Order(
      id: id,
      customer: customer,
      customerName: customerName,
      potionId: potionId,
      reward: reward,
      timeLimit: timeLimit,
      difficulty: difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  String get customerIcon {
    switch (customer) {
      case CustomerType.village:
        return '🏘️';
      case CustomerType.academy:
        return '🏛️';
      case CustomerType.knights:
        return '⚔️';
      case CustomerType.royal:
        return '👑';
      case CustomerType.wizard:
        return '🧙';
    }
  }

  static List<Order> generateDailyOrders() {
    return [
      const Order(
        id: 'order_1',
        customer: CustomerType.village,
        customerName: 'Village Healer',
        potionId: 'healing_basic',
        reward: 150,
        timeLimit: 60,
        difficulty: OrderDifficulty.easy,
      ),
      const Order(
        id: 'order_2',
        customer: CustomerType.academy,
        customerName: 'Apprentice Mage',
        potionId: 'mana_basic',
        reward: 180,
        timeLimit: 70,
        difficulty: OrderDifficulty.easy,
      ),
      const Order(
        id: 'order_3',
        customer: CustomerType.knights,
        customerName: 'Knight Captain',
        potionId: 'strength',
        reward: 280,
        timeLimit: 90,
        difficulty: OrderDifficulty.medium,
      ),
      const Order(
        id: 'order_4',
        customer: CustomerType.wizard,
        customerName: 'Archmage',
        potionId: 'invisibility',
        reward: 420,
        timeLimit: 120,
        difficulty: OrderDifficulty.hard,
      ),
      const Order(
        id: 'order_5',
        customer: CustomerType.royal,
        customerName: 'Princess',
        potionId: 'regeneration',
        reward: 500,
        timeLimit: 100,
        difficulty: OrderDifficulty.expert,
      ),
    ];
  }
}
