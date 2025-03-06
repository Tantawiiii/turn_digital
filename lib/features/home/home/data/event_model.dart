class Event {
  final int eventId;
  final String picture;
  final String date;
  final String title;
  final String address;
  final int numberOfGoing;
  final Organizer organizer;

  Event({
    required this.eventId,
    required this.picture,
    required this.date,
    required this.title,
    required this.address,
    required this.numberOfGoing,
    required this.organizer,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['event_id'],
      picture: json['picture'],
      date: json['date'],
      title: json['title'],
      address: json['address'],
      numberOfGoing: json['number_of_going'],
      organizer: Organizer.fromJson(json['organizer']),
    );
  }
}

class Organizer {
  final int id;
  final String name;
  final String picture;

  Organizer({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
    );
  }
}
