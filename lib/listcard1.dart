import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'pagecardppid.dart';

class ListCard1 extends StatelessWidget {
  final String ppid;
  final String cegnev;
  final String urllogo;

  ListCard1({Key key, this.ppid = '', this.cegnev = '', this.urllogo = ''})
      : super(key: key);
  // Print () {
  //   print( 'cegnev: $this.urllogo, urllogo: $this.urllogo' );
  // } ;

  // @override
  // String toString() {
  //   return 'ListCard1: {cegnev: ${cegnev}, urllogo: ${urllogo}}';
  // }

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
              MaterialPageRoute(builder: (context) => PageCardPpid(ppid)),
            );
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
// leading: Icon(Icons.account_circle),
          leading: SizedBox(
            child: urllogo == ''
                ? Container()
// : Image.network(element['urllogo']),
                : CachedNetworkImage(
                    imageUrl: urllogo,
                    placeholder: (context, url) => Container(),
                    //errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
            width: 100,
          ),
          title: Text(cegnev),
          //trailing: Icon(Icons.arrow_forward),
          //subtitle: Text(ppid),
        ),
      ),
    );
  }
}
