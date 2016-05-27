AC_INIT(GTKKit, 0.1)
BUILDSYS_INIT

AC_CONFIG_SRCDIR(src)
AC_CONFIG_MACRO_DIR(m4)
AC_CONFIG_AUX_DIR(build-aux)

AC_CHECK_TOOL(OBJFW_CONFIG, objfw-config)
AS_IF([test x"$OBJFW_CONFIG" = x""], [
	AC_MSG_ERROR(You need ObjFW and objfw-config installed!)
])

test x"$OBJC" = x"" && OBJC="$($OBJFW_CONFIG --objc)"

AC_LANG([Objective C])
AC_PROG_OBJC
AC_PROG_OBJCPP
AC_PROG_LN_S
AC_PROG_INSTALL

CPP="$OBJC"
CPPFLAGS="$CPPFLAGS $OBJCPPFLAGS $($OBJFW_CONFIG --cppflags)"
OBJCFLAGS="$OBJCFLAGS -Wall $($OBJFW_CONFIG --objcflags --arc)"
LDFLAGS="$LDFLAGS $($OBJFW_CONFIG --ldflags)"
LIBS="$LIBS $($OBJFW_CONFIG --libs)"

AC_ARG_ENABLE(shared,
	AS_HELP_STRING([--disable-shared], [do not build shared library]))
AS_IF([test x"$enable_shared" != x"no"], [
	BUILDSYS_SHARED_LIB
	AC_SUBST(GTKKIT_SHARED_LIB, "${LIB_PREFIX}gtkkit${LIB_SUFFIX}")
])
AC_ARG_ENABLE(static, AS_HELP_STRING([--enable-static], [build static library]))
AS_IF([test x"$enable_static" = x"yes" -o x"$enable_shared" = x"no"], [
	AC_PATH_TOOL(AR, ar)
	AC_PROG_RANLIB
	AC_SUBST(GTKKIT_STATIC_LIB, "libgtkkit.a")
])

PKG_CHECK_MODULES(gtk3, [gtk+-3.0 >= 3.16], [
	CPPFLAGS="$CPPFLAGS $gtk3_CFLAGS"
	LIBS="$LIBS $gtk3_LIBS"
], [
	AC_MSG_ERROR(You need Gtk+ >= 3.16 installed!)
])

dnl We don't call AC_PROG_CPP, but only AC_PROG_OBJCPP and set CPP to OBJCPP
dnl and add OBJCFPPFLAGS to CPPFLAGS, thus we need to AC_SUBST these ourself.
AC_SUBST(CPP)
AC_SUBST(CPPFLAGS)

AC_CONFIG_FILES([buildsys.mk extra.mk GTKKit.pc])
AC_OUTPUT
