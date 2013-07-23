//
//  SWSHTimeTableView.m
//  
//
//  Created by Nik Macintosh on 2013-07-22.
//
//

#import "SWSHTimeTableView.h"
#import "SWSHTimeTableViewCell.h"

@implementation NSDate (SWSHTimeTableView)

- (NSDate *)dateByAddingOneDay {
    return [self dateByAddingTimeInterval:60*60*24.0];
}

- (NSDate *)dateByAddingOneHour {
    return [self dateByAddingTimeInterval:60*60.0];
}

- (NSDate *)dateByAddingOneYear {
    return [self dateByAddingTimeInterval:60*60*24*365.0];
}

- (NSDate *)dateByAddingThirtyMinutes {
    return [self dateByAddingTimeInterval:60*30.0];
}

@end

static NSString *CellIdentifier = @"Cell";

@interface SWSHTimeTableView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *times;

@end

@implementation SWSHTimeTableView

@synthesize collectionView = _collectionView;
@synthesize times = _times;

#pragma mark - SWSHTimeTableView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *_collectionViewLayout = [UICollectionViewFlowLayout new];
        
        _collectionViewLayout.minimumInteritemSpacing = 0.f;
        _collectionViewLayout.minimumLineSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_collectionViewLayout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        
        [_collectionView registerClass:[SWSHTimeTableViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    
    return _collectionView;
}

- (void)setDay:(NSDate *)day {
    _day = day;
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSUInteger units = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *components = [currentCalendar components:units fromDate:day];
    
    components.hour = 0;
    components.minute = 0;
    
    NSMutableArray *mutableTimes = [@[] mutableCopy];

    for (NSDate *d = [currentCalendar dateFromComponents:components], *l = [d dateByAddingOneDay]; [d compare:l] == NSOrderedAscending; d = [d dateByAddingOneHour]) {
        [mutableTimes addObject:d];
        [mutableTimes addObject:[d dateByAddingThirtyMinutes]];
    }
    
    self.times = [mutableTimes copy];
}

- (NSArray *)times {
    if (!_times) {
        _times = @[];
    }
    
    return _times;
}

- (void)setTimes:(NSArray *)times {
    _times = times;
    
    [self.collectionView reloadData];
}

- (void)commonInit {
    _rowHeight = 32.f;
    _numberOfColumns = 5;
    
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.times.count;
}

- (SWSHTimeTableViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWSHTimeTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDate *time = self.times[indexPath.item];
    
    cell.time = time;
    cell.backgroundColor = indexPath.row < self.times.count / 2 ? [UIColor whiteColor] : [UIColor lightGrayColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.delegate respondsToSelector:@selector(timeTableView:didSelectTime:)]) {
        return;
    }
    
    [self.delegate timeTableView:self didSelectTime:self.times[indexPath.item]];
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width / self.numberOfColumns, self.rowHeight)];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

@end
