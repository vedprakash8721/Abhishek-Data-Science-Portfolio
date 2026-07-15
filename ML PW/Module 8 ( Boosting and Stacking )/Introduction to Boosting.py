"""
Boosting is an ensemble learning technique that combines multiple weak learners (usually small decision trees) to create one strong predictive model.

OR

Build first model on training data and then build second model to rectify the mistake present in the first model. thi procedure continues untill and unless the 
error are minimised or data is correctly predicted.

Train models sequentially (one after another).
Each new model focuses on the mistakes made by the previous model.
Final prediction is made by combining all models' outputs.

A weak learner is a simple model that performs slightly better than random guessing. 
In boosting, many weak learners are combined sequentially to create a strong learner.

"""
