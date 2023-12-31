import 'package:get/get.dart';
import 'package:znam_za_5_app/data/repository/popularproductrepo.dart';

class PopularProductController extends GetxService{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      _popularProductList = [];
      // _popularProductList.addAll();
    } else{

    }
  }
}