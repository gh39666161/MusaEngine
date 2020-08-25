#pragma once

// Marcos
#define ENGINE_BEGIN() namespace Engine {
#define ENGINE_END() };
#define USE_ENGINE() using namespace Engine;
#define ENGINE Engine;

#define CHECK(X) assert(X);
#define GMODULE(MODULE) MODULE::GetModule<MODULE>()

#ifdef __OBJC__
#define OBJC_CLASS(name) @class name
#else
#define OBJC_CLASS(name) typedef struct objc_object name
#endif

ENGINE_BEGIN()
// Types
typedef unsigned char       uint8;
typedef unsigned short int  uint16;
typedef unsigned int        uint32;
typedef unsigned long long  uint64;

typedef signed char         int8;
typedef signed short int    int16;
typedef signed int          int32;
typedef signed long long    int64;

typedef char                ANSICHAR;
typedef wchar_t             WIDECHAR;

ENGINE_END()
