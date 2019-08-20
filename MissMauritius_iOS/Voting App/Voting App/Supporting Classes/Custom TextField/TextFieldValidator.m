//
//  TextFieldValidator.m
//  Textfield Error Handle
//
//  Created by Dhawal Dawar on 22/11/12.
//  Copyright (c) 2012 Dhawal Dawar. All rights reserved.
//

#import "TextFieldValidator.h"
#import "IQPopUp.h"

@interface TextFieldValidatorSupport : NSObject<UITextFieldDelegate>

@property (nonatomic,retain) id<UITextFieldDelegate> delegate;
@property (nonatomic,assign) BOOL validateOnCharacterChanged;
@property (nonatomic,assign) BOOL validateOnResign;
@property (nonatomic,unsafe_unretained) IQPopUp *popUp;
@end

@implementation TextFieldValidatorSupport
@synthesize delegate,validateOnCharacterChanged,popUp,validateOnResign;

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [delegate textFieldShouldBeginEditing:textField];
//    if (textField.tag == 100) {
//        return NO;
//    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [delegate textFieldShouldEndEditing:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [delegate textFieldDidEndEditing:textField];
    [popUp removeFromSuperview];
    if(validateOnResign)
        [(TextFieldValidator *)textField validate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [(TextFieldValidator *)textField dismissPopup];
    textField.rightView = nil;
    if(validateOnCharacterChanged)
        [(TextFieldValidator *)textField performSelector:@selector(validate) withObject:nil afterDelay:0.1];
    else
        [(TextFieldValidator *)textField setRightView:nil];
    if([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [delegate textFieldShouldClear:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [delegate textFieldShouldReturn:textField];
    return YES;
}

-(void)setDelegate:(id<UITextFieldDelegate>)dele{
    delegate=dele;
}

@end


@interface TextFieldValidator(){
    NSString *strLengthValidationMsg;
    TextFieldValidatorSupport *supportObj;
    NSString *strMsg;
    NSMutableArray *arrRegx;
    IQPopUp *popUp;
    UIColor *popUpColor;
}

-(void)tapOnError;

@end

@implementation TextFieldValidator
@synthesize presentInView,validateOnCharacterChanged,popUpColor,isMandatory,validateOnResign;

#pragma mark - Default Methods of UIView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    arrRegx=[[NSMutableArray alloc] init];
    validateOnCharacterChanged=NO;
    isMandatory=YES;
    validateOnResign=NO;
    popUpColor=ColorPopUpBg;
    strLengthValidationMsg=[MsgValidateLength copy];
    supportObj=[[TextFieldValidatorSupport alloc] init];
    supportObj.validateOnCharacterChanged=validateOnCharacterChanged;
    supportObj.validateOnResign=validateOnResign;
    [self setValue:[UIColor lightGrayColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    NSNotificationCenter *notify=[NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(didHideKeyboard) name:UIKeyboardWillHideNotification object:nil];
    return self;
}

// override rightViewRectForBounds method:
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
   CGRect rightBounds = CGRectMake(bounds.size.width - 40, (bounds.size.height - 25)/2, 25, 25);

//    if (self.tag == 100) {
//        rightBounds = CGRectMake(bounds.size.width - 80, (bounds.size.height - 25)/2, 25, 25);
//    }
    return rightBounds ;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    if (self.tag == 100)
        return CGRectInset(bounds, 20, 10);
    else
        return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.tag == 100)
        return CGRectInset(bounds, 20, 10);
    else
        return CGRectInset(bounds, 10, 10);
}

-(void)setDelegate:(id<UITextFieldDelegate>)deleg{
    supportObj.delegate=deleg;
    super.delegate=supportObj;
}

-(void)setValidateOnCharacterChanged:(BOOL)validate{
    supportObj.validateOnCharacterChanged=validate;
    validateOnCharacterChanged=validate;
}

-(void)setValidateOnResign:(BOOL)validate{
    supportObj.validateOnResign=validate;
    validateOnResign=validate;
}

#pragma mark - Public methods
-(void)addRegx:(NSString *)strRegx withMsg:(NSString *)msg{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:strRegx,@"regx",msg,@"msg", nil];
    [arrRegx addObject:dic];
}

-(void)updateLengthValidationMsg:(NSString *)msg{
    strLengthValidationMsg=[msg copy];
}

-(void)addConfirmValidationTo:(TextFieldValidator *)txtConfirm withMsg:(NSString *)msg{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:txtConfirm,@"confirm",msg,@"msg", nil];
    [arrRegx addObject:dic];
}

-(BOOL)validate{
    if(isMandatory){
        if([self.text length]==0){
            [self showErrorIconForMsg:strLengthValidationMsg];
            return NO;
        }
    }
    for (int i=0; i<[arrRegx count]; i++) {
        NSDictionary *dic=[arrRegx objectAtIndex:i];
        if([dic objectForKey:@"confirm"]){
            TextFieldValidator *txtConfirm=[dic objectForKey:@"confirm"];
            if(![txtConfirm.text isEqualToString:self.text]){
                [self showErrorIconForMsg:[dic objectForKey:@"msg"]];
                return NO;
            }
        }else if(![[dic objectForKey:@"regx"] isEqualToString:@""] && [self.text length]!=0 && ![self validateString:self.text withRegex:[dic objectForKey:@"regx"]]){
            [self showErrorIconForMsg:[dic objectForKey:@"msg"]];
            return NO;
        }
    }
    self.rightView=nil;
    return YES;
}

-(void)dismissPopup{
    [popUp removeFromSuperview];
}


- (void)hideError{
    self.rightView = nil;
}
#pragma mark - Internal Methods

-(void)didHideKeyboard{
    [popUp removeFromSuperview];
}

-(void)tapOnError{
    [self showErrorWithMsg:strMsg];
}

- (BOOL)validateString:(NSString*)stringToSearch withRegex:(NSString*)regexString {
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [regex evaluateWithObject:stringToSearch];
}

-(void)showErrorIconForMsg:(NSString *)msg{
    UIButton *btnError=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnError addTarget:self action:@selector(tapOnError) forControlEvents:UIControlEventTouchUpInside];
    [btnError setBackgroundImage:[UIImage imageNamed:IconImageName] forState:UIControlStateNormal];
    self.rightView=btnError;
    self.rightViewMode=UITextFieldViewModeAlways;
    strMsg=[msg copy];
}

-(void)showErrorWithMsg:(NSString *)msg{
    popUp=[[IQPopUp alloc] initWithFrame:CGRectZero];
    popUp.strMsg=msg;
    popUp.popUpColor=popUpColor;
    popUp.showOnRect=[self convertRect:self.rightView.frame toView:presentInView];
    popUp.fieldFrame=[self.superview convertRect:self.frame toView:presentInView];
    popUp.backgroundColor=[UIColor clearColor];
    [presentInView addSubview:popUp];
    
    popUp.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary *dict=NSDictionaryOfVariableBindings(popUp);
    [popUp.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[popUp]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    [popUp.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[popUp]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    supportObj.popUp=popUp;
}

@end
