//
// Created by mo on 2018/8/23.
//

#import "FluwxAuthHandler.h"
#import "CallResults.h"
#import "FluwxKeys.h"
#import "StringToWeChatScene.h"
#import "FluwxMethods.h"
#import "ThumbnailHelper.h"
#import "NSStringWrapper.h"

@implementation FluwxAuthHandler

- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    self = [super init];
//    if (self) {
//
//    }

    return self;
}

- (void)handleAuth:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *openId = call.arguments[@"openId"];

    BOOL done;
    if([WXApi isWXAppInstalled]) {
        done = [WXApiRequestHandler sendAuthRequestScope:call.arguments[@"scope"]
                                                   State:call.arguments[@"state"]
                                                  OpenID:(openId == (id) [NSNull null]) ? nil : openId];
    }else{
        done = [WXApiRequestHandler sendAuthRequestForWeb:call.arguments[@"scope"] State:call.arguments[@"state"] delegate:[FluwxResponseHandler defaultManager]];
    }
    result(@(done));
}

@end
