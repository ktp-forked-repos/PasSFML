unit SfmlSystem;

////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015 Christian-W. Budde (Christian@savioursofsoul.de)
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented;
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
////////////////////////////////////////////////////////////

interface

{$I Sfml.inc}

const
{$IF Defined(MSWINDOWS)}
  CSfmlSystemLibrary = 'csfml-system-2.dll';
{$ELSEIF Defined(DARWIN)}
  CSfmlSystemLibrary = 'csfml-system-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlSystemLibrary = 'csfml-system-2.so';
{$IFEND}

  CSFML_VERSION_MAJOR = 2;
  CSFML_VERSION_MINOR = 2;
  CSFML_VERSION_PATCH = 0;

  sfFalse = 0;
  sfTrue = 1;

type
  sfBool = LongInt;
  sfInt8 = ShortInt;
  sfUint8 = Byte;
  sfInt16 = SmallInt;
  sfUint16 = Word;
  sfInt32 = LongInt;
  sfUint32 = Cardinal;
  sfInt64 = Int64;
  sfUint64 = UInt64;

  PSfmlClock = Pointer;
  PSfmlMutex = Pointer;
  PSfmlThread = Pointer;

  TSfmlTime = record
    MicroSeconds: Int64;
  end;

  TSfmlVector2i = record
    X, Y: LongInt;
  end;

  TSfmlVector2u = record
    X, Y: Cardinal;
  end;

  TSfmlVector2f = record
    X, Y : Single;
  end;

  TSfmlVector3f = record
    X, Y, Z: Single;
  end;

  TSfmlInputStreamReadFunc = function (Data: Pointer; Size: sfInt64; UserData: Pointer): sfInt64; cdecl;
  TSfmlInputStreamSeekFunc = function (Position: sfInt64; UserData: Pointer): sfInt64; cdecl;
  TSfmlInputStreamTellFunc = function (UserData: Pointer): sfInt64; cdecl;
  TSfmlInputStreamGetSizeFunc = function (UserData: Pointer): sfInt64; cdecl;

  TSfmlInputStream = record
    Read: TSfmlInputStreamReadFunc;
    Seek: TSfmlInputStreamSeekFunc;
    Tell: TSfmlInputStreamTellFunc;
    GetSize: TSfmlInputStreamGetSizeFunc;
    UserData: Pointer;
  end;
  PSfmlInputStream = ^TSfmlInputStream;

{$IFDEF DynLink}
  TSfmlTimeZero = function: TSfmlTime; cdecl;
  TSfmlTimeAsSeconds = function (Time: TSfmlTime): Single; cdecl;
  TSfmlTimeAsMilliseconds = function (Time: TSfmlTime): sfInt32; cdecl;
  TSfmlTimeAsMicroseconds = function (Time: TSfmlTime): Int64; cdecl;

  TSfmlSeconds = function (Amount: Single): TSfmlTime; cdecl;
  TSfmlMilliseconds = function (Amount: sfInt32): TSfmlTime; cdecl;
  TSfmlMicroseconds = function (Amount: sfInt64): TSfmlTime; cdecl;

  TSfmlClockCreate = function : PSfmlClock; cdecl;
  TSfmlClockCopy = function (const Clock: PSfmlClock): PSfmlClock; cdecl;
  TSfmlClockDestroy = procedure (Clock: PSfmlClock); cdecl;

  TSfmlClockGetElapsedTime = function (const Clock: PSfmlClock): TSfmlTime; cdecl;
  TSfmlClockRestart = function (Clock: PSfmlClock): TSfmlTime; cdecl;

  TSfmlMutexCreate = function : PSfmlMutex; cdecl;
  TSfmlMutexDestroy = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlMutexLock = procedure (Mutex: PSfmlMutex); cdecl;
  TSfmlMutexUnlock = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlSleep = procedure (Duration: TSfmlTime); cdecl;

  TSfmlThreadCreate = function (FuncEntryPoint: Pointer; UserData: Pointer): PSfmlThread; cdecl;
  TSfmlThreadDestroy = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadLaunch = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadWait = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadTerminate = procedure (Thread: PSfmlThread); cdecl;

var
  SfmlTimeZero: TSfmlTimeZero;
  SfmlTimeAsSeconds: TSfmlTimeAsSeconds;
  SfmlTimeAsMilliseconds: TSfmlTimeAsMilliseconds;
  SfmlTimeAsMicroseconds: TSfmlTimeAsMicroseconds;
  SfmlSeconds: TSfmlSeconds;
  SfmlMilliseconds: TSfmlMilliseconds;
  SfmlMicroseconds: TSfmlMicroseconds;

  SfmlClockCreate: TSfmlClockCreate;
  SfmlClockCopy: TSfmlClockCopy;
  SfmlClockDestroy: TSfmlClockDestroy;
  SfmlClockGetElapsedTime: TSfmlClockGetElapsedTime;
  SfmlClockRestart: TSfmlClockRestart;

  SfmlMutexCreate: TSfmlMutexCreate;
  SfmlMutexDestroy: TSfmlMutexDestroy;
  SfmlMutexLock: TSfmlMutexLock;
  SfmlMutexUnlock: TSfmlMutexUnlock;

  SfmlSleep: TSfmlSleep;

  SfmlThreadCreate: TSfmlThreadCreate;
  SfmlThreadDestroy: TSfmlThreadDestroy;
  SfmlThreadLaunch: TSfmlThreadLaunch;
  SfmlThreadWait: TSfmlThreadWait;
  SfmlThreadTerminate: TSfmlThreadTerminate;
{$ELSE}
  // static linking
  function SfmlTimeZero: TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfTime_Zero';
  function SfmlTimeAsSeconds(Time: TSfmlTime): Single; cdecl; external CSfmlSystemLibrary name 'sfTime_asSeconds';
  function SfmlTimeAsMilliseconds(Time: TSfmlTime): sfInt32; cdecl; external CSfmlSystemLibrary name 'sfTime_asMilliseconds';
  function SfmlTimeAsMicroseconds(Time: TSfmlTime): Int64; cdecl; external CSfmlSystemLibrary name 'sfTime_asMicroseconds';

  function SfmlSeconds(Amount: Single): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfSeconds';
  function SfmlMilliseconds(Amount: sfInt32): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfMilliseconds';
  function SfmlMicroseconds(Amount: sfInt64): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfMicroseconds';

  function SfmlClockCreate: PSfmlClock; cdecl; external CSfmlSystemLibrary name 'sfClock_create:';
  function SfmlClockCopy(const Clock: PSfmlClock): PSfmlClock; cdecl; external CSfmlSystemLibrary name 'sfClock_copy';
  procedure SfmlClockDestroy(Clock: PSfmlClock); cdecl; external CSfmlSystemLibrary name 'sfClock_destroy';

  function SfmlClockGetElapsedTime(const Clock: PSfmlClock): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfClock_getElapsedTime';
  function SfmlClockRestart(Clock: PSfmlClock): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfClock_restart';

  function SfmlMutexCreate: PSfmlMutex; cdecl; external CSfmlSystemLibrary name 'sfMutex_create';
  procedure SfmlMutexDestroy(Mutex: PSfmlMutex); cdecl; external CSfmlSystemLibrary name 'sfMutex_destroy';

  procedure SfmlMutexLock(Mutex: PSfmlMutex); cdecl; external CSfmlSystemLibrary name 'sfMutex_lock';
  procedure SfmlMutexUnlock(Mutex: PSfmlMutex); cdecl; external CSfmlSystemLibrary name 'sfMutex_unlock';

  procedure SfmlSleep(Duration: TSfmlTime); cdecl; external CSfmlSystemLibrary name 'sfSleep';

  function SfmlThreadCreate(FuncEntryPoint: Pointer; UserData: Pointer): PSfmlThread; cdecl; external CSfmlSystemLibrary name 'sfThread_create';
  procedure SfmlThreadDestroy(Thread: PSfmlThread); cdecl; external CSfmlSystemLibrary name 'sfThread_destroy';
  procedure SfmlThreadLaunch(Thread: PSfmlThread); cdecl; external CSfmlSystemLibrary name 'sfThread_launch';
  procedure SfmlThreadWait(Thread: PSfmlThread); cdecl; external CSfmlSystemLibrary name 'sfThread_wait';
  procedure SfmlThreadTerminate(Thread: PSfmlThread); cdecl; external CSfmlSystemLibrary name 'sfThread_terminate';
{$ENDIF}

implementation

{$IFDEF DynLink}

{$IFDEF MSWindows}
uses
  Windows;
{$ENDIF}

var
  CSfmlSystemHandle: HINST;

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlSystemHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  CSfmlSystemHandle := LoadLibraryA(CSfmlSystemLibrary);
  if CSfmlSystemHandle <> 0 then
    try
      SfmlTimeZero := BindFunction('sfTime_Zero');
      SfmlTimeAsSeconds := BindFunction('sfTime_asSeconds');
      SfmlTimeAsMilliseconds := BindFunction('sfTime_asMilliseconds');
      SfmlTimeAsMicroseconds := BindFunction('sfTime_asMicroseconds');
      SfmlSeconds := BindFunction('sfSeconds');
      SfmlMilliseconds := BindFunction('sfMilliseconds');
      SfmlMicroseconds := BindFunction('sfMicroseconds');
      SfmlClockCreate := BindFunction('sfClock_create');
      SfmlClockCopy := BindFunction('sfClock_copy');
      SfmlClockDestroy := BindFunction('sfClock_destroy');
      SfmlClockGetElapsedTime := BindFunction('sfClock_getElapsedTime');
      SfmlClockRestart := BindFunction('sfClock_restart');
      SfmlMutexCreate := BindFunction('sfMutex_create');
      SfmlMutexDestroy := BindFunction('sfMutex_destroy');
      SfmlMutexLock := BindFunction('sfMutex_lock');
      SfmlMutexUnlock := BindFunction('sfMutex_unlock');
      SfmlSleep := BindFunction('sfSleep');
      SfmlThreadCreate := BindFunction('sfThread_create');
      SfmlThreadDestroy := BindFunction('sfThread_destroy');
      SfmlThreadLaunch := BindFunction('sfThread_launch');
      SfmlThreadWait := BindFunction('sfThread_wait');
      SfmlThreadTerminate := BindFunction('sfThread_terminate');
    except
      FreeLibrary(CSfmlSystemHandle);
      CSfmlSystemHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlSystemHandle <> 0 then
    FreeLibrary(CSfmlSystemHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}

end.