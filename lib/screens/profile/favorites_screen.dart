import 'package:bazar/data/dummy_data.dart';
import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/screens/home/book_detail_screen.dart';
import 'package:bazar/state/favorites_store.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  List<BookModel> get _favoriteBooks {
    return topOfWeekBooks
        .where((book) => favoritesStore.isFavorite(book.id))
        .toList();
  }

  void _openBook(BuildContext context, BookModel book) {
    showBookDetailSheet(context, book);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Your Favorites',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: SafeArea(
          child: ListenableBuilder(
            listenable: favoritesStore,
            builder: (context, child) {
              final favorites = _favoriteBooks;
              if (favorites.isEmpty) {
                return const Center(
                  child: Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: favorites.length,
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.inputBorder,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final book = favorites[index];
                  return _FavoriteRow(
                    book: book,
                    onTap: () => _openBook(context, book),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({required this.book, required this.onTap});

  final BookModel book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                book.imagePath,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  width: 44,
                  height: 44,
                  color: AppColors.cardBackground,
                  child: const Icon(
                    Icons.book,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.price,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => favoritesStore.toggle(book.id),
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.favorite,
                size: 20,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}