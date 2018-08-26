install.packages("rvest")
library(rvest)

for (i in 1:10) {
    property_price_url <- paste0('https://www.daft.ie/price-register/?min_price=25000&max_price=5000000&pagenum=', i);
    print(property_price_url)
    # Scrapping the web page
    property_price_web_page <- read_html(property_price_url)
    # Reading the address node 
    property_address_nodes <- address <- html_nodes(property_price_web_page, '.priceregister-address a:first-child')
    # print address node
    property_address_nodes
    # reading price
    property_price_nodes <- html_nodes(property_price_web_page, '.priceregister-dwelling-details b')
    #reading the text address node and storing 
    property_address <- html_text(property_address_nodes)
    # readig the property price
    property_price <- html_text(property_price_nodes)
    #merging the property price and address
    temp <- cbind(property_address, property_price)
    # appending the details for display
    property_price_details <- rbind(property_price_details, temp);
}
property_price_details
# loading webpage dynamically and printing  address and the price .