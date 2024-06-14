import 'package:flutter_base_bloc/core/extensions/context_extension.dart';

import '../core/config.dart';
import 'data.dart';

@RoutePage()
class ChatBoxScreen extends StatefulWidget {
  const ChatBoxScreen({super.key});

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final TextEditingController _sendMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.2),
        elevation: 0,
        leading: const BackButton(),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tyler Nix",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Active now",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: [
          Icon(
            Icons.phone,
            color: context.colorScheme.primary,
            size: 32,
          ),
          const SizedBox(
            width: 15,
          ),
          Icon(
            Icons.video_call,
            color: context.primary,
            size: 35,
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white38),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }

  Widget getBottom() {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle,
                    size: 35,
                    color: context.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: context.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.photo,
                    size: 35,
                    color: context.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.keyboard_voice,
                    size: 35,
                    color: context.primary,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 140) / 2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _sendMessageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Aa",
                          suffixIcon: Icon(
                            Icons.face,
                            color: context.primary,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.thumb_up,
                    size: 35,
                    color: context.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return ListView(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 80),
      children: List.generate(messages.length, (index) {
        return ChatBubble(
            isMe: messages[index]['isMe'],
            messageType: messages[index]['messageType'],
            message: messages[index]['message'],
            profileImg: messages[index]['profileImg']);
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble({
    Key? key,
    required this.isMe,
    required this.profileImg,
    required this.message,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: context.primary,
                    borderRadius: getMessageType(messageType)),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(profileImg), fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: getMessageType(messageType)),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  getMessageType(messageType) {
    if (isMe) {
      // start message
      if (messageType == 1) {
        return const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return const BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return const BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // standalone message
      else {
        return const BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else {
      // start message
      if (messageType == 1) {
        return const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // standalone message
      else {
        return const BorderRadius.all(Radius.circular(30));
      }
    }
  }
}
