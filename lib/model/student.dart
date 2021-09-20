import 'package:firebase_database/firebase_database.dart';

class Student{
  String _id;
  String _name;
  String _age;
  String _city;
  String _grade;
  String _degree;
  String _studentImage;


  Student(
      this._id,
      this._name,
      this._age,
      this._city,
      this._grade,
      this._degree,
      this._studentImage);


  Student.map(dynamic obj){
    this._id = obj["id"];
    this._name = obj["name"];
    this._age = obj["age"];
    this._city = obj["city"];
    this._grade = obj["grade"];
    this._degree = obj["degree"];
    this._studentImage = obj["studentImage"];
  }



  String get id => _id;
  String get name => _name;
  String get age => _age;
  String get city => _city;
  String get grade => _grade;
  String get degree => _degree;
  String get studentImage => _studentImage;


Student.fromSnapShot(DataSnapshot snapshot){
  _id = snapshot.key;
  _name = snapshot.value['name'];
  _age = snapshot.value['age'];
  _city = snapshot.value['city'];
  _grade = snapshot.value['grade'];
  _degree = snapshot.value['degree'];
  _studentImage = snapshot.value['studentImage'];

}


}
