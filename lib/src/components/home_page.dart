import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../fruit_blocs/bloc.dart';
import '../models/fruits.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FruitBloc _fruitBloc;
  final GlobalKey<AnimatedListState> keyList = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // Obtaining the FruitBloc instance through BlocProvider which is an InheritedWidget
    _fruitBloc = BlocProvider.of<FruitBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    print(_fruitBloc.currentState);
    // We want to start loading fruits right from the start.
    _fruitBloc.dispatch(LoadFruits());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit app'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _fruitBloc.dispatch(AddRandomFruit());
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _fruitBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, FruitState state) {
        if (state is FruitLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FruitLoaded) {
          return ListView.builder(
            itemCount: state.fruits.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final displayedFruit = state.fruits[index];
              return ListTile(
                title: Text(displayedFruit.name),
                subtitle:
                    Text(displayedFruit.isBig ? 'Very big!' : 'Sooo small!'),
                trailing: _buildUpdateDeleteButtons(displayedFruit),
              );
            },
          );
        }
      },
    );
  }

  Row _buildUpdateDeleteButtons(Fruit displayedFruit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _fruitBloc.dispatch(UpdateRandomFruit(displayedFruit));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _fruitBloc.dispatch(DeleteFruit(displayedFruit));
          },
        ),
      ],
    );
  }
}
