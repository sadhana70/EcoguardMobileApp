import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_face_detection/logic/bloc/face_detection_bloc.dart';

class ForestActivityDetection extends StatefulWidget {
  const ForestActivityDetection({super.key});

  @override
  State<ForestActivityDetection> createState() => _ForestActivityDetectionState();
}

class _ForestActivityDetectionState extends State<ForestActivityDetection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaceDetectionBloc, FaceDetectionState>(
      builder: (context, state) {
        if (state is FaceDetectionInitial) {
          BlocProvider.of<FaceDetectionBloc>(context)
              .add(const FaceDetectionInitialEvent());

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is FaceDetectionReady) {
          // Determine the color and message based on the number of suspects
          Color textColor = state.faces.isEmpty ? Colors.green : Colors.red;
          Text(
  state.faces.isEmpty
      ? "Suspects detected: 0"
      : "Alert sent! Suspects detected: ${state.faces.length}",
  style: TextStyle(color: textColor, fontSize: 16),);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[700],
              title: const Text('Forest Activity Detection'),
            ),
            body: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      state.image == null
                          ? Container(
                              width: double.infinity,
                              height: 300,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.forest_outlined, size: 100),
                            )
                          : Image.file(
                              state.image!,
                              height: 300,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<FaceDetectionBloc>(context)
                              .add(const FaceDetectionCameraEvent());
                          
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text("Start Forest Monitoring",
                                  style: TextStyle(color: Colors.white, fontSize: 16))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<FaceDetectionBloc>(context)
                              .add(const FaceDetectionGalleryEvent());
                        
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "Choose Image from Gallery",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          "Suspects detected: ",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18, // Increased font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "approx.${state.faces.length}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 58, 1, 1),
                            fontSize: 18, // Increased font size
                            
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Conditionally show the "alert sent" message
                    if (state.faces.isNotEmpty)
                      Text(
                        "Alert sent!",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                      
                    
                  )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
