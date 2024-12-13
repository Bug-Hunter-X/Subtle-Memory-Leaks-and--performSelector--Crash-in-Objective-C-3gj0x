To fix the memory leak, ensure proper object release. For the given example, no explicit `release` is needed with ARC; however, if `myString` isn't always set, you need to handle setting it to `nil` before `MyClass` is deallocated to break the retain cycle.

```objectivec
@interface MyClass : NSObject
@property (strong, nonatomic) NSString *myString;
@end

@implementation MyClass
- (void)someMethod {
    self.myString = [[NSString alloc] initWithString:@"Hello"];
    // ... some code ...
    // Consider niling out myString to break strong reference cycle when appropriate
    // self.myString = nil;
}
- (void)dealloc {
    // In case you need to explicitly release objects (very rare with ARC, but always best practice to check if you need this)
    // [self.myString release]; // Note: Only necessary in manual memory management (MRC) or if you are working with frameworks that require it 
}
@end
```

For the `performSelector` issue, always check for selector validity using `respondsToSelector:` before calling `performSelector:`.  Additionally, implement proper error handling in case of unexpected behavior

```objectivec
- (void)delayedAction:(NSString *)selectorName {
    if ([self respondsToSelector:NSSelectorFromString(selectorName)]) {
        [self performSelector:NSSelectorFromString(selectorName) withObject:nil afterDelay:2.0];
    } else {
        NSLog("Selector '%@' not found", selectorName); 
        // Handle the error gracefully, perhaps by using an alternative method or displaying a user-friendly message
    }
}
```