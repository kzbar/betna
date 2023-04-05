import 'package:betna/items/page_row_item.dart';
import 'package:betna/models/project_model.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/widget/list_items_empty.dart';
import 'package:betna/style/widget/row_item_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsListWidget extends StatelessWidget {
  const ProjectsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListNotifier<ProjectModel> notifier =
        Provider.of<MainProvider>(context, listen: true).projectList;
    List<ProjectModel> listResult = [];
    listResult = notifier.list!;

    switch (notifier.fetchDataState) {
      case FetchDataState.done:
        return listResult.isNotEmpty
            ? Scrollbar(
                child: ListView.builder(
                    itemCount: listResult.length,
                    primary: true,
                    shrinkWrap: true,
                    //just set this property
                    padding: const EdgeInsets.only(
                        bottom: 0, top: 12, right: 12, left: 12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, itemCount) {
                      ProjectModel _model = listResult[itemCount];
                      return ProjectRowItem(
                        model: _model,
                        tag: '${_model.id}',
                      );
                    }))
            : ListItemsEmpty();
      case FetchDataState.wait:
        return Scrollbar(
            child: ListView.builder(
                itemCount: 1,
                primary: true,
                shrinkWrap: true,
                //just set this property
                padding: const EdgeInsets.only(
                    bottom: 50, top: 12, right: 12, left: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, itemCount) {
                  return const EmptyRowItem();
                }));
      case FetchDataState.error:
        return Container();
      case FetchDataState.none:
        return Scrollbar(
            child: ListView.builder(
                itemCount: 1,
                primary: true,
                shrinkWrap: true,
                //just set this property
                padding: const EdgeInsets.only(
                    bottom: 50, top: 12, right: 12, left: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, itemCount) {
                  return const EmptyRowItem();
                }));
      default:
        {
          return Scrollbar(
              child: ListView.builder(
                  itemCount: 1,
                  primary: true,
                  shrinkWrap: true,
                  //just set this property
                  padding: const EdgeInsets.only(
                      bottom: 50, top: 12, right: 12, left: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, itemCount) {
                    return const EmptyRowItem();
                  }));
        }
    }
  }
}
