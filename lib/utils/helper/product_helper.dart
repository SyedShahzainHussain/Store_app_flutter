import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/utils/constants/enum.dart';

class ProductHelper {
  // ! Get the products price or price range for variations.
  static String getProductsPrice(ProductModel productModel) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exists, return the simple price or sale price

    if (productModel.productType == ProductType.single.toString()) {
      return (productModel.salePrice > 0
              ? productModel.salePrice
              : productModel.price)
          .toString();
    } else {
      // calculates the smalles and largest price among variation
      for (var variation in productModel.productVariationModel!) {
        double priceConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //  Update the smallest largest and smallest price
        if (priceConsider < smallestPrice) {
          smallestPrice = priceConsider;
        }
        if (priceConsider > largestPrice) {
          largestPrice = priceConsider;
        }
      }

      // If smallest and largest price are same return the single price
      if (smallestPrice == largestPrice) {
        return largestPrice.toString();
      } else {
        // Otherwise return a price range
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  // ! Calculated Discout Percentage
  static String? calculatedSalePercentage(
      double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // ! Check Product Stock Status
 static String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
