//
//  GHNSAttributedString+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 4/9/11.
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

#import "GHNSAttributedString+Utils.h"


@implementation NSAttributedString(GHUtils)

+ (id)gh_linkFromString:(NSString *)string URL:(NSURL *)URL color:(NSColor *)color isUnderlined:(BOOL)isUnderlined {
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
  NSRange range = NSMakeRange(0, [attributedString length]);
 	
  [attributedString beginEditing];
  [attributedString addAttribute:NSLinkAttributeName value:[URL absoluteString] range:range];
 	
  if (color) {
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
  }
 	
  if (isUnderlined) {
    [attributedString addAttribute:
     NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSSingleUnderlineStyle] range:range];
  }
 	
  [attributedString endEditing];
 	
  return [attributedString autorelease];
}

@end
