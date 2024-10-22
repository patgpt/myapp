import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const int mobileBreakpoint = 600; // Extracted breakpoint value

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatefulWidget {
  const MyPortfolioApp({super.key});

  @override
  _MyPortfolioAppState createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LandingPage(onThemeSwitch: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class LandingPage extends StatefulWidget {
  final Function(bool) onThemeSwitch;
  final bool isDarkMode;

  const LandingPage(
      {required this.onThemeSwitch, required this.isDarkMode, super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      if (_ticker.isActive) {
        setState(() {
          _time = elapsed.inMilliseconds / 1000.0;
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrick Kelly'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeSwitch,
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width < mobileBreakpoint
          ? const PDrawer()
          : null, // Drawer on mobile
      bottomNavigationBar: BottomNavigationBar(
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
      body: Stack(
        children: [
          FancyShaderBackground(time: _time),
          const Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/pfp.jpg'),
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

class ShaderEffectBackground extends StatelessWidget {
  final double time;

  const ShaderEffectBackground({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        try {
          return const LinearGradient(
            colors: [
              Colors.deepPurpleAccent,
              Colors.blueAccent,
              Colors.tealAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        } catch (e) {
          print('Error compiling shader: $e');
          return const LinearGradient(
            // Fallback gradient in case shader fails
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        }
      },
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: backgroundDecoration(),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
    gradient: RadialGradient(
      colors: [
        Colors.black,
        Colors.transparent,
      ],
      radius: 1.5,
      center: Alignment.center,
    ),
  );
}

class FancyShaderBackground extends StatefulWidget {
  final double time;

  const FancyShaderBackground({required this.time, super.key});

  @override
  State<FancyShaderBackground> createState() => _FancyShaderBackgroundState();
}

class _FancyShaderBackgroundState extends State<FancyShaderBackground> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => _createShader(bounds),
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: backgroundDecoration(),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Shader _createShader(Rect bounds) {
    try {
      return const LinearGradient(
        colors: [
          Colors.deepPurpleAccent,
          Colors.blueAccent,
          Colors.tealAccent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds);
    } catch (e) {
      print('Error creating shader: $e');
      return const LinearGradient(
        // Fallback gradient in case shader fails
        colors: [Colors.black, Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds);
    }
  }
}

class PDrawer extends StatelessWidget {
  const PDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Work'),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Work'),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.brush),
            title: const Text('Art'),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact'),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
    );
  }
}

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  

  