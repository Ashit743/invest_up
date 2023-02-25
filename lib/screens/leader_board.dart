import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Color list_item = Colors.grey[200];

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

const Color avtar_backGround = Color(0xFF2FCB72);
const Color avtar_backGround1 = Color(0xFF0C3329);
const Color prof_Card = Color(0xFF196F3D);
const Color grade1 = Color(0xFF00b09b);
const Color grade2 = Color(0xFF96c93d);
const Color cool = Color(0xFF181A2F);
const clickedColor = Color(0xFF0C3329);
const unclickedColor = Color(0xFF196F3D);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFFE7E7E7);
Color bronze = Color(0xFFA45735);

class _MyAppState extends State<LeaderBoard> {
  List<String> names = [
    "Ashit",
    "Faizan",
    "Lahari",
    "Varun",
    "Suhas",
    "Saurav",
    "Karthik",
    "Somit"
  ];
  List<String> litems = ["1", "2", "3", "4", "5", "6", "7", "8"];
  static const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
  IconData get arrow_back => Icons.arrow_back;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: cool,
            child: Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              elevation: 0,
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("2",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/emoticon_winner.png"),
                      foregroundColor: Colors.green,
                    ),
                    Text(
                      "Faizan",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "800",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: probtn,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: Container(
                  color: avtar_backGround1,
                  height: 50,
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(width: 92),
                        Text("Postion",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 160),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 170),
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 190),
                        Text(
                          "Score",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Text(
                          "LEADERBOARD",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: gold,
                        size: 70,
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 9.0,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => buildList(context, index),
              childCount: litems.length,
            ))
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];

    Widget listItem;

    if (ind == 1) {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: gold,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/emoticon_winner.png"),
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Score",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else if (ind == 2) {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: silver,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/emoticon_winner.png"),
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Score",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else if (ind == 3) {
      listItem = Card(
        shadowColor: Colors.grey[200],
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        color: bronze,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/emoticon_winner.png"),
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Score",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/emoji-other.png"),
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Score",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: listItem,
        ),
      ],
    );
  }
}
