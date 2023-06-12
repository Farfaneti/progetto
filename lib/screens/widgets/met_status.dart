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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                MdiIcons.emoticonAngry,
                color: Colors.red,
                size: 60,
              ),
              Text(
                '<600',
                style: FitnessAppTheme.body2,
              )
            ],
          ),
          Column(
            children: [
              Icon(
                MdiIcons.emoticonNeutral,
                color: Colors.orange,
                size: 60,
              ),
              Text(
                '[600-3000]',
                style: FitnessAppTheme.body2,
              )
            ],
          ),
          Column(
            children: [
              Icon(
                MdiIcons.emoticonHappy,
                color: Colors.green,
                size: 60,
              ),
              Text(
                '>3000',
                style: FitnessAppTheme.body2,
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
