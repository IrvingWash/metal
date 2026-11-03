TBool :: #type s32;

Context :: struct {
    _interface: *Interface; // initialized with callback functions
    user_data:  *void;      // pointer     to   client   side mesh data etc. (passed as the first parameter with every interface call)
}

Interface :: struct {
    // Returns the number of faces (triangles/quads) on the mesh to be processed.
    get_num_faces: #type (_context: *Context) -> s32 #c_call;

    // Returns the number of vertices on face number iFace
    // iFace is a number in the range {0, 1, ..., getNumFaces()-1}
    get_num_vertices_of_face: #type (_context: *Context, face: s32) -> s32 #c_call;

    // returns the position/normal/texcoord of the referenced face of vertex number iVert.
    // iVert is in the range {0,1,2} for triangles and {0,1,2,3} for quads.
    get_position:  #type (_context: *Context, pos_out: *float, face: s32, vert: s32) -> void #c_call;
    get_normal:    #type (_context: *Context, norm_out: *float, face: s32, i_vert: s32) -> void #c_call;
    get_tex_coord: #type (_context: *Context, texc_out: *float, face: s32, vert: s32) -> void #c_call;

    // This function is used to return the tangent and fSign to the application.
    // fvTangent is a unit length vector.
    // For normal maps it is sufficient to use the following simplified version of the bitangent which is generated at pixel/vertex level.
    // bitangent = fSign * cross(vN, tangent);
    // Note that the results are returned unindexed. It is possible to generate a new index list
    // But averaging/overwriting tangent spaces by using an already existing index list WILL produce INCRORRECT results.
    // DO NOT! use an already existing index list.
    set_t_space_basic: #type (
        _context: *Context,
        tangent:  *float,
        sign:     float,
        face:     s32,
        vert:     s32,
    ) -> void #c_call;

    // This function is used to return tangent space results to the application.
    // fvTangent and fvBiTangent are unit length vectors and fMagS and fMagT are their
    // true magnitudes which can be used for relief mapping effects.
    // fvBiTangent is the "real" bitangent and thus may not be perpendicular to fvTangent.
    // However, both are perpendicular to the vertex normal.
    // For normal maps it is sufficient to use the following simplified version of the bitangent which is generated at pixel/vertex level.
    // fSign = bIsOrientationPreserving ? 1.0f : (-1.0f);
    // bitangent = fSign * cross(vN, tangent);
    // Note that the results are returned unindexed. It is possible to generate a new index list
    // But averaging/overwriting tangent spaces by using an already existing index list WILL produce INCRORRECT results.
    // DO NOT! use an already existing index list.
    set_t_space: #type (
        _context:                  *Context,
        tangent:                   *float,
        bi_tangent:                *float,
        mag_s:                     float,
        mag_t:                     float,
        is_orientation_preserving: TBool,
        face:                      s32,
        vert:                      s32,
    ) -> void #c_call;
}

gen_tang_space_default :: (_context: *Context) -> TBool #foreign libmikktspace "genTangSpaceDefault";

gen_tang_space :: (_context: *Context, angular_threshold: float) -> TBool #foreign libmikktspace "genTangSpace";



#scope_file

#if OS == .LINUX {
    libmikktspace :: #library,no_dll "./LINUX/libmikktspace";
} else {
    #assert "Unsupported OS";
}
