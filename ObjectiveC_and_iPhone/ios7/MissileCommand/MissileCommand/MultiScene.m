//
//  MultiScene.m
//  Missile Command
//
//  Created by Bart Jacobs on 31/01/14.
//  Copyright (c) 2014 Mobiletuts+. All rights reserved.
//

#import "MultiScene.h"

#import "MyScene.h"
#import "MenuScene.h"

@interface MultiScene () <SKPhysicsContactDelegate>

@end

@implementation MultiScene{
    int flowerBulletsPlayerOne1, flowerBulletsPlayerOne2, flowerBulletsPlayerOne3;
    int flowerBulletsPlayerTwo1, flowerBulletsPlayerTwo2, flowerBulletsPlayerTwo3;
    int missileExplodedPlayerOne, missileExplodedPlayerTwo, monstersDeadPlayerOne;
    int monstersDeadPlayerTwo, position;
    SKLabelNode *labelflowerBulletsPlayerOne1;
    SKLabelNode *labelflowerBulletsPlayerOne2;
    SKLabelNode *labelflowerBulletsPlayerOne3;
    
    SKLabelNode *labelflowerBulletsPlayerTwo1;
    SKLabelNode *labelflowerBulletsPlayerTwo2;
    SKLabelNode *labelflowerBulletsPlayerTwo3;
    
    SKLabelNode *labelMissilesExplodedPlayerOne;
    SKLabelNode *labelMissilesExplodedPlayerTwo;
    
    CGSize sizeGlobal;
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:(198/255.f) green:(220/255.f) blue:(54/255.f) alpha:1.0];
        
        position = size.height/3;
        sizeGlobal = size;
        
        [self createPlayer1Map];
        [self createPlayer2Map];
        
        //draw middle (separator) line
        SKShapeNode *separatorLine = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, size.width/2, size.height);
        CGPathAddLineToPoint(pathToDraw, NULL, size.width/2, 0);
        separatorLine.path = pathToDraw;
        [separatorLine setStrokeColor:[UIColor yellowColor]];
        [self addChild:separatorLine];
        
        //schedule enemies
        SKAction *wait = [SKAction waitForDuration:2];
        SKAction *callMissiles = [SKAction runBlock:^{
            [self addMissilesFromSky:size];
        }];
        
        SKAction *updateMissiles = [SKAction sequence:@[wait,callMissiles]];
        [self runAction:[SKAction repeatActionForever:updateMissiles]];
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}

-(void)createPlayer1Map{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self addFlowerCommand:1];
    
    flowerBulletsPlayerOne1 = 10;
    flowerBulletsPlayerOne2 = 10;
    flowerBulletsPlayerOne3 = 10;
    
    //Label Informing Missiles Exploded
    labelMissilesExplodedPlayerOne = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelMissilesExplodedPlayerOne.text = [NSString stringWithFormat:@"Missiles Exploded: %d",missileExplodedPlayerOne];
    labelMissilesExplodedPlayerOne.fontSize = 20;
    labelMissilesExplodedPlayerOne.position = CGPointMake(sizeGlobal.width/2-labelMissilesExplodedPlayerOne.frame.size.height,sizeGlobal.height-labelMissilesExplodedPlayerOne.frame.size.width/2-10);
    labelMissilesExplodedPlayerOne.zPosition = 3;
    labelMissilesExplodedPlayerOne.zRotation = -M_PI_2;
    [self addChild:labelMissilesExplodedPlayerOne];
     NSLog(@"%f %f", sizeGlobal.width/2-labelMissilesExplodedPlayerOne.frame.size.height,sizeGlobal.height-labelMissilesExplodedPlayerOne.frame.size.width/2-10);
    
    labelflowerBulletsPlayerOne1 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerOne1.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerOne1];
    labelflowerBulletsPlayerOne1.fontSize = 30;
    labelflowerBulletsPlayerOne1.position = CGPointMake(labelflowerBulletsPlayerOne1.frame.size.height/2,position*1-position/2);
    labelflowerBulletsPlayerOne1.zPosition = 3;
    labelflowerBulletsPlayerOne1.scale = 0.5;
    labelflowerBulletsPlayerOne1.zRotation = -M_PI_2;
    [self addChild:labelflowerBulletsPlayerOne1];
     NSLog(@"%f %d",labelflowerBulletsPlayerOne1.frame.size.height/2,position*1-position/2);
    
    labelflowerBulletsPlayerOne2 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerOne2.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerOne2];
    labelflowerBulletsPlayerOne2.fontSize = 30;
    labelflowerBulletsPlayerOne2.position = CGPointMake(labelflowerBulletsPlayerOne2.frame.size.height/2,position*2-position/2);
    labelflowerBulletsPlayerOne2.zPosition = 3;
    labelflowerBulletsPlayerOne2.scale = 0.5;
    labelflowerBulletsPlayerOne2.zRotation = -M_PI_2;
    [self addChild:labelflowerBulletsPlayerOne2];
     NSLog(@"%f %d",labelflowerBulletsPlayerOne1.frame.size.height/2,position*1-position/2);
    
    labelflowerBulletsPlayerOne3 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerOne3.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerOne3];
    labelflowerBulletsPlayerOne3.fontSize = 30;
    labelflowerBulletsPlayerOne3.position = CGPointMake(labelflowerBulletsPlayerOne3.frame.size.height/2,position*3-position/2);
    labelflowerBulletsPlayerOne3.zPosition = 3;
    labelflowerBulletsPlayerOne3.scale = 0.5;
    labelflowerBulletsPlayerOne3.zRotation = -M_PI_2;
    [self addChild:labelflowerBulletsPlayerOne3];
     NSLog(@"%f %d",labelflowerBulletsPlayerOne3.frame.size.height/2,position*3-position/2);
    
    monstersDeadPlayerOne = 0;
    missileExplodedPlayerOne = 0;
    
    [self addMonstersForPlayer:1];
}


-(void)createPlayer2Map{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self addFlowerCommand:2];
    SKSpriteNode *flower = [SKSpriteNode spriteNodeWithImageNamed:@"flower.png"];
    float width = sizeGlobal.width-flower.size.width/2 + 10;
    
    flowerBulletsPlayerTwo1 = 10;
    flowerBulletsPlayerTwo2 = 10;
    flowerBulletsPlayerTwo3 = 10;
    
    //Label Informing Missiles Exploded
    labelMissilesExplodedPlayerTwo = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelMissilesExplodedPlayerTwo.text = [NSString stringWithFormat:@"Missiles Exploded: %d",missileExplodedPlayerTwo];
    labelMissilesExplodedPlayerTwo.fontSize = 20;
    labelMissilesExplodedPlayerTwo.position = CGPointMake(sizeGlobal.width/2+labelMissilesExplodedPlayerTwo.frame.size.height,sizeGlobal.height-labelMissilesExplodedPlayerTwo.frame.size.width/2-10);
    labelMissilesExplodedPlayerTwo.zPosition = 3;
    labelMissilesExplodedPlayerTwo.zRotation = M_PI_2;
    [self addChild:labelMissilesExplodedPlayerTwo];
    NSLog(@"%f %f", sizeGlobal.width/2+labelMissilesExplodedPlayerTwo.frame.size.height, sizeGlobal.height-labelMissilesExplodedPlayerTwo.frame.size.width/2-10);
    
    labelflowerBulletsPlayerTwo1 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerTwo1.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo1];
    labelflowerBulletsPlayerTwo1.fontSize = 30;
    labelflowerBulletsPlayerTwo1.position = CGPointMake( width ,position*1-position/2);
    labelflowerBulletsPlayerTwo1.zPosition = 3;
    labelflowerBulletsPlayerTwo1.scale = 0.5;
    labelflowerBulletsPlayerTwo1.zRotation = M_PI_2;
    [self addChild:labelflowerBulletsPlayerTwo1];
    NSLog(@"%f %d", labelflowerBulletsPlayerTwo1.frame.size.height/2,position*1-position/2);
    
    labelflowerBulletsPlayerTwo2 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerTwo2.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo2];
    labelflowerBulletsPlayerTwo2.fontSize = 30;
    labelflowerBulletsPlayerTwo2.position = CGPointMake( width ,position*2-position/2);
    labelflowerBulletsPlayerTwo2.zPosition = 3;
    labelflowerBulletsPlayerTwo2.scale = 0.5;
    labelflowerBulletsPlayerTwo2.zRotation = M_PI_2;
    [self addChild:labelflowerBulletsPlayerTwo2];
    NSLog(@"%f %d",labelflowerBulletsPlayerTwo2.frame.size.height/2,position*2-position/2);
    
    labelflowerBulletsPlayerTwo3 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
    labelflowerBulletsPlayerTwo3.text = [NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo3];
    labelflowerBulletsPlayerTwo3.fontSize = 30;
    labelflowerBulletsPlayerTwo3.position = CGPointMake( width ,position*3-position/2);
    labelflowerBulletsPlayerTwo3.zPosition = 3;
    labelflowerBulletsPlayerTwo3.scale = 0.5;
    labelflowerBulletsPlayerTwo3.zRotation = M_PI_2;
    [self addChild:labelflowerBulletsPlayerTwo3];
    NSLog(@"%f %d",labelflowerBulletsPlayerTwo3.frame.size.height/2,position*3-position/2);
    
    monstersDeadPlayerTwo = 0;
    missileExplodedPlayerTwo = 0;
    
    [self addMonstersForPlayer:2];

    
}



-(void)addMonstersForPlayer:(int)player{
    [self addMonstersBetweenSpace:1 forPlayer:player];
    [self addMonstersBetweenSpace:2 forPlayer:player];
}


-(void)addMonstersBetweenSpace:(int)spaceOrder forPlayer:(int)player{
    
    CGFloat rotate;
    int comeca;
    if(player == 1){
        rotate = -M_PI_2;
        comeca = 0;
    } else{
        rotate = M_PI_2;
        comeca = sizeGlobal.width;
    }
    
    for(int i = 0; i< 3; i++){
        int giveDistanceToMonsters = 60 * i -60;
        
        SKSpriteNode *monster;
        CGMutablePathRef path = CGPathCreateMutable();
        
        int randomMonster = [self getRandomNumberBetween:0 to:1];
        if(randomMonster == 0){
            monster = [SKSpriteNode spriteNodeWithImageNamed:@"protectCreature4"];
            
            CGFloat offsetX = monster.frame.size.width * monster.anchorPoint.x;
            CGFloat offsetY = monster.frame.size.height * monster.anchorPoint.y;
            CGPathMoveToPoint(path, NULL, 10 - offsetX, 1 - offsetY);
            CGPathAddLineToPoint(path, NULL, 42 - offsetX, 0 - offsetY);
            CGPathAddLineToPoint(path, NULL, 49 - offsetX, 13 - offsetY);
            CGPathAddLineToPoint(path, NULL, 51 - offsetX, 29 - offsetY);
            CGPathAddLineToPoint(path, NULL, 50 - offsetX, 42 - offsetY);
            CGPathAddLineToPoint(path, NULL, 42 - offsetX, 59 - offsetY);
            CGPathAddLineToPoint(path, NULL, 29 - offsetX, 67 - offsetY);
            CGPathAddLineToPoint(path, NULL, 19 - offsetX, 67 - offsetY);
            CGPathAddLineToPoint(path, NULL, 5 - offsetX, 53 - offsetY);
            CGPathAddLineToPoint(path, NULL, 0 - offsetX, 34 - offsetY);
            CGPathAddLineToPoint(path, NULL, 1 - offsetX, 15 - offsetY);
            CGPathCloseSubpath(path);

        } else {
            monster = [SKSpriteNode spriteNodeWithImageNamed:@"protectCreature2"];
            
            CGFloat offsetX = monster.frame.size.width * monster.anchorPoint.x;
            CGFloat offsetY = monster.frame.size.height * monster.anchorPoint.y;
            CGPathMoveToPoint(path, NULL, 0 - offsetX, 1 - offsetY);
            CGPathAddLineToPoint(path, NULL, 47 - offsetX, 1 - offsetY);
            CGPathAddLineToPoint(path, NULL, 47 - offsetX, 24 - offsetY);
            CGPathAddLineToPoint(path, NULL, 40 - offsetX, 43 - offsetY);
            CGPathAddLineToPoint(path, NULL, 28 - offsetX, 53 - offsetY);
            CGPathAddLineToPoint(path, NULL, 19 - offsetX, 53 - offsetY);
            CGPathAddLineToPoint(path, NULL, 8 - offsetX, 44 - offsetY);
            CGPathAddLineToPoint(path, NULL, 1 - offsetX, 26 - offsetY);
            CGPathCloseSubpath(path);

        }
        
        monster.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        monster.physicsBody.dynamic = YES;
        monster.physicsBody.categoryBitMask = MonsterCategory;
        monster.physicsBody.contactTestBitMask = MissileCategory;
        monster.physicsBody.collisionBitMask = 0;
        
        monster.zPosition = 2;
        monster.scale = 0.8;
        monster.zPosition = 2;
        monster.zRotation = rotate;
        monster.position = player == 1 ? CGPointMake(monster.size.height/2,position*spaceOrder-(giveDistanceToMonsters)) : CGPointMake(comeca-monster.size.height/2,position*spaceOrder-(giveDistanceToMonsters));
        [self addChild:monster];
    }
    
}


-(void)addFlowerCommand:(int)player{
    
    for(int i=1;i<=3;i++){
        SKSpriteNode *flower = [SKSpriteNode spriteNodeWithImageNamed:@"flower.png"];
        flower.zPosition = 2;
        flower.scale = 0.5;
        
        int xCoord;
        if(player == 1){
            xCoord = 0+flower.size.width/2;
            flower.zRotation = -M_PI_2;
        } else{
            xCoord = sizeGlobal.width-flower.size.width/2;
            flower.zRotation = M_PI_2;
        }
        
        flower.position = CGPointMake(xCoord,position*i-position/2);
        [self addChild:flower];
    }
}

-(void)addMissilesFromSky:(CGSize)size{
    
    //define number of missiles in one time
    int numberMissiles = [self getRandomNumberBetween:0 to:3];
    
    for(int i = 0; i < numberMissiles; i++){
        SKSpriteNode *missile;
        missile = [SKSpriteNode spriteNodeWithImageNamed:@"enemyMissile"];
        missile.scale = 0.4;
        missile.zPosition = 1;
        
        missile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:missile.size.height/2];
        missile.physicsBody.dynamic = NO;
        missile.physicsBody.categoryBitMask = MissileCategory;
        missile.physicsBody.contactTestBitMask = ExplosionCategory | MonsterCategory;
        missile.physicsBody.collisionBitMask = 0;
        
        int startPoint = [self getRandomNumberBetween:0 to:size.height];
        int endPoint = [self getRandomNumberBetween:0 to:size.height];
        
        //player1
        SKSpriteNode *missile1;
        missile1 = [SKSpriteNode spriteNodeWithImageNamed:@"enemyMissile"];
        missile1.scale = 0.4;
        missile1.zPosition = 1;
        
        missile1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:missile.size.height/2];
        missile1.physicsBody.dynamic = NO;
        missile1.physicsBody.categoryBitMask = MissileCategory;
        missile1.physicsBody.contactTestBitMask = ExplosionCategory | MonsterCategory;
        missile1.physicsBody.collisionBitMask = 0;
        missile1.position = CGPointMake(size.width/2,size.height-startPoint);
        
        SKAction *move1 =[SKAction moveTo:CGPointMake(size.width,size.height-endPoint) duration:15];
        SKAction *remove1 = [SKAction removeFromParent];
        [missile1 runAction:[SKAction sequence:@[move1,remove1]]];
        [self addChild:missile1];
        
        startPoint = [self getRandomNumberBetween:0 to:size.height];
        endPoint = [self getRandomNumberBetween:0 to:size.height];

        
        //player2
        SKSpriteNode *missile2;
        missile2 = [SKSpriteNode spriteNodeWithImageNamed:@"enemyMissile"];
        missile2.scale = 0.4;
        missile2.zPosition = 1;
        
        missile2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:missile.size.height/2];
        missile2.physicsBody.dynamic = NO;
        missile2.physicsBody.categoryBitMask = MissileCategory;
        missile2.physicsBody.contactTestBitMask = ExplosionCategory | MonsterCategory;
        missile2.physicsBody.collisionBitMask = 0;
        missile2.position = CGPointMake(size.width/2,size.height-startPoint);
        
        SKAction *move2 =[SKAction moveTo:CGPointMake(0 ,size.height-endPoint) duration:15];
        SKAction *remove2 = [SKAction removeFromParent];
        [missile2 runAction:[SKAction sequence:@[move2,remove2]]];
        [self addChild:missile2];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //don't let bullets go to flower's bottom
        if(location.x < 60 || sizeGlobal.width-location.x < 60)
            return;
        
        int bulletBeginning = 0;
        
        if(sizeGlobal.width/2 > location.x){ //player1
            if(location.y >= 0 && location.y < position){
                bulletBeginning = position-position/2;
                if(flowerBulletsPlayerOne1 > 0)
                    flowerBulletsPlayerOne1--;
                else{
                    if(flowerBulletsPlayerOne1 == 0 && flowerBulletsPlayerOne2 > 0){
                        flowerBulletsPlayerOne2--;
                        [labelflowerBulletsPlayerOne2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne2]];
                        bulletBeginning = [self positionOfWhichFlowerShouldBegin:2];
                    } else if(flowerBulletsPlayerOne3 > 0){
                        flowerBulletsPlayerOne3--;
                        [labelflowerBulletsPlayerOne3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne3]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                    } else{
                        return;
                    }
                }
                [labelflowerBulletsPlayerOne1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne1]];
                
            }
            else if((location.y >= position && location.y < position*2)){
                bulletBeginning = position*2-position/2;
                if(flowerBulletsPlayerOne2 > 0)
                    flowerBulletsPlayerOne2--;
                else{
                    if(location.y < sizeGlobal.height/2){ //bullets of the center over and needs to decide the most closest
                        if(flowerBulletsPlayerOne1 > 0){
                            flowerBulletsPlayerOne1--;
                            [labelflowerBulletsPlayerOne1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne1]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                        } else if (flowerBulletsPlayerOne3 > 0){
                            flowerBulletsPlayerOne3--;
                            [labelflowerBulletsPlayerOne3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne3]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                        } else{
                            return;
                        }
                    } else{
                        if(flowerBulletsPlayerOne3 > 0){
                            flowerBulletsPlayerOne3--;
                            [labelflowerBulletsPlayerOne3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne3]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                        }
                        else if (flowerBulletsPlayerOne1 > 0){
                            flowerBulletsPlayerOne1--;
                            [labelflowerBulletsPlayerOne1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne1]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                        }
                        else{
                            return;
                        }
                    }
                    
                }
                [labelflowerBulletsPlayerOne2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne2]];
            }
            else{
                bulletBeginning = position*3-position/2;
                if(flowerBulletsPlayerOne3 > 0)
                    flowerBulletsPlayerOne3--;
                else{
                    if(flowerBulletsPlayerOne3 == 0 && flowerBulletsPlayerOne2 > 0){
                        flowerBulletsPlayerOne2--;
                        [labelflowerBulletsPlayerTwo2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne2]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:2];
                    }
                    else if(flowerBulletsPlayerOne1 > 0){
                        flowerBulletsPlayerOne1--;
                        [labelflowerBulletsPlayerOne1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne1]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                    }
                    else{
                        return;
                    }
                }
                [labelflowerBulletsPlayerOne3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerOne3]];
            }
        }
        else{ //player2
            if(location.y >= 0 && location.y < position){
                bulletBeginning = position-position/2;
                if(flowerBulletsPlayerTwo1 > 0)
                    flowerBulletsPlayerTwo1--;
                else{
                    if(flowerBulletsPlayerTwo1 == 0 && flowerBulletsPlayerTwo2 > 0){
                        flowerBulletsPlayerTwo2--;
                        [labelflowerBulletsPlayerTwo2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo2]];
                        bulletBeginning = [self positionOfWhichFlowerShouldBegin:2];
                    }
                    else if(flowerBulletsPlayerTwo3 > 0){
                        flowerBulletsPlayerTwo3--;
                        [labelflowerBulletsPlayerTwo3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo3]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                    }
                    else{
                        return;
                    }
                }
                [labelflowerBulletsPlayerTwo1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo1]];
                
            }
            else if((location.y >= position && location.y < position*2)){
                bulletBeginning = position*2-position/2;
                if(flowerBulletsPlayerTwo2 > 0)
                    flowerBulletsPlayerTwo2--;
                else{
                    if(location.y < sizeGlobal.height/2){ //bullets of the center over and needs to decide the most closest
                        if(flowerBulletsPlayerTwo1 > 0){
                            flowerBulletsPlayerTwo1--;
                            [labelflowerBulletsPlayerTwo1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo1]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                        }
                        else if (flowerBulletsPlayerTwo3 > 0){
                            flowerBulletsPlayerTwo3--;
                            [labelflowerBulletsPlayerTwo3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo3]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                        }
                        else{
                            return;
                        }
                    }
                    else{
                        if(flowerBulletsPlayerTwo3 > 0){
                            flowerBulletsPlayerTwo3--;
                            [labelflowerBulletsPlayerTwo3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo3]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                        }
                        else if (flowerBulletsPlayerTwo1 > 0){
                            flowerBulletsPlayerTwo1--;
                            [labelflowerBulletsPlayerTwo1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo1]];
                            bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                        }
                        else{
                            return;
                        }
                    }
                    
                    
                }
                [labelflowerBulletsPlayerTwo2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo2]];
            }
            else{
                bulletBeginning = position*3-position/2;
                if(flowerBulletsPlayerTwo3 > 0)
                    flowerBulletsPlayerTwo3--;
                else{
                    if(flowerBulletsPlayerTwo3 == 0 && flowerBulletsPlayerTwo2 > 0){
                        flowerBulletsPlayerTwo2--;
                        [labelflowerBulletsPlayerTwo2 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo2]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:2];
                    }
                    else if(flowerBulletsPlayerTwo1 > 0){
                        flowerBulletsPlayerTwo1--;
                        [labelflowerBulletsPlayerTwo1 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo1]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                    }
                    else{
                        return;
                    }
                }
                [labelflowerBulletsPlayerTwo3 setText:[NSString stringWithFormat:@"%d",flowerBulletsPlayerTwo3]];
            }
        }
        
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithImageNamed:@"flowerBullet"];
        bullet.zPosition = 1;
        bullet.scale = 0.4;
        float duration = 0;
        
        if(sizeGlobal.width/2 > location.x){
            bullet.position = CGPointMake(55,bulletBeginning);
            duration = (3 * location.x) / (sizeGlobal.width/2);
        }
        else{
            bullet.position = CGPointMake(sizeGlobal.width-55,bulletBeginning);
            duration = (3 * location.x) / (sizeGlobal.width/2); //todo: need new calculation for the duration for player 2 bullets
        }
        bullet.color = [SKColor redColor];
        bullet.colorBlendFactor = 0.5;
        
        //calculate duration
//        float duration = (3 * location.x)/(sizeGlobal.width/2);
        NSLog(@"duration:%f", duration);
        
        SKAction *move =[SKAction moveTo:CGPointMake(location.x,location.y) duration:duration];
        SKAction *remove = [SKAction removeFromParent];
        
        // Explosion
        SKAction *callExplosion = [SKAction runBlock:^{
            SKSpriteNode *explosion = [SKSpriteNode spriteNodeWithImageNamed:@"explosion"];
            explosion.zPosition = 3;
            explosion.scale = 0.1;
            explosion.position = CGPointMake(location.x,location.y);
            explosion.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:explosion.size.height/2];
            explosion.physicsBody.dynamic = YES;
            explosion.physicsBody.categoryBitMask = ExplosionCategory;
            explosion.physicsBody.contactTestBitMask = MissileCategory;
            explosion.physicsBody.collisionBitMask = 1;
            SKAction *explosionAction = [SKAction scaleTo:0.8 duration:1.5];
            [explosion runAction:[SKAction sequence:@[explosionAction,remove]]];
            [self addChild:explosion];
        }];
        
        [bullet runAction:[SKAction sequence:@[move, callExplosion, remove]]];
        [self addChild:bullet];
        
    }
}


-(int)positionOfWhichFlowerShouldBegin:(int)number{
    return position*number-position/2;
}


-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if ((firstBody.categoryBitMask & ExplosionCategory) != 0) {
        SKNode *missile = (contact.bodyA.categoryBitMask & ExplosionCategory) ? contact.bodyB.node : contact.bodyA.node;
        [missile runAction:[SKAction removeFromParent]];
        NSLog(@"Kill Missile");
        
        if(missile.position.x < sizeGlobal.width/2){
            missileExplodedPlayerOne++;
            [labelMissilesExplodedPlayerOne setText:[NSString stringWithFormat:@"Missiles Exploded: %d",missileExplodedPlayerOne]];
        } else{
            missileExplodedPlayerTwo++;
            [labelMissilesExplodedPlayerTwo setText:[NSString stringWithFormat:@"Missiles Exploded: %d",missileExplodedPlayerTwo]];
        }
        
        
        if(missileExplodedPlayerOne == 20){
            SKLabelNode *ganhou = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            ganhou.text = @"You Win";
            ganhou.fontSize = 40;
            ganhou.zRotation = -M_PI_2;
            ganhou.position = CGPointMake(sizeGlobal.width/3,sizeGlobal.height/2);
            ganhou.zPosition = 3;
            [self addChild:ganhou];
            
            SKLabelNode *perdeu = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            perdeu.text = @"You lost";
            perdeu.fontSize = 40;
            perdeu.zRotation = M_PI_2;
            perdeu.position = CGPointMake(sizeGlobal.width/3*2,sizeGlobal.height/2);
            perdeu.zPosition = 3;
            [self addChild:perdeu];
            [self runAction:[SKAction waitForDuration:2.0] completion:^{
                [self moveToMenu];
            }];
        }
        if(missileExplodedPlayerTwo == 20){
            SKLabelNode *ganhou = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            ganhou.text = @"You Win";
            ganhou.fontSize = 40;
            ganhou.zRotation = M_PI_2;
            ganhou.position = CGPointMake(sizeGlobal.width/3*2,sizeGlobal.height/2);
            ganhou.zPosition = 3;
            [self addChild:ganhou];
            
            SKLabelNode *perdeu = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            perdeu.text = @"You lost";
            perdeu.fontSize = 40;
            perdeu.zRotation = -M_PI_2;
            perdeu.position = CGPointMake(sizeGlobal.width/3,sizeGlobal.height/2);
            perdeu.zPosition = 3;
            [self addChild:perdeu];
            [self runAction:[SKAction waitForDuration:2.0] completion:^{
                [self moveToMenu];
            }];
        }
        
    } else if ((contact.bodyA.categoryBitMask == MonsterCategory && contact.bodyB.categoryBitMask == MissileCategory) ||
               (contact.bodyB.categoryBitMask == MonsterCategory && contact.bodyA.categoryBitMask == MissileCategory)) {
         NSLog(@"Monster killed!");
        SKNode *missile = (contact.bodyA.categoryBitMask & MonsterCategory) ? contact.bodyA.node : contact.bodyB.node;
        SKNode *monster = (contact.bodyA.categoryBitMask & MonsterCategory) ? contact.bodyB.node : contact.bodyA.node;
        [missile runAction:[SKAction removeFromParent]];
        [monster runAction:[SKAction removeFromParent]];
        
        if(monster.position.x < sizeGlobal.width/2){
            monstersDeadPlayerOne++;
        } else{
            monstersDeadPlayerTwo++;
        }
       
        
        if(monstersDeadPlayerOne == 6){
            SKLabelNode *ganhou = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            ganhou.text = @"You Win";
            ganhou.fontSize = 40;
            ganhou.zRotation = M_PI_2;
            ganhou.position = CGPointMake(sizeGlobal.width/3*2,sizeGlobal.height/2);
            ganhou.zPosition = 3;
            [self addChild:ganhou];
            
            SKLabelNode *perdeu = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            perdeu.text = @"You lost";
            perdeu.fontSize = 40;
            perdeu.zRotation = -M_PI_2;
            perdeu.position = CGPointMake(sizeGlobal.width/3,sizeGlobal.height/2);
            perdeu.zPosition = 3;
            [self addChild:perdeu];
            [self runAction:[SKAction waitForDuration:2.0] completion:^{
                [self moveToMenu];
            }];

        }
        if(monstersDeadPlayerTwo == 6){
            SKLabelNode *ganhou = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            ganhou.text = @"You Win";
            ganhou.fontSize = 40;
            ganhou.zRotation = -M_PI_2;
            ganhou.position = CGPointMake(sizeGlobal.width/3,sizeGlobal.height/2);
            ganhou.zPosition = 3;
            [self addChild:ganhou];
            
            SKLabelNode *perdeu = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
            perdeu.text = @"You lost";
            perdeu.fontSize = 40;
            perdeu.zRotation = M_PI_2;
            perdeu.position = CGPointMake(sizeGlobal.width/3*2,sizeGlobal.height/2);
            perdeu.zPosition = 3;
            [self addChild:perdeu];
            [self runAction:[SKAction waitForDuration:2.0] completion:^{
                [self moveToMenu];
            }];
        }
        
    }
    
}

-(void)moveToMenu{
    SKTransition* transition = [SKTransition fadeWithDuration:2];
    MenuScene* myscene = [[MenuScene alloc] initWithSize:CGSizeMake(self.frame.size.height, self.frame.size.width)];
    [self.scene.view presentScene:myscene transition:transition];
}


-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end