import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:path/path.dart';

import 'package:test_soundboard_app/main.dart';
import 'package:test_soundboard_app/soundplayer.dart';
import 'package:test_soundboard_app/soundstorage.dart';

class DrawerMaker extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                onTap: () { 
                  Navigator.of(context).pushReplacementNamed("/a");
                },
                title: new Text(
                  'Home Page',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 36,
                  )
                ),
              ),
              new Divider(),
              new ListTile(
                onTap: () { 
                  Navigator.of(context).pushReplacementNamed("/b"); 
                },
                title: new Text(
                  'Responses',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontFamily: 'Comfortaa Bold',
                    fontSize: 30,
                  )
                ),
              ),
              new Divider(),
              new ListTile(
                onTap: () { 
                  Navigator.of(context).pushReplacementNamed("/c");
                  //TODO: Add route for this page
                },
                title: new Text(
                  'Curse Words',
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontFamily: 'Comfortaa Bold',
                    fontSize: 30,
                  )
                )
              )
            ],
          )
        );
  }
}