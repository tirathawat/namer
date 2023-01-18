import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AppChangeNotifier extends ChangeNotifier {
  final List<WordPair> _histories = <WordPair>[];
  final List<WordPair> _favorites = <WordPair>[];

  WordPair _currentWord = WordPair.random();
  GlobalKey? _historyListKey;

  List<WordPair> get favorites => _favorites;
  List<WordPair> get histories => _histories;
  WordPair get currentWord => _currentWord;

  set historyListKey(GlobalKey key) => _historyListKey = key;

  bool favoritedCurrentWord() {
    return _favorites.contains(_currentWord);
  }

  void nextWord() {
    _histories.insert(0, _currentWord);
    var animatedList = _historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    _currentWord = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? _currentWord;
    _favorites.contains(pair) ? _favorites.remove(pair) : _favorites.add(pair);
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    _favorites.remove(pair);
    notifyListeners();
  }
}
