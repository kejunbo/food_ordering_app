import 'package:flutter/material.dart';

class ViewModel with ChangeNotifier{
  bool isLoading = false;

  setLoading(){
    isLoading = true;
    notifyListeners();
  }
  
  setIdle(){
    isLoading = false;
    notifyListeners();
  }
}