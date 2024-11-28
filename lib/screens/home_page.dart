import 'package:flutter/material.dart';
import 'package:words_pronunciation/main.dart';
import 'package:words_pronunciation/screens/admin_page.dart';
import 'package:words_pronunciation/screens/start_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> wordsList = [];
  int timerCount = 5; // Default timer value

  TextEditingController wordController = TextEditingController();
  PageController pageController = PageController();
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Word Game"),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Paramètres'),
              Tab(text: 'Jeu'),
            ],
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
              pageController.jumpToPage(index);
            },
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              tabIndex = index;
            });
          },
          children: [
            // First Tab
            AdminPage(
              wordsList: wordsList,
              timerCount: timerCount,
              onAddWord: (word) {
                setState(() {
                  wordsList.add(word);
                });
              },
              onDeleteWord: (index) {
                setState(() {
                  wordsList.removeAt(index);
                });
              },
              onTimerChanged: (value) {
                setState(() {
                  timerCount = value.round();
                });
              },
            ),

            // Second Tab
            StartPage(
              wordsList: wordsList,
              timerCount: timerCount,
            ),
          ],
        ),
      ),
    );
  }
}
