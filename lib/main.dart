import 'package:ctgb_appv1/features/app/splash_screen/splash_screen.dart';
import 'package:ctgb_appv1/features/user_auth/presentation/pages/home_page.dart';
import 'package:ctgb_appv1/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      name: 'CTGB',
      options: FirebaseOptions(
        apiKey: "AIzaSyB6kC8aabHIWimQgUC9IU3PvLVxlaLPrLY",
        appId: "1:985749654972:web:38f2f3138616530f206fb9",
        messagingSenderId: "985749654972",
        projectId: "ctgb-db872",
      ),
    );

    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle the error or display a message to the user
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => SplashScreen(
          child: LoginPage(),
        ),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        // ... other routes
      },
    );
  }
}
