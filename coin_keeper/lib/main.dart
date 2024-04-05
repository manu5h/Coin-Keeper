import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Consts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color1,
        body: Center(
          child: SizedBox(
            width: screenWidth * 0.6,
            height: screenHeight * 0.4,
            child: Image.asset("assets/Banner_Image.png"),
          )
        ),
      )
    );
  }
}

void main(){
  runApp(MainPage()
  );
}
