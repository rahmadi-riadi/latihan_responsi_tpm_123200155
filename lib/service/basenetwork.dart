import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi_123200155/model/model_karakter.dart';
import 'package:latihan_responsi_123200155/model/model_weapon.dart';

class GenshinApi {
  Future<List<dynamic>> getKarakter() async {
    var url = Uri.parse('https://api.genshin.dev/characters');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<List<dynamic>> getWeapon() async {
    var url = Uri.parse('https://api.genshin.dev/weapons');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<ModelKarakter> getDetailKarakter(String name) async {
    var url = Uri.parse('https://api.genshin.dev/characters/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return ModelKarakter.fromJson(data);
  }

  Future<ModelWeapon> getDetailWeapon(String name) async {
    print(name);
    var url = Uri.parse('https://api.genshin.dev/weapons/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return ModelWeapon.fromJson(data);
  }
}
