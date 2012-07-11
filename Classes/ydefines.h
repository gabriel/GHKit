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


#ifndef oauth_ydefines_h
#define oauth_ydefines_h

#ifndef __has_extension
#define __has_extension(x) 0
#endif

#ifdef __cplusplus
#define YEXTERN extern "C"
#else
#define YEXTERN extern
#endif

#define IN
#define OUT
#define INOUT

#if __has_extension(attribute_unavailable_with_message)
#define NOTTESTED __attribute__((unavailable("it is currently not TESTED!")))
#else
#define NOTTESTED
#endif


#endif