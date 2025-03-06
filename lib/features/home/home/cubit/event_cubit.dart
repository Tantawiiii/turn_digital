import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turn_digital/core/constant/apis_const.dart';
import 'package:turn_digital/features/home/home/data/event_details_model.dart';
import '../../../../core/helper/dio_helper.dart';
import '../data/event_model.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  int _currentPage = 1;
  final int _limit = 10;
  bool hasMore = true;
  List<Event> events = [];

  Future<void> fetchEvents({bool isRefresh = false}) async {
    if (state is EventLoading || !hasMore) return;

    try {
      if (isRefresh) {
        _currentPage = 1;
        events.clear();
        hasMore = true;
        emit(EventLoading());
      }

      final response = await DioHelper.getData(
        url: ApisClient.API_Event,
        queryParams: {
          "page": _currentPage,
          "limit": _limit,
        },
      );

      if (response != null && response.data['success']) {
        List<Event> newEvents = (response.data['data']['events'] as List)
            .map((eventJson) => Event.fromJson(eventJson))
            .toList();

        if (newEvents.length < _limit) {
          hasMore = false;
        }

        events.addAll(newEvents);
        emit(EventLoaded(List.from(events)));

        _currentPage++;
      } else {
        emit(EventError('Failed to fetch events'));
      }
    } catch (e) {
      emit(EventError('An error occurred'));
    }
  }

  Future<void> fetchEventById(int eventId) async {
    try {
      emit(EventDetailsLoading());

      final response = await DioHelper.getData(
        url: 'events/$eventId',
      );

      if (response!.statusCode == 200 && response.data != null && response.data['success'] == true) {
        final eventData = response.data['data'];
        final singleEvent = EventDetailsModel.fromJson(eventData);

        emit(EventDetailsLoaded(singleEvent));
      } else {
        emit(EventDetailsError('Failed to load event details.'));
      }
    } catch (e) {
      emit(EventDetailsError(e.toString()));
    }
  }

}
