//
//  GHUIResponder.h
//
//  Created by Gabriel Handford on 1/8/09.
//  Copyright 2009 Gabriel Handford
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/*!
 Custom responder protocol used by GHUITextField.
 @ingroup iPhone
 */
@protocol GHUIResponder 
// We need a different return type than nextResponder, so we use nextToRespond and previousToRespond,
// instead of using UIResponder.
- (id<GHUIResponder>)nextToRespond; 
- (id<GHUIResponder>)previousToRespond;
- (void)setNextToRespond:(id<GHUIResponder>)nextToRespond;
- (void)setPreviousToRespond:(id<GHUIResponder>)previousToRespond;

// Set the previous and next responders from the next responder
- (void)setResponders:(id<GHUIResponder>)nextToRespond;

// From UIResponder
- (BOOL)resignFirstResponder;
- (BOOL)becomeFirstResponder;

@end

