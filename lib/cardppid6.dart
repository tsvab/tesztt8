import 'package:cached_network_image/cached_network_image.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'calendarmodal1.dart';
import 'calendarmodalcupertino1.dart';
import 'kiallito1.dart';
import 'package:badges/badges.dart';
import 'constants2.dart' as Constant;
import 'styles2.dart';
import 'services2.dart';

class CardPpid6 extends StatefulWidget {
  final String ppid;

  CardPpid6({Key key, this.ppid});

  @override
  _CardPpid6State createState() => _CardPpid6State();
}

class _CardPpid6State extends State<CardPpid6>
    with SingleTickerProviderStateMixin {
  Kiallito kiallito;
  Future<bool> _getKiallitoDone;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;
  int _tabIndex = 0;
  List<Tab> _tabBar = [];
  List<Widget> _tabBarView = [];

  _handleTabSelection() {
    _tabIndex = _tabController.index;
    setState(() {});
  }

  TextEditingController _noteController;
  String _noteSaved = '';

  Future<bool> kiallitoInit(String ppid) async {
    final user = 'AU0000025';
    kiallito = await fetchKiallito(ppid, user);
    _noteController = TextEditingController(text: kiallito.note);

    setTabs();
    return true;
  }

  Future<void> setFavorite() async {
    const reltid = Constant.RELTID_PPID_USER;
    final idv1 = kiallito.ppid;
    const idv2 = 'AU0000025';
    final aktiv = kiallito.favorite ? '0' : '1';
    int result = await FavoriteService.set(reltid, idv1, idv2, aktiv);

    String textsnack;

    if (result == 1) {
      setState(() {
        kiallito.favorite = !kiallito.favorite;
      });
      if (kiallito.favorite) {
        textsnack = 'Hozzáadvabbbbbbb a kedvencekhez!!!!!!!!!!!';
      } else {
        textsnack = 'Eltávoltítvaaaaaaaaaaaaaaaaaaaaaaa a kedvencekből!';
      }
    } else {
      textsnack =
          'A kedvencekhez hozzáadás nem sikerült hibaüzenettttttttttttttttttttttttt!';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      //_scaffoldKey.currentState.showSnackBar(
      SnackBar(
        key: _scaffoldKey,
        behavior: SnackBarBehavior.fixed,
        content: Text(textsnack),
        duration: Duration(milliseconds: 1500),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () {},
        // ),
      ),
    );
  }

  // Future<void> getNote(String ppid) async {
  //   if (!_noteInitDone && !_noteInitializing) {
  //     _noteInitializing = true;
  //     const reltid = Constant.RELTID_PPID_USER_TEXT;
  //     const idv1 = 'AU0000025';
  //     final idv2 = ppid;
  //
  //     await NoteService.get(reltid, idv1, idv2).then((value) {
  //       setState(() {
  //         _noteSaved = value;
  //         _noteController.text = value;
  //       });
  //       _noteInitDone = true;
  //     });
  //     _noteInitializing = true;
  //   }
  // }

  Future<void> setNote(String note) async {
    const reltid = Constant.RELTID_PPID_USER_TEXT;
    final idv1 = kiallito.ppid;

    /// TODO a user-t ki kell oldani
    const idv2 = 'AU0000025';
    final text1 = note;
    final aktiv = '1';

    if (note != _noteSaved) {
      final int result =
          await NoteService.set(reltid, idv1, idv2, text1, aktiv);
      if (result == 1) {
        _noteSaved = note;
      }
    }
  }

  @override
  void initState() {
    _getKiallitoDone = kiallitoInit(widget.ppid);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    setNote(_noteController.text);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: FutureBuilder(
        future: _getKiallitoDone,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return cardppid();
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget cardppid() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ez egy fejléc'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity < 0) {
            if (_tabController.index < _tabController.length - 1) {
              _tabController.index += 1;
            }
          } else if (dragEndDetails.primaryVelocity > 0) {
            if (_tabController.index > 0) {
              _tabController.index -= 1;
            }
          }
        },
        child: ListView(
          children: [
            logo(),
            cegnev(),
            helylist(),
            kedvencekhez(),
            tab1(),
          ],
        ),
      ),
    );
  }

  void setTabs() {
    var _textstyle = TextStyle(color: Colors.black, fontSize: 20);
    _tabBar = [];
    _tabBarView = [];
    if (true) {
      _tabBar.add(
        Tab(
          child: Badge(
            child: Text(
              'Leírás',
              style: _textstyle,
            ),
            badgeContent: Text('12'),
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(0),
            position: BadgePosition.topEnd(top: -12, end: -20),
            padding: EdgeInsets.all(1),
            showBadge: true,
            // position: BadgePosition.topEnd(top: 10, end: 10),
            //position: BadgePosition.topEnd(top: -10, end: -5),
          ),
        ),
      );
      _tabBarView.add(
        Column(
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
        ),
      );
    }
    if (true) {
      _tabBar.add(Tab(
        child: Text(
          'Kuponok',
          style: _textstyle,
        ),
      ));
      _tabBarView.add(Text('kuponok'));
    }
    if (true) {
      _tabBar.add(Tab(
        child: Text(
          'Újdonságok',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabBarView.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(20, (index) => Text('blabla: $index')).toList(),
      ));
    }
    if (true) {
      _tabBar.add(Tab(
        child: Text(
          'Jegyzet',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabBarView.add(jegyzet1(Constant.RELTID_PPID_USER_TEXT));
    }
    if (true) {
      _tabBar.add(Tab(
        child: Text(
          'Időpont foglalás',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
      _tabBarView.add(calendar1());
    }

    _tabController = TabController(
      length: _tabBar.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  Widget tab1() {
    return Column(children: [
      tabbar1(),
      tabbarview2(),
    ]);
  }

  Widget tabbar1() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: _tabBar,
    );
  }

  Widget tabbarview2() {
    return Container(
      child: _tabBarView[_tabIndex],
    );
  }

  Widget logo() {
    /// TODO Hero
    final visibile = (kiallito.urllogo != '');

    return Visibility(
      visible: visibile,
      child: Center(
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
      ),
    );
  }

  Widget kedvencekhez() {
    print(kiallito);
    String _textbutton =
        kiallito.favorite ? 'Törlés a kedvencekből' : 'Kedvencekhez';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text(_textbutton),
          //padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            setFavorite();
          },
        ),
      ],
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
          Text(kiallito.ppid),
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
          style: ktextStylePlain,
          // style: DefaultTextStyle.of(context).style.apply(
          //     fontSizeFactor: 1, fontWeightDelta: 2, color: Colors.black),
          // style: TextStyle(
          //     fontWeight: FontWeight.bold, fontSize: Font),
        ),
      ),
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
                  style: ktextStyleHeading,
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
              style: ktextStyleHeading,
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
              style: ktextStyleHeading,
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
                        style: ktextStylePlain,
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
                    style: ktextStylePlain,
                  ),
                ),
          kiallito.web == ''
              ? Container()
              : ListTile(
                  leading: Icon(Icons.web_asset),
                  title: Text(
                    kiallito.web,
                    style: ktextStylePlain,
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
                    style: ktextStylePlain,
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
              style: ktextStyleHeading,
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

  Widget jegyzet1(String reltid) {
    //return Text('jegyzet ' + idt);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            //focusNode: _nodeNote,
            controller: _noteController,
            onEditingComplete: () {
              setNote(_noteController.text);
            },
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
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            // focusNode: _nodeNote,
            minLines: 1,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}
