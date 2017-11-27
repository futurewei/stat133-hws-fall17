#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# required packages
library(dplyr)
library(ggplot2)
library(shiny)
library(ggvis)
source("../code/functions.R",chdir = TRUE)
source("../code/clean-data-script.R",chdir = TRUE)

order <- c("A+","A","A-","B+","B","B-","C+","C","C-","D","F")

grade_dist<-c()
grade_dist$A_P <- length(which( raw_score$grade== "A+")) 
grade_dist$A <- length(which( raw_score$grade== "A")) 
grade_dist$A_M <- length(which( raw_score$grade== "A-")) 
grade_dist$B_P <- length(which( raw_score$grade== "B+")) 
grade_dist$B <- length(which( raw_score$grade== "B")) 
grade_dist$B_M <- length(which( raw_score$grade== "B-")) 
grade_dist$C_P <- length(which( raw_score$grade== "C+")) 
grade_dist$C <- length(which( raw_score$grade== "C")) 
grade_dist$C_M <- length(which( raw_score$grade== "C-")) 
grade_dist$D <- length(which( raw_score$grade== "D")) 
grade_dist$FF <- length(which( raw_score$grade== "F")) 
grade_dist <- round( as.numeric(grade_dist), digits = 0)


raw_score$Grade <- factor(raw_score$grade,levels = order)

# Variable names for histograms
cols <- c('HW1','HW2','HW3','HW4','HW5','HW6','HW6','HW7','HW8','HW9',
                'Att','QZ1','QZ2','QZ3','QZ4','EX1','EX2','Test1','Test2','Homework',
                'Quiz','Lab','Overall')


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected==1",
                       h4("Grades Distribution"),
                       tableOutput("table")),              
      conditionalPanel(condition = "input.tabselected==2",
                       selectInput("var1", "X-axis variable", cols, 
                                   selected = "HW1"),
                       sliderInput("width", "Bin Width", 
                                   min = 1,max = 10, value = 10)),
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput("var2", "X-axis variable",cols, 
                                   selected = "Test1"),
                       selectInput("Y","Y-axis variable", cols, 
                                   selected="Overall"),
                       sliderInput("Opa","Opacity",
                                   min= 0, max= 1, value = 0.5),
                       radioButtons("line", "Show line:",
                                    c("none" = "none",
                                      "lm" = "lm",
                                      "lowess" = "lowess"),
                                    selected = "none")
      )
    ),
    # Show a tabset 
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"),
                           h4("Summary Statistics"),
                           verbatimTextOutput("summary")),
                  tabPanel("Scatterplot", value = 3, 
                           ggvisOutput("scatterplot"),
                           h4("Correlation"),
                           verbatimTextOutput("correlation")),
                  id = "tabselected")
    )
  )
)


# Define server logic
server <- function(input, output) {
  
  #Barchart 
  vis_barchart <- reactive({
    raw_score %>% 
      ggvis(x = ~Grade, fill := "#7BA6EE", opacity:= 0.8) %>% 
      add_axis("y", title = "frequency")
  })
  vis_barchart %>% bind_shiny("barchart")
  
  #Grade Frequency Table Output
  frame <- cbind(Grade = order,Freq = grade_dist, Prop=round(grade_dist/sum(grade_dist),digits = 2))
  output$table <- renderTable({
    frame
  })
  
  
  
  
  #Histogram 
  vis_histogram <- reactive({
    HW1 <- prop("x", as.symbol(input$var1))
    raw_score %>% 
      ggvis(x = HW1, fill := "#abafb4", opacity:= 0.5) %>% 
      add_axis("y", title = "count")
  })
  vis_histogram %>% bind_shiny("histogram")
  
  
  #Summary Stats for Historgram
  output$summary <- renderPrint({
    print_stats(raw_score[[input$var1]])
  })
  
  
  
  
  #Scatterplot
  datas <- reactive({
    switch(input$line,
           "none" = "none",
           "lm" = "lm",
           "lowess" = "lowess")
  })
  vis_scatterplot <- reactive({
    Test1 <- prop("x", as.symbol(input$var2))
    Overall <- prop('y', as.symbol(input$Y))
    if (datas()=="none") {raw_score %>% 
      ggvis(x = Test1, y = Overall, fill := "black", opacity:= 0.5) %>%
      layer_points() }
    else if (datas()=="lm") {
      raw_score %>% 
        ggvis(x = Test1, y = Overall, fill := "black", opacity:= 0.5) %>%
        layer_points() %>% layer_model_predictions(model = "lm")
    }
    else if (datas()=="lowess") {
      raw_score %>% 
        ggvis(x = Test1, y = Overall, fill := "black", opacity:= 0.5) %>%
        layer_points() %>% layer_smooths()
    }
  })
  vis_scatterplot %>% bind_shiny("scatterplot")
  
  #Correlation output
  output$correlation <- renderPrint({
    cat(cor(raw_score[[input$var2]],raw_score[[input$Y]]))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)