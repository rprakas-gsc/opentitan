CAPI=2:
# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
name: ${instance_vlnv("lowrisc:dv:flash_ctrl_cov")}
description: "FLASH_CTRL functional coverage interface & bind."

filesets:
  files_dv:
    depend:
      - lowrisc:dv:dv_utils
      - ${instance_vlnv("lowrisc:ip:flash_ctrl")}
    files:
      - flash_ctrl_cov_bind.sv
      - flash_ctrl_phy_cov_if.sv
    file_type: systemVerilogSource

targets:
  default:
    filesets:
      - files_dv