

import 'package:dabasesqflite/Database_helper/Appdb.dart';
class note_mode{
  int? note_id;
  String title;
  String desc;
  note_mode({this.note_id,required  this.title,required  this.desc});
  factory note_mode.from_map(Map<String, dynamic >map){
    return note_mode(

        note_id:  map[AppDatabase.NOTE_COLUMN_ID],
        title: map[AppDatabase.NOTE_COLUMN_TITLE],
        desc: map[AppDatabase.NOTE_COLUMN_DESC]);
  }
  Map<String,dynamic> to_map(){
        return {
          AppDatabase.NOTE_COLUMN_ID:note_id,
          AppDatabase.NOTE_COLUMN_TITLE:title,
          AppDatabase.NOTE_COLUMN_DESC:desc
        };
    }
    }