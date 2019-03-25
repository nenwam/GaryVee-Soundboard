import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:test_soundboard_app/drawer_maker.dart';
import 'package:test_soundboard_app/main.dart';
import 'package:test_soundboard_app/soundplayer.dart';
import 'package:test_soundboard_app/soundstorage.dart';

class Responses extends StatefulWidget
{
   Responses({ Key key }) : super(key: key);
   State<StatefulWidget> createState() => new _Responses();
}

class _Responses extends State<Responses>
{

  SoundPlayer player;

  List<String> soundFilePath;

  @override
  void initState() {
    super.initState();
    player = new SoundPlayer();
  }


  Widget getFuture(){
    return new FutureBuilder<List<String>>(
      future: new SoundStorage().loadSounds(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else{
              soundFilePath = snapshot.requireData;
              print('Loading completed. ${soundFilePath.length} sounds loaded');
              return getLoadedBody();
            }
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Responses', 
          style: new TextStyle(
            fontFamily: 'Permanent Marker', 
            fontSize: 26
              ), 
            ),
        centerTitle: true,
        ),

        //Drawer
        endDrawer: DrawerMaker(),

      body: getFuture()
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
  
   Widget makeButton(double buttonWidth, double buttonHeight, String name, int filePath){
    return ButtonTheme(
      minWidth: buttonWidth,
      height: buttonHeight,
      child: new RaisedButton(
        onPressed: () => player.play(soundFilePath[filePath]),
        child: Text(name, style: new TextStyle(fontFamily: 'Comfortaa Regular'))
      )
    );
  }

  Widget getLoadedBody(){

    final space = Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0));
    final double width = 100.0;
    final double height = 50.0;

    return new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/images/garyVeeTestBG1.png'),
                  fit: BoxFit.cover
                )
              ),
              child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.black.withOpacity(0.2)
                  ),
                )
              )
            ), 
        Container(
          margin: EdgeInsets.all(20),
          child: Container(
            child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, height, 'Yes', 23),
                makeButton(width, height, 'No', 24),
                makeButton(width, height, 'Welcome', 5),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, height, 'You did, \nmy man', 3),
                makeButton(width, height, 'Entrepeneurship is cool', 14),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, height, 'I feel bad', 10),
                makeButton(width, height, 'You\'re not \nhappy', 13),
                makeButton(width, height, 'This is \nreal talk', 9),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, height, 'I\'m just so tired', 17),
                makeButton(width, height, 'That\'s exactly right', 18),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, 56.0, 'That\'s \nfucking \namazing', 16),
                makeButton(width, height, 'Shit, man', 12),
                makeButton(width, height, 'You guys \nare here?', 22),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(width, height, 'You\'re not', 29),
                makeButton(width, height, 'Listen', 20),
                makeButton(width, height, 'I Don\'t Know', 21),
              ],)
            ])
          )
        )
      ]);
    }
}