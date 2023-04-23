import 'package:flutter/material.dart';

import '../methods/theme.dart';

class Contents extends StatelessWidget {
  Contents({Key? key}) : super(key: key);

  static const routename = 'Content';

  @override
  Widget build(BuildContext context) {
    print('${Contents.routename} built');
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      body: Column(children: <Widget>[
        Spacer(),
        Hypertension(),
        METindex(),
        Spacer(),
      ]),
    );
  } //build
}

class Hypertension extends StatelessWidget {
  const Hypertension({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: const AssetImage('assets/hypertension.jpg'),
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Text(
                      'Hypertension',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'Hypertension is..........................................',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: () {}, child: const Text('Learn more'))
              ],
            )
          ],
        ));
  }
}

class METindex extends StatelessWidget {
  const METindex({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: const AssetImage('assets/Met.png'),
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Text(
                      'MET INDEX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'MET index is..........................................',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: () {}, child: const Text('Learn more'))
              ],
            )
          ],
        ));
  }
}
