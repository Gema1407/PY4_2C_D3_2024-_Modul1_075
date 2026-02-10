class CounterController {
  int _counter = 0; // Variabel private (Enkapsulasi)
  int _step = 1;
  final List<String> _activityLogs = [];

  int get value => _counter; // Getter untuk akses data
  int get step => _step; // Getter untuk step
  List<String> get activityLogs => _activityLogs;

  void setStep(int newStep) {
    _step = newStep;
  }

  void _addLog(String type, int value) {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');

    String message;
    if (type == 'increment') {
      message = 'User menambahkan nilai sebesar $value pada jam $hour.$minute';
    } else if (type == 'decrement') {
      message = 'User mengurangi nilai sebesar $value pada jam $hour.$minute';
    } else {
      message = 'User mereset nilai menjadi 0 pada jam $hour.$minute';
    }

    _activityLogs.add(message);
  }

  void increment() {
    _counter += _step;
    _addLog('increment', _step);
  }

  void decrement() {
    int decrementValue = _step;
    if (_counter >= _step) {
      _counter -= _step;
    } else {
      decrementValue = _counter;
      _counter = 0;
    }
    _addLog('decrement', decrementValue);
  }

  void reset() {
    _counter = 0;
    _addLog('reset', 0);
  }
}
