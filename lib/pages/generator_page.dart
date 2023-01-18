import 'package:flutter/material.dart';
import 'package:namer/providers/app_change_notifier.dart';
import 'package:namer/widgets/big_card.dart';
import 'package:namer/widgets/history_list_view.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          const SizedBox(height: 10),
          BigCard(pair: context.watch<AppChangeNotifier>().currentWord),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLikeButton(context),
              const SizedBox(width: 10),
              _buildNextButton(context),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  ElevatedButton _buildLikeButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<AppChangeNotifier>().toggleFavorite();
      },
      icon: Icon(_buildIconData(context)),
      label: const Text('Like'),
    );
  }

  ElevatedButton _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppChangeNotifier>().nextWord();
      },
      child: const Text('Next'),
    );
  }

  IconData _buildIconData(BuildContext context) {
    if (context.watch<AppChangeNotifier>().favoritedCurrentWord()) {
      return Icons.favorite;
    }

    return Icons.favorite_border;
  }
}
