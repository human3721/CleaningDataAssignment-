Data description:

The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and a smartphone was wearing on his/her waist. The smartphones are embedded accelerometer and gyroscope to capture 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

Then, they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise (variables starts with "time"). Similarly, the acceleration signal was then separated into body and gravity acceleration signals (time_body_gyroscope_singnal-XYZ and time_gravity_accelerometer_singnal-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time_body_accelerometer_jerk_signal_magnitude-XYZ and time_body_gyroscope_jerk_signal_magnitude-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (time_body_accelerometer_magnitude, time_gravity_accelerometer_magnitude, time_body_accelerometer_jerk_signal_magnitude, time_body_gyroscope_magnitude, time_body_gyroscope_jerk_signal_magnitude). 

Lastly, a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency_body_accelerometer_singnal-XYZ, frequency_body_accelerometer_jerk_signal-XYZ, frequency_body_gyroscope_singnal-XYZ, frequency_body_accelerometer_jerk_signal, frequency_body_gyroscope_magnitude, frequency_body_gyroscope_jerk_signal_magnitude. (Note the "frequency" to indicate frequency domain signals). 


Procedure:

1. Load data files (features.txt, activity_labels.txt, test/X_test.txt, test/y_test.txt, test/subject_test.txt, train/X_train.txt, train/Y_train.txt, train/subject_train.txt) into the R. 

2. Label the column as different the measurment fetures

3. Add and label subject,activity, and group columns

4. Merges the training and the test sets to create one data set

5. Select the columns with mean() or std() column names + the subject,activity, and group columns to extracts only the measurements on the mean and standard deviation for each measurement

6. Substitute the activity column data with descriptive activity names

6. Describe the feature mesasurement columns with descriptive names

7. Create a tigy dataset which tabulate the mean of each feature mesasurement for each subject and activity combination 

8. Export the final data set and name it "final_mean_table.csv"



End. Thank you for reading my work:)