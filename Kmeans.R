# Kmeans Clustering of Wine Dataset


library(rattle)
library(NbClust)
library(factoextra)

# import the data set 

data(wine, package = "rattle")
head(wine) #display the first few obs
View(wine)
str(wine)

# Finding the optimum no of clusters 

df <- wine[-1]

df <- scale(df)

library(NbClust)
NbClust(data = df,
              min.nc = 2,
              max.nc = 10,
              method = "kmeans")

library(factoextra)
fviz_nbclust(x = df, FUNcluster = kmeans,method = "wss") 

fviz_nbclust(x = df, FUNcluster = kmeans, method = "silhouette")

model <- kmeans(x = df,centers = 3,nstart = 25)

fviz_cluster(object = model, data = df)

aggregate(df,by=list(cluster = model$cluster),mean)

wine$cluster <- model$cluster

t <- table(wine$Type, model$cluster)

library(flexclust)

randIndex(t)

model$cluster == 1

cluster1 <- as.data.frame(wine[wine$cluster == 1,])
model$size
