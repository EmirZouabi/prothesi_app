import 'package:ctgb_appv1/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailrestcrontroler = TextEditingController();


  @override
  void dispose(){
    _emailrestcrontroler.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {

      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailrestcrontroler.text.trim());
      showDialog(context: context,
          builder: (context){
        return AlertDialog(
          content: Text('Password reset link sent! Check your email'),
        );
          },
      );
    } on FirebaseAuthException catch(e){
      print(e);
      showToast(message: "Some error occurred $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest password Page ",

        ),
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
            controller: _emailrestcrontroler,
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
        MaterialButton(onPressed: passwordRest,
        child: Text('Reset Password'),
          color: Colors.greenAccent[200],
        )
      ],
      ),
    );
  }
}
