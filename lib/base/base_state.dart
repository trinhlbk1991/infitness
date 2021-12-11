import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/network_utils.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/progress_dialog.dart';
import 'package:infitness/widgets/space.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool hasNetwork = true;
  late FToast fToast;

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

    fToast = FToast();
    fToast.init(context);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    _showToast(
      context,
      message: error,
      icon: Icons.error_outline_rounded,
      color: Colors.red[700]!,
    );
  }

  showSuccess(BuildContext context, String message) {
    _showToast(
      context,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green[700]!,
    );
  }

  showWarning(BuildContext context, String message) {
    _showToast(
      context,
      message: message,
      icon: Icons.warning_amber_rounded,
      color: Colors.yellow[800]!,
    );
  }

  showInfo(BuildContext context, String message) {
    _showToast(
      context,
      message: message,
      icon: Icons.lightbulb_rounded,
      color: Colors.blue[700]!,
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

  _showToast(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color color,
  }) {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.NORMAL_2,
        vertical: Spacing.NORMAL,
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          Space(),
          Expanded(child: AppText(message, color: Colors.white)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
