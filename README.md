ggcountymx
========

Generate `ggplot2` `geom_map` Mexico county maps

This is a simple package with one purpose:

- Make it easier to generate Mexico Municipality Choroplet maps

For installation, just do:

    library(devtools)
    install_github("nicholasbucher/ggcountymx")
    library(ggcountymx)
    data(mxcounty)
    
    BCS <- ggcountymx("03")
    BCS$gg
    
To get:

![map1](https://raw.githubusercontent.com/nicholasbucher/ggcountymx/master/img/BCS_1.svg)

The `BCS` object in the above code contains

- the `gg` ggplot2 object
- a `map` object which is the polygon points data frame
- a `mun.names` object which is a list of all municipality names with FIPS codes in that municipality
- a `geom` object (`geom`) for the municipality map


This lets you add further map layers (e.g. for a choropleth):

    library(ggcountymx)
    
    # built-in MEX socioeconomic by FIPS code data set from ENIGH 2016
    data(socioeconomic)
    
    # define appropriate (& nicely labeled) socioeconomic breaks
    
    socioeconomic$brk<-cut(socioeconomic$Level,
                           breaks=c(0, 0.5 , 1 , 1.5 , 2 , 2.5 , 3 ,3.5 , 4),
                           labels=c("Outcast",
                                    "Low",
                                    "Lower Middle",
                                    "Middle",
                                    "Upper Middle",
                                    "Lower High",
                                    "Middle High",
                                    "Upper High"),
                          include.lowest=TRUE)
                     
    # get the Mexico municipality map
    BCS <- ggcountymx("03")
    
    # start the plot with our base map
    gg <- BCS$gg
    
    # add a new geom with our population (choropleth)
    
    choro_geom <- geom_map(data=socioeconomic,
                           map=BCS$map,
                           aes(map_id=FIPS, fill=brk),
                           color="white", size=0.125)

    gg<-gg + choro_geom
    
    # define nice colors
    
    choro_color<-scale_fill_manual(values=c("#ff0000", "#ff4000", "#ff8000",
                                            "#ffbf00", "#ffff00", "#bfff00",
                                            "#80ff00","#40ff00"),
                                   name="Socioeconomic Class")
    
    gg<-gg + choro_color
    
    # plot the map
    gg

![map2](https://rawgit.com/nicholasbucher/ggcountymxmaster/master/img/BCS.jpeg)

And, combining individual maps is pretty straightforward:

    BCN <- ggcountymx("02", fill="#c7e9b4", color="white")
    BCS <- ggcountymx("03", fill="#41b6c4", color="white")
    SON <- ggcountymx("26", fill="#253494", color="white")

    BCS$gg + BCN$geom + SON$geom
    

![map2](https://rawgit.com/nicholasbucher/ggcountymx/master/img/COM.svg)

