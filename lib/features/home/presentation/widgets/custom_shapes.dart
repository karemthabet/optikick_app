import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/utils/colors.dart';

// Custom Painter for the Circular Chart in the Overview Section
class CircularChartPainter extends CustomPainter {
  final double optimal;
  final double atRisk;
  final double underperforming;
  final double recovering;

  CircularChartPainter({
    required this.optimal,
    required this.atRisk,
    required this.underperforming,
    required this.recovering,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 20.0;
    final total = optimal + atRisk + underperforming + recovering;

    // Paint for the background circle (unfilled portion)
    final backgroundPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Paint for each segment
    final optimalPaint = Paint()
      ..color = const Color(0xFF4A90E2) // Blue for Optimal
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final atRiskPaint = Paint()
      ..color = const Color(0xFF2E2E54) // Dark blue for At Risk
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final underperformingPaint = Paint()
      ..color = const Color(0xFF6B5B95) // Purple for Underperforming
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final recoveringPaint = Paint()
      ..color = const Color(0xFF88B04B) // Green for Recovering
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw the background circle
    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Calculate angles for each segment
    double startAngle = -90 * (3.14159 / 180); // Start at the top
    if (total > 0) {
      // Draw Optimal segment
      final optimalSweep = (optimal / total) * 360 * (3.14159 / 180);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        optimalSweep,
        false,
        optimalPaint,
      );
      startAngle += optimalSweep;

      // Draw At Risk segment
      final atRiskSweep = (atRisk / total) * 360 * (3.14159 / 180);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        atRiskSweep,
        false,
        atRiskPaint,
      );
      startAngle += atRiskSweep;

      // Draw Underperforming segment
      final underperformingSweep =
          (underperforming / total) * 360 * (3.14159 / 180);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        underperformingSweep,
        false,
        underperformingPaint,
      );
      startAngle += underperformingSweep;

      // Draw Recovering segment
      final recoveringSweep = (recovering / total) * 360 * (3.14159 / 180);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        recoveringSweep,
        false,
        recoveringPaint,
      );
    }

    // Draw the person icon in the center
    final iconPaint = Paint()..color = Colors.white;
    final iconPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius * 0.3)) // Head
      ..moveTo(center.dx - radius * 0.2, center.dy + radius * 0.3)
      ..lineTo(center.dx, center.dy + radius * 0.6) // Body
      ..lineTo(center.dx + radius * 0.2, center.dy + radius * 0.3)
      ..moveTo(center.dx - radius * 0.4, center.dy + radius * 0.4)
      ..lineTo(center.dx, center.dy + radius * 0.3) // Left arm
      ..lineTo(center.dx + radius * 0.4, center.dy + radius * 0.4)
      ..moveTo(center.dx - radius * 0.2, center.dy + radius * 0.6)
      ..lineTo(center.dx, center.dy + radius * 0.9) // Left leg
      ..lineTo(center.dx + radius * 0.2, center.dy + radius * 0.6);
    canvas.drawPath(iconPath, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for the Card Background with Layered Border
class CardBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const radius = Radius.circular(16);

    // Background gradient for the card
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A5C54), // Lighter teal
          Color(0xFF1A3C34), // Dark teal
        ],
      ).createShader(rect);

    // Draw the card background
    final backgroundPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, radius));
    canvas.drawPath(backgroundPath, gradientPaint);

    // Draw layered border with noise-like effect
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (int i = 0; i < 3; i++) {
      borderPaint.color = Colors.teal.withValues(alpha: 1.0 - (i * 0.3));
      final offset = i * 2.0;
      final borderPath = Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              offset,
              offset,
              size.width - (2 * offset),
              size.height - (2 * offset),
            ),
            radius,
          ),
        );
      canvas.drawPath(borderPath, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// HomeScreenBody Widget with Custom Paint Widgets
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A3C34), // Dark teal at the top
            Color(0xFF2A5C54), // Lighter teal in the middle
            Color(0xFFFFD54F), // Yellowish glow at the bottom
          ],
          stops: [0.0, 0.7, 1.0],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              Text(
                'OVERVIEW',
                style: TextStyle(
                  color: ColorsManager.realWhiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular Chart
                  SizedBox(
                    width: 150.w,
                    height: 150.w,
                    child: CustomPaint(
                      painter: CircularChartPainter(
                        optimal: 48,
                        atRisk: 24,
                        underperforming: 16,
                        recovering: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Metrics List
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMetricRow(
                            'Optimal', '48% (12)', const Color(0xFF4A90E2)),
                        SizedBox(height: 8.h),
                        _buildMetricRow(
                            'At Risk', '24% (6)', const Color(0xFF2E2E54)),
                        SizedBox(height: 8.h),
                        _buildMetricRow('Underperforming', '16% (4)',
                            const Color(0xFF6B5B95)),
                        SizedBox(height: 8.h),
                        _buildMetricRow(
                            'Recovering', '12% (3)', const Color(0xFF88B04B)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Cards Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCard(
                    image: 'assets/images/handwashing.png', // Placeholder path
                    title: 'Handwashing Can Protect Your Health',
                    subtitle: 'Why it matters and tips for how to do it well.',
                  ),
                  _buildCard(
                    image:
                        'assets/images/mental_health.png', // Placeholder path
                    title: 'Common Concerns About Mental Health',
                    subtitle:
                        'Learn about common mental health conditions and what to pay attention to.',
                  ),
                  _buildCard(
                    image: 'assets/images/vitals.png', // Placeholder path
                    title: 'Understanding Your Vitals',
                    subtitle:
                        'Certain metrics can give you a sense of how the body is doing.',
                  ),
                  _buildCard(
                    image: 'assets/images/sleep.png', // Placeholder path
                    title: 'Why Sleep Is So Important',
                    subtitle: 'Learn about how sleep helps the body.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '$label  $value',
          style: TextStyle(
            color: ColorsManager.realWhiteColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
      {required String image,
      required String title,
      required String subtitle}) {
    return CustomPaint(
      painter: CardBackgroundPainter(),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the image
            Container(
              height: 80.h,
              color: Colors.grey
                  .withValues(alpha: 0.2), // Placeholder for the image
              child: Center(
                child: Text(
                  'Image: $image',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: ColorsManager.realWhiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                color: ColorsManager.realWhiteColor,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
