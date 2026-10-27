#module_parameters(DEBUG: bool = false);

MAGIC             :: 0x46546C67;
SUPPORTED_VERSION :: 2;

Header :: struct {
    magic: u32;
    version: u32;
    length: u32;

    SPEC_BYTE_SIZE :: 12;
}

Chunk_Header :: struct {
    length: u32;
    type:   Chunk_Type;

    SPEC_BYTE_SIZE :: 8;
}

Chunk_Type :: enum u32 {
    JSON :: 0x4E4F534A;
    BIN  :: 0x004E4942;
}

#if DEBUG {
    #assert(size_of(Header)       == Header.SPEC_BYTE_SIZE);
    #assert(size_of(Chunk_Header) == Chunk_Header.SPEC_BYTE_SIZE);
}
