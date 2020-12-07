import 'package:flutter/material.dart';
import 'list2.dart';

class Page2 extends StatelessWidget {
  final String prid;
  final String searchmode;

  Page2({this.prid, this.searchmode});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Construma'),
        ),
        body: Row(
          children: [
            //List1(),
            List2(prid: prid, searchmode: searchmode),
            // Expanded(
            //   // flex: 3,
            //   child: Column(
            //     children: [
            //       Expanded(
            //         child: Align(
            //           child:
            //           FloatingActionButton(
            //             backgroundColor: Colors.yellow,
            //             onPressed: (){
            //               Navigator.pop(context) ;
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
