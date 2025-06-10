import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/crypto_assets.dart';
import '../services/coincap_api_service.dart';

class CryptoListModel extends ChangeNotifier {
  final CoinCapApiService _apiService = CoinCapApiService();

  List<CryptoAsset> _assets = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 15;

  List<CryptoAsset> get assets => _assets;

  bool get isLoading => _isLoading;

  bool get hasMore => _hasMore;


  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      64,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Future<void> fetchAssets({Function(String message)? onError}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newAssets = await _apiService.getAssets(offset: _offset, limit: _limit);

      if (newAssets.isEmpty) {
        _hasMore = false;
      } else {
        for (var asset in newAssets) {
          asset.backgroundColor = _generateRandomColor();
        }
        _assets.addAll(newAssets);
        _offset += _limit;
      }
    } on DioException catch (e) {
      String errorMessage;
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        errorMessage = 'Fatal Error (Code: $statusCode): ${e.response!.statusMessage ?? 'API error'}.';
      } else {
        errorMessage = 'Fatal Error: Network connection issue or server is unreachable.';
      }
      debugPrint(errorMessage);
      if (onError != null) {
        onError(errorMessage);
      }
    } catch (e) {
      String errorMessage = 'Fatal Error: An unexpected error occurred: ${e.toString()}';
      debugPrint(errorMessage);
      if (onError != null) {
        onError(errorMessage);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void loadMoreAssets({Function(String message)? onError}) {
    fetchAssets(onError: onError);
  }

  Future<void> refreshAssets({Function(String message)? onError}) async {
    _assets = [];
    _offset = 0;
    _hasMore = true;
    await fetchAssets(onError: onError);
  }
}
