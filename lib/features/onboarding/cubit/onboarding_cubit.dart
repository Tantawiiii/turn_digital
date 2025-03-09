import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  late PageController pageController;
  int currentIndex = 0;

  OnBoardingCubit() : super(OnBoardingInitial()) {
    pageController = PageController();
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeDotState());
  }

  void nextPage() {
    currentIndex++;
    pageController.animateToPage(
      currentIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(NextPageState());
  }
}
