import 'package:e_commerse_app/models/product.dart';
import 'package:e_commerse_app/views/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowProductsWidget extends StatelessWidget {
  final List<Product>? products;
  final void Function()? onRefresh;
  const ShowProductsWidget(
      {super.key, required this.products, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : products!.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No Data'),
                    IconButton(onPressed: onRefresh, icon: Icon(Icons.refresh))
                  ],
                ),
              )
            : Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    products!.map((e) => ProductCard(product: e)).toList(),
              );
  }
}
