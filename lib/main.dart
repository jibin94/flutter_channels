import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomNumber = 0;
  static const platformChannel = MethodChannel('com.randomNumber');
  static const eventChannel = EventChannel('com.timeEvent');

  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platformChannel.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      randomNumber = random;
    });
  }

  Stream<String> streamTimeFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Flutter channels",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Method channel generates the following number:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              '$randomNumber',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Event channel timer :',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            StreamBuilder<String>(
              stream: streamTimeFromNative(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: _generateRandomNumber,
        tooltip: 'Generate',
        child: const Icon(
          Icons.restart_alt,
          color: Colors.white,
        ),
      ),
    );
  }
}
