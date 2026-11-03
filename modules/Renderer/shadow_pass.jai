Shadow_Pass :: struct {}

create_shadow_pass :: () -> error: string, Shadow_Pass {
    shadow_pass: Shadow_Pass;

    return "", shadow_pass;
}

destroy_shadow_pass :: (shadow_pass: *Shadow_Pass) {
    shadow_pass.* = {};
}

do_shadow_pass :: (shadow_pass: *Shadow_Pass) {}
