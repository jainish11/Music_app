import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Screens/NowPlaying.dart';
import '../tried/songHelper.dart';
import '../tried/songInfo.dart';

class NormalList extends StatefulWidget {
  const NormalList({Key? key}) : super(key: key);

  @override
  State<NormalList> createState() => _normalListState();
}

class _normalListState extends State<NormalList> {
  final _audioQuery= new OnAudioQuery();
  final _audioPlayer=new AudioPlayer();
  SongHelper _songHelper= SongHelper();


  // final SongModel songModel;
  // bool _searching=false;
  // List<SongModel> filterdSongs=<SongModel>[];
  // final _searchController=TextEditingController();



  @override
  void initState(){
    super.initState();
    Permission.storage.request();
    // _songHelper.initializeDatabase().then((value)  {
    // print('-------Databse intialized--------');
    // });


  }
  playSong(String? uri){
    try{
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
      // _audioPlayer.setSpeed(0);
    }on Exception{
      log("Error Parsing Song");
    }
  }
  void dispose(){
    // _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Music Player"),
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),

      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true
        ),
        builder: (context, item){
          if(item.data==null)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(item.data!.isEmpty)
          {
            return Center(
              child: Text("No Data Found"),
            );
          }

          // Container(
          //   child: Text(_audioPlayer.sequenceState!.currentSource.toString()),
          // );

          return ListView.builder(

                  itemCount:item.data!.length,

                  itemBuilder: (context, index) {
                    var songIndex=item.data![index].id;
                    print('custom song index: $songIndex');
                    return ListTile(
                      leading: CircleAvatar(child: Icon(Icons.music_note)),
                      title: Text(item.data![index].displayNameWOExt),
                      subtitle: Text('${item.data![index].artist}'),
                      trailing: Icon(Icons.play_arrow),
                      onTap: () {
                        print("cuttent song: ${item.data![index]}");
                        // var songInfo=SongInfo(
                        //     id: item.data![index].id,
                        //     title: item.data![index].title);
                        // _songHelper.insertSong(songInfo);
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NowPlaying(songModel: item.data![index],
                                    audioPlayer: _audioPlayer,)),);
                      },
                    );
                  }
              );
        },
      ),



    );
  }
}
