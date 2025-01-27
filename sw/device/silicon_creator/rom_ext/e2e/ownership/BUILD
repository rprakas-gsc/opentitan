# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

load(
    "//rules/opentitan:defs.bzl",
    "fpga_params",
    "opentitan_test",
)
load(
    "//sw/device/silicon_creator/rom_ext/e2e/ownership:defs.bzl",
    "ownership_transfer_test",
)

package(default_visibility = ["//visibility:public"])

# TODO(#24462): The tests in this file are marked `changes_otp = True`,
# but they don't change OTP.  They modify the ownership INFO pages,
# so we need to clear the bitstream after the test, which is what the
# `changes_otp` parameter actually does.

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_transfer_any_test
ownership_transfer_test(
    name = "transfer_any_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Any
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
    rsa_key = {
        "//sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod": "app_prod",
    },
    deps = [
        "//sw/device/lib/base:status",
        "//sw/device/lib/testing/test_framework:ottf_main",
        "//sw/device/silicon_creator/lib:boot_log",
        "//sw/device/silicon_creator/lib/drivers:retention_sram",
    ],
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_unlock_test
ownership_transfer_test(
    name = "bad_unlock_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Any
            # NOTE: We use the wrong unlock key to test that the unlock operation fails.
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:activate_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
            --expected-error=OwnershipInvalidSignature
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_activate_test
ownership_transfer_test(
    name = "bad_activate_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Any
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            # NOTE: We use the wrong activate key to test that the activate operation fails.
            --activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
            --expected-error=OwnershipInvalidSignature
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_owner_block_test
ownership_transfer_test(
    name = "bad_owner_block_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Any
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
            --corrupt-owner-block-signature=true
            --dual-owner-boot-check=false
            --expected-error=OwnershipInvalidInfoPage
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_app_key_test
ownership_transfer_test(
    name = "bad_app_key_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Any
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            # NOTE: We use the wrong app key (fake instead of dummy) to test that we cannot boot
            # the test program after completing the transfer.
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:app_prod_pub)
            --expected-error=OwnershipKeyNotFound
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_transfer_endorsed_test
ownership_transfer_test(
    name = "transfer_endorsed_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Endorsed
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-owner-key-pub=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key_pub)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_endorsee_test
ownership_transfer_test(
    name = "bad_endorsee_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Endorsed
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            # NOTE: We use the wrong next-owner-public-key to test that endorsee is rejected and the activate operation fails.
            --next-owner-key-pub=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:owner_key_pub)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
            --dual-owner-boot-check=false
            --expected-error=OwnershipInvalidInfoPage
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_locked_update_test
ownership_transfer_test(
    name = "locked_update_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Update
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:activate_key)
            # NOTE: We rotate the `fake` test owner's application key to the dummy key to test that
            #       we can execute code with the new key.
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_locked_update_test
# Part 1: Ensure a LockedUpdate with a new owner key is rejected.
ownership_transfer_test(
    name = "bad_locked_update_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Update
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            # NOTE: We use the wrong owner key to test that the activate operation fails.
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:activate_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:app_prod_pub)
            --dual-owner-boot-check=false
            --expected-error=OwnershipInvalidInfoPage
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
    rsa_key = {
        "//sw/device/silicon_creator/lib/ownership/keys/fake:app_prod": "app_prod",
    },
)

# rom_ext_e2e_testplan.hjson%rom_ext_e2e_bad_locked_update_test
# Part 2: Ensure a LockedUpdate denies execution to anything signed with new app keys.
ownership_transfer_test(
    name = "bad_locked_update_no_exec_test",
    fpga = fpga_params(
        changes_otp = True,
        test_cmd = """
            --clear-bitstream
            --bootstrap={firmware}
            --unlock-mode=Update
            --unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-unlock-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:unlock_key)
            --next-activate-key=$(location //sw/device/silicon_creator/lib/ownership/keys/fake:activate_key)

            # NOTE: We use the wrong owner key and the dummy app key (which the ownership_transfer_test rule
            #       uses for signing) to check that owner code execution is denied in the intermediate
            #       dual-owner state.
            --next-owner-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:owner_key)
            --next-application-key=$(location //sw/device/silicon_creator/lib/ownership/keys/dummy:app_prod_pub)
            --expected-error=OwnershipKeyNotFound
        """,
        test_harness = "//sw/host/tests/ownership:transfer_test",
    ),
)
