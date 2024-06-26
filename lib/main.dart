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
        page = InclingsPage();
        break;
      case 2:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Inclings'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.build),
                    label: Text('working on it'),
                  )
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
    });
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
                icon: Icon(Icons.tips_and_updates),
                label: Text('action-potential'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InclingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appCntxt = context.watch<MyAppState>();

    if (appCntxt.inclinations.isEmpty) {
      return Center(
        child: Text('develop some intuition'),
      );
    }

    return ListView(children: [
      Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appCntxt.inclinations.length} inclinations, apparently')),
      for (var litPair in appCntxt.inclinations)
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text(litPair.asLowerCase),
        )
    ]);
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
 * SECTION 8: add a new page
 * left off on line 172
  
 * use cli with ci systems
 * last step before fully installing firebase: Installed executable flutterfire.
  Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.
  You can fix that by adding this to your shell's config file (.bashrc, .bash_profile, etc.):

  export PATH="$PATH":"$HOME/.pub-cache/bin"
 */
