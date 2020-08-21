# A-Fuzzy-Universum-Support-Vector-Machine-Based-on-Information-Entropy

This is implementation of the paper: B. Richhariya, M. Tanveer (2019) A Fuzzy Universum Support Vector Machine Based on Information Entropy. In: Tanveer M., Pachori R. (eds) Machine Intelligence and Signal Analysis. Advances in Intelligent Systems and Computing, vol 748. Springer, Singapore. https://doi.org/10.1007/978-981-13-0923-6_49.

Description of files:

main.m: selecting parameters of FUTSVM using k fold cross-validation. One can select parameters c, mu and e to be used in grid-search method.

test_train.m: implementation of FUTSVM algorithm. Takes parameters c, mu, e, and training data and test data, and provides accuracy obtained and running time.

fuzzyu.m: generates the fuzzy membership values.

For quickly obtaining the results of the FUTSVM algorithm, we have made a newd folder containing a sample dataset. One can simply run the main.m file to check the obtained results on this sample dataset. To run experiments on more datasets, simply add datasets in the newd folder and run main.m file. The code has been tested on Windows 10 with MATLAB R2017a.

This code is for non-commercial and academic use only. Please cite the following paper if you are using this code.

Reference: B. Richhariya, M. Tanveer (2019) A Fuzzy Universum Support Vector Machine Based on Information Entropy. In: Tanveer M., Pachori R. (eds) Machine Intelligence and Signal Analysis. Advances in Intelligent Systems and Computing, vol 748. Springer, Singapore. https://doi.org/10.1007/978-981-13-0923-6_49.

For further details regarding working of algorithm, please refer to the paper.

If further information is required you may contact on: phd1701241001@iiti.ac.in.
