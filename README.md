# Grip_Clustering_Task3_Decision_Tree
<h1>Prediction using Decision Tree Algorithm<h1>

Tree are envisage naturally as having many branches and many leaves. Analogous to natural trees there is Decision Trees in Machine Learning, have branches, sub trees, nodes and leaves.

**Decision trees uses simple method of classification and diverge into multiple nodes and branches.
Classification can be appreciated as to profiling.
This subdivision from roots leads to creation of nodes, branches and splitting of branches into sub trees. As we can see these are split into multiple child splits.**
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture1.png)
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture2.png)

**Splitting of root node is based on :**
1. Information Gain
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture4.jpg)
2. GINI
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture3.png)
3. Greedy Algorithm
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture5.jpg)
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture6.jpg)
4. Cost Computing of weights
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture10.png)
5. Parsimony Principle and Re-substitution Error
![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture5.jpg)

<h2>With all the splitting and creation of branches and data size is elongated the complexity of trees starts to appear which leads to high variance in Decision Trees which is over fitting of data.<h2>
So the Problems
1. **Tree structure prone to sampling** — While Decision Trees are generally robust to outliers, due to their tendency to over fit, they are prone to sampling errors. If sampled training data is somewhat different than evaluation or scoring data, then Decision Trees tend not to produce great results.
2. **Tree splitting is locally greedy** — At each level, tree looks for binary split such that impurity of tree is reduced by maximum amount. This is a greedy algorithm and achieves local optima. It may be possible, for example, to achieve less than maximum drop in impurity at current level, so as to achieve lowest possible impurity of final tree, but tree splitting algorithm cannot see far beyond the current level. This means that Decision Tree built is typically locally optimal and not globally optimal or best.
3. **Optimal decision tree is NP-complete problem** — Because of number of feature variables, potential number of split points, and large depth of tree, total number of trees from same input datasets is unimaginably humongous. Thus, not only tree splitting is not global, computation of globally optimal tree is also practically impossible.

In this post will go about how to overcome some of these disadvantages in development of Decision Trees.
**To avoid over fitting, Decision Trees are almost always stopped before they reach depth such that each leaf node only contains observations of one class or only one observation point. There are various approaches which can decide when to stop growing the tree.**
1. **When the leaf node is pure node** — If a leaf node happens to be pure node at any stage, then no further downstream tree is grown from that node. Tree can continue to be grown from other leaf nodes.
2. **When the leaf node has very few observations left** — This ensures that we terminate the tree when reliability of further splitting the node becomes suspect due to small sample size. Central Limit Theorem tells us that when observations are mutually independent, then about 30 observations constitute large sample. This can become rough guide, though usually, this user input parameter should be higher than 30, say 50 or 100 or more, because we typically work with multi-dimensional observations and observations could be correlated.
3. **When decrease in impurity of tree is very small** — This user input parameter leads to termination of tree when impurity drops by very small amount, say, 0.001 or lesser.
4. **When sufficient number of leaves are created** — One method of culminating growth of tree is to achieve desired number of leaves — an user input parameter — and then stop. Personally, I find this to be not so good criteria simply because growth of tree is unbalanced and some branch would have nodes of very few observations while others of very large, when stopping condition is met. Also, while it is possible to decide what is small sample size or what is small change in impurity, it’s not usually possible to know what is reasonable number of leaves for given data and business context.
5. **When cross-validation impurity starts to increase** — This is one of complex method, but likely to be more robust as it doesn’t required any assumption on user input. Training data is split into train and cross-validation data, in say 70%-30% proportion. Tree is grown on train data by computing impurity of tree and splitting the tree wherever decrease in impurity is observed. Similar tree is replicated on cross-validation data. Since we are growing tree on train data, its impurity will always decrease, by very definition of process. However, at some point, impurity of cross-validation tree will increase for same split. This is point where we can stop growing the tree since divergence in error (impurity) signals start of over fitting.

<h3>Limitations of Decision Trees:<h3>
1. **Low-Performance**
By ‘performance’ i don’t mean resolution, but execution speed. The reason why it’s poor is that you need to ‘redraw the tree’ every time you wish to update your CART model — data classified by an already-trained Tree, that you then want to add to the Tree (i.e., use as a training data point) requires that you start from over — training instances can not be added incrementally, as they can for most other supervised learning algorithms. Perhaps the best way to state this is that Decision Trees cannot be trained in online mode, rather only in batch mode. Obviously you won’t notice this limitation if you don’t update your classifier, but then i would expect that you see a drop in resolution.
2. This is significant because for Multi-Layer Perceptrons for instance, once it’s trained, then it can begin classifying data; that data can also be used to ‘tune’ the already-trained classifier, though with Decision Trees, you need to retrain with the entire data set (original data used in training plus any new instances).
3. Poor Resolution on Data With Complex Relationships Among the Variables
4. Decision Trees classify by step-wise assessment of a data point of unknown class, one node at time, starting at the root node and ending with a terminal node. And at each node, only two possibilities are possible (left-right), hence there are some variable relationships that Decision Trees just can’t learn.
5. Practically Limited to Classification
6. Decision Trees work best when they are trained to assign a data point to a class — preferably one of only a few possible classes. I don’t believe i have ever had any success using a Decision Tree in regression mode (i.e., continuous output, such as price, or expected lifetime revenue). This is not a formal or inherent limitation but a practical one. Most of the time, Decision Trees are used for prediction of factors or discrete outcomes.
7. Poor Resolution With Continuous Expectation Variables
 ![alt tag](https://github.com/jaikushwaha7/-Grip_Clustering_Task3_Decision_Tree/blob/main/Images/Picture9.png) 

***Again, in principle, it’s ok to have independent variables like “download time” or “number of days since previous online purchase” — just change your splitting criterion to variance (it’s usually Information Entropy or Gini Impurity for discrete variables) but in my experience Decision Trees rarely work well in these instance. Exceptions are cases like “student’s age” which looks continuous but in practice the range of values is quite small (particularly if they are reported as integers).***

<h4>Conclusion:<h4>
There many problems with decision trees but there are solutions also with different kind of CART methods and then there is Random Forest a full baggage of trees and helps selecting the best out the Decision trees.
**However, all these advantages need to be tempered with one key disadvantage of decision trees: without proper pruning or limiting tree growth, they tend to over fit the training data, making them somewhat poor predictors.**
