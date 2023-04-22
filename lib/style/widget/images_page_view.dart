import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class ImagePageView extends StatefulWidget {
  final List? images;
  final String? tag;

  const ImagePageView({Key? key, this.images, @required this.tag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImagePageView();
}

class _ImagePageView extends State<ImagePageView> with SingleTickerProviderStateMixin{
  CarouselController buttonCarouselController = CarouselController();
  final _controller = ScrollController();
  Animation<double>? _animation;
  AnimationController? controller;

  int _current = 0;
  bool autoPlay = false;



  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    super.initState();
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 12.0,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              const SizedBox(
                width: 30,
              ),
              CustomText(
                text: '${_current + 1} / ${widget.images!.length}',
                color: Colors.white,
              ),
              IconButton(onPressed: (){
                setState(() => autoPlay = !autoPlay);
                controller!.forward();
              }, icon: Icon(autoPlay ? Icons.pause : Icons.play_arrow_outlined),color: Colors.white,),
              const Spacer(),
              Container(
                height: h * 0.10 - 12,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),

          Hero(
            tag: widget.tag!,
            child: CarouselSlider(
              items: widget.images!.map((e) {
                return ImageView(
                  width: w,
                  image: e,
                  height: h * 0.75,

                  fit: BoxFit.contain,
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlayInterval:const Duration(milliseconds: 4000) ,
                height: h * 0.75,
                onPageChanged: (index, pageChange) {

                  setState(() {
                    _current = index;
                  });
                  _animateToIndex(index, h * 0.09);
                  if(autoPlay){
                    _reForward();
                  }
                },
                autoPlay: autoPlay,

                autoPlayAnimationDuration:const Duration(milliseconds: 2000),
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
            ),
          ),
          if(autoPlay)
            Container(
              width:  w * 0.80 ,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              color: Colors.grey.shade900,
              child: LinearProgressIndicator(value: _animation!.value,minHeight: 1,),
            ),

          Container(
            height: h * 0.05 -12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images!.map((url) {
                int index = widget.images!.indexOf(url);
                return Container(
                  width: _current == index ? 10.0 : 6.0,
                  height: _current == index ? 10.0 : 6.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Style.primaryColors : Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            height: h * 0.10 ,
            // width: w * 0.75,
            alignment: Alignment.center,
            color: Colors.grey.shade900,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                        border: index == _current
                            ? Border.all(color: Colors.white, width: 1.5)
                            : null),
                    margin: const EdgeInsets.all(6.0),
                    width: h * 0.09,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: ImageView(
                        image: widget.images![index],
                        width: h * 0.09,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 500),(){
                      buttonCarouselController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastLinearToSlowEaseIn);

                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  _animateToIndex(i, w) => _controller.animateTo(w * i,
      duration: const Duration(milliseconds: 1500), curve: Curves.fastOutSlowIn);

  _reForward ( ){
    controller!.reset();
    Future.delayed(const Duration(milliseconds: 750),(){
      controller!.forward();
    });
  }
}
