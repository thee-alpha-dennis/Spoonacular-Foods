class CartItem {
  final int id;
  final String name;
  final String photo;
  final double price;
  int selectedQty;

  CartItem({
    required this.id,
    required this.name,
    required this.photo,
    this.price=230,
    this.selectedQty = 1,
  });

  CartItem copyWith({
    int? id,
    String? name,
    String? photo,
    double? price,
    int? selectedQty,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      price: price ?? this.price,
      selectedQty: selectedQty ?? this.selectedQty,
    );
  }
}
