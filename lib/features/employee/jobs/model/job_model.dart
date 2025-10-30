class JobModel {
  final String title;
  final String category;
  final String location;
  final String pay;
  final String imageUrl;
  final bool isUrgent;

  JobModel({
    required this.title,
    required this.category,
    required this.location,
    required this.pay,
    required this.imageUrl,
    this.isUrgent = false,
  });
}
