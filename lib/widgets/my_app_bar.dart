import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? leading;
  const MyAppBar({super.key, required this.title, this.trailing, this.leading});

  @override
  Widget build(BuildContext context) {
    int firstFlexValue = 1;
    int secondFlexValue = 1;
    if (leading != null && trailing == null) {
      firstFlexValue = 2;
      secondFlexValue = 3;
    } else if (leading == null && trailing != null) {
      firstFlexValue = 3;
      secondFlexValue = 2;
    }
    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ?? Container(),
            Spacer(
              flex: firstFlexValue,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white),
            ),
            Spacer(
              flex: secondFlexValue,
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
