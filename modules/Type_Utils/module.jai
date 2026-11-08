enum_name_count :: ($T: Type) -> int
#modify {
    ti := cast(*Type_Info, T);
    return ti.type == .ENUM;
}
{
    tie := cast(*Type_Info_Enum, type_info(T));

    return tie.names.count;
}

offset_of :: ($T: Type, $member: string) -> int
#modify {
    ti := cast(*Type_Info, T);
    if ti.type != .STRUCT {
        return false;
    }

    tis := cast(*Type_Info_Struct, ti);

    for tis.members {
        if it.name == member {
            return true;
        }
    }

    return false;
}
{
    tis := cast(*Type_Info_Struct, type_info(T));

    for tis.members {
        if it.name == member {
            return it.offset_in_bytes;
        }
    }

    return -1;
}

