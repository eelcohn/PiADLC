# --------------------------------------------------------------------------- #
# PiADLC - Drop-in replacement for the 68B54 ADLC                             #
#                                                                             #
# (c) Eelco Huininga 2018                                                     #
# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #
# First we'll set all the variables                                           #
# --------------------------------------------------------------------------- #
# Define which compiler we want to use                                        #
# --------------------------------------------------------------------------- #
CC = g++

# --------------------------------------------------------------------------- #
# Set the compiler flags:                                                     #
#  -g            adds debugging information to the executable file            #
#  -Wall         turns on most, but not all, compiler warnings                #
#  -Wall -Wextra turns on almost all compiler warnings                        #
#  -O2           do some code optimizations when compiling                    #
#  -std=c++11    turns on compiler and library support for the 2011 C++       #
#                standard (needed for thread support)                         #
# --------------------------------------------------------------------------- #
CFLAGS = -g -Wall -O3 -std=c++11

# define any directories containing header files other than /usr/include
INCLUDES = .

# define library paths in addition to /usr/lib
LDFLAGS = ./pigpio/

# define any libraries to link into executable:
LIBS =	-lcrypt \
	-lcrypto \
	-lcurses \
	-lpigpio \
	-lpthread \
	-lrt \
	-lssl

# define the C source files
MAIN_SRCS = \
	main.cpp \
	aun.cpp \
	platforms/linux.cpp \
	platforms/rpi-gpio.cpp

# define the C object files
OBJS		= $(MAIN_SRCS:.cpp=.o)

# define the executable file
MAIN	= FileStore



# --------------------------------------------------------------------------- #
# The following part of the makefile is generic; it can be used to            #
# build any executable just by changing the definitions above and by          #
# deleting dependencies appended to the file from 'make depend'               #
# --------------------------------------------------------------------------- #
# this is a suffix replacement rule for building .o's from .c's it uses       #
# automatic variables $<: the name of the prerequisite of the rule(a .c file) #
# and $@: the name of the target of the rule (a .o file) (see the gnu make    #
# manual section about automatic variables)                                   #
# --------------------------------------------------------------------------- #
%.o: %.cpp
	$(CC) $(CFLAGS) -I$(INCLUDES) -c $< -o $@

all:	$(MAIN)
	@echo
	@echo Done! Your PiADLC is compiled.
	
$(MAIN): $(OBJS)
	@echo Linking $(MAIN)...
	$(CC) $(CFLAGS) -I$(INCLUDES) -o $(MAIN) $(OBJS) -L$(LDFLAGS) $(LIBS)

install:
	@echo Installing $(MAIN)...
	@install -m 755 $(MAIN) ..
	@strip ../$(MAIN)
	@echo
	@echo Done! Your PiADLC is installed.

clean:
	$(RM) $(OBJS) $(MAIN) config.h
	$(RM) *~

depend: $(MAIN_SRCS)
	makedepend $(INCLUDES) $^

help:
	@echo Options
	@echo "   make"
	@echo "      Compile the sourcecode."
	@echo ""
	@echo "   make install"
	@echo "      Install the compiled sourcecode."
	@echo ""
	@echo "   make clean"
	@echo "      Remove all like object (.o) files and the compiled binaries."
	@echo ""
	@echo "   make help"
	@echo "      Show this help screen."
