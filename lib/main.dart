import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_sticker_animation/secrets.dart';

import 'models/rive_stream_reactions.dart';
import 'screens/users_page.dart';

void main() {
  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.client,
  }) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Sticker Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      builder: (context, child) => StreamChat(
        client: client,
        child: child,
        streamChatThemeData: StreamChatThemeData(
          reactionIcons: riveStreamReactionAnimations
              .map(
                (reaction) => ReactionIcon(
                  type: reaction.type,
                  builder: (context, highlighted, size) {
                    return KeyedSubtree(
                      key: ValueKey('reaction-${reaction.type}'),
                      child: RiveAnimation.asset(
                        'assets/stream_reactions.riv',
                        artboard: highlighted
                            ? reaction.artboardHighlighted
                            : reaction.artboard,
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
      home: const UsersPage(),
    );
  }
}
