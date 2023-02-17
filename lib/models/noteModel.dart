import 'dart:convert';

// List<NoteModel?>? noteModelFromJson(String str) => json.decode(str) == null ? [] : List<NoteModel?>.from(json.decode(str)!.map((x) => NoteModel.fromJson(x)));

// String noteModelToJson(List<NoteModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class NoteModel {
    NoteModel({
        this.id,
        this.userid,
        this.title,
        this.content,
        this.dateadded,
    });

    String? id;
    String? userid;
    String? title;
    String? content;
    DateTime? dateadded;

    // factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    //     id: json["id"],
    //     userid: json["userid"],
    //     title: json["title"],
    //     content: json["content"],
    //     dateadded: json["dateadded"],
    // );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "userid": userid,
    //     "title": title,
    //     "content": content,
    //     "dateadded": dateadded,
    // };

    factory NoteModel.fromMap(Map<String, dynamic> map){
        return NoteModel(
          id : map['id'],
          userid: map['userid'],
          title: map['title'],
          content: map['content'],
          dateadded: DateTime.tryParse(map['dateadded'])
        );
    } 

    Map<String, dynamic> toMap(){
      return {
        "id": id,
        "userid": userid,
        "title": title,
        "content": content,
        "dateadded": dateadded!.toIso8601String(),
      };
    }

}
