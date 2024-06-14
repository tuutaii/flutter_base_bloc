import 'package:flutter/cupertino.dart';
import 'package:flutter_base_bloc/screens/chat_box_screen.dart';

import '../core/config.dart';
import 'data.dart';

@RoutePage()
class NavigateScreen extends StatefulWidget {
  const NavigateScreen({super.key});

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> onlineUsers = [
      'User 1',
      'User 2',
      'User 3',
      'User 3',
      'User 3',
      'User 3'
    ];

    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UserSearch(onlineUsers));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 219, 219),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                cursorColor: Colors.black,
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onlineUsers.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(onlineUsers[index]),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userMessages.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChatBoxScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: Stack(
                              children: [
                                userMessages[index]['story']
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            width: 75,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    userMessages[index]['img']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                userMessages[index]['img']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                userMessages[index]['online']
                                    ? Positioned(
                                        top: 48,
                                        left: 52,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.amberAccent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userMessages[index]['name'],
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 135,
                                child: Text(
                                  userMessages[index]['message'] +
                                      " - " +
                                      userMessages[index]['created_at'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.8)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  final List<String> users;

  UserSearch(this.users);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = users
        .where((user) => user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}
