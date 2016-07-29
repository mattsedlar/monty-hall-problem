source("raw/game.R")

require(ggplot2)
require(scales)
require(cowplot)

df = as.data.frame(simulations.table)

p = ggplot(df, aes(x=simulations, y=Freq, label=Freq))
p = p + geom_bar(stat="identity",fill=c("#382531","#877975"))
p = p + geom_text()
p = p + labs(x="Outcome",y="Count")
p = p + ggtitle("Outcomes of 10,000 Simulations of the Monty Hall Problem")
p = p + scale_x_discrete(labels=c("Lose","Win"))
p = p + scale_y_continuous(breaks=seq(0,7000,by=1000),labels=comma(seq(0,7000,by=1000)),expand=c(0,0))
p = p + coord_cartesian(ylim=c(0,7000))
p = p + theme(panel.background=element_blank(),
              axis.line.x=element_line(size=.15),
              axis.line.y=element_line(size=.15),
              plot.title=element_text(face="bold",size=15))

p.final = add_sub(p,"Note: Outcomes are based on the player's strategy of sticking with the door selected at the beginning of the game.\n\nstatsforgeeks.com",
                       x=0,hjust=0,size=10)

ggdraw(p.final)