import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../model/booking_model.dart';

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
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Color(0xFFFF9800),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                const SizedBox(width: 16),
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
            const SizedBox(height: 20),

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF9800), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.customerName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    booking.customerPhone ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Booking Details
          _buildDetailRow(Icons.temple_hindu, booking.pujaName ?? ''),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.calendar_today,
            booking.dateTime != null
                ? '${booking.dateTime!.day} ${_getMonthName(booking.dateTime!.month)} ${booking.dateTime!.year}, ${_formatTime(booking.dateTime!)}'
                : '',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on, booking.location ?? ''),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.person, 'Somagiri | Self Arranged'),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.currency_rupee,
            '₹${(booking.amount ?? 0).toStringAsFixed(0)}',
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (booking.id != null) {
                      setState(() {
                        _bookingStates[booking.id!] = 'accepted';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _bookingStates[booking.id] == 'accepted'
                        ? const Color(0xFFFF9800)
                        : Colors.white,
                    foregroundColor: _bookingStates[booking.id] == 'accepted'
                        ? Colors.white
                        : const Color(0xFFFF9800),
                    side: const BorderSide(color: Color(0xFFFF9800)),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(height: 2),
                      Text(
                        'Accept',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, size: 16),
                      SizedBox(height: 2),
                      Text(
                        'Reject',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: icon == Icons.currency_rupee
                  ? const Color(0xFFFF9800)
                  : Colors.grey,
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
