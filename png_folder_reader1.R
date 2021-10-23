library(tesseract)
full.text1 <- NULL
for(i1 in 1:1000){
  current.text1 <- tesseract::ocr(paste("Logs2019OCR_", i, ".png", sep=""))
  full.text1 <- paste(full.text1,current.text1)
}
sink(file="full.text1.txt")
full.text1
sink()
