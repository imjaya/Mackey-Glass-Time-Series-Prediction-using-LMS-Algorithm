# Mackey-Glass-Time-Series-Prediction-using-LMS-Algorithm

1) Run "mackeyglass.m" to generate Mackey Glass Time Series training and test data
 - This code is created by modifying the open source code provided in https://www.mathworks.com/matlabcentral/fileexchange/24390-mackey-glass-time-series-generator
 - The code creates 5000 samples where we will use the first 4000 as training and the last 1000 as the test data

2) Run "Mackey_Glass_Time_Series_LMS" to generate prediction model using LMS approach
 - This code is created by modifying the open source code provided in https://www.mathworks.com/matlabcentral/fileexchange/61017-mackey-glass-time-series-prediction-using-least-mean-square-lms?s_cid=ME_prod_FX
 - The code plots convergence graphs for different learning rates and tap numbers. It also reports the MSE errors for the test data
