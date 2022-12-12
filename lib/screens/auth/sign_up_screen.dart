
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/main.dart';
import 'package:foodapp/services/auth_service.dart';
import 'package:lottie/lottie.dart';

import '../home/home.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toogleView;
  const SignUpScreen({Key? key, required this.toogleView}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: (){
                widget.toogleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In')
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/images/food_app_icon.json', width:250),
            Text('TO DO', style: Theme.of(context).textTheme.headline6,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(hintText: 'Enter email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val == null || !val.contains('@')
                              ? 'Enter valid email address'
                              : null),
                      SizedBox(height: 20,),
                      TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(hintText: 'Enter password'),
                          obscureText: true,
                          validator: (val) => val!.length <6
                              ? 'Enter a password of at least 6 chars'
                              : null),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState!.validate())
                            {
                              final user = await AuthService()
                                  .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _pwdController.text);
                              if (user != null)
                              {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeScreen())
                                // );
                              }
                            }
                          },
                          child:  Text('Sign Up'))
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}