//
//  BoardSquare.h
//  Snakes and Ladders
//
//  Created by Zach Smoroden on 2016-05-06.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardSquareProperty.h"

@interface BoardSquare : NSObject

@property (nonatomic) BoardSquareProperty *property;

@end
