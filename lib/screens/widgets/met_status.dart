import 'package:flutter/material.dart';

class METStatusBox extends StatelessWidget {
  const METStatusBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.red,
                size: 60,
              ),
              Text('< 15%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ))
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.sentiment_satisfied,
                color: Colors.orange,
                size: 60,
              ),
              Text('15-75%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange,
                  ))
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
                size: 60,
              ),
              Text('> 75%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
