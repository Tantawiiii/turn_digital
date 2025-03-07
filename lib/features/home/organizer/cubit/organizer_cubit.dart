import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/dio_helper.dart';
import '../model/organizer_model.dart';
import 'organizer_state.dart';

class OrganizerCubit extends Cubit<OrganizerState> {
  OrganizerCubit() : super(OrganizerInitial());

  void fetchOrganizerDetails(int organizerId) async {
    emit(OrganizerLoading());

    try {
      final response = await DioHelper.getData(
        url: 'organizers/$organizerId',
      );

      if (response!.statusCode == 200 && response.data != null && response.data['success'] == true) {
        final eventData = response.data['data'];
        final singleEvent = OrganizerModel.fromJson(eventData);

        emit(OrganizerLoaded(singleEvent));
      } else {
        emit(OrganizerError("Failed to load organizer details."));
      }
    } catch (e) {
      emit(OrganizerError(e.toString()));
    }
  }
}
