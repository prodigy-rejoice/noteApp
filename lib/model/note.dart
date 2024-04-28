import 'package:flutter/material.dart';

class Note {
  final String noteTitle;
  final String noteContent;
  Color noteColor;

  Note({required this.noteTitle, required this.noteContent, required this.noteColor});
  void toggleColor(Color color) {
    noteColor = color;
  }
}
