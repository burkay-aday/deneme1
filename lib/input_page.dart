import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yasam_beklentisi/result_page.dart';
import 'package:yasam_beklentisi/user_data.dart';

import 'Classes.dart';
import 'constants.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String? seciliCinsiyet;
  double icilenSigara = 0.0;
  double yapilanSpor = 0.0;
  int boy = 170;
  int kilo = 50;

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YAŞAM BEKLENTİSİ',
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: MyContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text('Boy', style: kMetinStili),
                        ),
                        RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              boy.toString(),
                              style: kSayiStili,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonTheme(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                child: Icon(FontAwesomeIcons.plus),
                                onPressed: () {
                                  setState(() {
                                    boy++;
                                  });
                                },
                              ),
                            ),
                            ButtonTheme(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                child: Icon(FontAwesomeIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    boy--;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MyContainer(
                    child: buildRowOutlineButton(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Haftada kac gun spor yapiyorsunuz?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${yapilanSpor.round()}',
                    style: kSayiStili,
                  ),
                  Slider(
                    min: 0,
                    max: 7,
                    onChanged: (double newValue) {
                      setState(() {
                        yapilanSpor = newValue;
                      });
                    },
                    value: yapilanSpor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MyContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kac Sigara İciyorsunuz?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${icilenSigara.round()}',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    min: 0,
                    max: 30,
                    onChanged: (double newValue) {
                      setState(() {
                        icilenSigara = newValue;
                      });
                    },
                    value: icilenSigara,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seciliCinsiyet = 'KADIN';
                      });
                    },
                    child: MyContainer(
                        renk: seciliCinsiyet == 'KADIN'
                            ? Colors.blue
                            : Colors.white,
                        child: IconCinsiyet(
                          cinsiyet: 'KADIN',
                          icon: FontAwesomeIcons.venus,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seciliCinsiyet = 'ERKEK';
                      });
                    },
                    child: MyContainer(
                        renk: seciliCinsiyet == 'ERKEK'
                            ? Colors.blue
                            : Colors.white,
                        child: IconCinsiyet(
                          icon: FontAwesomeIcons.mars,
                          cinsiyet: 'ERKEK',
                        )),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: Size(30, 50),
            ),
            onPressed: () async {
              CollectionReference KullanicilarCollectionRef =
                  FirebaseFirestore.instance.collection('Kullanicilar');
              KullanicilarCollectionRef.add({
                'sigara': '${icilenSigara.round().toString()}',
                'boy': '${boy.round()}',
                'kilo': '${kilo.round()}',
                'cinsiyet': '$seciliCinsiyet',
                'spor': '${yapilanSpor.round()}'
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(UserData(
                            kilo: kilo,
                            boy: boy,
                            seciliCinsiyet: seciliCinsiyet,
                            yapilanSpor: yapilanSpor,
                            icilenSigara: icilenSigara,
                            liste: KullanicilarCollectionRef,
                          ))));
            },
            child: Text(
              'HESAPLA  ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRowOutlineButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Text('Kilo', style: kMetinStili),
        ),
        RotatedBox(
            quarterTurns: 3,
            child: Text(
              kilo.toString(),
              style: kSayiStili,
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Icon(FontAwesomeIcons.plus),
                onPressed: () {
                  setState(() {
                    kilo++;
                  });
                },
              ),
            ),
            ButtonTheme(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                child: Icon(FontAwesomeIcons.minus),
                onPressed: () {
                  setState(() {
                    kilo--;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
