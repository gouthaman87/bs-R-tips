# Youtube link: https://www.youtube.com/watch?v=M3h11elq34E

# Libraries ----
library(magrittr)

# 1.0 Stock Data ----
# - https://finance.yahoo.com/quote/AAPL/history

stock_data <- tibble::tribble(
                         ~Date,  ~Open,  ~High,   ~Low, ~`Close`, ~`Adj.Close`,     ~Volume,
                "Oct 06, 2021", 139.47, 142.15, 138.37,       142,            142,    83049259,
                "Oct 05, 2021", 139.49, 142.24, 139.36,    141.11,         141.11,    80861100,
                "Oct 04, 2021", 141.76, 142.21, 138.27,    139.14,         139.14,    98322000,
                "Oct 01, 2021",  141.9, 142.92, 139.11,    142.65,         142.65,    94639600,
                "Sep 30, 2021", 143.66, 144.38, 141.28,     141.5,          141.5,    88934200,
                "Sep 29, 2021", 142.47, 144.45, 142.03,    142.83,         142.83,    74602000,
                "Sep 28, 2021", 143.25, 144.75, 141.69,    141.91,         141.91,   108972300,
                "Sep 27, 2021", 145.47, 145.96, 143.82,    145.37,         145.37,    74150700,
                "Sep 24, 2021", 145.66, 147.47, 145.56,    146.92,         146.92,    53477900,
                "Sep 23, 2021", 146.65, 147.08, 145.64,    146.83,         146.83,    64838200,
                "Sep 22, 2021", 144.45, 146.43,  143.7,    145.85,         145.85,    76404300,
                "Sep 21, 2021", 143.93,  144.6, 142.78,    143.43,         143.43,    75834000,
                "Sep 20, 2021",  143.8, 144.84, 141.27,    142.94,         142.94,   123478900,
                "Sep 17, 2021", 148.82, 148.82, 145.76,    146.06,         146.06,   129868800,
                "Sep 16, 2021", 148.44, 148.97, 147.22,    148.79,         148.79,    68034100,
                "Sep 15, 2021", 148.56, 149.44, 146.37,    149.03,         149.03,    83281300,
                "Sep 14, 2021", 150.35, 151.07, 146.91,    148.12,         148.12,   109296300,
                "Sep 13, 2021", 150.63, 151.42, 148.75,    149.55,         149.55,   102404300,
                "Sep 10, 2021",    155, 155.48,  148.7,    148.97,         148.97,   140646400,
                "Sep 09, 2021", 155.49, 156.11, 153.95,    154.07,         154.07,    57305700,
                "Sep 08, 2021", 156.98, 157.04, 153.98,    155.11,         155.11,    74420200,
                "Sep 07, 2021", 154.97, 157.26, 154.39,    156.69,         156.69,    82278300,
                "Sep 03, 2021", 153.76, 154.63, 153.09,     154.3,          154.3,    57808700,
                "Sep 02, 2021", 153.87, 154.72,  152.4,    153.65,         153.65,    71115500,
                "Sep 01, 2021", 152.83, 154.98, 152.34,    152.51,         152.51,    80313700,
                "Aug 31, 2021", 152.66,  152.8, 151.29,    151.83,         151.83,    86453100,
                "Aug 30, 2021",    149, 153.49, 148.61,    153.12,         153.12,    90956700,
                "Aug 27, 2021", 147.48, 148.75, 146.83,     148.6,          148.6,    55721500,
                "Aug 26, 2021", 148.35, 149.12, 147.51,    147.54,         147.54,    48597200,
                "Aug 25, 2021", 149.81, 150.32,  147.8,    148.36,         148.36,    58991300
                )

stock_data %>% 
  dplyr::mutate(Date = lubridate::mdy(Date)) %>% 
  timetk::plot_time_series(Date, Volume)

# 2.0 Largest Companies by Revenue ----
# - https://en.wikipedia.org/wiki/List_of_largest_companies_by_revenue

largest_companies_df <- tibble::tribble(
                          ~V1,                                     ~V2,                              ~V3,                 ~V4,        ~V5,       ~V6,                             ~V7,    ~V8,
                           1L,                               "Walmart",                         "Retail", "Increase $559,151",  "$13,600",   2300000,   "United States United States",  "[4]",
                           2L,                            "State Grid",                    "Electricity", "Increase $386,618",   "$5,580",    896360,                   "China China",  "[5]",
                           3L,                                "Amazon", "Retail, Information Technology", "Increase $386,064",  "$21,331",   1335000,   "United States United States",  "[6]",
                           4L,              "China National Petroleum",                    "Oil and gas", "Decrease $283,958",   "$4,575",   1242245,                   "China China",  "[7]",
                           5L,                         "Sinopec Group",                    "Oil and gas", "Decrease $283,728",   "$6,205",    553833,                   "China China",  "[8]",
                           6L,                                 "Apple",                    "Electronics", "Increase $274,515",  "$57,411",    147000,   "United States United States",  "[9]",
                           7L,                            "CVS Health",                     "Healthcare", "Increase $268,706",   "$7,179",    256500,   "United States United States", "[10]",
                           8L,                          "UnitedHealth",                     "Healthcare", "Increase $257,141",  "$15,403",    330000,   "United States United States", "[11]",
                           9L,                                "Toyota",                     "Automotive", "Decrease $256,722",  "$21,180",    366283,                   "Japan Japan", "[12]",
                          10L,                            "Volkswagen",                     "Automotive", "Decrease $253,965",  "$10,104",    662575,               "Germany Germany", "[13]",
                          11L,                    "Berkshire Hathaway",                     "Financials", "Increase $254,510",  "$42,521",    360000,   "United States United States", "[14]",
                          12L,                              "McKesson",                     "Healthcare", "Increase $238,228",  "-$4,539",     67500,   "United States United States", "[15]",
                          13L,              "China State Construction",                   "Construction", "Increase $234,425",   "$3,578",    356864,                   "China China", "[16]",
                          14L,                          "Saudi Aramco",                    "Oil and gas", "Decrease $229,766",  "$49,287",     79800,     "Saudi Arabia Saudi Arabia", "[17]",
                          15L,                   "Samsung Electronics",                    "Electronics", "Increase $200,734",  "$22,116",    267937,       "South Korea South Korea", "[18]",
                          16L,                     "Ping An Insurance",                     "Financials", "Increase $191,509",  "$20,739",    362035,                   "China China", "[19]",
                          17L,                     "AmerisourceBergen",                     "Healthcare", "Increase $189,894",  "-$3,409",     21500,   "United States United States", "[20]",
                          18L,                                    "BP",                    "Oil and gas", "Decrease $183,500", "-$20,305",     68100, "United Kingdom United Kingdom", "[21]",
                          19L,                     "Royal Dutch Shell",                    "Oil and gas", "Decrease $183,195", "-$21,680",     87000,       "Netherlands Netherlands", "[22]",
                          20L,                                  "ICBC",                     "Financials", "Increase $182,794",  "$45,783",    439787,                   "China China", "[23]",
                          21L,                              "Alphabet",         "Information technology", "Increase $182,527",  "$40,269",    144056,   "United States United States", "[24]",
                          22L,                               "Foxconn",                    "Electronics", "Increase $181,945",   "$3,457",    878429,                 "Taiwan Taiwan", "[25]",
                          23L,                            "ExxonMobil",                    "Oil and gas", "Decrease $181,502", "-$22,440",     72000,   "United States United States", "[26]",
                          24L,                               "Daimler",                     "Automotive", "Decrease $175,827",   "$4,133",    288481,               "Germany Germany", "[27]",
                          25L,               "China Construction Bank",                     "Financials", "Increase $172,000",  "$39,283",    373814,                   "China China", "[28]",
                          26L,                                  "AT&T",             "Telecommunications", "Decrease $171,760",  "-$5,176",    230760,   "United States United States", "[29]",
                          27L,                             "Microsoft",         "Information technology", "Increase $168,090",  "$61,270",    181000,   "United States United States", "[30]",
                          28L,                                "Costco",                         "Retail", "Increase $166,761",   "$4,002",    214500,   "United States United States", "[31]",
                          29L,                                 "Cigna",                     "Healthcare", "Increase $160,401",   "$8,458",     72963,   "United States United States", "[32]",
                          30L,            "Agricultural Bank of China",                     "Financials", "Increase $153,885",  "$31,293",    462592,                   "China China", "[33]",
                          31L,                       "Cardinal Health",                     "Healthcare", "Increase $152,922",  "-$3,696",     48000,   "United States United States", "[34]",
                          32L,                             "Trafigura",                    "Commodities", "Decrease $146,994",   "$1,699",      8619,           "Singapore Singapore", "[35]",
                          33L,                  "China Life Insurance",                      "Insurance", "Increase $144,589",   "$4,648",    183417,                   "China China", "[36]",
                          34L,                              "Glencore",                    "Commodities", "Decrease $142,338",  "-$1,903",     87822,       "Switzerland Switzerland", "[37]",
                          35L, "China Railway Engineering Corporation",                   "Construction", "Increase $141,384",   "$1,639",    308483,                   "China China", "[38]",
                          36L,              "Walgreens Boots Alliance",                         "Retail", "Increase $139,537",     "$456",    450000,   "United States United States", "[39]",
                          37L,                                  "Exor",                "Holding company", "Decrease $136,186",     "-$34",    263284,       "Netherlands Netherlands", "[40]",
                          38L,                               "Allianz",                     "Financials", "Increase $136,173",   "$7,756",    150269,               "Germany Germany", "[41]",
                          39L,                         "Bank of China",                     "Financials", "Decrease $134,046",  "$27,952",    309084,                   "China China", "[42]",
                          40L,                                "Kroger",                         "Retail", "Increase $132,498",   "$2,585",    465000,   "United States United States",  "[2]",
                          41L,                            "Home Depot",                         "Retail", "Increase $132,110",  "$12,870",    504800,   "United States United States",  "[2]",
                          42L,            "China Railway Construction",                   "Construction", "Increase $131,992",   "$1,486",    364632,                   "China China",  "[2]",
                          43L,                        "JPMorgan Chase",                     "Financials", "Decrease $129,503",  "$29,131",    260110,   "United States United States", "[43]",
                          44L,                                "Huawei",                    "Electronics", "Increase $129,184",   "$9,362",    197000,                   "China China", "[44]",
                          45L,                               "Verizon",             "Telecommunications", "Decrease $128,292",  "$17,801",    135500,   "United States United States", "[45]",
                          46L,                                   "AXA",                     "Financials", "Decrease $128,011",   "$3,605",     96595,                 "France France", "[46]",
                          47L,                                  "Ford",                     "Automotive", "Decrease $127,144",  "-$1,279",    186000,   "United States United States", "[47]",
                          48L,                                 "Honda",                     "Automotive", "Decrease $124,241",   "$6,202",    211374,                   "Japan Japan", "[48]",
                          49L,                        "General Motors",                     "Automotive", "Decrease $122,485",   "$6,427",    155000,   "United States United States", "[49]",
                          50L,                                "Anthem",                     "Healthcare", "Increase $121,867",   "$4,572",     83400,   "United States United States",  "[2]"
                          )


largest_companies_df %>% 
  dplyr::slice(1:5) %>% 
  dplyr::mutate(
    V4 = readr::parse_number(V4),
    V2 = forcats::as_factor(V2) %>% forcats::fct_rev()
  ) %>% 
  
  ggplot2::ggplot(ggplot2::aes(V4, V2)) +
  ggplot2::geom_col(ggplot2::aes(fill = V4)) +
  ggplot2::geom_label(ggplot2::aes(label = scales::dollar_format()(V4)), hjust = 1) +
  ggplot2::theme_minimal() +
  ggplot2::scale_x_continuous(labels = scales::dollar_format()) +
  ggplot2::labs(
    title = "Revenue (Millions) for Largest Companies",
    y = "Company Name", 
    x = "Revenue" 
  ) +
  ggplot2::theme(legend.position = "none")
