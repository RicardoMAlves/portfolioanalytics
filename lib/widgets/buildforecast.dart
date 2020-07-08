import 'package:flutter/material.dart';

class BuildForecast extends StatefulWidget {
  @override
  _BuildForecastState createState() => _BuildForecastState();
}

class _BuildForecastState extends State<BuildForecast> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  double _value = 45;

  @override
  Widget build(BuildContext context) {

    final _textForecasting = Text(
      "Cash Forecasting",
      style: TextStyle(
          color: Colors.red,
          fontSize: 12.0,
          fontWeight: FontWeight.bold
      ),
    );

    final _slidersForecast = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Colors.redAccent,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        )
      ),
      child: Slider(
        value: _value,
        min: 0,
        max: 100,
        divisions: 10,
        label: _value.toString(),
        onChanged: (val) {
          setState(() {
            _value = val;
          });
        },
      ),
    );

    return Center(
      child: Column(
        children: [
          Card(
            color: Colors.grey[100],
            child: Container(
              width: 600.0,
              height: 75.0,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textForecasting,
                  _slidersForecast
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
