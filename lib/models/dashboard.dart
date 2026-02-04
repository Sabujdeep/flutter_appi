import 'package:flutter/material.dart';
import 'package:task2/widgets/appbar_widget.dart';
import 'package:task2/widgets/terminal_card.dart';

class AirportDashboard extends StatefulWidget {
  const AirportDashboard({Key? key}) : super(key: key);

  @override
  State<AirportDashboard> createState() => _AirportDashboardState();
}

class _AirportDashboardState extends State<AirportDashboard> {
  double _sliderValue = 0.5; // 0 = Arrivals, 1 = Departures

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
              SizedBox(
                height: 220, // FIXED height for the slider
                child: PageView(
                  controller: PageController(viewportFraction: 0.9),
                  children: const [
                    TerminalCard(),
                    TerminalCard(),
                    TerminalCard(),
                  ],
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

  //appbar

  // Widget _buildTerminalCard()

  Widget _buildFlightStatsWithSlider() {
    bool showArrivals = _sliderValue < 0.5;

    return Column(
      children: [
        // Stats Display (switches between Arrivals and Departures)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: showArrivals ? _buildArrivalsStats() : _buildDeparturesStats(),
        ),

        const SizedBox(height: 20),

        // Slider
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 8,
                      activeTrackColor: const Color(0xFF8B1F9C),
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: const Color(0xFF8B1F9C),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                      ),
                      overlayColor: const Color(0xFF8B1F9C).withOpacity(0.2),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20,
                      ),
                    ),
                    child: Slider(
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Arrivals',
                          style: TextStyle(
                            color: showArrivals
                                ? const Color(0xFF8B1F9C)
                                : Colors.grey,
                            fontWeight: showArrivals
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Departures',
                          style: TextStyle(
                            color: !showArrivals
                                ? const Color(0xFF8B1F9C)
                                : Colors.grey,
                            fontWeight: !showArrivals
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArrivalsStats() {
    return Container(
      key: const ValueKey('arrivals'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1F9C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.flight_land,
              color: Color(0xFF8B1F9C),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Arrivals',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '255',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/699',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'On Time Arrivals',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Text(
                    '71.8%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_downward, color: Colors.red, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDeparturesStats() {
    return Container(
      key: const ValueKey('departures'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1F9C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.flight_takeoff,
              color: Color(0xFF8B1F9C),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Departures',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '261',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/694',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'On Time Departures',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Text(
                    '71.3%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_upward, color: Colors.green, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
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
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildQuickAccessItem(Icons.settings, 'App\nSettings'),
              _buildQuickAccessItem(Icons.luggage, 'Arrival\nBaggage P...'),
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
      height: 100,
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
