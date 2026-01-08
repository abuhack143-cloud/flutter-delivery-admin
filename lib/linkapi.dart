class AppLink {
  // static const String server = "http://10.0.2.2/companydelivery/admin";
  static const String server = "http://192.168.0.105/companydelivery/admin";
  // static const String server = "http://194.34.232.105/companydelivery/admin";

  static const String test = "$server/test.php";

  static const String refreshToken = "$server/refresh.php";
  //================ Auth ================

  static const String signup = "$server/auth/signup.php";
  static const String verifycode = "$server/auth/verifycode.php";
  static const String login = "$server/auth/login.php";

  //================ Map ================
  static const String storeMap = "$server/map/storeMap.php";
  static const String deliveryMap = "$server/map/deliveryMap.php";
  static const String storeOwnerMap = "$server/map/storeOwnerMap.php";

  //================ Account ================

  //====== Delivery ======
  static const String delivery = "$server/account/delivery/delivery.php";
  static const String detaildelivery = "$server/account/delivery/detail.php";
  static const String detaildAccept = "$server/account/delivery/accept.php";
  static const String detaildRject = "$server/account/delivery/reject.php";

  //====== StoreOwner ======
  static const String storeOwner = "$server/account/storeOwner/storeOwner.php";
  static const String storeOwnerEast =
      "$server/account/storeOwner/storeOwner_east.php";
  static const String storeOwnerWest =
      "$server/account/storeOwner/storeOwner_west.php";
  static const String detailowner = "$server/account/storeOwner/detail.php";
  static const String detaildownerAccept =
      "$server/account/storeOwner/accept.php";
  static const String detaildownerRject =
      "$server/account/storeOwner/reject.php";

  //====== Admin ======
  static const String admin = "$server/account/admin/admin.php";
  static const String addAdmin = "$server/account/admin/addAdmin.php";
  static const String removeAdmin = "$server/account/admin/reject.php";
  static const String city = "$server/account/admin/city.php";
  static const String otherOwner = "$server/account/admin/otherStoreOwner.php";
  static const String addOtherAdmin = "$server/account/admin/addAdminOther.php";
  static const String presignUpload = "$server/account/admin/presignUpload.php";
  static const String rollbackUpload =
      "$server/account/admin/addAdminOther.php";

  //=================== Other =======================

  //======== City ========
  static const String cityOther = "$server/other/city/city.php";
  static const String classification = "$server/other/city/classification.php";
  static const String addCity = "$server/other/city/addcity.php";
  static const String editCity = "$server/other/city/editCity.php";
  static const String deleteCity = "$server/other/city/deletecity.php";

  //======== Street ========
  static const String street = "$server/other/street/street.php";
  static const String cityStreet = "$server/other/street/city_street.php";
  static const String cityS = "$server/other/street/city.php";
  static const String addStreet = "$server/other/street/addStreet.php";
  static const String editStreet = "$server/other/street/editStreet.php";
  static const String deleteStreet = "$server/other/street/deleteStreet.php";

  //======== Box Size =========
  static const String boxSize = "$server/other/boxSize/boxSize.php";
  static const String deleteBoxSize = "$server/other/boxSize/deleteBoxSize.php";
  static const String editBoxSize = "$server/other/boxSize/editBoxSize.php";
  static const String addBoxSize = "$server/other/boxSize/addBoxSize.php";

  //======== Packaging =========
  static const String packaging = "$server/other/packaging/packaging.php";
  static const String deletePackaging =
      "$server/other/packaging/deletePackaging.php";
  static const String editPackaging =
      "$server/other/packaging/editPackaging.php";
  static const String addPackaging = "$server/other/packaging/addPackaging.php";

  //======== Categories1 =========
  static const String cate1 = "$server/other/categories/cate1/categories1.php";
  static const String searchCate1 =
      "$server/other/categories/cate1/searchCate1.php";
  static const String addCate1 = "$server/other/categories/cate1/addCate1.php";
  static const String deleteCate1 =
      "$server/other/categories/cate1/deleteCate1.php";
  static const String editCate1 =
      "$server/other/categories/cate1/editCate1.php";

  //======== Categories2 =========
  static const String cate2 = "$server/other/categories/cate2/categories2.php";
  static const String searchCate2 =
      "$server/other/categories/cate2/searchCate2.php";
  static const String addCate2 = "$server/other/categories/cate2/addCate2.php";
  static const String deleteCate2 =
      "$server/other/categories/cate2/deleteCate2.php";
  static const String editCate2 =
      "$server/other/categories/cate2/editCate2.php";

  //======== Categories3 =========
  static const String cate3 = "$server/other/categories/cate3/categories3.php";
  static const String searchCate3 =
      "$server/other/categories/cate3/searchCate3.php";
  static const String addCate3 = "$server/other/categories/cate3/addCate3.php";
  static const String deleteCate3 =
      "$server/other/categories/cate3/deleteCate3.php";
  static const String editCate3 =
      "$server/other/categories/cate3/editCate3.php";

  //======== Collection Point =========
  static const String collectionPoint =
      "$server/other/collectionPoint/collectionPoint.php";
  static const String deletecollectionPoint =
      "$server/other/collectionPoint/deleteCollectionPoint.php";
  static const String editcollectionPoint =
      "$server/other/collectionPoint/editCollectionPoint.php";
  static const String addcollectionPoint =
      "$server/other/collectionPoint/addCollectionPoint.php";
  static const String cityCollection =
      "$server/other/collectionPoint/cityCollection.php";

  //======== Street ========
  static const String report = "$server/other/report/report.php";
  static const String deleteReport = "$server/other/report/deleteReport.php";

  //======== profit =========
  static const String profit = "$server/other/profit/profit.php";
  static const String editProfit = "$server/other/profit/editprofit.php";

  //======== profit =========
  static const String term = "$server/other/terms/terms.php";
  static const String editTerm = "$server/other/terms/editTerms.php";

  //======== notification =========
  static const String adminNotification =
      "$server/other/notification/admin_noti.php";
  static const String sendNotification =
      "$server/other/notification/send_notification.php";
  static const String deliveryNotification =
      "$server/other/notification/delivery.php";
  static const String ownerNotification =
      "$server/other/notification/storeOwner_noti.php";

  //========================== Order ============================
  static const String ordersdetails = "$server/order/detail.php";
  static const String location = "$server/order/deliverylocation.php";

  //======== All Order =========
  static const String allOrderStatus = "$server/order/AllOrder/OrderStatus.php";
  static const String allOrder = "$server/order/AllOrder/orders.php";

  //======== cancel =========
  static const String canceledOrder = "$server/order/cancel/cancel.php";
  static const String mycanceledOrder = "$server/order/cancel/mycancel.php";

  //======== Delivered =========
  static const String deliveredOrder = "$server/order/delivered/delivered.php";
  static const String myDeliveredOrder =
      "$server/order/delivered/mydelivered.php";

  //======== Pending =========
  static const String pendingOrder = "$server/order/pending/pending.php";
  static const String approveOrder = "$server/order/pending/approve.php";
  static const String reject = "$server/order/pending/reject.php";
  static const String pending2Order = "$server/order/pending/pending2.php";
  static const String approve2Order = "$server/order/pending/approve2.php";

  static const String pending3Order = "$server/order/pending/pending3.php";
  static const String reasonRejectOrder =
      "$server/order/pending/reasonReject.php";

  static const String deliveryPending =
      "$server/order/pending/deliveryPending.php";

  //======== Status =========
  static const String status = "$server/order/status/status.php";
  static const String search = "$server/order/status/search.php";
  static const String result = "$server/order/status/result.php";

  //======== City =========
  static const String cityOrder = "$server/order/city/city.php";
  static const String approveCityOrder = "$server/order/city/approve.php";
  static const String approve2CityOrder = "$server/order/city/approve2.php";
  static const String rejectCity = "$server/order/city/reject.php";

  //======== City =========
  static const String deliveryFail = "$server/order/deliveryFail/fail.php";
  static const String approvefailOrder =
      "$server/order/deliveryFail/approve.php";

  //======== Pending Custommer =========
  static const String pending2OrderCustommer =
      "$server/order/pendingCustommer/pending2.php";
  static const String approve2OrderCustommer =
      "$server/order/pendingCustommer/approve2.php";

  static const String pending3OrderCustommer =
      "$server/order/pendingCustommer/pending3.php";
  static const String rejectOrderCustommer =
      "$server/order/pendingCustommer/reject.php";

  static const String adminCity = "$server/order/pendingCustommer/admin.php";
  static const String selectAdminCity =
      "$server/order/pendingCustommer/cityAdmin.php";

  //======== Delivery =========
  static const String toAdminOrder = "$server/order/delivery/toAdmin.php";
  static const String toCustommerOrder =
      "$server/order/delivery/toCustommer.php";

  //======== Storage =========
  static const String storageOrder = "$server/order/storage/storage.php";
  static const String approveStorage = "$server/order/storage/approve.php";
  static const String rejectStorage = "$server/order/storage/reject.php";
  static const String storage2Order = "$server/order/storage/storage2.php";
  static const String approve2Storage = "$server/order/storage/approve2.php";
  static const String storage3Order = "$server/order/storage/storage3.php";
  static const String storageDetails = "$server/order/storage/detail.php";

  //================ notification ====================
  static const String notification = "$server/notification.php";
}
