import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  final List<String> wordsList;
  final int timerCount;
  final Function(String) onAddWord;
  final Function(int) onDeleteWord;
  final Function(double) onTimerChanged;

  const AdminPage({
    super.key,
    required this.wordsList,
    required this.timerCount,
    required this.onAddWord,
    required this.onDeleteWord,
    required this.onTimerChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController wordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text('Timer: $timerCount secondes'),
          Slider(
            value: timerCount.toDouble(),
            min: 1,
            max: 20,
            onChanged: onTimerChanged,
          ),
          TextField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
              labelText: 'Entrer un mot',
            ),
            onSubmitted: (value) {
              onAddWord(value);
              wordController.clear();
            },
          ),
          const SizedBox(height: 20),
          const Text('Liste de mots:'),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: wordsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wordsList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      onDeleteWord(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
