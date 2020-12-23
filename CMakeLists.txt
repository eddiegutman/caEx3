cmake_minimum_required(VERSION 3.17)
project(caEx3 C ASM)
set(CMAKE_C_FLAGS "-no-pie")
set(CMAKE_ASM_FLAGS "-no-pie")
add_executable(caEx3
        main.c
        pstring.s
        pstring.h
        run_main.s
        func_select.s)