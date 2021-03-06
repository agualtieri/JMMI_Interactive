# UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI UI


#DROP DOWN MENU SELECTIONS 
vars1 <- c(
  "SMEB"="SMEB",
  "Parallel Exchange Rates"="exchange_rates",
  "Petrol" = "petrol",
  "Diesel" = "diesel",
  "Bottled Water"="bottled_water",
  "Treated Water"="treated_water",
  "Soap"="soap",
  "Laundry Powder"="laundry_powder",
  "Sanitary Napkins"="sanitary_napkins",
  "Water Trucking"= "cost_cubic_meter"
)

varsDate<- c("Months to Select" = "varDateSelect")

#USER INTERFACE COMPONENTS 
navbarPage(theme= shinytheme("journal"), 
           title=strong(HTML("<span style='font-size:30px'>YEMEN: JOINT MARKET MONITORING INITIATIVE</span>")), # id="nav", #MAIN TITLE
           windowTitle = "REACH: Yemen Joint Market Monitoring Initiative (JMMI)", #Title for browser tab window
           
           ###..................................M A P. . P A G E ..........................................
           tabPanel(strong("JMMI"), #TAB LABEL
                    icon= icon("map-marker"), #TAB ICON
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("AdminLTE.css"),
                          shiny::includeCSS( "bootstrap.css"), #added 
                          includeCSS(path = "shinydashboard.css"),
                          br()#added
                        ),
                        
                        #LEAFLET MAP
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map1", width="100%", height="100%"), #BRING IN LEAFLET MAP, object created in server.R
                        tags$head(tags$style(".leaflet-control-zoom { display: none; }
                                              
                                            #controls {height:90vh; overflow-y: auto; }
                                              ")), #remove map zoom controls
                      
                        tags$head(tags$style(
                          type = "text/css",
                          "#controlPanel {background-color: rgba(255,255,255,0.8);}",
                          ".leaflet-top.leaflet-left .leaflet-control {
                           margin-top: 25px;
                         }"
                        )),
                        #https://stackoverflow.com/questions/37861234/adjust-the-height-of-infobox-in-shiny-dashboard
                        
                       
                        #SIDE PANEL
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = 1,
                                      width = 500, height = "auto", 
                                      
                                      hr(),
                                      h4("The Yemen Joint Market Monitoring Initiative (JMMI) is a harmonized price monitoriong initiative that focuses on informing
                                      the Water, Sanitation, and Hygiene (WASH) Cluster and the Cash 
                                      and Market Working Group (CMWG) to support humanitarian activies throughout Yemen.  
                                      The JMMI provides an indicative estimation of the prices of WASH and fuel items across districts in Yemen."),
                                      
                                      h4(p("The districts shaded in color on this map represent the most recent data collected from (number) districts in (month/year).
                                        The districts outlined in red indicate that data for the selected item was collected in that district in previous months.")),
                                      
                                      h4("Further details regarding the JMMI methodology and the Survival Minimum Expenditure Basket (SMEB) calculation can be found on the information tab. 
                                         For additional information on supply chains and market-related concerns, please visit the  ",a("REACH Resource Center", target="_blank",    href="https://www.reachresourcecentre.info/country/yemen/cycle/754/#cycle-754"), " to access the monthly situation overviews."),
                                      
                                      hr(),
                                      
                                      h4(tags$u("Most recent findings displayed in map are from data collected in ", #DistsNumn and currentD will change based on the most recent JMMI, defined in global.R
                                         tags$strong(DistsNumb), "districts in ", tags$strong(currentD))),
                                      
                                      selectInput("variable1", h4("Select Variable Below"), vars1, selected = "SMEB"), #linked text
                                      
                                    
                                      h4(textOutput("text3")), #extra small text which had to be customized as an html output in server.r (same with text1 and text 2)
                                      
                                      #HIGH CHART
                                      highchartOutput("hcontainer", height= 300, width = 450),
                                      
                                      #new data table 
                                      hr(),
                                      selectInput(inputId= "varDateSelect", label = h4("Select Month of Data Collection"), choices=NULL, selected = (("varsDateSelect"))),#linked date stuff
                                      h5("Please select a district to enable month selection"),
                                      h4(textOutput("text_DT")),
                                      DT::dataTableOutput("out_table_obs",height = "auto", width = "100%"),
                                      
                                      #####Attempt to add an info box
                                      hr(),
                                      h4("Exchange Rate for selected month in table"),
                                      h5("Please select month to populate the information box"),
                                      fluidRow(valueBoxOutput("info_exchange", width = 12)),
                                      hr(),
                                      #hr(),
                                      
                                      h6(htmlOutput("text1")),
                                      h6(htmlOutput("text2")),
                                      h6(htmlOutput("text4")),
                                      column(width=12, align="center", div(id="cite2", "Funded by: "), img(src='DFID UKAID.png', width= "90px"),img(src='OCHA@3x.png', width= "90px"),
                                             img(src='USAID.png', width= "105px")) #donor logos
                                      
                                      
                        ),
                        
                        
                        tags$div(id="cite",
                                 a(img(src='reach_logoInforming.jpg', height= "40px"), target="_blank", href="http://www.reach-initiative.org"),
                                 img(src='CMWG Logo.jpg', height= "40px", style='padding:1px;border:thin solid black;'),
                                 img(src='washlogo_grey-300DPI.png', height= "40px"))

                        # tags$div(id="cite",
                        #          a(img(src='reach_logoInforming.jpg', width= "200px"), target="_blank", href="http://www.reach-initiative.org"))
                    )
           ),
           ###..................................I N F O. . P A G E ..........................................
           tabPanel(strong("Information"),
                    tags$head(tags$style("{ height:90vh; overflow-y: scroll; }")),

                    icon= icon("info"), #info-circle
                    div(#class="outer",

                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css"),
                        style=" { height:90vh; overflow-y: scroll; }
                                              "), 
                        
                        column(width=8,h3("Overview")), #h1- h5 change the header level of the text
                        
                        column(width=7,h5("The Yemen Joint Market Monitoring Initiative (JMMI) was launched by 
                                          REACH in collaboration with the Water, Sanitation, and Hygiene (WASH) 
                                          Cluster and the Cash and Market Working Group (CMWG) to support 
                                          humanitarian actors with the harmonization of price monitoring among 
                                          all cash actors in Yemen. The basket of goods assessed includes eight 
                                          non-food items (NFIs), including fuel, water and hygiene products, 
                                          reflecting the programmatic areas of the WASH Cluster. The JMMI 
                                          tracks all components of the WASH Survival Minimum Expenditure Basket 
                                          (SMEB) since September 2018.")),
                        
                        column(width=8,h3("Methodology")), #h1- h5 change the header level of the text
                        
                        column(width=7,h5("Data was collected through interviews with vendor Key Informants 
                                          (KIs), selected by partner organizations from markets of various sizes 
                                          in both urban and rural areas. To be assessed by the JMMI, markets 
                                          must be either a single permanent market, or a local community where 
                                          multiple commercial areas are located in close proximity to one another. 
                                          When possible, markets/shops are selected within a single geographical 
                                          location, where there is at least one wholesaler operating in the 
                                          market, or multiple areas of commerce within the same geographical 
                                          location when it is too small, to provide a minimum of three price 
                                          quotations per assessed item.", tags$i(tags$strong("Findings are indicative for the assessed 
                                          locations and timeframe in which the data was collected.")))),
                               
                        column(width=8,h3("SMEB Calculation")), #h1- h5 change the header level of the text
                               
                        column(width=7,h5("Each month, enumerators conduct KI interviews with market vendors to collect three price quotations for each item from the same market in each district. 
                                          REACH calculates the WASH SMEB,
                                          which is composed of four median item prices: Soap (1.05 kg), Laundry Powder (2 kg), Sanitary Napkins (20 units) ,and Water Trucking (3.15 m3).",
                                          p(),
                                          p("The calculation of the aggregated median price for districts and governorates is done following a stepped approach. 
                                          Firstly, the median of all the price quotations related to the same market is taken. Secondly, the median quotation from each market is aggregated to calculate the district median. 
                                          Finally, the median quotation from each district is aggregated to calculate the governorate median. "))),
                               
                        
                        column(width=8,h3("About REACH")), #h1- h5 change the header level of the text
                        
                        column(width=7,h5("REACH is a joint initiative that facilitates the development of 
                                          information tools and products that enhance the capacity of aid actors 
                                          to make evidence-based decisions in emergency, recovery and development 
                                          contexts. By doing so, REACH contributes to ensuring that communities 
                                          affected by emergencies receive the support they need. All REACH 
                                          activities are conducted in support to and within the framework of 
                                          inter-agency aid coordination  mechanisms. For more information, please 
                                          visit our",a("REACH Website", target="_blank",    href="https://www.reach-initiative.org"), "or contact us directly 
                                          at yemen@reach-initiative.org.")),
  
                        hr(),
                       p(),
                      p(),
                      hr(),

                        tags$div(id="cite4",
                                 a(img(src='reach_logoInforming.jpg', width= "200px"), target="_blank", href="http://www.reach-initiative.org")))
                    ),
           
           
           #conditionalPanel("false", icon("crosshairs")),
#)

tabPanel(strong("Partners"),
         
         #style=("{overflow-y:auto; }"), 
         icon= icon("handshake"), #info-circle
         div(tags$head(
               # Include our custom CSS
               tags$style(".fa-check {color:#008000}"),
               tags$style(HTML(".sidebar {height:50vh; overflow-y:auto; }"))
             ),
             
             column(width=8,h3("Partners Past and Present")), #h1- h5 change the header level of the text
             column(width=7, h6(tags$i("Check marks indicate current participating partner in indicated month"))),
             
             #list of partners orgs
             column(width=12, h5("Agency for Technical Cooperation and Development (ACTED)"),img(src='0_acted.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Adventist Development and Relief Agency (ADRA)"), img(src='0_adra.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Al Thadamon Association"), img(src='0_thadamon.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Brains for Development (B4D)"),img(src='0_b4d.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Creative Youth Foundation (CYF)"), a(img(src='0_cyf.jpg', height= "50px", style='padding:1px;border:thin solid black;'),target="_blank", href="https://www.facebook.com/cyf.org77/")),
             column(width=12, h5("Danish Refugee Council (DRC)"), a(img(src='0_drc.png', height= "50px", style='padding:1px;border:thin solid black;'), target="_blank", href="http://www.drc.dk")),
             #column(width=12, h5("Generations without Qat (GWQ)"), img(src='0_gwq.png', height= "50px", style='padding:1px;border:thin solid black;')),
             #column(width=12, h5("LLMPO"), img(src='0_cyf.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("International Organization for Migration (IOM)", icon("check", "fa-2x")), img(src='0_iom.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Mercy Corps (MC)"), img(src='0_mercy.jfif', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("National Foundation for Development and Humanitarian Response (NFDHR)",icon("check", "fa-2x")), a(img(src='0_nfdhr.png', height= "50px", style='padding:1px;border:thin solid black;'),target="_blank", href="http://nfdhr.org/")),
             column(width=12, h5("National Forum Human Development (NFHD)", icon("check", "fa-2x")), img(src='0_nfhd.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Norweigan Refugee Council (NRC)"), img(src='0_nrc.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Old City Foundation for Development (OCFD)"), img(src='0_ocfd.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("OXFAM"), img(src='0_oxfam.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Rising Org. for Children Rights Development (ROC)",icon("check", "fa-2x")), a(img(src='0_roc.jpg', height= "50px", style='padding:1px;border:thin solid black;'), target="_blank", href="https://rocye.org/")),
             #column(width=12, h5("SAMA"), img(src='0_cyf.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Save the Children (SCI)",icon("check", "fa-2x")), img(src='0_sci.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Sustainable Development Foundation (SDF)"), img(src='0_sdf.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Solidarites International (SI)"), img(src='0_si.jpeg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Soul Yemen"), img(src='0_soul.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Tamdeen Youth Foundation (TYF)",icon("check", "fa-2x")), img(src='0_tyf.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Vision Hope"), img(src='0_vision.png', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Yemen Family Care Association (YFCA)"), img(src='0_yfca.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             column(width=12, h5("Yemen Shoreline Development (YSD)"), img(src='0_ysd.jpg', height= "50px", style='padding:1px;border:thin solid black;')),
             hr()

             
))
)