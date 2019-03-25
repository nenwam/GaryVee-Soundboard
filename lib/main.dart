import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_soundboard_app/drawer_maker.dart';
import 'package:test_soundboard_app/responses.dart';
import 'dart:ui';

void main() async{
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(SoundBoardApp());
} 

class SoundBoardApp extends StatelessWidget
{
  String version = '(alpha)';
  String appBarTitle = 'Categories';
  String responses = 'Responses';
  String curseWords = 'Curse Words';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Test Soundboard App',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: new HomePage(),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => new SoundBoardApp(),
        "/b": (BuildContext context) => new Responses(),
      }
    );
  }
}

class HomePage extends StatelessWidget
{
  SoundBoardApp main = new SoundBoardApp();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      
        //AppBar
        appBar: new AppBar(
          title: new Text('Categories', style:TextStyle(fontSize: 26, fontFamily: 'Permanent Marker')),
          centerTitle: true,
          backgroundColor: Colors.yellow,
          elevation: 0.0,
        ),

        //Background Color
        // backgroundColor: Colors.blueGrey,
        
        //Drawer
        endDrawer: DrawerMaker(),

        //Body
        body: new Stack(
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

            new Center(
            child: new Container(
              color: Colors.yellow,
              height: 370,
              width: 330,
              child: new Column(
                children: <Widget>[
                  new Text(''),
                  new Text(''),
                  new Text(
                    'Welcome to',
                    style: new TextStyle(
                      fontFamily: 'Comfortaa Bold',
                      fontSize: 45
                    )
                  ),
                  new Text(''),
                  new Text(
                    'the',
                    style: new TextStyle(
                      fontFamily: 'Comfortaa Bold',
                      fontSize: 35
                    )
                  ),
                  new Text(
                    'GaryVee',
                    style: new TextStyle(
                      fontFamily: 'Permanent Marker',
                      fontSize: 70
                    )
                  ),
                  new Text(''),
                  new Text(''),
                  new Text(
                    'Soundboard',
                    style: new TextStyle(
                      fontFamily: 'Comfortaa Bold',
                      fontSize: 45
                    )
                  ),
                  new Text(''),
                  new Text(
                    main.version,
                    textAlign: TextAlign.end,
                    style: new TextStyle(
                      fontFamily: 'Comfortaa Light',
                      fontSize: 16
                    )
                  )
                ],
              )
          )
        ),
      ]    
      )
    );
  }
}


//  new Container(
//                   decoration: new BoxDecoration(
//                     image: new DecorationImage(
//                       image: new AssetImage("assets/images/garyVeeTestBG1.png"),
//                       fit: BoxFit.cover,
//                     )
//                   ),
//                 ),