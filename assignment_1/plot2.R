## Read data, with ? as NA and date and time as character.
df <-
        read.table(
                "./data/household_power_consumption.txt",
                header = TRUE,
                sep = ';',
                na.strings = '?',
                colClasses = c("character", "character" , rep("numeric", 7))
        )

## Load package lubridate
library(lubridate)

## Convert date and time column to date and time format and add a column with
## date and time combined
df$DateTime <- dmy_hms(paste(df$Date, df$Time))
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)

## setting to use english
Sys.setlocale("LC_TIME", "English")

## subset for dates: 2007-02-01 and 2007-02-02
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
dfsubset <- df[df$Date %in% d1:d2,]

## Open device to save to png-file
dev.copy(png,
         filename = "./data/plot2.png",
         width = 480,
         height = 480)

## Make chart
with(
        dfsubset,
        plot(
                DateTime,
                Global_active_power,
                type = "l",
                ylab = "Global Active Power (kilowatts)"
        )
)

## close device
dev.off()