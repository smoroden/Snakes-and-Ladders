//
//  main.m
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputCollector.h"
#import "GameController.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSMutableArray *d = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 100000; i++){
//            //NSLog(@"%d", arc4random_uniform(100 - 1) + 1);
//            
//            NSNumber *rand = [NSNumber numberWithInteger: arc4random_uniform(98) + 1];
//            [d addObject:rand];
//        }
//        
//        [d sortUsingSelector:@selector(compare:)];
//        
//        for (NSNumber *number in d) {
//            NSLog(@"%@", number);
//            
//        }
//
        NSString *input;
        NSInteger size = 0;
        GameDifficulty difficulty;
        NSInteger players = 0;
        
        InputCollector *ic = [[InputCollector alloc] init];
        
        
        // Get the size
        while(size == 0) {
            input = [ic inputForPrompt:@"Please enter the size of board you would like to play. Eg. 10 would give you a 10x10 board:"];
            size = [input integerValue];
        }
        
        // Get the difficulty
        while(1) {
            input = [ic inputForPrompt:@"Please enter the difficulty (E for easy/M for medium/H for hard)"];
            if ([[input lowercaseString]  isEqualToString: @"e"]) {
                difficulty = GameDifficultyEasy;
                break;
            } else if ([[input lowercaseString]  isEqualToString: @"m"]) {
                difficulty = GameDifficultyMedium;
                break;
            } else if ([[input lowercaseString]  isEqualToString: @"h"]) {
                difficulty = GameDifficultyHard;
                break;
            }
        }
        
        // Get the number of players
        while (players == 0) {
            input = [ic inputForPrompt:@"Please enter the number of players"];
            players = [input integerValue];
        }
        
        // Setup the board
        GameController *gc = [[GameController alloc] initWithSize:size andDifficulty:difficulty andAmountOfPlayers:players];
        
        // Start the game
        [gc startGameLoop];
    }
    return 0;
}
