import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PhoneAuthSupabaseCubit extends Cubit<PhoneAuthState> {
  PhoneAuthSupabaseCubit() : super(PhoneAuthInitial());
  Future<void> submitPhoneNumber(String phone) async {
    emit(Loading());
    try {
      await Supabase.instance.client.auth.signInWithOtp(phone: '+2$phone');
      emit(PhoneNumberSubmitted());
    } catch (e) {
      emit(ErrorOccured(message: e.toString()));
    }
  }
  Future<void> signIn(String phone , String otp) async{
    emit(Loading());
    try{
      await Supabase.instance.client.auth.verifyOTP(type: OtpType.sms,token: otp,phone:phone);
    }catch(e){
      emit(ErrorOccured(message: e.toString()));
    }
  }
  Future<void> logout()async{
    await Supabase.instance.client.auth.signOut();
  }
}
