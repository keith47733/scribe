import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/scribe.dart';
import '../../variables/constants.dart';

class ScribeAvatar extends StatefulWidget {
  const ScribeAvatar({super.key});

  @override
  State<ScribeAvatar> createState() => _ScribeAvatarState();
}

class _ScribeAvatarState extends State<ScribeAvatar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RADIUS / 2),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(SPACING / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatar(),
              _scribeName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(APP_BAR_HEIGHT * 0.50),
        child: Image.network(
          Provider.of<Scribe>(context, listen: false).avatarUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _scribeName() {
    return Text(
      Provider.of<Scribe>(context, listen: false).name!,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }
}
