class ProductVariationModel {
  final String id;
  final String sku;
  final String image;
  final String? description;
  final double price;
  final double salePrice;
  final int stock;
  final Map<String, String> attributeValues;

  const ProductVariationModel({
    required this.id,
    this.sku = "",
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  @override
  String toString() {
    return "Id:$id,Attributes:$attributeValues";
  }

  static ProductVariationModel empty() => const ProductVariationModel(
      id: "",
      attributeValues: {},
      description: "",
      image: "",
      price: 0.0,
      salePrice: 0.0,
      sku: "",
      stock: 0);

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
