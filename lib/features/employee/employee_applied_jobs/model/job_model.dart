class JobModel {
  final String? id;
  final String image;
  final String title;
  final String company;
  final String location;
  final String rate;
  final String time;
  final String status;
  final String progressText;
  final String jobDescription;
  final List<String>? requirements;

  JobModel({
    this.id,
    required this.image,
    required this.title,
    required this.company,
    required this.location,
    required this.rate,
    required this.time,
    required this.status,
    required this.progressText,
    required this.jobDescription,
    this.requirements,
  });

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] as String?,
      image: map['file']?['url'] ?? '',
      title: map['title'] ?? 'No Title',
      company: map['company_name'] ?? 'No Company',
      location: map['location'] ?? 'No Location',
      rate: map['amount']?.toString() ?? 'N/A',
      time: '${map['start_time'] ?? 'N/A'} - ${map['end_time'] ?? 'N/A'}',
      status: map['application_status'] ?? 'Unknown',
      progressText: map['progress_text'] ?? '',
      jobDescription: map['description'] ?? 'No description available.',
      requirements: map['requirements'] != null
          ? List<String>.from(map['requirements'])
          : null,
    );
  }
}
