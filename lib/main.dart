import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
    home: MyApp()
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    //Declare Settings  of notification for Android and ios device
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('mipmap/ic_launcher');
    // var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, /*iOS*/);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotificationEmpLocation,
        onDidReceiveNotificationResponse: onSelectNotificationEmpLocation
    );
  }


  // action perform on select notification - open alert dialog
  static onSelectNotificationEmpLocation(NotificationResponse notificationResponse){
    var payload = notificationResponse.payload.toString();
    debugPrint("payload : $payload");
    showGenericDialog(payload);
  }

  // action perform on select notification - naviagte to another page
//  Future onSelectNotification(String payload) async{
//    await Navigator.push(context, MaterialPageRoute(
//        builder: (context) => SecondPage(payload:payload)),);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local Notification'),
        ),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Coding With Suraj',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold),),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: showNotification,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lime,
                            Colors.cyan
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text('Click For Push Notification',
                        style: TextStyle(fontSize: 20,)
                    ),
                  ),
                ),
              ],
            )
        ));
  }

  void showNotification() async{

    //Set Details of notification  to display
    var android =const AndroidNotificationDetails('channelId', 'channelName',);
    // var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, /*iOS*/);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Hello Suraj Tiwari',
        'Good Morning Guys . How are you?',
        platform,
        payload: 'Hurray !!! Code suraj Example work.'
    );
  }

  static Future showGenericDialog(String payloadData){
    return Get.dialog(
        AlertDialog(content: Text(payloadData.toString(), style: GoogleFonts.nunitoSans(
          fontSize: Get.width*0.045,
          fontWeight: FontWeight.w500,
        )),)
    );
  }
}