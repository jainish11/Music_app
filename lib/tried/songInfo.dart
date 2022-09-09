
import 'dart:convert';
//
// SongInfo songInfoFromJson(String str) => SongInfo.fromJson(json.decode(str));
//
// String songInfoToJson(SongInfo data)=> json.encode(data.toJson());
class SongInfo {
  SongInfo({
    required this.id,
    required this.title
});
  int id;
  String title;

  factory SongInfo.fromJson(Map<String,dynamic> json)=> SongInfo(
    id: json['id'],
    title: json['title'],
  );

  Map<String,dynamic> toMap()=>{
    "id":id,
    "title":title,
  };
}