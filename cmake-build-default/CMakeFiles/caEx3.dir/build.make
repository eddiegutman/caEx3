# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/clion-2020.3/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /opt/clion-2020.3/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/eddie/Documents/code/ClionProjects/caEx3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default

# Include any dependencies generated for this target.
include CMakeFiles/caEx3.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/caEx3.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/caEx3.dir/flags.make

CMakeFiles/caEx3.dir/main.c.o: CMakeFiles/caEx3.dir/flags.make
CMakeFiles/caEx3.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/caEx3.dir/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/caEx3.dir/main.c.o   -c /home/eddie/Documents/code/ClionProjects/caEx3/main.c

CMakeFiles/caEx3.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/caEx3.dir/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/eddie/Documents/code/ClionProjects/caEx3/main.c > CMakeFiles/caEx3.dir/main.c.i

CMakeFiles/caEx3.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/caEx3.dir/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/eddie/Documents/code/ClionProjects/caEx3/main.c -o CMakeFiles/caEx3.dir/main.c.s

CMakeFiles/caEx3.dir/pstring.s.o: CMakeFiles/caEx3.dir/flags.make
CMakeFiles/caEx3.dir/pstring.s.o: ../pstring.s
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building ASM object CMakeFiles/caEx3.dir/pstring.s.o"
	/usr/bin/cc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/caEx3.dir/pstring.s.o -c /home/eddie/Documents/code/ClionProjects/caEx3/pstring.s

CMakeFiles/caEx3.dir/run_main.s.o: CMakeFiles/caEx3.dir/flags.make
CMakeFiles/caEx3.dir/run_main.s.o: ../run_main.s
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building ASM object CMakeFiles/caEx3.dir/run_main.s.o"
	/usr/bin/cc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/caEx3.dir/run_main.s.o -c /home/eddie/Documents/code/ClionProjects/caEx3/run_main.s

CMakeFiles/caEx3.dir/func_select.s.o: CMakeFiles/caEx3.dir/flags.make
CMakeFiles/caEx3.dir/func_select.s.o: ../func_select.s
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building ASM object CMakeFiles/caEx3.dir/func_select.s.o"
	/usr/bin/cc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/caEx3.dir/func_select.s.o -c /home/eddie/Documents/code/ClionProjects/caEx3/func_select.s

# Object files for target caEx3
caEx3_OBJECTS = \
"CMakeFiles/caEx3.dir/main.c.o" \
"CMakeFiles/caEx3.dir/pstring.s.o" \
"CMakeFiles/caEx3.dir/run_main.s.o" \
"CMakeFiles/caEx3.dir/func_select.s.o"

# External object files for target caEx3
caEx3_EXTERNAL_OBJECTS =

caEx3: CMakeFiles/caEx3.dir/main.c.o
caEx3: CMakeFiles/caEx3.dir/pstring.s.o
caEx3: CMakeFiles/caEx3.dir/run_main.s.o
caEx3: CMakeFiles/caEx3.dir/func_select.s.o
caEx3: CMakeFiles/caEx3.dir/build.make
caEx3: CMakeFiles/caEx3.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable caEx3"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/caEx3.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/caEx3.dir/build: caEx3

.PHONY : CMakeFiles/caEx3.dir/build

CMakeFiles/caEx3.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/caEx3.dir/cmake_clean.cmake
.PHONY : CMakeFiles/caEx3.dir/clean

CMakeFiles/caEx3.dir/depend:
	cd /home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/eddie/Documents/code/ClionProjects/caEx3 /home/eddie/Documents/code/ClionProjects/caEx3 /home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default /home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default /home/eddie/Documents/code/ClionProjects/caEx3/cmake-build-default/CMakeFiles/caEx3.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/caEx3.dir/depend

