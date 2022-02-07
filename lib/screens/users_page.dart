import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_sticker_animation/models/stream_user.dart';

import 'channels_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool _isLoading = false;

  /// Method to connect a user.
  Future<void> _connectUser(StreamUser demoUser) async {
    setState(() {
      _isLoading = true;
    });

    final client = StreamChat.of(context).client;
    try {
      await client.connectUser(
        User(
          id: demoUser.id,
          name: demoUser.name,
          image: demoUser.image,
        ),
        client.devToken(demoUser.id).rawValue,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ChannelsPage()),
      );
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return UserTile(
                          demoUser: testUsers[index],
                          callback: _connectUser,
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                      ),
                      itemCount: testUsers.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

typedef UserTileCallback = void Function(StreamUser user);

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.demoUser,
    required this.callback,
  }) : super(key: key);

  final StreamUser demoUser;
  final UserTileCallback callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      leading: CircleAvatar(
        foregroundImage: Image.network(demoUser.image).image,
      ),
      title: Text(
        demoUser.name,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: () => callback(demoUser),
    );
  }
}
