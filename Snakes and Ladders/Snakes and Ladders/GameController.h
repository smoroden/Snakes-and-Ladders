//
//  GameController.h
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

typedef NS_ENUM(NSInteger, GameDifficulty) {
    GameDifficultyEasy,
    GameDifficultyMedium,
    GameDifficultyHard
};

@interface GameController : NSObject


-(instancetype)initWithSize:(NSInteger)size andDifficulty:(GameDifficulty)difficulty andAmountOfPlayers:(NSInteger)amount;
-(void)startGameLoop;

@end
