# OCR-for-Primary-School-English-Composition (Final Project)

## Definition of problem being solved

How to recognize images of indeterminate length text and transform them into texts output using deep learning?

The image and text datasets were segmented by python, and the image and text segmentation was split by row for training. Training segmentation data via tensorflow, saving the trained tensorflow model in pb format. Converting pb formats to CoreML-acceptable formats (.mlmodel) using coremltools. Xcode automatically generates the swift wrapper classes and the app can easily use the trained model through the API provided by Core ML. The recognition output is submitted to the Tencent Cloud ECC API via a POST request for scoring and returning the results to the local database.

![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/app-workflow.png)

## Documentation of experiments and results
The OCR model consists of a convolutional layer composed of four convolutional layers, a recurrent later composed of bidirectional LSTM, and a transcription layer composed of connectionist temporal classification. The CNN is used to extract the convolutional feature maps of the input image, the recurrent network layer is a deep bi-directional LSTM network that continues to extract the text sequence features based on the convolutional features,CTC proposes a method for calculating the Loss without alignment, which is used as the loss function of the training process.

![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/model-workflow.png)
CNN consists of four convolutional layers and three pooling layers. The convolutional layers perform feature extraction on the image, the activation function is used to add nonlinear factors to enhance the expressiveness of the linear model, and the pooling layers compress the input feature map to make the feature map smaller and simplify the computational complexity of the network on the one hand; on the other hand, feature compression is performed to extract the main features.
The RNN layer consists of a BiLSTM, which is a combination of a forward LSTM and a backward LSTM. Both are often utilised to model contextual information in natural language processing tasks. The BiLSTM allows better capture of bidirectional semantic dependencies.
CTC is a loss function. The traditional training criterion for neural networks is for each frame of data, i.e., the training error is minimized for each frame of data, while the training criterion for CTC is sequence-based. The CTC allows the neural network to predict the label at any slice as long as the sequence order of the output is correct.

The learning rate was adjusted to 0.01, 0.001, and 0.0001 respectively, and the loss and accuracy rate during the training were observed, the training results are shown in the following figure：
![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/experiment.png)

Since there are only about 1000 sets of data in the training set, when the learning rate is large, the network converges to the local optimal point and cannot be fitted well, so epoch=10, learning rate=0.0001 was chosen finally.

The application can take a picture of the composition by calling the phone camera, and then the image will be sent to Tencent Cloud for scoring by OCR, and then returned to local.
![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/result.png)

## Critical reflection and learning from experiments
This project did not find enough data sets to train the model. The author believes that it is not a problem with the model, because there has been previous work that has trained an excellent ocr model based on CNN+BiLSTM+CTC framework. It is a good extension if there is enough dataset to supplement the model. In addition, there is room for further improvement in the way the application interacts. For example, students can take pictures and upload them using the student's client, and after grading, the system score with text information is displayed on the teacher's terminal, and the results are stored by the teacher's score. Multi-terminal communication can clarify user needs and reduce unnecessary entering work for the teacher.
