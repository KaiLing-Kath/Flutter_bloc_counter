//builder
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:state_management/counter_cubit.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider ( //created before create a BLoC
//           create: (context) => CounterCubit(), //this class is from the counter_cubit page
//           child: const MyHomePage()),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget { //stateful means it will change, so u need to set the state on hw is it going to run
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> { //rmb to use setState()
//   int count = 0;
//
//   late CounterCubit cubit;
//
//   @override
//   void didChangeDependencies() { // this runs whenever the state changes
//     cubit = BlocProvider.of<CounterCubit>(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Bloc'),
//       ),
//       body: BlocBuilder<CounterCubit, int >( //after blocbuilder
//         bloc: cubit,
//         builder: (context, state) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('$state',style: TextStyle(fontSize: 50),),
//                     ElevatedButton(
//                       onPressed: () {cubit.increment();},
//                       child: const Text('Increment'),
//                     )
//                   ],
//                 ),
//               );
//             }
//         ),
//      // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//

//listener & builder
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:state_management/counter_cubit.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider ( //created before create a BLoC
//           create: (context) => CounterCubit(), //this class is from the counter_cubit page
//           child: const MyHomePage()),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget { //stateful means it will change, so u need to set the state on hw is it going to run
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> { //rmb to use setState()
//   //int count = 0;
//
//   late CounterCubit cubit;
//
//   @override
//   void didChangeDependencies() { // this runs whenever the state changes
//     cubit = BlocProvider.of<CounterCubit>(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Flutter Bloc')),
//       ),
//       body: BlocListener<CounterCubit, int >( //after blocbuilder
//         bloc: cubit,
//         listener: (context, state) {
//           const snackbar = SnackBar(content: Text('State is reached'),
//           );
//           if(state == 2005) {
//             ScaffoldMessenger.of(context).showSnackBar(snackbar);
//           }
//         },
//         child: BlocBuilder<CounterCubit, int>(
//             bloc: cubit, //give after the bloc builder created
//             builder: (context, state) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('$state', style: TextStyle(fontSize: 50),),
//                     ElevatedButton(onPressed: () {cubit.increment();},
//                       child: const Text('Increment'),
//                     )
//                   ],
//                 ),
//               );
//             }
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

//consumer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/counter_cubit.dart';
import 'package:state_management/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          //created before create a BLoC
          create: (context) =>
              CounterCubit(), //this class is from the counter_cubit page
          child: const MyHomePage()),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/result':
            final data = settings.arguments as ScreenArguments;

            return MaterialPageRoute(
                builder: (_) => resultPage(
                      counter: data.counter,
                      inputNumber: data.inputNumber,
                      function: data.function,
                    ));
            break;
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  //stateful means it will change, so u need to set the state on hw is it going to run
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //rmb to use setState()
  //int count = 0;

  late CounterCubit cubit;
  final inputNumber = TextEditingController();

  void navigateToResultPage(
      BuildContext context, int counter, int inputNumber, String function) {
    Navigator.pushNamed(
      context,
      '/result',
      arguments: ScreenArguments(counter, inputNumber, function),
    );
  }

  @override
  void didChangeDependencies() {
    // this runs whenever the state changes
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Flutter Bloc')),
        ),
        body: BlocConsumer<CounterCubit, int>(
          bloc: cubit,
          listener: (context, state) {
            const snackbar = SnackBar(
              content: Text('Congrats!! State is reached!!'),
            );
            if (state == 5) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  TextField(
                    controller: inputNumber,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(hintText: "Input number"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$state',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  cubit.increment();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    padding: EdgeInsets.all(12)),
                                child: const Text('Increment',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.decrement();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    padding: EdgeInsets.all(12)),
                                child: const Text(
                                  'Decrement',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.reset();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pink,
                                    padding: EdgeInsets.all(12)),
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        // <-- ElevatedButton
                        onPressed: () {
                          //go to result page
                          navigateToResultPage(
                              context, state, int.parse(inputNumber.text), "x");
                        },
                        icon: Icon(Icons.star),
                        label: Text('Multiply'),
                      ),
                      ElevatedButton.icon(
                        // <-- ElevatedButton
                        onPressed: () {
                          //go to result page
                          navigateToResultPage(
                              context, state, int.parse(inputNumber.text), "/");
                        },
                        icon: Icon(Icons.mood_bad),
                        label: Text('Divide'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ScreenArguments {
  final int counter;
  final int inputNumber;
  final String function;

  ScreenArguments(this.counter, this.inputNumber, this.function);
}
