import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarModal1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CloseButton(),
            RaisedButton(
              child: Text('foglalás indítása'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
