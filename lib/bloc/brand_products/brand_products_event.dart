sealed class BrandProducts {}

class GetSpecificBrandProducts extends BrandProducts {
  String brandId;
  int? limit;
  GetSpecificBrandProducts(this.brandId, [this.limit = -1]);
}
