//@dart = 2.9
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:chess_lib/models/game.model.dart';
import 'package:chess_lib/services/game.service.dart';
import 'screens/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;
  String imagePath = '';
  static const TextStyle styles =
      TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400);

  Future<List<GameM>> _listGames;
  GameS service = GameS();

  @override
  void initState() {
    super.initState();
    _listGames = service.getGames();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _options = [
      new Text('Favoritos', style: styles),
      //Listado de partidas
      new Center(
          child: new ListView(children: <Widget>[
        new Text('\n\nComienza a explorar\n',
            style: styles, textAlign: TextAlign.center),
        new FutureBuilder(
          future: _listGames,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  mainAxisSize:
                      MainAxisSize.max, //Arreglar el scroll y evitar overflow
                  children: _btnGames(snapshot.data));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error');
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          },
        )
      ])),
      new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            (imagePath=='')?
            new Center(
              child: new Container(
                margin: const EdgeInsets.only(top: 25),
                child: new Image(
                  width: 70,
                  height: 70,
                  image: NetworkImage(
                    'https://i.pinimg.com/originals/73/de/d1/73ded1b4fd57df52b00739b97bfc5945.png'),
                  ))):
              Center(child: ClipRRect(child: Container(margin: const EdgeInsets.only(top: 25),
              //decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
              child: Image.file(File(imagePath)),width: 70,height: 70))),
              new Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                IconButton(
                  color: Colors.black,
                  icon: new Icon(Icons.add_a_photo_rounded),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile _pickedFile = await _picker.pickImage(source: ImageSource.camera);
                    if(_pickedFile!=null){
                      imagePath = _pickedFile.path;
                    }
                  },
                ),
                IconButton(
                  color: Colors.black,
                  icon: new Icon(Icons.add_photo_alternate_rounded),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    if(_pickedFile!=null){
                      imagePath = _pickedFile.path;
                    }
                  },
                )
              ]),
              new Text('\nNombre de usuario',style: TextStyle(fontSize: 20)),
              new Text('Informacion adicional')
            ],
          )
      )

    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        appBar: new AppBar(
            title: new Center(
                child:
                    new Text('ChessLib', style: new TextStyle(fontSize: 30.0))),
            backgroundColor: Colors.black),
        body: new Center(child: _options[_selectedIndex]),
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.favorite), label: 'Favoritos'),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), label: 'Inicio'),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle), label: 'Perfil')
          ],
          selectedItemColor: Colors.black,
          iconSize: 35.0,
          unselectedFontSize: 15.0,
          selectedFontSize: 18.0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
//Lista de widgets con nombres de la partida
  List<Widget> _btnGames(data) {
    List<Widget> games = [];
    int cont = 0;
    TextStyle txtStyle;
    var color;
    for (GameM game in data) {
      if (cont == 0) {
        color = Colors.white;
        txtStyle = new TextStyle(color: Colors.black);
        cont += 1;
      } else {
        color = Colors.black;
        txtStyle = new TextStyle(color: Colors.white);
        cont = 0;
      }
      games.add(new MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new Game(game, 0, 0)));
          },
          child: new Text(game.name, style: txtStyle),
          height: 50.0,
          minWidth: 250.0,
          splashColor: Colors.grey,
          color: color));
    }
    return games;
  }
}
