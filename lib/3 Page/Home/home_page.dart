import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: const SizedBox(),
      ),
      body: const TaskList(),
    );
  }
}
