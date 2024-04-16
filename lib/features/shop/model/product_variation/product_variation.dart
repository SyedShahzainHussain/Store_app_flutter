
class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = "",
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: "", attributeValues: {});

  toJson() {
    return {
      "Id": id,
      "Image": image,
      "Description": description,
      "Price": price,
      "SalePrice": salePrice,
      "SKU": sku,
      "Stock": stock,
      "AttributeValues": attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> documents) {
    final data = documents;
    if (data.isEmpty) return empty();
    return ProductVariationModel(
        stock: data["Stock"] ?? 0,
        description: data["Description"] ?? "",
        image: data["Image"] ?? "",
        price: double.parse((data["Price"] ?? 0.0).toString()),
        salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
        sku: data["SKU"] ?? "",
        id: data["Id"] ?? "",
        attributeValues: Map<String, String>.from(data["AttributeValues"]));
  }
}
