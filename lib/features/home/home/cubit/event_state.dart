import 'package:turn_digital/features/home/home/data/event_details_model.dart';

import '../data/event_model.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}

class EventDetailsLoading extends EventState {}

class EventDetailsLoaded extends EventState {
  final EventDetailsModel event;
  EventDetailsLoaded(this.event);
}

class EventDetailsError extends EventState {
  final String message;
  EventDetailsError(this.message);
}