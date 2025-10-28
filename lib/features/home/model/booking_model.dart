enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final String pujaName;
  final String customerName;
  final String customerPhone;
  final DateTime dateTime;
  final String location;
  final double amount;
  final BookingStatus status;
  final String? notes;

  const BookingModel({
    required this.id,
    required this.pujaName,
    required this.customerName,
    required this.customerPhone,
    required this.dateTime,
    required this.location,
    required this.amount,
    required this.status,
    this.notes,
  });

  BookingModel copyWith({
    String? id,
    String? pujaName,
    String? customerName,
    String? customerPhone,
    DateTime? dateTime,
    String? location,
    double? amount,
    BookingStatus? status,
    String? notes,
  }) {
    return BookingModel(
      id: id ?? this.id,
      pujaName: pujaName ?? this.pujaName,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}