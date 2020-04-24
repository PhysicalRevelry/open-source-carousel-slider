import 'package:flutter/material.dart';
import 'dart:io';

class FinalScreenBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => print('Get Started Now'),
        child: Container(
          height: Platform.isIOS ? 100 : 90,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            'GET STARTED NOW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
