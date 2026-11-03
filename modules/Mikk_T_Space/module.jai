TBool :: #type s32;

Context :: struct {
    m_p_interface: *Interface; // initialized with callback functions
    m_p_user_data: *void;      // pointer     to   client   side mesh data etc. (passed as the first parameter with every interface call)
}

Interface :: struct {
    // Returns the number of faces (triangles/quads) on the mesh to be processed.
    m_get_num_faces: #type (p_context: *Context) -> s32 #c_call;

    // Returns the number of vertices on face number iFace
    // iFace is a number in the range {0, 1, ..., getNumFaces()-1}
    m_get_num_vertices_of_face: #type (p_context: *Context, i_face: s32) -> s32 #c_call;

    // returns the position/normal/texcoord of the referenced face of vertex number iVert.
    // iVert is in the range {0,1,2} for triangles and {0,1,2,3} for quads.
    m_get_position:  #type (p_context: *Context, fv_pos_out:  *float, i_face: s32, i_vert: s32) -> void #c_call;
    m_get_normal:    #type (p_context: *Context, fv_norm_out: *float, i_face: s32, i_vert: s32) -> void #c_call;
    m_get_tex_coord: #type (p_context: *Context, fv_texc_out: *float, i_face: s32, i_vert: s32) -> void #c_call;

    // This function is used to return the tangent and fSign to the application.
    // fvTangent is a unit length vector.
    // For normal maps it is sufficient to use the following simplified version of the bitangent which is generated at pixel/vertex level.
    // bitangent = fSign * cross(vN, tangent);
    // Note that the results are returned unindexed. It is possible to generate a new index list
    // But averaging/overwriting tangent spaces by using an already existing index list WILL produce INCRORRECT results.
    // DO NOT! use an already existing index list.
    m_set_t_space_basic: #type (
        p_context: *Context,
        fv_tangent: *float,
        f_sign: float,
        i_face: s32,
        i_vert: s32,
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
    m_set_t_space: #type (
        p_context:                   *Context,
        fv_tangent:                  *float,
        fv_bi_tangent:               *float,
        f_mag_s:                     float,
        f_mag_t:                     float,
        b_is_orientation_preserving: TBool,
        i_face:                      s32,
        i_vert:                      s32,
    ) -> void #c_call;
}

gen_tang_space_default :: (p_context: *Context) -> TBool #foreign libmikktspace :: "genTangSpaceDefault";

gen_tang_space :: (p_context: *Context, f_angular_threshold: float) -> TBool #foreign libmikktspace "genTangSpace";

#if OS == .LINUX {
    libmikktspace :: #library,no_dll "./LINUX/libmikktspace";
} else {
    #assert "Unsupported OS";
}
