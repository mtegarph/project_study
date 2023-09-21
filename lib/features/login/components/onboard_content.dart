import 'package:flutter/material.dart';
import 'package:project_study/features/home/views/home_screen.dart';
import 'package:project_study/features/login/components/landed_content.dart';
import 'package:project_study/features/login/components/sign_up_form.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late PageController _onboardPageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onboardPageController = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _onboardPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(_onboardPageController.page);
    final double progress = _onboardPageController.hasClients
        ? _onboardPageController.page ?? 0
        : 0;
    return SizedBox(
      height: 400 + progress * 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _onboardPageController,
                  children: const [
                    LandingContent(),
                    SignUpForm(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            height: 56,
            bottom: 32 + progress * 140,
            right: 16,
            child: GestureDetector(
              onTap: () {
                if (_onboardPageController.page == 0) {
                  _onboardPageController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.8],
                    colors: [
                      Color.fromARGB(255, 239, 104, 80),
                      Color.fromARGB(255, 139, 33, 146)
                    ],
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 92 + progress * 32,
                        child: Stack(
                          children: [
                            Opacity(
                                opacity: 1 - progress,
                                child: const Text("Get Started")),
                            Opacity(
                                opacity: progress,
                                child: const Text(
                                  "Crete Account",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                )),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
