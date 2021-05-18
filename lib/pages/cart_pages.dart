import 'dart:math';

import 'package:dapur/api_service/api.dart';
import 'package:dapur/models/product_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: Text(
          "Shopping Cart",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<ProductItems>>(
              future: getProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ProductItems> dataProduct = snapshot.data;
                  return Container(
                    // margin:
                    //     EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                    // height: MediaQuery.of(context).size.height / 5,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 3.0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ListTile(
                                title: Text(dataProduct[0].title),
                                subtitle: Text(dataProduct[0].conditionOfItem),
                                leading: Image.network(
                                    "https://cdn.eraspace.com/pub/media/catalog/product/cache/184775a204380039ae47e1177f9cfc1b/m/a/macbook_pro_m1_silver_1_2.jpg"),
                                trailing: Text(
                                  NumberFormat.currency(
                                          locale: 'id-ID',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(int.parse(dataProduct[0].price)),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value = max(1, value - 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(width: 1),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/btn_min.png"))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      value.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value = min(999, value + 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(width: 1),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/btn_add.png"))),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            SizedBox(
              height: 9.0,
            ),
            FutureBuilder<List<ProductItems>>(
                future: getProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductItems> adaData = snapshot.data;
                    return Text(
                      NumberFormat.currency(
                              locale: 'id-ID',
                              symbol: 'Total IDR ',
                              decimalDigits: 0)
                          .format(value * int.parse(adaData[0].price)),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return SizedBox();
                }),
            FractionallySizedBox(
              widthFactor: 2 / 3,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan)),
                child: Text(
                  "Confirm Payment",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
