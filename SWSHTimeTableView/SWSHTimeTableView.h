//
//  SWSHTimeTableView.h
//  
//
//  Created by Nik Macintosh on 2013-07-22.
//
//

#import <UIKit/UIKit.h>

@protocol SWSHTimeTableViewDelegate;

@interface SWSHTimeTableView : UIView

@property (weak, nonatomic) NSDate *day;
@property (weak, nonatomic) id<SWSHTimeTableViewDelegate> delegate;
@property (assign, nonatomic) NSUInteger numberOfColumns;
@property (assign, nonatomic) CGFloat rowHeight;

@end

@protocol SWSHTimeTableViewDelegate <NSObject>

@optional

- (void)timeTableView:(SWSHTimeTableView *)timeTableView didSelectTime:(NSDate *)time;

@end
