import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class METStatusBox extends StatelessWidget {
  const METStatusBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMETStatus('😔', 'MET-min < 600', Colors.red),
          _buildMETStatus('🙂', 'MET-min [600-3000]', Colors.orange),
          _buildMETStatus('😃', 'MET-min > 3000', Colors.green),
        ],
      ),
    );
  }

  Widget _buildMETStatus(String emoji, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Text(
            emoji,
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}