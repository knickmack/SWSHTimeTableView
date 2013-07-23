//
//  SWSHTimeTableViewCell.m
//  SWSHTimeTableViewExample
//
//  Created by Nik Macintosh on 2013-07-22.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "SWSHTimeTableViewCell.h"

@interface SWSHTimeTableViewCell ()

@property (strong, nonatomic, readonly) UILabel *label;

@end

@implementation SWSHTimeTableViewCell

@synthesize label = _label;

#pragma mark - SWSHTimeTableViewCell

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

- (void)setTime:(NSDate *)time {
    _time = time;
    
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [NSDateFormatter new];
        
        _dateFormatter.dateFormat = @"hmm";
    });
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[_dateFormatter stringFromDate:time]];
    NSUInteger halfAttributedTextLength = attributedText.length / 2;
    NSUInteger remainderAttributedTextLength = attributedText.length - halfAttributedTextLength;
    
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.f] range:NSMakeRange(0, halfAttributedTextLength)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.f] range:NSMakeRange(halfAttributedTextLength, remainderAttributedTextLength)];
    [attributedText addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(halfAttributedTextLength, remainderAttributedTextLength)];
    
    self.label.attributedText = attributedText;
}

#pragma mark - UICollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.label.textColor = [UIColor colorWithWhite:selected alpha:1.f];
}

#pragma mark - UICollectionReusableView

- (void)prepareForReuse {
    _time = nil;

    [super prepareForReuse];
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self.contentView addSubview:self.label];
    
    self.selectedBackgroundView = [UIView new];
    self.selectedBackgroundView.backgroundColor = [UIColor purpleColor];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.contentView.bounds;
}

@end
