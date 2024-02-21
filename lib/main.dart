import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'garbageCollect.dart';

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

class _MyScreenState extends State<MyScreen> with SingleTickerProviderStateMixin {
  bool isSpeaking = true;
  int currentIndex = 0;
  int rotator = 0;
  FlutterTts flutterTts = FlutterTts();
  String selectedLanguage = "en-US"; // Default language is English

  List<String> imagePaths = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
  ];

  List<String> texts = [
    "Meet Emie, a 27-year-old working at an IT firm in bustling Tokyo. She shares a cozy home with her mother, embracing the blend of modern city life and traditional Japanese warmth. As Emi navigates the challenges of her career, she finds herself on a journey toward sustainability, weaving her story through the vibrant streets of Tokyo",
    "In the heart of Tokyo, amidst the ceaseless rhythm of the city, Emi makes her way home after another day at the office.",
    "Welcome back, Emie. How was your day?",
    "Long, but productive. How about you, Mom?",
    "Busy as always, but nothing I can't handle. Oh, by the way, your room is a bit of a mess. Mind tidying up before dinner?",
    "Of course, Mom. I'll take care of it right away.",
    "As Emie steps into her cluttered room, a wave of frustration washes over her. Papers strewn across the desk, clothes piled haphazardly on the floor – it's chaos.",
  ];
  List<String> jTexts = [
  "エミーに会いましょう。27歳のエミーは、賑やかな東京でIT企業で働いています。彼女は母親とアットホームな家を共有し、現代の都市生活と日本の伝統的な温かさを融合させています。エミーはキャリアの挑戦に立ち向かいながら、自分自身を持続可能性への旅に導き、東京の活気ある街を通して物語を紡いでいます。",
  "東京の中心部で、街の絶え間ないリズムの中、エミーはオフィスでの別の一日の後、家路につきます。",
  "おかえりなさい、エミー。今日はどうだった？",
  "長かったけれども生産的でした。あなたはどうだったの、お母さん？",
  "相変わらず忙しいけれど、私には対処できることばかりよ。ところで、あなたの部屋はちょっと散らかっているわね。夕食前に片付けてくれるかしら？",
  "もちろん、お母さん。すぐに片付けます。",
  "エミーが散らかった部屋に足を踏み入れると、彼女を襲うフラストレーションの波が押し寄せます。机に散らばる紙、床に不規則に積まれた服 – まるで混沌です。",
];
  List<List<String>> imagePathsList = [
    ["/intro/intro1.jpg", "/intro/intro2.jpg", "/intro/intro3.jpg", "/intro/intro4.jpg", "/intro/intro5.jpg", "/intro/intro6.jpg", "/intro/intro7.jpg", "/intro/intro8.jpg"],
    ["/drive/d.jpg", "/drive/d2.jpg", "/drive/d3.jpg" ,"/drive/d4.jpg","/drive/d5.jpg"],
    ["/mom/mom1.jpg"],
    ["/mom/tmom1.jpg", "/mom/tmom2.jpg", "/mom/tmom1.jpg", "/mom/tmom2.jpg"],
    ["/mom/mom3.jpg", "/mom/mom4.jpg", "/mom/mom3.jpg", "/mom/mom4.jpg"],
    ["/mom/tmom4.jpg", "/mom/tmom5.jpg", "/mom/tmom4.jpg", "/mom/tmom5.jpg"],
    ["/angry/angry1.jpg", "/angry/angry2.jpg", "/angry/angry3.jpg"],
    // Add more lists if needed
  ];
    late AnimationController animationController;
    late Timer timer;

@override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust the duration as needed
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLanguageDialog(); // Show language selection dialog when the page loads
      _delayedNextButtonVisibility(); // Introduce a delay before showing the "Next" button
    });
  }

  Future<void> _delayedNextButtonVisibility() async {
    setState(() {
      isSpeaking = true; // Set isSpeaking to false after the delay
    });
    await Future.delayed(Duration(seconds: 10));
    setState(() {
      isSpeaking = false; // Set isSpeaking to false after the delay
    });
  }

  Future<void> _startImageRotation() async {
    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      print("rotat" );
      print(rotator);
      print("currentIndex");
      print(currentIndex);
      setState(() {
        if (rotator < imagePathsList[currentIndex].length - 1) {
          rotator++;
        } else {
          rotator = 0;
        }
      });
    });
  }
  Future<void> _showLanguageDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language / 言語を選択'),
          content: Column(
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  setState(() {
                    selectedLanguage = "en-US";
                    isSpeaking = true;
                    _speak(texts[currentIndex]);
                    _startImageRotation();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('日本語'),
                onTap: () {
                  setState(() {
                    selectedLanguage = "ja-JP";
                    isSpeaking = true;
                    texts = jTexts;
                    _speak(texts[currentIndex]);
                    _startImageRotation();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _speak(String text) async {
    setState( () {
      isSpeaking = true; // Set isSpeaking to true when text-to-speech starts
    });
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.setPitch(0.95);
    await flutterTts.setSpeechRate(2);
    await flutterTts.speak(text);
    setState( () {
      isSpeaking = false; // Set isSpeaking to true when text-to-speech starts
    });
    // Check if all images have been processed
    if (currentIndex == imagePaths.length - 1) {
      await Future.delayed(Duration(seconds: 5));
      // Show congratulatory page
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ExampleDragAndDrop(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            imagePathsList[currentIndex][rotator],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Button and description strip
    Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              height: 98,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 157, 151, 151),
                    blurRadius: 3,
                    spreadRadius: 5,
                    offset: Offset(0, 0)
                ),
                BoxShadow(
                    color: Color.fromARGB(255, 157, 151, 151),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(5, 5)
                ),
              ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Description strip (90% width)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 - 40, // Adjusting width considering padding
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          texts[currentIndex],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: GoogleFonts.caveatBrush().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Next button (10% width)
                  Visibility(
                    visible: !isSpeaking, // Show the button only when not speaking
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: ElevatedButton(
                        onPressed: () async {
                          print(currentIndex);

                          setState(() {
                            isSpeaking = false;
                             _speak(texts[++currentIndex]);
                            rotator = 0;
                          });
                        },
                        child: Icon(Icons.arrow_forward),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
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

class CongratulatoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations!'),
      ),
      body: Center(
        child: Text('Hurray! You are done.'),
      ),
    );
  }
}
