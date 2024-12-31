## Plot the proportions for each archetype within each run
#Stacked bar chart
archetype_barchart <- ggplot(archetype_proportions, aes(x = run_number, y = proportion, fill = archetype)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(title = "Proportion of Archetypes in Runs 4-7",
       x = "Run Number",
       y = "Proportion (%)") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()

#Line plot
archetype_lineplot <- ggplot(archetype_proportions, aes(x = run_number, y = proportion, group = archetype, color = archetype)) +
  geom_line() +
  geom_point() +
  labs(title = "Trend of Archetype Proportions Across Runs 4-7",
       x = "Run Number",
       y = "Proportion (%)") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")

#Faceted plot
archetype_facetedplot <- ggplot(archetype_proportions, aes(x = run_number, y = proportion, fill = archetype)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ archetype) +
  labs(title = "Distribution of Archetypes Across Runs 4-7",
       x = "Run Number",
       y = "Proportion (%)") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")

## Plot the summary of leaving reasons
#Ordered dot plot
leaving_reasons <- ggplot(leaving_reason_counts, aes(x = count, y = reorder(leaving_reason, -count))) +
  geom_point(stat = "identity", size = 4, aes(color = leaving_reason)) +
  labs(title = "Ranking of Reasons for Leaving the Course",
       x = "Count",
       y = "Reason for Leaving") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_color_brewer(palette = "Set1")

## Plot the Word cloud of user experience survey (Directly put in R markdown as word cloud cannot be assigned to a variable)
#wordcloud(words = words$word, freq = words$n, max.words = 100, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

