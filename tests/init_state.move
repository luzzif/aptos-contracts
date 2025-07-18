#[test_only]
module metrom::init_state_tests {
    use std::signer;

    use metrom::metrom::{
        Self,
        EForbidden,
        EInvalidFee,
        EInvalidMinimumCampaignDuration,
        EAlreadyInitialized
    };
    use metrom::tests_base;

    #[test(aptos = @aptos_framework, metrom = @metrom, other = @0x50)]
    #[expected_failure(abort_code = EForbidden)]
    fun fail_forbidden(aptos: &signer, metrom: &signer, other: &signer) {
        tests_base::init(aptos);
        metrom::test_init_module(metrom);
        metrom::init_state(other, signer::address_of(other), @0x00, 0, 0, 0);
    }

    #[test(aptos = @aptos_framework, metrom = @metrom, owner = @0x50)]
    #[expected_failure(abort_code = EInvalidFee)]
    fun fail_invalid_fee(
        aptos: &signer, metrom: &signer, owner: &signer
    ) {
        tests_base::init(aptos);
        tests_base::init_metrom(metrom, owner, owner, 1_000_000, 1, 1);
    }

    #[test(aptos = @aptos_framework, metrom = @metrom, owner = @0x50)]
    #[expected_failure(abort_code = EInvalidMinimumCampaignDuration)]
    fun fail_invalid_minimum_campaign_duration(
        aptos: &signer, metrom: &signer, owner: &signer
    ) {
        tests_base::init(aptos);
        tests_base::init_metrom(metrom, owner, owner, 10_000, 20, 10);
    }

    #[test(aptos = @aptos_framework, metrom = @metrom, owner = @0x50)]
    #[expected_failure(abort_code = EAlreadyInitialized)]
    fun fail_already_initialized(
        aptos: &signer, metrom: &signer, owner: &signer
    ) {
        tests_base::init(aptos);
        tests_base::init_metrom(metrom, owner, owner, 10_000, 10, 20);
        metrom::init_state(
            metrom,
            signer::address_of(owner),
            @0x00,
            10_000,
            10,
            20
        );
    }
}
