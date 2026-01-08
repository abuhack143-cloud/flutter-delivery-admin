import 'package:admin/controller/account/admin/PersonalPicture_controller.dart';
import 'package:admin/controller/account/admin/addAdmin_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdmin extends StatelessWidget {
  const AddAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddadminController());
    Get.put(PersonalPictureControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "add_admin".tr,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GetBuilder<AddadminController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    children: [
                      Customtextformauth(
                        hintText: 'hint_name'.tr,
                        labelText: 'name'.tr,
                        iconData: Icons.person,
                        mycontroller: controller.name,
                        valid: (val) {
                          return validInput(val!, 3, 254, "name");
                        },
                        type: TextInputType.text,
                      ),
                      Customtextformauth(
                        hintText: 'hint_email'.tr,
                        labelText: 'email'.tr,
                        iconData: Icons.email_outlined,
                        mycontroller: controller.email,
                        valid: (val) {
                          return validInput(val!, 6, 254, "email");
                        },
                        type: TextInputType.text,
                      ),
                      Customtextformauth(
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        obscureText: controller.isshowpassword,
                        hintText: 'hint_password'.tr,
                        labelText: 'password'.tr,
                        iconData: controller.isshowpassword
                            ? Icons.lock_outline
                            : Icons.lock_open_outlined,
                        mycontroller: controller.password,
                        valid: (val) {
                          return validInput(val!, 8, 32, "password");
                        },
                        type: TextInputType.text,
                      ),
                      Customtextformauth(
                        hintText: 'hint_branch'.tr,
                        labelText: 'branch'.tr,
                        iconData: Icons.person,
                        mycontroller: controller.branch,
                        valid: (val) {
                          return validInput(val!, 3, 254, "name");
                        },
                        type: TextInputType.text,
                      ),
                      GetBuilder<PersonalPictureControllerImp>(
                          builder: (controller) {
                        return Row(
                          children: [
                            controller.image.value == null
                                ? Text('no_image_selected'.tr)
                                : Image.file(
                                    controller.image.value!,
                                    width: 40,
                                    height: 40,
                                  ),
                            GestureDetector(
                              onTap: controller.showImageSourceDialog,
                              child: Text(
                                'personal_picture'.tr,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.blue),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        );
                      }),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'choose_role'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          items: controller.items,
                          value: controller.selectedValue,
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedValue = value;
                              controller.selectcity = [];
                              controller.selectedCity = '';
                              if (controller.selectedValue == "admin_other") {
                                controller.cityData();
                              }
                              controller.update();
                            }
                          },
                          buttonStyleData: ButtonStyleData(
                            width: double.infinity,
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: controller.selectedValue == null
                                    ? Colors.grey
                                    : Appcolor.primary,
                                width: 1,
                              ),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.selectedValue == "admin_other")
                        CustomDroplist(
                          multi: true,
                          selectedcolor: controller.selectcity.isNotEmpty,
                          errorcolor: controller.isCityError,
                          droptext: 'city'.tr,
                          data: controller.city,
                          text: 'city'.tr,
                          fornull: controller.selectcity.isNotEmpty,
                          selected: controller.selectcity.join(", "),
                          dropWWidth: MediaQuery.of(context).size.width * 0.83,
                          onSelected: (List<dynamic> selectedList) {
                            if (selectedList.isNotEmpty) {
                              controller.selectcity = selectedList
                                  .whereType<SelectedListItem>()
                                  .map((item) => item.data.toString())
                                  .toList();

                              controller.selectedCity = selectedList
                                  .whereType<SelectedListItem>()
                                  .map((item) => item.value.toString())
                                  .join(", ");
                              controller.isCityError = false;
                              controller.listOwner = [];
                              controller.ownerData();
                              // تحديث واجهة المستخدم
                              controller.update();
                            }
                          },
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.selectcity.isNotEmpty)
                        CustomDroplist(
                          multi: true,
                          selectedcolor: controller.listOwner.isNotEmpty,
                          errorcolor: controller.isOwnerError,
                          droptext: 'StoreOwner'.tr,
                          data: controller.ownerListItem,
                          text: 'StoreOwner'.tr,
                          fornull: controller.listOwner.isNotEmpty,
                          selected: controller.listOwner.join(", "),
                          dropWWidth: MediaQuery.of(context).size.width * 0.83,
                          onSelected: (List<dynamic> selectedList) {
                            if (selectedList.isNotEmpty) {
                              controller.listOwner = selectedList
                                  .whereType<SelectedListItem>()
                                  .map((item) => item.data.toString())
                                  .toList();

                              controller.stringOwner = selectedList
                                  .whereType<SelectedListItem>()
                                  .map((item) => item.value.toString())
                                  .toList();
                              controller.isOwnerError = false;
                              controller.update();
                            }
                          },
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButtonSubmit(
                        text: "add".tr,
                        loading:
                            controller.statusRequest == StatusRequest.loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : null,
                        onTap: controller.statusRequest == StatusRequest.loading
                            ? null
                            : () {
                                controller.addAdmin();
                              },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
