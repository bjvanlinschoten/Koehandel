####Classes

* Card  
	* Properties:  
		- animal: represents the animal on the card  
		- value: represents the value of the animal
	* Methods:  
		- initWithValue: initializes the card with a value and an animal

* Deck  
	* Properties:  
		- cards: NSMutableArray with all the cards in the deck  
	* Methods:  
		- shuffle: shuffles the cards in the NSMutableArray  
		- draw: draws a card an remove it from the deck  

* Player  
	* Properties:  
		- moneyCards: NSMutableArray of all money cards the player possesses  
		- animalCards: NSMutableArray of all animal cards the player possesses  
		- name: the name of the player  
	* Methods:  
		- getTotalMoney: calculates the amount of money the player has from the moneyCards array  
		- getScore: calculates score from animal cards  
		- initWithName: initializes a player with correct starting amount of money and the players name  

* Gameplay  
	* Properties:  
		- Players: objects from the player class  
		- currentPlayer: the player whose turn it is  
		- waitingPlayer1 & 2: the players that can buy the drawn animal in an auction  
		- currentCard: the card that is up for auction  
	* Methods:  
		- auctionCard: controls the auctioning of an animal. inputted is the buyer and the amount bid.  
		- tradeCard: controls the trading of cards. inputted is the animal up for trading and the amounts the players bid. Player get each others money and highest bidding player gets both animals.  




####View Controllers

- NewGameViewController  
	Screen where players input there name and start a new game

- AuctionViewController  
	Screen where players auction animals

- TradeViewController  
	Screen where players can start a trade

- StatsViewController  
	Screen where players can see all statistics (money, animals, score)



####How the game is played

The game is played offline and with 3 players. Player’s turn. He chooses to auction or trade.   

######Auction:  
The player draws a card. Then the 2 other players proceed to verbally bid on the animal. Once the price is determined the player taps the SOLD button, after which the buying player and the price is inputted. The auction has now ended.  

######Trade:  
The player selects the opposite player and the animal he wants to bid for. He then taps the LETS TRADE button. Now the first player is prompted a bid. Then the second player places his bid. A pop-up menu alerts the players who has won the trade and the winning player gets the animals.  

Players need to be able to see there stats at all times. Animals (and thus score) are open; everyone can see the distribution of the animals. For the money this is a bit different. The amount of money cards is open, but the total amount is hidden. This is shown by holding down finger on money cards digit (Optional: input 3 digit password to avoid dirty play).  
























