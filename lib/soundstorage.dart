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
    'assets/sounds/responses/im_just_so_tired.mp3',       // 17 "I'm just so tired"
    'assets/sounds/responses/thats_exactly_right.mp3',    // 18 "That's exactly right"
    'assets/sounds/responses/100Percent.mp3',             // 19 "100 Percent"
    'assets/sounds/responses/Listen.mp3',                 // 20 "Listen"
    'assets/sounds/responses/IDontKnow.mp3',              // 21 "I Dont' Know"
    'assets/sounds/responses/YouGuysHere.mp3',            // 22 "What are you guys doing here"
    'assets/sounds/responses/Yes.mp3',                    // 23 "Yes"
    'assets/sounds/responses/No.mp3',                     // 24 "No"
    'assets/sounds/responses/ItsRealSimple.mp3',          // 25 "It's real Simple"
    'assets/sounds/responses/HumanBehavior.mp3',          // 26 "Human Behavior"
    'assets/sounds/misc/ShesAGangster.mp3',               // 27 "She's a gangster"
    'assets/sounds/misc/HelloHongKong.mp3',               // 28 "Hello Hong Kong"
    'assets/sounds/responses/YoureNot.mp3',               // 29 "You're Not"
    'assets/sounds/curse/Fucken.mp3',                     // 30 "Fucken"
    'assets/sounds/curse/FuckTheMan.mp3',                 // 31 "Fuck The Man"
    'assets/sounds/curse/IDontGiveAFuck.mp3',             // 32 "I Don't Give a Fuck"
    'assets/sounds/curse/TheFuckYouThink.mp3',            // 33 "The Fuck You Think"
    'assets/sounds/curse/AintShit.mp3',                   // 34 "Aint Shit"   // Start
    'assets/sounds/curse/CrazyShit.mp3',                  // 35 "Crazy Shit" 
    'assets/sounds/curse/FuckedUp.mp3',                   // 36 "Fucked Up"
    'assets/sounds/curse/FuckenSuck.mp3',                 // 37 "You fucken suck"
    'assets/sounds/curse/FuckenTrash.mp3',                // 38 "Fucken Trash"
    'assets/sounds/curse/Shit.mp3',                       // 39 "Shit"
    'assets/sounds/curse/ShitOnYou.mp3',                  // 40 "Shit on You"
    'assets/sounds/curse/FuckedUpReal.mp3',               // 41 "Fucked Up" (The Real One)
    'assets/sounds/misc/LunchRoomShit.mp3',               // 42 "Lunch Room Shit"
    'assets/sounds/sayings/early_bird.mp3',               // 43 "Early Bird Gets the Worm"
    'assets/sounds/sayings/ThisIsFunny.mp3',              // 44 "This is Funny"
    'assets/sounds/sayings/HireSomebody.mp3',             // 45 "Hire Somebody"
    'assets/sounds/sayings/Players.mp3',                  // 46 "Players"
    'assets/sounds/sayings/DoTheirThing.mp3',             // 47 "Do Their Thing"
    'assets/sounds/sayings/UnderstandThat.mp3',           // 48 "Understand That"
    'assets/sounds/misc/HighOnSupply.mp3',                // 49 "High on Supply"
    'assets/sounds/sayings/ThisIsFunnyReal.mp3',          // 50 "This is Really Funny" (Real)
    'assets/sounds/sayings/UnderstandThatReal.mp3',       // 51 "Understand That"
    'assets/sounds/sayings/LessMarathons.mp3',            // 52 "Less Stranger Things Marathons"
    'assets/sounds/sayings/LessFortnite.mp3',             // 53 "Less Fortnite"
    'assets/sounds/sayings/FishingPole.mp3',              // 54 "I'm Giving you the fishing pole"
    'assets/sounds/sayings/YourDream.mp3',                // 55 "You have to bleed for your dream"
    'assets/sounds/sayings/JustGoDo.mp3',                 // 56 "Just Go Do"
    'assets/sounds/sayings/OtherOpinions.mp3',            // 57 "People live lives based on opinions
    'assets/sounds/sayings/TryShit.mp3',                  // 58 "You have to try shit"
    'assets/sounds/sayings/TryShit2.mp3',                 // 59 "Try shit"
    'assets/sounds/sayings/DecideNo.mp3',                 // 60 "Your deciding to say no"
    'assets/sounds/sayings/LoveLosing.mp3',               // 61 "I Love Losing"
    'assets/sounds/misc/Hotdogs.mp3',                     // 62 "Hotdogs are da' best"
    'assets/sounds/misc/21Savage.mp3',                    // 63 "21 Savage"
    'assets/sounds/misc/TheWorld.mp3',                    // 64 "The World"
    'assets/sounds/misc/Fatpants86.mp3',                  // 65 "Fatpants86"
    'assets/sounds/misc/FoodTaste.mp3',                   // 66 "Food Taste"
    'assets/sounds/sayings/ParentOpinion.mp3',            // 67 "Your Parent's Opinion"
    'assets/sounds/sayings/Friends.mp3',                  // 68 "Optimistic Friends"
    'assets/sounds/misc/Blueberries.mp3',                 // 69 "Blueberries Meme"
    'assets/sounds/misc/Blueberries2.mp3',                // 70 "Blueberries Meme 2"
    'assets/sounds/misc/FuckYouGrandpa.mp3',              // 71 "Fuck Your Grandpa"
    'assets/sounds/curse/FuckFaces.mp3',                  // 72 "Fuck Faces"
    'assets/sounds/misc/ILoveCurse.mp3',                  // 73 "I Love Curse Words"
    'assets/sounds/curse/DickFace.mp3',                   // 74 "Dick Face"
    'assets/sounds/curse/NobodyGivesAFuck.mp3',           // 75 "Nobody Gives a Fuck"
    'assets/sounds/curse/JackShit.mp3',                   // 76 "Jack Shit"
    'assets/sounds/curse/FuckTheMan.mp3',                 // 77 "Fuck The Man"
    'assets/sounds/curse/DoneShit.mp3',                   // 78 "You haven't done shit"  
    'assets/sounds/curse/YoureLost.mp3',                   // 79 "You're Fucken Lost"
    'assets/sounds/misc/HandEye.mp3',                     // 80 "Hand Eye Coordination"         
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