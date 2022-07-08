import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/helper/db_helper.dart';
import 'package:trying/providers/cart_provider.dart';

import '../model/cart_model.dart';

class BasketPage extends StatefulWidget {
  BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  DBHelper dbHelper = DBHelper();
  bool isTappedRemove = false;
  bool isTappedAdd = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BasketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getData(),
            builder: ((context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: snapshot.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var product = snapshot.data![index];
                            return Card(
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset(
                                        product.productImage.toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${product.productName}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text('Price: ${product.productPrice}\$',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print(isTappedRemove);
                                                if (!isTappedRemove) {
                                                  isTappedRemove = true;
                                                  int quantity =
                                                      product.productQuantity!;
                                                  double price = double.parse(
                                                      product
                                                          .productInitialPrice
                                                          .toString());
                                                  if (quantity > 1) {
                                                    quantity--;
                                                    double newPrice =
                                                        price * quantity;

                                                    dbHelper
                                                        .updateQuanity(Product(
                                                            id: product.id,
                                                            productId: product
                                                                .productId,
                                                            productName: product
                                                                .productName,
                                                            productInitialPrice:
                                                                product
                                                                    .productInitialPrice,
                                                            productPrice:
                                                                newPrice,
                                                            productStock: product
                                                                .productStock,
                                                            productQuantity:
                                                                quantity,
                                                            productImage: product
                                                                .productImage))
                                                        .then((value) {
                                                      print(product.productPrice
                                                          .toString());
                                                      newPrice = 0;
                                                      cart.removeTotalPrice(
                                                          double.parse(product
                                                              .productInitialPrice
                                                              .toString()));
                                                      isTappedRemove = false;
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(error.toString());
                                                    });
                                                  } else {
                                                    print('delete');
                                                    isTappedRemove = false;
                                                    cart.removeCartItem(
                                                        product.id.toString());
                                                    dbHelper
                                                        .delete(product.id!);
                                                    cart.removeConter();

                                                    cart.removeTotalPrice(
                                                        double.parse(product
                                                            .productPrice
                                                            .toString()));
                                                  }
                                                }
                                              },
                                              child:
                                                  product.productQuantity! > 1
                                                      ? const Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        )
                                                      : const Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                            ),
                                            Text(
                                              product.productQuantity
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!isTappedAdd) {
                                                  isTappedAdd = true;
                                                  int quantity =
                                                      product.productQuantity!;
                                                  double price = double.parse(
                                                      product
                                                          .productInitialPrice
                                                          .toString());
                                                  quantity++;
                                                  double newPrice =
                                                      price * quantity;

                                                  dbHelper
                                                      .updateQuanity(Product(
                                                          id: product.id,
                                                          productId:
                                                              product.productId,
                                                          productName: product
                                                              .productName,
                                                          productInitialPrice:
                                                              product
                                                                  .productInitialPrice,
                                                          productPrice:
                                                              newPrice,
                                                          productStock: product
                                                              .productStock,
                                                          productQuantity:
                                                              quantity,
                                                          productImage: product
                                                              .productImage))
                                                      .then((value) {
                                                    newPrice = 0;
                                                    cart.addTotalprice(
                                                        double.parse(product
                                                            .productInitialPrice
                                                            .toString()));
                                                    isTappedAdd = false;
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    print(error.toString());
                                                  });
                                                }
                                              },
                                              child: const Icon(Icons.add,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/where.gif",
                              height: 175.0,
                              width: 175.0,
                            ),
                            Text(
                              'Your cart is empty',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[200]),
                            ),
                          ],
                        )),
                );
              } else {}

              return Text('Null');
            }),
          ),
          Consumer<BasketProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableWidget(
                    title: 'Sub Total',
                    value: r'$' + value.getTotalPrice().toStringAsFixed(2),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
