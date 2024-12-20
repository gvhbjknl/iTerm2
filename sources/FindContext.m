//
//  FindContext.m
//  iTerm
//
//  Created by George Nachman on 10/26/13.
//
//

#import "FindContext.h"

// Default max time per iteration of search.
static const NSTimeInterval kDefaultMaxTime = 0.1;

@implementation FindContext {
    int absBlockNum_;
    NSString* substring_;
    FindOptions options_;
    int dir_;
    int offset_;
    int stopAt_;
    FindContextStatus status_;
    int matchLength_;
    NSMutableArray* results_;
    BOOL hasWrapped_;
    NSTimeInterval maxTime_;
}

@synthesize absBlockNum = absBlockNum_;
@synthesize substring = substring_;
@synthesize options = options_;
@synthesize dir = dir_;
@synthesize offset = offset_;
@synthesize stopAt = stopAt_;
@synthesize status = status_;
@synthesize matchLength = matchLength_;
@synthesize results = results_;
@synthesize hasWrapped = hasWrapped_;
@synthesize maxTime = maxTime_;

- (instancetype)init {
    self = [super init];
    if (self) {
        maxTime_ = kDefaultMaxTime;
        _lastAbsPositionsSearched = NSMakeRange(0, 0);
    }
    return self;
}

- (void)dealloc {
    [results_ release];
    [substring_ release];
    [super dealloc];
}

- (NSString *)briefDescription {
    return [NSString stringWithFormat:@"<%@: %p absBlockNum=%@ substring=%@ options=%@ dir=%@ offset=%@ stopAt=%@ status=%@ matchLength=%@ results.count=%@ hasWrapped=%@ maxTime=%@ searched=%@>",
            self.class, self, @(absBlockNum_), substring_, @(options_), @(dir_), @(offset_), @(stopAt_), @(status_), @(matchLength_), @(results_.count), @(hasWrapped_), @(maxTime_), NSStringFromRange(_lastAbsPositionsSearched)];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p absBlockNum=%@ substring=%@ options=%@ dir=%@ offset=%@ stopAt=%@ status=%@ matchLength=%@ results=%@ hasWrapped=%@ maxTime=%@ searched=%@>",
            self.class, self, @(absBlockNum_), substring_, @(options_), @(dir_), @(offset_), @(stopAt_), @(status_), @(matchLength_), results_, @(hasWrapped_), @(maxTime_), NSStringFromRange(_lastAbsPositionsSearched)];
}

- (void)copyFromFindContext:(FindContext *)other {
    self.absBlockNum = other.absBlockNum;
    self.substring = other.substring;
    self.options = other.options;
    self.mode = other.mode;
    self.dir = other.dir;
    self.offset = other.offset;
    self.stopAt = other.stopAt;
    self.status = other.status;
    self.matchLength = other.matchLength;
    self.results = other.results;
    self.hasWrapped = other.hasWrapped;
    self.maxTime = other.maxTime;
    self.lastAbsPositionsSearched = other.lastAbsPositionsSearched;
}

- (void)reset {
    self.substring = nil;
    self.results = nil;
}

- (void)removeResults {
    [self.results removeAllObjects];
}

- (void)setSubstring:(NSString *)substring {
    [substring_ autorelease];
    substring_ = [substring copy];
}

- (id)copyWithZone:(NSZone *)zone {
    FindContext *copy = [[FindContext alloc] init];
    [copy copyFromFindContext:self];
    return copy;
}

- (FindContext *)copy {
    return [self copyWithZone:nil];
}

@end
