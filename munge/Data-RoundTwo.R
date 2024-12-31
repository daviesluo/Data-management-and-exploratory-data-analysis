###Round two: Where to improve the course quality based on feedbacks

##Data preparation - Merging data from last 4 runs using "id"
merge_survey_data <- function(archetype, leaving, weekly_sentiment) {
  merged <- archetype %>%
    full_join(leaving, by = 'id', suffix = c("_archetype", "_leaving")) %>%
    full_join(weekly_sentiment, by = 'id', suffix = c("_archetype", "_weekly"))
  
  return(merged)
}

check_and_convert_id <- function(df) {
  if (!is.character(df$id)) {
    df$id <- as.character(df$id)
  }
  return(df)
}

# Loop to merge survey datasets for each run
combined_survey_data <- list()

for (i in 4:7) {
  # Retrieve data frames for each run
  archetype <- get(paste0("cyber.security.", i, "_archetype.survey.responses"))
  leaving <- get(paste0("cyber.security.", i, "_leaving.survey.responses"))
  weekly_sentiment <- get(paste0("cyber.security.", i, "_weekly.sentiment.survey.responses"))
  
  # Merge the data frames for the current run
  merged_run_data <- merge_survey_data(archetype, leaving, weekly_sentiment)
  merged_run_data$run_number <- as.factor(i)  # Add run number as a factor
  
  combined_survey_data[[i - 3]] <- merged_run_data  # Append to list, adjusting index for the range starting at 4
}

# Combine all run survey data into a single dataframe
combined_survey_data <- bind_rows(combined_survey_data, .id = "run_number")

## Calculate the proportions for each archetype within each run
archetype_proportions <- combined_survey_data %>%
  filter(!is.na(archetype)) %>%
  group_by(run_number, archetype) %>%
  summarise(count = n(), .groups = 'drop') %>%
  ungroup() %>%
  group_by(run_number) %>%
  mutate(proportion = count / sum(count) * 100)

## Calculate the summary of leaving reasons
leaving_reason_counts <- combined_survey_data %>%
  filter(!is.na(leaving_reason)) %>%
  group_by(leaving_reason) %>%
  summarise(count = n(), .groups = 'drop') %>%
  arrange(desc(count))

## Preparing data for the Word cloud of user experience survey
# Remove common stopwords
data(stop_words)

# custom stopwords specific to dataset
custom_stop_words <- bind_rows(tibble(word = c("week", "cyber", "security"), lexicon = c("custom")), stop_words)

## Prepare the text data
words <- combined_survey_data %>%
  filter(!is.na(reason)) %>%
  unnest_tokens(word, reason) %>%
  anti_join(custom_stop_words, by = "word") %>%
  count(word, sort = TRUE)

