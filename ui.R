

library(shiny)
library(shinyjs)
library(shinythemes)
library(dplyr)
library(highcharter)
library(shinyWidgets)
library(quantmod)

jscode <- "shinyjs.refresh = function() { history.go(0); }"

df_indices <- read.csv('sbf_informations.csv')
names <- df_indices$name



navbarPage(theme = shinytheme("united"), "Stock Exchange", navbarMenu("Menu", icon = icon("chart-line"), 
                                                                  tabPanel("Candlesticks", icon = icon("chart-line"), 
                                                                           sidebarPanel(verticalLayout(
                                                                            selectizeInput("stock", label = h5(tags$b("Stock:")),
                                                                                          choices = names,
                                                                                          selected = NULL,
                                                                                          multiple = FALSE,
                                                                                          options = list(maxItems = 1, placeholder = 'Select a stock ...')),                                                                             
                                                                             tags$style(".irs-line {background: #ff7400} .irs-bar {background: #007bff}"), 
                                                                             sliderInput("fast_mma", "Fast MMA:", min = 5, max = 45 , value = 20, step = 5), 
                                                                             sliderInput("slow_mma", "Slow MMA:", min = 50, max = 200 , value = 50, step = 10), 
                                                                             splitLayout(actionButton("apply", "Apply", icon = icon("play"), class = "btn btn-primary")))),
                                                                           fluidRow(
                                                                             highchartOutput('candlesticks')
                                                                             ))))


