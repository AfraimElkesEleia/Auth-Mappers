import 'package:auth_mappers/business_logic/cubit/maps/maps_cubit.dart';
import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:auth_mappers/data/repository/map_repo.dart';
import 'package:auth_mappers/data/web_services/places_web_services.dart';
import 'package:auth_mappers/presentation/screens/home_screen.dart';
import 'package:auth_mappers/presentation/screens/map_screen.dart';
import 'package:auth_mappers/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late PhoneAuthCubit phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => MapsCubit(
                      mapRepository: MapRepository(
                        placesWebServices: PlacesWebServices(),
                      ),
                    ),
                child: MapScreen(),
              ),
        );
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
