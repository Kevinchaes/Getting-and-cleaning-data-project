#gradeURL <- "https://s3.amazonaws.com/coursera-uploads/peer-review/616e3e30aefec7876030199ee342a339/tidy_dataset.txt"
#gradeURL <- "https://s3.amazonaws.com/coursera-uploads/peer-review/7acfe9b1a649f12291217747da006798/tidy_data.txt"
#gradeURL  <- "https://s3.amazonaws.com/coursera-uploads/peer-review/6ae1fd730677627c03b9759d62dc1cda/tidy.txt"

download.file(gradeURL, destfile = "grade.txt")
grade <- read.table("grade.txt") #, header = FALSE)
View(grade)
