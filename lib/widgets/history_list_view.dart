import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer/providers/app_change_notifier.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final GlobalKey _key = GlobalKey();

  Shader _createShader(Rect bounds) {
    return const LinearGradient(
      colors: [Colors.transparent, Colors.black],
      stops: [0.0, 0.5],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    final appChangeNotifier = context.watch<AppChangeNotifier>();
    appChangeNotifier.historyListKey = _key;
    return ShaderMask(
      shaderCallback: _createShader,
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
        initialItemCount: appChangeNotifier.histories.length,
        itemBuilder: _buildHistoryItem,
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    AppChangeNotifier appChangeNotifier = context.watch<AppChangeNotifier>();
    WordPair word = appChangeNotifier.histories[index];
    return SizeTransition(
      sizeFactor: animation,
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            appChangeNotifier.toggleFavorite(word);
          },
          icon: appChangeNotifier.favorites.contains(word)
              ? const Icon(Icons.favorite, size: 12)
              : const SizedBox(),
          label: Text(
            word.asLowerCase,
            semanticsLabel: word.asPascalCase,
          ),
        ),
      ),
    );
  }
}
