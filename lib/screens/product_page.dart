import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/helper/db_helper.dart';
import 'package:trying/model/cart_model.dart';
import 'package:trying/providers/cart_provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BasketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: Product.products.length,
          itemBuilder: (context, index) {
            var product = Product.products[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(product.productImage.toString())),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Name: ${product.productName}'),
                        Text('Price: ${product.productPrice}\$'),
                        Text('Stock: ${product.productStock}'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cart.addItemsIndex(product.id.toString());
                        print('Product Name: ${product.productName}');
                        if (!cart.sameItemCheck) {
                          dbHelper!
                              .insert(Product(
                            id: product.id,
                            productId: product.productId,
                            productName: product.productName.toString(),
                            productInitialPrice: product.productInitialPrice,
                            productPrice: product.productPrice,
                            productStock: product.productStock,
                            productQuantity: 1,
                            productImage: product.productImage.toString(),
                          ))
                              .then((value) {
                            cart.addTotalprice(
                                double.parse(product.productPrice.toString()));
                            cart.addCounter();

                            const snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Product is added to cart'),
                              duration: Duration(seconds: 1),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }).onError((error, StackTrace stackTrace) {
                            print("$error");
                          });
                        } else {
                          const snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Product is already added in cart'),
                              duration: Duration(seconds: 1));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: const Text('Add to Cart'),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
