// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CommunityProvider extends ChangeNotifier {
  int containerTappedIndex = 0;
  void toggleContainerTapped(int index) {
    containerTappedIndex = index;
    notifyListeners();
  }
}
