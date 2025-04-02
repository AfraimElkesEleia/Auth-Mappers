import 'package:auth_mappers/app_router.dart';
import 'package:auth_mappers/constants/routes.dart';
// import 'package:auth_mappers/constants/routes.dart';
// import 'package:auth_mappers/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((user){
    if(user == null){
      initialRoute = loginScreen;
    }else{
      initialRoute = mapScreen;
    }
  });*/
  await Supabase.initialize(
    url: 'https://vdpwcvgkiakahtdgiemv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZkcHdjdmdraWFrYWh0ZGdpZW12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1Njc4MzgsImV4cCI6MjA1OTE0MzgzOH0.EPKG-g4lGa-PIZDWplbUAsLk3x1jaqFzuL_WVnRCcGA',
  );
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    initialRoute = mapScreen;
  } else {
    initialRoute = loginScreen;
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
      initialRoute: mapScreen,
    );
  }
}
