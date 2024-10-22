import 'package:flutter/material.dart';
import 'package:myapp/widgets/drawer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: const Text('Patrick Kelly'),
      ),
      drawer: const PDrawer(),

      bottomNavigationBar: BottomNavigationBar(elevation: 3, items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.deepPurpleAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work',
            backgroundColor: Colors.blueAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
            backgroundColor: Colors.tealAccent),
      ]),
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

class ShaderEffectBackground extends StatelessWidget {
  const ShaderEffectBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Colors.deepPurpleAccent,
            Colors.blueAccent,
            Colors.tealAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            radius: 1.5,
            center: Alignment.center,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class FancyShaderBackground extends StatefulWidget {
  const FancyShaderBackground({super.key});

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

  Shader _createShader(Rect bounds) {
    return const LinearGradient(
      colors: [
        Colors.deepPurpleAccent,
        Colors.blueAccent,
        Colors.tealAccent,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds);
  }
}
