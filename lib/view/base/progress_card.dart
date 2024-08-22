import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/icons.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (con) {
      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // name
                Text(con.appUser!.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
                const Spacer(),
                // points
                Text(
                    con.appUser!.loyaltyPoints == null
                        ? ''
                        : '${con.appUser!.loyaltyPoints}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
                const SizedBox(width: 5),
                // points icon
                const Icon(
                  FFIcons.star,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('${con.appUser!.loyaltyAmount} $CURRENCY',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white))
          ],
        ),
      );
    });
  }
}
