import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Screens/NowPlaying.dart';
import '../tried/songHelper.dart';
import '../tried/songInfo.dart';

class SelectSongForList extends StatefulWidget {
  SelectSongForList({Key? key}) : super(key: key);

  get songModel => songModel;


  @override
  State<SelectSongForList> createState() => _normalListState();
}

class _normalListState extends State<SelectSongForList> {
  final _audioQuery= new OnAudioQuery();
  final _audioPlayer=new AudioPlayer();
  late final SongModel songModel;
  SongHelper _songHelper= SongHelper();
  late final List<SongModel> songs=<SongModel>[];
  bool _isSelected=false;

  bool flag=true;



  // final SongModel songModel;
  // bool _searching=false;
  // List<SongModel> filterdSongs=<SongModel>[];
  // final _searchController=TextEditingController();



  @override
  void initState(){
    super.initState();
    Permission.storage.request();
    print("is selectd: $_isSelected");
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
      var id = widget.songModel.artist;
      print(id.toString());
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
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.music_note)),
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text('${item.data![index].artist}'),
                  trailing: ElevatedButton(
                      onPressed: (){
                            print("list: ${item.data![index]}");
                            print("----------------------");
                            print('current song index: $songIndex');
                            if(songs.length==0)
                              {
                                songs.add(item.data![index]);
                                Fluttertoast.showToast(
                                          msg: "${item.data![index].displayNameWOExt} Added",
                                          timeInSecForIosWeb: 0,

                                          backgroundColor: Colors.green,
                                        );

                                // print("song list: ${songs.length}");

                              }
                            else{
                              songs.add(item.data![index]);
                              Fluttertoast.showToast(
                                msg: "${item.data![index].displayNameWOExt} Added",
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                              );
                            }

                            for(int i=0;i<(songs.length);i++){

                              for(int j=i+1;j<songs.length;j++)
                                {
                                if (songs[i].id == songs[j].id) {
                                  setState(() {
                                    songs.remove(songs[i]);
                                  });


                                  }

                                }
                              }




                            print("songlist Length: ${songs.length}");
                            for(int i=0;i<songs.length;i++)
                              {
                                print("List: ${songs[i].artist},${songs[i].id}");
                              }
                      }, child: Icon(_isSelected?Icons.chevron_right :  Icons.maps_ugc_outlined),
                      ),
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
chilld(bool x) {
  RaisedButton(
    child: Text('Show alert'),
    onPressed: () {
      print("hello");
    },
  );
}