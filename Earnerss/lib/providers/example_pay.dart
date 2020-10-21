

import 'package:flutter/widgets.dart';
import 'package:Earnerss/helpers/data/order_wc.dart';
import 'package:Earnerss/helpers/tools.dart';
import 'package:Earnerss/pages/checkout_confirmation.dart';
import 'package:woosignal/models/payload/order_wc.dart';
import 'package:woosignal/models/response/order.dart';
import 'package:woosignal/models/response/tax_rate.dart';

// CALL THE BELOW METHOD TO SHOW AND HIDE LOADER
// state.reloadState(showLoader: false);

// CHECKOUT HELPER
// IT WILL RETURN THE ORDER TOTAL, BILLING DETAILS AND CART
// await checkout(taxRate, (total, billingDetails, cart) async {
//
// });

// REMEMBER TO ADD THIS METHOD E.G. "examplePay" TO THE APP_PAYMENT_METHODS
// AS THE PAY METHOD

examplePay(context,
    {@required CheckoutConfirmationPageState state, TaxRate taxRate}) async {
  // HANDLE YOUR PAYMENT INTEGRATION HERE
  // ...
  // ...
  // ...
  // THEN ON SUCCESS OF A PAYMENT YOU CAN DO SOMETHING SIMILAR BELOW

  // CREATES ORDER MODEL
  OrderWC orderWC = await buildOrderWC(taxRate: taxRate, markPaid: true);

  // CREATES ORDER IN WOOCOMMERCE
  Order order = await appWooSignal((api) => api.createOrder(orderWC));

  // CHECK IF ORDER IS NULL
  if (order != null) {
    Navigator.pushNamed(context, "/checkout-status", arguments: order);
  } else {
    showEdgeAlertWith(
      context,
      title: trans(context, "Error"),
      desc: trans(context,
          trans(context, "Something went wrong, please contact our store")),
    );
    state.reloadState(showLoader: false);
  }
}
