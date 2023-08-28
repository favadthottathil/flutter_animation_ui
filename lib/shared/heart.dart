import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<Color> animateColor;

  Animation<double> sizeAnimate;

  Animation curve;

  bool fav = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    curve = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);

    animateColor = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(
      curve,
    );

    sizeAnimate = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 30, end: 50),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 50, end: 30),
          weight: 50,
        ),
      ],
    ).animate(curve);

    

    // controller.addListener(() {});

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          fav = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          fav = false;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: animateColor.value,
            size: sizeAnimate.value,
          ),
          onPressed: () {
            fav ? controller.reverse() : controller.forward();
          },
        );
      },
    );
  }
}
