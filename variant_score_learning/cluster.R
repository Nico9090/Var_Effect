#required libraries: tidyverse
#Functions
read_data<-function(file){
  #library() add tidyverse and load
  obj<-read_delim(file)
}

col_min_max<-function(df){ #requires a data frame input
  sel<-readline("Input data column for analysis: ")
  if(!is.numeric(df$sel)){
    print(paste(sel + "is not numeric!"))
  }else{
    mx<-max(df$sel)
    mn<-min(df$sel)
  }
#=========================================================================================================

