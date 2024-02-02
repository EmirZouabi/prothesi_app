import 'package:ctgb_appv1/features/app/splash_screen/splash_screen.dart';
import 'package:ctgb_appv1/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      name : 'CTGB',
      options: FirebaseOptions(
        apiKey: "your-api-key",
        appId: "your-app-id",
        messagingSenderId: "your-messaging-sender-id",
        projectId: "your-project-id",
      ),
    );
  }

  runApp(MyApp());
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
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}
