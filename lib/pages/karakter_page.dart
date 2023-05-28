import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200155/pages/detail_karakter_page.dart';
import 'package:latihan_responsi_123200155/service/basenetwork.dart';

class KarakterPage extends StatefulWidget {
  const KarakterPage({super.key});

  @override
  State<KarakterPage> createState() => _KarakterPageState();
}

class _KarakterPageState extends State<KarakterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List Karakter")),
        body: Container(
          child: FutureBuilder(
              future: GenshinApi().getKarakter(),
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
                                    builder: (context) => DetailKarakterPage(
                                        name:
                                            snapshot.data[index].toLowerCase()),
                                  ));
                            },
                            leading: Image.network(
                              'https://api.genshin.dev/characters/${snapshot.data[index]}/icon',
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
