import 'package:flutter/material.dart';

@immutable
class StreamUser {
  final String id;
  final String name;
  final String image;

  const StreamUser({required this.id, required this.name, required this.image});
}

/// Demo users for testing. The ids should match those of the users you
/// created on the Stream dashboard.
const testUsers = [
  StreamUser(
    id: 'souvik-biswas',
    name: 'Souvik Biswas',
    image: 'https://avatars.githubusercontent.com/u/43280874?v=4',
  ),
  StreamUser(
    id: 'gordon-hayes',
    name: 'Gordon Hayes',
    image: 'https://avatars.githubusercontent.com/u/13705472?v=4',
  )
];
