#  Use cases

## Show a list of global cryptocurrences

As a user I want to be able to show the global cryptocurrences ordered by market cap

 GIVEN I have my app started
 WHEN I access the main view
 THEN I see a list of globa cryptos
 AND I access basic crypto info (name, symbol, price, last price change, last 24 hs volume, market cap)

- Entities (domain models)
    Cryptocurrencies
        id
        name
        symbol
        price
        price24hs
        volume24hs
        marketCap
        
- Use Cases
    Get a global crypto list

