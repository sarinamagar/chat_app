import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:forum/feature/groupchat/widgets/group_info_widget.dart';

class GroupInfoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> members;
  const GroupInfoScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return GroupInfoWidget(
      members: members,
    );
  }
}
