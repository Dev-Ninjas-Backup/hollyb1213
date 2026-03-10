class EmployeeStats {
  final int jobsCompleted;
  final int hoursWorked;
  final num totalEarned;
  final int thisMonth;

  EmployeeStats({
    required this.jobsCompleted,
    required this.hoursWorked,
    required this.totalEarned,
    required this.thisMonth,
  });

  factory EmployeeStats.fromJson(Map<String, dynamic> json) {
    return EmployeeStats(
      jobsCompleted: json['jobsCompleted'] ?? 0,
      hoursWorked: json['hoursWorked'] ?? 0,
      totalEarned: json['totalEarned'] ?? 0,
      thisMonth: json['thisMonth'] ?? 0,
    );
  }
}
