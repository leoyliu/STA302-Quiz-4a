# Set the seed for reproducibility
set.seed(123)

# Generate true heights
true_heights <- rnorm(20, mean = 170, sd = 10)

# Simulate measurements with different errors
edward_measurements <- true_heights + rnorm(20, mean = 0, sd = 1)
hugo_measurements <- true_heights + rnorm(20, mean = 0, sd = 2)
lucy_measurements <- true_heights + rnorm(20, mean = 0, sd = 1.5)

# Combine the measurements into a data frame
measurements <- data.frame(
  Friends = 1:20,
  Edward = edward_measurements,
  Hugo = hugo_measurements,
  Lucy = lucy_measurements
)

# Test 1: Verify the number of measurements
test_number_of_measurements <- length(edward_measurements) == 20 && 
  length(hugo_measurements) == 20 && 
  length(lucy_measurements) == 20

# Test 2: Check for missing values
test_no_missing_values <- all(complete.cases(edward_measurements, hugo_measurements, lucy_measurements))

# Test 3: Ensure measurements are within expected limits (e.g., 140 cm to 210 cm)
test_measurements_range <- all(edward_measurements >= 140 & edward_measurements <= 210) &&
  all(hugo_measurements >= 140 & hugo_measurements <= 210) &&
  all(lucy_measurements >= 140 & lucy_measurements <= 210)

# Print the results
results <- list(
  test_number_of_measurements = test_number_of_measurements,
  test_no_missing_values = test_no_missing_values,
  test_measurements_range = test_measurements_range
)

print(results)

# Using ggplot2 to create a scatter plot
# install.packages("ggplot2")
# install.packages("tidyr")
library(ggplot2)
library(tidyr)

measurements_reshape <- gather(measurements, key = "Measured_by", value = "Measurement", -Friends)

# Create the scatter plot
ggplot(measurements_reshape, aes(x = Friends, y = Measurement, color = Measured_by)) +
  geom_point() +
  theme_minimal() +
  labs(
    title = "Heights Measured by Edward, Hugo, and Lucy",
    x = "Friends",
    y = "Measured Height (cm)",
    color = "Measurer") +
  theme(legend.title = element_blank())