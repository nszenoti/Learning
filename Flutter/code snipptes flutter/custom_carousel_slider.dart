// custom_carousel_slider.dart

class CustomCarousel extends StatefulWidget {
  final List<Widget> items;

  const CustomCarousel({super.key, required this.items});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _controller = PageController();

  double _childHeight = 0;
  double _childWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSize(0));
  }

  void _updateSize(int index) {
    if (index >= 0 && index < widget.items.length) {
      final renderBox = (context.findRenderObject() as RenderBox?)?.size;
      if (renderBox != null) {
        setState(() {
          _childHeight = renderBox.height;
          _childWidth = renderBox.width;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _childWidth,
      height: _childHeight,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.items.length,
        onPageChanged: _updateSize,
        itemBuilder: (context, index) {
          return MeasureSize(
            onChange: (size) {
              setState(() {
                _childHeight = size.height;
                _childWidth = size.width;
              });
            },
            child: widget.items[index],
          );
        },
      ),
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({super.key, required this.child, required this.onChange});

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = (context.findRenderObject() as RenderBox).size;
      widget.onChange(size);
    });

    return widget.child;
  }
}
