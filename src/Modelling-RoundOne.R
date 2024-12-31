## Plot the trend of enrollment number
#Line plot
enrollment_lineplot <- ggplot(enrollment_trend, aes(x = run_number, y = enrollments)) +
  geom_line(group=1, color="blue") +
  geom_point(size=2, color="red") +
  labs(x = "Run Number",
       y = "Number of Enrollments") +
  theme_minimal()

## Plot the trend of gender equality
#Stacked percentafe bar chart
gender_barchart <- ggplot(gender_percentages, aes(x = factor(run_number), y = percentage, fill = gender)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(x = "Run Number",
       y = "Percentage") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")

#Line plot
gender_lineplot <- ggplot(gender_percentages, aes(x = run_number, y = percentage, color = gender, group = gender)) +
  geom_line() +
  geom_point() +
  labs(x = "Run Number",
       y = "Percentage") +
  theme_minimal() +
  scale_color_manual(values = c("male" = "blue", "female" = "pink", "unknown" = "grey"))


## Plot the trend of correct responses
#Line plot
question_lineplot <- ggplot(correct_proportion_by_run, aes(x = run_number, y = proportion_correct)) +
  geom_line() +
  geom_point() +
  labs(x = "Run Number",
       y = "Proportion Correct") +
  theme_minimal()

#Bar chart
question_barchart <- ggplot(correct_proportion_by_run, aes(x = factor(run_number), y = proportion_correct)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  labs(x = "Run Number",
       y = "Proportion Correct") +
  theme_minimal()

#Smooth line plot
question_smootheslineplot <- ggplot(correct_proportion_by_run, aes(x = run_number, y = proportion_correct)) +
  geom_line() +
  geom_smooth(method = "loess") +
  labs(x = "Run Number",
       y = "Proportion Correct") +
  theme_minimal()

## Plot the trend of step finishing time for each run
#Line plot
finishing_time <- ggplot(average_time_data, aes(x = run_number, y = average_time, group = step, color = step)) +
  geom_line() +
  geom_point() +
  labs(x = "Run Number",
       y = "Average Time (hours)") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")

## Plot the completion rate for each run
#Bar chart
completion_rate <- ggplot(average_time_data, aes(x = run_number, y = completion_percentage, group = step, fill = step)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(x = "Run Number",
       y = "Completion Percentage (%)") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")


