import 'package:admin/core/middleware/mymiddelware.dart';
import 'package:admin/view/screen/account.dart';
import 'package:admin/view/screen/account/admin/addAdmin.dart';
import 'package:admin/view/screen/account/admin/admin.dart';
import 'package:admin/view/screen/account/delivery/DetailProfileDelivery.dart';
import 'package:admin/view/screen/account/delivery/delivery.dart';
import 'package:admin/view/screen/account/storeowner/DetailProfileOwner.dart';
import 'package:admin/view/screen/account/storeowner/storeOwner.dart';
import 'package:admin/view/screen/auth/login.dart';
import 'package:admin/view/screen/map.dart';
import 'package:admin/view/screen/order/allOrder/AllOrder.dart';
import 'package:admin/view/screen/order/deliveryFail/deliveryFail.dart';
import 'package:admin/view/screen/order/deliveryFail/mapDelivery.dart';
import 'package:admin/view/screen/order/deliveryFail/mapTrackDelivery.dart';
import 'package:admin/view/screen/order/mapLocation.dart';
import 'package:admin/view/screen/order/cityOrder/cityOrder.dart';
import 'package:admin/view/screen/order/deliveryOrder/maindelivery.dart';
import 'package:admin/view/screen/order/deliveryOrder/mapTrackDelivery.dart';
import 'package:admin/view/screen/order/pendingOrder/delivery.dart';
import 'package:admin/view/screen/order/pendingOrderCustomer/adminCity.dart';
import 'package:admin/view/screen/order/pendingOrderCustomer/mainPending.dart';
import 'package:admin/view/screen/order/pendingOrderCustomer/mapDelivery.dart';
import 'package:admin/view/screen/order/pendingStorage/detailStorage.dart';
import 'package:admin/view/screen/order/pendingStorage/mainStorage.dart';
import 'package:admin/view/screen/order/pendingStorage/mapDelivery.dart';
import 'package:admin/view/screen/order/statusOrder/Qr.dart';
import 'package:admin/view/screen/order/statusOrder/orderStatus.dart';
import 'package:admin/view/screen/order/statusOrder/search.dart';
import 'package:admin/view/screen/order/cancelOrder/cancelOrder.dart';
import 'package:admin/view/screen/order/detail.dart';
import 'package:admin/view/screen/order/cancelOrder/mainCancel.dart';
import 'package:admin/view/screen/order/deliveredOrder/deliverdOrder.dart';
import 'package:admin/view/screen/order/deliveredOrder/mainDeliverd.dart';
import 'package:admin/view/screen/order/pendingOrder/mainPending.dart';
import 'package:admin/view/screen/order/pendingOrder/mapDelivery.dart';
import 'package:admin/view/screen/orders.dart';
import 'package:admin/view/screen/other.dart';
import 'package:admin/view/screen/other/BoxSize/addBoxSize.dart';
import 'package:admin/view/screen/other/BoxSize/boxSize.dart';
import 'package:admin/view/screen/other/BoxSize/editBoxSize.dart';
import 'package:admin/view/screen/other/Packaging/Packaging.dart';
import 'package:admin/view/screen/other/Packaging/addPackaging.dart';
import 'package:admin/view/screen/other/Packaging/editPackaging.dart';
import 'package:admin/view/screen/other/categories/cate1/addCategories1.dart';
import 'package:admin/view/screen/other/categories/cate1/categories1.dart';
import 'package:admin/view/screen/other/categories/cate1/editCategories1.dart';
import 'package:admin/view/screen/other/categories/cate2/addCategories2.dart';
import 'package:admin/view/screen/other/categories/cate2/categories2.dart';
import 'package:admin/view/screen/other/categories/cate2/editCategories2.dart';
import 'package:admin/view/screen/other/categories/cate3/addCategories3.dart';
import 'package:admin/view/screen/other/categories/cate3/categories3.dart';
import 'package:admin/view/screen/other/categories/cate3/editCategories3.dart';
import 'package:admin/view/screen/other/city/addCity.dart';
import 'package:admin/view/screen/other/city/city.dart';
import 'package:admin/view/screen/other/city/editCity.dart';
import 'package:admin/view/screen/other/collectionPoint/addCollectionPoint.dart';
import 'package:admin/view/screen/other/collectionPoint/collectionPoint.dart';
import 'package:admin/view/screen/other/collectionPoint/editCollectionPoint.dart';
import 'package:admin/view/screen/other/notification/admin.dart';
import 'package:admin/view/screen/other/notification/delivery.dart';
import 'package:admin/view/screen/other/notification/notification.dart';
import 'package:admin/view/screen/other/notification/storeOwner.dart';
import 'package:admin/view/screen/other/profit/profit.dart';
import 'package:admin/view/screen/other/report/report.dart';
import 'package:admin/view/screen/other/street/addStreet.dart';
import 'package:admin/view/screen/other/street/editStreet.dart';
import 'package:admin/view/screen/other/street/street.dart';
import 'package:admin/view/screen/other/term/term.dart';
import 'package:admin/view/screen/settings/settings.dart';
import 'package:admin/view/screen/home_SAdmin.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/settings/image.dart';
import 'package:admin/view/screen/settings/profile.dart';

import 'view/screen/order/cityOrder/mapDelivery.dart';

// import 'package:admin/view/screen/home_delivery.dart';
Transition transition = Transition.cupertino;
List<GetPage<dynamic>>? routes = [
  //Auth

  // GetPage(name: "/", page: () => const TestView()),

  GetPage(
    name: "/",
    page: () => const Login(),
    middlewares: [MyMiddleWare()],
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Home
  GetPage(
    name: AppRoute.homeSAdmin,
    page: () => const Home(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //
  GetPage(
    name: AppRoute.mapSD,
    page: () => const MapSD(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Account
  GetPage(
    name: AppRoute.account,
    page: () => const Account(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.delivey,
    page: () => const Delivery(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.detaildelivey,
    page: () => const DetailProfileDelivery(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.storeOwner,
    page: () => const StoreOwner(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.detailowner,
    page: () => const DetailProfileOwner(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.admin,
    page: () => const Admin(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addadmin,
    page: () => const AddAdmin(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  ////// Other
  //City
  GetPage(
    name: AppRoute.other,
    page: () => const Other(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.addCity,
    page: () => const AddCity(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.city,
    page: () => const City(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editcity,
    page: () => const EditCity(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Street
  GetPage(
    name: AppRoute.street,
    page: () => const Street(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addstreet,
    page: () => const AddStreet(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editstreet,
    page: () => const EditStreet(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Box Size
  GetPage(
    name: AppRoute.boxsize,
    page: () => const Boxsize(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editboxsize,
    page: () => const EditBoxSize(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addboxsize,
    page: () => const AddBoxSize(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  // categories1
  GetPage(
    name: AppRoute.cate1,
    page: () => const Categories1(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addcate1,
    page: () => const AddCategories1(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editcate1,
    page: () => const EditCategories1(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  // categories2
  GetPage(
    name: AppRoute.cate2,
    page: () => const Categories2(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addcate2,
    page: () => const AddCategories2(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editcate2,
    page: () => const EditCategories2(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

// categories2
  GetPage(
    name: AppRoute.cate3,
    page: () => const Categories3(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addcate3,
    page: () => const AddCategories3(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editcate3,
    page: () => const EditCategories3(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //CollectionPoint
  GetPage(
    name: AppRoute.collectionPoint,
    page: () => const CollectionPoint(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.editCollectionPoint,
    page: () => const EditCollectionPoint(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.addCollectionPoint,
    page: () => const AddCollectionPoint(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

//profit
  GetPage(
    name: AppRoute.profit,
    page: () => const Profit(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

//term
  GetPage(
    name: AppRoute.term,
    page: () => const Term(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

//Packaging
  GetPage(
    name: AppRoute.packaging,
    page: () => const Packaging(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.addPackaging,
    page: () => const AddPackaging(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.editPackaging,
    page: () => const EditPackaging(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //notification
  GetPage(
    name: AppRoute.notification,
    page: () => const Notification(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.adminnotification,
    page: () => const AdminNotification(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.deliverynotification,
    page: () => const DeliveryNotification(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.ownernotification,
    page: () => const OwnerNotification(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  /////////////////Order
  GetPage(
    name: AppRoute.order,
    page: () => const Order(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  // All Order
  GetPage(
    name: AppRoute.allorder,
    page: () => const AllOrder(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Cancel
  GetPage(
    name: AppRoute.maincancel,
    page: () => const MainCancel(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.cancelorder,
    page: () => const CancelOrder(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.detail,
    page: () => const Detail(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.cancellocation,
    page: () => const MapLocation(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //delivered
  GetPage(
    name: AppRoute.maindelivered,
    page: () => const MainDelivered(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.deliveredorder,
    page: () => const DeliveredOrder(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //pending
  GetPage(
    name: AppRoute.mainpending,
    page: () => const MainPending(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.pendingMap,
    page: () => const MapDelivery(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.pendingdelivery,
    page: () => const DeliveryPending(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //pending Custommer
  GetPage(
    name: AppRoute.mainpendingCustommer,
    page: () => const MainPendingCustommer(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.pendingMapCustommer,
    page: () => const MapDeliveryCustommer(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Status
  GetPage(
    name: AppRoute.status,
    page: () => const OrderStatus(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.search,
    page: () => const Search(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.qr,
    page: () => const GenerateQRCodeScreen(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //city
  GetPage(
    name: AppRoute.cityorder,
    page: () => const CityOrder(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.adminorder,
    page: () => const AdminCity(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.citydeliveryorder,
    page: () => const MapDeliveryCity(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Delivery
  GetPage(
    name: AppRoute.mainDelivery,
    page: () => const MainDelivery(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.trackDelivery,
    page: () => const MapTrackDelivery(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Storage
  GetPage(
    name: AppRoute.mainstorgae,
    page: () => const MainStorage(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.mapDeliveryStorage,
    page: () => const MapDeliveryStorage(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.detailStorage,
    page: () => const DetailStorage(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //deliveryFail
  GetPage(
    name: AppRoute.deliveryFail,
    page: () => const DeliveryFail(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.faildeliveryorder,
    page: () => const MapDeliveryFail(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.failtrackorder,
    page: () => const MapTrackDeliveryFail(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //Report
  GetPage(
    name: AppRoute.report,
    page: () => const Report(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  ///
  GetPage(
    name: AppRoute.settings,
    page: () => const Settings(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: AppRoute.profile,
    page: () => const Profile(),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppRoute.image,
    page: () => const ImageViewerPage(
      imageUrl: '',
    ),
    transition: transition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];


// Map<String, Widget Function(BuildContext)> routess = {
//   //Auth
// AppRoute.login : (context) => const Login(),
// AppRoute.role : (context) => const RoleSignUp(),
// AppRoute.signupUser : (context) => const SignUpUser(),
// AppRoute.forgetPassword : (context) => const ForgetPassword(),
// AppRoute.resetPassword : (context) => const ResetPassword(),
// AppRoute.verfiyCode : (context) => const VerfiyCode(),
// AppRoute.sucess_reset : (context) => const SuccessResetPassword(),
// AppRoute.sucess_signup : (context) => const SuccessSignUp(),
// AppRoute.checkEmail : (context) => const CheckEmail(),
//
// // onBoarding
// AppRoute.onBoarding : (context) => const OnBoarding(),
// };