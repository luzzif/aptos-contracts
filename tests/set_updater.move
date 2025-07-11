#[test_only]
module metrom::set_updater_tests {
    use metrom::metrom::{Self, EForbidden};
    use metrom::tests_base;

    #[test(
        aptos = @aptos_framework, metrom = @metrom, owner = @0x50, updater = @0x51
    )]
    #[expected_failure(abort_code = EForbidden)]
    fun fail_forbidden(
        aptos: &signer,
        metrom: &signer,
        owner: &signer,
        updater: &signer
    ) {
        tests_base::init(aptos);
        tests_base::init_metrom_with_defaults(metrom, owner);
        metrom::set_updater(updater, @0x60);
    }

    #[test(aptos = @aptos_framework, metrom = @metrom, owner = @0x50)]
    fun success(aptos: &signer, metrom: &signer, owner: &signer) {
        tests_base::init(aptos);
        tests_base::init_metrom_with_defaults(metrom, owner);
        assert!(metrom::updater() != @0x60);
        metrom::set_updater(owner, @0x60);
        assert!(metrom::updater() == @0x60);
    }
}
