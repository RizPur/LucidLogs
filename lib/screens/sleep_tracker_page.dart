import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepTrackerPage extends StatelessWidget {
  const SleepTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dreamDatabase = context.watch<DreamDatabase>();

    final sleepData = _getSleepDurationData(dreamDatabase);
    final sleepQualityData = _getSleepQualityData(dreamDatabase);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep Tracker"),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Track your sleep patterns to gain insights into your overall well-being. The graph below shows your sleep duration per day compared to the recommended 7-9 hours.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildSleepDurationChart(sleepData, context),
              const SizedBox(height: 8),
              const Text(
                "The duration of your sleep is critical for your health. Ensure that your sleep duration aligns with the recommended hours to feel refreshed and alert.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The graph below provides an analysis of your sleep quality over time. This is calculated based on factors like the number of awakenings, sleep interruptions, and dream recall.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildSleepQualityChart(sleepQualityData, context),
              const SizedBox(height: 8),
              const Text(
                "Quality of sleep plays a significant role in how you feel during the day. Higher quality sleep generally leads to better mood, concentration, and overall health.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, double> _getSleepDurationData(DreamDatabase db) {
    final sleepData = <String, double>{};
    for (var dream in db.currentDreams) {
      final date =
          "${dream.createdAt.year}-${dream.createdAt.month}-${dream.createdAt.day}";
      // Example: Simulate 7-9 hours of sleep, with small variations.
      sleepData[date] = (sleepData[date] ?? 0) +
          7.5 +
          (dream.feeling == 'Neutral' ? 0.5 : 0.0);
    }
    return sleepData;
  }

  Map<String, double> _getSleepQualityData(DreamDatabase db) {
    final sleepQualityData = <String, double>{};
    for (var dream in db.currentDreams) {
      final date =
          "${dream.createdAt.year}-${dream.createdAt.month}-${dream.createdAt.day}";
      // Example: Simulate sleep quality score out of 10.
      sleepQualityData[date] =
          (sleepQualityData[date] ?? 0) + (dream.feeling == 'Good' ? 8.5 : 6.5);
    }
    return sleepQualityData;
  }

  Widget _buildSleepDurationChart(
      Map<String, double> sleepData, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: "Sleep Duration Per Day",
            textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          LineSeries<MapEntry<String, double>, String>(
            dataSource: sleepData.entries.toList(),
            xValueMapper: (MapEntry<String, double> e, _) => e.key,
            yValueMapper: (MapEntry<String, double> e, _) => e.value,
            color: const Color(0xFF6A1B9A), // Purple color for the line chart
          )
        ],
      ),
    );
  }

  Widget _buildSleepQualityChart(
      Map<String, double> sleepData, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: "Sleep Quality Over Time",
            textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          SplineAreaSeries<MapEntry<String, double>, String>(
            dataSource: sleepData.entries.toList(),
            xValueMapper: (MapEntry<String, double> e, _) => e.key,
            yValueMapper: (MapEntry<String, double> e, _) => e.value,
            color: const Color(0xFF6A1B9A), // Purple color for the area chart
          )
        ],
      ),
    );
  }
}
