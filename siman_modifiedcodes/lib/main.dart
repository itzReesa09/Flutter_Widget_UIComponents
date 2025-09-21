import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HingeAnimation(),
    );
  }
}

// Create a stateful widget
class HingeAnimation extends StatefulWidget {
  @override
  _HingeAnimationState createState() => _HingeAnimationState();
}

class _HingeAnimationState extends State<HingeAnimation>
    with SingleTickerProviderStateMixin {
  // Animation setup
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    // Setup the rotation animation (negative value for right-side hinge)
    _rotationAnimation = Tween<double>(begin: 0.0, end: -0.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.bounceInOut,
        ),
      ),
    );

    // Setup the slide animation (move to right instead of down)
    _slideAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    // Setup the opacity animation
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  // The animation widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("GeeksForGeeks"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight, // Align to right side
            child: Transform.translate(
              offset: Offset(_slideAnimation.value, 0), // Move horizontally
              child: RotationTransition(
                turns: _rotationAnimation, // Negative rotation for right hinge
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 200,
                    height: 150,
                    color: Colors.green[100],
                    child: Center(
                      child: Text(
                        'Claresa Siman',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      
      // The button to trigger the animation
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.green[300],
        onPressed: () {
          _controller.forward();
        },
      ),
    );
  }
}