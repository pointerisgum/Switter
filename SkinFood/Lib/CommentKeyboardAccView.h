//
//  CommentKeyboardAccView.h
//  ThoThing
//
//  Created by KimYoung-Min on 2016. 8. 4..
//  Copyright © 2016년 youngmin.kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface CommentKeyboardAccView : UIView
//@property (nonatomic, weak) IBOutlet UIButton *btn_Add;
@property (nonatomic, weak) IBOutlet UIButton *btn_Done;
@property (nonatomic, weak) IBOutlet UIPlaceHolderTextView *tv_Contents;
@property (nonatomic, weak) IBOutlet UILabel *lb_PlaceHolder;
//@property (nonatomic, weak) IBOutlet UIView *v_InputLayer;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lc_TfWidth;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lc_Bottom;
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lc_AddWidth;
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lc_Height;
- (void)removeContents;
@end