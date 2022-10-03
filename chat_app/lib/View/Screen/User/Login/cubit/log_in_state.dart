part of 'log_in_cubit.dart';

@immutable
abstract class LogInState {}

class LogInInitial extends LogInState {}

//google Sign in
class LogInSignInGoogleLoadingState extends LogInState {}

class LogInSignInGoogleSuccessState extends LogInState {}

class LogInSignInGoogleErrorState extends LogInState {}

// Save Data User
class LogInSaveDataUserLoadedState extends LogInState {}

class LogInSaveDataUserSuccessState extends LogInState {}

class LogInSaveDataUserErrorState extends LogInState {}
