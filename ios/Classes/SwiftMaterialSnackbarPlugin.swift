import Flutter
import UIKit

public class SwiftMaterialSnackbarPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "material_snackbar", binaryMessenger: registrar.messenger())
    let instance = SwiftMaterialSnackbarPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
