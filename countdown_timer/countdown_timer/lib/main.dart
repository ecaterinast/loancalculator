import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:countdown_timer/CowntdownScreen.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => CountdownApp(), 
    ),);
}

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetTimerScreen(),
    );
  }
}

class SetTimerScreen extends StatefulWidget {
  @override
  _SetTimerScreenState createState() => _SetTimerScreenState();
}

class _SetTimerScreenState extends State<SetTimerScreen> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          SizedBox(height: 50), // Spacing to move the title lower
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                  children: [
                    TimePickerUnit(
                      label: "hour(s)",
                      value: hours,
                      onChanged: (val) {
                        setState(() {
                          hours = val ?? 0;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    TimePickerUnit(
                      label: "minute(s)",
                      value: minutes,
                      onChanged: (val) {
                        setState(() {
                          minutes = val ?? 0;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    TimePickerUnit(
                      label: "second(s)",
                      value: seconds,
                      onChanged: (val) {
                        setState(() {
                          seconds = val ?? 0;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: IconButton(
              icon: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
              onPressed: () {
                int totalTimeInSeconds = (hours * 3600) + (minutes * 60) + seconds;
                if (totalTimeInSeconds > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountdownScreen(
                        totalTimeInSeconds: totalTimeInSeconds,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 30), // Padding at the bottom
        ],
      ),
    );
  }
}

class TimePickerUnit extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int?> onChanged;

  TimePickerUnit({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.black,
          child: DropdownButton<int>(
            dropdownColor: Colors.black,
            value: value,
            items: List.generate(60, (index) => index)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Center(
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 32, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}






