//
//  GameController.m
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "GameController.h"
#import "InputCollector.h"

@interface GameController ()

@property (nonatomic) NSMutableArray *gameBoard;
@property (nonatomic) NSArray *players;

@end

@implementation GameController

-(instancetype)initWithSize:(NSInteger)size andDifficulty:(GameDifficulty)difficulty andAmountOfPlayers:(NSInteger)amount {
    self = [super init];
    if (!self)
        return nil;
    _gameBoard = [@[] mutableCopy];
    _players = [self generatePlayersWithAmount:amount];
    
    
    //generate the boardsquares
    [self generateBoardOfSize:size];
    
    //populate the squares with ladders and snakes according to difficulty
    [self generateSnakesAndLaddersWithDifficutly:difficulty andSize:size];
    
    //Set the players current square to the first square
    for (Player *player in _players) {
        player.currentSquare = _gameBoard[0];
    }
    
    
    
    return self;
}

-(void)startGameLoop {
    InputCollector *ic = [[InputCollector alloc] init];
    NSString *input;
    NSInteger roll = 0;
    BOOL playerWon = NO;
    while (!playerWon) {
        // Loop through each of the players for their turns
        for(int i = 0; i < self.players.count; i++) {
            Player* currentPlayer = self.players[i];
            // Get a valid roll
            while (roll < 1 || roll > 6) {
                input = [ic inputForPrompt:[NSString stringWithFormat:@"Player %ld enter a valid dice roll", currentPlayer.number]];
                roll = [input integerValue];
                
            }
            // Move the player
            [self movePlayer:currentPlayer withRoll:roll];
            //Check their square for snakes/ladders
            [self checkSquareForPlayer:currentPlayer];
            //Check if they won
            playerWon = [self checkIfPlayerWon:currentPlayer];
        }
        
        
        
    }
    NSLog(@"Game over. Thanks for playing!");
}

-(BOOL)checkIfPlayerWon:(Player *)player {
    if ([self.gameBoard indexOfObject:player.currentSquare] == 99) {
        NSLog(@"Congratulations player %ld, you won!", player.number);
        return YES;
    }
    
    return NO;
}

-(NSArray*)generatePlayersWithAmount:(NSInteger)amount {
    NSMutableArray *playerArray = [@[] mutableCopy];
    
    for (int i = 0; i < amount; i++) {
        [playerArray addObject:[[Player alloc] initWithNumber:i] ];
    }
    
    return playerArray;
}

-(void)generateBoardOfSize:(NSInteger)size {
    
    for(int i = 0; i < size * size; i++) {
        [_gameBoard addObject:[[BoardSquare alloc] init]];
    }
}

-(void)generateSnakesAndLaddersWithDifficutly:(GameDifficulty)difficulty andSize:(NSInteger)size {
    switch (difficulty) {
        case GameDifficultyEasy:
            [self generateLaddersWithAmount:size * 1];
            [self generateSnakesWithAmount:size * .4];
            break;
        case GameDifficultyMedium:
            [self generateLaddersWithAmount:size * .7];
            [self generateSnakesWithAmount:size * .7];
            break;
        case GameDifficultyHard:
            [self generateLaddersWithAmount:size * .4];
            [self generateSnakesWithAmount:size * 1.2];
            break;
        default:
            break;
    }
}

-(void)generateSnakesWithAmount:(NSInteger)amount {
    
    NSInteger firstNumber;
    
    NSInteger secondNumber = 0;
    for (int i = 0; i < amount; i++) {
        firstNumber = arc4random_uniform(_gameBoard.count - 2) + 1;
        while (secondNumber == firstNumber) {
            secondNumber = arc4random_uniform(_gameBoard.count - 2) + 1;
        }
        
        NSInteger min = firstNumber < secondNumber ? firstNumber : secondNumber;
        NSInteger max = firstNumber > secondNumber ? firstNumber : secondNumber;
        
        // We need to link the two boardsquares together so we add the ladder property to both.
        BoardSquare *bs1 = self.gameBoard[max];
        bs1.property = [[BoardSquareProperty alloc] initWithType:BoardSquarePropertyTypeSnake andOtherSquareNumber:min];
        
        
    }
    
    
}

-(void)generateLaddersWithAmount:(NSInteger)amount {
    NSInteger firstNumber;

    NSInteger secondNumber = 0;
    for (int i = 0; i < amount; i++) {
        firstNumber = arc4random_uniform(_gameBoard.count - 2) + 1;
        while (secondNumber == firstNumber) {
            secondNumber = arc4random_uniform(_gameBoard.count - 2) + 1;
        }
        
        NSInteger min = firstNumber < secondNumber ? firstNumber : secondNumber;
        NSInteger max = firstNumber > secondNumber ? firstNumber : secondNumber;
        
        
        BoardSquare *bs1 = self.gameBoard[min];
        bs1.property = [[BoardSquareProperty alloc] initWithType:BoardSquarePropertyTypeLadder andOtherSquareNumber:max];
        

    }
}

-(void)movePlayer:(Player*)player withRoll:(NSInteger)roll {
    NSInteger currentNumber = [self.gameBoard indexOfObject:player.currentSquare];
    NSInteger newNumber;
    
    if(currentNumber + roll > 99){
        newNumber = (currentNumber + roll) % 99;
    } else {
        newNumber = currentNumber + roll;
    }
    
    player.currentSquare = self.gameBoard[newNumber];

}

-(void)applySquarePropertyOnPlayer:(Player *)player {
    player.currentSquare = self.gameBoard[player.currentSquare.property.otherNumber];
    NSLog(@"Player %ld is now on square %ld!", player.number, [self.gameBoard indexOfObject:player.currentSquare]);
}


-(void)checkSquareForPlayer:(Player*)player {
    switch (player.currentSquare.property.type) {
        case BoardSqurePropertyTypeEmpty:
            NSLog(@"Player %ld is now on square number %ld",player.number, [self.gameBoard indexOfObject:player.currentSquare]);
            break;
        case BoardSquarePropertyTypeSnake:
            NSLog(@"Oh no! A snake!");
            [self applySquarePropertyOnPlayer:player];
            break;
        case BoardSquarePropertyTypeLadder:
            NSLog(@"Hey, a ladder!");
            [self applySquarePropertyOnPlayer:player];
            break;
        default:
            break;
    }
}

@end
