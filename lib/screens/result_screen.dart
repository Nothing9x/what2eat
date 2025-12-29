import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/food_item.dart';
import '../models/food_delivery_platform.dart';

class ResultScreen extends StatefulWidget {
  final FoodItem foodItem;

  const ResultScreen({
    super.key,
    required this.foodItem,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _confettiController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final List<ConfettiParticle> _confettiParticles = [];
  List<FoodDeliveryPlatform> _platforms = [];

  @override
  void initState() {
    super.initState();

    // Detect country and set platforms
    _detectCountryAndSetPlatforms();

    // Main entrance animation - faster
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Confetti animation - shorter for better effect
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Generate confetti particles
    _generateConfetti();

    // Start animations
    _animationController.forward();
    _confettiController.forward();
  }

  void _detectCountryAndSetPlatforms() {
    // Try to get country from locale
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    String countryCode = locale.countryCode ?? 'US';

    // Get platforms for the detected country
    _platforms = FoodDeliveryConfig.getPlatformsByCountry(countryCode);

    // If no platforms found, use default
    if (_platforms.isEmpty) {
      _platforms = FoodDeliveryConfig.getPlatformsByCountry('US');
    }
  }

  void _generateConfetti() {
    final random = Random();
    for (int i = 0; i < 60; i++) {
      _confettiParticles.add(
        ConfettiParticle(
          x: random.nextDouble(),
          y: -0.1 - random.nextDouble() * 0.2,
          color: _getRandomColor(random),
          size: 6 + random.nextDouble() * 8,
          rotation: random.nextDouble() * 2 * pi,
          rotationSpeed: (random.nextDouble() - 0.5) * 3,
          velocity: 0.8 + random.nextDouble() * 0.4,
          drift: (random.nextDouble() - 0.5) * 0.4,
        ),
      );
    }
  }

  Color _getRandomColor(Random random) {
    final colors = [
      const Color(0xFFEC9213),
      const Color(0xFFe94560),
      const Color(0xFF10b981),
      const Color(0xFFf59e0b),
      const Color(0xFF8b5cf6),
      const Color(0xFF06b6d4),
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  // Open delivery platform app with search query
  Future<void> _openPlatform(FoodDeliveryPlatform platform) async {
    final foodName = widget.foodItem.name;
    final appUrl = platform.getAppUri(foodName);
    final webUrl = Uri.parse(platform.getSearchUrl(foodName));

    try {
      if (await canLaunchUrl(appUrl)) {
        await launchUrl(appUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể mở ${platform.name}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFF8F7F6);
    final surfaceColor = isDark ? const Color(0xFF3a2d1e) : Colors.white;
    final primaryColor = const Color(0xFFEC9213);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Confetti animation
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: ConfettiPainter(
                  particles: _confettiParticles,
                  progress: _confettiController.value,
                ),
              );
            },
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.close, size: 24),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Kết quả',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Congratulations text
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'CHÚC MỪNG! BẠN SẼ ĂN:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Food image with sparkle effect
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Animated sparkles - quick burst
                              ...List.generate(8, (index) {
                                final angle = (index * pi / 4);
                                return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    final progress = _animationController.value;
                                    // Quick burst out and fade
                                    final distance = progress < 0.6
                                        ? (progress / 0.6) * 60
                                        : 60 - ((progress - 0.6) / 0.4) * 60;
                                    final opacity = progress < 0.3
                                        ? (progress / 0.3)
                                        : progress < 0.6
                                            ? 1.0
                                            : 1 - ((progress - 0.6) / 0.4);

                                    return Transform.translate(
                                      offset: Offset(
                                        cos(angle) * distance,
                                        sin(angle) * distance,
                                      ),
                                      child: Opacity(
                                        opacity: opacity.clamp(0.0, 1.0),
                                        child: Icon(
                                          Icons.star,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                              // Glow effect
                              Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 50,
                                      spreadRadius: 15,
                                    ),
                                  ],
                                ),
                              ),
                              // Image container
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: surfaceColor,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.foodItem.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: Text(
                                          widget.foodItem.icon,
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Food name and description
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                widget.foodItem.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.foodItem.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.7),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // Bottom buttons
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(0.9),
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.black.withOpacity(0.05),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dynamic delivery platform buttons
                      ...List.generate(
                        _platforms.length > 2 ? 2 : _platforms.length,
                        (index) {
                          final platform = _platforms[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: index < 1 ? 12 : 0),
                            child: ElevatedButton(
                              onPressed: () => _openPlatform(platform),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: platform.color,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 8,
                                shadowColor: platform.color.withOpacity(0.3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(platform.icon, size: 24),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      'Đặt ngay trên ${platform.name}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // Back button
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          foregroundColor: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.refresh, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Quay lại vòng quay',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  final double x;
  final double y;
  final Color color;
  final double size;
  final double rotation;
  final double rotationSpeed;
  final double velocity;
  final double drift;

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.velocity,
    required this.drift,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // Natural gravity-like fall with acceleration
      final currentY = particle.y + (progress * progress * particle.velocity * 0.8);
      // Gentle side-to-side drift
      final currentX = particle.x + (sin(progress * pi * 3) * particle.drift * 0.15);
      // Slower, more natural rotation
      final currentRotation = particle.rotation + (progress * particle.rotationSpeed * 0.7);

      if (currentY > 1.3) continue; // Don't draw particles that have fallen off screen

      // Fade out more gradually
      final opacity = progress < 0.8 ? 1.0 : 1.0 - ((progress - 0.8) / 0.2);

      final paint = Paint()
        ..color = particle.color.withOpacity(opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(
        currentX * size.width,
        currentY * size.height,
      );
      canvas.rotate(currentRotation);

      // Draw confetti as rectangles
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: particle.size,
        height: particle.size * 1.5,
      );
      canvas.drawRect(rect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}
