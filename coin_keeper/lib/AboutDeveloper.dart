import 'package:coin_keeper/Consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services package for clipboard operations

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color3,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.07, left: screenWidth * 0.05,right: screenWidth * 0.05),
              child: Row(
                children: [
                  const Text(
                    "Developer",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Lexend', fontSize: 18),
                  ),
                  Spacer(),
                  GestureDetector(onTap: (){
                    Navigator.pop(context);
                    },
                  child: const Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Lexend', fontSize: 14),
                  ),)
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: Image.asset(
                'assets/developerPhoto.png',
                width: screenWidth * 0.6,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Image.asset(
                'assets/NamePng.png',
                width: screenWidth * 0.7,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Center(
              child: Image.asset(
                'assets/studentImage.png',
                width: screenWidth * 0.7,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: GestureDetector(
                onTap: () {
                  const url = 'https://www.linkedin.com/in/manusha-upekshana/';
                  Clipboard.setData(
                      ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Center(
                            child: Text(
                      'link copied to clipboard',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Lexend'),
                    ))),
                  ); // Show snackbar notification
                },
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/linkedinLogo.png',
                        width: screenWidth * 0.1,
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      const Text("linkedin.com/manusha-upekshana"),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      const Icon(
                        Icons.copy,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: GestureDetector(
                onTap: () {
                  const url = 'https://github.com/manu5h';
                  Clipboard.setData(
                      ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Center(
                            child: Text(
                              'link copied to clipboard',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Lexend'),
                            ))),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/gitHubLogo.png', // Add your LinkedIn icon asset here
                        width: screenWidth * 0.1,
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      const Text("github.com/manu5h"),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      const Icon(
                        Icons.copy,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: AboutDeveloper(),
      ),
    ),
  );
}
