import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//import 'package:http/http.dart' as http;
import 'calendarmodal1.dart';
import 'calendarmodalcupertino1.dart';
import 'constants2.dart' as Constant;
import 'kiallito1.dart';
import 'services2.dart';

//import 'dart:math';

class CardPpid4 extends StatefulWidget {
  final String ppid;
//  CardPpid4({Key key, @required this.recordObject}) : super(key: key);
  CardPpid4({Key key, this.ppid}) : super(key: key);

  @override
  _CardPpid4State createState() => _CardPpid4State();
}

class _CardPpid4State extends State<CardPpid4>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _tabIndex = 0;

  bool _isFavorite = false;
  Kiallito kiallito;

  bool _kiallitoInitDone = false;
  bool _favoriteInitDone = false;
  bool _noteInitDone = false;

  Future<bool> _getKiallito;

  TextStyle _textStylePlain;
  TextStyle _textStyleHeading;

  List<Tab> _tabbar = [];
  List<Widget> _tabbarview = [];

  TextEditingController _jegyzetController;
  String _jegyzetSaved;

  // var _blankFocusNode = FocusNode();
  // FocusNode _focusNode;

  Future<bool> getKiallito(ppid) async {
    // Future<void> getKiallito() async {
    if (!_kiallitoInitDone) {
      await fetchKiallito(ppid).then((value) async {
        kiallito = value;
        //print('getKiallito kiallito: $kiallito');
        _kiallitoInitDone = true;
        setTabs();
      });
    }
    return true;
  }

  @override
  void initState() {
    //print('init start');
    super.initState();

    // _focusNode = FocusNode();
    _jegyzetController = TextEditingController(text: '');

    //_controller = TabController(length: 5, vsync: this);
    _getKiallito = getKiallito(widget.ppid);

    // _controller = TabController(length: 5, vsync: this);
    // _controller.addListener(_handleTabSelection);
//    print("kiallito: ${kiallito}");
  }

  _handleTabSelection() {
    //print('_controller.index: ${_controller.index}');
    //if (_controller.indexIsChanging) {
//    _controller = TabController(length: _tabbar.length, vsync: this);
    _tabIndex = _controller.index;
    setState(() {
      //print("tab state");
    });
  }

  beforeDispose() async {
    //print("beforeDispose eleje");

    await setNote(_jegyzetController.text).then((value) {
      //print("setnote után ");
      // _controller.dispose();
      // _jegyzetController.dispose();
      //print("controllerek elbontva");
    });
    //print("beforeDispose vége");
  }

  @override
  void dispose() {
    //print('dispose-ban');
    // print("dispose jegyzet: ${_jegyzetController.text}");

    // _focusNode.dispose();
    // print("dispose setnote előtt");
    //setNote(_jegyzetController.text);
    beforeDispose();
    //print("dispose setnote után");

    // print("setnote előtt");
    // await setNote().then((value) async {
    //   print("dispose előtt");
    //   super.dispose();
    //   print("dispose után");
    // });
    // print("kkkkkkkkkkkkkkkk");
    _controller.dispose();
    _jegyzetController.dispose();
    // print("_jegyzetController.text ${_jegyzetController}");
    // print("super dispose előtt");

    super.dispose();
    //print("super dispose után");
  }

  @override
  Widget build(BuildContext context) {
    _textStyleHeading = DefaultTextStyle.of(context).style.apply(
          fontSizeFactor: 1.5,
          fontWeightDelta: 2,
          color: Colors.black,
        );

    _textStylePlain = DefaultTextStyle.of(context).style.apply(
          fontSizeFactor: 1,
          fontWeightDelta: 1,
          color: Colors.black,
        );
    return FutureBuilder(
        //future: getKiallito(widget.ppid),
        future: _getKiallito,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //print('kiallito: $kiallito');
          if (snapshot.hasData) {
            //print("FutureBuilder itt vagyok");
            getNote();
            getFavorite();

            //return Text(kiallito.cegnev);
            return cardppid4();
          } else {
            //return Container();
            return Container(
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

  //https://stackoverflow.com/questions/54642710/tabbarview-with-dynamic-container-height

  Widget cardppid4() {
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity < 0) {
          if (_controller.index < _controller.length - 1) {
            _controller.index += 1;
          }
        } else if (dragEndDetails.primaryVelocity > 0) {
          if (_controller.index > 0) {
            _controller.index -= 1;
          }
        }
      },
      // onTap: () {
      //   FocusScope.of(context).requestFocus(_blankFocusNode);
      //   _jegyzetController.text = _jegyzetSubmitted;
      // },
      child: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   height: 300,
            //   color: Colors.yellow,
            // ),
            // AppBar(
            //   title: Text('sss'),
            // ),
            logo(),
            cegnev(),
            helylist(),
            kedvencekhez(),
            // TabBar(
            //   controller: _controller,
            //   labelColor: Colors.redAccent,
            //   tabs: myTabs,
            // ),

            tab1(),
            // tabbar1(),
            // tabbarview2(),

            //tab2(),

            // Text(
            //     '.. és itt jön a folytatás, ami jól kapcsolódik, függ a felette lévők méretétől :-))))'),
            //cegnev(),
            //Container(child: Text('another component')),
          ],
        ),
      ]),
    );
  }

  Widget logo() {
    /// TODO Hero
    return Center(
      child: Container(
        child: SizedBox(
          child: kiallito.urllogo == ''
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: kiallito.urllogo,
                    placeholder: (context, url) => Container(),
                    //errorWidget: (context, url, error) => Icon(Icons.error),
                    //width: 300,
                  ),
                ),
        ),
        constraints: BoxConstraints(
            minHeight: 0,
            // minWidth: double.infinity,
            // maxWidth: 300,
            maxHeight: 150),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }

  Widget cegnev() {
    return Container(
      // width: 100,
      // height: 50,
      //color: Colors.amber[600],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            /// DONE hosszú cégnév több sorba törik
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kiallito.cegnev,
                  maxLines: 2,
                  softWrap: true,
                  //overflow: TextOverflow.fade,
                  style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor: 1.5,
                      fontWeightDelta: 2,
                      color: Colors.black),
                  // style: TextStyle(
                  //     fontWeight: FontWeight.bold, fontSize: Font),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget helylist() {
    return Container(
      // width: 100,
      // height: 50,
      //color: Colors.amber[600],
      child: Center(
        child: Text(
          kiallito.helylist,
          style: _textStylePlain,
          // style: DefaultTextStyle.of(context).style.apply(
          //     fontSizeFactor: 1, fontWeightDelta: 2, color: Colors.black),
          // style: TextStyle(
          //     fontWeight: FontWeight.bold, fontSize: Font),
        ),
      ),
    );
  }

  getFavorite() async {
    const reltid = Constant.RELTID_PPID_USER;
    const idv1 = 'AU0000025';
    final idv2 = kiallito.ppid;

    if (!_favoriteInitDone) {
      //print("getFavorite: $reltid, $idv1, $idv2");
      await FavoriteService.get(reltid, idv1, idv2).then((value) {
        //print("getFavorite FavoriteService.get: $value");
        setState(() {
          //print("favorite stestate");
          _isFavorite = value == 0 ? false : true;
        });
        _favoriteInitDone = true;
      });
    }
  }

  Future<void> getNote() async {
    const reltid = Constant.RELTID_PPID_USER_TEXT;
    const idv1 = 'AU0000025';
    final idv2 = kiallito.ppid;

    if (!_noteInitDone) {
      //print("getNote: $reltid, $idv1, $idv2");
      await NoteService.get(reltid, idv1, idv2).then((value) {
        //print("getNote NoteService.get: $value");
        setState(() {
          _jegyzetSaved = value;
          _jegyzetController.text = value;
        });
      });
      _noteInitDone = true;
    }
  }

  setFavorite() async {
    const reltid = Constant.RELTID_PPID_USER;
    const idv1 = 'AU0000025';
    final idv2 = kiallito.ppid;
    final aktiv = _isFavorite ? '0' : '1';
    //print('setFavorite előtt');
    int result = await FavoriteService.set(reltid, idv1, idv2, aktiv);

    String textsnack;

    if (result == 1) {
      setState(() {
        _isFavorite = !_isFavorite;
      });
      if (_isFavorite) {
        textsnack = 'Hozzáadva a kedvencekhez!';
      } else {
        textsnack = 'Eltávoltítva a kedvencekből!';
      }
    } else {
      textsnack = 'A kedvencekhez hozzáadás nem sikerült!';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(textsnack),
      duration: Duration(milliseconds: 1500),
      // action: SnackBarAction(
      //   label: 'ACTION',
      //   onPressed: () {},
      // ),
    ));
  }

  Widget kedvencekhez() {
    String _textbutton = _isFavorite ? 'Törlés a kedvencekből' : 'Kedvencekhez';

    return !_favoriteInitDone
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text(_textbutton),
                //padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  //result = await FavoriteService.set(reltid, idv1, idv2);
                  setFavorite();
                },
              ),
            ],
          );
  }

  Widget magunkrol() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: kiallito.magunkrol == ''
          ? Container()
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  "Rólunk",
                  style: _textStyleHeading,
                ),
              ),
              // Text(
              //   kiallito.magunkrol,
              //   style: _textStylePlain,
              //
              //   /// DONE text justify
              //   textAlign: TextAlign.justify,
              // ),
              ExpandText(
                kiallito.magunkrol,
                textAlign: TextAlign.justify,
                maxLines: 10,
                expandOnGesture: false,
              ),
            ]),
    );
  }

  Widget terkep() {
    /// TODO itt áll ön külön layer-en
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              'Hol talál meg minket?',
              style: _textStyleHeading,
            ),
          ),
          Image.network(
              'https://eregistrator.hu/upload/profil1/0015837634573.jpg'),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              "További információk",
              style: _textStyleHeading,
            ),
          ),
          kiallito.katagorialist == ''
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.widgets_outlined),
                      title: Text(
                        kiallito.katagorialist,
                        style: _textStylePlain,
                      ),
                    ),
                  ],
                ),
          kiallito.email == ''
              ? Container()
              : ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(
                    kiallito.email,
                    style: _textStylePlain,
                  ),
                ),
          kiallito.web == ''
              ? Container()
              : ListTile(
                  leading: Icon(Icons.web_asset),
                  title: Text(
                    kiallito.web,
                    style: _textStylePlain,
                  ),
                ),
          kiallito.kapcsolat == ''
              ? Container()
              : ListTile(
                  leading: Icon(Icons.location_pin),
                  title: Text(
                    /// TODO: php telefon-t le kell választani, hogy külön mezőben legyen
                    /// TODO: telefonszámra kattintással tárcsázza a számot
                    kiallito.kapcsolat,
                    style: _textStylePlain,
                  ),
                ),
        ],
      ),
    );
  }

  Widget markak1() {
    return Container(
      /// TODO: ide még kell javítás, vmi más technológia a direkt magasság kiküszöbölésére
      //color: Colors.yellow,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kiallito.markalista.length,
        //itemCount: 5,
        itemBuilder: (c, index) {
          //index = 0;
          //return Text('AAAAAB ');
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      //color: Colors.red,
                      )),
              child: Column(
                children: [
                  ListTile(
                    //horizontalTitleGap: 10,
                    // leading: CircleAvatar(
                    //   child: Text('CA'),
                    // ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Text(kiallito.markalista[index]['urllogomarka']),
                        Container(
                          height: 100,
                          child: kiallito.markalista[index]['urllogomarka'] ==
                                  ''
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: kiallito.markalista[index]
                                        ['urllogomarka'],
                                    placeholder: (context, url) => Container(),
                                    //errorWidget: (context, url, error) => Icon(Icons.error),
                                    //width: 300,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    subtitle: Center(
                      child: Text(
                        //'asdasd $i',
                        kiallito.markalista[index]['nev1'],
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    // return Container(
    //     height: 50,
    //     color: Colors.yellow,
    //     child: ListView.builder(
    //       //scrollDirection: Axis.horizontal,
    //       itemCount: 5,
    //       itemBuilder: (c, i) {
    //         return Column(
    //           // height: 30,
    //           // width: 30,
    //           // decoration: BoxDecoration(
    //           //     border: Border.all(
    //           //         //color: Colors.black,
    //           //         )),
    //           //color: Colors.blue,
    //           children: [
    //             ListTile(
    //               //horizontalTitleGap: 10,
    //               title: Text(
    //                 'SSS',
    //                 style: TextStyle(color: Colors.green),
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     ));

    // return Container(
    //   //height: 100,
    //   child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    //     ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: 3,
    //       itemBuilder: (c, index) {
    //         return Container(
    //           height: 50,
    //           width: 50,
    //           color: Colors.yellow,
    //           // child: Text('wefwefqwf')
    //         );
    //       },
    //     )
    //   ]),
    // );

    //   return ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 3,
    //     itemBuilder: (BuildContext ctxt, int index) {
    //       return Container(
    //         width: 80,
    //         height: 80,
    //         child: ListTile(
    //           horizontalTitleGap: 5,
    //
    //           title: Text('asadsasd'),
    //         ),
    //       );
    //     },
    //   // );
  }

  Widget marka() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              "Forgalmazott márkák",
              style: _textStyleHeading,
            ),
          ),
          markak1(),
          //Text('Márka vége QQQQQQQQQQQQQQ'),
        ],
      ),
    );
  }

  Widget calendar1() {
    /// TODO x close button
    return Column(
      children: [
        RaisedButton(
          child: Text('Foglalás Cupertino'),
          onPressed: () {
            return showCupertinoModalBottomSheet(
              expand: false,
              enableDrag: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => CalendarModalCupertino1(),
            );
          },
        ),
        RaisedButton(
          child: Text('Foglalás'),
          onPressed: () {
            return showMaterialModalBottomSheet(
              expand: false,
              enableDrag: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => CalendarModal1(),
            );
          },
        ),
      ],
    );
  }

  Future<void> setNote(String note) async {
    // Timer(Duration(seconds: 2), () {
    //   print("setNote megtörtént a mentés...");
    // });
    //
    // return;
    //print("setNote eleje");
    const reltid = Constant.RELTID_PPID_USER_TEXT;
    const idv1 = 'AU0000025';
    final idv2 = kiallito.ppid;
    final text1 = note;
    final aktiv = '1';

    if (note != _jegyzetSaved) {
      //print("setNote mentés előtt");

      // print("setNote késleltetés előtt");
      // Timer(Duration(seconds: 10), () async {
      //   final int result =
      //       await NoteService.set(reltid, idv1, idv2, text1, aktiv);
      //   print("setNote megtörtént a mentés...");
      //   print("setNote megtörtént a késleltetés");
      // });

      final int result =
          await NoteService.set(reltid, idv1, idv2, text1, aktiv);

      if (result == 1) {
        _jegyzetSaved = note;
        // Timer(Duration(seconds: 5), () async {
        //   print(_jegyzetSaved);
        //   print(_jegyzetController.text);
        //   _jegyzetSaved = note;
        // });
      }
      print("setNote megtörtént a mentés...$note");
      //
      // String textsnack;
      //
      // if (result == 1) {
      //   textsnack = 'A mentés sikerült!';
      // } else {
      //   textsnack = 'A mentés nem sikerült!';
      // }

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(textsnack),
      //   duration: Duration(milliseconds: 1500),
      // ));
    }
    //print("setNote végén");
  }

  Widget jegyzet1(String reltid) {
    //return Text('jegyzet ' + idt);
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            // focusNode: _focusNode,
            controller: _jegyzetController,
            onEditingComplete: () {
              //print("onEditingComplete: ${_jegyzetController.text}");
              // _focusNode.unfocus();
              setNote(_jegyzetController.text);
            },
            // onSubmitted: (text) {
            //   print("onSubmitted: $text");
            //   //_jegyzetSubmitted = text;
            //   //setState(() {});
            // },

            // onChanged: (text) {
            //   print("onChanged: $text");
            // },
            // // onChanged: () {
            // //   print('befejezte');
            // // },
            // onChanged: (text) {},
            // // onFieldSubmitted: (text) {
            // //   print('befejezte $text');
            // // },
            decoration: InputDecoration(
              hintText: 'Írjon feljegyzést a kiállítóról',
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                //  when the TextFormField in focused
              ),
            ),
            //textInputAction: TextInputAction.done,
            //keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         //setNote();
        //       },
        //       tooltip: 'save',
        //       child: Icon(Icons.save),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget tab1() {
    return Column(children: [
      tabbar1(),
      tabbarview2(),
    ]);
  }

  setTabs() {
    var _textstyle = TextStyle(color: Colors.black, fontSize: 20);
    _tabbar = [];
    _tabbarview = [];
    if (true) {
      _tabbar.add(Tab(
        child: Text(
          'Leírás',
          style: _textstyle,
        ),
      ));
      _tabbarview.add(Column(
        children: [
          magunkrol(),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          terkep(),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          info(),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          marka(),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
        ],
      ));
    }
    if (true) {
      _tabbar.add(Tab(
        child: Text(
          'Kuponok',
          style: _textstyle,
        ),
      ));
      _tabbarview.add(Text('kuponok'));
    }
    if (true) {
      _tabbar.add(Tab(
        child: Text(
          'Újdonságok',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabbarview.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(20, (index) => Text('blabla: $index')).toList(),
      ));
    }
    if (true) {
      _tabbar.add(Tab(
        child: Text(
          'Jegyzet',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabbarview.add(jegyzet1(Constant.RELTID_PPID_USER_TEXT));
    }
    if (true) {
      _tabbar.add(Tab(
        child: Text(
          'Időpont foglalás',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabbarview.add(calendar1());
    }

    _controller = TabController(length: _tabbar.length, vsync: this);
    _controller.addListener(_handleTabSelection);
  }

  Widget tabbar1() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      tabs: _tabbar,
    );
  }

  Widget tabbarview2() {
    return Container(
      child: _tabbarview[_tabIndex],
    );
  }

  // Widget tabbarview2() {
  //   return Container(
  //     child: [
  //       Column(
  //         children: [
  //           magunkrol(),
  //           Divider(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //           terkep(),
  //           Divider(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //           info(),
  //           Divider(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //           marka(),
  //           Divider(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         ],
  //       ),
  //       //      children:
  //       // ),
  //       Text('kuponok'),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children:
  //             List.generate(20, (index) => Text('blabla: $index')).toList(),
  //       ),
  //       Text('jegyzet'),
  //       calendar1(),
  //     ][_tabIndex],
  //   );
  // }

  // Widget tabbarview3() {
  //   return Container(
  //     controller: _controller,
  //     children: <Widget>[
  //       Text('1'),
  //       Text('2'),
  //     ],
  //   );
  // }

//   Widget tabbarview1() {
//     return SingleChildScrollView(
//       child: TabBarView(
//         controller: _controller,
//         children: <Widget>[
//           Container(
//             // width: 100,
//             // height: 50,
//             //color: Colors.amber[600],
//             child: Column(
//               children: [
//                 Text(
//                   'Rólunk',
//                   style: _textStyleHeading,
//                   textAlign: TextAlign.left,
//                   // style: TextStyle(
//                   //     fontWeight: FontWeight.bold, fontSize: Font),
//                 ),
//                 Container(
//                   // width: 100,
//                   // height: 50,
//                   //color: Colors.amber[600],
//                   padding: const EdgeInsets.all(10.0),
//                   child: Center(
//                     child: Text(
//                       kiallito.magunkrol,
//                       style: _textStylePlain,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//           ),
//           Container(
//             height: 70,
//             child: Card(
//               child: ListTile(
//                 leading: const Icon(Icons.location_on),
//                 title: Text('Latitude: 48.09342\nLongitude: 11.23403'),
//                 trailing: IconButton(
//                     icon: const Icon(Icons.my_location), onPressed: () {}),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
