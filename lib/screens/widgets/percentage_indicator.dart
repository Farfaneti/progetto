import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progetto/methods/theme.dart';
import 'package:provider/provider.dart';

import '../../provider/homeprovider.dart';
import '../../utils/shared_preferences.dart';

class PercentageIndicator extends StatelessWidget {
  const PercentageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferences>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<double>(
          future: homeProvider.calculateMETforWeek(DateTime.now(), pref.weight ?? 0),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var percent = snapshot.data!;
              return CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                radius: 200,
                lineWidth: 35,
                percent: percent,
                progressColor:  _getProgressColor(percent),
                backgroundColor: FitnessAppTheme.cream,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${percent*100} %',
                  style: FitnessAppTheme.title,
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