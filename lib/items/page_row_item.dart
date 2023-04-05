import 'package:betna/generated/l10n.dart';
import 'package:betna/models/project_model.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectRowItem extends StatefulWidget {
  final ProjectModel? model;
  final String? tag;

  const ProjectRowItem({Key? key, this.model, this.tag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectRowItem();
}

class _ProjectRowItem extends State<ProjectRowItem> {
  bool isShare = false;
  GlobalKey _globalKey = new GlobalKey();
  String? rooms = '';

  @override
  void initState() {
    widget.model!.roomsAndPrice!.map((e) {
      rooms = '$rooms  ${e['room']}  ';
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String lang = Provider.of<MainProvider>(context, listen: false).kLang;
    void _handleSharePressed() async {
      setState(() {
        isShare = true;
      });
      // try {
      //   Capture().capturePng(context,_globalKey).then((value) async {
      //     await WM()
      //         .saveAndLaunchImage(value, "${widget.model!.id}.png")
      //         .then((value) {
      //       setState(() {
      //         isShare = false;
      //       });
      //     });
      //   });
      // } catch (error) {
      //   setState(() {
      //     isShare = false;
      //   });
      //   rethrow;
      // }
      CloseContextMenuNotification().dispatch(context);
    }

    return ContextMenuRegion(
      contextMenu: TextButton(
        style: ButtonStyles.style,
        onPressed: _handleSharePressed,
        child: CustomText(
          text: S.of(context).kShare,
          color: Style.lavenderBlack,
        ),
      ),
      child: InkWell(
        child: RepaintBoundary(
          key: _globalKey,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: Corners.lgBorder,
                    boxShadow: Shadows.universal),
                width: 300,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: '${widget.model!.id!}${widget.tag}',
                          child: ClipRRect(
                            borderRadius: Corners.lgBorderTop,
                            child: ImageView(
                              height: 280 * 0.75,
                              width: 300,
                              image: widget.model!.image!.isNotEmpty
                                  ? widget.model!.image![0]
                                  : '',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InfoTextWidget(
                                text1: S.of(context).kProjectType,
                                text2:
                                    '${kProjectState.singleWhere((element) => element['id'] == widget.model!.propertyType)[lang]}',
                              ),
                            ],
                          ),
                        ),
                        if (rooms!.isNotEmpty)
                          InfoTextWidget(
                            text1: S.of(context).kRoomPlan,
                            text2: rooms,
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InfoTextWidget(
                                text1: S.of(context).kCity,
                                text2: '${widget.model!.city!.name}',
                              ),
                              InfoTextWidget(
                                text1: S.of(context).kTown,
                                text2: '${widget.model!.town!.name}',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 6,right: 6),
                          child: CustomText(
                            text: Constants.convertPrice(
                                context, widget.model!.staredPrice!),
                            size: 20,
                            color: Style.primaryColors,
                            weight: FontWeight.bold,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        margin: const EdgeInsets.only(),
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: Corners.medBorder,
                            color: Style.primaryColors),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (Constants.checkIsNewItem(
                                DateTime.fromMillisecondsSinceEpoch(widget
                                        .model!.date!.millisecondsSinceEpoch)
                                    .toIso8601String())) ...[
                              CustomText(
                                text: S.of(context).kNew.toUpperCase(),
                                size: 10,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: ' - ',
                                size: 12,
                                color: Colors.white,
                              ),
                            ],
                            CustomText(
                              text: Constants.timeAgoSinceDate(
                                      DateTime.fromMillisecondsSinceEpoch(widget
                                              .model!
                                              .date!
                                              .millisecondsSinceEpoch)
                                          .toIso8601String(),
                                      context: context)
                                  .toUpperCase(),
                              size: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        color: Colors.white70,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4),
                        margin: const EdgeInsets.only(),
                        child: CustomText(
                          text: widget.model!.id,
                          color: Style.lavenderBlack,
                          weight: FontWeight.bold,
                          height: 1,
                          size: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 124,
                      left: 12,
                      child: Column(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                '${kPropertyType.singleWhere((element) => element['id'] == widget.model!.propertyType)[lang]}',
                            size: 12,
                            color: Colors.white,
                            height: 2,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Visibility(
                    visible: isShare,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    )),
              )
            ],
          ),
        ),
        onTap: () {
          // Navigator.of(context).push(PageRouteBuilder(
          //     settings: RouteSettings(name: 'project?id=${widget.model!.id}'),
          //     pageBuilder: (BuildContext context, Animation<double> animation,
          //         Animation<double> secondaryAnimation) {
          //       return DetailsProject(
          //         model: widget.model,
          //         tag: widget.tag,
          //       );
          //     }));
        },
      ),
    );
  }
}

class InfoTextWidget extends StatelessWidget {
  final String? text1;
  final String? text2;

  const InfoTextWidget({Key? key, this.text1, this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
      child: Row(
        children: [
          CustomText(
            text: text1,
            color: Colors.black45,
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          CustomText(
            text: text2,
            color: Style.primaryColors,
            weight: FontWeight.bold,
            size: 16,
          ),
        ],
      ),
    );
  }
}
