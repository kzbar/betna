import 'package:betna/generated/l10n.dart';
import 'package:betna/listView_mixin.dart';
import 'package:betna/models/project_model.dart';
import 'package:betna/rowsItems/page_row_item.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/list_items_empty.dart';
import 'package:betna/rowsItems/row_item_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectsSection();

}

class _ProjectsSection extends State<ProjectsSection> with AutomaticKeepAliveClientMixin ,ListViewMixin  {
  List<dynamic> listToShow = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement list
  LayoutBuilder get list {
    if (room != null && room!.isNotEmpty) {
      switch(room){
        case '*':
          listToShow = Provider.of<MainProvider>(context, listen: true).projectList.list!;
          break;
        default:
          listToShow = listToShow.where((element) => element.room == room).toList();
      }
      listCount = listToShow.length;
    }

    return LayoutBuilder(
      builder: (context, box) {
        listCount = listToShow.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Scrollbar(
                child: listToShow.isEmpty
                    ? ListItemsEmpty()
                    : ListView.builder(
                    itemCount: listToShow.length,
                    primary: true,
                    shrinkWrap: true,
                    //just set this property
                    padding: const EdgeInsets.only(
                        bottom: 6, top: 6, right: 6, left: 6),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, itemCount) {
                      ProjectModel model = listToShow[itemCount];
                      return ProjectRowItem(
                        model: model,
                        tag: '${''}_project',
                      );
                    })),),
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
  List get listItem  => listToShow;

  @override
  // TODO: implement notifier
  ListNotifier get notifier {
    listToShow =
    Provider
        .of<MainProvider>(context, listen: true)
        .projectList
        .list!;
    return Provider
        .of<MainProvider>(context, listen: true)
        .projectList;
  }

  @override
  // TODO: implement title
  String get title => S.of(context).kProjectAll;

  @override
  // TODO: implement scrollController
  ScrollController get scrollController => ScrollController();

  @override
  Function? changed(val) {
    // TODO: implement changed
    throw UnimplementedError();
  }

  @override
  // TODO: implement showFilterInsideSite
  bool get showFilterInsideSite => false;

  @override
  // TODO: implement showFilterRom
  bool get showFilterRom => true;

}
