import 'package:flutter/material.dart';
import 'package:mavericscare/presentation/home/dashboard/prescription_screen.dart';
import 'package:mavericscare/presentation/home/dashboard/tele_consultation_screen.dart';
import 'package:mavericscare/presentation/home/dashboard/tests_screen.dart';
import 'package:mavericscare/utils/constants.dart';
import 'package:mavericscare/widgets/custom_app_bar_home.dart';

import 'appointment_screen.dart';
import 'bills_screen.dart';
import 'diagnosis_screen.dart';
import 'health_record_screen.dart';
import 'lab_report_screen.dart';
import 'opd_scan_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Widget _buildIconRow(BuildContext context, List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 100, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => _navigateToScreen(context, item['screen']),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item['icon'], size: 50, color: AppColors.darkAppColor300),
                const SizedBox(height: 5, width: 80),
                Text(item['title'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AppBarHome(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    _buildIconRow(context, [
                      {'icon': Icons.local_hospital, 'title': 'OPD Scan', 'screen': const OpdScanScreen()},
                      {'icon': Icons.calendar_today, 'title': 'Appointment', 'screen': const AppointmentScreen()},
                      {'icon': Icons.biotech, 'title': 'Diagnosis', 'screen': const DiagnosisScreen()},
                      {'icon': Icons.video_call, 'title': 'Tele Consultation', 'screen': const TeleConsultationScreen()},
                      {'icon': Icons.medical_services_sharp, 'title': 'Tests', 'screen': const TestsScreen()},
                      // Add more icons and titles as needed
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Records',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    _buildIconRow(context, [
                      {'icon': Icons.receipt_long, 'title': 'Prescription', 'screen': const PrescriptionScreen()},
                      {'icon': Icons.science, 'title': 'Lab Reports', 'screen': const LabReportsScreen()},
                      {'icon': Icons.receipt, 'title': 'Bills', 'screen': const BillsScreen()},
                      {'icon': Icons.medical_services, 'title': 'Health Records', 'screen': const HealthRecordsScreen()},
                    ]),
                  ],
                ),
              ),
            ),
            // Add more cards as needed
          ],
        ),
      ),
    );
  }
}
