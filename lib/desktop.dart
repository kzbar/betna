import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betna/bar.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/section/projects_section.dart';
import 'package:betna/section/resale_section.dart';
import 'package:betna/section/urgent_section.dart';
import 'package:betna/style/widget/list_view_items.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<StatefulWidget> createState() => _Desktop();
}

class _Desktop extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.65;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const CustomBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Expanded(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///title
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Style.primaryColors,width: 2),
                      borderRadius: BorderRadius.circular(6),
                      color: Style.primaryColors
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 6),
                          child: SizedBox(
                            height: 40,
                            child: DefaultTextStyle(
                              style:  const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.white,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FlickerAnimatedText(S.of(context).kUrgent),
                                  FlickerAnimatedText(S.of(context).kUrgent1),
                                  FlickerAnimatedText(S.of(context).kUrgent2),
                                ],
                                onTap: () {
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          width: w,
                          height: 200,
                          child: const UrgentListWidget(),
                        ),
                      ],
                    ),
                  ),

                  ///projects list
                  ListViewItems(
                    title: S.of(context).kProjectAll,
                    titleAction: S.of(context).kSeeAllListing,
                    function: () {},
                    list: const ProjectsListWidget(),
                  ),

                  ///resale list
                  ListViewItems(
                    title: S.of(context).kSale,
                    titleAction: S.of(context).kSeeAllListing,
                    function: () {},
                    list: const SaleListWidget(),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
