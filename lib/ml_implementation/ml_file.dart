
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;


Future<FirebaseCustomModel> loadModel() async {
    final customModel = await FirebaseModelDownloader.instance.getModel(
      "anomaly_detector", // Replace with your actual model name
      FirebaseModelDownloadType.latestModel, // Ensure latest version
    ); // Removed conditional parameter (not supported in current version)

    // Download complete. You can now use the model for inference.
    final localModelPath = customModel.file;

    return customModel; // Return the loaded model instance
}


// Future<void> processData(FirebaseCustomModel model, List<double> dataRow) async {
//   // Assuming your model expects a single input tensor
//   final inputTensor = Tensor.fromList(dataRow);
//
//   // Create a FirebaseModelInterpreter instance
//   final interpreter = await tfl.Interpreter.fromAsset(assetName);
//   // Prepare interpreter options (optional)
//   final interpreterOptions = FirebaseModelInterpreterOptions(threads: 2);
//
//   // Run inference on the input data
//   final List<Object> outputData = List(model.outputDataType.length);
//   await interpreter.run(inputTensor, outputData, options: interpreterOptions);
//
//   // Process and print the output data based on your model's output type
//   if (model.outputDataType == FirebaseModelDataType.FLOAT32) {
//     final outputList = outputData.cast<double>();
//     print("Model output: ${outputList.join(', ')}");
//   } else {
//     // Handle other output data types (e.g., int32, string)
//     print("Unsupported output data type: ${model.outputDataType}");
//   }
// }


// Future<int> processData(List<double> row) async {
//
//   print('Reached here');
//   // Create a FirebaseModelInterpreter instance
//   final interpreter = await tfl.Interpreter.fromAsset('lib/assets/model_anonymoos.tflite');
//
//   // List<double> input = [[2.37,115.06,36.34]];
//
//   List<double> input = [row[0], row[1], row[2]];
//
//   print(input);
//
//
//   // input[0] = row[4];
//   // input[1] = row[0];
//   // input[2] = row[2];
//
//   var output = List.filled(1, 1).reshape([1,1]);
//
//   interpreter.run(input, output);
//
//
//   int label = (output[0][0] > 0.5) ? 1 : 0;
//
//
//   print(output);
//   print(label);
//
//   interpreter.close();
//
//   return label;
// }

Future<int> processData(Map<String, double>? healthData) async {

  print('Reached here');
  // Create a FirebaseModelInterpreter instance
  final interpreter = await tfl.Interpreter.fromAsset('lib/assets/model_anonymoos.tflite');

  // List<double> input = [[2.37,115.06,36.34]];

  List<double?> input = [healthData?['eda'], healthData?['heart_rate'], healthData?['temp']];

  print(input);


  // input[0] = row[4];
  // input[1] = row[0];
  // input[2] = row[2];

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

  // List predictedLabels = output.map((prediction) {
  //   return prediction.reduce((double a, double b) => a < b ? a : b).round();
  // }).toList();

  // Usage:
  List<double> predictions = convertToDoubleList(output);

  // List<double> predictions = List<double>.from(output);
  // List<double> predictions = [3.9709544598280563e-19, 1.6820277437545883e-7, 0.00040524889482185245, 0.02080192044377327, 0.9787926077842712];
  print(predictions);

  int predictedLabel = argmax(predictions);
  print(predictedLabel);


  interpreter.close();

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

