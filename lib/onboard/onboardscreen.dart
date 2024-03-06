import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/login.dart';

import '../utils/checkuser.dart';


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController = PageController(
    initialPage: _foodlist.length * 9999,
  );
  List<OnBoardModel> _foodlist = foodList;

  double get _currentOffset {
    bool inited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return inited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currentOffset.round() % _foodlist.length;


  @override
  void initState() {
    CheckUser().isLogin(context);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return _buildScreen();
        },
      ),
    );
  }

  Stack _buildScreen() {
    final Size size = MediaQuery.of(context).size;
    final OnBoardModel _currentFood = _foodlist[_currentIndex];
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: -size.width * 0.6,
          child: BgImage(
            currentIndex: _currentIndex,
            food: _currentFood,
            pageOffset: _currentOffset,
          ),
        ),
        SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                          child:
                          Text("Skip >",style: TextStyle(
                            color: Colors.grey.shade800,
                          fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _currentFood.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        _currentFood.subname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IconButton(
                            icon: Icon(Iconsax.arrow_circle_right),
                            onPressed: () {

                            },
                            iconSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        Center(
          child: SizedBox(
            height: 400,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                double _value = 0.0;
                double vp = 1;
                double scale = max(vp, (_currentOffset - index).abs());

                if (_pageController.position.haveDimensions) {
                  _value = index.toDouble() - (_pageController.page ?? 0);
                  _value = (_value * 0.7).clamp(-1, 1);
                }
                return Transform.rotate(
                    angle: pi * _value,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 100 - scale * 5),
                      child: FittedBox(
                        child: Image.asset(
                          _foodlist[index % _foodlist.length].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BgImage extends StatefulWidget {
  const BgImage(
      {super.key,
        required this.currentIndex,
        required this.food,
        required this.pageOffset});

  final int currentIndex;
  final OnBoardModel food;
  final double pageOffset;

  @override
  State<BgImage> createState() => _BgImageState();
}

class _BgImageState extends State<BgImage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _value = 0.0;
    _value = (widget.pageOffset - widget.currentIndex).abs();
    return Opacity(
      opacity: 0.3,
      child: Transform.rotate(
        angle: pi * _value + pi / 180,
        child: SizedBox(
          width: size.width * 1.65,
          height: size.width * 1.65,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          )
        ),
      ),
    );
  }
}


class OnBoardModel {
  String name;
  String subname;
  String image;
  OnBoardModel({
    required this.name,
    required this.subname,
    required this.image,
  });
}

List<OnBoardModel> foodList = [
  OnBoardModel(
    name: 'Learning in a smartphone',
    subname: "Submit your homework in one click, effortlessly and efficiently.!",
    image: 'assets/images/1.png',
  ),
  OnBoardModel(
    name: 'Communication',
    subname: "Write to teachers to find answers to your questions quickly!",
    image: 'assets/images/2.png',
  ),
  OnBoardModel(
    name: 'Time Conservation',
    subname: "Learning is interesting and convenient when there is enough time for things!",
    image: 'assets/images/3.png',
  ),
];