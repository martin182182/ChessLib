import 'dart:convert';

TournamentM tournamentFromJson(String str) => TournamentM.fromJson(json.decode(str));

String tournamentToJson(TournamentM data) => json.encode(data.toJson());

class TournamentM {
    TournamentM({
        required this.name,
        required this.city,
        required this.prize,
        required this.description,
    });

    String name;
    String city;
    String prize;
    String description;

    factory TournamentM.fromJson(Map<String, dynamic> json) => TournamentM(
        name: json["name"],
        city: json["city"],
        prize: json["prize"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "prize": prize,
        "description": description,
    };
}
