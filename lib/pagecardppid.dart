import 'package:flutter/material.dart';
import 'cardppid6.dart';

class PageCardPpid extends StatelessWidget {
  final ppid;

  PageCardPpid(this.ppid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PagePpid'),
      // ),
      body: CardPpid6(ppid: ppid),
    );
  }
}
