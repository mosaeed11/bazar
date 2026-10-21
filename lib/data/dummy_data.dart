class BookModel {
  final String id;
  final String title;
  final String price;
  final String imagePath;
  final String vendorName;
  final String description;
  final double rating;

  const BookModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.vendorName,
    required this.description,
    required this.rating,
  });
}

class AuthorModel {
  final String name;
  final String role;
  final String imagePath;

  const AuthorModel({
    required this.name,
    required this.role,
    required this.imagePath,
  });
}

class VendorModel {
  final String name;
  final String logoPath;

  const VendorModel({required this.name, required this.logoPath});
}

class SpecialOfferModel {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final String imagePath;

  const SpecialOfferModel({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.imagePath,
  });
}

class CategoryItemModel {
  final String title;
  final String price;
  final String imagePath;

  const CategoryItemModel({
    required this.title,
    required this.price,
    required this.imagePath,
  });
}

class UserModel {
  final String name;
  final String phone;
  final String avatarPath;

  const UserModel({
    required this.name,
    required this.phone,
    required this.avatarPath,
  });
}

class OrderModel {
  final String title;
  final String imagePath;
  final String status;
  final int itemsCount;

  const OrderModel({
    required this.title,
    required this.imagePath,
    required this.status,
    required this.itemsCount,
  });

  bool get isDelivered => status == 'Delivered';
}

const List<BookModel> topOfWeekBooks = [
  BookModel(
    id: 'kite_runner',
    title: 'The Kite Runner',
    price: '\$14.99',
    imagePath: 'assets/images/books/kite_runner.png',
    vendorName: 'GooDay',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.',
    rating: 4.0,
  ),
  BookModel(
    id: 'subtle_art',
    title: 'The Subtle Art of Not Giving a F*ck',
    price: '\$20.99',
    imagePath: 'assets/images/books/subtle_art.jpg',
    vendorName: 'GooDay',
    description: 'Lorem ipsum dolor sit amet...',
    rating: 4.5,
  ),
  BookModel(
    id: 'art_of_war',
    title: 'The Art of War',
    price: '\$14.99',
    imagePath: 'assets/images/books/art_of_war.jpg',
    vendorName: 'GooDay',
    description: 'Lorem ipsum dolor sit amet...',
    rating: 4.0,
  ),
];

const List<AuthorModel> authors = [
  AuthorModel(
    name: 'John Freeman',
    role: 'Writer',
    imagePath: 'assets/images/authors/john_freeman.png',
  ),
  AuthorModel(
    name: 'Tess Gunty',
    role: 'Novelist',
    imagePath: 'assets/images/authors/tess_gunty.png',
  ),
  AuthorModel(
    name: 'Richard Per...',
    role: 'Writer',
    imagePath: 'assets/images/authors/richard_per.png',
  ),
  AuthorModel(
    name: 'Richard Per...',
    role: 'Writer',
    imagePath: 'assets/images/authors/richard_per.png',
  ),
];

const List<VendorModel> vendors = [
  VendorModel(
    name: 'WS Warehouse',
    logoPath: 'assets/images/vendors/ws_logo.png',
  ),
  VendorModel(
    name: 'Kuromi',
    logoPath: 'assets/images/vendors/kuromi.png',
  ),
  VendorModel(
    name: 'GooDay',
    logoPath: 'assets/images/vendors/gooday_logo.png',
  ),
  VendorModel(
    name: 'CRANE & CO',
    logoPath: 'assets/images/vendors/crane_logo.png',
  ),
  VendorModel(
    name: 'CRANE & CO',
    logoPath: 'assets/images/vendors/crane_logo.png',
  ),
];

const List<SpecialOfferModel> specialOffers = [
  SpecialOfferModel(
    title: 'Special Offer',
    subtitle: 'Discount 25%',
    buttonLabel: 'Order Now',
    imagePath: 'assets/images/banners/banner_1.png',
  ),
  SpecialOfferModel(
    title: 'Special Offer',
    subtitle: 'Discount 25%',
    buttonLabel: 'Order Now',
    imagePath: 'assets/images/banners/banner_1.png',
  ),
  SpecialOfferModel(
    title: 'Special Offer',
    subtitle: 'Discount 25%',
    buttonLabel: 'Order Now',
    imagePath: 'assets/images/banners/banner_1.png',
  ),
];

const List<String> categoryTabs = [
  'All',
  'Novels',
  'Self Love',
  'Science',
  'Romance',
];

const List<CategoryItemModel> categoryItems = [
  CategoryItemModel(
    title: 'In in amet ultrices sit.',
    price: '\$19.99',
    imagePath: 'assets/images/categories/ln_in_amet.png',
  ),
  CategoryItemModel(
    title: 'Bibendum facilisis.',
    price: '\$27.12',
    imagePath: 'assets/images/categories/bibendum.png',
  ),
  CategoryItemModel(
    title: 'Nulla et diam cras.',
    price: '\$13.52',
    imagePath: 'assets/images/categories/nulla.png',
  ),
  CategoryItemModel(
    title: 'Risus malesuada in.',
    price: '\$31.00',
    imagePath: 'assets/images/categories/risus.png',
  ),
];

const UserModel currentUser = UserModel(
  name: 'John Doe',
  phone: '(+1) 234 567 890',
  avatarPath: 'assets/images/authors/john_freeman.png',
);

const String orderHistoryMonth = 'October 2021';

const List<OrderModel> orders = [
  OrderModel(
    title: 'The Da vinci Code',
    imagePath: 'assets/images/categories/ln_in_amet.png',
    status: 'Delivered',
    itemsCount: 1,
  ),
  OrderModel(
    title: 'Carrie Fisher',
    imagePath: 'assets/images/categories/bibendum.png',
    status: 'Delivered',
    itemsCount: 5,
  ),
  OrderModel(
    title: 'The Waiting',
    imagePath: 'assets/images/categories/nulla.png',
    status: 'Cancelled',
    itemsCount: 2,
  ),
];
