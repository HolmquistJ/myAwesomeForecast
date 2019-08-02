library(portalr)
library(rEDM)
library(tidverse)

# download rodent data
rodent_data = abundance()

do_data <- select(rodent_data, period, abundance = DO)

ggplot(do_data, aes(x=period, y=abundance)) +
  geom_line()

n=nrow(do_data)
training=c(1, floor(2/3*n))
test=c(floor(2/3*n)+1,n)

simplex(do_data, lib=training, pred=test, E=1:10, stats_only = T)

forecasts=simplex(do_data,
                  lib=training,
                  pred=test,
                  E = 5,
                  stats_only = F)

predictions = forecasts[[1]]$model_output

ggplot(do_data, aes(x=period, y=abundance)) +
  geom_line()
