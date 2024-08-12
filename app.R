library(shiny)

generate_story <- function(noun, verb, adjective, adverb) {
  story <- glue::glue("
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  ")

  # Add logging
  cat("\n 🚨 NEW ENTRY \n", file = stderr())
  cat(story, file = stderr())


  story
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- reactive({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
