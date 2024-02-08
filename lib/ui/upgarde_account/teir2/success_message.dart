import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';

class UpgardeTierSuccessPage extends StatefulWidget {
  const UpgardeTierSuccessPage({super.key});

  @override
  State<UpgardeTierSuccessPage> createState() => _UpgardeTierSuccessPageState();
}

class _UpgardeTierSuccessPageState extends State<UpgardeTierSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID Submission successful and under review ',
              style: Theme.of(context).textTheme.displaySmall!,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text: 'Go Home',
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()));


              },
            )
          ],
        ),
      ),
    );
  }
}
