source("raw/game.R")

no.simulations = c(100,500,1000,5000,10000)

require(animation)
require(ggplot2)
require(cowplot)
require(scales)

trace.bar = function(n) {
  p = ggplot(as.data.frame(table(replicate(n,game(sample(doors,1))))), aes(x=Var1, y=Freq, label=paste((Freq/n)*100,"%",sep="")))
  p = p + geom_bar(stat="identity",fill=c("#382531","#877975"))
  p = p + geom_text(aes(y=Freq+250))
  p = p + labs(x="Outcome",y="Count")
  p = p + ggtitle(paste("Outcomes of", comma(n), "Simulations of the Monty Hall Problem",sep=" "))
  p = p + scale_x_discrete(labels=c("Lose","Win"))
  p = p + scale_y_continuous(breaks=seq(0,8000,by=1000),labels=comma(seq(0,8000,by=1000)),expand=c(0,0))
  p = p + coord_cartesian(ylim=c(0,8000))
  p = p + theme(panel.background=element_blank(),
                axis.line.x=element_line(size=.15),
                axis.line.y=element_line(size=.15),
                plot.title=element_text(face="bold",size=15))
  p.final = add_sub(p,"Note: Outcomes are based on the player's strategy of sticking with the door selected at the beginning of the game.\n\nhttp://statsforgeeks.com",
                    x=0,hjust=0,size=9)
  
  print(ggdraw(p.final))
} 

trace.animate <- function() {
  set.seed(1234)
  lapply(no.simulations, function(i) {
    trace.bar(i)
  })
}

saveGIF(trace.animate(),interval=1.5,movie.name = "monty-hall-simulations.gif", ani.height=400, ani.width=600)

