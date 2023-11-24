// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Champion {
  final String name;
  String? imageUrl;
  String? title;
  String? partype;
  String? lore;
  String? fullart;

  List<String> tags = [];
  List<String> spellNames = [];
  List<String> spellIds = [];

  String? qhabilityimg;
  String? ehabilityimg;
  String? whabilityimg;
  String? rhabilityimg;

  String? qdesc;
  String? edesc;
  String? wdesc;
  String? rdesc;

  int? rating = 10;

  Champion(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      var uri = Uri.https('ddragon.leagueoflegends.com',
          '/cdn/13.21.1/data/en_US/champion/$name.json');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = json.decode(responseBody);
      Map<String, dynamic> championData = data['data'][name];

      if (championData != null) {
        title = championData['title'];
        partype = championData['partype'];
        lore = championData['lore'];
        imageUrl =
            'https://ddragon.leagueoflegends.com/cdn/13.21.1/img/champion/$name.png';
        fullart =
            'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/$name'
            '_0.jpg';

        tags = List<String>.from(championData['tags']);

        for (var i = 0; i < championData['spells'].length; i++) {
          var spell = championData['spells'][i];
          spellNames.add(spell['name']);
          spellIds.add(spell['id']);

          // Store spell descriptions
          switch (i) {
            case 0:
              qdesc = spell['description'];
              qdesc = qdesc!.replaceAll(RegExp(r'<br>'), '\n');
              break;
            case 1:
              wdesc = spell['description'];
              wdesc = wdesc!.replaceAll(RegExp(r'<br>'), '\n');
              break;
            case 2:
              edesc = spell['description'];
              edesc = edesc!.replaceAll(RegExp(r'<br>'), '\n');
              break;
            case 3:
              rdesc = spell['description'];
              rdesc = rdesc!.replaceAll(RegExp(r'<br>'), '\n');
              break;
            default:
              break;
          }
        }

        qhabilityimg =
            'https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/${spellIds[0]}.png';
        whabilityimg =
            'https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/${spellIds[1]}.png';
        ehabilityimg =
            'https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/${spellIds[2]}.png';
        rhabilityimg =
            'https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/${spellIds[3]}.png';
      }
    } catch (exception) {
      // Handle the exception or print it for debugging
    }
  }
}
