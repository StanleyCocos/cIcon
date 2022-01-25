
import 'dart:async';

import 'package:flutter/services.dart';

class Cicon {
  static const MethodChannel _channel = MethodChannel('cicon');

  /// @title setIcon
  /// @description 修改设备桌面Icon
  /// @param: name 替换的icon文件名称
  /// @return Future
  /// @updateTime 2022/1/25 10:00 上午
  /// @author 10456
  static Future setIcon({required String name}) async {
    return await _channel.invokeMethod("setIcons", name);
  }

  /// @title restoreIcon
  /// @description 恢复成默认Icon
  /// @return Future
  /// @updateTime 2022/1/25 10:00 上午
  /// @author 10456
  static Future restoreIcon() async {
    return await _channel.invokeMethod("restoreIcon");
  }

  /// @title currentIcon
  /// @description 获取当前icon名称
  /// @return Future
  /// @updateTime 2022/1/25 10:00 上午
  /// @author 10456
  static Future<String?> get currentIcon async {
    return await _channel.invokeMethod("getIcon");
  }
}
