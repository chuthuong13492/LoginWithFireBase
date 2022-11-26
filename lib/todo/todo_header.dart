import 'package:app_todo/event/delete_todo_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_todo/bloc/todo_bloc.dart';
import 'package:app_todo/event/add_todo_event.dart';

class TodoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration:
                InputDecoration(labelText: 'Add todo', hintText: 'Add todo'),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        RaisedButton.icon(
          onPressed: () {
            bloc.event.add(AddTodoEvent(txtTodoController.text));
          },
          icon: Icon(Icons.add),
          label: Text('Add'),
        ),
      ],
    );
  }
}
