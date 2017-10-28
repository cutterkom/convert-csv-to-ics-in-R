# create an ics-file by iterating over an csv-file. 


# import data on events
source("input/get_data.R")
#df <- read.csv("input/example_data.csv", sep = "\t", stringsAsFactors = F)

# import ics templates
ics_header <- readLines("ics_template/template_header.ics", warn = F)
ics_body <- readLines("ics_template/template_body.ics", warn = F)
ics_footer <- readLines("ics_template/template_footer.ics", warn = F)

# iterate over events and insert events data
ics_events <- ""

for(i in 1:nrow(df)) {

  ics_body <- str_replace(ics_body, "SUMMARY:.*", paste0("SUMMARY:", df$summary[i]))
  ics_body <- str_replace(ics_body, "LOCATION:.*", paste0("LOCATION:", df$location[i]))
  ics_body <- str_replace(ics_body, "DESCRIPTION:.*", paste0("DESCRIPTION:", df$description[i]))
  ics_body <- str_replace(ics_body, "DTSTART:.*", paste0("DTSTART:", df$starttime[i]))
  ics_body <- str_replace(ics_body, "DTEND:.*", paste0("DTEND:", df$endtime[i]))
  # create unique identifier
  ics_body <- str_replace(ics_body, "UID:.*", paste0("UID:", paste0(df$starttime[i], df$endtime[i])))
  ics_events <- append(ics_events, ics_body)
}

# combine template parts to one vector
ics_events <- append(ics_header, ics_events)
ics_events <- append(ics_events, ics_footer)

write(ics_events, file = "output/events.ics")