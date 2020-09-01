import 'package:covid_app/src/screens/home/widgets/navigator_item.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      height: responsive.dp(8),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: NavigatorItem(
                title: 'Contactos',
                path: 'assets/screens/home/notification.svg',
                onPressed: () {
                  print('1');
                },
              )),
          Flexible(
            flex: 1,
            child: NavigatorItem(
              title: 'Reportar',
              path: 'assets/screens/home/send.svg',
              onPressed: () {
                print('2');
              },
            ),
          ),
          Flexible(
              flex: 1,
              child: NavigatorItem(
                title: 'Ayuda',
                path: 'assets/screens/home/faq.svg',
                onPressed: () {
                  print('3');
                },
              )),
        ],
      ),
    );
  }
}
