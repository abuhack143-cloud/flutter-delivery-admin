import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/constant/color.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomDroplist extends StatelessWidget {
  final bool errorcolor;
  final String droptext;
  final List<SelectedListItem> data;
  final void Function(List<SelectedListItem>)? onSelected;
  final String text;
  final bool fornull;
  final String selected;
  final double dropWWidth;
  final bool selectedcolor;
  final bool multi;
  const CustomDroplist(
      {super.key,
      required this.errorcolor,
      required this.droptext,
      required this.data,
      this.onSelected,
      required this.text,
      required this.fornull,
      required this.selected,
      required this.dropWWidth,
      required this.selectedcolor,
      required this.multi});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          shape: OutlineInputBorder(
            borderSide: BorderSide(
              color: errorcolor
                  ? Colors.red
                  : selectedcolor
                      ? Appcolor.primary
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            DropDownState(
              dropDown: DropDown(
                bottomSheetTitle: Text(
                  droptext,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                submitButtonChild: Text(
                  'ok'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                clearButtonChild: Text(
                  'cancel'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                deSelectAllTextButtonChild: Text(
                  'Deselect_all'.tr,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                selectAllTextButtonChild: Text(
                  'select_All'.tr,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                data: data,
                onSelected: onSelected,
                enableMultipleSelection: multi,
              ),
            ).showModal(context);
          },
          child: Container(
            width: dropWWidth,
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                ),
                if (fornull)
                  Text(
                    selected,
                    style:
                        const TextStyle(color: Appcolor.primary, fontSize: 12),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
