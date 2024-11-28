import 'dart:async';

import 'package:flutter/material.dart';
import 'package:words_pronunciation/models/played_word.dart';
import 'package:words_pronunciation/screens/results_page.dart';
import 'package:words_pronunciation/widgets/buttons.dart';

class GamePage extends StatefulWidget {
  final List<String> wordsList;
  final int timerCount;

  GamePage({required this.wordsList, required this.timerCount});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<PlayedWord> playedWords = [];
  int currentIndex = 0;
  late DateTime startTime;
  late Timer countdownTimer;

  @override
  void initState() {
    startTime = DateTime.now();
    super.initState();
    // Delay the start of the timer by 1 second
    Future.delayed(const Duration(milliseconds: 500), startGame);
  }

  void startGame() {
    startTime = DateTime.now();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsedTime = DateTime.now().difference(startTime).inSeconds;
      final remainingTime = widget.timerCount - elapsedTime;
      if (remainingTime <= 0) {
        timer.cancel();
        // Time's up, handle wrong answer
        handleAnswer(false);
      } else {
        if (mounted) setState(() {});
      }
    });
  }

  void handleAnswer(bool isCorrect) {
    if (currentIndex >= widget.wordsList.length) {
      // Ensure currentIndex is within the valid range
      return;
    }
    final playedWord = PlayedWord(
      word: widget.wordsList[currentIndex],
      isCorrect: isCorrect,
    );
    playedWords.add(playedWord);
    currentIndex++;

    if (currentIndex < widget.wordsList.length) {
      startGame();
    } else {
      showResults();
    }
  }

  void showResults() {
    // Show the results page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          playedWords: playedWords,
        ),
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime =
        widget.timerCount - DateTime.now().difference(startTime).inSeconds;
    final currentWord = currentIndex < widget.wordsList.length
        ? widget.wordsList[currentIndex]
        : '';

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Game Page'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('$remainingTime',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(currentWord,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnswerButton(
                    buttonType: AnswerButtonType.wrong,
                    onPressed: () => handleAnswer(false)),
                AnswerButton(
                    buttonType: AnswerButtonType.right,
                    onPressed: () => handleAnswer(true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
