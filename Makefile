SUBDIRS = src tests
PC_FILES = GTKKit.pc

tests: src

include buildsys.mk
