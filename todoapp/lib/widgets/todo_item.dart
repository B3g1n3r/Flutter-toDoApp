import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class TodoLists extends StatelessWidget {
  final ToDo todo;
  final todoTracker;
  final onDelete;
  const TodoLists(
      {Key? key,
      required this.todo,
      required this.todoTracker,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          todoTracker(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone == true ? Icons.check_box : Icons.check_box_outline_blank,
          color: const Color.fromARGB(255, 68, 168, 255),
        ),
        title: Text(
          todo.todoText.toString(),
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            decoration: todo.isDone == true ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 50,
            width: 35,
            decoration: BoxDecoration(
              
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.delete),
              iconSize: 18,
              color: Colors.black,
              onPressed: () {
                onDelete(todo.id);
              },
            )),
      ),
    );
  }
}
