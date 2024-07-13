class CourtReservationModel {
  String id;
  DateTime startingDateTime;
  DateTime endingDateTime;
  String courtId;
  String usedId;
  String comment;
  int price;

  CourtReservationModel({
    required this.id,
    required this.startingDateTime,
    required this.endingDateTime,
    required this.courtId,
    required this.usedId,
    required this.comment,
    required this.price,
});

}