// Creado por: Elisama Arturo Calva Moreno
// Asignatura: Desarrollo Movil Integral
//Grado: 10   Grupo: "A"
// Docente: MTI. Marco Antonio Ramirez Hernandez

import 'package:flutter/material.dart';
import 'package:movieapp_200561/common/HttpHandler.dart';
import 'package:movieapp_200561/media_list.dart';
import 'package:movieapp_200561/common/MediaProvider.dart';
import 'package:movieapp_200561/model/Media.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key});
  @override
  State<Home> createState() =>
      _HomeState();
}

class _HomeState extends State<Home> {

  final MediaProvider movieProvider = new MediaPrvider();
  final MediaProvider showProvider = new ShowProvider();

  MediaType mediaType = MediaType.movie;
  final TextStyle customTextStyle = TextStyle(
    fontFamily: 'si',
    fontSize: 16.0,
    fontWeight: FontWeight
        .bold,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MovieApp-200561"),
        titleTextStyle: TextStyle(fontFamily: 'si'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
       drawer: new Drawer(
        child: new ListView(children: <Widget>[
          new DrawerHeader(
            child: Center(
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/b.png'), fit: BoxFit.cover)),
          ),
          new ListTile(
            title: new Text(
              "Peliculas",
              style:
                  customTextStyle,
            ),
            selected: mediaType == MediaType.movie,
            trailing: new Icon(Icons.local_movies),
            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop();
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text(
              "Television",
              style:
                  customTextStyle,
            ),
             trailing: new Icon(Icons.live_tv ),
              onTap: () {
              _changeMediaType(MediaType.show);
              Navigator.of(context).pop();
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text(
              "Cerrar",
              style:
                  customTextStyle,
            ),
           trailing: new Icon(Icons.exit_to_app),
            onTap: () => Navigator.of(context)
                .pop(),
          ),
        ]),
      ),
      body: PageView(children: _getMediaList()),
      bottomNavigationBar: new BottomNavigationBar(
        items: _obtenerIconos(),
      ),
    );
  }

  List<BottomNavigationBarItem> _obtenerIconos() {
    return [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),
        label: ("Populares"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),
        label: ("Proximamente"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),
        label: ("Mejor valorados"),
      ),
    ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[new MediaList(movieProvider)]
        : <Widget>[new MediaList(showProvider)];
  }
}