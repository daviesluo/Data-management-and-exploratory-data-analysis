# FutureLearn Cyber Security MOOC Analysis (CSC8631)

A comprehensive learning analytics project analysing data from Newcastle University's "Cyber Security: Safety At Home, Online, and in Life" MOOC offered through FutureLearn. The analysis employs the CRISP-DM methodology across two cycles to investigate learner engagement, course effectiveness, and potential areas for improvement.

## Project Overview
- Analysis of learner behavior and course performance across 7 course runs
- Implementation of CRISP-DM methodology in two cycles
- Investigation of enrollment trends, learner demographics, and engagement patterns
- Qualitative analysis of learner feedback and course satisfaction
- Development of actionable insights for course improvement

## Key Features
- Data preprocessing and exploratory analysis
- Multiple analytical approaches:
  - Enrollment trend analysis
  - Gender equality analysis
  - Quiz performance evaluation
  - Step completion analysis
  - Learner archetype analysis
  - Sentiment analysis
  - Reasons for course discontinuation
- Comprehensive data visualization
- Integration of quantitative and qualitative insights

## Repository Structure
### Data Processing
- `data/`: Contains FutureLearn raw data files
- `munge/`: Data preprocessing scripts
  - `Data-RoundOne.R`: First CRISP-DM cycle data preparation
  - `Data-RoundTwo.R`: Second CRISP-DM cycle data preparation
- `cache/`: Cached preprocessed data

### Analysis and Visualisation
- `src/`: Analysis scripts
  - `Modelling-RoundOne.R`: First cycle modelling and visualization
  - `Modelling-RoundTwo.R`: Second cycle modelling and visualization

### Documentation
- `reports/`: Analysis documentation
  - `Analysis Report.Rmd`: R Markdown source
  - `Analysis Report.pdf`: Generated report
  - `Presentation slides.pdf`: Project presentation
- `logs/`: Project logs
  - `logs.txt`: Git logs
  - `Reflective Logs.docx`: Project reflection

### Configuration
- `config/`: Project configuration files
  - `global.dcf`: Required R packages

## Technical Stack
### Core Technologies
- R Statistical Software
- RStudio
- R Markdown

### Key R Libraries
- `ProjectTemplate`: Project organization
- `dplyr`: Data manipulation
- `ggplot2`: Data visualization
- `tidyr`: Data tidying
- `lubridate`: Date handling
- `wordcloud`: Text visualization
- `knitr`: Report generation

### Analysis Techniques
- Time series analysis
- Demographic analysis
- Performance metrics
- Text analytics
- Statistical visualization

## Key Findings
### First CRISP-DM Cycle
- Significant enrollment decline after initial run
- Gender participation imbalances
- Stable quiz performance across runs
- Varying step completion patterns

### Second CRISP-DM Cycle
- Evolution of learner archetypes across runs
- Time constraints as primary dropout factor
- Generally positive sentiment toward course content
- Changing learner demographics and needs

## Setup Instructions
1. Clone the repository
2. Install required R packages from `config/global.dcf`
3. Run preprocessing scripts in `munge/` folder
4. Execute analysis scripts in `src/` folder
5. Generate report by compiling `Analysis Report.Rmd`
