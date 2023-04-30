import '/modules/introduction_screen/introduction_screen.dart';
import '/modules/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'settings_controller.dart';
import '/modules/notifications/notifications_demo.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int durationTime = 30;
  int notyTimes = 4;
  bool toggleState = false;
  @override
  void initState() {
    super.initState();
    durationTime = userPreferences.getTime() ?? 30;
    notyTimes = userPreferences.getNoty() ?? 4;
    userPreferences.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Select theme',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Container(
                            width: 40,
                          ),
                          DropdownButton<ThemeMode>(
                            value: widget.controller.themeMode,
                            onChanged: widget.controller.updateThemeMode,
                            items: const [
                              DropdownMenuItem(
                                value: ThemeMode.system,
                                child: Text('System Theme'),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.light,
                                child: Text('Light Theme'),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.dark,
                                child: Text('Dark Theme'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Breath holding time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Slider(
                          value: durationTime.toDouble(),
                          activeColor: Colors.lightBlue,
                          inactiveColor: Colors.blueGrey,
                          divisions: 20,
                          min: 20.0,
                          max: 120.0,
                          label: '$durationTime Seconds',
                          thumbColor: Colors.blue[700],
                          onChanged: (value) {
                            setState(() {
                              durationTime = value.toInt();
                              setTime();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Notifications reminder',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Slider(
                          value: notyTimes.toDouble(),
                          activeColor: Colors.lightBlue,
                          inactiveColor: Colors.blueGrey,
                          divisions: 10,
                          min: 0.0,
                          max: 10.0,
                          label: '$notyTimes Times a day',
                          thumbColor: Colors.blue[700],
                          onChanged: (valueNoty) {
                            setState(() {
                              notyTimes = valueNoty.toInt();
                              setNoty();
                              switch (notyTimes) {
                                case 0:
                                  break;
                                case 2:
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(16),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        Navigator.restorablePushNamed(
                          context,
                          IntroductionScreen.routeName,
                        );
                      },
                      child: const Text(
                        'See Help',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(16),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        Navigator.restorablePushNamed(
                          context,
                          Noty.routeName,
                        );
                      },
                      child: const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void setTime() async {
    await userPreferences.setTime(durationTime);
  }

  void setNoty() async {
    await userPreferences.setNoty(notyTimes);
  }
}
