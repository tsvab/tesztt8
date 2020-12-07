import 'package:flutter/material.dart';
import 'list1.dart';

class Page1 extends StatelessWidget {
  final String prid;
  final String searchmode;

  Page1({this.prid, this.searchmode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiállítói lista $prid $searchmode'),
      ),
      body: Column(
        children: [
          //List1(),
          //Text('Kiállítói lista $prid $searchmode'),
          List1(prid: prid, searchmode: searchmode),
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
    );
  }
}
