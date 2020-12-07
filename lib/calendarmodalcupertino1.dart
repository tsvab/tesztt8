import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class CalendarModalCupertino1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //CloseButton(),
          CupertinoButton(
            child: Text('foglalás indítása'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
