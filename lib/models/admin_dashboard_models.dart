class AdminDashboardModel {
  final int totalProducts;
  final int lowStock;
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final String revenueTotal;
  final String revenueNet;
  final List<RecentOrder> recentOrders;

  AdminDashboardModel({
    required this.totalProducts,
    required this.lowStock,
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.revenueTotal,
    required this.revenueNet,
    required this.recentOrders,
  });

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final stats = data["stats"];

    return AdminDashboardModel(
      totalProducts: stats["products"]["total"],
      lowStock: stats["products"]["low_stock"],
      totalOrders: stats["orders"]["total"],
      pendingOrders: int.parse(stats["orders"]["pending"]),
      completedOrders: int.parse(stats["orders"]["completed"]),
      revenueTotal: stats["revenue"]["total"],
      revenueNet: stats["revenue"]["net"],
      recentOrders: List<RecentOrder>.from(
        data["recent_orders"].map((x) => RecentOrder.fromJson(x)),
      ),
    );
  }
}

class RecentOrder {
  final String code;
  final String username;
  final String total;
  final String status;

  RecentOrder({
    required this.code,
    required this.username,
    required this.total,
    required this.status,
  });

  factory RecentOrder.fromJson(Map<String, dynamic> json) {
    return RecentOrder(
      code: json["order_code"],
      username: json["user"]["username"],
      total: json["total_amount"],
      status: json["status"],
    );
  }
}
