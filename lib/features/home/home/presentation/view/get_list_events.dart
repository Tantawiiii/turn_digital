import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/event_cubit.dart';

import '../../cubit/event_state.dart';
import '../widgets/event_card.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  late EventCubit _eventCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _eventCubit = context.read<EventCubit>();
    _eventCubit.fetchEvents(isRefresh: true);

    // Pagination Listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _eventCubit.fetchEvents();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Events")),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading && _eventCubit.events.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          } else if (state is EventLoaded) {
            final events = state.events;

            return ListView.builder(
              controller: _scrollController,
              itemCount: events.length + 1,
              itemBuilder: (context, index) {
                if (index == events.length) {
                  return _eventCubit.hasMore
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox();
                }

                final event = events[index];
                return EventCard(
                  eventImage: event.picture,
                  eventTitle: event.title,
                  eventDate: event.date,
                  attendees: [event.organizer.picture],
                  eventLocation: event.address,
                  numberOfGoing: event.numberOfGoing,
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
