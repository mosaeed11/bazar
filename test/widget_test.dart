import 'package:bazar/data/dummy_data.dart';
import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/state/favorites_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoritesStore', () {
    setUp(() {
      favoritesStore.clear();
    });

    test('starts empty', () {
      expect(favoritesStore.favoriteIds, isEmpty);
      expect(favoritesStore.isFavorite('kite_runner'), isFalse);
    });

    test('toggle adds then removes the id', () {
      favoritesStore.toggle('kite_runner');
      expect(favoritesStore.isFavorite('kite_runner'), isTrue);

      favoritesStore.toggle('kite_runner');
      expect(favoritesStore.isFavorite('kite_runner'), isFalse);
    });

    test('notifies listeners on every change', () {
      var notifications = 0;
      void listener() => notifications++;
      favoritesStore.addListener(listener);

      favoritesStore.toggle('kite_runner');
      favoritesStore.toggle('art_of_war');
      favoritesStore.toggle('kite_runner');

      expect(notifications, 3);
      favoritesStore.removeListener(listener);
    });

    test('keeps ids independent from each other', () {
      favoritesStore.toggle('kite_runner');
      favoritesStore.toggle('art_of_war');

      expect(favoritesStore.isFavorite('kite_runner'), isTrue);
      expect(favoritesStore.isFavorite('art_of_war'), isTrue);
      expect(favoritesStore.isFavorite('subtle_art'), isFalse);
    });
  });

  group('Dummy data', () {
    test('book ids are unique', () {
      final ids = topOfWeekBooks.map((book) => book.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('books have an image and a price', () {
      for (final book in topOfWeekBooks) {
        expect(book.imagePath, isNotEmpty);
        expect(book.price, isNotEmpty);
      }
    });

    test('category items have unique images', () {
      final paths = categoryItems.map((item) => item.imagePath).toList();
      expect(paths.toSet().length, paths.length);
    });
  });

  group('AppColors', () {
    test('primary is the onboarding purple', () {
      expect(AppColors.primary, const Color(0xFF54408C));
    });
  });
}
