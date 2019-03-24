import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundStorage{

//  Future<String> _hasInPrefs(String assetPath){
//    return new Future(()=>'S');
//  }

  final soundAssetPath = <String>[
    'assets/sounds/service-bell_daniel_simion.mp3',       // 0 TESTER SOUND
    'assets/sounds/im/business_man.mp3',                  // 1 "I'm a business man"
    'assets/sounds/responses/you_did.mp3',                // 2 DO NOT USE THIS ONE
    'assets/sounds/responses/you_did.mp3',                // 3 "You did, my man"
    'assets/sounds/im/business_man_real.mp3',             // 4 "I'm a business man"
    'assets/sounds/responses/welcome.mp3',                // 5 "Welcome"
    'assets/sounds/misc/really_turns_me_on.mp3',          // 6 "Really Turns Me On"
    'assets/sounds/sayings/early_bird.mp3',               // 7 "Early Bird"
    'assets/sounds/misc/dick_pants_47.mp3',               // 8 "Dickpants47"
    'assets/sounds/responses/this_is_real_talk.mp3',      // 9 "This is real talk"
    'assets/sounds/responses/i_feel_bad.mp3',             // 10 "I feel bad"
    'assets/sounds/misc/juice_from_moon.mp3',             // 11 "Juice from the moon"
    'assets/sounds/responses/shit_man.mp3',               // 12 "Shit, man"
    'assets/sounds/responses/youre_not_happy.mp3',        // 13 "You're not happy"
    'assets/sounds/responses/entrepeneurshiop_is_cool.mp3',   // 14 "Entrepenurship is cool"
    'assets/sounds/misc/piano_on_face.mp3',               // 15 "Piano on your fucking face"
    'assets/sounds/responses/thats_fucking_amazing.mp3',  // 16 "That's fucking amazing"
  ];

  Future<SharedPreferences> prefs;

  SoundStorage(){
    prefs = SharedPreferences.getInstance();
  }

  Future<List<String>> loadSounds() async{
    List<String> filePaths = new List<String>();
    await Future.forEach(soundAssetPath, (assetPath) async {
      final path = await getSoundPath(assetPath);
      filePaths.add(path);
      print('Sound $path added');
    });
    return filePaths;
  }

  Future<String> getSoundPath(String assetPath) async{
    final pref = (await prefs);
    final value = pref.getString(assetPath);
    if(value != null){
      print('Loading from shared_pref');
      return value;
    }else{
      print('Loading from assets');
      final path = await _assetPathToFilePath(assetPath);
      pref.setString(assetPath, path);
      return path;
    }
  }

  /// Writes new file to [tempPath] with byte data from asset and returns it.
  Future<String> _assetPathToFilePath(String assetPath) async{
    final name = assetPath.hashCode.toString();
    final tempPath = (await getTemporaryDirectory()).path;
    final file = new File('$tempPath/$name');
    final rawAsset = await rootBundle.load(assetPath);
    // TODO Handle io errors
    await file.writeAsBytes(rawAsset.buffer.asUint8List());
    return file.path;
  }

}