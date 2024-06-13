import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let eventChannel = FlutterEventChannel(name: "com.timeEvent", binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(TimeHandler())


        let randomChannel = FlutterMethodChannel(name: "com.randomNumber",
                                                  binaryMessenger: controller.binaryMessenger)
        randomChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if call.method == "getRandomNumber" {
            self.generateRandomNumber(result: result)
          } else {
            result(FlutterMethodNotImplemented)
          }
        }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func generateRandomNumber(result: FlutterResult) {
      let randomNum = Int.random(in: 1...100)
      result(randomNum)
    }


 class TimeHandler: NSObject, FlutterStreamHandler {
        // Handle events on the main thread.
        var timer = Timer()
        // Declare our eventSink, it will be initialized later
        private var eventSink: FlutterEventSink?

        func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
            print("onListen......")
            self.eventSink = eventSink

            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm:ss"
                    let time = dateFormat.string(from: Date())
                    eventSink(time)
            })


            return nil
        }

        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            eventSink = nil
            return nil
        }
    }
}
