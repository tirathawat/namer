import 'package:flutter/material.dart';
import 'package:namer/pages/favorites_page.dart';
import 'package:namer/pages/generator_page.dart';
import 'package:namer/models/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final List<Menu> menus = const <Menu>[
    Menu(title: 'Generator', icon: Icons.home, page: GeneratorPage()),
    Menu(title: 'Favorites', icon: Icons.favorite, page: FavoritesPage()),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onSelectedMenu(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return _buildSmallContent();
          }

          return _buildLargeContent(constraints);
        },
      ),
    );
  }

  Column _buildSmallContent() {
    return Column(
      children: [
        _buildMainArea(),
        SafeArea(
          child: BottomNavigationBar(
            items: widget.menus
                .map((menu) => BottomNavigationBarItem(
                      icon: Icon(menu.icon),
                      label: menu.title,
                    ))
                .toList(),
            currentIndex: _selectedIndex,
            onTap: _onSelectedMenu,
          ),
        )
      ],
    );
  }

  Row _buildLargeContent(BoxConstraints constraints) {
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            extended: constraints.maxWidth >= 600,
            destinations: widget.menus
                .map((menu) => NavigationRailDestination(
                      icon: Icon(menu.icon),
                      label: Text(menu.title),
                    ))
                .toList(),
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onSelectedMenu,
          ),
        ),
        _buildMainArea(),
      ],
    );
  }

  Expanded _buildMainArea() {
    return Expanded(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: widget.menus[_selectedIndex].page,
        ),
      ),
    );
  }
}
