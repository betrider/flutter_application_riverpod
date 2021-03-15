import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A Counter example implemented with riverpod
void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specifies how to create a state
final counterProvider = StateProvider((ref) => 0);

final counterProvider2 = StateNotifierProvider<Counter>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter(): super(0);

  void increment() => state++;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        // You could also use the hook "useProvider" if you uses flutter_hooks
        child: Consumer(builder: (context, watch, _) {
          print('consumer');
          final count = watch(counterProvider2.state);
          return Text('$count');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is an utility to read a provider without listening to it
        onPressed: () => context.read(counterProvider2).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/* class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        // You could also use the hook "useProvider" if you uses flutter_hooks
        child: Consumer(builder: (context, watch, _) {
          print('consumer');
          final count = watch(counterProvider).state;
          return Text('$count');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is an utility to read a provider without listening to it
        onPressed: () => context.read(counterProvider).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
} */

/* class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('build');
    final int value = watch(counterProvider).state;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Text(value.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(counterProvider).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
} */