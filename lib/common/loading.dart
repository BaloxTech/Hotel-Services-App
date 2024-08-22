import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Loadingg extends StatefulWidget {
  const Loadingg({Key? key}) : super(key: key);

  @override
  State<Loadingg> createState() => _LoadinggState();
}

class _LoadinggState extends State<Loadingg>
// with SingleTickerProviderStateMixin
{
  // late AnimationController controller;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 1),
  //   );
  //   startAnimation();
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  // startAnimation() async {
  //   controller.forward();
  //   controller.repeat();
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SmartDialog.dismiss();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const SizedBox(
              width: 80,
              height: 80,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Loading(),
                    SizedBox(height: 10),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(60)),
            child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor))));
  }
}
