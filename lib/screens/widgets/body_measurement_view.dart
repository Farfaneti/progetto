import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/provider/homeprovider.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class BodyMeasurementView extends StatefulWidget {
  // final AnimationController? animationController;
  // final Animation<double>? animation;

  const BodyMeasurementView({Key? key}) : super(key: key);

  @override
  State<BodyMeasurementView> createState() => _BodyMeasurementViewState();
}

class _BodyMeasurementViewState extends State<BodyMeasurementView> {
  double systolicMax = 0;
  double diastolicMax = 0;
  bool isMaxSysBpNormal = true;
  bool isMaxDiasBpNormal = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final pref = Provider.of<Preferences>(context);
    var weight = pref.weight;
    var height = pref.height;
    var heightInMeters = height! / 100;
    var bmi = weight! / pow(heightInMeters, 2);
    bmi = double.parse(bmi.toStringAsFixed(2));

    // Calculate the maximum systolic pressure for the specific day
    DateTime specificDay =
        DateTime.now(); // Replace with your desired specific day
    // Calculate the maximum systolic pressure for the specific day
    Future<int> maxSysPressureFuture =
        homeProvider.calculateDailyMaxSystolicPressure(specificDay);

// Calculate the maximum diastolic pressure for the specific day
    Future<int> maxDiasPressureFuture =
        homeProvider.calculateDailyMaxDiastolicPressure(specificDay);

    return Container(
      //animation: animationController!,

      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 18),
        child: Container(
          height: 260,
          width: 380,
          decoration: BoxDecoration(
            color: FitnessAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8, top: 16),
                      child: Text(
                        "Today's Max Systolic BP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ),
                    FutureBuilder<int>(
                        future: maxSysPressureFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int maxSysPressure = snapshot.data ?? 0;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 3),
                                      child: Text(
                                        maxSysPressure == 0
                                            ? 'No data'
                                            : '${maxSysPressure.toStringAsFixed(0)}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 26,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 4),
                                      child: Text(
                                        maxSysPressure == 0 ? '' : 'mmHg',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 90,
                                  height: 20,
                                  child: Text(
                                    maxSysPressure == 0
                                        ? ''
                                        : maxSysPressure < 140
                                            ? 'Normal value'
                                            : 'High value',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: maxSysPressure < 140
                                          ? FitnessAppTheme.nearlyDarkBlue
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8, top: 16),
                      child: Text(
                        "Today's Max Diastolic BP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ),
                    FutureBuilder<int>(
                        future: maxDiasPressureFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int maxDiasPressure = snapshot.data ?? 0;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 3),
                                      child: Text(
                                        maxDiasPressure == 0
                                            ? 'No data'
                                            : '${maxDiasPressure.toStringAsFixed(0)}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 26,
                                          color: FitnessAppTheme.lightPurple,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 4),
                                      child: Text(
                                        maxDiasPressure == 0 ? '' : 'mmHg',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.lightPurple,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 90,
                                  height: 20,
                                  child: Text(
                                    maxDiasPressure == 0
                                        ? ''
                                        : maxDiasPressure < 90
                                            ? 'Normal value'
                                            : 'High value',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: maxDiasPressure < 90
                                          ? FitnessAppTheme.lightPurple
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    color: FitnessAppTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${pref.height} cm',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: FitnessAppTheme.darkText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Height',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${pref.weight} kg',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: FitnessAppTheme.darkText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Weight',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$bmi BMI',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.2,
                                  color: FitnessAppTheme.darkText,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  bmi < 18.5
                                      ? 'Underweight'
                                      : bmi >= 18.5 && bmi <= 24.9
                                          ? 'Normal weight'
                                          : bmi >= 25.0 && bmi <= 29.9
                                              ? 'Overweight'
                                              : 'Obesity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color:
                                        FitnessAppTheme.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
