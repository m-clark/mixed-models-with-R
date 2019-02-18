set.seed(1234)
gpa_lm = lm(gpa ~ occasion, data=gpa)

init = gpa %>% 
  modelr::add_predictions(gpa_lm, var='all') %>% 
  mutate(select = factor(student %in% sample(1:200, 10)),
         sz = c(.5, 1)[select]) %>% 
  group_by(student, select) 

init %>% 
  plot_ly %>% 
  add_lines(x=~occasion, y=~gpa, size=I(.5), 
            opacity=.35, 
            color=~select, 
            size= ~sz, 
            colors=scico::scico(2, begin = .25), 
            showlegend=F) %>%
  add_lines(x=~occasion, y=~gpa, 
            opacity=.35, 
            color=~select, 
            size = I(2),
            colors=scico::scico(2, begin = .25), 
            data = filter(init, select==TRUE),
            showlegend=F) %>%
  add_lines(x=~occasion, 
            y=~all, 
            color=I(palettes$stan_red$stan_red), 
            opacity=.70) %>% 
  theme_plotly()

library(gganimate)

gpa %>% 
  ggplot(aes(x = occasion, y = gpa)) +
  geom_line(aes(group = student))

gpa %>% 
  group_by(occasion) %>% 
  arrange(gpa) %>% 
  mutate(student = fct_inorder(student)) %>% 
  ggplot(aes(x = occasion, y = student, fill = gpa)) +
  geom_tile() +
  scico::scale_fill_scico(palette = 'acton', direction = -1) + 
  transition_time(occasion)

gpa %>% 
  ggplot(aes(x = occasion, y = gpa)) +
  geom_point() +
  transition_states(occasion,
                    transition_length = 2,
                    state_length = 1)

load('https://github.com/m-clark/mixed-models-with-r-workshop-2019/raw/master/data/gpa.RData')
gpa %>% 
  slice(1:60) %>%   # if you don't want to wait
  ggplot(aes(x = occasion, y = gpa)) +
  geom_path(aes(group = student, alpha = occasion),
            color = 'black',
            arrow = arrow(type = 'closed', 
                          angle = 45, 
                          length = unit(2, 'points')),
            show.legend = F) +
  transition_reveal(occasion, keep_last = T) + 
  # shadow_mark(color = 'darkred',  alpha = alpha/10) +
  theme_minimal()


# will take about 20 sec
library(lme4); library(gganimate)
sleepstudy %>% 
  ggplot(aes(x = Days, y = Reaction)) +
  geom_path(aes(group = Subject, alpha = Days),
            color = 'black',
            arrow = arrow(type = 'closed', 
                          angle = 45, 
                          length = unit(2, 'points')),
            show.legend = F) +
  transition_reveal(Days) + 
  theme_minimal()

sleepstudy %>% 
  mutate(Subject = as.numeric(Subject)) %>% 
  ggplot(aes(x = Days, y = Reaction)) +
  geom_smooth(aes(alpha = Days),
              se=F,
              color = 'darkred',
              show.legend = F) +
  transition_time(Subject) + 
  shadow_mark(colour = 'black', size = 0.25)
  theme_minimal()

