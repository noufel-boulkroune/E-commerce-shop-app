import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItems extends StatefulWidget {
  const OrderItems({super.key, required this.order});
  final ord.OrderItem order;

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

bool isExpanded = false;
bool isTapped = true;

class _OrderItemsState extends State<OrderItems> {
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     SlimyCard(
    //       color: Colors.red,
    //       width: 200,
    //       topCardHeight: 400,
    //       bottomCardHeight: 200,
    //       borderRadius: 15,
    //       topCardWidget: myWidget01(),
    //       bottomCardWidget: myWidget02(),
    //       slimeEnabled: true,
    //     )
    //   ],
    // );

    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        onHighlightChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          // duration: Duration(microseconds: 8000),
          //  curve: Curves.fastLinearToSlowEaseIn,

          // width: isExpanded ? 385 : 390,
          decoration: BoxDecoration(
            color: Color(0xffCE28AD),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xffCE28AD).withOpacity(0.5),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(children: [
            ListTile(
              title: Text(
                "Orders price : ${widget.order.amount.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Ordred time : ${DateFormat('dd-MM-yyy hh:mm').format(widget.order.dateTime)}",
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: isExpanded
                      ? const Icon(
                          Icons.expand_less,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.expand_more,
                          color: Colors.white,
                        )),
            ),
            SizedBox(
              height: !isExpanded ? 0 : 20,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: !isExpanded ? 0 : widget.order.products.length * 40,
              child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.order.products[index].title,
                              softWrap: true,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            softWrap: true,
                            widget.order.products[index].quantity
                                    .toStringAsFixed(0) +
                                " * \$" +
                                widget.order.products[index].price
                                    .toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Divider()),
                    ]);
                  }),
            )
          ]),
        ));
  }
}
 
  // Widget myWidget01() {
  //   return Text("laskdjk");
  // }

  // Widget myWidget02() {
  //   return Text("laskdjk");
  // }
// ,
//               ],
//             )}





// SingleChildScrollView(
//       child: Column(
//         children: [
//           Card(
//             margin: const EdgeInsets.all(10),
//             child: ListTile(
//               title: Text(
//                   "Orders price : ${widget.order.amount.toStringAsFixed(2)}"),
//               subtitle: Text(
//                   "Ordred time : ${DateFormat('dd-MM-yyy hh:mm').format(widget.order.dateTime)}"),
//               trailing: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _expanded = !_expanded;
//                     });
//                   },
//                   icon: _expanded
//                       ? const Icon(Icons.expand_less)
//                       : const Icon(Icons.expand_more)),
//             ),
//           ),
//           //  if (_expanded)
//           Card(
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//               color: Colors.white,
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               // height: min(widget.order.products.length * 20 + 75, 170),
//               height: _expanded ? widget.order.products.length * 20 + 75 : 0,
//               child: ListView.builder(
//                 itemCount: widget.order.products.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             widget.order.products[index].title,
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             widget.order.products[index].quantity
//                                     .toStringAsFixed(0) +
//                                 " * \$" +
//                                 widget.order.products[index].price
//                                     .toStringAsFixed(2),
//                             style: const TextStyle(
//                                 color: Colors.grey, fontSize: 18),
//                           )
//                         ],
//                       ),
//                       Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: const Divider()),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
