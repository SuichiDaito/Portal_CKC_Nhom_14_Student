abstract class StudentPointEvent {}

class FetchPointResultEvent extends StudentPointEvent {
  final int chuyenNganh;
  FetchPointResultEvent({required this.chuyenNganh});
}
