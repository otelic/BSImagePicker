//
//  BSVideoCamera.h
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface BSVideoCamera : NSObject

@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;

+ (instancetype)sharedInstance;

@end
