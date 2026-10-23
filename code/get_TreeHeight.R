args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
    stop("Please provide exactly one CSV file path")
}


input_file <- args[1]

if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
}

MyData <- read.csv(input_file, header = TRUE)

required_cols <- c("Species", "Distance.m", "Angle.degrees")

if (!identical(names(MyData), required_cols)) {
    stop("Invalid CSV header: expected Species, Distance.m, Angle.degrees")
}

print(is.numeric(MyData$Distance.m))
print(is.numeric(MyData$Angle.degrees))
print(all(is.finite(MyData$Distance.m)))
print(all(is.finite(MyData$Angle.degrees)))

if (!is.numeric(MyData$Distance.m)) {
    stop("Distance.m must be numeric")
}

if (!is.numeric(MyData$Angle.degrees)) {
    stop("Angle.degrees must be numeric")
}

if (!all(is.finite(MyData$Distance.m))) {
    stop("Distance.m contains invalid values")
}

if (!all(is.finite(MyData$Angle.degrees))) {
    stop("Angle.degrees contains invalid values")
}

print(all(MyData$Distance.m > 0 & MyData$Distance.m <= 100))
print(all(MyData$Angle.degrees > 0 & MyData$Angle.degrees < 90))

if (!all(MyData$Distance.m > 0 & MyData$Distance.m <= 100)) {
    stop("Invalid distance: must be greater than 0 and at most 100")
}
if (!all(MyData$Angle.degrees > 0 & MyData$Angle.degrees < 90)) {
    stop("Invalid angle: must be greater than 0 and less than 90")
}


# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle is measured from horizontal in degrees
# distance:  The distance is horizontal distance from observer to tree, unit:meters
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(Angle.degrees, Distance.m) {
    radians <- Angle.degrees * pi / 180
    height_m <- Distance.m * tan(radians)
    return(height_m)
}



MyData$height_m <- TreeHeight(MyData$Angle.degrees, MyData$Distance.m)

print(head(MyData))

dir.create("results", showWarnings = FALSE)

file_base <- sub("\\.csv$", "", basename(input_file))
output_file <- paste0("results/", file_base, "_treeheights.csv")

write.csv(MyData, output_file, row.names = FALSE)