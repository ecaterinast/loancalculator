import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:math';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => LoanCalculator(), 
    ),
  );
}

class LoanCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoanCalculatorHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoanCalculatorHome extends StatefulWidget {
  @override
  _LoanCalculatorHomeState createState() => _LoanCalculatorHomeState();
}

class _LoanCalculatorHomeState extends State<LoanCalculatorHome> {
  double _loanAmount = 0.0;
  double _interestRate = 0.0;
  int _months = 1;
  double _monthlyPayment = 0.0;

  final _amountController = TextEditingController();
  final _interestController = TextEditingController();

  void _calculateMonthlyPayment() {
    if (_loanAmount > 0 && _interestRate > 0 && _months > 0) {
      double monthlyRate = _interestRate / 100;
      double numerator = _loanAmount * monthlyRate;
      double denominator = 1 - (1 / pow(1 + monthlyRate, _months)); 
      setState(() {
        _monthlyPayment = numerator / denominator;
      });
    } else {
      setState(() {
        _monthlyPayment = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text(
              'Loan Calculator',
              
              style: TextStyle(
                fontSize: 40,           // Bigger font size for the title
                fontWeight: FontWeight.w900,
                fontFamily: 'Roboto',
                color: Colors.black,    // Black color for the title
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
             // Label for Amount Field
            Text(
              'Enter amount',  // Label for the amount field
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),  // Space between label and TextField
            // Enter Amount Field
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _loanAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),

            // Slider for Number of Months
           Text(
              'Enter number of months',  // Label for the amount field
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Slider(
              value: _months.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: '$_months months',
              thumbColor: Color.fromRGBO(20, 39, 197, 1),
              activeColor:Color.fromRGBO(20, 39, 197, 1),
              onChanged: (double newValue) {
                setState(() {
                  _months = newValue.toInt();
                });
              },
            ),
            SizedBox(height: 20),

            Text(
              'Enter % per month',  // Label for the amount field
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Enter Interest Rate
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Percent',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _interestRate = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 50),
             
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(241, 242, 246, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You will pay the approximate amount monthly:',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                '${_monthlyPayment.toStringAsFixed(2)}€',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(20, 39, 197, 1),
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              height: 50,
              
              child: ElevatedButton(
                onPressed: _calculateMonthlyPayment,
                child: Text(
                  'Calculate',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Roboto'
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Color.fromRGBO(20, 39, 197, 1), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Correct parameter for button color
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

