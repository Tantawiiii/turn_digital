import 'package:flutter_bloc/flutter_bloc.dart';

class OtpState {
  final bool isValid;
  final String errorMessage;

  OtpState({required this.isValid, this.errorMessage = ''});
}

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState(isValid: false));

  void verifyOtp(String otp) {
    if (otp == "0000") {
      emit(OtpState(isValid: true));
    } else {
      emit(OtpState(isValid: false, errorMessage: "Invalid OTP"));
    }
  }
}
