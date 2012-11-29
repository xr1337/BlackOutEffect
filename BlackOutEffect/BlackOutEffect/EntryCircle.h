//
//  EntryCircle.h
//  LuckyTest
//
//  Created by Sufiyan Yasa on 11/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Bck : CCSprite{
    int number_of_points;
}
@property(readwrite)ccVertex2F *glPoints;

@end

@interface EntryCircle : CCLayer {
    Bck* bck;
    CCSprite* round;
    CGPoint startPoint;
}
+(id)scene;
@end
