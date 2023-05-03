import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        grade,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: ColorStyle.white),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: ColorStyle.white),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            presence.toString(),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(color: ColorStyle.white),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Hadir',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(color: ColorStyle.white),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        children: [
                          Text(
                            absence.toString(),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(color: ColorStyle.pinkyRed),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Absen',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(color: ColorStyle.pinkyRed),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Image.asset('assets/images/maincard-image.png'),
            ],
          ),
        ),
      ),
    );
  }
}