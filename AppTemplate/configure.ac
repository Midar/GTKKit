dnl  To generate the configure script, call:
dnl    aclocal -I m4
dnl    autoconf
dnl

dnl Specify name, version and contact e-mail of the package.
AC_INIT(GTKKit Example App, 0.1)
BUILDSYS_INIT

dnl Specifies where your sources are.
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

PKG_CHECK_MODULES(gtk3, [gtk+-3.0 >= 3.16], [
	CPPFLAGS="$CPPFLAGS $gtk3_CFLAGS"
	LIBS="$LIBS $gtk3_LIBS"
], [
	AC_MSG_ERROR(You need Gtk+ >= 3.16 installed!)
])

PKG_CHECK_MODULES(GTKKit, [GTKKit >= 0.1], [
	CPPFLAGS="$CPPFLAGS $gtkkit_CFLAGS"
	LIBS="$LIBS $gtkkit_LIBS"
], [
	AC_MSG_ERROR(You need GTKKit >= 0.1 installed!)
])

dnl We don't call AC_PROG_CPP, but only AC_PROG_OBJCPP and set CPP to OBJCPP
dnl and add OBJCFPPFLAGS to CPPFLAGS, thus we need to AC_SUBST these ourself.
AC_SUBST(CPP)
AC_SUBST(CPPFLAGS)

dnl If you don't need any extra variables
dnl AC_CONFIG_FILES(buildsys.mk)
dnl If you need any extra variables, they go to extra.mk.
dnl If you use extra variables, comment the line above and uncomment the line
dnl below.
AC_CONFIG_FILES([buildsys.mk extra.mk])

dnl Generate config.h if we did some defines.
dnl AC_CONFIG_HEADERS(config.h)

dnl Write out configure script
AC_OUTPUT
