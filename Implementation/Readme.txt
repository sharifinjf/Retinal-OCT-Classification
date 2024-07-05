In the name of ALLAH

1) First, Train data should be prepared by running the "Main_ROCC_Per_B_Scan.m". This script produces "FeatureVector_HOG.mat"
2) Second, Validation data should be prepared by running the "Main_ROCC_Per_B_Scan_Valid.m". This script produces "FeatureVector_Valid_HOG.mat"
3) Third, Test data should be prepared by running the "Main_ROCC_Per_B_Scan_Test.m". This script produces "FeatureVector_Test_HOG.mat"
4) Finally, the "Main_ROCC_Per_B_Scan_Classification" (Train=15,Test=15)
			 or "Main_ROCC_Per_B_Scan_Classification_Valid" (Train=30,Test=10)
			 or "Main_ROCC_Per_B_Scan_Classification_Test" (Train=30,Test=???)
			 should be run. 