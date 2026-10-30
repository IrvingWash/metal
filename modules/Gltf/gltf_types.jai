// This file contains only type declarations

SENTINEL :: -1;

SUPPORTED_GLTF_VERSION :: "2";

Gltf :: struct {
    extensions_used:     []string;      @JsonName(extensionsUsed)
    extensions_required: []string;      @JsonName(extensionsRequired)
    accessors:           []Accessor;
    animations:          []Animation;
    asset:               Asset;
    buffers:             []Buffer;
    buffer_views:        []Buffer_View; @JsonName(bufferViews)
    cameras:             []Camera;
    images:              []Image;
    materials:           []Material;
    meshes:              []Mesh;
    nodes:               []Node;
    samplers:            []Sampler;
    _scene:              int            = SENTINEL; @JsonName(scene)
    scenes:              []Scene;
    skins:               []Skin;
    textures:            []Texture;
    extensions:          JSON_Value;
    extras:              JSON_Value;
}

Accessor :: struct {
    _buffer_view:   int             = SENTINEL; @JsonName(bufferView)
    byte_offset:    int;                        @JsonName(byteOffset)
    component_type: Component_Type;             @JsonName(componentType)
    normalized:     bool;
    count:          int;
    type:           _Type;
    max:            []float;
    min:            []float;
    sparse:         Sparse;
    name:           string = "Accessor";
    extensions:     JSON_Value;
    extras:         JSON_Value;

    Component_Type :: enum #specified {
        BYTE           :: 5120;
        UNSIGNED_BYTE  :: 5121;
        SHORT          :: 5122;
        UNSIGNED_SHORT :: 5123;
        UNSIGNED_INT   :: 5125;
        FLOAT          :: 5126;
    }

    _Type :: enum {
        SCALAR;
        VEC2;
        VEC3;
        VEC4;
        MAT2;
        MAT3;
        MAT4;
    }

    Sparse :: struct {
        _count:     int = SENTINEL; @JsonName(count)
        indices:    Indices;
        values:     Values;
        extensions: JSON_Value;
        extras:     JSON_Value;

        Indices :: struct {
            buffer_view:    int;            @JsonName(bufferView)
            byte_offset:    int;            @JsonName(byteOffset)
            component_type: Component_Type; @JsonName(componentType)
            extensions:     JSON_Value;
            extras:         JSON_Value;
        }

        Values :: struct {
            buffer_view: int; @JsonName(bufferView)
            byte_offset: int; @JsonName(byteOffset)
            extensions:  JSON_Value;
            extras:      JSON_Value;
        }
    }
}

Animation :: struct {
    channels:   []Channel;
    samplers:   []Animation.Sampler;
    name:       string = "Animation";
    extensions: JSON_Value;
    extras:     JSON_Value;

    Channel :: struct {
        sampler:    int;
        target:     Target;
        extensions: JSON_Value;
        extras:     JSON_Value;

        Target :: struct {
            _node:      int = SENTINEL; @JsonName(node)
            path:       Path;
            extensions: JSON_Value;
            extras:     JSON_Value;

            Path :: enum {
                translation;
                rotation;
                scale;
                weights;
            }
        }
    }

    Sampler :: struct {
        input:         int;
        interpolation: Interpolation = .LINEAR;
        output:        int;
        extensions:    JSON_Value;
        extras:        JSON_Value;

        Interpolation :: enum {
            LINEAR;
            STEP;
            CUBICSPLINE;
        }
    }
}

Asset :: struct {
    copyright:   string;
    generator:   string;
    version:     string; // GLTF version: <major>.<minor>
    min_version: string; @JsonName(minVersion) //   GLTF version: <major>.<minor>
    extensions:  JSON_Value;
    extras:      JSON_Value;
}

Buffer :: struct {
    uri:         string;
    byte_length: int; @JsonName(byteLength)
    name:        string = "Buffer";
    extensions:  JSON_Value;
    extras:      JSON_Value;

    bytes: []u8; @JsonIgnore
}

Buffer_View :: struct {
    buffer:       int;
    byte_offset:  int;             @JsonName(byteOffset)
    byte_length:  int;             @JsonName(byteLength)
    _byte_stride: int  = SENTINEL; @JsonName(byteStride)
    target:       Target;
    name:         string = "Buffer View";
    extensions:   JSON_Value;
    extras:       JSON_Value;

    Target :: enum #specified {
        UNDEFINED            :: 0;
        ARRAY_BUFFER         :: 34962;
        ELEMENT_ARRAY_BUFFER :: 34963;
    }
}

Camera :: struct {
    orthographic: Orthographic;
    perspective:  Perspective;
    type:         _Type;
    name:         string = "Camera";
    extensions:   JSON_Value;
    extras:       JSON_Value;

    Orthographic :: struct {
        x_mag:      float; @JsonName(xmag)
        y_mag:      float; @JsonName(ymag)
        z_far:      float; @JsonName(zfar)
        z_near:     float; @JsonName(znear)
        extensions: JSON_Value;
        extras:     JSON_Value;
    }

    Perspective :: struct {
        _aspect_ratio: float  = xx SENTINEL;      @JsonName(aspectRatio)
        y_fov:         float;                     @JsonName(yfov)
        z_far:         float  = FLOAT32_INFINITY; @JsonName(zfar)
        z_near:        float;                     @JsonName(znear)
        extensions:    JSON_Value;
        extras:        JSON_Value;
    }

    _Type :: enum {
        perspective;
        orthographic;
    }
}

Image :: struct {
    uri:          string;
    mime_type:    string;             @JsonName(mimeType)
    _buffer_view: int     = SENTINEL; @JsonName(bufferView)
    name:         string = "Image";
    extensions:   JSON_Value;
    extras:       JSON_Value;
}

Material :: struct {
    pbr_metallic_roughness: Pbr_Metallic_Roughness;            @JsonName(pbrMetallicRoughness)
    normal_texture:         Normal_Texture_Info;               @JsonName(normalTexture)
    occlusion_texture:      Occlusion_Texture_Info;            @JsonName(occlusionTexture)
    emissive_texture:       Texture_Info;                      @JsonName(emissiveTexture)
    emissive_factor:        [3]float;                          @JsonName(emissiveFactor)
    alpha_mode:             Alpha_Mode              = .OPAQUE; @JsonName(alphaMode)
    alpha_cutoff:           float                   = 0.5;     @JsonName(alphaCutoff)
    double_sided:           bool;                              @JsonName(doubleSided)
    name:                   string = "Material";
    extensions:             JSON_Value;
    extras:                 JSON_Value;

    Normal_Texture_Info :: struct {
        _index:     int   = SENTINEL; @JsonName(index)
        tex_coord:  int;              @JsonName(texCoord)
        scale:      float = 1;
        extensions: JSON_Value;
        extras:     JSON_Value;
    }

    Occlusion_Texture_Info :: struct {
        _index:     int   = SENTINEL; @JsonName(index)
        tex_coord:  int;              @JsonName(texCoord)
        strength:   float = 1;
        extensions: JSON_Value;
        extras:     JSON_Value;
    }

    Pbr_Metallic_Roughness :: struct {
        base_color_factor:          [4]float      = .[1, 1, 1, 1]; @JsonName(baseColorFactor)
        base_color_texture:         Texture_Info;                  @JsonName(baseColorTexture)
        metallic_factor:            float         = 1;             @JsonName(metallicFactor)
        roughness_factor:           float         = 1;             @JsonName(roughnessFactor)
        metallic_roughness_texture: Texture_Info;                  @JsonName(metallicRoughnessTexture)
        extensions:                 JSON_Value;
        extras:                     JSON_Value;
    }

    Alpha_Mode :: enum {
        OPAQUE;
        MASK;
        BLEND;
    }
}

Mesh :: struct {
    primitives: []Primitive;
    weights:    []float;
    name:       string = "Mesh";
    extensions: JSON_Value;
    extras:     JSON_Value;

    Primitive :: struct {
        attributes: Attribute;
        _indices:   int           = SENTINEL; @JsonName(indices)
        _material:  int           = SENTINEL; @JsonName(material)
        mode:       Topology_Mode = .TRIANGLES;
        targets:    []Morph_Target;
        extensions: JSON_Value;
        extras:     JSON_Value;

        Attribute :: struct {
            _position:    int = SENTINEL; @JsonName(POSITION)
            _normal:      int = SENTINEL; @JsonName(NORMAL)
            _tangent:     int = SENTINEL; @JsonName(TANGENT)
            _tex_coord_0: int = SENTINEL; @JsonName(TEXCOORD_0)
            _tex_coord_1: int = SENTINEL; @JsonName(TEXCOORD_1)
            _tex_coord_2: int = SENTINEL; @JsonName(TEXCOORD_2)
            _color_0:     int = SENTINEL; @JsonName(COLOR_0)
            _color_1:     int = SENTINEL; @JsonName(COLOR_1)
            _color_2:     int = SENTINEL; @JsonName(COLOR_2)
            _joints_0:    int = SENTINEL; @JsonName(JOINTS_0)
            _joints_1:    int = SENTINEL; @JsonName(JOINTS_1)
            _joints_2:    int = SENTINEL; @JsonName(JOINTS_2)
            _weights_0:   int = SENTINEL; @JsonName(WEIGHTS_0)
            _weights_1:   int = SENTINEL; @JsonName(WEIGHTS_1)
            _weights_2:   int = SENTINEL; @JsonName(WEIGHTS_2)
        }

        Topology_Mode :: enum #specified {
            POINTS         :: 0;
            LINES          :: 1;
            LINE_LOOP      :: 2;
            LINE_STRIP     :: 3;
            TRIANGLES      :: 4;
            TRIANGLE_STRIP :: 5;
            TRIANGLE_FAN   :: 6;
        }

        Morph_Target :: struct {
            _position: int = SENTINEL; @JsonName(POSITION)
            _normal:   int = SENTINEL; @JsonName(NORMAL)
            _tangent:  int = SENTINEL; @JsonName(TANGENT)
        }
    }
}

Node :: struct {
    _camera:  int = SENTINEL; @JsonName(camera)
    children: []int;
    _skin:    int = SENTINEL; @JsonName(skin)
    // Column-major
    column_major_matrix: [16]float = .[
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
    ]; @JsonName(matrix)
    _mesh:       int      = SENTINEL; @JsonName(mesh)
    rotation:    [4]float = .[0, 0, 0, 1];
    scale:       [3]float = .[1, 1, 1];
    translation: [3]float;
    weights:     []float;
    name:        string = "Node";
    extensions:  JSON_Value;
    extras:      JSON_Value;
}

Sampler :: struct {
    mag_filter: Mag_Filter;            @JsonName(magFilter)
    min_filter: Min_Filter;            @JsonName(minFilter)
    wrap_s:     Wrap_Mode   = .REPEAT; @JsonName(wrapS)
    wrap_t:     Wrap_Mode   = .REPEAT; @JsonName(wrapT)
    name:       string = "Sampler";
    extensions: JSON_Value;
    extras:     JSON_Value;

    Mag_Filter :: enum #specified {
        UNDEFINED :: 0;
        NEAREST   :: 9728;
        LINEAR    :: 9729;
    }

    Min_Filter :: enum #specified {
        UNDEFINED              :: 0;
        NEAREST                :: 9728;
        LINEAR                 :: 9729;
        NEAREST_MIPMAP_NEAREST :: 9984;
        LINEAR_MIPMAP_NEAREST  :: 9985;
        NEAREST_MIPMAP_LINEAR  :: 9986;
        LINEAR_MIPMAP_LINEAR   :: 9987;
    }

    Wrap_Mode :: enum #specified {
        CLAMP_TO_EDGE   :: 33071;
        MIRRORED_REPEAT :: 33648;
        REPEAT          :: 10497;
    }
}

Scene :: struct {
    nodes:      []int;
    name:       string = "Scene";
    extensions: JSON_Value;
    extras:     JSON_Value;
}

Skin :: struct {
    _inverse_bind_matrices: int = SENTINEL; @JsonName(inverseBindMatrices)
    _skeleton:              int = SENTINEL; @JsonName(skeleton)
    joints:                 []int;
    name:                   string = "Skin";
    extensions:             JSON_Value;
    extras:                 JSON_Value;
}

Texture :: struct {
    _sampler:   int = SENTINEL; @JsonName(sampler)
    _source:    int = SENTINEL; @JsonName(source)
    name:       string = "Texture";
    extensions: JSON_Value;
    extras:     JSON_Value;
}

Texture_Info :: struct {
    _index:     int  = SENTINEL; @JsonName(index)
    tex_coord:  int;             @JsonName(texCoord)
    extensions: JSON_Value;
    extras:     JSON_Value;
}



#scope_file

#import "Math";
