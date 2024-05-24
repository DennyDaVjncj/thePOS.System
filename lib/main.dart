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

  var inclinations = <WordPair>[];
  void toggleFavorite() {
    if (inclinations.contains(uiContent)) {
      inclinations.remove(uiContent);
    } else {
      inclinations.add(uiContent);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///**
///this instantiation of our MyHomPage widget, is made private by the underscore preceeding the class-name.
///this widget contains the "business-logic" if you will. this contains the details
///this widget is the definition to our MyHomePage class, right above.
/// */
class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Inclings'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var couple = appState.uiContent;

    IconData icon;
    if (appState.inclinations.contains(couple)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiContent(couple: couple),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Incling'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
                icon: Icon(icon),
                label: Text('Trigger action-potential'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

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
 * stateful vs stateless widgets
 * deepened understanding of widget states
 * left off at setState
 */
