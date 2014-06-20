Koehandel
=========

iOS App for the Koehandel game

### Description
Classic bidding and bluffing game. The deck consists of sets of farm animals, 4 cards per animal. Players auction off the top animal of the deck, or try to complete their set by trading with another player. Highest bid wins, but auctioneer always has the choice to buy the animal for the same price as the highest bid.
Trading is a blind bidding system: both players place their bid face down on the table and reveal them simultaneously to each other. High bidder gets the other player's animal. Both players swap their bid. It's best to bid just a little bit more than your opponent, but just how much did he bid?

### Features

- Upon launch, new game menu is shown, unless a game was already started, in which case the game continues.
- Game can be played with 3, 4 or 5 players
- Display of amount of each animal per player
- Display amount of money of current player, and when tapped the precise amount of cards per card size (i.e. 0, 10 , 20, 50 etc.)
- Display amount of money cards for all other players
- Next turn pop-up menu with options 'Auction' and 'Trade', if a trade can be made
- If auction is chose, a random animal from the remaining deck is drawn and displayed with an image
- Input the amount for which an animal is sold via an pop-up menu, with options 'sell' and 'buy myself'
- When the deck with animals is empty, only trading is allowed
- Trading is done by selecting the animal of another player that you want to trade. Then input all money cards you want to bid. The other player does the same. Then the result (i.e. player 1 wins the trade!) is shown. On draw, repeat.
- Gameplay ends when all animals are auctioned and traded so that all animal sets are complete.

### Implementation

- Objective C
- Xcode
