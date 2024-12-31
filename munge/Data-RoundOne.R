###Round one: Evaluation of the course quality development in 7 years

##Data preparation - Merging data from 7 runs using "learner_id"

# Function to check and convert learner_id types
check_and_convert_learner_id <- function(df) {
  if (is.logical(df$learner_id)) {
    df$learner_id <- as.character(df$learner_id)
  }
  return(df)
}

merge_run_data <- function(archetype, enrolments, leaving, questions, step_activity) {
  merged <- enrolments %>%
    left_join(archetype, by = 'learner_id') %>%
    left_join(leaving, by = 'learner_id') %>%
    full_join(questions, by = 'learner_id', relationship = "many-to-many")
  
  return(merged)
}

# Loop to merge datasets for each run
all_runs_data <- list()

for (i in 1:7) {
  # Retrieve data frames for each run
  archetype <- get(paste0("cyber.security.", i, "_archetype.survey.responses"))
  enrolments <- get(paste0("cyber.security.", i, "_enrolments"))
  leaving <- get(paste0("cyber.security.", i, "_leaving.survey.responses"))
  questions <- get(paste0("cyber.security.", i, "_question.response"))
  step_activity <- get(paste0("cyber.security.", i, "_step.activity"))
  
  # Convert learner_id to character if it's logical
  archetype <- check_and_convert_learner_id(archetype)
  enrolments <- check_and_convert_learner_id(enrolments)
  leaving <- check_and_convert_learner_id(leaving)
  questions <- check_and_convert_learner_id(questions)
  step_activity <- check_and_convert_learner_id(step_activity)
  
  # Merge the data frames for the current run
  merged_run_data <- merge_run_data(archetype, enrolments, leaving, questions, step_activity)
  merged_run_data$run_number <- i  # Add run number
  
  all_runs_data[[i]] <- merged_run_data  # Append to list
}

# Combine all run data into a single dataframe
combined_data <- bind_rows(all_runs_data)

## Calculate the trend of enrollment number
enrollment_trend <- combined_data %>%
  group_by(run_number) %>%
  summarise(enrollments = n_distinct(learner_id))

## Calculate the trend of gender equality
gender_percentages <- combined_data %>%
  group_by(run_number) %>%
  count(gender) %>%
  mutate(percentage = n / sum(n) * 100)

## Calculate the trend of correct responses
combined_data$correct = toupper(combined_data$correct)
combined_data$correct = as.logical(combined_data$correct)
combined_data$correct = as.integer(combined_data$correct)

correct_proportion_by_run <- combined_data %>%
  group_by(run_number) %>%
  summarise(proportion_correct = mean(correct, na.rm = TRUE))

## Calculate the trend of step finishing time and completion percentage for each run
library(lubridate)
process_step_data <- function(step_activity) {
  # Convert date-time columns to POSIXct
  step_activity$first_visited_at <- ymd_hms(step_activity$first_visited_at)
  step_activity$last_completed_at <- ymd_hms(step_activity$last_completed_at)
  
  # Filter for steps "1.1", "2.1", and "3.1"
  steps_of_interest <- step_activity %>%
    filter(step %in% c("1.1", "2.1", "3.1")) %>%
    mutate(
      # Calculate time difference in hours, handling NA values
      time_diff = as.numeric(difftime(last_completed_at, first_visited_at, units = "hours")),
      # Identify if the step was completed
      completed = !is.na(last_completed_at)
    )
  
  return(steps_of_interest)
}

# Apply this function to each step_activity dataset and store them in a list
step_data_processed <- list()
for (i in 1:7) {
  step_activity_var_name <- paste0("cyber.security.", i, "_step.activity")
  step_activity <- get(step_activity_var_name)
  step_data_processed[[i]] <- process_step_data(step_activity)
}

average_times <- lapply(step_data_processed, function(df) {
  df %>%
    group_by(step) %>%
    summarise(
      average_time = mean(time_diff, na.rm = TRUE),
      completion_percentage = sum(completed) / n() * 100
    )
})

# Combine the list into a single data frame
average_time_data <- bind_rows(average_times, .id = "run_number")

# Ensure 'run_number' and 'step' are factors
average_time_data$run_number <- as.factor(average_time_data$run_number)
average_time_data$step <- as.factor(average_time_data$step)

