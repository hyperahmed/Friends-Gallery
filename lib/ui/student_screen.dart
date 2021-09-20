
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_firebase/model/student.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';



class StudentScreen extends StatefulWidget {
  final Student student;

  StudentScreen(this.student);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentScreenState extends State<StudentScreen> {
  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _cityController;
  TextEditingController _gradeController;
  TextEditingController _degreeeController;

  ImagePicker _picker = ImagePicker();
  XFile image;
  Cpicker()async{

    // XFile img = await _picker.pickImage(source: ImageSource.gallery);
    XFile img = await _picker.pickImage(source: ImageSource.camera);
    if(img != null){
      image = img ;
      setState(() {


      });
    }

  }
  Gpicker()async{

    // XFile img = await _picker.pickImage(source: ImageSource.gallery);
    XFile img = await _picker.pickImage(source: ImageSource.gallery);
    if(img != null){
      image = img ;
      setState(() {


      });
    }

  }


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _cityController = TextEditingController(text: widget.student.city);
    _gradeController = TextEditingController(text: widget.student.grade);
    _degreeeController = TextEditingController(text: widget.student.degree);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("student db"),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Column(
              children: [

                TextButton(
                  onPressed: Gpicker,
                  child: image == null? Text("select a photo from gallery ☺"): Image.file(

                        File(image.path),fit: BoxFit.fitWidth,
                    height:300 ,),
                  ),
                Padding(padding:EdgeInsets.only(top:8)),

                TextField(
                  controller: _nameController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "name",
                  ),
                ),
                Padding(padding:EdgeInsets.only(top:8)),
                TextField(
                  controller: _ageController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.timelapse),
                    labelText: "age",
                  ),
                ),
                Padding(padding:EdgeInsets.only(top:8)),
                TextField(
                  controller: _cityController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                    labelText: "city",
                  ),
                ),
                Padding(padding:EdgeInsets.only(top:8)),
                TextField(
                  controller: _gradeController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.school),
                    labelText: "grade",
                  ),
                ),
                Padding(padding:EdgeInsets.only(top:8)),
                TextField(
                  controller: _degreeeController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.collections_bookmark_outlined),
                    labelText: "degree",
                  ),
                ),
                Padding(padding:EdgeInsets.only(top:8)),
                TextButton(
                  child: (widget.student.id != null)?Text("update"):Text("Add"),
                  onPressed: () async {
                    if(widget.student.id != null){


                      var now = formatDate(DateTime.now(),[yyyy,"-",'mm',"-",dd]);
                      var fullImageName = 'images/${_nameController.text}$now'+'.jpg';
                      // var fullImageName2 = 'images%2F${_nameController.text}$now'+'.jpg';
///////////////////////////////////////////////////////////////////////////////////


                      Reference storageReference =
                      FirebaseStorage.instance.ref().child(fullImageName);

                      print('uploading..');
                      UploadTask uploadTask = storageReference.putFile(File(image.path));

                      //waiting for the image to upload
                      await uploadTask.whenComplete((){
                        print('File Uploaded');
                        storageReference.getDownloadURL().then((fileURL) {
                          print(fileURL);
                          studentReference.child(widget.student.id).set({
                            'name': _nameController.text,
                            'age': _ageController.text,
                            'city': _cityController.text,
                            'grade': _gradeController.text,
                            'degree': _degreeeController.text,
                            'studentImage':fileURL
                        });
                      });
// ////////////////////////////////////////////////////
//                       final Reference ref = FirebaseStorage
//                           .instance.ref()
//                           .child(fullImageName);
//                       final UploadTask task = ref.putFile(File(image.path));
//                       await task.whenComplete(() => null);
//
//
//                       var part1 = 'https://firebasestorage.googleapis.com/v0/b/studentsdbtest.appspot.com/o/';
//                       var fullPathImage = part1 + fullImageName2;
/////////////////////////////////////////////////////////////////////////////////////////



                      }).then((_){
                        Navigator.pop(context);
                      });

                    }else{

                      var now = formatDate(DateTime.now(),[yyyy,"-",'mm',"-",dd]);
                      var fullImageName = 'images/${_nameController.text}$now'+'.jpg';


                      Reference storageReference =
                      FirebaseStorage.instance.ref().child(fullImageName);

                      print('uploading..');
                      UploadTask uploadTask = storageReference.putFile(File(image.path));
                      //waiting for the image to upload
                      await uploadTask.whenComplete((){
                        print('File Uploaded');
                        storageReference.getDownloadURL().then((fileURL) {
                          print(fileURL);
                          studentReference.push().set({
                            'name': _nameController.text,
                            'age': _ageController.text,
                            'city': _cityController.text,
                            'grade': _gradeController.text,
                            'degree': _degreeeController.text,
                            'studentImage':fileURL
                        });
                      });



                      }).then((_){
                        Navigator.pop(context);
                      });

                    }
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.camera),
        onPressed: Cpicker,

      ),
    );



  }

}
