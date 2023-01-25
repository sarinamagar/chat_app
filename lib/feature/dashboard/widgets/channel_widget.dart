import 'package:flutter/material.dart';

class ChannelWidget extends StatefulWidget {
  const ChannelWidget({super.key});

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Channel"),
      ),
    );
  }
}
