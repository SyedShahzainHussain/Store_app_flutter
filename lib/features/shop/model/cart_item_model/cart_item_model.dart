class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = "",
    this.title = "",
    this.price = 0.0,
    this.brandName,
    this.image,
    this.selectedVariation,
  });

  @override
  String toString() {
    return "ProductId:$productId Title:$title";
  }

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      "ProductId": productId,
      "Quantity": quantity,
      "VariationId": variationId,
      "Title": title,
      "Price": price,
      "BrandName": brandName,
      "Image": image,
      "SelectedVariation": selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
  // Convert selectedVariation to Map<String, String> explicitly
  Map<String, String>? selectedVariation;
  if (json["SelectedVariation"] != null) {
    selectedVariation = Map<String, String>.from(json["SelectedVariation"]);
  }

  return CartItemModel(
    productId: json["ProductId"],
    quantity: json["Quantity"],
    brandName: json["BrandName"],
    image: json["Image"],
    price: json["Price"],
    selectedVariation: selectedVariation,
    title: json["Title"],
    variationId: json["VariationId"],
  );
}
}
