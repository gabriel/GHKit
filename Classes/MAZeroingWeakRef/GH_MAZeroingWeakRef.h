//
//  GH_MAZeroingWeakRef.h
//  ZeroingWeakRef
//
//  Created by Michael Ash on 7/5/10.
//

#import <Foundation/Foundation.h>


@interface GH_MAZeroingWeakRef : NSObject
{
    id _target;
    BOOL _nativeZWR;
#if NS_BLOCKS_AVAILABLE
    void (^_cleanupBlock)(id target);
#endif
}

+ (BOOL)canRefCoreFoundationObjects;

+ (id)refWithTarget: (id)target;

- (id)initWithTarget: (id)target;

#if NS_BLOCKS_AVAILABLE
// ON 10.7:
// cleanup block runs while the target's memory is still
// allocated but after all dealloc methods have run
// (it runs at associated object cleanup time)
// you can use the target's pointer value but don't
// manipulate its contents!

// ON 10.6 AND BELOW:
// cleanup block runs while the global ZWR lock is held
// so make it short and sweet!
// use GCD or something to schedule execution later
// if you need to do something that may take a while
//
// it is unsafe to call -target on the weak ref from
// inside the cleanup block, which is why the target
// is passed in as a parameter
// note that you must not resurrect the target at this point!
- (void)setCleanupBlock: (void (^)(id target))block;
#endif

- (id)target;

@end

#ifndef __has_feature
#define __has_feature(feature) 0
#endif

#define GH_MAWeakVar(var)            __weak_ ## var

#if __has_feature(objc_arc_weak)

#define GH_MAWeakDeclare(var)        __weak __typeof__((var)) GH_MAWeakVar(var) = var
#define GH_MAWeakImport(var)         __typeof__((GH_MAWeakVar(var))) var = GH_MAWeakVar(var)
#define GH_MAWeakImportReturn(var)   GH_MAWeakImport(var); do { if(var == nil) return; } while(NO)

#else

#define GH_MAWeakDeclare(var)        __typeof__((var)) GH_MAWeakVar(var) = (id)[GH_MAZeroingWeakRef refWithTarget:var]
#define GH_MAWeakImport(var)         __typeof__((GH_MAWeakVar(var))) var = [(GH_MAZeroingWeakRef *)GH_MAWeakVar(var) target]
#define GH_MAWeakImportReturn(var)   GH_MAWeakImport(var); do { if(var == nil) return; } while(NO)

#endif

#define GH_MAWeakSelfDeclare()       GH_MAWeakDeclare(self)
#define GH_MAWeakSelfImport()        GH_MAWeakImport(self)
#define GH_MAWeakSelfImportReturn()  GH_MAWeakImportReturn(self)
