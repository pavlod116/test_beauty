import 'package:flutter/material.dart';

class CryptoAsset {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String priceUsd;
  final String changePercent24Hr;
  Color? backgroundColor;

  CryptoAsset({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.changePercent24Hr,
    this.backgroundColor,
  });

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
      id: json['id'] as String,
      rank: json['rank'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      priceUsd: json['priceUsd'] as String,
      changePercent24Hr: json['changePercent24Hr'] as String,
    );
  }
}