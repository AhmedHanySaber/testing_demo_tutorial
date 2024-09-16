import 'package:flutter/cupertino.dart';

class Favorites extends ChangeNotifier{
  final List<int> _favorites = [];

  List<int> get items => _favorites;

  void add(int item){
    _favorites.add(item);
    notifyListeners();
  }

  void remove(int item){
    _favorites.remove(item);
    notifyListeners();
  }
}