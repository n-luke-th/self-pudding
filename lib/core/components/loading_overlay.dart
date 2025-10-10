import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:pudding/core/components/page_view_wrappers.dart';
import 'package:pudding/core/utils/svg_color_mapper.dart';

class LoadingOverlay {
  const LoadingOverlay._();

  static void showDefaultLoading({String? msg}) async {
    const String lt = 'LOADING';
    await SmartDialog.showLoading(
      msg: msg ?? lt,
      animationType: SmartAnimationType.scale,
      useAnimation: true,
      maskColor: Color.alphaBlend(Colors.cyan, Colors.indigoAccent),
      alignment: Alignment.center,
      builder: (_) => CustomLoadingIndicator(type: 2, msg: msg ?? lt),
    );
  }

  static void dismissLoading({bool force = false}) async {
    await SmartDialog.dismiss(status: SmartStatus.loading, force: force);
  }
}

// TODO: customize this
class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({
    super.key,
    this.type = 2,
    this.msg = "Loading",
  });

  final int type;
  final String msg;

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // smile
        Visibility(visible: widget.type == 1, child: _buildLoadingOne()),

        // icon
        Visibility(visible: widget.type == 2, child: _buildLoadingTwo()),

        // normal
        Visibility(visible: widget.type == 3, child: _buildLoadingThree()),
      ],
    );
  }

  Widget _buildLoadingOne() {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          alignment: Alignment.center,
          turns: _controller,
          child: Image.network(
            'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101174606.png',
            height: 110,
            width: 110,
          ),
        ),
        Image.network(
          'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101181404.png',
          height: 60,
          width: 60,
        ),
      ],
    );
  }

  Widget _buildLoadingTwo() {
    final String svgString =
        '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><radialGradient id="a12" cx=".66" fx=".66" cy=".3125" fy=".3125" gradientTransform="scale(1.5)"><stop offset="0" stop-color="#FF156D"></stop><stop offset=".3" stop-color="#FF156D" stop-opacity=".9"></stop><stop offset=".6" stop-color="#FF156D" stop-opacity=".6"></stop><stop offset=".8" stop-color="#FF156D" stop-opacity=".3"></stop><stop offset="1" stop-color="#FF156D" stop-opacity="0"></stop></radialGradient><circle transform-origin="center" fill="none" stroke="url(#a12)" stroke-width="10" stroke-linecap="round" stroke-dasharray="200 1000" stroke-dashoffset="0" cx="100" cy="100" r="70"><animateTransform type="rotate" attributeName="transform" calcMode="spline" dur="2" values="360;0" keyTimes="0;1" keySplines="0 0 1 1" repeatCount="indefinite"></animateTransform></circle><circle transform-origin="center" fill="none" opacity=".2" stroke="#FF156D" stroke-width="10" stroke-linecap="round" cx="100" cy="100" r="70"></circle></svg>''';
    final Widget svgIcon = SvgPicture.string(
      svgString,
      colorMapper: const SvgColorMapper(),
      height: 140,
      width: 100,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(child: FlutterLogo(size: 65)),
        RotationTransition(
          alignment: Alignment.center,
          turns: _controller,
          child: svgIcon,

          //  Image.network(
          //   'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101173708.png',
          //   height: 100,
          //   width: 80,
          // ),
        ),
        Container(margin: EdgeInsets.only(top: 165), child: Text(widget.msg)),
      ],
    );
  }

  Widget _buildLoadingThree() {
    return Center(
      child: Container(
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              alignment: Alignment.center,
              turns: _controller,
              child: Image.network(
                'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101163010.png',
                height: 50,
                width: 50,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('loading...'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
