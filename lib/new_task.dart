import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ass/app_provider.dart';
import 'package:provider_ass/db_helper.dart';
import 'package:provider_ass/task_model.dart';

class NewTask extends StatelessWidget {
  bool isComplete = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Consumer<AppProvider>(builder: (context, v, child) {
              return Checkbox(
                  value: isComplete,
                  onChanged: (value) {
                    this.isComplete = value;
                    v.notify();
                  });
            }),
            Consumer<AppProvider>(
              builder: (context, v, child) {
                return RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Add New Task',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      v.list.add(Task2(
                          taskName: this.taskName,
                          isComplete: this.isComplete));
                      DBHelper.dbHelper.insertNewTask(Task2(
                          taskName: this.taskName,
                          isComplete: this.isComplete));
                      Navigator.pop(context);
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
