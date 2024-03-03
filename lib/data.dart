import 'package:chatview/chatview.dart';

class Data {
  static const profileImage =
      "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png";
  static final messageListOriginal = [
    Message(
      id: '0',
      message:
          " Wow, Mom! Look what I got for sorting all the wet waste correctly!",
      createdAt: DateTime.now(),
      sendBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
  ];
  static final messageList = [
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
}
