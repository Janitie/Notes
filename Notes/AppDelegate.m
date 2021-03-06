//
//  AppDelegate.m
//  Notes
//
//  Created by 徐琬璇 on 2017/4/27.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic, copy) NSString * shareNoteId;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self wechatRegister];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    MainTableViewController *root = [MainTableViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    [AVOSCloud setApplicationId:@"BQuc8AC0uFuUfMO2hmtirFcr-gzGzoHsz"
                      clientKey:@"UYafhCVztDte7zr1lwO8fQ7O"];


    return YES;
}

- (void)wechatRegister {
    [ShareSDK registerApp:@"1d9d0406fd4c6"
          activePlatforms:@[ @(SSDKPlatformTypeWechat) ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx7379c514e42a8c3d"
                                       appSecret:@"48e5d3bceea3e15c1016c851d88ade3b"];
                 break;
             default:
                 break;
         }
     }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options {
    
    NSString * urlStr = [url absoluteString];
    NSRange range = [urlStr rangeOfString:@"NoteApp://"];
    if (range.location < urlStr.length) {
        NSString * noteId = [urlStr substringFromIndex:10];
        NSLog(@"noteId = %@", noteId);
        NoteObject * noteObj = [NoteObject newObjectWithObjectId:noteId];
        WS(weakSelf);
        [noteObj.avObject fetchInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
            if (!error) {
                weakSelf.shareNoteId = noteObj.objectId;
                NSString * message = [NSString stringWithFormat:@"是否接受订阅《%@》？", noteObj.title];
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"共享笔记"
                                                                     message:message
                                                                    delegate:self
                                                           cancelButtonTitle:@"否"
                                                           otherButtonTitles:@"是", nil];
                [alertView show];
            }
        }];
    }
    NSLog(@"openURL = %@", url);
    NSLog(@"openOptions = %@", options);
    return YES;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [NoteService addReaderWithNoteId:self.shareNoteId
                                callback:^(BOOL isSuccess)
        {
            if (isSuccess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNotesNotification"
                                                                    object:nil];
                [MBProgressHUD showQuickTipWithText:@"已订阅"];
            } else {
                [MBProgressHUD showQuickTipWithText:@"订阅失败"];
            }
        }];
    }
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Notes"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
