import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto/methods/theme.dart';

class METStatusBox extends StatelessWidget {
  const METStatusBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                //MdiIcons.emoticonAngry,
                color: Colors.red,
                size: 60,
              ),
              Text(
                '< 15%',
                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color:  Colors.red,
                )
                
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.sentiment_satisfied,
                //MdiIcons.emoticonNeutral,
                color: Colors.orange,
                size: 60,
              ),
              Text(
                '15-75%',
                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color:  Colors.orange,
                )
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.sentiment_very_satisfied,
                //MdiIcons.emoticonHappy,
                color: Colors.green,
                size: 60,
              ),
              Text(
                 '> 75%',
                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color:  Colors.green,
                )
              )
            ],
          )
          // _buildMETStatus(Icon(icon: Icon.smile, color: ), '<600', Colors.red),
          // _buildMETStatus('🙂', '[600-3000]', Colors.orange),
          // _buildMETStatus('😃', '>3000', Colors.green),
        ],
      ),
    );
  }

//   Widget _buildMETStatus(Icon icon, String label, Color color) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: color,
//           child: Text(
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }
}
