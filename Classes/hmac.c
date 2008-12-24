//
// hmac.c
//
//  Copyright 2008 Gabriel Handford
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

#include <string.h>

#include "hmac.h"
#include "sha1.h"

#define HMAC_IPAD	0x36
#define HMAC_OPAD	0x5c

int HMAC_SHA1(unsigned char* digest, unsigned char* text, unsigned int textlen, unsigned char* key, unsigned int keylen) {  
  
  unsigned char k_ipad[64], k_opad[64];
  
  // This is untested
  if (keylen > 64) {
    SHA1_CTX context;
    SHA1Init(&context);  
    SHA1Update(&context, key, keylen);
    SHA1Final(key, &context);
    keylen = 20;
  }
  
  memcpy(k_ipad, key, keylen);
  memcpy(k_opad, key, keylen);
  memset(k_ipad+keylen, 0, 64 - keylen);
  memset(k_opad+keylen, 0, 64 - keylen);
  
  unsigned int i;
  for (i = 0; i < 64; i++) {
		k_ipad[i] ^= HMAC_IPAD;
		k_opad[i] ^= HMAC_OPAD;
	}  
  
  SHA1_CTX context;
  SHA1Init(&context);  
  SHA1Update(&context, k_ipad, 64);
  SHA1Update(&context, text, textlen);  
  SHA1Final(digest, &context);
  
  SHA1Init(&context);
  SHA1Update(&context, k_opad, 64);
  SHA1Update(&context, digest, 20);
  SHA1Final(digest, &context);
  
  return 20;
}
