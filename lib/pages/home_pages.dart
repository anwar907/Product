import 'package:dapur/api_service/api.dart';
import 'package:dapur/models/product_items.dart';
import 'package:flutter/material.dart';

import 'cart_pages.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Product"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Icon(Icons.shopping_bag),
              ))
        ],
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<List<ProductItems>>(
              future: getProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ProductItems> dataProduct = snapshot.data;
                  return GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: dataProduct.map((e) {
                        var image = e.defaultPhoto;
                        print("ADA GAMBAR $image");
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(0, 3),
                                  blurRadius: 3.0),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            "https://ranting.twisdev.com/uploads/$image")),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(9.0),
                                      topRight: Radius.circular(9.0),
                                    ),
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle: StrutStyle(fontSize: 14.0),
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          text: e.title),
                                    ),
                                    Text(
                                      e.locationName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .apply(bodyColor: Colors.grey[500])
                                          .overline,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Rp.${e.price}",
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (ctx) {
                                            //       return CartScreen();
                                            //     },
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.cyan,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[400],
                                                  blurRadius: 5.0,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
