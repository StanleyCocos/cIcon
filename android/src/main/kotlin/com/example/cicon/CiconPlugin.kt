package com.example.cicon

import android.content.ComponentName
import android.content.Context
import android.content.pm.ActivityInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Boolean

/** CiconPlugin */
class CiconPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private var TAG: String = "FlutterIconSwitcherPlugin"
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cicon")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "setIcons" -> {
        try {
          setIcon(call.arguments as String)
          result.success(true)
        } catch (e: Exception) {
          e.printStackTrace()
        }
      }
      "restoreIcon" -> {
        try {
          restoreIcon()
          result.success(true)
        } catch (e: Exception) {
          e.printStackTrace()
        }
      }
      "getIcon" -> {
        try {
          val icon = getEnabledComponent()?.name?.split(".")?.last() ?: ""
          result.success(icon)
        } catch (e: Exception) {
          e.printStackTrace()
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun setIcon(name: String?) {
    // Get the packageName of the app
    val packageName = context.packageName
    // Get the class name of the activity-alias
    val className = String.format("%s.%s", packageName, name)
    val oldName: Array<ActivityInfo> = getActivities()
    val pm: PackageManager = context.packageManager
    pm.setComponentEnabledSetting(
      ComponentName(packageName, className),
      PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
      PackageManager.DONT_KILL_APP
    )
    for (activity in oldName) {
      if (!activity.name.equals(className)) {
        pm.setComponentEnabledSetting(
          ComponentName(packageName, activity.name),
          PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
          PackageManager.DONT_KILL_APP
        )
      }
    }
  }

  private fun restoreIcon() {
    setIcon("default");
  }

  private fun getEnabledComponent(): ActivityInfo? {
    val activityInfos = getActivities()
    var enabledComponent: ActivityInfo? = null
    for (currentComponent in activityInfos) {
      if (currentComponent.enabled) {
          enabledComponent = currentComponent
      }
    }
    return enabledComponent
  }

  private fun getActivities(): Array<ActivityInfo> {
    val activityInfos: Array<ActivityInfo>
    val pm = context.packageManager
    val packageName = context.packageName
    try {
      val info: PackageInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        pm.getPackageInfo(packageName,
          PackageManager.GET_ACTIVITIES or PackageManager.MATCH_DISABLED_COMPONENTS)
      } else {
        pm.getPackageInfo(packageName,
          PackageManager.GET_ACTIVITIES or PackageManager.GET_DISABLED_COMPONENTS)
      }
      activityInfos = info.activities
      Log.d(TAG, "Found this configured activities:")
      for (activityInfo in activityInfos) {
        Log.d(TAG, "${activityInfo.name} ${activityInfo.isEnabled}")
      }
      return activityInfos
    } catch (e: PackageManager.NameNotFoundException) {
      Log.e(TAG, e.toString())
    }
    return emptyArray()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
