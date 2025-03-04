
part of 'onboarding_cubit.dart';


@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState{}

class NextPageState extends OnBoardingState {}
class ChangeDotState extends OnBoardingState {}
