import 'package:coin_keeper/Home%20page%20starting.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Consts.dart';
import 'RecentSheet.dart';

class SheetPage extends StatefulWidget {
  final String id;
  const SheetPage({
    super.key,
    required this.id,
  });

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  String sheetName = '';
  String recentSheetName = '';
  String expenseName = '';
  String isOpened_ = '';
  int expenseAmount = 0;
  late String date = '';
  int totalAmount = 0;
  late bool isOpened;
  bool lang = true;
  List<String>? listOfExpensesNames = [];
  List<String>? listOfExpensesAmounts = [];
  List<String>? listOfIds_ = [];
  List<String>? listOfSheetNames = [];
  List<String>? listOfSheetDates = [];
  List<String>? listOfDeletedExpensesNames = [];
  List<String>? listOfDeletedExpensesAmounts = [];

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

    final List<String>? listOfIds = prefs.getStringList('listOfIds');
    for (int i = 0; i < listOfIds!.length; i++) {
      isOpened_ = prefs.getString("isOpened") ?? "o";
      if (listOfIds[i] != isOpened_) {
        recentSheetName =
            prefs.getString("${listOfIds[i]}sheetName") ?? "Untitled Sheet";
        listOfSheetNames?.add(recentSheetName);
        date = prefs.getString("${listOfIds[i]}dateTime") ?? "Date not updated";
        listOfSheetDates?.add(date);
      }
    }
    listOfIds_ = prefs.getStringList("listOfIds") ?? [];

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
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: MaterialApp(
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
                            width:
                                lang ? screenWidth * 0.06 : screenWidth * 0.06,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
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
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.03),
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
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.3),
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
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.03),
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
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05),
                        child: Container(
                          height: screenHeight * 0.45,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: screenHeight * 0.0),
                            itemCount: listOfExpensesNames?.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onLongPress: () {
                                  deleteExpense(index);
                                },
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
                    : Column(
                        children: [
                          Text(
                            lang
                                ? "Click (+) to add an expense"
                                : "වියදමක් එක් කිරීමට (+) ඔබන්න",
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Image(
                            image: AssetImage("assets/arrow.png"),
                            width: screenHeight * 0.2,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Color3,
            color: Color2,
            items: const [
              CurvedNavigationBarItem(
                  child: Icon(
                Icons.list,
                color: Colors.white,
              )),
              CurvedNavigationBarItem(
                  child: Icon(
                Icons.add,
                color: Colors.white,
              )),
              CurvedNavigationBarItem(
                  child: Icon(
                Icons.offline_pin_outlined,
                color: Colors.white,
              )),
              CurvedNavigationBarItem(
                  child: Icon(
                Icons.history_sharp,
                color: Colors.white,
              )),
            ],
            onTap: (int index) {
              // add expense
              if (index == 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async {
                        // Prevent back button from working
                        return false;
                      },
                      child: Scaffold(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        body: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.15),
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight * 0.5,
                                    width: screenWidth * 0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.05,
                                          right: screenWidth * 0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              lang
                                                  ? "Add new expense"
                                                  : "නව වියදම් එකතු කරන්න",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'lexend',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w100,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.05,
                                          ),
                                          Text(
                                            lang ? "Name" : "නම",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'lexend',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w100,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          SizedBox(
                                            child: TextFormField(
                                              onChanged: (value) {
                                                expenseName = value;
                                              },
                                              maxLength: 20,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
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
                                            lang ? "Amount" : "මුදල",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'lexend',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w100,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          SizedBox(
                                            child: TextFormField(
                                              onChanged: (value) {
                                                expenseAmount =
                                                    int.tryParse(value) ?? 0;
                                              },
                                              maxLength: 7,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1,
                                        right: screenWidth * 0.1),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.05,
                                          width: screenWidth * 0.3,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SheetPage(
                                                    id: widget.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                lang ? "Discard" : "ඉවතලන්න",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: 'Lexend'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: screenHeight * 0.05,
                                          width: screenWidth * 0.3,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (expenseName == "" ||
                                                  expenseAmount == 0) {
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
                                                    .showSnackBar(
                                                        snackBar); // Show the SnackBar
                                              } else {
                                                print(
                                                    "${listOfExpensesNames} list of sheet names");
                                                print(
                                                    "${listOfExpensesAmounts} list of sheet amounts");
                                                AddExpense(
                                                    context,
                                                    widget.id,
                                                    expenseName,
                                                    expenseAmount.toString());
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                lang ? "Add" : "එකතු කරන්න",
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

              // close a sheet

              if (index == 2) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async {
                        // Prevent back button from working
                        return false;
                      },
                      child: Scaffold(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        body: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: screenHeight * 0.3),
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              lang
                                                  ? "Close expense sheet"
                                                  : "වියදම් පත්‍රිකාව අවසන් කරන්න",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'lexend',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.03,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1,
                                        right: screenWidth * 0.1),
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SheetPage(
                                                    id: widget.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                child: Text(
                                                  lang ? "Discard" : "ඉවතලන්න",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'lexend',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              finalizedSheet();
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StartingHomePage()),
                                                (Route<dynamic> route) =>
                                                    false,
                                              );
                                            },
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.3,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  lang
                                                      ? "Close"
                                                      : "අවසන් කරන්න",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'lexend',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
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

              //Recent sheets
              if (index == 3) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async {
                        // Prevent back button from working
                        return false;
                      },
                      child: Scaffold(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        body: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.17),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1,
                                        right: screenWidth * 0.1),
                                    child: SizedBox(
                                      child: Container(
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.8,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            lang
                                                ? "Recent sheets"
                                                : "පෙර පත්‍ර",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'lexend',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w100,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Container(
                                    height: screenHeight * 0.5,
                                    width: screenWidth * 0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: listOfSheetNames!.length > 0
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                              left: screenWidth * 0.05,
                                              right: screenWidth * 0.05,
                                            ),
                                            child: Container(
                                              height: screenHeight * 0.6,
                                              child: ListView.builder(
                                                padding: EdgeInsets.only(
                                                    top: screenHeight * 0.0),
                                                itemCount:
                                                    listOfSheetNames?.length,
                                                itemBuilder: (context, index) {
                                                  final reverseIndex =
                                                      listOfSheetNames!.length -
                                                          1 -
                                                          index;
                                                  return ListTile(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              RecentSheet(
                                                            id: listOfIds_![
                                                                reverseIndex],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    contentPadding:
                                                        EdgeInsets.only(top: 0),
                                                    title: Container(
                                                      height:
                                                          screenHeight * 0.07,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.black,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            listOfSheetNames![
                                                                reverseIndex],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Lexend',
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            listOfSheetDates![
                                                                reverseIndex],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontFamily:
                                                                    'Lexend',
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              lang
                                                  ? "No recent sheets !"
                                                  : "පෙර පත්‍ර නැත !",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Lexend',
                                                  color: Colors.white
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.03,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1,
                                        right: screenWidth * 0.1),
                                    child: SizedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SheetPage(
                                                        id: widget.id,
                                                      )));
                                        },
                                        child: Container(
                                          height: screenHeight * 0.05,
                                          width: screenWidth * 0.3,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              lang ? "Discard" : "ඉවතලන්න",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'lexend',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
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
            },
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
                        height: screenHeight * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              lang ? "Save" : "සුරකින්න",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'lexend',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  decoration: TextDecoration.none),
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

  Future<void> deleteExpense(int index) async {
    final prefs = await SharedPreferences.getInstance();
    @override
    final controller = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller.text = totalAmount.toString();
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.3),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.4),
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.15,
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
                            Center(
                              child: Text(
                                lang ? "Delete expense" : "වියදම මකාදමන්න",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      lang ? "Discard" : "ඉවතලන්න",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'lexend',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w100,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      List<String>? expensesNamesList =
                                          prefs.getStringList(
                                              '${widget.id}ExpensesNames');
                                      List<String>? expensesAmountsList =
                                          prefs.getStringList(
                                              '${widget.id}ExpensesAmounts');

                                      expensesNamesList?.removeAt(index);
                                      expensesAmountsList?.removeAt(index);

                                      await prefs.setStringList(
                                          '${widget.id}ExpensesNames',
                                          expensesNamesList!);
                                      await prefs.setStringList(
                                          '${widget.id}ExpensesAmounts',
                                          expensesAmountsList!);

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SheetPage(
                                                    id: widget.id,
                                                  )));
                                    },
                                    child: Text(
                                      lang ? "Delete" : "මකන්න",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'lexend',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w100,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
}

Future<void> AddExpense(BuildContext context, String id, String newExpenseName,
    String newAmount) async {
  final prefs = await SharedPreferences.getInstance();

  // Retrieve the existing list from SharedPreferences
  List<String>? existingNamesList = prefs.getStringList('${id}ExpensesNames');
  List<String>? existingAmountList =
      prefs.getStringList('${id}ExpensesAmounts');

  // Add the new element to the existing list
  if (existingNamesList != null) {
    existingNamesList.add(newExpenseName);
  } else {
    existingNamesList = [newExpenseName];
  }

  // Store the updated list back into SharedPreferences
  await prefs.setStringList('${id}ExpensesNames', existingNamesList);

  // Add the new element to the existing list
  if (existingAmountList != null) {
    existingAmountList.add(newAmount);
  } else {
    existingAmountList = [newAmount];
  }

  // Store the updated list back into SharedPreferences
  await prefs.setStringList('${id}ExpensesAmounts', existingAmountList);

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SheetPage(
                id: id,
              )));
}

Future<void> finalizedSheet() async {
  final prefs = await SharedPreferences.getInstance();

  // Remove data for the 'isOpened' key.
  await prefs.remove('isOpened');
}

// navigate to the phone home page when pressed back button
Future<bool> _onWillPop(BuildContext context) async {
  SystemNavigator.pop();
  return false;
}

void main() {
  runApp(const MaterialApp(
    home: SheetPage(
      id: '',
    ),
  ));
}
