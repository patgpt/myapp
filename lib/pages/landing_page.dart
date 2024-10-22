import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/navigation_provider.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/widgets/drawer.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrick Kelly'),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              ref.read(themeProvider.notifier).state = value;
            },
          ),
        ],
      ),
      drawer: PDrawer(
        onItemSelected: (index) {
          ref.read(navigationProvider.notifier).state = index;
          Navigator.pop(context); // Close the drawer
          Navigator.pushNamed(context, '/$index');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationProvider.notifier).state = index;
        },
        elevation: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.deepPurpleAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
            backgroundColor: Colors.tealAccent,
          ),
        ],
      ),
      body: const Stack(
        children: [
          FancyShaderBackground(),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/pfp.jpg',
                  ),
                ),
                Text(
                  'Patrick Kelly',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Building scalable web experiences for over 20 years',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//

class FancyShaderBackground extends ConsumerWidget {
  const FancyShaderBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return ShaderMask(
      shaderCallback: (bounds) => _createShader(bounds, isDarkMode),
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.black, Colors.transparent],
            radius: 1.5,
            center: Alignment.center,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Shader _createShader(Rect bounds, bool isDarkMode) {
    return LinearGradient(
      colors: isDarkMode
          ? [Colors.deepPurpleAccent, Colors.blueAccent, Colors.tealAccent]
          : [Colors.orangeAccent, Colors.pinkAccent, Colors.yellowAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds);
  }
}
