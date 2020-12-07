import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
//import 'pageteszt.dart';

class Page0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 0'),
      ),
      body: Row(
        children: [
          // Expanded(
          //   flex: 3,
          //   child: Column(
          //     children: [
          //       Expanded(
          //         child:
          //         Align(
          //           alignment: Alignment.topCenter,
          //           child: FloatingActionButton(
          //             // onPressed: _incrementCounter,
          //             backgroundColor: Colors.red,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    child: FlatButton(
                      color: Colors.red,
                      //backgroundColor: Colors.green,
                      child: Text('List 1'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Page1(prid: 'IND20', searchmode: 'P')),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: FlatButton(
                      color: Colors.blue,
                      //backgroundColor: Colors.red,
                      child: Text('List2 OK'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Page2(prid: 'CSA19', searchmode: 'P')),
                        );
                      },
                    ),
                  ),
                ),
                // Expanded(
                //   child: Align(
                //     child: FlatButton(
                //       color: Colors.blue,
                //       //backgroundColor: Colors.red,
                //       child: Text('Teszt'),
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => PageTeszt()),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
