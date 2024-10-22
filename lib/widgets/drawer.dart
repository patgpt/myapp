import 'package:flutter/material.dart';

class PDrawer extends StatelessWidget {
  const PDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          child: Image.asset('assets/pfp.webp'),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              // Home, Projects, Education, Art
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.work),
                title: const Text('Projects'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Education'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.art_track),
                title: const Text('Art'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}


