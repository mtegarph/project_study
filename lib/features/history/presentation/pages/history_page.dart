import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_study/config/theme/app_theme.dart';
import 'package:project_study/features/history/presentation/bloc/history_bloc.dart';
import 'package:supercharged/supercharged.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Riwayat Barang Yang Sudah Pernah Di Pesan",
                style: headlineStyleText(),
              ),
            ),
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoading) {
                  return const CupertinoActivityIndicator();
                }
                if (state is HistoryFailed) {
                  return Text(
                    state.error!.message.toString(),
                    style: headlineStyleText(),
                  );
                }
                if (state is HistoryDone) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.history!.length,
                      itemBuilder: (context, index) {
                        var item = state.history![index];
                        return Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.sizeOf(context).width / 2,
                          //height: MediaQuery.sizeOf(context).height / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(10, 5))
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.shop),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Belanja",
                                        style: titleStyleText(),
                                      ),
                                      Text(DateTime.now().toString())
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                indent: 2,
                                height: 2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    //height: 50,

                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    imageUrl: item.thumbnail.toString(),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Text(error.toString()),
                                    fit: BoxFit
                                        .cover, // Adjust the fit property as needed
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title.toString(),
                                          softWrap:
                                              true, // Break the text at soft line breaks
                                          overflow: TextOverflow
                                              .ellipsis, // Use an ellipsis to indicate that the text is too long
                                          maxLines: 3,
                                          style: titleStyleText(),
                                        ),
                                        Text(
                                          "${item.total} pieces",
                                          style: titleStyleText().copyWith(
                                              fontSize: 13, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Rp ${item.price.toString()}.000",
                                  style: headlineStyleText(),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
