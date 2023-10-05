import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Addnotes.dart';
import '../Database_helper/Appdb.dart';
import '../models/Notes_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class note_dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Dash_board();
  }
}
class Dash_board extends State<note_dashboard>{
  late AppDatabase myDB;
  List<note_mode>arrnotes=[];
  var height = [100.0,200.0,150.0,250.0,200.0,];
  var colorlist=[
    Color(0xFFB5C5E5),
    Color(0xFF59CD73),
    Color(0xFF3083BB),
    Color(0xFFEA9D54),
    Color(0xFFE791F5),
    Color(0xFF54EAC0),
  ];
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
  var time = DateTime.now();

  @override
  void initState() {
    super.initState();
    myDB = AppDatabase.db;
    getnotes();
  }
  void addnotes(String title,String desc)async{
    bool check = await myDB.addNote(note_mode(title: title, desc: desc));
    if(check){
      arrnotes = await myDB.fetchALLNotes();
      setState(() {
      });
    }
  }
  void getnotes()async {
    arrnotes = await myDB.fetchALLNotes();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
  getnotes();
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:20,bottom: 8.0,right:8.0,left:8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),

              child: Center(child: Text('Your notes',style: TextStyle(
                fontSize: 30,
                color: Colors.white
              ),)),
            ),

            Expanded(
              child:
              Builder(
                builder: (context) {
                  if (arrnotes.length!=0){
                    return MasonryGridView.builder(
                        itemCount: arrnotes.length,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        gridDelegate:  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context,index){
                          Color cardcolor= colorlist[index% colorlist.length];
                          return
                            InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Addnotes(tittle:arrnotes[index].title ,desc: arrnotes[index].desc,notes_id: arrnotes[index].note_id,)));
                              },
                              onLongPress: (){
                                myDB.deleteNote(arrnotes[index].note_id!);
                                getnotes();
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: cardcolor,
                                  borderRadius: BorderRadius.only(topRight:Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                ),
                                width: double.infinity,
                                height:height[index % height.length],
                                child: Column(
                                  children: [
                                    Center(child: Text('${arrnotes[index].title}',style: TextStyle(
                                        fontSize: 20
                                    ),)),
                                    Expanded(child: Container(
                                        margin: EdgeInsets.only(top: 10,right: 3,left: 3,bottom: 5),
                                        child: Stack(children:[
                                          Text('${arrnotes[index].desc}',
                                            style: TextStyle(fontSize: 10),
                                            textAlign: TextAlign.center,),
                                          Align(alignment:Alignment(1,1),
                                              child: Text('${DateFormat('dd-MMMyy').format(time)}',
                                                style: TextStyle(backgroundColor:cardcolor,),))]))),
                                  ],
                                ),
                              ),
                            );
                        }
                    );
                  }else{
                    return Container(child:Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height:200,
                    width:200,
                    child: Image.asset('Assets/images/post-it.png')),
                        Text('No Data',style: TextStyle(fontSize: 18),),
                      ],
                    ),));
                  }

                }
              ),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton.extended(
          label:Text('Add new ',style: TextStyle(
              color: Colors.green
          ),),
          icon : Icon(Icons.edit_note_sharp,color: Colors.green,),
          backgroundColor: Color(0xFFECEFF5),
          onPressed: (
              ){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>Addnotes()));
          },
        ),
    );
  }

}