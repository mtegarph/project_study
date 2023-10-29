import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_study/config/theme/app_theme.dart';
import 'package:project_study/features/dashboard/presentation/bloc/product/remote/remote_product_bloc.dart';
import 'package:project_study/features/dashboard/presentation/page/detail_page.dart';
import 'package:project_study/models/item.dart';
import 'package:supercharged/supercharged.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendation = [
      // Recommendation(
      //     "Cherry healty",
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     5000.0),
      // Recommendation(
      //     "Cherry healty",
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     5000.0),
      // Recommendation(
      //     "Cherry healty",
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     5000.0),
      // Recommendation(
      //     "Cherry healty",
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     5000.0),
    ];
    final other = [
      // Other(
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     "Cherry healty",
      //     5000.0),
      // Other(
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     "Cherry healty",
      //     5000.0),
      // Other(
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     "Cherry healty",
      //     5000.0),
      // Other(
      //     "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
      //     "Cherry healty",
      //     5000.0)
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: BlocBuilder<RemoteProductBloc, RemoteProductState>(
          builder: (context, state) {
            if (state is RemoteProductLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is RemoteProductFailed) {
              return const Center(
                child: Icon(Icons.refresh),
              );
            }
            if (state is RemoteProductDone) {
              state.product?.forEach((element) {
                recommendation.add(Recommendation(
                    element.title,
                    "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
                    element.price?.toDouble()));
                other.add(Other(
                    "https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe.png",
                    element.title,
                    element.price?.toDouble()));
              });
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBar(context),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 230, // Adjust this height as needed
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendation.length,
                        itemBuilder: (context, index) {
                          final item = recommendation[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      recommendation: item, index: index),
                                )),
                            child: Hero(
                              tag: 'barang$index',
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: item.buildArea(context),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Pilih Makanan yang kami pilih untuk kamu",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 15, color: "4D4D4D".toColor()),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: other.length,
                      itemBuilder: (context, index) {
                        final item = other[index];

                        ///jadi jika kita menggunakan liskov substitution principle disini bisa dilihat
                        ///kalau master class yang ada yaitu Other bisa di deklarasi kan dengan subclass Drink
                        ///dikarenakan Drink meng heritance class Other
                        final Other oth =
                            Drink(item.image, item.name, item.price);
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              item.buildArea(context),
                              oth.buildArea(context)
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

///dan ini adalah contoh class yang menggunakan liskov principle yang dimana dia meng extends class super class yaitu other
///dan menggunakanya dan tidak banyak mengubah fungsi utama
class Drink extends Other {
  Drink(super.image, super.name, super.price);
  @override
  Widget buildArea(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      // width: MediaQuery.of(context).size.width / ,
      //height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: 'FAD7A0'.toColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              //height: 50,
              width: MediaQuery.of(context).size.width / 3,
              imageUrl: image.toString(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Text(error.toString()),
              fit: BoxFit.cover, // Adjust the fit property as needed
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 200,
                child: Text(
                  name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.actor(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                price.toString(),
                style: GoogleFonts.actor(color: Colors.black, fontSize: 15),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

///ini adalah class yang menggunakan abstract class item untuk meng inheritance fungsi dari main class item
class Other implements Item {
  String? name;
  String? image;
  double? price;
  Other(this.image, this.name, this.price);
  @override
  Widget buildArea(BuildContext context) {
    // TODO: implement buildArea
    return Container(
      margin: const EdgeInsets.all(8),
      // width: MediaQuery.of(context).size.width / ,
      //height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: '3F1D38'.toColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              //height: 50,
              width: MediaQuery.of(context).size.width / 3,
              imageUrl: image.toString(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Text(error.toString()),
              fit: BoxFit.cover, // Adjust the fit property as needed
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 200,
                child: Text(
                  name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.actor(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                price.toString(),
                style: GoogleFonts.actor(color: Colors.white, fontSize: 15),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

//ini adalah class yang menggunakan abstract class item untuk meng inheritance fungsi dari main class item
class Recommendation implements Item {
  String? name;
  String? image;
  double? price;
  Recommendation(this.name, this.image, this.price);
  @override
  Widget buildArea(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: '3F1D38'.toColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: image.toString(),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Text(error.toString()),
            fit: BoxFit.cover, // Adjust the fit property as needed
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            child: Text(
              name.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: GoogleFonts.actor(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                price.toString(),
                style: GoogleFonts.actor(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              width: 88,
              height: 16,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFC700),
                        shape: StarBorder(
                          points: 5,
                          innerRadiusRatio: 0.38,
                          pointRounding: 0,
                          valleyRounding: 0,
                          rotation: 0,
                          squash: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFC700),
                        shape: StarBorder(
                          points: 5,
                          innerRadiusRatio: 0.38,
                          pointRounding: 0,
                          valleyRounding: 0,
                          rotation: 0,
                          squash: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFC700),
                        shape: StarBorder(
                          points: 5,
                          innerRadiusRatio: 0.38,
                          pointRounding: 0,
                          valleyRounding: 0,
                          rotation: 0,
                          squash: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 54,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFC700),
                        shape: StarBorder(
                          points: 5,
                          innerRadiusRatio: 0.38,
                          pointRounding: 0,
                          valleyRounding: 0,
                          rotation: 0,
                          squash: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 72,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFEBEBEB),
                        shape: StarBorder(
                          points: 5,
                          innerRadiusRatio: 0.38,
                          pointRounding: 0,
                          valleyRounding: 0,
                          rotation: 0,
                          squash: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
