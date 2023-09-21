import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'call.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole? _roleType = ClientRole.Broadcaster;
  CallFunction callFunction = CallFunction();
  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await callFunction.handleCameraAndMic(Permission.camera);
      await callFunction.handleCameraAndMic(Permission.microphone);
      // ignore: use_build_context_synchronously
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallPage(
              channelName: _channelController.text,
              clientRoleType: _roleType,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Agora"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                    errorText: _validateError ? 'Channel Is mandatory' : null,
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    hintText: 'Channel Name'),
              ),
              RadioListTile(
                title: const Text("BroadCaster"),
                value: ClientRole.Broadcaster,
                groupValue: _roleType,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _roleType = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Audience"),
                value: ClientRole.Audience,
                groupValue: _roleType,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _roleType = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: onJoin,
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 40))),
                child: const Text("Join"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallFunction {
  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
