import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:student_firebase/model/student.dart';
import 'package:student_firebase/ui/student_screen.dart';
import 'package:student_firebase/ui/studentInformation_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _HomeScreenState extends State<HomeScreen> {
  List<Student> items;
  StreamSubscription<Event> _onStudentAddedSubscription;
  StreamSubscription<Event> _onStudentChangedSubscription;

@override
  void initState() {
    items = [];
    _onStudentAddedSubscription =
        studentReference.onChildAdded.listen(_onStudentAdded);
    _onStudentChangedSubscription =
        studentReference.onChildChanged.listen(_onStudentUpdated);
    super.initState();
  }

  dispose() {
    super.dispose();
    _onStudentAddedSubscription.cancel();
    _onStudentChangedSubscription.cancel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Students data"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Container(
          width: double.infinity,
            child: ListView.builder(
          itemBuilder: (context, position) {
            return Column(
              children: [
                Divider(
                  height: 6,
                ),
                SizedBox(
                  height: 300,
                  child:Center(
                      child: items[position].studentImage == ""
                          ? Text("no image")
                          :Image.network(items[position].studentImage)),
                ),
                Card(child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          "${items[position].name}",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                          ),
                        ),
                        subtitle: Text(
                          "${items[position].city}"
                              " - ${items[position].age}"
                              "- ${items[position].grade}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        leading:
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 18,
                          child: Text(
                            "${position+1}",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onTap: () =>
                            _navigateToStudentInformation(context, items[position]),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit_outlined),
                      onPressed: () =>
                          _navigateToStudent( items[position]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () =>
                          _deleteStudent(context, items[position], position),
                    )

                  ],
                ),),


              ],
            );
          },
          itemCount: items.length,
          padding: EdgeInsets.only(top: 12),
        )),
        floatingActionButton: FloatingActionButton(
          elevation: 50,
          backgroundColor: Colors.teal,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: ()=>_createNewStudent(),
        ),
    );
  }

  _createNewStudent()async {
    await Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentScreen(Student(null,"","","","","",""))));
  }

  _onStudentAdded(Event event) {
    setState(() {
      items.add(Student.fromSnapShot(event.snapshot));
    });
  }

  _onStudentUpdated(Event event) {
    var oldStudent =
    items.singleWhere((student) => student.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldStudent)] = Student.fromSnapShot(event.snapshot);
    });
  }
  _deleteStudent(BuildContext context, Student item, int position)async {
    await studentReference.child(item.id).remove().then((_){
      items.removeAt(position);
    }).then((_){
      setState(() {

      });
    } );
  }

  _navigateToStudent(Student student) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => StudentScreen(student)));
  }
  _navigateToStudentInformation(BuildContext context, Student student) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => StudentInfo(student)));
  }
}
