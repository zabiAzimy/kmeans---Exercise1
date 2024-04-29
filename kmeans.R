# Working on exercise-1

# required libraries for the task
library(dplyr)
library(mdsr)

# K-means in R - Simulation
# Generating some random data
set.seed(1234567890)

x <- matrix(rnorm(2*50), ncol = 2)

x[1:25,1] <- x[1:25,1] + 2
x[1:25,2] <- x[1:25,2] - 2


plot(x, pch=16, asp = 1)
# The asp arg here - y/x aspect ratio of the axis


# Running the above code with two clusters
km.out <- kmeans(x, centers = 2, nstart = 1)

# we can now access the attributes of km.out object
km.out$cluster
names(km.out)
# Total sum of squares without clustering
km.out$totss

# Sum of squares within each cluster
km.out$tot.withinss

# Finding the coordinates of the centers of the clusters
km.out$centers

# let's plot the points - giving a color for each cluster
plot(x, pch=16, asp = 1, col=km.out$cluster)
# let's also plot the center points on the existing plot
points(km.out$centers, col=1:2, pch=3, cex=2)

# In the above code, we have specified 1 for nstart - but that is too low

# ideally we run the algorithm multiple time to find the best cluster centers
# Now running it 20 times
km.out <- kmeans(x, centers = 2, nstart = 20)

# Visualizing the clusters
plot(x, pch=16, asp = 1, col=km.out$cluster)
points(km.out$centers, col=1:2, pch=3, cex=2)

# Accessing the statistics for km.out objects
km.out$tot.withinss



# We are now trying to force the data to have three clusters
km.out <- kmeans(x, centers = 3, nstart = 20)
plot(x, pch=16, asp = 1, col=km.out$cluster)
km.out$tot.withinss


# continuing to increase the number of clusters
# 4 clusters
km.out <- kmeans(x, centers = 4, nstart = 20)
plot(x, col = km.out$cluster, pch = 16, asp = 1)
km.out$tot.withinss


# we are now generating new data - with three clusters
# data generation
x <- matrix(rnorm(50*3), ncol = 2)
x[1:25, 1] <- x[1:25, 1] + 2
x[1:25, 2] <- x[1:25, 2] - 2
x[50+1:25, 1] <- x[50 + 1:25, 1] + 2
x[50+1:25, 2] <- x[50 + 1:25, 2] + 2

# clustering
km.out <- kmeans(x, centers = 3, nstart = 20)

# visualisation
plot(x, col = km.out$cluster, pch = 16, asp = 1)
points(km.out$centers, col = 1:3, pch = 3, cex = 2)

# we are now working with some real data - world_cities
data("world_cities")

# doing some exploratory analysis to out data
str(world_cities)
summary(world_cities)

# running the kmeans algorithm on the entire dataset
km.out <- kmeans(world_cities, centers = 7, nstart = 20)

plot(world_cities$longitude, world_cities$latitude, col = km.out$cluster,
       pch=16, asp=1)

# we want to take only the cities with at least 200.000 inhabitants
# For them, we take the latitude and longitude - Thus two columns
# after getting help from chatgpt - I write the following code as:
big_cities <- world_cities %>%
              filter(population >= 200000) %>%
              select(longitude, latitude)
big_cities

# Running kmeans clustering algorithm on big_cities with 7 clusters
km.out <- kmeans(big_cities, centers = 7, nstart = 30)

# plotting 
plot(big_cities, pch=16, col=km.out$cluster)







