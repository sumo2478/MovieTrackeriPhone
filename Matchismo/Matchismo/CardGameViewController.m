//
//  CardGameViewController.m
//  Matchismo
//
//  Created by user on 13/12/18.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *myDeck;

@end

@implementation CardGameViewController

- (Deck *)myDeck
{
    if (!_myDeck) _myDeck = [self createDeck];
    return _myDeck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}


-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *myCard = [self.myDeck drawRandomCard];
        if (myCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:myCard.contents forState:UIControlStateNormal];
        }

    }
    self.flipCount++;
    
}



@end
