# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# ------------------- W A R N I N G: A U T O - G E N E R A T E D   C O D E !! -------------------#
# PLEASE DO NOT HAND-EDIT THIS FILE. IT HAS BEEN AUTO-GENERATED WITH THE FOLLOWING COMMAND:
# util/topgen.py -t hw/top_englishbreakfast/data/top_englishbreakfast.hjson
# -o hw/top_englishbreakfast

load("//rules:linker.bzl", "ld_library")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "top_englishbreakfast",
    srcs = [
        "top_englishbreakfast.c",
    ],
    hdrs = [
        "top_englishbreakfast.h",
        "top_englishbreakfast_memory.h",
    ],
)

ld_library(
    name = "top_englishbreakfast_memory",
    includes = ["top_englishbreakfast_memory.ld"],
)
