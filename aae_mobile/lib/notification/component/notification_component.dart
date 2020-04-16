import 'package:aae/common/widgets/cards/aae_card.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/menu/drawer/aae_drawer_component.dart';
import 'package:aae/notification/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';

class NotificationPageComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      itemBuilder: (context, index) {
        return AaeCard(
          timeStamp: '3/6/2020',
          title: 'TODO (rpaglinawan): update this to spec.',
          body: 'Body of notification',
          primaryActionTitle: 'See more',
          onPrimaryAction: (context) {},
          secondaryActionTitle: 'Remove',
          onSecondaryAction: (context) {},
        );
      },
    );
  }
}
