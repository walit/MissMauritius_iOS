//
//  IQPopUp.h
//  myleastprice
//
//  Created by gate6 on 5/25/16.
//  Copyright © 2016 Gate6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
@interface IQPopUp : UIView
@property (nonatomic,assign) CGRect showOnRect;
@property (nonatomic,assign) int popWidth;
@property (nonatomic,assign) CGRect fieldFrame;
@property (nonatomic,copy) NSString *strMsg;
@property (nonatomic,retain) UIColor *popUpColor;
@end
