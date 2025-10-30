import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/navigation_provider.dart';
import 'screens/home_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/pujas_screen.dart';
import 'screens/profile_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label, NavigationProvider provider) {
    bool isSelected = provider.currentIndex == index;
    return GestureDetector(
      onTap: () => provider.setIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: isSelected ? BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: Colors.white,
              size: 24,
            ),
            if (isSelected) const SizedBox(width: 8),
            if (isSelected) Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return Scaffold(
            body: IndexedStack(
              index: navigationProvider.currentIndex,
              children: [
                HomeScreen(),
                BookingScreen(),
                PujasScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 60,
              color: const Color(0xFFFF9800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home', navigationProvider),
                  _buildNavItem(1, Icons.calendar_today_outlined, Icons.calendar_today, 'Booking', navigationProvider),
                  _buildNavItem(2, Icons.temple_hindu_outlined, Icons.temple_hindu, 'Pujas', navigationProvider),
                  _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile', navigationProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
