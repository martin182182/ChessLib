import 'dart:convert';

import 'package:chess_lib/models/tournament.model.dart';
import 'package:http/http.dart' as http;

class TournamentS{
  Future<List<TournamentM>> getTournaments() async {
    List<TournamentM> tournaments = [];
    final url = Uri.parse("http://192.168.100.5:3000/api/list");
    final res = await http.get(url);
    if(res.statusCode==200){
      final jsonData = json.decode(res.body);
      
    }
    return tournaments; 
  } 
}