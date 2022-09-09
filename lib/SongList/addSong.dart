import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_audio/SongList/selectSongForList.dart';

class addPlayListName extends StatefulWidget {
  const addPlayListName({Key? key}) : super(key: key);

  @override
  State<addPlayListName> createState() => _addPlayListNameState();
}

class _addPlayListNameState extends State<addPlayListName> {
  late TextEditingController listName;
  String listNM="";
  final List<String> listSong=["null"];


  void initState(){
    super.initState();
    listName=TextEditingController();
    // final List<String> listSong;

  }

  void dispose(){
    listName.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        title: Text("Music Player"),
        actions: [
        IconButton(onPressed: (){
          showDialog(
              context: context,
              builder: (context)=> AlertDialog(
                title:Text("Enter Name"),
                content: TextField(
                  controller: listName,
                  decoration: const InputDecoration(
                    hintText: "Playlist Name"
                  ),
                ),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop(listName.text);
                    setState(() {
                      listNM=listName.text;
                      listSong.add(listNM);
                    });
                  },
                      child: Text("Submit"))
                ],
              )

          );
        }, icon: Icon(Icons.plus_one))
        ],
        ),
      body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: listSong.length,
                  itemBuilder: (BuildContext context, int index) {

                    // return Card(
                    //
                    //   child: ListTile(
                    //         leading: SizedBox(
                    //           height: 10,
                    //           child: Icon(Icons.album_outlined),
                    //         ),
                    //
                    //         title: Text(listSong[index]),
                    //
                    //       ),
                    //   onTap:(){
                    //
                    //   }
                    //
                    // );
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(

                            onPressed: (){

                        },
                            child: Card(

                              child: ListTile(
                                    leading: Icon(Icons.album_outlined),
                                    title: Text(listSong[index]),
                                    trailing:ElevatedButton(onPressed: (){
                                      Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectSongForList()),);
                                    }, child: Icon(Icons.add),
                                    ),
                                  ),
                        )),
                      ],
                    );

                  }
              )



    );
  }
}
