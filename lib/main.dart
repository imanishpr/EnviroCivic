import 'dart:io';
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:garbage_sorting/app_barcode_scanner_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:garbage_sorting/animate.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'garbageCollect.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  var isEnglish = true;
  bool isMuted = false;
  bool shouldRenderFirstWidget = true;
  bool shouldRenderSubwayWidget = false;
  bool isSpeaking = true;
  int currentIndex = 0;
  int rotator = 0;
  FlutterTts flutterTts = FlutterTts();
  String selectedLanguage = "en-US"; // Default language is English

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );

  List<String> imagePaths = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg"
  ];

  List<String> texts = [
    "Meet Emie, a 27-year-old working at an IT firm in bustling Tokyo. She shares a cozy home with her mother, embracing the blend of modern city life and traditional Japanese warmth. As Emie navigates the challenges of her career, she finds herself on a journey toward sustainability, weaving her story through the vibrant streets of Tokyo",
    "In the heart of Tokyo, amidst the ceaseless rhythm of the city, Emie makes her way home after another day at the office.",
    "Welcome back, Emie. How was your day?",
    "Long, but productive. How about you, Mom?",
    "Busy as always, but nothing I can't handle. Oh, by the way, your room is a bit of a mess. Mind tidying up before dinner?",
    "Of course, Mom. I'll take care of it right away.",
    "As Emie steps into her cluttered room, a wave of frustration washes over her. Papers strewn across the desk, clothes piled haphazardly on the floor – it's chaos.",
    "click the the next button and start playing..",
  ];
  List<String> jTexts = [
    "エミーに会いましょう。27歳のエミーは、賑やかな東京でIT企業で働いています。彼女は母親とアットホームな家を共有し、現代の都市生活と日本の伝統的な温かさを融合させています。エミーはキャリアの挑戦に立ち向かいながら、自分自身を持続可能性への旅に導き、東京の活気ある街を通して物語を紡いでいます。",
    "東京の中心部で、街の絶え間ないリズムの中、エミーはオフィスでの別の一日の後、家路につきます。",
    "おかえりなさい、エミー。今日はどうだった？",
    "長かったけれども生産的でした。あなたはどうだったの、お母さん？",
    "相変わらず忙しいけれど、私には対処できることばかりよ。ところで、あなたの部屋はちょっと散らかっているわね。夕食前に片付けてくれるかしら？",
    "もちろん、お母さん。すぐに片付けます。",
    "エミーが散らかった部屋に足を踏み入れると、彼女を襲うフラストレーションの波が押し寄せます。机に散らばる紙、床に不規則に積まれた服 – まるで混沌です。",
    "次のボタンをクリックしてプレイを開始してください。",
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
    ["/angry/angry1.jpg"]
    // Add more lists if needed
  ];

  List<List<String>> imagePathsListSubWay = [
    [
      "/subway/coffee/coffee1.jpeg",
      "/subway/coffee/coffee2.jpeg",
      "/subway/coffee/coffee3.jpeg",
      "/subway/coffee/coffee4.jpeg",
    ],
    [
      "/subway/friend/friend.jpeg",
      "/subway/friend/friend2.jpeg",
      "/subway/friend/friend3.jpeg",
    ],
    [
      "/subway/friend/waitfortrain.jpeg",
      "/subway/friend/waitfortrain2.jpeg",
      "/subway/friend/waitfortrain3.jpeg",
      "/subway/friend/waitfortrain4.jpeg",
    ],
    [
      "/subway/police/ticketbuy.png",
    ],
    [
      "/subway/police/policeman.jpeg",
    ],
    // Add more lists if needed
  ];
  List<String> subWaytexts = [
    "having coffee",
    "talk to friend",
    "wait for friend",
    "emie bought ticket",
    "show your ticket",
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
      isSpeaking = false; // Set isSpeaking to false after the delay
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isSpeaking = false; // Set isSpeaking to false after the delay
    });
  }

  Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 200,
              width: 200,
              child: AppBarcodeScannerWidget.defaultStyle(
                resultCallback: (String code) {
                  print("Scanned text is " + code);
                  setState(() {});
                },
                openManual: true,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Route<Object?> _addSubwayPassDialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ElevatedButton(
              onPressed: () {
                print("Adding qr to wallet");
                //Navigator.of(context).restorablePush(_dialogBuilder);
                _launchURL();
              },
              child: SvgPicture.asset(
                'assets/wallet-eng.svg', // Replace 'assets/your_sample.svg' with your SVG file path
                width: 250, // Adjust the width as needed
                height: 50, // Adjust the height as needed
              ),
            ),
          ),
        );
      },
    );
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

  // Future<void> _showLanguageDialog() async {
  //   return showDialog<void>(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         insetPadding: EdgeInsets.all(0),
  //         title: Text('Urban Eco-Adventures'),
  //         elevation: 50.0,
  //         backgroundColor: Color.fromARGB(255, 132, 219, 146),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Align(
  //               alignment: Alignment.center,
  //               child: Swiper(
  //                 itemWidth: 300,
  //                 itemHeight: 300,
  //                 loop: true,
  //                 autoplay: true,
  //                 duration: 2000,
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: 6,
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                     width: 300,
  //                     height: 300,
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                           image: AssetImage(imagePaths[index])),
  //                       borderRadius: BorderRadius.circular(300),
  //                     ),
  //                   );
  //                 },
  //                 layout: SwiperLayout.STACK,
  //               ),
  //             ),
  //             // Image container (replace with your image widget)
  //             // Text description followed by images (replace with your content)
  //             Text(
  //               'Welcome to the Game!\nPlay and Win to Collect Your Collectible Card!',
  //               style: TextStyle(
  //                   fontSize: 16.0,
  //                   fontFamily: GoogleFonts.poppins().fontFamily),
  //             ),
  //             SizedBox(height: 8.0), // Adjust spacing as needed
  //             const AvatarStack(
  //               avatars: [
  //                 'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
  //                 'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
  //                 'https://res.cloudinary.com/parc-india/image/upload/e_blur:2000/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
  //               ],
  //             ),
  //             SizedBox(height: 16.0), // Adjust spacing as needed

  //             Text(
  //               'Language Settings / 言語の設定',
  //               style: TextStyle(
  //                   fontSize: 16.0,
  //                   fontFamily: GoogleFonts.poppins().fontFamily),
  //             ),
  //             SizedBox(height: 8.0), // Adjust spacing as needed
  //             // Language selection
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedLanguage = "en-US";
  //                   isSpeaking = true;
  //                   _speak(texts[currentIndex]);
  //                   _startImageRotation();
  //                 });
  //                 Navigator.of(context).pop();
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   color: Color.fromARGB(255, 132, 219, 146),
  //                   border: Border.all(color: Colors.green, width: 2.0),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.green.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 4,
  //                       offset: Offset(0, 3),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Material(
  //                   elevation: 4.0,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Text(
  //                       'English',
  //                       style: TextStyle(
  //                         fontSize: 16.0,
  //                         fontFamily: GoogleFonts.poppins().fontFamily,
  //                         color: Color.fromARGB(255, 132, 219, 146),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),

  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedLanguage = "ja-JP";
  //                   isSpeaking = true;
  //                   texts = jTexts;
  //                   _speak(texts[currentIndex]);
  //                   _startImageRotation();
  //                 });
  //                 Navigator.of(context).pop();
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Color.fromARGB(255, 132, 219, 146),
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   border: Border.all(color: Colors.green, width: 2.0),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.green.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 4,
  //                       offset: Offset(0, 3),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Material(
  //                   elevation: 4.0,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Text(
  //                       '日本語',
  //                       style: TextStyle(
  //                         fontSize: 16.0,
  //                         fontFamily: GoogleFonts.poppins().fontFamily,
  //                         color: Color.fromARGB(255, 132, 219, 146),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),

  //             // Add more language options as needed
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _speak(String text) async {
    setState(() {
      isSpeaking = true; // Set isSpeaking to true when text-to-speech starts
    });
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.setPitch(0.95);
    await flutterTts.setSpeechRate(2);
    await flutterTts.speak(text);
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      isSpeaking = false; // Set isSpeaking to true when text-to-speech starts
    });
    print("hello im running");
    if (currentIndex == imagePaths.length - 1 && !shouldRenderSubwayWidget) {
      await Future.delayed(Duration(seconds: 5));
      // Navigate to ExampleDragAndDrop and wait for it to return
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExampleDragAndDrop(),
        ),
      );
      currentIndex = 0;
      rotator = 0;
      shouldRenderSubwayWidget = true;
      imagePathsList = imagePathsListSubWay;
      texts = subWaytexts;
      // This code will be executed after ExampleDragAndDrop is popped
      // You can render a widget or perform any action here
      print("Returned from ExampleDragAndDrop");
    }
    if (currentIndex == imagePathsListSubWay.length - 1 &&
        shouldRenderSubwayWidget) {
      await Future.delayed(Duration(seconds: 2));
      print("Returned from scan");
      Navigator.of(context).restorablePush(_dialogBuilder);
    }
    if (currentIndex == imagePathsListSubWay.length - 2 &&
        shouldRenderSubwayWidget) {
      await Future.delayed(Duration(seconds: 2));
      print("Returned from scan");
      Navigator.of(context).restorablePush(_addSubwayPassDialogBuilder);
    }
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
    if (shouldRenderFirstWidget && !shouldRenderSubwayWidget) {
      return Stack(children: <Widget>[
        FirstPageWidget(),
        SizedBox(
          width: 60,
          height: 60,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              // print("You pressed Icon Elevated Button");
              setState(() {
                isMuted = !isMuted;
              });
            },
            child: isMuted
                ? Icon(
                    Icons.volume_off,
                    color: Colors.white,
                  )
                : Icon(Icons.volume_up,
                    color: Colors.white), //icon data for elevated button
            //label text
          ),
        )
      ]);
    } else if (!shouldRenderFirstWidget && !shouldRenderSubwayWidget) {
      return Stack(children: <Widget>[
        secondWidget(),
        SizedBox(
          width: 60,
          height: 60,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              // print("You pressed Icon Elevated Button");
              setState(() {
                isMuted = !isMuted;
              });
            },
            child: isMuted
                ? Icon(
                    Icons.volume_off,
                    color: Colors.white,
                  )
                : Icon(Icons.volume_up,
                    color: Colors.white), //icon data for elevated button
            //label text
          ),
        )
      ]);
    } else {
      return Stack(children: <Widget>[
        subWayWidget(),
        SizedBox(
          width: 60,
          height: 60,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              // print("You pressed Icon Elevated Button");
              setState(() {
                isMuted = !isMuted;
              });
            },
            child: isMuted
                ? Icon(
                    Icons.volume_off,
                    color: Colors.white,
                  )
                : Icon(Icons.volume_up,
                    color: Colors.white), //icon data for elevated button
            //label text
          ),
        )
      ]);
    }
  }

  AlertDialog FirstPageWidget() {
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.zero,
      // title: Text('Urban Eco-Adventures'),
      backgroundColor: Colors.indigo.shade50,
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            width:
                double.maxFinite, // Set width to take up the full screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 500,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Urban Eco Adventures',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(50), // Image radius
                            child: Image.asset(imagePaths[index],
                                fit: BoxFit.cover),
                          ),
                        );
                        // )
                      },
                      axisDirection: AxisDirection.right,
                      loop: true,
                      autoplay: true,
                      itemCount: 3,
                      itemWidth: 300.0,
                      itemHeight: 200.0,
                      layout: SwiperLayout.STACK,
                    )),
                SizedBox(height: 30.0),
                Text(
                  'Embark on a Sustainable Journey!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                Text(
                  'Explore, Learn, Collect Rewards for your Google Wallet',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                SizedBox(height: 30.0),
                const AvatarStack(
                  avatars: [
                    '/assets/newspaper.png',
                    '/assets/pastic_bottle.png',
                    '/assets/phone.png',
                    '/assets/tea_bags.png'
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
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SizedBox(
                      width: 100,
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 20,
                            child: isEnglish
                                ? CountryFlag.fromLanguageCode('en-us')
                                : CountryFlag.fromCountryCode('jp'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: isEnglish
                                ? Text(
                                    "English",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "日本語",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == MenuItems.english) {
                        setState(() {
                          isEnglish = true;
                        });
                      } else {
                        setState(() {
                          isEnglish = false;
                        });
                      }
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: 160,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black12,
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled(MenuItems.firstItems.length, 48),
                      ],
                      padding: const EdgeInsets.only(left: 16, right: 16),
                    ),
                  ),
                ),
                SizedBox(height: 90.0),
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                        300.0), // Adjust the value as needed
                    border: Border.all(
                        color: Colors.white12,
                        width: 7.0), // Optional: Add border color and width
                  ),
                  child: ElevatedButton(
                    // style: Stylel
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      shouldRenderFirstWidget = false;
                      selectedLanguage = "ja-JP";
                      isSpeaking = true;
                      texts = jTexts;
                      _speak(texts[currentIndex]);
                      _startImageRotation();
                      // print("Adding qr to wallet");
                      //Navigator.of(context).restorablePush(_dialogBuilder);
                      // _launchURL();
                    },
                    child: Center(
                      child: Text(
                        'START',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     shouldRenderFirstWidget = false;
                //     setState(() {
                //       selectedLanguage = "en-US";
                //       isSpeaking = true;
                //       _speak(texts[currentIndex]);
                //       _startImageRotation();
                //     });
                //   },
                //   child: LanguageOptionWidget(
                //     label: 'English',
                //     isSelected: selectedLanguage == "en-US",
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     shouldRenderFirstWidget = false;
                //     selectedLanguage = "ja-JP";
                //     isSpeaking = true;
                //     texts = jTexts;
                //     _speak(texts[currentIndex]);
                //     _startImageRotation();
                //   },
                //   child: LanguageOptionWidget(
                //     label: '日本語',
                //     isSelected: selectedLanguage == "ja-JP",
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
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
                      color: Colors.transparent,
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
                          primary: Color.fromARGB(255, 118, 224, 122)
                              .withOpacity(0.4),
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

  Widget subWayWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            imagePathsListSubWay[currentIndex][rotator],
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
                      color: Colors.transparent,
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
                            _speak(subWaytexts[currentIndex]);
                            currentIndex++;
                            rotator = 0;
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 70.0, // Adjust the size as needed
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 118, 224, 122)
                              .withOpacity(0.4),
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

Future<void> _launchURL() async {
  final jwt = JWT(
    {
      'iss': 'straw-hat@devposthackathon.iam.gserviceaccount.com',
      'aud': 'google',
      'origins': [],
      'typ': 'savetowallet',
      'payload': {
        'genericObjects': [
          {
            'id': '3388000000022321421.123123123123121',
            'classId': '3388000000022321421.Starsefdsfs77',
            'genericType': 'GENERIC_TYPE_UNSPECIFIED',
            'hexBackgroundColor': '#4285f4',
            'logo': {
              'sourceUri': {
                'uri':
                    'https://res.cloudinary.com/parc-india/image/upload/v1642349740/Screen_Shot_2022-01-16_at_9.44.45_PM_hgazpj.png'
              }
            },
            'cardTitle': {
              'defaultValue': {'language': 'en', 'value': 'Straw hat labs'}
            },
            'subheader': {
              'defaultValue': {'language': 'en', 'value': 'Entire day'}
            },
            'header': {
              'defaultValue': {'language': 'en', 'value': 'Subway pass'}
            }
          }
        ]
      }
    },
    issuer: getIssuerForPass,
  );

  String pem = getPrivateKey();

  final pkey = RSAPrivateKey(pem);

  String token = jwt.sign(pkey, algorithm: JWTAlgorithm.RS256);

  final Uri _url = Uri.parse('https://pay.google.com/gp/v/save/$token');
  // print(uri)
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

String get getIssuerForPass =>
    'straw-hat@devposthackathon.iam.gserviceaccount.com';

String getPrivateKey() {
  const pem = '''-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5PHHiqp78VQEt
FUrs7WUT8NQmNwGWgot5+cHFmd9zQFP9qxtnFbKJL7ZmybiKbeH+vIGsa+sFpOwB
S3nfvnkyurJfzIoPujY348FmqtCBkUIN+HhW39NIe2hhwN9U6wtWtbRxDaPDXAia
h64j9yWwlO/BAJmMXHtcrKsxPUMWaLtKqqCJpck0t956Nb7SngMoq3Fvwvgc6LMk
iA3Nn5x/CbbrkRxsiDEJMbFTNLAGIhYhugM/Unjv9vMKnrvF2fEgYuBp26i9hSbH
V1xBbcdUuEumL0MZqiWs0KKeezDeJg1oUDXf0T85RzuhA3/CZw/eQCCG+mKNg9F2
37Vfop9JAgMBAAECggEAJ10f+oI1rPvHdzQqKvU74KPyAXj4/moZh786nWpYoN5P
uv1solhrC1o3UdqWO9ykBQU8LU71r8pfWNsYOCL7EHu6Qj9uK29v7CqbQ90S2CXt
OpjNwfBoruOCyBs7mokkbLXKdafnYDGjpmsk54Gy4baUyJf/CWPx1zzeWGVjZ1RX
ix+qv1tuznBUQyt3VkUHMAzEi5j1qe5MwYUK9Wfj+k0tA4/Dxi70Vqr0CEhcXmAY
8h3Vat8XIovLwGeiKQhqyI22wU+okg8fHwtmPTKtVNmFGBUzVpfLQog62XGOmwxm
ROwfIA4P0K3MX4dCp5AUE0gVnADrBm/+QWnVtOBAcQKBgQDpRLiDlplcnjZcOa0O
lzFMC9cqvSOZtCXd6ynFARM0xkFWib2h7E2x04cEkn2AJ8o7WvsubxMhgaNul7N/
iT3VSDGOHv6IGHfizIeQRNAO/OQbH1jaQICWmejBWkLE+rD9Ua0tASY4eRcsgh62
sKbK9AjBSCANS0d94/K5lMRXzQKBgQDLSXnKLUJ2hC1O8KJgYzIWjFnYEh+0PBgz
38MLFXiLyGwv6i9AYR0O9dvjRKa0g8THH13zXnmAK9KxpT2TBbGG02LMh4Psicd8
Xw4fnKXC8Ib4OzXbdgvpgVCXulU0wEZeKtlxdSeLosQVtrIDHx6ODGvj4p901OuQ
QyqdXycxbQKBgCLf2U4jB86nAK2NGehihkY+Ru7m1Bm4qyigbeA8Juju8vnDIgzB
TWRWoYr3c7fjOwLguUjZ5lxOC2cPWxCoLgxi/LWowJkMP3Ay79mL0CdNe7TqXNhU
aGUboYa2veDBMhDNUzy1PUeYIvTOh1T82BLjpSNwawpRxOB3YeSI70nJAoGBAL8v
xz8B+fQEs6f+YHhOUpkqPoUb5n1X11tSItmVw92TDUyy7uWZb/7V84t20WIMW1D6
ix2LyLFmha1VPue6/w9SVyUMfmJD4j1yGJJafPstw4JKDYjtKJ7fY7CPKfuGqad+
nSo7iImm9suFGz4cUlw+Cmo0hMsYRMNUqAuBphaxAoGAOq6IpyYQI0ivSluXwpFV
F8aiZsH6AVadAEMqPl3ue2khYFJHHFFnZb6lm2N3rCwlLct2sJSBu5vYRbhld7qy
EZW1R276C15ZWzTgdiIgd+4YRlAWJbhp7dROf8hlFkUN+R0JDQFL7fk+lGLn2ZoL
9U+gS/j67Cz3C3R1aXe/yss=
-----END PRIVATE KEY-----''';
  return pem;
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
    this.stackHeight = 75,
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
    return AvatarGlow(
      startDelay: const Duration(milliseconds: 1000),
      glowColor: Colors.white,
      glowShape: BoxShape.circle,
      animate: true,
      curve: Curves.easeInBack,
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 50.0,
        ),
      ),
    );

    // return CircleAvatar(
    //   radius: radius.toDouble() + 2,
    //   backgroundColor: Colors.white,
    //   child: CircleAvatar(
    //     radius: radius.toDouble(),
    //     backgroundImage: NetworkImage(imageUrl),
    //     child: child,
    //   ),
    // );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: isSelected
                    ? CountryFlag.fromLanguageCode('en-us')
                    : CountryFlag.fromCountryCode('jp'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: isSelected ? Color.fromARGB(255, 132, 219, 146) : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Item> _itemsBackup = [
  const Item(
    name: 'Aluminium can',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: AssetImage('assets/alum_can.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oops! Looks like this can needs a different destination. Think about where you'd recycle it.",
  ),
  const Item(
    name: 'Band-Aids',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: AssetImage('assets/band_aids.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Uh-oh! Seems like this item is more suited for a specific bin. Consider its material and its journey after disposal.",
  ),
  const Item(
    name: 'Burger',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: AssetImage('assets/burger.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, looks like this burger's journey has been cut short! Consider where its remaining 'half' belongs",
  ),
  const Item(
    name: 'Cardboard Box',
    totalPriceCents: 1499,
    uid: '4',
    imageProvider: AssetImage('assets/cardboard_box.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hmm, this one might need a sturdier home. Think about where you'd put it for a new life.",
  ),
  const Item(
    name: 'Charging Cable',
    totalPriceCents: 1499,
    uid: '5',
    imageProvider: AssetImage('assets/charging_cable.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoopsie! This item needs a charge of its own, but in a different bin. Consider its technological nature.",
  ),
  const Item(
    name: 'Disposable Cup',
    totalPriceCents: 1499,
    uid: '6',
    imageProvider: AssetImage('assets/disposable_cup.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh dear, this cup's journey might be a bit different than you think. Reflect on its composition.",
  ),
  const Item(
    name: 'Egg Shells',
    totalPriceCents: 1499,
    uid: '7',
    imageProvider: AssetImage('assets/egg_shells.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hm, this one's a bit 'shell'-shocked! Imagine where it belongs after its 'cracking' adventure.",
  ),
  const Item(
    name: 'Food Leftover',
    totalPriceCents: 1499,
    uid: '8',
    imageProvider: AssetImage('assets/food_leftover.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Ah, leftovers from a journey! But perhaps a different destination awaits them. Consider their origins.",
  ),
  const Item(
    name: 'Fruit Scraps',
    totalPriceCents: 1499,
    uid: '9',
    imageProvider: AssetImage('assets/fruit_scraps.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hmm, these scraps may lead to a fruitful destination elsewhere. Ponder their potential.",
  ),
  const Item(
    name: 'Game Console',
    totalPriceCents: 1499,
    uid: '10',
    imageProvider: AssetImage('assets/game_console.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoa, a gaming device! But its journey might be to a different bin. Imagine where it 'resets'.",
  ),
  const Item(
    name: 'Keyboard',
    totalPriceCents: 1499,
    uid: '11',
    imageProvider: AssetImage('assets/keyboard.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Oops, seems like this keyboard needs a different key to its journey. Reflect on its functionality.",
  ),
  const Item(
    name: 'Mask',
    totalPriceCents: 1499,
    uid: '12',
    imageProvider: AssetImage('assets/mask.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Ah, a mask! But perhaps a different bin awaits it for a new journey. Consider its protective purpose.",
  ),
  const Item(
    name: 'Mouse',
    totalPriceCents: 1499,
    uid: '13',
    imageProvider: AssetImage('assets/mouse.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Squeak! This mouse's journey might lead it to a different bin. Imagine where it 'clicks'.",
  ),
  const Item(
    name: 'Newspapers',
    totalPriceCents: 1499,
    uid: '14',
    imageProvider: AssetImage('assets/newspaper.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hm, this news needs a new destination. Think about where it belongs after being 'read'.",
  ),
  const Item(
    name: 'Plastic Bottle',
    totalPriceCents: 1499,
    uid: '15',
    imageProvider: AssetImage('assets/pastic_bottle.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh, a bottle! But where does it go after quenching its thirst? Imagine its next adventure.",
  ),
  const Item(
    name: 'Broken Phone',
    totalPriceCents: 1499,
    uid: '16',
    imageProvider: AssetImage('assets/phone.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Uh-oh, this phone's journey might need a new 'connection'. Think about where its 'broken' parts should go for a new life",
  ),
  const Item(
    name: 'Sanitary Napkins',
    totalPriceCents: 1499,
    uid: '17',
    imageProvider: AssetImage('assets/sanitary_napkins.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Whoops, this item might need a different destination. Reflect on its hygiene purpose.",
  ),
  const Item(
    name: 'Tampons',
    totalPriceCents: 1499,
    uid: '18',
    imageProvider: AssetImage('assets/tampons.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Hmm, these might need a different bin for their next 'cycle'. Imagine where they belong.",
  ),
  const Item(
    name: 'Tea Bags',
    totalPriceCents: 1499,
    uid: '19',
    imageProvider: AssetImage('assets/tea_bags.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, these bags might need a different brew of a bin. Ponder their compostable potential",
  )
];

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final CountryFlag icon;
}

abstract class MenuItems {
  static final List<MenuItem> firstItems = [english, japanese];

  static final english =
      MenuItem(text: 'English', icon: CountryFlag.fromLanguageCode('en-us'));
  static final japanese =
      MenuItem(text: '日本語', icon: CountryFlag.fromCountryCode('jp'));

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        SizedBox(
          width: 25,
          height: 15,
          child: item.icon,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// class FirstWidget extends StatefulWidget {
// static const colorizeColors = [
//   Colors.purple,
//   Colors.blue,
//   Colors.yellow,
//   Colors.red,
// ];

// static const colorizeTextStyle = TextStyle(
//   fontSize: 50.0,
//   fontFamily: 'Horizon',
// );

//   @override
//   State<FirstWidget> createState() => _FirstWidgetState();
// }

// class _FirstWidgetState extends State<FirstWidget> {
//   var isEnglish = true;
//   List<String> imagePaths = [
//     "assets/image1.jpg",
//     "assets/image2.jpg",
//     "assets/image3.jpg",
//     "assets/image4.jpg",
//     "assets/image4.jpg",
//     "assets/image4.jpg",
//     "assets/image4.jpg"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.all(0),
//       contentPadding: EdgeInsets.zero,
//       // title: Text('Urban Eco-Adventures'),
//       backgroundColor: Colors.indigo.shade50,
//       content: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: ExactAssetImage("assets/background.png"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
//               ),
//             ),
//           ),
//           Container(
//             width:
//                 double.maxFinite, // Set width to take up the full screen width
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: 500,
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       ColorizeAnimatedText(
//                         'Urban Eco Adventures',
//                         textStyle: FirstWidget.colorizeTextStyle,
//                         colors: FirstWidget.colorizeColors,
//                       ),
//                     ],
//                     isRepeatingAnimation: true,
//                     onTap: () {
//                       print("Tap Event");
//                     },
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Swiper(
//                       itemBuilder: (BuildContext context, int index) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: SizedBox.fromSize(
//                             size: Size.fromRadius(50), // Image radius
//                             child: Image.asset(imagePaths[index],
//                                 fit: BoxFit.cover),
//                           ),
//                         );
//                         // )
//                       },
//                       axisDirection: AxisDirection.right,
//                       loop: true,
//                       autoplay: true,
//                       itemCount: 3,
//                       itemWidth: 300.0,
//                       itemHeight: 200.0,
//                       layout: SwiperLayout.STACK,
//                     )),
//                 SizedBox(height: 30.0),
//                 Text(
//                   'Embark on a Sustainable Journey!',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                   ),
//                 ),
//                 Text(
//                   'Explore, Learn, Collect Rewards for your Google Wallet',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//                 const AvatarStack(
//                   avatars: [
//                     '/assets/newspaper.png',
//                     '/assets/pastic_bottle.png',
//                     '/assets/phone.png',
//                     '/assets/tea_bags.png'
//                   ],
//                 ),
//                 SizedBox(height: 60.0),
//                 Text(
//                   'Language Settings / 言語の設定',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 DropdownButtonHideUnderline(
//                   child: DropdownButton2(
//                     customButton: SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 30,
//                             height: 20,
//                             child: isEnglish
//                                 ? CountryFlag.fromLanguageCode('en-us')
//                                 : CountryFlag.fromCountryCode('jp'),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             child: isEnglish
//                                 ? Text(
//                                     "English",
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 : Text(
//                                     "日本語",
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     items: [
//                       ...MenuItems.firstItems.map(
//                         (item) => DropdownMenuItem<MenuItem>(
//                           value: item,
//                           child: MenuItems.buildItem(item),
//                         ),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       if (value == MenuItems.english) {
//                         setState(() {
//                           isEnglish = true;
//                         });
//                       } else {
//                         setState(() {
//                           isEnglish = false;
//                         });
//                       }
//                     },
//                     dropdownStyleData: DropdownStyleData(
//                       width: 160,
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         color: Colors.black12,
//                       ),
//                       offset: const Offset(0, 8),
//                     ),
//                     menuItemStyleData: MenuItemStyleData(
//                       customHeights: [
//                         ...List<double>.filled(MenuItems.firstItems.length, 48),
//                       ],
//                       padding: const EdgeInsets.only(left: 16, right: 16),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 90.0),
//                 Container(
//                   width: 300.0,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.green.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(
//                         300.0), // Adjust the value as needed
//                     border: Border.all(
//                         color: Colors.white12,
//                         width: 7.0), // Optional: Add border color and width
//                   ),
//                   child: ElevatedButton(
//                     // style: Stylel
//                     style: ElevatedButton.styleFrom(
//                       primary:
//                           Color.fromARGB(255, 118, 224, 122).withOpacity(0.4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                     ),
//                     onPressed: () {
//                       // shouldRenderFirstWidget = false;
//                       // selectedLanguage = "ja-JP";
//                       // isSpeaking = true;
//                       // texts = jTexts;
//                       // _speak(texts[currentIndex]);
//                       // _startImageRotation();
//                       // print("Adding qr to wallet");
//                       //Navigator.of(context).restorablePush(_dialogBuilder);
//                       // _launchURL();
//                     },
//                     child: Center(
//                       child: Text(
//                         'START',
//                         style: TextStyle(
//                           fontSize: 36.0,
//                           color: Colors.white70,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: GoogleFonts.poppins().fontFamily,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     shouldRenderFirstWidget = false;
//                 //     setState(() {
//                 //       selectedLanguage = "en-US";
//                 //       isSpeaking = true;
//                 //       _speak(texts[currentIndex]);
//                 //       _startImageRotation();
//                 //     });
//                 //   },
//                 //   child: LanguageOptionWidget(
//                 //     label: 'English',
//                 //     isSelected: selectedLanguage == "en-US",
//                 //   ),
//                 // ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     shouldRenderFirstWidget = false;
//                 //     selectedLanguage = "ja-JP";
//                 //     isSpeaking = true;
//                 //     texts = jTexts;
//                 //     _speak(texts[currentIndex]);
//                 //     _startImageRotation();
//                 //   },
//                 //   child: LanguageOptionWidget(
//                 //     label: '日本語',
//                 //     isSelected: selectedLanguage == "ja-JP",
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
