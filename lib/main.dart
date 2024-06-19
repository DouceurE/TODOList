




import 'package:flutter/material.dart';
import 'package:flutter_layout/models/task.dart'; // Import task model first
import 'Nouvelle_tache.dart'; // Import NouvelleTache after task model

enum TaskStatus { todo, inProgress, done, bug }

class Task {
  final String title;
  final String description;
  final TaskStatus status;

  Task(this.title, this.description, this.status);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Task> _tasks = [
    Task('Buy groceries', 'Milk, eggs, fruits', TaskStatus.todo),
    Task('Finish report', 'Results and conclusion section', TaskStatus.inProgress),
    Task('Fix UI bug', 'Navigation issue', TaskStatus.bug),
  ];

  String _selectedStatus = TaskStatus.values.first.toString(); // Default to todo
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _addTask() async {
    final nouvelleTache = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NouvelleTache()),
    );

    if (nouvelleTache != null) {
      setState(() {
        _tasks.add(Task(
          nouvelleTache.title,
          nouvelleTache.description,
          nouvelleTache.status, // Use the retrieved status from NouvelleTache
        ));
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _showDialog(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Item'),
          content: Text(item),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  List<Task> _filteredTasks() {
    if (_selectedStatus == TaskStatus.values.first.toString()) {
      return _tasks; // Show all tasks
    } else {
      return _tasks
          .where((task) => task.status.toString() == _selectedStatus)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List with Filters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
          actions: [
            DropdownButton<String>(
              value: _selectedStatus,
              items: TaskStatus.values
                  .map((status) => DropdownMenuItem<String>(
                        value: status.toString(),
                        child: Text(status.toString().split('.').last), // Extract status name
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTasks().length,
                itemBuilder: (context, index) {
                  final task = _filteredTasks()[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                    onTap: () => _showDialog(task.title),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: 'Enter task title...'),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                     

controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(hintText: 'Enter task description...'),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.add),
                  onPressed: () async {
  final nouvelleTache = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NouvelleTache()),
  );
  if (nouvelleTache != null) {
    setState(() {
      _tasks.add(nouvelleTache);
    });
  }
},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

