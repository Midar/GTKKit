SUBDIRS = src tests
PC_FILES = $(wildcard *.pc)

tests: src

include buildsys.mk
