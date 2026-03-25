import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/quick_action_button.dart';

class EnquirySummaryTab extends StatelessWidget {
  final dynamic lead;
  final List<dynamic> callSummaryData;
  final bool isLoading;
  final String? selectedStatus;

  const EnquirySummaryTab({
    super.key,
    this.lead,
    required this.callSummaryData,
    required this.isLoading,
    this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF26A69A),
          strokeWidth: 3.w,
        ),
      );
    }

    // Dynamic Mock Data bound to the current lead
    final String currentClient =
        (lead?['le_name'] ?? lead?['cus_name'] ?? 'Client').toString();
    final String currentProject =
        (lead?['product_service'] ??
                lead?['required_project'] ??
                'General Inquiry')
            .toString();
    final String currentBudget = (lead?['budget'] ?? '₹0').toString();

    final List<dynamic> mockData = [
      {
        'call_date': '21 March 2026',
        'call_time': '02:30 PM',
        'call_outcome_name': 'Connected',
        'client_name': currentClient,
        'project_name': currentProject,
        'project_budget': currentBudget,
        'meeting_type': 'Virtual Meeting',
        'meeting_platform': 'Google Meet',
        'call_summary':
            'Discussed the primary requirements for $currentProject. The client is satisfied with the initial demo and budget alignment.',
        'next_followup_mode': 'Video Call',
        'next_followup_date': '24 March 2026',
        'next_followup_time': '10:30 AM',
        'client_status': 'Follow-up',
      },
      {
        'call_date': '19 March 2026',
        'call_time': '11:00 AM',
        'call_outcome_name': 'Interested',
        'client_name': currentClient,
        'project_name': currentProject,
        'project_budget': currentBudget,
        'meeting_type': 'Call',
        'call_summary':
            'Initial discovery call to understand the project scope and timeline for $currentProject.',
        'next_followup_mode': 'Physical Meet',
        'next_followup_date': '22 March 2026',
        'next_followup_time': '02:00 PM',
        'client_status': 'New',
      },
    ];

    final List<dynamic> displayData = [...callSummaryData, ...mockData];

    if (displayData.isEmpty) {
      return Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history_edu_rounded,
                  size: 64.r,
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No interaction history',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Insights will appear as you engage with this lead.',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            right: 24.w,
            child: QuickActionButton(lead: lead),
          ),
        ],
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 100.h),
          itemCount: displayData.length,
          itemBuilder: (context, index) {
            return _buildPremiumInteractionCard(context, displayData[index]);
          },
        ),
        Positioned(
          bottom: 24.h,
          right: 24.w,
          child: QuickActionButton(lead: lead),
        ),
      ],
    );
  }

  Widget _buildPremiumInteractionCard(
    BuildContext context,
    dynamic call,
  ) {
    const Color primaryColor = Color(0xFF26A69A);

    final date = (call['call_date'] ?? 'N/A').toString();
    final time = (call['call_time'] ?? '').toString();
    final outcome = (call['call_outcome_name'] ?? call['call_outcome'] ?? 'N/A')
        .toString();
    final summary = (call['call_summary'] ?? '').toString();
    final projectName =
        (lead?['product_service'] ??
                lead?['required_project'] ??
                'General Inquiry')
            .toString();
    final budget = (call['project_budget'] ?? lead?['budget'] ?? '₹0')
        .toString();
    final meetingType = (call['meeting_type'] ?? 'Call').toString();
    final location = (call['location'] ?? '').toString();
    final meetingPlatform = (call['meeting_platform'] ?? '').toString();

    // Next Follow-up Data
    final nextMode = (call['next_followup_mode'] ?? '').toString();
    final nextDate = (call['next_followup_date'] ?? '').toString();
    final nextTime = (call['next_followup_time'] ?? '').toString();

    IconData headerIcon = Icons.call_rounded;
    String modeName = 'Voice Call';
    Color accentColor = const Color(0xFF1B7BBC); // Blue for call

    if (meetingType == 'Direct Meeting') {
      headerIcon = Icons.location_on_rounded;
      modeName = 'Direct Meeting';
      accentColor = const Color(0xFFE91E63); // Pink for meeting
    } else if (meetingType == 'Virtual Meeting') {
      headerIcon = Icons.videocam_rounded;
      modeName = 'Virtual Meeting';
      accentColor = const Color(0xFF9C27B0); // Purple for virtual
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Accent Bar with Icon
            Container(
              width: 50.w,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(headerIcon, size: 20.r, color: accentColor),
                  SizedBox(height: 12.h),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      modeName.toUpperCase(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main Content Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Date & Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 14.r,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "$date ${time.isNotEmpty ? '@ $time' : ''}",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            outcome.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 24.h, color: Colors.grey.shade100),
                    // Project Info
                    Text(
                      projectName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          "Budget: ",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          budget,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Summary Block
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        summary,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ),
                    // Meeting Logistics (if applicable)
                    if (meetingType != 'Call' &&
                        (location.isNotEmpty || meetingPlatform.isNotEmpty))
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Row(
                          children: [
                            Icon(
                              meetingType == 'Direct Meeting'
                                  ? Icons.place_outlined
                                  : Icons.sensors_rounded,
                              size: 16.r,
                              color: accentColor,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                meetingType == 'Direct Meeting'
                                    ? location
                                    : meetingPlatform,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Next Follow-up Block
                    if (nextDate.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.refresh_rounded,
                                size: 14.r,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NEXT FOLLOW-UP",
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w900,
                                      color: primaryColor,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "$nextDate @ $nextTime ($nextMode)",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
