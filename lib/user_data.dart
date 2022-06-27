import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? seciliCinsiyet;
  double? icilenSigara;
  double? yapilanSpor;
  int? kilo;
  int? boy;
  CollectionReference? liste;
  UserData(
      {this.seciliCinsiyet,
      this.icilenSigara,
      this.yapilanSpor,
      this.kilo,
      this.boy,
      this.liste});
}
