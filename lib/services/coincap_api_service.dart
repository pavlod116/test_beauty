import 'package:dio/dio.dart';

import '../models/crypto_assets.dart';

class CoinCapApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://rest.coincap.io/v3';
  final String _apiKey = '195ebea5717db18a64b31d968ce021aa797d512a75742d720984881349d6c305';

  CoinCapApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_apiKey.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_apiKey';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<CryptoAsset>> getAssets({int offset = 0, int limit = 15}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/assets',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => CryptoAsset.fromJson(json)).toList();
      } else {
        throw Exception('API returned status code: ${response.statusCode}. Message: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unknown error occurred while fetching assets: $e');
    }
  }
}