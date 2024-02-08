import 'dart:async';


import 'package:airruppies/ui/home/models/advert_model.dart';
import 'package:flutter/material.dart';

class AdvertBoard extends StatefulWidget {
 const AdvertBoard({super.key, this.advertList});
 final  List<AdvertModel>? advertList;

  @override
  State<AdvertBoard> createState() => _AdvertBoardState();
}

class _AdvertBoardState extends State<AdvertBoard> {
  List<AdvertModel>? advertData;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1.0);
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), _handleTimer);
  }

  void _handleTimer(Timer timer) {
    if (_currentIndex < widget.advertList!.length) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }

    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: widget.advertList!.isEmpty ? 0 : 100,
      child: Stack(children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Row(
            //   children: List.generate(
            //       advertData!.length,
            //       (index) => Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10),
            //             child: Container(
            //               height: 5,
            //               width: 5,
            //               decoration: BoxDecoration(
            //                   color:
            //                       int == index ? Colors.blue : Colors.red),
            //             ),
            //           )),
            // )
          ],
        ),
        PageView.builder(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.advertList![index].image,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                ),
              );
            },
            // separatorBuilder: (context, int) {
            //   return Container(
            //     width: 10,
            //   );
            // },
            itemCount: widget.advertList!.length),
      ]),
    ));
  }
}
