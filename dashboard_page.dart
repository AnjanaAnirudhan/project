import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stego Vision Dashboard'),
      ),
      drawer: const DashboardDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // System Status
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'System Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('All systems are operational.'),
                    const SizedBox(height: 8.0),
                    const Text('Real-Time Encryption: Active'),
                    const Text('Cloud Storage Integration: Connected'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Recent Activity
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Activity',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Encryption Task Completed: 10 minutes ago'),
                    const Text('Video File Uploaded: 30 minutes ago'),
                    const Text('Error Report Generated: 1 hour ago'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Error Logs
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Error Logs',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('No recent errors.'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Performance Metrics Chart
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  height: 200.0,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 120,
                      barGroups: _createSampleData(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return Text('Jan',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                                case 1:
                                  return Text('Feb',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                                case 2:
                                  return Text('Mar',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                                case 3:
                                  return Text('Apr',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                                default:
                                  return Text('',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text('${value.toInt()}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold));
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _createSampleData() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          toY: 50,
          color: Colors.blue,
          width: 20,
        ),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
          toY: 25,
          color: Colors.blue,
          width: 20,
        ),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
          toY: 100,
          color: Colors.blue,
          width: 20,
        ),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(
          toY: 75,
          color: Colors.blue,
          width: 20,
        ),
      ]),
    ];
  }
}

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Dashboard Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Overview'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Overview Page
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Settings Page
            },
          ),
          ListTile(
            title: const Text('Support'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Support Page
            },
          ),
        ],
      ),
    );
  }
}
