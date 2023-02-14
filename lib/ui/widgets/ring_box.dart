import 'package:flutter/material.dart';
import 'package:ring_size_calculator/main.dart';
import 'package:ring_size_calculator/models/ring_size.dart';
import 'package:ring_size_calculator/util/util.dart';

class RingBox extends StatefulWidget {
  const RingBox({super.key});

  @override
  State<RingBox> createState() => _RingBoxState();
}

class _RingBoxState extends State<RingBox> {
  final double _boxHeight = 180;

  final double _boxWidth = 180;

  late final ValueNotifier<double> _radiusNotifier;
  late final ValueNotifier<bool> _loadingData;
  RingSize? ringSize;

  @override
  void initState() {
    super.initState();
    _loadingData = ValueNotifier(false);
    _radiusNotifier = ValueNotifier(20.0);
  }

  @override
  void didChangeDependencies() {
    final size = _getTheRightSize(2 * _radiusNotifier.value / MediaQuery.of(context).devicePixelRatio);
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(size.toString()));
    super.didChangeDependencies();
  }

  void _fetchData(String size) {
    _loadingData.value = true;
    ringSizesCollectionRef.doc(size).get().then((value) {
      ringSize = value.data();
      _loadingData.value = false;
    });
  }

  @override
  void dispose() {
    _radiusNotifier.dispose();
    _loadingData.dispose();
    super.dispose();
  }

  int _getTheRightSize(double size) {
    int x = 6;
    if (size >= 14.2 && size < 14.6) {
      x = 6;
    } else if (size >= 14.6 && size < 14.9) {
      x = 7;
    } else if (size >= 14.9 && size <= 15.2) {
      x = 8;
    } else if (size > 15.2 && size <= 15.6) {
      x = 9;
    } else if (size > 15.6 && size <= 15.8) {
      x = 10;
    } else if (size > 15.8 && size <= 16.2) {
      x = 11;
    } else if (size > 16.2 && size <= 16.4) {
      x = 12;
    } else if (size > 16.4 && size <= 16.75) {
      x = 13;
    } else if (size > 16.75 && size <= 16.95) {
      x = 14;
    } else if (size > 16.95 && size <= 17.45) {
      x = 15;
    } else if (size > 17.45 && size <= 17.65) {
      x = 16;
    } else if (size > 17.65 && size <= 18.05) {
      x = 17;
    } else if (size > 18.05 && size <= 18.25) {
      x = 18;
    } else if (size > 18.25 && size <= 18.75) {
      x = 19;
    } else if (size > 18.75 && size <= 18.95) {
      x = 20;
    } else if (size > 18.95 && size <= 19.35) {
      x = 21;
    } else if (size > 19.35 && size <= 19.65) {
      x = 22;
    } else if (size > 19.65 && size <= 19.95) {
      x = 23;
    } else if (size > 19.95 && size <= 20.25) {
      x = 24;
    } else if (size > 20.25 && size <= 20.65) {
      x = 25;
    } else if (size > 20.65 && size <= 21.0) {
      x = 26;
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Put the ring on the circle to determine its size. Use the slider below to choose the right size of the ring.",
            maxLines: 10,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Stack(
          children: [
            CustomPaint(
              painter: GraphPaper(),
              size: Size(_boxWidth, _boxHeight),
            ),
            Container(
              height: _boxHeight,
              width: _boxWidth,
              margin: const EdgeInsets.all(10),
              child: CustomPaint(
                painter: CirclePainter(_radiusNotifier),
                foregroundPainter: DiameterPainter(_radiusNotifier),
              ),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _radiusNotifier,
          builder: (context, radius, _) {
            return Slider(
              value: radius,
              min: 19,
              max: 30.0,
              onChangeEnd: (value) {
                final size = 2 * value / MediaQuery.of(context).devicePixelRatio;
                _fetchData(_getTheRightSize(size).toString());
              },
              onChanged: (value) => _radiusNotifier.value = value,
            );
          },
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          padding: const EdgeInsets.all(10),
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ring Data",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: _loadingData,
                builder: (context, value, child) => value
                    ? Column(
                        children: const [
                          Center(child: CircularProgressIndicator()),
                          SizedBox(height: 5),
                          Text("Getting the right ring size for you...")
                        ],
                      )
                    : Text(
                        "Size: ${ringSize?.size}\nDiameter: ${ringSize?.sizeInMM} mm",
                        style: Theme.of(context).textTheme.headline5,
                      ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
