import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 218, 168, 121),
        elevation: 0,
        title: Text(
          'Check Out Page',
          style: GoogleFonts.akayaKanadaka(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: (Provider.of<ProductProvider>(context).productSelected == null ||
              (Provider.of<ProductProvider>(context).productSelected?.isEmpty ??
                  false))
          ? Center(
              child: Text('No Data Selected'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // show selected product list
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: Provider.of<ProductProvider>(context)
                        .productSelected!
                        .map(
                          (e) => ListTile(
                            title: Text(
                              e['productName'],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Quantity : ${e['quantity']}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Price : ${e['productPrice'] * e['quantity']}',
                                    style: TextStyle(color: Colors.green),
                                  )
                                ],
                              ),
                            ),
                            leading: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e['productImage']),
                                      fit: BoxFit.fitHeight)),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .removeProductFromCart(e['productId']);
                                  });
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        )
                        .toList(),
                  )))

                  // total price and check out btn

                  ,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Text(
                          'Total Price ' +
                              '\$' +
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .getCartTotalPrice(),
                          style: GoogleFonts.akayaKanadaka(
                              color: Color.fromARGB(255, 218, 168, 121),
                              fontSize: 23,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 168, 121)),
                                onPressed: () {
                                  Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .sendCartHandler(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    'Check Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
