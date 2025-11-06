import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

Future<bool> isValidProfilePhoto(String filePath) async {
  //print(filePath);

  try {
    // Load the image
    final inputImage = InputImage.fromFilePath(filePath);

    // Create a face detector
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );

    // Detect faces in the image
    final faces = await faceDetector.processImage(inputImage);

    // Dispose the face detector after use
    await faceDetector.close();

    // Check if any faces were detected
    //print(faces);
    return faces.isNotEmpty;
  } catch (error) {
    // Handle error
    //print('Error detecting faces: $error');
    return false;
  }
}
