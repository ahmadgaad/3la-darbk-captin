
class CommissionModel {
    final String? driverId;
    final String? totalOrders;
    final String? totalWithCash;
    final String? totalWithOnline;
    final String? totalCommission;
    final String? currentCommission;
    final String? avaliablewithdrawprofit;
    final String? totalprofit;

    CommissionModel({
        this.driverId,
        this.totalOrders,
        this.totalWithCash,
        this.totalWithOnline,
        this.totalCommission,
        this.currentCommission,
        this.avaliablewithdrawprofit,
        this.totalprofit,
    });

    CommissionModel copyWith({
        String? driverId,
        String? totalOrders,
        String? totalWithCash,
        String? totalWithOnline,
        String? totalCommission,
        String? currentCommission,
        String? avaliablewithdrawprofit,
        String? totalprofit,
    }) => 
        CommissionModel(
            driverId: driverId ?? this.driverId,
            totalOrders: totalOrders ?? this.totalOrders,
            totalWithCash: totalWithCash ?? this.totalWithCash,
            totalWithOnline: totalWithOnline ?? this.totalWithOnline,
            totalCommission: totalCommission ?? this.totalCommission,
            currentCommission: currentCommission ?? this.currentCommission,
            avaliablewithdrawprofit: avaliablewithdrawprofit ?? this.avaliablewithdrawprofit,
            totalprofit: totalprofit ?? this.totalprofit,
        );

    factory CommissionModel.fromJson(Map<String, dynamic> json) => CommissionModel(
        driverId: json["driver_id"],
        totalOrders: json["total_orders"],
        totalWithCash: json["total_with_cash"],
        totalWithOnline: json["total_with_online"],
        totalCommission: json["total_commission"],
        currentCommission: json["current_commission"],
        avaliablewithdrawprofit: json["avaliablewithdrawprofit"],
        totalprofit: json["totalprofit"],
    );


}
