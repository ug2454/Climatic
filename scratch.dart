import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2result = await task2();
  task3(task2result);
}

void task1() {
  String result1 = 'task1 data';
  print('task 1 complete');
}

Future<String> task2() async {
  Duration threeSeconds = Duration(seconds: 3);
  // sleep(threeSeconds);
  String result2;
  await Future.delayed(threeSeconds, () {
    result2 = 'task 2 data';
    print('task 2 complete');
  });
  return result2;
}

void task3(String task2data) {
  String result3 = 'task 3 data';
  print('task 3 complete with $task2data');
}
