import 'package:auth_mappers/app_router.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:auth_mappers/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late final String initialRoute ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //  FirebaseAuth.instance.authStateChanges().listen((user) {
  //   if (user == null) {
  //     initialRoute = loginScreen;
  //   } else {
  //     initialRoute = mapScreen;
  //     }
  //   }
  // );
  final user = FirebaseAuth.instance.currentUser;
   if (user == null) {
      initialRoute = loginScreen;
      print('here login');
    } else {
      print('here map screen');
      initialRoute = mapScreen;
    }
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoutes,
      initialRoute: initialRoute,
    );
  }
}
