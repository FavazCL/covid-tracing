import 'package:covid_app/src/screens/home/widgets/bottom_navigator.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatelessWidget {
  static const routeName = 'home';
  const HomeUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      bottomSheet: BottomNavigator(),
    );
  }
}
