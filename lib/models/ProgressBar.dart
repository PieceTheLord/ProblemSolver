import 'package:flutter/material.dart';

class TaskProgressBar extends StatefulWidget {
  const TaskProgressBar({super.key});

  @override
  _TaskProgressBarState createState() => _TaskProgressBarState();
}

class _TaskProgressBarState extends State<TaskProgressBar> {
  double _progress = 0.0;
  TextEditingController progressBarIcreaseController = TextEditingController();

  @override
  void dispose() {
    progressBarIcreaseController.dispose();
    super.dispose();
  }

  void IncreaseBar(int percents) {
    double res = percents / 100;
    setState(() {
      if (_progress < 1) _progress += res;
      if (_progress > 1) _progress = 1;
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
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            IncreaseBar(10);
                          },
                          child: Text("10%"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            IncreaseBar(25);
                          },
                          child: Text("25%"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            IncreaseBar(25);
                          },
                          child: Text("50%"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            IncreaseBar(50);
                          },
                          child: Text("50%"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            IncreaseBar(100);
                          },
                          child: Text("100%"),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Increase'),
          ),
        ],
      ),
    );
  }
}
