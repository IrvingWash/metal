#scope_module

Model_Draw_Buckets :: struct {
    double_opaque: [..]Model_Draw_Bucket_Entry;
    double_mask:   [..]Model_Draw_Bucket_Entry;
    double_blend:  [..]Model_Draw_Bucket_Entry;

    single_opaque: [..]Model_Draw_Bucket_Entry;
    single_mask:   [..]Model_Draw_Bucket_Entry;
    single_blend:  [..]Model_Draw_Bucket_Entry;
}

Model_Draw_Bucket_Entry :: struct {
    command:  VK.Draw_Indexed_Indirect_Command;
    instance: Instance;
}

Draw_Pass :: struct {
    bucket:    []Model_Draw_Bucket_Entry;
    pipeline:  VK.Pipeline;
    cull_mode: VK.Cull_Mode_Flags;
}

init_model_draw_buckets :: () -> Model_Draw_Buckets {
    draw_buckets: Model_Draw_Buckets;
    for bucket: into_array(*draw_buckets) {
        array_reserve(bucket, MAX_DRAW_COUNT);
    }

    return draw_buckets;
}

into_draw_passes :: (draw_buckets: *Model_Draw_Buckets, pbr_pipeline_info: Pbr_Pipeline_Info) -> [6]Draw_Pass {
    #assert cast(*Type_Info_Struct, type_info(Model_Draw_Buckets)).members.count == 6 "Update this procedure";

    return .[
        {
            bucket    = draw_buckets.single_opaque,
            pipeline  = pbr_pipeline_info.opaque_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_opaque,
            pipeline  = pbr_pipeline_info.opaque_pipeline,
            cull_mode = .NONE,
        },
        {
            bucket    = draw_buckets.single_mask,
            pipeline  = pbr_pipeline_info.mask_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_mask,
            pipeline  = pbr_pipeline_info.mask_pipeline,
            cull_mode = .NONE,
        },
        {
            bucket    = draw_buckets.single_blend,
            pipeline  = pbr_pipeline_info.blend_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_blend,
            pipeline  = pbr_pipeline_info.blend_pipeline,
            cull_mode = .NONE,
        },
    ];
}

get_model_draw_bucket_by_material :: (draw_buckets: *Model_Draw_Buckets, material: Material) -> *[..]Model_Draw_Bucket_Entry {
    if material.double_sided {
        if #complete material.alpha_mode == {
            case .OPAQUE;
                return *draw_buckets.double_opaque;
            case .MASK;
                return *draw_buckets.double_mask;
            case .BLEND;
                return *draw_buckets.double_blend;
        }
    } else {
        if #complete material.alpha_mode == {
            case .OPAQUE;
                return *draw_buckets.single_opaque;
            case .MASK;
                return *draw_buckets.single_mask;
            case .BLEND;
                return *draw_buckets.single_blend;
        }
    }

    assert(false, "Unknown material: %", material);
}

reset_model_draw_buckets :: (draw_buckets: *Model_Draw_Buckets) {
    for bucket: into_array(draw_buckets) {
        array_reset_keeping_memory(bucket);
    }
}

destroy_model_draw_buckets :: (draw_buckets: *Model_Draw_Buckets) {
    for bucket: into_array(draw_buckets) {
        array_free(bucket.*);
    }

    draw_buckets.* = {};
}



#scope_file

into_array :: (draw_buckets: *Model_Draw_Buckets) -> [6]*[..]Model_Draw_Bucket_Entry {
    #assert cast(*Type_Info_Struct, type_info(Model_Draw_Buckets)).members.count == 6 "Update this procedure";

    return .[
        *draw_buckets.double_opaque,
        *draw_buckets.double_mask,
        *draw_buckets.double_blend,

        *draw_buckets.single_opaque,
        *draw_buckets.single_mask,
        *draw_buckets.single_blend,
    ];
}

VK :: #import "Jai_Vulkan";
