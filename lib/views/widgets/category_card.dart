import 'package:e_commerse_app/views/pages/all_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  const CategoryCard({required this.title, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AllProductsScreen(
                      categoryTitle: title,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 5,
        child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 218, 168, 121),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.akayaKanadaka(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              ),
            )),
      ),
    );
  }
}
