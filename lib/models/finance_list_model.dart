class FinanceListModel {
  final int? userId;
  final String? financeType;
  final String? dateFilter;

  FinanceListModel({
    required this.userId,
    required this.financeType,
    required this.dateFilter,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) "userId": userId,
      if (financeType != null) "financeType": financeType,
      if (dateFilter != null) "dateFilter": dateFilter,
    };
  }
}
