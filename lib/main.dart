import 'package:flutter/material.dart';
import 'package:foodapp/config/custom_theme.dart';
import 'package:foodapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
 final Future<FirebaseApp> _initialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if (snapshot.hasError)
          {
            return Center(child: Text('There was an error'),);
          }
        if (snapshot.connectionState == ConnectionState.done)
          {
            return MultiProvider(
              providers:[ StreamProvider<User?>.value(
                  value: FirebaseAuth.instance.authStateChanges(),
                  initialData: FirebaseAuth.instance.currentUser),
                ChangeNotifierProvider(create: (context) =>CustomTheme())
              ],
                  child: Wrapper()
              );
          }
        return CircularProgressIndicator();
      },
    );
  }
}

