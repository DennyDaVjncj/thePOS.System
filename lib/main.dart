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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('the POS system of POS systems'),
            UiContent(couple: couple),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('click here to trigger an action potential'),
            )
          ],
        ),
      ),
    );
  }
}

class UiContent extends StatelessWidget {
  const UiContent({
    super.key,
    required this.couple,
  });

  final WordPair couple;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      elevation: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(39.0),
        child: Text(couple.asLowerCase,
            style: style, semanticsLabel: "${couple.first} ${couple.second}"),
      ),
    );
  } //this is what ultimately renders to the UI
}
/**
 * left off with the copywith() update
 */