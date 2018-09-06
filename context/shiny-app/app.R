library(shiny)
library(rjson)

# For local development:
# ln -s `pwd`/fixtures/fake-input.json /tmp/input.json

input_json <- paste(readLines('/tmp/input.json'), collapse = "")
input_data <- fromJSON(input_json)
csv_urls <- input_data$file_relationships
csv <- read.csv(url(csv_urls[1]))

message('csv: ', csv)

ui <- fluidPage(
    titlePanel("Hello World!"),
    mainPanel(tableOutput('table'))
)

server <- function(input, output) {
  output$table <- renderTable(csv)
}

shinyApp(ui = ui, server = server)