class ProductAttributeModel {
  String? name;
   List<String>? values;
  ProductAttributeModel({this.name, this.values});

  toJson() {
    return {'Name': name, 'Values': values};
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> documents) {
    if (documents.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
        name: documents.containsKey('Name') ? documents['Name'] : '',
        values: List<String>.from(
          documents["Values"],
        ));
  }
}
