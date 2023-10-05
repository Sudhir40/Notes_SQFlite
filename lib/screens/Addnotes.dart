
import 'package:dabasesqflite/models/Notes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database_helper/Appdb.dart';

class Addnotes extends StatefulWidget{
  String? tittle;
  String? desc;
  int? notes_id;
  Addnotes({ this.tittle,  this.desc,this.notes_id});
  @override
  State<Addnotes> createState() {
    return AddnotesState();
  }
}
class AddnotesState extends State<Addnotes>{
  var titlecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  late AppDatabase myDB;
  late String? mtitle = widget.tittle;
  late String? mnotes = widget.desc;
  late int? notes_id = widget.notes_id;
  @override
  Widget build(BuildContext context) {
    if(mtitle!=null&&mnotes!=null){
      titlecontroller.text=mtitle!;
      notescontroller.text=mnotes!;
    }
    myDB = AppDatabase.db;
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.black54,
        width: double.infinity,
      //  color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Color(0xFFECEFF5),
              padding: EdgeInsets.only(top: 100),
              child: TextField(
                keyboardType:TextInputType.multiline ,
                maxLines: null,
                controller: titlecontroller,
              //  scrollController: ScrollController.,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color:Colors.green),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.edit_note,color: Colors.green,),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFECEFF5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all( 8.0,),
                  child: TextField(
                    controller: notescontroller,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 30
                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Writr here your notes',
                      border: InputBorder.none
                    ),
          ),
                ),
              ),
            )
                 ],
        ),
      ),
     floatingActionButton: FloatingActionButton.extended(
       label: Text('Save',style: TextStyle(
         color: Colors.green
       ),),
       icon: Icon(Icons.save,color: Colors.green,),
       backgroundColor: Color(0xFFECEFF5),
       onPressed: (

         )async{
      var title = titlecontroller.text.toString();
      var notes = notescontroller.text.toString();
      if(mtitle!=null&&mnotes!=null){
        await myDB.update(note_mode(title: title, desc:notes,note_id: notes_id!));
      }else{
        await myDB.addNote(note_mode(title: title, desc: notes));
      }
      setState(() {
      });
     },),
    );
  }
}