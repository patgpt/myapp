import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/navigation_provider.dart';

class PDrawer extends ConsumerWidget {
  final Function(int) onItemSelected;

  const PDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Work'),
            selected: currentIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Education'),
            selected: currentIndex == 2,
            onTap: () => onItemSelected(2),
          ),
        ],
      ),
    );
  }
}
