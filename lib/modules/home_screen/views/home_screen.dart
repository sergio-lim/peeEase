import 'package:flutter/material.dart';
import '/widgets/mainAppBar.dart';
import 'dart:async';
import '/modules/shared_preferences/user_preferences.dart';

enum ButtonState { init, loading, done }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int durationTime = 30;

  @override
  void initState() {
    super.initState();
    durationTime = userPreferences.getTime() ?? 30;
    userPreferences.init();
  }

  bool isAnimating = true;
  ButtonState state = ButtonState.init;

  @override
  Widget build(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;
    final isStreched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    return Scaffold(
      appBar: mainAppBar(context),
      body: Center(
        child: GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeIn,
            height: 80,
            width: state == ButtonState.init ? width : 80,
            onEnd: () => setState(
              () => isAnimating = !isAnimating,
            ),
            child: isStreched
                ? buildButton(durationTime.toInt())
                : buildSmallButton(isDone, durationTime.toInt()),
          ),
          onTap: () {
            if (state == ButtonState.loading) {
              setState(() {
                state = ButtonState.init;
              });
            }
          },
        ),
      ),
    );
  }

  Widget buildButton(durationTime) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 12,
          backgroundColor: Colors.indigo[300],
          side: const BorderSide(
            width: 6,
            color: Colors.indigoAccent,
          ),
          shape: const CircleBorder(),
        ),
        child: const Text(
          'Start',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () async {
          setState(() => state = ButtonState.loading);

          await Future.delayed(
              Duration(seconds: userPreferences.getTime() ?? 0));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() => state = ButtonState.init);
        },
        onLongPress: () async {
          setState(() => state = ButtonState.loading);

          await Future.delayed(const Duration(seconds: 0));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() => state = ButtonState.init);
        },
      );

  Widget buildSmallButton(isDone, durationTime) {
    final color = isDone ? Colors.green[300] : Colors.indigo[300];

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Container(
        child: isDone
            ? const Icon(
                Icons.done,
                size: 52,
                color: Colors.white,
              )
            : TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: userPreferences.getTime() ?? 0),
                builder: (context, double value, _) => SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: value,
                    color: Colors.green,
                    backgroundColor: Colors.indigoAccent,
                    strokeWidth: 6,
                  ),
                ),
              ),
      ),
    );
  }
}
