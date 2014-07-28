shinyServer(function(input, output, session) {
    tooltip <- function(df, ...) {
      paste0("<b>", format(as.POSIXct(df$Event_Date/1000,origin=as.Date("1970-01-01")), format="%F"), "</b><br>",
             df$text,"<br>",
             df$Total_Fatal_Injuries,"/", df$Total_Aboard," fatalities")
    }
    
    data %>% filter(Total_Fatal_Injuries>4) %>% mutate(text=paste0("<em>",Location,"</em><br>",Make," ",Model)) %>%
      select(Event_Date, Total_Fatal_Injuries, Total_Aboard, text) %>%
      ggvis(x=~Event_Date, y=~Total_Aboard,size=~Total_Fatal_Injuries, fill=~as.Date(Event_Date),
            opacity := 0.7,key := ~text) %>%
      layer_points() %>%
      scale_numeric("y", domain = c(0, 400), clamp=TRUE, nice = FALSE, override=TRUE, expand=0) %>%
      scale_numeric("size",trans = "sqrt",range=c(10,500)) %>%
      scale_numeric("fill", range=c("darkred","darkblue")) %>%
      add_axis("y",title="Passengers aboard",title_offset = 50,
               properties = axis_props(majorTicks=list(strokeWidth = 0),
                                       axis = list(stroke = "#666666",strokeWidth = 0),
                                       labels = list(fill="#666666"),
                                       title=list(fill="#666666", fontSize=15)
               )
      ) %>%
      add_axis("x",title="",tick_size_end=0,
               properties = axis_props(majorTicks=list(stroke="#666666",strokeWidth = 1),
                                       minorTicks=list(stroke="#666666",strokeWidth = 0),
                                       axis=list(stroke="#666666",strokeWidth = 1),
                                       labels = list(fill="#666666")
               ),
               grid = FALSE
      ) %>% 
      hide_legend(c("size","fill","shape")) %>% add_legend("size", title="Fatalities") %>%
      add_tooltip(tooltip) %>% bind_shiny("ggvis", "ggvis_ui") %>%
      bind_shiny("ggvis", "ggvis_ui")
})


