import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:test_soundboard_app/drawer_maker.dart';
import 'package:test_soundboard_app/main.dart';
import 'package:test_soundboard_app/soundplayer.dart';
import 'package:test_soundboard_app/soundstorage.dart';

class Funny extends StatefulWidget
{
   Funny({ Key key }) : super(key: key);
   State<StatefulWidget> createState() => new _Funny();
}

class _Funny extends State<Funny>
{

  MediaQueryData queryData;

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
    queryData = MediaQuery.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Funny', 
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
    queryData = MediaQuery.of(context);
    player.dispose();
  }
  
   Widget makeButton(double buttonWidth, double buttonHeight, String name, int filePath){
    return ButtonTheme(
      minWidth: buttonWidth,
      height: buttonHeight,
      padding: new EdgeInsets.all(10),
      child: new RaisedButton(
        onPressed: () => player.play(soundFilePath[filePath]),
        child: Text(name, style: new TextStyle(fontFamily: 'Comfortaa Regular', fontSize: queryData.textScaleFactor*14))
      )
    );
  }

  Widget getLoadedBody(){

    final space = Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0));
    final double buttonWidth = 100;
    final double buttonHeight = 50;

    return new  Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/images/garyVeeTestBG1.png'),
                  fit: BoxFit.cover,
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
        SingleChildScrollView(
          child: Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: queryData.size.width,
              child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Turns Me On', 6),
                makeButton(buttonWidth, buttonHeight, 'Dickpants47', 8),
                makeButton(buttonWidth, buttonHeight, 'Juice From \n the Moon', 11),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Piano On Face', 15),
                makeButton(buttonWidth, buttonHeight, 'She\'s a Gangster', 27),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Hello Hong Kong', 28),
                makeButton(buttonWidth, buttonHeight, 'Lunch Room Shit', 42),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Hotdogs', 62),
                makeButton(buttonWidth, buttonHeight, '21 Savage', 63),
                makeButton(buttonWidth, buttonHeight, 'The World', 64)
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Fatpants86', 65),
                makeButton(buttonWidth, buttonHeight, 'Food Taste', 66),
                makeButton(buttonWidth, buttonHeight, 'Blueberries', 69),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Blueberries 2', 70),
                makeButton(buttonWidth, buttonHeight, 'Fuck You \n Grandpa', 71),
                makeButton(buttonWidth, buttonHeight, 'Hand Eye', 80)
              ],),
            ])
            )
            
          )
          ),
        )
        
        
      ]);
   
    }
}