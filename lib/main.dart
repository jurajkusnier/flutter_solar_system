import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:infinite_listview/infinite_listview.dart';

const ss = "Solar System";
const idl = "idle";
const red = Color(0xffD55F5F);

decodePlanets(List<dynamic> json) =>
    json.map((i) => Planet.fromJson(i)).toList();

planetFlr(double size, String source, double margin) => Container(
    margin: EdgeInsets.only(top: margin),
    width: size,
    height: size,
    child: FlareActor(source, animation: idl));

imgButton(photo) => Padding(
    padding: EdgeInsets.all(15),
    child: RaisedButton(
        padding: EdgeInsets.all(0),
        onPressed: () {},
        child: Image.asset(photo, fit: BoxFit.cover)));

text(txt) => Padding(
    padding: EdgeInsets.all(20),
    child: Text(txt,
        textAlign: TextAlign.justify,
        style: TextStyle(fontFamily: "R", fontSize: 16, color: Colors.white)));

class Planet {
  final String flr;
  final String name;
  final String description;
  final String intro;
  final String text;
  final List<String> photos;

  Planet(this.flr, this.name, this.description, this.intro, this.text,
      this.photos);

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
      json["flr"],
      json["name"],
      json["description"],
      json["intro"],
      json["text"],
      List<String>.from(json["photos"]));
}

void main() async {
  final data = await rootBundle.loadString('assets/planets.json');
  final planets = decodePlanets(jsonDecode(data));
  runApp(MaterialApp(title: ss, home: Menu(planets: planets)));
}

class Menu extends StatefulWidget {
  final List<Planet> planets;

  const Menu({Key key, this.planets}) : super(key: key);

  @override
  _MenuSt createState() => _MenuSt();
}

class _MenuSt extends State<Menu> {
  var _cntrl;
  var _offset = 0.0;

  _listener() {
    setState(() {
      _offset = _cntrl.offset;
    });
  }

  @override
  void initState() {
    _cntrl = InfiniteScrollController();
    _cntrl.addListener(_listener);
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff183F6D), Color(0xff030D1A)])),
      child: Scaffold(
          backgroundColor: Color(0),
          body: Stack(fit: StackFit.expand, children: <Widget>[
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 80),
                child: Text(ss,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "H",
                        color: Color(0xddffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 50))),
            Padding(
                padding: EdgeInsets.only(top: 50),
                child:
                    Stack(alignment: Alignment.centerLeft, children: <Widget>[
                  Container(
                      height: 500,
                      child: FlareActor("assets/sun.flr",
                          animation: idl,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft)),
                  Container(
                      height: 500,
                      child: InfiniteListView.builder(
                          itemExtent: 80,
                          controller: _cntrl,
                          itemBuilder: (ctx, i) => Item(
                              offset: _offset,
                              index: i,
                              planet: widget.planets[i % 8])))
                ]))
          ])));
}

class Item extends StatelessWidget {
  final offset, index;
  final Planet planet;

  const Item({Key key, this.offset, this.index, this.planet}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final toMiddle = min((210 - index * 80 + offset).abs(), 250);
    final opacity = 1 - min(min(max(toMiddle, 150), 225) - 150, 75) / 75;
    final padding = 250 * cos(asin(toMiddle / 250));
    return Opacity(
        opacity: opacity,
        child: FlatButton(
            padding: EdgeInsets.only(left: max(padding - 100, 0)),
            child: Row(children: <Widget>[
              planetFlr(64, planet.flr, 0),
              Text(planet.name,
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: "H",
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ]),
            onPressed: () {
              Navigator.push(ctx,
                  MaterialPageRoute(builder: (ctx) => Content(planet: planet)));
            }));
  }
}

class Content extends StatelessWidget {
  final Planet planet;

  const Content({Key key, this.planet}) : super(key: key);

  @override
  Widget build(BuildContext ctx) => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 0.5],
              colors: [Colors.black, red])),
      child: Scaffold(
          backgroundColor: Color(0),
          body: Stack(children: [
            ListView(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                    height: 200,
                    child: FlareActor("assets/top.flr",
                        animation: idl, fit: BoxFit.cover)),
                Container(
                    margin: EdgeInsets.only(top: 200),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.white, width: 2)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xffECA86A), red])),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 180, top: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(planet.name,
                                        style: TextStyle(
                                            fontFamily: "H",
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: Text(planet.description,
                                            style: TextStyle(
                                                fontFamily: "H",
                                                color: Colors.white,
                                                fontSize: 16)))
                                  ])),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("About",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: "R",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white))),
                          Container(
                              height: 2,
                              width: 55,
                              color: Colors.white70,
                              margin: EdgeInsets.only(top: 20, left: 20)),
                          text(planet.intro),
                          SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (c, i) =>
                                      imgButton(planet.photos[i]),
                                  itemCount: planet.photos.length)),
                          text(planet.text)
                        ])),
                planetFlr(200, planet.flr, 100)
              ])
            ]),
            SafeArea(child: BackButton(color: Colors.white))
          ])));
}
