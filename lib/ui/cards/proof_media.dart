import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';

class ProofOfResidencyWidget extends StatefulWidget {
  const ProofOfResidencyWidget({super.key});

  @override
  State<ProofOfResidencyWidget> createState() => _ProofOfResidencyWidgetState();
}

class _ProofOfResidencyWidgetState extends State<ProofOfResidencyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Proof of residency',
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 7),
                  Text('Prove you live in Indonesia',
                      style: TextStyles()
                          .greyTextStyle()
                          .copyWith(fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 40),
                  Text('Method of verification',
                      style: TextStyles()
                          .greyTextStyle()
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 20,
                  ),
                  proofItem('Identity Card', 'Issued in Nigeria'),
                  const SizedBox(
                    height: 10,
                  ),
                  proofItem('Home Address', 'Address in Nigeria')
                ],
              ),
            ),
            MyButton(
              text: 'Continue',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProofOfResidencyWidget()));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget proofItem(String firstString, String secondString) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: const Color(0xffF9F9FA)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Text('d'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstString,
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      secondString,
                      style: TextStyles()
                          .greyTextStyle()
                          .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios , size: 14,)
          ],
        ),
      ),
    );
  }
}
