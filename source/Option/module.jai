Option :: union ($T: Type) kind: Option_Kind {
    .NONE,, none: void;
    .SOME,, some: T;
}

Option_Kind :: enum {
    NONE;
    SOME;
}
