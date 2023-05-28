import 'dart:math';
import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200155/pages/detail_karakter_page.dart';
import 'package:latihan_responsi_123200155/pages/detail_weapon_page.dart';
import 'package:latihan_responsi_123200155/pages/karakter_page.dart';
import 'package:latihan_responsi_123200155/pages/weapon_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _lastSeen;
  String? _category;

  Future<void> _getLastSeen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _lastSeen = pref.getString("last_seen");
      _category = pref.getString("category");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lastSeen = "";
    _category = "";
    _getLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 80),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_lastSeen != null && _lastSeen != "")
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Card(
                      child: ListTile(
                    onTap: () async {
                      if (_category == "characters") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailKarakterPage(name: _lastSeen!),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailWeaponPage(name: _lastSeen!),
                            ));
                      }
                    },
                    leading: Image.network(
                        'https://api.genshin.dev/${_category}/${_lastSeen!.toLowerCase()}/icon'),
                    title: Text(_lastSeen.toString().toUpperCase()),
                  )),
                ),
              Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KarakterPage(),
                            ));
                        _getLastSeen();
                      },
                      child: Text("Karakter"))),
              Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeaponPage(),
                            ));
                        _getLastSeen();
                      },
                      child: Text("Weapon"))),
            ],
          )),
    );
  }
}
