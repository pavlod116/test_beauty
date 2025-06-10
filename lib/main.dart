import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_beauty/ui/crypto_list_model.dart';
import 'package:test_beauty/ui/crypto_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CryptoListModel(),
      child: MaterialApp(
        title: 'Crypto App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'SF Pro Text',
        ),
        home: const CryptoListView(),
      ),
    );
  }
}