// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notes {
  String title;
  String content;
  DateTime dateTime;
  Notes({
    required this.title,
    required this.content,
    required this.dateTime,
  });
}

List<Notes> sampleNotes = [
  Notes(
      title: 'Sweet Like Cinamide',
      content: 'There was an issue that too ',
      dateTime: DateTime(4, 505, 6, 6, 44)),
  Notes(
      title: 'Sweet Like Cinamide',
      content: 'There was an issue that too ',
      dateTime: DateTime(4, 505, 6, 6, 44)),
  Notes(
      title: 'Sweet Like Cinamide',
      content: 'There was an issue that too ',
      dateTime: DateTime(4, 505, 6, 6, 44)),
  Notes(
      title: 'Sweet Like Cinamide',
      content: 'There was an issue that too ',
      dateTime: DateTime(4, 505, 6, 6, 44)),
  Notes(
      title: 'Sweet Like Cinamide',
      content: 'There was an issue that too ',
      dateTime: DateTime(4, 505, 6, 6, 44)),
];
