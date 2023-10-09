import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywebapp/cubit/counter/counter_cubit.dart';


Stream<int> countStream (int max) async* {
  for (int i = 0; i< max; i++){
    await Future.delayed(const Duration(seconds: 1) );
    yield i;
  }
}

void main() {
  Stream<int> myCountStream = countStream(5);
  myCountStream.listen((int myCount) {
    print("received: $myCount");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit> ( 
    create: (context) => CounterCubit(),
    child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    )
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  void decrement() {

  }

  void increment() {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState> (
         builder: (context, state) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              )
            );
      },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [    
          const SizedBox(height: 8.0),  
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), 
                    FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ), 
        ],)
    )
    ;
  }
}
