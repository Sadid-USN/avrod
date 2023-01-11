import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String subtitle;
  final double margin;
  final void Function()? onTap;
  const GroupTile({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
    required this.onTap,
    this.margin = 0.0,
    this.subtitle = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        margin: EdgeInsets.all(margin > 0 ? margin : 0),
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
            color: margin > 0
                ? audiplayerColor.withOpacity(0.2)
                : audiplayerColor.withOpacity(0.0),
            borderRadius: BorderRadius.circular(28.0)),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: audiplayerColor.withOpacity(0.8),
            radius: 30,
            child: Text(
              groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          title: Text(
            groupName,
            style: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            margin > 0 ? "$subtitle $userName" : 'Чат дар гурӯҳи $userName',
            textAlign: TextAlign.start,
            style: margin > 0
                ? const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  )
                : const TextStyle(
                    color: Colors.black45,
                  ),
          ),
        ),
      ),
    );
  }
}
