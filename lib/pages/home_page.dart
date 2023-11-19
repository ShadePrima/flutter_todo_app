import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/dialo_box.dart';
import 'package:flutter_todo_app/components/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//refetence the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openig the app,
    //then create default date

    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //there already exist data
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controler = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    final String taskName = _controler.text.trim();

    if (taskName.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controler.text, false]);
        _controler.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    } else {
      Navigator.of(context).pop();
    }
  }

  //create a new task
  void createNewTask() {
    _controler.clear();

    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controler: _controler,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //edit task
  void editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controler: _controler
            ..text = db.toDoList[index][0], // set initial text
          onSave: () {
            setState(() {
              db.toDoList[index][0] =
                  _controler.text.trim(); // update task name
              _controler.clear();
            });
            Navigator.of(context).pop();
            db.updateDataBase();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[300],
        appBar: AppBar(
          backgroundColor: Colors.yellow[600],
          title: const Center(child: Text('TO DO')),
          elevation: 0,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60, right: 20),
          child: FloatingActionButton(
            backgroundColor: Colors.yellow[600],
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              editFunction: (context) => editTask(index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
