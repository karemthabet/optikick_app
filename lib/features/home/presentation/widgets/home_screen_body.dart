import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/features/home/data/info_card_model.dart';
import 'package:optikick/features/home/presentation/widgets/overviewsection.dart';
import 'package:optikick/features/home/presentation/widgets/info_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 4, 21, 10),
            Color.fromARGB(255, 40, 59, 52),
            Color(0xff5D6E68),
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
              OverviewSection(),
              // Shadow effect container for the grid
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 24.w,
                  mainAxisSpacing: 18.h,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(infoCards.length, (index) {
                    final card = infoCards[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      enableFeedback: true,
                      onTap: () {},
                      child: Hero(
                        tag: 'infoCard_${card.title}',
                        child: InfoCard(
                          imagePath: card.imagePath,
                          title: card.title,
                          description: card.description,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24.h), // Additional bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
