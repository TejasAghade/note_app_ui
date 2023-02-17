// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:note_app/providers/listProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({super.key, required this.isUpdate, this.note});
  final bool isUpdate;
  final NoteModel? note;
  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  
  TextEditingController _titleEditingController = new TextEditingController();
  TextEditingController _contentEditingController = new TextEditingController();
  FocusNode noteFocus = FocusNode();

   void addNewNote(){
    NoteModel newNote = NoteModel(
      id: const Uuid().v1(),
      userid: "exampleid@gmail.com",
      title: _titleEditingController.text,
      content: _contentEditingController.text,
      dateadded: DateTime.now()
    );

      Provider.of<NotesProvider>(context, listen: false).addNotes(newNote);
      Navigator.pop(context);
   }

   void updateNote(){
      widget.note!.title = _titleEditingController.text;
      widget.note!.content = _contentEditingController.text;
      Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
      Navigator.pop(context);
   }


  @override
  void initState() {
    super.initState();
    if(widget.isUpdate){
      _titleEditingController.text = widget.note!.title!;
      _contentEditingController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Note"),
        elevation: 1,
        shadowColor: Colors.cyan.shade200,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange.shade300,
        actions: [
          IconButton(
            onPressed: (){
              if(widget.isUpdate){
                // update
                updateNote();
              }else{
                // add
                addNewNote();
              }
            }, 
            icon: const Icon(Icons.check))
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: _titleEditingController,
                onSubmitted: (val){
                  if(val !=""){
                    noteFocus.requestFocus();
                  }
                },
                autofocus: (widget.isUpdate == true)? false: true,
                style: TextStyle(
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none
                ),
              ),
              
              Expanded(
                child: TextField(
                  controller: _contentEditingController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none
                  ),
                ),
              ), 
            ],
          ),
        ),
      ),
      
    );
  }
}