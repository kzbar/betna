import 'package:betna/generated/l10n.dart';
import 'package:betna/style/widget/images_list.dart';
import 'package:betna/style/widget/skeleton.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotosView extends StatefulWidget {
  final List<dynamic>? images;
  final String? flatId;

  const PhotosView({Key? key, this.images, this.flatId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhotosView();
  }
}

class _PhotosView extends State<PhotosView> {
  final GlobalKey<ScaffoldState> _sKey = GlobalKey<ScaffoldState>();

  int indexImage = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).adPhoto),
            actions: [
              IconButton(
                  icon: Icon(Icons.share_outlined),
                  onPressed: () async {
                    shareImages(context);
                  }),
            ],
          ),
          key: _sKey,
          body: Center(
            child: Container(
              width: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: GalleryPhotoViewWrapper(
                      galleryItems: widget.images,
                      pageController: controller,
                      loadingBuilder: (cx, image) {
                        return Skeleton(
                          showCircular: false,
                          cornerRadius: 24,
                        );
                      },
                      backgroundDecoration: BoxDecoration(
                        color: Style.primaryColors,
                      ),
                      initialIndex: 0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    child: ImageList(
                      controller: controller,
                      photosList: widget.images,
                      valueChanged: (index) {
                        setState(() {
                          indexImage = index;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void shareImages(context) async {
    // _showDialogFlash();
    // await WM().share(
    //     ref:
    //         'https://kira-contract.web.app/#/forRent?rentId=${widget.flatId}',
    //     context: context);
    // Navigator.of(context).pop();
  }

  void _showDialogFlash() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
    this.pageController,
  });

  final LoadingBuilder? loadingBuilder;
  final Decoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int? initialIndex;
  final PageController? pageController;
  final List<dynamic>? galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int? currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(6.0),
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder!,
              pageController: widget.pageController!,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "${currentIndex! + 1}",
                style:  TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(widget.galleryItems![index],scale: 1.5),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 1.0,
      heroAttributes: PhotoViewHeroAttributes(tag: index),
    );
  }
}
