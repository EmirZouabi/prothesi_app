  import 'package:ctgb_appv1/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
  import 'package:ctgb_appv1/features/user_auth/presentation/pages/home_page.dart';
  import 'package:ctgb_appv1/features/user_auth/presentation/pages/sign_up_page.dart';
  import 'package:ctgb_appv1/features/user_auth/presentation/widgets/form_container_widget.dart';
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';


  class LoginPage extends StatefulWidget {
    const LoginPage({Key? key}) : super(key: key);

    @override
    _LoginPageState createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    final FirebaseAuthServices _auth = FirebaseAuthServices();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: _login, // Use a function for the login logic
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    void _login() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        // Sign in with email and password using Firebase authentication
        User? user = await _auth.signInWithEmailAndPassword(email, password);

        if (user != null) {
          // Successful login, navigate to home page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          // Handle the case where user is null (login failed)
          print("Invalid credentials. Please check your email and password.");
        }
      } catch (e) {
        // Handle other login errors
        print("Error during login: $e");
      }
    }
  }
