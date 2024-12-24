import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:produce_pos/core/components/high_lighted_button.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/modules/cart/components/drag_widget.dart';

class PanelContent extends StatelessWidget {
  const PanelContent({super.key});
  @override
  Widget build(BuildContext context) {
  ScrollController controller = ScrollController();
    return ListView(
      controller: controller ,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 30.h,
        ),
        dragHandle(),
        SizedBox(
          height: 30.h,
        ),
        GestureDetector(
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
            }
          },
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(
                    AppDefaults.padding,
                  ),
                  child: Row(
                    children: [],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppDefaults.padding),
                    child: Text(
                      "Subtotal",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "LBP total",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppDefaults.padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        IconButton(
                          onPressed: () {
                            // CherryToast.info(
                            //   toastPosition: Position.bottom,
                            //   title: const Text(''),
                            //   displayTitle: false,
                            //   animationCurve: Curves.fastLinearToSlowEaseIn,
                            //   description: Text(
                            //     "Orders above 1 Million Lira got a free dilvery",
                            //     style: Theme.of(context).textTheme.displaySmall,
                            //   ),
                            // ).show(context);
                          },
                          icon: const Icon(Icons.info_outline_rounded),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "bigTotal! >= 1000000 ? LBP 0 : LBP deliveryCost",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Total",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: AppDefaults.padding),
                  //   child: Text(
                  //     bigTotal >= 1000000
                  //         ? "LBP $bigTotal"
                  //         : "LBP ${bigTotal + 80000}",
                  //     style: Theme.of(context).textTheme.labelMedium,
                  //   ),
                  // ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              SizedBox(height: 90.h),
              Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: highLightedButton(
                      onPressed: () async {
                        List<Map<String, dynamic>> products = [];
                        for (int i = 0; i < 1; i++) {
                          // products.add(
                          //     CartItem.fromJson(snapshot.data.docs[i].data())
                          //         .toJson());
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OrderScreen(
                        //             amount: bigTotal as int,
                        //             cartItems: products,
                        //             address: _user.address,
                        //             email: _user.email,
                        //             name:
                        //                 '${_user.firstName} ${_user.lastName}')));
                        // List<Map<String, dynamic>> products = [];
                        // for (int i = 0; i < length; i++) {
                        //   products.add(CartItem.fromJson(
                        //           snapshot.data.docs[i].data())
                        //       .toJson());
                        // }
                        // Order.Order order = Order.Order(
                        //     address: 'address',
                        //     status: 'status',
                        //     id: FirebaseFirestore.instance,
                        //     products: products,
                        //     amount: 20);
                        // await FirebaseFirestore.instance
                        //     .collection('user-orders')
                        //     .doc(user!.phoneNumber)
                        //     .collection('orders')
                        //     .add(order.toJson());
                      },
                      text: "PROCEED ORDER"))
            ],
          ),
        ),
        SizedBox(height: 30.h),
        TextButton(
            onPressed: () {
              // confirm_dialog(context, 'Clear The Basket', () async {
              //   await FirestoreUtil.clearBakset();
              //   Navigator.pop(context);
              // });
            },
            child: Text(
              "Clear The Basket",
              style: Theme.of(context).textTheme.labelMedium,
            ))
      ],
    );
    ;
  }
}
