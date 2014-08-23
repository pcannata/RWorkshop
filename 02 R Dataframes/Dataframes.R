library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
"Displaying the top few rows of a dataframe:"
head(diamonds)
"Selecting a subset of columns from a dataframe:"
head(subset(diamonds, select = c(carat, cut)))
"Selecting a subset of rows from a dataframe:"
head(subset(diamonds, cut == "Ideal" & price > 5000))
