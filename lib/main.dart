import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:local_audio/Screens/NowPlaying.dart';
import 'package:local_audio/tried/songHelper.dart';
import 'package:local_audio/tried/songInfo.dart';
// import 'package:on_audio_query_platform_interface/on_audio_query_platform_interface.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'SongList/addSong.dart';
import 'SongList/normalList.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const AllSongs(),
    );
  }
}

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);


  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {

  // final SongModel songModel;
  // bool _searching=false;
  // List<SongModel> filterdSongs=<SongModel>[];
  // final _searchController=TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Music Player"),
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(

          children: [


            ElevatedButton(onPressed: () {

              Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NormalList()),);

            },
              child: Text("All Songs"),


            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        addPlayListName()),);

            }, child: Text("PlayList"))
          ],
        ),
      ),
    );
  }
}

      

              
                     

                      //
              

         

