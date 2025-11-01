import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../model/booking_model.dart';

class HomeProvider extends ChangeNotifier {
  UserModel _user = const UserModel(
    name: 'Ramesh Kumar',
    email: 'ramesh@example.com',
    mobileNumber: '+91 9876543210',
    experience: '5 to 7 years',
    languages: ['Telugu', 'Hindi', 'English'],
    address: 'Hyderabad, Telangana',
    bio: 'Experienced puja specialist with traditional knowledge',
    rating: 4.8,
    totalBookings: 125,
    totalEarnings: 12000.0,
    monthlyEarnings: 5000.0,
  );

  final Set<String> _acceptedBookings = {};
  final Set<String> _rejectedBookings = {};

  List<BookingModel> _bookings = [
    BookingModel(
      id: '1',
      pujaName: 'Ganesh Puja',
      customerName: 'Priya Sharma',
      customerPhone: '+91 9876543210',
      dateTime: DateTime(2025, 10, 11, 7, 0),
      location: 'Hyderabad',
      amount: 1500.0,
      status: BookingStatus.confirmed,
    ),
    BookingModel(
      id: '2',
      pujaName: 'Lakshmi Puja',
      customerName: 'Raj Kumar',
      customerPhone: '+91 9876543211',
      dateTime: DateTime(2025, 10, 12, 8, 0),
      location: 'Secunderabad',
      amount: 2000.0,
      status: BookingStatus.pending,
    ),
    BookingModel(
      id: '3',
      pujaName: 'Durga Puja',
      customerName: 'Anita Reddy',
      customerPhone: '+91 9876543212',
      dateTime: DateTime(2025, 10, 13, 6, 30),
      location: 'Banjara Hills',
      amount: 2500.0,
      status: BookingStatus.completed,
    ),
  ];

  UserModel get user => _user;
  List<BookingModel> get bookings => _bookings;
  List<BookingModel> get todayBookings => _bookings.where((booking) {
    final today = DateTime.now();
    return booking.dateTime.year == today.year &&
           booking.dateTime.month == today.month &&
           booking.dateTime.day == today.day;
  }).toList();

  void updateUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void updateBookingStatus(String bookingId, BookingStatus status) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: status);
      notifyListeners();
    }
  }

  List<BookingModel> getBookingsByStatus(BookingStatus? status) {
    if (status == null) return _bookings;
    return _bookings.where((booking) => booking.status == status).toList();
  }

  BookingModel? getNewBooking() {
    // Show the first booking regardless of status for new bookings section
    return _bookings.isNotEmpty ? _bookings.first : null;
  }

  bool isBookingAccepted(String bookingId) {
    return _acceptedBookings.contains(bookingId);
  }

  void acceptBooking(String bookingId) {
    _acceptedBookings.add(bookingId);
    _rejectedBookings.remove(bookingId);
    notifyListeners();
  }

  void rejectBooking(String bookingId) {
    _acceptedBookings.remove(bookingId);
    _rejectedBookings.add(bookingId);
    notifyListeners();
  }

  bool isBookingRejected(String bookingId) {
    return _rejectedBookings.contains(bookingId);
  }

  void addToDailyBookings(BookingModel booking) {
    // Booking is already in the list, just update status
    notifyListeners();
  }
}