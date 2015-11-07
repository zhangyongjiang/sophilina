#import "Data.h"

@interface SupportedVersions : Data

@property(strong, nonatomic) NSNumber* minBuildNumber;
@property(strong, nonatomic) NSNumber* maxBuildNumber;
@property(strong, nonatomic) NSNumber* warningBuildNumber;

@end
