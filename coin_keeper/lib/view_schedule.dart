import 'dart:convert';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  final String userId;
  final String gymId;

  const Schedule({Key? key, required this.userId, required this.gymId})
      : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String schedule = "";

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF323335),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: screenWidth * 0.27,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'lexend',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'lexend',
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 60),
              Container(
                height: screenHeight * 0.6,
                width: screenWidth * 0.8,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF4A4B4D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: schedule.isEmpty
                      ? const Center(
                    child: Text(
                      "Schedule unavailable!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  )
                      : Text(
                    schedule,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'lexend',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
