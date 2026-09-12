import 'package:flutter/material.dart';

void main() {
  runApp(const StudyBuddyApp());
}

class StudyTask {
  StudyTask({
    required this.title,
    required this.subject,
    this.completed = false,
  });

  String title;
  String subject;
  bool completed;
}

class StudyBuddyApp extends StatelessWidget {
  const StudyBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StudyTask> tasks = [
    StudyTask(title: 'Learn Dart variables', subject: 'Dart'),
    StudyTask(title: 'Build a Flutter screen', subject: 'Flutter'),
    StudyTask(title: 'Practice widgets', subject: 'Flutter'),
  ];

  int get completedCount =>
      tasks.where((task) => task.completed).length;

  void toggleTask(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Add a task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Example: Practice buttons',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final title = controller.text.trim();

                if (title.isNotEmpty) {
                  setState(() {
                    tasks.add(
                      StudyTask(
                        title: title,
                        subject: 'Practice',
                      ),
                    );
                  });
                }

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final progress = total == 0 ? 0.0 : completedCount / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Buddy'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTask,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Hello, Developer! 👋',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Keep learning Dart and Flutter one small task at a time.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 10),
                  Text('$completedCount of $total tasks completed'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Study tasks',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...tasks.asMap().entries.map(
                (entry) => Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: entry.value.completed,
                      onChanged: (_) => toggleTask(entry.key),
                    ),
                    title: Text(
                      entry.value.title,
                      style: TextStyle(
                        decoration: entry.value.completed
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(entry.value.subject),
                    trailing: const Icon(Icons.school_outlined),
                  ),
                ),
              ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
