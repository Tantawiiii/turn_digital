class OrganizerModel {
  final String name;
  final String picture;
  final int numberOfFollowing;
  final int numberOfFollowers;
  final String about;
  final List<Event> events;
  final List<Review> reviews;

  OrganizerModel({
    required this.name,
    required this.picture,
    required this.numberOfFollowing,
    required this.numberOfFollowers,
    required this.about,
    required this.events,
    required this.reviews,
  });

  factory OrganizerModel.fromJson(Map<String, dynamic> json) {
    return OrganizerModel(
      name: json['name'],
      picture: json['picture'],
      numberOfFollowing: json['number_of_following'],
      numberOfFollowers: json['number_of_followers'],
      about: json['about'],
      events: (json['events'] as List).map((e) => Event.fromJson(e)).toList(),
      reviews: (json['reviews'] as List).map((r) => Review.fromJson(r)).toList(),
    );
  }
}

class Event {
  final int id;
  final String picture;
  final String date;
  final String title;

  Event({
    required this.id,
    required this.picture,
    required this.date,
    required this.title,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      picture: json['picture'],
      date: json['date'],
      title: json['title'],
    );
  }
}

class Review {
  final int reviewId;
  final String reviewerPicture;
  final String reviewerName;
  final int rate;
  final String review;
  final String reviewDate;

  Review({
    required this.reviewId,
    required this.reviewerPicture,
    required this.reviewerName,
    required this.rate,
    required this.review,
    required this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['review_id'],
      reviewerPicture: json['reviewer_picture'],
      reviewerName: json['reviewer_name'],
      rate: json['rate'],
      review: json['review'],
      reviewDate: json['review_date'],
    );
  }
}
