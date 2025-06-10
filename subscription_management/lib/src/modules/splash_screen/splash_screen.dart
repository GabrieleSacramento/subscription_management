import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:subscription_management/src/routes/router.dart';

@RoutePage(name: 'SplashScreenRoute')
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward().then((_) {
        _navigateToSelectLoginMethodPage();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToSelectLoginMethodPage() {
    context.pushRoute(const SelectLoginMethodRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 228, 237, 1),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 200 * (1 - _animation.value)),
              child: child,
            );
          },
          child: Image.asset('assets/images/subscription_management_logo.png'),
        ),
      ),
    );
  }
}
