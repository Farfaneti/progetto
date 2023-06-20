import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/provider/homeprovider.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class DailyMetView extends StatefulWidget {
  // final AnimationController? animationController;
  // final Animation<double>? animation;

  const DailyMetView({Key? key}) : super(key: key);

  @override
  State<DailyMetView> createState() => _DailyMetView();
}

class _DailyMetView extends State<DailyMetView> {
  double WeeklyMet = 0;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final pref = Provider.of<Preferences>(context);
    var weight = pref.weight;
    

    // Calculate the Met value
    DateTime specificDay =
        DateTime.now(); // Replace with your desired specific day
    // Calculate the maximum systolic pressure for the specific day
    Future<double> WeeklyMet =
        homeProvider.calculateMETforWeek(specificDay, weight!);

// Calculate the maximum diastolic pressure for the specific day
    

    return Container(
      //animation: animationController!,

      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          height: 260,
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
                        "Weekly Met/min value",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ),
                    FutureBuilder<double>(
                        future: WeeklyMet,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            double WeeklyMet = snapshot.data ?? 0;

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
                                         WeeklyMet == 0
                                       ? 'No data'
                                     : '${WeeklyMet.toStringAsFixed(0)}',
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
                                      padding:
                                          const EdgeInsets.only(left: 8, bottom: 4),
                                      child: Text(
                                          WeeklyMet == 0
                                       ? ''
                                     :'met/min',
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
                              ],
                            );
                          }
                        }),
                  ],
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
