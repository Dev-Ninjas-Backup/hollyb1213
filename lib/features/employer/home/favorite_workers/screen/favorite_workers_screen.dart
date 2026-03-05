import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class FavoriteWorkersScreen extends StatefulWidget {
  const FavoriteWorkersScreen({super.key});

  @override
  State<FavoriteWorkersScreen> createState() => _FavoriteWorkersScreenState();
}

class _FavoriteWorkersScreenState extends State<FavoriteWorkersScreen> {
  final searchController = TextEditingController();
  final RxList<Map<String, dynamic>> favoriteWorkers = <Map<String, dynamic>>[
    {
      "id": "1",
      "name": "Nicolas",
      "image": "https://via.placeholder.com/100",
      "rating": 4.6,
      "lastJob": "Restaurant Helper",
      "lastWorked": "12 Oct 2025",
    },
    {
      "id": "2",
      "name": "Marvin McKinney",
      "image": "https://via.placeholder.com/100",
      "rating": 4.6,
      "lastJob": "Restaurant Chef",
      "lastWorked": "12 Oct 2025",
    },
    {
      "id": "3",
      "name": "Jon Dorman",
      "image": "https://via.placeholder.com/100",
      "rating": 4.6,
      "lastJob": "Restaurant Helper",
      "lastWorked": "12 Oct 2025",
    },
    {
      "id": "4",
      "name": "Sarah Johnson",
      "image": "https://via.placeholder.com/100",
      "rating": 4.6,
      "lastJob": "Kitchen Assistant",
      "lastWorked": "12 Oct 2025",
    },
  ].obs;

  late RxList<Map<String, dynamic>> filteredWorkers;

  @override
  void initState() {
    super.initState();
    filteredWorkers =
        RxList<Map<String, dynamic>>(List.from(favoriteWorkers.value));
    searchController.addListener(_filterWorkers);
  }

  void _filterWorkers() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredWorkers.value = List.from(favoriteWorkers.value);
    } else {
      filteredWorkers.value = favoriteWorkers.value
          .where((worker) => worker['name'].toLowerCase().contains(query))
          .toList();
    }
  }

  void _removeWorker(String workerId) {
    favoriteWorkers.removeWhere((worker) => worker['id'] == workerId);
    _filterWorkers();
    Get.snackbar('Removed', 'Worker removed from favorites');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: Appcolor.primaryColor,
              ),
            ),
            Expanded(
              child: Text(
                'Favorite Workers',
                style: getTextStyle(
                  fontSize: sp(18),
                  fontWeight: FontWeight.w600,
                  color: Appcolor.primaryColor,
                ),
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // --- Search Bar ---
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.grey[100]!,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: getBodyTextStyle(
                    fontSize: 14,
                    color: Colors.grey[400]!,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400]!,
                    size: 20.sp,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 30.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // --- Worker List ---
            Expanded(
              child: Obx(
                () => filteredWorkers.isEmpty
                    ? Center(
                        child: Text(
                          'No favorite workers yet',
                          style: getBodyTextStyle(
                            fontSize: 16,
                            color: Colors.grey[600]!,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredWorkers.length,
                        itemBuilder: (context, index) {
                          final worker = filteredWorkers[index];
                          return _buildWorkerCard(worker);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header Row: Name + Delete Icon ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                worker['name'],
                style: getTextStyle(
                  fontSize: sp(16),
                  fontWeight: FontWeight.w600,
                  color: Appcolor.appTextColor,
                ),
              ),
              GestureDetector(
                onTap: () => _removeWorker(worker['id']),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.grey[600]!,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // --- Profile Section ---
          Row(
            children: [
              // --- Profile Image ---
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: Image.network(
                  worker['image'],
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[300]!,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600]!,
                        size: 30.sp,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 14.w),

              // --- Info Column ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Rating ---
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Appcolor.primaryColor,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${worker['rating']}/5',
                          style: getTextStyle(
                            fontSize: sp(12),
                            fontWeight: FontWeight.w600,
                            color: Appcolor.appTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),

                    // --- Last Job ---
                    Text(
                      'Last Job: ${worker['lastJob']}',
                      style: getBodyTextStyle(
                        fontSize: 12,
                        color: Colors.grey[700]!,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),

                    // --- Last Worked Date ---
                    Text(
                      'Last Worked: ${worker['lastWorked']}',
                      style: getBodyTextStyle(
                        fontSize: 12,
                        color: Colors.grey[600]!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // --- View Profile Button ---
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDDE9FF),
                foregroundColor: Appcolor.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Get.snackbar(
                  'Profile',
                  'Viewing profile of ${worker['name']}',
                );
              },
              child: Text(
                'View Profile',
                style: getTextStyle(
                  fontSize: sp(14),
                  fontWeight: FontWeight.w600,
                  color: Appcolor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
