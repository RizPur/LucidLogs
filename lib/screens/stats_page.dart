import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:lucidlogs/components/topper_widget.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dreamDatabase = context.watch<DreamDatabase>();

    final totalDreams = dreamDatabase.currentDreams.length;
    final lucidDreams = dreamDatabase.currentDreams
        .where((dream) => dream.isLucid ?? false)
        .length;
    final mostCommonFeeling = _getMostCommonFeeling(dreamDatabase);
    final mostUsedTags = _getMostUsedTags(dreamDatabase);
    final dreamsPerDay = _getDreamsPerDay(dreamDatabase);
    final feelingsDistribution = _getFeelingsDistribution(dreamDatabase);
    final feelingsOverTime = _getFeelingsOverTime(dreamDatabase);
    final dreamLengths = _getDreamLengths(dreamDatabase);

    return Scaffold(
      appBar: const TopperWidget(title: "Dream Statistics"), // Custom title
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Analyze your dreams to gain insights into your subconscious patterns. Below, you’ll find the most frequently used tags in your dream journal.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildMostUsedTags(mostUsedTags, context),
              const SizedBox(height: 8),
              const Text(
                "These tags can give you clues about recurring themes or symbols in your dreams.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The Dream Factors section gives you a quick overview of your dream patterns, including the number of lucid dreams and the most common feeling associated with your dreams.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildDreamFactors(
                  totalDreams, lucidDreams, mostCommonFeeling, context),
              const SizedBox(height: 8),
              const Text(
                "Understanding these factors can help you identify emotional triggers or events that may influence your dreams.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The graph below shows the number of dreams recorded each day. This can help you track how often you are recalling your dreams.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildLineChart(dreamsPerDay, context),
              const SizedBox(height: 8),
              const Text(
                "Frequent dream recording can indicate a strong dream recall ability, which is beneficial for dream analysis.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The pie chart below represents the distribution of feelings in your dreams. This helps you understand the emotional tone of your dreams.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildDonutChart(
                  "Feelings Distribution", feelingsDistribution, context),
              const SizedBox(height: 8),
              const Text(
                "Positive or negative feelings in dreams can reflect your waking life emotional state.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "This bar chart compares the number of lucid dreams versus non-lucid dreams. Increasing the number of lucid dreams can enhance your ability to control and explore your dreams.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildBarChart(
                  "Lucid vs Non-Lucid Dreams",
                  {
                    "Lucid": lucidDreams,
                    "Non-Lucid": totalDreams - lucidDreams
                  },
                  context),
              const SizedBox(height: 8),
              const Text(
                "A higher number of lucid dreams suggests stronger dream awareness and control.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The spline area chart below tracks changes in your dream feelings over time. It provides insight into how your emotional state in dreams evolves.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildSplineAreaChart(
                  "Feelings Over Time", feelingsOverTime, context),
              const SizedBox(height: 8),
              const Text(
                "Fluctuations in feelings over time can indicate periods of emotional stress or calm.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                "The scatter plot below shows the lengths of your dream entries. Longer dreams may contain more detailed content and can be more insightful for analysis.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _buildScatterChart("Dream Lengths", dreamLengths, context),
              const SizedBox(height: 8),
              const Text(
                "Pay attention to the length of your dreams as it can indicate the depth of your dream experiences.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMostCommonFeeling(DreamDatabase db) {
    final feelingCounts = <String, int>{};
    for (var dream in db.currentDreams) {
      final feeling = dream.feeling ?? 'Neutral';
      feelingCounts[feeling] = (feelingCounts[feeling] ?? 0) + 1;
    }
    return feelingCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  Map<String, int> _getMostUsedTags(DreamDatabase db) {
    final tagCounts = <String, int>{};
    for (var dream in db.currentDreams) {
      for (var tag in dream.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    return tagCounts;
  }

  Map<String, int> _getDreamsPerDay(DreamDatabase db) {
    final dreamsPerDay = <String, int>{};
    for (var dream in db.currentDreams) {
      final date =
          "${dream.createdAt.year}-${dream.createdAt.month}-${dream.createdAt.day}";
      dreamsPerDay[date] = (dreamsPerDay[date] ?? 0) + 1;
    }
    return dreamsPerDay;
  }

  Map<String, int> _getFeelingsDistribution(DreamDatabase db) {
    final feelingCounts = <String, int>{};
    for (var dream in db.currentDreams) {
      final feeling = dream.feeling ?? 'Neutral';
      feelingCounts[feeling] = (feelingCounts[feeling] ?? 0) + 1;
    }
    return feelingCounts;
  }

  Map<String, int> _getFeelingsOverTime(DreamDatabase db) {
    final feelingsOverTime = <String, int>{};
    for (var dream in db.currentDreams) {
      final date =
          "${dream.createdAt.year}-${dream.createdAt.month}-${dream.createdAt.day}";
      feelingsOverTime[date] = (feelingsOverTime[date] ?? 0) + 1;
    }
    return feelingsOverTime;
  }

  Map<String, double> _getDreamLengths(DreamDatabase db) {
    final dreamLengths = <String, double>{};
    for (var dream in db.currentDreams) {
      dreamLengths[dream.content] = dream.content.length.toDouble();
    }
    return dreamLengths;
  }

  Widget _buildMostUsedTags(Map<String, int> tags, BuildContext context) {
    if (tags.isEmpty) {
      return SizedBox.shrink(); // Don't render anything if there are no tags
    }

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.1), // Light and slightly transparent background
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Most Used Tags",
            style:
                TextStyle(fontSize: 18, color: Colors.black), // Dark text color
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: tags.keys
                .map((tag) => Chip(
                      backgroundColor:
                          Colors.black12, // Light background for chips
                      label: Text(tag,
                          style: TextStyle(
                              color: Colors.black)), // Dark text color
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDreamFactors(int totalDreams, int lucidDreams,
      String mostCommonFeeling, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dream Factors",
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xFF6A1B9A), // Light purple text color
              fontWeight: FontWeight.bold, // Add bold style for emphasis
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Total Dreams: $totalDreams",
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.w500, // Semi-bold style
            ),
          ),
          Text(
            "Lucid Dreams: $lucidDreams",
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.w500, // Semi-bold style
            ),
          ),
          Text(
            "Most Common Feeling: $mostCommonFeeling",
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.w500, // Semi-bold style
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart(Map<String, int> dreamsPerDay, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: "Dreams Per Day",
            textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          LineSeries<MapEntry<String, int>, String>(
            dataSource: dreamsPerDay.entries.toList(),
            xValueMapper: (MapEntry<String, int> e, _) => e.key,
            yValueMapper: (MapEntry<String, int> e, _) => e.value,
            color: Colors.black, // Black color for the line chart
          )
        ],
      ),
    );
  }

  Widget _buildDonutChart(
      String title, Map<String, int> data, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfCircularChart(
        title: ChartTitle(
            text: title,
            textStyle:
                const TextStyle(color: Color.fromARGB(255, 28, 92, 144))),
        series: <CircularSeries>[
          DoughnutSeries<MapEntry<String, int>, String>(
            dataSource: data.entries.toList(),
            xValueMapper: (MapEntry<String, int> e, _) => e.key,
            yValueMapper: (MapEntry<String, int> e, _) => e.value,
            dataLabelMapper: (MapEntry<String, int> e, _) =>
                "${e.key}: ${e.value}%",
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(
      String title, Map<String, int> data, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: title, textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          BarSeries<MapEntry<String, int>, String>(
            dataSource: data.entries.toList(),
            xValueMapper: (MapEntry<String, int> e, _) => e.key,
            yValueMapper: (MapEntry<String, int> e, _) => e.value,
            color: const Color.fromARGB(
                255, 66, 60, 233), // Black color for the bars
          )
        ],
      ),
    );
  }

  Widget _buildSplineAreaChart(
      String title, Map<String, int> data, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: title, textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          SplineAreaSeries<MapEntry<String, int>, String>(
            dataSource: data.entries.toList(),
            xValueMapper: (MapEntry<String, int> e, _) => e.key,
            yValueMapper: (MapEntry<String, int> e, _) => e.value,
            color: const Color.fromARGB(
                255, 39, 71, 216), // Black color for the area chart
          )
        ],
      ),
    );
  }

  Widget _buildScatterChart(
      String title, Map<String, double> data, BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Light background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow for depth
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
            text: title, textStyle: const TextStyle(color: Colors.black)),
        series: <ChartSeries>[
          ScatterSeries<MapEntry<String, double>, String>(
            dataSource: data.entries.toList(),
            xValueMapper: (MapEntry<String, double> e, _) => e.key,
            yValueMapper: (MapEntry<String, double> e, _) => e.value,
            color: const Color.fromARGB(
                255, 34, 128, 217), // Black color for the scatter plot
          )
        ],
      ),
    );
  }
}
