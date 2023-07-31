AC_INIT([arc-toolchain],[1.0])


AC_ARG_WITH(gcc,
		[AS_HELP_STRING([--with-gcc=SIM],
		[Sets the base ARC Simulator @<:@--with-cpu=qemu@:>@])],
		[],
		[with_gcc=default]
		)

AS_IF([test "x$with_gcc" != xdefault],
	    [AC_SUBST(with_gcc, $with_gcc)])


AC_CONFIG_FILES([Makefile])

AC_OUTPUT