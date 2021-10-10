import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/network_utils.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/progress_dialog.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool hasNetwork = true;

  @override
  void initState() {
    super.initState();
    NetworkUtils.hasInternet().then((value) {
      setState(() {
        hasNetwork = value;
      });
    });

    NetworkUtils.onConnectivityChanged.listen((event) {
      setState(() {
        hasNetwork = event != ConnectivityResult.none;
      });
    });
  }

  Widget scaffold({
    required Widget child,
    Widget? bottomNavigationBar,
    Widget? fab,
    Key? key,
  }) =>
      Scaffold(
        key: key,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Builder(
            builder: (context) => SafeArea(
              top: false,
              child: Column(
                children: [
                  _networkIndicator(),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: fab,
      );

  Widget scaffoldSafe({
    required Widget child,
    Widget? bottomNavigationBar,
    Widget? fab,
    Key? key,
  }) =>
      Scaffold(
        key: key,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Builder(
            builder: (context) => SafeArea(
              child: Column(
                children: [
                  _networkIndicator(),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: fab,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.all(Spacing.NORMAL),
          content: AppText(error, color: Colors.white),
          leading: Icon(Icons.error_outline_rounded),
          backgroundColor: Colors.red[700],
          actions: [],
        ),
      );
  }

  showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.all(Spacing.NORMAL),
          content: AppText(message, color: Colors.white),
          leading: Icon(Icons.check_circle_outline_rounded),
          backgroundColor: Colors.green[700],
          actions: [],
        ),
      );
  }

  showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.all(Spacing.NORMAL),
          content: AppText(message, color: Colors.white),
          leading: Icon(Icons.warning_amber_rounded),
          backgroundColor: Colors.yellow[800],
          actions: [],
        ),
      );
  }

  showProgress(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    ProgressDialog.show(context, message: message);
  }

  dismissProgress() {
    Navigator.of(context).pop();
  }

  Widget _networkIndicator() => !hasNetwork
      ? Container(
          height: 40,
          width: double.infinity,
          color: Colors.yellow[600],
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: Spacing.NORMAL,
            right: Spacing.NORMAL,
            top: Spacing.TINY,
            bottom: Spacing.TINY,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: Spacing.NORMAL),
                child: Icon(Icons.wifi_off_rounded, color: AppColors.PRIMARY),
              ),
              AppText('No network connection', color: AppColors.PRIMARY),
            ],
          ),
        )
      : Container();
}
