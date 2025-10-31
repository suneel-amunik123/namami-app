import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.07,
                    backgroundColor: const Color(0xFFE47f25),
                    backgroundImage: const AssetImage(
                      'assets/images/profile_image.jpg',
                    ),
                    // child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Namaste !',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFE47f25),
                          ),
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return Text(
                              homeProvider.user.name.split(' ').first,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                color: const Color(0xFFE47f25),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.notifications_outlined),
                  // ),
                ],
              ),
              const SizedBox(height: 24),

              // Earnings Cards
              Row(
                children: [
                  Expanded(
                    child: Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                        return _buildEarningsCard(
                          'Total Earnings',
                          '₹${homeProvider.user.totalEarnings.toStringAsFixed(0)}',
                          Colors.white,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                        return _buildEarningsCard(
                          'This Month',
                          '₹${homeProvider.user.monthlyEarnings.toStringAsFixed(0)}',
                          Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // New Bookings
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   padding: const EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     // color: const Color(0xFFE47F25),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Image.asset(
                        //     'assets/images/oom.jpg',
                        //     width: 20,
                        //     height: 20,
                        //     color: Colors.white,
                        //   ),

                        //   // child: const Icon(
                        //   //   Icons.calendar_today,
                        //   //   color: Colors.white,
                        //   //   size: 20,
                        //   // ),
                        // ),
                        Image.asset(
                          'assets/images/oom.jpg',
                          width: 28,
                          height: 28,
                        ),

                        const SizedBox(width: 10),
                        const Text(
                          'New Bookings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFE47F25),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                        final newBooking = homeProvider.getNewBooking();
                        if (newBooking == null) return const SizedBox();
                        return _buildNewBookingCard(newBooking, homeProvider);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Daily Bookings
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xFFE47F25),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Daily Bookings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE47F25),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Booking List
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    final bookings = homeProvider.bookings;
                    return ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return _buildBookingCard(bookings[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsCard(String title, String amount, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
        border: Border.all(color: const Color(0xFFE47F25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.03,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
          Text(
            amount,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE47F25)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFE47F25),
            child: Image.asset('assets/images/ganesh.jpg', fit: BoxFit.fill),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.pujaName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/callender.jpg',
                      width: 18,
                      height: 18,
                      // color: Color(0xFFE47F25),
                    ),
                    // const SizedBox(width: 4),
                    // const Icon(
                    //   Icons.calendar_today,
                    //   size: 12,
                    //   color: Color(0xFFE47F25),
                    // ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${booking.dateTime.day} ${_getMonthName(booking.dateTime.month)} ${booking.dateTime.year}, ${_formatTime(booking.dateTime)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const SizedBox(width: 8),
                    // const Icon(Icons.location_on, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    // Flexible(
                    //   child: Text(
                    //     booking.location,
                    //     style: const TextStyle(
                    //       fontSize: 12,
                    //       color: Colors.grey,
                    //     ),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
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

  Widget _buildNewBookingCard(booking, HomeProvider homeProvider) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE47F25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking.pujaName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 12,
                color: Color(0xFFE47F25),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  '${booking.dateTime.day} ${_getMonthName(booking.dateTime.month)} ${booking.dateTime.year}, ${_formatTime(booking.dateTime)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.location_on, size: 15, color: Color(0XFFE47F25)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  booking.location,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  homeProvider.acceptBooking(booking.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: homeProvider.isBookingAccepted(booking.id)
                      ? const Color(0xFFE47F25)
                      : Colors.white,
                  foregroundColor: homeProvider.isBookingAccepted(booking.id)
                      ? Colors.white
                      : const Color(0xFFE47F25),
                  side: const BorderSide(color: Color(0xFFE47F25)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              size: 12,
                              color: Color(0xFFE47F25),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              homeProvider.isBookingAccepted(booking.id)
                                  ? 'Accepted'
                                  : 'Accept',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // const Text(
                        //   'Accept',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  homeProvider.rejectBooking(booking.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.close,
                              size: 12,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Reject',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // const Text(
                        //   'Reject',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                // child: const Text(
                //   'Reject',
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
