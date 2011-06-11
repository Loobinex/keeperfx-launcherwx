#******************************************************************************
#  Game Launcher for KeeperFX - free implementation of Dungeon Keeper.
#******************************************************************************
#   @file Makefile
#      A script used by GNU Make to recompile the launcher.
#  @par Purpose:
#      Allows to invoke "make all" or similar commands to compile all
#      source code files and link them into executable file.
#  @par Comment:
#      None.
#  @author   Tomasz Lis
#  @date     25 May 2011 - 07 Jun 2011
#  @par  Copying and copyrights:
#      This program is free software; you can redistribute it and/or modify
#      it under the terms of the GNU General Public License as published by
#      the Free Software Foundation; either version 2 of the License, or
#      (at your option) any later version.
#
#******************************************************************************
CPP  = g++
CC   = gcc
WINDRES = windres
RM = rm -f
MV = mv -f
CP = @cp -f
ECHO = @echo
BIN    = bin/launcher.exe
RES    = obj/launcher.rc.o
DATA   = bin/launchermn.jpg
LIBS   = 
OBJS   = \
obj/wxImageFrame.o \
obj/LauncherApp.o \
obj/FilelistChecker.o \
obj/md5.o \
$(RES)

# include wxWidgets build configuration
include wx/config.gcc

# Variables

CPPDEPS = -MT$@ -MF$@.d -MD -MP
WX_RELEASE_NODOT = 28
LIBDIRNAME = ./wx/lib/gcc_$(LIBTYPE_SUFFIX)$(CFG)
SETUPHDIR = \
	$(LIBDIRNAME)/$(PORTNAME)$(WXUNIVNAME)$(WXUNICODEFLAG)$(WXDEBUGFLAG)
WXWIDGETS_CXXFLAGS = $(__DEBUGINFO) $(__OPTIMIZEFLAG_2) $(__THREADSFLAG) \
	$(GCCFLAGS) -DHAVE_W32API_H -D__WXMSW__ $(__WXUNIV_DEFINE_p) \
	$(__DEBUG_DEFINE_p) $(__NDEBUG_DEFINE_p) $(__EXCEPTIONS_DEFINE_p) \
	$(__RTTI_DEFINE_p) $(__THREAD_DEFINE_p) $(__UNICODE_DEFINE_p) \
	$(__MSLU_DEFINE_p) $(__GFXCTX_DEFINE_p) -I$(SETUPHDIR) -I./wx/include \
	$(____CAIRO_INCLUDEDIR_FILENAMES_p) -W -Wall $(__DLLFLAG_p) \
	-DNOPCH $(__RTTIFLAG_5) $(__EXCEPTIONSFLAG_6) \
	-Wno-ctor-dtor-privacy $(CPPFLAGS)
CXXFLAGS = -c $(WXWIDGETS_CXXFLAGS) $(CPPDEPS)
CFLAGS = -c $(CPPDEPS) 

# Conditionally set variables

ifeq ($(USE_GUI),0)
PORTNAME = base
endif
ifeq ($(USE_GUI),1)
PORTNAME = msw
endif
ifeq ($(BUILD),debug)
ifeq ($(DEBUG_FLAG),default)
WXDEBUGFLAG = d
endif
endif
ifeq ($(DEBUG_FLAG),1)
WXDEBUGFLAG = d
endif
ifeq ($(UNICODE),1)
WXUNICODEFLAG = u
endif
ifeq ($(WXUNIV),1)
WXUNIVNAME = univ
endif
ifeq ($(SHARED),1)
WXDLLFLAG = dll
endif
ifeq ($(SHARED),0)
LIBTYPE_SUFFIX = lib
endif
ifeq ($(SHARED),1)
LIBTYPE_SUFFIX = dll
endif
ifeq ($(MONOLITHIC),0)
EXTRALIBS_FOR_BASE = 
endif
ifeq ($(MONOLITHIC),1)
EXTRALIBS_FOR_BASE =  
endif
ifeq ($(BUILD),debug)
__OPTIMIZEFLAG_2 = -O0
endif
ifeq ($(BUILD),release)
__OPTIMIZEFLAG_2 = -O2
endif
ifeq ($(USE_RTTI),0)
__RTTIFLAG_5 = -fno-rtti
endif
ifeq ($(USE_RTTI),1)
__RTTIFLAG_5 = 
endif
ifeq ($(USE_EXCEPTIONS),0)
__EXCEPTIONSFLAG_6 = -fno-exceptions
endif
ifeq ($(USE_EXCEPTIONS),1)
__EXCEPTIONSFLAG_6 = 
endif
ifeq ($(WXUNIV),1)
__WXUNIV_DEFINE_p = -D__WXUNIVERSAL__
endif
ifeq ($(WXUNIV),1)
__WXUNIV_DEFINE_p_1 = --define __WXUNIVERSAL__
endif
ifeq ($(BUILD),debug)
ifeq ($(DEBUG_FLAG),default)
__DEBUG_DEFINE_p = -D__WXDEBUG__
endif
endif
ifeq ($(DEBUG_FLAG),1)
__DEBUG_DEFINE_p = -D__WXDEBUG__
endif
ifeq ($(BUILD),debug)
ifeq ($(DEBUG_FLAG),default)
__DEBUG_DEFINE_p_1 = --define __WXDEBUG__
endif
endif
ifeq ($(DEBUG_FLAG),1)
__DEBUG_DEFINE_p_1 = --define __WXDEBUG__
endif
ifeq ($(BUILD),release)
__NDEBUG_DEFINE_p = -DNDEBUG
endif
ifeq ($(BUILD),release)
__NDEBUG_DEFINE_p_1 = --define NDEBUG
endif
ifeq ($(USE_EXCEPTIONS),0)
__EXCEPTIONS_DEFINE_p = -DwxNO_EXCEPTIONS
endif
ifeq ($(USE_EXCEPTIONS),0)
__EXCEPTIONS_DEFINE_p_1 = --define wxNO_EXCEPTIONS
endif
ifeq ($(USE_RTTI),0)
__RTTI_DEFINE_p = -DwxNO_RTTI
endif
ifeq ($(USE_RTTI),0)
__RTTI_DEFINE_p_1 = --define wxNO_RTTI
endif
ifeq ($(USE_THREADS),0)
__THREAD_DEFINE_p = -DwxNO_THREADS
endif
ifeq ($(USE_THREADS),0)
__THREAD_DEFINE_p_1 = --define wxNO_THREADS
endif
ifeq ($(UNICODE),1)
__UNICODE_DEFINE_p = -D_UNICODE
endif
ifeq ($(UNICODE),1)
__UNICODE_DEFINE_p_1 = --define _UNICODE
endif
ifeq ($(MSLU),1)
__MSLU_DEFINE_p = -DwxUSE_UNICODE_MSLU=1
endif
ifeq ($(MSLU),1)
__MSLU_DEFINE_p_1 = --define wxUSE_UNICODE_MSLU=1
endif
ifeq ($(USE_GDIPLUS),1)
__GFXCTX_DEFINE_p = -DwxUSE_GRAPHICS_CONTEXT=1
endif
ifeq ($(USE_GDIPLUS),1)
__GFXCTX_DEFINE_p_1 = --define wxUSE_GRAPHICS_CONTEXT=1
endif
ifeq ($(USE_CAIRO),1)
____CAIRO_INCLUDEDIR_FILENAMES_p = -I$(CAIRO_ROOT)\include\cairo
endif
ifeq ($(USE_CAIRO),1)
__CAIRO_INCLUDEDIR_p = --include-dir $(CAIRO_ROOT)/include/cairo
endif
ifeq ($(SHARED),1)
__DLLFLAG_p = -DWXUSINGDLL
endif
ifeq ($(SHARED),1)
__DLLFLAG_p_1 = --define WXUSINGDLL
endif
ifeq ($(MONOLITHIC),0)
__WXLIB_CORE_p = \
	-lwx$(PORTNAME)$(WXUNIVNAME)$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_core
endif
ifeq ($(MONOLITHIC),0)
__WXLIB_BASE_p = \
	-lwxbase$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)
endif
ifeq ($(MONOLITHIC),1)
__WXLIB_MONO_p = \
	-lwx$(PORTNAME)$(WXUNIVNAME)$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)
endif
ifeq ($(USE_GUI),1)
__LIB_TIFF_p = -lwxtiff$(WXDEBUGFLAG)
endif
ifeq ($(USE_GUI),1)
__LIB_JPEG_p = -lwxjpeg$(WXDEBUGFLAG)
endif
ifeq ($(USE_GUI),1)
__LIB_PNG_p = -lwxpng$(WXDEBUGFLAG)
endif
ifeq ($(MSLU),1)
__UNICOWS_LIB_p = -lunicows
endif
ifeq ($(USE_GDIPLUS),1)
__GDIPLUS_LIB_p = -lgdiplus
endif
ifeq ($(USE_CAIRO),1)
__CAIRO_LIB_p = -lcairo
endif
ifeq ($(USE_CAIRO),1)
____CAIRO_LIBDIR_FILENAMES_p = -L$(CAIRO_ROOT)\lib
endif
ifeq ($(BUILD),debug)
ifeq ($(DEBUG_INFO),default)
__DEBUGINFO = -g
endif
endif
ifeq ($(BUILD),release)
ifeq ($(DEBUG_INFO),default)
__DEBUGINFO = 
endif
endif
ifeq ($(DEBUG_INFO),0)
__DEBUGINFO = 
endif
ifeq ($(DEBUG_INFO),1)
__DEBUGINFO = -g
endif
ifeq ($(USE_THREADS),0)
__THREADSFLAG = 
endif
ifeq ($(USE_THREADS),1)
__THREADSFLAG = -mthreads
endif

.PHONY: all all-before all-after debug docs docsdox clean clean-custom

# Dependencies tracking
-include obj/*.d

# Targets

all: all-before $(BIN) $(DATA) all-after

clean: clean-custom
	-$(RM) $(OBJS) $(BIN) $(LIBS) $(DATA)

$(BIN): $(OBJS)
	-$(ECHO) 'Building target: $@'
	$(CPP) -o $@ $(OBJS)  $(__DEBUGINFO) $(__THREADSFLAG) -L$(LIBDIRNAME) -Wl,--subsystem,windows -mwindows $(____CAIRO_LIBDIR_FILENAMES_p) $(LDFLAGS)  $(__WXLIB_CORE_p)  $(__WXLIB_BASE_p)  $(__WXLIB_MONO_p) $(__LIB_TIFF_p) $(__LIB_JPEG_p) $(__LIB_PNG_p)  -lwxzlib$(WXDEBUGFLAG)  -lwxregex$(WXUNICODEFLAG)$(WXDEBUGFLAG) -lwxexpat$(WXDEBUGFLAG) $(EXTRALIBS_FOR_BASE) $(__UNICOWS_LIB_p) $(__GDIPLUS_LIB_p) $(__CAIRO_LIB_p) -lkernel32 -luser32 -lgdi32 -lcomdlg32 -lwinspool -lwinmm -lshell32 -lcomctl32 -lole32 -loleaut32 -luuid -lrpcrt4 -ladvapi32 -lwsock32 -lodbc32
	-$(ECHO) 'Finished building target: $@'
	-$(ECHO) ' '

obj/%.o: src/%.cpp
	-$(ECHO) 'Building file: $<'
	$(CPP) $(CXXFLAGS) -o"$@" "$<"
	-$(ECHO) 'Finished building: $<'
	-$(ECHO) ' '

obj/%.o: src/%.c
	-$(ECHO) 'Building file: $<'
	$(CC) $(CFLAGS) -o"$@" "$<"
	-$(ECHO) 'Finished building: $<'
	-$(ECHO) ' '

obj/%.rc.o: res/%.rc
	-$(ECHO) 'Building resource: $<'
	$(WINDRES) --use-temp-file -i$< -o$@    --define __WXMSW__ $(__WXUNIV_DEFINE_p_1) $(__DEBUG_DEFINE_p_1) $(__NDEBUG_DEFINE_p_1) $(__EXCEPTIONS_DEFINE_p_1) $(__RTTI_DEFINE_p_1) $(__THREAD_DEFINE_p_1) $(__UNICODE_DEFINE_p_1) $(__MSLU_DEFINE_p_1) $(__GFXCTX_DEFINE_p_1) --include-dir $(SETUPHDIR) --include-dir ./wx/include $(__CAIRO_INCLUDEDIR_p) --include-dir ./src $(__DLLFLAG_p_1) --define NOPCH
	-$(ECHO) 'Finished building: $<'
	-$(ECHO) ' '

bin/%.bmp: res/%.bmp
	-$(ECHO) 'Copying file: $<'
	$(CP) "$<" "$@"

bin/%.jpg: res/%.jpg
	-$(ECHO) 'Copying file: $<'
	$(CP) "$<" "$@"
