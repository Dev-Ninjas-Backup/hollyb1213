import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class ViewApplicantsScreen extends StatefulWidget {
  const ViewApplicantsScreen({super.key});

  @override
  State<ViewApplicantsScreen> createState() => _ViewApplicantsScreenState();
}

class _ViewApplicantsScreenState extends State<ViewApplicantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy data — replace with API data later
  final List<Map<String, dynamic>> _jobs = [
    {
      "title": "Restaurant Chef",
      "icon": Icons.restaurant,
      "applicants": [
        {
          "name": "Nicolas",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Chef",
          "rating": 4.6,
        },
        {
          "name": "Sarah Johnson",
          "image": "",
          "experience": "3 years experience",
          "appliedFor": "Restaurant Chef",
          "rating": 4.8,
        },
        {
          "name": "Mike Chen",
          "image": "",
          "experience": "5 years experience",
          "appliedFor": "Restaurant Chef",
          "rating": 4.9,
        },
      ],
    },
    {
      "title": "Restaurant Cleaner",
      "icon": Icons.cleaning_services,
      "applicants": [
        {
          "name": "Emma Wilson",
          "image": "",
          "experience": "2 years experience",
          "appliedFor": "Restaurant Cleaner",
          "rating": 4.5,
        },
        {
          "name": "David Brown",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Cleaner",
          "rating": 4.3,
        },
        {
          "name": "Lisa Park",
          "image": "",
          "experience": "4 years experience",
          "appliedFor": "Restaurant Cleaner",
          "rating": 4.7,
        },
        {
          "name": "Tom Harris",
          "image": "",
          "experience": "2 years experience",
          "appliedFor": "Restaurant Cleaner",
          "rating": 4.4,
        },
      ],
    },
    {
      "title": "Restaurant Helper",
      "icon": Icons.room_service,
      "applicants": [
        {
          "name": "Nicolas",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.6,
        },
        {
          "name": "Jon Dorman",
          "image": "",
          "experience": "2 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.8,
        },
        {
          "name": "Marvin McKinney",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.6,
        },
        {
          "name": "Alex Turner",
          "image": "",
          "experience": "3 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.5,
        },
        {
          "name": "Rachel Green",
          "image": "",
          "experience": "2 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.7,
        },
        {
          "name": "Sam Wilson",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.2,
        },
        {
          "name": "Kelly Adams",
          "image": "",
          "experience": "4 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.9,
        },
        {
          "name": "Chris Evans",
          "image": "",
          "experience": "2 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.4,
        },
        {
          "name": "Diana Prince",
          "image": "",
          "experience": "3 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.6,
        },
        {
          "name": "Bruce Wayne",
          "image": "",
          "experience": "5 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.8,
        },
        {
          "name": "Peter Parker",
          "image": "",
          "experience": "1 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 4.3,
        },
        {
          "name": "Tony Stark",
          "image": "",
          "experience": "6 years experience",
          "appliedFor": "Restaurant Helper",
          "rating": 5.0,
        },
      ],
    },
  ];

  final Set<int> _expandedIndices = {};

  List<Map<String, dynamic>> get _filteredJobs {
    if (_searchQuery.isEmpty) return _jobs;
    final query = _searchQuery.toLowerCase();
    final List<Map<String, dynamic>> result = [];
    for (final job in _jobs) {
      final title = (job['title'] as String).toLowerCase();
      final applicants = job['applicants'] as List<Map<String, dynamic>>;
      final matchedApplicants = applicants
          .where((a) => (a['name'] as String).toLowerCase().contains(query))
          .toList();
      if (title.contains(query) || matchedApplicants.isNotEmpty) {
        result.add({
          ...job,
          'applicants': title.contains(query) ? applicants : matchedApplicants,
        });
      }
    }
    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
        ),
        centerTitle: true,
        title: Text(
          "Applicants",
          style: getBodyTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  SizedBox(width: 14.w),
                  Icon(Icons.search, color: Colors.grey, size: 22.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Search applicants by name or Job...",
                        hintStyle: getBodyTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                ],
              ),
            ),
          ),

          // Job Expandable List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: _filteredJobs.length,
              itemBuilder: (context, index) {
                final job = _filteredJobs[index];
                final applicants =
                    job['applicants'] as List<Map<String, dynamic>>;
                final isExpanded = _expandedIndices.contains(index);

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: isExpanded
                          ? Border.all(
                              color: Appcolor.primaryColor.withOpacity(0.3),
                              width: 1.2,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Job Header (tap to expand/collapse)
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (isExpanded) {
                                _expandedIndices.remove(index);
                              } else {
                                _expandedIndices.add(index);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(14.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 14.h,
                            ),
                            child: Row(
                              children: [
                                // Job Icon
                                Container(
                                  height: 44.w,
                                  width: 44.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    job['icon'] as IconData,
                                    size: 22.sp,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Title & count
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['title'] as String,
                                        style: getBodyTextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people_outline,
                                            size: 16.sp,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            "${applicants.length} Applicants",
                                            style: getBodyTextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Expand/collapse arrow
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 26.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Applicant Cards (when expanded)
                        if (isExpanded)
                          Column(
                            children: applicants.map((applicant) {
                              return _buildApplicantCard(applicant);
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantCard(Map<String, dynamic> applicant) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: (applicant['image'] as String).isNotEmpty
                    ? NetworkImage(applicant['image'] as String)
                    : null,
                child: (applicant['image'] as String).isEmpty
                    ? Icon(Icons.person, size: 28.sp, color: Colors.grey)
                    : null,
              ),
              SizedBox(width: 12.w),

              // Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      applicant['name'] as String,
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Experience
                    Text(
                      applicant['experience'] as String,
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Applied For
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Applied: ",
                            style: getBodyTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Appcolor.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: applicant['appliedFor'] as String,
                            style: getBodyTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Rating Row
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "Rating ${applicant['rating']}/5",
                          style: getBodyTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    // View Profile
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Appcolor.primaryColor,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "View Profile",
                          style: getBodyTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Appcolor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chat Icon
              GestureDetector(
                onTap: () {
                  // TODO: handle chat tap
                },
                child: Container(
                  height: 36.w,
                  width: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 18.sp,
                    color: Appcolor.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Accept / Reject Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: handle accept
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Appcolor.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Text(
                    "Accept",
                    style: getBodyTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: handle reject
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Text(
                    "Reject",
                    style: getBodyTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
