import 'package:coin_keeper/Consts.dart';
import 'package:coin_keeper/Sheet%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'main.dart';

class StartingHomePage extends StatefulWidget {
  const StartingHomePage({super.key});

  @override
  State<StartingHomePage> createState() => _StartingHomePageState();
}

class _StartingHomePageState extends State<StartingHomePage> {
  bool lang = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color3,
        body: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.12,
              color: Color2,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Coin Keeper",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontSize: 18),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          lang = !lang;
                        });
                        print(lang);
                      },
                      child: Image.asset(
                        lang ? "assets/sinhala.png" : "assets/Eng.png",
                        width: lang ? screenWidth * 0.06 : screenWidth * 0.06,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Icon(Icons.developer_mode, color: Colors.white)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage("assets/Container_Background.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      lang
                          ? "Create new expence sheet"
                          : "නව වියදම් පත්‍රිකාවක් සාදන්න",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                        color: Color2, borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        CreatePopupScreen(context, lang);
                      },
                      child: Center(
                        child: Text(
                          lang ? "Create" : "සාදන්න",
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lexend',
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.07,
                color: Color2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.1, top: screenHeight * 0.02),
                    child: Text(
                      lang ? "Recent sheets" : "පසුගිය පත්‍රිකා",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Lexend'),
                    ),
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

void CreatePopupScreen(BuildContext context, bool lang) {
  String sheetName = "";
  int totalAmount = 0;
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang ? "Sheet name" : "වියදම් පත්‍රිකාවේ නම",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'lexend',
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(
                            child: TextFormField(
                              onChanged: (value) {
                                sheetName = value;
                              },
                              maxLength: 20,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                  fontFamily: 'Lexend'),
                              maxLines: 1,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          ),
                          Text(
                            lang ? "Total amount" : "මුලු මුදල",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'lexend',
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(
                            child: TextFormField(
                              onChanged: (value) {
                                totalAmount = int.tryParse(value) ?? 0;
                              },
                              maxLength: 7,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                  fontFamily: 'Lexend'),
                              maxLines: 1,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: () async {
                        if (sheetName == "" || totalAmount == 0) {
                          final snackBar = SnackBar(
                            backgroundColor: Color2,
                            content: Center(
                              child: Text(
                                lang
                                    ? 'Please enter name and amount.'
                                    : "කරුණාකර නම සහ මුදල ඇතුළත් කරන්න.",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Lexend',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar); // Show the SnackBar
                        } else {
                          print(sheetName);
                          print("Total amount 1: $totalAmount ");
                          SaveSheet(context, sheetName, totalAmount, lang);
                        }
                      },
                      child: Center(
                        child: Text(
                          lang ? "Create" : "සාදන්න",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Lexend'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> SaveSheet(
    BuildContext context, String sheetName, int totalAmount, bool lang) async {
  String isOpened;
  String dateTime = DateTime.now.toString();
  String id = Uuid().v4();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("id", id);
  await prefs.setString("${id}sheetName", sheetName);
  await prefs.setString("${id}dateTime", dateTime);
  await prefs.setInt("${id}totalAmount", totalAmount);
  await prefs.setString("isOpened", id);
  await prefs.setBool("lang", lang);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SheetPage()));
}

void main() {
  runApp(const MaterialApp(
    home: StartingHomePage(),
  ));
}
