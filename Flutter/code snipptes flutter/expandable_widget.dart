// SizeTransition
SizeTransition(
  sizeFactor: _controller,
  axisAlignment: -1.0, // top-to-bottom (default)
  child: Text("Hello World"),
);

// Align + heightFactor
ClipRect(
  child: Align(
    alignment: Alignment.bottomCenter,
    heightFactor: _controller.value,
    child: Text("Hello World"),
  ),
);
