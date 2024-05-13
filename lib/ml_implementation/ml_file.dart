
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:life_saver/arduino-transfer/data_sender.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

int dummy=0;


Future<FirebaseCustomModel> loadModel() async {
    final customModel = await FirebaseModelDownloader.instance.getModel(
      "anomaly_detector", // Replace with your actual model name
      FirebaseModelDownloadType.latestModel, // Ensure latest version
    ); // Removed conditional parameter (not supported in current version)

    // Download complete. You can now use the model for inference.
    final localModelPath = customModel.file;

    return customModel; // Return the loaded model instance
}



Future<int> processData(Map<String, double>? healthData) async {

  print('Reached here');
  // Create a FirebaseModelInterpreter instance
  final interpreter = await tfl.Interpreter.fromAsset('lib/assets/model_anonymoos.tflite');


  List<double?> input = [healthData?['eda'], healthData?['heart_rate'], healthData?['temp']];

  print(input);



  var output = List.filled(1, 1).reshape([1,1]);

  interpreter.run(input, output);

  int label = (output[0][0] > 0.5) ? 1 : 0;


  print(output);
  print(label);

  interpreter.close();

  return label;
}


Future<int> stageData(Map<String, double>? healthData) async {

  print('Reached here');
  // Create a FirebaseModelInterpreter instance
  final interpreter = await tfl.Interpreter.fromAsset('lib/assets/bloodmodel_penicillin_discovered.tflite');

  // var input = [[116.85, 3.71, 58.3, 18.3, 67.01, 29.71]];

  List<double?> input = [healthData?['heart_rate'], healthData?['eda'], healthData?['blood_sys'], healthData?['blood_dys'], healthData?['oxy_sat'], healthData?['temp']];

  var output = List.filled(1*5, 0).reshape([1,5]);

  interpreter.run(input, output);

  print(output);
  // Usage:
  List<double> predictions = convertToDoubleList(output);

  print(predictions);

  int predictedLabel = argmax(predictions);
  print('this is the predicted ${predictedLabel}');
  interpreter.close();

  if(predictedLabel == 1 && predictedLabel != dummy) {
    dummy = predictedLabel;
    print('reached if');
    DataArd().sendCommand('1');
  }else if(predictedLabel == 2 && predictedLabel != dummy) {
    dummy = predictedLabel;
    print('reached if');
    DataArd().sendCommand('2');
  }else if(predictedLabel == 3 && predictedLabel != dummy) {
    dummy = predictedLabel;
    print('reached if 3');
    DataArd().sendCommand('3');
  }else if(predictedLabel == 4 && predictedLabel != dummy) {
    dummy = predictedLabel;
    print('reached if 3');
    DataArd().sendCommand('4');
  }

  return predictedLabel;
}

int argmax(List<double> list) {
  double maxValue = double.negativeInfinity;
  int maxIndex = -1;

  for (int i = 0; i < list.length; i++) {
    if (list[i] > maxValue) {
      maxValue = list[i];
      maxIndex = i;
    }
  }

  return maxIndex;
}

List<double> convertToDoubleList(List<dynamic> dynamicList) {
  List<double> doubleList = [];

  for (var element in dynamicList[0]) {
    // Try to parse each element as a double and add to the new list
     doubleList.add(element.toDouble());
    }
    // You can handle other cases or ignore non-convertible elements based on your need

  return doubleList;
}

