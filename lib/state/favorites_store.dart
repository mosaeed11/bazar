import 'package:flutter/foundation.dart';

class FavoritesStore extends ChangeNotifier {
  final Set<String> _favoriteIds = <String>{};

  List<String> get favoriteIds => List.unmodifiable(_favoriteIds);

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggle(String id) {
    if (!_favoriteIds.remove(id)) {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  void clear() {
    if (_favoriteIds.isEmpty) return;
    _favoriteIds.clear();
    notifyListeners();
  }
}

final FavoritesStore favoritesStore = FavoritesStore();