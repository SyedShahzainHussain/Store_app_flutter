class TPricingCalculator {
  static double calculatedTotalAmount(double productPrice, String location) {
    double taxRate = getTaxRates(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  static String calculatedShippingCose(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculatedTax(double productPrice, String location) {
    double taxRates = getTaxRates(location);
    double taxAmount = productPrice + taxRates;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRates(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }

  // ! sum of cart total
  // static double calculateCartTotal(CartModel cartModel) {
  //   return cartModel.item.map((e) => e.price).fold(0,
  //       (previousPrice, currenntPrice) => previousPrice + (currenntPrice ?? 0));
  // }
}
