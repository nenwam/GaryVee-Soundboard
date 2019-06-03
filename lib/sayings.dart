import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:test_soundboard_app/drawer_maker.dart';
import 'package:test_soundboard_app/main.dart';
import 'package:test_soundboard_app/soundplayer.dart';
import 'package:test_soundboard_app/soundstorage.dart';

class Sayings extends StatefulWidget
{
   Sayings({ Key key }) : super(key: key);
   State<StatefulWidget> createState() => new _Sayings();
}

class _Sayings extends State<Sayings>
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
          'Sayings', 
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
                makeButton(buttonWidth, buttonHeight, 'Early Bird', 43),
                makeButton(buttonWidth, buttonHeight, 'This is Funny', 50),
                makeButton(buttonWidth, buttonHeight, 'Hire Somebody', 45),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Players', 46),
                makeButton(buttonWidth, buttonHeight, 'Do Their Thing', 47),
                makeButton(buttonWidth, buttonHeight, 'Understand \nThat', 51),
              ]),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Less Marathons', 52),
                makeButton(buttonWidth, buttonHeight, 'Less Fortnite', 53),
                makeButton(buttonWidth, buttonHeight, 'Fishing \nPole', 54),
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Your Dream', 55),
                makeButton(buttonWidth, buttonHeight, 'Just Go Do', 56),
                makeButton(buttonWidth, buttonHeight, 'Other People\'s \n Opinions', 57)
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'Try Shit', 58),
                makeButton(buttonWidth, buttonHeight, 'Try Shit 2', 59),
                makeButton(buttonWidth, buttonHeight, 'People Decide No', 60)
              ],),
              space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                makeButton(buttonWidth, buttonHeight, 'I Love Losing', 61),
                makeButton(buttonWidth, buttonHeight, 'Parent Opinion', 67),
                makeButton(buttonWidth, buttonHeight, 'Friends', 68)
              ],),
            ])
            )
            
          )
          ),
        )
        
        
      ]);
   
    }
}