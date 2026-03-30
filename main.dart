import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 5000;
  double baseStake = 50;
  double stake = 50;
  int wins = 0;
  int losses = 0;
  int step = 0;

  double target = 5542436;
  int totalSteps = 30;
  double profitRate = 2.8;

  void win() {
    setState(() {
      wins++;
      balance += stake * profitRate;
      stake = baseStake;
      step++;

      if (balance >= target) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("🎉 Target Reached!"),
            content: Text("Congratulations!"),
          ),
        );
      }
    });
  }

  void loss() {
    setState(() {
      losses++;
      stake = stake * 1.6;
      step++;
    });
  }

  void reset() {
    setState(() {
      balance = 5000;
      stake = baseStake;
      wins = 0;
      losses = 0;
      step = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double expectedReturn = stake * profitRate;
    double progress = step / totalSteps;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Many Management"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            card("Balance", balance),
            card("Next Stake", stake),
            card("Expected Return", expectedReturn),
            SizedBox(height: 10),
            Text("Wins: $wins   Losses: $losses",
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: win,
                  child: Text("WIN"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: loss,
                  child: Text("LOSS"),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: reset,
              child: Text("RESET"),
            )
          ],
        ),
      ),
    );
  }

  Widget card(String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          Text("৳${value.toStringAsFixed(2)}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
