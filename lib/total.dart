import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Total extends StatefulWidget {
  Total(this.currency, this.value, {Key key}) : super(key: key);

  final String currency;
  double value;

  @override
  TotalState createState() {
    return new TotalState();
  }
}

class TotalState extends State<Total> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  double totalValue = 0.0;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = _controller;
  }

  updateState(double _valor) {
    setState(() {
      widget.value = _valor;
      totalValue += widget.value;
      _animation = new Tween<double>(
        begin: _animation.value,
        end: totalValue,
      ).animate(new CurvedAnimation(
        curve: Curves.bounceIn, //bounceIn easeInOutQuint
        parent: _controller,
      ));
      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    String symbol = widget.currency;
    final f = new NumberFormat.currency(decimalDigits: 2, name: symbol, symbol: "");
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Material(
      color: Colors.black,
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget child) {
                return new Text(
                  f.format(double.parse(_animation.value.toStringAsFixed(1))),
                  style: textTheme.display3.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
                );
              },
            ),
            new Text(
              symbol,
              style: textTheme.display1.copyWith(fontStyle: FontStyle.italic, color: Colors.white),
            ),
            new Text(
              widget.value.toString(),
              style: textTheme.display1.copyWith(fontStyle: FontStyle.normal, color: Colors.white),
            )
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
