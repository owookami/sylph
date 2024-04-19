import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sylph/app/backend/parse/purchase_parse.dart';

class PurchaseController extends GetxController implements GetxService {

  final PurchaseParse parser;
  
  final InAppPurchase _iap = InAppPurchase.instance;
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  RxBool isAvailable = false.obs;


  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  PurchaseController({required this.parser});

  void initialize() async {
    isAvailable.value = await _iap.isAvailable();
    
    if(isAvailable.value) {
      const Set<String> _kIds = {'sylph_inapp_001'};
      final ProductDetailsResponse response = await _iap.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        // Handle Missing IDs
      }
      products.value = response.productDetails;
    }
  }

  void buyProduct(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
}