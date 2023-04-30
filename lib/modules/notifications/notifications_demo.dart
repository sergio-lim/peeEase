import '/modules/home_screen/views/home_screen.dart';
import '/services/local_notification_services.dart';
import 'package:flutter/material.dart';
import '/services/erase.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class Noty extends StatefulWidget {
  const Noty({Key? key}) : super(key: key);

  static const routeName = '/noty';

  @override
  State<Noty> createState() => _NotyState();
}

class _NotyState extends State<Noty> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noty Page')),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
              onPressed: () async {
                await service.showNoty(
                  id: 0,
                  title: 'Reminder',
                  body: 'Take a minute to practice your breathing',
                  seconds: 5,
                  payload: '',
                );
              },
              child: Text('Not working')),
          OutlinedButton(
              onPressed: () async {
                await service.showNoty(
                  id: 0,
                  title: 'Reminder',
                  body: 'Take a minute to practice your breathing',
                  seconds: 5,
                  payload: '',
                );
              },
              child: Text('Send Notification')),
          OutlinedButton(
              onPressed: () {
                print(
                  tz.TZDateTime.from(
                    DateTime.now().add(Duration(seconds: 2)),
                    tz.local,
                  ),
                );
                var info = tz.TZDateTime.from(
                  DateTime.now().add(Duration(seconds: 2)),
                  tz.local,
                );
              },
              child: Text(''))
        ],
      ))),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => Noty())));
    }
  }
}
