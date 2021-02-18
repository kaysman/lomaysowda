import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/slider.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SliderPart extends StatefulWidget {
  const SliderPart({
    Key key,
  }) : super(key: key);

  @override
  _SliderPartState createState() => _SliderPartState();
}

class _SliderPartState extends State<SliderPart> {
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
    if (myProvider.sliderImages == null) {
      return FutureBuilder<List<SliderImage>>(
        future: myProvider.getSliderImages(api: 'sliders'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SliderContainer();
          } else {
            return Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: SliderShimmerEffect(),
            );
          }
        },
      );
    } else {
      return SliderContainer();
    }
  }
}

class SliderShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[300],
      child: Card(
        elevation: 1,
        child: Container(
          height: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class SliderContainer extends StatelessWidget {
  const SliderContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder:
          (BuildContext context, final MyProvider myProvider, Widget child) {
        return CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayCurve: Curves.easeIn,
          ),
          items: myProvider.sliderImages.map((img) {
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  imageUrl: img.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  // errorWidget: (context, url, error) => Image.asset(
                  //   'assets/bag_10.png',
                  //   fit: BoxFit.cover,
                  // ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
