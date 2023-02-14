import 'package:flutter/material.dart';
import 'package:ring_size_calculator/main.dart';
import 'package:ring_size_calculator/models/ring_size.dart';
import 'package:ring_size_calculator/ui/widgets/widgets.dart';
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
    final size = Common.getTheRightSize(2 * _radiusNotifier.value / MediaQuery.of(context).devicePixelRatio);
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
          alignment: Alignment.center,
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
                _fetchData(Common.getTheRightSize(size).toString());
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
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: _loadingData,
                builder: (context, value, child) => value
                    ? Column(
                        children: const [Center(child: CircularProgressIndicator()), SizedBox(height: 5), Text("Getting the right ring size for you...")],
                      )
                    : Text(
                        "Size: ${ringSize?.size}\nDiameter: ${ringSize?.sizeInMM} mm",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          "Made with ❤️ by Ankit Bhankharia",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
