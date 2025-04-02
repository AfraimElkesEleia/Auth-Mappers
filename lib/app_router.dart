import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_supabase_cubit.dart';
import 'package:auth_mappers/constants/routes.dart';
import 'package:auth_mappers/presentation/screens/home_screen.dart';
import 'package:auth_mappers/presentation/screens/map_screen.dart';
import 'package:auth_mappers/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late PhoneAuthSupabaseCubit phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthSupabaseCubit();
  }
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: phoneAuthCubit,
                child: HomeScreen(),
              ),
        );
      case otpScreen:
       final String phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: phoneAuthCubit,
                child: OtpScreen(phoneNumber: phoneNumber),
              ),
        );
    }
  }
}
