/*
 *  hmac.h
 *  S3Hub
 *
 *  Created by Gabe on 7/2/08.
 *  Copyright 2008 ducktyper.com. All rights reserved.
 *
 */

int HMAC_SHA1(unsigned char* digest, unsigned char* text, unsigned int textlen, unsigned char* key, unsigned int keylen);