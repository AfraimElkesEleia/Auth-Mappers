part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

final class Loading extends PhoneAuthState {}

final class ErrorOccured extends PhoneAuthState {
  final String message;
  ErrorOccured({required this.message});
}

// state when user enter his number and i should start to connect with firebase
final class PhoneNumberSubmitted extends PhoneAuthState {}

// state when user submit the code that is arrived on his phone
final class PhoneOTPVerified extends PhoneAuthState {}
