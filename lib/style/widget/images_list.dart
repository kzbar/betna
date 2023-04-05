
import 'package:betna/style/widget/ImageView.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  final List<dynamic>? photosList;
  final ValueChanged? valueChanged;
  final PageController? controller ;


  const ImageList({Key? key, this.photosList, this.valueChanged, this.controller}) : super(key: key);
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: widget.photosList!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              if(widget.controller != null){
                setState(() {
                  this.index = index;
                  widget.controller!.animateToPage(index, duration: Duration(microseconds: 200), curve: Curves.linear);
                });
                widget.valueChanged!(index);

              }

            },
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Style.lavenderBlack,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ImageView(image: widget.photosList![index],),
                ),
              ),
            ),
          ),);
        },
      ),
    );
  }
}
