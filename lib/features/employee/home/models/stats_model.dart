class Stats {
  final int availableJobs;
  final int appliedJobs;

  Stats({required this.availableJobs, required this.appliedJobs});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      availableJobs: json['availableJobs'] ?? 0,
      appliedJobs: json['appliedJobs'] ?? 0,
    );
  }
}
