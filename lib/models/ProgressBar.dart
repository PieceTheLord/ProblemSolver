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
                  return Dialog(
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("I have done"),
                          SizedBox(width: 8), // Add some spacing
                          SizedBox(
                            height: 30,
                            width: 50, // Limit the width of the TextField
                            child: TextField(
                              controller: progressBarIcreaseController,
                              keyboardType:
                                  TextInputType.number, // Use a number keyboard
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                            ),
                          ),
                          Text("%"),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              IncreaseBar(
                                int.parse(progressBarIcreaseController.text),
                              );
                              progressBarIcreaseController.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.done),
                          ),
                          IconButton(
                            onPressed: () {
                              progressBarIcreaseController.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
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
