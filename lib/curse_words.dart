import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:test_soundboard_app/drawer_maker.dart';
import 'package:test_soundboard_app/main.dart';
import 'package:test_soundboard_app/soundplayer.dart';
import 'package:test_soundboard_app/soundstorage.dart';

class CurseWords extends StatefulWidget
{
   CurseWords({ Key key }) : super(key: key);
   State<StatefulWidget> createState() => new _CurseWords();
}

class _CurseWords extends State<CurseWords>
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
          'Curse Words', 
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
        child: Text(name, style: new TextStyle(fontFamily: 'Comfortaa Regular', fontSize: queryData.textScaleFactor*18))
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
                makeButton(buttonWidth, buttonHeight, 'Give a Fuck', 32),
                makeButton(buttonWidth, buttonHeight, 'Fuck the Man', 31),
                makeButton(buttonWidth, buttonHeight, 'Fucken', 30),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'The Fuck \nYou Think', 33),
                makeButton(buttonWidth, buttonHeight, 'Ain\'t Shit', 34),
                makeButton(buttonWidth, buttonHeight, 'Crazy Shit', 35),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Fucked Up', 41),
                makeButton(buttonWidth, buttonHeight, 'Shit', 39),
                makeButton(buttonWidth, buttonHeight, 'Fucken Suck', 37),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Fucken Trash', 38),
                makeButton(buttonWidth, 56.0, 'Shit on You', 40),
              ],),
            ])
            )
            
          )
          ),
        )
        
        
      ]);
   
    }
}