/*
 *  hmac.c
 *  S3Hub
 *
 *  Created by Gabe on 7/2/08.
 *  Copyright 2008 ducktyper.com. All rights reserved.
 *
 */

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