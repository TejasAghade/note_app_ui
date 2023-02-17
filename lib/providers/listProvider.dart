import 'package:flutter/cupertino.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:note_app/services/api_services.dart';

class NotesProvider with ChangeNotifier{

  bool isLoading = true;

  List<NoteModel> notes = [];
  NotesProvider(){
    fetchNotes();
  }
  addNotes(NoteModel note){
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  updateNote(NoteModel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
     ApiService.addNote(note);
  }

  deleteNote(NoteModel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
     ApiService.deleteNote(note);
  }


  void fetchNotes() async{
    notes = await ApiService.fetchNotes("exampleid@gmail.com");
    // notes = allNotes;
    isLoading = false;
    notifyListeners();
  }


}