// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:note_app/providers/listProvider.dart';
import 'package:note_app/screens/addNewNotePage.dart';
import 'package:provider/provider.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {

 

  @override
  Widget build(BuildContext context) {

    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text("Note App"),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.cyan.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange.shade300,
      ),
      body: (!notesProvider.isLoading)? SafeArea(
        child: (notesProvider.notes.length>0)? ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index){

            NoteModel currentNote = notesProvider.notes[index];

            return GestureDetector(
              onTap: (){
                Navigator.push(context, 
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context)=>AddNewNotePage(isUpdate: true, note: currentNote,)
                  )
                );
              },
              onLongPress: (){
                notesProvider.deleteNote(currentNote);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal:12, vertical: 12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 234, 232),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentNote.title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    SizedBox(
                      height: 5,
                    ),
                    Text(currentNote.content!, style: TextStyle(color: Colors.blueGrey.shade700), maxLines: 4,overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            );
        }) : Center(child: Text("No notes to display")),
      ): Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        onPressed: (){
          Navigator.push(context, 
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context)=>AddNewNotePage(isUpdate: false,))
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}