import 'package:e_commerse_app/models/product.dart';
import 'package:e_commerse_app/views/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetailsPage(
                      product: product,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 3,
        child: Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              product.image ?? '',
                            ),
                            fit: BoxFit.contain)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.title ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.akayaKanadaka(
                      color: Color.fromARGB(255, 218, 168, 121),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${product.price.toString()}',
                  maxLines: 1,
                  style: GoogleFonts.akayaKanadaka(
                      color: Color.fromARGB(255, 192, 64, 25),
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
