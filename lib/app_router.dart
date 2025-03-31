import 'package:auth_mappers/constants/routes.dart';
import 'package:auth_mappers/presentation/screens/home_screen.dart';
import 'package:auth_mappers/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouter{

  Route? generateRoutes(RouteSettings settings){
    switch(settings.name){
      case loginScreen:
        return MaterialPageRoute(builder: (_)=>HomeScreen());
      case otpScreen:
        return MaterialPageRoute(builder: (_)=>OtpScreen());
    }
  }
}