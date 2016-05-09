//
//  Player.h
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardSquare.h"

@interface Player : NSObject

@property (nonatomic) BoardSquare *currentSquare;
@property (nonatomic) NSInteger number;

-(instancetype)initWithNumber:(NSInteger)number;

@end
