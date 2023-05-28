import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200155/pages/detail_weapon_page.dart';
import 'package:latihan_responsi_123200155/service/basenetwork.dart';

class WeaponPage extends StatefulWidget {
  const WeaponPage({super.key});

  @override
  State<WeaponPage> createState() => _WeaponPageState();
}

class _WeaponPageState extends State<WeaponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List Weapon")),
        body: Container(
          child: FutureBuilder(
              future: GenshinApi().getWeapon(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: Text("Tidak ada data")),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailWeaponPage(
                                        name:
                                            snapshot.data[index].toLowerCase()),
                                  ));
                            },
                            leading: Image.network(
                              'https://api.genshin.dev/weapons/${snapshot.data[index]}/icon',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(snapshot.data[index].toUpperCase()),
                          ),
                        );
                      });
                }
              }),
        ));
  }
}
