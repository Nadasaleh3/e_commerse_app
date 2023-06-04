import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:e_commerse_app/helpers/app_dialog.dart';
import 'package:e_commerse_app/provider/product_provider.dart';
import 'package:e_commerse_app/views/pages/all_products.dart';
import 'package:e_commerse_app/views/pages/check_out.dart';
import 'package:e_commerse_app/views/widgets/category_card.dart';
import 'package:e_commerse_app/views/widgets/show_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Provider.of<ProductProvider>(context, listen: false)
    //     .getHomeProductsHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 218, 168, 121),
        title: Text(
          'Find your Match Style .',
          style: GoogleFonts.akayaKanadaka(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (Provider.of<ProductProvider>(context).productSelected !=
                        null &&
                    (Provider.of<ProductProvider>(context)
                            .productSelected
                            ?.isNotEmpty ??
                        false))
                ? badges.Badge(
                    position: BadgePosition.topStart(),
                    badgeContent: Text(
                      Provider.of<ProductProvider>(context)
                          .productSelected!
                          .length
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CheckOutPage()));
                        },
                        icon: Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        )),
                  )
                : IconButton(
                    onPressed: () {
                      AppDialog.showDialogEx(
                        context,
                        title: 'Add Product First',
                      );
                    },
                    icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/ph.png'),
                          fit: BoxFit.fitWidth)),
                ),
              ),
              Text(
                'Categories : ',
                style: GoogleFonts.akayaKanadaka(
                    color: Color.fromARGB(255, 218, 168, 121),
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              Column(
                children: [
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Provider.of<ProductProvider>(context)
                          .categoriesData1
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CategoryCard(
                                    title: e['title'], image: e['image']),
                              ))
                          .toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Provider.of<ProductProvider>(context)
                          .categoriesData2
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CategoryCard(
                                    title: e['title'], image: e['image']),
                              ))
                          .toList(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AllProductsScreen()));
                    },
                    child: Text(
                      'See more Product',
                      style: GoogleFonts.akayaKanadaka(
                          color: Color.fromARGB(255, 223, 160, 72),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
