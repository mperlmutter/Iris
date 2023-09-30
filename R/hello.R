# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'
```{r}
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(datasets)
library(h2o)
h2o.init()
iris.hex <- as.h2o(iris)
h2o.ls()
r_df <- as.data.frame(iris.hex)
```
```{r Explore dataframe graphically}

ggplot(data=r_df, aes(x= Sepal.Length))+
  geom_histogram(binwidth=0.1, fill="blue", color="black")+
  labs(title="Histogram Plot", x="Sepal Length", y="Frequency")


ggplot(data=r_df, aes(x= Sepal.Width))+
  geom_histogram(binwidth=0.1, fill="blue", color="black")+
  labs(title="Histogram Plot", x="Sepal Width", y="Frequency")

ggplot(data=r_df, aes(x= Petal.Length))+
  geom_histogram(binwidth=0.1, fill="blue", color="black")+
  labs(title="Histogram Plot", x="Petal Length", y="Frequency")

ggplot(data=r_df, aes(x= Petal.Width))+
  geom_histogram(binwidth=0.1, fill="blue", color="black")+
  labs(title="Histogram Plot", x="Petal Width", y="Frequency")



```











```{r Split Iris Data}
splits <- h2o.splitFrame(data = iris.hex,
                         ratios = c(0.8),  #partition data into 80% and 20% chunks
                         seed = 198)

train <- splits[[1]]
test <- splits[[2]]

print(paste0("Number of rows in train set: ", h2o.nrow(train)))
## [1] "Number of rows in train set: 117"
print(paste0("Number of rows in test set: ", h2o.nrow(test)))
## [1] "Number of rows in test set: 33"
```

```{r Train Random Forest}
rf <- h2o.randomForest(x = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                       y = c("Species"),
                       training_frame = train,
                       model_id = "our.randforest",
                       seed = 1234)

print(rf)

```
```{r Test the Model}
rf_perf1 <- h2o.performance(model = rf, newdata=test)


print(rf_perf1)







```


```{r Test Random Forest Model}

predictions <- h2o.predict(rf, test)
print(predictions)




```




