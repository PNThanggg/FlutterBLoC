import 'package:flutter/services.dart';

import '../app_log/app_log.dart';
import 'native_result.dart';

class NativeChannel {
  MethodChannel? platform;

  static final NativeChannel _instance = NativeChannel._internal();

  NativeChannel get instance => _instance;

  factory NativeChannel() {
    return _instance;
  }

  NativeChannel._internal() {
    platform = const MethodChannel("native_channel");
  }

  Future<NativeResult> _nativeFunction(String methodName) async {
    NativeResult result = NativeResult();

    try {
      final resultNative = await platform?.invokeMethod(methodName);

      result = NativeResult(
        success: true,
        code: "-1",
        message: "",
        data: resultNative,
      );
    } on PlatformException catch (e) {
      result = NativeResult(
        success: false,
        code: e.code,
        message: e.message,
        data: null,
      );
    }

    AppLog.verbose(result.toJson());

    return result;
  }

  Future<int> getCurrentVolume() async {
    NativeResult result = await _nativeFunction('get_volume');

    if (result.success == true) {
      AppLog.info("result.data: ${result.data as int}");
      return result.data as int;
    } else {
      AppLog.info("result.code: ${result.code}");
      AppLog.info("result.message: ${result.message}");
      return -1;
    }
  }

  Future<void> adjustRaiseVolume() async {
    NativeResult result = await _nativeFunction('adjust_raise');

    if (result.success == true) {
      AppLog.info("result.data: ${result.data as String}");
    } else {
      AppLog.info("result.code: ${result.code}");
      AppLog.info("result.message: ${result.message}");
    }

    return;
  }

  Future<void> adjustLowerVolume() async {
    NativeResult result = await _nativeFunction('adjust_lower');

    if (result.success == true) {
      AppLog.info("result.data: ${result.data as String}");
    } else {
      AppLog.info("result.code: ${result.code}");
      AppLog.info("result.message: ${result.message}");
    }

    return;
  }

  Future<void> mute() async {
    NativeResult result = await _nativeFunction('mute');

    if (result.success == true) {
      AppLog.info("result.data: ${result.data as String}");
    } else {
      AppLog.info("result.code: ${result.code}");
      AppLog.info("result.message: ${result.message}");
    }

    return;
  }
}
