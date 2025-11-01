import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget _buildNavItem(
    int index,
    String imagePath,
    String activeImagePath,
    String label,
    NavigationProvider provider,
  ) {
    bool isSelected = provider.currentIndex == index;
    return GestureDetector(
      onTap: () => provider.setIndex(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? activeImagePath : imagePath,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
            if (isSelected) SizedBox(width: 3.w),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFFe47F25),
                  fontSize: 12.sp,
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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
                  height: 60.h,
                  color: const Color(0xFFe47f25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        0,
                        'assets/images/home_white.png',
                        'assets/images/home_icon3.jpg',
                        'Home',
                        navigationProvider,
                      ),
                      _buildNavItem(
                        1,
                        'assets/images/booking_white.png',
                        'assets/images/booking_icon3.jpg',
                        'Booking',
                        navigationProvider,
                      ),
                      _buildNavItem(
                        2,
                        'assets/images/oom_white.png',
                        'assets/images/oom3.jpg',
                        'Pujas',
                        navigationProvider,
                      ),
                      _buildNavItem(
                        3,
                        'assets/images/profile_white.png',
                        'assets/images/profile_icon3.jpg',
                        'Profile',
                        navigationProvider,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
