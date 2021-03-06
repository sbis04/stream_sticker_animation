import 'package:flutter/material.dart';

/// The list of artboards and the reaction type in the `stream_reactions.riv` file.
/// This is used for custom reactions.
const riveStreamReactionAnimations = [
  RiveStreamReaction(
    type: 'love',
    artboard: 'love',
    artboardHighlighted: 'love_highlight',
  ),
  RiveStreamReaction(
    type: 'like',
    artboard: 'like',
    artboardHighlighted: 'like_highlight',
  ),
  RiveStreamReaction(
    type: 'sad',
    artboard: 'sad',
    artboardHighlighted: 'sad_highlight',
  ),
  RiveStreamReaction(
    type: 'haha',
    artboard: 'haha',
    artboardHighlighted: 'haha_highlight',
  ),
  RiveStreamReaction(
    type: 'wow',
    artboard: 'wow',
    artboardHighlighted: 'wow_highlight',
  ),
];
const riveStreamReactionAnimations2 = [
  RiveStreamReaction(
    type: 'Mindblown',
    artboard: 'Mindblown',
    artboardHighlighted: 'Mindblown',
  ),
  RiveStreamReaction(
    type: 'Onfire',
    artboard: 'Onfire',
    artboardHighlighted: 'Onfire',
  ),
  RiveStreamReaction(
    type: 'love',
    artboard: 'love',
    artboardHighlighted: 'love',
  ),
  RiveStreamReaction(
    type: 'joy',
    artboard: 'joy',
    artboardHighlighted: 'joy',
  ),
  RiveStreamReaction(
    type: 'Tada',
    artboard: 'Tada',
    artboardHighlighted: 'Tada',
  ),
];

@immutable
class RiveStreamReaction {
  final String type;
  final String artboard;
  final String artboardHighlighted;

  const RiveStreamReaction({
    required this.type,
    required this.artboard,
    required this.artboardHighlighted,
  });
}