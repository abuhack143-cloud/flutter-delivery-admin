import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/imageasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Lottie.asset(
                AppImageAsset.loading,
                width: 120,
              ),
            ),
          )
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Lottie.asset(AppImageAsset.offline,
                      width: 300, fit: BoxFit.contain),
                ),
              )
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Lottie.asset(
                      AppImageAsset.server,
                      width: 300,
                    ),
                  ))
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Lottie.asset(
                            AppImageAsset.noData,
                            width: 300,
                          ),
                        ),
                      )
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final void Function()? onPressed;
  const HandlingDataRequest(
      {super.key,
      required this.statusRequest,
      required this.widget,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Lottie.asset(
                AppImageAsset.loading,
                width: 120,
              ),
            ),
          )
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Lottie.asset(AppImageAsset.offline,
                      width: 300, fit: BoxFit.contain),
                ),
              )
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Lottie.asset(
                          AppImageAsset.server,
                          width: 300,
                        ),
                        IconButton(
                            onPressed: onPressed,
                            icon: Icon(
                              Icons.refresh,
                              color: Appcolor.red,
                            ))
                      ],
                    ),
                  ))
                : widget;
  }
}
