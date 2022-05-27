import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  String title;

  String subtitle;

  String time;

  FeedbackCard({
    Key? key,
    this.title = '',
    this.subtitle = '''heloooooo''',
    this.time = "12-01-23 12:23:34",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
