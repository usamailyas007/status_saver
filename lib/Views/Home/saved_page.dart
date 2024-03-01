import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/fetch_status/fetch_status_bloc.dart';
import '../../Utilities/Widgets/image_container.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key, required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return BlocProvider(
      create: (context) => FetchStatusBloc()..add(FetchSavedImages()),
      child: Builder(
        builder: (context) {
          return BlocBuilder<FetchStatusBloc, FetchStatusState>(
            builder: (context, state) {
              return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<FetchStatusBloc>(context)
                        .add(FetchSavedImages());
                    return Future.value();
                  },
                  child: state is FetchStatusLoading
                      ? const Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: RepaintBoundary(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : state is FetchStatusSuccess
                          ? GridView.builder(
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount: state.statuses.length,
                              itemBuilder: (context, index) {
                                return StatusImageContainer(
                                  imagePath: state.statuses[index].path,
                                  controller: controller,
                                );
                              },
                            )
                          : const Center(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: RepaintBoundary(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ));
            },
          );
        }
      ),
    );
  }
}
