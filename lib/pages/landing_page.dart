import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hfs/bloc/channel_cubit/channel_cubit.dart';
import 'package:hfs/bloc/user_cubit/stream_cubit.dart';
import 'package:hfs/pages/home_page.dart';
import 'package:hfs/pages/video_player_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController urlEditingController;
  TextEditingController nameEditingController;
  GlobalKey<FormState> formKey;

  String get nickname => nameEditingController.value.text;

  String get url => urlEditingController.value.text;

  @override
  void initState() {
    super.initState();
    urlEditingController = TextEditingController();
    nameEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    urlEditingController.dispose();
    nameEditingController.dispose();
  }

  Future<void> onContinueToHomePressed() async {
    if (formKey.currentState.validate()) {
      await context.read<UserCubit>().configureUser(name: nickname);
      Navigator.of(context).pushReplacement(HomePage.route());
    }
    return;
  }

  Future<void> onCustomUrlGoPressed() async {
    if (formKey.currentState.validate()) {
      await context.read<UserCubit>().configureUser(name: nickname);
      context.read<ChannelCubit>().configureChannel(url);
      Navigator.of(context).pushReplacement(
        PlayerPage.route(url),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFf5c3ff),
                      Color(0xFF0047ff),
                    ],
                  ).createShader(rect);
                },
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
              const SizedBox(height: 64.0),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 48.0,
                ),
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Center(
                    child: TextFormField(
                      controller: urlEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Custom HLS/RTP URL",
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 48.0,
                  vertical: 12.0,
                ),
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Center(
                    child: TextFormField(
                      validator: (val) => (val != null && val.isNotEmpty)
                          ? null
                          : "Please enter a name",
                      controller: nameEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Nickname",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: urlEditingController,
                builder: (context, controller, _) {
                  if (controller.text.isEmpty) {
                    return Align(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color(0xff4d7bfe).withOpacity(0.2),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xff4d7bfe),
                          ),
                        ),
                        onPressed: onContinueToHomePressed,
                        child: Text("Continue to home"),
                      ),
                    );
                  } else {
                    return Align(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                          shadowColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color(0xff4d7bfe).withOpacity(0.2),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xff4d7bfe),
                          ),
                        ),
                        onPressed: onCustomUrlGoPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
