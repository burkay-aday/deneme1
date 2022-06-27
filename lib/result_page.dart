import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yasam_beklentisi/constants.dart';
import 'package:yasam_beklentisi/user_data.dart';

class ResultPage extends StatefulWidget {
  UserData _userData = UserData();
  ResultPage(this._userData);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? kullanici;

  @override
  Widget build(BuildContext context) {
    var liste = widget._userData.liste!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuc Sayfasi'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(50),
              margin: EdgeInsets.all(10),
              child: Text(
                'Ortalam yasam suresi : ${Hesap().round().toString()}     ',
                style: kMetinStili,
              ),
            ),
            flex: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.add_circle),
                color: Colors.black,
                splashRadius: 30,
                iconSize: 35,
                padding: EdgeInsets.all(30),
                highlightColor: Colors.red,
                onPressed: () {
                  showDialogforAdd();
                },
              ),
            ],
          ),
          Expanded(
            flex: 30,
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: liste.snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot asyncSnapshot) {
                      List<DocumentSnapshot> listofdocuments =
                          asyncSnapshot.data.docs;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: listofdocuments.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 25),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: ListTile(
                                    title: Text('Kullanici ${index + 1}',
                                        style: TextStyle(color: Colors.black)),
                                    subtitle: Text(
                                        '${listofdocuments[index].data()}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            showDialogWithFields();
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            await listofdocuments[index]
                                                .reference
                                                .delete();
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            showDialogforAdd();
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Geri Dön:', style: kMetinStili),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double Hesap() {
    Random random = Random();
    if (widget._userData.seciliCinsiyet == 'ERKEK') {
      var sonuc = random.nextInt(30) +
          70 -
          widget._userData.icilenSigara! +
          widget._userData.yapilanSpor!;
      return sonuc;
    } else {
      var sonuc = random.nextInt(30) +
          70 -
          widget._userData.icilenSigara! +
          widget._userData.yapilanSpor!;
      return sonuc;
    }
  }

  void showDialogWithFields() {
    var liste = widget._userData.liste!;
    showDialog(
      context: context,
      builder: (_) {
        TextEditingController nameeditor = TextEditingController();
        TextEditingController sigaraeditor = TextEditingController();
        TextEditingController boyeditor = TextEditingController();
        TextEditingController kiloeditor = TextEditingController();
        TextEditingController sporeditor = TextEditingController();
        return AlertDialog(
          content: Container(
            height: 200,
            width: 200,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: boyeditor,
                  decoration: InputDecoration(hintText: 'Boyu Güncelle'),
                ),
                TextFormField(
                  controller: kiloeditor,
                  decoration: InputDecoration(hintText: 'Kiloyu Güncelle'),
                ),
                TextFormField(
                  controller: sigaraeditor,
                  decoration:
                      InputDecoration(hintText: 'İcilen sigarayi Güncelle'),
                ),
                TextFormField(
                  controller: sporeditor,
                  decoration:
                      InputDecoration(hintText: 'Haftalik Spor Sayisini'),
                ),
                TextFormField(
                  controller: nameeditor,
                  decoration: InputDecoration(hintText: 'İsimi güncelle'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Map<String, dynamic> yasamData = {
                  'name': nameeditor.text,
                  'boy': boyeditor.text,
                  'kilo': kiloeditor.text,
                  'spor': sporeditor.text,
                  'sigara': sigaraeditor.text
                };
                liste.doc().update(yasamData);

                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void showDialogforAdd() {
    var liste = widget._userData.liste!;
    showDialog(
      context: context,
      builder: (_) {
        TextEditingController nameadder = TextEditingController();
        TextEditingController sigaraadder = TextEditingController();
        TextEditingController boyadder = TextEditingController();
        TextEditingController kiloadder = TextEditingController();
        TextEditingController sporadder = TextEditingController();
        return AlertDialog(
          content: Container(
            height: 200,
            width: 200,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: boyadder,
                  decoration: InputDecoration(hintText: 'Yeni Boy'),
                ),
                TextFormField(
                  controller: kiloadder,
                  decoration: InputDecoration(hintText: 'Yeni Kilo'),
                ),
                TextFormField(
                  controller: sigaraadder,
                  decoration: InputDecoration(hintText: 'Yeni Sigara'),
                ),
                TextFormField(
                  controller: sporadder,
                  decoration: InputDecoration(hintText: 'Yeni Spor'),
                ),
                TextFormField(
                  controller: nameadder,
                  decoration: InputDecoration(hintText: 'Yeni İsim'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Map<String, dynamic> yasamData = {
                  'id': DateTime.now().toString(),
                  'name': nameadder.text,
                  'boy': boyadder.text,
                  'kilo': kiloadder.text,
                  'spor': sporadder.text,
                  'sigara': sigaraadder.text
                };
                liste.doc().set(yasamData);

                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }
}
