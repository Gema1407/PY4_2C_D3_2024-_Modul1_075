import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LogBook: Versi SRP")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Total Hitungan:"),
              Text(
                '${_controller.value}',
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 30),
              // Tombol tambah dan kurang
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () => setState(() => _controller.decrement()),
                      icon: const Icon(Icons.remove, color: Colors.white),
                      iconSize: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () => setState(() => _controller.reset()),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      iconSize: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () => setState(() => _controller.increment()),
                      icon: const Icon(Icons.add, color: Colors.white),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Slider untuk step
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      'Step: ${_controller.step}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _controller.step.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: '${_controller.step}',
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _controller.setStep(value.toInt());
                        });
                      },
                    ),
                    const Text(
                      'Pilih step 1 - 10',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
