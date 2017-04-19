//
//  MPDocument+HistoryBrowsing.m
//  MacPass
//
//  Created by Michael Starke on 26.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#import "MPDocument.h"

NSString *const MPDocumentShowEntryHistoryNotification = @"MPDocumentShowEntryHistoryNotification";
NSString *const MPDocumentHideEntryHistoryNotification  = @"MPDocumentHideEntryHistoryNotification";

@implementation MPDocument (HistoryBrowsing)

- (void)showEntryHistory:(id)sender {
  id<MPTargetNodeResolving> resolver = [NSApp targetForAction:@selector(currentTargetEntries)];
  NSArray *entries = resolver.currentTargetEntries;
  if(entries.count != 1) {
    return; // only single selection is used
  }
  if(self.hasSearch) {
    [self exitSearch:sender];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:MPDocumentShowEntryHistoryNotification
                                                      object:self
                                                    userInfo:@{ MPDocumentEntryKey: entries.firstObject }];
}

- (void)hideEntryHistory:(id)sender {
  [[NSNotificationCenter defaultCenter] postNotificationName:MPDocumentHideEntryHistoryNotification
                                                      object:self];
}


@end
