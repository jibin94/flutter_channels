## Event Channel & Method Channel
In Flutter, the MethodChannel and EventChannel classes are used for communication between Dart code and platform-specific code (written in Java, Kotlin, Objective-C, or Swift).
Here’s an overview of the differences between MethodChannel and EventChannel:<br />

1. **MethodChannel**: It is used for invoking platform-specific methods from Dart and receiving the results back. It enables bi-directional communication where Dart code can call methods in platform-specific code and receive the results asynchronously.
   Dart-to-Platform: In Dart, you use the invokeMethod method on the MethodChannel to call a platform-specific method. On the platform side, you handle the method invocation and return the result asynchronously.
   Platform-to-Dart: After the platform-specific method completes execution, it can use the Result object to send a result or error back to the Dart side.
   
   `final platformChannel = MethodChannel('channel_name');`<br />
   `final result = await platformChannel.invokeMethod('method_name', arguments);`

2. **EventChannel**: It is used for receiving continuous streams of events or data from platform-specific code. It enables the platform-specific code to send streams of data or events to the Dart side.
   Platform-to-Dart: On the platform side, you set up a stream of events or data and send them using the EventSink.
   Dart-to-Platform: In Dart, you listen to the stream provided by the EventChannel to receive the events or data sent from the platform.
    
   `final eventChannel = EventChannel('channel_name');`<br />
   `final eventStream = eventChannel.receiveBroadcastStream();`

In summary, MethodChannel is used for invoking platform-specific methods and receiving results asynchronously, while EventChannel is used for receiving continuous streams of events or data from the platform. Both channels facilitate communication between Dart and platform-specific code in Flutter applications.
