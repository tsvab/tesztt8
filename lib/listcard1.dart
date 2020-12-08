import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'pagecardppid.dart';

class ListCard1 extends StatefulWidget {
  final String ppid;
  final String cegnev;
  final String urllogo;

  ListCard1({Key key, this.ppid = '', this.cegnev = '', this.urllogo = ''})
      : super(key: key);

  @override
  _ListCard1State createState() => _ListCard1State();
}

class _ListCard1State extends State<ListCard1> {
  bool isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(1.0),
        ),
      ),
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageCardPpid(widget.ppid)),
            ).then((value) {
              if (value != null) {
                print("ListCard1 then: $value");
                setState(() {
                  isfavorite = value;
                });
              }
            });
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
// leading: Icon(Icons.account_circle),
          trailing: isfavorite ? Icon(Icons.favorite) : null,
          leading: SizedBox(
            child: widget.urllogo == ''
                ? Container()
// : Image.network(element['urllogo']),
                : CachedNetworkImage(
                    imageUrl: widget.urllogo,
                    placeholder: (context, url) => Container(),
                    //errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
            width: 100,
          ),
          title: Text(widget.cegnev),
          //trailing: Icon(Icons.arrow_forward),
          //subtitle: Text(ppid),
        ),
      ),
    );
  }
}
