
## CART Model on IRIS Data
## Three species of iris flower setosa, versicolor, virginica
View(iris)

## install.packages("rpart")
## install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

table(iris$Species)

## Sampling code
set.seed(1212)
s <- sample(c(1:150), size = 100)
iris.train <- iris[s,]
iris.test <- iris[-s,]
nrow(iris.train)
nrow(iris.test)

table(iris.train$Species)
m1 <- rpart(Species ~ ., 
            data = iris.train, 
            method = "class")
m1
View(iris.test)
rpart.plot(m1)
iris.test$Predict <- predict(m1, 
                             iris.test, 
                             type = "class")
View(iris.test)
table(iris.test$Species, 
      iris.test$Predict)



## Unbalanced Dataset
## Let us first set the working directory path

setwd("D:/Study/Great Lakes/Data Mining/Classification_Tree")
getwd()

## Data Import
CTDF.dev <- read.table("DEV_SAMPLE.csv", sep = ",", header = T)
CTDF.holdout <- read.table("HOLDOUT_SAMPLE.csv", sep = ",", header = T)
c(nrow(CTDF.dev), nrow(CTDF.holdout))

View(CTDF.dev)

## installing rpart package for CART
## install.packages("rpart")
## install.packages("rpart.plot")


## loading the library
library(rpart)
library(rpart.plot)

table(CTDF.dev$Target)

## Target Rate 
sum(CTDF.dev$Target)/14000

?rpart.control
## setting the control paramter inputs for rpart
r.ctrl = rpart.control(minsplit=30, minbucket = 10, cp = 0, xval = 10)  ## cp cost complexity parameter


## calling the rpart function to build the tree
##m1 <- rpart(formula = Target ~ ., data = CTDF.dev[which(CTDF.dev$Holding_Period>10),-1], method = "class", control = r.ctrl)
m1 <- rpart(formula = Target ~ ., 
            data = CTDF.dev[,-1], method = "class", 
            control = r.ctrl)
m1
rpart.plot(m1)
CTDF.dev$predict.score <- predict(m1, CTDF.dev, type="prob")

## Plot the tree
## install.packages("rattle")
## install.packages("RColorBrewer")
library(rattle)
##install.packages
library(RColorBrewer)
fancyRpartPlot(m1)

## Quick Model Performance Check (before pruning)
CTDF.dev$predict.class <- predict(m1, CTDF.dev, type="class")
with(CTDF.dev, table(Target, predict.class))

1-(152+910)/14000

install.packages("MLmetrics")
library(MLmetrics)
MLmetrics::AUC(CTDF.dev$predict.score[,2], 
               CTDF.dev$Target)
class(CTDF.dev$predict.score)

CTDF.holdout$predict.score <- predict(m1, 
                                      CTDF.holdout, type="prob")
MLmetrics::AUC(CTDF.holdout$predict.score[,2], 
               CTDF.holdout$Target)



## to find how the tree performs
printcp(m1)


##rattle()
## Pruning Code
ptree<- prune(m1, cp= 0.0029 ,"CP")
printcp(ptree)
fancyRpartPlot(ptree, uniform=TRUE,  main="Pruned Classification Tree")


## Let's use rattle to see various model evaluation measures
##rattle()

View(CTDF.dev)

## Model Performance Measures after pruning
CTDF.dev$predict.class <- predict(ptree, CTDF.dev, type="class")
CTDF.dev$predict.score <- predict(ptree, CTDF.dev, type="prob")
MLmetrics::AUC(CTDF.dev$predict.score[,2], 
               CTDF.dev$Target)

CTDF.holdout$predict.score <- predict(ptree, CTDF.holdout, type="prob")
MLmetrics::AUC(CTDF.holdout$predict.score[,2], 
               CTDF.holdout$Target)



## Syntax to get the node path
tree.path <- path.rpart(ptree, node = c(2, 12))

