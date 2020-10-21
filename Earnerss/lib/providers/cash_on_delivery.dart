

import 'package:flutter/widgets.dart';
import 'package:Earnerss/helpers/data/order_wc.dart';
import 'package:Earnerss/helpers/tools.dart';
import 'package:Earnerss/models/cart.dart';
import 'package:Earnerss/models/checkout_session.dart';
import 'package:Earnerss/pages/checkout_confirmation.dart';
import 'package:woosignal/models/payload/order_wc.dart';
import 'package:woosignal/models/response/order.dart';
import 'package:woosignal/models/response/tax_rate.dart';

cashOnDeliveryPay(context,
    {@required CheckoutConfirmationPageState state, TaxRate taxRate}) async {
  try {
    OrderWC orderWC = await buildOrderWC(taxRate: taxRate, markPaid: false);

    Order order = await appWooSignal((api) => api.createOrder(orderWC));

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
  } catch (ex) {
    showEdgeAlertWith(
      context,
      title: trans(context, "Error"),
      desc: trans(context,
          trans(context, "Something went wrong, please contact our store")),
    );
    state.reloadState(showLoader: false);
  }
}
