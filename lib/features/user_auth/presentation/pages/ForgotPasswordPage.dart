import 'package:ctgb_appv1/features/exception/firebase_auth_exceptions.dart';
import 'package:ctgb_appv1/features/exception/format_exceptions.dart';
import 'package:ctgb_appv1/features/exception/platform_exceptions.dart';
import 'package:ctgb_appv1/global/common/toast.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../exception/firebase_exceptions.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailResetController = TextEditingController();



  @override
  void dispose() {
    _emailResetController.dispose();
    super.dispose();
  }

  bool isEmailValid(String email) {
    // Regular expression for email validation
    final RegExp regex =
    RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }



  Future<void> passwordReset() async {
    try {
      String email = _emailResetController.text.trim();

      if (email.isEmpty) {
        showToast(message: "Email cannot be empty ! Please enter a valid email.");
        return;
      }

      if (!isEmailValid(email)) {
        showToast(message: "Invalid email format! Please enter a valid email.");
        return;
      }


      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast(message: 'Password reset link sent! Check your email');
      return;
    } on FirebaseAuthException catch (e) {
      print(e);
      showToast(message: "Some error occurred $e ");
    }
  }

  //another meythode
  Future<void> sendPasswordResetEmail() async{
  String email = _emailResetController.text.trim();
    try{

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast(message: 'Password reset link sent! Check your email');

    } on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      throw 'Something went wrong. Please try again';
    }
  }


  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.greenAccent,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text('Enter Your Email ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailResetController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.greenAccent),
              ),
              hintText: 'Email',
              filled: true,
            ),
          ),
        ),
          SizedBox(height: 10),
        ElevatedButton(onPressed: ()async {await passwordReset();} ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.greenAccent)),
        child: Text('Reset Password',
        style: TextStyle(color: Colors.white
        )),

        )
      ],
      ),
    );
  }
}
