import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_study/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:supercharged/supercharged.dart';

class DetailPage extends StatelessWidget {
  final Recommendation recommendation;
  final int index;
  const DetailPage(
      {super.key, required this.recommendation, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: 'barang$index',
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 2,
                imageUrl: recommendation.image.toString(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Text(error.toString()),
                fit: BoxFit.cover, // Adjust the fit property as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  maxChildSize: 1,
                  minChildSize: 0.5,
                  builder: (context, scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            //borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.actor(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              //SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 5),
                                child: Text(
                                  "Bahan",
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.actor(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 3),
                                child: Text(
                                  "seledri, tomat, sawi putih",
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.actor(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBar() => SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                  child: Text(
                    "Harga",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.actor(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "Rp 15.000",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.actor(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 20),
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 1,
                          color: Colors.grey,
                          spreadRadius: 1,
                          offset: Offset(3, 5))
                    ],
                    color: "FFF8C9".toColor(),
                    borderRadius: BorderRadius.circular(5)),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Beli",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.actor(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                )),
          ],
        ),
      );
}
