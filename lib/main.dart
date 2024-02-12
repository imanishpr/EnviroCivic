import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int currentIndex = 0;
  FlutterTts flutterTts = FlutterTts();

  List<String> imagePaths = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
  ];

  List<String> texts = [
    "Description 1",
    "Description 2",
    "Description 3",
    "Description 4",
  ];

  @override
  void initState() {
    super.initState();
    _speak(texts[currentIndex]);
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ja-JP");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(.8);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            imagePaths[currentIndex],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Button and description strip
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Description strip (90% width)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          texts[currentIndex],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Next button (10% width)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (currentIndex < imagePaths.length - 1) {
                            currentIndex++;
                            _speak(texts[currentIndex]);
                          } else {
                            currentIndex = 0;
                          }
                        });
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
