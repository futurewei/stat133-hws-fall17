library(dplyr)
library(ggplot2)

roster = read.csv("~/Desktop/stat133/stat133-hws-fall17/hw03/data/nba2017-roster.csv", stringsAsFactors = FALSE)
stats = read.csv("~/Desktop/stat133/stat133-hws-fall17/hw03/data/nba2017-stats.csv", stringsAsFactors = FALSE)


missed_fg = field_goals_atts - field_goals_made
missed_ft = points1_atts-points1_made
points = points1_made + points2_made*2 + points3_made*3
rebounds = off_rebounds + def_rebounds
efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers)/games_played
stats = stats %>% mutate(missed_fg, 
missed_ft,  points,rebounds, efficiency)

sink(file = '~/Desktop/stat133/stat133-hws-fall17/hw03/output/efficiency-summary.txt')
summary(stats$efficiency)
sink()

data = merge(stats, roster, by = 'player')

teams = data %>% 
  group_by(team) %>%
  summarize(experience = sum(experience), salary = round(sum(salary)/1000000, 2), points3 = sum(points3_made),
points2 = sum(points2_made),free_throws = sum(points1_made), points = sum(points),off_rebounds = sum(off_rebounds),def_rebounds = sum(def_rebounds),
assists = sum(assists),steals = sum(steals),blocks = sum(blocks),turnovers = sum(turnovers),
fouls = sum(fouls), efficiency = sum(efficiency))

summary(teams)
sink(file = '~/Desktop/stat133/stat133-hws-fall17/hw03/data/teams-summary.txt')
summary(stats$efficiency)
sink()
write.csv(teams, file = "~/Desktop/stat133/stat133-hws-fall17/hw03/data/teams.csv")
pdf('~/Desktop/stat133/stat133-hws-fall17/hw03/images/teams_stars_plot.pdf')
stars(teams[ , -1], labels = str(teams$team))
dev.off()

pdf('~/Desktop/stat133/stat133-hws-fall17/hw03/images/experience_salary.pdf')
ggplot(teams, aes(experience, salary)) + geom_point() + geom_text(aes(label= team))
dev.off()
