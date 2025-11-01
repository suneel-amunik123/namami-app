import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/booking_model.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFFE47F25)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Booking Details',
              style: TextStyle(
                color: Color(0xFFE47F25),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFF4E6),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xFFE47F25), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        _buildDetailItem(
                          'assets/images/background_home.jpg',
                          'Name',
                          booking.customerName ?? 'Rohan Sharma',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_phone.jpg',
                          'Phone',
                          booking.customerPhone ?? '9876543210',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_callender.jpg',
                          'Date & Time',
                          booking.dateTime != null
                              ? '${booking.dateTime!.day} Oct 2024, 7:00 AM'
                              : '22 Oct 2024, 7:00 AM',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_ganesh_puja.jpg',
                          'Puja Type',
                          booking.pujaName ?? 'Ganesh Puja',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_price.jpg',
                          'Booking Amount',
                          '₹${booking.amount?.toStringAsFixed(0) ?? '2500'}',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_oom.jpg',
                          'Mode of Puja',
                          'Home',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_samagri.jpg',
                          'Samagri',
                          'Self Arranged',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailItem(
                          'assets/images/background_location.jpg',
                          'Address',
                          booking.location ?? 'Jubilee Hills,Hyderabad',
                        ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        'Map View',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String imagePath, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xFFE47F25).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Color(0xFFE47f25).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFFE47F25).withOpacity(0.3)),
            ),
            child: Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
