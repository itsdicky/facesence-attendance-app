import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/styles/color_style.dart';

class MainCard extends StatelessWidget {
  final String grade;
  final String name;
  final int presence;
  final int absence;

  const MainCard({super.key, required this.grade, required this.name, required this.presence, required this.absence});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 174,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Image.asset('assets/images/maincard-image.png'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        grade,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorStyle.white),
                      ),
                      const SizedBox(height: 8,),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            presence.toString(),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorStyle.white),
                          ),
                          Text(
                            'Hadir',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorStyle.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        children: [
                          Text(
                            absence.toString(),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorStyle.pinkyRed),
                          ),
                          Text(
                            'Absen',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorStyle.pinkyRed),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}