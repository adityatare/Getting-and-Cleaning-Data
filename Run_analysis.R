## R Assignment Getting and Cleaning Data 
2 ## Project files 
3  
4 require(plyr) 
5 # Directories and files 
6 uci_hard_dir <- "UCI\ HAR\ Dataset" 
7 feature_file <- paste(uci_hard_dir, "/features.txt", sep = "") 
8 activity_labels_file <- paste(uci_hard_dir, "/activity_labels.txt", sep = "") 
9 x_train_file <- paste(uci_hard_dir, "/train/X_train.txt", sep = "") 
10 y_train_file <- paste(uci_hard_dir, "/train/y_train.txt", sep = "") 
11 subject_train_file <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "") 
12 x_test_file  <- paste(uci_hard_dir, "/test/X_test.txt", sep = "") 
13 y_test_file  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "") 
14 subject_test_file <- paste(uci_hard_dir, "/test/subject_test.txt", sep = "") 
15  
16 # Load raw data 
17 features <- read.table(feature_file, colClasses = c("character")) 
18 activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity")) 
19 x_train <- read.table(x_train_file) 
20 y_train <- read.table(y_train_file) 
21 subject_train <- read.table(subject_train_file) 
22 x_test <- read.table(x_test_file) 
23 y_test <- read.table(y_test_file) 
24 subject_test <- read.table(subject_test_file) 
25  
26 # 1. Merges the training and the test sets to create one data set. 
27 # Binding sensor data 
28 training_sensor_data <- cbind(cbind(x_train, subject_train), y_train) 
29 test_sensor_data <- cbind(cbind(x_test, subject_test), y_test) 
30 sensor_data <- rbind(training_sensor_data, test_sensor_data) 
31  
32 # Label columns 
33 sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2] 
34 names(sensor_data) <- sensor_labels 
35  
36 # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
37 sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))] 
38  
39 # 3. Uses descriptive activity names to name the activities in the data set 
40 sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first") 
41 sensor_data_mean_std <- sensor_data_mean_std[,-1] 
42  
43 # 4. Appropriately labels the data set with descriptive names. 
44 # Remove parentheses 
45 names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE) 
46 # Make syntactically valid names 
47 names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std)) 
48 # Make clearer names 
49 names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std)) 
50 names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std)) 
51 names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std)) 
52 names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std)) 
53 names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std)) 
54 names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std)) 
55 names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std)) 
56 names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std)) 
57 names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std)) 
58 names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std)) 
59  
60 # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
61 sensor_avg_by_act_sub = ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean)) 
62 write.table(sensor_avg_by_act_sub, file = "sensor_avg_by_act_sub.txt") 
