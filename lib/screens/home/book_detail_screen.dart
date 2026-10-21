import 'package:bazar/data/dummy_data.dart';
import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/state/favorites_store.dart';
import 'package:flutter/material.dart';

void showBookDetailSheet(BuildContext context, BookModel book) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BookDetailSheet(book: book),
  );
}

class BookDetailSheet extends StatefulWidget {
  const BookDetailSheet({required this.book, super.key});

  final BookModel book;

  @override
  State<BookDetailSheet> createState() => _BookDetailSheetState();
}

class _BookDetailSheetState extends State<BookDetailSheet> {
  int _quantity = 1;

  bool get _isFavorite => favoritesStore.isFavorite(widget.book.id);

  void _toggleFavorite() {
    favoritesStore.toggle(widget.book.id);
    setState(() {});
  }

  double get _unitPrice {
    return double.tryParse(widget.book.price.replaceAll('\$', '').trim()) ?? 0;
  }

  String get _totalPrice {
    return '\$${(_unitPrice * _quantity).toStringAsFixed(2)}';
  }

  String get _vendorLogoPath {
    for (final vendor in vendors) {
      if (vendor.name == widget.book.vendorName) {
        return vendor.logoPath;
      }
    }
    return 'assets/images/vendors/gooday_logo.png';
  }

  void _decrease() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _increase() {
    setState(() => _quantity++);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.book.imagePath,
                      height: 260,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        height: 260,
                        width: 200,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.book,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _toggleFavorite,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    _vendorLogoPath,
                    height: 22,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stack) => Text(
                      widget.book.vendorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vendorName,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.book.description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Review',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildStars(),
                    const SizedBox(width: 8),
                    Text(
                      '(${widget.book.rating.toStringAsFixed(1)})',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildStepperButton(icon: Icons.remove, onTap: _decrease),
                    const SizedBox(width: 16),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildStepperButton(icon: Icons.add, onTap: _increase),
                    const Spacer(),
                    Text(
                      _totalPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _pillButton(
                        label: 'Continue shopping',
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _pillButton(
                        label: 'View cart',
                        backgroundColor: const Color(0xFFECE6FF),
                        foregroundColor: AppColors.primary,
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cart is not built yet'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStars() {
    final rating = widget.book.rating;
    final fullStars = rating.floor();
    final hasHalf = rating - fullStars >= 0.5;

    return Row(
      children: List.generate(5, (i) {
        final IconData icon;
        if (i < fullStars) {
          icon = Icons.star;
        } else if (i == fullStars && hasHalf) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, size: 18, color: AppColors.rating);
      }),
    );
  }

  Widget _buildStepperButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFECE6FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }

  Widget _pillButton({
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}