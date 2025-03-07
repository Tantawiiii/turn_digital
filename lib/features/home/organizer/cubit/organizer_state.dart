import '../model/organizer_model.dart';

abstract class OrganizerState {}

class OrganizerInitial extends OrganizerState {}

class OrganizerLoading extends OrganizerState {}

class OrganizerLoaded extends OrganizerState {
  final OrganizerModel organizer;
  OrganizerLoaded(this.organizer);
}

class OrganizerError extends OrganizerState {
  final String message;
  OrganizerError(this.message);
}
