import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/crypto_list_item.dart';
import 'crypto_list_model.dart';

class CryptoListView extends StatefulWidget {
  const CryptoListView({Key? key}) : super(key: key);

  @override
  State<CryptoListView> createState() => _CryptoListViewState();
}

class _CryptoListViewState extends State<CryptoListView> {
  final ScrollController _scrollController = ScrollController();

  void _showErrorSnackBar(String message) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 5),
      leftBarIndicatorColor: Colors.red[300],
      backgroundColor: Colors.red.shade700,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5.0,
          offset: const Offset(0.0, 2.0),
        )
      ],
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    final cryptoProvider = Provider.of<CryptoListModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cryptoProvider.fetchAssets(onError: _showErrorSnackBar);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !cryptoProvider.isLoading && cryptoProvider.hasMore) {
        cryptoProvider.loadMoreAssets(onError: _showErrorSnackBar);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Assets',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Consumer<CryptoListModel>(
        builder: (context, cryptoProvider, child) {
          return RefreshIndicator(
            onRefresh: () => cryptoProvider.refreshAssets(onError: _showErrorSnackBar),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: cryptoProvider.assets.length + (cryptoProvider.hasMore && cryptoProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < cryptoProvider.assets.length) {
                  final asset = cryptoProvider.assets[index];
                  return CryptoListItem(
                    asset: asset,
                    itemColor: asset.backgroundColor ?? Colors.grey,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
