import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Consts.dart';

class RecentSheet extends StatefulWidget {
  final String id;
  const RecentSheet({super.key, required this.id});

  @override
  State<RecentSheet> createState() => _RecentSheetState();
}

class _RecentSheetState extends State<RecentSheet> {
  String sheetName = '';
  late String date = '';
  int totalAmount = 0;
  bool lang = true;
  List<String>? listOfExpensesNames;
  List<String>? listOfExpensesAmounts;

  @override
  void initState() {
    super.initState();
    RetriveSheetData();
  }

  Future<void> RetriveSheetData() async {
    final prefs = await SharedPreferences.getInstance();
    sheetName = prefs.getString("${widget.id}sheetName") ?? "Untitled Sheet";
    date = prefs.getString("${widget.id}dateTime") ?? "Date not updated";
    totalAmount = prefs.getInt("${widget.id}totalAmount") ?? 0;
    lang = prefs.getBool("lang") ?? true;
    listOfExpensesNames = prefs.getStringList('${widget.id}ExpensesNames');
    listOfExpensesAmounts = prefs.getStringList('${widget.id}ExpensesAmounts');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int spentAmount_ = 0;
    int spentAmount = 0;
    if (listOfExpensesAmounts?.length != null) {
      for (int i = 0; i < listOfExpensesAmounts!.length; i++) {
        int amount = int.parse(listOfExpensesAmounts![i]);
        spentAmount_ = spentAmount_ + amount;
      }
      spentAmount = spentAmount_;
    }
    int remainingBalance = totalAmount - spentAmount;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double progressingContainerMaxWidth = screenWidth * 0.85;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color3,
        body: SingleChildScrollView(
          child: Column(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Text(
                        lang ? "recent sheets" : "පෙර පත්‍ර",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lexend',
                            fontSize: 18),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool("lang", !lang);
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      sheetName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.05,
                        fontFamily: "lexend",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: screenWidth * 0.26,
                            width: screenWidth * 0.415,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/Container_Background.jpg"),
                                  fit: BoxFit.fill),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.03),
                                  child: Column(
                                    children: [
                                      Text(
                                        lang ? "Total amount" : "මුලු මුදල",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "$totalAmount /=",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: screenWidth * 0.25,
                            width: screenWidth * 0.415,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/Container_Background.jpg"),
                                  fit: BoxFit.fill),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.03),
                                  child: Column(
                                    children: [
                                      Text(
                                        lang ? "Spent amount" : "වැයවූ මුදල",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Lexend',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "$spentAmount /=",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color4,
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0,
                          top: 0,
                          height: screenHeight * 0.05,
                          width: calculateProgressContainerWidth(
                              remainingBalance.toDouble(),
                              progressingContainerMaxWidth,
                              spentAmount),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color2,
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.015,
                          left: screenWidth * 0.02,
                          child: Text(
                            remainingBalance >= 0
                                ? lang
                                    ? "Remaining: $remainingBalance /="
                                    : "ඉතිරි: $remainingBalance /="
                                : lang
                                    ? "Overspent: ${remainingBalance * -1} /="
                                    : "වැඩිපුර වියදම: ${remainingBalance * -1} /=",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              listOfExpensesNames != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                      child: Container(
                        height: screenHeight * 0.45,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: screenHeight * 0.0),
                          itemCount: listOfExpensesNames?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.only(top: 0),
                              title: Container(
                                height: screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.06,
                                      right: screenWidth * 0.06),
                                  child: Row(
                                    children: [
                                      Text(
                                        listOfExpensesNames![index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lexend',
                                            fontSize: 14),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${listOfExpensesAmounts![index]} /=",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontFamily: 'Lexend',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Text(
                      lang
                          ? "no expenses in this sheet"
                          : "මෙම පත්‍රයේ වියදම් නොමැත",
                      style:
                          const TextStyle(fontSize: 12, fontFamily: 'Lexend'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateProgressContainerWidth(
      double remainingBalance, double maxWidth, int spentAmount) {
    if (remainingBalance <= 0) {
      return maxWidth; // Width is 0 when remaining balance is zero or negative
    } else {
      return maxWidth *
          (spentAmount /
              totalAmount); // Width is maximum when remaining balance exceeds total amount
    }
  }
}
