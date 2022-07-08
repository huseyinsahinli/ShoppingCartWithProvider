import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/cart_provider.dart';
import 'package:trying/screens/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BasketProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: MainPage(),
        );
      }),
    );
  }
}
