import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lomaysowda/models/slider.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';

class HeadSwiper extends StatefulWidget {
  final List<SliderModel> bannerList;
  const HeadSwiper({Key key, this.bannerList}) : super(key: key);

  @override
  _HeadSwiperState createState() => _HeadSwiperState();
}

class _HeadSwiperState extends State<HeadSwiper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0 + 30,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 4000,
        duration: 750,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 135,
            child: MyCachedNetworkImage(
              imageurl: widget.bannerList[index].image,
            ),
          );
        },
        itemCount: widget.bannerList.length,
      ),
    );
  }
}
