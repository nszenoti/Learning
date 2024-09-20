import 'package:flutter/material.dart';

class SlidingWidget extends StatefulWidget {
  @override
  _SlidingWidgetState createState() => _SlidingWidgetState();
}

class _SlidingWidgetState extends State<SlidingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = true;
  bool _isSlidingOut = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && _isSlidingOut) {
          // After sliding out, replace with SizedBox.shrink
          setState(() {
            _isVisible = false;
            _isSlidingOut = false;
          });
        }
      });
  }

  void _toggleVisibility() {
    setState(() {
      if (_isVisible) {
        // Start sliding out
        _isSlidingOut = true;
        _controller.forward();
      } else {
        // Make it visible again and slide in
        _isVisible = true;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Widget Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_vert),
            onPressed: _toggleVisibility,
          ),
        ],
      ),
      body: Center(
        child: _isVisible
            ? SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -1),
                  end: Offset(0, 0),
                ).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: Container(
                  height: 200,
                  width: 300,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Slide In/Out Widget',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(), // Widget is replaced with SizedBox.shrink after sliding out
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: SlidingWidget(),
  ));
}
