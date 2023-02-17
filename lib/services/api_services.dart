import 'dart:convert';
import 'dart:developer';

import 'package:note_app/models/noteModel.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static String _baseUrl ="https://note-app-i63o.onrender.com/notes/";

  static Future<void> addNote(NoteModel note) async{
    Uri requestUri = Uri.parse(_baseUrl+"/add");
    var response = await http.post(requestUri,body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());

  }

  static Future<void> deleteNote(NoteModel note) async{
    Uri requestUri = Uri.parse(_baseUrl+"/delete");
    var response = await http.post(requestUri,body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());

  }


  static Future<List<NoteModel>> fetchNotes(String userid) async{
    Uri requestUri = Uri.parse(_baseUrl+"/list");
    var response = await http.post(requestUri, body: {"userid":userid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString()); 
    
    List<NoteModel> notes = [];

    for(var noteMap in decoded){
      NoteModel newNote = NoteModel.fromMap(noteMap);
      notes.add(newNote);
    }
    
    return notes;

  }
  


}