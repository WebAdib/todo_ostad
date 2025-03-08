import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add Todo functionality here
              },
              child: Text('Add Todo'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20, // Replace with actual number of todos
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Todo $index'),
                    onTap: () {
                      // Todo item clicked functionality here
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Clear Todos functionality here
        },
        tooltip: 'Clear Todos',
        child: Icon(Icons.clear),
      ),
    );
  }
}
