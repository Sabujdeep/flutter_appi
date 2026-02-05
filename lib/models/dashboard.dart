import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:task2/widgets/appbar_widget.dart';
import 'package:task2/widgets/terminal_card.dart';

class AirportDashboard extends StatefulWidget {
  const AirportDashboard({super.key});

  @override
  State<AirportDashboard> createState() => _AirportDashboardState();
}

class _AirportDashboardState extends State<AirportDashboard> {
  Future<List<dynamic>> _loadContact() async {
    final jsonString = await rootBundle.loadString('assets/data/details.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B1F9C), Color(0xFF6B1A7C), Color(0xFFF5F5F5)],
            stops: [0.0, 0.4, 0.6],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const DashboardAppBar(),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 220, // FIXED height for the slider

                        child: FutureBuilder(
                          future: _loadContact(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text("No contacts found"),
                              );
                            }

                            final contacts = snapshot.data!;

                            return PageView.builder(
                              controller: PageController(viewportFraction: 0.9),
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                final c = contacts[index];
                                final name =
                                    "${c['firstName']} ${c['lastName']}";

                                return TerminalCard(
                                  name: name,
                                  email: c['email'],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      _buildHourlyFlightLoad(),
                      SizedBox(height: 25),
                      _buildQuickAccess(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8B1F9C),
        child: const Icon(Icons.search, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildQuickAccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Text(
                'Quick Access',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.edit_outlined, size: 20, color: Color(0xFF8B1F9C)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildQuickAccessItem(Icons.settings, 'App\nSettings'),
              _buildQuickAccessItem(Icons.luggage, 'Arrival\nBaggage'),
              _buildQuickAccessItem(Icons.conveyor_belt, 'Belt\nUtilization'),
              _buildQuickAccessItem(Icons.meeting_room, 'Gate\nUtilization'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xFF8B1F9C)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyFlightLoad() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.flight, color: Color(0xFF8B1F9C)),
              const SizedBox(width: 8),
              const Text(
                'Hourly Flight Load',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLegendItem(Colors.blue, 'Peak'),
              const SizedBox(width: 16),
              _buildLegendItem(Colors.purple.shade200, 'Lean'),
            ],
          ),
          const SizedBox(height: 16),
          _buildBarChart(),
        ],
      ),
    );
  }

  Widget _buildHourlyPAXLoad() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.people, color: Color(0xFF8B1F9C)),
              const SizedBox(width: 8),
              const Text(
                'Hourly PAX Load',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              _buildToggleButton(),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLegendItem(Colors.blue, 'Peak'),
              const SizedBox(width: 16),
              _buildLegendItem(Colors.purple.shade200, 'Lean'),
            ],
          ),
          const SizedBox(height: 16),
          _buildBarChart(),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildToggleButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('ARR', style: TextStyle(fontSize: 12)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1F9C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'DEP',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final times = ['00-01', '06-07', '12-13', '18-19', '23-00'];
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(25, (index) {
          final isPeak = index % 6 == 3 || index % 6 == 4;
          final height = (index % 7 + 2) * 8.0;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: height,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isPeak ? Colors.blue : Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 8),
                if (index % 6 == 0)
                  Text(
                    times[index ~/ 6],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItem(Icons.flight, 'Flights', false),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(Icons.show_chart, 'Live Updates', false),
            _buildNavItem(Icons.menu, 'Menu', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF8B1F9C) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF8B1F9C) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
