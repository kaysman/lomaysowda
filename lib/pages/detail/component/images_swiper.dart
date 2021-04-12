import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';

class ImagesSwiper extends StatefulWidget {
  final List imagesList;
  const ImagesSwiper({Key key, this.imagesList}) : super(key: key);

  @override
  _ImagesSwiperState createState() => _ImagesSwiperState();
}

class _ImagesSwiperState extends State<ImagesSwiper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight * 0.3,
      color: Colors.white,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 4000,
        duration: 750,
        itemBuilder: (BuildContext context, int index) {
          return MyCachedNetworkImage(
            imageurl: widget.imagesList[index]['image'],
          );
        },
        itemCount: widget.imagesList.length,
      ),
    );
  }
}
