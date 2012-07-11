//Copytright(c) 2011 Hongbo Yang (hongbo@yang.me). All rights reserved
//This file is part of YToolkit.
//
//YToolkit is free software: you can redistribute it and/or modify
//it under the terms of the GNU Lesser General Public License as 
//published by the Free Software Foundation, either version 3 of 
//the License, or (at your option) any later version.
//
//YToolkit is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU Lesser General Public License for more details.
//
//You should have received a copy of the GNU Lesser General Public 
//License along with YToolkit.  If not, see <http://www.gnu.org/licenses/>.
//


#ifndef ybase64_h
#define ybase64_h

#include "ydefines.h"

//typedef void (*ybase64_write_callback)(const void * data, 
//                                 const size_t len, 
//                                 const void * context);
//
//typedef size_t (*ybase64_read_callback)(const void * data, 
//                                        const size_t max, 
//                                        const size_t to_read
//                                        const void * context);

//version: 0.9
#define YBASE64_VERSION_MAJOR 0
#define YBASE64_VERSION_MINOR 9

YEXTERN size_t ybase64_encode( IN const void * from, 
                              IN const size_t from_len,
                              OUT void * to, 
                              IN const size_t to_len);
YEXTERN void * ybase64_encode_alloc( IN const void * from, 
                                    IN const size_t from_len,
                                    OUT size_t *to_len);
YEXTERN size_t ybase64_decode( IN const char * from, //input must be an Base64 encoded text
                              IN const size_t strlen,  // must be a string length, (minus \0)
                              OUT void * to, 
                              IN const size_t to_len);
YEXTERN void * ybase64_decode_alloc( IN const void * from, 
                                    IN const size_t from_len,
                                    OUT size_t *to_len);

#endif