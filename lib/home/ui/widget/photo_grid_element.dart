import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_warehouse/core/constants/app_design.dart';

class PhotoGridElement extends StatelessWidget {
  final String title;
  final Future<Map<String, dynamic>> futureFunction;
  final Color? extendedColor;
  final int flex;
  const PhotoGridElement({
    Key? key,
    required this.title,
    required this.futureFunction,
    this.extendedColor,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF4C4C4C).withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(
            AppDesign.circularRadius,
          ),
        ),
        height: 190,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDesign.circularRadius,
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: futureFunction,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        if (File(
                          snapshot.data!['image_path'],
                        ).existsSync())
                          Image.file(
                            File(
                              snapshot.data!['image_path'],
                            ),
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        FittedBox(
                          child: Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppDesign.smallPadding),
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      AppDesign.circularRadius,
                                    ),
                                  ),
                                ),
                                color: Colors.white54,
                              ),
                              child: Text(
                                snapshot.data!['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SvgPicture.asset(
                      'assets/svg/productPlaceHolder.svg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(AppDesign.mediumPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4C4C4C),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
