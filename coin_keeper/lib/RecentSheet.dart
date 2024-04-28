import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentSheet extends StatefulWidget {
  final String id;
  const RecentSheet({super.key, required this.id});

  @override
  State<RecentSheet> createState() => _RecentSheetState();
}

class _RecentSheetState extends State<RecentSheet> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Text(widget.id)),
      ),
    );
  }
}
