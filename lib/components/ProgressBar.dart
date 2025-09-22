import 'package:flutter/material.dart';

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({super.key});

  @override
  _ProgressBarExampleState createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  double _progress = 0.0;


  void IncreaseBar() {
    setState(() {
      if (_progress < 0.9) _progress += 0.1;
    });
  }

  void DecreaseBar() {
    setState(() {
      if (_progress > 0.1) _progress -= 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(value: _progress),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Progress: ${(_progress * 100).toStringAsFixed(0)}%'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: IncreaseBar,
                child: Text("Increase by 10"),
              ),
              ElevatedButton(
                onPressed: DecreaseBar,
                child: Text("Decrease by 10"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
