import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Consts.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({
    super.key,
  });

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  String sheetName = '';
  String id = '';
  late String dateTime;
  int totalAmount = 0;
  int spentAmount = 13000;
  late bool isOpened;
  bool lang = true;

  @override
  void initState() {
    super.initState();
    RetriveSheetData();
  }

  Future<void> RetriveSheetData() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('isOpened') ?? "Null";
    sheetName = prefs.getString("${id}sheetName") ?? "Untitled Sheet";
    totalAmount = prefs.getInt("${id}totalAmount") ?? 10;
    lang = prefs.getBool("lang") ?? true;
    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    int remainingBalance = totalAmount - spentAmount;
    print("remainingBalance : $remainingBalance");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double progressingContainerMaxWidth = screenWidth * 0.85;
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
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Icon(Icons.developer_mode, color: Colors.white)
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, top: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    sheetName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "lexend",
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
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.3),
                                child: GestureDetector(
                                  onTap: () {
                                    UpdateTotalAmount();
                                  },
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
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
                            remainingBalance.toDouble(), progressingContainerMaxWidth),
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
                        child:
                        Text( remainingBalance>=0 ?
                          lang
                              ? "Remaining: $remainingBalance /="
                              : "ඉතිරි: $remainingBalance /="
                        :
                        lang
                            ? "Overspent: ${remainingBalance*-1} /="
                            : "වැඩිපුර වියදම: ${remainingBalance*-1} /=",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateProgressContainerWidth(
      double remainingBalance, double maxWidth) {
    if (remainingBalance <= 0) {
      return maxWidth; // Width is 0 when remaining balance is zero or negative
    } else {
      return maxWidth *
          (spentAmount /
              totalAmount); // Width is maximum when remaining balance exceeds total amount
    }
  }

  void UpdateTotalAmount() {
    @override
    final controller = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller.text = totalAmount.toString();
        return WillPopScope(
          onWillPop: () async {
            // Prevent back button from working
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.2),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.15),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.25,
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
                                lang
                                    ? "Update total amount"
                                    : "මුලු මුදල යාවත්කාලීන කරන්න",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    decoration: TextDecoration.none),
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: controller,
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
                        width: screenWidth * 0.42,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () async {
                            if (totalAmount == 0) {
                              final snackBar = SnackBar(
                                backgroundColor: Color2,
                                content: Center(
                                  child: Text(
                                    lang
                                        ? 'Please enter amount.'
                                        : "කරුණාකර මුදල ඇතුළත් කරන්න.",
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
                              Navigator.pop(context);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt(
                                  "${id}totalAmount", totalAmount);
                            }
                          },
                          child: Center(
                            child: Text(
                              lang ? "Update" : "යාවත්කාලීන කරන්න",
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
          ),
        );
      },
    );
  }
}
