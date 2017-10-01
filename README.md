ggcountymx
========

Generate `ggplot2` `geom_map` Mexico county maps

This is a simple package with one purpose:

- Make it easier to generate Mexico Municipality Choroplet maps

For installation, just do:

    library(devtools)
    install_github("nicholasbucher/ggcountymx")
    library(ggcountymx)

    AGS <- ggcountymx("AGS")
    AGS$gg
    
To get:

IMAGE1

The `AGS` object in the above code contains

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
    mx <- ggcountymx()
    
    # start the plot with our base map
    gg <- mx$gg
    
    # add a new geom with our population (choropleth)
    
    choro_geom <- geom_map(data=Choroplet,
                           map=Data,
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

# ![map2](https://rawgit.com/hrbrmstr/ggcounty/master/mainechoro.png)

And, combining individual maps is pretty straightforward:

    ny <- ggcounty("New York", fill="#c7e9b4", color="white")
    nj <- ggcounty("New Jersey", fill="#41b6c4", color="white")
    pa <- ggcounty("Pennsylvania", fill="#253494", color="white")

    ny$gg + nj$geom + pa$geom 
    

![map2](https://rawgit.com/hrbrmstr/ggcounty/master/tristate.png)

or have the county names/FIPS codes as a quick reference or for verifitcation.

    > ny$county.names
     [1] "Albany"       "Allegany"     "Bronx"        "Broome"       "Cattaraugus"  "Cayuga"      
     [7] "Chautauqua"   "Chemung"      "Chenango"     "Clinton"      "Columbia"     "Cortland"    
    [13] "Delaware"     "Dutchess"     "Erie"         "Essex"        "Franklin"     "Fulton"      
    [19] "Genesee"      "Greene"       "Hamilton"     "Herkimer"     "Jefferson"    "Kings"       
    [25] "Lewis"        "Livingston"   "Madison"      "Monroe"       "Montgomery"   "Nassau"      
    [31] "New York"     "Niagara"      "Oneida"       "Onondaga"     "Ontario"      "Orange"      
    [37] "Orleans"      "Oswego"       "Otsego"       "Putnam"       "Queens"       "Rensselaer"  
    [43] "Richmond"     "Rockland"     "Saratoga"     "Schenectady"  "Schoharie"    "Schuyler"    
    [49] "Seneca"       "St. Lawrence" "Steuben"      "Suffolk"      "Sullivan"     "Tioga"       
    [55] "Tompkins"     "Ulster"       "Warren"       "Washington"   "Wayne"        "Westchester" 
    [61] "Wyoming"      "Yates"  
