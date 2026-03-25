import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/Lead_Information/enquiry_tabs_view.dart';

class LeadRowCard extends StatelessWidget {
  final dynamic lead;
  final VoidCallback onCall;
  final bool showCall;
  final bool showStatus;

  const LeadRowCard({
    super.key,
    required this.lead,
    required this.onCall,
    this.showCall = true,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final name = (lead['le_name'] ?? lead['cus_name'] ?? 'Arun Kumar')
        .toString();
    final p1 = (lead['mobile_1'] ?? '98756 32123').toString();
    final p2 = (lead['mobile_2'] ?? '98756 32123').toString();
    final service =
        (lead['product_service'] ??
                lead['required_project'] ??
                'Micro fin soft')
            .toString();
    final email = (lead['email'] ?? 'crmapp@gmail.com').toString();
    final date = (lead['enquiry_date'] ?? '16 March 2026').toString();
    final displayStatus =
        (lead['lead_type'] ?? lead['lead_status'] ?? lead['status'] ?? 'New')
            .toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => EnquiryTabsView(lead: lead, status: displayStatus),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 4.h,
        ), // Reduced vertical margin
        padding: EdgeInsets.all(8.r), // Reduced padding
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          border: Border.all(color: const Color(0xFF26A69A), width: 1.r),
          borderRadius: BorderRadius.circular(10.r), // Slightly smaller radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4.r, // Reduced blur
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 18.r, // Reduced icon size
                      color: Colors.black,
                    ),
                    SizedBox(width: 8.w), // Reduced width
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15.sp, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (showStatus)
                      Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 8.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              displayStatus,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.h), // Reduced height
            // Phone 1
            _item(Icons.phone_outlined, p1, const Color(0xFF2E7D32)),
            // Phone 2
            _item(Icons.phone_outlined, p2, const Color(0xFF2E7D32)),
            // Service
            _item(Icons.headset_mic_outlined, service, const Color(0xFFEF6C00)),
            // Email
            _item(Icons.mail_outline, email, Colors.black),
            // Date and Call Button Row
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16.r,
                    color: const Color(0xFF3949AB),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      date,
                      style: TextStyle(
                        color: const Color(0xFF3949AB),
                        fontSize: 12.sp, // Reduced font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (showCall)
                    GestureDetector(
                      onTap: onCall,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.call, color: Colors.white, size: 14.r),
                            SizedBox(width: 4.w),
                            Text(
                              'Call',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp, // Reduced font size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.chevron_right,
                    size: 22.r,
                    color: const Color(0xFF3949AB), // Color matches the date
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h), // Reduced padding
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.r, // Reduced icon size
            color: color == Colors.black ? Colors.black87 : color,
          ),
          SizedBox(width: 8.w), // Reduced width
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12.sp, // Reduced font size from 14.sp
                fontWeight: color == Colors.black
                    ? FontWeight.normal
                    : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
