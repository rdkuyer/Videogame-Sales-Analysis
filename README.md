# Videogame-Sales-Analysis

# Scenario
I am working as a data analyst for Xbox, they asked if I could analyze the Japanese market to increase their market share in Japan.

# Key insights

- Video-game sales peaked in 2008 during the 7th game generation (2005–2017), and have been decreasing ever since, with a short-lived exception after the launch of the 8th generation.
- Japanese top 5 gaming genre differs from the rest of the world.
- Xbox focus in Japan is on popular genres in the rest of the world, whereas Ninentdo and PlayStation adapt to Japenese preferences.

# Recommendations
- Conduct market research in the Japanese gaming culture, adjust your market entry strategy towards a Japanese specialized strategy.
- Conduct further research on the driving factors of the succes of the 7th generation.
  
# About this project

Conducted analysis in postgreSQL and PowerBI to surface insights on videogame dataset from maven containing 64,000 rows. I worked in postgreSQL to build a mini-database, clean and prepare the dataset for analysis, and pre-analyze the data. I built a trend and Japanese performance report in PowerBI to visualize the key findings. 

Insight 1 can be easily obtained by reviewing the stacked area chart. This chart is created to show the total sales over time. By including the x lines, the impact of the generation becomes apparent. Xbox was not an import platform before the 7th gaming generation. Furthermore, the peak and decline can easily be obtained from this graph.

Insight 2 is found by initial analysis in PostgreSQL and shown in the report by making use of a treemap. This visual allows to easily compare the overall top 5 sold genres in Japan to the top 5 genres sold per platform (found in the donut charts).

Insight 3 is found by comparing the donut charts. The upper donut chart displays the shares of the top 5 genres sold in Japan by the chosen platform. The lower donut chart displays the shares of the top 5 genres sold in the world by the chosen platform. By comparing the two donut charts one can find little change in genres for Xbox; for both charts Shooter is the largest followed by action.

By reviewing the donut charts for Playstation and Nintendo one can clearly see these platforms focus on differnt game genre specified to the Japanese market. For Nintendo and PlayStation the donut charts differ much more than they do for Xbox.






