part of 'home_cubit_cubit.dart';

@immutable
abstract class HomeState {}

class HomeCubitInitial extends HomeState {}

// Get Data User
class HomeGetDataUserLoadedState extends HomeState {}

class HomeGetDataUserSuccessState extends HomeState {}

class HomeGetDataUserErrorState extends HomeState {}

//send Message Me
class HomeSendMessageSuccessState extends HomeState {}

class HomeSendMessageErrorState extends HomeState {}

//send Message You
class HomeSendMessageYouSuccessState extends HomeState {}

class HomeSendMessageYouErrorState extends HomeState {}

//Sign Out
class HomeSignOutLoadedState extends HomeState {}

class HomeSignOutSuccessState extends HomeState {}

//is Write
class HomeWriteDoneState extends HomeState {}

class HomeWriteNotDoneState extends HomeState {}
