import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ass/app_provider.dart';
import 'package:provider_ass/db_helper.dart';
import 'package:provider_ass/task_model.dart';

class TaskWidget extends StatelessWidget {
  Task2 task;
  Function function;
  TaskWidget(this.task, [this.function]);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<AppProvider>(
              builder: (context, v, child) {
                return IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // set up the buttons
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          v.list.remove(Task2(
                              taskName: this.task.taskName,
                              isComplete: this.task.isComplete));
                          DBHelper.dbHelper.deleteTask(Task2(
                              taskName: this.task.taskName,
                              isComplete: this.task.isComplete));
                          Navigator.of(context).pop();
                          v.notify();
                          this.function();
                        },
                      );
                      Widget noButton = FlatButton(
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Alert"),
                        content: Text("You will delete a task,are you sure?"),
                        actions: [
                          okButton,
                          noButton,
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    });
              },
            ),
            Text(this.task.taskName),
            Consumer<AppProvider>(
              builder: (context, v, child) {
                return Checkbox(
                    value: this.task.isComplete,
                    onChanged: (value) {
                      DBHelper.dbHelper.updateTask(Task2(
                          taskName: this.task.taskName, isComplete: value));
                      this.task.isComplete = this.task.isComplete;
                      v.notify();
                      this.function();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
