import 'package:flutter/material.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/style.dart';

class ServicesWidget extends StatelessWidget {
  final String text;
  const ServicesWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20).copyWith(bottom: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // image
          Container(
            width: getPixels(context, 100),
            height: getPixels(context, 100),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(Images.logoWhite, height: 50),
          ),
          const SizedBox(width: 10),
          // title
          Expanded(
            child: Text(text.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: fontSizeMedium(context),
                    fontWeight: fontWeightBold)),
          ),
        ],
      ),
    );
  }
}
