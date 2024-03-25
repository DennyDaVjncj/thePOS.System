import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'the POS system',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var uiContent = WordPair.random();
  void getNext() {
    uiContent = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var couple = appState.uiContent;

    return Scaffold(
      body: Column(
        children: [
          Text('the POS system of POS systems'),
          uiContent(couple: couple),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Click to spawn new term'),
          )
        ],
      ),
    );
  }
}

class uiContent extends StatelessWidget {
  const uiContent({
    super.key,
    required this.couple,
  });

  final WordPair couple;

  @override
  Widget build(BuildContext context) {
    return Text(couple.asLowerCase);
  } //this is what ultimately renders to the UI
}
