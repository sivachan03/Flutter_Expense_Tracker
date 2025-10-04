import 'package:expense_trackerr/Pages/home.dart';
// import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import 'package:flutter/material.dart';

class onBoardingSccreen extends StatefulWidget {
  const onBoardingSccreen({super.key});

  @override
  State<onBoardingSccreen> createState() => _onBoardingSccreenState();
}

class _onBoardingSccreenState extends State<onBoardingSccreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/1.jpg",
      "title": "Welcome to MyApp",
      "desc": "Your one-stop solution for tracking expenses.",
    },
    {
      "image": "assets/images/2.jpg",
      "title": "Easy to Use",
      "desc": "Simple interface and smooth experience.",
    },
    {
      "image": "assets/images/3.jpg",
      "title": "Get Started",
      "desc": "Let’s dive in and explore the app together!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              HomeScreen();
            },
            child: Text("Skip"),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _pages[index]["image"]!,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    _pages[index]["title"]!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _pages[index]["desc"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              );
            },
          ),
          Stack(
            children: [
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          // Last page → Navigate to home
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? "Get Started"
                            : "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
