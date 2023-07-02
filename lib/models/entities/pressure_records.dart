import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:progetto/models/entities/pressure.dart';

import 'package:provider/provider.dart';
import '../../methods/theme.dart';

import '../../provider/homeprovider.dart';
import '../../screens/homepage.dart';

class PressureRecordPage extends StatefulWidget {
  const PressureRecordPage({Key? key}) : super(key: key);

  @override
  PressureRecordState createState() => PressureRecordState();
}

class PressureRecordState extends State<PressureRecordPage> {
  final _formKey = GlobalKey<FormState>();
  Completer<void> primaryCompleter = Completer<void>();

  int? systolic;
  int? diastolic;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            selected.year,
            selected.month,
            selected.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Pressure Record'),
          backgroundColor: FitnessAppTheme.purple,
        ),
        backgroundColor: FitnessAppTheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add your systolic pressure, diastolic pressure and date of registration:',
                      style: FitnessAppTheme.body1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Systolic pressure in mmHg',
                      labelStyle: FitnessAppTheme.subtitle,
                      prefixIcon: const Icon(
                        Icons.medical_services_rounded,
                        color: FitnessAppTheme.lightPurple,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: FitnessAppTheme.lightPurple),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter systolic pressure';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid pressure';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        systolic = int.tryParse(value);
                      });
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Diastolic pressure in mmHg',
                      labelStyle: FitnessAppTheme.subtitle,
                      prefixIcon: const Icon(
                        Icons.medical_services_rounded,
                        color: FitnessAppTheme.lightPurple,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: FitnessAppTheme.lightPurple),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter diastolic pressure';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid pressure';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        diastolic = int.tryParse(value);
                      });
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    onTap: () {
                      _selectDateTime(context);
                    },
                    controller: TextEditingController(
                      text: _selectedDateTime != null
                          ? intl.DateFormat('yyyy-MM-dd HH:mm')
                              .format(_selectedDateTime)
                          : '',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Date and Time',
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (_selectedDateTime == null) {
                        return 'Please select a date and time';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _savePressureRecord();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill in all the fields'),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              FitnessAppTheme.nearlyDarkBlue),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _savePressureRecord() async {
    final currentContext =
        context; 

    final pressureRecord =
        Pressure(null, systolic!, diastolic!, _selectedDateTime);
    await Provider.of<HomeProvider>(context, listen: false)
        .insertPressure(pressureRecord);

    ScaffoldMessenger.of(currentContext).showSnackBar(
      const SnackBar(
        content: Text('Pressure record saved'),
      ),
    );

  
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          title: 'Home',
          initialIndex: 1, 
        ),
      ),
    );
  }
}
