import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/animate.dart';
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

class _MyScreenState extends State<MyScreen>
    with SingleTickerProviderStateMixin {
  bool shouldRenderFirstWidget = true;
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
    "Meet Emie, a 27-year-old working at an IT firm in bustling Tokyo. She shares a cozy home with her mother, embracing the blend of modern city life and traditional Japanese warmth. As Emie navigates the challenges of her career, she finds herself on a journey toward sustainability, weaving her story through the vibrant streets of Tokyo",
    "In the heart of Tokyo, amidst the ceaseless rhythm of the city, Emie makes her way home after another day at the office.",
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
    [
      "/intro/intro1.jpg",
      "/intro/intro2.jpg",
      "/intro/intro3.jpg",
      "/intro/intro4.jpg",
      "/intro/intro5.jpg",
      "/intro/intro6.jpg",
      "/intro/intro7.jpg",
      "/intro/intro8.jpg"
    ],
    [
      "/drive/d.jpg",
      "/drive/d2.jpg",
      "/drive/d3.jpg",
      "/drive/d4.jpg",
      "/drive/d5.jpg"
    ],
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
      //_showLanguageDialog(); // Show language selection dialog when the page loads
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
      print("rotat");
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          title: Text('Urban Eco-Adventures'),
          elevation: 50.0,
          backgroundColor: Color.fromARGB(255, 132, 219, 146),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Swiper(
                  itemWidth: 200,
                  itemHeight: 200,
                  loop: true,
                  autoplay: true,
                  duration: 2000,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagePaths[index])),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                  layout: SwiperLayout.STACK,
                ),
              ),
              // Image container (replace with your image widget)
              // Text description followed by images (replace with your content)
              Text(
                'Welcome to the Game!\nPlay and Win to Collect Your Collectible Card!',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ),
              SizedBox(height: 8.0), // Adjust spacing as needed
              const AvatarStack(
                avatars: [
                  'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
                  'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
                  'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
                ],
              ),
              SizedBox(height: 16.0), // Adjust spacing as needed

              Text(
                'Language Settings / 言語の設定',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ),
              SizedBox(height: 8.0), // Adjust spacing as needed
              // Language selection
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLanguage = "en-US";
                    isSpeaking = true;
                    _speak(texts[currentIndex]);
                    _startImageRotation();
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromARGB(255, 132, 219, 146),
                    border: Border.all(color: Colors.green, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color.fromARGB(255, 132, 219, 146),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 132, 219, 146),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '日本語',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color.fromARGB(255, 132, 219, 146),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Add more language options as needed
            ],
          ),
        );
      },
    );
  }

  Future<void> _speak(String text) async {
    setState(() {
      isSpeaking = true; // Set isSpeaking to true when text-to-speech starts
    });
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.setPitch(0.95);
    await flutterTts.setSpeechRate(2);
    await flutterTts.speak(text);
    setState(() {
      isSpeaking = false; // Set isSpeaking to true when text-to-speech starts
    });
    // Check if all images have been processed
    if (currentIndex == imagePaths.length - 1) {
      await Future.delayed(Duration(seconds: 5));
      // Show congratulatory page
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ExampleDragAndDrop(selectedLanguage: selectedLanguage),
        ),
      );
    }
  }


  Widget firstWidget() {
        return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.zero,
       backgroundColor: const Color.fromARGB(255, 118, 224, 122),
      content: Container(
        width: double.maxFinite, // Set width to take up the full screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Your existing content here
            Align(
              alignment: Alignment.center,
              child: Swiper(
              itemWidth: 200,
              itemHeight: 200,
              loop: true,
              autoplay: true,
              duration: 2000,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePaths[index]),
                    ),
                  
                  ),
                );
              },
              layout: SwiperLayout.STACK,
            ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Welcome to the Game!\nPlay and Win to Collect Your Collectible Card!',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 30.0),
            const AvatarStack(
            avatars: [
              'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
              'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
              'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
            ],
          ),
            SizedBox(height: 60.0),
            Text(
              'Language Settings / 言語の設定',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                  shouldRenderFirstWidget = false;
                  setState(() {
                    selectedLanguage = "en-US";
                    isSpeaking = true;
                    _speak(texts[currentIndex]);
                    _startImageRotation();
                  });
              },
              child: LanguageOptionWidget(
                label: 'English',
                isSelected: selectedLanguage == "en-US",
              ),
            ),
            GestureDetector(
              onTap: () {
                shouldRenderFirstWidget = false;
                 selectedLanguage = "ja-JP";
                    isSpeaking = true;
                    texts = jTexts;
                    _speak(texts[currentIndex]);
                    _startImageRotation();
              },
              child: LanguageOptionWidget(
                label: '日本語',
                isSelected: selectedLanguage == "ja-JP",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageContainer(String language) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromARGB(255, 132, 219, 146),
        border: Border.all(color: Colors.green, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            language,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Color.fromARGB(255, 132, 219, 146),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (shouldRenderFirstWidget) {
      return firstWidget();
    } else {
      return secondWidget();
    }
}

  Widget secondWidget() {
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
              height: 110,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 118, 224, 122).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 3,
                      spreadRadius: 5,
                      offset: Offset(1, 1)),
                  BoxShadow(
                      color:Colors.transparent,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(5, 5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Description strip (90% width)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 -
                        40, // Adjusting width considering padding
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          texts[currentIndex],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.caveatBrush().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Next button (10% width)
                  Visibility(
                    visible:
                        !isSpeaking, // Show the button only when not speaking
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
                        child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 70.0, // Adjust the size as needed
      ),
                        style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
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

class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.avatars,
    this.stackHeight = 120,
    this.extraParticipantsCount,
  });

  final List<String> avatars;
  final double stackHeight;
  final int? extraParticipantsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: stackHeight,
      child: Stack(
        children: List.generate(
          avatars.length,
          (index) => Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset((index - 1) * 50.0, 0),
              child: Avatar(imageUrl: avatars[index])
                  .animate(
                    delay: const Duration(
                      milliseconds: 500,
                    ),
                  )
                  .fadeIn(
                    delay: Duration(
                      milliseconds: index * 100,
                    ),
                  )
                  .slide(
                    begin: const Offset(0.5, 0),
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeOut,
                    delay: Duration(
                      milliseconds: index * 100,
                    ),
                  )
                  .animate(
                onPlay: (controller) {
                  controller.repeat();
                },
              ).shimmer(
                duration: 2400.ms,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.imageUrl,
    this.radius = 100,
    this.child,
  });

  final String imageUrl;
  final int radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.toDouble() + 2,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radius.toDouble(),
        backgroundImage: NetworkImage(imageUrl),
        child: child,
      ),
    );
  }
}

class LanguageOptionWidget extends StatelessWidget {
  final String label;
  final bool isSelected;

  LanguageOptionWidget({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 132, 219, 146) : null,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Material(
        elevation: isSelected ? 4.0 : 0.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: isSelected ? Color.fromARGB(255, 132, 219, 146) : null,
            ),
          ),
        ),
      ),
    );
  }
}