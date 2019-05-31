import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot_ui/widgets/gradientIcon.dart';


class DeviceCard extends StatelessWidget {

  final String value;
  final String unit;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData iconData;

  const DeviceCard({Key key, this.value, this.unit, this.title, this.subtitle, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        color: Colors.black.withOpacity(0.05),
        child: Container(
          width: 200.0,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0),),
                      SizedBox(width: 3.0,),
                      Text(unit, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),),
                    ],
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                  ),
                  CircleText(onTap: (){}, iconData: iconData,)
                ],
              ),
              Center(
                child: GradientIcon(
                  icon: Icon(Icons.blur_on, size: 150.0,),
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[
                      Colors.greenAccent[200],
                      Colors.blueAccent[200]
                    ],
                    tileMode: TileMode.mirror,
                  ),
                )
              ),
              Hero(
                child: Material(
                  child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                  color: Colors.transparent,
                ),
                tag: title,
              ),
              Text(subtitle, style: TextStyle(color: Colors.white70, /* fontWeight: FontWeight.bold*/),)
            ],
          ),
        )
      ),
    );
    return Material(
        child: w,
        color: Colors.transparent,
      );
  }
}

class CircleText extends StatelessWidget {

  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleText({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 50.0;
    return Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.lightBlueAccent),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.lightBlueAccent,
        ),
    );
  }
}