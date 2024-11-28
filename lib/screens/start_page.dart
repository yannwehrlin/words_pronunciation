import 'package:flutter/material.dart';
import 'package:words_pronunciation/screens/game_page.dart';

class StartPage extends StatelessWidget {
  final List<String> wordsList;
  final int timerCount;

  StartPage({super.key, required this.wordsList, required this.timerCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                wordsList: wordsList,
                timerCount: timerCount,
              ),
            ),
          );
        },
        child: const Text('Commencer le jeu'),
      ),
    );
  }
}
