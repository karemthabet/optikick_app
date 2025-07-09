import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/metric_cubit.dart';

class CustomTabSelector extends StatefulWidget {
  const CustomTabSelector({
    super.key,
    required this.mericType,
  });
  final String mericType;
  // ignore: library_private_types_in_public_api
  @override
  _CustomTabSelectorState createState() => _CustomTabSelectorState();
}

class _CustomTabSelectorState extends State<CustomTabSelector> {
  int selectedIndex = 0;

  final List<String> tabs = ['D', 'W', 'M', '6M'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(141, 182, 182, 182),
          width: 1,
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xff5D6E68),
            Color.fromARGB(255, 30, 47, 41),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<MetricCubit>().getPlayerMetric(
                  mericType: widget.mericType,
                  period: tabs[index],
                );
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            child: Text(
              tabs[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? Colors.white
                    : const Color.fromARGB(255, 145, 145, 145),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.white,
          thickness: 1,
          width: 1,
        ),
        itemCount: tabs.length,
      ),
    );
  }
}
