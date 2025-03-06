import 'package:intl/intl.dart';

class EventDetailsModel {
  final int eventId;
  final String picture;
  final DateTime date;
  final String title;
  final String address;
  final String addressTitle;
  final double latitude;
  final double longitude;
  final int numberOfGoing;
  final String aboutEvent;
  final double eventPrice;
  final Organizer organizer;

  EventDetailsModel({
    required this.eventId,
    required this.picture,
    required this.date,
    required this.title,
    required this.address,
    required this.addressTitle,
    required this.latitude,
    required this.longitude,
    required this.numberOfGoing,
    required this.aboutEvent,
    required this.eventPrice,
    required this.organizer,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      eventId: json['event_id'],
      picture: json['picture'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      address: json['address'],
      addressTitle: json['address_title'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      numberOfGoing: json['number_of_going'],
      aboutEvent: json['about_event'],
      eventPrice: double.parse(json['event_price']),
      organizer: Organizer.fromJson(json['organizer']),
    );
  }

  String get formattedDate {
    return DateFormat('d MMMM, yyyy').format(date);
  }

  String get formattedTime {
    final startTime = DateFormat('EEEE, h:mm a').format(date);
    final endTime = DateFormat('h:mm a').format(date.add(Duration(hours: 5)));
    return "$startTime - $endTime";
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
