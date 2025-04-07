import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  // when code is sent
  late String verificationId;
  PhoneAuthCubit() : super(PhoneAuthInitial());
  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      // It gets called when verification happens automatically
      //PhoneAuthCredential :
      //----> This is an object containing the authentication credentials
      //----> It includes the verification ID and SMS code (if used)
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout:codeAutoRetrievalTimeout,
    );
  }
  Future<void> phoneVerificationCompleted(PhoneAuthCredential credential) async {
    print('verfication is completed');
    await signIn(credential);
  }
  void phoneVerificationFailed (FirebaseAuthException error) {
    print('verificationFailed : ${error.message}');
    emit(ErrorOccured(message: error.message!));
  }
  void codeSent(String verificationId , int? resendToken){
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }
  void codeAutoRetrievalTimeout(String verificationId) {
    //Time needed of trying in phoneVerficationComplete automatic
    // On Android devices which support automatic SMS code resolution, 
    //this handler will be called if the device has not automatically resolved an SMS message within a certain timeframe. Once the timeframe has passed, the device will no longer attempt to resolve any incoming messages.
    print('CodeAutoRetrivalTimeout');
  }
  Future<void> submitOTP(String otp) async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    await signIn(credential);
  }
  Future<void> signIn(PhoneAuthCredential credential) async{
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    }catch(e){
      print('Wrong OTP');
      emit(ErrorOccured(message: e.toString()));
    }
  }
  Future<void> logout()async{
    await FirebaseAuth.instance.signOut();
  }
  User getLoggedinUser(){
    return FirebaseAuth.instance.currentUser!;
  }
  Future<void> signInWithGoogle() async {
    emit(Loading());
  // Trigger the authentication flow
  try{
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
  emit(GoogleAuthCompleted());
  }catch(e){
    emit(ErrorOccured(message: e.toString()));
  }
}
}
