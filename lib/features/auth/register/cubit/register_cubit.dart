import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turn_digital/core/constant/apis_const.dart';
import 'package:turn_digital/features/auth/register/cubit/register_state.dart';

import '../../../../core/helper/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void register(String name, String email, String password) async {
    emit(RegisterLoading());
    final response = await DioHelper.postData(
      url: ApisClient.API_Register,
      data: {'name': name, 'email': email, 'password': password},
    );
    if (response != null && response.statusCode == 200) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterFailure("Registration Failed"));
    }
  }
}