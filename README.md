# cydno_female_preference
Datasets, images, videos, and analytical codes for the manuscript entitled "Divergent warning patterns influence male and female mating behaviors in a tropical butterfly"

**Data files:**

jiggins_data.txt: male behavioral data from Jiggins et al. 2001
  - Species: male species (CP: H. cydno; MP: H. melpomene)
  - group: male group number, which was unit of behavioral data recordinig
  - type_experiment: whether the female model was made with dissected wings (real_wing) or paper wings (paper)
  - court_mp: number of total courtships towards the model MP female 
  - court_cp: number of total courtships towards the model CP female

merrill_data.txt: male behavioral data from Merrill et al. 2019
  - species: male species (CP: H. cydno; MP: H. melpomene)
  - ID: unique ID of the male
  - type_experiment: live_female, denoting that the experiments were done using live females
  - court_mp: number of total courtships towards the model MP female 
  - court_cp: number of total courtships towards the model CP female 

chi_data.txt: male behavioral data from the present study
  - species: male species (CP: H. cydno; MP: H. melpomene)
  - ID: unique ID of the male
  - type_experiment: real_wing, denoting that the experiments were done using model females made of dissected wings
  - court_mp: number of total courtships towards the model MP female 
  - court_cp: number of total courtships towards the model CP female

cydno_female_1male.csv: female behavioral data from the one-male, "no-choice" experiments
  - population: population of H. cydno used (Panama or Colombia)
  - design: one_male, denoting that females only encountered one single male in the experiments
  - observation_time: total observation time in minutes. Numbers <= 120 meant that mating occurred during the initial two-hour period
  - female_id: unique ID of the female
  - female_age: age of the female in days
  - male_id: unique ID of the male
  - male_age: age of the male in days
  - treatment: wing coloura treatment that the male received (red or white)
  - total_male_behaviors: total number of courtship behaviours that the male performed
  - response_pos: number of acceptance behaviours that the female performed
  - response_neg: number of rejection behaviours that the female performed
  - mating_latency: minutes from the beginning of the experiment to mating. Experiments in which mating never occurred were assigned a maximum value of 5000.
  - outcome: mating outcome (0: mating did not occur; 1: mating occurred)

female_choice_red_white_males.csv: Data from "two-choice" experiments
  - Date_exp: date when the experiment started (year_month_day)
  - Start_exp: hour at which the experiment started (hour_minute)
  - Mate_date: date when mating occurred (year_month_day or "No mating")
  - Mate time: hour at which mating occurred (hour_minute or "NA")
  - Preference: which male mated with the female (red, white, or NA)
  - White_male_ID: unique ID of the male from the white treatment
  - White_male_age: age of the male in days from the white treatment
  - Red_male_ID: unique ID of the male from the red treatment
  - Red_male_age: age of the male in days from the red treatment
  - Female_ID: unique ID of the female
  - Female_age: age of the female in days
  - Mate duration: minutes from the beginning of the experiment to mating. Experiments in which mating never occurred were recorded as NA.
  - Cage: Number of the experimental cage

**R code:**

stats_for_paper.R: R code for statistical analyses

**Word document:**

cydno paper_Suppl_080123.docx: Supplementart Materials for the paper (Supplementary Methods, Figure, and Tables)

**Raw image files:**

cydno_with_markers.jpg: H. cydno chioneus wings with eight areas painted with eight candidate red Copic markers and the colorless blender marker

cydno_visible.NEF: painted H. cydno chioneus wings and a 40% gray standard photographed with a Baader filter permitting only visible light (400 - 700 nm)

cydno_UV.NEF: painted H. cydno chioneus wings a 40% gray standard photographed with a Baader filter permitting only UV light (320 - 380 nm)

melpomene_visible.NEF: H. melpomene rosina wing and a 40% gray standard photographed with a Baader filter permitting only visible light (400 - 700 nm)

melpomene_UV.NEF: H. melpomene rosina wing and a 40% gray standard photographed with a Baader filter permitting only UV light (320 - 380 nm)

**Sample raw video recordings:** 

There are five videos that represented male preference behaviors from our raw recordings.

approach_linger_away.mov: a male approaches a model female, lingers, and then flies away

approach_then_away.mov: a male approaches a model female and then flies away

away_then_approach.mov: a male changes his flight trajectory to approach the model female

circling_around.mov: a male circles around the model female

hovering.mov: a male hovers over the model female
