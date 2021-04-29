# OCR-for-Primary-School-English-Composition (Final Project)

## Definition of problem being solved

How to recognize images of indeterminate length text and transform them into texts output using deep learning?

The image and text datasets were segmented by python, and the image and text segmentation was split by row for training. Training segmentation data via tensorflow, saving the trained tensorflow model in pb format. Converting pb formats to CoreML-acceptable formats (.mlmodel) using coremltools. Xcode automatically generates the swift wrapper classes and the app can easily use the trained model through the API provided by Core ML. The recognition output is submitted to the Tencent Cloud ECC API via a POST request for scoring and returning the results to the local database.

![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/app-workflow.png)

## Documentation of experiments and results
The OCR model consists of a convolutional layer composed of four convolutional layers, a recurrent later composed of bidirectional LSTM, and a transcription layer composed of connectionist temporal classification. The CNN is used to extract the convolutional feature maps of the input image, the recurrent network layer is a deep bi-directional LSTM network that continues to extract the text sequence features based on the convolutional features,CTC proposes a method for calculating the Loss without alignment, which is used as the loss function of the training process.

![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/model-workflow.png)
The learning rate was adjusted to 0.01, 0.001, and 0.0001 respectively, and the loss and accuracy rate during the training were observed, the training results are shown in the following figure：
![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/experiment.png)

Since there are only about 1000 sets of data in the training set, when the learning rate is large, the network converges to the local optimal point and cannot be fitted well, so epoch=10, learning rate=0.0001 was chosen finally.

The application can take a picture of the composition by calling the phone camera, and then the image will be sent to Tencent Cloud for scoring by OCR, and then returned to local.
![image](https://github.com/Hotomoderato/OCR-for-Primary-School-English-Composition/blob/main/Pic/result.png)

## Critical reflection and learning from experiments
This project did not find enough data sets to train the model. The author believes that it is not a problem with the model, because there has been previous work that has trained an excellent ocr model based on CNN+BiLSTM+CTC framework. It is a good extension if there is enough dataset to supplement the model.
