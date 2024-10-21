import 'package:flutter/material.dart';
import 'dart:async';

class CountdownScreen extends StatefulWidget {
  final int totalTimeInSeconds;

  CountdownScreen({required this.totalTimeInSeconds});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  late int remainingTime;
  late Timer timer;
  bool isPaused = false;  // Track whether the timer is paused

  @override
  void initState() {
    super.initState();
    remainingTime = widget.totalTimeInSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          Navigator.pop(context);  // Return to the time-setting page when finished
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
      timer.cancel();
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
      startTimer();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int time) {
    int hours = time ~/ 3600;
    int minutes = (time % 3600) ~/ 60;
    int seconds = time % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          SizedBox(height: 50), // Extra space to move the title lower
          Center(
            child: Text(
              'Countdown Timer',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                Stack(
                  alignment: Alignment.center,  // Center the text inside the circle
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: CircularProgressIndicator(
                        value: remainingTime / widget.totalTimeInSeconds,
                        strokeWidth: 6,
                        color: Colors.white,
                        backgroundColor: Colors.red[200],
                      ),
                    ),
                    Text(
                      formatTime(remainingTime),
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: IconButton(
              icon: Icon(
                isPaused ? Icons.play_circle_fill : Icons.pause_circle_filled,
                size: 64,
                color: Colors.white,
              ),
              onPressed: () {
                if (isPaused) {
                  resumeTimer();
                } else {
                  pauseTimer();
                }
              },
            ),
          ),
          SizedBox(height: 30),  // Padding at the bottom
        ],
      ),
    );
  }
}
