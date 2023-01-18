import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer/providers/app_change_notifier.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<AppChangeNotifier>().favorites.isEmpty) {
      return _buildNoFavorites();
    }

    return _buildContent(context);
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFavoritesCount(context),
        _buildFavoritesList(context),
      ],
    );
  }

  Padding _buildFavoritesCount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text(
        'You have '
        '${context.watch<AppChangeNotifier>().favorites.length} favorites:',
      ),
    );
  }

  Expanded _buildFavoritesList(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 400 / 80,
        ),
        children: context
            .watch<AppChangeNotifier>()
            .favorites
            .map((pair) => _buildFavoriteItem(context, pair))
            .toList(),
      ),
    );
  }

  ListTile _buildFavoriteItem(BuildContext context, WordPair pair) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(
          Icons.delete_outline,
          semanticLabel: 'Delete',
        ),
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          context.read<AppChangeNotifier>().removeFavorite(pair);
        },
      ),
      title: Text(
        pair.asLowerCase,
        semanticsLabel: pair.asPascalCase,
      ),
    );
  }

  Center _buildNoFavorites() {
    return const Center(
      child: Text('No favorites yet.'),
    );
  }
}
