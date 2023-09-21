import 'dart:async';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/settings.dart';

class CallPage extends StatefulWidget {
  final String? channelName;
  final ClientRole? clientRoleType;
  const CallPage({super.key, this.channelName, this.clientRoleType});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _user = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _user.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
            "APP_ID is Missing,Please provide your APP_ID in Setting.dart");
        _infoStrings.add("agora Engine is not starting");
      });
      return;
    }
    //! _init AgoraRTCEngine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.clientRoleType!);
    //! _addAgoraEvenetHandlers
    _addAgoraEventHandler();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(token, widget.channelName!, null, 0);
  }

  void _addAgoraEventHandler() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (err) {
        setState(() {
          final info = 'Error: $err';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = "Join Channel : $channel, uid: $uid";
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        _infoStrings.add("Leave Channel");
        _user.clear();
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = "User Joined $uid";
          _infoStrings.add(info);
          _user.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          final info = "User Offline: $uid";
          _infoStrings.add(info);
          _user.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'Firs Remote Vide: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
    ));
  }

  Widget _toolBar() {
    if (widget.clientRoleType == ClientRole.Audience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            fillColor: Colors.redAccent,
            elevation: 2,
            padding: const EdgeInsets.all(15),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
        visible: viewPanel,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: ListView.builder(
                reverse: true,
                itemCount: _infoStrings.length,
                itemBuilder: (context, index) {
                  if (_infoStrings.isEmpty) {
                    return const Text("NULL");
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            _infoStrings[index],
                            style: GoogleFonts.abel(color: Colors.blueGrey),
                          ),
                        ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.clientRoleType == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (var uid in _user) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: widget.channelName!,
      ));
    }
    final views = list;
    return Column(
      children:
          List.generate(views.length, (index) => Expanded(child: views[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CALL"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  viewPanel = !viewPanel;
                });
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [_viewRows(), _panel(), _toolBar()],
        ),
      ),
    );
  }
}
