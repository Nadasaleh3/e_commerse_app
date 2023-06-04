import 'package:e_commerse_app/helpers/app_dialog.dart';
import 'package:e_commerse_app/models/product.dart';
import 'package:e_commerse_app/services/product_services.dart';
import 'package:e_commerse_app/views/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> categoriesData1 = [
    {'title': 'women\'s clothing', 'image': 'assets/woman.png'},
    {'title': 'men\'s clothing', 'image': 'assets/men.png'},
  ];
  List<Map<String, dynamic>> categoriesData2 = [
    {'title': 'electronics', 'image': 'assets/elctronics.png'},
    {'title': 'jewelery', 'image': 'assets/jewelery.png'},
  ];
  List<Product>? _allProducts;
  List<Product>? get allProducts => _allProducts;
  List<Product>? _categoryProducts;
  List<Product>? get categoryProducts => _categoryProducts;
  List<Map<String, dynamic>>? _productSelected;
  List<Map<String, dynamic>>? get productSelected => _productSelected;
  

  void getAllProductsHandler() async {
    clearAllProductList();
    _allProducts = await ProductService.getProducts(limit: 0);
    _allProducts?.shuffle();
    notifyListeners();
  }

  void getCategoryProductsHandler({required String categoryTitle}) async {
    clearCategoryList();
    _categoryProducts =
        await ProductService.getCategoryProducts(categoryTitle: categoryTitle);
    _categoryProducts?.shuffle();
    notifyListeners();
  }

  void clearCategoryList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoryProducts = null;
      notifyListeners();
    });
  }

  void clearAllProductList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _allProducts = null;
      notifyListeners();
    });
  }

  void addProductToCart(Map<String, dynamic> valueSelected) {
    _productSelected ??= [];
    _productSelected?.add(valueSelected);
    notifyListeners();
  }

  void removeProductFromCart(int productId) {
    _productSelected
        ?.removeWhere((element) => element['productId'] == productId);
    notifyListeners();
  }

  bool cartContainProduct(int productId) {
    var result = _productSelected
        ?.where((element) => element['productId'] == productId)
        .toList();

    if (result?.isNotEmpty ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void changeCartItemQuantity(int productId, int newQuantity) {
    var productModified = _productSelected
        ?.where((element) => element['productId'] == productId)
        .first;
    productModified?['quantity'] = newQuantity;

    _productSelected
        ?.removeWhere((element) => element['productId'] == productId);
    _productSelected?.add(productModified!);
  }

  String getCartTotalPrice() {
    double totalPrice = 0;

    for (var produce in (_productSelected ?? [])) {
      totalPrice += produce['productPrice'] * produce['quantity'];
    }

    return totalPrice.toString();
  }

  void sendCartHandler(BuildContext context) async {
    var _productSelectedEx = _productSelected
        ?.map((e) => {
              'productId': e['productId'].toString(),
              'quantity': e['quantity'].toString(),
            })
        .toList();
    var response = await showFutureLoadingDialog(
        context: context,
        future: () =>
            ProductService.sendCart(productSelected: _productSelectedEx!));

    if (response.result ?? false) {
      _productSelected = null;
      notifyListeners();
      await AppDialog.showDialogEx(context,
          title: 'Order Created Successfully');

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
    } else {
      AppDialog.showDialogEx(context, title: 'Error while create order !!');
    }
  }
}
