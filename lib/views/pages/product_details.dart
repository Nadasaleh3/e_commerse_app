import 'package:e_commerse_app/models/product.dart';
import 'package:e_commerse_app/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_dialog.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({required this.product, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (Provider.of<ProductProvider>(context, listen: false)
        .cartContainProduct(widget.product.id ?? 0)) {
      var value = Provider.of<ProductProvider>(context, listen: false)
          .productSelected
          ?.where((element) => element['productId'] == widget.product.id)
          .first['quantity'];
      setState(() {
        quantity = value;
      });
    } else {
      setState(() {
        quantity = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 168, 121),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          widget.product.title ?? 'No Title',
          style: GoogleFonts.akayaKanadaka(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 250, 243, 233),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.product.image ?? '',
                        ),
                        fit: BoxFit.contain)),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title ?? 'No Title',
                    maxLines: 2,
                    style: GoogleFonts.akayaKanadaka(
                        color: Color.fromARGB(255, 218, 168, 121),
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.category ?? 'No Category',
                        style: GoogleFonts.akayaKanadaka(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            widget.product.rating?.rate.toString() ?? 'No Rate',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '(' +
                                widget.product.rating!.count.toString() +
                                " Reviews)",
                            style: GoogleFonts.akayaKanadaka(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Information',
                    style: GoogleFonts.akayaKanadaka(
                      color: Color.fromARGB(255, 199, 139, 84),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.product.description ?? 'No Describtion',
                    maxLines: 10,
                    style: GoogleFonts.akayaKanadaka(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Row(
                      children: [
                        Text(
                          '\$' + widget.product.price.toString(),
                          maxLines: 10,
                          style: TextStyle(
                              color: Color.fromARGB(255, 177, 123, 74),
                              fontSize: 23,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (quantity != 1) {
                                    if (Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .cartContainProduct(
                                            widget.product.id ?? 0)) {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .changeCartItemQuantity(
                                              widget.product.id ?? 0,
                                              quantity - 1);

                                      init();
                                    } else {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  }
                                },
                                icon: Icon(Icons.remove)),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .cartContainProduct(
                                          widget.product.id ?? 0)) {
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .changeCartItemQuantity(
                                            widget.product.id ?? 0,
                                            quantity + 1);

                                    init();
                                  } else {
                                    setState(() {
                                      quantity++;
                                    });
                                  }
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 168, 121),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () {
                                  onItemClicked(
                                      context, quantity, widget.product);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .cartContainProduct(
                                                widget.product.id ?? 0)
                                        ? '- Remove From Cart'
                                        : '+ Add To Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onItemClicked(BuildContext context, int quantity, Product product) {
    if (Provider.of<ProductProvider>(context, listen: false)
        .cartContainProduct(widget.product.id ?? 0)) {
      Provider.of<ProductProvider>(context, listen: false)
          .removeProductFromCart(product.id ?? 0);
      init();
      AppDialog.showDialogEx(context, title: 'Product Deleted Successfully');
    } else {
      Provider.of<ProductProvider>(context, listen: false).addProductToCart({
        'productId': product.id,
        'quantity': quantity,
        'productName': product.title,
        'productPrice': product.price,
        'productImage': product.image,
      });
      init();
      AppDialog.showDialogEx(context, title: 'Product Added Successfully');
    }
  }
}
