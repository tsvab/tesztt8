import 'package:flutter/material.dart';

import 'cardppid4.dart';

class PageCardPpid extends StatelessWidget {
  final ppid;

  PageCardPpid(this.ppid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PagePpid'),
      ),
      body: CardPpid4(ppid: ppid),
    );
  }
}
