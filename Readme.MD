## Instructions for Generating Metric Figures
These instructions provide a step-by-step guide for generating metric figures using R.

### Prerequisites
R and RStudio: Ensure that you have R and RStudio installed on your computer.

Required Packages: The code uses several R packages for data manipulation and visualization. Make sure to install the necessary packages by running the following commands in your R session if you haven't already:

````
install.packages("ggplot2")
install.packages("dplyr")
install.packages("readr")
````

### Steps

1. #### Load Metrics Data:

The code begins by loading a metrics dataset from a CSV file. Make sure to replace the file path with the correct path to your data file. The data should be structured with a header row and columns separated by semicolons.

````
metricas <- read.table("<your-path>/0_Model_performance/00_performance_all_models.txt", sep = ";", header = TRUE, dec = ".")
````

2. #### Filter Data:

Next, the code filters the data to include only specific models. You can customize the list of models based on your requirements. The filtered data is stored in metricas2.

````
metricas2 <- filter(metricas, model %in% c("gam", "gau", "gbm", "glm", "max", "mean", "net", "raf", "svm", "esm_gam", "esm_gbm", "esm_max", "esm_net", "raf"))
````

3. #### Generate Violin and Box Plots:

The code then creates three types of plots (Sorensen, TSS, and AUC) for the filtered data using the ggplot2 package. Each plot is saved in a separate variable (Sorensen, TSS, and AUC).
Customize the aesthetics, titles, and other plot settings as needed.

4. #### Combine and Save Plots:

Finally, the code combines the three plots (Sorensen, TSS, and AUC) into a single plot using the / operator.
The combined plot is saved as an image file in the specified directory. Adjust the file path and filename as per your preference.

````
ggsave(plot = , "./Figuras/metrics_reports2.png", dpi = 300, units = "cm", width = 20, height = 12, scale = 1.2)
````

5. #### Run the Code:

Open RStudio, load the script, and run the code. The generated metric figures will be saved in the specified directory.
Please note that this is a general guide, and you should tailor it to your specific dataset and requirements. Make sure the paths and settings in the code are accurate for your setup.