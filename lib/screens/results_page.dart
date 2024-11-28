import 'package:flutter/material.dart';
import 'package:words_pronunciation/models/played_word.dart';

class ResultsPage extends StatelessWidget {
  final List<PlayedWord> playedWords;

  ResultsPage({super.key, required this.playedWords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: playedWords.length,
              itemBuilder: (context, index) {
                final playedWord = playedWords[index];

                return ListTile(
                    title: Text(playedWord.word),
                    trailing: Icon(
                      playedWord.isCorrect ? Icons.check : Icons.close,
                      color: playedWord.isCorrect ? Colors.green : Colors.red,
                    ));
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to the first tab
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }
}
