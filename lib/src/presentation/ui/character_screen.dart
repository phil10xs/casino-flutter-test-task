import 'package:animate_do/animate_do.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/infinite_scroll_list.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  int page = 1;
  bool everyThingLoaded = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      BlocProvider.of<MainPageBloc>(
        context,
        listen: false,
      )..add(GetTestDataOnMainPageEvent((page)));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {},
        builder: (blocContext, state) {
          if (state is LoadingMainPageState) {
            return _loadingWidget(context);
          } else if (state is SuccessfulMainPageState) {
            return _successfulWidget(state);
          } else {
            return _failedWidget(context);
          }
        },
      ),
    );
  }

  Widget _failedWidget(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              BlocProvider.of<MainPageBloc>(
                context,
                listen: false,
              )..add(GetTestDataOnMainPageEvent(page));
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(SuccessfulMainPageState state) {
    return InfiniteScrollList(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: state.characters.map((e) => _characterWidget(e)).toList(),
      onLoadingStart: (p) async {
        BlocProvider.of<MainPageBloc>(
          context,
          listen: false,
        )..add(GetTestDataOnMainPageEvent((p + 1)));
      },
      everythingLoaded: everyThingLoaded,
    );
  }

  Widget _characterWidget(Character character) {
    return ElasticIn(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  character.image,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        character.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(character.gender),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Specie: ${character.species}'),
                    ),
                    if (character.origin.dimension != null)
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          'Dimension: ${character.origin.dimension ?? ''}',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
