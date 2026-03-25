import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'title': 'Upcoming Follow-Up Reminder',
      'description':
          'Reminder:\nCall Arun Kumar for a product demo at 11:00 AM.',
      'time': '2 hrs ago',
      'type': 'Follow-up',
      'showPhone': true,
      'phone': '1234567890',
    },
    {
      'title': 'Missed Follow-Up',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Missed',
      'showPhone': true,
      'phone': '9876543210',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Deal',
      'phone': '9988776655',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Meeting',
      'phone': '1122334455',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Follow-up',
      'phone': '5566778899',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Deal',
      'phone': '4433221100',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Meeting',
      'phone': '6677889900',
    },
    {
      'title': 'New Lead Assigned',
      'description':
          'You missed your follow-up call with Rahul Sharma, scheduled at 4:00 PM today.',
      'time': '2 hrs ago',
      'type': 'Follow-up',
      'phone': '2233445566',
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    if (_selectedFilter == 'All') return _allNotifications;
    return _allNotifications
        .where((notif) => notif['type'] == _selectedFilter)
        .toList();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF26A69A)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Logic to filter by date could go here
    }
  }

  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch dialer')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF26A69A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Follow-up'),
                _buildFilterChip('Deal'),
                _buildFilterChip('Meeting'),
                _buildFilterChip('Missed'),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Latest Notification Header & Pick Date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Latest Notification',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sort by Date ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: _selectDate,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF26A69A),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Pick Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Notification List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredNotifications.length,
              itemBuilder: (context, index) {
                final notif = _filteredNotifications[index];
                return _buildNotificationCard(
                  title: notif['title'],
                  description: notif['description'],
                  time: notif['time'],
                  showPhone: notif['showPhone'] ?? false,
                  onCallTap: () {
                    if (notif['phone'] != null) {
                      _makeCall(notif['phone']);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF26A69A) : Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: const Color(0xFF26A69A)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF26A69A),
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
    bool showPhone = false,
    VoidCallback? onCallTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9EFFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD1C4E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF666666),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF555555),
                    height: 1.4,
                  ),
                ),
              ),
              if (showPhone) ...[
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: onCallTap,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.call, color: Colors.white, size: 20.r),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
