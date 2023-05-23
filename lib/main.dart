import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:progetto/services/impact.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Preferences()..init(),
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  // We pass the newly created preferences to the service
                  Provider.of<Preferences>(context, listen: false),
                )),
        // Provider(
        //     create: (context) => PurpleAirService(
        //         Provider.of<Preferences>(context, listen: false)))
      ],
      child: MaterialApp(
        home: const HomePage(
          title: 'HomePage',
          nickname: '',
        ),
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: FitnessAppTheme.lightPurple)),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: FitnessAppTheme.lightPurple,
          ),
          scaffoldBackgroundColor: FitnessAppTheme.background,
        ),
      ),
    );
  }
}
