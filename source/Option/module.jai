Option :: union ($T: Type) kind: Option_Kind {
    .NONE,, none: void;
    .SOME,, some: T;
}

Option_Kind :: enum {
    NONE;
    SOME;
}

set :: (option: *Option($T), value: T) {
    option.kind = .SOME;
    option.some = value;
}
