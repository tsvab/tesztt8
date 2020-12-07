import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
//import 'api1.dart' ;
import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';
import 'kiallito1.dart';
import 'listcard1.dart';

class List2 extends StatefulWidget {
  final String prid;
  final String searchmode;
  List2({this.prid, this.searchmode});

  @override
  _List2State createState() => _List2State();
}

class _List2State extends State<List2> {
  var _elements = List<dynamic>();

  Future<bool> getKiallitok() async {
    // Future<void> getKiallito() async {
    await fetchKiallitok(widget.prid, widget.searchmode).then((value) {
      _elements = value;
      //(_elements);
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    // getKiallito();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getKiallitok(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: GroupedListView<dynamic, String>(
                elements: _elements,
                groupBy: (element) => element['group'],
                itemComparator: (item1, item2) =>
                    //item1['name'].compareTo(item2['name']),
                    item1['cegnev']
                        .toLowerCase()
                        .compareTo(item2['cegnev'].toLowerCase()),
                itemBuilder: (c, element) {
                  return ListCard1(
                    ppid: element['ppid'],
                    cegnev: element['cegnev'],
                    urllogo: element['urllogo'],
                  );
                  // return Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(1.0),
                  //     ),
                  //   ),
                  //   elevation: 2.0,
                  //   margin: new EdgeInsets.symmetric(
                  //       horizontal: 10.0, vertical: 6.0),
                  //   child: Container(
                  //     child: ListTile(
                  //       onTap: () {},
                  //       contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 20.0, vertical: 10.0),
                  //       // leading: Icon(Icons.account_circle),
                  //       leading: SizedBox(
                  //         child: element['urllogo'] == ''
                  //             ? Container()
                  //             // : Image.network(element['urllogo']),
                  //             : CachedNetworkImage(
                  //                 imageUrl: element['urllogo'],
                  //                 placeholder: (context, url) => Container(),
                  //                 errorWidget: (context, url, error) =>
                  //                     Icon(Icons.error),
                  //               ),
                  //         width: 100,
                  //       ),
                  //
                  //       title: Text(element['name']),
                  //       //trailing: Icon(Icons.arrow_forward),
                  //     ),
                  //   ),
                  // );
                },
                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Text(
                      '    ' + value,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                order: GroupedListOrder.ASC,
              ),
            );
          } else {
            return Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
