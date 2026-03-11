class EmployeeStats {
  final num jobsCompleted;
  final num hoursWorked;
  final num totalEarned;
  final num thisMonth;

  EmployeeStats({
    required this.jobsCompleted,
    required this.hoursWorked,
    required this.totalEarned,
    required this.thisMonth,
  });

  factory EmployeeStats.fromJson(Map<String, dynamic> json) {
    return EmployeeStats(
      jobsCompleted: (json['jobsCompleted'] ?? 0) is double
          ? (json['jobsCompleted'] as double).toInt()
          : (json['jobsCompleted'] ?? 0) as int,
      hoursWorked: (json['hoursWorked'] ?? 0) is double
          ? (json['hoursWorked'] as double).toInt()
          : (json['hoursWorked'] ?? 0) as int,
      totalEarned: json['totalEarned'] ?? 0,
      thisMonth: (json['thisMonth'] ?? 0) is double
          ? (json['thisMonth'] as double).toInt()
          : (json['thisMonth'] ?? 0) as int,
    );
  }
}
