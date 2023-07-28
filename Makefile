# Makefile for GNU Compiler Collection
# Run 'configure' to generate Makefile from Makefile.in

# Copyright (C) 1987-2023 Free Software Foundation, Inc.

#This file is part of GCC.

#GCC is free software; you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation; either version 3, or (at your option)
#any later version.

#GCC is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with GCC; see the file COPYING3.  If not see
#<http://www.gnu.org/licenses/>.

# The targets for external use include:
# all, doc, install, install-cross, install-cross-rest, install-strip,
# uninstall, TAGS, mostlyclean, clean, distclean, maintainer-clean.

# This is the default target.
# Set by autoconf to "all.internal" for a native build, or
# "all.cross" to build a cross compiler.
all: all.cross

# Depend on this to specify a phony target portably.
force:

# This tells GNU make version 3 not to export the variables
# defined in this file into the environment (and thus recursive makes).
.NOEXPORT:
# And this tells it not to automatically pass command-line variables
# to recursive makes.
MAKEOVERRIDES =

# Suppress smart makes who think they know how to automake yacc and flex file
.y.c:
.l.c:

# The only suffixes we want for implicit rules are .c and .o, so clear
# the list and add them.  This speeds up GNU Make, and allows -r to work.
# For i18n support, we also need .gmo, .po, .pox.
# This must come before the language makefile fragments to allow them to
# add suffixes and rules of their own.
.SUFFIXES:
.SUFFIXES: .c .cc .o .po .pox .gmo

# -------------------------------
# Standard autoconf-set variables
# -------------------------------

build=x86_64-pc-linux-gnu
host=x86_64-pc-linux-gnu
host_noncanonical=x86_64-pc-linux-gnu
host_os=linux-gnu
target=arc64-unknown-elf
target_noncanonical:=arc64-elf

# Normally identical to target_noncanonical, except for compilers built
# as accelerator targets.
real_target_noncanonical:=arc64-elf
accel_dir_suffix = 

# Sed command to transform gcc to installed name.
program_transform_name := s&^&arc64-elf-&

# -----------------------------
# Directories used during build
# -----------------------------

# Directory where sources are, from where we are.
srcdir = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc
gcc_docdir = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/doc

# Directory where sources are, absolute.
abs_srcdir = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc
abs_docdir = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/doc

# Directory where sources are, relative to here.
top_srcdir = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc

# Top build directory for this package, relative to here.
top_builddir = .

# The absolute path to the current directory.
objdir := $(shell pwd)

host_subdir=.
build_subdir=build-x86_64-pc-linux-gnu
target_subdir=arc64-elf
build_libsubdir=build-x86_64-pc-linux-gnu

# Top build directory for the "Cygnus tree", relative to $(top_builddir).
ifeq ($(host_subdir),.)
toplevel_builddir := ..
else
toplevel_builddir := ../..
endif

build_objdir := $(toplevel_builddir)/$(build_subdir)
build_libobjdir := $(toplevel_builddir)/$(build_libsubdir)
target_objdir := $(toplevel_builddir)/$(target_subdir)

# --------
# Defined vpaths
# --------

# Directory where sources are, from where we are.
VPATH = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc

# We define a vpath for the sources of the .texi files here because they
# are split between multiple directories and we would rather use one implicit
# pattern rule for everything.
# This vpath could be extended within the Make-lang fragments.

vpath %.texi $(gcc_docdir)
vpath %.texi $(gcc_docdir)/include

# --------
# UNSORTED
# --------

# Extra flags to pass to indicate cross compilation, which
# might be used or tested by Make-lang fragments.
CROSS=-DCROSS_DIRECTORY_STRUCTURE

# Variables that exist for you to override.
# See below for how to change them for certain systems.

# List of language subdirectories.
SUBDIRS = ada c cp d fortran go jit lto m2 objc objcp rust build

# Selection of languages to be made.
CONFIG_LANGUAGES =  c c++ lto
LANGUAGES = c $(CONFIG_LANGUAGES)
ifeq (yes,yes)
LANGUAGES += gcov$(exeext) gcov-dump$(exeext) gcov-tool$(exeext)
endif

# Default values for variables overridden in Makefile fragments.
# CFLAGS is for the user to override to, e.g., do a cross build with -O2.
# TCFLAGS is used for compilations with the GCC just built.
# T_CFLAGS is used for all compilations and is overridden by t-* files.
# TFLAGS is also for the user to override, passed down from the top-level
# Makefile.  It is used for all compilations.
T_CFLAGS =
TCFLAGS =
TFLAGS =
CFLAGS =   
CXXFLAGS =    
LDFLAGS = -static-libstdc++ -static-libgcc  

# Should we build position-independent host code?
PICFLAG = 

# Flags to determine code coverage. When coverage is disabled, this will
# contain the optimization flags, as you normally want code coverage
# without optimization.
COVERAGE_FLAGS = 
coverageexts = .{gcda,gcno}

# The warning flags are separate from CFLAGS because people tend to
# override optimization flags and we'd like them to still have warnings
# turned on.  These flags are also used to pass other stage dependent
# flags from configure.  The user is free to explicitly turn these flags
# off if they wish.
# LOOSE_WARN are the warning flags to use when compiling something
# which is only compiled with gcc, such as libgcc.
# C_LOOSE_WARN is similar, but with C-only warnings.
# STRICT_WARN are the additional warning flags to
# apply to the back end and some front ends, which may be compiled
# with other compilers.
# C_STRICT_WARN is similar, with C-only warnings.
LOOSE_WARN = -W -Wall -Wno-narrowing -Wwrite-strings -Wcast-qual
C_LOOSE_WARN = -Wstrict-prototypes -Wmissing-prototypes
STRICT_WARN = -Wmissing-format-attribute -Wconditionally-supported -Woverloaded-virtual -pedantic -Wno-long-long -Wno-variadic-macros -Wno-overlength-strings
C_STRICT_WARN = -Wold-style-definition -Wc++-compat

# This is set by --enable-checking.  The idea is to catch forgotten
# "extern" tags in header files.
NOCOMMON_FLAG = 

NOEXCEPTION_FLAGS = -fno-exceptions -fno-rtti -fasynchronous-unwind-tables

ALIASING_FLAGS = 

# This is set by --disable-maintainer-mode (default) to "#"
# FIXME: 'MAINT' will always be set to an empty string, no matter if
# --disable-maintainer-mode is used or not.  This is because the
# following will expand to "MAINT := " in maintainer mode, and to
# "MAINT := #" in non-maintainer mode, but because '#' starts a comment,
# they mean exactly the same thing for make.
MAINT := #

# The following provides the variable ENABLE_MAINTAINER_RULES that can
# be used in language Make-lang.in makefile fragments to enable
# maintainer rules.  So, ENABLE_MAINTAINER_RULES is 'true' in
# maintainer mode, and '' otherwise.
# ENABLE_MAINTAINER_RULES = true

# These are set by --enable-checking=valgrind.
RUN_GEN = 
VALGRIND_DRIVER_DEFINES = 

# This is how we control whether or not the additional warnings are applied.
.-warn = $(STRICT_WARN)
build-warn = $(STRICT_WARN)
rtl-ssa-warn = $(STRICT_WARN)
GCC_WARN_CFLAGS = $(LOOSE_WARN) $(C_LOOSE_WARN) $($(@D)-warn) $(if $(filter-out $(STRICT_WARN),$($(@D)-warn)),,$(C_STRICT_WARN)) $(NOCOMMON_FLAG) $($@-warn)
GCC_WARN_CXXFLAGS = $(LOOSE_WARN) $($(@D)-warn) $(NOCOMMON_FLAG) $($@-warn)

# These files are to have specific diagnostics suppressed, or are not to
# be subject to -Werror:
# flex output may yield harmless "no previous prototype" warnings
build/gengtype-lex.o-warn = -Wno-error
gengtype-lex.o-warn = -Wno-error
libgcov-util.o-warn = -Wno-error
libgcov-driver-tool.o-warn = -Wno-error
libgcov-merge-tool.o-warn = -Wno-error
gimple-match.o-warn = -Wno-unused
generic-match.o-warn = -Wno-unused
dfp.o-warn = -Wno-strict-aliasing

# All warnings have to be shut off in stage1 if the compiler used then
# isn't gcc; configure determines that.  WARN_CFLAGS will be either
# $(GCC_WARN_CFLAGS), or nothing.  Similarly, WARN_CXXFLAGS will be
# either $(GCC_WARN_CXXFLAGS), or nothing.
WARN_CFLAGS = $(GCC_WARN_CFLAGS)
WARN_CXXFLAGS = $(GCC_WARN_CXXFLAGS)

CPPFLAGS = 

AWK = /usr/bin/gawk
CC = gcc
CXX = g++
BISON = bison
BISONFLAGS =
FLEX = flex
FLEXFLAGS =
AR = ar
AR_FLAGS = rc
NM = nm
RANLIB = ranlib
RANLIB_FLAGS = 

# Libraries to use on the host.
HOST_LIBS = 

# The name of the compiler to use.
COMPILER = $(CXX)
COMPILER_FLAGS = $(CXXFLAGS)
# If HOST_LIBS is set, then the user is controlling the libraries to
# link against.  In that case, link with $(CC) so that the -lstdc++
# library is not introduced.  If HOST_LIBS is not set, link with
# $(CXX) to pick up -lstdc++.
ifeq ($(HOST_LIBS),)
LINKER = $(CXX)
LINKER_FLAGS = $(CXXFLAGS)
else
LINKER = $(CC)
LINKER_FLAGS = $(CFLAGS)
endif

# Enable Intel CET on Intel CET enabled host if needed.
CET_HOST_FLAGS = 
COMPILER += $(CET_HOST_FLAGS)

NO_PIE_CFLAGS = -fno-PIE
NO_PIE_FLAG = -no-pie
DO_LINK_MUTEX = false

# We don't want to compile the compilers with -fPIE, it make PCH fail.
COMPILER += $(NO_PIE_CFLAGS)

# Link with -no-pie since we compile the compiler with -fno-PIE.
LINKER += $(NO_PIE_FLAG)

# Like LINKER, but use a mutex for serializing front end links.
ifeq (false,true)
LLINKER = $(SHELL) $(srcdir)/lock-and-run.sh linkfe.lck $(LINKER)
else
LLINKER = $(LINKER)
endif

THIN_ARCHIVE_SUPPORT = yes

USE_THIN_ARCHIVES = no
ifeq ($(THIN_ARCHIVE_SUPPORT),yes)
ifeq ($(AR_FLAGS),rc)
ifeq ($(RANLIB_FLAGS),)
USE_THIN_ARCHIVES = yes
endif
endif
endif

# -------------------------------------------
# Programs which operate on the build machine
# -------------------------------------------

SHELL = /bin/bash
# pwd command to use.  Allow user to override default by setting PWDCMD in
# the environment to account for automounters.  The make variable must not
# be called PWDCMD, otherwise the value set here is passed to make
# subprocesses and overrides the setting from the user's environment.
# Don't use PWD since it is a common shell environment variable and we
# don't want to corrupt it.
PWD_COMMAND = $${PWDCMD-pwd}
# on sysV, define this as cp.
INSTALL = /usr/bin/install -c
# Some systems may be missing symbolic links, regular links, or both.
# Allow configure to check this and use "ln -s", "ln", or "cp" as appropriate.
LN=ln
LN_S=ln -s
# These permit overriding just for certain files.
INSTALL_PROGRAM = /usr/bin/install -c
INSTALL_DATA = /usr/bin/install -c -m 644
INSTALL_SCRIPT = /usr/bin/install -c
install_sh = $(SHELL) $(srcdir)/../install-sh
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
MAKEINFO = makeinfo --split-size=5000000
MAKEINFOFLAGS = --no-split
TEXI2DVI = texi2dvi
TEXI2PDF = texi2pdf
TEXI2HTML = $(MAKEINFO) --html
TEXI2POD = perl $(srcdir)/../contrib/texi2pod.pl
POD2MAN = pod2man --center="GNU" --release="gcc-$(version)" --date=$(shell sed 's/\(....\)\(..\)\(..\)/\1-\2-\3/' <$(DATESTAMP))
# Some versions of `touch' (such as the version on Solaris 2.8)
# do not correctly set the timestamp due to buggy versions of `utime'
# in the kernel.  So, we use `echo' instead.
STAMP = echo timestamp >
# If necessary (e.g., when using the MSYS shell on Microsoft Windows)
# translate the shell's notion of absolute pathnames to the native
# spelling.
build_file_translate = 

# Make sure the $(MAKE) variable is defined.


# Locate mkinstalldirs.
mkinstalldirs=$(SHELL) $(srcdir)/../mkinstalldirs

# write_entries_to_file - writes each entry in a list
# to the specified file.  Entries are written in chunks of
# $(write_entries_to_file_split) to accommodate systems with
# severe command-line-length limitations.
# Parameters:
# $(1): variable containing entries to iterate over
# $(2): output file
write_entries_to_file_split = 50
write_entries_to_file = $(shell rm -f $(2) || :) $(shell touch $(2)) \
	$(foreach range, \
	  $(shell i=1; while test $$i -le $(words $(1)); do \
	     echo $$i; i=`expr $$i + $(write_entries_to_file_split)`; done), \
	  $(shell echo "$(wordlist $(range), \
			  $(shell expr $(range) + $(write_entries_to_file_split) - 1), $(1))" \
	     | tr ' ' '\012' >> $(2)))

# The jit documentation looks better if built with sphinx, but can be
# built with texinfo if sphinx is not available.
# configure sets "doc_build_sys" to "sphinx" or "texinfo" accordingly
doc_build_sys=texinfo

# --------
# UNSORTED
# --------

# Dependency tracking stuff.
CXXDEPMODE = depmode=gcc3
DEPDIR = .deps
depcomp = $(SHELL) $(srcdir)/../depcomp

# In the past we used AC_PROG_CC_C_O and set this properly, but
# it was discovered that this hadn't worked in a long time, so now
# we just hard-code.
OUTPUT_OPTION = -o $@

# This is where we get zlib from.  zlibdir is -L../zlib and zlibinc is
# -I../zlib, unless we were configured with --with-system-zlib, in which
# case both are empty.
ZLIB =  -lz
ZLIBINC = 

# How to find GMP
GMPLIBS = -lmpc -lmpfr -lgmp
GMPINC = 

# How to find isl.
ISLLIBS = 
ISLINC = 

# Set to 'yes' if the LTO front end is enabled.
enable_lto = yes

# Compiler and flags needed for plugin support
PLUGINCC = g++
PLUGINCFLAGS =    

# Libs and linker options needed for plugin support
PLUGINLIBS = -rdynamic -ldl

enable_plugin = yes

# On MinGW plugin installation involves installing import libraries.
ifeq ($(enable_plugin),yes)
  plugin_implib := $(if $(strip $(filter mingw%,$(host_os))),yes,no)
endif

enable_host_shared = 

enable_as_accelerator = 

CPPLIB = ../libcpp/libcpp.a
CPPINC = -I$(srcdir)/../libcpp/include

CODYLIB = ../libcody/libcody.a
CODYINC = -I$(srcdir)/../libcody
NETLIBS = 

# Where to find decNumber
enable_decimal_float = dpd
DECNUM = $(srcdir)/../libdecnumber
DECNUMFMT = $(srcdir)/../libdecnumber/$(enable_decimal_float)
DECNUMINC = -I$(DECNUM) -I$(DECNUMFMT) -I../libdecnumber
LIBDECNUMBER = ../libdecnumber/libdecnumber.a

# The backtrace library.
BACKTRACE = $(srcdir)/../libbacktrace
BACKTRACEINC = -I$(BACKTRACE)
LIBBACKTRACE = ../libbacktrace/.libs/libbacktrace.a

# Target to use when installing include directory.  Either
# install-headers-tar, install-headers-cpio or install-headers-cp.
INSTALL_HEADERS_DIR = install-headers-tar

# Header files that are made available under the same name
# to programs compiled with GCC.
USER_H = $(srcdir)/ginclude/float.h \
	 $(srcdir)/ginclude/iso646.h \
	 $(srcdir)/ginclude/stdarg.h \
	 $(srcdir)/ginclude/stdbool.h \
	 $(srcdir)/ginclude/stddef.h \
	 $(srcdir)/ginclude/varargs.h \
	 $(srcdir)/ginclude/stdfix.h \
	 $(srcdir)/ginclude/stdnoreturn.h \
	 $(srcdir)/ginclude/stdalign.h \
	 $(srcdir)/ginclude/stdatomic.h \
	 $(EXTRA_HEADERS)

USER_H_INC_NEXT_PRE = 
USER_H_INC_NEXT_POST = 

# Enable target overriding of this fragment, as in config/t-vxworks.
T_GLIMITS_H = $(srcdir)/glimits.h
T_STDINT_GCC_H = $(srcdir)/ginclude/stdint-gcc.h

# The GCC to use for compiling crt*.o.
# Usually the one we just built.
# Don't use this as a dependency--use $(GCC_PASSES).
GCC_FOR_TARGET = $(STAGE_CC_WRAPPER) ./xgcc -B./ -B$(build_tooldir)/bin/ -isystem $(build_tooldir)/include -isystem $(build_tooldir)/sys-include -L$(objdir)/../ld $(TFLAGS)

# Set if the compiler was configured with --with-build-sysroot.
SYSROOT_CFLAGS_FOR_TARGET = 

# This is used instead of ALL_CFLAGS when compiling with GCC_FOR_TARGET.
# It specifies -B./.
# It also specifies -isystem ./include to find, e.g., stddef.h.
GCC_CFLAGS=$(CFLAGS_FOR_TARGET) $(INTERNAL_CFLAGS) $(T_CFLAGS) $(LOOSE_WARN) $(C_LOOSE_WARN) -Wold-style-definition $($@-warn) -isystem ./include $(TCFLAGS)

# ---------------------------------------------------
# Programs which produce files for the target machine
# ---------------------------------------------------

AR_FOR_TARGET := $(shell \
  if [ -f $(objdir)/../binutils/ar ] ; then \
    echo $(objdir)/../binutils/ar ; \
  else \
    if [ "$(host)" = "$(target)" ] ; then \
      echo $(AR); \
    else \
       t='$(program_transform_name)'; echo ar | sed -e "$$t" ; \
    fi; \
  fi)
AR_FLAGS_FOR_TARGET =
AR_CREATE_FOR_TARGET = $(AR_FOR_TARGET) $(AR_FLAGS_FOR_TARGET) rc
AR_EXTRACT_FOR_TARGET = $(AR_FOR_TARGET) $(AR_FLAGS_FOR_TARGET) x
LIPO_FOR_TARGET = lipo
ORIGINAL_AS_FOR_TARGET = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/install/arc64-elf/bin/as
RANLIB_FOR_TARGET := $(shell \
  if [ -f $(objdir)/../binutils/ranlib ] ; then \
    echo $(objdir)/../binutils/ranlib ; \
  else \
    if [ "$(host)" = "$(target)" ] ; then \
      echo $(RANLIB); \
    else \
       t='$(program_transform_name)'; echo ranlib | sed -e "$$t" ; \
    fi; \
  fi)
ORIGINAL_LD_FOR_TARGET = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/install/arc64-elf/bin/ld
ORIGINAL_NM_FOR_TARGET = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/install/arc64-elf/bin/nm
NM_FOR_TARGET = ./nm
STRIP_FOR_TARGET := $(shell \
  if [ -f $(objdir)/../binutils/strip-new ] ; then \
    echo $(objdir)/../binutils/strip-new ; \
  else \
    if [ "$(host)" = "$(target)" ] ; then \
      echo strip; \
    else \
       t='$(program_transform_name)'; echo strip | sed -e "$$t" ; \
    fi; \
  fi)

# --------
# UNSORTED
# --------

# Where to find some libiberty headers.
HASHTAB_H   = $(srcdir)/../include/hashtab.h
OBSTACK_H   = $(srcdir)/../include/obstack.h
SPLAY_TREE_H= $(srcdir)/../include/splay-tree.h
MD5_H	    = $(srcdir)/../include/md5.h
XREGEX_H    = $(srcdir)/../include/xregex.h
FNMATCH_H   = $(srcdir)/../include/fnmatch.h

# Linker plugin API headers
LINKER_PLUGIN_API_H = $(srcdir)/../include/plugin-api.h

# Default native SYSTEM_HEADER_DIR, to be overridden by targets.
NATIVE_SYSTEM_HEADER_DIR = /usr/include
# Default cross SYSTEM_HEADER_DIR, to be overridden by targets.
ifeq (${prefix}/include,$(prefix)/include)
  CROSS_SYSTEM_HEADER_DIR = $(gcc_tooldir)/sys-include
else
  CROSS_SYSTEM_HEADER_DIR = ${prefix}/include
endif

# autoconf sets SYSTEM_HEADER_DIR to one of the above.
# Purge it of unnecessary internal relative paths
# to directories that might not exist yet.
# The sed idiom for this is to repeat the search-and-replace until it doesn't match, using :a ... ta.
# Use single quotes here to avoid nested double- and backquotes, this
# macro is also used in a double-quoted context.
SYSTEM_HEADER_DIR = `echo $(CROSS_SYSTEM_HEADER_DIR) | sed -e :a -e 's,[^/]*/\.\.\/,,' -e ta`

# Path to the system headers on the build machine.
BUILD_SYSTEM_HEADER_DIR = `echo $(CROSS_SYSTEM_HEADER_DIR) | sed -e :a -e 's,[^/]*/\.\.\/,,' -e ta`

# Control whether to run fixincludes.
STMP_FIXINC = stmp-fixinc

# Test to see whether <limits.h> exists in the system header files.
LIMITS_H_TEST = [ -f $(BUILD_SYSTEM_HEADER_DIR)/limits.h ]

# Directory for prefix to system directories, for
# each of $(system_prefix)/usr/include, $(system_prefix)/usr/lib, etc.
TARGET_SYSTEM_ROOT = 
TARGET_SYSTEM_ROOT_DEFINE = 

xmake_file= $(srcdir)/config/x-linux
tmake_file= $(srcdir)/config/arc64/t-multilib $(srcdir)/config/arc64/t-arc64
TM_ENDIAN_CONFIG=
TM_MULTILIB_CONFIG=
TM_MULTILIB_EXCEPTIONS_CONFIG=
out_file=$(srcdir)/config/arc64/arc64.cc
out_object_file=arc64.o
common_out_file=$(srcdir)/common/config/arc64/arc64-common.cc
common_out_object_file=arc64-common.o
EXTRA_GTYPE_DEPS=
md_file=$(srcdir)/common.md $(srcdir)/config/arc64/arc64.md
tm_file_list=options.h $(srcdir)/config/elfos.h $(srcdir)/config/newlib-stdint.h $(srcdir)/config/arc64/elf.h $(srcdir)/config/arc64/elf64.h $(srcdir)/config/arc64/arc64.h $(srcdir)/config/initfini-array.h $(srcdir)/defaults.h
tm_include_list=options.h insn-constants.h config/elfos.h config/newlib-stdint.h config/arc64/elf.h config/arc64/elf64.h config/arc64/arc64.h config/initfini-array.h defaults.h
tm_defines= LIBC_GLIBC=1 LIBC_UCLIBC=2 LIBC_BIONIC=3 LIBC_MUSL=4
tm_p_file_list= $(srcdir)/config/arc64/arc64-protos.h tm-preds.h
tm_p_include_list= config/arc64/arc64-protos.h tm-preds.h
tm_d_file_list=
tm_d_include_list=
build_xm_file_list= auto-host.h $(srcdir)/../include/ansidecl.h
build_xm_include_list= auto-host.h ansidecl.h
build_xm_defines=
host_xm_file_list= auto-host.h $(srcdir)/../include/ansidecl.h
host_xm_include_list= auto-host.h ansidecl.h
host_xm_defines=
xm_file_list= auto-host.h $(srcdir)/../include/ansidecl.h
xm_include_list= auto-host.h ansidecl.h
xm_defines=
lang_checks=
lang_checks_parallelized=
lang_opt_files= /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/ada/gcc-interface/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/d/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/fortran/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/go/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/lto/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/m2/lang.opt /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/rust/lang.opt $(srcdir)/c-family/c.opt $(srcdir)/common.opt $(srcdir)/params.opt $(srcdir)/analyzer/analyzer.opt
lang_specs_files= /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/cp/lang-specs.h /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/lto/lang-specs.h
lang_tree_files= /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/ada/gcc-interface/ada-tree.def /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/cp/cp-tree.def /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/d/d-tree.def /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/m2/m2-tree.def /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/../../sources/arc-gnu-toolchain/gcc/gcc/objc/objc-tree.def
target_cpu_default=
OBJC_BOEHM_GC=
extra_modes_file=$(srcdir)/config/arc64/arc64-modes.def
extra_opt_files= $(srcdir)/config/arc64/arc64.opt
host_hook_obj=host-linux.o

# Multiarch support
enable_multiarch = no
with_cpu = hs6x
with_float = 
ifeq ($(enable_multiarch),yes)
  if_multiarch = $(1)
else
  ifeq ($(enable_multiarch),auto)
    # SYSTEM_HEADER_DIR is makefile syntax, cannot be evaluated in configure.ac
    if_multiarch = $(if $(wildcard $(shell echo $(BUILD_SYSTEM_HEADER_DIR))/../../usr/lib/*/crti.o),$(1))
  else
    if_multiarch =
  endif
endif

# ------------------------
# Installation directories
# ------------------------

# Common prefix for installation directories.
# NOTE: This directory must exist when you start installation.
prefix = /scratch/luiss/issues/toolchain/421/default/workspace/hs6x-gcc-baremetal/install
# Directory in which to put localized header files. On the systems with
# gcc as the native cc, `local_prefix' may not be `prefix' which is
# `/usr'.
# NOTE: local_prefix *should not* default from prefix.
local_prefix = /usr/local
# Directory in which to put host dependent programs and libraries
exec_prefix = ${prefix}
# Directory in which to put the executable for the command `gcc'
bindir = ${exec_prefix}/bin
# Directory in which to put the directories used by the compiler.
libdir = ${exec_prefix}/lib
# Directory in which GCC puts its executables.
libexecdir = ${exec_prefix}/libexec

# --------
# UNSORTED
# --------

# Directory in which the compiler finds libraries etc.
libsubdir = $(libdir)/gcc/$(real_target_noncanonical)/$(version)$(accel_dir_suffix)
# Directory in which the compiler finds executables
libexecsubdir = $(libexecdir)/gcc/$(real_target_noncanonical)/$(version)$(accel_dir_suffix)
# Directory in which all plugin resources are installed
plugin_resourcesdir = $(libsubdir)/plugin
 # Directory in which plugin headers are installed
plugin_includedir = $(plugin_resourcesdir)/include
# Directory in which plugin specific executables are installed
plugin_bindir = $(libexecsubdir)/plugin
# Used to produce a relative $(gcc_tooldir) in gcc.o
ifeq ($(enable_as_accelerator),yes)
unlibsubdir = ../../../../..
else
unlibsubdir = ../../..
endif
# $(prefix), expressed as a path relative to $(libsubdir).
#
# An explanation of the sed strings:
#  -e 's|^$(prefix)||'   matches and eliminates 'prefix' from 'exec_prefix'
#  -e 's|/$$||'          match a trailing forward slash and eliminates it
#  -e 's|^[^/]|/|'       forces the string to start with a forward slash (*)
#  -e 's|/[^/]*|../|g'   replaces each occurrence of /<directory> with ../
#
# (*) Note this pattern overwrites the first character of the string
# with a forward slash if one is not already present.  This is not a
# problem because the exact names of the sub-directories concerned is
# unimportant, just the number of them matters.
#
# The practical upshot of these patterns is like this:
#
#  prefix     exec_prefix        result
#  ------     -----------        ------
#   /foo        /foo/bar          ../
#   /foo/       /foo/bar          ../
#   /foo        /foo/bar/         ../
#   /foo/       /foo/bar/         ../
#   /foo        /foo/bar/ugg      ../../
libsubdir_to_prefix := \
  $(unlibsubdir)/$(shell echo "$(libdir)" | \
    sed -e 's|^$(prefix)||' -e 's|/$$||' -e 's|^[^/]|/|' \
        -e 's|/[^/]*|../|g')
# $(exec_prefix), expressed as a path relative to $(prefix).
prefix_to_exec_prefix := \
  $(shell echo "$(exec_prefix)" | \
    sed -e 's|^$(prefix)||' -e 's|^/||' -e '/./s|$$|/|')
# Directory in which to find other cross-compilation tools and headers.
dollar = 
# Used in install-cross.
gcc_tooldir = $(libsubdir)/$(libsubdir_to_prefix)$(target_noncanonical)
# Since gcc_tooldir does not exist at build-time, use -B$(build_tooldir)/bin/
build_tooldir = $(exec_prefix)/$(target_noncanonical)
# Directory in which the compiler finds target-independent g++ includes.
gcc_gxx_include_dir = $(libsubdir)/$(libsubdir_to_prefix)arc64-elf/include/c++/$(version)
gcc_gxx_include_dir_add_sysroot = 0
# Directory in which the compiler finds libc++ includes.
gcc_gxx_libcxx_include_dir = $(libsubdir)/$(libsubdir_to_prefix)arc64-elf/libc++_include/c++/$(version)/v1
gcc_gxx_libcxx_include_dir_add_sysroot = 0
# Directory to search for site-specific includes.
local_includedir = $(local_prefix)/include
includedir = $(prefix)/include
# where the info files go
infodir = ${datarootdir}/info
# Where cpp should go besides $prefix/bin if necessary
cpp_install_dir = 
# where the locale files go
datadir = ${datarootdir}
localedir = $(datadir)/locale
# Extension (if any) to put in installed man-page filename.
man1ext = .1
man7ext = .7
objext = .o
exeext = 
build_exeext = 

# Directory in which to put man pages.
mandir = ${datarootdir}/man
man1dir = $(mandir)/man1
man7dir = $(mandir)/man7
# Dir for temp files.
tmpdir = /tmp

datarootdir = ${prefix}/share
docdir = ${datarootdir}/doc/${PACKAGE}
# Directory in which to put DVIs
dvidir = ${docdir}
# Directory in which to build HTML
build_htmldir = $(objdir)/HTML/gcc-$(version)
# Directory in which to put HTML
htmldir = ${docdir}

# Whether we were configured with NLS.
USE_NLS = no

# Internationalization library.
INCINTL = 
LIBINTL = 
LIBINTL_DEP = 

# Character encoding conversion library.
LIBICONV = 
LIBICONV_DEP = 

# If a supplementary library is being used for the GC.
GGC_LIB=

# "true" if the target C library headers are unavailable; "false"
# otherwise.
inhibit_libc = false
ifeq ($(inhibit_libc),true)
INHIBIT_LIBC_CFLAGS = -Dinhibit_libc
endif

# List of extra executables that should be compiled for this target machine
# that are used when linking.
# The rules for compiling them should be in the t-* file for the machine.
EXTRA_PROGRAMS = 

# List of extra object files that should be compiled and linked with
# compiler proper (cc1, cc1obj, cc1plus).
EXTRA_OBJS =  

# List of extra object files that should be compiled and linked with
# the gcc driver.
EXTRA_GCC_OBJS = 

# List of extra libraries that should be linked with the gcc driver.
EXTRA_GCC_LIBS = 

# List of additional header files to install.
EXTRA_HEADERS = $(srcdir)/ginclude/tgmath.h

# How to handle <stdint.h>.
USE_GCC_STDINT = wrap

# The configure script will set this to collect2$(exeext), except on a
# (non-Unix) host which cannot build collect2, for which it will be
# set to empty.
COLLECT2 = collect2$(exeext)

# Program to convert libraries.
LIBCONVERT =

# Control whether header files are installed.
INSTALL_HEADERS=install-headers install-mkheaders

# Control whether Info documentation is built and installed.
BUILD_INFO = info

# Control flags for @contents placement in HTML output
MAKEINFO_TOC_INLINE_FLAG = -c CONTENTS_OUTPUT_LOCATION=inline

# Control whether manpages generated by texi2pod.pl can be rebuilt.
GENERATED_MANPAGES = generated-manpages

# Additional directories of header files to run fixincludes on.
# These should be directories searched automatically by default
# just as /usr/include is.
# *Do not* use this for directories that happen to contain
# header files, but are not searched automatically by default.
# On most systems, this is empty.
OTHER_FIXINCLUDES_DIRS=

# A list of all the language-specific executables.
COMPILERS =  gnat1$(exeext) cc1$(exeext) cc1plus$(exeext) d21$(exeext) f951$(exeext) go1$(exeext)  lto1$(exeext) cc1gm2$(exeext) cc1obj$(exeext) cc1objplus$(exeext) rust1$(exeext)

# List of things which should already be built whenever we try to use xgcc
# to compile anything (without linking).
GCC_PASSES=xgcc$(exeext) specs

# Directory to link to, when using the target `maketest'.
DIR = ../gcc

# Native compiler for the build machine and its switches.
CC_FOR_BUILD = $(CC)
CXX_FOR_BUILD = $(CXX)
BUILD_CFLAGS= $(ALL_CFLAGS) $(GENERATOR_CFLAGS) -DGENERATOR_FILE
BUILD_CXXFLAGS = $(ALL_CXXFLAGS) $(GENERATOR_CFLAGS) -DGENERATOR_FILE

# Native compiler that we use.  This may be C++ some day.
COMPILER_FOR_BUILD = $(CXX_FOR_BUILD)
BUILD_COMPILERFLAGS = $(BUILD_CXXFLAGS)

# Native linker that we use.
LINKER_FOR_BUILD = $(CXX_FOR_BUILD)
BUILD_LINKERFLAGS = $(BUILD_CXXFLAGS)

# Native linker and preprocessor flags.  For x-fragment overrides.
BUILD_LDFLAGS=$(LDFLAGS)
BUILD_CPPFLAGS= -I. -I$(@D) -I$(srcdir) -I$(srcdir)/$(@D) \
		-I$(srcdir)/../include $(INCINTL) $(CPPINC) $(CPPFLAGS)

# Actual name to use when installing a native compiler.
GCC_INSTALL_NAME := $(shell echo gcc|sed '$(program_transform_name)')
GCC_TARGET_INSTALL_NAME := $(target_noncanonical)-$(shell echo gcc|sed '$(program_transform_name)')
CPP_INSTALL_NAME := $(shell echo cpp|sed '$(program_transform_name)')
GCOV_INSTALL_NAME := $(shell echo gcov|sed '$(program_transform_name)')
GCOV_TOOL_INSTALL_NAME := $(shell echo gcov-tool|sed '$(program_transform_name)')
GCOV_DUMP_INSTALL_NAME := $(shell echo gcov-dump|sed '$(program_transform_name)')

# Setup the testing framework, if you have one
EXPECT = `if [ -f $${rootme}/../expect/expect ] ; then \
            echo $${rootme}/../expect/expect ; \
          else echo expect ; fi`

RUNTEST = `if [ -f $${srcdir}/../dejagnu/runtest ] ; then \
	       echo $${srcdir}/../dejagnu/runtest ; \
	    else echo runtest; fi`
RUNTESTFLAGS =

# This should name the specs file that we're going to install.  Target
# Makefiles may override it and name another file to be generated from
# the built-in specs and installed as the default spec, as long as
# they also introduce a rule to generate a file name specs, to be used
# at build time.
SPECS = specs

# Extra include files that are defined by HeaderInclude directives in
# the .opt files
OPTIONS_H_EXTRA =

# Extra include files that are defined by SourceInclude directives in
# the .opt files
OPTIONS_C_EXTRA = $(PRETTY_PRINT_H)

OPTIONS_H_EXTRA += $(srcdir)/config/arc64/arc64-opts.h

# End of variables for you to override.

# GTM_H lists the config files that the generator files depend on,
# while TM_H lists the ones ordinary gcc files depend on, which
# includes several files generated by those generators.
BCONFIG_H = bconfig.h $(build_xm_file_list)
CONFIG_H  = config.h  $(host_xm_file_list)
TCONFIG_H = tconfig.h $(xm_file_list)
TM_P_H    = tm_p.h    $(tm_p_file_list)
TM_D_H    = tm_d.h    $(tm_d_file_list)
GTM_H     = tm.h      $(tm_file_list) insn-constants.h
TM_H      = $(GTM_H) insn-flags.h $(OPTIONS_H)

# Variables for version information.
BASEVER     := $(srcdir)/BASE-VER  # 4.x.y
DEVPHASE    := $(srcdir)/DEV-PHASE # experimental, prerelease, ""
DATESTAMP   := $(srcdir)/DATESTAMP # YYYYMMDD or empty
REVISION    := $(srcdir)/REVISION  # [BRANCH revision XXXXXX]

BASEVER_c   := $(shell cat $(BASEVER))
DEVPHASE_c  := $(shell cat $(DEVPHASE))
DATESTAMP_c := $(shell cat $(DATESTAMP))

ifeq (,$(wildcard $(REVISION)))
REVISION_c  :=
REVISION    :=
else
REVISION_c  := $(shell cat $(REVISION))
endif

version     := $(shell cat $(BASEVER))

PATCHLEVEL_c := \
  $(shell echo $(BASEVER_c) | sed -e 's/^[0-9]*\.[0-9]*\.\([0-9]*\)$$/\1/')


# For use in version.cc - double quoted strings, with appropriate
# surrounding punctuation and spaces, and with the datestamp and
# development phase collapsed to the empty string in release mode
# (i.e. if DEVPHASE_c is empty and PATCHLEVEL_c is 0).  The space
# immediately after the comma in the $(if ...) constructs is
# significant - do not remove it.
BASEVER_s   := "\"$(BASEVER_c)\""
DEVPHASE_s  := "\"$(if $(DEVPHASE_c), ($(DEVPHASE_c)))\""
DATESTAMP_s := \
  "\"$(if $(DEVPHASE_c)$(filter-out 0,$(PATCHLEVEL_c)), $(DATESTAMP_c))\""
PKGVERSION_s:= "\"(GCC) \""
BUGURL_s    := "\"<https://gcc.gnu.org/bugs/>\""

PKGVERSION  := (GCC) 
BUGURL_TEXI := @uref{https://gcc.gnu.org/bugs/}

ifdef REVISION_c
REVISION_s  := \
  "\"$(if $(DEVPHASE_c)$(filter-out 0,$(PATCHLEVEL_c)), $(REVISION_c))\""
else
REVISION_s  := "\"\""
endif

# Shorthand variables for dependency lists.
DUMPFILE_H = $(srcdir)/../libcpp/include/line-map.h dumpfile.h
VEC_H = vec.h statistics.h $(GGC_H)
HASH_TABLE_H = $(HASHTAB_H) hash-table.h $(GGC_H)
EXCEPT_H = except.h $(HASHTAB_H)
TARGET_DEF = target.def target-hooks-macros.h target-insns.def
C_TARGET_DEF = c-family/c-target.def target-hooks-macros.h
COMMON_TARGET_DEF = common/common-target.def target-hooks-macros.h
D_TARGET_DEF = d/d-target.def target-hooks-macros.h
TARGET_H = $(TM_H) target.h $(TARGET_DEF) insn-modes.h insn-codes.h
C_TARGET_H = c-family/c-target.h $(C_TARGET_DEF)
COMMON_TARGET_H = common/common-target.h $(INPUT_H) $(COMMON_TARGET_DEF)
D_TARGET_H = d/d-target.h $(D_TARGET_DEF)
MACHMODE_H = machmode.h mode-classes.def
HOOKS_H = hooks.h
HOSTHOOKS_DEF_H = hosthooks-def.h $(HOOKS_H)
LANGHOOKS_DEF_H = langhooks-def.h $(HOOKS_H)
TARGET_DEF_H = target-def.h target-hooks-def.h $(HOOKS_H) targhooks.h
C_TARGET_DEF_H = c-family/c-target-def.h c-family/c-target-hooks-def.h \
  $(TREE_H) $(C_COMMON_H) $(HOOKS_H) common/common-targhooks.h
CORETYPES_H = coretypes.h insn-modes.h signop.h wide-int.h wide-int-print.h \
  insn-modes-inline.h $(MACHMODE_H) double-int.h align.h poly-int.h \
  poly-int-types.h
RTL_BASE_H = $(CORETYPES_H) rtl.h rtl.def reg-notes.def \
  insn-notes.def $(INPUT_H) $(REAL_H) statistics.h $(VEC_H) \
  $(FIXED_VALUE_H) alias.h $(HASHTAB_H)
FIXED_VALUE_H = fixed-value.h
RTL_H = $(RTL_BASE_H) $(FLAGS_H) genrtl.h
READ_MD_H = $(OBSTACK_H) $(HASHTAB_H) read-md.h
BUILTINS_DEF = builtins.def sync-builtins.def omp-builtins.def \
	gtm-builtins.def sanitizer.def
INTERNAL_FN_DEF = internal-fn.def
INTERNAL_FN_H = internal-fn.h $(INTERNAL_FN_DEF)
TREE_CORE_H = tree-core.h $(CORETYPES_H) all-tree.def tree.def \
	c-family/c-common.def $(lang_tree_files) \
	$(BUILTINS_DEF) $(INPUT_H) statistics.h \
	$(VEC_H) treestruct.def $(HASHTAB_H) \
	alias.h $(SYMTAB_H) $(FLAGS_H) \
	$(REAL_H) $(FIXED_VALUE_H)
TREE_H = tree.h $(TREE_CORE_H)  tree-check.h
REGSET_H = regset.h $(BITMAP_H) hard-reg-set.h
BASIC_BLOCK_H = basic-block.h $(PREDICT_H) $(VEC_H) $(FUNCTION_H) \
	cfg-flags.def cfghooks.h profile-count.h
GIMPLE_H = gimple.h gimple.def gsstruct.def $(VEC_H) \
	$(GGC_H) $(BASIC_BLOCK_H) $(TREE_H) tree-ssa-operands.h \
	tree-ssa-alias.h $(INTERNAL_FN_H) $(HASH_TABLE_H) is-a.h
GCOV_IO_H = gcov-io.h version.h auto-host.h gcov-counter.def
RECOG_H = recog.h
EMIT_RTL_H = emit-rtl.h
FLAGS_H = flags.h flag-types.h $(OPTIONS_H)
OPTIONS_H = options.h flag-types.h $(OPTIONS_H_EXTRA)
FUNCTION_H = function.h $(HASHTAB_H) $(TM_H) hard-reg-set.h \
	$(VEC_H) $(INPUT_H)
EXPR_H = expr.h insn-config.h $(FUNCTION_H) $(RTL_H) $(FLAGS_H) $(TREE_H) \
	$(EMIT_RTL_H)
OPTABS_H = optabs.h insn-codes.h insn-opinit.h
REGS_H = regs.h hard-reg-set.h
CFGLOOP_H = cfgloop.h $(BASIC_BLOCK_H) $(BITMAP_H) sbitmap.h
IPA_UTILS_H = ipa-utils.h $(TREE_H) $(CGRAPH_H)
IPA_REFERENCE_H = ipa-reference.h $(BITMAP_H) $(TREE_H)
CGRAPH_H = cgraph.h $(VEC_H) $(TREE_H) $(BASIC_BLOCK_H) $(FUNCTION_H) \
	cif-code.def ipa-ref.h $(LINKER_PLUGIN_API_H) is-a.h
DF_H = df.h $(BITMAP_H) $(REGSET_H) sbitmap.h $(BASIC_BLOCK_H) \
	alloc-pool.h $(TIMEVAR_H)
RESOURCE_H = resource.h hard-reg-set.h $(DF_H)
GCC_H = gcc.h version.h $(DIAGNOSTIC_CORE_H)
GGC_H = ggc.h gtype-desc.h statistics.h
TIMEVAR_H = timevar.h timevar.def
INSN_ATTR_H = insn-attr.h insn-attr-common.h $(INSN_ADDR_H)
INSN_ADDR_H = $(srcdir)/insn-addr.h
C_COMMON_H = c-family/c-common.h c-family/c-common.def $(TREE_H) \
	$(SPLAY_TREE_H) $(CPPLIB_H) $(GGC_H) $(DIAGNOSTIC_CORE_H)
C_PRAGMA_H = c-family/c-pragma.h $(CPPLIB_H)
C_TREE_H = c/c-tree.h $(C_COMMON_H) $(DIAGNOSTIC_H)
SYSTEM_H = system.h hwint.h $(srcdir)/../include/libiberty.h \
	$(srcdir)/../include/safe-ctype.h $(srcdir)/../include/filenames.h \
	$(HASHTAB_H)
PREDICT_H = predict.h predict.def
CPPLIB_H = $(srcdir)/../libcpp/include/line-map.h \
	$(srcdir)/../libcpp/include/cpplib.h
CODYLIB_H = $(srcdir)/../libcody/cody.hh
INPUT_H = $(srcdir)/../libcpp/include/line-map.h input.h
OPTS_H = $(INPUT_H) $(VEC_H) opts.h $(OBSTACK_H)
SYMTAB_H = $(srcdir)/../libcpp/include/symtab.h $(OBSTACK_H)
CPP_INTERNAL_H = $(srcdir)/../libcpp/internal.h
TREE_DUMP_H = tree-dump.h $(SPLAY_TREE_H) $(DUMPFILE_H)
TREE_PASS_H = tree-pass.h $(TIMEVAR_H) $(DUMPFILE_H)
TREE_SSA_H = tree-ssa.h tree-ssa-operands.h \
		$(BITMAP_H) sbitmap.h $(BASIC_BLOCK_H) $(GIMPLE_H) \
		$(HASHTAB_H) $(CGRAPH_H) $(IPA_REFERENCE_H) \
		tree-ssa-alias.h
PRETTY_PRINT_H = pretty-print.h $(INPUT_H) $(OBSTACK_H) wide-int-print.h
TREE_PRETTY_PRINT_H = tree-pretty-print.h $(PRETTY_PRINT_H)
GIMPLE_PRETTY_PRINT_H = gimple-pretty-print.h $(TREE_PRETTY_PRINT_H)
DIAGNOSTIC_CORE_H = diagnostic-core.h $(INPUT_H) bversion.h diagnostic.def
DIAGNOSTIC_H = diagnostic.h $(DIAGNOSTIC_CORE_H) $(PRETTY_PRINT_H)
C_PRETTY_PRINT_H = c-family/c-pretty-print.h $(PRETTY_PRINT_H) \
	$(C_COMMON_H) $(TREE_H)
TREE_INLINE_H = tree-inline.h
REAL_H = real.h
LTO_STREAMER_H = lto-streamer.h $(LINKER_PLUGIN_API_H) $(TARGET_H) \
		$(CGRAPH_H) $(VEC_H) $(HASH_TABLE_H) $(TREE_H) $(GIMPLE_H) \
		$(GCOV_IO_H) $(DIAGNOSTIC_H) alloc-pool.h
IPA_PROP_H = ipa-prop.h $(TREE_H) $(VEC_H) $(CGRAPH_H) $(GIMPLE_H) alloc-pool.h
BITMAP_H = bitmap.h $(HASHTAB_H) statistics.h
GCC_PLUGIN_H = gcc-plugin.h highlev-plugin-common.h plugin.def \
		$(CONFIG_H) $(SYSTEM_H) $(HASHTAB_H)
PLUGIN_H = plugin.h $(GCC_PLUGIN_H)
PLUGIN_VERSION_H = plugin-version.h configargs.h
CONTEXT_H = context.h
GENSUPPORT_H = gensupport.h read-md.h optabs.def
RTL_SSA_H = $(PRETTY_PRINT_H) insn-config.h splay-tree-utils.h \
	    $(RECOG_H) $(REGS_H) function-abi.h obstack-utils.h \
	    mux-utils.h rtlanal.h memmodel.h $(EMIT_RTL_H) \
	    rtl-ssa/accesses.h rtl-ssa/insns.h rtl-ssa/blocks.h \
	    rtl-ssa/changes.h rtl-ssa/functions.h rtl-ssa/is-a.inl \
	    rtl-ssa/access-utils.h rtl-ssa/insn-utils.h rtl-ssa/movement.h \
	    rtl-ssa/change-utils.h rtl-ssa/member-fns.inl

#
# Now figure out from those variables how to compile and link.

# IN_GCC distinguishes between code compiled into GCC itself and other
# programs built during a bootstrap.
# autoconf inserts -DCROSS_DIRECTORY_STRUCTURE if we are building a
# cross compiler which does not use the native headers and libraries.
INTERNAL_CFLAGS = -DIN_GCC $(PICFLAG) -DCROSS_DIRECTORY_STRUCTURE

# This is the variable actually used when we compile. If you change this,
# you probably want to update BUILD_CFLAGS in configure.ac
ALL_CFLAGS = $(T_CFLAGS) $(CFLAGS-$@) \
  $(CFLAGS) $(INTERNAL_CFLAGS) $(COVERAGE_FLAGS) $(WARN_CFLAGS) -DHAVE_CONFIG_H

# The C++ version.
ALL_CXXFLAGS = $(T_CFLAGS) $(CFLAGS-$@) $(CXXFLAGS) $(INTERNAL_CFLAGS) \
  $(COVERAGE_FLAGS) $(ALIASING_FLAGS) $(NOEXCEPTION_FLAGS) \
  $(WARN_CXXFLAGS) -DHAVE_CONFIG_H

# Likewise.  Put INCLUDES at the beginning: this way, if some autoconf macro
# puts -I options in CPPFLAGS, our include files in the srcdir will always
# win against random include files in /usr/include.
ALL_CPPFLAGS = $(INCLUDES) $(CPPFLAGS)

# This is the variable to use when using $(COMPILER).
ALL_COMPILERFLAGS = $(ALL_CXXFLAGS)

# This is the variable to use when using $(LINKER).
ALL_LINKERFLAGS = $(ALL_CXXFLAGS)

# Build and host support libraries.

# Use the "pic" build of libiberty if --enable-host-shared, unless we are
# building for mingw.
LIBIBERTY_PICDIR=$(if $(findstring mingw,$(target)),,pic)
ifeq ($(enable_host_shared),yes)
LIBIBERTY = ../libiberty/$(LIBIBERTY_PICDIR)/libiberty.a
BUILD_LIBIBERTY = $(build_libobjdir)/libiberty/$(LIBIBERTY_PICDIR)/libiberty.a
else
LIBIBERTY = ../libiberty/libiberty.a
BUILD_LIBIBERTY = $(build_libobjdir)/libiberty/libiberty.a
endif

# Dependencies on the intl and portability libraries.
LIBDEPS= libcommon.a $(CPPLIB) $(LIBIBERTY) $(LIBINTL_DEP) $(LIBICONV_DEP) \
	$(LIBDECNUMBER) $(LIBBACKTRACE)

# Likewise, for use in the tools that must run on this machine
# even if we are cross-building GCC.
BUILD_LIBDEPS= $(BUILD_LIBIBERTY)

# How to link with both our special library facilities
# and the system's installed libraries.
LIBS =  libcommon.a $(CPPLIB) $(LIBINTL) $(LIBICONV) $(LIBBACKTRACE) \
	$(LIBIBERTY) $(LIBDECNUMBER) $(HOST_LIBS)
BACKENDLIBS = $(ISLLIBS) $(GMPLIBS) $(PLUGINLIBS) $(HOST_LIBS) \
	$(ZLIB) $(ZSTD_LIB)
# Any system libraries needed just for GNAT.
SYSLIBS = 

# Used from ada/gcc-interface/Make-lang.in
GNATBIND = no
GNATMAKE = no

# Used from d/Make-lang.in
GDC = no
GDCFLAGS = 

# Libs needed (at present) just for jcf-dump.
LDEXP_LIB = 

ZSTD_INC = 
ZSTD_LIB =  

# Likewise, for use in the tools that must run on this machine
# even if we are cross-building GCC.
BUILD_LIBS = $(BUILD_LIBIBERTY)

BUILD_RTL = build/rtl.o build/read-rtl.o build/ggc-none.o \
	    build/vec.o build/min-insn-modes.o build/gensupport.o \
	    build/print-rtl.o build/hash-table.o build/sort.o
BUILD_MD = build/read-md.o
BUILD_ERRORS = build/errors.o

# Specify the directories to be searched for header files.
# Both . and srcdir are used, in that order,
# so that *config.h will be found in the compilation
# subdirectory rather than in the source directory.
# -I$(@D) and -I$(srcdir)/$(@D) cause the subdirectory of the file
# currently being compiled, in both source trees, to be examined as well.
# libintl.h will be found in ../intl if we are using the included libintl.
INCLUDES = -I. -I$(@D) -I$(srcdir) -I$(srcdir)/$(@D) \
	   -I$(srcdir)/../include $(INCINTL) \
	   $(CPPINC) $(CODYINC) $(GMPINC) $(DECNUMINC) $(BACKTRACEINC) \
	   $(ISLINC)

COMPILE.base = $(COMPILER) -c $(ALL_COMPILERFLAGS) $(ALL_CPPFLAGS) -o $@
ifeq ($(CXXDEPMODE),depmode=gcc3)
# Note a subtlety here: we use $(@D) for the directory part, to make
# things like the go/%.o rule work properly; but we use $(*F) for the
# file part, as we just want the file part of the stem, not the entire
# file name.
COMPILE = $(COMPILE.base) -MT $@ -MMD -MP -MF $(@D)/$(DEPDIR)/$(*F).TPo
POSTCOMPILE = @mv $(@D)/$(DEPDIR)/$(*F).TPo $(@D)/$(DEPDIR)/$(*F).Po
else
COMPILE = source='$<' object='$@' libtool=no \
    DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) $(COMPILE.base)
POSTCOMPILE =
endif

.cc.o .c.o:
	$(COMPILE) $<
	$(POSTCOMPILE)

#
# Support for additional languages (other than C).
# C can be supported this way too (leave for later).

LANG_CONFIGUREFRAGS  =  $(srcdir)/ada/gcc-interface/config-lang.in $(srcdir)/c/config-lang.in $(srcdir)/cp/config-lang.in $(srcdir)/d/config-lang.in $(srcdir)/fortran/config-lang.in $(srcdir)/go/config-lang.in $(srcdir)/jit/config-lang.in $(srcdir)/lto/config-lang.in $(srcdir)/m2/config-lang.in $(srcdir)/objc/config-lang.in $(srcdir)/objcp/config-lang.in $(srcdir)/rust/config-lang.in
LANG_MAKEFRAGS = $(srcdir)/c/Make-lang.in  $(srcdir)/ada/gcc-interface/Make-lang.in $(srcdir)/cp/Make-lang.in $(srcdir)/d/Make-lang.in $(srcdir)/fortran/Make-lang.in $(srcdir)/go/Make-lang.in $(srcdir)/jit/Make-lang.in $(srcdir)/lto/Make-lang.in $(srcdir)/m2/Make-lang.in $(srcdir)/objc/Make-lang.in $(srcdir)/objcp/Make-lang.in $(srcdir)/rust/Make-lang.in

# Used by gcc/jit/Make-lang.in
LD_VERSION_SCRIPT_OPTION = --version-script
LD_SONAME_OPTION = -soname

# Flags to pass to recursive makes.
# CC is set by configure.
# ??? The choices here will need some experimenting with.

export AR_FOR_TARGET
export AR_CREATE_FOR_TARGET
export AR_FLAGS_FOR_TARGET
export AR_EXTRACT_FOR_TARGET
export AWK
export DESTDIR
export GCC_FOR_TARGET
export INCLUDES
export INSTALL_DATA
export LIPO_FOR_TARGET
export MACHMODE_H
export NM_FOR_TARGET
export STRIP_FOR_TARGET
export RANLIB_FOR_TARGET
export libsubdir

FLAGS_TO_PASS = \
	"ADA_CFLAGS=$(ADA_CFLAGS)" \
	"BISON=$(BISON)" \
	"BISONFLAGS=$(BISONFLAGS)" \
	"CFLAGS=$(CFLAGS) $(WARN_CFLAGS)" \
	"LDFLAGS=$(LDFLAGS)" \
	"FLEX=$(FLEX)" \
	"FLEXFLAGS=$(FLEXFLAGS)" \
	"INSTALL=$(INSTALL)" \
	"INSTALL_DATA=$(INSTALL_DATA)" \
	"INSTALL_PROGRAM=$(INSTALL_PROGRAM)" \
	"INSTALL_SCRIPT=$(INSTALL_SCRIPT)" \
	"LN=$(LN)" \
	"LN_S=$(LN_S)" \
	"RANLIB_FOR_TARGET=$(RANLIB_FOR_TARGET)" \
	"MAKEINFO=$(MAKEINFO)" \
	"MAKEINFOFLAGS=$(MAKEINFOFLAGS)" \
	"MAKEOVERRIDES=" \
	"SHELL=$(SHELL)" \
	"TFLAGS=$(TFLAGS)" \
	"exeext=$(exeext)" \
	"build_exeext=$(build_exeext)" \
	"objext=$(objext)" \
	"exec_prefix=$(exec_prefix)" \
	"prefix=$(prefix)" \
	"local_prefix=$(local_prefix)" \
	"gxx_include_dir=$(gcc_gxx_include_dir)" \
	"gxx_libcxx_include_dir=$(gcc_gxx_libcxx_include_dir)" \
	"build_tooldir=$(build_tooldir)" \
	"gcc_tooldir=$(gcc_tooldir)" \
	"bindir=$(bindir)" \
	"libexecsubdir=$(libexecsubdir)" \
	"datarootdir=$(datarootdir)" \
	"datadir=$(datadir)" \
	"libsubdir=$(libsubdir)" \
	"localedir=$(localedir)"
#
# Lists of files for various purposes.

# All option source files
ALL_OPT_FILES=$(lang_opt_files) $(extra_opt_files)

# Target specific, C specific object file
C_TARGET_OBJS=arc64-c.o default-c.o

# Target specific, C++ specific object file
CXX_TARGET_OBJS=arc64-c.o default-c.o

# Target specific, D specific object file
D_TARGET_OBJS= default-d.o

# Target specific, Fortran specific object file
FORTRAN_TARGET_OBJS=

# Object files for gcc many-languages driver.
GCC_OBJS = gcc.o gcc-main.o ggc-none.o

c-family-warn = $(STRICT_WARN)

# Language-specific object files shared by all C-family front ends.
C_COMMON_OBJS = c-family/c-common.o c-family/c-cppbuiltin.o c-family/c-dump.o \
  c-family/c-format.o c-family/c-gimplify.o c-family/c-indentation.o \
  c-family/c-lex.o c-family/c-omp.o c-family/c-opts.o c-family/c-pch.o \
  c-family/c-ppoutput.o c-family/c-pragma.o c-family/c-pretty-print.o \
  c-family/c-semantics.o c-family/c-ada-spec.o \
  c-family/c-ubsan.o c-family/known-headers.o \
  c-family/c-attribs.o c-family/c-warn.o c-family/c-spellcheck.o

# Analyzer object files
ANALYZER_OBJS = \
	analyzer/analysis-plan.o \
	analyzer/analyzer.o \
	analyzer/analyzer-language.o \
	analyzer/analyzer-logging.o \
	analyzer/analyzer-pass.o \
	analyzer/analyzer-selftests.o \
	analyzer/bar-chart.o \
	analyzer/bounds-checking.o \
	analyzer/call-details.o \
	analyzer/call-info.o \
	analyzer/call-string.o \
	analyzer/call-summary.o \
	analyzer/checker-event.o \
	analyzer/checker-path.o \
	analyzer/complexity.o \
	analyzer/constraint-manager.o \
	analyzer/diagnostic-manager.o \
	analyzer/engine.o \
	analyzer/feasible-graph.o \
	analyzer/function-set.o \
	analyzer/infinite-recursion.o \
	analyzer/kf.o \
	analyzer/kf-analyzer.o \
	analyzer/kf-lang-cp.o \
	analyzer/known-function-manager.o \
	analyzer/pending-diagnostic.o \
	analyzer/program-point.o \
	analyzer/program-state.o \
	analyzer/region.o \
	analyzer/region-model.o \
	analyzer/region-model-asm.o \
	analyzer/region-model-manager.o \
	analyzer/region-model-reachability.o \
	analyzer/sm.o \
	analyzer/sm-file.o \
	analyzer/sm-fd.o \
	analyzer/sm-malloc.o \
	analyzer/sm-pattern-test.o \
	analyzer/sm-sensitive.o \
	analyzer/sm-signal.o \
	analyzer/sm-taint.o \
	analyzer/state-purge.o \
	analyzer/store.o \
	analyzer/supergraph.o \
	analyzer/svalue.o \
	analyzer/trimmed-graph.o \
	analyzer/varargs.o

# Language-independent object files.
# We put the *-match.o and insn-*.o files first so that a parallel make
# will build them sooner, because they are large and otherwise tend to be
# the last objects to finish building.
OBJS = \
	gimple-match.o \
	generic-match.o \
	insn-attrtab.o \
	insn-automata.o \
	insn-dfatab.o \
	insn-emit.o \
	insn-extract.o \
	insn-latencytab.o \
	insn-modes.o \
	insn-opinit.o \
	insn-output.o \
	insn-peep.o \
	insn-preds.o \
	insn-recog.o \
	insn-enums.o \
	ggc-page.o \
	adjust-alignment.o \
	alias.o \
	alloc-pool.o \
	auto-inc-dec.o \
	auto-profile.o \
	bb-reorder.o \
	bitmap.o \
	builtins.o \
	caller-save.o \
	calls.o \
	ccmp.o \
	cfg.o \
	cfganal.o \
	cfgbuild.o \
	cfgcleanup.o \
	cfgexpand.o \
	cfghooks.o \
	cfgloop.o \
	cfgloopanal.o \
	cfgloopmanip.o \
	cfgrtl.o \
	ctfc.o \
	ctfout.o \
	btfout.o \
	symtab.o \
	symtab-thunks.o \
	symtab-clones.o \
	cgraph.o \
	cgraphbuild.o \
	cgraphunit.o \
	cgraphclones.o \
	combine.o \
	combine-stack-adj.o \
	compare-elim.o \
	context.o \
	convert.o \
	coroutine-passes.o \
	coverage.o \
	cppbuiltin.o \
	cppdefault.o \
	cprop.o \
	cse.o \
	cselib.o \
	data-streamer.o \
	data-streamer-in.o \
	data-streamer-out.o \
	dbgcnt.o \
	dce.o \
	ddg.o \
	debug.o \
	df-core.o \
	df-problems.o \
	df-scan.o \
	dfp.o \
	digraph.o \
	dojump.o \
	dominance.o \
	domwalk.o \
	double-int.o \
	dse.o \
	dumpfile.o \
	dwarf2asm.o \
	dwarf2cfi.o \
	dwarf2ctf.o \
	dwarf2out.o \
	early-remat.o \
	emit-rtl.o \
	et-forest.o \
	except.o \
	explow.o \
	expmed.o \
	expr.o \
	fibonacci_heap.o \
	file-prefix-map.o \
	final.o \
	fixed-value.o \
	fold-const.o \
	fold-const-call.o \
	function.o \
	function-abi.o \
	function-tests.o \
	fwprop.o \
	gcc-rich-location.o \
	gcse.o \
	gcse-common.o \
	ggc-common.o \
	ggc-tests.o \
	gimple.o \
	gimple-array-bounds.o \
	gimple-builder.o \
	gimple-expr.o \
	gimple-if-to-switch.o \
	gimple-iterator.o \
	gimple-fold.o \
	gimple-harden-conditionals.o \
	gimple-laddress.o \
	gimple-loop-interchange.o \
	gimple-loop-jam.o \
	gimple-loop-versioning.o \
	gimple-low.o \
	gimple-predicate-analysis.o \
	gimple-pretty-print.o \
	gimple-range.o \
	gimple-range-cache.o \
	gimple-range-edge.o \
	gimple-range-fold.o \
	gimple-range-gori.o \
	gimple-range-infer.o \
	gimple-range-op.o \
	gimple-range-trace.o \
	gimple-ssa-backprop.o \
	gimple-ssa-isolate-paths.o \
	gimple-ssa-nonnull-compare.o \
	gimple-ssa-split-paths.o \
	gimple-ssa-store-merging.o \
	gimple-ssa-strength-reduction.o \
	gimple-ssa-sprintf.o \
	gimple-ssa-warn-access.o \
	gimple-ssa-warn-alloca.o \
	gimple-ssa-warn-restrict.o \
	gimple-streamer-in.o \
	gimple-streamer-out.o \
	gimple-walk.o \
	gimple-warn-recursion.o \
	gimplify.o \
	gimplify-me.o \
	godump.o \
	graph.o \
	graphds.o \
	graphviz.o \
	graphite.o \
	graphite-isl-ast-to-gimple.o \
	graphite-dependences.o \
	graphite-optimize-isl.o \
	graphite-poly.o \
	graphite-scop-detection.o \
	graphite-sese-to-poly.o \
	gtype-desc.o \
	haifa-sched.o \
	hash-map-tests.o \
	hash-set-tests.o \
	hw-doloop.o \
	hwint.o \
	ifcvt.o \
	ree.o \
	inchash.o \
	incpath.o \
	init-regs.o \
	internal-fn.o \
	ipa-cp.o \
	ipa-sra.o \
	ipa-devirt.o \
	ipa-fnsummary.o \
	ipa-polymorphic-call.o \
	ipa-split.o \
	ipa-inline.o \
	ipa-comdats.o \
	ipa-free-lang-data.o \
	ipa-visibility.o \
	ipa-inline-analysis.o \
	ipa-inline-transform.o \
	ipa-modref.o \
	ipa-modref-tree.o \
	ipa-predicate.o \
	ipa-profile.o \
	ipa-prop.o \
	ipa-param-manipulation.o \
	ipa-pure-const.o \
	ipa-icf.o \
	ipa-icf-gimple.o \
	ipa-reference.o \
	ipa-ref.o \
	ipa-utils.o \
	ipa.o \
	ira.o \
	ira-build.o \
	ira-costs.o \
	ira-conflicts.o \
	ira-color.o \
	ira-emit.o \
	ira-lives.o \
	jump.o \
	langhooks.o \
	lcm.o \
	lists.o \
	loop-doloop.o \
	loop-init.o \
	loop-invariant.o \
	loop-iv.o \
	loop-unroll.o \
	lower-subreg.o \
	lra.o \
	lra-assigns.o \
	lra-coalesce.o \
	lra-constraints.o \
	lra-eliminations.o \
	lra-lives.o \
	lra-remat.o \
	lra-spills.o \
	lto-cgraph.o \
	lto-streamer.o \
	lto-streamer-in.o \
	lto-streamer-out.o \
	lto-section-in.o \
	lto-section-out.o \
	lto-opts.o \
	lto-compress.o \
	mcf.o \
	mode-switching.o \
	modulo-sched.o \
	multiple_target.o \
	omp-offload.o \
	omp-expand.o \
	omp-general.o \
	omp-low.o \
	omp-oacc-kernels-decompose.o \
	omp-oacc-neuter-broadcast.o \
	omp-simd-clone.o \
	opt-problem.o \
	optabs.o \
	optabs-libfuncs.o \
	optabs-query.o \
	optabs-tree.o \
	optinfo.o \
	optinfo-emit-json.o \
	options-save.o \
	opts-global.o \
	ordered-hash-map-tests.o \
	passes.o \
	plugin.o \
	pointer-query.o \
	postreload-gcse.o \
	postreload.o \
	predict.o \
	print-rtl.o \
	print-rtl-function.o \
	print-tree.o \
	profile.o \
	profile-count.o \
	range.o \
	range-op.o \
	range-op-float.o \
	read-md.o \
	read-rtl.o \
	read-rtl-function.o \
	real.o \
	realmpfr.o \
	recog.o \
	reg-stack.o \
	regcprop.o \
	reginfo.o \
	regrename.o \
	regstat.o \
	reload.o \
	reload1.o \
	reorg.o \
	resource.o \
	rtl-error.o \
	rtl-ssa/accesses.o \
	rtl-ssa/blocks.o \
	rtl-ssa/changes.o \
	rtl-ssa/functions.o \
	rtl-ssa/insns.o \
	rtl-tests.o \
	rtl.o \
	rtlhash.o \
	rtlanal.o \
	rtlhooks.o \
	rtx-vector-builder.o \
	run-rtl-passes.o \
	sched-deps.o \
	sched-ebb.o \
	sched-rgn.o \
	sel-sched-ir.o \
	sel-sched-dump.o \
	sel-sched.o \
	selftest-rtl.o \
	selftest-run-tests.o \
	sese.o \
	shrink-wrap.o \
	simplify-rtx.o \
	sparseset.o \
	spellcheck.o \
	spellcheck-tree.o \
	splay-tree-utils.o \
	sreal.o \
	stack-ptr-mod.o \
	statistics.o \
	stmt.o \
	stor-layout.o \
	store-motion.o \
	streamer-hooks.o \
	stringpool.o \
	substring-locations.o \
	target-globals.o \
	targhooks.o \
	timevar.o \
	toplev.o \
	tracer.o \
	trans-mem.o \
	tree-affine.o \
	asan.o \
	tsan.o \
	ubsan.o \
	sanopt.o \
	sancov.o \
	tree-call-cdce.o \
	tree-cfg.o \
	tree-cfgcleanup.o \
	tree-chrec.o \
	tree-complex.o \
	tree-data-ref.o \
	tree-dfa.o \
	tree-diagnostic.o \
	tree-diagnostic-client-data-hooks.o \
	tree-diagnostic-path.o \
	tree-dump.o \
	tree-eh.o \
	tree-emutls.o \
	tree-if-conv.o \
	tree-inline.o \
	tree-into-ssa.o \
	tree-iterator.o \
	tree-logical-location.o \
	tree-loop-distribution.o \
	tree-nested.o \
	tree-nrv.o \
	tree-object-size.o \
	tree-outof-ssa.o \
	tree-parloops.o \
	tree-phinodes.o \
	tree-predcom.o \
	tree-pretty-print.o \
	tree-profile.o \
	tree-scalar-evolution.o \
	tree-sra.o \
	tree-switch-conversion.o \
	tree-ssa-address.o \
	tree-ssa-alias.o \
	tree-ssa-ccp.o \
	tree-ssa-coalesce.o \
	tree-ssa-copy.o \
	tree-ssa-dce.o \
	tree-ssa-dom.o \
	tree-ssa-dse.o \
	tree-ssa-forwprop.o \
	tree-ssa-ifcombine.o \
	tree-ssa-live.o \
	tree-ssa-loop-ch.o \
	tree-ssa-loop-im.o \
	tree-ssa-loop-ivcanon.o \
	tree-ssa-loop-ivopts.o \
	tree-ssa-loop-manip.o \
	tree-ssa-loop-niter.o \
	tree-ssa-loop-prefetch.o \
	tree-ssa-loop-split.o \
	tree-ssa-loop-unswitch.o \
	tree-ssa-loop.o \
	tree-ssa-math-opts.o \
	tree-ssa-operands.o \
	gimple-range-path.o \
	tree-ssa-phiopt.o \
	tree-ssa-phiprop.o \
	tree-ssa-pre.o \
	tree-ssa-propagate.o \
	tree-ssa-reassoc.o \
	tree-ssa-sccvn.o \
	tree-ssa-scopedtables.o \
	tree-ssa-sink.o \
	tree-ssa-strlen.o \
	tree-ssa-structalias.o \
	tree-ssa-tail-merge.o \
	tree-ssa-ter.o \
	tree-ssa-threadbackward.o \
	tree-ssa-threadedge.o \
	tree-ssa-threadupdate.o \
	tree-ssa-uncprop.o \
	tree-ssa-uninit.o \
	tree-ssa.o \
	tree-ssanames.o \
	tree-stdarg.o \
	tree-streamer.o \
	tree-streamer-in.o \
	tree-streamer-out.o \
	tree-tailcall.o \
	tree-vect-generic.o \
	gimple-isel.o \
	tree-vect-patterns.o \
	tree-vect-data-refs.o \
	tree-vect-stmts.o \
	tree-vect-loop.o \
	tree-vect-loop-manip.o \
	tree-vect-slp.o \
	tree-vect-slp-patterns.o \
	tree-vectorizer.o \
	tree-vector-builder.o \
	tree-vrp.o \
	tree.o \
	tristate.o \
	typed-splay-tree.o \
	valtrack.o \
	value-pointer-equiv.o \
	value-query.o \
	value-range.o \
	value-range-pretty-print.o \
	value-range-storage.o \
	value-relation.o \
	value-prof.o \
	var-tracking.o \
	varasm.o \
	varpool.o \
	vec-perm-indices.o \
	vmsdbgout.o \
	vr-values.o \
	vtable-verify.o \
	warning-control.o \
	web.o \
	wide-int.o \
	wide-int-print.o \
	$(out_object_file) \
	$(ANALYZER_OBJS) \
	$(EXTRA_OBJS) \
	$(host_hook_obj)

# Objects in libcommon.a, potentially used by all host binaries and with
# no target dependencies.
OBJS-libcommon = diagnostic-spec.o diagnostic.o diagnostic-color.o \
	diagnostic-format-json.o \
	diagnostic-format-sarif.o \
	diagnostic-show-locus.o \
	edit-context.o \
	pretty-print.o intl.o \
	json.o \
	sbitmap.o \
	vec.o input.o hash-table.o ggc-none.o memory-block.o \
	selftest.o selftest-diagnostic.o sort.o

# Objects in libcommon-target.a, used by drivers and by the core
# compiler and containing target-dependent code.
OBJS-libcommon-target = $(common_out_object_file) prefix.o \
	opts.o opts-common.o options.o vec.o hooks.o common/common-targhooks.o \
	hash-table.o file-find.o spellcheck.o selftest.o opt-suggestions.o

# This lists all host objects for the front ends.
ALL_HOST_FRONTEND_OBJS = $(foreach v,$(CONFIG_LANGUAGES),$($(v)_OBJS))

ALL_HOST_BACKEND_OBJS = $(GCC_OBJS) $(OBJS) $(OBJS-libcommon) \
  $(OBJS-libcommon-target) main.o c-family/cppspec.o \
  $(COLLECT2_OBJS) $(EXTRA_GCC_OBJS) $(GCOV_OBJS) $(GCOV_DUMP_OBJS) \
  $(GCOV_TOOL_OBJS) $(GENGTYPE_OBJS) gcc-ar.o gcc-nm.o gcc-ranlib.o \
  lto-wrapper.o collect-utils.o

# for anything that is shared use the cc1plus profile data, as that
# is likely the most exercised during the build
ifeq ($(if $(wildcard ../stage_current),$(shell cat \
  ../stage_current)),stageautofeedback)
$(ALL_HOST_BACKEND_OBJS): ALL_COMPILERFLAGS += -fauto-profile=cc1plus.fda
$(ALL_HOST_BACKEND_OBJS): cc1plus.fda
endif

# This lists all host object files, whether they are included in this
# compilation or not.
ALL_HOST_OBJS = $(ALL_HOST_FRONTEND_OBJS) $(ALL_HOST_BACKEND_OBJS)

BACKEND = libbackend.a main.o libcommon-target.a libcommon.a \
	$(CPPLIB) $(LIBDECNUMBER)

# This is defined to "yes" if Tree checking is enabled, which roughly means
# front-end checking.
TREECHECKING = 

# The full name of the driver on installation
FULL_DRIVER_NAME=$(target_noncanonical)-gcc-$(version)$(exeext)

MOSTLYCLEANFILES = insn-flags.h insn-config.h insn-codes.h \
 insn-output.cc insn-recog.cc insn-emit.cc insn-extract.cc insn-peep.cc \
 insn-attr.h insn-attr-common.h insn-attrtab.cc insn-dfatab.cc \
 insn-latencytab.cc insn-opinit.cc insn-opinit.h insn-preds.cc insn-constants.h \
 tm-preds.h tm-constrs.h checksum-options gimple-match.cc generic-match.cc \
 tree-check.h min-insn-modes.cc insn-modes.cc insn-modes.h insn-modes-inline.h \
 genrtl.h gt-*.h gtype-*.h gtype-desc.cc gtyp-input.list \
 case-cfn-macros.h cfn-operators.pd \
 xgcc$(exeext) cpp$(exeext) $(FULL_DRIVER_NAME) \
 $(EXTRA_PROGRAMS) gcc-cross$(exeext) \
 $(SPECS) collect2$(exeext) gcc-ar$(exeext) gcc-nm$(exeext) \
 gcc-ranlib$(exeext) \
 genversion$(build_exeext) gcov$(exeext) gcov-dump$(exeext) \
 gcov-tool$(exeect) \
 gengtype$(exeext) *.[0-9][0-9].* *.[si] *-checksum.cc libbackend.a \
 libcommon-target.a libcommon.a libgcc.mk perf.data

# This symlink makes the full installation name of the driver be available
# from within the *build* directory, for use when running the JIT library
# from there (e.g. when running its testsuite).
$(FULL_DRIVER_NAME): ./xgcc$(exeext)
	rm -f $@
	$(LN_S) $< $@

#
# SELFTEST_DEPS need to be set before including language makefile fragments.
# Otherwise $(SELFTEST_DEPS) is empty when used from <LANG>/Make-lang.in.
SELFTEST_DEPS = $(GCC_PASSES) stmp-int-hdrs $(srcdir)/testsuite/selftests

DO_LINK_SERIALIZATION = 

# Language makefile fragments.

# The following targets define the interface between us and the languages.
#
# all.cross, start.encap, rest.encap,
# install-common, install-info, install-man,
# uninstall,
# mostlyclean, clean, distclean, maintainer-clean,
#
# Each language is linked in with a series of hooks.  The name of each
# hooked is "lang.${target_name}" (eg: lang.info).  Configure computes
# and adds these here.  We use double-colon rules for some of the hooks;
# double-colon rules should be preferred for any new hooks.

# language hooks, generated by configure
lang.all.cross:  c.all.cross c++.all.cross lto.all.cross
lang.start.encap:  c.start.encap c++.start.encap lto.start.encap
lang.rest.encap:  c.rest.encap c++.rest.encap lto.rest.encap
lang.tags:  c.tags c++.tags lto.tags
lang.install-common:  c.install-common c++.install-common lto.install-common
lang.install-man:  c.install-man c++.install-man lto.install-man
lang.install-info:  c.install-info c++.install-info lto.install-info
lang.install-dvi:  c.install-dvi c++.install-dvi lto.install-dvi
lang.install-pdf:  c.install-pdf c++.install-pdf lto.install-pdf
lang.install-html:  c.install-html c++.install-html lto.install-html
lang.dvi:  c.dvi c++.dvi lto.dvi
lang.pdf:  c.pdf c++.pdf lto.pdf
lang.html:  c.html c++.html lto.html
lang.uninstall:  c.uninstall c++.uninstall lto.uninstall
lang.info:  c.info c++.info lto.info
lang.man:  c.man c++.man lto.man
lang.srcextra:  c.srcextra c++.srcextra lto.srcextra
lang.srcman:  c.srcman c++.srcman lto.srcman
lang.srcinfo:  c.srcinfo c++.srcinfo lto.srcinfo
lang.mostlyclean:  c.mostlyclean c++.mostlyclean lto.mostlyclean
lang.clean:  c.clean c++.clean lto.clean
lang.distclean:  c.distclean c++.distclean lto.distclean
lang.maintainer-clean:  c.maintainer-clean c++.maintainer-clean lto.maintainer-clean
lang.install-plugin:  c.install-plugin c++.install-plugin lto.install-plugin
ifeq ($(DO_LINK_SERIALIZATION),)
SERIAL_LIST =
else
SERIAL_LIST = $(wordlist $(DO_LINK_SERIALIZATION),3, lto1 c++ c)
endif
SERIAL_COUNT = 4
INDEX.c = 0
c++.prev = $(if $(word 3,$(SERIAL_LIST)),$($(word 3,$(SERIAL_LIST)).serial))
INDEX.c++ = 1
lto1.prev = $(if $(word 2,$(SERIAL_LIST)),$($(word 2,$(SERIAL_LIST)).serial))
INDEX.lto1 = 2
lto2.prev = $(if $(word 1,$(SERIAL_LIST)),$($(word 1,$(SERIAL_LIST)).serial))
INDEX.lto2 = 3

ifeq ($(DO_LINK_SERIALIZATION),)
LINK_PROGRESS = :
else
LINK_PROGRESS = msg="Linking $@ |"; cnt=0; if test "$(2)" = start; then \
  idx=0; cnt2=$(DO_LINK_SERIALIZATION); \
  while test $$cnt2 -le $(1); do msg="$${msg}=="; cnt2=`expr $$cnt2 + 1`; idx=`expr $$idx + 1`; done; \
  cnt=$$idx; \
  while test $$cnt -lt $(1); do msg="$${msg}>>"; cnt=`expr $$cnt + 1`; done; \
  msg="$${msg}--"; cnt=`expr $$cnt + 1`; \
  else \
  idx=`expr $(1) + 1`; \
  while test $$cnt -le $(1); do msg="$${msg}=="; cnt=`expr $$cnt + 1`; done; \
  fi; \
  while test $$cnt -lt $(SERIAL_COUNT); do msg="$${msg}  "; cnt=`expr $$cnt + 1`; done; \
  msg="$${msg}| `expr 100 \* $$idx / $(SERIAL_COUNT)`%"; echo "$$msg"
endif

# Wire in install-gnatlib invocation with `make install' for a configuration
# with top-level libada disabled.
gnat_install_lib = 

# per-language makefile fragments
-include $(LANG_MAKEFRAGS)

# target and host overrides must follow the per-language makefile fragments
# so they can override or augment language-specific variables

# target overrides
-include $(tmake_file)

# host overrides
-include $(xmake_file)

# all-tree.def includes all the tree.def files.
all-tree.def: s-alltree; @true
s-alltree: Makefile
	rm -f tmp-all-tree.def
	echo '#include "tree.def"' > tmp-all-tree.def
	echo 'END_OF_BASE_TREE_CODES' >> tmp-all-tree.def
	echo '#include "c-family/c-common.def"' >> tmp-all-tree.def
	ltf="$(lang_tree_files)"; for f in $$ltf; do \
	  echo "#include \"$$f\""; \
	done | sed 's|$(srcdir)/||' >> tmp-all-tree.def
	$(SHELL) $(srcdir)/../move-if-change tmp-all-tree.def all-tree.def
	$(STAMP) s-alltree

# Now that LANG_MAKEFRAGS are included, we can add special flags to the
# objects that belong to the front ends.  We add an extra define that
# causes back-end specific include files to be poisoned, in the hope that
# we can avoid introducing dependencies of the front ends on things that
# no front end should ever look at (e.g. everything RTL related).
$(foreach file,$(ALL_HOST_FRONTEND_OBJS),$(eval CFLAGS-$(file) += -DIN_GCC_FRONTEND))

#

# -----------------------------
# Rebuilding this configuration
# -----------------------------

# On the use of stamps:
# Consider the example of tree-check.h. It is constructed with build/gencheck.
# A simple rule to build tree-check.h would be
# tree-check.h: build/gencheck$(build_exeext)
#	$(RUN_GEN) build/gencheck$(build_exeext) > tree-check.h
#
# but tree-check.h doesn't change every time gencheck changes. It would the
# nice if targets that depend on tree-check.h wouldn't be rebuild
# unnecessarily when tree-check.h is unchanged. To make this, tree-check.h
# must not be overwritten with a identical copy. One solution is to use a
# temporary file
# tree-check.h: build/gencheck$(build_exeext)
#	$(RUN_GEN) build/gencheck$(build_exeext) > tmp-check.h
#	$(SHELL) $(srcdir)/../move-if-change tmp-check.h tree-check.h
#
# This solution has a different problem. Since the time stamp of tree-check.h
# is unchanged, make will try to update tree-check.h every time it runs.
# To prevent this, one can add a stamp
# tree-check.h: s-check
# s-check : build/gencheck$(build_exeext)
#	$(RUN_GEN) build/gencheck$(build_exeext) > tmp-check.h
#	$(SHELL) $(srcdir)/../move-if-change tmp-check.h tree-check.h
#	$(STAMP) s-check
#
# The problem with this solution is that make thinks that tree-check.h is
# always unchanged. Make must be deceived into thinking that tree-check.h is
# rebuild by the "tree-check.h: s-check" rule. To do this, add a dummy command:
# tree-check.h: s-check; @true
# s-check : build/gencheck$(build_exeext)
#	$(RUN_GEN) build/gencheck$(build_exeext) > tmp-check.h
#	$(SHELL) $(srcdir)/../move-if-change tmp-check.h tree-check.h
#	$(STAMP) s-check
#
# This is what is done in this makefile. Note that mkconfig.sh has a
# move-if-change built-in

Makefile: config.status $(srcdir)/Makefile.in $(LANG_MAKEFRAGS)
	LANGUAGES="$(CONFIG_LANGUAGES)" \
	CONFIG_HEADERS= \
	CONFIG_SHELL="$(SHELL)" \
	CONFIG_FILES=$@ $(SHELL) config.status

config.h: cs-config.h ; @true
bconfig.h: cs-bconfig.h ; @true
tconfig.h: cs-tconfig.h ; @true
tm.h: cs-tm.h ; @true
tm_p.h: cs-tm_p.h ; @true
tm_d.h: cs-tm_d.h ; @true

cs-config.h: Makefile
	TARGET_CPU_DEFAULT="" \
	HEADERS="$(host_xm_include_list)" DEFINES="$(host_xm_defines)" \
	$(SHELL) $(srcdir)/mkconfig.sh config.h

cs-bconfig.h: Makefile
	TARGET_CPU_DEFAULT="" \
	HEADERS="$(build_xm_include_list)" DEFINES="$(build_xm_defines)" \
	$(SHELL) $(srcdir)/mkconfig.sh bconfig.h

cs-tconfig.h: Makefile
	TARGET_CPU_DEFAULT="" \
	HEADERS="$(xm_include_list)" DEFINES="USED_FOR_TARGET $(xm_defines)" \
	$(SHELL) $(srcdir)/mkconfig.sh tconfig.h

cs-tm.h: Makefile
	TARGET_CPU_DEFAULT="$(target_cpu_default)" \
	HEADERS="$(tm_include_list)" DEFINES="$(tm_defines)" \
	$(SHELL) $(srcdir)/mkconfig.sh tm.h

cs-tm_p.h: Makefile
	TARGET_CPU_DEFAULT="" \
	HEADERS="$(tm_p_include_list)" DEFINES="" \
	$(SHELL) $(srcdir)/mkconfig.sh tm_p.h

cs-tm_d.h: Makefile
	TARGET_CPU_DEFAULT="" \
	HEADERS="$(tm_d_include_list)" DEFINES="" \
	$(SHELL) $(srcdir)/mkconfig.sh tm_d.h

# Don't automatically run autoconf, since configure.ac might be accidentally
# newer than configure.  Also, this writes into the source directory which
# might be on a read-only file system.  If configured for maintainer mode
# then do allow autoconf to be run.

AUTOCONF = autoconf
ACLOCAL = aclocal
ACLOCAL_AMFLAGS = -I ../config -I ..
aclocal_deps = \
	$(srcdir)/../libtool.m4 \
	$(srcdir)/../ltoptions.m4 \
	$(srcdir)/../ltsugar.m4 \
	$(srcdir)/../ltversion.m4 \
	$(srcdir)/../lt~obsolete.m4 \
	$(srcdir)/../config/acx.m4 \
	$(srcdir)/../config/codeset.m4 \
	$(srcdir)/../config/depstand.m4 \
	$(srcdir)/../config/dfp.m4 \
	$(srcdir)/../config/gcc-plugin.m4 \
	$(srcdir)/../config/gettext-sister.m4 \
	$(srcdir)/../config/iconv.m4 \
	$(srcdir)/../config/lcmessage.m4 \
	$(srcdir)/../config/lead-dot.m4 \
	$(srcdir)/../config/lib-ld.m4 \
	$(srcdir)/../config/lib-link.m4 \
	$(srcdir)/../config/lib-prefix.m4 \
	$(srcdir)/../config/mmap.m4 \
	$(srcdir)/../config/override.m4 \
	$(srcdir)/../config/picflag.m4 \
	$(srcdir)/../config/progtest.m4 \
        $(srcdir)/../config/stdint.m4 \
	$(srcdir)/../config/warnings.m4 \
	$(srcdir)/../config/zlib.m4 \
	$(srcdir)/acinclude.m4

$(srcdir)/configure: # $(srcdir)/configure.ac $(srcdir)/aclocal.m4
	(cd $(srcdir) && $(AUTOCONF))

$(srcdir)/aclocal.m4 : # $(aclocal_deps)
	(cd $(srcdir) && $(ACLOCAL) $(ACLOCAL_AMFLAGS))

# cstamp-h.in controls rebuilding of config.in.
# It is named cstamp-h.in and not stamp-h.in so the mostlyclean rule doesn't
# delete it.  A stamp file is needed as autoheader won't update the file if
# nothing has changed.
# It remains in the source directory and is part of the distribution.
# This follows what is done in shellutils, fileutils, etc.
# "echo timestamp" is used instead of touch to be consistent with other
# packages that use autoconf (??? perhaps also to avoid problems with patch?).
# ??? Newer versions have a maintainer mode that may be useful here.

# Don't run autoheader automatically either.
# Only run it if maintainer mode is enabled.
# AUTOHEADER = autoheader
# $(srcdir)/config.in: $(srcdir)/cstamp-h.in
# $(srcdir)/cstamp-h.in: $(srcdir)/configure.ac
#	(cd $(srcdir) && $(AUTOHEADER))
#	@rm -f $(srcdir)/cstamp-h.in
#	echo timestamp > $(srcdir)/cstamp-h.in
auto-host.h: cstamp-h ; @true
cstamp-h: config.in config.status
	CONFIG_HEADERS=auto-host.h:config.in \
	CONFIG_FILES= \
	LANGUAGES="$(CONFIG_LANGUAGES)" $(SHELL) config.status

# On configurations that require auto-build.h, it is created while
# running configure, so make config.status depend on it, so that
# config.status --recheck runs and updates or creates it.
# auto-build.h: $(srcdir)/configure $(srcdir)/config.gcc
# 	@if test -f $@; then echo rerunning config.status to update $@; \
# 	else echo rerunning config.status to update $@; fi
# config.status: auto-build.h

# Really, really stupid make features, such as SUN's KEEP_STATE, may force
# a target to build even if it is up-to-date.  So we must verify that
# config.status does not exist before failing.
config.status: $(srcdir)/configure $(srcdir)/config.gcc $(LANG_CONFIGUREFRAGS)
	@if [ ! -f config.status ] ; then \
	  echo You must configure gcc.  Look at http://gcc.gnu.org/install/ for details.; \
	  false; \
	else \
	  LANGUAGES="$(CONFIG_LANGUAGES)" $(SHELL) config.status --recheck; \
	fi

# --------
# UNSORTED
# --------

# Provide quickstrap as a target that people can type into the gcc directory,
# and that fails if you're not into it.
quickstrap: all
	cd $(toplevel_builddir) && $(MAKE) all-target-libgcc

all.internal: start.encap rest.encap doc selftest
# This is what to compile if making a cross-compiler.
all.cross: native gcc-cross$(exeext) cpp$(exeext) specs \
	libgcc-support lang.all.cross doc selftest # srcextra
# This is what must be made before installing GCC and converting libraries.
start.encap: native xgcc$(exeext) cpp$(exeext) specs \
	libgcc-support lang.start.encap # srcextra
# These can't be made until after GCC can run.
rest.encap: lang.rest.encap
# This is what is made with the host's compiler
# whether making a cross compiler or not.
native: config.status auto-host.h build- $(LANGUAGES) \
	$(EXTRA_PROGRAMS) $(COLLECT2) lto-wrapper$(exeext) \
	gcc-ar$(exeext) gcc-nm$(exeext) gcc-ranlib$(exeext)

ifeq ($(enable_plugin),yes)
native: gengtype$(exeext)
endif

# On the target machine, finish building a cross compiler.
# This does the things that can't be done on the host machine.
rest.cross: specs

# GCC's selftests.
# Specify a dummy input file to placate the driver.
# Specify -nostdinc to work around missing WIND_BASE environment variable
# required for *-wrs-vxworks-* targets.
# Specify -o /dev/null so the output of -S is discarded. More importantly
# It does not try to create a file with the name "null.s" on POSIX and
# "nul.s" on Windows. Because on Windows "nul" is a reserved file name.
# Beware that /dev/null is not available to mingw tools, so directly use
# "nul" instead of "/dev/null" if we're building on a mingw machine.
# Specify the path to gcc/testsuite/selftests within the srcdir
# as an argument to -fself-test.
DEVNULL=$(if $(findstring mingw,$(build)),nul,/dev/null)
SELFTEST_FLAGS = -nostdinc $(DEVNULL) -S -o $(DEVNULL) \
	-fself-test=$(srcdir)/testsuite/selftests

# Run the selftests during the build once we have a driver and the frontend,
# so that self-test failures are caught as early as possible.
# Use "s-selftest-FE" to ensure that we only run the selftests if the
# driver, frontend, or selftest data change.
.PHONY: selftest

# Potentially run all selftest-<LANG>.  The various <LANG>/Make-lang.in can
# require the selftests to be run by defining their selftest-<LANG> as
# s-selftest-<LANG>.  Otherwise, they should define it as empty.

SELFTEST_TARGETS =  selftest-c selftest-c++ selftest-lto
selftest: $(SELFTEST_TARGETS)

# Recompile all the language-independent object files.
# This is used only if the user explicitly asks for it.
compilations: $(BACKEND)

# This archive is strictly for the host.
libbackend.a: $(OBJS)
	-rm -rf libbackend.a
	@# Build libbackend.a as a thin archive if possible, as doing so
	@# significantly reduces build times.
ifeq ($(USE_THIN_ARCHIVES),yes)
	$(AR) $(AR_FLAGS)T libbackend.a $(OBJS)
else
	$(AR) $(AR_FLAGS) libbackend.a $(OBJS)
	-$(RANLIB) $(RANLIB_FLAGS) libbackend.a
endif

libcommon-target.a: $(OBJS-libcommon-target)
	-rm -rf libcommon-target.a
	$(AR) $(AR_FLAGS) libcommon-target.a $(OBJS-libcommon-target)
	-$(RANLIB) $(RANLIB_FLAGS) libcommon-target.a

libcommon.a: $(OBJS-libcommon)
	-rm -rf libcommon.a
	$(AR) $(AR_FLAGS) libcommon.a $(OBJS-libcommon)
	-$(RANLIB) $(RANLIB_FLAGS) libcommon.a

# We call this executable `xgcc' rather than `gcc'
# to avoid confusion if the current directory is in the path
# and CC is `gcc'.  It is renamed to `gcc' when it is installed.
xgcc$(exeext): $(GCC_OBJS) c/gccspec.o libcommon-target.a $(LIBDEPS) \
	$(EXTRA_GCC_OBJS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) -o $@ $(GCC_OBJS) \
	  c/gccspec.o $(EXTRA_GCC_OBJS) libcommon-target.a \
	  $(EXTRA_GCC_LIBS) $(LIBS)

# cpp is to cpp0 as e.g. g++ is to cc1plus: Just another driver.
# It is part of c-family because the handled extensions are hard-coded
# and only contain c-family extensions (see known_suffixes).
cpp$(exeext): $(GCC_OBJS) c-family/cppspec.o libcommon-target.a $(LIBDEPS) \
	$(EXTRA_GCC_OBJS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) -o $@ $(GCC_OBJS) \
	  c-family/cppspec.o $(EXTRA_GCC_OBJS) libcommon-target.a \
	  $(EXTRA_GCC_LIBS) $(LIBS)

# Dump a specs file to make -B./ read these specs over installed ones.
$(SPECS): xgcc$(exeext)
	$(GCC_FOR_TARGET) -dumpspecs > tmp-specs
	mv tmp-specs $(SPECS)

# We do want to create an executable named `xgcc', so we can use it to
# compile libgcc2.a.
# Also create gcc-cross, so that install-common will install properly.
gcc-cross$(exeext): xgcc$(exeext)
	cp xgcc$(exeext) gcc-cross$(exeext)

checksum-options:
	echo "$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS)" > checksum-options.tmp \
	&& $(srcdir)/../move-if-change checksum-options.tmp checksum-options

#
# Build libgcc.a.

libgcc-support: libgcc.mvars stmp-int-hdrs $(TCONFIG_H) \
	$(MACHMODE_H) version.h

libgcc.mvars: config.status Makefile specs xgcc$(exeext)
	: > tmp-libgcc.mvars
	echo GCC_CFLAGS = '$(GCC_CFLAGS)' >> tmp-libgcc.mvars
	echo INHIBIT_LIBC_CFLAGS = '$(INHIBIT_LIBC_CFLAGS)' >> tmp-libgcc.mvars
	echo TARGET_SYSTEM_ROOT = '$(TARGET_SYSTEM_ROOT)' >> tmp-libgcc.mvars
	if test no = yes; then \
	  NO_PIE_CFLAGS="-fno-PIE"; \
	else \
	  NO_PIE_CFLAGS=; \
	fi; \
	echo NO_PIE_CFLAGS = "$$NO_PIE_CFLAGS" >> tmp-libgcc.mvars

	mv tmp-libgcc.mvars libgcc.mvars

# Use the genmultilib shell script to generate the information the gcc
# driver program needs to select the library directory based on the
# switches.
multilib.h: s-mlib; @true
s-mlib: $(srcdir)/genmultilib Makefile
	if test no = yes \
	   || test -n "$(MULTILIB_OSDIRNAMES)"; then \
	  $(SHELL) $(srcdir)/genmultilib \
	    "$(MULTILIB_OPTIONS)" \
	    "$(MULTILIB_DIRNAMES)" \
	    "$(MULTILIB_MATCHES)" \
	    "$(MULTILIB_EXCEPTIONS)" \
	    "$(MULTILIB_EXTRA_OPTS)" \
	    "$(MULTILIB_EXCLUSIONS)" \
	    "$(MULTILIB_OSDIRNAMES)" \
	    "$(MULTILIB_REQUIRED)" \
	    "$(if $(MULTILIB_OSDIRNAMES),,$(MULTIARCH_DIRNAME))" \
	    "$(MULTILIB_REUSE)" \
	    "no" \
	    > tmp-mlib.h; \
	else \
	  $(SHELL) $(srcdir)/genmultilib '' '' '' '' '' '' '' '' \
	    "$(MULTIARCH_DIRNAME)" '' no \
	    > tmp-mlib.h; \
	fi
	$(SHELL) $(srcdir)/../move-if-change tmp-mlib.h multilib.h
	$(STAMP) s-mlib
#
# Compiling object files from source files.

# Note that dependencies on obstack.h are not written
# because that file is not part of GCC.

srcextra: gcc.srcextra lang.srcextra

gcc.srcextra: gengtype-lex.cc
	-cp -p $^ $(srcdir)

AR_OBJS = file-find.o
AR_LIBS = 

gcc-ar$(exeext): gcc-ar.o $(AR_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) gcc-ar.o -o $@ \
		$(AR_OBJS) $(LIBS) $(AR_LIBS)

gcc-nm$(exeext): gcc-nm.o $(AR_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) gcc-nm.o -o $@ \
		$(AR_OBJS) $(LIBS) $(AR_LIBS)

gcc-ranlib$(exeext): gcc-ranlib.o $(AR_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) gcc-ranlib.o -o $@ \
		$(AR_OBJS) $(LIBS) $(AR_LIBS)

CFLAGS-gcc-ar.o += $(DRIVER_DEFINES) \
	-DTARGET_MACHINE=\"$(target_noncanonical)\" \
	 -DPERSONALITY=\"ar\"

CFLAGS-gcc-ranlib.o += $(DRIVER_DEFINES) \
	-DTARGET_MACHINE=\"$(target_noncanonical)\" \
	 -DPERSONALITY=\"ranlib\"

CFLAGS-gcc-nm.o += $(DRIVER_DEFINES) \
	-DTARGET_MACHINE=\"$(target_noncanonical)\" \
	 -DPERSONALITY=\"nm\"

# ??? the implicit rules dont trigger if the source file has a different name
# so copy instead
gcc-ranlib.cc: gcc-ar.cc
	cp $^ $@

gcc-nm.cc: gcc-ar.cc
	cp $^ $@

COLLECT2_OBJS = collect2.o collect2-aix.o vec.o ggc-none.o \
  collect-utils.o file-find.o hash-table.o selftest.o
COLLECT2_LIBS = 
collect2$(exeext): $(COLLECT2_OBJS) $(LIBDEPS)
# Don't try modifying collect2 (aka ld) in place--it might be linking this.
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) -o T$@ \
		$(COLLECT2_OBJS) $(LIBS) $(COLLECT2_LIBS)
	mv -f T$@ $@

CFLAGS-collect2.o += -DTARGET_MACHINE=\"$(target_noncanonical)\" \
	

LTO_WRAPPER_OBJS = lto-wrapper.o collect-utils.o ggc-none.o
lto-wrapper$(exeext): $(LTO_WRAPPER_OBJS) libcommon-target.a $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) -o T$@ \
	   $(LTO_WRAPPER_OBJS) libcommon-target.a $(LIBS)
	mv -f T$@ $@

# Files used by all variants of C or by the stand-alone pre-processor.

CFLAGS-c-family/c-opts.o += 

CFLAGS-c-family/c-pch.o += -DHOST_MACHINE=\"$(host)\" \
	-DTARGET_MACHINE=\"$(target)\"

default-c.o: config/default-c.cc
	$(COMPILE) $<
	$(POSTCOMPILE)

# Files used by all variants of C and some other languages.

CFLAGS-prefix.o += -DPREFIX=\"$(prefix)\" -DBASEVER=$(BASEVER_s)
prefix.o: $(BASEVER)

# Files used by the D language front end.

default-d.o: config/default-d.cc
	$(COMPILE) $<
	$(POSTCOMPILE)

# Language-independent files.

DRIVER_DEFINES = \
  -DSTANDARD_STARTFILE_PREFIX=\"$(unlibsubdir)/\" \
  -DSTANDARD_EXEC_PREFIX=\"$(libdir)/gcc/\" \
  -DSTANDARD_LIBEXEC_PREFIX=\"$(libexecdir)/gcc/\" \
  -DDEFAULT_TARGET_VERSION=\"$(version)\" \
  -DDEFAULT_REAL_TARGET_MACHINE=\"$(real_target_noncanonical)\" \
  -DDEFAULT_TARGET_MACHINE=\"$(target_noncanonical)\" \
  -DSTANDARD_BINDIR_PREFIX=\"$(bindir)/\" \
  -DTOOLDIR_BASE_PREFIX=\"$(libsubdir_to_prefix)$(prefix_to_exec_prefix)\" \
  -DACCEL_DIR_SUFFIX=\"$(accel_dir_suffix)\" \
   \
  $(VALGRIND_DRIVER_DEFINES) \
  $(if $(SHLIB),$(if $(filter yes,no),-DENABLE_SHARED_LIBGCC)) \
  -DCONFIGURE_SPECS="\"\"" \
  -DTOOL_INCLUDE_DIR=\"$(gcc_tooldir)/include\" \
  -DNATIVE_SYSTEM_HEADER_DIR=\"$(NATIVE_SYSTEM_HEADER_DIR)\"

CFLAGS-gcc.o += $(DRIVER_DEFINES) -DBASEVER=$(BASEVER_s)
gcc.o: $(BASEVER)

specs.h : s-specs ; @true
s-specs : Makefile
	lsf="$(lang_specs_files)"; for f in $$lsf; do \
	    echo "#include \"$$f\""; \
	done | sed 's|$(srcdir)/||' > tmp-specs.h
	$(SHELL) $(srcdir)/../move-if-change tmp-specs.h specs.h
	$(STAMP) s-specs

optionlist: s-options ; @true
s-options: $(ALL_OPT_FILES) Makefile $(srcdir)/opt-gather.awk
	LC_ALL=C ; export LC_ALL ; \
	$(AWK) -f $(srcdir)/opt-gather.awk $(ALL_OPT_FILES) > tmp-optionlist
	$(SHELL) $(srcdir)/../move-if-change tmp-optionlist optionlist
	$(STAMP) s-options

options.cc: optionlist $(srcdir)/opt-functions.awk $(srcdir)/opt-read.awk \
    $(srcdir)/optc-gen.awk
	$(AWK) -f $(srcdir)/opt-functions.awk -f $(srcdir)/opt-read.awk \
	       -f $(srcdir)/optc-gen.awk \
	       -v header_name="config.h system.h coretypes.h options.h tm.h" < $< > $@

options-save.cc: optionlist $(srcdir)/opt-functions.awk $(srcdir)/opt-read.awk \
    $(srcdir)/optc-save-gen.awk
	$(AWK) -f $(srcdir)/opt-functions.awk -f $(srcdir)/opt-read.awk \
	       -f $(srcdir)/optc-save-gen.awk \
	       -v header_name="config.h system.h coretypes.h tm.h" < $< > $@

options.h: s-options-h ; @true
s-options-h: optionlist $(srcdir)/opt-functions.awk $(srcdir)/opt-read.awk \
    $(srcdir)/opth-gen.awk
	$(AWK) -f $(srcdir)/opt-functions.awk -f $(srcdir)/opt-read.awk \
	       -f $(srcdir)/opth-gen.awk \
	       < $< > tmp-options.h
	$(SHELL) $(srcdir)/../move-if-change tmp-options.h options.h
	$(STAMP) $@

dumpvers: dumpvers.cc

# lto-compress.o needs $(ZLIBINC) added to the include flags.
CFLAGS-lto-compress.o += $(ZLIBINC) $(ZSTD_INC)

CFLAGS-lto-streamer-in.o += -DTARGET_MACHINE=\"$(target_noncanonical)\"

bversion.h: s-bversion; @true
s-bversion: BASE-VER
	echo "#define BUILDING_GCC_MAJOR `echo $(BASEVER_c) | sed -e 's/^\([0-9]*\).*$$/\1/'`" > bversion.h
	echo "#define BUILDING_GCC_MINOR `echo $(BASEVER_c) | sed -e 's/^[0-9]*\.\([0-9]*\).*$$/\1/'`" >> bversion.h
	echo "#define BUILDING_GCC_PATCHLEVEL `echo $(BASEVER_c) | sed -e 's/^[0-9]*\.[0-9]*\.\([0-9]*\)$$/\1/'`" >> bversion.h
	echo "#define BUILDING_GCC_VERSION (BUILDING_GCC_MAJOR * 1000 + BUILDING_GCC_MINOR)" >> bversion.h
	$(STAMP) s-bversion

CFLAGS-toplev.o += -DTARGET_NAME=\"$(target_noncanonical)\"
CFLAGS-tree-diagnostic-client-data-hooks.o += -DTARGET_NAME=\"$(target_noncanonical)\"
CFLAGS-optinfo-emit-json.o += -DTARGET_NAME=\"$(target_noncanonical)\" $(ZLIBINC)
CFLAGS-analyzer/engine.o += $(ZLIBINC)

pass-instances.def: $(srcdir)/passes.def $(PASSES_EXTRA) \
		    $(srcdir)/gen-pass-instances.awk
	$(AWK) -f $(srcdir)/gen-pass-instances.awk \
	  $(srcdir)/passes.def $(PASSES_EXTRA) > pass-instances.def

$(out_object_file): $(out_file)
	$(COMPILE) $<
	$(POSTCOMPILE)

$(common_out_object_file): $(common_out_file)
	$(COMPILE) $<
	$(POSTCOMPILE)
#
# Generate header and source files from the machine description,
# and compile them.

.PRECIOUS: insn-config.h insn-flags.h insn-codes.h insn-constants.h \
  insn-emit.cc insn-recog.cc insn-extract.cc insn-output.cc insn-peep.cc \
  insn-attr.h insn-attr-common.h insn-attrtab.cc insn-dfatab.cc \
  insn-latencytab.cc insn-preds.cc gimple-match.cc generic-match.cc \
  insn-target-def.h

# Dependencies for the md file.  The first time through, we just assume
# the md file itself and the generated dependency file (in order to get
# it built).  The second time through we have the dependency file.
-include mddeps.mk
MD_DEPS = s-mddeps $(md_file) $(MD_INCLUDES)

s-mddeps: $(md_file) $(MD_INCLUDES) build/genmddeps$(build_exeext)
	$(RUN_GEN) build/genmddeps$(build_exeext) $(md_file) > tmp-mddeps
	$(SHELL) $(srcdir)/../move-if-change tmp-mddeps mddeps.mk
	$(STAMP) s-mddeps

# For each of the files generated by running a generator program over
# the machine description, the following static pattern rules run the
# generator program only if the machine description has changed,
# but touch the target file only when its contents actually change.
# The "; @true" construct forces Make to recheck the timestamp on
# the target file.

simple_rtl_generated_h	= insn-attr.h insn-attr-common.h insn-codes.h \
			  insn-config.h insn-flags.h insn-target-def.h

simple_rtl_generated_c	= insn-automata.cc insn-emit.cc \
			  insn-extract.cc insn-output.cc \
			  insn-peep.cc insn-recog.cc

simple_generated_h	= $(simple_rtl_generated_h) insn-constants.h

simple_generated_c	= $(simple_rtl_generated_c) insn-enums.cc

$(simple_generated_h:insn-%.h=s-%) \
$(simple_generated_c:insn-%.cc=s-%): s-%: $(MD_DEPS)

$(simple_rtl_generated_h:insn-%.h=s-%) \
$(simple_rtl_generated_c:insn-%.cc=s-%): s-%: insn-conditions.md

$(simple_generated_h): insn-%.h: s-%; @true

$(simple_generated_h:insn-%.h=s-%): s-%: build/gen%$(build_exeext)
	$(RUN_GEN) build/gen$*$(build_exeext) $(md_file) \
	  $(filter insn-conditions.md,$^) > tmp-$*.h
	$(SHELL) $(srcdir)/../move-if-change tmp-$*.h insn-$*.h
	$(STAMP) s-$*

$(simple_generated_c): insn-%.cc: s-%; @true
$(simple_generated_c:insn-%.cc=s-%): s-%: build/gen%$(build_exeext)
	$(RUN_GEN) build/gen$*$(build_exeext) $(md_file) \
	  $(filter insn-conditions.md,$^) > tmp-$*.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-$*.cc insn-$*.cc
	$(STAMP) s-$*

# gencheck doesn't read the machine description, and the file produced
# doesn't use the insn-* convention.
tree-check.h: s-check ; @true
s-check : build/gencheck$(build_exeext)
	$(RUN_GEN) build/gencheck$(build_exeext) > tmp-check.h
	$(SHELL) $(srcdir)/../move-if-change tmp-check.h tree-check.h
	$(STAMP) s-check

# genattrtab produces three files: tmp-{attrtab.cc,dfatab.cc,latencytab.cc}
insn-attrtab.cc insn-dfatab.cc insn-latencytab.cc: s-attrtab ; @true
s-attrtab : $(MD_DEPS) build/genattrtab$(build_exeext) \
  insn-conditions.md
	$(RUN_GEN) build/genattrtab$(build_exeext) $(md_file) insn-conditions.md \
		-Atmp-attrtab.cc -Dtmp-dfatab.cc -Ltmp-latencytab.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-attrtab.cc    insn-attrtab.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-dfatab.cc     insn-dfatab.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-latencytab.cc insn-latencytab.cc
	$(STAMP) s-attrtab

# genopinit produces two files.
insn-opinit.cc insn-opinit.h: s-opinit ; @true
s-opinit: $(MD_DEPS) build/genopinit$(build_exeext) insn-conditions.md
	$(RUN_GEN) build/genopinit$(build_exeext) $(md_file) \
	  insn-conditions.md -htmp-opinit.h -ctmp-opinit.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-opinit.h insn-opinit.h
	$(SHELL) $(srcdir)/../move-if-change tmp-opinit.cc insn-opinit.cc
	$(STAMP) s-opinit

# gencondmd doesn't use the standard naming convention.
build/gencondmd.cc: s-conditions; @true
s-conditions: $(MD_DEPS) build/genconditions$(build_exeext)
	$(RUN_GEN) build/genconditions$(build_exeext) $(md_file) > tmp-condmd.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-condmd.cc build/gencondmd.cc
	$(STAMP) s-conditions

insn-conditions.md: s-condmd; @true
s-condmd: build/gencondmd$(build_exeext)
	$(RUN_GEN) build/gencondmd$(build_exeext) > tmp-cond.md
	$(SHELL) $(srcdir)/../move-if-change tmp-cond.md insn-conditions.md
	$(STAMP) s-condmd


# These files are generated by running the same generator more than
# once with different options, so they have custom rules.  The
# stampfile idiom is the same.
genrtl.h: s-genrtl-h; @true

s-genrtl-h: build/gengenrtl$(build_exeext)
	$(RUN_GEN) build/gengenrtl$(build_exeext) > tmp-genrtl.h
	$(SHELL) $(srcdir)/../move-if-change tmp-genrtl.h genrtl.h
	$(STAMP) s-genrtl-h

insn-modes.cc: s-modes; @true
insn-modes.h: s-modes-h; @true
insn-modes-inline.h: s-modes-inline-h; @true
min-insn-modes.cc: s-modes-m; @true

s-modes: build/genmodes$(build_exeext)
	$(RUN_GEN) build/genmodes$(build_exeext) > tmp-modes.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-modes.cc insn-modes.cc
	$(STAMP) s-modes

s-modes-h: build/genmodes$(build_exeext)
	$(RUN_GEN) build/genmodes$(build_exeext) -h > tmp-modes.h
	$(SHELL) $(srcdir)/../move-if-change tmp-modes.h insn-modes.h
	$(STAMP) s-modes-h

s-modes-inline-h: build/genmodes$(build_exeext)
	$(RUN_GEN) build/genmodes$(build_exeext) -i > tmp-modes-inline.h
	$(SHELL) $(srcdir)/../move-if-change tmp-modes-inline.h \
	  insn-modes-inline.h
	$(STAMP) s-modes-inline-h

s-modes-m: build/genmodes$(build_exeext)
	$(RUN_GEN) build/genmodes$(build_exeext) -m > tmp-min-modes.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-min-modes.cc min-insn-modes.cc
	$(STAMP) s-modes-m

insn-preds.cc: s-preds; @true
tm-preds.h: s-preds-h; @true
tm-constrs.h: s-constrs-h; @true

.PHONY: mddump
mddump: $(BUILD_RTL) $(MD_DEPS) build/genmddump$(build_exeext)
	$(RUN_GEN) build/genmddump$(build_exeext) $(md_file) > tmp-mddump.md

s-preds: $(MD_DEPS) build/genpreds$(build_exeext)
	$(RUN_GEN) build/genpreds$(build_exeext) $(md_file) > tmp-preds.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-preds.cc insn-preds.cc
	$(STAMP) s-preds

s-preds-h: $(MD_DEPS) build/genpreds$(build_exeext)
	$(RUN_GEN) build/genpreds$(build_exeext) -h $(md_file) > tmp-preds.h
	$(SHELL) $(srcdir)/../move-if-change tmp-preds.h tm-preds.h
	$(STAMP) s-preds-h

s-constrs-h: $(MD_DEPS) build/genpreds$(build_exeext)
	$(RUN_GEN) build/genpreds$(build_exeext) -c $(md_file) > tmp-constrs.h
	$(SHELL) $(srcdir)/../move-if-change tmp-constrs.h tm-constrs.h
	$(STAMP) s-constrs-h

s-case-cfn-macros: build/gencfn-macros$(build_exeext)
	$(RUN_GEN) build/gencfn-macros$(build_exeext) -c \
	  > tmp-case-cfn-macros.h
	$(SHELL) $(srcdir)/../move-if-change tmp-case-cfn-macros.h \
	  case-cfn-macros.h
	$(STAMP) s-case-cfn-macros
case-cfn-macros.h: s-case-cfn-macros; @true

s-cfn-operators: build/gencfn-macros$(build_exeext)
	$(RUN_GEN) build/gencfn-macros$(build_exeext) -o \
	  > tmp-cfn-operators.pd
	$(SHELL) $(srcdir)/../move-if-change tmp-cfn-operators.pd \
	  cfn-operators.pd
	$(STAMP) s-cfn-operators
cfn-operators.pd: s-cfn-operators; @true

target-hooks-def.h: s-target-hooks-def-h; @true
# make sure that when we build info files, the used tm.texi is up to date.
$(srcdir)/doc/tm.texi: s-tm-texi; @true

s-target-hooks-def-h: build/genhooks$(build_exeext)
	$(RUN_GEN) build/genhooks$(build_exeext) "Target Hook" \
					     > tmp-target-hooks-def.h
	$(SHELL) $(srcdir)/../move-if-change tmp-target-hooks-def.h \
					     target-hooks-def.h
	$(STAMP) s-target-hooks-def-h

c-family/c-target-hooks-def.h: s-c-target-hooks-def-h; @true

s-c-target-hooks-def-h: build/genhooks$(build_exeext)
	$(RUN_GEN) build/genhooks$(build_exeext) "C Target Hook" \
					     > tmp-c-target-hooks-def.h
	$(SHELL) $(srcdir)/../move-if-change tmp-c-target-hooks-def.h \
					     c-family/c-target-hooks-def.h
	$(STAMP) s-c-target-hooks-def-h

common/common-target-hooks-def.h: s-common-target-hooks-def-h; @true

s-common-target-hooks-def-h: build/genhooks$(build_exeext)
	$(RUN_GEN) build/genhooks$(build_exeext) "Common Target Hook" \
					     > tmp-common-target-hooks-def.h
	$(SHELL) $(srcdir)/../move-if-change tmp-common-target-hooks-def.h \
					     common/common-target-hooks-def.h
	$(STAMP) s-common-target-hooks-def-h

d/d-target-hooks-def.h: s-d-target-hooks-def-h; @true

s-d-target-hooks-def-h: build/genhooks$(build_exeext)
	$(RUN_GEN) build/genhooks$(build_exeext) "D Target Hook" \
					     > tmp-d-target-hooks-def.h
	$(SHELL) $(srcdir)/../move-if-change tmp-d-target-hooks-def.h \
					     d/d-target-hooks-def.h
	$(STAMP) s-d-target-hooks-def-h

# check if someone mistakenly only changed tm.texi.
# We use a different pathname here to avoid a circular dependency.
s-tm-texi: $(srcdir)/doc/../doc/tm.texi

# The tm.texi we want to compare against / check into svn should have
# unix-style line endings.  To make this work on MinGW, remove \r.
# \r is not portable to Solaris tr, therefore we have a special
# case for ASCII.  We use \r for other encodings like EBCDIC.
s-tm-texi: build/genhooks$(build_exeext) $(srcdir)/doc/tm.texi.in
	$(RUN_GEN) build/genhooks$(build_exeext) -d \
			$(srcdir)/doc/tm.texi.in > tmp-tm.texi
	case `echo X|tr X '\101'` in \
	  A) tr -d '\015' < tmp-tm.texi > tmp2-tm.texi ;; \
	  *) tr -d '\r' < tmp-tm.texi > tmp2-tm.texi ;; \
	esac
	mv tmp2-tm.texi tmp-tm.texi
	$(SHELL) $(srcdir)/../move-if-change tmp-tm.texi tm.texi
	@if cmp -s $(srcdir)/doc/tm.texi tm.texi; then \
	  $(STAMP) $@; \
	elif test $(srcdir)/doc/tm.texi -nt $(srcdir)/doc/tm.texi.in \
	  && ( test $(srcdir)/doc/tm.texi -nt $(srcdir)/target.def \
	    || test $(srcdir)/doc/tm.texi -nt $(srcdir)/c-family/c-target.def \
	    || test $(srcdir)/doc/tm.texi -nt $(srcdir)/common/common-target.def \
	    || test $(srcdir)/doc/tm.texi -nt $(srcdir)/d/d-target.def \
	  ); then \
	  echo >&2 ; \
	  echo You should edit $(srcdir)/doc/tm.texi.in rather than $(srcdir)/doc/tm.texi . >&2 ; \
	  false; \
	else \
	  echo >&2 ; \
	  echo Verify that you have permission to grant a GFDL license for all >&2 ; \
	  echo new text in $(objdir)/tm.texi, then copy it to $(srcdir)/doc/tm.texi. >&2 ; \
	  false; \
	fi

gimple-match.cc: s-match gimple-match-head.cc ; @true
generic-match.cc: s-match generic-match-head.cc ; @true

s-match: build/genmatch$(build_exeext) $(srcdir)/match.pd cfn-operators.pd
	$(RUN_GEN) build/genmatch$(build_exeext) --gimple $(srcdir)/match.pd \
	    > tmp-gimple-match.cc
	$(RUN_GEN) build/genmatch$(build_exeext) --generic $(srcdir)/match.pd \
	    > tmp-generic-match.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-gimple-match.cc \
	    					gimple-match.cc
	$(SHELL) $(srcdir)/../move-if-change tmp-generic-match.cc \
	    					generic-match.cc
	$(STAMP) s-match

GTFILES = $(CPPLIB_H) $(srcdir)/input.h $(srcdir)/coretypes.h \
  $(host_xm_file_list) \
  $(OPTIONS_H_EXTRA) \
  $(tm_file_list) $(HASHTAB_H) $(SPLAY_TREE_H) $(srcdir)/bitmap.h \
  $(srcdir)/wide-int.h $(srcdir)/alias.h \
  $(srcdir)/coverage.cc  $(srcdir)/rtl.h \
  $(srcdir)/optabs.h $(srcdir)/tree.h $(srcdir)/tree-core.h \
  $(srcdir)/libfuncs.h $(SYMTAB_H) \
  $(srcdir)/real.h $(srcdir)/function.h $(srcdir)/insn-addr.h $(srcdir)/hwint.h \
  $(srcdir)/fixed-value.h \
  $(srcdir)/function-abi.h \
  $(srcdir)/output.h $(srcdir)/cfgloop.h $(srcdir)/cfg.h $(srcdir)/profile-count.h \
  $(srcdir)/cselib.h $(srcdir)/basic-block.h  $(srcdir)/ipa-ref.h $(srcdir)/cgraph.h \
  $(srcdir)/symtab-thunks.h $(srcdir)/symtab-thunks.cc \
  $(srcdir)/symtab-clones.h \
  $(srcdir)/reload.h $(srcdir)/caller-save.cc $(srcdir)/symtab.cc \
  $(srcdir)/alias.cc $(srcdir)/bitmap.cc $(srcdir)/cselib.cc $(srcdir)/cgraph.cc \
  $(srcdir)/ipa-prop.cc $(srcdir)/ipa-cp.cc $(srcdir)/ipa-utils.h \
  $(srcdir)/ipa-param-manipulation.h $(srcdir)/ipa-sra.cc \
  $(srcdir)/ipa-modref.h $(srcdir)/ipa-modref.cc \
  $(srcdir)/ipa-modref-tree.h \
  $(srcdir)/signop.h \
  $(srcdir)/diagnostic-spec.h $(srcdir)/diagnostic-spec.cc \
  $(srcdir)/dwarf2out.h \
  $(srcdir)/dwarf2asm.cc \
  $(srcdir)/dwarf2cfi.cc \
  $(srcdir)/dwarf2ctf.cc \
  $(srcdir)/dwarf2out.cc \
  $(srcdir)/ctfc.h \
  $(srcdir)/ctfout.cc \
  $(srcdir)/btfout.cc \
  $(srcdir)/tree-vect-generic.cc \
  $(srcdir)/gimple-isel.cc \
  $(srcdir)/dojump.cc $(srcdir)/emit-rtl.h \
  $(srcdir)/emit-rtl.cc $(srcdir)/except.h $(srcdir)/explow.cc $(srcdir)/expr.cc \
  $(srcdir)/expr.h \
  $(srcdir)/function.cc $(srcdir)/except.cc \
  $(srcdir)/ggc-tests.cc \
  $(srcdir)/gcse.cc $(srcdir)/godump.cc \
  $(srcdir)/lists.cc $(srcdir)/optabs-libfuncs.cc \
  $(srcdir)/profile.cc $(srcdir)/mcf.cc \
  $(srcdir)/reg-stack.cc $(srcdir)/cfgrtl.cc \
  $(srcdir)/stor-layout.cc \
  $(srcdir)/stringpool.cc $(srcdir)/tree.cc $(srcdir)/varasm.cc \
  $(srcdir)/gimple.h \
  $(srcdir)/gimple-ssa.h \
  $(srcdir)/tree-ssanames.cc $(srcdir)/tree-eh.cc $(srcdir)/tree-ssa-address.cc \
  $(srcdir)/tree-cfg.cc $(srcdir)/tree-ssa-loop-ivopts.cc \
  $(srcdir)/tree-dfa.cc \
  $(srcdir)/tree-iterator.cc $(srcdir)/gimple-expr.cc \
  $(srcdir)/tree-chrec.h \
  $(srcdir)/tree-scalar-evolution.cc \
  $(srcdir)/tree-ssa-operands.h \
  $(srcdir)/tree-profile.cc $(srcdir)/tree-nested.cc \
  $(srcdir)/omp-offload.h \
  $(srcdir)/omp-general.cc \
  $(srcdir)/omp-low.cc \
  $(srcdir)/targhooks.cc $(out_file) $(srcdir)/passes.cc \
  $(srcdir)/cgraphclones.cc \
  $(srcdir)/tree-phinodes.cc \
  $(srcdir)/tree-ssa-alias.h \
  $(srcdir)/tree-ssanames.h \
  $(srcdir)/tree-vrp.h \
  $(srcdir)/value-range.h \
  $(srcdir)/value-range-storage.h \
  $(srcdir)/ipa-prop.h \
  $(srcdir)/trans-mem.cc \
  $(srcdir)/lto-streamer.h \
  $(srcdir)/target-globals.h \
  $(srcdir)/ipa-predicate.h \
  $(srcdir)/ipa-fnsummary.h \
  $(srcdir)/vtable-verify.cc \
  $(srcdir)/asan.cc \
  $(srcdir)/ubsan.cc \
  $(srcdir)/tsan.cc \
  $(srcdir)/sanopt.cc \
  $(srcdir)/sancov.cc \
  $(srcdir)/ipa-devirt.cc \
  $(srcdir)/internal-fn.h \
  $(srcdir)/calls.cc \
  $(srcdir)/omp-general.h \
  $(srcdir)/analyzer/analyzer-language.cc \
   [ada] $(srcdir)/ada/gcc-interface/ada-tree.h $(srcdir)/ada/gcc-interface/gigi.h $(srcdir)/ada/gcc-interface/decl.cc $(srcdir)/ada/gcc-interface/trans.cc $(srcdir)/ada/gcc-interface/utils.cc $(srcdir)/ada/gcc-interface/misc.cc [c] $(srcdir)/c/c-lang.cc $(srcdir)/c/c-tree.h $(srcdir)/c/c-decl.cc $(srcdir)/c-family/c-common.cc $(srcdir)/c-family/c-common.h $(srcdir)/c-family/c-objc.h $(srcdir)/c-family/c-cppbuiltin.cc $(srcdir)/c-family/c-pragma.h $(srcdir)/c-family/c-pragma.cc $(srcdir)/c-family/c-format.cc $(srcdir)/c/c-objc-common.cc $(srcdir)/c/c-parser.h $(srcdir)/c/c-parser.cc $(srcdir)/c/c-lang.h [cp] $(srcdir)/cp/name-lookup.h $(srcdir)/cp/cp-tree.h $(srcdir)/c-family/c-common.h $(srcdir)/c-family/c-objc.h $(srcdir)/c-family/c-pragma.h $(srcdir)/cp/decl.h $(srcdir)/cp/parser.h $(srcdir)/c-family/c-common.cc $(srcdir)/c-family/c-format.cc $(srcdir)/c-family/c-cppbuiltin.cc $(srcdir)/c-family/c-pragma.cc $(srcdir)/cp/call.cc $(srcdir)/cp/class.cc $(srcdir)/cp/constexpr.cc $(srcdir)/cp/contracts.cc $(srcdir)/cp/constraint.cc $(srcdir)/cp/coroutines.cc $(srcdir)/cp/cp-gimplify.cc $(srcdir)/cp/cp-lang.cc $(srcdir)/cp/cp-objcp-common.cc $(srcdir)/cp/decl.cc $(srcdir)/cp/decl2.cc $(srcdir)/cp/except.cc $(srcdir)/cp/friend.cc $(srcdir)/cp/init.cc $(srcdir)/cp/lambda.cc $(srcdir)/cp/lex.cc $(srcdir)/cp/logic.cc $(srcdir)/cp/mangle.cc $(srcdir)/cp/method.cc $(srcdir)/cp/module.cc $(srcdir)/cp/name-lookup.cc $(srcdir)/cp/parser.cc $(srcdir)/cp/pt.cc $(srcdir)/cp/rtti.cc $(srcdir)/cp/semantics.cc $(srcdir)/cp/tree.cc $(srcdir)/cp/typeck2.cc $(srcdir)/cp/vtable-class-hierarchy.cc  [d] $(srcdir)/d/d-tree.h $(srcdir)/d/d-builtins.cc $(srcdir)/d/d-lang.cc $(srcdir)/d/typeinfo.cc [fortran] $(srcdir)/fortran/f95-lang.cc $(srcdir)/fortran/trans-decl.cc $(srcdir)/fortran/trans-intrinsic.cc $(srcdir)/fortran/trans-io.cc $(srcdir)/fortran/trans-stmt.cc $(srcdir)/fortran/trans-types.cc $(srcdir)/fortran/trans-types.h $(srcdir)/fortran/trans.h $(srcdir)/fortran/trans-const.h [go] $(srcdir)/go/go-lang.cc $(srcdir)/go/go-c.h [jit] $(srcdir)/jit/dummy-frontend.cc [lto] $(srcdir)/lto/lto-tree.h $(srcdir)/lto/lto-lang.cc $(srcdir)/lto/lto.cc $(srcdir)/lto/lto.h $(srcdir)/lto/lto-common.h $(srcdir)/lto/lto-common.cc $(srcdir)/lto/lto-dump.cc [m2] $(srcdir)/m2/gm2-lang.cc          $(srcdir)/m2/gm2-lang.h          $(srcdir)/m2/gm2-gcc/rtegraph.cc          $(srcdir)/m2/gm2-gcc/m2block.cc          $(srcdir)/m2/gm2-gcc/m2builtins.cc          $(srcdir)/m2/gm2-gcc/m2decl.cc          $(srcdir)/m2/gm2-gcc/m2except.cc          $(srcdir)/m2/gm2-gcc/m2expr.cc          $(srcdir)/m2/gm2-gcc/m2statement.cc          $(srcdir)/m2/gm2-gcc/m2type.cc [objc] $(srcdir)/objc/objc-map.h $(srcdir)/c-family/c-objc.h $(srcdir)/objc/objc-act.h $(srcdir)/objc/objc-act.cc $(srcdir)/objc/objc-runtime-shared-support.cc $(srcdir)/objc/objc-gnu-runtime-abi-01.cc $(srcdir)/objc/objc-next-runtime-abi-01.cc $(srcdir)/objc/objc-next-runtime-abi-02.cc $(srcdir)/c/c-parser.h $(srcdir)/c/c-parser.cc $(srcdir)/c/c-tree.h $(srcdir)/c/c-decl.cc $(srcdir)/c/c-lang.h $(srcdir)/c/c-objc-common.cc $(srcdir)/c-family/c-common.cc $(srcdir)/c-family/c-common.h $(srcdir)/c-family/c-cppbuiltin.cc $(srcdir)/c-family/c-pragma.h $(srcdir)/c-family/c-pragma.cc $(srcdir)/c-family/c-format.cc [objcp] $(srcdir)/cp/name-lookup.h $(srcdir)/cp/cp-tree.h $(srcdir)/c-family/c-common.h $(srcdir)/c-family/c-objc.h $(srcdir)/c-family/c-pragma.h $(srcdir)/cp/decl.h $(srcdir)/cp/parser.h $(srcdir)/c-family/c-common.cc $(srcdir)/c-family/c-format.cc $(srcdir)/c-family/c-cppbuiltin.cc $(srcdir)/c-family/c-pragma.cc $(srcdir)/cp/call.cc $(srcdir)/cp/class.cc $(srcdir)/cp/constexpr.cc $(srcdir)/cp/contracts.cc $(srcdir)/cp/constraint.cc $(srcdir)/cp/coroutines.cc $(srcdir)/cp/cp-gimplify.cc $(srcdir)/objcp/objcp-lang.cc $(srcdir)/cp/cp-objcp-common.cc $(srcdir)/cp/decl.cc $(srcdir)/cp/decl2.cc $(srcdir)/cp/except.cc $(srcdir)/cp/friend.cc $(srcdir)/cp/init.cc $(srcdir)/cp/lambda.cc $(srcdir)/cp/lex.cc $(srcdir)/cp/logic.cc $(srcdir)/cp/mangle.cc $(srcdir)/cp/method.cc $(srcdir)/cp/module.cc $(srcdir)/cp/name-lookup.cc $(srcdir)/cp/parser.cc $(srcdir)/cp/pt.cc $(srcdir)/cp/rtti.cc $(srcdir)/cp/semantics.cc $(srcdir)/cp/tree.cc $(srcdir)/cp/typeck2.cc $(srcdir)/cp/vtable-class-hierarchy.cc $(srcdir)/objc/objc-act.h $(srcdir)/objc/objc-map.h $(srcdir)/objc/objc-act.cc $(srcdir)/objc/objc-gnu-runtime-abi-01.cc $(srcdir)/objc/objc-next-runtime-abi-01.cc $(srcdir)/objc/objc-next-runtime-abi-02.cc $(srcdir)/objc/objc-runtime-shared-support.cc  [rust] $(srcdir)/rust/rust-lang.cc

# Compute the list of GT header files from the corresponding C sources,
# possibly nested within config or language subdirectories.  Match gengtype's
# behavior in this respect: gt-LANG-file.h for "file" anywhere within a LANG
# language subdir, gt-file.h otherwise (no subdir indication for config/
# related sources).

GTFILES_H = $(subst /,-, \
	    $(shell echo $(patsubst $(srcdir)/%,gt-%, \
			   $(patsubst %.cc,%.h, \
			     $(filter %.cc, $(GTFILES)))) \
			| sed -e "s|/[^ ]*/|/|g" -e "s|gt-config/|gt-|g"))

GTFILES_LANG_H = $(patsubst [%], gtype-%.h, $(filter [%], $(GTFILES)))
ALL_GTFILES_H := $(sort $(GTFILES_H) $(GTFILES_LANG_H))

# $(GTFILES) may be too long to put on a command line, so we have to
# write it out to a file (taking care not to do that in a way that
# overflows a command line!) and then have gengtype read the file in.

$(ALL_GTFILES_H) gtype-desc.cc gtype-desc.h gtype.state: s-gtype ; @true

### Common flags to gengtype [e.g. -v or -B backupdir]
GENGTYPE_FLAGS= 

gtyp-input.list: s-gtyp-input ; @true
s-gtyp-input: Makefile
	@: $(call write_entries_to_file,$(GTFILES),tmp-gi.list)
	$(SHELL) $(srcdir)/../move-if-change tmp-gi.list gtyp-input.list
	$(STAMP) s-gtyp-input

s-gtype: $(EXTRA_GTYPE_DEPS) build/gengtype$(build_exeext) \
	$(filter-out [%], $(GTFILES)) gtyp-input.list
# First, parse all files and save a state file.
	$(RUN_GEN) build/gengtype$(build_exeext) $(GENGTYPE_FLAGS) \
                    -S $(srcdir) -I gtyp-input.list -w tmp-gtype.state
# Second, read the state file and generate all files.  This ensure that
# gtype.state is correctly read:
	$(SHELL) $(srcdir)/../move-if-change tmp-gtype.state gtype.state
	$(RUN_GEN) build/gengtype$(build_exeext) $(GENGTYPE_FLAGS) \
                    -r gtype.state
	$(STAMP) s-gtype

generated_files = config.h tm.h $(TM_P_H) $(TM_D_H) $(TM_H) multilib.h \
       $(simple_generated_h) specs.h \
       tree-check.h genrtl.h insn-modes.h insn-modes-inline.h \
       tm-preds.h tm-constrs.h \
       $(ALL_GTFILES_H) gtype-desc.cc gtype-desc.h version.h \
       options.h target-hooks-def.h insn-opinit.h \
       common/common-target-hooks-def.h pass-instances.def \
       gimple-match.cc generic-match.cc \
       c-family/c-target-hooks-def.h d/d-target-hooks-def.h \
       case-cfn-macros.h \
       cfn-operators.pd omp-device-properties.h

#
# How to compile object files to run on the build machine.

build/%.o :  # dependencies provided by explicit rule later
	$(COMPILER_FOR_BUILD) -c $(BUILD_COMPILERFLAGS) $(BUILD_CPPFLAGS) \
		-o $@ $<

# Header dependencies for the programs that generate source code.
# These are library modules...
build/errors.o : errors.cc $(BCONFIG_H) $(SYSTEM_H) errors.h
build/gensupport.o: gensupport.cc $(BCONFIG_H) $(SYSTEM_H) 		\
  $(CORETYPES_H) $(GTM_H) $(RTL_BASE_H) $(OBSTACK_H) errors.h		\
  $(HASHTAB_H) $(READ_MD_H) $(GENSUPPORT_H) $(HASH_TABLE_H)
build/ggc-none.o : ggc-none.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H) 	\
  $(GGC_H)
build/min-insn-modes.o : min-insn-modes.cc $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H)
build/print-rtl.o: print-rtl.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H)	\
  $(GTM_H) $(RTL_BASE_H)
build/read-md.o: read-md.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H)	\
  $(HASHTAB_H) errors.h $(READ_MD_H)
build/read-rtl.o: read-rtl.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H)	\
  $(GTM_H) $(RTL_BASE_H) $(OBSTACK_H) $(HASHTAB_H) $(READ_MD_H)		\
  $(GENSUPPORT_H)
build/rtl.o: rtl.cc $(BCONFIG_H) $(CORETYPES_H) $(GTM_H) $(SYSTEM_H)	\
  $(RTL_H) $(GGC_H) errors.h
build/vec.o : vec.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H) $(VEC_H)	\
  $(GGC_H) toplev.h $(DIAGNOSTIC_CORE_H) $(HASH_TABLE_H)
build/hash-table.o : hash-table.cc $(BCONFIG_H) $(SYSTEM_H)		\
  $(CORETYPES_H) $(HASH_TABLE_H) $(GGC_H) toplev.h $(DIAGNOSTIC_CORE_H)
build/sort.o : sort.cc $(BCONFIG_H) $(SYSTEM_H)
build/inchash.o : inchash.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H)	\
  $(HASHTAB_H) inchash.h
build/gencondmd.o : build/gencondmd.cc $(BCONFIG_H) $(SYSTEM_H)		\
  $(CORETYPES_H) $(GTM_H) insn-constants.h				\
  $(filter-out insn-flags.h, $(RTL_H) $(TM_P_H) $(FUNCTION_H) $(REGS_H) \
  $(RECOG_H) output.h $(FLAGS_H) $(RESOURCE_H) toplev.h $(DIAGNOSTIC_CORE_H) reload.h 	\
  $(EXCEPT_H) tm-constrs.h)
# This pulls in tm-pred.h which contains inline functions wrapping up
# predicates from the back-end so those functions must be discarded.
# No big deal since gencondmd.cc is a dummy file for non-GCC compilers.
build/gencondmd.o : \
  BUILD_CFLAGS := $(filter-out -fkeep-inline-functions, $(BUILD_CFLAGS))

# ...these are the programs themselves.
build/genattr.o : genattr.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/genattr-common.o : genattr-common.cc $(RTL_BASE_H) $(BCONFIG_H)	\
  $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/genattrtab.o : genattrtab.cc $(RTL_BASE_H) $(OBSTACK_H)		\
  $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(GGC_H)	\
  $(READ_MD_H) $(GENSUPPORT_H) $(FNMATCH_H)
build/genautomata.o : genautomata.cc $(RTL_BASE_H) $(OBSTACK_H)		\
  $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(VEC_H)	\
  $(HASHTAB_H) $(GENSUPPORT_H) $(FNMATCH_H)
build/gencheck.o : gencheck.cc all-tree.def $(BCONFIG_H) $(GTM_H)	\
	$(SYSTEM_H) $(CORETYPES_H) tree.def c-family/c-common.def	\
	$(lang_tree_files) gimple.def
build/genchecksum.o : genchecksum.cc $(BCONFIG_H) $(SYSTEM_H) $(MD5_H)
build/gencodes.o : gencodes.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(GENSUPPORT_H)
build/genconditions.o : genconditions.cc $(RTL_BASE_H) $(BCONFIG_H)	\
  $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(HASHTAB_H)		\
  $(READ_MD_H) $(GENSUPPORT_H)
build/genconfig.o : genconfig.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(GENSUPPORT_H)
build/genconstants.o : genconstants.cc $(BCONFIG_H) $(SYSTEM_H)		\
  $(CORETYPES_H) errors.h $(READ_MD_H)
build/genemit.o : genemit.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H) internal-fn.def
build/genenums.o : genenums.cc $(BCONFIG_H) $(SYSTEM_H)			\
  $(CORETYPES_H) errors.h $(READ_MD_H)
build/genextract.o : genextract.cc $(RTL_BASE_H) $(BCONFIG_H)		\
  $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/genflags.o : genflags.cc $(RTL_BASE_H) $(OBSTACK_H) $(BCONFIG_H)	\
  $(SYSTEM_H) $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/gentarget-def.o : gentarget-def.cc $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) $(RTL_BASE_H) errors.h $(READ_MD_H)		\
  $(GENSUPPORT_H) $(HASH_TABLE_H) target-insns.def
build/gengenrtl.o : gengenrtl.cc $(BCONFIG_H) $(SYSTEM_H) rtl.def

# The gengtype generator program is special: Two versions are built.
# One is for the build machine, and one is for the host to allow
# plugins to define their types and generate the supporting GGC
# datastructures and routines with GTY markers.
# The host object files depend on CONFIG_H, and the build objects
# on BCONFIG_H.  For the build objects, add -DGENERATOR_FILE manually,
# the build-%: rule doesn't apply to them.

GENGTYPE_OBJS = gengtype.o gengtype-parse.o gengtype-state.o \
  gengtype-lex.o errors.o

gengtype-lex.o build/gengtype-lex.o : gengtype-lex.cc gengtype.h $(SYSTEM_H)
CFLAGS-gengtype-lex.o += -DHOST_GENERATOR_FILE
build/gengtype-lex.o: $(BCONFIG_H)

gengtype-parse.o build/gengtype-parse.o : gengtype-parse.cc gengtype.h \
  $(SYSTEM_H)
CFLAGS-gengtype-parse.o += -DHOST_GENERATOR_FILE
build/gengtype-parse.o: $(BCONFIG_H)

gengtype-state.o build/gengtype-state.o: gengtype-state.cc $(SYSTEM_H) \
  gengtype.h errors.h version.h $(HASHTAB_H) $(OBSTACK_H) \
  $(XREGEX_H)
CFLAGS-gengtype-state.o += -DHOST_GENERATOR_FILE
build/gengtype-state.o: $(BCONFIG_H)
gengtype.o build/gengtype.o : gengtype.cc $(SYSTEM_H) gengtype.h 	\
  rtl.def insn-notes.def errors.h version.h     		\
  $(HASHTAB_H) $(OBSTACK_H) $(XREGEX_H)
CFLAGS-gengtype.o += -DHOST_GENERATOR_FILE
build/gengtype.o: $(BCONFIG_H)

CFLAGS-errors.o += -DHOST_GENERATOR_FILE

build/genmddeps.o: genmddeps.cc $(BCONFIG_H) $(SYSTEM_H) $(CORETYPES_H)	\
  errors.h $(READ_MD_H)
build/genmodes.o : genmodes.cc $(BCONFIG_H) $(SYSTEM_H) errors.h		\
  $(HASHTAB_H) machmode.def $(extra_modes_file)
build/genopinit.o : genopinit.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(GENSUPPORT_H) optabs.def
build/genoutput.o : genoutput.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/genpeep.o : genpeep.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(GENSUPPORT_H) toplev.h		\
  $(DIAGNOSTIC_CORE_H)
build/genpreds.o : genpreds.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H) $(OBSTACK_H)
build/genrecog.o : genrecog.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)		\
  $(HASH_TABLE_H) inchash.h
build/genhooks.o : genhooks.cc $(TARGET_DEF) $(C_TARGET_DEF)		\
  $(COMMON_TARGET_DEF) $(D_TARGET_DEF) $(BCONFIG_H) $(SYSTEM_H) errors.h
build/genmddump.o : genmddump.cc $(RTL_BASE_H) $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) $(GTM_H) errors.h $(READ_MD_H) $(GENSUPPORT_H)
build/genmatch.o : genmatch.cc $(BCONFIG_H) $(SYSTEM_H) \
  $(CORETYPES_H) errors.h $(HASH_TABLE_H) hash-map.h $(GGC_H) is-a.h \
  tree.def builtins.def internal-fn.def case-cfn-macros.h $(CPPLIB_H)
build/gencfn-macros.o : gencfn-macros.cc $(BCONFIG_H) $(SYSTEM_H)	\
  $(CORETYPES_H) errors.h $(HASH_TABLE_H) hash-set.h builtins.def	\
  internal-fn.def

# Compile the programs that generate insn-* from the machine description.
# They are compiled with $(COMPILER_FOR_BUILD), and associated libraries,
# since they need to run on this machine
# even if GCC is being compiled to run on some other machine.

# All these programs use the RTL reader ($(BUILD_RTL)).
genprogrtl = attr attr-common attrtab automata codes conditions config emit \
	     extract flags mddump opinit output peep preds recog target-def
$(genprogrtl:%=build/gen%$(build_exeext)): $(BUILD_RTL)

# All these programs use the MD reader ($(BUILD_MD)).
genprogmd = $(genprogrtl) mddeps constants enums
$(genprogmd:%=build/gen%$(build_exeext)): $(BUILD_MD)

# All these programs need to report errors.
genprogerr = $(genprogmd) genrtl modes gtype hooks cfn-macros condmd
$(genprogerr:%=build/gen%$(build_exeext)): $(BUILD_ERRORS)

# Remaining build programs.
genprog = $(genprogerr) check checksum match

# These programs need libs over and above what they get from the above list.
build/genautomata$(build_exeext) : BUILD_LIBS += -lm

build/genrecog$(build_exeext) : build/hash-table.o build/inchash.o
build/gencfn-macros$(build_exeext) : build/hash-table.o build/vec.o \
  build/ggc-none.o build/sort.o

# For stage1 and when cross-compiling use the build libcpp which is
# built with NLS disabled.  For stage2+ use the host library and
# its dependencies.
ifeq ($(build_objdir),$(build_libobjdir))
BUILD_CPPLIB = $(build_libobjdir)/libcpp/libcpp.a
else
BUILD_CPPLIB = $(CPPLIB) $(LIBIBERTY)
build/genmatch$(build_exeext): BUILD_LIBDEPS += $(LIBINTL_DEP) $(LIBICONV_DEP)
build/genmatch$(build_exeext): BUILD_LIBS += $(LIBINTL) $(LIBICONV)
endif

build/genmatch$(build_exeext) : $(BUILD_CPPLIB) \
  $(BUILD_ERRORS) build/vec.o build/hash-table.o build/sort.o

# These programs are not linked with the MD reader.
build/gengtype$(build_exeext) : build/gengtype-lex.o build/gengtype-parse.o \
              build/gengtype-state.o build/errors.o

gengtype$(exeext) : gengtype.o gengtype-lex.o gengtype-parse.o \
              gengtype-state.o errors.o $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) -o $@ \
	    $(filter-out $(LIBDEPS), $^) $(LIBS)

# Rule for the generator programs:
$(genprog:%=build/gen%$(build_exeext)): build/gen%$(build_exeext): build/gen%.o $(BUILD_LIBDEPS)
	+$(LINKER_FOR_BUILD) $(BUILD_LINKERFLAGS) $(BUILD_LDFLAGS) -o $@ \
	    $(filter-out $(BUILD_LIBDEPS), $^) $(BUILD_LIBS)

omp-general.o: omp-device-properties.h

omp_device_properties = 
omp-device-properties.h: s-omp-device-properties-h ; @true
s-omp-device-properties-h: 
	-rm -f tmp-omp-device-properties.h; \
	for kind in kind arch isa; do \
	  echo 'const char omp_offload_device_'$${kind}'[] = ' \
	    >> tmp-omp-device-properties.h; \
	  for prop in none $(omp_device_properties); do \
	    [ "$$prop" = "none" ] && continue; \
	    tgt=`echo "$$prop" | sed 's/=.*$$//'`; \
	    props=`echo "$$prop" | sed 's/.*=//'`; \
	    echo "\"$$tgt\\0\"" >> tmp-omp-device-properties.h; \
	    sed -n 's/^'$${kind}': //p' $${props} \
	      | sed 's/[[:blank:]]/ /g;s/  */ /g;s/^ //;s/ $$//;s/ /\\0/g;s/^/"/;s/$$/\\0\\0"/' \
	      >> tmp-omp-device-properties.h; \
	  done; \
	  echo '"";' >> tmp-omp-device-properties.h; \
	done; \
	$(SHELL) $(srcdir)/../move-if-change tmp-omp-device-properties.h \
	  omp-device-properties.h
	$(STAMP) s-omp-device-properties-h

# Generated source files for gengtype.  Prepend inclusion of
# config.h/bconfig.h because AIX requires _LARGE_FILES to be defined before
# any system header is included.
gengtype-lex.cc : gengtype-lex.l
	-$(FLEX) $(FLEXFLAGS) -o$@ $< && { \
	  echo '#ifdef HOST_GENERATOR_FILE' > $@.tmp; \
	  echo '#include "config.h"'       >> $@.tmp; \
	  echo '#else'                     >> $@.tmp; \
	  echo '#include "bconfig.h"'      >> $@.tmp; \
	  echo '#endif'                    >> $@.tmp; \
	  cat $@ >> $@.tmp; \
	  mv $@.tmp $@; \
	}

#
# Remake internationalization support.
CFLAGS-intl.o += -DLOCALEDIR=\"$(localedir)\"

#
# Remake cpp.

PREPROCESSOR_DEFINES = \
  -DGCC_INCLUDE_DIR=\"$(libsubdir)/include\" \
  -DFIXED_INCLUDE_DIR=\"$(libsubdir)/include-fixed\" \
  -DGPLUSPLUS_INCLUDE_DIR=\"$(gcc_gxx_include_dir)\" \
  -DGPLUSPLUS_INCLUDE_DIR_ADD_SYSROOT=$(gcc_gxx_include_dir_add_sysroot) \
  -DGPLUSPLUS_TOOL_INCLUDE_DIR=\"$(gcc_gxx_include_dir)/$(target_noncanonical)\" \
  -DGPLUSPLUS_BACKWARD_INCLUDE_DIR=\"$(gcc_gxx_include_dir)/backward\" \
  -DGPLUSPLUS_LIBCXX_INCLUDE_DIR=\"$(gcc_gxx_libcxx_include_dir)\" \
  -DGPLUSPLUS_LIBCXX_INCLUDE_DIR_ADD_SYSROOT=$(gcc_gxx_libcxx_include_dir_add_sysroot) \
  -DLOCAL_INCLUDE_DIR=\"$(local_includedir)\" \
  -DCROSS_INCLUDE_DIR=\"$(CROSS_SYSTEM_HEADER_DIR)\" \
  -DTOOL_INCLUDE_DIR=\"$(gcc_tooldir)/include\" \
  -DNATIVE_SYSTEM_HEADER_DIR=\"$(NATIVE_SYSTEM_HEADER_DIR)\" \
  -DPREFIX=\"$(prefix)/\" \
  -DSTANDARD_EXEC_PREFIX=\"$(libdir)/gcc/\" \
  

CFLAGS-cppbuiltin.o += $(PREPROCESSOR_DEFINES) -DBASEVER=$(BASEVER_s)
cppbuiltin.o: $(BASEVER)

CFLAGS-cppdefault.o += $(PREPROCESSOR_DEFINES)

# Note for the stamp targets, we run the program `true' instead of
# having an empty command (nothing following the semicolon).

# genversion.cc is run on the build machine to generate version.h
CFLAGS-build/genversion.o += -DBASEVER=$(BASEVER_s) -DDATESTAMP=$(DATESTAMP_s) \
	-DREVISION=$(REVISION_s) \
	-DDEVPHASE=$(DEVPHASE_s) -DPKGVERSION=$(PKGVERSION_s) \
	-DBUGURL=$(BUGURL_s)

build/genversion.o: genversion.cc $(BCONFIG_H) $(SYSTEM_H) $(srcdir)/DATESTAMP

build/genversion$(build_exeext): build/genversion.o
	+$(LINKER_FOR_BUILD) $(BUILD_LINKERFLAGS) $(BUILD_LDFLAGS) \
		build/genversion.o -o $@

version.h: s-version; @true
s-version: build/genversion$(build_exeext)
	build/genversion$(build_exeext) > tmp-version.h
	$(SHELL) $(srcdir)/../move-if-change tmp-version.h version.h
	$(STAMP) s-version

# gcov.o needs $(ZLIBINC) added to the include flags.
CFLAGS-gcov.o += $(ZLIBINC)

GCOV_OBJS = gcov.o json.o
gcov$(exeext): $(GCOV_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) $(GCOV_OBJS) \
		hash-table.o ggc-none.o $(LIBS) $(ZLIB) -o $@
GCOV_DUMP_OBJS = gcov-dump.o
gcov-dump$(exeext): $(GCOV_DUMP_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) $(GCOV_DUMP_OBJS) \
		hash-table.o ggc-none.o\
		$(LIBS) -o $@

GCOV_TOOL_DEP_FILES = $(srcdir)/../libgcc/libgcov-util.c gcov-io.cc $(GCOV_IO_H) \
  $(srcdir)/../libgcc/libgcov-driver.c $(srcdir)/../libgcc/libgcov-driver-system.c \
  $(srcdir)/../libgcc/libgcov-merge.c $(srcdir)/../libgcc/libgcov.h \
  $(SYSTEM_H) coretypes.h $(TM_H) $(CONFIG_H) version.h intl.h $(DIAGNOSTIC_H)
libgcov-util.o: $(srcdir)/../libgcc/libgcov-util.c $(GCOV_TOOL_DEP_FILES)
	+$(COMPILER) -c $(ALL_COMPILERFLAGS) $(ALL_CPPFLAGS) $(INCLUDES) -o $@ $<
libgcov-driver-tool.o: $(srcdir)/../libgcc/libgcov-driver.c $(GCOV_TOOL_DEP_FILES)
	+$(COMPILER) -c $(ALL_COMPILERFLAGS) $(ALL_CPPFLAGS) $(INCLUDES) \
	  -DIN_GCOV_TOOL=1 -o $@ $<
libgcov-merge-tool.o: $(srcdir)/../libgcc/libgcov-merge.c $(GCOV_TOOL_DEP_FILES)
	+$(COMPILER) -c $(ALL_COMPILERFLAGS) $(ALL_CPPFLAGS) $(INCLUDES) \
	  -DIN_GCOV_TOOL=1 -o $@ $<
GCOV_TOOL_OBJS = gcov-tool.o libgcov-util.o libgcov-driver-tool.o libgcov-merge-tool.o
gcov-tool$(exeext): $(GCOV_TOOL_OBJS) $(LIBDEPS)
	+$(LINKER) $(ALL_LINKERFLAGS) $(LDFLAGS) $(GCOV_TOOL_OBJS) $(LIBS) -o $@
#
# Build the include directories.  The stamp files are stmp-* rather than
# s-* so that mostlyclean does not force the include directory to
# be rebuilt.

# Build the include directories.
stmp-int-hdrs: $(STMP_FIXINC) $(T_GLIMITS_H) $(T_STDINT_GCC_H) $(USER_H) fixinc_list
# Copy in the headers provided with gcc.
#
# The sed command gets just the last file name component;
# this is necessary because VPATH could add a dirname.
# Using basename would be simpler, but some systems don't have it.
#
# The touch command is here to workaround an AIX/Linux NFS bug.
#
# The move-if-change + cp -p twists for limits.h are intended to preserve
# the time stamp when we regenerate, to prevent pointless rebuilds during
# e.g. install-no-fixedincludes.
	-if [ -d include ] ; then true; else mkdir include; chmod a+rx include; fi
	-if [ -d include-fixed ] ; then true; else mkdir include-fixed; chmod a+rx include-fixed; fi
	for file in .. $(USER_H); do \
	  if [ X$$file != X.. ]; then \
	    realfile=`echo $$file | sed -e 's|.*/\([^/]*\)$$|\1|'`; \
	    $(STAMP) include/$$realfile; \
	    rm -f include/$$realfile; \
	    cp $$file include; \
	    chmod a+r include/$$realfile; \
	  fi; \
	done
	for file in .. $(USER_H_INC_NEXT_PRE); do \
	  if [ X$$file != X.. ]; then \
            mv include/$$file include/x_$$file; \
            echo "#include_next <$$file>" >include/$$file; \
            cat include/x_$$file >>include/$$file; \
            rm -f include/x_$$file; \
	    chmod a+r include/$$file; \
	  fi; \
	done
	for file in .. $(USER_H_INC_NEXT_POST); do \
	  if [ X$$file != X.. ]; then \
	    echo "#include_next <$$file>" >>include/$$file; \
	    chmod a+r include/$$file; \
	  fi; \
	done
	rm -f include/stdint.h
	if [ $(USE_GCC_STDINT) = wrap ]; then \
	  rm -f include/stdint-gcc.h; \
	  cp $(srcdir)/ginclude/stdint-gcc.h include/stdint-gcc.h; \
	  chmod a+r include/stdint-gcc.h; \
	  cp $(srcdir)/ginclude/stdint-wrap.h include/stdint.h; \
	  chmod a+r include/stdint.h; \
	elif [ $(USE_GCC_STDINT) = provide ]; then \
	  cp $(T_STDINT_GCC_H) include/stdint.h; \
	  chmod a+r include/stdint.h; \
	fi
	set -e; for ml in `cat fixinc_list`; do \
	  sysroot_headers_suffix=`echo $${ml} | sed -e 's/;.*$$//'`; \
	  multi_dir=`echo $${ml} | sed -e 's/^[^;]*;//'`; \
	  include_dir=include$${multi_dir}; \
	  if $(LIMITS_H_TEST) ; then \
	    cat $(srcdir)/limitx.h $(T_GLIMITS_H) $(srcdir)/limity.h > tmp-xlimits.h; \
	  else \
	    cat $(T_GLIMITS_H) > tmp-xlimits.h; \
	  fi; \
	  $(mkinstalldirs) $${include_dir}; \
	  chmod a+rx $${include_dir} || true; \
	  $(SHELL) $(srcdir)/../move-if-change \
	    tmp-xlimits.h  tmp-limits.h; \
	  rm -f $${include_dir}/limits.h; \
	  cp -p tmp-limits.h $${include_dir}/limits.h; \
	  chmod a+r $${include_dir}/limits.h; \
	  cp $(srcdir)/gsyslimits.h $${include_dir}/syslimits.h; \
	done
# Install the README
	if [ x$(STMP_FIXINC) != x ]; then \
	  rm -f include-fixed/README; \
	  cp $(srcdir)/../fixincludes/README-fixinc include-fixed/README; \
	  chmod a+r include-fixed/README; \
	fi;
	$(STAMP) $@

.PHONY: install-gcc-tooldir
install-gcc-tooldir:
	$(mkinstalldirs) $(DESTDIR)$(gcc_tooldir)

macro_list: s-macro_list; @true
s-macro_list : $(GCC_PASSES) cc1$(exeext)
	echo | $(GCC_FOR_TARGET) -E -dM - | \
	  sed -n -e 's/^#define \([^_][a-zA-Z0-9_]*\).*/\1/p' \
		 -e 's/^#define \(_[^_A-Z][a-zA-Z0-9_]*\).*/\1/p' | \
	  sort -u > tmp-macro_list
	$(SHELL) $(srcdir)/../move-if-change tmp-macro_list macro_list
	$(STAMP) s-macro_list

fixinc_list: s-fixinc_list; @true
s-fixinc_list : $(GCC_PASSES)
# Build up a list of multilib directories and corresponding sysroot
# suffixes, in form sysroot;multilib.
	if $(GCC_FOR_TARGET) -print-sysroot-headers-suffix > /dev/null 2>&1; then \
	  set -e; for ml in `$(GCC_FOR_TARGET) -print-multi-lib`; do \
	    multi_dir=`echo $${ml} | sed -e 's/;.*$$//'`; \
	    flags=`echo $${ml} | sed -e 's/^[^;]*;//' -e 's/@/ -/g'`; \
	    sfx=`$(GCC_FOR_TARGET) $${flags} -print-sysroot-headers-suffix`; \
	    if [ "$${multi_dir}" = "." ]; \
	      then multi_dir=""; \
	    else \
	      multi_dir=/$${multi_dir}; \
	    fi; \
	    echo "$${sfx};$${multi_dir}"; \
	  done; \
	else \
	  echo ";"; \
	fi > tmp-fixinc_list
	$(SHELL) $(srcdir)/../move-if-change tmp-fixinc_list fixinc_list
	$(STAMP) s-fixinc_list

# The line below is supposed to avoid accidentally matching the
# built-in suffix rule `.o:' to build fixincl out of fixincl.o.  You'd
# expect fixincl to be newer than fixincl.o, such that this situation
# would never come up.  As it turns out, if you use ccache with
# CCACHE_HARDLINK enabled, the compiler doesn't embed the current
# working directory in object files (-g absent, or -fno-working-dir
# present), and build and host are the same, fixincl for the host will
# build after fixincl for the build machine, getting a cache hit,
# thereby updating the timestamp of fixincl.o in the host tree.
# Because of CCACHE_HARDLINK, this will also update the timestamp in
# the build tree, and so fixincl in the build tree will appear to be
# out of date.  Yuck.
../$(build_subdir)/fixincludes/fixincl: ; @ :

# Build fixed copies of system files.
# Abort if no system headers available, unless building a crosscompiler.
# FIXME: abort unless building --without-headers would be more accurate and less ugly
stmp-fixinc: gsyslimits.h macro_list fixinc_list \
  $(build_objdir)/fixincludes/fixincl \
  $(build_objdir)/fixincludes/fixinc.sh
	rm -rf include-fixed; mkdir include-fixed
	-chmod a+rx include-fixed
	if [ -d ../prev-gcc ]; then \
	  cd ../prev-gcc && \
	  $(MAKE) real-$(INSTALL_HEADERS_DIR) DESTDIR=`pwd`/../gcc/ \
	    libsubdir=. ; \
	else \
	  set -e; for ml in `cat fixinc_list`; do \
	    sysroot_headers_suffix=`echo $${ml} | sed -e 's/;.*$$//'`; \
	    multi_dir=`echo $${ml} | sed -e 's/^[^;]*;//'`; \
	    fix_dir=include-fixed$${multi_dir}; \
	    if ! $(inhibit_libc) && test ! -d ${BUILD_SYSTEM_HEADER_DIR}; then \
	      echo The directory that should contain system headers does not exist: >&2 ; \
	      echo "  ${BUILD_SYSTEM_HEADER_DIR}" >&2 ; \
	      tooldir_sysinc=`echo "${gcc_tooldir}/sys-include" | sed -e :a -e "s,[^/]*/\.\.\/,," -e ta`; \
	      if test "x${BUILD_SYSTEM_HEADER_DIR}" = "x$${tooldir_sysinc}"; \
	      then sleep 1; else exit 1; fi; \
	    fi; \
	    $(mkinstalldirs) $${fix_dir}; \
	    chmod a+rx $${fix_dir} || true; \
	    (TARGET_MACHINE='$(target)'; srcdir=`cd $(srcdir); ${PWD_COMMAND}`; \
	      SHELL='$(SHELL)'; MACRO_LIST=`${PWD_COMMAND}`/macro_list ; \
	      gcc_dir=`${PWD_COMMAND}` ; \
	      export TARGET_MACHINE srcdir SHELL MACRO_LIST && \
	      cd $(build_objdir)/fixincludes && \
	      $(SHELL) ./fixinc.sh "$${gcc_dir}/$${fix_dir}" \
	        $(BUILD_SYSTEM_HEADER_DIR) $(OTHER_FIXINCLUDES_DIRS) ); \
	  done; \
	fi
	$(STAMP) stmp-fixinc
#

# Install with the gcc headers files, not the fixed include files, which we
# are typically not allowed to distribute.  The general idea is to:
#  - Get to "install" with a bare set of internal headers, not the
#    fixed system ones,
#  - Prevent rebuilds of what normally depends on the headers, which is
#    useless for installation purposes and would rely on improper headers.
#  - Restore as much of the original state as possible.

.PHONY: install-no-fixedincludes

install-no-fixedincludes:
	# Stash the current set of headers away, save stamps we're going to
	# alter explicitly, and arrange for fixincludes not to run next time
	# we trigger a headers rebuild.
	-rm -rf tmp-include
	-mv include tmp-include 2>/dev/null
	-mv include-fixed tmp-include-fixed 2>/dev/null
	-mv stmp-int-hdrs tmp-stmp-int-hdrs 2>/dev/null
	-mv stmp-fixinc tmp-stmp-fixinc 2>/dev/null
	-mkdir include
	-cp -p $(srcdir)/gsyslimits.h include/syslimits.h
	-touch stmp-fixinc

	# Rebuild our internal headers, restore the original stamps so that
	# "install" doesn't trigger pointless rebuilds because of that update,
	# then do install
	$(MAKE) $(FLAGS_TO_PASS) stmp-int-hdrs
	-mv tmp-stmp-int-hdrs stmp-int-hdrs 2>/dev/null
	-mv tmp-stmp-fixinc stmp-fixinc 2>/dev/null
	$(MAKE) $(FLAGS_TO_PASS) install

	# Restore the original set of maybe-fixed headers
	-rm -rf include; mv tmp-include include 2>/dev/null
	-rm -rf include-fixed; mv tmp-include-fixed include-fixed 2>/dev/null

# Remake the info files.

doc: $(BUILD_INFO) $(GENERATED_MANPAGES)

INFOFILES = doc/cpp.info doc/gcc.info doc/gccint.info \
            doc/gccinstall.info doc/cppinternals.info

info: $(INFOFILES) lang.info # srcinfo lang.srcinfo

srcinfo: $(INFOFILES)
	-cp -p $^ $(srcdir)/doc

TEXI_CPP_FILES = cpp.texi fdl.texi cppenv.texi cppopts.texi		\
	 gcc-common.texi gcc-vers.texi

TEXI_GCC_FILES = gcc.texi gcc-common.texi gcc-vers.texi frontends.texi	\
	 standards.texi invoke.texi extend.texi md.texi objc.texi	\
	 gcov.texi trouble.texi bugreport.texi service.texi		\
	 contribute.texi compat.texi funding.texi gnu.texi gpl_v3.texi	\
	 fdl.texi contrib.texi cppenv.texi cppopts.texi avr-mmcu.texi	\
	 implement-c.texi implement-cxx.texi gcov-tool.texi gcov-dump.texi \
	 lto-dump.texi

# we explicitly use $(srcdir)/doc/tm.texi here to avoid confusion with
# the generated tm.texi; the latter might have a more recent timestamp,
# but we don't want to rebuild the info files unless the contents of
# the *.texi files have changed.
TEXI_GCCINT_FILES = gccint.texi gcc-common.texi gcc-vers.texi		\
	 contribute.texi makefile.texi configterms.texi options.texi	\
	 portability.texi interface.texi passes.texi rtl.texi md.texi	\
	 $(srcdir)/doc/tm.texi hostconfig.texi fragments.texi	\
	 configfiles.texi collect2.texi headerdirs.texi funding.texi	\
	 gnu.texi gpl_v3.texi fdl.texi contrib.texi languages.texi	\
	 sourcebuild.texi gty.texi libgcc.texi cfg.texi tree-ssa.texi	\
	 loop.texi generic.texi gimple.texi plugins.texi optinfo.texi   \
	 match-and-simplify.texi analyzer.texi ux.texi poly-int.texi

TEXI_GCCINSTALL_FILES = install.texi fdl.texi		\
	 gcc-common.texi gcc-vers.texi

TEXI_CPPINT_FILES = cppinternals.texi gcc-common.texi gcc-vers.texi

# gcc-vers.texi is generated from the version files.
gcc-vers.texi: $(BASEVER) $(DEVPHASE)
	(echo "@set version-GCC $(BASEVER_c)"; \
	 if [ "$(DEVPHASE_c)" = "experimental" ]; \
	 then echo "@set DEVELOPMENT"; \
	 else echo "@clear DEVELOPMENT"; \
	 fi) > $@T
	$(build_file_translate) echo @set srcdir `echo $(abs_srcdir) | sed -e 's|\\([@{}]\\)|@\\1|g'` >> $@T
	if [ -n "$(PKGVERSION)" ]; then \
	  echo "@set VERSION_PACKAGE $(PKGVERSION)" >> $@T; \
	fi
	echo "@set BUGURL $(BUGURL_TEXI)" >> $@T; \
	mv -f $@T $@


# The *.1, *.7, *.info, *.dvi, and *.pdf files are being generated from implicit
# patterns.  To use them, put each of the specific targets with its
# specific dependencies but no build commands.

doc/cpp.info: $(TEXI_CPP_FILES)
doc/gcc.info: $(TEXI_GCC_FILES)
doc/gccint.info: $(TEXI_GCCINT_FILES)
doc/cppinternals.info: $(TEXI_CPPINT_FILES)

doc/%.info: %.texi
	if [ x$(BUILD_INFO) = xinfo ]; then \
		$(MAKEINFO) $(MAKEINFOFLAGS) -I . -I $(gcc_docdir) \
			-I $(gcc_docdir)/include -o $@ $<; \
	fi

# Duplicate entry to handle renaming of gccinstall.info
doc/gccinstall.info: $(TEXI_GCCINSTALL_FILES)
	if [ x$(BUILD_INFO) = xinfo ]; then \
		$(MAKEINFO) $(MAKEINFOFLAGS) -I $(gcc_docdir) \
			-I $(gcc_docdir)/include -o $@ $<; \
	fi

doc/cpp.dvi: $(TEXI_CPP_FILES)
doc/gcc.dvi: $(TEXI_GCC_FILES)
doc/gccint.dvi: $(TEXI_GCCINT_FILES)
doc/cppinternals.dvi: $(TEXI_CPPINT_FILES)

doc/cpp.pdf: $(TEXI_CPP_FILES)
doc/gcc.pdf: $(TEXI_GCC_FILES)
doc/gccint.pdf: $(TEXI_GCCINT_FILES)
doc/cppinternals.pdf: $(TEXI_CPPINT_FILES)

$(build_htmldir)/cpp/index.html: $(TEXI_CPP_FILES)
$(build_htmldir)/gcc/index.html: $(TEXI_GCC_FILES)
$(build_htmldir)/gccint/index.html: $(TEXI_GCCINT_FILES)
$(build_htmldir)/cppinternals/index.html: $(TEXI_CPPINT_FILES)

DVIFILES = doc/gcc.dvi doc/gccint.dvi doc/gccinstall.dvi doc/cpp.dvi \
           doc/cppinternals.dvi

dvi:: $(DVIFILES) lang.dvi

doc/%.dvi: %.texi
	$(TEXI2DVI) -I . -I $(abs_docdir) -I $(abs_docdir)/include -o $@ $<

# Duplicate entry to handle renaming of gccinstall.dvi
doc/gccinstall.dvi: $(TEXI_GCCINSTALL_FILES)
	$(TEXI2DVI) -I . -I $(abs_docdir) -I $(abs_docdir)/include -o $@ $<

PDFFILES = doc/gcc.pdf doc/gccint.pdf doc/gccinstall.pdf doc/cpp.pdf \
           doc/cppinternals.pdf

pdf:: $(PDFFILES) lang.pdf

doc/%.pdf: %.texi
	$(TEXI2PDF) -I . -I $(abs_docdir) -I $(abs_docdir)/include -o $@ $<

# Duplicate entry to handle renaming of gccinstall.pdf
doc/gccinstall.pdf: $(TEXI_GCCINSTALL_FILES)
	$(TEXI2PDF) -I . -I $(abs_docdir) -I $(abs_docdir)/include -o $@ $<

# List the directories or single hmtl files which are installed by
# install-html. The lang.html file triggers language fragments to build
# html documentation.
HTMLS_INSTALL=$(build_htmldir)/cpp $(build_htmldir)/gcc \
       $(build_htmldir)/gccinstall $(build_htmldir)/gccint \
       $(build_htmldir)/cppinternals

# List the html file targets.
HTMLS_BUILD=$(build_htmldir)/cpp/index.html $(build_htmldir)/gcc/index.html \
       $(build_htmldir)/gccinstall/index.html $(build_htmldir)/gccint/index.html \
       $(build_htmldir)/cppinternals/index.html lang.html

html:: $(HTMLS_BUILD)

$(build_htmldir)/%/index.html: %.texi
	$(mkinstalldirs) $(@D)
	rm -f $(@D)/*
	$(TEXI2HTML) $(MAKEINFO_TOC_INLINE_FLAG) \
		-I $(abs_docdir) -I $(abs_docdir)/include -o $(@D) $<

# Duplicate entry to handle renaming of gccinstall
$(build_htmldir)/gccinstall/index.html: $(TEXI_GCCINSTALL_FILES)
	$(mkinstalldirs) $(@D)
	echo rm -f $(@D)/*
	SOURCEDIR=$(abs_docdir) \
	DESTDIR=$(@D) \
	$(SHELL) $(srcdir)/doc/install.texi2html

MANFILES = doc/gcov.1 doc/cpp.1 doc/gcc.1 doc/gfdl.7 doc/gpl.7 \
           doc/fsf-funding.7 doc/gcov-tool.1 doc/gcov-dump.1 \
	   $(if $(filter yes,yes),doc/lto-dump.1)

generated-manpages: man

man: $(MANFILES) lang.man # srcman lang.srcman

srcman: $(MANFILES)
	-cp -p $^ $(srcdir)/doc

doc/%.1: %.pod
	$(STAMP) $@
	-($(POD2MAN) --section=1 $< > $(@).T$$$$ && \
		mv -f $(@).T$$$$ $@) || \
		(rm -f $(@).T$$$$ && exit 1)

doc/%.7: %.pod
	$(STAMP) $@
	-($(POD2MAN) --section=7 $< > $(@).T$$$$ && \
		mv -f $(@).T$$$$ $@) || \
		(rm -f $(@).T$$$$ && exit 1)

%.pod: %.texi
	$(STAMP) $@
	-$(TEXI2POD) -DBUGURL="$(BUGURL_TEXI)" $< > $@

.INTERMEDIATE: cpp.pod gcc.pod gfdl.pod fsf-funding.pod gpl.pod
cpp.pod: cpp.texi cppenv.texi cppopts.texi

# These next rules exist because the output name is not the same as
# the input name, so our implicit %.pod rule will not work.

gcc.pod: invoke.texi cppenv.texi cppopts.texi gcc-vers.texi
	$(STAMP) $@
	-$(TEXI2POD) $< > $@
gfdl.pod: fdl.texi
	$(STAMP) $@
	-$(TEXI2POD) $< > $@
fsf-funding.pod: funding.texi
	$(STAMP) $@
	-$(TEXI2POD) $< > $@
gpl.pod: gpl_v3.texi
	$(STAMP) $@
	-$(TEXI2POD) $< > $@

#
# Deletion of files made during compilation.
# There are four levels of this:
#   `mostlyclean', `clean', `distclean' and `maintainer-clean'.
# `mostlyclean' is useful while working on a particular type of machine.
# It deletes most, but not all, of the files made by compilation.
# It does not delete libgcc.a or its parts, so it won't have to be recompiled.
# `clean' deletes everything made by running `make all'.
# `distclean' also deletes the files made by config.
# `maintainer-clean' also deletes everything that could be regenerated
# automatically, except for `configure'.
# We remove as much from the language subdirectories as we can
# (less duplicated code).

mostlyclean: lang.mostlyclean
	-rm -f $(MOSTLYCLEANFILES)
	-rm -f *$(objext) c-family/*$(objext)
	-rm -f *$(coverageexts)
# Delete build programs
	-rm -f build/*
	-rm -f mddeps.mk
# Delete other built files.
	-rm -f specs.h options.cc options.h options-save.cc
# Delete the stamp and temporary files.
	-rm -f s-* tmp-* stamp-* stmp-*
	-rm -f */stamp-* */tmp-*
# Delete debugging dump files.
	-rm -f *.[0-9][0-9].* */*.[0-9][0-9].*
# Delete some files made during installation.
	-rm -f specs $(SPECS)
	-rm -f collect collect2 mips-tfile mips-tdump
# Delete unwanted output files from TeX.
	-rm -f *.toc *.log *.vr *.fn *.cp *.tp *.ky *.pg
	-rm -f */*.toc */*.log */*.vr */*.fn */*.cp */*.tp */*.ky */*.pg
# Delete sorted indices we don't actually use.
	-rm -f gcc.vrs gcc.kys gcc.tps gcc.pgs gcc.fns
# Delete core dumps.
	-rm -f core */core
# Delete file generated for gengtype
	-rm -f gtyp-input.list
# Delete files generated by gengtype
	-rm -f gtype-*
	-rm -f gt-*
	-rm -f gtype.state
# Delete genchecksum outputs
	-rm -f *-checksum.cc
# Delete lock-and-run bits
	-rm -rf linkfe.lck lock-stamp.*

# Delete all files made by compilation
# that don't exist in the distribution.
clean: mostlyclean lang.clean
	-rm -f libgcc.a libgcc_eh.a libgcov.a
	-rm -f libgcc_s*
	-rm -f libunwind*
	-rm -f config.h tconfig.h bconfig.h tm_p.h tm.h
	-rm -f options.cc options.h optionlist
	-rm -f cs-*
	-rm -f doc/*.dvi
	-rm -f doc/*.pdf
# Delete the include directories.
	-rm -rf include include-fixed
# Delete files used by the "multilib" facility (including libgcc subdirs).
	-rm -f multilib.h tmpmultilib*
	-if [ "x$(MULTILIB_DIRNAMES)" != x ] ; then \
	  rm -rf $(MULTILIB_DIRNAMES); \
	else if [ "x$(MULTILIB_OPTIONS)" != x ] ; then \
	  rm -rf `echo $(MULTILIB_OPTIONS) | sed -e 's/\// /g'`; \
	fi ; fi

# Delete all files that users would normally create
# while building and installing GCC.
distclean: clean lang.distclean
	-rm -f auto-host.h auto-build.h
	-rm -f cstamp-h
	-rm -f config.status config.run config.cache config.bak
	-rm -f Make-lang Make-hooks Make-host Make-target
	-rm -f Makefile *.oaux
	-rm -f gthr-default.h
	-rm -f TAGS */TAGS
	-rm -f *.asm
	-rm -f site.exp site.bak testsuite/site.exp testsuite/site.bak
	-rm -f testsuite/*.log testsuite/*.sum
	-cd testsuite && rm -f x *.x *.x? *.exe *.rpo *.o *.s *.S *.cc
	-cd testsuite && rm -f *.out *.gcov *$(coverageexts)
	-rm -rf ${QMTEST_DIR} stamp-qmtest
	-rm -f .gdbinit configargs.h
	-rm -f gcov.pod
# Delete po/*.gmo only if we are not building in the source directory.
	-if [ ! -f po/exgettext ]; then rm -f po/*.gmo; fi
	-rmdir ada cp f java objc intl po testsuite plugin 2>/dev/null

# Get rid of every file that's generated from some other file, except for `configure'.
# Most of these files ARE PRESENT in the GCC distribution.
maintainer-clean:
	@echo 'This command is intended for maintainers to use; it'
	@echo 'deletes files that may need special tools to rebuild.'
	$(MAKE) lang.maintainer-clean distclean
	-rm -f cpp.??s cpp.*aux
	-rm -f gcc.??s gcc.*aux
	-rm -f $(gcc_docdir)/*.info $(gcc_docdir)/*.1 $(gcc_docdir)/*.7 $(gcc_docdir)/*.dvi $(gcc_docdir)/*.pdf
#
# Entry points `install', `install-strip', and `uninstall'.
# Also use `install-collect2' to install collect2 when the config files don't.

# Copy the compiler files into directories where they will be run.
# Install the driver last so that the window when things are
# broken is small.
install: install-common $(INSTALL_HEADERS) \
    install-cpp install-man install-info install- \
    install-driver install-lto-wrapper install-gcc-ar

ifeq ($(enable_plugin),yes)
install: install-plugin
endif

install-strip: override INSTALL_PROGRAM = $(INSTALL_STRIP_PROGRAM)
ifneq ($(STRIP),)
install-strip: STRIPPROG = $(STRIP)
export STRIPPROG
endif
install-strip: install

# Handle cpp installation.
install-cpp: installdirs cpp$(exeext)
	-if test "$(enable_as_accelerator)" != "yes" ; then \
	  rm -f $(DESTDIR)$(bindir)/$(CPP_INSTALL_NAME)$(exeext); \
	  $(INSTALL_PROGRAM) -m 755 cpp$(exeext) $(DESTDIR)$(bindir)/$(CPP_INSTALL_NAME)$(exeext); \
	  if [ x$(cpp_install_dir) != x ]; then \
	    rm -f $(DESTDIR)$(prefix)/$(cpp_install_dir)/$(CPP_INSTALL_NAME)$(exeext); \
	    $(INSTALL_PROGRAM) -m 755 cpp$(exeext) $(DESTDIR)$(prefix)/$(cpp_install_dir)/$(CPP_INSTALL_NAME)$(exeext); \
	  else true; fi; \
	fi

# Create the installation directories.
# $(libdir)/gcc/include isn't currently searched by cpp.
installdirs:
	$(mkinstalldirs) $(DESTDIR)$(libsubdir)
	$(mkinstalldirs) $(DESTDIR)$(libexecsubdir)
	$(mkinstalldirs) $(DESTDIR)$(bindir)
	$(mkinstalldirs) $(DESTDIR)$(includedir)
	$(mkinstalldirs) $(DESTDIR)$(infodir)
	$(mkinstalldirs) $(DESTDIR)$(man1dir)
	$(mkinstalldirs) $(DESTDIR)$(man7dir)

PLUGIN_HEADERS = $(TREE_H) $(CONFIG_H) $(SYSTEM_H) coretypes.h $(TM_H) \
  toplev.h $(DIAGNOSTIC_CORE_H) $(BASIC_BLOCK_H) $(HASH_TABLE_H) \
  tree-ssa-alias.h $(INTERNAL_FN_H) gimple-fold.h tree-eh.h gimple-expr.h \
  gimple.h is-a.h memmodel.h $(TREE_PASS_H) $(GCC_PLUGIN_H) \
  $(GGC_H) $(TREE_DUMP_H) $(PRETTY_PRINT_H) $(OPTS_H) $(PARAMS_H) \
  $(tm_file_list) $(tm_include_list) $(tm_p_file_list) $(tm_p_include_list) \
  $(host_xm_file_list) $(host_xm_include_list) $(xm_include_list) \
  intl.h $(PLUGIN_VERSION_H) $(DIAGNOSTIC_H) ${C_TREE_H} \
  $(C_COMMON_H) c-family/c-objc.h $(C_PRETTY_PRINT_H) \
  tree-iterator.h $(PLUGIN_H) $(TREE_SSA_H) langhooks.h incpath.h debug.h \
  $(EXCEPT_H) tree-ssa-sccvn.h real.h output.h $(IPA_UTILS_H) \
  ipa-param-manipulation.h $(C_PRAGMA_H)  $(CPPLIB_H)  $(FUNCTION_H) \
  cppdefault.h flags.h $(MD5_H) params.def params.h params-enum.h \
  prefix.h tree-inline.h $(GIMPLE_PRETTY_PRINT_H) realmpfr.h \
  $(IPA_PROP_H) $(TARGET_H) $(RTL_H) $(TM_P_H) $(CFGLOOP_H) $(EMIT_RTL_H) \
  version.h stringpool.h gimplify.h gimple-iterator.h gimple-ssa.h \
  fold-const.h fold-const-call.h tree-cfg.h tree-into-ssa.h tree-ssanames.h \
  print-tree.h varasm.h context.h tree-phinodes.h stor-layout.h \
  ssa-iterators.h $(RESOURCE_H) tree-cfgcleanup.h attribs.h calls.h \
  cfgexpand.h diagnostic-color.h gcc-symtab.h gimple-builder.h gimple-low.h \
  gimple-walk.h gimplify-me.h pass_manager.h print-rtl.h stmt.h \
  tree-dfa.h tree-hasher.h tree-nested.h tree-object-size.h tree-outof-ssa.h \
  tree-parloops.h tree-ssa-address.h tree-ssa-coalesce.h tree-ssa-dom.h \
  tree-ssa-loop.h tree-ssa-loop-ivopts.h tree-ssa-loop-manip.h \
  tree-ssa-loop-niter.h tree-ssa-ter.h tree-ssa-threadedge.h \
  tree-ssa-threadupdate.h inchash.h wide-int.h signop.h hash-map.h \
  hash-set.h dominance.h cfg.h cfgrtl.h cfganal.h cfgbuild.h cfgcleanup.h \
  lcm.h cfgloopmanip.h file-prefix-map.h builtins.def $(INSN_ATTR_H) \
  pass-instances.def params.list $(srcdir)/../include/gomp-constants.h \
  $(EXPR_H)

# generate the 'build fragment' b-header-vars
s-header-vars: Makefile
	rm -f tmp-header-vars
# The first sed gets the list "header variables" as the list variables
# assigned in Makefile and having _H at the end of the name.  "sed -n" proved
# more portable than a trailing "-e d" to filter out the uninteresting lines,
# in particular on ia64-hpux where "s/.../p" only prints if -n was requested
# as well.
	$(foreach header_var,$(shell sed < Makefile -n -e 's/^\([A-Z0-9_]*_H\)[ 	]*=.*/\1/p'),echo $(header_var)=$(shell echo $($(header_var):$(srcdir)/%=.../%) | sed -e 's~\.\.\./config/~config/~' -e 's~\.\.\./common/config/~common/config/~' -e 's~\.\.\.[^ 	]*/~~g') >> tmp-header-vars;)
	$(SHELL) $(srcdir)/../move-if-change tmp-header-vars b-header-vars
	$(STAMP) s-header-vars

# Install gengtype
install-gengtype: installdirs gengtype$(exeext) gtype.state
	$(mkinstalldirs) $(DESTDIR)$(plugin_resourcesdir)
	$(INSTALL_DATA) gtype.state $(DESTDIR)$(plugin_resourcesdir)/gtype.state
	$(mkinstalldirs) $(DESTDIR)$(plugin_bindir)
	$(INSTALL_PROGRAM) gengtype$(exeext) $(DESTDIR)$(plugin_bindir)/gengtype$(exeext)

# Install the headers needed to build a plugin.
install-plugin: installdirs lang.install-plugin s-header-vars install-gengtype
# We keep the directory structure for files in config, common/config or
# c-family and .def files. All other files are flattened to a single directory.
	$(mkinstalldirs) $(DESTDIR)$(plugin_includedir)
	headers=`echo $(sort $(PLUGIN_HEADERS)) $$(cd $(srcdir); echo *.h *.def) | tr ' ' '\012' | sort -u`; \
	srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*|]/\\\\&/g'`; \
	for file in $$headers; do \
	  if [ -f $$file ] ; then \
	    path=$$file; \
	  elif [ -f $(srcdir)/$$file ]; then \
	    path=$(srcdir)/$$file; \
	  else continue; \
	  fi; \
	  case $$path in \
	  "$(srcdir)"/config/* | "$(srcdir)"/common/config/* \
	  | "$(srcdir)"/c-family/* | "$(srcdir)"/*.def ) \
	    base=`echo "$$path" | sed -e "s|$$srcdirstrip/||"`;; \
	  *) base=`basename $$path` ;; \
	  esac; \
	  dest=$(plugin_includedir)/$$base; \
	  echo $(INSTALL_DATA) $$path $(DESTDIR)$$dest; \
	  dir=`dirname $$dest`; \
	  $(mkinstalldirs) $(DESTDIR)$$dir; \
	  $(INSTALL_DATA) $$path $(DESTDIR)$$dest; \
	done
	$(INSTALL_DATA) b-header-vars $(DESTDIR)$(plugin_includedir)/b-header-vars

# Install the compiler executables built during cross compilation.
install-common: native lang.install-common installdirs
	for file in $(COMPILERS); do \
	  if [ -f $$file ] ; then \
	    rm -f $(DESTDIR)$(libexecsubdir)/$$file; \
	    $(INSTALL_PROGRAM) $$file $(DESTDIR)$(libexecsubdir)/$$file; \
	  else true; \
	  fi; \
	done
	for file in $(EXTRA_PROGRAMS) $(COLLECT2) ..; do \
	  if [ x"$$file" != x.. ]; then \
	    rm -f $(DESTDIR)$(libexecsubdir)/$$file; \
	    $(INSTALL_PROGRAM) $$file $(DESTDIR)$(libexecsubdir)/$$file; \
	  else true; fi; \
	done
# We no longer install the specs file because its presence makes the
# driver slower, and because people who need it can recreate it by
# using -dumpspecs.  We remove any old version because it would
# otherwise override the specs built into the driver.
	rm -f $(DESTDIR)$(libsubdir)/specs
# Install gcov if it was compiled.
	-if test "$(enable_as_accelerator)" != "yes" ; then \
	  if [ -f gcov$(exeext) ]; \
	  then \
	    rm -f $(DESTDIR)$(bindir)/$(GCOV_INSTALL_NAME)$(exeext); \
	    $(INSTALL_PROGRAM) gcov$(exeext) $(DESTDIR)$(bindir)/$(GCOV_INSTALL_NAME)$(exeext); \
	  fi; \
	fi
# Install gcov-tool if it was compiled.
	-if test "$(enable_as_accelerator)" != "yes" ; then \
	  if [ -f gcov-tool$(exeext) ]; \
	  then \
	    rm -f $(DESTDIR)$(bindir)/$(GCOV_TOOL_INSTALL_NAME)$(exeext); \
	    $(INSTALL_PROGRAM) \
	    gcov-tool$(exeext) $(DESTDIR)$(bindir)/$(GCOV_TOOL_INSTALL_NAME)$(exeext); \
	  fi; \
	fi
# Install gcov-dump if it was compiled.
	-if test "$(enable_as_accelerator)" != "yes" ; then \
	  if [ -f gcov-dump$(exeext) ]; \
	  then \
	    rm -f $(DESTDIR)$(bindir)/$(GCOV_DUMP_INSTALL_NAME)$(exeext); \
	    $(INSTALL_PROGRAM) \
	    gcov-dump$(exeext) $(DESTDIR)$(bindir)/$(GCOV_DUMP_INSTALL_NAME)$(exeext); \
	  fi; \
	fi

# Install the driver program as $(target_noncanonical)-gcc,
# $(target_noncanonical)-gcc-$(version), and also as gcc if native.
install-driver: installdirs xgcc$(exeext)
	-rm -f $(DESTDIR)$(bindir)/$(GCC_INSTALL_NAME)$(exeext)
	-$(INSTALL_PROGRAM) xgcc$(exeext) $(DESTDIR)$(bindir)/$(GCC_INSTALL_NAME)$(exeext)
	-if test "$(enable_as_accelerator)" != "yes" ; then \
	  if [ "$(GCC_INSTALL_NAME)" != "$(target_noncanonical)-gcc-$(version)" ]; then \
	    rm -f $(DESTDIR)$(bindir)/$(FULL_DRIVER_NAME); \
	    ( cd $(DESTDIR)$(bindir) && \
	      $(LN) $(GCC_INSTALL_NAME)$(exeext) $(FULL_DRIVER_NAME) ); \
	  fi; \
	  if [ ! -f gcc-cross$(exeext) ] \
	      && [ "$(GCC_INSTALL_NAME)" != "$(GCC_TARGET_INSTALL_NAME)" ]; then \
	    rm -f $(DESTDIR)$(bindir)/$(target_noncanonical)-gcc-tmp$(exeext); \
	    ( cd $(DESTDIR)$(bindir) && \
	      $(LN) $(GCC_INSTALL_NAME)$(exeext) $(target_noncanonical)-gcc-tmp$(exeext) && \
	      mv -f $(target_noncanonical)-gcc-tmp$(exeext) $(GCC_TARGET_INSTALL_NAME)$(exeext) ); \
	  fi; \
	fi

# Install the info files.
# $(INSTALL_DATA) might be a relative pathname, so we can't cd into srcdir
# to do the install.
install-info:: doc installdirs \
	$(DESTDIR)$(infodir)/cpp.info \
	$(DESTDIR)$(infodir)/gcc.info \
	$(DESTDIR)$(infodir)/cppinternals.info \
	$(DESTDIR)$(infodir)/gccinstall.info \
	$(DESTDIR)$(infodir)/gccint.info \
	lang.install-info

$(DESTDIR)$(infodir)/%.info: doc/%.info installdirs
	rm -f $@
	if [ -f $< ]; then \
	  for f in $(<)*; do \
	    realfile=`echo $$f | sed -e 's|.*/\([^/]*\)$$|\1|'`; \
	    $(INSTALL_DATA) $$f $(DESTDIR)$(infodir)/$$realfile; \
	    chmod a-x $(DESTDIR)$(infodir)/$$realfile; \
	  done; \
	else true; fi
	-if $(SHELL) -c 'install-info --version' >/dev/null 2>&1; then \
	  if [ -f $@ ]; then \
	    install-info --dir-file=$(DESTDIR)$(infodir)/dir $@; \
	  else true; fi; \
	else true; fi;

dvi__strip_dir = `echo $$p | sed -e 's|^.*/||'`;

install-dvi: $(DVIFILES) lang.install-dvi
	@$(NORMAL_INSTALL)
	test -z "$(dvidir)/gcc" || $(mkinstalldirs) "$(DESTDIR)$(dvidir)/gcc"
	@list='$(DVIFILES)'; for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=$(dvi__strip_dir) \
	  echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(dvidir)/gcc/$$f'"; \
	  $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(dvidir)/gcc/$$f"; \
	done

pdf__strip_dir = `echo $$p | sed -e 's|^.*/||'`;

install-pdf: $(PDFFILES) lang.install-pdf
	@$(NORMAL_INSTALL)
	test -z "$(pdfdir)/gcc" || $(mkinstalldirs) "$(DESTDIR)$(pdfdir)/gcc"
	@list='$(PDFFILES)'; for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=$(pdf__strip_dir) \
	  echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(pdfdir)/gcc/$$f'"; \
	  $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(pdfdir)/gcc/$$f"; \
	done

html__strip_dir = `echo $$p | sed -e 's|^.*/||'`;

install-html: $(HTMLS_BUILD) lang.install-html
	@$(NORMAL_INSTALL)
	test -z "$(htmldir)" || $(mkinstalldirs) "$(DESTDIR)$(htmldir)"
	@list='$(HTMLS_INSTALL)'; for p in $$list; do \
	  if test -f "$$p" || test -d "$$p"; then d=""; else d="$(srcdir)/"; fi; \
	  f=$(html__strip_dir) \
	  if test -d "$$d$$p"; then \
	    echo " $(mkinstalldirs) '$(DESTDIR)$(htmldir)/$$f'"; \
	    $(mkinstalldirs) "$(DESTDIR)$(htmldir)/$$f" || exit 1; \
	    echo " $(INSTALL_DATA) '$$d$$p'/* '$(DESTDIR)$(htmldir)/$$f'"; \
	    $(INSTALL_DATA) "$$d$$p"/* "$(DESTDIR)$(htmldir)/$$f"; \
	  else \
	    echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(htmldir)/$$f'"; \
	    $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(htmldir)/$$f"; \
	  fi; \
	done

# Install the man pages.
install-man: lang.install-man \
	$(DESTDIR)$(man1dir)/$(GCC_INSTALL_NAME)$(man1ext) \
	$(DESTDIR)$(man1dir)/$(CPP_INSTALL_NAME)$(man1ext) \
	$(DESTDIR)$(man1dir)/$(GCOV_INSTALL_NAME)$(man1ext) \
	$(DESTDIR)$(man1dir)/$(GCOV_TOOL_INSTALL_NAME)$(man1ext) \
	$(DESTDIR)$(man1dir)/$(GCOV_DUMP_INSTALL_NAME)$(man1ext) \
	$(if $(filter yes,yes),$(DESTDIR)$(man1dir)/$(LTO_DUMP_INSTALL_NAME)$(man1ext)) \
	$(DESTDIR)$(man7dir)/fsf-funding$(man7ext) \
	$(DESTDIR)$(man7dir)/gfdl$(man7ext) \
	$(DESTDIR)$(man7dir)/gpl$(man7ext)

$(DESTDIR)$(man7dir)/%$(man7ext): doc/%.7 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(GCC_INSTALL_NAME)$(man1ext): doc/gcc.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(CPP_INSTALL_NAME)$(man1ext): doc/cpp.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(GCOV_INSTALL_NAME)$(man1ext): doc/gcov.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(GCOV_TOOL_INSTALL_NAME)$(man1ext): doc/gcov-tool.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(GCOV_DUMP_INSTALL_NAME)$(man1ext): doc/gcov-dump.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

$(DESTDIR)$(man1dir)/$(LTO_DUMP_INSTALL_NAME)$(man1ext): doc/lto-dump.1 installdirs
	-rm -f $@
	-$(INSTALL_DATA) $< $@
	-chmod a-x $@

# Install all the header files built in the include subdirectory.
install-headers: $(INSTALL_HEADERS_DIR)
# Fix symlinks to absolute paths in the installed include directory to
# point to the installed directory, not the build directory.
# Don't need to use LN_S here since we really do need ln -s and no substitutes.
	-files=`cd $(DESTDIR)$(libsubdir)/include-fixed; find . -type l -print 2>/dev/null`; \
	if [ $$? -eq 0 ]; then \
	  dir=`cd include-fixed; ${PWD_COMMAND}`; \
	  for i in $$files; do \
	    dest=`ls -ld $(DESTDIR)$(libsubdir)/include-fixed/$$i | sed -n 's/.*-> //p'`; \
	    if expr "$$dest" : "$$dir.*" > /dev/null; then \
	      rm -f $(DESTDIR)$(libsubdir)/include-fixed/$$i; \
	      ln -s `echo $$i | sed "s|/[^/]*|/..|g" | sed 's|/..$$||'``echo "$$dest" | sed "s|$$dir||"` $(DESTDIR)$(libsubdir)/include-fixed/$$i; \
	    fi; \
	  done; \
	fi

# Create or recreate the gcc private include file directory.
install-include-dir: installdirs
	$(mkinstalldirs) $(DESTDIR)$(libsubdir)/include
	-rm -rf $(DESTDIR)$(libsubdir)/include-fixed
	mkdir $(DESTDIR)$(libsubdir)/include-fixed
	-chmod a+rx $(DESTDIR)$(libsubdir)/include-fixed

# Create or recreate the install-tools include file directory.
itoolsdir = $(libexecsubdir)/install-tools
itoolsdatadir = $(libsubdir)/install-tools
install-itoolsdirs: installdirs
	$(mkinstalldirs) $(DESTDIR)$(itoolsdatadir)/include
	$(mkinstalldirs) $(DESTDIR)$(itoolsdir)

# Install the include directory using tar.
install-headers-tar: stmp-int-hdrs install-include-dir
# We use `pwd`/include instead of just include to problems with CDPATH
# Unless a full pathname is provided, some shells would print the new CWD,
# found in CDPATH, corrupting the output.  We could just redirect the
# output of `cd', but some shells lose on redirection within `()'s
	(cd `${PWD_COMMAND}`/include ; \
	 tar -cf - .; exit 0) | (cd $(DESTDIR)$(libsubdir)/include; tar xpf - )
	(cd `${PWD_COMMAND}`/include-fixed ; \
	 tar -cf - .; exit 0) | (cd $(DESTDIR)$(libsubdir)/include-fixed; tar xpf - )
# /bin/sh on some systems returns the status of the first tar,
# and that can lose with GNU tar which always writes a full block.
# So use `exit 0' to ignore its exit status.

# Install the include directory using cpio.
install-headers-cpio: stmp-int-hdrs install-include-dir
# See discussion about the use of `pwd` above
	cd `${PWD_COMMAND}`/include ; \
	find . -print | cpio -pdum $(DESTDIR)$(libsubdir)/include
	cd `${PWD_COMMAND}`/include-fixed ; \
	find . -print | cpio -pdum $(DESTDIR)$(libsubdir)/include-fixed

# Install the include directory using cp.
install-headers-cp: stmp-int-hdrs install-include-dir
	cp -p -r include $(DESTDIR)$(libsubdir)
	cp -p -r include-fixed $(DESTDIR)$(libsubdir)

# Targets without dependencies, for use in prev-gcc during bootstrap.
real-install-headers-tar:
	(cd `${PWD_COMMAND}`/include-fixed ; \
	 tar -cf - .; exit 0) | (cd $(DESTDIR)$(libsubdir)/include-fixed; tar xpf - )

real-install-headers-cpio:
	cd `${PWD_COMMAND}`/include-fixed ; \
	find . -print | cpio -pdum $(DESTDIR)$(libsubdir)/include-fixed

real-install-headers-cp:
	cp -p -r include-fixed $(DESTDIR)$(libsubdir)

# Install supporting files for fixincludes to be run later.
install-mkheaders: stmp-int-hdrs install-itoolsdirs \
  macro_list fixinc_list
	$(INSTALL_DATA) $(srcdir)/gsyslimits.h \
	  $(DESTDIR)$(itoolsdatadir)/gsyslimits.h
	$(INSTALL_DATA) macro_list $(DESTDIR)$(itoolsdatadir)/macro_list
	$(INSTALL_DATA) fixinc_list $(DESTDIR)$(itoolsdatadir)/fixinc_list
	set -e; for ml in `cat fixinc_list`; do \
	  multi_dir=`echo $${ml} | sed -e 's/^[^;]*;//'`; \
	  $(mkinstalldirs) $(DESTDIR)$(itoolsdatadir)/include$${multi_dir}; \
	  $(INSTALL_DATA) include$${multi_dir}/limits.h $(DESTDIR)$(itoolsdatadir)/include$${multi_dir}/limits.h; \
	done
	$(INSTALL_SCRIPT) $(srcdir)/../mkinstalldirs \
		$(DESTDIR)$(itoolsdir)/mkinstalldirs ; \
	sysroot_headers_suffix='$${sysroot_headers_suffix}'; \
		echo 'SYSTEM_HEADER_DIR="'"$(SYSTEM_HEADER_DIR)"'"' \
		> $(DESTDIR)$(itoolsdatadir)/mkheaders.conf
	echo 'OTHER_FIXINCLUDES_DIRS="$(OTHER_FIXINCLUDES_DIRS)"' \
		>> $(DESTDIR)$(itoolsdatadir)/mkheaders.conf
	echo 'STMP_FIXINC="$(STMP_FIXINC)"' \
		>> $(DESTDIR)$(itoolsdatadir)/mkheaders.conf

# Use this target to install the program `collect2' under the name `collect2'.
install-collect2: collect2 installdirs
	$(INSTALL_PROGRAM) collect2$(exeext) $(DESTDIR)$(libexecsubdir)/collect2$(exeext)
# Install the driver program as $(libsubdir)/gcc for collect2.
	$(INSTALL_PROGRAM) xgcc$(exeext) $(DESTDIR)$(libexecsubdir)/gcc$(exeext)

# Install lto-wrapper.
install-lto-wrapper: lto-wrapper$(exeext)
	$(INSTALL_PROGRAM) lto-wrapper$(exeext) $(DESTDIR)$(libexecsubdir)/lto-wrapper$(exeext)

install-gcc-ar: installdirs gcc-ar$(exeext) gcc-nm$(exeext) gcc-ranlib$(exeext)
	if test "$(enable_as_accelerator)" != "yes" ; then \
	  for i in gcc-ar gcc-nm gcc-ranlib; do \
	    install_name=`echo $$i|sed '$(program_transform_name)'` ;\
	    target_install_name=$(target_noncanonical)-`echo $$i|sed '$(program_transform_name)'` ; \
	    rm -f $(DESTDIR)$(bindir)/$$install_name$(exeext) ; \
	    $(INSTALL_PROGRAM) $$i$(exeext) $(DESTDIR)$(bindir)/$$install_name$(exeext) ;\
	    if test -f gcc-cross$(exeext); then \
	      :; \
	    else \
	      rm -f $(DESTDIR)$(bindir)/$$target_install_name$(exeext); \
	      ( cd $(DESTDIR)$(bindir) && \
		$(LN) $$install_name$(exeext) $$target_install_name$(exeext) ) ; \
	    fi ; \
	  done; \
	fi

# Cancel installation by deleting the installed files.
uninstall: lang.uninstall
	-rm -rf $(DESTDIR)$(libsubdir)
	-rm -rf $(DESTDIR)$(libexecsubdir)
	-rm -rf $(DESTDIR)$(bindir)/$(GCC_INSTALL_NAME)$(exeext)
	-rm -f $(DESTDIR)$(bindir)/$(CPP_INSTALL_NAME)$(exeext)
	-if [ x$(cpp_install_dir) != x ]; then \
	  rm -f $(DESTDIR)$(prefix)/$(cpp_install_dir)/$(CPP_INSTALL_NAME)$(exeext); \
	else true; fi
	-rm -rf $(DESTDIR)$(bindir)/$(GCOV_INSTALL_NAME)$(exeext)
	-rm -rf $(DESTDIR)$(man1dir)/$(GCC_INSTALL_NAME)$(man1ext)
	-rm -rf $(DESTDIR)$(man1dir)/cpp$(man1ext)
	-rm -f $(DESTDIR)$(infodir)/cpp.info* $(DESTDIR)$(infodir)/gcc.info*
	-rm -f $(DESTDIR)$(infodir)/cppinternals.info* $(DESTDIR)$(infodir)/gccint.info*
	for i in ar nm ranlib ; do \
	  install_name=`echo gcc-$$i|sed '$(program_transform_name)'`$(exeext) ;\
	  target_install_name=$(target_noncanonical)-`echo gcc-$$i|sed '$(program_transform_name)'`$(exeext) ; \
	  rm -f $(DESTDIR)$(bindir)/$$install_name ; \
	  rm -f $(DESTDIR)$(bindir)/$$target_install_name ; \
	done
#
# These targets are for the dejagnu testsuites. The file site.exp
# contains global variables that all the testsuites will use.

target_subdir = arc64-elf

site.exp: ./config.status Makefile
	@echo "Making a new config file..."
	-@rm -f ./site.tmp
	@$(STAMP) site.exp
	-@mv site.exp site.bak
	@echo "## these variables are automatically generated by make ##" > ./site.tmp
	@echo "# Do not edit here. If you wish to override these values" >> ./site.tmp
	@echo "# add them to the last section" >> ./site.tmp
	@echo "set rootme \"`${PWD_COMMAND}`\"" >> ./site.tmp
	@echo "set srcdir \"`cd ${srcdir}; ${PWD_COMMAND}`\"" >> ./site.tmp
	@echo "set host_triplet $(host)" >> ./site.tmp
	@echo "set build_triplet $(build)" >> ./site.tmp
	@echo "set target_triplet $(target)" >> ./site.tmp
	@echo "set target_alias $(target_noncanonical)" >> ./site.tmp
	@echo "set libiconv \"$(LIBICONV)\"" >> ./site.tmp
# CFLAGS is set even though it's empty to show we reserve the right to set it.
	@echo "set CFLAGS \"\"" >> ./site.tmp
	@echo "set CXXFLAGS \"\"" >> ./site.tmp
	@echo "set HOSTCC \"$(CC)\"" >> ./site.tmp
	@echo "set HOSTCXX \"$(CXX)\"" >> ./site.tmp
	@echo "set HOSTCFLAGS \"$(CFLAGS)\"" >> ./site.tmp
	@echo "set HOSTCXXFLAGS \"$(CXXFLAGS)\"" >> ./site.tmp
# TEST_ALWAYS_FLAGS are flags that should be passed to every compilation.
# They are passed first to allow individual tests to override them.
	@echo "set TEST_ALWAYS_FLAGS \"$(SYSROOT_CFLAGS_FOR_TARGET)\"" >> ./site.tmp
# When running the tests we set GCC_EXEC_PREFIX to the install tree so that
# files that have already been installed there will be found.  The -B option
# overrides it, so use of GCC_EXEC_PREFIX will not result in using GCC files
# from the install tree.
	@echo "set TEST_GCC_EXEC_PREFIX \"$(libdir)/gcc/\"" >> ./site.tmp
	@echo "set TESTING_IN_BUILD_TREE 1" >> ./site.tmp
	@echo "set HAVE_LIBSTDCXX_V3 1" >> ./site.tmp
	@if test "yes" = "yes" ; then \
	  echo "set ENABLE_PLUGIN 1" >> ./site.tmp; \
	  echo "set PLUGINCC \"$(PLUGINCC)\"" >> ./site.tmp; \
	  echo "set PLUGINCFLAGS \"$(PLUGINCFLAGS)\"" >> ./site.tmp; \
	  echo "set GMPINC \"$(GMPINC)\"" >> ./site.tmp; \
	fi
# If newlib has been configured, we need to pass -B to gcc so it can find
# newlib's crt0.o if it exists.  This will cause a "path prefix not used"
# message if it doesn't, but the testsuite is supposed to ignore the message -
# it's too difficult to tell when to and when not to pass -B (not all targets
# have crt0's).  We could only add the -B if ../newlib/crt0.o exists, but that
# seems like too selective a test.
# ??? Another way to solve this might be to rely on linker scripts.  Then
# theoretically the -B won't be needed.
# We also need to pass -L ../ld so that the linker can find ldscripts.
	@if [ -d $(objdir)/../$(target_subdir)/newlib ] \
	    && [ "${host}" != "${target}" ]; then \
	  echo "set newlib_cflags \"-I$(objdir)/../$(target_subdir)/newlib/targ-include -I\$$srcdir/../newlib/libc/include\"" >> ./site.tmp; \
	  echo "set newlib_ldflags \"-B$(objdir)/../$(target_subdir)/newlib/\"" >> ./site.tmp; \
	  echo "append CFLAGS \" \$$newlib_cflags\"" >> ./site.tmp; \
	  echo "append CXXFLAGS \" \$$newlib_cflags\"" >> ./site.tmp; \
	  echo "append LDFLAGS \" \$$newlib_ldflags\"" >> ./site.tmp; \
	else true; \
	fi
	@if [ -d $(objdir)/../ld ] ; then \
	  echo "append LDFLAGS \" -L$(objdir)/../ld\"" >> ./site.tmp; \
	else true; \
	fi
	echo "set tmpdir $(objdir)/testsuite" >> ./site.tmp
	@echo "set srcdir \"\$${srcdir}/testsuite\"" >> ./site.tmp
	@if [ "X$(ALT_CC_UNDER_TEST)" != "X" ] ; then \
	  echo "set ALT_CC_UNDER_TEST \"$(ALT_CC_UNDER_TEST)\"" >> ./site.tmp; \
	else true; \
	fi
	@if [ "X$(ALT_CXX_UNDER_TEST)" != "X" ] ; then \
	  echo "set ALT_CXX_UNDER_TEST \"$(ALT_CXX_UNDER_TEST)\"" >> ./site.tmp; \
	else true; \
	fi
	@if [ "X$(COMPAT_OPTIONS)" != "X" ] ; then \
	  echo "set COMPAT_OPTIONS \"$(COMPAT_OPTIONS)\"" >> ./site.tmp; \
	else true; \
	fi
	@echo "## All variables above are generated by configure. Do Not Edit ##" >> ./site.tmp
	@cat ./site.tmp > site.exp
	@cat site.bak | sed \
		-e '1,/^## All variables above are.*##/ d' >> site.exp
	-@rm -f ./site.tmp

CHECK_TARGETS =  check-c check-c++ check-lto

check: $(CHECK_TARGETS)

check-subtargets: $(patsubst %,%-subtargets,$(CHECK_TARGETS))

# The idea is to parallelize testing of multilibs, for example:
#   make -j3 check-gcc//sh-hms-sim/{-m1,-m2,-m3,-m3e,-m4}/{,-nofpu}
# will run 3 concurrent sessions of check-gcc, eventually testing
# all 10 combinations.  GNU make is required, as is a shell that expands
# alternations within braces.
lang_checks_parallel = $(lang_checks:=//%)
$(lang_checks_parallel): site.exp
	target=`echo "$@" | sed 's,//.*,,'`; \
	variant=`echo "$@" | sed 's,^[^/]*//,,'`; \
	vardots=`echo "$$variant" | sed 's,/,.,g'`; \
	$(MAKE) TESTSUITEDIR="testsuite.$$vardots" \
	  RUNTESTFLAGS="--target_board=$$variant $(RUNTESTFLAGS)" \
	  "$$target"

TESTSUITEDIR = testsuite

$(TESTSUITEDIR)/site.exp: site.exp
	-test -d $(TESTSUITEDIR) || mkdir $(TESTSUITEDIR)
	-rm -f $@
	sed '/set tmpdir/ s|testsuite$$|$(TESTSUITEDIR)|' < site.exp > $@

# This is only used for check-% targets that aren't parallelized.
$(filter-out $(lang_checks_parallelized),$(lang_checks)): check-% : site.exp
	-test -d plugin || mkdir plugin
	-test -d $(TESTSUITEDIR) || mkdir $(TESTSUITEDIR)
	test -d $(TESTSUITEDIR)/$* || mkdir $(TESTSUITEDIR)/$*
	-(rootme=`${PWD_COMMAND}`; export rootme; \
	srcdir=`cd ${srcdir}; ${PWD_COMMAND}` ; export srcdir ; \
	cd $(TESTSUITEDIR)/$*; \
	rm -f tmp-site.exp; \
	sed '/set tmpdir/ s|testsuite$$|$(TESTSUITEDIR)/$*|' \
		< ../../site.exp > tmp-site.exp; \
	$(SHELL) $${srcdir}/../move-if-change tmp-site.exp site.exp; \
	EXPECT=${EXPECT} ; export EXPECT ; \
	if [ -f $${rootme}/../expect/expect ] ; then  \
	   TCL_LIBRARY=`cd .. ; cd $${srcdir}/../tcl/library ; ${PWD_COMMAND}` ; \
	    export TCL_LIBRARY ; fi ; \
	$(RUNTEST) --tool $* $(RUNTESTFLAGS))

$(patsubst %,%-subtargets,$(lang_checks)): check-%-subtargets:
	@echo check-$*

check_p_tool=$(firstword $(subst _, ,$*))
check_p_count=$(check_$(check_p_tool)_parallelize)
check_p_subno=$(word 2,$(subst _, ,$*))
check_p_numbers0:=1 2 3 4 5 6 7 8 9
check_p_numbers1:=0 $(check_p_numbers0)
check_p_numbers2:=$(foreach i,$(check_p_numbers0),$(addprefix $(i),$(check_p_numbers1)))
check_p_numbers3:=$(addprefix 0,$(check_p_numbers1)) $(check_p_numbers2)
check_p_numbers4:=$(foreach i,$(check_p_numbers0),$(addprefix $(i),$(check_p_numbers3)))
check_p_numbers5:=$(addprefix 0,$(check_p_numbers3)) $(check_p_numbers4)
check_p_numbers6:=$(foreach i,$(check_p_numbers0),$(addprefix $(i),$(check_p_numbers5)))
check_p_numbers:=$(check_p_numbers0) $(check_p_numbers2) $(check_p_numbers4) $(check_p_numbers6)
check_p_subdir=$(subst _,,$*)
check_p_subdirs=$(wordlist 1,$(check_p_count),$(wordlist 1, \
		$(if $(GCC_TEST_PARALLEL_SLOTS),$(GCC_TEST_PARALLEL_SLOTS),128), \
		$(check_p_numbers)))

# For parallelized check-% targets, this decides whether parallelization
# is desirable (if -jN is used).  If desirable, recursive make is run with
# check-parallel-$lang{,1,2,3,4,5} etc. goals, which can be executed in
# parallel, as they are run in separate directories.
# check-parallel-$lang{,1,2,3,4,5} etc. goals invoke runtest with
# GCC_RUNTEST_PARALLELIZE_DIR var in the environment and runtest_file_p
# dejaGNU procedure is overridden to additionally synchronize through
# a $lang-parallel directory which tests will be run by which runtest instance.
# Afterwards contrib/dg-extract-results.sh is used to merge the sum and log
# files.  If parallelization isn't desirable, only one recursive make
# is run with check-parallel-$lang goal and check_$lang_parallelize variable
# cleared to say that no additional arguments beyond $(RUNTESTFLAGS)
# should be passed to runtest.
#
# To parallelize some language check, add the corresponding check-$lang
# to lang_checks_parallelized variable and define check_$lang_parallelize
# variable.  This is the upper limit to which it is useful to parallelize the
# check-$lang target.  It doesn't make sense to try e.g. 128 goals for small
# testsuites like objc or go.
$(lang_checks_parallelized): check-% : site.exp
	-rm -rf $(TESTSUITEDIR)/$*-parallel
	@if [ -n "$(filter -j%, $(MFLAGS))" ]; then \
	  test -d $(TESTSUITEDIR) || mkdir $(TESTSUITEDIR) || true; \
	  test -d $(TESTSUITEDIR)/$*-parallel || mkdir $(TESTSUITEDIR)/$*-parallel || true; \
	  GCC_RUNTEST_PARALLELIZE_DIR=`${PWD_COMMAND}`/$(TESTSUITEDIR)/$(check_p_tool)-parallel ; \
	  export GCC_RUNTEST_PARALLELIZE_DIR ; \
	  $(MAKE) TESTSUITEDIR="$(TESTSUITEDIR)" RUNTESTFLAGS="$(RUNTESTFLAGS)" \
	    check-parallel-$* \
	    $(patsubst %,check-parallel-$*_%, $(check_p_subdirs)); \
	  sums= ; logs= ; \
	  for dir in $(TESTSUITEDIR)/$* \
		     $(patsubst %,$(TESTSUITEDIR)/$*%,$(check_p_subdirs));\
	  do \
	    if [ -d $$dir ]; then \
	      mv -f $$dir/$*.sum $$dir/$*.sum.sep; mv -f $$dir/$*.log $$dir/$*.log.sep; \
	      sums="$$sums $$dir/$*.sum.sep"; logs="$$logs $$dir/$*.log.sep"; \
	    fi; \
	  done; \
	  $(SHELL) $(srcdir)/../contrib/dg-extract-results.sh $$sums \
	    > $(TESTSUITEDIR)/$*/$*.sum; \
	  $(SHELL) $(srcdir)/../contrib/dg-extract-results.sh -L $$logs \
	    > $(TESTSUITEDIR)/$*/$*.log; \
	  rm -rf $(TESTSUITEDIR)/$*-parallel || true; \
	else \
	  $(MAKE) TESTSUITEDIR="$(TESTSUITEDIR)" RUNTESTFLAGS="$(RUNTESTFLAGS)" \
	    check_$*_parallelize= check-parallel-$*; \
	fi

check-parallel-% : site.exp
	-@test -d plugin || mkdir plugin
	-@test -d $(TESTSUITEDIR) || mkdir $(TESTSUITEDIR)
	@test -d $(TESTSUITEDIR)/$(check_p_subdir) || mkdir $(TESTSUITEDIR)/$(check_p_subdir)
	-$(if $(check_p_subno),@)(rootme=`${PWD_COMMAND}`; export rootme; \
	srcdir=`cd ${srcdir}; ${PWD_COMMAND}` ; export srcdir ; \
	if [ -n "$(check_p_subno)" ] \
	   && [ -n "$$GCC_RUNTEST_PARALLELIZE_DIR" ] \
	   && [ -f $(TESTSUITEDIR)/$(check_p_tool)-parallel/finished ]; then \
	  rm -rf $(TESTSUITEDIR)/$(check_p_subdir); \
	else \
	  cd $(TESTSUITEDIR)/$(check_p_subdir); \
	  rm -f tmp-site.exp; \
	  sed '/set tmpdir/ s|testsuite$$|$(TESTSUITEDIR)/$(check_p_subdir)|' \
		< ../../site.exp > tmp-site.exp; \
	  $(SHELL) $${srcdir}/../move-if-change tmp-site.exp site.exp; \
	  EXPECT=${EXPECT} ; export EXPECT ; \
	  if [ -f $${rootme}/../expect/expect ] ; then  \
	    TCL_LIBRARY=`cd .. ; cd $${srcdir}/../tcl/library ; ${PWD_COMMAND}` ; \
	    export TCL_LIBRARY ; \
	  fi ; \
	  $(RUNTEST) --tool $(check_p_tool) $(RUNTESTFLAGS); \
	  if [ -n "$$GCC_RUNTEST_PARALLELIZE_DIR" ] ; then \
	    touch $${rootme}/$(TESTSUITEDIR)/$(check_p_tool)-parallel/finished; \
	  fi ; \
	fi )

# QMTest targets

# The path to qmtest.
QMTEST_PATH=qmtest

# The flags to pass to qmtest.
QMTESTFLAGS=

# The flags to pass to "qmtest run".
QMTESTRUNFLAGS=-f none --result-stream dejagnu_stream.DejaGNUStream

# The command to use to invoke qmtest.
QMTEST=${QMTEST_PATH} ${QMTESTFLAGS}

# The tests (or suites) to run.
QMTEST_GPP_TESTS=g++

# The subdirectory of the OBJDIR that will be used to store the QMTest
# test database configuration and that will be used for temporary
# scratch space during QMTest's execution.
QMTEST_DIR=qmtestsuite

# Create the QMTest database configuration.
${QMTEST_DIR} stamp-qmtest:
	${QMTEST} -D ${QMTEST_DIR} create-tdb \
	    -c gcc_database.GCCDatabase \
	    -a srcdir=`cd ${srcdir}/testsuite && ${PWD_COMMAND}` && \
	    $(STAMP) stamp-qmtest

# Create the QMTest context file.
${QMTEST_DIR}/context: stamp-qmtest
	rm -f $@
	echo "CompilerTable.languages=c cplusplus" >> $@
	echo "CompilerTable.c_kind=GCC" >> $@
	echo "CompilerTable.c_path=${objdir}/xgcc" >> $@
	echo "CompilerTable.c_options=-B${objdir}/" >> $@
	echo "CompilerTable.cplusplus_kind=GCC" >> $@
	echo "CompilerTable.cplusplus_path=${objdir}/xg++" >> $@
	echo "CompilerTable.cplusplus_options=-B${objdir}/" >> $@
	echo "DejaGNUTest.target=${target_noncanonical}" >> $@

# Run the G++ testsuite using QMTest.
qmtest-g++: ${QMTEST_DIR}/context
	cd ${QMTEST_DIR} && ${QMTEST} run ${QMTESTRUNFLAGS} -C context \
	   -o g++.qmr ${QMTEST_GPP_TESTS}

# Use the QMTest GUI.
qmtest-gui: ${QMTEST_DIR}/context
	cd ${QMTEST_DIR} && ${QMTEST} gui -C context

.PHONY: qmtest-g++

# Run Paranoia on real.cc.

paranoia.o: $(srcdir)/../contrib/paranoia.cc $(CONFIG_H) $(SYSTEM_H) $(TREE_H)
	g++ -c $(ALL_CFLAGS) $(ALL_CPPFLAGS) $< $(OUTPUT_OPTION)

paranoia: paranoia.o real.o $(LIBIBERTY)
	g++ -o $@ paranoia.o real.o $(LIBIBERTY)

# These exist for maintenance purposes.

CTAGS=ctags
ETAGS=etags
CSCOPE=cscope

# Update the tags table.
TAGS: lang.tags
	(cd $(srcdir);					\
	incs= ;						\
	list='$(SUBDIRS)'; for dir in $$list; do	\
	  if test -f $$dir/TAGS; then			\
	    incs="$$incs --include $$dir/TAGS.sub";	\
	  fi;						\
	done;						\
	$(ETAGS) -o TAGS.sub c-family/*.h c-family/*.cc \
	      *.h *.cc \
	      ../include/*.h ../libiberty/*.c \
	      ../libcpp/*.cc ../libcpp/include/*.h \
	      --language=none --regex="/\(char\|unsigned int\|int\|bool\|void\|HOST_WIDE_INT\|enum [A-Za-z_0-9]+\) [*]?\([A-Za-z_0-9]+\)/\2/" common.opt	\
	      --language=none --regex="/\(DEF_RTL_EXPR\|DEFTREECODE\|DEFGSCODE\|DEFTIMEVAR\|DEFPARAM\|DEFPARAMENUM5\)[ ]?(\([A-Za-z_0-9]+\)/\2/" rtl.def tree.def gimple.def timevar.def \
		; \
	$(ETAGS) --include TAGS.sub $$incs)

# -----------------------------------------------------
# Rules for generating translated message descriptions.
# Disabled by autoconf if the tools are not available.
# -----------------------------------------------------

XGETTEXT = /home/luiss/.install/gettext/0_20_1/bin/xgettext
GMSGFMT = /home/luiss/.install/gettext/0_20_1/bin/msgfmt
MSGMERGE = msgmerge
CATALOGS = $(patsubst %,po/%,)

.PHONY: build- install- build-po install-po update-po

# Dummy rules to deal with dependencies produced by use of
# "build-" and "install-" above, when NLS is disabled.
build-: ; @true
install-: ; @true

build-po: $(CATALOGS)

# This notation should be acceptable to all Make implementations used
# by people who are interested in updating .po files.
update-po: $(CATALOGS:.gmo=.pox)

# N.B. We do not attempt to copy these into $(srcdir).  The snapshot
# script does that.
.po.gmo:
	$(mkinstalldirs) po
	$(GMSGFMT) --statistics -o $@ $<

# The new .po has to be gone over by hand, so we deposit it into
# build/po with a different extension.
# If build/po/gcc.pot exists, use it (it was just created),
# else use the one in srcdir.
.po.pox:
	$(mkinstalldirs) po
	$(MSGMERGE) $< `if test -f po/gcc.pot; \
			then echo po/gcc.pot; \
			else echo $(srcdir)/po/gcc.pot; fi` -o $@

# This rule has to look for .gmo modules in both srcdir and
# the cwd, and has to check that we actually have a catalog
# for each language, in case they weren't built or included
# with the distribution.
install-po:
	$(mkinstalldirs) $(DESTDIR)$(datadir)
	cats="$(CATALOGS)"; for cat in $$cats; do \
	  lang=`basename $$cat | sed 's/\.gmo$$//'`; \
	  if [ -f $$cat ]; then :; \
	  elif [ -f $(srcdir)/$$cat ]; then cat=$(srcdir)/$$cat; \
	  else continue; \
	  fi; \
	  dir=$(localedir)/$$lang/LC_MESSAGES; \
	  echo $(mkinstalldirs) $(DESTDIR)$$dir; \
	  $(mkinstalldirs) $(DESTDIR)$$dir || exit 1; \
	  echo $(INSTALL_DATA) $$cat $(DESTDIR)$$dir/gcc.mo; \
	  $(INSTALL_DATA) $$cat $(DESTDIR)$$dir/gcc.mo; \
	done

# Rule for regenerating the message template (gcc.pot).
# Instead of forcing everyone to edit POTFILES.in, which proved impractical,
# this rule has no dependencies and always regenerates gcc.pot.  This is
# relatively harmless since the .po files do not directly depend on it.
# Note that exgettext has an awk script embedded in it which requires a
# fairly modern (POSIX-compliant) awk.
# The .pot file is left in the build directory.
gcc.pot: po/gcc.pot
po/gcc.pot: force
	$(mkinstalldirs) po
	$(MAKE) srcextra
	AWK=$(AWK) $(SHELL) $(srcdir)/po/exgettext \
		$(XGETTEXT) gcc $(srcdir)

#

# Dependency information.

# In order for parallel make to really start compiling the expensive
# objects from $(OBJS) as early as possible, build all their
# prerequisites strictly before all objects.
$(ALL_HOST_OBJS) : | $(generated_files)

# Include the auto-generated dependencies for all host objects.
DEPFILES = \
  $(foreach obj,$(ALL_HOST_OBJS),\
    $(dir $(obj))$(DEPDIR)/$(patsubst %.o,%.Po,$(notdir $(obj))))
-include $(DEPFILES)
