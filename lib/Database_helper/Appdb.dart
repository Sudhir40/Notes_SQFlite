import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/Notes_model.dart';
class  AppDatabase{
  AppDatabase._();
  static final AppDatabase db = AppDatabase._();
  Database? _database;
  static final NOTE_TABLE = "note";
  static final  NOTE_COLUMN_ID = "note_id";
  static final NOTE_COLUMN_TITLE = "title";
  static final NOTE_COLUMN_DESC = "desc";
  Future<Database> getDB()async{
    if (_database!=null){
      return _database!;
    }
    else{
      return await  initDB();
    }
  }
  Future<Database> initDB() async{
    Directory  documentdirectory = await getApplicationDocumentsDirectory() ;
    var dbpath =  join(documentdirectory.path, "noteDataBaes.db");
    return openDatabase(
        dbpath,
        version: 2,
        onCreate: (db,version){
          db.execute('Create table  $NOTE_TABLE    ( $NOTE_COLUMN_ID integer primary key autoincrement,$NOTE_COLUMN_TITLE text,$NOTE_COLUMN_DESC text )' );
        }
    );
  }
  Future<bool> addNote(note_mode model)async{
    var db = await getDB();
    var rowseffect =  await db.insert(NOTE_TABLE,model.to_map());
    if (rowseffect >0){
      return true;
    }else{
      return false;
    }
  }
  Future<List<note_mode>>fetchALLNotes()async{
    var db = await getDB();

    List<Map<String,dynamic>> notes= await db.query(NOTE_TABLE) ;
    List<note_mode> listnotes = [];
    for(Map<String,dynamic> note in notes){
      listnotes.add(note_mode.from_map(note));
    }
    return listnotes;
  }
Future<bool> deleteNote(int id)async{
    var db=await  getDB();
    var count =await  db.delete(NOTE_TABLE,where: "$NOTE_COLUMN_ID=$id");
    return count>0;
}
Future<bool> update(note_mode model)async{
    var db = await  getDB();
 var count =    await db.update(NOTE_TABLE,model.to_map(),where:"$NOTE_COLUMN_ID= ${model.note_id}");
   // var count = await  db.update(NOTE_TABLE,note.tomap(),where: '$NOTE_COLUMN_ID= ${note.note_id}");
    return count>0;
}
}
