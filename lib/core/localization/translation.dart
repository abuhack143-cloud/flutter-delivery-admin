import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  //choose language
  Map<String, Map<String, String>> get keys => {
        //Choose_language
        "ar": <String, String>{
          "Choose_language": "اختر اللغة",
          "1lang": "العربية",
          "2lang": "English",

          //permission
          "Please_accept_location": "الرجاء قبول إذن الوصول إلى الموقع.",
          "Cant_run_app_without_location": "لا يمكن تشغيل التطبيق بدون الموقع.",
          "Please_Open_location": "الرجاء فتح اذن الموقع",

          //login
          "title1": "مرحبًا بعودتك",
          "title2": "تسجيل الدخول",
          "email": "بريد الإلكتروني",
          "hint_email": "أدخل بريدك الإلكتروني",
          "password": "كلمة المرور",
          "forget": "هل نسيت كلمة المرور؟",
          "hint_password": "أدخل كلمة المرور الخاصة بك",
          "Text_link": "ليس لديك حساب؟ ",
          "link": " سجل الآن",
          "verification_tilte": "رمز التحقق",
          "verification_code": "أدخل رمز التحقق هنا",
          "rest_pass": "إعادة تعيين كلمة المرور",
          "new_pass": "كلمة المرور الجديدة",
          "success_reset": "تم إعادة تعيين كلمة المرور بنجاح",
          "wrong": "خطا",
          "emailOrPassword": "البريد الإلكتروني أو كلمة المرور غير صحيحة",

          //valid
          "valid_username": "يرجى إدخال اسم مستخدم صالح (أحرف ومسافات فقط).",
          "valid_email": "يرجى إدخال بريد إلكتروني صالح.",
          "valid_phone": "يرجى إدخال رقم هاتف صالح.",
          "field_required": "هذا الحقل مطلوب.",
          "min_length": "لا يمكن أن يكون أقل من",
          "max_length": "لا يمكن أن يكون أكثر من",
          "chara": "أحرف",

          //Notification
          "notification": "الإشعارات",

          //Setting
          "profile": "الملف الشخصي",
          "dark_mode": "الوضع الداكن",
          "contact_us": "اتصل بنا",
          "log_out": "تسجيل الخروج",
          "theme": "السمة",
          "System": "النظام",
          "Dark": "داكن",
          "Light": "فاتح",
          "lang": "اللغة",

          //Home
          "home": "الرئيسية",
          "maps": "الخرائط",
          "orders": "الطلبات",
          "account": "الحساب",
          "other": "أخرى",
          "settings": "الإعدادات",

          //map
          "map": "الخريطة",
          "name": "الاسم",
          "phone": "رقم الهاتف",
          "whatsapp": "واتساب",

          //order
          "order": "الطلبات",
          "order_all": "جميع الطلبات",
          "order_status": "حالة الطلبات",
          "order_pending": "الطلبات المعلقة",
          "order_pendingCustomer": "الطلبات المعلقة من العميل",
          "order_city": "الطلبات حسب المدينة",
          "order_delivery": "الطلبات التي يتم توصيلها",
          "order_delivered": "الطلبات المسلمة",
          "order_canceled": "الطلبات الملغاة",
          "storage": "المخزون",

          //other
          "city": "المدينة",
          "street": "الشارع",
          "box_size": "حجم الصندوق",
          "categories": "الفئات",
          "collection_point": "نقطة التجميع",
          "report": "التقرير",

          //Account
          "admin": "الإدارة",
          "store_owner": "أصحاب المتاجر",
          "delivery": "التوصيل",

          "adminCity": "الادمن في المدينة الاخرى",
          "delivery_location": "موقع عامل التوصيل",

          //admin
          "add": "إضافة",
          "superadmin": "سوبر أدمين",
          "admin_pro": "أدمين برو",
          "admin_all": "أدمين الكل",
          "admin_east": "أدمين شرق",
          "admin_west": "أدمين غرب",
          "admin_other": "أدمين آخر",
          "remove": "إزالة",
          "warning": "تحذير",
          "cancel": "إلغاء",
          "ok": "موافق",
          "delete_warning": "هل أنت متأكد أنك تريد حذف",

          //add admin
          "add_admin": "إضافة مسؤول",
          "branch": "الفرع",
          "personal_picture": "الصورة الشخصية",
          "admin_role": "دور المسؤول",
          "select_city": "اختار المدينة",
          "submit": "إرسال",
          "hint_name": "أدخل اسمك",
          "hint_branch": "أدخل الفرع",
          "select_role": "اختر الدور",
          "select_owner": "اختر مالك المتجر",
          "no_image_selected": "لا توجد صورة مختارة.",
          "choose_image": "اختار صورة",
          "choose_role": "اختار دور المسؤول",
          "choose_city": "اختار المدينة",
          "Choose_image_source": "اختر مصدر الصورة",
          "camera": "كاميرا",
          "galary": "المعرض",

          //delivery
          "Delivery": "عامل التوصيل",
          "not_accepted": "غير مقبول",
          "accepted": "مقبول",
          "Name": "الاسم: ",
          "Phone1": "الهاتف 1: ",
          "Phone2": "الهاتف 2: ",
          "WhatsApp": "واتساب: ",
          "Admin Approved": "تمت الموافقة من قبل الأدمين: ",
          "Detail": "التفاصيل",

          //detail delivery
          "username": "اسم المستخدم",
          "primary_phone_number": "رقم الهاتف الأساسي",
          "secondary_phone_numbers": "أرقام الهاتف الثانوية",
          "car_information": "معلومات السيارة",
          "driving_licence": "رخصة القيادة",
          "license_plate_number": "رقم اللوحة",
          "insurance_expiry_date": "تاريخ انتهاء التأمين",
          "Contract_Image": "صورة العقد",
          "Accept": "قبول",
          "reject": "رفض",
          "Are_You_Sure_You_Want_Reject_The_User":
              "هل أنت متأكد أنك تريد رفض المستخدم؟",

          //storeownner
          "StoreOwner": "مالك المتجر",
          "Admin_Approved": "تم الموافقة من قبل المدير",

          //detail storeowner
          "personal_information": "المعلومات الشخصية",
          "national_id": "الهوية الوطنية",
          "id_card_number": "رقم بطاقة الهوية",
          "passport_number": "رقم جواز السفر",

          //all order
          "order_status_not_accepted": "حالة الطلب: غير مقبول",
          "order_status_accepted": "حالة الطلب: مقبول",
          "order_status_DeliveryAccept":
              "حالة الطلب: تم قبول من قبل عامل التوصيل",
          "order_status_received": "حالة الطلب: تم الاستلام",
          "order_status_deliveryToAdmin": "حالة الطلب: التوصيل للإدارة",
          "order_status_deliveryToCustomer": "حالة الطلب: التوصيل للعميل",
          "order_status_deliveredNoCity": "حالة الطلب: تم التوصيل (بدون مدينة)",
          "order_status_city": "حالة الطلب: في المدينة",
          "order_status_adminAccepted": "حالة الطلب: تم القبول من قبل الادمن",
          "order_status_delivered": "حالة الطلب: تم التوصيل",
          "order_status_delivery_fail": "حالة الطلب: فشل عامل التوصیل",
          "order_status_failed": "حالة الطلب: فشل",
          "order_number": "رقم الطلب",
          "customer_name": "اسم العميل",
          "customer_phone": "هاتف العميل",
          "customer_location": "موقع العميل",
          "order_price": "سعر الطلب",
          "order_date": "تاريخ الطلب",
          "DeliveryAccept": "تم قبول التوصيل",
          "Received": "تم الاستلام",
          "deliveryToAdmin": "التوصيل للإدارة",
          "deliveryToCustomer": "التوصيل للعميل",
          "deliveredNoCity": "تم التوصيل (بدون مدينة)",
          "City": "المدينة",
          "Delivered": "تم التوصيل",
          "Fail": "فشل",
          "No Data": "لا توجد بينات",

          //search
          "all": "الكل",
          "search": "بحث",
          "No_Result": "لا توجد بيانات",
          "Go_To_Orders": "الذهاب الى الطلبية",

          //Main Pendding
          "Waiting_delivery": "قيد القبول",
          "order_status_waitting_delivery":
              "حالة الطلب: بانتظار قبول عامل التوصيل",
          "Please_enter_the_reason_for_reject": "يرجى إدخال سبب الرفض",

          //panding 2
          "Order_QR": "QR الطلبية",
          "choose_option": "اختر طريقة ارسال الطلبية",
          "manual": "يدوي",

          //delivery order
          "Order_tracking": "تتبع الطبية",
          "ToAdmin": "إلى الادمن",
          "ToCustommer": "إالى الزبون",
          "Are_You_Sure_you_Want_Choose": "هل انت متاكد باختيارك",
          "Are_you_sure_you_want_Accept_order": "هل انت متاكد بقبولك لطلبية",
          "reject_order": "هل انت متاكد من الغاء الطلبية",

          //map delivery
          "choose_delivery": "اختر عامل التوصيل",
          "choose": "اختر",

          //order_delivery
          "my_order": "طلباتي",

          //storage
          "storage_pending": "طلبات للتخزين",
          "waiting": "انتظار",

          //qr
          "share": "مشاركة",

          //detail
          'customer_address': 'موقع الزبون:',
          "item": "البضاعة",
          "count": "العدد",
          'price': 'السعر',
          'order_day': 'يوم الطلب',

          //Delivery Failed
          "delivery_fail": "فشل عامل التوصیل",

          //////////////////////////other
          //City
          "select_All": "تحديد الكل",
          "classification": "التصنيف",
          "Deselect_all": "الغاء تحديد الكل",

          //Add City
          "AddCity": "إضافة مدينة",
          "hint_city": "أدخل اسم المدينة",
          "hint_plate": "أدخل رقم اللوحة",
          "plate": "اللوحة",
          "hint_price": "أدخل السعر",

          //Edit City
          "Edit": "تعديل",

          //add street
          "AddStreet": "إضافة شارع",
          "hint_Street": "أدخل اسم الشارع",
          "Street": "الشارع",
          "hint_StreetNumber": "أدخل رقم الشارع",
          "StreetNumber": "رقم الشارع",

          //Box Size
          "Order_Size": "حجم الطلب",
          "size": "الحجم",
          "width": "العرض",
          "Length": "الطول",
          "Height": "الارتفاع",
          "Weight": "الوزن",
          "Price": "السعر",
          "Delete": "حذف",

          //add box size
          "Add Order Box": "إضافة صندوق الطلب",
          "length": "الطول",
          "height": "الارتفاع",
          "weight": "الوزن",
          "hint_size": "أدخل حجم الصندوق",
          "hint_width": "أدخل عرض الصندوق",
          "hint_length": "أدخل طول الصندوق",
          "hint_height": "أدخل ارتفاع الصندوق",
          "hint_weight": "أدخل وزن الصندوق",

          //categories1
          "categories1": "التصنيف 1",
          "select_all": "تحديد الكل",
          "edit": "تعديل",

          //add categories1
          "add_categories": "إضافة تصنيف",
          "hint_categories": "أدخل اسم التصنيف",

          //categories2
          "categories2": "التصنيف 2",
          "add_categories2": "إضافة تصنيف 2",

          //categories3
          "categories3": "التصنيف 3",
          "add_categories3": "إضافة تصنيف 3",

          //Collection Point
          "show_map": "عرض على الخريطة",

          //Add Collection Point
          "add_collection_point": "إضافة نقطة تجميع",
          "hint_point": "أدخل اسم النقطة",
          "point": "النقطة",
          "hint_pointDetail": "أدخل تفاصيل النقطة",
          "pointDetail": "تفاصيل النقطة",
          "hint_pointTime": "أدخل وقت النقطة",
          "pointTime": "وقت النقطة",
          "hint_pointlocations": "أدخل مواقع النقطة",
          "pointlocations": "مواقع النقطة",
          "hint_pointMaps": "أدخل رابط الخريطة",
          "pointMaps": "رابط الخريطة",

          //edit Collection Point
          "hint_pointCity": "أدخل المدينة",
          "pointCity": "المدينة",

          //report
          "the_report": "التقرير: ",

          //profit
          "profit": "الأرباح",
          "delivery_worker_profit_percentage": "نسبة أرباح عامل التوصيل",
          "hint_profit": "أدخل نسبة الأرباح",

          //term
          "terms_conditions": "الشروط والأحكام",

          //Packaging
          "Packaging": "تغليف",
          "package_price": "سعر التغليف",

          //add Packaging
          "add_packaging": "إضافة تغليف",
          "packaging": "التغليف",
          "hint_packaging": "أدخل نوع التغليف",

          //edit Packaging
          "edit_packaging": "تعديل التغليف",

          //notification
          "send_notification": "ارسال اشعار",
          "send": "ارسال",
          "special": "خصص",
          "title": "العنوان",
          "body": "الرسالة",
          "choosed": "تم الاختيار",
        },

////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////
        ///
        ///

        "en": {
          "Choose_language": "Choose language",
          "1lang": "العربية",
          "2lang": "English",

          //permission
          "Please_accept_location": "Please allow location permission.",
          "Cant_run_app_without_location":
              "Can't run the app without location.",
          "Please_Open_location": "Please Open Location",

          //login
          "title1": 'Welcome Back',
          "title2": 'Sign in',
          "email": 'Email',
          "hint_email": 'Enter Your Email',
          "password": "Password",
          "forget": "Forget password?",
          "hint_password": 'Enter Your Password',
          "Text_link": "Dont have an account? ",
          "link": " Sign up",
          "verification_tilte": "Verification Code ",
          "verification_code": "Enter verification code here",
          "rest_pass": "Reset Password",
          "new_pass": "New Password",
          "success_reset": "Password reset successfully",
          "wrong": "Error",
          "emailOrPassword": "Email or Password Not correct",

          //valid
          "valid_username":
              "Please enter a valid username (only letters with spaces).",
          "valid_email": "Please enter a valid email address.",
          "valid_phone": "Please enter a valid phone number.",
          "field_required": "Field is required.",
          "min_length": "Can't be less than",
          "max_length": "Can't be more than",
          "chara": "characters.",

          //Notification
          "notification": "Notification",

          //Setting
          "profile": "Profile",
          "dark_mode": "Dark Mode",
          "contact_us": "Contact Us",
          "log_out": "Log Out",
          "theme": "Theme",
          "System": "System",
          "Dark": "Dark",
          "Light": "Light",
          "lang": "Language",

          //Home
          "home": "Home",
          "maps": "Maps",
          "orders": "Orders",
          "account": "Account",
          "other": "Other",
          "settings": "Settings",

          //map
          "map": "Map",
          "name": "Name",
          "phone": "Phone",
          "whatsapp": "WhatsApp",

          //order
          "order": "Orders",
          "order_all": "All Orders",
          "order_status": "Order Status",
          "order_pending": "Pending Orders",
          "order_pendingCustomer": "Customer Pending Orders",
          "order_city": "City Orders",
          "order_delivery": "Orders to be Delivered",
          "order_delivered": "Delivered Orders",
          "order_canceled": "Canceled Orders",
          "storage": "Storage",

          //other
          "city": "City",
          "street": "Street",
          "box_size": "Box Size",
          "categories": "Categories",
          "collection_point": "Collection Point",
          "report": "Report",

          //Account
          "admin": "Admin",
          "store_owner": "Store Owner",
          "delivery": "Delivery",

          "adminCity": "Admin in another city",
          "delivery_location": "Delivery Location",

          //admin
          "add": "Add",
          "superadmin": "Super Admin",
          "admin_pro": "Admin Pro",
          "admin_all": "Admin All",
          "admin_east": "Admin East",
          "admin_west": "Admin West",
          "admin_other": "Admin Other",
          "remove": "Remove",
          "warning": "Warning",
          "cancel": "Cancel",
          "ok": "Ok",
          "delete_warning": "Are you sure you want to delete",

          //add admin
          "add_admin": "Add Admin",
          "branch": "Branch",
          "personal_picture": "Personal Picture",
          "admin_role": "Admin Role",
          "select_city": "Select City",
          "submit": "Submit",
          "hint_name": "Enter your name",
          "hint_branch": "Enter your branch",
          "select_role": "Select role",
          "select_owner": "Select Store Owner",
          "no_image_selected": "No image selected.",
          "choose_image": "Choose Image",
          "choose_role": "Choose Admin Role",
          "choose_city": "Choose City",
          "Choose_image_source": "Choose Image Source",
          "camera": "Camera",
          "galary": "Galary",

          //delivery
          "Delivery": "Delivery",
          "not_accepted": "Not Accepted",
          "accepted": "Accepted",
          "Name": "Name: ",
          "Phone1": "Phone1: ",
          "Phone2": "Phone2: ",
          "WhatsApp": "WhatsApp: ",
          "Admin Approved": "Admin Approved: ",
          "Detail": "Detail",

          //detail delivery
          "username": "Username",
          "primary_phone_number": "Primary phone number",
          "secondary_phone_numbers": "Secondary phone numbers",
          "car_information": "Car Information",
          "driving_licence": "Driving Licence",
          "license_plate_number": "License plate number",
          "insurance_expiry_date": "Insurance expiry date",
          "Contract_Image": "Contract Image",
          "accept": "Accept",
          "Are_You_Sure_You_Want_Reject_The_User":
              "Are you sure you want to reject the user?",
          "reject": "Reject",

          //storeowner
          "StoreOwner": "Store Owner",
          "Admin_Approved": "Admin Approved",

          //detail storeowner
          "personal_information": "Personal Information",
          "national_id": "National ID",
          "id_card_number": "ID Card Number",
          "passport_number": "Passport Number",
          "Accept": "Accept",

          //all order
          "order_status_not_accepted": "Order Status: Not Accepted",
          "order_status_accepted": "Order Status: Accepted",
          "order_status_DeliveryAccept":
              "Order Status: Accepted by the delivery worker",
          "order_status_received": "Order Status: Received",
          "order_status_deliveryToAdmin": "Order Status: Delivery to Admin",
          "order_status_deliveryToCustomer":
              "Order Status: Delivery to the Customer",
          "order_status_deliveredNoCity":
              "Order Status: Delivered without a specified city",
          "order_status_city": "Order Status: In City",
          "order_status_adminAccepted": "Order Status: Admin Accept The Order",
          "order_status_delivered": "Order Status: Delivered",
          "order_status_delivery_fail": "Order Status: Delivery Failed",
          "order_status_failed": "Order Status: Failed",
          "order_number": "Order Number",
          "customer_name": "Customer Name",
          "customer_phone": "Customer Phone",
          "customer_location": "Customer Location",
          "order_price": "Order Price",
          "order_date": "Order Date",
          "DeliveryAccept": "Delivery Accepted",
          "Received": "Received",
          "deliveryToAdmin": "Delivery to Admin",
          "deliveryToCustomer": "Delivery to Customer",
          "deliveredNoCity": "Delivered (No City)",
          "City": "City",
          "Delivered": "Delivered",
          "Fail": "Failed",
          "No Data": "No Data",

          //search
          "all": "All",
          "search": "Search",
          "No_Result": "No Result",
          "Go_To_Orders": "Go To The Order",

          //Main Pendding
          "Waiting_delivery": "Pending acceptance",
          "order_status_waitting_delivery": "order status: Pending acceptance",
          "Please_enter_the_reason_for_reject":
              "Please Enter The Reason For Reject",

          //panding 2
          "Order_QR": "Order QR",
          "choose_option": "Choose the order delivery method",
          "manual": "Manual",

          //delivery order
          "Order_tracking": "Treacking Order",
          "ToAdmin": "To Admin",
          "ToCustommer": "To Custommer",
          "Are_You_Sure_you_Want_Choose": "Are You Sure you Want Choose",
          "Are_you_sure_you_want_Accept_order":
              "Are you sure you want Accept order",
          "reject_order": "Are You Sure You Want Reject order",
          //map delivery
          "choose_delivery": "Choose Delivery",
          "choose": "Choose",

          //order_delivery
          "my_order": "My Order",

          //storage
          "storage_pending": "storage Order",
          "waiting": "Waitting",

          //qr
          "share": "Share",

          //detail
          'customer_address': 'Customer address:',
          "item": "Item",
          "count": "Count",
          'price': 'Price',
          'order_day': 'Order Day',

          //Delivery Failed
          "delivery_fail": "Delivery Failed",

          //////////////////////////other

          //City
          "select_All": "Select All",
          "classification": "Classification",
          "Deselect_all": "Deselect All",

          //Add City
          "AddCity": "Add City",
          "hint_city": "Enter city name",
          "hint_plate": "Enter plate number",
          "plate": "Plate",
          "hint_price": "Enter price",

          //Edit City
          "Edit": "Edit",

          //add street
          "AddStreet": "Add Street",
          "hint_Street": "Enter street name",
          "Street": "Street",
          "hint_StreetNumber": "Enter street number",
          "StreetNumber": "Street Number",

          /////////////////////Box size
          "Order_Size": "Order Size",
          "size": "Size",
          "width": "Width",
          "Length": "Length",
          "Height": "Height",
          "Weight": "Weight",
          "Price": "Price",
          "Delete": "Delete",

          //add box size
          "Add Order Box": "Add Order Box",
          "length": "Length",
          "height": "Height",
          "weight": "Weight",
          "hint_size": "Enter box size",
          "hint_width": "Enter box width",
          "hint_length": "Enter box length",
          "hint_height": "Enter box height",
          "hint_weight": "Enter box weight",

          //categories1
          "categories1": "Categories 1",
          "select_all": "Select All",
          "edit": "Edit",

          //add categories1
          "add_categories": "Add Categories",
          "hint_categories": "Enter category name",

          //categories2
          "categories2": "Categories 2",
          "add_categories2": "Add Categories 2",

          //categories3
          "categories3": "Categories 3",
          "add_categories3": "Add Categories 3",

          //Collection Point
          "show_map": "Show on Map",

          //Add Collection Point
          "add_collection_point": "Add Collection Point",
          "hint_point": "Enter point name",
          "point": "Point",
          "hint_pointDetail": "Enter point details",
          "pointDetail": "Point Details",
          "hint_pointTime": "Enter point time",
          "pointTime": "Point Time",
          "hint_pointlocations": "Enter point locations",
          "pointlocations": "Point Locations",
          "hint_pointMaps": "Enter map link",
          "pointMaps": "Map Link",

          //Edit Collection Point
          "hint_pointCity": "Enter city",
          "pointCity": "City",

          //report
          "the_report": "The Report: ",

          //profit
          "profit": "Profit",
          "delivery_worker_profit_percentage":
              "Delivery Worker Profit Percentage",
          "hint_profit": "Enter profit percentage",

          //term
          "terms_conditions": "Terms & Conditions",

          //Packaging
          "Packaging": "Packaging",
          "package_price": "Package Price",

          //addPackaging
          "add_packaging": "Add Packaging",
          "packaging": "Packaging",
          "hint_packaging": "Enter packaging type",

          //Edit Packaging
          "edit_packaging": "Edit Packaging",

          //notification
          "send_notification": "Send Notification",
          "send": "Send",
          "special": "Customize",
          "title": "Title",
          "body": "Body",
          "choosed": "Selected",
        }
      };
}
