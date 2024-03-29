
import 'package:flutter/material.dart';
import 'package:foodapp/screens/auth/sign_in_screen.dart';
import 'package:foodapp/screens/auth/sign_up_screen.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  bool _showSignInScreen = true;

  void toogleView(){
    setState(() {
      _showSignInScreen =!_showSignInScreen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _showSignInScreen
          ? SignInScreen(toogleView: toogleView)
          : SignUpScreen(toogleView: toogleView),
    );
  }
}
