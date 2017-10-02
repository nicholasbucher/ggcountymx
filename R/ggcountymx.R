#' Returns a ggplot2 object with a geom_map of the requested county
#'
#' @param state name string (e.g. + default = "NULL)
#' @param resolution (e.g. + default = 0.5)
#' @param fill color string (e.g. + default = "white")
#' @param color border string (e.g. + default = "#7f7f7f")
#' @param size border line width (e.g. + default = 0.25)
#' @param type (1,2) municipal, state (default = 1)
#' @param alpha (e.g. + default = 1)
#'
#' @return list of points (map), municipality id's (mun.id), ggplot2 object (gg), geom object (geom)
#' @export
#' @examples
#' ggcountymx("02")
ggcountymx <- function(state = NULL,
                       type=1,
                       resolution=0.5,
                       fill = "white",
                       color = "#7f7f7f",
                       size = 0.25,
                       alpha = 1) {
  require(ggplot2)

  mx.ss<-geomx[[type]][seq(1,dim(geomx[[type]])[1],floor(1/resolution)),]

  if (!is.null(state)) {
    mx.ss<-subset(mx.ss,substr(id,1,2)==state)
  }

  gg <- ggplot()
  geom <- geom_map(data=mx.ss, map = mx.ss, aes(map_id=id,x=x, y=y),
                   fill=fill, color=color, size=size, alpha=alpha)
  gg <- gg + geom
  gg <- gg + labs(x="", y="")
  gg <- gg + theme(plot.background = element_rect(fill = "transparent", colour = NA),
                   panel.border = element_blank(),
                   panel.background = element_rect(fill = "transparent", colour = NA),
                   panel.grid = element_blank(),
                   axis.text = element_blank(),
                   axis.ticks = element_blank(),
                   legend.position = "right")

  return(list(gg=gg, map=mx.ss, mun.id=unique(mx.ss$id), geom=geom))
}

#gg <- gg + coord_map()
