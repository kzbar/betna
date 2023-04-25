import 'package:betna/generated/l10n.dart';
import 'package:betna/listView_mixin.dart';
import 'package:betna/models/project_model.dart';
import 'package:betna/rowsItems/page_row_item.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectsSection();
}

class _ProjectsSection extends State<ProjectsSection>
    with
        AutomaticKeepAliveClientMixin,
        ListViewMixin,
        TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  AnimationController? _controller;

  Animation<Offset>? _offsetAnimation;
  List<ProjectModel> listToShow = [];

  List<ProjectModel> listBase = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement list
  LayoutBuilder get list {
    List<ProjectModel> listS = [];

    if (query != null) {
      listS = listToShow
          .where((element) =>
              query!.room == null ||
              query!.room == '*' ||
              element.roomsAndPrice!.every(
                  (ele) => ele['room'].toString().contains(query!.room!)))
          .toList();
      listToShow = [...listS];
      _controller!.forward(from: 0.6);
    }
    // listToShow.sort(
    //         (a, b) => b.available.toString().compareTo(a.available.toString()));

    return LayoutBuilder(
      builder: (context, box) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: listToShow.isNotEmpty
                  ? ListView.builder(
                      itemCount: listToShow.length,
                      shrinkWrap: false,
                      //just set this property
                      padding: const EdgeInsets.only(
                          bottom: 6, top: 6, right: 6, left: 6),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, itemCount) {
                        ProjectModel model = listToShow[itemCount];
                        return SlideTransition(
                          position: _offsetAnimation!,
                          child: ProjectRowItem(
                            model: model,
                            tag: 'project',
                          ),
                        );
                      })
                  : Center(
                      child: CustomText(
                        text: S.of(context).kNoOffer,
                      ),
                    ),
            ),
            const SizedBox(
              height: 3,
            ),
            CustomText(
              text: S.of(context).kOfferLength('${listToShow.length}'),
              size: 12,
              color: Style.lavenderBlack,
            ),
          ],
        );
      },
    );
  }

  @override
  // TODO: implement listItem
  List get listItem => listToShow;

  @override
  // TODO: implement notifier
  ListNotifier get notifier {
    listBase =
        Provider.of<MainProvider>(context, listen: true).projectList.list!;
    String lang = Provider.of<MainProvider>(context, listen: true).kLang;
    listToShow = listBase;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(lang == 'ar' ? -1 : 1, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));
    _controller!.forward();

    listToShow =
        Provider.of<MainProvider>(context, listen: true).projectList.list!;
    return Provider.of<MainProvider>(context, listen: true).projectList;
  }

  @override
  // TODO: implement title
  String get title => S.of(context).kProjectAll;

  @override
  // TODO: implement scrollController
  ScrollController get scrollController => ScrollController();

  @override
  // TODO: implement showFilterInsideSite
  bool get showFilterInsideSite => false;

  @override
  // TODO: implement showFilterRom
  bool get showFilterRom => true;
}
