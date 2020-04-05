
server <- function(input, output, session) {
  useSweetAlert()
  
  df_indices <- read.csv('sbf_informations.csv')


  
  observeEvent(input$apply, {
    
    df_indices <- df_indices[df_indices$name == input$stock,]
    my_value <- paste0(df_indices$symbole, '.PA')
    
    df_PA <- getSymbols(my_value, from = Sys.Date() - lubridate::years(1), auto.assign = FALSE)
    #BNP.PA <- adjustOHLC(BNP.PA)
    
    df_PA_SMA_fast <- SMA(Cl(df_PA), n = as.numeric(input$fast_mma))
    df_PA_SMA_slow <- SMA(Cl(df_PA), n = as.numeric(input$slow_mma))
    df_PA_RSI_14 <- RSI(Cl(df_PA))

  output$candlesticks <- renderHighchart({
    highchart(type = "stock") %>% 
      hc_yAxis_multiples(
        create_yaxis(3, height = c(2, 1, 1), turnopposite = TRUE)
      ) %>% 
      hc_size(width = 100, height = 1000) %>% 
      hc_add_series(df_PA, yAxis = 0, name = as.character(df_indices$name)) %>% 
      hc_add_series(df_PA_SMA_fast, yAxis = 0, name = "Fast MA") %>% 
      hc_add_series(df_PA_SMA_slow, yAxis = 0, name = "Slow MA") %>% 
      hc_add_series(df_PA[,5], color = "gray", yAxis = 1, name = "Volume", type = "column") %>% 
      hc_add_series(df_PA_RSI_14, yAxis = 2, name = "Osciallator", color = hex_to_rgba("green", 0.7))
    

  })
  
  })
  
}