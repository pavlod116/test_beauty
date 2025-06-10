import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:test_beauty/style/app_color.dart';

import '../models/crypto_assets.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoAsset asset;
  final Color itemColor;

  const CryptoListItem({Key? key, required this.asset, required this.itemColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double price = double.tryParse(asset.priceUsd) ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: itemColor,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Gap(16),
          Expanded(
            child: Text(
              asset.name,
              style: TextStyle(
                color: AppColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gap(16),
          Text(
            '\$${NumberFormat.currency(locale: 'en_US', symbol: '').format(price)}',
            style: TextStyle(
              color: AppColor.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
