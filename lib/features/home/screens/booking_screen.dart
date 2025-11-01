import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../model/booking_model.dart';
import 'booking_details_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Map<String, String> _bookingStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Booking',
          style: TextStyle(
            color: const Color(0xFFE47F25),
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          children: [
            // Status Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatusCard(
                    '20',
                    'Accepted',
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Expanded(
                  child: _buildStatusCard(
                    '08',
                    'Rejected',
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),

            // Booking List
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  final bookings = homeProvider.bookings ?? [];
                  if (bookings.isEmpty) {
                    return const Center(child: Text('No bookings available'));
                  }
                  return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      if (index >= bookings.length) return const SizedBox();
                      return _buildBookingCard(bookings[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    String count,
    String title,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.02,
        ),
        border: Border.all(color: const Color(0xFFe47f25), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(
              icon == Icons.check_circle ? Icons.check : Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    if (booking == null) return const SizedBox();

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.03,
        ),
        border: Border.all(color: const Color(0xFFE47f25), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Row(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.05,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/booking_profile.jpg',
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.width * 0.12,
                  fit: BoxFit.fill,
                ),
                // child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.customerName ?? 'Unknown',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Text(
                    booking.customerPhone ?? '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Booking Details
          _buildDetailRow(
            'assets/images/ganesh_puja.jpg',
            booking.pujaName ?? '',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            'assets/images/callender_image.jpg',
            booking.dateTime != null
                ? '${booking.dateTime!.day} ${_getMonthName(booking.dateTime!.month)} ${booking.dateTime!.year}, ${_formatTime(booking.dateTime!)}'
                : '',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            'assets/images/location_image.jpg',
            booking.location ?? '',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            'assets/images/samagri_image.jpg',
            'Somagiri | Self Arranged',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            'assets/images/price_image.jpg',
            '₹${(booking.amount ?? 0).toStringAsFixed(0)}',
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (booking.id != null) {
                    setState(() {
                      _bookingStates[booking.id!] = 'accepted';
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailsScreen(booking: booking),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _bookingStates[booking.id] == 'accepted'
                      ? const Color(0xFFE47F25)
                      : Colors.white,
                  foregroundColor: _bookingStates[booking.id] == 'accepted'
                      ? Colors.white
                      : const Color(0xFFE47F25),
                  side: const BorderSide(color: Color(0xFFE47F25)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, size: 16),
                    SizedBox(width: 2),
                    Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  if (booking.id != null) {
                    setState(() {
                      _bookingStates[booking.id!] = 'rejected';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _bookingStates[booking.id] == 'rejected'
                      ? Colors.red
                      : Colors.white,
                  foregroundColor: _bookingStates[booking.id] == 'rejected'
                      ? Colors.white
                      : Colors.red,
                  side: const BorderSide(color: Colors.red),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, size: 16),
                    SizedBox(width: 2),
                    Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String imagePath, String text) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.05,
          fit: BoxFit.contain,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: imagePath == 'assets/images/price_image.jpg'
                  ? const Color(0xFFE47F25)
                  : const Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
