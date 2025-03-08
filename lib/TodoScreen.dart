import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Map<String, dynamic>> tasks = [];
  bool showActiveTasks = true;
/////////////////////////////////////////////////////////////// all functions
  void _showTaskDialog({int? index}) {
    TextEditingController _taskController = TextEditingController(
      text: index != null ? tasks[index]['task'] : '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index != null ? 'Edit task' : 'Add tasks'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(
            hintText: 'Enter task',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () {
                if (_taskController.text.trim().isNotEmpty) {
                  if (index != null) {
                    _editTask(index, _taskController.text);
                  } else {
                    _addTask(_taskController.text);
                  }
                }
                Navigator.pop(context);
              },
              child: Text('Save')),
        ],
      ),
    );
  }

  void _addTask(String task) {
    setState(() {
      tasks.add({
        'task': task,
        'completed': false,
      });
      Navigator.pop(context);
    });
  }

  void _editTask(int index, String updateTask) {
    setState(() {
      tasks[index]['task'] = updateTask;
    });
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  int get activeCount => tasks.where((task) => !task['completed']).length;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxSquare = screenWidth * 0.46;
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: boxSquare,
                    height: boxSquare,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Active Task',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${activeCount}',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    alignment: Alignment.topCenter,
                    width: boxSquare,
                    height: boxSquare,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Completed',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${tasks.length - activeCount}',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  //itemExtent: boxSquare,
                  scrollDirection:
                      showActiveTasks ? Axis.vertical : Axis.horizontal,
                  reverse: !showActiveTasks,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(UniqueKey().toString()),
                      background: Container(
                        color: Colors.green.shade100,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green,
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red.shade100,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          _toggleTask(index);
                        } else {
                          _deleteTask(index);
                        }
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            tasks[index]['task'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: tasks[index]['completed']
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontStyle: tasks[index]['completed']
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              color: tasks[index]['completed']
                                  ? Colors.grey.shade400
                                  : Colors.black,
                            ),
                          ),
                          onTap: () => _toggleTask(index),
                          leading: Icon(
                            tasks[index]['completed']
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: tasks[index]['completed']
                                ? Colors.green.shade200
                                : Colors.blue,
                          ),
                          trailing: IconButton(
                            onPressed: tasks[index]['completed']
                                ? () {}
                                : () => _showTaskDialog(index: index),
                            icon: Icon(
                              tasks[index]['completed']
                                  ? Icons.edit_off_rounded
                                  : Icons.edit,
                              color: tasks[index]['completed']
                                  ? Colors.grey.shade200
                                  : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
