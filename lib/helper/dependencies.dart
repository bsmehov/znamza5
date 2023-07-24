import 'package:get/get.dart';
import 'package:znam_za_5_app/controllers/popularproductcontroller.dart';
import 'package:znam_za_5_app/data/repository/popularproductrepo.dart';

import '../data/api/apiclient.dart';

Future<void> init() async{
  // apis
  Get.lazyPut(()=>ApiClient(appBaseUrl: "https://www.dbesttech.com"));
  // Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  // Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}