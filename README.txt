The scripts run inside the folder UCI HAR Dataset created once unzip files:
The script "tidy_script.R" :
  - Load X_train and X_test data
  - Load labels from activities
  - Extract only mean and std features from X_train and X_test
  - Add, subject and activitys as factors
  - Merge teh data
  - From merge data creates a tidy dataset from mean of each activity and each subject
  - Save de last dataset in "tudy_data.txt"
