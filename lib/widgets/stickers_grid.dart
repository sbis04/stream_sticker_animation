import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'animated_sticker.dart';

class StickersGrid extends StatefulWidget {
  const StickersGrid({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  _StickersGridState createState() => _StickersGridState();
}

class _StickersGridState extends State<StickersGrid> {
  static late Future<RiveFile> riveFile = loadRiveFile();

  static Future<RiveFile> loadRiveFile() async {
    return await RiveFile.asset('assets/stream_animation.riv');
  }

  Future<void> sendSticker(String artboardName) async {
    await widget.channel.sendMessage(
      Message(
        attachments: [
          Attachment(
            uploadState: const UploadState.success(),
            type: 'sticker',
            extraData: {
              'artboard': artboardName,
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
            child: Text(
              'Stickers',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder<List<Artboard>>(
              future: riveFile.then((value) => value.artboards),
              builder: (context, snapshot) {
                final artboards = snapshot.data ?? [];
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (artboards.isEmpty) {
                        return const Center(child: Text('No stickers'));
                      }
                      return Scrollbar(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: artboards.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              sendSticker(snapshot.data![index].name);
                            },
                            child: AnimatedSticker(
                              artboard: artboards[index].name,
                            ),
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}