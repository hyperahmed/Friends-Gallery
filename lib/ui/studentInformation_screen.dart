import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_firebase/model/student.dart';
import 'package:student_firebase/ui/student_screen.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';


 
class StudentInfo extends StatefulWidget {
  final Student student;

  StudentInfo(this.student);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentInfoState extends State<StudentInfo> {


  String stuImage;
  @override
  void initState() {
    stuImage  = widget.student.studentImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("student information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.all(30) ,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child:Center(
                    child: stuImage == ""? Text("no image"):Image.network(stuImage)),
                  ),
                Padding(padding:EdgeInsets.only(top:8)),
                Text("name: ${widget.student.name}",style:TextStyle(
                  fontSize: 16,
                ),),
                Padding(padding:EdgeInsets.only(top:8)),
                Text("age: ${widget.student.age}",style:TextStyle(
                  fontSize: 16,
                ),),
                Padding(padding:EdgeInsets.only(top:8)),
                Text("city: ${widget.student.city}",style:TextStyle(
                  fontSize: 16,
                ),),
                Padding(padding:EdgeInsets.only(top:8)),
                Text("grade: ${widget.student.grade}",style:TextStyle(
                  fontSize: 16,
                ),),
                Padding(padding:EdgeInsets.only(top:8)),
                Text("degree: ${widget.student.degree}",style:TextStyle(
                  fontSize: 16,
                ),),
                Padding(padding:EdgeInsets.only(top:8)),

              ],
            )),
      ),
    );
  }
}
