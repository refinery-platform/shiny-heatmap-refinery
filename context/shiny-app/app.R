library(shiny)
library(rjson)

#input_json = paste(readLines(Sys.getenv('INPUT_JSON_URL')), collapse = "")
#input_data = fromJSON(input_json)

ui <- fluidPage(
    titlePanel("Hello World!")
#    mainPanel(paste("If this were for real, you would read from: ",
#                    input_data['file_relationships']))
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)