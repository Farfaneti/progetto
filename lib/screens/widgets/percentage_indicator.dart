import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progetto/methods/theme.dart';
import 'package:provider/provider.dart';

import '../../provider/homeprovider.dart';
import '../../utils/shared_preferences.dart';

class PercentageIndicator extends StatefulWidget {
  final DateTime selectedDate; // Add the selectedDate parameter

   const PercentageIndicator({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  DateTime selectedDate = DateTime.now(); // Track the selected day

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferences>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<double>(
          future: homeProvider.calculateMETforWeek(
              widget.selectedDate, pref.weight ?? 0),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var percent = snapshot.data!;
              return CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                radius: 200,
                lineWidth: 35,
                percent: percent,
                progressColor: _getProgressColor(percent),
                backgroundColor: Colors.black12,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${percent * 100}%',
                  style: TextStyle(
                      color: Colors.black45,
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Color _getProgressColor(double percent) {
    if (percent >= 0.75) {
      return Colors.green; // Colore verde se percent >= 0.75
    } else if (percent >= 0.15) {
      return Colors.orange; // Colore arancione se 0.15 <= percent < 0.75
    } else {
      return Colors.red; // Altrimenti, colore rosso
    }
  }
}
