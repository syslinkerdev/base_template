import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';

Future<void> isNotConnectedThrowError() async {
  final checkInternet = await isNotConnected();
  if (checkInternet == true) {
    //debugPrint(
    //   "error from: No Internet Connection , error: Please connect to a WiFi or mobile network to continue.",
    // );
    throw convertToAppException(
      title: 'No Internet Connection',
      exception: 'Please check your Internet connection and try again',
      exceptionType: ExceptionType.internet,
    );
  }
}

Future<bool> isNotConnected() async {
  final List<ConnectivityResult> result =
      await Connectivity().checkConnectivity();
  return _checkInternet(result);
}

bool _checkInternet(List<ConnectivityResult> result) {
  if (result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.mobile)) {
    return false;
  } else if (result.contains(ConnectivityResult.none)) {
    return true;
  } else {
    return false;
  }
}
