import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key, required this.songModel, required this.audioPlayer}) : super(key: key);
  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  // final AudioPlayer _audioPlayer= AudioPlayer();
  Duration _duration= Duration();
  Duration _position= Duration();
  bool _isPlaying=false;
  void initState()
  {
    super.initState();
    playSong();
  }
  void playSong()
  {
   try{
     widget.audioPlayer.setAudioSource(
         AudioSource.uri(
             Uri.parse(widget.songModel.uri.toString()),
             tag: MediaItem(
               id: '${widget.songModel.id}',
               album: "${widget.songModel.artist}",
               title: "${widget.songModel.displayNameWOExt}",
               // artUri: Uri.parse('https://example.com/albumart.jpg'),
             ),
         )
     );
     widget.audioPlayer.play();


     _isPlaying=true;
   }
   on Exception{
     log("Cannot Parse the song");
   }

   widget.audioPlayer.durationStream.listen((d) {

     setState(() {
       _duration=d!;
       widget.audioPlayer.setSpeed(1.0);
     });
   });
   widget.audioPlayer.positionStream.listen((p) {
     setState(() {
       _position=p;
     });
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);


              }, icon: Icon(Icons.arrow_back_ios),),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      child:Icon(
                        Icons.music_note,
                        size:80
                      )
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(widget.songModel.displayNameWOExt,overflow: TextOverflow.clip,maxLines: 2,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(widget.songModel.artist.toString()=="<unknown>"? "Unknown Artist":widget.songModel.artist.toString(),
                      overflow: TextOverflow.clip,maxLines: 1,style: TextStyle(
                        fontSize: 20
                    ),),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Text(_position.toString().split(".")[0]),
                        Expanded(
                          child: Slider(
                              min: Duration(microseconds: 0).inSeconds.toDouble(),
                              value: _position.inSeconds.toDouble(),
                              max: _duration.inSeconds.toDouble(),
                              onChanged: (double value) {
                                changeToSeconds(value.toInt());
                                value=value;
                          }),
                        ),
                        Text(_duration.toString().split(".")[0])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: (){
                          widget.audioPlayer.setSpeed(1);
                          Fluttertoast.showToast(
                            msg: "Normal",
                            // toastLength: Toast.LENGTH_SHORT,
                            // gravity: ToastGravity.BOTTOM,
                            // timeInSecForIosWeb: 2,
                            backgroundColor: Colors.black,
                            // textColor: Colors.red,
                            // fontSize: 14.0

                          );
                        }, icon: Icon(Icons.keyboard_double_arrow_left),iconSize: 40,),
                        IconButton(onPressed: (){
                           setState(() {
                             if(_isPlaying)
                               {
                                 widget.audioPlayer.pause();
                               }
                             else{
                               widget.audioPlayer.play();

                             }
                             _isPlaying= !_isPlaying;
                           });

                        }, icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),iconSize: 40, color: Colors.orangeAccent,),
                        IconButton(onPressed: (){
                          widget.audioPlayer.setSpeed(1.5);
                          // widget.audioPlayer.seekToNext();
                          Fluttertoast.showToast(
                              msg: "1.5x",
                              // toastLength: Toast.LENGTH_SHORT,
                              // gravity: ToastGravity.BOTTOM,
                              // timeInSecForIosWeb: 2,
                              backgroundColor: Colors.black,
                            // textColor: Colors.red,
                            // fontSize: 14.0

                          );
                          print('toated');
                        }, icon: Icon(Icons.keyboard_double_arrow_right_outlined),iconSize: 40,),
                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void changeToSeconds(int seconds){
    Duration duration=Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}

