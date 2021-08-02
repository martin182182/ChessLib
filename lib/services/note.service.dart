import 'dart:convert';

import 'package:navbar/models/note.model.dart';
import 'package:http/http.dart' as http;

class NoteS{
  Future<List<NoteM>> getNotes(String gameID) async {

    List<NoteM> notes = [];
    final res = await http.get(Uri.parse("http://192.168.100.5:3000/listNotes/"+gameID));
    if(res.statusCode == 200){
      String body = utf8.decode(res.bodyBytes);
      final jsonData = json.decode(body);
      for(var item in jsonData["notes"]){
        final note = NoteM.fromJson(item);
        notes.add(note);
      }
      return notes;
    }else{
      throw Exception('Error');
    }
  }

  Future<dynamic> createNotes(NoteM note) async {

    final Map<String, String> _headers = {"content-type": "application/json"};
    final res = await http.post(Uri.parse("http://192.168.100.5:3000/saveNote"), headers: _headers, body: noteMToJson(note));
    if(res.body.isEmpty) return null;
    return json.decode(res.body);
  }
}