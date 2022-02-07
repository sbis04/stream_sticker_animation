import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_sticker_animation/widgets/animated_sticker.dart';
import 'package:stream_sticker_animation/widgets/stickers_grid.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: (context, details, messages, defaultMessage) {
                final attachments = details.message.attachments;
                if (attachments.isNotEmpty &&
                    attachments[0].type == 'sticker') {
                  return defaultMessage.copyWith(
                    messageTheme:
                        StreamChatTheme.of(context).ownMessageTheme.copyWith(
                              messageBackgroundColor: Colors.transparent,
                              messageBorderColor: Colors.transparent,
                            ),
                    customAttachmentBuilders: {
                      'sticker': (context, message, attachments) {
                        return SizedBox(
                          height: 130,
                          width: 130,
                          child: AnimatedSticker(
                            artboard:
                                attachments[0].extraData['artboard'] as String,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return defaultMessage;
                }
              },
            ),
          ),
          MessageInput(
            actions: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.smiley,
                  color: Colors.grey,
                ),
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints.tightFor(
                  height: 24,
                  width: 24,
                ),
                splashRadius: 24,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => StickersGrid(
                      channel: channel,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
