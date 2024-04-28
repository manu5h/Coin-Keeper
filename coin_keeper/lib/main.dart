import 'dart:async';
import 'package:coin_keeper/Consts.dart';
import 'package:coin_keeper/Sheet%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home page starting.dart';

void main() async {
  // Ensure that the app runs only in portrait mode
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final String? isOpened; // Define isOpened at the class level

  const MyApp({Key? key, this.isOpened}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(isOpened: isOpened), // Pass isOpened to SplashScreen
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final String? isOpened; // Define isOpened at the class level

  const SplashScreen({Key? key, this.isOpened}) : super(key: key); // Constructor

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the appropriate page
    Timer(Duration(seconds: 3), () {
      navigateToNextPage(context);
    });
  }

  void navigateToNextPage(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isOpened = prefs.getString('isOpened'); // Initialize isOpened
    print('id: $isOpened');
    String initialRoute = isOpened != null ? '/newSheet' : '/isOpened';
    Navigator.of(context).pushReplacementNamed(initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color1,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Image.asset('assets/Banner_Image.png'),
              ),
              Spacer(),
              const LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color3),
                color: Color2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check the id and direct paths
    return FutureBuilder<String?>(
      future: _getIsOpened(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? userId = snapshot.data;
          if (userId != null) {
            return SheetPage(id: userId); // Pass userId as id
          } else {
            return StartingHomePage();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Future<String?> _getIsOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('isOpened');
  }
}
