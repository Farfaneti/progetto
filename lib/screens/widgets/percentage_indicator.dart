import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progetto/methods/theme.dart';

class Percentage_Indicator extends StatelessWidget {
  const Percentage_Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    var percent = 0.4;
    var percentage = percent * 100;
    return Container(
        child: CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      radius: 200,
      lineWidth: 35,
      percent: percent, // da inserire la percentuale giornaliera
      progressColor: FitnessAppTheme.nearlyDarkBlue,
      backgroundColor: FitnessAppTheme.cream,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '$percentage%',
        style: FitnessAppTheme.title,
      ),
    ));
  }
}
