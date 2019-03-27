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
        child: Text(name, style: new TextStyle(fontFamily: 'Comfortaa Regular', fontSize: queryData.textScaleFactor*20))
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
                makeButton(buttonWidth, buttonHeight, 'Yes', 23),
                makeButton(buttonWidth, buttonHeight, 'No', 24),
                makeButton(buttonWidth, buttonHeight, 'Welcome', 5),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'You did, \nmy man', 3),
                makeButton(buttonWidth, buttonHeight, 'Entrepeneurship is cool', 14),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'I feel bad', 10),
                makeButton(buttonWidth, buttonHeight, 'You\'re not \nhappy', 13),
                makeButton(buttonWidth, buttonHeight, 'This is \nreal talk', 9),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'I\'m just so tired', 17),
                makeButton(buttonWidth, buttonHeight, 'That\'s exactly right', 18),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, 56.0, 'That\'s \nfucking \namazing', 16),
                makeButton(buttonWidth, buttonHeight, 'Shit, man', 12),
                makeButton(buttonWidth, buttonHeight, 'You guys \nare here?', 22),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'You\'re not', 29),
                makeButton(buttonWidth, buttonHeight, 'Listen', 20),
                makeButton(buttonWidth, buttonHeight, 'I Don\'t Know', 21),
              ],),
              space,
            ])
            )
            
          )
          ),
        )
        
        
      ]);
   
    }
}