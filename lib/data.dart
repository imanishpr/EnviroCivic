import 'package:chatview/chatview.dart';

class Data {
  static const profileImage =
      "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png";
  static final messageListOriginal = [
    Message(
      id: '0',
      message: "Hey Mom, Did you see this?",
      createdAt: DateTime.now(),
      sendBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
  ];
  static final messageListGreen = [
    Message(
      id: '1',
      message:
          "Congratulations, Emi! Kumo is such a special companion. He's known as the Roaming Companion in the city. People adore him for his loyalty and friendly nature.",
      createdAt: DateTime.now(),
      sendBy: '2', // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message: "That's so cool! What does Kumo do in the city?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message: "We can meet?I am free",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message:
          "Well, Kumo is always on the move, trotting through the streets and alleys, spreading joy wherever he goes. His wagging tail is like a symbol of happiness, bringing warmth to everyone he meets.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message:
          "Aw, he sounds amazing! I can't wait to learn more about him. Do you think we'll get to see him around our neighborhood?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message:
          "Who knows, Emi? Maybe one day you'll spot him on one of our walks. But for now, cherish this card as a reminder of the importance of companionship and spreading positivity, just like Kumo does.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
  ];

  static final messageListBlue = [
    Message(
      id: '1',
      message:
          "Mom, check out the card I got for sorting all the dry waste! It's a cheetah named Zephyr.",
      createdAt: DateTime.now(),
      sendBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message:
          "Oh, well done, Emi! Zephyr is known as the Wanderer in the wild. He's quite a majestic creature.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message: "He looks so graceful! What does Zephyr do as the Wanderer?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message:
          "Zephyr roams through vast landscapes, his presence enigmatic and captivating. He's like a beacon amidst the horizon, leaving behind tales of mystery and wonder wherever he goes.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message:
          "Wow, that's incredible! I bet he sees so many amazing things on his travels. Do you think we'll ever get to see him in person?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message:
          "Who knows, Emi? Perhaps one day you'll catch a glimpse of him in the wilderness. But for now, let this card remind you of the beauty of nature and the adventures that await us beyond the city.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
  ];

  static final messageListRed = [
    Message(
      id: '1',
      message:
          "Mom, look at this card I received for sorting all the sanitary waste! It's a wolf named Fenrir.",
      createdAt: DateTime.now(),
      sendBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message:
          "Oh, well done, Emi! Fenrir is known as the Silent Stalker in the wild. He's quite a powerful and mysterious creature.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message:
          "He looks so intense! What does Fenrir do as the Silent Stalker?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message:
          "Fenrir prowls through the moonlit night with unmatched grace and stealth. His piercing gaze cuts through the darkness, guiding him through the untamed wilderness. He's a skilled hunter, and his howl echoes through the silent woods, striking fear into the hearts of prey.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message:
          "Wow, he sounds like a formidable predator. Do you think we'll ever encounter him in the wilderness?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message:
          "Who knows, Emi? Wolves like Fenrir are elusive creatures, preferring to remain hidden in the shadows. But let this card remind you of the balance and harmony of nature, even in its most fierce and untamed forms.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
  ];

  static final messageListGray = [
    Message(
      id: '1',
      message:
          "Mom, look what I got for sorting all the e-waste! It's a card of a bear named Ursula.",
      createdAt: DateTime.now(),
      sendBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message:
          "Oh, congratulations, Emi! Ursula is known as the Solitary Sentinel in the forest. She seems like a powerful and majestic creature.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message:
          "She looks so strong and serene! What does Ursula do as the Solitary Sentinel?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message:
          "Ursula stands tall amidst the dense forest, her formidable presence a testament to the strength and resilience of nature. She's like a guardian, with a watchful eye and a gentle spirit, protecting the secrets of the wilderness.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message:
          "That's incredible! I bet she's seen so much in her lifetime. Do you think we'll ever get to see her in person?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message:
          "Well, bears like Ursula are usually solitary creatures, preferring to roam their territories alone. But who knows, Emi? Maybe one day you'll catch a glimpse of her in the wild. Until then, let this card remind you of the beauty and majesty of nature, and the importance of protecting our environment.",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
  ];
}
