//
//  TransformerModelController.m
//  CastleTransformation
//
//  Created by Cong Tran on 2017-11-02.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import "Transformer.h"



@interface Transformer ()

@end

@implementation Transformer
@synthesize Name,Team,Strength,Intelligence,Speed,Endurance,Courage,Firepower,Skill,Rating,isAlive;

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        isAlive = YES;
    }
    return self;
}





@end
