//
// This file was auto-generated using the following command:
//
// jai ./modules/Mini_Audio/generate.jai
//



MA_VERSION_MAJOR :: 0;
MA_VERSION_MINOR :: 11;
MA_VERSION_REVISION :: 26;

MA_SIZEOF_PTR :: 8;

MA_TRUE :: 1;
MA_FALSE :: 0;

MA_SIZE_MAX :: 0xFFFFFFFF;

MA_UINT64_MAX :: (cast(ma_uint64) 0xFFFFFFFF << 32) | cast(ma_uint64) 0xFFFFFFFF;

MA_SIMD_ALIGNMENT :: 32;

MA_MIN_CHANNELS :: 1;

MA_MAX_CHANNELS :: 254;

MA_MAX_FILTER_ORDER :: 8;

MA_MAX_LOG_CALLBACKS :: 4;

MA_CHANNEL_INDEX_NULL :: 255;

MA_DATA_SOURCE_SELF_MANAGED_RANGE_AND_LOOP_POINT :: 0x00000001;

MA_DATA_FORMAT_FLAG_EXCLUSIVE_MODE :: 1 << 1;

MA_MAX_DEVICE_NAME_LENGTH :: 255;

ma_resource_manager_job :: ma_job;
ma_resource_manager_job_init :: ma_job_init;

ma_resource_manager_job_queue_config :: ma_job_queue_config;
ma_resource_manager_job_queue_config_init :: ma_job_queue_config_init;
ma_resource_manager_job_queue :: ma_job_queue;
ma_resource_manager_job_queue_get_heap_size :: ma_job_queue_get_heap_size;
ma_resource_manager_job_queue_init_preallocated :: ma_job_queue_init_preallocated;
ma_resource_manager_job_queue_init :: ma_job_queue_init;
ma_resource_manager_job_queue_uninit :: ma_job_queue_uninit;
ma_resource_manager_job_queue_post :: ma_job_queue_post;
ma_resource_manager_job_queue_next :: ma_job_queue_next;

MA_RESOURCE_MANAGER_MAX_JOB_THREAD_COUNT :: 64;

MA_MAX_NODE_BUS_COUNT :: 254;

MA_MAX_NODE_LOCAL_BUS_COUNT :: 2;

MA_NODE_BUS_COUNT_UNKNOWN :: 255;

MA_ENGINE_MAX_LISTENERS :: 4;

MA_LISTENER_INDEX_CLOSEST :: cast,trunc(ma_uint8) -1;

MA_SOUND_SOURCE_CHANNEL_COUNT :: 0xFFFFFFFF;

ma_int8 :: s8;
ma_uint8 :: u8;
ma_int16 :: s16;
ma_uint16 :: u16;
ma_int32 :: s32;
ma_uint32 :: u32;

ma_int64 :: s64;
ma_uint64 :: u64;

ma_uintptr :: ma_uint64;

ma_bool8 :: ma_uint8;
ma_bool32 :: ma_uint32;

/* These float types are not used universally by miniaudio. It's to simplify some macro expansion for atomic types. */
ma_float :: float;
ma_double :: float64;

ma_handle :: *void;
ma_ptr :: *void;

ma_proc :: #type () -> void #c_call;

ma_pthread_t :: pthread_t;
ma_pthread_mutex_t :: pthread_mutex_t;
ma_pthread_cond_t :: pthread_cond_t;

ma_wchar_win32 :: ma_uint16;

/*
Logging Levels
==============
Log levels are only used to give logging callbacks some context as to the severity of a log message
so they can do filtering. All log levels will be posted to registered logging callbacks. If you
don't want to output a certain log level you can discriminate against the log level in the callback.

MA_LOG_LEVEL_DEBUG
Used for debugging. Useful for debug and test builds, but should be disabled in release builds.

MA_LOG_LEVEL_INFO
Informational logging. Useful for debugging. This will never be called from within the data
callback.

MA_LOG_LEVEL_WARNING
Warnings. You should enable this in you development builds and action them when encountered. These
logs usually indicate a potential problem or misconfiguration, but still allow you to keep
running. This will never be called from within the data callback.

MA_LOG_LEVEL_ERROR
Error logging. This will be fired when an operation fails and is subsequently aborted. This can
be fired from within the data callback, in which case the device will be stopped. You should
always have this log level enabled.
*/
ma_log_level :: enum u32 {
    DEBUG   :: 4;
    INFO    :: 3;
    WARNING :: 2;
    ERROR   :: 1;

    MA_LOG_LEVEL_DEBUG   :: DEBUG;
    MA_LOG_LEVEL_INFO    :: INFO;
    MA_LOG_LEVEL_WARNING :: WARNING;
    MA_LOG_LEVEL_ERROR   :: ERROR;
}

ma_channel :: ma_uint8;
_ma_channel_position :: enum u32 {
    NONE               :: 0;
    MONO               :: 1;
    FRONT_LEFT         :: 2;
    FRONT_RIGHT        :: 3;
    FRONT_CENTER       :: 4;
    LFE                :: 5;
    BACK_LEFT          :: 6;
    BACK_RIGHT         :: 7;
    FRONT_LEFT_CENTER  :: 8;
    FRONT_RIGHT_CENTER :: 9;
    BACK_CENTER        :: 10;
    SIDE_LEFT          :: 11;
    SIDE_RIGHT         :: 12;
    TOP_CENTER         :: 13;
    TOP_FRONT_LEFT     :: 14;
    TOP_FRONT_CENTER   :: 15;
    TOP_FRONT_RIGHT    :: 16;
    TOP_BACK_LEFT      :: 17;
    TOP_BACK_CENTER    :: 18;
    TOP_BACK_RIGHT     :: 19;
    AUX_0              :: 20;
    AUX_1              :: 21;
    AUX_2              :: 22;
    AUX_3              :: 23;
    AUX_4              :: 24;
    AUX_5              :: 25;
    AUX_6              :: 26;
    AUX_7              :: 27;
    AUX_8              :: 28;
    AUX_9              :: 29;
    AUX_10             :: 30;
    AUX_11             :: 31;
    AUX_12             :: 32;
    AUX_13             :: 33;
    AUX_14             :: 34;
    AUX_15             :: 35;
    AUX_16             :: 36;
    AUX_17             :: 37;
    AUX_18             :: 38;
    AUX_19             :: 39;
    AUX_20             :: 40;
    AUX_21             :: 41;
    AUX_22             :: 42;
    AUX_23             :: 43;
    AUX_24             :: 44;
    AUX_25             :: 45;
    AUX_26             :: 46;
    AUX_27             :: 47;
    AUX_28             :: 48;
    AUX_29             :: 49;
    AUX_30             :: 50;
    AUX_31             :: 51;

    POSITION_COUNT     :: 52;

    LEFT               :: 2;
    RIGHT              :: 3;

    MA_CHANNEL_NONE               :: NONE;
    MA_CHANNEL_MONO               :: MONO;
    MA_CHANNEL_FRONT_LEFT         :: FRONT_LEFT;
    MA_CHANNEL_FRONT_RIGHT        :: FRONT_RIGHT;
    MA_CHANNEL_FRONT_CENTER       :: FRONT_CENTER;
    MA_CHANNEL_LFE                :: LFE;
    MA_CHANNEL_BACK_LEFT          :: BACK_LEFT;
    MA_CHANNEL_BACK_RIGHT         :: BACK_RIGHT;
    MA_CHANNEL_FRONT_LEFT_CENTER  :: FRONT_LEFT_CENTER;
    MA_CHANNEL_FRONT_RIGHT_CENTER :: FRONT_RIGHT_CENTER;
    MA_CHANNEL_BACK_CENTER        :: BACK_CENTER;
    MA_CHANNEL_SIDE_LEFT          :: SIDE_LEFT;
    MA_CHANNEL_SIDE_RIGHT         :: SIDE_RIGHT;
    MA_CHANNEL_TOP_CENTER         :: TOP_CENTER;
    MA_CHANNEL_TOP_FRONT_LEFT     :: TOP_FRONT_LEFT;
    MA_CHANNEL_TOP_FRONT_CENTER   :: TOP_FRONT_CENTER;
    MA_CHANNEL_TOP_FRONT_RIGHT    :: TOP_FRONT_RIGHT;
    MA_CHANNEL_TOP_BACK_LEFT      :: TOP_BACK_LEFT;
    MA_CHANNEL_TOP_BACK_CENTER    :: TOP_BACK_CENTER;
    MA_CHANNEL_TOP_BACK_RIGHT     :: TOP_BACK_RIGHT;
    MA_CHANNEL_AUX_0              :: AUX_0;
    MA_CHANNEL_AUX_1              :: AUX_1;
    MA_CHANNEL_AUX_2              :: AUX_2;
    MA_CHANNEL_AUX_3              :: AUX_3;
    MA_CHANNEL_AUX_4              :: AUX_4;
    MA_CHANNEL_AUX_5              :: AUX_5;
    MA_CHANNEL_AUX_6              :: AUX_6;
    MA_CHANNEL_AUX_7              :: AUX_7;
    MA_CHANNEL_AUX_8              :: AUX_8;
    MA_CHANNEL_AUX_9              :: AUX_9;
    MA_CHANNEL_AUX_10             :: AUX_10;
    MA_CHANNEL_AUX_11             :: AUX_11;
    MA_CHANNEL_AUX_12             :: AUX_12;
    MA_CHANNEL_AUX_13             :: AUX_13;
    MA_CHANNEL_AUX_14             :: AUX_14;
    MA_CHANNEL_AUX_15             :: AUX_15;
    MA_CHANNEL_AUX_16             :: AUX_16;
    MA_CHANNEL_AUX_17             :: AUX_17;
    MA_CHANNEL_AUX_18             :: AUX_18;
    MA_CHANNEL_AUX_19             :: AUX_19;
    MA_CHANNEL_AUX_20             :: AUX_20;
    MA_CHANNEL_AUX_21             :: AUX_21;
    MA_CHANNEL_AUX_22             :: AUX_22;
    MA_CHANNEL_AUX_23             :: AUX_23;
    MA_CHANNEL_AUX_24             :: AUX_24;
    MA_CHANNEL_AUX_25             :: AUX_25;
    MA_CHANNEL_AUX_26             :: AUX_26;
    MA_CHANNEL_AUX_27             :: AUX_27;
    MA_CHANNEL_AUX_28             :: AUX_28;
    MA_CHANNEL_AUX_29             :: AUX_29;
    MA_CHANNEL_AUX_30             :: AUX_30;
    MA_CHANNEL_AUX_31             :: AUX_31;

    MA_CHANNEL_POSITION_COUNT     :: POSITION_COUNT;

    MA_CHANNEL_LEFT               :: LEFT;
    MA_CHANNEL_RIGHT              :: RIGHT;
}

ma_result :: enum s32 {
    SUCCESS                        :: 0;
    ERROR                          :: -1;
    INVALID_ARGS                   :: -2;
    INVALID_OPERATION              :: -3;
    OUT_OF_MEMORY                  :: -4;
    OUT_OF_RANGE                   :: -5;
    ACCESS_DENIED                  :: -6;
    DOES_NOT_EXIST                 :: -7;
    ALREADY_EXISTS                 :: -8;
    TOO_MANY_OPEN_FILES            :: -9;
    INVALID_FILE                   :: -10;
    TOO_BIG                        :: -11;
    PATH_TOO_LONG                  :: -12;
    NAME_TOO_LONG                  :: -13;
    NOT_DIRECTORY                  :: -14;
    IS_DIRECTORY                   :: -15;
    DIRECTORY_NOT_EMPTY            :: -16;
    AT_END                         :: -17;
    NO_SPACE                       :: -18;
    BUSY                           :: -19;
    IO_ERROR                       :: -20;
    INTERRUPT                      :: -21;
    UNAVAILABLE                    :: -22;
    ALREADY_IN_USE                 :: -23;
    BAD_ADDRESS                    :: -24;
    BAD_SEEK                       :: -25;
    BAD_PIPE                       :: -26;
    DEADLOCK                       :: -27;
    TOO_MANY_LINKS                 :: -28;
    NOT_IMPLEMENTED                :: -29;
    NO_MESSAGE                     :: -30;
    BAD_MESSAGE                    :: -31;
    NO_DATA_AVAILABLE              :: -32;
    INVALID_DATA                   :: -33;
    TIMEOUT                        :: -34;
    NO_NETWORK                     :: -35;
    NOT_UNIQUE                     :: -36;
    NOT_SOCKET                     :: -37;
    NO_ADDRESS                     :: -38;
    BAD_PROTOCOL                   :: -39;
    PROTOCOL_UNAVAILABLE           :: -40;
    PROTOCOL_NOT_SUPPORTED         :: -41;
    PROTOCOL_FAMILY_NOT_SUPPORTED  :: -42;
    ADDRESS_FAMILY_NOT_SUPPORTED   :: -43;
    SOCKET_NOT_SUPPORTED           :: -44;
    CONNECTION_RESET               :: -45;
    ALREADY_CONNECTED              :: -46;
    NOT_CONNECTED                  :: -47;
    CONNECTION_REFUSED             :: -48;
    NO_HOST                        :: -49;
    IN_PROGRESS                    :: -50;
    CANCELLED                      :: -51;
    MEMORY_ALREADY_MAPPED          :: -52;

    CRC_MISMATCH                   :: -100;

    FORMAT_NOT_SUPPORTED           :: -200;
    DEVICE_TYPE_NOT_SUPPORTED      :: -201;
    SHARE_MODE_NOT_SUPPORTED       :: -202;
    NO_BACKEND                     :: -203;
    NO_DEVICE                      :: -204;
    API_NOT_FOUND                  :: -205;
    INVALID_DEVICE_CONFIG          :: -206;
    LOOP                           :: -207;
    BACKEND_NOT_ENABLED            :: -208;

    DEVICE_NOT_INITIALIZED         :: -300;
    DEVICE_ALREADY_INITIALIZED     :: -301;
    DEVICE_NOT_STARTED             :: -302;
    DEVICE_NOT_STOPPED             :: -303;

    FAILED_TO_INIT_BACKEND         :: -400;
    FAILED_TO_OPEN_BACKEND_DEVICE  :: -401;
    FAILED_TO_START_BACKEND_DEVICE :: -402;
    FAILED_TO_STOP_BACKEND_DEVICE  :: -403;

    MA_SUCCESS                        :: SUCCESS;
    MA_ERROR                          :: ERROR;
    MA_INVALID_ARGS                   :: INVALID_ARGS;
    MA_INVALID_OPERATION              :: INVALID_OPERATION;
    MA_OUT_OF_MEMORY                  :: OUT_OF_MEMORY;
    MA_OUT_OF_RANGE                   :: OUT_OF_RANGE;
    MA_ACCESS_DENIED                  :: ACCESS_DENIED;
    MA_DOES_NOT_EXIST                 :: DOES_NOT_EXIST;
    MA_ALREADY_EXISTS                 :: ALREADY_EXISTS;
    MA_TOO_MANY_OPEN_FILES            :: TOO_MANY_OPEN_FILES;
    MA_INVALID_FILE                   :: INVALID_FILE;
    MA_TOO_BIG                        :: TOO_BIG;
    MA_PATH_TOO_LONG                  :: PATH_TOO_LONG;
    MA_NAME_TOO_LONG                  :: NAME_TOO_LONG;
    MA_NOT_DIRECTORY                  :: NOT_DIRECTORY;
    MA_IS_DIRECTORY                   :: IS_DIRECTORY;
    MA_DIRECTORY_NOT_EMPTY            :: DIRECTORY_NOT_EMPTY;
    MA_AT_END                         :: AT_END;
    MA_NO_SPACE                       :: NO_SPACE;
    MA_BUSY                           :: BUSY;
    MA_IO_ERROR                       :: IO_ERROR;
    MA_INTERRUPT                      :: INTERRUPT;
    MA_UNAVAILABLE                    :: UNAVAILABLE;
    MA_ALREADY_IN_USE                 :: ALREADY_IN_USE;
    MA_BAD_ADDRESS                    :: BAD_ADDRESS;
    MA_BAD_SEEK                       :: BAD_SEEK;
    MA_BAD_PIPE                       :: BAD_PIPE;
    MA_DEADLOCK                       :: DEADLOCK;
    MA_TOO_MANY_LINKS                 :: TOO_MANY_LINKS;
    MA_NOT_IMPLEMENTED                :: NOT_IMPLEMENTED;
    MA_NO_MESSAGE                     :: NO_MESSAGE;
    MA_BAD_MESSAGE                    :: BAD_MESSAGE;
    MA_NO_DATA_AVAILABLE              :: NO_DATA_AVAILABLE;
    MA_INVALID_DATA                   :: INVALID_DATA;
    MA_TIMEOUT                        :: TIMEOUT;
    MA_NO_NETWORK                     :: NO_NETWORK;
    MA_NOT_UNIQUE                     :: NOT_UNIQUE;
    MA_NOT_SOCKET                     :: NOT_SOCKET;
    MA_NO_ADDRESS                     :: NO_ADDRESS;
    MA_BAD_PROTOCOL                   :: BAD_PROTOCOL;
    MA_PROTOCOL_UNAVAILABLE           :: PROTOCOL_UNAVAILABLE;
    MA_PROTOCOL_NOT_SUPPORTED         :: PROTOCOL_NOT_SUPPORTED;
    MA_PROTOCOL_FAMILY_NOT_SUPPORTED  :: PROTOCOL_FAMILY_NOT_SUPPORTED;
    MA_ADDRESS_FAMILY_NOT_SUPPORTED   :: ADDRESS_FAMILY_NOT_SUPPORTED;
    MA_SOCKET_NOT_SUPPORTED           :: SOCKET_NOT_SUPPORTED;
    MA_CONNECTION_RESET               :: CONNECTION_RESET;
    MA_ALREADY_CONNECTED              :: ALREADY_CONNECTED;
    MA_NOT_CONNECTED                  :: NOT_CONNECTED;
    MA_CONNECTION_REFUSED             :: CONNECTION_REFUSED;
    MA_NO_HOST                        :: NO_HOST;
    MA_IN_PROGRESS                    :: IN_PROGRESS;
    MA_CANCELLED                      :: CANCELLED;
    MA_MEMORY_ALREADY_MAPPED          :: MEMORY_ALREADY_MAPPED;

    MA_CRC_MISMATCH                   :: CRC_MISMATCH;

    MA_FORMAT_NOT_SUPPORTED           :: FORMAT_NOT_SUPPORTED;
    MA_DEVICE_TYPE_NOT_SUPPORTED      :: DEVICE_TYPE_NOT_SUPPORTED;
    MA_SHARE_MODE_NOT_SUPPORTED       :: SHARE_MODE_NOT_SUPPORTED;
    MA_NO_BACKEND                     :: NO_BACKEND;
    MA_NO_DEVICE                      :: NO_DEVICE;
    MA_API_NOT_FOUND                  :: API_NOT_FOUND;
    MA_INVALID_DEVICE_CONFIG          :: INVALID_DEVICE_CONFIG;
    MA_LOOP                           :: LOOP;
    MA_BACKEND_NOT_ENABLED            :: BACKEND_NOT_ENABLED;

    MA_DEVICE_NOT_INITIALIZED         :: DEVICE_NOT_INITIALIZED;
    MA_DEVICE_ALREADY_INITIALIZED     :: DEVICE_ALREADY_INITIALIZED;
    MA_DEVICE_NOT_STARTED             :: DEVICE_NOT_STARTED;
    MA_DEVICE_NOT_STOPPED             :: DEVICE_NOT_STOPPED;

    MA_FAILED_TO_INIT_BACKEND         :: FAILED_TO_INIT_BACKEND;
    MA_FAILED_TO_OPEN_BACKEND_DEVICE  :: FAILED_TO_OPEN_BACKEND_DEVICE;
    MA_FAILED_TO_START_BACKEND_DEVICE :: FAILED_TO_START_BACKEND_DEVICE;
    MA_FAILED_TO_STOP_BACKEND_DEVICE  :: FAILED_TO_STOP_BACKEND_DEVICE;
}

ma_stream_format :: enum u32 {
    pcm :: 0;
    ma_stream_format_pcm :: pcm;
}

ma_stream_layout :: enum u32 {
    interleaved   :: 0;
    deinterleaved :: 1;

    ma_stream_layout_interleaved   :: interleaved;
    ma_stream_layout_deinterleaved :: deinterleaved;
}

ma_dither_mode :: enum u32 {
    none      :: 0;
    rectangle :: 1;
    triangle  :: 2;

    ma_dither_mode_none      :: none;
    ma_dither_mode_rectangle :: rectangle;
    ma_dither_mode_triangle  :: triangle;
}

ma_format :: enum u32 {
    unknown :: 0;
    _u8     :: 1;
    _s16    :: 2;
    s24     :: 3;
    _s32    :: 4;
    f32     :: 5;
    count   :: 6;

    ma_format_unknown :: unknown;
    ma_format_u8      :: _u8;
    ma_format_s16     :: _s16;
    ma_format_s24     :: s24;
    ma_format_s32     :: _s32;
    ma_format_f32     :: f32;
    ma_format_count   :: count;
}

ma_standard_sample_rate :: enum u32 {
    _48000  :: 48000;
    _44100  :: 44100;

    _32000  :: 32000;
    _24000  :: 24000;
    _22050  :: 22050;

    _88200  :: 88200;
    _96000  :: 96000;
    _176400 :: 176400;
    _192000 :: 192000;

    _16000  :: 16000;
    _11025  :: 11025;
    _8000   :: 8000;

    _352800 :: 352800;
    _384000 :: 384000;

    min     :: 8000;
    max     :: 384000;
    count   :: 14;

    ma_standard_sample_rate_48000  :: _48000;
    ma_standard_sample_rate_44100  :: _44100;

    ma_standard_sample_rate_32000  :: _32000;
    ma_standard_sample_rate_24000  :: _24000;
    ma_standard_sample_rate_22050  :: _22050;

    ma_standard_sample_rate_88200  :: _88200;
    ma_standard_sample_rate_96000  :: _96000;
    ma_standard_sample_rate_176400 :: _176400;
    ma_standard_sample_rate_192000 :: _192000;

    ma_standard_sample_rate_16000  :: _16000;
    ma_standard_sample_rate_11025  :: _11025;
    ma_standard_sample_rate_8000   :: _8000;

    ma_standard_sample_rate_352800 :: _352800;
    ma_standard_sample_rate_384000 :: _384000;

    ma_standard_sample_rate_min    :: min;
    ma_standard_sample_rate_max    :: max;
    ma_standard_sample_rate_count  :: count;
}

ma_channel_mix_mode :: enum u32 {
    rectangular    :: 0;
    simple         :: 1;
    custom_weights :: 2;
    default        :: 0;

    ma_channel_mix_mode_rectangular    :: rectangular;
    ma_channel_mix_mode_simple         :: simple;
    ma_channel_mix_mode_custom_weights :: custom_weights;
    ma_channel_mix_mode_default        :: default;
}

ma_standard_channel_map :: enum u32 {
    microsoft :: 0;
    alsa      :: 1;
    rfc3551   :: 2;
    flac      :: 3;
    vorbis    :: 4;
    sound4    :: 5;
    sndio     :: 6;
    webaudio  :: 3;
    default   :: 0;

    ma_standard_channel_map_microsoft :: microsoft;
    ma_standard_channel_map_alsa      :: alsa;
    ma_standard_channel_map_rfc3551   :: rfc3551;
    ma_standard_channel_map_flac      :: flac;
    ma_standard_channel_map_vorbis    :: vorbis;
    ma_standard_channel_map_sound4    :: sound4;
    ma_standard_channel_map_sndio     :: sndio;
    ma_standard_channel_map_webaudio  :: webaudio;
    ma_standard_channel_map_default   :: default;
}

ma_performance_profile :: enum u32 {
    low_latency  :: 0;
    conservative :: 1;

    ma_performance_profile_low_latency  :: low_latency;
    ma_performance_profile_conservative :: conservative;
}

ma_allocation_callbacks :: struct {
    pUserData: *void;
    onMalloc:  #type (sz: u64, pUserData: *void) -> *void #c_call;
    onRealloc: #type (p: *void, sz: u64, pUserData: *void) -> *void #c_call;
    onFree:    #type (p: *void, pUserData: *void) -> void #c_call;
}

ma_lcg :: struct {
    state: ma_uint32;
}

ma_atomic_uint32 :: struct {
    value: ma_uint32;
}
ma_atomic_int32 :: struct {
    value: ma_int32;
}
ma_atomic_uint64 :: struct {
    value: ma_uint64;
}
ma_atomic_float :: struct {
    value: ma_float;
}
ma_atomic_bool32 :: struct {
    value: ma_bool32;
}

/* Spinlocks are 32-bit for compatibility reasons. */
ma_spinlock :: ma_uint32;

/* Thread priorities should be ordered such that the default priority of the worker thread is 0. */
ma_thread_priority :: enum s32 {
    idle     :: -5;
    lowest   :: -4;
    low      :: -3;
    normal   :: -2;
    high     :: -1;
    highest  :: 0;
    realtime :: 1;
    default  :: 0;

    ma_thread_priority_idle     :: idle;
    ma_thread_priority_lowest   :: lowest;
    ma_thread_priority_low      :: low;
    ma_thread_priority_normal   :: normal;
    ma_thread_priority_high     :: high;
    ma_thread_priority_highest  :: highest;
    ma_thread_priority_realtime :: realtime;
    ma_thread_priority_default  :: default;
}

ma_thread :: ma_pthread_t;

ma_mutex :: ma_pthread_mutex_t;

ma_event :: struct {
    value: ma_uint32;
    lock:  ma_pthread_mutex_t;
    cond:  ma_pthread_cond_t;
}

ma_semaphore :: struct {
    value: s32;
    lock:  ma_pthread_mutex_t;
    cond:  ma_pthread_cond_t;
}

/*
Retrieves the version of miniaudio as separated integers. Each component can be NULL if it's not required.
*/
ma_version :: (pMajor: *ma_uint32, pMinor: *ma_uint32, pRevision: *ma_uint32) -> void #foreign libminiaudio;

/*
Retrieves the version of miniaudio as a string which can be useful for logging purposes.
*/
ma_version_string :: () -> *u8 #foreign libminiaudio;

/*
The callback for handling log messages.


Parameters
----------
pUserData (in)
The user data pointer that was passed into ma_log_register_callback().

logLevel (in)
The log level. This can be one of the following:

+----------------------+
| Log Level            |
+----------------------+
| MA_LOG_LEVEL_DEBUG   |
| MA_LOG_LEVEL_INFO    |
| MA_LOG_LEVEL_WARNING |
| MA_LOG_LEVEL_ERROR   |
+----------------------+

pMessage (in)
The log message.
*/
ma_log_callback_proc :: #type (pUserData: *void, level: ma_uint32, pMessage: *u8) -> void #c_call;

ma_log_callback :: struct {
    onLog:     ma_log_callback_proc;
    pUserData: *void;
}

ma_log_callback_init :: (onLog: ma_log_callback_proc, pUserData: *void) -> ma_log_callback #foreign libminiaudio;

ma_log :: struct {
    callbacks:           [4] ma_log_callback;
    callbackCount:       ma_uint32;
    allocationCallbacks: ma_allocation_callbacks; /* Need to store these persistently because ma_log_postv() might need to allocate a buffer on the heap. */

    lock:                ma_mutex; /* For thread safety just to make it easier and safer for the logging implementation. */
}

ma_log_init :: (pAllocationCallbacks: *ma_allocation_callbacks, pLog: *ma_log) -> ma_result #foreign libminiaudio;
ma_log_uninit :: (pLog: *ma_log) -> void #foreign libminiaudio;
ma_log_register_callback :: (pLog: *ma_log, callback: ma_log_callback) -> ma_result #foreign libminiaudio;
ma_log_unregister_callback :: (pLog: *ma_log, callback: ma_log_callback) -> ma_result #foreign libminiaudio;
ma_log_post :: (pLog: *ma_log, level: ma_uint32, pMessage: *u8) -> ma_result #foreign libminiaudio;

ma_log_postf_CFormat :: (pLog: *ma_log, level: ma_uint32, pFormat: *u8, __args: ..Any) -> ma_result #foreign libminiaudio "ma_log_postf";
ma_log_postf :: (pLog: *ma_log, level: ma_uint32, pFormat: string, __args: ..Any) -> ma_result {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, pFormat, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return ma_log_postf_CFormat(pLog, level, "%s", formatted_text.data);
} @PrintLike

/**************************************************************************************************************************************************************

Biquad Filtering

**************************************************************************************************************************************************************/
ma_biquad_coefficient :: struct {
    f32: float;

    #overlay (f32) _s32: ma_int32;
}

ma_biquad_config :: struct {
    format:   ma_format;
    channels: ma_uint32;
    b0:       float64;
    b1:       float64;
    b2:       float64;
    a0:       float64;
    a1:       float64;
    a2:       float64;
}

ma_biquad_config_init :: (format: ma_format, channels: ma_uint32, b0: float64, b1: float64, b2: float64, a0: float64, a1: float64, a2: float64) -> ma_biquad_config #foreign libminiaudio;

ma_biquad :: struct {
    format:    ma_format;
    channels:  ma_uint32;
    b0:        ma_biquad_coefficient;
    b1:        ma_biquad_coefficient;
    b2:        ma_biquad_coefficient;
    a1:        ma_biquad_coefficient;
    a2:        ma_biquad_coefficient;
    pR1:       *ma_biquad_coefficient;
    pR2:       *ma_biquad_coefficient;

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_biquad_get_heap_size :: (pConfig: *ma_biquad_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_biquad_init_preallocated :: (pConfig: *ma_biquad_config, pHeap: *void, pBQ: *ma_biquad) -> ma_result #foreign libminiaudio;
ma_biquad_init :: (pConfig: *ma_biquad_config, pAllocationCallbacks: *ma_allocation_callbacks, pBQ: *ma_biquad) -> ma_result #foreign libminiaudio;
ma_biquad_uninit :: (pBQ: *ma_biquad, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_biquad_reinit :: (pConfig: *ma_biquad_config, pBQ: *ma_biquad) -> ma_result #foreign libminiaudio;
ma_biquad_clear_cache :: (pBQ: *ma_biquad) -> ma_result #foreign libminiaudio;
ma_biquad_process_pcm_frames :: (pBQ: *ma_biquad, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_biquad_get_latency :: (pBQ: *ma_biquad) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

Low-Pass Filtering

**************************************************************************************************************************************************************/
ma_lpf1_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    q:               float64;
}

/**************************************************************************************************************************************************************

Low-Pass Filtering

**************************************************************************************************************************************************************/
ma_lpf2_config :: ma_lpf1_config;

ma_lpf1_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64) -> ma_lpf1_config #foreign libminiaudio;
ma_lpf2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, q: float64) -> ma_lpf2_config #foreign libminiaudio;

ma_lpf1 :: struct {
    format:    ma_format;
    channels:  ma_uint32;
    a:         ma_biquad_coefficient;
    pR1:       *ma_biquad_coefficient;

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_lpf1_get_heap_size :: (pConfig: *ma_lpf1_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_lpf1_init_preallocated :: (pConfig: *ma_lpf1_config, pHeap: *void, pLPF: *ma_lpf1) -> ma_result #foreign libminiaudio;
ma_lpf1_init :: (pConfig: *ma_lpf1_config, pAllocationCallbacks: *ma_allocation_callbacks, pLPF: *ma_lpf1) -> ma_result #foreign libminiaudio;
ma_lpf1_uninit :: (pLPF: *ma_lpf1, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_lpf1_reinit :: (pConfig: *ma_lpf1_config, pLPF: *ma_lpf1) -> ma_result #foreign libminiaudio;
ma_lpf1_clear_cache :: (pLPF: *ma_lpf1) -> ma_result #foreign libminiaudio;
ma_lpf1_process_pcm_frames :: (pLPF: *ma_lpf1, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_lpf1_get_latency :: (pLPF: *ma_lpf1) -> ma_uint32 #foreign libminiaudio;

ma_lpf2 :: struct {
    bq: ma_biquad; /* The second order low-pass filter is implemented as a biquad filter. */
}

ma_lpf2_get_heap_size :: (pConfig: *ma_lpf2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_lpf2_init_preallocated :: (pConfig: *ma_lpf2_config, pHeap: *void, pHPF: *ma_lpf2) -> ma_result #foreign libminiaudio;
ma_lpf2_init :: (pConfig: *ma_lpf2_config, pAllocationCallbacks: *ma_allocation_callbacks, pLPF: *ma_lpf2) -> ma_result #foreign libminiaudio;
ma_lpf2_uninit :: (pLPF: *ma_lpf2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_lpf2_reinit :: (pConfig: *ma_lpf2_config, pLPF: *ma_lpf2) -> ma_result #foreign libminiaudio;
ma_lpf2_clear_cache :: (pLPF: *ma_lpf2) -> ma_result #foreign libminiaudio;
ma_lpf2_process_pcm_frames :: (pLPF: *ma_lpf2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_lpf2_get_latency :: (pLPF: *ma_lpf2) -> ma_uint32 #foreign libminiaudio;

ma_lpf_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    order:           ma_uint32; /* If set to 0, will be treated as a passthrough (no filtering will be applied). */
}

ma_lpf_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_lpf_config #foreign libminiaudio;

ma_lpf :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    lpf1Count:  ma_uint32;
    lpf2Count:  ma_uint32;
    pLPF1:      *ma_lpf1;
    pLPF2:      *ma_lpf2;

    /* Memory management. */
    _pHeap:     *void;
    _ownsHeap:  ma_bool32;
}

ma_lpf_get_heap_size :: (pConfig: *ma_lpf_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_lpf_init_preallocated :: (pConfig: *ma_lpf_config, pHeap: *void, pLPF: *ma_lpf) -> ma_result #foreign libminiaudio;
ma_lpf_init :: (pConfig: *ma_lpf_config, pAllocationCallbacks: *ma_allocation_callbacks, pLPF: *ma_lpf) -> ma_result #foreign libminiaudio;
ma_lpf_uninit :: (pLPF: *ma_lpf, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_lpf_reinit :: (pConfig: *ma_lpf_config, pLPF: *ma_lpf) -> ma_result #foreign libminiaudio;
ma_lpf_clear_cache :: (pLPF: *ma_lpf) -> ma_result #foreign libminiaudio;
ma_lpf_process_pcm_frames :: (pLPF: *ma_lpf, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_lpf_get_latency :: (pLPF: *ma_lpf) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

High-Pass Filtering

**************************************************************************************************************************************************************/
ma_hpf1_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    q:               float64;
}

/**************************************************************************************************************************************************************

High-Pass Filtering

**************************************************************************************************************************************************************/
ma_hpf2_config :: ma_hpf1_config;

ma_hpf1_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64) -> ma_hpf1_config #foreign libminiaudio;
ma_hpf2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, q: float64) -> ma_hpf2_config #foreign libminiaudio;

ma_hpf1 :: struct {
    format:    ma_format;
    channels:  ma_uint32;
    a:         ma_biquad_coefficient;
    pR1:       *ma_biquad_coefficient;

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_hpf1_get_heap_size :: (pConfig: *ma_hpf1_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_hpf1_init_preallocated :: (pConfig: *ma_hpf1_config, pHeap: *void, pLPF: *ma_hpf1) -> ma_result #foreign libminiaudio;
ma_hpf1_init :: (pConfig: *ma_hpf1_config, pAllocationCallbacks: *ma_allocation_callbacks, pHPF: *ma_hpf1) -> ma_result #foreign libminiaudio;
ma_hpf1_uninit :: (pHPF: *ma_hpf1, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_hpf1_reinit :: (pConfig: *ma_hpf1_config, pHPF: *ma_hpf1) -> ma_result #foreign libminiaudio;
ma_hpf1_process_pcm_frames :: (pHPF: *ma_hpf1, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_hpf1_get_latency :: (pHPF: *ma_hpf1) -> ma_uint32 #foreign libminiaudio;

ma_hpf2 :: struct {
    bq: ma_biquad; /* The second order high-pass filter is implemented as a biquad filter. */
}

ma_hpf2_get_heap_size :: (pConfig: *ma_hpf2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_hpf2_init_preallocated :: (pConfig: *ma_hpf2_config, pHeap: *void, pHPF: *ma_hpf2) -> ma_result #foreign libminiaudio;
ma_hpf2_init :: (pConfig: *ma_hpf2_config, pAllocationCallbacks: *ma_allocation_callbacks, pHPF: *ma_hpf2) -> ma_result #foreign libminiaudio;
ma_hpf2_uninit :: (pHPF: *ma_hpf2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_hpf2_reinit :: (pConfig: *ma_hpf2_config, pHPF: *ma_hpf2) -> ma_result #foreign libminiaudio;
ma_hpf2_process_pcm_frames :: (pHPF: *ma_hpf2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_hpf2_get_latency :: (pHPF: *ma_hpf2) -> ma_uint32 #foreign libminiaudio;

ma_hpf_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    order:           ma_uint32; /* If set to 0, will be treated as a passthrough (no filtering will be applied). */
}

ma_hpf_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_hpf_config #foreign libminiaudio;

ma_hpf :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    hpf1Count:  ma_uint32;
    hpf2Count:  ma_uint32;
    pHPF1:      *ma_hpf1;
    pHPF2:      *ma_hpf2;

    /* Memory management. */
    _pHeap:     *void;
    _ownsHeap:  ma_bool32;
}

ma_hpf_get_heap_size :: (pConfig: *ma_hpf_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_hpf_init_preallocated :: (pConfig: *ma_hpf_config, pHeap: *void, pLPF: *ma_hpf) -> ma_result #foreign libminiaudio;
ma_hpf_init :: (pConfig: *ma_hpf_config, pAllocationCallbacks: *ma_allocation_callbacks, pHPF: *ma_hpf) -> ma_result #foreign libminiaudio;
ma_hpf_uninit :: (pHPF: *ma_hpf, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_hpf_reinit :: (pConfig: *ma_hpf_config, pHPF: *ma_hpf) -> ma_result #foreign libminiaudio;
ma_hpf_process_pcm_frames :: (pHPF: *ma_hpf, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_hpf_get_latency :: (pHPF: *ma_hpf) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

Band-Pass Filtering

**************************************************************************************************************************************************************/
ma_bpf2_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    q:               float64;
}

ma_bpf2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, q: float64) -> ma_bpf2_config #foreign libminiaudio;

ma_bpf2 :: struct {
    bq: ma_biquad; /* The second order band-pass filter is implemented as a biquad filter. */
}

ma_bpf2_get_heap_size :: (pConfig: *ma_bpf2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_bpf2_init_preallocated :: (pConfig: *ma_bpf2_config, pHeap: *void, pBPF: *ma_bpf2) -> ma_result #foreign libminiaudio;
ma_bpf2_init :: (pConfig: *ma_bpf2_config, pAllocationCallbacks: *ma_allocation_callbacks, pBPF: *ma_bpf2) -> ma_result #foreign libminiaudio;
ma_bpf2_uninit :: (pBPF: *ma_bpf2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_bpf2_reinit :: (pConfig: *ma_bpf2_config, pBPF: *ma_bpf2) -> ma_result #foreign libminiaudio;
ma_bpf2_process_pcm_frames :: (pBPF: *ma_bpf2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_bpf2_get_latency :: (pBPF: *ma_bpf2) -> ma_uint32 #foreign libminiaudio;

ma_bpf_config :: struct {
    format:          ma_format;
    channels:        ma_uint32;
    sampleRate:      ma_uint32;
    cutoffFrequency: float64;
    order:           ma_uint32; /* If set to 0, will be treated as a passthrough (no filtering will be applied). */
}

ma_bpf_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_bpf_config #foreign libminiaudio;

ma_bpf :: struct {
    format:    ma_format;
    channels:  ma_uint32;
    bpf2Count: ma_uint32;
    pBPF2:     *ma_bpf2;

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_bpf_get_heap_size :: (pConfig: *ma_bpf_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_bpf_init_preallocated :: (pConfig: *ma_bpf_config, pHeap: *void, pBPF: *ma_bpf) -> ma_result #foreign libminiaudio;
ma_bpf_init :: (pConfig: *ma_bpf_config, pAllocationCallbacks: *ma_allocation_callbacks, pBPF: *ma_bpf) -> ma_result #foreign libminiaudio;
ma_bpf_uninit :: (pBPF: *ma_bpf, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_bpf_reinit :: (pConfig: *ma_bpf_config, pBPF: *ma_bpf) -> ma_result #foreign libminiaudio;
ma_bpf_process_pcm_frames :: (pBPF: *ma_bpf, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_bpf_get_latency :: (pBPF: *ma_bpf) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

Notching Filter

**************************************************************************************************************************************************************/
ma_notch2_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    q:          float64;
    frequency:  float64;
}

/**************************************************************************************************************************************************************

Notching Filter

**************************************************************************************************************************************************************/
ma_notch_config :: ma_notch2_config;

ma_notch2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, q: float64, frequency: float64) -> ma_notch2_config #foreign libminiaudio;

ma_notch2 :: struct {
    bq: ma_biquad;
}

ma_notch2_get_heap_size :: (pConfig: *ma_notch2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_notch2_init_preallocated :: (pConfig: *ma_notch2_config, pHeap: *void, pFilter: *ma_notch2) -> ma_result #foreign libminiaudio;
ma_notch2_init :: (pConfig: *ma_notch2_config, pAllocationCallbacks: *ma_allocation_callbacks, pFilter: *ma_notch2) -> ma_result #foreign libminiaudio;
ma_notch2_uninit :: (pFilter: *ma_notch2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_notch2_reinit :: (pConfig: *ma_notch2_config, pFilter: *ma_notch2) -> ma_result #foreign libminiaudio;
ma_notch2_process_pcm_frames :: (pFilter: *ma_notch2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_notch2_get_latency :: (pFilter: *ma_notch2) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

Peaking EQ Filter

**************************************************************************************************************************************************************/
ma_peak2_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    gainDB:     float64;
    q:          float64;
    frequency:  float64;
}

/**************************************************************************************************************************************************************

Peaking EQ Filter

**************************************************************************************************************************************************************/
ma_peak_config :: ma_peak2_config;

ma_peak2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, q: float64, frequency: float64) -> ma_peak2_config #foreign libminiaudio;

ma_peak2 :: struct {
    bq: ma_biquad;
}

ma_peak2_get_heap_size :: (pConfig: *ma_peak2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_peak2_init_preallocated :: (pConfig: *ma_peak2_config, pHeap: *void, pFilter: *ma_peak2) -> ma_result #foreign libminiaudio;
ma_peak2_init :: (pConfig: *ma_peak2_config, pAllocationCallbacks: *ma_allocation_callbacks, pFilter: *ma_peak2) -> ma_result #foreign libminiaudio;
ma_peak2_uninit :: (pFilter: *ma_peak2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_peak2_reinit :: (pConfig: *ma_peak2_config, pFilter: *ma_peak2) -> ma_result #foreign libminiaudio;
ma_peak2_process_pcm_frames :: (pFilter: *ma_peak2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_peak2_get_latency :: (pFilter: *ma_peak2) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

Low Shelf Filter

**************************************************************************************************************************************************************/
ma_loshelf2_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    gainDB:     float64;
    shelfSlope: float64;
    frequency:  float64;
}

/**************************************************************************************************************************************************************

Low Shelf Filter

**************************************************************************************************************************************************************/
ma_loshelf_config :: ma_loshelf2_config;

ma_loshelf2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, shelfSlope: float64, frequency: float64) -> ma_loshelf2_config #foreign libminiaudio;

ma_loshelf2 :: struct {
    bq: ma_biquad;
}

ma_loshelf2_get_heap_size :: (pConfig: *ma_loshelf2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_loshelf2_init_preallocated :: (pConfig: *ma_loshelf2_config, pHeap: *void, pFilter: *ma_loshelf2) -> ma_result #foreign libminiaudio;
ma_loshelf2_init :: (pConfig: *ma_loshelf2_config, pAllocationCallbacks: *ma_allocation_callbacks, pFilter: *ma_loshelf2) -> ma_result #foreign libminiaudio;
ma_loshelf2_uninit :: (pFilter: *ma_loshelf2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_loshelf2_reinit :: (pConfig: *ma_loshelf2_config, pFilter: *ma_loshelf2) -> ma_result #foreign libminiaudio;
ma_loshelf2_process_pcm_frames :: (pFilter: *ma_loshelf2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_loshelf2_get_latency :: (pFilter: *ma_loshelf2) -> ma_uint32 #foreign libminiaudio;

/**************************************************************************************************************************************************************

High Shelf Filter

**************************************************************************************************************************************************************/
ma_hishelf2_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    gainDB:     float64;
    shelfSlope: float64;
    frequency:  float64;
}

/**************************************************************************************************************************************************************

High Shelf Filter

**************************************************************************************************************************************************************/
ma_hishelf_config :: ma_hishelf2_config;

ma_hishelf2_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, shelfSlope: float64, frequency: float64) -> ma_hishelf2_config #foreign libminiaudio;

ma_hishelf2 :: struct {
    bq: ma_biquad;
}

ma_hishelf2_get_heap_size :: (pConfig: *ma_hishelf2_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_hishelf2_init_preallocated :: (pConfig: *ma_hishelf2_config, pHeap: *void, pFilter: *ma_hishelf2) -> ma_result #foreign libminiaudio;
ma_hishelf2_init :: (pConfig: *ma_hishelf2_config, pAllocationCallbacks: *ma_allocation_callbacks, pFilter: *ma_hishelf2) -> ma_result #foreign libminiaudio;
ma_hishelf2_uninit :: (pFilter: *ma_hishelf2, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_hishelf2_reinit :: (pConfig: *ma_hishelf2_config, pFilter: *ma_hishelf2) -> ma_result #foreign libminiaudio;
ma_hishelf2_process_pcm_frames :: (pFilter: *ma_hishelf2, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_hishelf2_get_latency :: (pFilter: *ma_hishelf2) -> ma_uint32 #foreign libminiaudio;

/*
Delay
*/
ma_delay_config :: struct {
    channels:      ma_uint32;
    sampleRate:    ma_uint32;
    delayInFrames: ma_uint32;
    delayStart:    ma_bool32; /* Set to true to delay the start of the output; false otherwise. */
    wet:           float; /* 0..1. Default = 1. */
    dry:           float; /* 0..1. Default = 1. */
    decay:         float; /* 0..1. Default = 0 (no feedback). Feedback decay. Use this for echo. */
}

ma_delay_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, delayInFrames: ma_uint32, decay: float) -> ma_delay_config #foreign libminiaudio;

ma_delay :: struct {
    config:             ma_delay_config;
    cursor:             ma_uint32; /* Feedback is written to this cursor. Always equal or in front of the read cursor. */
    bufferSizeInFrames: ma_uint32;
    pBuffer:            *float;
}

ma_delay_init :: (pConfig: *ma_delay_config, pAllocationCallbacks: *ma_allocation_callbacks, pDelay: *ma_delay) -> ma_result #foreign libminiaudio;
ma_delay_uninit :: (pDelay: *ma_delay, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_delay_process_pcm_frames :: (pDelay: *ma_delay, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint32) -> ma_result #foreign libminiaudio;
ma_delay_set_wet :: (pDelay: *ma_delay, value: float) -> void #foreign libminiaudio;
ma_delay_get_wet :: (pDelay: *ma_delay) -> float #foreign libminiaudio;
ma_delay_set_dry :: (pDelay: *ma_delay, value: float) -> void #foreign libminiaudio;
ma_delay_get_dry :: (pDelay: *ma_delay) -> float #foreign libminiaudio;
ma_delay_set_decay :: (pDelay: *ma_delay, value: float) -> void #foreign libminiaudio;
ma_delay_get_decay :: (pDelay: *ma_delay) -> float #foreign libminiaudio;

/* Gainer for smooth volume changes. */
ma_gainer_config :: struct {
    channels:           ma_uint32;
    smoothTimeInFrames: ma_uint32;
}

ma_gainer_config_init :: (channels: ma_uint32, smoothTimeInFrames: ma_uint32) -> ma_gainer_config #foreign libminiaudio;

ma_gainer :: struct {
    config:       ma_gainer_config;
    t:            ma_uint32;
    masterVolume: float;
    pOldGains:    *float;
    pNewGains:    *float;

    /* Memory management. */
    _pHeap:       *void;
    _ownsHeap:    ma_bool32;
}

ma_gainer_get_heap_size :: (pConfig: *ma_gainer_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_gainer_init_preallocated :: (pConfig: *ma_gainer_config, pHeap: *void, pGainer: *ma_gainer) -> ma_result #foreign libminiaudio;
ma_gainer_init :: (pConfig: *ma_gainer_config, pAllocationCallbacks: *ma_allocation_callbacks, pGainer: *ma_gainer) -> ma_result #foreign libminiaudio;
ma_gainer_uninit :: (pGainer: *ma_gainer, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_gainer_process_pcm_frames :: (pGainer: *ma_gainer, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_gainer_set_gain :: (pGainer: *ma_gainer, newGain: float) -> ma_result #foreign libminiaudio;
ma_gainer_set_gains :: (pGainer: *ma_gainer, pNewGains: *float) -> ma_result #foreign libminiaudio;
ma_gainer_set_master_volume :: (pGainer: *ma_gainer, volume: float) -> ma_result #foreign libminiaudio;
ma_gainer_get_master_volume :: (pGainer: *ma_gainer, pVolume: *float) -> ma_result #foreign libminiaudio;

/* Stereo panner. */
ma_pan_mode :: enum u32 {
    balance :: 0;
    pan     :: 1;

    ma_pan_mode_balance :: balance;
    ma_pan_mode_pan     :: pan;
}

ma_panner_config :: struct {
    format:   ma_format;
    channels: ma_uint32;
    mode:     ma_pan_mode;
    pan:      float;
}

ma_panner_config_init :: (format: ma_format, channels: ma_uint32) -> ma_panner_config #foreign libminiaudio;

ma_panner :: struct {
    format:   ma_format;
    channels: ma_uint32;
    mode:     ma_pan_mode;
    pan:      float; /* -1..1 where 0 is no pan, -1 is left side, +1 is right side. Defaults to 0. */
}

ma_panner_init :: (pConfig: *ma_panner_config, pPanner: *ma_panner) -> ma_result #foreign libminiaudio;
ma_panner_process_pcm_frames :: (pPanner: *ma_panner, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_panner_set_mode :: (pPanner: *ma_panner, mode: ma_pan_mode) -> void #foreign libminiaudio;
ma_panner_get_mode :: (pPanner: *ma_panner) -> ma_pan_mode #foreign libminiaudio;
ma_panner_set_pan :: (pPanner: *ma_panner, pan: float) -> void #foreign libminiaudio;
ma_panner_get_pan :: (pPanner: *ma_panner) -> float #foreign libminiaudio;

/* Fader. */
ma_fader_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
}

ma_fader_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32) -> ma_fader_config #foreign libminiaudio;

ma_fader :: struct {
    config:         ma_fader_config;
    volumeBeg:      float; /* If volumeBeg and volumeEnd is equal to 1, no fading happens (ma_fader_process_pcm_frames() will run as a passthrough). */
    volumeEnd:      float;
    lengthInFrames: ma_uint64; /* The total length of the fade. */
    cursorInFrames: ma_int64; /* The current time in frames. Incremented by ma_fader_process_pcm_frames(). Signed because it'll be offset by startOffsetInFrames in set_fade_ex(). */
}

ma_fader_init :: (pConfig: *ma_fader_config, pFader: *ma_fader) -> ma_result #foreign libminiaudio;
ma_fader_process_pcm_frames :: (pFader: *ma_fader, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_fader_get_data_format :: (pFader: *ma_fader, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32) -> void #foreign libminiaudio;
ma_fader_set_fade :: (pFader: *ma_fader, volumeBeg: float, volumeEnd: float, lengthInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_fader_set_fade_ex :: (pFader: *ma_fader, volumeBeg: float, volumeEnd: float, lengthInFrames: ma_uint64, startOffsetInFrames: ma_int64) -> void #foreign libminiaudio;
ma_fader_get_current_volume :: (pFader: *ma_fader) -> float #foreign libminiaudio;

/* Spatializer. */
ma_vec3f :: struct {
    x: float;
    y: float;
    z: float;
}

ma_atomic_vec3f :: struct {
    v:    ma_vec3f;
    lock: ma_spinlock;
}

ma_attenuation_model :: enum u32 {
    none        :: 0;
    inverse     :: 1;
    linear      :: 2;
    exponential :: 3;

    ma_attenuation_model_none        :: none;
    ma_attenuation_model_inverse     :: inverse;
    ma_attenuation_model_linear      :: linear;
    ma_attenuation_model_exponential :: exponential;
}

ma_positioning :: enum u32 {
    absolute :: 0;
    relative :: 1;

    ma_positioning_absolute :: absolute;
    ma_positioning_relative :: relative;
}

ma_handedness :: enum u32 {
    right :: 0;
    left  :: 1;

    ma_handedness_right :: right;
    ma_handedness_left  :: left;
}

ma_spatializer_listener_config :: struct {
    channelsOut:             ma_uint32;
    pChannelMapOut:          *ma_channel;
    handedness:              ma_handedness; /* Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis. */
    coneInnerAngleInRadians: float;
    coneOuterAngleInRadians: float;
    coneOuterGain:           float;
    speedOfSound:            float;
    worldUp:                 ma_vec3f;
}

ma_spatializer_listener_config_init :: (channelsOut: ma_uint32) -> ma_spatializer_listener_config #foreign libminiaudio;

ma_spatializer_listener :: struct {
    config:    ma_spatializer_listener_config;
    position:  ma_atomic_vec3f; /* The absolute position of the listener. */
    direction: ma_atomic_vec3f; /* The direction the listener is facing. The world up vector is config.worldUp. */
    velocity:  ma_atomic_vec3f;
    isEnabled: ma_bool32;

    /* Memory management. */
    _ownsHeap: ma_bool32;
    _pHeap:    *void;
}

ma_spatializer_listener_get_heap_size :: (pConfig: *ma_spatializer_listener_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_spatializer_listener_init_preallocated :: (pConfig: *ma_spatializer_listener_config, pHeap: *void, pListener: *ma_spatializer_listener) -> ma_result #foreign libminiaudio;
ma_spatializer_listener_init :: (pConfig: *ma_spatializer_listener_config, pAllocationCallbacks: *ma_allocation_callbacks, pListener: *ma_spatializer_listener) -> ma_result #foreign libminiaudio;
ma_spatializer_listener_uninit :: (pListener: *ma_spatializer_listener, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_spatializer_listener_get_channel_map :: (pListener: *ma_spatializer_listener) -> *ma_channel #foreign libminiaudio;
ma_spatializer_listener_set_cone :: (pListener: *ma_spatializer_listener, innerAngleInRadians: float, outerAngleInRadians: float, outerGain: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_cone :: (pListener: *ma_spatializer_listener, pInnerAngleInRadians: *float, pOuterAngleInRadians: *float, pOuterGain: *float) -> void #foreign libminiaudio;
ma_spatializer_listener_set_position :: (pListener: *ma_spatializer_listener, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_position :: (pListener: *ma_spatializer_listener) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_listener_set_direction :: (pListener: *ma_spatializer_listener, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_direction :: (pListener: *ma_spatializer_listener) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_listener_set_velocity :: (pListener: *ma_spatializer_listener, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_velocity :: (pListener: *ma_spatializer_listener) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_listener_set_speed_of_sound :: (pListener: *ma_spatializer_listener, speedOfSound: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_speed_of_sound :: (pListener: *ma_spatializer_listener) -> float #foreign libminiaudio;
ma_spatializer_listener_set_world_up :: (pListener: *ma_spatializer_listener, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_listener_get_world_up :: (pListener: *ma_spatializer_listener) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_listener_set_enabled :: (pListener: *ma_spatializer_listener, isEnabled: ma_bool32) -> void #foreign libminiaudio;
ma_spatializer_listener_is_enabled :: (pListener: *ma_spatializer_listener) -> ma_bool32 #foreign libminiaudio;

ma_spatializer_config :: struct {
    channelsIn:                   ma_uint32;
    channelsOut:                  ma_uint32;
    pChannelMapIn:                *ma_channel;
    attenuationModel:             ma_attenuation_model;
    positioning:                  ma_positioning;
    handedness:                   ma_handedness; /* Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis. */
    minGain:                      float;
    maxGain:                      float;
    minDistance:                  float;
    maxDistance:                  float;
    rolloff:                      float;
    coneInnerAngleInRadians:      float;
    coneOuterAngleInRadians:      float;
    coneOuterGain:                float;
    dopplerFactor:                float; /* Set to 0 to disable doppler effect. */
    directionalAttenuationFactor: float; /* Set to 0 to disable directional attenuation. */
    minSpatializationChannelGain: float; /* The minimal scaling factor to apply to channel gains when accounting for the direction of the sound relative to the listener. Must be in the range of 0..1. Smaller values means more aggressive directional panning, larger values means more subtle directional panning. */
    gainSmoothTimeInFrames:       ma_uint32; /* When the gain of a channel changes during spatialization, the transition will be linearly interpolated over this number of frames. */
}

ma_spatializer_config_init :: (channelsIn: ma_uint32, channelsOut: ma_uint32) -> ma_spatializer_config #foreign libminiaudio;

ma_spatializer :: struct {
    channelsIn:                   ma_uint32;
    channelsOut:                  ma_uint32;
    pChannelMapIn:                *ma_channel;
    attenuationModel:             ma_attenuation_model;
    positioning:                  ma_positioning;
    handedness:                   ma_handedness; /* Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis. */
    minGain:                      float;
    maxGain:                      float;
    minDistance:                  float;
    maxDistance:                  float;
    rolloff:                      float;
    coneInnerAngleInRadians:      float;
    coneOuterAngleInRadians:      float;
    coneOuterGain:                float;
    dopplerFactor:                float; /* Set to 0 to disable doppler effect. */
    directionalAttenuationFactor: float; /* Set to 0 to disable directional attenuation. */
    gainSmoothTimeInFrames:       ma_uint32; /* When the gain of a channel changes during spatialization, the transition will be linearly interpolated over this number of frames. */
    position:                     ma_atomic_vec3f;
    direction:                    ma_atomic_vec3f;
    velocity:                     ma_atomic_vec3f; /* For doppler effect. */
    dopplerPitch:                 float; /* Will be updated by ma_spatializer_process_pcm_frames() and can be used by higher level functions to apply a pitch shift for doppler effect. */
    minSpatializationChannelGain: float;
    gainer:                       ma_gainer; /* For smooth gain transitions. */
    pNewChannelGainsOut:          *float; /* An offset of _pHeap. Used by ma_spatializer_process_pcm_frames() to store new channel gains. The number of elements in this array is equal to config.channelsOut. */

    /* Memory management. */
    _pHeap:                       *void;
    _ownsHeap:                    ma_bool32;
}

ma_spatializer_get_heap_size :: (pConfig: *ma_spatializer_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_spatializer_init_preallocated :: (pConfig: *ma_spatializer_config, pHeap: *void, pSpatializer: *ma_spatializer) -> ma_result #foreign libminiaudio;
ma_spatializer_init :: (pConfig: *ma_spatializer_config, pAllocationCallbacks: *ma_allocation_callbacks, pSpatializer: *ma_spatializer) -> ma_result #foreign libminiaudio;
ma_spatializer_uninit :: (pSpatializer: *ma_spatializer, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_spatializer_process_pcm_frames :: (pSpatializer: *ma_spatializer, pListener: *ma_spatializer_listener, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_spatializer_set_master_volume :: (pSpatializer: *ma_spatializer, volume: float) -> ma_result #foreign libminiaudio;
ma_spatializer_get_master_volume :: (pSpatializer: *ma_spatializer, pVolume: *float) -> ma_result #foreign libminiaudio;
ma_spatializer_get_input_channels :: (pSpatializer: *ma_spatializer) -> ma_uint32 #foreign libminiaudio;
ma_spatializer_get_output_channels :: (pSpatializer: *ma_spatializer) -> ma_uint32 #foreign libminiaudio;
ma_spatializer_set_attenuation_model :: (pSpatializer: *ma_spatializer, attenuationModel: ma_attenuation_model) -> void #foreign libminiaudio;
ma_spatializer_get_attenuation_model :: (pSpatializer: *ma_spatializer) -> ma_attenuation_model #foreign libminiaudio;
ma_spatializer_set_positioning :: (pSpatializer: *ma_spatializer, positioning: ma_positioning) -> void #foreign libminiaudio;
ma_spatializer_get_positioning :: (pSpatializer: *ma_spatializer) -> ma_positioning #foreign libminiaudio;
ma_spatializer_set_rolloff :: (pSpatializer: *ma_spatializer, rolloff: float) -> void #foreign libminiaudio;
ma_spatializer_get_rolloff :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_min_gain :: (pSpatializer: *ma_spatializer, minGain: float) -> void #foreign libminiaudio;
ma_spatializer_get_min_gain :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_max_gain :: (pSpatializer: *ma_spatializer, maxGain: float) -> void #foreign libminiaudio;
ma_spatializer_get_max_gain :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_min_distance :: (pSpatializer: *ma_spatializer, minDistance: float) -> void #foreign libminiaudio;
ma_spatializer_get_min_distance :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_max_distance :: (pSpatializer: *ma_spatializer, maxDistance: float) -> void #foreign libminiaudio;
ma_spatializer_get_max_distance :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_cone :: (pSpatializer: *ma_spatializer, innerAngleInRadians: float, outerAngleInRadians: float, outerGain: float) -> void #foreign libminiaudio;
ma_spatializer_get_cone :: (pSpatializer: *ma_spatializer, pInnerAngleInRadians: *float, pOuterAngleInRadians: *float, pOuterGain: *float) -> void #foreign libminiaudio;
ma_spatializer_set_doppler_factor :: (pSpatializer: *ma_spatializer, dopplerFactor: float) -> void #foreign libminiaudio;
ma_spatializer_get_doppler_factor :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_directional_attenuation_factor :: (pSpatializer: *ma_spatializer, directionalAttenuationFactor: float) -> void #foreign libminiaudio;
ma_spatializer_get_directional_attenuation_factor :: (pSpatializer: *ma_spatializer) -> float #foreign libminiaudio;
ma_spatializer_set_position :: (pSpatializer: *ma_spatializer, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_get_position :: (pSpatializer: *ma_spatializer) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_set_direction :: (pSpatializer: *ma_spatializer, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_get_direction :: (pSpatializer: *ma_spatializer) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_set_velocity :: (pSpatializer: *ma_spatializer, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_spatializer_get_velocity :: (pSpatializer: *ma_spatializer) -> ma_vec3f #foreign libminiaudio;
ma_spatializer_get_relative_position_and_direction :: (pSpatializer: *ma_spatializer, pListener: *ma_spatializer_listener, pRelativePos: *ma_vec3f, pRelativeDir: *ma_vec3f) -> void #foreign libminiaudio;

/**************************************************************************************************************************************************************

Resampling

**************************************************************************************************************************************************************/
ma_linear_resampler_config :: struct {
    format:           ma_format;
    channels:         ma_uint32;
    sampleRateIn:     ma_uint32;
    sampleRateOut:    ma_uint32;
    lpfOrder:         ma_uint32; /* The low-pass filter order. Setting this to 0 will disable low-pass filtering. */
    lpfNyquistFactor: float64; /* 0..1. Defaults to 1. 1 = Half the sampling frequency (Nyquist Frequency), 0.5 = Quarter the sampling frequency (half Nyquest Frequency), etc. */
}

ma_linear_resampler_config_init :: (format: ma_format, channels: ma_uint32, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_linear_resampler_config #foreign libminiaudio;

ma_linear_resampler :: struct {
    config:        ma_linear_resampler_config;
    inAdvanceInt:  ma_uint32;
    inAdvanceFrac: ma_uint32;
    inTimeInt:     ma_uint32;
    inTimeFrac:    ma_uint32;
    x0:            struct {
        f32: *float;

        #overlay (f32) _s16: *ma_int16;
    }; /* The previous input frame. */

    x1:            struct {
        f32: *float;

        #overlay (f32) _s16: *ma_int16;
    }; /* The next input frame. */

    lpf:           ma_lpf;

    /* Memory management. */
    _pHeap:        *void;
    _ownsHeap:     ma_bool32;
}

ma_linear_resampler_get_heap_size :: (pConfig: *ma_linear_resampler_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_linear_resampler_init_preallocated :: (pConfig: *ma_linear_resampler_config, pHeap: *void, pResampler: *ma_linear_resampler) -> ma_result #foreign libminiaudio;
ma_linear_resampler_init :: (pConfig: *ma_linear_resampler_config, pAllocationCallbacks: *ma_allocation_callbacks, pResampler: *ma_linear_resampler) -> ma_result #foreign libminiaudio;
ma_linear_resampler_uninit :: (pResampler: *ma_linear_resampler, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_linear_resampler_process_pcm_frames :: (pResampler: *ma_linear_resampler, pFramesIn: *void, pFrameCountIn: *ma_uint64, pFramesOut: *void, pFrameCountOut: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_linear_resampler_set_rate :: (pResampler: *ma_linear_resampler, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_result #foreign libminiaudio;
ma_linear_resampler_set_rate_ratio :: (pResampler: *ma_linear_resampler, ratioInOut: float) -> ma_result #foreign libminiaudio;
ma_linear_resampler_get_input_latency :: (pResampler: *ma_linear_resampler) -> ma_uint64 #foreign libminiaudio;
ma_linear_resampler_get_output_latency :: (pResampler: *ma_linear_resampler) -> ma_uint64 #foreign libminiaudio;
ma_linear_resampler_get_required_input_frame_count :: (pResampler: *ma_linear_resampler, outputFrameCount: ma_uint64, pInputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_linear_resampler_get_expected_output_frame_count :: (pResampler: *ma_linear_resampler, inputFrameCount: ma_uint64, pOutputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_linear_resampler_reset :: (pResampler: *ma_linear_resampler) -> ma_result #foreign libminiaudio;

ma_resampling_backend :: void;
ma_resampling_backend_vtable :: struct {
    onGetHeapSize:                 #type (pUserData: *void, pConfig: *ma_resampler_config, pHeapSizeInBytes: *u64) -> ma_result #c_call;
    onInit:                        #type (pUserData: *void, pConfig: *ma_resampler_config, pHeap: *void, ppBackend: **ma_resampling_backend) -> ma_result #c_call;
    onUninit:                      #type (pUserData: *void, pBackend: *ma_resampling_backend, pAllocationCallbacks: *ma_allocation_callbacks) -> void #c_call;
    onProcess:                     #type (pUserData: *void, pBackend: *ma_resampling_backend, pFramesIn: *void, pFrameCountIn: *ma_uint64, pFramesOut: *void, pFrameCountOut: *ma_uint64) -> ma_result #c_call;
    onSetRate:                     #type (pUserData: *void, pBackend: *ma_resampling_backend, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_result #c_call; /* Optional. Rate changes will be disabled. */
    onGetInputLatency:             #type (pUserData: *void, pBackend: *ma_resampling_backend) -> ma_uint64 #c_call; /* Optional. Latency will be reported as 0. */
    onGetOutputLatency:            #type (pUserData: *void, pBackend: *ma_resampling_backend) -> ma_uint64 #c_call; /* Optional. Latency will be reported as 0. */
    onGetRequiredInputFrameCount:  #type (pUserData: *void, pBackend: *ma_resampling_backend, outputFrameCount: ma_uint64, pInputFrameCount: *ma_uint64) -> ma_result #c_call; /* Optional. Latency mitigation will be disabled. */
    onGetExpectedOutputFrameCount: #type (pUserData: *void, pBackend: *ma_resampling_backend, inputFrameCount: ma_uint64, pOutputFrameCount: *ma_uint64) -> ma_result #c_call; /* Optional. Latency mitigation will be disabled. */
    onReset:                       #type (pUserData: *void, pBackend: *ma_resampling_backend) -> ma_result #c_call;
}

ma_resample_algorithm :: enum u32 {
    linear :: 0;
    custom :: 1;

    ma_resample_algorithm_linear :: linear;
    ma_resample_algorithm_custom :: custom;
}

ma_resampler_config :: struct {
    format:           ma_format; /* Must be either ma_format_f32 or ma_format_s16. */
    channels:         ma_uint32;
    sampleRateIn:     ma_uint32;
    sampleRateOut:    ma_uint32;
    algorithm:        ma_resample_algorithm; /* When set to ma_resample_algorithm_custom, pBackendVTable will be used. */
    pBackendVTable:   *ma_resampling_backend_vtable;
    pBackendUserData: *void;
    linear:           struct {
        lpfOrder: ma_uint32;
    };
}

ma_resampler_config_init :: (format: ma_format, channels: ma_uint32, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32, algorithm: ma_resample_algorithm) -> ma_resampler_config #foreign libminiaudio;

ma_resampler :: struct {
    pBackend:         *ma_resampling_backend;
    pBackendVTable:   *ma_resampling_backend_vtable;
    pBackendUserData: *void;
    format:           ma_format;
    channels:         ma_uint32;
    sampleRateIn:     ma_uint32;
    sampleRateOut:    ma_uint32;
    state:            struct {
        linear: ma_linear_resampler;
    }; /* State for stock resamplers so we can avoid a malloc. For stock resamplers, pBackend will point here. */

    /* Memory management. */
    _pHeap:           *void;
    _ownsHeap:        ma_bool32;
}

ma_resampler_get_heap_size :: (pConfig: *ma_resampler_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_resampler_init_preallocated :: (pConfig: *ma_resampler_config, pHeap: *void, pResampler: *ma_resampler) -> ma_result #foreign libminiaudio;

/*
Initializes a new resampler object from a config.
*/
ma_resampler_init :: (pConfig: *ma_resampler_config, pAllocationCallbacks: *ma_allocation_callbacks, pResampler: *ma_resampler) -> ma_result #foreign libminiaudio;

/*
Uninitializes a resampler.
*/
ma_resampler_uninit :: (pResampler: *ma_resampler, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Converts the given input data.

Both the input and output frames must be in the format specified in the config when the resampler was initialized.

On input, [pFrameCountOut] contains the number of output frames to process. On output it contains the number of output frames that
were actually processed, which may be less than the requested amount which will happen if there's not enough input data. You can use
ma_resampler_get_expected_output_frame_count() to know how many output frames will be processed for a given number of input frames.

On input, [pFrameCountIn] contains the number of input frames contained in [pFramesIn]. On output it contains the number of whole
input frames that were actually processed. You can use ma_resampler_get_required_input_frame_count() to know how many input frames
you should provide for a given number of output frames. [pFramesIn] can be NULL, in which case zeroes will be used instead.

If [pFramesOut] is NULL, a seek is performed. In this case, if [pFrameCountOut] is not NULL it will seek by the specified number of
output frames. Otherwise, if [pFramesCountOut] is NULL and [pFrameCountIn] is not NULL, it will seek by the specified number of input
frames. When seeking, [pFramesIn] is allowed to NULL, in which case the internal timing state will be updated, but no input will be
processed. In this case, any internal filter state will be updated as if zeroes were passed in.

It is an error for [pFramesOut] to be non-NULL and [pFrameCountOut] to be NULL.

It is an error for both [pFrameCountOut] and [pFrameCountIn] to be NULL.
*/
ma_resampler_process_pcm_frames :: (pResampler: *ma_resampler, pFramesIn: *void, pFrameCountIn: *ma_uint64, pFramesOut: *void, pFrameCountOut: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Sets the input and output sample rate.
*/
ma_resampler_set_rate :: (pResampler: *ma_resampler, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_result #foreign libminiaudio;

/*
Sets the input and output sample rate as a ratio.

The ration is in/out.
*/
ma_resampler_set_rate_ratio :: (pResampler: *ma_resampler, ratio: float) -> ma_result #foreign libminiaudio;

/*
Retrieves the latency introduced by the resampler in input frames.
*/
ma_resampler_get_input_latency :: (pResampler: *ma_resampler) -> ma_uint64 #foreign libminiaudio;

/*
Retrieves the latency introduced by the resampler in output frames.
*/
ma_resampler_get_output_latency :: (pResampler: *ma_resampler) -> ma_uint64 #foreign libminiaudio;

/*
Calculates the number of whole input frames that would need to be read from the client in order to output the specified
number of output frames.

The returned value does not include cached input frames. It only returns the number of extra frames that would need to be
read from the input buffer in order to output the specified number of output frames.
*/
ma_resampler_get_required_input_frame_count :: (pResampler: *ma_resampler, outputFrameCount: ma_uint64, pInputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Calculates the number of whole output frames that would be output after fully reading and consuming the specified number of
input frames.
*/
ma_resampler_get_expected_output_frame_count :: (pResampler: *ma_resampler, inputFrameCount: ma_uint64, pOutputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Resets the resampler's timer and clears its internal cache.
*/
ma_resampler_reset :: (pResampler: *ma_resampler) -> ma_result #foreign libminiaudio;

/**************************************************************************************************************************************************************

Channel Conversion

**************************************************************************************************************************************************************/
ma_channel_conversion_path :: enum u32 {
    unknown     :: 0;
    passthrough :: 1;
    mono_out    :: 2;
    mono_in     :: 3;
    shuffle     :: 4;
    weights     :: 5;

    ma_channel_conversion_path_unknown     :: unknown;
    ma_channel_conversion_path_passthrough :: passthrough;
    ma_channel_conversion_path_mono_out    :: mono_out;
    ma_channel_conversion_path_mono_in     :: mono_in;
    ma_channel_conversion_path_shuffle     :: shuffle;
    ma_channel_conversion_path_weights     :: weights;
}

ma_mono_expansion_mode :: enum u32 {
    duplicate   :: 0;
    average     :: 1;
    stereo_only :: 2;
    default     :: 0;

    ma_mono_expansion_mode_duplicate   :: duplicate;
    ma_mono_expansion_mode_average     :: average;
    ma_mono_expansion_mode_stereo_only :: stereo_only;
    ma_mono_expansion_mode_default     :: default;
}

ma_channel_converter_config :: struct {
    format:                          ma_format;
    channelsIn:                      ma_uint32;
    channelsOut:                     ma_uint32;
    pChannelMapIn:                   *ma_channel;
    pChannelMapOut:                  *ma_channel;
    mixingMode:                      ma_channel_mix_mode;
    calculateLFEFromSpatialChannels: ma_bool32; /* When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present. */
    ppWeights:                       **float; /* [in][out]. Only used when mixingMode is set to ma_channel_mix_mode_custom_weights. */
}

ma_channel_converter_config_init :: (format: ma_format, channelsIn: ma_uint32, pChannelMapIn: *ma_channel, channelsOut: ma_uint32, pChannelMapOut: *ma_channel, mixingMode: ma_channel_mix_mode) -> ma_channel_converter_config #foreign libminiaudio;

ma_channel_converter :: struct {
    format:         ma_format;
    channelsIn:     ma_uint32;
    channelsOut:    ma_uint32;
    mixingMode:     ma_channel_mix_mode;
    conversionPath: ma_channel_conversion_path;
    pChannelMapIn:  *ma_channel;
    pChannelMapOut: *ma_channel;
    pShuffleTable:  *ma_uint8; /* Indexed by output channel index. */
    weights:        struct {
        f32: **float;

        #overlay (f32) _s16: **ma_int32;
    }; /* [in][out] */

    /* Memory management. */
    _pHeap:         *void;
    _ownsHeap:      ma_bool32;
}

ma_channel_converter_get_heap_size :: (pConfig: *ma_channel_converter_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_channel_converter_init_preallocated :: (pConfig: *ma_channel_converter_config, pHeap: *void, pConverter: *ma_channel_converter) -> ma_result #foreign libminiaudio;
ma_channel_converter_init :: (pConfig: *ma_channel_converter_config, pAllocationCallbacks: *ma_allocation_callbacks, pConverter: *ma_channel_converter) -> ma_result #foreign libminiaudio;
ma_channel_converter_uninit :: (pConverter: *ma_channel_converter, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_channel_converter_process_pcm_frames :: (pConverter: *ma_channel_converter, pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_channel_converter_get_input_channel_map :: (pConverter: *ma_channel_converter, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_channel_converter_get_output_channel_map :: (pConverter: *ma_channel_converter, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;

/**************************************************************************************************************************************************************

Data Conversion

**************************************************************************************************************************************************************/
ma_data_converter_config :: struct {
    formatIn:                        ma_format;
    formatOut:                       ma_format;
    channelsIn:                      ma_uint32;
    channelsOut:                     ma_uint32;
    sampleRateIn:                    ma_uint32;
    sampleRateOut:                   ma_uint32;
    pChannelMapIn:                   *ma_channel;
    pChannelMapOut:                  *ma_channel;
    ditherMode:                      ma_dither_mode;
    channelMixMode:                  ma_channel_mix_mode;
    calculateLFEFromSpatialChannels: ma_bool32; /* When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present. */
    ppChannelWeights:                **float; /* [in][out]. Only used when mixingMode is set to ma_channel_mix_mode_custom_weights. */
    allowDynamicSampleRate:          ma_bool32;
    resampling:                      ma_resampler_config;
}

ma_data_converter_config_init_default :: () -> ma_data_converter_config #foreign libminiaudio;
ma_data_converter_config_init :: (formatIn: ma_format, formatOut: ma_format, channelsIn: ma_uint32, channelsOut: ma_uint32, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_data_converter_config #foreign libminiaudio;

ma_data_converter_execution_path :: enum u32 {
    passthrough    :: 0;
    format_only    :: 1;
    channels_only  :: 2;
    resample_only  :: 3;
    resample_first :: 4;
    channels_first :: 5;

    ma_data_converter_execution_path_passthrough    :: passthrough;
    ma_data_converter_execution_path_format_only    :: format_only;
    ma_data_converter_execution_path_channels_only  :: channels_only;
    ma_data_converter_execution_path_resample_only  :: resample_only;
    ma_data_converter_execution_path_resample_first :: resample_first;
    ma_data_converter_execution_path_channels_first :: channels_first;
}

ma_data_converter :: struct {
    formatIn:                ma_format;
    formatOut:               ma_format;
    channelsIn:              ma_uint32;
    channelsOut:             ma_uint32;
    sampleRateIn:            ma_uint32;
    sampleRateOut:           ma_uint32;
    ditherMode:              ma_dither_mode;
    executionPath:           ma_data_converter_execution_path; /* The execution path the data converter will follow when processing. */
    channelConverter:        ma_channel_converter;
    resampler:               ma_resampler;
    hasPreFormatConversion:  ma_bool8;
    hasPostFormatConversion: ma_bool8;
    hasChannelConverter:     ma_bool8;
    hasResampler:            ma_bool8;
    isPassthrough:           ma_bool8;

    /* Memory management. */
    _ownsHeap:               ma_bool8;
    _pHeap:                  *void;
}

ma_data_converter_get_heap_size :: (pConfig: *ma_data_converter_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_data_converter_init_preallocated :: (pConfig: *ma_data_converter_config, pHeap: *void, pConverter: *ma_data_converter) -> ma_result #foreign libminiaudio;
ma_data_converter_init :: (pConfig: *ma_data_converter_config, pAllocationCallbacks: *ma_allocation_callbacks, pConverter: *ma_data_converter) -> ma_result #foreign libminiaudio;
ma_data_converter_uninit :: (pConverter: *ma_data_converter, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_data_converter_process_pcm_frames :: (pConverter: *ma_data_converter, pFramesIn: *void, pFrameCountIn: *ma_uint64, pFramesOut: *void, pFrameCountOut: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_converter_set_rate :: (pConverter: *ma_data_converter, sampleRateIn: ma_uint32, sampleRateOut: ma_uint32) -> ma_result #foreign libminiaudio;
ma_data_converter_set_rate_ratio :: (pConverter: *ma_data_converter, ratioInOut: float) -> ma_result #foreign libminiaudio;
ma_data_converter_get_input_latency :: (pConverter: *ma_data_converter) -> ma_uint64 #foreign libminiaudio;
ma_data_converter_get_output_latency :: (pConverter: *ma_data_converter) -> ma_uint64 #foreign libminiaudio;
ma_data_converter_get_required_input_frame_count :: (pConverter: *ma_data_converter, outputFrameCount: ma_uint64, pInputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_converter_get_expected_output_frame_count :: (pConverter: *ma_data_converter, inputFrameCount: ma_uint64, pOutputFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_converter_get_input_channel_map :: (pConverter: *ma_data_converter, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_data_converter_get_output_channel_map :: (pConverter: *ma_data_converter, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_data_converter_reset :: (pConverter: *ma_data_converter) -> ma_result #foreign libminiaudio;

/************************************************************************************************************************************************************

Format Conversion

************************************************************************************************************************************************************/
ma_pcm_u8_to_s16 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_u8_to_s24 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_u8_to_s32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_u8_to_f32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s16_to_u8 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s16_to_s24 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s16_to_s32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s16_to_f32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s24_to_u8 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s24_to_s16 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s24_to_s32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s24_to_f32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s32_to_u8 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s32_to_s16 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s32_to_s24 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_s32_to_f32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_f32_to_u8 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_f32_to_s16 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_f32_to_s24 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_f32_to_s32 :: (pOut: *void, pIn: *void, count: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_pcm_convert :: (pOut: *void, formatOut: ma_format, pIn: *void, formatIn: ma_format, sampleCount: ma_uint64, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;
ma_convert_pcm_frames_format :: (pOut: *void, formatOut: ma_format, pIn: *void, formatIn: ma_format, frameCount: ma_uint64, channels: ma_uint32, ditherMode: ma_dither_mode) -> void #foreign libminiaudio;

/*
Deinterleaves an interleaved buffer.
*/
ma_deinterleave_pcm_frames :: (format: ma_format, channels: ma_uint32, frameCount: ma_uint64, pInterleavedPCMFrames: *void, ppDeinterleavedPCMFrames: **void) -> void #foreign libminiaudio;

/*
Interleaves a group of deinterleaved buffers.
*/
ma_interleave_pcm_frames :: (format: ma_format, channels: ma_uint32, frameCount: ma_uint64, ppDeinterleavedPCMFrames: **void, pInterleavedPCMFrames: *void) -> void #foreign libminiaudio;

/*
Retrieves the channel position of the specified channel in the given channel map.

The pChannelMap parameter can be null, in which case miniaudio's default channel map will be assumed.
*/
ma_channel_map_get_channel :: (pChannelMap: *ma_channel, channelCount: ma_uint32, channelIndex: ma_uint32) -> ma_channel #foreign libminiaudio;

/*
Initializes a blank channel map.

When a blank channel map is specified anywhere it indicates that the native channel map should be used.
*/
ma_channel_map_init_blank :: (pChannelMap: *ma_channel, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Helper for retrieving a standard channel map.

The output channel map buffer must have a capacity of at least `channelMapCap`.
*/
ma_channel_map_init_standard :: (standardChannelMap: ma_standard_channel_map, pChannelMap: *ma_channel, channelMapCap: u64, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Copies a channel map.

Both input and output channel map buffers must have a capacity of at least `channels`.
*/
ma_channel_map_copy :: (pOut: *ma_channel, pIn: *ma_channel, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Copies a channel map if one is specified, otherwise copies the default channel map.

The output buffer must have a capacity of at least `channels`. If not NULL, the input channel map must also have a capacity of at least `channels`.
*/
ma_channel_map_copy_or_default :: (pOut: *ma_channel, channelMapCapOut: u64, pIn: *ma_channel, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Determines whether or not a channel map is valid.

A blank channel map is valid (all channels set to MA_CHANNEL_NONE). The way a blank channel map is handled is context specific, but
is usually treated as a passthrough.

Invalid channel maps:
- A channel map with no channels
- A channel map with more than one channel and a mono channel

The channel map buffer must have a capacity of at least `channels`.
*/
ma_channel_map_is_valid :: (pChannelMap: *ma_channel, channels: ma_uint32) -> ma_bool32 #foreign libminiaudio;

/*
Helper for comparing two channel maps for equality.

This assumes the channel count is the same between the two.

Both channels map buffers must have a capacity of at least `channels`.
*/
ma_channel_map_is_equal :: (pChannelMapA: *ma_channel, pChannelMapB: *ma_channel, channels: ma_uint32) -> ma_bool32 #foreign libminiaudio;

/*
Helper for determining if a channel map is blank (all channels set to MA_CHANNEL_NONE).

The channel map buffer must have a capacity of at least `channels`.
*/
ma_channel_map_is_blank :: (pChannelMap: *ma_channel, channels: ma_uint32) -> ma_bool32 #foreign libminiaudio;

/*
Helper for determining whether or not a channel is present in the given channel map.

The channel map buffer must have a capacity of at least `channels`.
*/
ma_channel_map_contains_channel_position :: (channels: ma_uint32, pChannelMap: *ma_channel, channelPosition: ma_channel) -> ma_bool32 #foreign libminiaudio;

/*
Find a channel position in the given channel map. Returns MA_TRUE if the channel is found; MA_FALSE otherwise. The
index of the channel is output to `pChannelIndex`.

The channel map buffer must have a capacity of at least `channels`.
*/
ma_channel_map_find_channel_position :: (channels: ma_uint32, pChannelMap: *ma_channel, channelPosition: ma_channel, pChannelIndex: *ma_uint32) -> ma_bool32 #foreign libminiaudio;

/*
Generates a string representing the given channel map.

This is for printing and debugging purposes, not serialization/deserialization.

Returns the length of the string, not including the null terminator.
*/
ma_channel_map_to_string :: (pChannelMap: *ma_channel, channels: ma_uint32, pBufferOut: *u8, bufferCap: u64) -> u64 #foreign libminiaudio;

/*
Retrieves a human readable version of a channel position.
*/
ma_channel_position_to_string :: (channel: ma_channel) -> *u8 #foreign libminiaudio;

/*
High-level helper for doing a full format conversion in one go. Returns the number of output frames. Call this with pOut set to NULL to
determine the required size of the output buffer. frameCountOut should be set to the capacity of pOut. If pOut is NULL, frameCountOut is
ignored.

A return value of 0 indicates an error.

This function is useful for one-off bulk conversions, but if you're streaming data you should use the ma_data_converter APIs instead.
*/
ma_convert_frames :: (pOut: *void, frameCountOut: ma_uint64, formatOut: ma_format, channelsOut: ma_uint32, sampleRateOut: ma_uint32, pIn: *void, frameCountIn: ma_uint64, formatIn: ma_format, channelsIn: ma_uint32, sampleRateIn: ma_uint32) -> ma_uint64 #foreign libminiaudio;
ma_convert_frames_ex :: (pOut: *void, frameCountOut: ma_uint64, pIn: *void, frameCountIn: ma_uint64, pConfig: *ma_data_converter_config) -> ma_uint64 #foreign libminiaudio;

/************************************************************************************************************************************************************

Data Source

************************************************************************************************************************************************************/
ma_data_source :: void;

ma_data_source_vtable :: struct {
    onRead:          #type (pDataSource: *ma_data_source, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #c_call;
    onSeek:          #type (pDataSource: *ma_data_source, frameIndex: ma_uint64) -> ma_result #c_call;
    onGetDataFormat: #type (pDataSource: *ma_data_source, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #c_call;
    onGetCursor:     #type (pDataSource: *ma_data_source, pCursor: *ma_uint64) -> ma_result #c_call;
    onGetLength:     #type (pDataSource: *ma_data_source, pLength: *ma_uint64) -> ma_result #c_call;
    onSetLooping:    #type (pDataSource: *ma_data_source, isLooping: ma_bool32) -> ma_result #c_call;
    flags:           ma_uint32;
}

ma_data_source_get_next_proc :: #type (pDataSource: *ma_data_source) -> *ma_data_source #c_call;

ma_data_source_config :: struct {
    vtable: *ma_data_source_vtable;
}

ma_data_source_config_init :: () -> ma_data_source_config #foreign libminiaudio;

ma_data_source_base :: struct {
    vtable:           *ma_data_source_vtable;
    rangeBegInFrames: ma_uint64;
    rangeEndInFrames: ma_uint64; /* Set to -1 for unranged (default). */
    loopBegInFrames:  ma_uint64; /* Relative to rangeBegInFrames. */
    loopEndInFrames:  ma_uint64; /* Relative to rangeBegInFrames. Set to -1 for the end of the range. */
    pCurrent:         *ma_data_source; /* When non-NULL, the data source being initialized will act as a proxy and will route all operations to pCurrent. Used in conjunction with pNext/onGetNext for seamless chaining. */
    pNext:            *ma_data_source; /* When set to NULL, onGetNext will be used. */
    onGetNext:        ma_data_source_get_next_proc; /* Will be used when pNext is NULL. If both are NULL, no next will be used. */
    isLooping:        ma_bool32;
}

ma_data_source_init :: (pConfig: *ma_data_source_config, pDataSource: *ma_data_source) -> ma_result #foreign libminiaudio;
ma_data_source_uninit :: (pDataSource: *ma_data_source) -> void #foreign libminiaudio;
ma_data_source_read_pcm_frames :: (pDataSource: *ma_data_source, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_seek_pcm_frames :: (pDataSource: *ma_data_source, frameCount: ma_uint64, pFramesSeeked: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_seek_to_pcm_frame :: (pDataSource: *ma_data_source, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_seek_seconds :: (pDataSource: *ma_data_source, secondCount: float, pSecondsSeeked: *float) -> ma_result #foreign libminiaudio;
ma_data_source_seek_to_second :: (pDataSource: *ma_data_source, seekPointInSeconds: float) -> ma_result #foreign libminiaudio;
ma_data_source_get_data_format :: (pDataSource: *ma_data_source, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_data_source_get_cursor_in_pcm_frames :: (pDataSource: *ma_data_source, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_get_length_in_pcm_frames :: (pDataSource: *ma_data_source, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_get_cursor_in_seconds :: (pDataSource: *ma_data_source, pCursor: *float) -> ma_result #foreign libminiaudio;
ma_data_source_get_length_in_seconds :: (pDataSource: *ma_data_source, pLength: *float) -> ma_result #foreign libminiaudio;
ma_data_source_set_looping :: (pDataSource: *ma_data_source, isLooping: ma_bool32) -> ma_result #foreign libminiaudio;
ma_data_source_is_looping :: (pDataSource: *ma_data_source) -> ma_bool32 #foreign libminiaudio;
ma_data_source_set_range_in_pcm_frames :: (pDataSource: *ma_data_source, rangeBegInFrames: ma_uint64, rangeEndInFrames: ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_get_range_in_pcm_frames :: (pDataSource: *ma_data_source, pRangeBegInFrames: *ma_uint64, pRangeEndInFrames: *ma_uint64) -> void #foreign libminiaudio;
ma_data_source_set_loop_point_in_pcm_frames :: (pDataSource: *ma_data_source, loopBegInFrames: ma_uint64, loopEndInFrames: ma_uint64) -> ma_result #foreign libminiaudio;
ma_data_source_get_loop_point_in_pcm_frames :: (pDataSource: *ma_data_source, pLoopBegInFrames: *ma_uint64, pLoopEndInFrames: *ma_uint64) -> void #foreign libminiaudio;
ma_data_source_set_current :: (pDataSource: *ma_data_source, pCurrentDataSource: *ma_data_source) -> ma_result #foreign libminiaudio;
ma_data_source_get_current :: (pDataSource: *ma_data_source) -> *ma_data_source #foreign libminiaudio;
ma_data_source_set_next :: (pDataSource: *ma_data_source, pNextDataSource: *ma_data_source) -> ma_result #foreign libminiaudio;
ma_data_source_get_next :: (pDataSource: *ma_data_source) -> *ma_data_source #foreign libminiaudio;
ma_data_source_set_next_callback :: (pDataSource: *ma_data_source, onGetNext: ma_data_source_get_next_proc) -> ma_result #foreign libminiaudio;
ma_data_source_get_next_callback :: (pDataSource: *ma_data_source) -> ma_data_source_get_next_proc #foreign libminiaudio;

ma_audio_buffer_ref :: struct {
    ds:           ma_data_source_base;
    format:       ma_format;
    channels:     ma_uint32;
    sampleRate:   ma_uint32;
    cursor:       ma_uint64;
    sizeInFrames: ma_uint64;
    pData:        *void;
}

ma_audio_buffer_ref_init :: (format: ma_format, channels: ma_uint32, pData: *void, sizeInFrames: ma_uint64, pAudioBufferRef: *ma_audio_buffer_ref) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_uninit :: (pAudioBufferRef: *ma_audio_buffer_ref) -> void #foreign libminiaudio;
ma_audio_buffer_ref_set_data :: (pAudioBufferRef: *ma_audio_buffer_ref, pData: *void, sizeInFrames: ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_read_pcm_frames :: (pAudioBufferRef: *ma_audio_buffer_ref, pFramesOut: *void, frameCount: ma_uint64, loop: ma_bool32) -> ma_uint64 #foreign libminiaudio;
ma_audio_buffer_ref_seek_to_pcm_frame :: (pAudioBufferRef: *ma_audio_buffer_ref, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_map :: (pAudioBufferRef: *ma_audio_buffer_ref, ppFramesOut: **void, pFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_unmap :: (pAudioBufferRef: *ma_audio_buffer_ref, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_at_end :: (pAudioBufferRef: *ma_audio_buffer_ref) -> ma_bool32 #foreign libminiaudio;
ma_audio_buffer_ref_get_cursor_in_pcm_frames :: (pAudioBufferRef: *ma_audio_buffer_ref, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_get_length_in_pcm_frames :: (pAudioBufferRef: *ma_audio_buffer_ref, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_ref_get_available_frames :: (pAudioBufferRef: *ma_audio_buffer_ref, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

ma_audio_buffer_config :: struct {
    format:              ma_format;
    channels:            ma_uint32;
    sampleRate:          ma_uint32;
    sizeInFrames:        ma_uint64;
    pData:               *void; /* If set to NULL, will allocate a block of memory for you. */
    allocationCallbacks: ma_allocation_callbacks;
}

ma_audio_buffer_config_init :: (format: ma_format, channels: ma_uint32, sizeInFrames: ma_uint64, pData: *void, pAllocationCallbacks: *ma_allocation_callbacks) -> ma_audio_buffer_config #foreign libminiaudio;

ma_audio_buffer :: struct {
    ref:                 ma_audio_buffer_ref;
    allocationCallbacks: ma_allocation_callbacks;
    ownsData:            ma_bool32; /* Used to control whether or not miniaudio owns the data buffer. If set to true, pData will be freed in ma_audio_buffer_uninit(). */
    _pExtraData:         [1] ma_uint8; /* For allocating a buffer with the memory located directly after the other memory of the structure. */
}

ma_audio_buffer_init :: (pConfig: *ma_audio_buffer_config, pAudioBuffer: *ma_audio_buffer) -> ma_result #foreign libminiaudio;
ma_audio_buffer_init_copy :: (pConfig: *ma_audio_buffer_config, pAudioBuffer: *ma_audio_buffer) -> ma_result #foreign libminiaudio;
ma_audio_buffer_alloc_and_init :: (pConfig: *ma_audio_buffer_config, ppAudioBuffer: **ma_audio_buffer) -> ma_result #foreign libminiaudio;
ma_audio_buffer_uninit :: (pAudioBuffer: *ma_audio_buffer) -> void #foreign libminiaudio;
ma_audio_buffer_uninit_and_free :: (pAudioBuffer: *ma_audio_buffer) -> void #foreign libminiaudio;
ma_audio_buffer_read_pcm_frames :: (pAudioBuffer: *ma_audio_buffer, pFramesOut: *void, frameCount: ma_uint64, loop: ma_bool32) -> ma_uint64 #foreign libminiaudio;
ma_audio_buffer_seek_to_pcm_frame :: (pAudioBuffer: *ma_audio_buffer, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_map :: (pAudioBuffer: *ma_audio_buffer, ppFramesOut: **void, pFrameCount: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_unmap :: (pAudioBuffer: *ma_audio_buffer, frameCount: ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_at_end :: (pAudioBuffer: *ma_audio_buffer) -> ma_bool32 #foreign libminiaudio;
ma_audio_buffer_get_cursor_in_pcm_frames :: (pAudioBuffer: *ma_audio_buffer, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_get_length_in_pcm_frames :: (pAudioBuffer: *ma_audio_buffer, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_audio_buffer_get_available_frames :: (pAudioBuffer: *ma_audio_buffer, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

ma_paged_audio_buffer_page :: struct {
    pNext:        *ma_paged_audio_buffer_page;
    sizeInFrames: ma_uint64;
    pAudioData:   [1] ma_uint8;
}

ma_paged_audio_buffer_data :: struct {
    format:   ma_format;
    channels: ma_uint32;
    head:     ma_paged_audio_buffer_page; /* Dummy head for the lock-free algorithm. Always has a size of 0. */
    pTail:    *ma_paged_audio_buffer_page; /* Never null. Initially set to &head. */
}

ma_paged_audio_buffer_data_init :: (format: ma_format, channels: ma_uint32, pData: *ma_paged_audio_buffer_data) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_data_uninit :: (pData: *ma_paged_audio_buffer_data, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_paged_audio_buffer_data_get_head :: (pData: *ma_paged_audio_buffer_data) -> *ma_paged_audio_buffer_page #foreign libminiaudio;
ma_paged_audio_buffer_data_get_tail :: (pData: *ma_paged_audio_buffer_data) -> *ma_paged_audio_buffer_page #foreign libminiaudio;
ma_paged_audio_buffer_data_get_length_in_pcm_frames :: (pData: *ma_paged_audio_buffer_data, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_data_allocate_page :: (pData: *ma_paged_audio_buffer_data, pageSizeInFrames: ma_uint64, pInitialData: *void, pAllocationCallbacks: *ma_allocation_callbacks, ppPage: **ma_paged_audio_buffer_page) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_data_free_page :: (pData: *ma_paged_audio_buffer_data, pPage: *ma_paged_audio_buffer_page, pAllocationCallbacks: *ma_allocation_callbacks) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_data_append_page :: (pData: *ma_paged_audio_buffer_data, pPage: *ma_paged_audio_buffer_page) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_data_allocate_and_append_page :: (pData: *ma_paged_audio_buffer_data, pageSizeInFrames: ma_uint32, pInitialData: *void, pAllocationCallbacks: *ma_allocation_callbacks) -> ma_result #foreign libminiaudio;

ma_paged_audio_buffer_config :: struct {
    pData: *ma_paged_audio_buffer_data; /* Must not be null. */
}

ma_paged_audio_buffer_config_init :: (pData: *ma_paged_audio_buffer_data) -> ma_paged_audio_buffer_config #foreign libminiaudio;

ma_paged_audio_buffer :: struct {
    ds:             ma_data_source_base;
    pData:          *ma_paged_audio_buffer_data; /* Audio data is read from here. Cannot be null. */
    pCurrent:       *ma_paged_audio_buffer_page;
    relativeCursor: ma_uint64; /* Relative to the current page. */
    absoluteCursor: ma_uint64;
}

ma_paged_audio_buffer_init :: (pConfig: *ma_paged_audio_buffer_config, pPagedAudioBuffer: *ma_paged_audio_buffer) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_uninit :: (pPagedAudioBuffer: *ma_paged_audio_buffer) -> void #foreign libminiaudio;
ma_paged_audio_buffer_read_pcm_frames :: (pPagedAudioBuffer: *ma_paged_audio_buffer, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_seek_to_pcm_frame :: (pPagedAudioBuffer: *ma_paged_audio_buffer, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_get_cursor_in_pcm_frames :: (pPagedAudioBuffer: *ma_paged_audio_buffer, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_paged_audio_buffer_get_length_in_pcm_frames :: (pPagedAudioBuffer: *ma_paged_audio_buffer, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;

/************************************************************************************************************************************************************

Ring Buffer

************************************************************************************************************************************************************/
ma_rb :: struct {
    pBuffer:                *void;
    subbufferSizeInBytes:   ma_uint32;
    subbufferCount:         ma_uint32;
    subbufferStrideInBytes: ma_uint32;
    encodedReadOffset:      ma_uint32; /* Most significant bit is the loop flag. Lower 31 bits contains the actual offset in bytes. Must be used atomically. */
    encodedWriteOffset:     ma_uint32; /* Most significant bit is the loop flag. Lower 31 bits contains the actual offset in bytes. Must be used atomically. */
    ownsBuffer:             ma_bool8; /* Used to know whether or not miniaudio is responsible for free()-ing the buffer. */
    clearOnWriteAcquire:    ma_bool8; /* When set, clears the acquired write buffer before returning from ma_rb_acquire_write(). */
    allocationCallbacks:    ma_allocation_callbacks;
}

ma_rb_init_ex :: (subbufferSizeInBytes: u64, subbufferCount: u64, subbufferStrideInBytes: u64, pOptionalPreallocatedBuffer: *void, pAllocationCallbacks: *ma_allocation_callbacks, pRB: *ma_rb) -> ma_result #foreign libminiaudio;
ma_rb_init :: (bufferSizeInBytes: u64, pOptionalPreallocatedBuffer: *void, pAllocationCallbacks: *ma_allocation_callbacks, pRB: *ma_rb) -> ma_result #foreign libminiaudio;
ma_rb_uninit :: (pRB: *ma_rb) -> void #foreign libminiaudio;
ma_rb_reset :: (pRB: *ma_rb) -> void #foreign libminiaudio;
ma_rb_acquire_read :: (pRB: *ma_rb, pSizeInBytes: *u64, ppBufferOut: **void) -> ma_result #foreign libminiaudio;
ma_rb_commit_read :: (pRB: *ma_rb, sizeInBytes: u64) -> ma_result #foreign libminiaudio;
ma_rb_acquire_write :: (pRB: *ma_rb, pSizeInBytes: *u64, ppBufferOut: **void) -> ma_result #foreign libminiaudio;
ma_rb_commit_write :: (pRB: *ma_rb, sizeInBytes: u64) -> ma_result #foreign libminiaudio;
ma_rb_seek_read :: (pRB: *ma_rb, offsetInBytes: u64) -> ma_result #foreign libminiaudio;
ma_rb_seek_write :: (pRB: *ma_rb, offsetInBytes: u64) -> ma_result #foreign libminiaudio;
ma_rb_pointer_distance :: (pRB: *ma_rb) -> ma_int32 #foreign libminiaudio;
ma_rb_available_read :: (pRB: *ma_rb) -> ma_uint32 #foreign libminiaudio;
ma_rb_available_write :: (pRB: *ma_rb) -> ma_uint32 #foreign libminiaudio;
ma_rb_get_subbuffer_size :: (pRB: *ma_rb) -> u64 #foreign libminiaudio;
ma_rb_get_subbuffer_stride :: (pRB: *ma_rb) -> u64 #foreign libminiaudio;
ma_rb_get_subbuffer_offset :: (pRB: *ma_rb, subbufferIndex: u64) -> u64 #foreign libminiaudio;
ma_rb_get_subbuffer_ptr :: (pRB: *ma_rb, subbufferIndex: u64, pBuffer: *void) -> *void #foreign libminiaudio;

ma_pcm_rb :: struct {
    ds:         ma_data_source_base;
    rb:         ma_rb;
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32; /* Not required for the ring buffer itself, but useful for associating the data with some sample rate, particularly for data sources. */
}

ma_pcm_rb_init_ex :: (format: ma_format, channels: ma_uint32, subbufferSizeInFrames: ma_uint32, subbufferCount: ma_uint32, subbufferStrideInFrames: ma_uint32, pOptionalPreallocatedBuffer: *void, pAllocationCallbacks: *ma_allocation_callbacks, pRB: *ma_pcm_rb) -> ma_result #foreign libminiaudio;
ma_pcm_rb_init :: (format: ma_format, channels: ma_uint32, bufferSizeInFrames: ma_uint32, pOptionalPreallocatedBuffer: *void, pAllocationCallbacks: *ma_allocation_callbacks, pRB: *ma_pcm_rb) -> ma_result #foreign libminiaudio;
ma_pcm_rb_uninit :: (pRB: *ma_pcm_rb) -> void #foreign libminiaudio;
ma_pcm_rb_reset :: (pRB: *ma_pcm_rb) -> void #foreign libminiaudio;
ma_pcm_rb_acquire_read :: (pRB: *ma_pcm_rb, pSizeInFrames: *ma_uint32, ppBufferOut: **void) -> ma_result #foreign libminiaudio;
ma_pcm_rb_commit_read :: (pRB: *ma_pcm_rb, sizeInFrames: ma_uint32) -> ma_result #foreign libminiaudio;
ma_pcm_rb_acquire_write :: (pRB: *ma_pcm_rb, pSizeInFrames: *ma_uint32, ppBufferOut: **void) -> ma_result #foreign libminiaudio;
ma_pcm_rb_commit_write :: (pRB: *ma_pcm_rb, sizeInFrames: ma_uint32) -> ma_result #foreign libminiaudio;
ma_pcm_rb_seek_read :: (pRB: *ma_pcm_rb, offsetInFrames: ma_uint32) -> ma_result #foreign libminiaudio;
ma_pcm_rb_seek_write :: (pRB: *ma_pcm_rb, offsetInFrames: ma_uint32) -> ma_result #foreign libminiaudio;
ma_pcm_rb_pointer_distance :: (pRB: *ma_pcm_rb) -> ma_int32 #foreign libminiaudio;
ma_pcm_rb_available_read :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_available_write :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_get_subbuffer_size :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_get_subbuffer_stride :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_get_subbuffer_offset :: (pRB: *ma_pcm_rb, subbufferIndex: ma_uint32) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_get_subbuffer_ptr :: (pRB: *ma_pcm_rb, subbufferIndex: ma_uint32, pBuffer: *void) -> *void #foreign libminiaudio;
ma_pcm_rb_get_format :: (pRB: *ma_pcm_rb) -> ma_format #foreign libminiaudio;
ma_pcm_rb_get_channels :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_get_sample_rate :: (pRB: *ma_pcm_rb) -> ma_uint32 #foreign libminiaudio;
ma_pcm_rb_set_sample_rate :: (pRB: *ma_pcm_rb, sampleRate: ma_uint32) -> void #foreign libminiaudio;

/*
The idea of the duplex ring buffer is to act as the intermediary buffer when running two asynchronous devices in a duplex set up. The
capture device writes to it, and then a playback device reads from it.

At the moment this is just a simple naive implementation, but in the future I want to implement some dynamic resampling to seamlessly
handle desyncs. Note that the API is work in progress and may change at any time in any version.

The size of the buffer is based on the capture side since that's what'll be written to the buffer. It is based on the capture period size
in frames. The internal sample rate of the capture device is also needed in order to calculate the size.
*/
ma_duplex_rb :: struct {
    rb: ma_pcm_rb;
}

ma_duplex_rb_init :: (captureFormat: ma_format, captureChannels: ma_uint32, sampleRate: ma_uint32, captureInternalSampleRate: ma_uint32, captureInternalPeriodSizeInFrames: ma_uint32, pAllocationCallbacks: *ma_allocation_callbacks, pRB: *ma_duplex_rb) -> ma_result #foreign libminiaudio;
ma_duplex_rb_uninit :: (pRB: *ma_duplex_rb) -> ma_result #foreign libminiaudio;

/************************************************************************************************************************************************************

Miscellaneous Helpers

************************************************************************************************************************************************************/
/*
Retrieves a human readable description of the given result code.
*/
ma_result_description :: (result: ma_result) -> *u8 #foreign libminiaudio;

/*
malloc()
*/
ma_malloc :: (sz: u64, pAllocationCallbacks: *ma_allocation_callbacks) -> *void #foreign libminiaudio;

/*
calloc()
*/
ma_calloc :: (sz: u64, pAllocationCallbacks: *ma_allocation_callbacks) -> *void #foreign libminiaudio;

/*
realloc()
*/
ma_realloc :: (p: *void, sz: u64, pAllocationCallbacks: *ma_allocation_callbacks) -> *void #foreign libminiaudio;

/*
free()
*/
ma_free :: (p: *void, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Performs an aligned malloc, with the assumption that the alignment is a power of 2.
*/
ma_aligned_malloc :: (sz: u64, alignment: u64, pAllocationCallbacks: *ma_allocation_callbacks) -> *void #foreign libminiaudio;

/*
Free's an aligned malloc'd buffer.
*/
ma_aligned_free :: (p: *void, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Retrieves a friendly name for a format.
*/
ma_get_format_name :: (format: ma_format) -> *u8 #foreign libminiaudio;

/*
Blends two frames in floating point format.
*/
ma_blend_f32 :: (pOut: *float, pInA: *float, pInB: *float, factor: float, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Retrieves the size of a sample in bytes for the given format.

This API is efficient and is implemented using a lookup table.

Thread Safety: SAFE
This API is pure.
*/
ma_get_bytes_per_sample :: (format: ma_format) -> ma_uint32 #foreign libminiaudio;

/*
Converts a log level to a string.
*/
ma_log_level_to_string :: (logLevel: ma_uint32) -> *u8 #foreign libminiaudio;

/************************************************************************************************************************************************************

Synchronization

************************************************************************************************************************************************************/
/*
Locks a spinlock.
*/
ma_spinlock_lock :: (pSpinlock: *ma_spinlock) -> ma_result #foreign libminiaudio;

/*
Locks a spinlock, but does not yield() when looping.
*/
ma_spinlock_lock_noyield :: (pSpinlock: *ma_spinlock) -> ma_result #foreign libminiaudio;

/*
Unlocks a spinlock.
*/
ma_spinlock_unlock :: (pSpinlock: *ma_spinlock) -> ma_result #foreign libminiaudio;

/*
Creates a mutex.

A mutex must be created from a valid context. A mutex is initially unlocked.
*/
ma_mutex_init :: (pMutex: *ma_mutex) -> ma_result #foreign libminiaudio;

/*
Deletes a mutex.
*/
ma_mutex_uninit :: (pMutex: *ma_mutex) -> void #foreign libminiaudio;

/*
Locks a mutex with an infinite timeout.
*/
ma_mutex_lock :: (pMutex: *ma_mutex) -> void #foreign libminiaudio;

/*
Unlocks a mutex.
*/
ma_mutex_unlock :: (pMutex: *ma_mutex) -> void #foreign libminiaudio;

/*
Initializes an auto-reset event.
*/
ma_event_init :: (pEvent: *ma_event) -> ma_result #foreign libminiaudio;

/*
Uninitializes an auto-reset event.
*/
ma_event_uninit :: (pEvent: *ma_event) -> void #foreign libminiaudio;

/*
Waits for the specified auto-reset event to become signalled.
*/
ma_event_wait :: (pEvent: *ma_event) -> ma_result #foreign libminiaudio;

/*
Signals the specified auto-reset event.
*/
ma_event_signal :: (pEvent: *ma_event) -> ma_result #foreign libminiaudio;

ma_semaphore_init :: (initialValue: s32, pSemaphore: *ma_semaphore) -> ma_result #foreign libminiaudio;
ma_semaphore_uninit :: (pSemaphore: *ma_semaphore) -> void #foreign libminiaudio;
ma_semaphore_wait :: (pSemaphore: *ma_semaphore) -> ma_result #foreign libminiaudio;
ma_semaphore_release :: (pSemaphore: *ma_semaphore) -> ma_result #foreign libminiaudio;

/*
Fence
=====
This locks while the counter is larger than 0. Counter can be incremented and decremented by any
thread, but care needs to be taken when waiting. It is possible for one thread to acquire the
fence just as another thread returns from ma_fence_wait().

The idea behind a fence is to allow you to wait for a group of operations to complete. When an
operation starts, the counter is incremented which locks the fence. When the operation completes,
the fence will be released which decrements the counter. ma_fence_wait() will block until the
counter hits zero.

If threading is disabled, ma_fence_wait() will spin on the counter.
*/
ma_fence :: struct {
    e:       ma_event;

    counter: ma_uint32;
}

ma_fence_init :: (pFence: *ma_fence) -> ma_result #foreign libminiaudio;
ma_fence_uninit :: (pFence: *ma_fence) -> void #foreign libminiaudio;
ma_fence_acquire :: (pFence: *ma_fence) -> ma_result #foreign libminiaudio;
ma_fence_release :: (pFence: *ma_fence) -> ma_result #foreign libminiaudio;
ma_fence_wait :: (pFence: *ma_fence) -> ma_result #foreign libminiaudio;

/*
Notification callback for asynchronous operations.
*/
ma_async_notification :: void;

ma_async_notification_callbacks :: struct {
    onSignal: #type (pNotification: *ma_async_notification) -> void #c_call;
}

ma_async_notification_signal :: (pNotification: *ma_async_notification) -> ma_result #foreign libminiaudio;

/*
Simple polling notification.

This just sets a variable when the notification has been signalled which is then polled with ma_async_notification_poll_is_signalled()
*/
ma_async_notification_poll :: struct {
    cb:        ma_async_notification_callbacks;
    signalled: ma_bool32;
}

ma_async_notification_poll_init :: (pNotificationPoll: *ma_async_notification_poll) -> ma_result #foreign libminiaudio;
ma_async_notification_poll_is_signalled :: (pNotificationPoll: *ma_async_notification_poll) -> ma_bool32 #foreign libminiaudio;

/*
Event Notification

This uses an ma_event. If threading is disabled (MA_NO_THREADING), initialization will fail.
*/
ma_async_notification_event :: struct {
    cb: ma_async_notification_callbacks;

    e:  ma_event;
}

ma_async_notification_event_init :: (pNotificationEvent: *ma_async_notification_event) -> ma_result #foreign libminiaudio;
ma_async_notification_event_uninit :: (pNotificationEvent: *ma_async_notification_event) -> ma_result #foreign libminiaudio;
ma_async_notification_event_wait :: (pNotificationEvent: *ma_async_notification_event) -> ma_result #foreign libminiaudio;
ma_async_notification_event_signal :: (pNotificationEvent: *ma_async_notification_event) -> ma_result #foreign libminiaudio;

/*
Slot Allocator
--------------
The idea of the slot allocator is for it to be used in conjunction with a fixed sized buffer. You use the slot allocator to allocate an index that can be used
as the insertion point for an object.

Slots are reference counted to help mitigate the ABA problem in the lock-free queue we use for tracking jobs.

The slot index is stored in the low 32 bits. The reference counter is stored in the high 32 bits:

+-----------------+-----------------+
| 32 Bits         | 32 Bits         |
+-----------------+-----------------+
| Reference Count | Slot Index      |
+-----------------+-----------------+
*/
ma_slot_allocator_config :: struct {
    capacity: ma_uint32; /* The number of slots to make available. */
}

ma_slot_allocator_config_init :: (capacity: ma_uint32) -> ma_slot_allocator_config #foreign libminiaudio;

ma_slot_allocator_group :: struct {
    bitfield: ma_uint32; /* Must be used atomically because the allocation and freeing routines need to make copies of this which must never be optimized away by the compiler. */
}

ma_slot_allocator :: struct {
    pGroups:   *ma_slot_allocator_group; /* Slots are grouped in chunks of 32. */
    pSlots:    *ma_uint32; /* 32 bits for reference counting for ABA mitigation. */
    count:     ma_uint32; /* Allocation count. */
    capacity:  ma_uint32;

    /* Memory management. */
    _ownsHeap: ma_bool32;
    _pHeap:    *void;
}

ma_slot_allocator_get_heap_size :: (pConfig: *ma_slot_allocator_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_slot_allocator_init_preallocated :: (pConfig: *ma_slot_allocator_config, pHeap: *void, pAllocator: *ma_slot_allocator) -> ma_result #foreign libminiaudio;
ma_slot_allocator_init :: (pConfig: *ma_slot_allocator_config, pAllocationCallbacks: *ma_allocation_callbacks, pAllocator: *ma_slot_allocator) -> ma_result #foreign libminiaudio;
ma_slot_allocator_uninit :: (pAllocator: *ma_slot_allocator, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_slot_allocator_alloc :: (pAllocator: *ma_slot_allocator, pSlot: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_slot_allocator_free :: (pAllocator: *ma_slot_allocator, slot: ma_uint64) -> ma_result #foreign libminiaudio;

/*
Callback for processing a job. Each job type will have their own processing callback which will be
called by ma_job_process().
*/
ma_job_proc :: #type (pJob: *ma_job) -> ma_result #c_call;

/* When a job type is added here an callback needs to be added go "g_jobVTable" in the implementation section. */
ma_job_type :: enum u32 {
    QUIT                                   :: 0;
    CUSTOM                                 :: 1;

    RESOURCE_MANAGER_LOAD_DATA_BUFFER_NODE :: 2;
    RESOURCE_MANAGER_FREE_DATA_BUFFER_NODE :: 3;
    RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE :: 4;
    RESOURCE_MANAGER_LOAD_DATA_BUFFER      :: 5;
    RESOURCE_MANAGER_FREE_DATA_BUFFER      :: 6;
    RESOURCE_MANAGER_LOAD_DATA_STREAM      :: 7;
    RESOURCE_MANAGER_FREE_DATA_STREAM      :: 8;
    RESOURCE_MANAGER_PAGE_DATA_STREAM      :: 9;
    RESOURCE_MANAGER_SEEK_DATA_STREAM      :: 10;

    DEVICE_AAUDIO_REROUTE                  :: 11;

    COUNT                                  :: 12;

    MA_JOB_TYPE_QUIT                                   :: QUIT;
    MA_JOB_TYPE_CUSTOM                                 :: CUSTOM;

    MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_BUFFER_NODE :: RESOURCE_MANAGER_LOAD_DATA_BUFFER_NODE;
    MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_BUFFER_NODE :: RESOURCE_MANAGER_FREE_DATA_BUFFER_NODE;
    MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE :: RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE;
    MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_BUFFER      :: RESOURCE_MANAGER_LOAD_DATA_BUFFER;
    MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_BUFFER      :: RESOURCE_MANAGER_FREE_DATA_BUFFER;
    MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_STREAM      :: RESOURCE_MANAGER_LOAD_DATA_STREAM;
    MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_STREAM      :: RESOURCE_MANAGER_FREE_DATA_STREAM;
    MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_STREAM      :: RESOURCE_MANAGER_PAGE_DATA_STREAM;
    MA_JOB_TYPE_RESOURCE_MANAGER_SEEK_DATA_STREAM      :: RESOURCE_MANAGER_SEEK_DATA_STREAM;

    MA_JOB_TYPE_DEVICE_AAUDIO_REROUTE                  :: DEVICE_AAUDIO_REROUTE;

    MA_JOB_TYPE_COUNT                                  :: COUNT;
}

ma_job :: struct {
    toc:   struct {
        breakup: struct {
            code:     ma_uint16; /* Job type. */
            slot:     ma_uint16; /* Index into a ma_slot_allocator. */
            refcount: ma_uint32;
        };

        #overlay (breakup) allocation: ma_uint64;
    }; /* 8 bytes. We encode the job code into the slot allocation data to save space. */

    next:  ma_uint64; /* refcount + slot for the next item. Does not include the job code. */
    order: ma_uint32; /* Execution order. Used to create a data dependency and ensure a job is executed in order. Usage is contextual depending on the job type. */

    data:  struct {
        resourceManager: struct {
            loadDataBuffer: struct {
                pDataBuffer:             *void; /*ma_resource_manager_data_buffer**/
                pInitNotification:       *ma_async_notification; /* Signalled when the data buffer has been initialized and the format/channels/rate can be retrieved. */
                pDoneNotification:       *ma_async_notification; /* Signalled when the data buffer has been fully decoded. */
                pInitFence:              *ma_fence; /* Released when the data buffer has been initialized and the format/channels/rate can be retrieved. */
                pDoneFence:              *ma_fence; /* Released when the data buffer has been fully decoded. */
                rangeBegInPCMFrames:     ma_uint64;
                rangeEndInPCMFrames:     ma_uint64;
                loopPointBegInPCMFrames: ma_uint64;
                loopPointEndInPCMFrames: ma_uint64;
                isLooping:               ma_uint32;
            }; // largest member, moved to the start of the struct/union to support #overlay.

            #overlay (loadDataBuffer) loadDataBufferNode: struct {
                pResourceManager:  *void; /*ma_resource_manager**/
                pDataBufferNode:   *void; /*ma_resource_manager_data_buffer_node**/
                pFilePath:         *u8;
                pFilePathW:        *s32;
                flags:             ma_uint32; /* Resource manager data source flags that were used when initializing the data buffer. */
                pInitNotification: *ma_async_notification; /* Signalled when the data buffer has been initialized and the format/channels/rate can be retrieved. */
                pDoneNotification: *ma_async_notification; /* Signalled when the data buffer has been fully decoded. Will be passed through to MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE when decoding. */
                pInitFence:        *ma_fence; /* Released when initialization of the decoder is complete. */
                pDoneFence:        *ma_fence; /* Released if initialization of the decoder fails. Passed through to PAGE_DATA_BUFFER_NODE untouched if init is successful. */
            };
            #overlay (loadDataBuffer) freeDataBufferNode: struct {
                pResourceManager:  *void; /*ma_resource_manager**/
                pDataBufferNode:   *void; /*ma_resource_manager_data_buffer_node**/
                pDoneNotification: *ma_async_notification;
                pDoneFence:        *ma_fence;
            };
            #overlay (loadDataBuffer) pageDataBufferNode: struct {
                pResourceManager:  *void; /*ma_resource_manager**/
                pDataBufferNode:   *void; /*ma_resource_manager_data_buffer_node**/
                pDecoder:          *void; /*ma_decoder**/
                pDoneNotification: *ma_async_notification; /* Signalled when the data buffer has been fully decoded. */
                pDoneFence:        *ma_fence; /* Passed through from LOAD_DATA_BUFFER_NODE and released when the data buffer completes decoding or an error occurs. */
            };
            #overlay (loadDataBuffer) freeDataBuffer:     struct {
                pDataBuffer:       *void; /*ma_resource_manager_data_buffer**/
                pDoneNotification: *ma_async_notification;
                pDoneFence:        *ma_fence;
            };
            #overlay (loadDataBuffer) loadDataStream:     struct {
                pDataStream:       *void; /*ma_resource_manager_data_stream**/
                pFilePath:         *u8; /* Allocated when the job is posted, freed by the job thread after loading. */
                pFilePathW:        *s32; /* ^ As above ^. Only used if pFilePath is NULL. */
                initialSeekPoint:  ma_uint64;
                pInitNotification: *ma_async_notification; /* Signalled after the first two pages have been decoded and frames can be read from the stream. */
                pInitFence:        *ma_fence;
            };
            #overlay (loadDataBuffer) freeDataStream:     struct {
                pDataStream:       *void; /*ma_resource_manager_data_stream**/
                pDoneNotification: *ma_async_notification;
                pDoneFence:        *ma_fence;
            };
            #overlay (loadDataBuffer) pageDataStream:     struct {
                pDataStream: *void; /*ma_resource_manager_data_stream**/
                pageIndex:   ma_uint32; /* The index of the page to decode into. */
            };
            #overlay (loadDataBuffer) seekDataStream:     struct {
                pDataStream: *void; /*ma_resource_manager_data_stream**/
                frameIndex:  ma_uint64;
            };
        }; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (resourceManager) custom: struct {
            proc:  ma_job_proc;
            data0: ma_uintptr;
            data1: ma_uintptr;
        };
        #overlay (resourceManager) device: struct {
            aaudio: struct {
                reroute: struct {
                    pDevice:    *void; /*ma_device**/
                    deviceType: ma_uint32; /*ma_device_type*/
                };
            };
        };
    };
}

ma_job_init :: (code: ma_uint16) -> ma_job #foreign libminiaudio;
ma_job_process :: (pJob: *ma_job) -> ma_result #foreign libminiaudio;

/*
When set, ma_job_queue_next() will not wait and no semaphore will be signaled in
ma_job_queue_post(). ma_job_queue_next() will return MA_NO_DATA_AVAILABLE if nothing is available.

This flag should always be used for platforms that do not support multithreading.
*/
ma_job_queue_flags :: enum u32 {
    MA_JOB_QUEUE_FLAG_NON_BLOCKING :: 1;
}

ma_job_queue_config :: struct {
    flags:    ma_uint32;
    capacity: ma_uint32; /* The maximum number of jobs that can fit in the queue at a time. */
}

ma_job_queue_config_init :: (flags: ma_uint32, capacity: ma_uint32) -> ma_job_queue_config #foreign libminiaudio;

ma_job_queue :: struct {
    flags:     ma_uint32; /* Flags passed in at initialization time. */
    capacity:  ma_uint32; /* The maximum number of jobs that can fit in the queue at a time. Set by the config. */
    head:      ma_uint64; /* The first item in the list. Required for removing from the top of the list. */
    tail:      ma_uint64; /* The last item in the list. Required for appending to the end of the list. */

    sem:       ma_semaphore; /* Only used when MA_JOB_QUEUE_FLAG_NON_BLOCKING is unset. */

    allocator: ma_slot_allocator;
    pJobs:     *ma_job;

    lock:      ma_spinlock;

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_job_queue_get_heap_size :: (pConfig: *ma_job_queue_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_job_queue_init_preallocated :: (pConfig: *ma_job_queue_config, pHeap: *void, pQueue: *ma_job_queue) -> ma_result #foreign libminiaudio;
ma_job_queue_init :: (pConfig: *ma_job_queue_config, pAllocationCallbacks: *ma_allocation_callbacks, pQueue: *ma_job_queue) -> ma_result #foreign libminiaudio;
ma_job_queue_uninit :: (pQueue: *ma_job_queue, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_job_queue_post :: (pQueue: *ma_job_queue, pJob: *ma_job) -> ma_result #foreign libminiaudio;
ma_job_queue_next :: (pQueue: *ma_job_queue, pJob: *ma_job) -> ma_result #foreign libminiaudio;

ma_device_state :: enum u32 {
    uninitialized :: 0;
    stopped       :: 1;
    started       :: 2;
    starting      :: 3;
    stopping      :: 4;

    ma_device_state_uninitialized :: uninitialized;
    ma_device_state_stopped       :: stopped;
    ma_device_state_started       :: started;
    ma_device_state_starting      :: starting;
    ma_device_state_stopping      :: stopping;
}

ma_atomic_device_state :: struct {
    value: ma_device_state;
}

/* Backend enums must be in priority order. */
ma_backend :: enum u32 {
    wasapi     :: 0;
    dsound     :: 1;
    winmm      :: 2;
    coreaudio  :: 3;
    sndio      :: 4;
    audio4     :: 5;
    oss        :: 6;
    pulseaudio :: 7;
    alsa       :: 8;
    jack       :: 9;
    aaudio     :: 10;
    opensl     :: 11;
    webaudio   :: 12;
    custom     :: 13;
    _null      :: 14;

    ma_backend_wasapi     :: wasapi;
    ma_backend_dsound     :: dsound;
    ma_backend_winmm      :: winmm;
    ma_backend_coreaudio  :: coreaudio;
    ma_backend_sndio      :: sndio;
    ma_backend_audio4     :: audio4;
    ma_backend_oss        :: oss;
    ma_backend_pulseaudio :: pulseaudio;
    ma_backend_alsa       :: alsa;
    ma_backend_jack       :: jack;
    ma_backend_aaudio     :: aaudio;
    ma_backend_opensl     :: opensl;
    ma_backend_webaudio   :: webaudio;
    ma_backend_custom     :: custom;
    ma_backend_null       :: _null;
}

/*
Device job thread. This is used by backends that require asynchronous processing of certain
operations. It is not used by all backends.

The device job thread is made up of a thread and a job queue. You can post a job to the thread with
ma_device_job_thread_post(). The thread will do the processing of the job.
*/
ma_device_job_thread_config :: struct {
    noThread:         ma_bool32; /* Set this to true if you want to process jobs yourself. */
    jobQueueCapacity: ma_uint32;
    jobQueueFlags:    ma_uint32;
}

ma_device_job_thread_config_init :: () -> ma_device_job_thread_config #foreign libminiaudio;

ma_device_job_thread :: struct {
    thread:     ma_thread;
    jobQueue:   ma_job_queue;
    _hasThread: ma_bool32;
}

ma_device_job_thread_init :: (pConfig: *ma_device_job_thread_config, pAllocationCallbacks: *ma_allocation_callbacks, pJobThread: *ma_device_job_thread) -> ma_result #foreign libminiaudio;
ma_device_job_thread_uninit :: (pJobThread: *ma_device_job_thread, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_device_job_thread_post :: (pJobThread: *ma_device_job_thread, pJob: *ma_job) -> ma_result #foreign libminiaudio;
ma_device_job_thread_next :: (pJobThread: *ma_device_job_thread, pJob: *ma_job) -> ma_result #foreign libminiaudio;

/* Device notification types. */
ma_device_notification_type :: enum u32 {
    started            :: 0;
    stopped            :: 1;
    rerouted           :: 2;
    interruption_began :: 3;
    interruption_ended :: 4;
    unlocked           :: 5;

    ma_device_notification_type_started            :: started;
    ma_device_notification_type_stopped            :: stopped;
    ma_device_notification_type_rerouted           :: rerouted;
    ma_device_notification_type_interruption_began :: interruption_began;
    ma_device_notification_type_interruption_ended :: interruption_ended;
    ma_device_notification_type_unlocked           :: unlocked;
}

ma_device_notification :: struct {
    pDevice: *ma_device;
    type:    ma_device_notification_type;
    data:    struct {
        started: struct {
            _unused: s32;
        };

        #overlay (started) stopped:      struct {
            _unused: s32;
        };
        #overlay (started) rerouted:     struct {
            _unused: s32;
        };
        #overlay (started) interruption: struct {
            _unused: s32;
        };
    };
}

/*
The notification callback for when the application should be notified of a change to the device.

This callback is used for notifying the application of changes such as when the device has started,
stopped, rerouted or an interruption has occurred. Note that not all backends will post all
notification types. For example, some backends will perform automatic stream routing without any
kind of notification to the host program which means miniaudio will never know about it and will
never be able to fire the rerouted notification. You should keep this in mind when designing your
program.

The stopped notification will *not* get fired when a device is rerouted.


Parameters
----------
pNotification (in)
A pointer to a structure containing information about the event. Use the `pDevice` member of
this object to retrieve the relevant device. The `type` member can be used to discriminate
against each of the notification types.


Remarks
-------
Do not restart or uninitialize the device from the callback.

Not all notifications will be triggered by all backends, however the started and stopped events
should be reliable for all backends. Some backends do not have a good way to detect device
stoppages due to unplugging the device which may result in the stopped callback not getting
fired. This has been observed with at least one BSD variant.

The rerouted notification is fired *after* the reroute has occurred. The stopped notification will
*not* get fired when a device is rerouted. The following backends are known to do automatic stream
rerouting, but do not have a way to be notified of the change:

* DirectSound

The interruption notifications are used on mobile platforms for detecting when audio is interrupted
due to things like an incoming phone call. Currently this is only implemented on iOS. None of the
Android backends will report this notification.
*/
ma_device_notification_proc :: #type (pNotification: *ma_device_notification) -> void #c_call;

/*
The callback for processing audio data from the device.

The data callback is fired by miniaudio whenever the device needs to have more data delivered to a playback device, or when a capture device has some data
available. This is called as soon as the backend asks for more data which means it may be called with inconsistent frame counts. You cannot assume the
callback will be fired with a consistent frame count.


Parameters
----------
pDevice (in)
A pointer to the relevant device.

pOutput (out)
A pointer to the output buffer that will receive audio data that will later be played back through the speakers. This will be non-null for a playback or
full-duplex device and null for a capture and loopback device.

pInput (in)
A pointer to the buffer containing input data from a recording device. This will be non-null for a capture, full-duplex or loopback device and null for a
playback device.

frameCount (in)
The number of PCM frames to process. Note that this will not necessarily be equal to what you requested when you initialized the device. The
`periodSizeInFrames` and `periodSizeInMilliseconds` members of the device config are just hints, and are not necessarily exactly what you'll get. You must
not assume this will always be the same value each time the callback is fired.


Remarks
-------
You cannot stop and start the device from inside the callback or else you'll get a deadlock. You must also not uninitialize the device from inside the
callback. The following APIs cannot be called from inside the callback:

ma_device_init()
ma_device_init_ex()
ma_device_uninit()
ma_device_start()
ma_device_stop()

The proper way to stop the device is to call `ma_device_stop()` from a different thread, normally the main application thread.
*/
ma_device_data_proc :: #type (pDevice: *ma_device, pOutput: *void, pInput: *void, frameCount: ma_uint32) -> void #c_call;

/*
DEPRECATED. Use ma_device_notification_proc instead.

The callback for when the device has been stopped.

This will be called when the device is stopped explicitly with `ma_device_stop()` and also called implicitly when the device is stopped through external forces
such as being unplugged or an internal error occurring.


Parameters
----------
pDevice (in)
A pointer to the device that has just stopped.


Remarks
-------
Do not restart or uninitialize the device from the callback.
*/
ma_stop_proc :: #type (pDevice: *ma_device) -> void #c_call;

ma_device_type :: enum u32 {
    playback :: 1;
    capture  :: 2;
    duplex   :: 3;
    loopback :: 4;

    ma_device_type_playback :: playback;
    ma_device_type_capture  :: capture;
    ma_device_type_duplex   :: duplex;
    ma_device_type_loopback :: loopback;
}

ma_share_mode :: enum u32 {
    shared    :: 0;
    exclusive :: 1;

    ma_share_mode_shared    :: shared;
    ma_share_mode_exclusive :: exclusive;
}

/* iOS/tvOS/watchOS session categories. */
ma_ios_session_category :: enum u32 {
    default         :: 0;
    none            :: 1;
    ambient         :: 2;
    solo_ambient    :: 3;
    playback        :: 4;
    record          :: 5;
    play_and_record :: 6;
    multi_route     :: 7;

    ma_ios_session_category_default         :: default;
    ma_ios_session_category_none            :: none;
    ma_ios_session_category_ambient         :: ambient;
    ma_ios_session_category_solo_ambient    :: solo_ambient;
    ma_ios_session_category_playback        :: playback;
    ma_ios_session_category_record          :: record;
    ma_ios_session_category_play_and_record :: play_and_record;
    ma_ios_session_category_multi_route     :: multi_route;
}

/* iOS/tvOS/watchOS session category options */
ma_ios_session_category_option :: enum u32 {
    mix_with_others                            :: 1;
    duck_others                                :: 2;
    allow_bluetooth                            :: 4;
    default_to_speaker                         :: 8;
    interrupt_spoken_audio_and_mix_with_others :: 17;
    allow_bluetooth_a2dp                       :: 32;
    allow_air_play                             :: 64;

    ma_ios_session_category_option_mix_with_others                            :: mix_with_others;
    ma_ios_session_category_option_duck_others                                :: duck_others;
    ma_ios_session_category_option_allow_bluetooth                            :: allow_bluetooth;
    ma_ios_session_category_option_default_to_speaker                         :: default_to_speaker;
    ma_ios_session_category_option_interrupt_spoken_audio_and_mix_with_others :: interrupt_spoken_audio_and_mix_with_others;
    ma_ios_session_category_option_allow_bluetooth_a2dp                       :: allow_bluetooth_a2dp;
    ma_ios_session_category_option_allow_air_play                             :: allow_air_play;
}

/* OpenSL stream types. */
ma_opensl_stream_type :: enum u32 {
    default      :: 0;
    voice        :: 1;
    system       :: 2;
    ring         :: 3;
    media        :: 4;
    alarm        :: 5;
    notification :: 6;

    ma_opensl_stream_type_default      :: default;
    ma_opensl_stream_type_voice        :: voice;
    ma_opensl_stream_type_system       :: system;
    ma_opensl_stream_type_ring         :: ring;
    ma_opensl_stream_type_media        :: media;
    ma_opensl_stream_type_alarm        :: alarm;
    ma_opensl_stream_type_notification :: notification;
}

/* OpenSL recording presets. */
ma_opensl_recording_preset :: enum u32 {
    default             :: 0;
    generic             :: 1;
    camcorder           :: 2;
    voice_recognition   :: 3;
    voice_communication :: 4;
    voice_unprocessed   :: 5;

    ma_opensl_recording_preset_default             :: default;
    ma_opensl_recording_preset_generic             :: generic;
    ma_opensl_recording_preset_camcorder           :: camcorder;
    ma_opensl_recording_preset_voice_recognition   :: voice_recognition;
    ma_opensl_recording_preset_voice_communication :: voice_communication;
    ma_opensl_recording_preset_voice_unprocessed   :: voice_unprocessed;
}

/* WASAPI audio thread priority characteristics. */
ma_wasapi_usage :: enum u32 {
    default   :: 0;
    games     :: 1;
    pro_audio :: 2;

    ma_wasapi_usage_default   :: default;
    ma_wasapi_usage_games     :: games;
    ma_wasapi_usage_pro_audio :: pro_audio;
}

/* AAudio usage types. */
ma_aaudio_usage :: enum u32 {
    default                        :: 0;
    media                          :: 1;
    voice_communication            :: 2;
    voice_communication_signalling :: 3;
    alarm                          :: 4;
    notification                   :: 5;
    notification_ringtone          :: 6;
    notification_event             :: 7;
    assistance_accessibility       :: 8;
    assistance_navigation_guidance :: 9;
    assistance_sonification        :: 10;
    game                           :: 11;
    assitant                       :: 12;
    emergency                      :: 13;
    safety                         :: 14;
    vehicle_status                 :: 15;
    announcement                   :: 16;

    ma_aaudio_usage_default                        :: default;
    ma_aaudio_usage_media                          :: media;
    ma_aaudio_usage_voice_communication            :: voice_communication;
    ma_aaudio_usage_voice_communication_signalling :: voice_communication_signalling;
    ma_aaudio_usage_alarm                          :: alarm;
    ma_aaudio_usage_notification                   :: notification;
    ma_aaudio_usage_notification_ringtone          :: notification_ringtone;
    ma_aaudio_usage_notification_event             :: notification_event;
    ma_aaudio_usage_assistance_accessibility       :: assistance_accessibility;
    ma_aaudio_usage_assistance_navigation_guidance :: assistance_navigation_guidance;
    ma_aaudio_usage_assistance_sonification        :: assistance_sonification;
    ma_aaudio_usage_game                           :: game;
    ma_aaudio_usage_assitant                       :: assitant;
    ma_aaudio_usage_emergency                      :: emergency;
    ma_aaudio_usage_safety                         :: safety;
    ma_aaudio_usage_vehicle_status                 :: vehicle_status;
    ma_aaudio_usage_announcement                   :: announcement;
}

/* AAudio content types. */
ma_aaudio_content_type :: enum u32 {
    default      :: 0;
    speech       :: 1;
    music        :: 2;
    movie        :: 3;
    sonification :: 4;

    ma_aaudio_content_type_default      :: default;
    ma_aaudio_content_type_speech       :: speech;
    ma_aaudio_content_type_music        :: music;
    ma_aaudio_content_type_movie        :: movie;
    ma_aaudio_content_type_sonification :: sonification;
}

/* AAudio input presets. */
ma_aaudio_input_preset :: enum u32 {
    default             :: 0;
    generic             :: 1;
    camcorder           :: 2;
    voice_recognition   :: 3;
    voice_communication :: 4;
    unprocessed         :: 5;
    voice_performance   :: 6;

    ma_aaudio_input_preset_default             :: default;
    ma_aaudio_input_preset_generic             :: generic;
    ma_aaudio_input_preset_camcorder           :: camcorder;
    ma_aaudio_input_preset_voice_recognition   :: voice_recognition;
    ma_aaudio_input_preset_voice_communication :: voice_communication;
    ma_aaudio_input_preset_unprocessed         :: unprocessed;
    ma_aaudio_input_preset_voice_performance   :: voice_performance;
}

ma_aaudio_allowed_capture_policy :: enum u32 {
    default   :: 0;
    by_all    :: 1;
    by_system :: 2;
    by_none   :: 3;

    ma_aaudio_allow_capture_default   :: default;
    ma_aaudio_allow_capture_by_all    :: by_all;
    ma_aaudio_allow_capture_by_system :: by_system;
    ma_aaudio_allow_capture_by_none   :: by_none;
}

ma_timer :: struct {
    counter: ma_int64;

    #overlay (counter) counterD: float64;
}

ma_device_id :: struct {
    alsa: [256] u8; // largest member, moved to the start of the struct/union to support #overlay. /* ALSA uses a name string for identification. */

    #overlay (alsa) wasapi:      [64] ma_wchar_win32; /* WASAPI uses a wchar_t string for identification. */
    #overlay (alsa) dsound:      [16] ma_uint8; /* DirectSound uses a GUID for identification. */
    #overlay (alsa) winmm:       ma_uint32; /* When creating a device, WinMM expects a Win32 UINT_PTR for device identification. In practice it's actually just a UINT. */
    #overlay (alsa) pulse:       [256] u8; /* PulseAudio uses a name string for identification. */
    #overlay (alsa) jack:        s32; /* JACK always uses default devices. */
    #overlay (alsa) coreaudio:   [256] u8; /* Core Audio uses a string for identification. */
    #overlay (alsa) sndio:       [256] u8; /* "snd/0", etc. */
    #overlay (alsa) audio4:      [256] u8; /* "/dev/audio", etc. */
    #overlay (alsa) oss:         [64] u8; /* "dev/dsp0", etc. "dev/dsp" for the default device. */
    #overlay (alsa) aaudio:      ma_int32; /* AAudio uses a 32-bit integer for identification. */
    #overlay (alsa) opensl:      ma_uint32; /* OpenSL|ES uses a 32-bit unsigned integer for identification. */
    #overlay (alsa) webaudio:    [32] u8; /* Web Audio always uses default devices for now, but if this changes it'll be a GUID. */
    #overlay (alsa) custom:      struct {
        s: [256] u8; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (s) i: s32;
        #overlay (s) p: *void;
    }; /* The custom backend could be anything. Give them a few options. */
    #overlay (alsa) nullbackend: s32; /* The null backend uses an integer for device IDs. */
}

ma_device_id_equal :: (pA: *ma_device_id, pB: *ma_device_id) -> ma_bool32 #foreign libminiaudio;

ma_device_info :: struct {
    /* Basic info. This is the only information guaranteed to be filled in during device enumeration. */
    id:                    ma_device_id;
    name:                  [256] u8; /* +1 for null terminator. */
    isDefault:             ma_bool32;

    nativeDataFormatCount: ma_uint32;
    nativeDataFormats:     [64] struct {
        format:     ma_format; /* Sample format. If set to ma_format_unknown, all sample formats are supported. */
        channels:   ma_uint32; /* If set to 0, all channels are supported. */
        sampleRate: ma_uint32; /* If set to 0, all sample rates are supported. */
        flags:      ma_uint32; /* A combination of MA_DATA_FORMAT_FLAG_* flags. */
    }; /*ma_format_count * ma_standard_sample_rate_count * MA_MAX_CHANNELS*/
}

ma_device_config :: struct {
    deviceType:                ma_device_type;
    sampleRate:                ma_uint32;
    periodSizeInFrames:        ma_uint32;
    periodSizeInMilliseconds:  ma_uint32;
    periods:                   ma_uint32;
    performanceProfile:        ma_performance_profile;
    noPreSilencedOutputBuffer: ma_bool8; /* When set to true, the contents of the output buffer passed into the data callback will be left undefined rather than initialized to silence. */
    noClip:                    ma_bool8; /* When set to true, the contents of the output buffer passed into the data callback will not be clipped after returning. Only applies when the playback sample format is f32. */
    noDisableDenormals:        ma_bool8; /* Do not disable denormals when firing the data callback. */
    noFixedSizedCallback:      ma_bool8; /* Disables strict fixed-sized data callbacks. Setting this to true will result in the period size being treated only as a hint to the backend. This is an optimization for those who don't need fixed sized callbacks. */
    dataCallback:              ma_device_data_proc;
    notificationCallback:      ma_device_notification_proc;
    stopCallback:              ma_stop_proc;
    pUserData:                 *void;
    resampling:                ma_resampler_config;
    playback:                  struct {
        pDeviceID:                       *ma_device_id;
        format:                          ma_format;
        channels:                        ma_uint32;
        pChannelMap:                     *ma_channel;
        channelMixMode:                  ma_channel_mix_mode;
        calculateLFEFromSpatialChannels: ma_bool32; /* When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present. */
        shareMode:                       ma_share_mode;
    };

    capture:                   struct {
        pDeviceID:                       *ma_device_id;
        format:                          ma_format;
        channels:                        ma_uint32;
        pChannelMap:                     *ma_channel;
        channelMixMode:                  ma_channel_mix_mode;
        calculateLFEFromSpatialChannels: ma_bool32; /* When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present. */
        shareMode:                       ma_share_mode;
    };

    wasapi:                    struct {
        usage:                  ma_wasapi_usage; /* When configured, uses Avrt APIs to set the thread characteristics. */
        noAutoConvertSRC:       ma_bool8; /* When set to true, disables the use of AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM. */
        noDefaultQualitySRC:    ma_bool8; /* When set to true, disables the use of AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY. */
        noAutoStreamRouting:    ma_bool8; /* Disables automatic stream routing. */
        noHardwareOffloading:   ma_bool8; /* Disables WASAPI's hardware offloading feature. */
        loopbackProcessID:      ma_uint32; /* The process ID to include or exclude for loopback mode. Set to 0 to capture audio from all processes. Ignored when an explicit device ID is specified. */
        loopbackProcessExclude: ma_bool8; /* When set to true, excludes the process specified by loopbackProcessID. By default, the process will be included. */
    };

    alsa:                      struct {
        noMMap:         ma_bool32; /* Disables MMap mode. */
        noAutoFormat:   ma_bool32; /* Opens the ALSA device with SND_PCM_NO_AUTO_FORMAT. */
        noAutoChannels: ma_bool32; /* Opens the ALSA device with SND_PCM_NO_AUTO_CHANNELS. */
        noAutoResample: ma_bool32; /* Opens the ALSA device with SND_PCM_NO_AUTO_RESAMPLE. */
    };

    pulse:                     struct {
        pStreamNamePlayback: *u8;
        pStreamNameCapture:  *u8;
        channelMap:          s32;
    };

    coreaudio:                 struct {
        allowNominalSampleRateChange: ma_bool32; /* Desktop only. When enabled, allows changing of the sample rate at the operating system level. */
    };

    opensl:                    struct {
        streamType:                     ma_opensl_stream_type;
        recordingPreset:                ma_opensl_recording_preset;
        enableCompatibilityWorkarounds: ma_bool32;
    };

    aaudio:                    struct {
        usage:                          ma_aaudio_usage;
        contentType:                    ma_aaudio_content_type;
        inputPreset:                    ma_aaudio_input_preset;
        allowedCapturePolicy:           ma_aaudio_allowed_capture_policy;
        noAutoStartAfterReroute:        ma_bool32;
        enableCompatibilityWorkarounds: ma_bool32;
        allowSetBufferCapacity:         ma_bool32;
    };
}

/*
The callback for handling device enumeration. This is fired from `ma_context_enumerate_devices()`.


Parameters
----------
pContext (in)
A pointer to the context performing the enumeration.

deviceType (in)
The type of the device being enumerated. This will always be either `ma_device_type_playback` or `ma_device_type_capture`.

pInfo (in)
A pointer to a `ma_device_info` containing the ID and name of the enumerated device. Note that this will not include detailed information about the device,
only basic information (ID and name). The reason for this is that it would otherwise require opening the backend device to probe for the information which
is too inefficient.

pUserData (in)
The user data pointer passed into `ma_context_enumerate_devices()`.
*/
ma_enum_devices_callback_proc :: #type (pContext: *ma_context, deviceType: ma_device_type, pInfo: *ma_device_info, pUserData: *void) -> ma_bool32 #c_call;

/*
Describes some basic details about a playback or capture device.
*/
ma_device_descriptor :: struct {
    pDeviceID:                *ma_device_id;
    shareMode:                ma_share_mode;
    format:                   ma_format;
    channels:                 ma_uint32;
    sampleRate:               ma_uint32;
    channelMap:               [254] ma_channel;
    periodSizeInFrames:       ma_uint32;
    periodSizeInMilliseconds: ma_uint32;
    periodCount:              ma_uint32;
}

/*
These are the callbacks required to be implemented for a backend. These callbacks are grouped into two parts: context and device. There is one context
to many devices. A device is created from a context.

The general flow goes like this:

1) A context is created with `onContextInit()`
1a) Available devices can be enumerated with `onContextEnumerateDevices()` if required.
1b) Detailed information about a device can be queried with `onContextGetDeviceInfo()` if required.
2) A device is created from the context that was created in the first step using `onDeviceInit()`, and optionally a device ID that was
selected from device enumeration via `onContextEnumerateDevices()`.
3) A device is started or stopped with `onDeviceStart()` / `onDeviceStop()`
4) Data is delivered to and from the device by the backend. This is always done based on the native format returned by the prior call
to `onDeviceInit()`. Conversion between the device's native format and the format requested by the application will be handled by
miniaudio internally.

Initialization of the context is quite simple. You need to do any necessary initialization of internal objects and then output the
callbacks defined in this structure.

Once the context has been initialized you can initialize a device. Before doing so, however, the application may want to know which
physical devices are available. This is where `onContextEnumerateDevices()` comes in. This is fairly simple. For each device, fire the
given callback with, at a minimum, the basic information filled out in `ma_device_info`. When the callback returns `MA_FALSE`, enumeration
needs to stop and the `onContextEnumerateDevices()` function returns with a success code.

Detailed device information can be retrieved from a device ID using `onContextGetDeviceInfo()`. This takes as input the device type and ID,
and on output returns detailed information about the device in `ma_device_info`. The `onContextGetDeviceInfo()` callback must handle the
case when the device ID is NULL, in which case information about the default device needs to be retrieved.

Once the context has been created and the device ID retrieved (if using anything other than the default device), the device can be created.
This is a little bit more complicated than initialization of the context due to its more complicated configuration. When initializing a
device, a duplex device may be requested. This means a separate data format needs to be specified for both playback and capture. On input,
the data format is set to what the application wants. On output it's set to the native format which should match as closely as possible to
the requested format. The conversion between the format requested by the application and the device's native format will be handled
internally by miniaudio.

On input, if the sample format is set to `ma_format_unknown`, the backend is free to use whatever sample format it desires, so long as it's
supported by miniaudio. When the channel count is set to 0, the backend should use the device's native channel count. The same applies for
sample rate. For the channel map, the default should be used when `ma_channel_map_is_blank()` returns true (all channels set to
`MA_CHANNEL_NONE`). On input, the `periodSizeInFrames` or `periodSizeInMilliseconds` option should always be set. The backend should
inspect both of these variables. If `periodSizeInFrames` is set, it should take priority, otherwise it needs to be derived from the period
size in milliseconds (`periodSizeInMilliseconds`) and the sample rate, keeping in mind that the sample rate may be 0, in which case the
sample rate will need to be determined before calculating the period size in frames. On output, all members of the `ma_device_descriptor`
object should be set to a valid value, except for `periodSizeInMilliseconds` which is optional (`periodSizeInFrames` *must* be set).

Starting and stopping of the device is done with `onDeviceStart()` and `onDeviceStop()` and should be self-explanatory. If the backend uses
asynchronous reading and writing, `onDeviceStart()` and `onDeviceStop()` should always be implemented.

The handling of data delivery between the application and the device is the most complicated part of the process. To make this a bit
easier, some helper callbacks are available. If the backend uses a blocking read/write style of API, the `onDeviceRead()` and
`onDeviceWrite()` callbacks can optionally be implemented. These are blocking and work just like reading and writing from a file. If the
backend uses a callback for data delivery, that callback must call `ma_device_handle_backend_data_callback()` from within its callback.
This allows miniaudio to then process any necessary data conversion and then pass it to the miniaudio data callback.

If the backend requires absolute flexibility with its data delivery, it can optionally implement the `onDeviceDataLoop()` callback
which will allow it to implement the logic that will run on the audio thread. This is much more advanced and is completely optional.

The audio thread should run data delivery logic in a loop while `ma_device_get_state() == ma_device_state_started` and no errors have been
encountered. Do not start or stop the device here. That will be handled from outside the `onDeviceDataLoop()` callback.

The invocation of the `onDeviceDataLoop()` callback will be handled by miniaudio. When you start the device, miniaudio will fire this
callback. When the device is stopped, the `ma_device_get_state() == ma_device_state_started` condition will fail and the loop will be terminated
which will then fall through to the part that stops the device. For an example on how to implement the `onDeviceDataLoop()` callback,
look at `ma_device_audio_thread__default_read_write()`. Implement the `onDeviceDataLoopWakeup()` callback if you need a mechanism to
wake up the audio thread.

If the backend supports an optimized retrieval of device information from an initialized `ma_device` object, it should implement the
`onDeviceGetInfo()` callback. This is optional, in which case it will fall back to `onContextGetDeviceInfo()` which is less efficient.
*/
ma_backend_callbacks :: struct {
    onContextInit:             #type (pContext: *ma_context, pConfig: *ma_context_config, pCallbacks: *ma_backend_callbacks) -> ma_result #c_call;
    onContextUninit:           #type (pContext: *ma_context) -> ma_result #c_call;
    onContextEnumerateDevices: #type (pContext: *ma_context, callback: ma_enum_devices_callback_proc, pUserData: *void) -> ma_result #c_call;
    onContextGetDeviceInfo:    #type (pContext: *ma_context, deviceType: ma_device_type, pDeviceID: *ma_device_id, pDeviceInfo: *ma_device_info) -> ma_result #c_call;
    onDeviceInit:              #type (pDevice: *ma_device, pConfig: *ma_device_config, pDescriptorPlayback: *ma_device_descriptor, pDescriptorCapture: *ma_device_descriptor) -> ma_result #c_call;
    onDeviceUninit:            #type (pDevice: *ma_device) -> ma_result #c_call;
    onDeviceStart:             #type (pDevice: *ma_device) -> ma_result #c_call;
    onDeviceStop:              #type (pDevice: *ma_device) -> ma_result #c_call;
    onDeviceRead:              #type (pDevice: *ma_device, pFrames: *void, frameCount: ma_uint32, pFramesRead: *ma_uint32) -> ma_result #c_call;
    onDeviceWrite:             #type (pDevice: *ma_device, pFrames: *void, frameCount: ma_uint32, pFramesWritten: *ma_uint32) -> ma_result #c_call;
    onDeviceDataLoop:          #type (pDevice: *ma_device) -> ma_result #c_call;
    onDeviceDataLoopWakeup:    #type (pDevice: *ma_device) -> ma_result #c_call;
    onDeviceGetInfo:           #type (pDevice: *ma_device, type: ma_device_type, pDeviceInfo: *ma_device_info) -> ma_result #c_call;
}

ma_context_config :: struct {
    pLog:                *ma_log;
    threadPriority:      ma_thread_priority;
    threadStackSize:     u64;
    pUserData:           *void;
    allocationCallbacks: ma_allocation_callbacks;
    dsound:              struct {
        hWnd: ma_handle; /* HWND. Optional window handle to pass into SetCooperativeLevel(). Will default to the foreground window, and if that fails, the desktop window. */
    };

    alsa:                struct {
        useVerboseDeviceEnumeration: ma_bool32;
    };

    pulse:               struct {
        pApplicationName: *u8;
        pServerName:      *u8;
        tryAutoSpawn:     ma_bool32; /* Enables autospawning of the PulseAudio daemon if necessary. */
    };

    coreaudio:           struct {
        sessionCategory:          ma_ios_session_category;
        sessionCategoryOptions:   ma_uint32;
        noAudioSessionActivate:   ma_bool32; /* iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:true] on initialization. */
        noAudioSessionDeactivate: ma_bool32; /* iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:false] on uninitialization. */
    };

    jack:                struct {
        pClientName:    *u8;
        tryStartServer: ma_bool32;
    };

    custom:              ma_backend_callbacks;
}

/* WASAPI specific structure for some commands which must run on a common thread due to bugs in WASAPI. */
ma_context_command__wasapi :: struct {
    code:   s32;
    pEvent: *ma_event; /* This will be signalled when the event is complete. */
    data:   struct {
        createAudioClient: struct {
            deviceType:           ma_device_type;
            pAudioClient:         *void;
            ppAudioClientService: **void;
            pResult:              *ma_result; /* The result from creating the audio client service. */
        }; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (createAudioClient) quit:               struct {
            _unused: s32;
        };
        #overlay (createAudioClient) releaseAudioClient: struct {
            pDevice:    *ma_device;
            deviceType: ma_device_type;
        };
    };
}

ma_context :: struct {
    callbacks:               ma_backend_callbacks;
    backend:                 ma_backend; /* DirectSound, ALSA, etc. */
    pLog:                    *ma_log;
    log:                     ma_log; /* Only used if the log is owned by the context. The pLog member will be set to &log in this case. */
    threadPriority:          ma_thread_priority;
    threadStackSize:         u64;
    pUserData:               *void;
    allocationCallbacks:     ma_allocation_callbacks;
    deviceEnumLock:          ma_mutex; /* Used to make ma_context_get_devices() thread safe. */
    deviceInfoLock:          ma_mutex; /* Used to make ma_context_get_device_info() thread safe. */
    deviceInfoCapacity:      ma_uint32; /* Total capacity of pDeviceInfos. */
    playbackDeviceInfoCount: ma_uint32;
    captureDeviceInfoCount:  ma_uint32;
    pDeviceInfos:            *ma_device_info; /* Playback devices first, then capture. */

    struct {
        alsa: struct {
            asoundSO:                               ma_handle;
            snd_pcm_open:                           ma_proc;
            snd_pcm_close:                          ma_proc;
            snd_pcm_hw_params_sizeof:               ma_proc;
            snd_pcm_hw_params_any:                  ma_proc;
            snd_pcm_hw_params_set_format:           ma_proc;
            snd_pcm_hw_params_set_format_first:     ma_proc;
            snd_pcm_hw_params_get_format_mask:      ma_proc;
            snd_pcm_hw_params_set_channels:         ma_proc;
            snd_pcm_hw_params_set_channels_near:    ma_proc;
            snd_pcm_hw_params_set_channels_minmax:  ma_proc;
            snd_pcm_hw_params_set_rate_resample:    ma_proc;
            snd_pcm_hw_params_set_rate:             ma_proc;
            snd_pcm_hw_params_set_rate_near:        ma_proc;
            snd_pcm_hw_params_set_rate_minmax:      ma_proc;
            snd_pcm_hw_params_set_buffer_size_near: ma_proc;
            snd_pcm_hw_params_set_periods_near:     ma_proc;
            snd_pcm_hw_params_set_access:           ma_proc;
            snd_pcm_hw_params_get_format:           ma_proc;
            snd_pcm_hw_params_get_channels:         ma_proc;
            snd_pcm_hw_params_get_channels_min:     ma_proc;
            snd_pcm_hw_params_get_channels_max:     ma_proc;
            snd_pcm_hw_params_get_rate:             ma_proc;
            snd_pcm_hw_params_get_rate_min:         ma_proc;
            snd_pcm_hw_params_get_rate_max:         ma_proc;
            snd_pcm_hw_params_get_buffer_size:      ma_proc;
            snd_pcm_hw_params_get_periods:          ma_proc;
            snd_pcm_hw_params_get_access:           ma_proc;
            snd_pcm_hw_params_test_format:          ma_proc;
            snd_pcm_hw_params_test_channels:        ma_proc;
            snd_pcm_hw_params_test_rate:            ma_proc;
            snd_pcm_hw_params:                      ma_proc;
            snd_pcm_sw_params_sizeof:               ma_proc;
            snd_pcm_sw_params_current:              ma_proc;
            snd_pcm_sw_params_get_boundary:         ma_proc;
            snd_pcm_sw_params_set_avail_min:        ma_proc;
            snd_pcm_sw_params_set_start_threshold:  ma_proc;
            snd_pcm_sw_params_set_stop_threshold:   ma_proc;
            snd_pcm_sw_params:                      ma_proc;
            snd_pcm_format_mask_sizeof:             ma_proc;
            snd_pcm_format_mask_test:               ma_proc;
            snd_pcm_get_chmap:                      ma_proc;
            snd_pcm_state:                          ma_proc;
            snd_pcm_prepare:                        ma_proc;
            snd_pcm_start:                          ma_proc;
            snd_pcm_drop:                           ma_proc;
            snd_pcm_drain:                          ma_proc;
            snd_pcm_reset:                          ma_proc;
            snd_device_name_hint:                   ma_proc;
            snd_device_name_get_hint:               ma_proc;
            snd_card_get_index:                     ma_proc;
            snd_device_name_free_hint:              ma_proc;
            snd_pcm_mmap_begin:                     ma_proc;
            snd_pcm_mmap_commit:                    ma_proc;
            snd_pcm_recover:                        ma_proc;
            snd_pcm_readi:                          ma_proc;
            snd_pcm_writei:                         ma_proc;
            snd_pcm_avail:                          ma_proc;
            snd_pcm_avail_update:                   ma_proc;
            snd_pcm_wait:                           ma_proc;
            snd_pcm_nonblock:                       ma_proc;
            snd_pcm_info:                           ma_proc;
            snd_pcm_info_sizeof:                    ma_proc;
            snd_pcm_info_get_name:                  ma_proc;
            snd_pcm_poll_descriptors:               ma_proc;
            snd_pcm_poll_descriptors_count:         ma_proc;
            snd_pcm_poll_descriptors_revents:       ma_proc;
            snd_config_update_free_global:          ma_proc;

            internalDeviceEnumLock:                 ma_mutex;
            useVerboseDeviceEnumeration:            ma_bool32;
        };

        #overlay (alsa) pulse:        struct {
            pulseSO:                            ma_handle;
            pa_mainloop_new:                    ma_proc;
            pa_mainloop_free:                   ma_proc;
            pa_mainloop_quit:                   ma_proc;
            pa_mainloop_get_api:                ma_proc;
            pa_mainloop_iterate:                ma_proc;
            pa_mainloop_wakeup:                 ma_proc;
            pa_threaded_mainloop_new:           ma_proc;
            pa_threaded_mainloop_free:          ma_proc;
            pa_threaded_mainloop_start:         ma_proc;
            pa_threaded_mainloop_stop:          ma_proc;
            pa_threaded_mainloop_lock:          ma_proc;
            pa_threaded_mainloop_unlock:        ma_proc;
            pa_threaded_mainloop_wait:          ma_proc;
            pa_threaded_mainloop_signal:        ma_proc;
            pa_threaded_mainloop_accept:        ma_proc;
            pa_threaded_mainloop_get_retval:    ma_proc;
            pa_threaded_mainloop_get_api:       ma_proc;
            pa_threaded_mainloop_in_thread:     ma_proc;
            pa_threaded_mainloop_set_name:      ma_proc;
            pa_context_new:                     ma_proc;
            pa_context_unref:                   ma_proc;
            pa_context_connect:                 ma_proc;
            pa_context_disconnect:              ma_proc;
            pa_context_set_state_callback:      ma_proc;
            pa_context_get_state:               ma_proc;
            pa_context_get_sink_info_list:      ma_proc;
            pa_context_get_source_info_list:    ma_proc;
            pa_context_get_sink_info_by_name:   ma_proc;
            pa_context_get_source_info_by_name: ma_proc;
            pa_operation_unref:                 ma_proc;
            pa_operation_get_state:             ma_proc;
            pa_channel_map_init_extend:         ma_proc;
            pa_channel_map_valid:               ma_proc;
            pa_channel_map_compatible:          ma_proc;
            pa_stream_new:                      ma_proc;
            pa_stream_unref:                    ma_proc;
            pa_stream_connect_playback:         ma_proc;
            pa_stream_connect_record:           ma_proc;
            pa_stream_disconnect:               ma_proc;
            pa_stream_get_state:                ma_proc;
            pa_stream_get_sample_spec:          ma_proc;
            pa_stream_get_channel_map:          ma_proc;
            pa_stream_get_buffer_attr:          ma_proc;
            pa_stream_set_buffer_attr:          ma_proc;
            pa_stream_get_device_name:          ma_proc;
            pa_stream_set_write_callback:       ma_proc;
            pa_stream_set_read_callback:        ma_proc;
            pa_stream_set_suspended_callback:   ma_proc;
            pa_stream_set_moved_callback:       ma_proc;
            pa_stream_is_suspended:             ma_proc;
            pa_stream_flush:                    ma_proc;
            pa_stream_drain:                    ma_proc;
            pa_stream_is_corked:                ma_proc;
            pa_stream_cork:                     ma_proc;
            pa_stream_trigger:                  ma_proc;
            pa_stream_begin_write:              ma_proc;
            pa_stream_write:                    ma_proc;
            pa_stream_peek:                     ma_proc;
            pa_stream_drop:                     ma_proc;
            pa_stream_writable_size:            ma_proc;
            pa_stream_readable_size:            ma_proc;

            pMainLoop:                          ma_ptr; /*pa_mainloop**/
            pPulseContext:                      ma_ptr; /*pa_context**/
            pApplicationName:                   *u8; /* Set when the context is initialized. Used by devices for their local pa_context objects. */
            pServerName:                        *u8; /* Set when the context is initialized. Used by devices for their local pa_context objects. */
        };
        #overlay (alsa) jack:         struct {
            jackSO:                        ma_handle;
            jack_client_open:              ma_proc;
            jack_client_close:             ma_proc;
            jack_client_name_size:         ma_proc;
            jack_set_process_callback:     ma_proc;
            jack_set_buffer_size_callback: ma_proc;
            jack_on_shutdown:              ma_proc;
            jack_get_sample_rate:          ma_proc;
            jack_get_buffer_size:          ma_proc;
            jack_get_ports:                ma_proc;
            jack_activate:                 ma_proc;
            jack_deactivate:               ma_proc;
            jack_connect:                  ma_proc;
            jack_port_register:            ma_proc;
            jack_port_name:                ma_proc;
            jack_port_get_buffer:          ma_proc;
            jack_free:                     ma_proc;

            pClientName:                   *u8;
            tryStartServer:                ma_bool32;
        };
        #overlay (alsa) null_backend: struct {
            _unused: s32;
        };
    }

    struct {
        posix: struct {
            _unused: s32;
        };

        #overlay (posix) _unused: s32;
    }
}

ma_device :: struct {
    pContext:                  *ma_context;
    type:                      ma_device_type;
    sampleRate:                ma_uint32;
    state:                     ma_atomic_device_state; /* The state of the device is variable and can change at any time on any thread. Must be used atomically. */
    onData:                    ma_device_data_proc; /* Set once at initialization time and should not be changed after. */
    onNotification:            ma_device_notification_proc; /* Set once at initialization time and should not be changed after. */
    onStop:                    ma_stop_proc; /* DEPRECATED. Use the notification callback instead. Set once at initialization time and should not be changed after. */
    pUserData:                 *void; /* Application defined data. */
    startStopLock:             ma_mutex;
    wakeupEvent:               ma_event;
    startEvent:                ma_event;
    stopEvent:                 ma_event;
    thread:                    ma_thread;
    workResult:                ma_result; /* This is set by the worker thread after it's finished doing a job. */
    isOwnerOfContext:          ma_bool8; /* When set to true, uninitializing the device will also uninitialize the context. Set to true when NULL is passed into ma_device_init(). */
    noPreSilencedOutputBuffer: ma_bool8;
    noClip:                    ma_bool8;
    noDisableDenormals:        ma_bool8;
    noFixedSizedCallback:      ma_bool8;
    masterVolumeFactor:        ma_atomic_float; /* Linear 0..1. Can be read and written simultaneously by different threads. Must be used atomically. */
    duplexRB:                  ma_duplex_rb; /* Intermediary buffer for duplex device on asynchronous backends. */
    resampling:                struct {
        algorithm:        ma_resample_algorithm;
        pBackendVTable:   *ma_resampling_backend_vtable;
        pBackendUserData: *void;
        linear:           struct {
            lpfOrder: ma_uint32;
        };
    };

    playback:                  struct {
        pID:                             *ma_device_id; /* Set to NULL if using default ID, otherwise set to the address of "id". */
        id:                              ma_device_id; /* If using an explicit device, will be set to a copy of the ID used for initialization. Otherwise cleared to 0. */
        name:                            [256] u8; /* Maybe temporary. Likely to be replaced with a query API. */
        shareMode:                       ma_share_mode; /* Set to whatever was passed in when the device was initialized. */
        format:                          ma_format;
        channels:                        ma_uint32;
        channelMap:                      [254] ma_channel;
        internalFormat:                  ma_format;
        internalChannels:                ma_uint32;
        internalSampleRate:              ma_uint32;
        internalChannelMap:              [254] ma_channel;
        internalPeriodSizeInFrames:      ma_uint32;
        internalPeriods:                 ma_uint32;
        channelMixMode:                  ma_channel_mix_mode;
        calculateLFEFromSpatialChannels: ma_bool32;
        converter:                       ma_data_converter;
        pIntermediaryBuffer:             *void; /* For implementing fixed sized buffer callbacks. Will be null if using variable sized callbacks. */
        intermediaryBufferCap:           ma_uint32;
        intermediaryBufferLen:           ma_uint32; /* How many valid frames are sitting in the intermediary buffer. */
        pInputCache:                     *void; /* In external format. Can be null. */
        inputCacheCap:                   ma_uint64;
        inputCacheConsumed:              ma_uint64;
        inputCacheRemaining:             ma_uint64;
    };

    capture:                   struct {
        pID:                             *ma_device_id; /* Set to NULL if using default ID, otherwise set to the address of "id". */
        id:                              ma_device_id; /* If using an explicit device, will be set to a copy of the ID used for initialization. Otherwise cleared to 0. */
        name:                            [256] u8; /* Maybe temporary. Likely to be replaced with a query API. */
        shareMode:                       ma_share_mode; /* Set to whatever was passed in when the device was initialized. */
        format:                          ma_format;
        channels:                        ma_uint32;
        channelMap:                      [254] ma_channel;
        internalFormat:                  ma_format;
        internalChannels:                ma_uint32;
        internalSampleRate:              ma_uint32;
        internalChannelMap:              [254] ma_channel;
        internalPeriodSizeInFrames:      ma_uint32;
        internalPeriods:                 ma_uint32;
        channelMixMode:                  ma_channel_mix_mode;
        calculateLFEFromSpatialChannels: ma_bool32;
        converter:                       ma_data_converter;
        pIntermediaryBuffer:             *void; /* For implementing fixed sized buffer callbacks. Will be null if using variable sized callbacks. */
        intermediaryBufferCap:           ma_uint32;
        intermediaryBufferLen:           ma_uint32; /* How many valid frames are sitting in the intermediary buffer. */
    };

    struct {
        null_device: struct {
            deviceThread:                         ma_thread;
            operationEvent:                       ma_event;
            operationCompletionEvent:             ma_event;
            operationSemaphore:                   ma_semaphore;
            operation:                            ma_uint32;
            operationResult:                      ma_result;
            timer:                                ma_timer;
            priorRunTime:                         float64;
            currentPeriodFramesRemainingPlayback: ma_uint32;
            currentPeriodFramesRemainingCapture:  ma_uint32;
            lastProcessedFramePlayback:           ma_uint64;
            lastProcessedFrameCapture:            ma_uint64;
            isStarted:                            ma_atomic_bool32; /* Read and written by multiple threads. Must be used atomically, and must be 32-bit for compiler compatibility. */
        }; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (null_device) alsa:  struct {
            pPCMPlayback:                ma_ptr; /*snd_pcm_t**/
            pPCMCapture:                 ma_ptr; /*snd_pcm_t**/
            pPollDescriptorsPlayback:    *void; /*struct pollfd**/
            pPollDescriptorsCapture:     *void; /*struct pollfd**/
            pollDescriptorCountPlayback: s32;
            pollDescriptorCountCapture:  s32;
            wakeupfdPlayback:            s32; /* eventfd for waking up from poll() when the playback device is stopped. */
            wakeupfdCapture:             s32; /* eventfd for waking up from poll() when the capture device is stopped. */
            isUsingMMapPlayback:         ma_bool8;
            isUsingMMapCapture:          ma_bool8;
        };
        #overlay (null_device) pulse: struct {
            pMainLoop:       ma_ptr; /*pa_mainloop**/
            pPulseContext:   ma_ptr; /*pa_context**/
            pStreamPlayback: ma_ptr; /*pa_stream**/
            pStreamCapture:  ma_ptr; /*pa_stream**/
        };
        #overlay (null_device) jack:  struct {
            pClient:                     ma_ptr; /*jack_client_t**/
            ppPortsPlayback:             *ma_ptr; /*jack_port_t**/
            ppPortsCapture:              *ma_ptr; /*jack_port_t**/
            pIntermediaryBufferPlayback: *float; /* Typed as a float because JACK is always floating point. */
            pIntermediaryBufferCapture:  *float;
        };
    }
}

/*
Initializes a `ma_context_config` object.


Return Value
------------
A `ma_context_config` initialized to defaults.


Remarks
-------
You must always use this to initialize the default state of the `ma_context_config` object. Not using this will result in your program breaking when miniaudio
is updated and new members are added to `ma_context_config`. It also sets logical defaults.

You can override members of the returned object by changing it's members directly.


See Also
--------
ma_context_init()
*/
ma_context_config_init :: () -> ma_context_config #foreign libminiaudio;

/*
Initializes a context.

The context is used for selecting and initializing an appropriate backend and to represent the backend at a more global level than that of an individual
device. There is one context to many devices, and a device is created from a context. A context is required to enumerate devices.


Parameters
----------
backends (in, optional)
A list of backends to try initializing, in priority order. Can be NULL, in which case it uses default priority order.

backendCount (in, optional)
The number of items in `backend`. Ignored if `backend` is NULL.

pConfig (in, optional)
The context configuration.

pContext (in)
A pointer to the context object being initialized.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. Do not call this function across multiple threads as some backends read and write to global state.


Remarks
-------
When `backends` is NULL, the default priority order will be used. Below is a list of backends in priority order:

|-------------|-----------------------|--------------------------------------------------------|
| Name        | Enum Name             | Supported Operating Systems                            |
|-------------|-----------------------|--------------------------------------------------------|
| WASAPI      | ma_backend_wasapi     | Windows Vista+                                         |
| DirectSound | ma_backend_dsound     | Windows XP+                                            |
| WinMM       | ma_backend_winmm      | Windows XP+ (may work on older versions, but untested) |
| Core Audio  | ma_backend_coreaudio  | macOS, iOS                                             |
| ALSA        | ma_backend_alsa       | Linux                                                  |
| PulseAudio  | ma_backend_pulseaudio | Cross Platform (disabled on Windows, BSD and Android)  |
| JACK        | ma_backend_jack       | Cross Platform (disabled on BSD and Android)           |
| sndio       | ma_backend_sndio      | OpenBSD                                                |
| audio(4)    | ma_backend_audio4     | NetBSD, OpenBSD                                        |
| OSS         | ma_backend_oss        | FreeBSD                                                |
| AAudio      | ma_backend_aaudio     | Android 8+                                             |
| OpenSL|ES   | ma_backend_opensl     | Android (API level 16+)                                |
| Web Audio   | ma_backend_webaudio   | Web (via Emscripten)                                   |
| Null        | ma_backend_null       | Cross Platform (not used on Web)                       |
|-------------|-----------------------|--------------------------------------------------------|

The context can be configured via the `pConfig` argument. The config object is initialized with `ma_context_config_init()`. Individual configuration settings
can then be set directly on the structure. Below are the members of the `ma_context_config` object.

pLog
A pointer to the `ma_log` to post log messages to. Can be NULL if the application does not
require logging. See the `ma_log` API for details on how to use the logging system.

threadPriority
The desired priority to use for the audio thread. Allowable values include the following:

|--------------------------------------|
| Thread Priority                      |
|--------------------------------------|
| ma_thread_priority_idle              |
| ma_thread_priority_lowest            |
| ma_thread_priority_low               |
| ma_thread_priority_normal            |
| ma_thread_priority_high              |
| ma_thread_priority_highest (default) |
| ma_thread_priority_realtime          |
| ma_thread_priority_default           |
|--------------------------------------|

threadStackSize
The desired size of the stack for the audio thread. Defaults to the operating system's default.

pUserData
A pointer to application-defined data. This can be accessed from the context object directly such as `context.pUserData`.

allocationCallbacks
Structure containing custom allocation callbacks. Leaving this at defaults will cause it to use MA_MALLOC, MA_REALLOC and MA_FREE. These allocation
callbacks will be used for anything tied to the context, including devices.

alsa.useVerboseDeviceEnumeration
ALSA will typically enumerate many different devices which can be intrusive and not user-friendly. To combat this, miniaudio will enumerate only unique
card/device pairs by default. The problem with this is that you lose a bit of flexibility and control. Setting alsa.useVerboseDeviceEnumeration makes
it so the ALSA backend includes all devices. Defaults to false.

pulse.pApplicationName
PulseAudio only. The application name to use when initializing the PulseAudio context with `pa_context_new()`.

pulse.pServerName
PulseAudio only. The name of the server to connect to with `pa_context_connect()`.

pulse.tryAutoSpawn
PulseAudio only. Whether or not to try automatically starting the PulseAudio daemon. Defaults to false. If you set this to true, keep in mind that
miniaudio uses a trial and error method to find the most appropriate backend, and this will result in the PulseAudio daemon starting which may be
intrusive for the end user.

coreaudio.sessionCategory
iOS only. The session category to use for the shared AudioSession instance. Below is a list of allowable values and their Core Audio equivalents.

|-----------------------------------------|-------------------------------------|
| miniaudio Token                         | Core Audio Token                    |
|-----------------------------------------|-------------------------------------|
| ma_ios_session_category_ambient         | AVAudioSessionCategoryAmbient       |
| ma_ios_session_category_solo_ambient    | AVAudioSessionCategorySoloAmbient   |
| ma_ios_session_category_playback        | AVAudioSessionCategoryPlayback      |
| ma_ios_session_category_record          | AVAudioSessionCategoryRecord        |
| ma_ios_session_category_play_and_record | AVAudioSessionCategoryPlayAndRecord |
| ma_ios_session_category_multi_route     | AVAudioSessionCategoryMultiRoute    |
| ma_ios_session_category_none            | AVAudioSessionCategoryAmbient       |
| ma_ios_session_category_default         | AVAudioSessionCategoryAmbient       |
|-----------------------------------------|-------------------------------------|

coreaudio.sessionCategoryOptions
iOS only. Session category options to use with the shared AudioSession instance. Below is a list of allowable values and their Core Audio equivalents.

|---------------------------------------------------------------------------|------------------------------------------------------------------|
| miniaudio Token                                                           | Core Audio Token                                                 |
|---------------------------------------------------------------------------|------------------------------------------------------------------|
| ma_ios_session_category_option_mix_with_others                            | AVAudioSessionCategoryOptionMixWithOthers                        |
| ma_ios_session_category_option_duck_others                                | AVAudioSessionCategoryOptionDuckOthers                           |
| ma_ios_session_category_option_allow_bluetooth                            | AVAudioSessionCategoryOptionAllowBluetooth                       |
| ma_ios_session_category_option_default_to_speaker                         | AVAudioSessionCategoryOptionDefaultToSpeaker                     |
| ma_ios_session_category_option_interrupt_spoken_audio_and_mix_with_others | AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers |
| ma_ios_session_category_option_allow_bluetooth_a2dp                       | AVAudioSessionCategoryOptionAllowBluetoothA2DP                   |
| ma_ios_session_category_option_allow_air_play                             | AVAudioSessionCategoryOptionAllowAirPlay                         |
|---------------------------------------------------------------------------|------------------------------------------------------------------|

coreaudio.noAudioSessionActivate
iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:true] on initialization.

coreaudio.noAudioSessionDeactivate
iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:false] on uninitialization.

jack.pClientName
The name of the client to pass to `jack_client_open()`.

jack.tryStartServer
Whether or not to try auto-starting the JACK server. Defaults to false.


It is recommended that only a single context is active at any given time because it's a bulky data structure which performs run-time linking for the
relevant backends every time it's initialized.

The location of the context cannot change throughout it's lifetime. Consider allocating the `ma_context` object with `malloc()` if this is an issue. The
reason for this is that a pointer to the context is stored in the `ma_device` structure.


Example 1 - Default Initialization
----------------------------------
The example below shows how to initialize the context using the default configuration.

```c
ma_context context;
ma_result result = ma_context_init(NULL, 0, NULL, &context);
if (result != MA_SUCCESS) {
// Error.
}
```


Example 2 - Custom Configuration
--------------------------------
The example below shows how to initialize the context using custom backend priorities and a custom configuration. In this hypothetical example, the program
wants to prioritize ALSA over PulseAudio on Linux. They also want to avoid using the WinMM backend on Windows because it's latency is too high. They also
want an error to be returned if no valid backend is available which they achieve by excluding the Null backend.

For the configuration, the program wants to capture any log messages so they can, for example, route it to a log file and user interface.

```c
ma_backend backends[] = {
ma_backend_alsa,
ma_backend_pulseaudio,
ma_backend_wasapi,
ma_backend_dsound
};

ma_log log;
ma_log_init(&log);
ma_log_register_callback(&log, ma_log_callback_init(my_log_callbac, pMyLogUserData));

ma_context_config config = ma_context_config_init();
config.pLog = &log; // Specify a custom log object in the config so any logs that are posted from ma_context_init() are captured.

ma_context context;
ma_result result = ma_context_init(backends, sizeof(backends)/sizeof(backends[0]), &config, &context);
if (result != MA_SUCCESS) {
// Error.
if (result == MA_NO_BACKEND) {
// Couldn't find an appropriate backend.
}
}

// You could also attach a log callback post-initialization:
ma_log_register_callback(ma_context_get_log(&context), ma_log_callback_init(my_log_callback, pMyLogUserData));
```


See Also
--------
ma_context_config_init()
ma_context_uninit()
*/
ma_context_init :: (backends: *ma_backend, backendCount: ma_uint32, pConfig: *ma_context_config, pContext: *ma_context) -> ma_result #foreign libminiaudio;

/*
Uninitializes a context.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. Do not call this function across multiple threads as some backends read and write to global state.


Remarks
-------
Results are undefined if you call this while any device created by this context is still active.


See Also
--------
ma_context_init()
*/
ma_context_uninit :: (pContext: *ma_context) -> ma_result #foreign libminiaudio;

/*
Retrieves the size of the ma_context object.

This is mainly for the purpose of bindings to know how much memory to allocate.
*/
ma_context_sizeof :: () -> u64 #foreign libminiaudio;

/*
Retrieves a pointer to the log object associated with this context.


Remarks
-------
Pass the returned pointer to `ma_log_post()`, `ma_log_postv()` or `ma_log_postf()` to post a log
message.

You can attach your own logging callback to the log with `ma_log_register_callback()`


Return Value
------------
A pointer to the `ma_log` object that the context uses to post log messages. If some error occurs,
NULL will be returned.
*/
ma_context_get_log :: (pContext: *ma_context) -> *ma_log #foreign libminiaudio;

/*
Enumerates over every device (both playback and capture).

This is a lower-level enumeration function to the easier to use `ma_context_get_devices()`. Use `ma_context_enumerate_devices()` if you would rather not incur
an internal heap allocation, or it simply suits your code better.

Note that this only retrieves the ID and name/description of the device. The reason for only retrieving basic information is that it would otherwise require
opening the backend device in order to probe it for more detailed information which can be inefficient. Consider using `ma_context_get_device_info()` for this,
but don't call it from within the enumeration callback.

Returning false from the callback will stop enumeration. Returning true will continue enumeration.


Parameters
----------
pContext (in)
A pointer to the context performing the enumeration.

callback (in)
The callback to fire for each enumerated device.

pUserData (in)
A pointer to application-defined data passed to the callback.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Safe. This is guarded using a simple mutex lock.


Remarks
-------
Do _not_ assume the first enumerated device of a given type is the default device.

Some backends and platforms may only support default playback and capture devices.

In general, you should not do anything complicated from within the callback. In particular, do not try initializing a device from within the callback. Also,
do not try to call `ma_context_get_device_info()` from within the callback.

Consider using `ma_context_get_devices()` for a simpler and safer API, albeit at the expense of an internal heap allocation.


Example 1 - Simple Enumeration
------------------------------
ma_bool32 ma_device_enum_callback(ma_context* pContext, ma_device_type deviceType, const ma_device_info* pInfo, void* pUserData)
{
printf("Device Name: %s\n", pInfo->name);
return MA_TRUE;
}

ma_result result = ma_context_enumerate_devices(&context, my_device_enum_callback, pMyUserData);
if (result != MA_SUCCESS) {
// Error.
}


See Also
--------
ma_context_get_devices()
*/
ma_context_enumerate_devices :: (pContext: *ma_context, callback: ma_enum_devices_callback_proc, pUserData: *void) -> ma_result #foreign libminiaudio;

/*
Retrieves basic information about every active playback and/or capture device.

This function will allocate memory internally for the device lists and return a pointer to them through the `ppPlaybackDeviceInfos` and `ppCaptureDeviceInfos`
parameters. If you do not want to incur the overhead of these allocations consider using `ma_context_enumerate_devices()` which will instead use a callback.

Note that this only retrieves the ID and name/description of the device. The reason for only retrieving basic information is that it would otherwise require
opening the backend device in order to probe it for more detailed information which can be inefficient. Consider using `ma_context_get_device_info()` for this,
but don't call it from within the enumeration callback.


Parameters
----------
pContext (in)
A pointer to the context performing the enumeration.

ppPlaybackDeviceInfos (out)
A pointer to a pointer that will receive the address of a buffer containing the list of `ma_device_info` structures for playback devices.

pPlaybackDeviceCount (out)
A pointer to an unsigned integer that will receive the number of playback devices.

ppCaptureDeviceInfos (out)
A pointer to a pointer that will receive the address of a buffer containing the list of `ma_device_info` structures for capture devices.

pCaptureDeviceCount (out)
A pointer to an unsigned integer that will receive the number of capture devices.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. Since each call to this function invalidates the pointers from the previous call, you should not be calling this simultaneously across multiple
threads. Instead, you need to make a copy of the returned data with your own higher level synchronization.


Remarks
-------
It is _not_ safe to assume the first device in the list is the default device.

You can pass in NULL for the playback or capture lists in which case they'll be ignored.

The returned pointers will become invalid upon the next call this this function, or when the context is uninitialized. Do not free the returned pointers.


See Also
--------
ma_context_enumerate_devices()
*/
ma_context_get_devices :: (pContext: *ma_context, ppPlaybackDeviceInfos: **ma_device_info, pPlaybackDeviceCount: *ma_uint32, ppCaptureDeviceInfos: **ma_device_info, pCaptureDeviceCount: *ma_uint32) -> ma_result #foreign libminiaudio;

/*
Retrieves information about a device of the given type, with the specified ID and share mode.


Parameters
----------
pContext (in)
A pointer to the context performing the query.

deviceType (in)
The type of the device being queried. Must be either `ma_device_type_playback` or `ma_device_type_capture`.

pDeviceID (in)
The ID of the device being queried.

pDeviceInfo (out)
A pointer to the `ma_device_info` structure that will receive the device information.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Safe. This is guarded using a simple mutex lock.


Remarks
-------
Do _not_ call this from within the `ma_context_enumerate_devices()` callback.

It's possible for a device to have different information and capabilities depending on whether or not it's opened in shared or exclusive mode. For example, in
shared mode, WASAPI always uses floating point samples for mixing, but in exclusive mode it can be anything. Therefore, this function allows you to specify
which share mode you want information for. Note that not all backends and devices support shared or exclusive mode, in which case this function will fail if
the requested share mode is unsupported.

This leaves pDeviceInfo unmodified in the result of an error.
*/
ma_context_get_device_info :: (pContext: *ma_context, deviceType: ma_device_type, pDeviceID: *ma_device_id, pDeviceInfo: *ma_device_info) -> ma_result #foreign libminiaudio;

/*
Determines if the given context supports loopback mode.


Parameters
----------
pContext (in)
A pointer to the context getting queried.


Return Value
------------
MA_TRUE if the context supports loopback mode; MA_FALSE otherwise.
*/
ma_context_is_loopback_supported :: (pContext: *ma_context) -> ma_bool32 #foreign libminiaudio;

/*
Initializes a device config with default settings.


Parameters
----------
deviceType (in)
The type of the device this config is being initialized for. This must set to one of the following:

|-------------------------|
| Device Type             |
|-------------------------|
| ma_device_type_playback |
| ma_device_type_capture  |
| ma_device_type_duplex   |
| ma_device_type_loopback |
|-------------------------|


Return Value
------------
A new device config object with default settings. You will typically want to adjust the config after this function returns. See remarks.


Thread Safety
-------------
Safe.


Callback Safety
---------------
Safe, but don't try initializing a device in a callback.


Remarks
-------
The returned config will be initialized to defaults. You will normally want to customize a few variables before initializing the device. See Example 1 for a
typical configuration which sets the sample format, channel count, sample rate, data callback and user data. These are usually things you will want to change
before initializing the device.

See `ma_device_init()` for details on specific configuration options.


Example 1 - Simple Configuration
--------------------------------
The example below is what a program will typically want to configure for each device at a minimum. Notice how `ma_device_config_init()` is called first, and
then the returned object is modified directly. This is important because it ensures that your program continues to work as new configuration options are added
to the `ma_device_config` structure.

```c
ma_device_config config = ma_device_config_init(ma_device_type_playback);
config.playback.format   = ma_format_f32;
config.playback.channels = 2;
config.sampleRate        = 48000;
config.dataCallback      = ma_data_callback;
config.pUserData         = pMyUserData;
```


See Also
--------
ma_device_init()
ma_device_init_ex()
*/
ma_device_config_init :: (deviceType: ma_device_type) -> ma_device_config #foreign libminiaudio;

/*
Initializes a device.

A device represents a physical audio device. The idea is you send or receive audio data from the device to either play it back through a speaker, or capture it
from a microphone. Whether or not you should send or receive data from the device (or both) depends on the type of device you are initializing which can be
playback, capture, full-duplex or loopback. (Note that loopback mode is only supported on select backends.) Sending and receiving audio data to and from the
device is done via a callback which is fired by miniaudio at periodic time intervals.

The frequency at which data is delivered to and from a device depends on the size of its period. The size of the period can be defined in terms of PCM frames
or milliseconds, whichever is more convenient. Generally speaking, the smaller the period, the lower the latency at the expense of higher CPU usage and
increased risk of glitching due to the more frequent and granular data deliver intervals. The size of a period will depend on your requirements, but
miniaudio's defaults should work fine for most scenarios. If you're building a game you should leave this fairly small, whereas if you're building a simple
media player you can make it larger. Note that the period size you request is actually just a hint - miniaudio will tell the backend what you want, but the
backend is ultimately responsible for what it gives you. You cannot assume you will get exactly what you ask for.

When delivering data to and from a device you need to make sure it's in the correct format which you can set through the device configuration. You just set the
format that you want to use and miniaudio will perform all of the necessary conversion for you internally. When delivering data to and from the callback you
can assume the format is the same as what you requested when you initialized the device. See Remarks for more details on miniaudio's data conversion pipeline.


Parameters
----------
pContext (in, optional)
A pointer to the context that owns the device. This can be null, in which case it creates a default context internally.

pConfig (in)
A pointer to the device configuration. Cannot be null. See remarks for details.

pDevice (out)
A pointer to the device object being initialized.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. It is not safe to call this function simultaneously for different devices because some backends depend on and mutate global state. The same applies to
calling this at the same time as `ma_device_uninit()`.


Callback Safety
---------------
Unsafe. It is not safe to call this inside any callback.


Remarks
-------
Setting `pContext` to NULL will result in miniaudio creating a default context internally and is equivalent to passing in a context initialized like so:

```c
ma_context_init(NULL, 0, NULL, &context);
```

Do not set `pContext` to NULL if you are needing to open multiple devices. You can, however, use NULL when initializing the first device, and then use
device.pContext for the initialization of other devices.

The device can be configured via the `pConfig` argument. The config object is initialized with `ma_device_config_init()`. Individual configuration settings can
then be set directly on the structure. Below are the members of the `ma_device_config` object.

deviceType
Must be `ma_device_type_playback`, `ma_device_type_capture`, `ma_device_type_duplex` of `ma_device_type_loopback`.

sampleRate
The sample rate, in hertz. The most common sample rates are 48000 and 44100. Setting this to 0 will use the device's native sample rate.

periodSizeInFrames
The desired size of a period in PCM frames. If this is 0, `periodSizeInMilliseconds` will be used instead. If both are 0 the default buffer size will
be used depending on the selected performance profile. This value affects latency. See below for details.

periodSizeInMilliseconds
The desired size of a period in milliseconds. If this is 0, `periodSizeInFrames` will be used instead. If both are 0 the default buffer size will be
used depending on the selected performance profile. The value affects latency. See below for details.

periods
The number of periods making up the device's entire buffer. The total buffer size is `periodSizeInFrames` or `periodSizeInMilliseconds` multiplied by
this value. This is just a hint as backends will be the ones who ultimately decide how your periods will be configured.

performanceProfile
A hint to miniaudio as to the performance requirements of your program. Can be either `ma_performance_profile_low_latency` (default) or
`ma_performance_profile_conservative`. This mainly affects the size of default buffers and can usually be left at its default value.

noPreSilencedOutputBuffer
When set to true, the contents of the output buffer passed into the data callback will be left undefined. When set to false (default), the contents of
the output buffer will be cleared the zero. You can use this to avoid the overhead of zeroing out the buffer if you can guarantee that your data
callback will write to every sample in the output buffer, or if you are doing your own clearing.

noClip
When set to true, the contents of the output buffer are left alone after returning and it will be left up to the backend itself to decide whether or
not to clip. When set to false (default), the contents of the output buffer passed into the data callback will be clipped after returning. This only
applies when the playback sample format is f32.

noDisableDenormals
By default, miniaudio will disable denormals when the data callback is called. Setting this to true will prevent the disabling of denormals.

noFixedSizedCallback
Allows miniaudio to fire the data callback with any frame count. When this is set to false (the default), the data callback will be fired with a
consistent frame count as specified by `periodSizeInFrames` or `periodSizeInMilliseconds`. When set to true, miniaudio will fire the callback with
whatever the backend requests, which could be anything.

dataCallback
The callback to fire whenever data is ready to be delivered to or from the device.

notificationCallback
The callback to fire when something has changed with the device, such as whether or not it has been started or stopped.

pUserData
The user data pointer to use with the device. You can access this directly from the device object like `device.pUserData`.

resampling.algorithm
The resampling algorithm to use when miniaudio needs to perform resampling between the rate specified by `sampleRate` and the device's native rate. The
default value is `ma_resample_algorithm_linear`, and the quality can be configured with `resampling.linear.lpfOrder`.

resampling.pBackendVTable
A pointer to an optional vtable that can be used for plugging in a custom resampler.

resampling.pBackendUserData
A pointer that will passed to callbacks in pBackendVTable.

resampling.linear.lpfOrder
The linear resampler applies a low-pass filter as part of its processing for anti-aliasing. This setting controls the order of the filter. The higher
the value, the better the quality, in general. Setting this to 0 will disable low-pass filtering altogether. The maximum value is
`MA_MAX_FILTER_ORDER`. The default value is `min(4, MA_MAX_FILTER_ORDER)`.

playback.pDeviceID
A pointer to a `ma_device_id` structure containing the ID of the playback device to initialize. Setting this NULL (default) will use the system's
default playback device. Retrieve the device ID from the `ma_device_info` structure, which can be retrieved using device enumeration.

playback.format
The sample format to use for playback. When set to `ma_format_unknown` the device's native format will be used. This can be retrieved after
initialization from the device object directly with `device.playback.format`.

playback.channels
The number of channels to use for playback. When set to 0 the device's native channel count will be used. This can be retrieved after initialization
from the device object directly with `device.playback.channels`.

playback.pChannelMap
The channel map to use for playback. When left empty, the device's native channel map will be used. This can be retrieved after initialization from the
device object direct with `device.playback.pChannelMap`. When set, the buffer should contain `channels` items.

playback.shareMode
The preferred share mode to use for playback. Can be either `ma_share_mode_shared` (default) or `ma_share_mode_exclusive`. Note that if you specify
exclusive mode, but it's not supported by the backend, initialization will fail. You can then fall back to shared mode if desired by changing this to
ma_share_mode_shared and reinitializing.

capture.pDeviceID
A pointer to a `ma_device_id` structure containing the ID of the capture device to initialize. Setting this NULL (default) will use the system's
default capture device. Retrieve the device ID from the `ma_device_info` structure, which can be retrieved using device enumeration.

capture.format
The sample format to use for capture. When set to `ma_format_unknown` the device's native format will be used. This can be retrieved after
initialization from the device object directly with `device.capture.format`.

capture.channels
The number of channels to use for capture. When set to 0 the device's native channel count will be used. This can be retrieved after initialization
from the device object directly with `device.capture.channels`.

capture.pChannelMap
The channel map to use for capture. When left empty, the device's native channel map will be used. This can be retrieved after initialization from the
device object direct with `device.capture.pChannelMap`. When set, the buffer should contain `channels` items.

capture.shareMode
The preferred share mode to use for capture. Can be either `ma_share_mode_shared` (default) or `ma_share_mode_exclusive`. Note that if you specify
exclusive mode, but it's not supported by the backend, initialization will fail. You can then fall back to shared mode if desired by changing this to
ma_share_mode_shared and reinitializing.

wasapi.noAutoConvertSRC
WASAPI only. When set to true, disables WASAPI's automatic resampling and forces the use of miniaudio's resampler. Defaults to false.

wasapi.noDefaultQualitySRC
WASAPI only. Only used when `wasapi.noAutoConvertSRC` is set to false. When set to true, disables the use of `AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY`.
You should usually leave this set to false, which is the default.

wasapi.noAutoStreamRouting
WASAPI only. When set to true, disables automatic stream routing on the WASAPI backend. Defaults to false.

wasapi.noHardwareOffloading
WASAPI only. When set to true, disables the use of WASAPI's hardware offloading feature. Defaults to false.

alsa.noMMap
ALSA only. When set to true, disables MMap mode. Defaults to false.

alsa.noAutoFormat
ALSA only. When set to true, disables ALSA's automatic format conversion by including the SND_PCM_NO_AUTO_FORMAT flag. Defaults to false.

alsa.noAutoChannels
ALSA only. When set to true, disables ALSA's automatic channel conversion by including the SND_PCM_NO_AUTO_CHANNELS flag. Defaults to false.

alsa.noAutoResample
ALSA only. When set to true, disables ALSA's automatic resampling by including the SND_PCM_NO_AUTO_RESAMPLE flag. Defaults to false.

pulse.pStreamNamePlayback
PulseAudio only. Sets the stream name for playback.

pulse.pStreamNameCapture
PulseAudio only. Sets the stream name for capture.

pulse.channelMap
PulseAudio only. Sets the channel map that is requested from PulseAudio. See MA_PA_CHANNEL_MAP_* constants. Defaults to MA_PA_CHANNEL_MAP_AIFF.

coreaudio.allowNominalSampleRateChange
Core Audio only. Desktop only. When enabled, allows the sample rate of the device to be changed at the operating system level. This
is disabled by default in order to prevent intrusive changes to the user's system. This is useful if you want to use a sample rate
that is known to be natively supported by the hardware thereby avoiding the cost of resampling. When set to true, miniaudio will
find the closest match between the sample rate requested in the device config and the sample rates natively supported by the
hardware. When set to false, the sample rate currently set by the operating system will always be used.

opensl.streamType
OpenSL only. Explicitly sets the stream type. If left unset (`ma_opensl_stream_type_default`), the
stream type will be left unset. Think of this as the type of audio you're playing.

opensl.recordingPreset
OpenSL only. Explicitly sets the type of recording your program will be doing. When left
unset, the recording preset will be left unchanged.

aaudio.usage
AAudio only. Explicitly sets the nature of the audio the program will be consuming. When
left unset, the usage will be left unchanged.

aaudio.contentType
AAudio only. Sets the content type. When left unset, the content type will be left unchanged.

aaudio.inputPreset
AAudio only. Explicitly sets the type of recording your program will be doing. When left
unset, the input preset will be left unchanged.

aaudio.noAutoStartAfterReroute
AAudio only. Controls whether or not the device should be automatically restarted after a
stream reroute. When set to false (default) the device will be restarted automatically;
otherwise the device will be stopped.


Once initialized, the device's config is immutable. If you need to change the config you will need to initialize a new device.

After initializing the device it will be in a stopped state. To start it, use `ma_device_start()`.

If both `periodSizeInFrames` and `periodSizeInMilliseconds` are set to zero, it will default to `MA_DEFAULT_PERIOD_SIZE_IN_MILLISECONDS_LOW_LATENCY` or
`MA_DEFAULT_PERIOD_SIZE_IN_MILLISECONDS_CONSERVATIVE`, depending on whether or not `performanceProfile` is set to `ma_performance_profile_low_latency` or
`ma_performance_profile_conservative`.

If you request exclusive mode and the backend does not support it an error will be returned. For robustness, you may want to first try initializing the device
in exclusive mode, and then fall back to shared mode if required. Alternatively you can just request shared mode (the default if you leave it unset in the
config) which is the most reliable option. Some backends do not have a practical way of choosing whether or not the device should be exclusive or not (ALSA,
for example) in which case it just acts as a hint. Unless you have special requirements you should try avoiding exclusive mode as it's intrusive to the user.
Starting with Windows 10, miniaudio will use low-latency shared mode where possible which may make exclusive mode unnecessary.

When sending or receiving data to/from a device, miniaudio will internally perform a format conversion to convert between the format specified by the config
and the format used internally by the backend. If you pass in 0 for the sample format, channel count, sample rate _and_ channel map, data transmission will run
on an optimized pass-through fast path. You can retrieve the format, channel count and sample rate by inspecting the `playback/capture.format`,
`playback/capture.channels` and `sampleRate` members of the device object.

When compiling for UWP you must ensure you call this function on the main UI thread because the operating system may need to present the user with a message
asking for permissions. Please refer to the official documentation for ActivateAudioInterfaceAsync() for more information.

ALSA Specific: When initializing the default device, requesting shared mode will try using the "dmix" device for playback and the "dsnoop" device for capture.
If these fail it will try falling back to the "hw" device.


Example 1 - Simple Initialization
---------------------------------
This example shows how to initialize a simple playback device using a standard configuration. If you are just needing to do simple playback from the default
playback device this is usually all you need.

```c
ma_device_config config = ma_device_config_init(ma_device_type_playback);
config.playback.format   = ma_format_f32;
config.playback.channels = 2;
config.sampleRate        = 48000;
config.dataCallback      = ma_data_callback;
config.pMyUserData       = pMyUserData;

ma_device device;
ma_result result = ma_device_init(NULL, &config, &device);
if (result != MA_SUCCESS) {
// Error
}
```


Example 2 - Advanced Initialization
-----------------------------------
This example shows how you might do some more advanced initialization. In this hypothetical example we want to control the latency by setting the buffer size
and period count. We also want to allow the user to be able to choose which device to output from which means we need a context so we can perform device
enumeration.

```c
ma_context context;
ma_result result = ma_context_init(NULL, 0, NULL, &context);
if (result != MA_SUCCESS) {
// Error
}

ma_device_info* pPlaybackDeviceInfos;
ma_uint32 playbackDeviceCount;
result = ma_context_get_devices(&context, &pPlaybackDeviceInfos, &playbackDeviceCount, NULL, NULL);
if (result != MA_SUCCESS) {
// Error
}

// ... choose a device from pPlaybackDeviceInfos ...

ma_device_config config = ma_device_config_init(ma_device_type_playback);
config.playback.pDeviceID       = pMyChosenDeviceID;    // <-- Get this from the `id` member of one of the `ma_device_info` objects returned by ma_context_get_devices().
config.playback.format          = ma_format_f32;
config.playback.channels        = 2;
config.sampleRate               = 48000;
config.dataCallback             = ma_data_callback;
config.pUserData                = pMyUserData;
config.periodSizeInMilliseconds = 10;
config.periods                  = 3;

ma_device device;
result = ma_device_init(&context, &config, &device);
if (result != MA_SUCCESS) {
// Error
}
```


See Also
--------
ma_device_config_init()
ma_device_uninit()
ma_device_start()
ma_context_init()
ma_context_get_devices()
ma_context_enumerate_devices()
*/
ma_device_init :: (pContext: *ma_context, pConfig: *ma_device_config, pDevice: *ma_device) -> ma_result #foreign libminiaudio;

/*
Initializes a device without a context, with extra parameters for controlling the configuration of the internal self-managed context.

This is the same as `ma_device_init()`, only instead of a context being passed in, the parameters from `ma_context_init()` are passed in instead. This function
allows you to configure the internally created context.


Parameters
----------
backends (in, optional)
A list of backends to try initializing, in priority order. Can be NULL, in which case it uses default priority order.

backendCount (in, optional)
The number of items in `backend`. Ignored if `backend` is NULL.

pContextConfig (in, optional)
The context configuration.

pConfig (in)
A pointer to the device configuration. Cannot be null. See remarks for details.

pDevice (out)
A pointer to the device object being initialized.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. It is not safe to call this function simultaneously for different devices because some backends depend on and mutate global state. The same applies to
calling this at the same time as `ma_device_uninit()`.


Callback Safety
---------------
Unsafe. It is not safe to call this inside any callback.


Remarks
-------
You only need to use this function if you want to configure the context differently to its defaults. You should never use this function if you want to manage
your own context.

See the documentation for `ma_context_init()` for information on the different context configuration options.


See Also
--------
ma_device_init()
ma_device_uninit()
ma_device_config_init()
ma_context_init()
*/
ma_device_init_ex :: (backends: *ma_backend, backendCount: ma_uint32, pContextConfig: *ma_context_config, pConfig: *ma_device_config, pDevice: *ma_device) -> ma_result #foreign libminiaudio;

/*
Uninitializes a device.

This will explicitly stop the device. You do not need to call `ma_device_stop()` beforehand, but it's harmless if you do.


Parameters
----------
pDevice (in)
A pointer to the device to stop.


Return Value
------------
Nothing


Thread Safety
-------------
Unsafe. As soon as this API is called the device should be considered undefined.


Callback Safety
---------------
Unsafe. It is not safe to call this inside any callback. Doing this will result in a deadlock.


See Also
--------
ma_device_init()
ma_device_stop()
*/
ma_device_uninit :: (pDevice: *ma_device) -> void #foreign libminiaudio;

/*
Retrieves a pointer to the context that owns the given device.
*/
ma_device_get_context :: (pDevice: *ma_device) -> *ma_context #foreign libminiaudio;

/*
Helper function for retrieving the log object associated with the context that owns this device.
*/
ma_device_get_log :: (pDevice: *ma_device) -> *ma_log #foreign libminiaudio;

/*
Retrieves information about the device.


Parameters
----------
pDevice (in)
A pointer to the device whose information is being retrieved.

type (in)
The device type. This parameter is required for duplex devices. When retrieving device
information, you are doing so for an individual playback or capture device.

pDeviceInfo (out)
A pointer to the `ma_device_info` that will receive the device information.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. This should be considered unsafe because it may be calling into the backend which may or
may not be safe.


Callback Safety
---------------
Unsafe. You should avoid calling this in the data callback because it may call into the backend
which may or may not be safe.
*/
ma_device_get_info :: (pDevice: *ma_device, type: ma_device_type, pDeviceInfo: *ma_device_info) -> ma_result #foreign libminiaudio;

/*
Retrieves the name of the device.


Parameters
----------
pDevice (in)
A pointer to the device whose information is being retrieved.

type (in)
The device type. This parameter is required for duplex devices. When retrieving device
information, you are doing so for an individual playback or capture device.

pName (out)
A pointer to the buffer that will receive the name.

nameCap (in)
The capacity of the output buffer, including space for the null terminator.

pLengthNotIncludingNullTerminator (out, optional)
A pointer to the variable that will receive the length of the name, not including the null
terminator.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Unsafe. This should be considered unsafe because it may be calling into the backend which may or
may not be safe.


Callback Safety
---------------
Unsafe. You should avoid calling this in the data callback because it may call into the backend
which may or may not be safe.


Remarks
-------
If the name does not fully fit into the output buffer, it'll be truncated. You can pass in NULL to
`pName` if you want to first get the length of the name for the purpose of memory allocation of the
output buffer. Allocating a buffer of size `MA_MAX_DEVICE_NAME_LENGTH + 1` should be enough for
most cases and will avoid the need for the inefficiency of calling this function twice.

This is implemented in terms of `ma_device_get_info()`.
*/
ma_device_get_name :: (pDevice: *ma_device, type: ma_device_type, pName: *u8, nameCap: u64, pLengthNotIncludingNullTerminator: *u64) -> ma_result #foreign libminiaudio;

/*
Starts the device. For playback devices this begins playback. For capture devices it begins recording.

Use `ma_device_stop()` to stop the device.


Parameters
----------
pDevice (in)
A pointer to the device to start.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Safe. It's safe to call this from any thread with the exception of the callback thread.


Callback Safety
---------------
Unsafe. It is not safe to call this inside any callback.


Remarks
-------
For a playback device, this will retrieve an initial chunk of audio data from the client before returning. The reason for this is to ensure there is valid
audio data in the buffer, which needs to be done before the device begins playback.

This API waits until the backend device has been started for real by the worker thread. It also waits on a mutex for thread-safety.

Do not call this in any callback.


See Also
--------
ma_device_stop()
*/
ma_device_start :: (pDevice: *ma_device) -> ma_result #foreign libminiaudio;

/*
Stops the device. For playback devices this stops playback. For capture devices it stops recording.

Use `ma_device_start()` to start the device again.


Parameters
----------
pDevice (in)
A pointer to the device to stop.


Return Value
------------
MA_SUCCESS if successful; any other error code otherwise.


Thread Safety
-------------
Safe. It's safe to call this from any thread with the exception of the callback thread.


Callback Safety
---------------
Unsafe. It is not safe to call this inside any callback. Doing this will result in a deadlock.


Remarks
-------
This API needs to wait on the worker thread to stop the backend device properly before returning. It also waits on a mutex for thread-safety. In addition, some
backends need to wait for the device to finish playback/recording of the current fragment which can take some time (usually proportionate to the buffer size
that was specified at initialization time).

Backends are required to either pause the stream in-place or drain the buffer if pausing is not possible. The reason for this is that stopping the device and
the resuming it with ma_device_start() (which you might do when your program loses focus) may result in a situation where those samples are never output to the
speakers or received from the microphone which can in turn result in de-syncs.

Do not call this in any callback.


See Also
--------
ma_device_start()
*/
ma_device_stop :: (pDevice: *ma_device) -> ma_result #foreign libminiaudio;

/*
Determines whether or not the device is started.


Parameters
----------
pDevice (in)
A pointer to the device whose start state is being retrieved.


Return Value
------------
True if the device is started, false otherwise.


Thread Safety
-------------
Safe. If another thread calls `ma_device_start()` or `ma_device_stop()` at this same time as this function is called, there's a very small chance the return
value will be out of sync.


Callback Safety
---------------
Safe. This is implemented as a simple accessor.


See Also
--------
ma_device_start()
ma_device_stop()
*/
ma_device_is_started :: (pDevice: *ma_device) -> ma_bool32 #foreign libminiaudio;

/*
Retrieves the state of the device.


Parameters
----------
pDevice (in)
A pointer to the device whose state is being retrieved.


Return Value
------------
The current state of the device. The return value will be one of the following:

+-------------------------------+------------------------------------------------------------------------------+
| ma_device_state_uninitialized | Will only be returned if the device is in the middle of initialization.      |
+-------------------------------+------------------------------------------------------------------------------+
| ma_device_state_stopped       | The device is stopped. The initial state of the device after initialization. |
+-------------------------------+------------------------------------------------------------------------------+
| ma_device_state_started       | The device started and requesting and/or delivering audio data.              |
+-------------------------------+------------------------------------------------------------------------------+
| ma_device_state_starting      | The device is in the process of starting.                                    |
+-------------------------------+------------------------------------------------------------------------------+
| ma_device_state_stopping      | The device is in the process of stopping.                                    |
+-------------------------------+------------------------------------------------------------------------------+


Thread Safety
-------------
Safe. This is implemented as a simple accessor. Note that if the device is started or stopped at the same time as this function is called,
there's a possibility the return value could be out of sync. See remarks.


Callback Safety
---------------
Safe. This is implemented as a simple accessor.


Remarks
-------
The general flow of a devices state goes like this:

```
ma_device_init()  -> ma_device_state_uninitialized -> ma_device_state_stopped
ma_device_start() -> ma_device_state_starting      -> ma_device_state_started
ma_device_stop()  -> ma_device_state_stopping      -> ma_device_state_stopped
```

When the state of the device is changed with `ma_device_start()` or `ma_device_stop()` at this same time as this function is called, the
value returned by this function could potentially be out of sync. If this is significant to your program you need to implement your own
synchronization.
*/
ma_device_get_state :: (pDevice: *ma_device) -> ma_device_state #foreign libminiaudio;

/*
Performs post backend initialization routines for setting up internal data conversion.

This should be called whenever the backend is initialized. The only time this should be called from
outside of miniaudio is if you're implementing a custom backend, and you would only do it if you
are reinitializing the backend due to rerouting or reinitializing for some reason.


Parameters
----------
pDevice [in]
A pointer to the device.

deviceType [in]
The type of the device that was just reinitialized.

pPlaybackDescriptor [in]
The descriptor of the playback device containing the internal data format and buffer sizes.

pPlaybackDescriptor [in]
The descriptor of the capture device containing the internal data format and buffer sizes.


Return Value
------------
MA_SUCCESS if successful; any other error otherwise.


Thread Safety
-------------
Unsafe. This will be reinitializing internal data converters which may be in use by another thread.


Callback Safety
---------------
Unsafe. This will be reinitializing internal data converters which may be in use by the callback.


Remarks
-------
For a duplex device, you can call this for only one side of the system. This is why the deviceType
is specified as a parameter rather than deriving it from the device.

You do not need to call this manually unless you are doing a custom backend, in which case you need
only do it if you're manually performing rerouting or reinitialization.
*/
ma_device_post_init :: (pDevice: *ma_device, deviceType: ma_device_type, pPlaybackDescriptor: *ma_device_descriptor, pCaptureDescriptor: *ma_device_descriptor) -> ma_result #foreign libminiaudio;

/*
Sets the master volume factor for the device.

The volume factor must be between 0 (silence) and 1 (full volume). Use `ma_device_set_master_volume_db()` to use decibel notation, where 0 is full volume and
values less than 0 decreases the volume.


Parameters
----------
pDevice (in)
A pointer to the device whose volume is being set.

volume (in)
The new volume factor. Must be >= 0.


Return Value
------------
MA_SUCCESS if the volume was set successfully.
MA_INVALID_ARGS if pDevice is NULL.
MA_INVALID_ARGS if volume is negative.


Thread Safety
-------------
Safe. This just sets a local member of the device object.


Callback Safety
---------------
Safe. If you set the volume in the data callback, that data written to the output buffer will have the new volume applied.


Remarks
-------
This applies the volume factor across all channels.

This does not change the operating system's volume. It only affects the volume for the given `ma_device` object's audio stream.


See Also
--------
ma_device_get_master_volume()
ma_device_set_master_volume_db()
ma_device_get_master_volume_db()
*/
ma_device_set_master_volume :: (pDevice: *ma_device, volume: float) -> ma_result #foreign libminiaudio;

/*
Retrieves the master volume factor for the device.


Parameters
----------
pDevice (in)
A pointer to the device whose volume factor is being retrieved.

pVolume (in)
A pointer to the variable that will receive the volume factor. The returned value will be in the range of [0, 1].


Return Value
------------
MA_SUCCESS if successful.
MA_INVALID_ARGS if pDevice is NULL.
MA_INVALID_ARGS if pVolume is NULL.


Thread Safety
-------------
Safe. This just a simple member retrieval.


Callback Safety
---------------
Safe.


Remarks
-------
If an error occurs, `*pVolume` will be set to 0.


See Also
--------
ma_device_set_master_volume()
ma_device_set_master_volume_gain_db()
ma_device_get_master_volume_gain_db()
*/
ma_device_get_master_volume :: (pDevice: *ma_device, pVolume: *float) -> ma_result #foreign libminiaudio;

/*
Sets the master volume for the device as gain in decibels.

A gain of 0 is full volume, whereas a gain of < 0 will decrease the volume.


Parameters
----------
pDevice (in)
A pointer to the device whose gain is being set.

gainDB (in)
The new volume as gain in decibels. Must be less than or equal to 0, where 0 is full volume and anything less than 0 decreases the volume.


Return Value
------------
MA_SUCCESS if the volume was set successfully.
MA_INVALID_ARGS if pDevice is NULL.
MA_INVALID_ARGS if the gain is > 0.


Thread Safety
-------------
Safe. This just sets a local member of the device object.


Callback Safety
---------------
Safe. If you set the volume in the data callback, that data written to the output buffer will have the new volume applied.


Remarks
-------
This applies the gain across all channels.

This does not change the operating system's volume. It only affects the volume for the given `ma_device` object's audio stream.


See Also
--------
ma_device_get_master_volume_gain_db()
ma_device_set_master_volume()
ma_device_get_master_volume()
*/
ma_device_set_master_volume_db :: (pDevice: *ma_device, gainDB: float) -> ma_result #foreign libminiaudio;

/*
Retrieves the master gain in decibels.


Parameters
----------
pDevice (in)
A pointer to the device whose gain is being retrieved.

pGainDB (in)
A pointer to the variable that will receive the gain in decibels. The returned value will be <= 0.


Return Value
------------
MA_SUCCESS if successful.
MA_INVALID_ARGS if pDevice is NULL.
MA_INVALID_ARGS if pGainDB is NULL.


Thread Safety
-------------
Safe. This just a simple member retrieval.


Callback Safety
---------------
Safe.


Remarks
-------
If an error occurs, `*pGainDB` will be set to 0.


See Also
--------
ma_device_set_master_volume_db()
ma_device_set_master_volume()
ma_device_get_master_volume()
*/
ma_device_get_master_volume_db :: (pDevice: *ma_device, pGainDB: *float) -> ma_result #foreign libminiaudio;

/*
Called from the data callback of asynchronous backends to allow miniaudio to process the data and fire the miniaudio data callback.


Parameters
----------
pDevice (in)
A pointer to device whose processing the data callback.

pOutput (out)
A pointer to the buffer that will receive the output PCM frame data. On a playback device this must not be NULL. On a duplex device
this can be NULL, in which case pInput must not be NULL.

pInput (in)
A pointer to the buffer containing input PCM frame data. On a capture device this must not be NULL. On a duplex device this can be
NULL, in which case `pOutput` must not be NULL.

frameCount (in)
The number of frames being processed.


Return Value
------------
MA_SUCCESS if successful; any other result code otherwise.


Thread Safety
-------------
This function should only ever be called from the internal data callback of the backend. It is safe to call this simultaneously between a
playback and capture device in duplex setups.


Callback Safety
---------------
Do not call this from the miniaudio data callback. It should only ever be called from the internal data callback of the backend.


Remarks
-------
If both `pOutput` and `pInput` are NULL, and error will be returned. In duplex scenarios, both `pOutput` and `pInput` can be non-NULL, in
which case `pInput` will be processed first, followed by `pOutput`.

If you are implementing a custom backend, and that backend uses a callback for data delivery, you'll need to call this from inside that
callback.
*/
ma_device_handle_backend_data_callback :: (pDevice: *ma_device, pOutput: *void, pInput: *void, frameCount: ma_uint32) -> ma_result #foreign libminiaudio;

/*
Calculates an appropriate buffer size from a descriptor, native sample rate and performance profile.

This function is used by backends for helping determine an appropriately sized buffer to use with
the device depending on the values of `periodSizeInFrames` and `periodSizeInMilliseconds` in the
`pDescriptor` object. Since buffer size calculations based on time depends on the sample rate, a
best guess at the device's native sample rate is also required which is where `nativeSampleRate`
comes in. In addition, the performance profile is also needed for cases where both the period size
in frames and milliseconds are both zero.


Parameters
----------
pDescriptor (in)
A pointer to device descriptor whose `periodSizeInFrames` and `periodSizeInMilliseconds` members
will be used for the calculation of the buffer size.

nativeSampleRate (in)
The device's native sample rate. This is only ever used when the `periodSizeInFrames` member of
`pDescriptor` is zero. In this case, `periodSizeInMilliseconds` will be used instead, in which
case a sample rate is required to convert to a size in frames.

performanceProfile (in)
When both the `periodSizeInFrames` and `periodSizeInMilliseconds` members of `pDescriptor` are
zero, miniaudio will fall back to a buffer size based on the performance profile. The profile
to use for this calculation is determine by this parameter.


Return Value
------------
The calculated buffer size in frames.


Thread Safety
-------------
This is safe so long as nothing modifies `pDescriptor` at the same time. However, this function
should only ever be called from within the backend's device initialization routine and therefore
shouldn't have any multithreading concerns.


Callback Safety
---------------
This is safe to call within the data callback, but there is no reason to ever do this.


Remarks
-------
If `nativeSampleRate` is zero, this function will fall back to `pDescriptor->sampleRate`. If that
is also zero, `MA_DEFAULT_SAMPLE_RATE` will be used instead.
*/
ma_calculate_buffer_size_in_frames_from_descriptor :: (pDescriptor: *ma_device_descriptor, nativeSampleRate: ma_uint32, performanceProfile: ma_performance_profile) -> ma_uint32 #foreign libminiaudio;

/*
Retrieves a friendly name for a backend.
*/
ma_get_backend_name :: (backend: ma_backend) -> *u8 #foreign libminiaudio;

/*
Retrieves the backend enum from the given name.
*/
ma_get_backend_from_name :: (pBackendName: *u8, pBackend: *ma_backend) -> ma_result #foreign libminiaudio;

/*
Determines whether or not the given backend is available by the compilation environment.
*/
ma_is_backend_enabled :: (backend: ma_backend) -> ma_bool32 #foreign libminiaudio;

/*
Retrieves compile-time enabled backends.


Parameters
----------
pBackends (out, optional)
A pointer to the buffer that will receive the enabled backends. Set to NULL to retrieve the backend count. Setting
the capacity of the buffer to `MA_BACKEND_COUNT` will guarantee it's large enough for all backends.

backendCap (in)
The capacity of the `pBackends` buffer.

pBackendCount (out)
A pointer to the variable that will receive the enabled backend count.


Return Value
------------
MA_SUCCESS if successful.
MA_INVALID_ARGS if `pBackendCount` is NULL.
MA_NO_SPACE if the capacity of `pBackends` is not large enough.

If `MA_NO_SPACE` is returned, the `pBackends` buffer will be filled with `*pBackendCount` values.


Thread Safety
-------------
Safe.


Callback Safety
---------------
Safe.


Remarks
-------
If you want to retrieve the number of backends so you can determine the capacity of `pBackends` buffer, you can call
this function with `pBackends` set to NULL.

This will also enumerate the null backend. If you don't want to include this you need to check for `ma_backend_null`
when you enumerate over the returned backends and handle it appropriately. Alternatively, you can disable it at
compile time with `MA_NO_NULL`.

The returned backends are determined based on compile time settings, not the platform it's currently running on. For
example, PulseAudio will be returned if it was enabled at compile time, even when the user doesn't actually have
PulseAudio installed.


Example 1
---------
The example below retrieves the enabled backend count using a fixed sized buffer allocated on the stack. The buffer is
given a capacity of `MA_BACKEND_COUNT` which will guarantee it'll be large enough to store all available backends.
Since `MA_BACKEND_COUNT` is always a relatively small value, this should be suitable for most scenarios.

```
ma_backend enabledBackends[MA_BACKEND_COUNT];
size_t enabledBackendCount;

result = ma_get_enabled_backends(enabledBackends, MA_BACKEND_COUNT, &enabledBackendCount);
if (result != MA_SUCCESS) {
// Failed to retrieve enabled backends. Should never happen in this example since all inputs are valid.
}
```


See Also
--------
ma_is_backend_enabled()
*/
ma_get_enabled_backends :: (pBackends: *ma_backend, backendCap: u64, pBackendCount: *u64) -> ma_result #foreign libminiaudio;

/*
Determines whether or not loopback mode is support by a backend.
*/
ma_is_loopback_supported :: (backend: ma_backend) -> ma_bool32 #foreign libminiaudio;

/*
Calculates a buffer size in milliseconds (rounded up) from the specified number of frames and sample rate.
*/
ma_calculate_buffer_size_in_milliseconds_from_frames :: (bufferSizeInFrames: ma_uint32, sampleRate: ma_uint32) -> ma_uint32 #foreign libminiaudio;

/*
Calculates a buffer size in frames from the specified number of milliseconds and sample rate.
*/
ma_calculate_buffer_size_in_frames_from_milliseconds :: (bufferSizeInMilliseconds: ma_uint32, sampleRate: ma_uint32) -> ma_uint32 #foreign libminiaudio;

/*
Copies PCM frames from one buffer to another.
*/
ma_copy_pcm_frames :: (dst: *void, src: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Copies silent frames into the given buffer.

Remarks
-------
For all formats except `ma_format_u8`, the output buffer will be filled with 0. For `ma_format_u8` it will be filled with 128. The reason for this is that it
makes more sense for the purpose of mixing to initialize it to the center point.
*/
ma_silence_pcm_frames :: (p: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Offsets a pointer by the specified number of PCM frames.
*/
ma_offset_pcm_frames_ptr :: (p: *void, offsetInFrames: ma_uint64, format: ma_format, channels: ma_uint32) -> *void #foreign libminiaudio;
ma_offset_pcm_frames_const_ptr :: (p: *void, offsetInFrames: ma_uint64, format: ma_format, channels: ma_uint32) -> *void #foreign libminiaudio;

/*
Clips samples.
*/
ma_clip_samples_u8 :: (pDst: *ma_uint8, pSrc: *ma_int16, count: ma_uint64) -> void #foreign libminiaudio;
ma_clip_samples_s16 :: (pDst: *ma_int16, pSrc: *ma_int32, count: ma_uint64) -> void #foreign libminiaudio;
ma_clip_samples_s24 :: (pDst: *ma_uint8, pSrc: *ma_int64, count: ma_uint64) -> void #foreign libminiaudio;
ma_clip_samples_s32 :: (pDst: *ma_int32, pSrc: *ma_int64, count: ma_uint64) -> void #foreign libminiaudio;
ma_clip_samples_f32 :: (pDst: *float, pSrc: *float, count: ma_uint64) -> void #foreign libminiaudio;
ma_clip_pcm_frames :: (pDst: *void, pSrc: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32) -> void #foreign libminiaudio;

/*
Helper for applying a volume factor to samples.

Note that the source and destination buffers can be the same, in which case it'll perform the operation in-place.
*/
ma_copy_and_apply_volume_factor_u8 :: (pSamplesOut: *ma_uint8, pSamplesIn: *ma_uint8, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_s16 :: (pSamplesOut: *ma_int16, pSamplesIn: *ma_int16, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_s24 :: (pSamplesOut: *void, pSamplesIn: *void, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_s32 :: (pSamplesOut: *ma_int32, pSamplesIn: *ma_int32, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_f32 :: (pSamplesOut: *float, pSamplesIn: *float, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;

ma_apply_volume_factor_u8 :: (pSamples: *ma_uint8, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_s16 :: (pSamples: *ma_int16, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_s24 :: (pSamples: *void, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_s32 :: (pSamples: *ma_int32, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_f32 :: (pSamples: *float, sampleCount: ma_uint64, factor: float) -> void #foreign libminiaudio;

ma_copy_and_apply_volume_factor_pcm_frames_u8 :: (pFramesOut: *ma_uint8, pFramesIn: *ma_uint8, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_pcm_frames_s16 :: (pFramesOut: *ma_int16, pFramesIn: *ma_int16, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_pcm_frames_s24 :: (pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_pcm_frames_s32 :: (pFramesOut: *ma_int32, pFramesIn: *ma_int32, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_pcm_frames_f32 :: (pFramesOut: *float, pFramesIn: *float, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_factor_pcm_frames :: (pFramesOut: *void, pFramesIn: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;

ma_apply_volume_factor_pcm_frames_u8 :: (pFrames: *ma_uint8, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_pcm_frames_s16 :: (pFrames: *ma_int16, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_pcm_frames_s24 :: (pFrames: *void, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_pcm_frames_s32 :: (pFrames: *ma_int32, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_pcm_frames_f32 :: (pFrames: *float, frameCount: ma_uint64, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;
ma_apply_volume_factor_pcm_frames :: (pFrames: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32, factor: float) -> void #foreign libminiaudio;

ma_copy_and_apply_volume_factor_per_channel_f32 :: (pFramesOut: *float, pFramesIn: *float, frameCount: ma_uint64, channels: ma_uint32, pChannelGains: *float) -> void #foreign libminiaudio;

ma_copy_and_apply_volume_and_clip_samples_u8 :: (pDst: *ma_uint8, pSrc: *ma_int16, count: ma_uint64, volume: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_and_clip_samples_s16 :: (pDst: *ma_int16, pSrc: *ma_int32, count: ma_uint64, volume: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_and_clip_samples_s24 :: (pDst: *ma_uint8, pSrc: *ma_int64, count: ma_uint64, volume: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_and_clip_samples_s32 :: (pDst: *ma_int32, pSrc: *ma_int64, count: ma_uint64, volume: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_and_clip_samples_f32 :: (pDst: *float, pSrc: *float, count: ma_uint64, volume: float) -> void #foreign libminiaudio;
ma_copy_and_apply_volume_and_clip_pcm_frames :: (pDst: *void, pSrc: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32, volume: float) -> void #foreign libminiaudio;

/*
Helper for converting a linear factor to gain in decibels.
*/
ma_volume_linear_to_db :: (factor: float) -> float #foreign libminiaudio;

/*
Helper for converting gain in decibels to a linear factor.
*/
ma_volume_db_to_linear :: (gain: float) -> float #foreign libminiaudio;

/*
Mixes the specified number of frames in floating point format with a volume factor.

This will run on an optimized path when the volume is equal to 1.
*/
ma_mix_pcm_frames_f32 :: (pDst: *float, pSrc: *float, frameCount: ma_uint64, channels: ma_uint32, volume: float) -> ma_result #foreign libminiaudio;

/************************************************************************************************************************************************************

VFS
===

The VFS object (virtual file system) is what's used to customize file access. This is useful in cases where stdio FILE* based APIs may not be entirely
appropriate for a given situation.

************************************************************************************************************************************************************/
ma_vfs :: void;
ma_vfs_file :: ma_handle;

ma_open_mode_flags :: enum u32 {
    READ  :: 1;
    WRITE :: 2;

    MA_OPEN_MODE_READ  :: READ;
    MA_OPEN_MODE_WRITE :: WRITE;
}

ma_seek_origin :: enum u32 {
    start   :: 0;
    current :: 1;
    end     :: 2;

    ma_seek_origin_start   :: start;
    ma_seek_origin_current :: current;
    ma_seek_origin_end     :: end;
}

ma_file_info :: struct {
    sizeInBytes: ma_uint64;
}

ma_vfs_callbacks :: struct {
    onOpen:  #type (pVFS: *ma_vfs, pFilePath: *u8, openMode: ma_uint32, pFile: *ma_vfs_file) -> ma_result #c_call;
    onOpenW: #type (pVFS: *ma_vfs, pFilePath: *s32, openMode: ma_uint32, pFile: *ma_vfs_file) -> ma_result #c_call;
    onClose: #type (pVFS: *ma_vfs, file: ma_vfs_file) -> ma_result #c_call;
    onRead:  #type (pVFS: *ma_vfs, file: ma_vfs_file, pDst: *void, sizeInBytes: u64, pBytesRead: *u64) -> ma_result #c_call;
    onWrite: #type (pVFS: *ma_vfs, file: ma_vfs_file, pSrc: *void, sizeInBytes: u64, pBytesWritten: *u64) -> ma_result #c_call;
    onSeek:  #type (pVFS: *ma_vfs, file: ma_vfs_file, offset: ma_int64, origin: ma_seek_origin) -> ma_result #c_call;
    onTell:  #type (pVFS: *ma_vfs, file: ma_vfs_file, pCursor: *ma_int64) -> ma_result #c_call;
    onInfo:  #type (pVFS: *ma_vfs, file: ma_vfs_file, pInfo: *ma_file_info) -> ma_result #c_call;
}

ma_vfs_open :: (pVFS: *ma_vfs, pFilePath: *u8, openMode: ma_uint32, pFile: *ma_vfs_file) -> ma_result #foreign libminiaudio;
ma_vfs_open_w :: (pVFS: *ma_vfs, pFilePath: *s32, openMode: ma_uint32, pFile: *ma_vfs_file) -> ma_result #foreign libminiaudio;
ma_vfs_close :: (pVFS: *ma_vfs, file: ma_vfs_file) -> ma_result #foreign libminiaudio;
ma_vfs_read :: (pVFS: *ma_vfs, file: ma_vfs_file, pDst: *void, sizeInBytes: u64, pBytesRead: *u64) -> ma_result #foreign libminiaudio;
ma_vfs_write :: (pVFS: *ma_vfs, file: ma_vfs_file, pSrc: *void, sizeInBytes: u64, pBytesWritten: *u64) -> ma_result #foreign libminiaudio;
ma_vfs_seek :: (pVFS: *ma_vfs, file: ma_vfs_file, offset: ma_int64, origin: ma_seek_origin) -> ma_result #foreign libminiaudio;
ma_vfs_tell :: (pVFS: *ma_vfs, file: ma_vfs_file, pCursor: *ma_int64) -> ma_result #foreign libminiaudio;
ma_vfs_info :: (pVFS: *ma_vfs, file: ma_vfs_file, pInfo: *ma_file_info) -> ma_result #foreign libminiaudio;
ma_vfs_open_and_read_file :: (pVFS: *ma_vfs, pFilePath: *u8, ppData: **void, pSize: *u64, pAllocationCallbacks: *ma_allocation_callbacks) -> ma_result #foreign libminiaudio;

ma_default_vfs :: struct {
    cb:                  ma_vfs_callbacks;
    allocationCallbacks: ma_allocation_callbacks; /* Only used for the wchar_t version of open() on non-Windows platforms. */
}

ma_default_vfs_init :: (pVFS: *ma_default_vfs, pAllocationCallbacks: *ma_allocation_callbacks) -> ma_result #foreign libminiaudio;

ma_read_proc :: #type (pUserData: *void, pBufferOut: *void, bytesToRead: u64, pBytesRead: *u64) -> ma_result #c_call;
ma_seek_proc :: #type (pUserData: *void, offset: ma_int64, origin: ma_seek_origin) -> ma_result #c_call;
ma_tell_proc :: #type (pUserData: *void, pCursor: *ma_int64) -> ma_result #c_call;

ma_encoding_format :: enum u32 {
    unknown :: 0;
    wav     :: 1;
    flac    :: 2;
    mp3     :: 3;
    vorbis  :: 4;

    ma_encoding_format_unknown :: unknown;
    ma_encoding_format_wav     :: wav;
    ma_encoding_format_flac    :: flac;
    ma_encoding_format_mp3     :: mp3;
    ma_encoding_format_vorbis  :: vorbis;
}

ma_decoding_backend_config :: struct {
    preferredFormat: ma_format;
    seekPointCount:  ma_uint32; /* Set to > 0 to generate a seektable if the decoding backend supports it. */
}

ma_decoding_backend_config_init :: (preferredFormat: ma_format, seekPointCount: ma_uint32) -> ma_decoding_backend_config #foreign libminiaudio;

ma_decoding_backend_vtable :: struct {
    onInit:       #type (pUserData: *void, onRead: ma_read_proc, onSeek: ma_seek_proc, onTell: ma_tell_proc, pReadSeekTellUserData: *void, pConfig: *ma_decoding_backend_config, pAllocationCallbacks: *ma_allocation_callbacks, ppBackend: **ma_data_source) -> ma_result #c_call;
    onInitFile:   #type (pUserData: *void, pFilePath: *u8, pConfig: *ma_decoding_backend_config, pAllocationCallbacks: *ma_allocation_callbacks, ppBackend: **ma_data_source) -> ma_result #c_call; /* Optional. */
    onInitFileW:  #type (pUserData: *void, pFilePath: *s32, pConfig: *ma_decoding_backend_config, pAllocationCallbacks: *ma_allocation_callbacks, ppBackend: **ma_data_source) -> ma_result #c_call; /* Optional. */
    onInitMemory: #type (pUserData: *void, pData: *void, dataSize: u64, pConfig: *ma_decoding_backend_config, pAllocationCallbacks: *ma_allocation_callbacks, ppBackend: **ma_data_source) -> ma_result #c_call; /* Optional. */
    onUninit:     #type (pUserData: *void, pBackend: *ma_data_source, pAllocationCallbacks: *ma_allocation_callbacks) -> void #c_call;
}

/*
The read callback should return MA_SUCCESS if more than zero bytes were successfully read. If zero
bytes can be read because it reached the end of the file, return MA_AT_END. If any other error
occurs just return any other error code (it's fine to just generically return MA_ERROR).

Return the actual number of bytes read in `pBytesRead`. Important note: if the number of bytes
actually read is less than the number of bytes requested (bytesToRead), miniaudio will treat it as
if the end of the file has been reached and it will stop decoding. This becomes relevant for things
like streaming data sources, such as internet streams. If you haven't yet received `bytesToRead`
from the network, you need to have your callback wait for it and then only return when the full
number of bytes can be output, or when you've reached the genuine end of the stream.
*/
ma_decoder_read_proc :: #type (pDecoder: *ma_decoder, pBufferOut: *void, bytesToRead: u64, pBytesRead: *u64) -> ma_result #c_call;
ma_decoder_seek_proc :: #type (pDecoder: *ma_decoder, byteOffset: ma_int64, origin: ma_seek_origin) -> ma_result #c_call;
ma_decoder_tell_proc :: #type (pDecoder: *ma_decoder, pCursor: *ma_int64) -> ma_result #c_call;

ma_decoder_config :: struct {
    format:                 ma_format; /* Set to 0 or ma_format_unknown to use the stream's internal format. */
    channels:               ma_uint32; /* Set to 0 to use the stream's internal channels. */
    sampleRate:             ma_uint32; /* Set to 0 to use the stream's internal sample rate. */
    pChannelMap:            *ma_channel;
    channelMixMode:         ma_channel_mix_mode;
    ditherMode:             ma_dither_mode;
    resampling:             ma_resampler_config;
    allocationCallbacks:    ma_allocation_callbacks;
    encodingFormat:         ma_encoding_format;
    seekPointCount:         ma_uint32; /* When set to > 0, specifies the number of seek points to use for the generation of a seek table. Not all decoding backends support this. */
    ppCustomBackendVTables: **ma_decoding_backend_vtable;
    customBackendCount:     ma_uint32;
    pCustomBackendUserData: *void;
}

ma_decoder :: struct {
    ds:                     ma_data_source_base;
    pBackend:               *ma_data_source; /* The decoding backend we'll be pulling data from. */
    pBackendVTable:         *ma_decoding_backend_vtable; /* The vtable for the decoding backend. This needs to be stored so we can access the onUninit() callback. */
    pBackendUserData:       *void;
    onRead:                 ma_decoder_read_proc;
    onSeek:                 ma_decoder_seek_proc;
    onTell:                 ma_decoder_tell_proc;
    pUserData:              *void;
    readPointerInPCMFrames: ma_uint64; /* In output sample rate. Used for keeping track of how many frames are available for decoding. */
    outputFormat:           ma_format;
    outputChannels:         ma_uint32;
    outputSampleRate:       ma_uint32;
    converter:              ma_data_converter; /* Data conversion is achieved by running frames through this. */
    pInputCache:            *void; /* In input format. Can be null if it's not needed. */
    inputCacheCap:          ma_uint64; /* The capacity of the input cache. */
    inputCacheConsumed:     ma_uint64; /* The number of frames that have been consumed in the cache. Used for determining the next valid frame. */
    inputCacheRemaining:    ma_uint64; /* The number of valid frames remaining in the cache. */
    allocationCallbacks:    ma_allocation_callbacks;
    data:                   struct {
        memory: struct {
            pData:          *ma_uint8;
            dataSize:       u64;
            currentReadPos: u64;
        }; // largest member, moved to the start of the struct/union to support #overlay. /* Only used for decoders that were opened against a block of memory. */

        #overlay (memory) vfs: struct {
            pVFS: *ma_vfs;
            file: ma_vfs_file;
        };
    };
}

ma_decoder_config_init :: (outputFormat: ma_format, outputChannels: ma_uint32, outputSampleRate: ma_uint32) -> ma_decoder_config #foreign libminiaudio;
ma_decoder_config_init_default :: () -> ma_decoder_config #foreign libminiaudio;

ma_decoder_init :: (onRead: ma_decoder_read_proc, onSeek: ma_decoder_seek_proc, pUserData: *void, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;
ma_decoder_init_memory :: (pData: *void, dataSize: u64, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;
ma_decoder_init_vfs :: (pVFS: *ma_vfs, pFilePath: *u8, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;
ma_decoder_init_vfs_w :: (pVFS: *ma_vfs, pFilePath: *s32, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;
ma_decoder_init_file :: (pFilePath: *u8, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;
ma_decoder_init_file_w :: (pFilePath: *s32, pConfig: *ma_decoder_config, pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;

/*
Uninitializes a decoder.
*/
ma_decoder_uninit :: (pDecoder: *ma_decoder) -> ma_result #foreign libminiaudio;

/*
Reads PCM frames from the given decoder.

This is not thread safe without your own synchronization.
*/
ma_decoder_read_pcm_frames :: (pDecoder: *ma_decoder, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Seeks to a PCM frame based on its absolute index.

This is not thread safe without your own synchronization.
*/
ma_decoder_seek_to_pcm_frame :: (pDecoder: *ma_decoder, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;

/*
Retrieves the decoder's output data format.
*/
ma_decoder_get_data_format :: (pDecoder: *ma_decoder, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;

/*
Retrieves the current position of the read cursor in PCM frames.
*/
ma_decoder_get_cursor_in_pcm_frames :: (pDecoder: *ma_decoder, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Retrieves the length of the decoder in PCM frames.

Do not call this on streams of an undefined length, such as internet radio.

If the length is unknown or an error occurs, 0 will be returned.

This will always return 0 for Vorbis decoders. This is due to a limitation with stb_vorbis in push mode which is what miniaudio
uses internally.

For MP3's, this will decode the entire file. Do not call this in time critical scenarios.

This function is not thread safe without your own synchronization.
*/
ma_decoder_get_length_in_pcm_frames :: (pDecoder: *ma_decoder, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Retrieves the number of frames that can be read before reaching the end.

This calls `ma_decoder_get_length_in_pcm_frames()` so you need to be aware of the rules for that function, in
particular ensuring you do not call it on streams of an undefined length, such as internet radio.

If the total length of the decoder cannot be retrieved, such as with Vorbis decoders, `MA_NOT_IMPLEMENTED` will be
returned.
*/
ma_decoder_get_available_frames :: (pDecoder: *ma_decoder, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

/*
Helper for opening and decoding a file into a heap allocated block of memory. Free the returned pointer with ma_free(). On input,
pConfig should be set to what you want. On output it will be set to what you got.
*/
ma_decode_from_vfs :: (pVFS: *ma_vfs, pFilePath: *u8, pConfig: *ma_decoder_config, pFrameCountOut: *ma_uint64, ppPCMFramesOut: **void) -> ma_result #foreign libminiaudio;
ma_decode_file :: (pFilePath: *u8, pConfig: *ma_decoder_config, pFrameCountOut: *ma_uint64, ppPCMFramesOut: **void) -> ma_result #foreign libminiaudio;
ma_decode_memory :: (pData: *void, dataSize: u64, pConfig: *ma_decoder_config, pFrameCountOut: *ma_uint64, ppPCMFramesOut: **void) -> ma_result #foreign libminiaudio;

ma_encoder_write_proc :: #type (pEncoder: *ma_encoder, pBufferIn: *void, bytesToWrite: u64, pBytesWritten: *u64) -> ma_result #c_call;
ma_encoder_seek_proc :: #type (pEncoder: *ma_encoder, offset: ma_int64, origin: ma_seek_origin) -> ma_result #c_call;
ma_encoder_init_proc :: #type (pEncoder: *ma_encoder) -> ma_result #c_call;
ma_encoder_uninit_proc :: #type (pEncoder: *ma_encoder) -> void #c_call;
ma_encoder_write_pcm_frames_proc :: #type (pEncoder: *ma_encoder, pFramesIn: *void, frameCount: ma_uint64, pFramesWritten: *ma_uint64) -> ma_result #c_call;

ma_encoder_config :: struct {
    encodingFormat:      ma_encoding_format;
    format:              ma_format;
    channels:            ma_uint32;
    sampleRate:          ma_uint32;
    allocationCallbacks: ma_allocation_callbacks;
}

ma_encoder_config_init :: (encodingFormat: ma_encoding_format, format: ma_format, channels: ma_uint32, sampleRate: ma_uint32) -> ma_encoder_config #foreign libminiaudio;

ma_encoder :: struct {
    config:           ma_encoder_config;
    onWrite:          ma_encoder_write_proc;
    onSeek:           ma_encoder_seek_proc;
    onInit:           ma_encoder_init_proc;
    onUninit:         ma_encoder_uninit_proc;
    onWritePCMFrames: ma_encoder_write_pcm_frames_proc;
    pUserData:        *void;
    pInternalEncoder: *void;
    data:             struct {
        vfs: struct {
            pVFS: *ma_vfs;
            file: ma_vfs_file;
        };
    };
}

ma_encoder_init :: (onWrite: ma_encoder_write_proc, onSeek: ma_encoder_seek_proc, pUserData: *void, pConfig: *ma_encoder_config, pEncoder: *ma_encoder) -> ma_result #foreign libminiaudio;
ma_encoder_init_vfs :: (pVFS: *ma_vfs, pFilePath: *u8, pConfig: *ma_encoder_config, pEncoder: *ma_encoder) -> ma_result #foreign libminiaudio;
ma_encoder_init_vfs_w :: (pVFS: *ma_vfs, pFilePath: *s32, pConfig: *ma_encoder_config, pEncoder: *ma_encoder) -> ma_result #foreign libminiaudio;
ma_encoder_init_file :: (pFilePath: *u8, pConfig: *ma_encoder_config, pEncoder: *ma_encoder) -> ma_result #foreign libminiaudio;
ma_encoder_init_file_w :: (pFilePath: *s32, pConfig: *ma_encoder_config, pEncoder: *ma_encoder) -> ma_result #foreign libminiaudio;
ma_encoder_uninit :: (pEncoder: *ma_encoder) -> void #foreign libminiaudio;
ma_encoder_write_pcm_frames :: (pEncoder: *ma_encoder, pFramesIn: *void, frameCount: ma_uint64, pFramesWritten: *ma_uint64) -> ma_result #foreign libminiaudio;

ma_waveform_type :: enum u32 {
    sine     :: 0;
    square   :: 1;
    triangle :: 2;
    sawtooth :: 3;

    ma_waveform_type_sine     :: sine;
    ma_waveform_type_square   :: square;
    ma_waveform_type_triangle :: triangle;
    ma_waveform_type_sawtooth :: sawtooth;
}

ma_waveform_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    type:       ma_waveform_type;
    amplitude:  float64;
    frequency:  float64;
}

ma_waveform_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, type: ma_waveform_type, amplitude: float64, frequency: float64) -> ma_waveform_config #foreign libminiaudio;

ma_waveform :: struct {
    ds:      ma_data_source_base;
    config:  ma_waveform_config;
    advance: float64;
    time:    float64;
}

ma_waveform_init :: (pConfig: *ma_waveform_config, pWaveform: *ma_waveform) -> ma_result #foreign libminiaudio;
ma_waveform_uninit :: (pWaveform: *ma_waveform) -> void #foreign libminiaudio;
ma_waveform_read_pcm_frames :: (pWaveform: *ma_waveform, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_waveform_seek_to_pcm_frame :: (pWaveform: *ma_waveform, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_waveform_set_amplitude :: (pWaveform: *ma_waveform, amplitude: float64) -> ma_result #foreign libminiaudio;
ma_waveform_set_frequency :: (pWaveform: *ma_waveform, frequency: float64) -> ma_result #foreign libminiaudio;
ma_waveform_set_type :: (pWaveform: *ma_waveform, type: ma_waveform_type) -> ma_result #foreign libminiaudio;
ma_waveform_set_sample_rate :: (pWaveform: *ma_waveform, sampleRate: ma_uint32) -> ma_result #foreign libminiaudio;

ma_pulsewave_config :: struct {
    format:     ma_format;
    channels:   ma_uint32;
    sampleRate: ma_uint32;
    dutyCycle:  float64;
    amplitude:  float64;
    frequency:  float64;
}

ma_pulsewave_config_init :: (format: ma_format, channels: ma_uint32, sampleRate: ma_uint32, dutyCycle: float64, amplitude: float64, frequency: float64) -> ma_pulsewave_config #foreign libminiaudio;

ma_pulsewave :: struct {
    waveform: ma_waveform;
    config:   ma_pulsewave_config;
}

ma_pulsewave_init :: (pConfig: *ma_pulsewave_config, pWaveform: *ma_pulsewave) -> ma_result #foreign libminiaudio;
ma_pulsewave_uninit :: (pWaveform: *ma_pulsewave) -> void #foreign libminiaudio;
ma_pulsewave_read_pcm_frames :: (pWaveform: *ma_pulsewave, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_pulsewave_seek_to_pcm_frame :: (pWaveform: *ma_pulsewave, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_pulsewave_set_amplitude :: (pWaveform: *ma_pulsewave, amplitude: float64) -> ma_result #foreign libminiaudio;
ma_pulsewave_set_frequency :: (pWaveform: *ma_pulsewave, frequency: float64) -> ma_result #foreign libminiaudio;
ma_pulsewave_set_sample_rate :: (pWaveform: *ma_pulsewave, sampleRate: ma_uint32) -> ma_result #foreign libminiaudio;
ma_pulsewave_set_duty_cycle :: (pWaveform: *ma_pulsewave, dutyCycle: float64) -> ma_result #foreign libminiaudio;

ma_noise_type :: enum u32 {
    white    :: 0;
    pink     :: 1;
    brownian :: 2;

    ma_noise_type_white    :: white;
    ma_noise_type_pink     :: pink;
    ma_noise_type_brownian :: brownian;
}

ma_noise_config :: struct {
    format:            ma_format;
    channels:          ma_uint32;
    type:              ma_noise_type;
    seed:              ma_int32;
    amplitude:         float64;
    duplicateChannels: ma_bool32;
}

ma_noise_config_init :: (format: ma_format, channels: ma_uint32, type: ma_noise_type, seed: ma_int32, amplitude: float64) -> ma_noise_config #foreign libminiaudio;

ma_noise :: struct {
    ds:        ma_data_source_base;
    config:    ma_noise_config;
    lcg:       ma_lcg;
    state:     struct {
        pink: struct {
            bin:          **float64;
            accumulation: *float64;
            counter:      *ma_uint32;
        };

        #overlay (pink) brownian: struct {
            accumulation: *float64;
        };
    };

    /* Memory management. */
    _pHeap:    *void;
    _ownsHeap: ma_bool32;
}

ma_noise_get_heap_size :: (pConfig: *ma_noise_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_noise_init_preallocated :: (pConfig: *ma_noise_config, pHeap: *void, pNoise: *ma_noise) -> ma_result #foreign libminiaudio;
ma_noise_init :: (pConfig: *ma_noise_config, pAllocationCallbacks: *ma_allocation_callbacks, pNoise: *ma_noise) -> ma_result #foreign libminiaudio;
ma_noise_uninit :: (pNoise: *ma_noise, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_noise_read_pcm_frames :: (pNoise: *ma_noise, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_noise_set_amplitude :: (pNoise: *ma_noise, amplitude: float64) -> ma_result #foreign libminiaudio;
ma_noise_set_seed :: (pNoise: *ma_noise, seed: ma_int32) -> ma_result #foreign libminiaudio;
ma_noise_set_type :: (pNoise: *ma_noise, type: ma_noise_type) -> ma_result #foreign libminiaudio;

ma_resource_manager_data_source_flags :: enum u32 {
    STREAM         :: 1;
    DECODE         :: 2;
    ASYNC          :: 4;
    WAIT_INIT      :: 8;
    UNKNOWN_LENGTH :: 16;
    LOOPING        :: 32;

    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM         :: STREAM;
    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE         :: DECODE;
    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC          :: ASYNC;
    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_WAIT_INIT      :: WAIT_INIT;
    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_UNKNOWN_LENGTH :: UNKNOWN_LENGTH;
    MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_LOOPING        :: LOOPING;
}

/*
Pipeline notifications used by the resource manager. Made up of both an async notification and a fence, both of which are optional.
*/
ma_resource_manager_pipeline_stage_notification :: struct {
    pNotification: *ma_async_notification;
    pFence:        *ma_fence;
}

ma_resource_manager_pipeline_notifications :: struct {
    init: ma_resource_manager_pipeline_stage_notification; /* Initialization of the decoder. */
    done: ma_resource_manager_pipeline_stage_notification; /* Decoding fully completed. */
}

ma_resource_manager_pipeline_notifications_init :: () -> ma_resource_manager_pipeline_notifications #foreign libminiaudio;

ma_resource_manager_flags :: enum u32 {
    NON_BLOCKING :: 1;

    NO_THREADING :: 2;

    MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING :: NON_BLOCKING;

    MA_RESOURCE_MANAGER_FLAG_NO_THREADING :: NO_THREADING;
}

ma_resource_manager_data_source_config :: struct {
    pFilePath:                   *u8;
    pFilePathW:                  *s32;
    pNotifications:              *ma_resource_manager_pipeline_notifications;
    initialSeekPointInPCMFrames: ma_uint64;
    rangeBegInPCMFrames:         ma_uint64;
    rangeEndInPCMFrames:         ma_uint64;
    loopPointBegInPCMFrames:     ma_uint64;
    loopPointEndInPCMFrames:     ma_uint64;
    flags:                       ma_uint32;
    isLooping:                   ma_bool32; /* Deprecated. Use the MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_LOOPING flag in `flags` instead. */
}

ma_resource_manager_data_source_config_init :: () -> ma_resource_manager_data_source_config #foreign libminiaudio;

ma_resource_manager_data_supply_type :: enum u32 {
    unknown       :: 0;
    encoded       :: 1;
    decoded       :: 2;
    decoded_paged :: 3;

    ma_resource_manager_data_supply_type_unknown       :: unknown;
    ma_resource_manager_data_supply_type_encoded       :: encoded;
    ma_resource_manager_data_supply_type_decoded       :: decoded;
    ma_resource_manager_data_supply_type_decoded_paged :: decoded_paged;
}

ma_resource_manager_data_supply :: struct {
    type:    ma_resource_manager_data_supply_type; /* Read and written from different threads so needs to be accessed atomically. */
    backend: struct {
        decodedPaged: struct {
            data:              ma_paged_audio_buffer_data;
            decodedFrameCount: ma_uint64;
            sampleRate:        ma_uint32;
        }; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (decodedPaged) encoded: struct {
            pData:       *void;
            sizeInBytes: u64;
        };
        #overlay (decodedPaged) decoded: struct {
            pData:             *void;
            totalFrameCount:   ma_uint64;
            decodedFrameCount: ma_uint64;
            format:            ma_format;
            channels:          ma_uint32;
            sampleRate:        ma_uint32;
        };
    };
}

ma_resource_manager_data_buffer_node :: struct {
    hashedName32:                 ma_uint32; /* The hashed name. This is the key. */
    refCount:                     ma_uint32;
    result:                       ma_result; /* Result from asynchronous loading. When loading set to MA_BUSY. When fully loaded set to MA_SUCCESS. When deleting set to MA_UNAVAILABLE. */
    executionCounter:             ma_uint32; /* For allocating execution orders for jobs. */
    executionPointer:             ma_uint32; /* For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing. */
    isDataOwnedByResourceManager: ma_bool32; /* Set to true when the underlying data buffer was allocated the resource manager. Set to false if it is owned by the application (via ma_resource_manager_register_*()). */
    data:                         ma_resource_manager_data_supply;
    pParent:                      *ma_resource_manager_data_buffer_node;
    pChildLo:                     *ma_resource_manager_data_buffer_node;
    pChildHi:                     *ma_resource_manager_data_buffer_node;
}

ma_resource_manager_data_buffer :: struct {
    ds:                     ma_data_source_base; /* Base data source. A data buffer is a data source. */
    pResourceManager:       *ma_resource_manager; /* A pointer to the resource manager that owns this buffer. */
    pNode:                  *ma_resource_manager_data_buffer_node; /* The data node. This is reference counted and is what supplies the data. */
    flags:                  ma_uint32; /* The flags that were passed used to initialize the buffer. */
    executionCounter:       ma_uint32; /* For allocating execution orders for jobs. */
    executionPointer:       ma_uint32; /* For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing. */
    seekTargetInPCMFrames:  ma_uint64; /* Only updated by the public API. Never written nor read from the job thread. */
    seekToCursorOnNextRead: ma_bool32; /* On the next read we need to seek to the frame cursor. */
    result:                 ma_result; /* Keeps track of a result of decoding. Set to MA_BUSY while the buffer is still loading. Set to MA_SUCCESS when loading is finished successfully. Otherwise set to some other code. */
    isLooping:              ma_bool32; /* Can be read and written by different threads at the same time. Must be used atomically. */
    isConnectorInitialized: ma_atomic_bool32; /* Used for asynchronous loading to ensure we don't try to initialize the connector multiple times while waiting for the node to fully load. */
    connector:              struct {
        decoder: ma_decoder; /* Supply type is ma_resource_manager_data_supply_type_encoded */

        #overlay (decoder) buffer:      ma_audio_buffer; /* Supply type is ma_resource_manager_data_supply_type_decoded */
        #overlay (decoder) pagedBuffer: ma_paged_audio_buffer; /* Supply type is ma_resource_manager_data_supply_type_decoded_paged */
    }; /* Connects this object to the node's data supply. */
}

ma_resource_manager_data_stream :: struct {
    ds:                     ma_data_source_base; /* Base data source. A data stream is a data source. */
    pResourceManager:       *ma_resource_manager; /* A pointer to the resource manager that owns this data stream. */
    flags:                  ma_uint32; /* The flags that were passed used to initialize the stream. */
    decoder:                ma_decoder; /* Used for filling pages with data. This is only ever accessed by the job thread. The public API should never touch this. */
    isDecoderInitialized:   ma_bool32; /* Required for determining whether or not the decoder should be uninitialized in MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_STREAM. */
    totalLengthInPCMFrames: ma_uint64; /* This is calculated when first loaded by the MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_STREAM. */
    relativeCursor:         ma_uint32; /* The playback cursor, relative to the current page. Only ever accessed by the public API. Never accessed by the job thread. */
    absoluteCursor:         ma_uint64; /* The playback cursor, in absolute position starting from the start of the file. */
    currentPageIndex:       ma_uint32; /* Toggles between 0 and 1. Index 0 is the first half of pPageData. Index 1 is the second half. Only ever accessed by the public API. Never accessed by the job thread. */
    executionCounter:       ma_uint32; /* For allocating execution orders for jobs. */
    executionPointer:       ma_uint32; /* For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing. */

    isLooping:              ma_bool32; /* Whether or not the stream is looping. It's important to set the looping flag at the data stream level for smooth loop transitions. */

    pPageData:              *void; /* Buffer containing the decoded data of each page. Allocated once at initialization time. */
    pageFrameCount:         [2] ma_uint32; /* The number of valid PCM frames in each page. Used to determine the last valid frame. */

    result:                 ma_result; /* Result from asynchronous loading. When loading set to MA_BUSY. When initialized set to MA_SUCCESS. When deleting set to MA_UNAVAILABLE. If an error occurs when loading, set to an error code. */
    isDecoderAtEnd:         ma_bool32; /* Whether or not the decoder has reached the end. */
    isPageValid:            [2] ma_bool32; /* Booleans to indicate whether or not a page is valid. Set to false by the public API, set to true by the job thread. Set to false as the pages are consumed, true when they are filled. */
    seekCounter:            ma_bool32; /* When 0, no seeking is being performed. When > 0, a seek is being performed and reading should be delayed with MA_BUSY. */
}

ma_resource_manager_data_source :: struct {
    backend:          struct {
        stream: ma_resource_manager_data_stream; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (stream) buffer: ma_resource_manager_data_buffer;
    }; /* Must be the first item because we need the first item to be the data source callbacks for the buffer or stream. */

    flags:            ma_uint32; /* The flags that were passed in to ma_resource_manager_data_source_init(). */
    executionCounter: ma_uint32; /* For allocating execution orders for jobs. */
    executionPointer: ma_uint32; /* For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing. */
}

ma_resource_manager_config :: struct {
    allocationCallbacks:            ma_allocation_callbacks;
    pLog:                           *ma_log;
    decodedFormat:                  ma_format; /* The decoded format to use. Set to ma_format_unknown (default) to use the file's native format. */
    decodedChannels:                ma_uint32; /* The decoded channel count to use. Set to 0 (default) to use the file's native channel count. */
    decodedSampleRate:              ma_uint32; /* the decoded sample rate to use. Set to 0 (default) to use the file's native sample rate. */
    jobThreadCount:                 ma_uint32; /* Set to 0 if you want to self-manage your job threads. Defaults to 1. */
    jobThreadStackSize:             u64;
    jobQueueCapacity:               ma_uint32; /* The maximum number of jobs that can fit in the queue at a time. Defaults to MA_JOB_TYPE_RESOURCE_MANAGER_QUEUE_CAPACITY. Cannot be zero. */
    flags:                          ma_uint32;
    pVFS:                           *ma_vfs; /* Can be NULL in which case defaults will be used. */
    ppCustomDecodingBackendVTables: **ma_decoding_backend_vtable;
    customDecodingBackendCount:     ma_uint32;
    pCustomDecodingBackendUserData: *void;
    resampling:                     ma_resampler_config;
}

ma_resource_manager_config_init :: () -> ma_resource_manager_config #foreign libminiaudio;

ma_resource_manager :: struct {
    config:              ma_resource_manager_config;
    pRootDataBufferNode: *ma_resource_manager_data_buffer_node; /* The root buffer in the binary tree. */

    dataBufferBSTLock:   ma_mutex; /* For synchronizing access to the data buffer binary tree. */
    jobThreads:          [64] ma_thread; /* The threads for executing jobs. */

    jobQueue:            ma_job_queue; /* Multi-consumer, multi-producer job queue for managing jobs for asynchronous decoding and streaming. */
    defaultVFS:          ma_default_vfs; /* Only used if a custom VFS is not specified. */
    log:                 ma_log; /* Only used if no log was specified in the config. */
}

/* Init. */
ma_resource_manager_init :: (pConfig: *ma_resource_manager_config, pResourceManager: *ma_resource_manager) -> ma_result #foreign libminiaudio;
ma_resource_manager_uninit :: (pResourceManager: *ma_resource_manager) -> void #foreign libminiaudio;
ma_resource_manager_get_log :: (pResourceManager: *ma_resource_manager) -> *ma_log #foreign libminiaudio;

/* Registration. */
ma_resource_manager_register_file :: (pResourceManager: *ma_resource_manager, pFilePath: *u8, flags: ma_uint32) -> ma_result #foreign libminiaudio;
ma_resource_manager_register_file_w :: (pResourceManager: *ma_resource_manager, pFilePath: *s32, flags: ma_uint32) -> ma_result #foreign libminiaudio;
ma_resource_manager_register_decoded_data :: (pResourceManager: *ma_resource_manager, pName: *u8, pData: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32, sampleRate: ma_uint32) -> ma_result #foreign libminiaudio;
ma_resource_manager_register_decoded_data_w :: (pResourceManager: *ma_resource_manager, pName: *s32, pData: *void, frameCount: ma_uint64, format: ma_format, channels: ma_uint32, sampleRate: ma_uint32) -> ma_result #foreign libminiaudio;
ma_resource_manager_register_encoded_data :: (pResourceManager: *ma_resource_manager, pName: *u8, pData: *void, sizeInBytes: u64) -> ma_result #foreign libminiaudio;
ma_resource_manager_register_encoded_data_w :: (pResourceManager: *ma_resource_manager, pName: *s32, pData: *void, sizeInBytes: u64) -> ma_result #foreign libminiaudio;
ma_resource_manager_unregister_file :: (pResourceManager: *ma_resource_manager, pFilePath: *u8) -> ma_result #foreign libminiaudio;
ma_resource_manager_unregister_file_w :: (pResourceManager: *ma_resource_manager, pFilePath: *s32) -> ma_result #foreign libminiaudio;
ma_resource_manager_unregister_data :: (pResourceManager: *ma_resource_manager, pName: *u8) -> ma_result #foreign libminiaudio;
ma_resource_manager_unregister_data_w :: (pResourceManager: *ma_resource_manager, pName: *s32) -> ma_result #foreign libminiaudio;

/* Data Buffers. */
ma_resource_manager_data_buffer_init_ex :: (pResourceManager: *ma_resource_manager, pConfig: *ma_resource_manager_data_source_config, pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_init :: (pResourceManager: *ma_resource_manager, pFilePath: *u8, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_init_w :: (pResourceManager: *ma_resource_manager, pFilePath: *s32, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_init_copy :: (pResourceManager: *ma_resource_manager, pExistingDataBuffer: *ma_resource_manager_data_buffer, pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_uninit :: (pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_read_pcm_frames :: (pDataBuffer: *ma_resource_manager_data_buffer, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_seek_to_pcm_frame :: (pDataBuffer: *ma_resource_manager_data_buffer, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_get_data_format :: (pDataBuffer: *ma_resource_manager_data_buffer, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_get_cursor_in_pcm_frames :: (pDataBuffer: *ma_resource_manager_data_buffer, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_get_length_in_pcm_frames :: (pDataBuffer: *ma_resource_manager_data_buffer, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_result :: (pDataBuffer: *ma_resource_manager_data_buffer) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_set_looping :: (pDataBuffer: *ma_resource_manager_data_buffer, isLooping: ma_bool32) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_buffer_is_looping :: (pDataBuffer: *ma_resource_manager_data_buffer) -> ma_bool32 #foreign libminiaudio;
ma_resource_manager_data_buffer_get_available_frames :: (pDataBuffer: *ma_resource_manager_data_buffer, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

/* Data Streams. */
ma_resource_manager_data_stream_init_ex :: (pResourceManager: *ma_resource_manager, pConfig: *ma_resource_manager_data_source_config, pDataStream: *ma_resource_manager_data_stream) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_init :: (pResourceManager: *ma_resource_manager, pFilePath: *u8, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataStream: *ma_resource_manager_data_stream) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_init_w :: (pResourceManager: *ma_resource_manager, pFilePath: *s32, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataStream: *ma_resource_manager_data_stream) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_uninit :: (pDataStream: *ma_resource_manager_data_stream) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_read_pcm_frames :: (pDataStream: *ma_resource_manager_data_stream, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_seek_to_pcm_frame :: (pDataStream: *ma_resource_manager_data_stream, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_get_data_format :: (pDataStream: *ma_resource_manager_data_stream, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_get_cursor_in_pcm_frames :: (pDataStream: *ma_resource_manager_data_stream, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_get_length_in_pcm_frames :: (pDataStream: *ma_resource_manager_data_stream, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_result :: (pDataStream: *ma_resource_manager_data_stream) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_set_looping :: (pDataStream: *ma_resource_manager_data_stream, isLooping: ma_bool32) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_stream_is_looping :: (pDataStream: *ma_resource_manager_data_stream) -> ma_bool32 #foreign libminiaudio;
ma_resource_manager_data_stream_get_available_frames :: (pDataStream: *ma_resource_manager_data_stream, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

/* Data Sources. */
ma_resource_manager_data_source_init_ex :: (pResourceManager: *ma_resource_manager, pConfig: *ma_resource_manager_data_source_config, pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_init :: (pResourceManager: *ma_resource_manager, pName: *u8, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_init_w :: (pResourceManager: *ma_resource_manager, pName: *s32, flags: ma_uint32, pNotifications: *ma_resource_manager_pipeline_notifications, pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_init_copy :: (pResourceManager: *ma_resource_manager, pExistingDataSource: *ma_resource_manager_data_source, pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_uninit :: (pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_read_pcm_frames :: (pDataSource: *ma_resource_manager_data_source, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_seek_to_pcm_frame :: (pDataSource: *ma_resource_manager_data_source, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_get_data_format :: (pDataSource: *ma_resource_manager_data_source, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_get_cursor_in_pcm_frames :: (pDataSource: *ma_resource_manager_data_source, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_get_length_in_pcm_frames :: (pDataSource: *ma_resource_manager_data_source, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_result :: (pDataSource: *ma_resource_manager_data_source) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_set_looping :: (pDataSource: *ma_resource_manager_data_source, isLooping: ma_bool32) -> ma_result #foreign libminiaudio;
ma_resource_manager_data_source_is_looping :: (pDataSource: *ma_resource_manager_data_source) -> ma_bool32 #foreign libminiaudio;
ma_resource_manager_data_source_get_available_frames :: (pDataSource: *ma_resource_manager_data_source, pAvailableFrames: *ma_uint64) -> ma_result #foreign libminiaudio;

/* Job management. */
ma_resource_manager_post_job :: (pResourceManager: *ma_resource_manager, pJob: *ma_job) -> ma_result #foreign libminiaudio;
ma_resource_manager_post_job_quit :: (pResourceManager: *ma_resource_manager) -> ma_result #foreign libminiaudio;
ma_resource_manager_next_job :: (pResourceManager: *ma_resource_manager, pJob: *ma_job) -> ma_result #foreign libminiaudio;
ma_resource_manager_process_job :: (pResourceManager: *ma_resource_manager, pJob: *ma_job) -> ma_result #foreign libminiaudio;
ma_resource_manager_process_next_job :: (pResourceManager: *ma_resource_manager) -> ma_result #foreign libminiaudio;

/* For some internal memory management of ma_node_graph. */
ma_stack :: struct {
    offset:      u64;
    sizeInBytes: u64;
    _data:       [1] u8;
}

ma_node :: void;

/* Node flags. */
ma_node_flags :: enum u32 {
    PASSTHROUGH                :: 1;
    CONTINUOUS_PROCESSING      :: 2;
    ALLOW_NULL_INPUT           :: 4;
    DIFFERENT_PROCESSING_RATES :: 8;
    SILENT_OUTPUT              :: 16;

    MA_NODE_FLAG_PASSTHROUGH                :: PASSTHROUGH;
    MA_NODE_FLAG_CONTINUOUS_PROCESSING      :: CONTINUOUS_PROCESSING;
    MA_NODE_FLAG_ALLOW_NULL_INPUT           :: ALLOW_NULL_INPUT;
    MA_NODE_FLAG_DIFFERENT_PROCESSING_RATES :: DIFFERENT_PROCESSING_RATES;
    MA_NODE_FLAG_SILENT_OUTPUT              :: SILENT_OUTPUT;
}

/* The playback state of a node. Either started or stopped. */
ma_node_state :: enum u32 {
    started :: 0;
    stopped :: 1;

    ma_node_state_started :: started;
    ma_node_state_stopped :: stopped;
}

ma_node_vtable :: struct {
    /*
    Extended processing callback. This callback is used for effects that process input and output
    at different rates (i.e. they perform resampling). This is similar to the simple version, only
    they take two separate frame counts: one for input, and one for output.
    
    On input, `pFrameCountOut` is equal to the capacity of the output buffer for each bus, whereas
    `pFrameCountIn` will be equal to the number of PCM frames in each of the buffers in `ppFramesIn`.
    
    On output, set `pFrameCountOut` to the number of PCM frames that were actually output and set
    `pFrameCountIn` to the number of input frames that were consumed.
    */
    onProcess:                    #type (pNode: *ma_node, ppFramesIn: **float, pFrameCountIn: *ma_uint32, ppFramesOut: **float, pFrameCountOut: *ma_uint32) -> void #c_call;

    /*
    A callback for retrieving the number of input frames that are required to output the
    specified number of output frames. You would only want to implement this when the node performs
    resampling. This is optional, even for nodes that perform resampling, but it does offer a
    small reduction in latency as it allows miniaudio to calculate the exact number of input frames
    to read at a time instead of having to estimate.
    */
    onGetRequiredInputFrameCount: #type (pNode: *ma_node, outputFrameCount: ma_uint32, pInputFrameCount: *ma_uint32) -> ma_result #c_call;

    /*
    The number of input buses. This is how many sub-buffers will be contained in the `ppFramesIn`
    parameters of the callbacks above.
    */
    inputBusCount:                ma_uint8;

    /*
    The number of output buses. This is how many sub-buffers will be contained in the `ppFramesOut`
    parameters of the callbacks above.
    */
    outputBusCount:               ma_uint8;

    /*
    Flags describing characteristics of the node. This is currently just a placeholder for some
    ideas for later on.
    */
    flags:                        ma_uint32;
}

ma_node_config :: struct {
    vtable:          *ma_node_vtable; /* Should never be null. Initialization of the node will fail if so. */
    initialState:    ma_node_state; /* Defaults to ma_node_state_started. */
    inputBusCount:   ma_uint32; /* Only used if the vtable specifies an input bus count of `MA_NODE_BUS_COUNT_UNKNOWN`, otherwise must be set to `MA_NODE_BUS_COUNT_UNKNOWN` (default). */
    outputBusCount:  ma_uint32; /* Only used if the vtable specifies an output bus count of `MA_NODE_BUS_COUNT_UNKNOWN`, otherwise  be set to `MA_NODE_BUS_COUNT_UNKNOWN` (default). */
    pInputChannels:  *ma_uint32; /* The number of elements are determined by the input bus count as determined by the vtable, or `inputBusCount` if the vtable specifies `MA_NODE_BUS_COUNT_UNKNOWN`. */
    pOutputChannels: *ma_uint32; /* The number of elements are determined by the output bus count as determined by the vtable, or `outputBusCount` if the vtable specifies `MA_NODE_BUS_COUNT_UNKNOWN`. */
}

ma_node_config_init :: () -> ma_node_config #foreign libminiaudio;

ma_node_output_bus :: struct {
    pNode:                  *ma_node; /* The node that owns this output bus. The input node. Will be null for dummy head and tail nodes. */
    outputBusIndex:         ma_uint8; /* The index of the output bus on pNode that this output bus represents. */
    channels:               ma_uint8; /* The number of channels in the audio stream for this bus. */

    inputNodeInputBusIndex: ma_uint8; /* The index of the input bus on the input. Required for detaching. Will only be used within the spinlock so does not need to be atomic. */
    flags:                  ma_uint32; /* Some state flags for tracking the read state of the output buffer. A combination of MA_NODE_OUTPUT_BUS_FLAG_*. */
    refCount:               ma_uint32; /* Reference count for some thread-safety when detaching. */
    isAttached:             ma_bool32; /* This is used to prevent iteration of nodes that are in the middle of being detached. Used for thread safety. */
    lock:                   ma_spinlock; /* Unfortunate lock, but significantly simplifies the implementation. Required for thread-safe attaching and detaching. */
    volume:                 float; /* Linear. */
    pNext:                  *ma_node_output_bus; /* If null, it's the tail node or detached. */
    pPrev:                  *ma_node_output_bus; /* If null, it's the head node or detached. */
    pInputNode:             *ma_node; /* The node that this output bus is attached to. Required for detaching. */
}

ma_node_input_bus :: struct {
    head:        ma_node_output_bus; /* Dummy head node for simplifying some lock-free thread-safety stuff. */
    nextCounter: ma_uint32; /* This is used to determine whether or not the input bus is finding the next node in the list. Used for thread safety when detaching output buses. */
    lock:        ma_spinlock; /* Unfortunate lock, but significantly simplifies the implementation. Required for thread-safe attaching and detaching. */

    channels:    ma_uint8; /* The number of channels in the audio stream for this bus. */
}

ma_node_base :: struct {
    pNodeGraph:                  *ma_node_graph; /* The graph this node belongs to. */
    vtable:                      *ma_node_vtable;
    inputBusCount:               ma_uint32;
    outputBusCount:              ma_uint32;
    pInputBuses:                 *ma_node_input_bus;
    pOutputBuses:                *ma_node_output_bus;
    pCachedData:                 *float; /* Allocated on the heap. Fixed size. Needs to be stored on the heap because reading from output buses is done in separate function calls. */
    cachedDataCapInFramesPerBus: ma_uint16; /* The capacity of the input data cache in frames, per bus. */

    /* These variables are read and written only from the audio thread. */
    cachedFrameCountOut:         ma_uint16;
    cachedFrameCountIn:          ma_uint16;
    consumedFrameCountIn:        ma_uint16;

    state:                       ma_node_state; /* When set to stopped, nothing will be read, regardless of the times in stateTimes. */
    stateTimes:                  [2] ma_uint64; /* Indexed by ma_node_state. Specifies the time based on the global clock that a node should be considered to be in the relevant state. */
    localTime:                   ma_uint64; /* The node's local clock. This is just a running sum of the number of output frames that have been processed. Can be modified by any thread with `ma_node_set_time()`. */

    /* Memory management. */
    _inputBuses:                 [2] ma_node_input_bus;
    _outputBuses:                [2] ma_node_output_bus;
    _pHeap:                      *void; /* A heap allocation for internal use only. pInputBuses and/or pOutputBuses will point to this if the bus count exceeds MA_MAX_NODE_LOCAL_BUS_COUNT. */
    _ownsHeap:                   ma_bool32; /* If set to true, the node owns the heap allocation and _pHeap will be freed in ma_node_uninit(). */
}

ma_node_get_heap_size :: (pNodeGraph: *ma_node_graph, pConfig: *ma_node_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_node_init_preallocated :: (pNodeGraph: *ma_node_graph, pConfig: *ma_node_config, pHeap: *void, pNode: *ma_node) -> ma_result #foreign libminiaudio;
ma_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_node) -> ma_result #foreign libminiaudio;
ma_node_uninit :: (pNode: *ma_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_node_get_node_graph :: (pNode: *ma_node) -> *ma_node_graph #foreign libminiaudio;
ma_node_get_input_bus_count :: (pNode: *ma_node) -> ma_uint32 #foreign libminiaudio;
ma_node_get_output_bus_count :: (pNode: *ma_node) -> ma_uint32 #foreign libminiaudio;
ma_node_get_input_channels :: (pNode: *ma_node, inputBusIndex: ma_uint32) -> ma_uint32 #foreign libminiaudio;
ma_node_get_output_channels :: (pNode: *ma_node, outputBusIndex: ma_uint32) -> ma_uint32 #foreign libminiaudio;
ma_node_attach_output_bus :: (pNode: *ma_node, outputBusIndex: ma_uint32, pOtherNode: *ma_node, otherNodeInputBusIndex: ma_uint32) -> ma_result #foreign libminiaudio;
ma_node_detach_output_bus :: (pNode: *ma_node, outputBusIndex: ma_uint32) -> ma_result #foreign libminiaudio;
ma_node_detach_all_output_buses :: (pNode: *ma_node) -> ma_result #foreign libminiaudio;
ma_node_set_output_bus_volume :: (pNode: *ma_node, outputBusIndex: ma_uint32, volume: float) -> ma_result #foreign libminiaudio;
ma_node_get_output_bus_volume :: (pNode: *ma_node, outputBusIndex: ma_uint32) -> float #foreign libminiaudio;
ma_node_set_state :: (pNode: *ma_node, state: ma_node_state) -> ma_result #foreign libminiaudio;
ma_node_get_state :: (pNode: *ma_node) -> ma_node_state #foreign libminiaudio;
ma_node_set_state_time :: (pNode: *ma_node, state: ma_node_state, globalTime: ma_uint64) -> ma_result #foreign libminiaudio;
ma_node_get_state_time :: (pNode: *ma_node, state: ma_node_state) -> ma_uint64 #foreign libminiaudio;
ma_node_get_state_by_time :: (pNode: *ma_node, globalTime: ma_uint64) -> ma_node_state #foreign libminiaudio;
ma_node_get_state_by_time_range :: (pNode: *ma_node, globalTimeBeg: ma_uint64, globalTimeEnd: ma_uint64) -> ma_node_state #foreign libminiaudio;
ma_node_get_time :: (pNode: *ma_node) -> ma_uint64 #foreign libminiaudio;
ma_node_set_time :: (pNode: *ma_node, localTime: ma_uint64) -> ma_result #foreign libminiaudio;

ma_node_graph_config :: struct {
    channels:               ma_uint32;
    processingSizeInFrames: ma_uint32; /* This is the preferred processing size for node processing callbacks unless overridden by a node itself. Can be 0 in which case it will be based on the frame count passed into ma_node_graph_read_pcm_frames(), but will not be well defined. */
    preMixStackSizeInBytes: u64; /* Defaults to 512KB per channel. Reducing this will save memory, but the depth of your node graph will be more restricted. */
}

ma_node_graph_config_init :: (channels: ma_uint32) -> ma_node_graph_config #foreign libminiaudio;

ma_node_graph :: struct {
    base:                           ma_node_base; /* The node graph itself is a node so it can be connected as an input to different node graph. This has zero inputs and calls ma_node_graph_read_pcm_frames() to generate it's output. */
    endpoint:                       ma_node_base; /* Special node that all nodes eventually connect to. Data is read from this node in ma_node_graph_read_pcm_frames(). */
    pProcessingCache:               *float; /* This will be allocated when processingSizeInFrames is non-zero. This is needed because ma_node_graph_read_pcm_frames() can be called with a variable number of frames, and we may need to do some buffering in situations where the caller requests a frame count that's not a multiple of processingSizeInFrames. */
    processingCacheFramesRemaining: ma_uint32;
    processingSizeInFrames:         ma_uint32;

    /* Read and written by multiple threads. */
    isReading:                      ma_bool32;

    /* Modified only by the audio thread. */
    pPreMixStack:                   *ma_stack;
}

ma_node_graph_init :: (pConfig: *ma_node_graph_config, pAllocationCallbacks: *ma_allocation_callbacks, pNodeGraph: *ma_node_graph) -> ma_result #foreign libminiaudio;
ma_node_graph_uninit :: (pNodeGraph: *ma_node_graph, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_node_graph_get_endpoint :: (pNodeGraph: *ma_node_graph) -> *ma_node #foreign libminiaudio;
ma_node_graph_read_pcm_frames :: (pNodeGraph: *ma_node_graph, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_node_graph_get_channels :: (pNodeGraph: *ma_node_graph) -> ma_uint32 #foreign libminiaudio;
ma_node_graph_get_time :: (pNodeGraph: *ma_node_graph) -> ma_uint64 #foreign libminiaudio;
ma_node_graph_set_time :: (pNodeGraph: *ma_node_graph, globalTime: ma_uint64) -> ma_result #foreign libminiaudio;
ma_node_graph_get_processing_size_in_frames :: (pNodeGraph: *ma_node_graph) -> ma_uint32 #foreign libminiaudio;

/* Data source node. 0 input buses, 1 output bus. Used for reading from a data source. */
ma_data_source_node_config :: struct {
    nodeConfig:  ma_node_config;
    pDataSource: *ma_data_source;
}

ma_data_source_node_config_init :: (pDataSource: *ma_data_source) -> ma_data_source_node_config #foreign libminiaudio;

ma_data_source_node :: struct {
    base:        ma_node_base;
    pDataSource: *ma_data_source;
}

ma_data_source_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_data_source_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pDataSourceNode: *ma_data_source_node) -> ma_result #foreign libminiaudio;
ma_data_source_node_uninit :: (pDataSourceNode: *ma_data_source_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_data_source_node_set_looping :: (pDataSourceNode: *ma_data_source_node, isLooping: ma_bool32) -> ma_result #foreign libminiaudio;
ma_data_source_node_is_looping :: (pDataSourceNode: *ma_data_source_node) -> ma_bool32 #foreign libminiaudio;

/* Splitter Node. 1 input, many outputs. Used for splitting/copying a stream so it can be as input into two separate output nodes. */
ma_splitter_node_config :: struct {
    nodeConfig:     ma_node_config;
    channels:       ma_uint32;
    outputBusCount: ma_uint32;
}

ma_splitter_node_config_init :: (channels: ma_uint32) -> ma_splitter_node_config #foreign libminiaudio;

ma_splitter_node :: struct {
    base: ma_node_base;
}

ma_splitter_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_splitter_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pSplitterNode: *ma_splitter_node) -> ma_result #foreign libminiaudio;
ma_splitter_node_uninit :: (pSplitterNode: *ma_splitter_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Biquad Node
*/
ma_biquad_node_config :: struct {
    nodeConfig: ma_node_config;
    biquad:     ma_biquad_config;
}

ma_biquad_node_config_init :: (channels: ma_uint32, b0: float, b1: float, b2: float, a0: float, a1: float, a2: float) -> ma_biquad_node_config #foreign libminiaudio;

ma_biquad_node :: struct {
    baseNode: ma_node_base;
    biquad:   ma_biquad;
}

ma_biquad_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_biquad_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_biquad_node) -> ma_result #foreign libminiaudio;
ma_biquad_node_reinit :: (pConfig: *ma_biquad_config, pNode: *ma_biquad_node) -> ma_result #foreign libminiaudio;
ma_biquad_node_uninit :: (pNode: *ma_biquad_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Low Pass Filter Node
*/
ma_lpf_node_config :: struct {
    nodeConfig: ma_node_config;
    lpf:        ma_lpf_config;
}

ma_lpf_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_lpf_node_config #foreign libminiaudio;

ma_lpf_node :: struct {
    baseNode: ma_node_base;
    lpf:      ma_lpf;
}

ma_lpf_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_lpf_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_lpf_node) -> ma_result #foreign libminiaudio;
ma_lpf_node_reinit :: (pConfig: *ma_lpf_config, pNode: *ma_lpf_node) -> ma_result #foreign libminiaudio;
ma_lpf_node_uninit :: (pNode: *ma_lpf_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
High Pass Filter Node
*/
ma_hpf_node_config :: struct {
    nodeConfig: ma_node_config;
    hpf:        ma_hpf_config;
}

ma_hpf_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_hpf_node_config #foreign libminiaudio;

ma_hpf_node :: struct {
    baseNode: ma_node_base;
    hpf:      ma_hpf;
}

ma_hpf_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_hpf_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_hpf_node) -> ma_result #foreign libminiaudio;
ma_hpf_node_reinit :: (pConfig: *ma_hpf_config, pNode: *ma_hpf_node) -> ma_result #foreign libminiaudio;
ma_hpf_node_uninit :: (pNode: *ma_hpf_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Band Pass Filter Node
*/
ma_bpf_node_config :: struct {
    nodeConfig: ma_node_config;
    bpf:        ma_bpf_config;
}

ma_bpf_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, cutoffFrequency: float64, order: ma_uint32) -> ma_bpf_node_config #foreign libminiaudio;

ma_bpf_node :: struct {
    baseNode: ma_node_base;
    bpf:      ma_bpf;
}

ma_bpf_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_bpf_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_bpf_node) -> ma_result #foreign libminiaudio;
ma_bpf_node_reinit :: (pConfig: *ma_bpf_config, pNode: *ma_bpf_node) -> ma_result #foreign libminiaudio;
ma_bpf_node_uninit :: (pNode: *ma_bpf_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Notching Filter Node
*/
ma_notch_node_config :: struct {
    nodeConfig: ma_node_config;
    notch:      ma_notch_config;
}

ma_notch_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, q: float64, frequency: float64) -> ma_notch_node_config #foreign libminiaudio;

ma_notch_node :: struct {
    baseNode: ma_node_base;
    notch:    ma_notch2;
}

ma_notch_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_notch_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_notch_node) -> ma_result #foreign libminiaudio;
ma_notch_node_reinit :: (pConfig: *ma_notch_config, pNode: *ma_notch_node) -> ma_result #foreign libminiaudio;
ma_notch_node_uninit :: (pNode: *ma_notch_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Peaking Filter Node
*/
ma_peak_node_config :: struct {
    nodeConfig: ma_node_config;
    peak:       ma_peak_config;
}

ma_peak_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, q: float64, frequency: float64) -> ma_peak_node_config #foreign libminiaudio;

ma_peak_node :: struct {
    baseNode: ma_node_base;
    peak:     ma_peak2;
}

ma_peak_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_peak_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_peak_node) -> ma_result #foreign libminiaudio;
ma_peak_node_reinit :: (pConfig: *ma_peak_config, pNode: *ma_peak_node) -> ma_result #foreign libminiaudio;
ma_peak_node_uninit :: (pNode: *ma_peak_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
Low Shelf Filter Node
*/
ma_loshelf_node_config :: struct {
    nodeConfig: ma_node_config;
    loshelf:    ma_loshelf_config;
}

ma_loshelf_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, q: float64, frequency: float64) -> ma_loshelf_node_config #foreign libminiaudio;

ma_loshelf_node :: struct {
    baseNode: ma_node_base;
    loshelf:  ma_loshelf2;
}

ma_loshelf_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_loshelf_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_loshelf_node) -> ma_result #foreign libminiaudio;
ma_loshelf_node_reinit :: (pConfig: *ma_loshelf_config, pNode: *ma_loshelf_node) -> ma_result #foreign libminiaudio;
ma_loshelf_node_uninit :: (pNode: *ma_loshelf_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/*
High Shelf Filter Node
*/
ma_hishelf_node_config :: struct {
    nodeConfig: ma_node_config;
    hishelf:    ma_hishelf_config;
}

ma_hishelf_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, gainDB: float64, q: float64, frequency: float64) -> ma_hishelf_node_config #foreign libminiaudio;

ma_hishelf_node :: struct {
    baseNode: ma_node_base;
    hishelf:  ma_hishelf2;
}

ma_hishelf_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_hishelf_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pNode: *ma_hishelf_node) -> ma_result #foreign libminiaudio;
ma_hishelf_node_reinit :: (pConfig: *ma_hishelf_config, pNode: *ma_hishelf_node) -> ma_result #foreign libminiaudio;
ma_hishelf_node_uninit :: (pNode: *ma_hishelf_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

ma_delay_node_config :: struct {
    nodeConfig: ma_node_config;
    delay:      ma_delay_config;
}

ma_delay_node_config_init :: (channels: ma_uint32, sampleRate: ma_uint32, delayInFrames: ma_uint32, decay: float) -> ma_delay_node_config #foreign libminiaudio;

ma_delay_node :: struct {
    baseNode: ma_node_base;
    delay:    ma_delay;
}

ma_delay_node_init :: (pNodeGraph: *ma_node_graph, pConfig: *ma_delay_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pDelayNode: *ma_delay_node) -> ma_result #foreign libminiaudio;
ma_delay_node_uninit :: (pDelayNode: *ma_delay_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;
ma_delay_node_set_wet :: (pDelayNode: *ma_delay_node, value: float) -> void #foreign libminiaudio;
ma_delay_node_get_wet :: (pDelayNode: *ma_delay_node) -> float #foreign libminiaudio;
ma_delay_node_set_dry :: (pDelayNode: *ma_delay_node, value: float) -> void #foreign libminiaudio;
ma_delay_node_get_dry :: (pDelayNode: *ma_delay_node) -> float #foreign libminiaudio;
ma_delay_node_set_decay :: (pDelayNode: *ma_delay_node, value: float) -> void #foreign libminiaudio;
ma_delay_node_get_decay :: (pDelayNode: *ma_delay_node) -> float #foreign libminiaudio;

/* Sound flags. */
ma_sound_flags :: enum u32 {
    STREAM                :: 1;
    DECODE                :: 2;
    ASYNC                 :: 4;
    WAIT_INIT             :: 8;
    UNKNOWN_LENGTH        :: 16;
    LOOPING               :: 32;

    NO_DEFAULT_ATTACHMENT :: 4096;
    NO_PITCH              :: 8192;
    NO_SPATIALIZATION     :: 16384;

    MA_SOUND_FLAG_STREAM                :: STREAM;
    MA_SOUND_FLAG_DECODE                :: DECODE;
    MA_SOUND_FLAG_ASYNC                 :: ASYNC;
    MA_SOUND_FLAG_WAIT_INIT             :: WAIT_INIT;
    MA_SOUND_FLAG_UNKNOWN_LENGTH        :: UNKNOWN_LENGTH;
    MA_SOUND_FLAG_LOOPING               :: LOOPING;

    MA_SOUND_FLAG_NO_DEFAULT_ATTACHMENT :: NO_DEFAULT_ATTACHMENT;
    MA_SOUND_FLAG_NO_PITCH              :: NO_PITCH;
    MA_SOUND_FLAG_NO_SPATIALIZATION     :: NO_SPATIALIZATION;
}

ma_engine_node_type :: enum u32 {
    sound :: 0;
    group :: 1;

    ma_engine_node_type_sound :: sound;
    ma_engine_node_type_group :: group;
}

ma_engine_node_config :: struct {
    pEngine:                     *ma_engine;
    type:                        ma_engine_node_type;
    channelsIn:                  ma_uint32;
    channelsOut:                 ma_uint32;
    sampleRate:                  ma_uint32; /* Only used when the type is set to ma_engine_node_type_sound. */
    volumeSmoothTimeInPCMFrames: ma_uint32; /* The number of frames to smooth over volume changes. Defaults to 0 in which case no smoothing is used. */
    monoExpansionMode:           ma_mono_expansion_mode;
    isPitchDisabled:             ma_bool8; /* Pitching can be explicitly disabled with MA_SOUND_FLAG_NO_PITCH to optimize processing. */
    isSpatializationDisabled:    ma_bool8; /* Spatialization can be explicitly disabled with MA_SOUND_FLAG_NO_SPATIALIZATION. */
    pinnedListenerIndex:         ma_uint8; /* The index of the listener this node should always use for spatialization. If set to MA_LISTENER_INDEX_CLOSEST the engine will use the closest listener. */
    resampling:                  ma_resampler_config;
}

ma_engine_node_config_init :: (pEngine: *ma_engine, type: ma_engine_node_type, flags: ma_uint32) -> ma_engine_node_config #foreign libminiaudio;

/* Base node object for both ma_sound and ma_sound_group. */
ma_engine_node :: struct {
    baseNode:                    ma_node_base; /* Must be the first member for compatibility with the ma_node API. */
    pEngine:                     *ma_engine; /* A pointer to the engine. Set based on the value from the config. */
    sampleRate:                  ma_uint32; /* The sample rate of the input data. For sounds backed by a data source, this will be the data source's sample rate. Otherwise it'll be the engine's sample rate. */
    volumeSmoothTimeInPCMFrames: ma_uint32;
    monoExpansionMode:           ma_mono_expansion_mode;
    fader:                       ma_fader;
    resampler:                   ma_resampler; /* For pitch shift. */
    spatializer:                 ma_spatializer;
    panner:                      ma_panner;
    volumeGainer:                ma_gainer; /* This will only be used if volumeSmoothTimeInPCMFrames is > 0. */
    volume:                      ma_atomic_float; /* Defaults to 1. */
    oldVolume:                   float; /* The volume last applied by the mixing thread. */
    pitch:                       float;
    oldPitch:                    float; /* For determining whether or not the resampler needs to be updated to reflect the new pitch. The resampler will be updated on the mixing thread. */
    oldDopplerPitch:             float; /* For determining whether or not the resampler needs to be updated to take a new doppler pitch into account. */
    isPitchDisabled:             ma_bool32; /* When set to true, pitching will be disabled which will allow the resampler to be bypassed to save some computation. */
    isSpatializationDisabled:    ma_bool32; /* Set to false by default. When set to false, will not have spatialisation applied. */
    pinnedListenerIndex:         ma_uint32; /* The index of the listener this node should always use for spatialization. If set to MA_LISTENER_INDEX_CLOSEST the engine will use the closest listener. */

    fadeSettings:                struct {
        volumeBeg:                  ma_atomic_float;
        volumeEnd:                  ma_atomic_float;
        fadeLengthInFrames:         ma_atomic_uint64; /* <-- Defaults to (~(ma_uint64)0) which is used to indicate that no fade should be applied. */
        absoluteGlobalTimeInFrames: ma_atomic_uint64; /* <-- The time to start the fade. */
    };

    /* Memory management. */
    _ownsHeap:                   ma_bool8;
    _pHeap:                      *void;
}

ma_engine_node_get_heap_size :: (pConfig: *ma_engine_node_config, pHeapSizeInBytes: *u64) -> ma_result #foreign libminiaudio;
ma_engine_node_init_preallocated :: (pConfig: *ma_engine_node_config, pHeap: *void, pEngineNode: *ma_engine_node) -> ma_result #foreign libminiaudio;
ma_engine_node_init :: (pConfig: *ma_engine_node_config, pAllocationCallbacks: *ma_allocation_callbacks, pEngineNode: *ma_engine_node) -> ma_result #foreign libminiaudio;
ma_engine_node_uninit :: (pEngineNode: *ma_engine_node, pAllocationCallbacks: *ma_allocation_callbacks) -> void #foreign libminiaudio;

/* Callback for when a sound reaches the end. */
ma_sound_end_proc :: #type (pUserData: *void, pSound: *ma_sound) -> void #c_call;

ma_sound_config :: struct {
    pFilePath:                      *u8; /* Set this to load from the resource manager. */
    pFilePathW:                     *s32; /* Set this to load from the resource manager. */
    pDataSource:                    *ma_data_source; /* Set this to load from an existing data source. */
    pInitialAttachment:             *ma_node; /* If set, the sound will be attached to an input of this node. This can be set to a ma_sound. If set to NULL, the sound will be attached directly to the endpoint unless MA_SOUND_FLAG_NO_DEFAULT_ATTACHMENT is set in `flags`. */
    initialAttachmentInputBusIndex: ma_uint32; /* The index of the input bus of pInitialAttachment to attach the sound to. */
    channelsIn:                     ma_uint32; /* Ignored if using a data source as input (the data source's channel count will be used always). Otherwise, setting to 0 will cause the engine's channel count to be used. */
    channelsOut:                    ma_uint32; /* Set this to 0 (default) to use the engine's channel count. Set to MA_SOUND_SOURCE_CHANNEL_COUNT to use the data source's channel count (only used if using a data source as input). */
    monoExpansionMode:              ma_mono_expansion_mode; /* Controls how the mono channel should be expanded to other channels when spatialization is disabled on a sound. */
    flags:                          ma_uint32; /* A combination of MA_SOUND_FLAG_* flags. */
    volumeSmoothTimeInPCMFrames:    ma_uint32; /* The number of frames to smooth over volume changes. Defaults to 0 in which case no smoothing is used. */
    initialSeekPointInPCMFrames:    ma_uint64; /* Initializes the sound such that it's seeked to this location by default. */
    rangeBegInPCMFrames:            ma_uint64;
    rangeEndInPCMFrames:            ma_uint64;
    loopPointBegInPCMFrames:        ma_uint64;
    loopPointEndInPCMFrames:        ma_uint64;
    endCallback:                    ma_sound_end_proc; /* Fired when the sound reaches the end. Will be fired from the audio thread. Do not restart, uninitialize or otherwise change the state of the sound from here. Instead fire an event or set a variable to indicate to a different thread to change the start of the sound. Will not be fired in response to a scheduled stop with ma_sound_set_stop_time_*(). */
    pEndCallbackUserData:           *void;
    pitchResampling:                ma_resampler_config;

    initNotifications:              ma_resource_manager_pipeline_notifications;

    pDoneFence:                     *ma_fence; /* Deprecated. Use initNotifications instead. Released when the resource manager has finished decoding the entire sound. Not used with streams. */
    isLooping:                      ma_bool32; /* Deprecated. Use the MA_SOUND_FLAG_LOOPING flag in `flags` instead. */
}

ma_sound_config_init :: () -> ma_sound_config #foreign libminiaudio;
ma_sound_config_init_2 :: (pEngine: *ma_engine) -> ma_sound_config #foreign libminiaudio;

ma_sound :: struct {
    engineNode:                     ma_engine_node; /* Must be the first member for compatibility with the ma_node API. */
    pDataSource:                    *ma_data_source;
    seekTarget:                     ma_uint64; /* The PCM frame index to seek to in the mixing thread. Set to (~(ma_uint64)0) to not perform any seeking. */
    atEnd:                          ma_bool32;
    endCallback:                    ma_sound_end_proc;
    pEndCallbackUserData:           *void;
    pProcessingCache:               *float; /* Will be null if pDataSource is null. */
    processingCacheFramesRemaining: ma_uint32;
    processingCacheCap:             ma_uint32;
    ownsDataSource:                 ma_bool8;

    pResourceManagerDataSource:     *ma_resource_manager_data_source;
}

ma_sound_inlined :: struct {
    sound: ma_sound;
    pNext: *ma_sound_inlined;
    pPrev: *ma_sound_inlined;
}

/* A sound group is just a sound. */
ma_sound_group_config :: ma_sound_config;
ma_sound_group :: ma_sound;

ma_sound_group_config_init :: () -> ma_sound_group_config #foreign libminiaudio;
ma_sound_group_config_init_2 :: (pEngine: *ma_engine) -> ma_sound_group_config #foreign libminiaudio;

ma_engine_process_proc :: #type (pUserData: *void, pFramesOut: *float, frameCount: ma_uint64) -> void #c_call;

ma_engine_config :: struct {
    pResourceManager:                   *ma_resource_manager; /* Can be null in which case a resource manager will be created for you. */

    pContext:                           *ma_context;
    pDevice:                            *ma_device; /* If set, the caller is responsible for calling ma_engine_data_callback() in the device's data callback. */
    pPlaybackDeviceID:                  *ma_device_id; /* The ID of the playback device to use with the default listener. */
    dataCallback:                       ma_device_data_proc; /* Can be null. Can be used to provide a custom device data callback. */
    notificationCallback:               ma_device_notification_proc;

    pLog:                               *ma_log; /* When set to NULL, will use the context's log. */
    listenerCount:                      ma_uint32; /* Must be between 1 and MA_ENGINE_MAX_LISTENERS. */
    channels:                           ma_uint32; /* The number of channels to use when mixing and spatializing. When set to 0, will use the native channel count of the device. */
    sampleRate:                         ma_uint32; /* The sample rate. When set to 0 will use the native sample rate of the device. */
    periodSizeInFrames:                 ma_uint32; /* If set to something other than 0, updates will always be exactly this size. The underlying device may be a different size, but from the perspective of the mixer that won't matter.*/
    periodSizeInMilliseconds:           ma_uint32; /* Used if periodSizeInFrames is unset. */
    gainSmoothTimeInFrames:             ma_uint32; /* The number of frames to interpolate the gain of spatialized sounds across. If set to 0, will use gainSmoothTimeInMilliseconds. */
    gainSmoothTimeInMilliseconds:       ma_uint32; /* When set to 0, gainSmoothTimeInFrames will be used. If both are set to 0, a default value will be used. */
    defaultVolumeSmoothTimeInPCMFrames: ma_uint32; /* Defaults to 0. Controls the default amount of smoothing to apply to volume changes to sounds. High values means more smoothing at the expense of high latency (will take longer to reach the new volume). */
    preMixStackSizeInBytes:             ma_uint32; /* A stack is used for internal processing in the node graph. This allows you to configure the size of this stack. Smaller values will reduce the maximum depth of your node graph. You should rarely need to modify this. */
    allocationCallbacks:                ma_allocation_callbacks;
    noAutoStart:                        ma_bool32; /* When set to true, requires an explicit call to ma_engine_start(). This is false by default, meaning the engine will be started automatically in ma_engine_init(). */
    noDevice:                           ma_bool32; /* When set to true, don't create a default device. ma_engine_read_pcm_frames() can be called manually to read data. */
    monoExpansionMode:                  ma_mono_expansion_mode; /* Controls how the mono channel should be expanded to other channels when spatialization is disabled on a sound. */
    pResourceManagerVFS:                *ma_vfs; /* A pointer to a pre-allocated VFS object to use with the resource manager. This is ignored if pResourceManager is not NULL. */
    onProcess:                          ma_engine_process_proc; /* Fired at the end of each call to ma_engine_read_pcm_frames(). For engine's that manage their own internal device (the default configuration), this will be fired from the audio thread, and you do not need to call ma_engine_read_pcm_frames() manually in order to trigger this. */
    pProcessUserData:                   *void; /* User data that's passed into onProcess. */
    resourceManagerResampling:          ma_resampler_config; /* The resampling config to use with the resource manager. */
    pitchResampling:                    ma_resampler_config; /* The resampling config for the pitch and Doppler effects. You will typically want this to be a fast resampler. For high quality stuff, it's recommended that you pre-resample. */
}

ma_engine_config_init :: () -> ma_engine_config #foreign libminiaudio;

ma_engine :: struct {
    nodeGraph:                          ma_node_graph; /* An engine is a node graph. It should be able to be plugged into any ma_node_graph API (with a cast) which means this must be the first member of this struct. */

    pResourceManager:                   *ma_resource_manager;

    pDevice:                            *ma_device; /* Optionally set via the config, otherwise allocated by the engine in ma_engine_init(). */

    pLog:                               *ma_log;
    sampleRate:                         ma_uint32;
    listenerCount:                      ma_uint32;
    listeners:                          [4] ma_spatializer_listener;
    allocationCallbacks:                ma_allocation_callbacks;
    ownsResourceManager:                ma_bool8;
    ownsDevice:                         ma_bool8;
    inlinedSoundLock:                   ma_spinlock; /* For synchronizing access to the inlined sound list. */
    pInlinedSoundHead:                  *ma_sound_inlined; /* The first inlined sound. Inlined sounds are tracked in a linked list. */
    inlinedSoundCount:                  ma_uint32; /* The total number of allocated inlined sound objects. Used for debugging. */
    gainSmoothTimeInFrames:             ma_uint32; /* The number of frames to interpolate the gain of spatialized sounds across. */
    defaultVolumeSmoothTimeInPCMFrames: ma_uint32;
    monoExpansionMode:                  ma_mono_expansion_mode;
    onProcess:                          ma_engine_process_proc;
    pProcessUserData:                   *void;
    pitchResamplingConfig:              ma_resampler_config;
}

ma_engine_init :: (pConfig: *ma_engine_config, pEngine: *ma_engine) -> ma_result #foreign libminiaudio;
ma_engine_uninit :: (pEngine: *ma_engine) -> void #foreign libminiaudio;
ma_engine_read_pcm_frames :: (pEngine: *ma_engine, pFramesOut: *void, frameCount: ma_uint64, pFramesRead: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_engine_get_node_graph :: (pEngine: *ma_engine) -> *ma_node_graph #foreign libminiaudio;

ma_engine_get_resource_manager :: (pEngine: *ma_engine) -> *ma_resource_manager #foreign libminiaudio;

ma_engine_get_device :: (pEngine: *ma_engine) -> *ma_device #foreign libminiaudio;
ma_engine_get_log :: (pEngine: *ma_engine) -> *ma_log #foreign libminiaudio;
ma_engine_get_endpoint :: (pEngine: *ma_engine) -> *ma_node #foreign libminiaudio;
ma_engine_get_time_in_pcm_frames :: (pEngine: *ma_engine) -> ma_uint64 #foreign libminiaudio;
ma_engine_get_time_in_milliseconds :: (pEngine: *ma_engine) -> ma_uint64 #foreign libminiaudio;
ma_engine_set_time_in_pcm_frames :: (pEngine: *ma_engine, globalTime: ma_uint64) -> ma_result #foreign libminiaudio;
ma_engine_set_time_in_milliseconds :: (pEngine: *ma_engine, globalTime: ma_uint64) -> ma_result #foreign libminiaudio;
ma_engine_get_time :: (pEngine: *ma_engine) -> ma_uint64 #foreign libminiaudio;
ma_engine_set_time :: (pEngine: *ma_engine, globalTime: ma_uint64) -> ma_result #foreign libminiaudio;
ma_engine_get_channels :: (pEngine: *ma_engine) -> ma_uint32 #foreign libminiaudio;
ma_engine_get_sample_rate :: (pEngine: *ma_engine) -> ma_uint32 #foreign libminiaudio;

ma_engine_start :: (pEngine: *ma_engine) -> ma_result #foreign libminiaudio;
ma_engine_stop :: (pEngine: *ma_engine) -> ma_result #foreign libminiaudio;
ma_engine_set_volume :: (pEngine: *ma_engine, volume: float) -> ma_result #foreign libminiaudio;
ma_engine_get_volume :: (pEngine: *ma_engine) -> float #foreign libminiaudio;
ma_engine_set_gain_db :: (pEngine: *ma_engine, gainDB: float) -> ma_result #foreign libminiaudio;
ma_engine_get_gain_db :: (pEngine: *ma_engine) -> float #foreign libminiaudio;

ma_engine_get_listener_count :: (pEngine: *ma_engine) -> ma_uint32 #foreign libminiaudio;
ma_engine_find_closest_listener :: (pEngine: *ma_engine, absolutePosX: float, absolutePosY: float, absolutePosZ: float) -> ma_uint32 #foreign libminiaudio;
ma_engine_listener_set_position :: (pEngine: *ma_engine, listenerIndex: ma_uint32, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_engine_listener_get_position :: (pEngine: *ma_engine, listenerIndex: ma_uint32) -> ma_vec3f #foreign libminiaudio;
ma_engine_listener_set_direction :: (pEngine: *ma_engine, listenerIndex: ma_uint32, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_engine_listener_get_direction :: (pEngine: *ma_engine, listenerIndex: ma_uint32) -> ma_vec3f #foreign libminiaudio;
ma_engine_listener_set_velocity :: (pEngine: *ma_engine, listenerIndex: ma_uint32, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_engine_listener_get_velocity :: (pEngine: *ma_engine, listenerIndex: ma_uint32) -> ma_vec3f #foreign libminiaudio;
ma_engine_listener_set_cone :: (pEngine: *ma_engine, listenerIndex: ma_uint32, innerAngleInRadians: float, outerAngleInRadians: float, outerGain: float) -> void #foreign libminiaudio;
ma_engine_listener_get_cone :: (pEngine: *ma_engine, listenerIndex: ma_uint32, pInnerAngleInRadians: *float, pOuterAngleInRadians: *float, pOuterGain: *float) -> void #foreign libminiaudio;
ma_engine_listener_set_world_up :: (pEngine: *ma_engine, listenerIndex: ma_uint32, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_engine_listener_get_world_up :: (pEngine: *ma_engine, listenerIndex: ma_uint32) -> ma_vec3f #foreign libminiaudio;
ma_engine_listener_set_enabled :: (pEngine: *ma_engine, listenerIndex: ma_uint32, isEnabled: ma_bool32) -> void #foreign libminiaudio;
ma_engine_listener_is_enabled :: (pEngine: *ma_engine, listenerIndex: ma_uint32) -> ma_bool32 #foreign libminiaudio;

ma_engine_play_sound_ex :: (pEngine: *ma_engine, pFilePath: *u8, pNode: *ma_node, nodeInputBusIndex: ma_uint32) -> ma_result #foreign libminiaudio;
ma_engine_play_sound :: (pEngine: *ma_engine, pFilePath: *u8, pGroup: *ma_sound_group) -> ma_result #foreign libminiaudio;

ma_sound_init_from_file :: (pEngine: *ma_engine, pFilePath: *u8, flags: ma_uint32, pGroup: *ma_sound_group, pDoneFence: *ma_fence, pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_init_from_file_w :: (pEngine: *ma_engine, pFilePath: *s32, flags: ma_uint32, pGroup: *ma_sound_group, pDoneFence: *ma_fence, pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_init_copy :: (pEngine: *ma_engine, pExistingSound: *ma_sound, flags: ma_uint32, pGroup: *ma_sound_group, pSound: *ma_sound) -> ma_result #foreign libminiaudio;

ma_sound_init_from_data_source :: (pEngine: *ma_engine, pDataSource: *ma_data_source, flags: ma_uint32, pGroup: *ma_sound_group, pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_init_ex :: (pEngine: *ma_engine, pConfig: *ma_sound_config, pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_uninit :: (pSound: *ma_sound) -> void #foreign libminiaudio;
ma_sound_get_engine :: (pSound: *ma_sound) -> *ma_engine #foreign libminiaudio;
ma_sound_get_data_source :: (pSound: *ma_sound) -> *ma_data_source #foreign libminiaudio;
ma_sound_start :: (pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_stop :: (pSound: *ma_sound) -> ma_result #foreign libminiaudio;
ma_sound_stop_with_fade_in_pcm_frames :: (pSound: *ma_sound, fadeLengthInFrames: ma_uint64) -> ma_result #foreign libminiaudio;
ma_sound_stop_with_fade_in_milliseconds :: (pSound: *ma_sound, fadeLengthInFrames: ma_uint64) -> ma_result #foreign libminiaudio;
ma_sound_reset_start_time :: (pSound: *ma_sound) -> void #foreign libminiaudio;
ma_sound_reset_stop_time :: (pSound: *ma_sound) -> void #foreign libminiaudio;
ma_sound_reset_fade :: (pSound: *ma_sound) -> void #foreign libminiaudio;
ma_sound_reset_stop_time_and_fade :: (pSound: *ma_sound) -> void #foreign libminiaudio;
ma_sound_set_volume :: (pSound: *ma_sound, volume: float) -> void #foreign libminiaudio;
ma_sound_get_volume :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_pan :: (pSound: *ma_sound, pan: float) -> void #foreign libminiaudio;
ma_sound_get_pan :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_pan_mode :: (pSound: *ma_sound, panMode: ma_pan_mode) -> void #foreign libminiaudio;
ma_sound_get_pan_mode :: (pSound: *ma_sound) -> ma_pan_mode #foreign libminiaudio;
ma_sound_set_pitch :: (pSound: *ma_sound, pitch: float) -> void #foreign libminiaudio;
ma_sound_get_pitch :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_spatialization_enabled :: (pSound: *ma_sound, enabled: ma_bool32) -> void #foreign libminiaudio;
ma_sound_is_spatialization_enabled :: (pSound: *ma_sound) -> ma_bool32 #foreign libminiaudio;
ma_sound_set_pinned_listener_index :: (pSound: *ma_sound, listenerIndex: ma_uint32) -> void #foreign libminiaudio;
ma_sound_get_pinned_listener_index :: (pSound: *ma_sound) -> ma_uint32 #foreign libminiaudio;
ma_sound_get_listener_index :: (pSound: *ma_sound) -> ma_uint32 #foreign libminiaudio;
ma_sound_get_direction_to_listener :: (pSound: *ma_sound) -> ma_vec3f #foreign libminiaudio;
ma_sound_set_position :: (pSound: *ma_sound, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_get_position :: (pSound: *ma_sound) -> ma_vec3f #foreign libminiaudio;
ma_sound_set_direction :: (pSound: *ma_sound, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_get_direction :: (pSound: *ma_sound) -> ma_vec3f #foreign libminiaudio;
ma_sound_set_velocity :: (pSound: *ma_sound, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_get_velocity :: (pSound: *ma_sound) -> ma_vec3f #foreign libminiaudio;
ma_sound_set_attenuation_model :: (pSound: *ma_sound, attenuationModel: ma_attenuation_model) -> void #foreign libminiaudio;
ma_sound_get_attenuation_model :: (pSound: *ma_sound) -> ma_attenuation_model #foreign libminiaudio;
ma_sound_set_positioning :: (pSound: *ma_sound, positioning: ma_positioning) -> void #foreign libminiaudio;
ma_sound_get_positioning :: (pSound: *ma_sound) -> ma_positioning #foreign libminiaudio;
ma_sound_set_rolloff :: (pSound: *ma_sound, rolloff: float) -> void #foreign libminiaudio;
ma_sound_get_rolloff :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_min_gain :: (pSound: *ma_sound, minGain: float) -> void #foreign libminiaudio;
ma_sound_get_min_gain :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_max_gain :: (pSound: *ma_sound, maxGain: float) -> void #foreign libminiaudio;
ma_sound_get_max_gain :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_min_distance :: (pSound: *ma_sound, minDistance: float) -> void #foreign libminiaudio;
ma_sound_get_min_distance :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_max_distance :: (pSound: *ma_sound, maxDistance: float) -> void #foreign libminiaudio;
ma_sound_get_max_distance :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_cone :: (pSound: *ma_sound, innerAngleInRadians: float, outerAngleInRadians: float, outerGain: float) -> void #foreign libminiaudio;
ma_sound_get_cone :: (pSound: *ma_sound, pInnerAngleInRadians: *float, pOuterAngleInRadians: *float, pOuterGain: *float) -> void #foreign libminiaudio;
ma_sound_set_doppler_factor :: (pSound: *ma_sound, dopplerFactor: float) -> void #foreign libminiaudio;
ma_sound_get_doppler_factor :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_directional_attenuation_factor :: (pSound: *ma_sound, directionalAttenuationFactor: float) -> void #foreign libminiaudio;
ma_sound_get_directional_attenuation_factor :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_fade_in_pcm_frames :: (pSound: *ma_sound, volumeBeg: float, volumeEnd: float, fadeLengthInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_fade_in_milliseconds :: (pSound: *ma_sound, volumeBeg: float, volumeEnd: float, fadeLengthInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_fade_start_in_pcm_frames :: (pSound: *ma_sound, volumeBeg: float, volumeEnd: float, fadeLengthInFrames: ma_uint64, absoluteGlobalTimeInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_fade_start_in_milliseconds :: (pSound: *ma_sound, volumeBeg: float, volumeEnd: float, fadeLengthInMilliseconds: ma_uint64, absoluteGlobalTimeInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_get_current_fade_volume :: (pSound: *ma_sound) -> float #foreign libminiaudio;
ma_sound_set_start_time_in_pcm_frames :: (pSound: *ma_sound, absoluteGlobalTimeInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_start_time_in_milliseconds :: (pSound: *ma_sound, absoluteGlobalTimeInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_stop_time_in_pcm_frames :: (pSound: *ma_sound, absoluteGlobalTimeInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_stop_time_in_milliseconds :: (pSound: *ma_sound, absoluteGlobalTimeInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_stop_time_with_fade_in_pcm_frames :: (pSound: *ma_sound, stopAbsoluteGlobalTimeInFrames: ma_uint64, fadeLengthInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_set_stop_time_with_fade_in_milliseconds :: (pSound: *ma_sound, stopAbsoluteGlobalTimeInMilliseconds: ma_uint64, fadeLengthInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_is_playing :: (pSound: *ma_sound) -> ma_bool32 #foreign libminiaudio;
ma_sound_get_time_in_pcm_frames :: (pSound: *ma_sound) -> ma_uint64 #foreign libminiaudio;
ma_sound_get_time_in_milliseconds :: (pSound: *ma_sound) -> ma_uint64 #foreign libminiaudio;
ma_sound_set_looping :: (pSound: *ma_sound, isLooping: ma_bool32) -> void #foreign libminiaudio;
ma_sound_is_looping :: (pSound: *ma_sound) -> ma_bool32 #foreign libminiaudio;
ma_sound_at_end :: (pSound: *ma_sound) -> ma_bool32 #foreign libminiaudio;
ma_sound_seek_to_pcm_frame :: (pSound: *ma_sound, frameIndex: ma_uint64) -> ma_result #foreign libminiaudio;
ma_sound_seek_to_second :: (pSound: *ma_sound, seekPointInSeconds: float) -> ma_result #foreign libminiaudio;
ma_sound_get_data_format :: (pSound: *ma_sound, pFormat: *ma_format, pChannels: *ma_uint32, pSampleRate: *ma_uint32, pChannelMap: *ma_channel, channelMapCap: u64) -> ma_result #foreign libminiaudio;
ma_sound_get_cursor_in_pcm_frames :: (pSound: *ma_sound, pCursor: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_sound_get_length_in_pcm_frames :: (pSound: *ma_sound, pLength: *ma_uint64) -> ma_result #foreign libminiaudio;
ma_sound_get_cursor_in_seconds :: (pSound: *ma_sound, pCursor: *float) -> ma_result #foreign libminiaudio;
ma_sound_get_length_in_seconds :: (pSound: *ma_sound, pLength: *float) -> ma_result #foreign libminiaudio;
ma_sound_set_end_callback :: (pSound: *ma_sound, callback: ma_sound_end_proc, pUserData: *void) -> ma_result #foreign libminiaudio;

ma_sound_group_init :: (pEngine: *ma_engine, flags: ma_uint32, pParentGroup: *ma_sound_group, pGroup: *ma_sound_group) -> ma_result #foreign libminiaudio;
ma_sound_group_init_ex :: (pEngine: *ma_engine, pConfig: *ma_sound_group_config, pGroup: *ma_sound_group) -> ma_result #foreign libminiaudio;
ma_sound_group_uninit :: (pGroup: *ma_sound_group) -> void #foreign libminiaudio;
ma_sound_group_get_engine :: (pGroup: *ma_sound_group) -> *ma_engine #foreign libminiaudio;
ma_sound_group_start :: (pGroup: *ma_sound_group) -> ma_result #foreign libminiaudio;
ma_sound_group_stop :: (pGroup: *ma_sound_group) -> ma_result #foreign libminiaudio;
ma_sound_group_set_volume :: (pGroup: *ma_sound_group, volume: float) -> void #foreign libminiaudio;
ma_sound_group_get_volume :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_pan :: (pGroup: *ma_sound_group, pan: float) -> void #foreign libminiaudio;
ma_sound_group_get_pan :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_pan_mode :: (pGroup: *ma_sound_group, panMode: ma_pan_mode) -> void #foreign libminiaudio;
ma_sound_group_get_pan_mode :: (pGroup: *ma_sound_group) -> ma_pan_mode #foreign libminiaudio;
ma_sound_group_set_pitch :: (pGroup: *ma_sound_group, pitch: float) -> void #foreign libminiaudio;
ma_sound_group_get_pitch :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_spatialization_enabled :: (pGroup: *ma_sound_group, enabled: ma_bool32) -> void #foreign libminiaudio;
ma_sound_group_is_spatialization_enabled :: (pGroup: *ma_sound_group) -> ma_bool32 #foreign libminiaudio;
ma_sound_group_set_pinned_listener_index :: (pGroup: *ma_sound_group, listenerIndex: ma_uint32) -> void #foreign libminiaudio;
ma_sound_group_get_pinned_listener_index :: (pGroup: *ma_sound_group) -> ma_uint32 #foreign libminiaudio;
ma_sound_group_get_listener_index :: (pGroup: *ma_sound_group) -> ma_uint32 #foreign libminiaudio;
ma_sound_group_get_direction_to_listener :: (pGroup: *ma_sound_group) -> ma_vec3f #foreign libminiaudio;
ma_sound_group_set_position :: (pGroup: *ma_sound_group, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_group_get_position :: (pGroup: *ma_sound_group) -> ma_vec3f #foreign libminiaudio;
ma_sound_group_set_direction :: (pGroup: *ma_sound_group, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_group_get_direction :: (pGroup: *ma_sound_group) -> ma_vec3f #foreign libminiaudio;
ma_sound_group_set_velocity :: (pGroup: *ma_sound_group, x: float, y: float, z: float) -> void #foreign libminiaudio;
ma_sound_group_get_velocity :: (pGroup: *ma_sound_group) -> ma_vec3f #foreign libminiaudio;
ma_sound_group_set_attenuation_model :: (pGroup: *ma_sound_group, attenuationModel: ma_attenuation_model) -> void #foreign libminiaudio;
ma_sound_group_get_attenuation_model :: (pGroup: *ma_sound_group) -> ma_attenuation_model #foreign libminiaudio;
ma_sound_group_set_positioning :: (pGroup: *ma_sound_group, positioning: ma_positioning) -> void #foreign libminiaudio;
ma_sound_group_get_positioning :: (pGroup: *ma_sound_group) -> ma_positioning #foreign libminiaudio;
ma_sound_group_set_rolloff :: (pGroup: *ma_sound_group, rolloff: float) -> void #foreign libminiaudio;
ma_sound_group_get_rolloff :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_min_gain :: (pGroup: *ma_sound_group, minGain: float) -> void #foreign libminiaudio;
ma_sound_group_get_min_gain :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_max_gain :: (pGroup: *ma_sound_group, maxGain: float) -> void #foreign libminiaudio;
ma_sound_group_get_max_gain :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_min_distance :: (pGroup: *ma_sound_group, minDistance: float) -> void #foreign libminiaudio;
ma_sound_group_get_min_distance :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_max_distance :: (pGroup: *ma_sound_group, maxDistance: float) -> void #foreign libminiaudio;
ma_sound_group_get_max_distance :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_cone :: (pGroup: *ma_sound_group, innerAngleInRadians: float, outerAngleInRadians: float, outerGain: float) -> void #foreign libminiaudio;
ma_sound_group_get_cone :: (pGroup: *ma_sound_group, pInnerAngleInRadians: *float, pOuterAngleInRadians: *float, pOuterGain: *float) -> void #foreign libminiaudio;
ma_sound_group_set_doppler_factor :: (pGroup: *ma_sound_group, dopplerFactor: float) -> void #foreign libminiaudio;
ma_sound_group_get_doppler_factor :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_directional_attenuation_factor :: (pGroup: *ma_sound_group, directionalAttenuationFactor: float) -> void #foreign libminiaudio;
ma_sound_group_get_directional_attenuation_factor :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_fade_in_pcm_frames :: (pGroup: *ma_sound_group, volumeBeg: float, volumeEnd: float, fadeLengthInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_set_fade_in_milliseconds :: (pGroup: *ma_sound_group, volumeBeg: float, volumeEnd: float, fadeLengthInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_get_current_fade_volume :: (pGroup: *ma_sound_group) -> float #foreign libminiaudio;
ma_sound_group_set_start_time_in_pcm_frames :: (pGroup: *ma_sound_group, absoluteGlobalTimeInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_set_start_time_in_milliseconds :: (pGroup: *ma_sound_group, absoluteGlobalTimeInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_set_stop_time_in_pcm_frames :: (pGroup: *ma_sound_group, absoluteGlobalTimeInFrames: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_set_stop_time_in_milliseconds :: (pGroup: *ma_sound_group, absoluteGlobalTimeInMilliseconds: ma_uint64) -> void #foreign libminiaudio;
ma_sound_group_is_playing :: (pGroup: *ma_sound_group) -> ma_bool32 #foreign libminiaudio;
ma_sound_group_get_time_in_pcm_frames :: (pGroup: *ma_sound_group) -> ma_uint64 #foreign libminiaudio;

#scope_file

#import "Basic"; // For assert, print_to_builder


#run {
    {
        info := type_info(ma_allocation_callbacks);
        for info.members {
            if it.name == {
                case "pUserData";
                    assert(it.offset_in_bytes == 0, "ma_allocation_callbacks.pUserData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_allocation_callbacks.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "onMalloc";
                    assert(it.offset_in_bytes == 8, "ma_allocation_callbacks.onMalloc has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_allocation_callbacks.onMalloc has unexpected size % instead of 8", it.type.runtime_size);
                case "onRealloc";
                    assert(it.offset_in_bytes == 16, "ma_allocation_callbacks.onRealloc has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_allocation_callbacks.onRealloc has unexpected size % instead of 8", it.type.runtime_size);
                case "onFree";
                    assert(it.offset_in_bytes == 24, "ma_allocation_callbacks.onFree has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_allocation_callbacks.onFree has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_allocation_callbacks) == 32, "ma_allocation_callbacks has size % instead of 32", size_of(ma_allocation_callbacks));
    }

    {
        info := type_info(ma_lcg);
        for info.members {
            if it.name == {
                case "state";
                    assert(it.offset_in_bytes == 0, "ma_lcg.state has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lcg.state has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lcg) == 4, "ma_lcg has size % instead of 4", size_of(ma_lcg));
    }

    {
        info := type_info(ma_atomic_uint32);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_uint32.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_uint32.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_uint32) == 4, "ma_atomic_uint32 has size % instead of 4", size_of(ma_atomic_uint32));
    }

    {
        info := type_info(ma_atomic_int32);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_int32.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_int32.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_int32) == 4, "ma_atomic_int32 has size % instead of 4", size_of(ma_atomic_int32));
    }

    {
        info := type_info(ma_atomic_uint64);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_uint64.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_atomic_uint64.value has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_uint64) == 8, "ma_atomic_uint64 has size % instead of 8", size_of(ma_atomic_uint64));
    }

    {
        info := type_info(ma_atomic_float);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_float.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_float.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_float) == 4, "ma_atomic_float has size % instead of 4", size_of(ma_atomic_float));
    }

    {
        info := type_info(ma_atomic_bool32);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_bool32.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_bool32.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_bool32) == 4, "ma_atomic_bool32 has size % instead of 4", size_of(ma_atomic_bool32));
    }

    {
        info := type_info(ma_event);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_event.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_event.value has unexpected size % instead of 4", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 8, "ma_event.lock has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_event.lock has unexpected size % instead of 40", it.type.runtime_size);
                case "cond";
                    assert(it.offset_in_bytes == 48, "ma_event.cond has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_event.cond has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_event) == 96, "ma_event has size % instead of 96", size_of(ma_event));
    }

    {
        info := type_info(ma_semaphore);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_semaphore.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_semaphore.value has unexpected size % instead of 4", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 8, "ma_semaphore.lock has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_semaphore.lock has unexpected size % instead of 40", it.type.runtime_size);
                case "cond";
                    assert(it.offset_in_bytes == 48, "ma_semaphore.cond has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_semaphore.cond has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_semaphore) == 96, "ma_semaphore has size % instead of 96", size_of(ma_semaphore));
    }

    {
        info := type_info(ma_log_callback);
        for info.members {
            if it.name == {
                case "onLog";
                    assert(it.offset_in_bytes == 0, "ma_log_callback.onLog has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_log_callback.onLog has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 8, "ma_log_callback.pUserData has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_log_callback.pUserData has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_log_callback) == 16, "ma_log_callback has size % instead of 16", size_of(ma_log_callback));
    }

    {
        info := type_info(ma_log);
        for info.members {
            if it.name == {
                case "callbacks";
                    assert(it.offset_in_bytes == 0, "ma_log.callbacks has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_log.callbacks has unexpected size % instead of 64", it.type.runtime_size);
                case "callbackCount";
                    assert(it.offset_in_bytes == 64, "ma_log.callbackCount has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_log.callbackCount has unexpected size % instead of 4", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 72, "ma_log.allocationCallbacks has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_log.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 104, "ma_log.lock has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_log.lock has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_log) == 144, "ma_log has size % instead of 144", size_of(ma_log));
    }

    {
        info := type_info(ma_biquad_coefficient);
        for info.members {
            if it.name == {
                case "f32";
                    assert(it.offset_in_bytes == 0, "ma_biquad_coefficient.f32 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad_coefficient.f32 has unexpected size % instead of 4", it.type.runtime_size);
                case "_s32";
                    assert(it.offset_in_bytes == 0, "ma_biquad_coefficient._s32 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad_coefficient._s32 has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_biquad_coefficient) == 4, "ma_biquad_coefficient has size % instead of 4", size_of(ma_biquad_coefficient));
    }

    {
        info := type_info(ma_biquad_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_biquad_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_biquad_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "b0";
                    assert(it.offset_in_bytes == 8, "ma_biquad_config.b0 has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.b0 has unexpected size % instead of 8", it.type.runtime_size);
                case "b1";
                    assert(it.offset_in_bytes == 16, "ma_biquad_config.b1 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.b1 has unexpected size % instead of 8", it.type.runtime_size);
                case "b2";
                    assert(it.offset_in_bytes == 24, "ma_biquad_config.b2 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.b2 has unexpected size % instead of 8", it.type.runtime_size);
                case "a0";
                    assert(it.offset_in_bytes == 32, "ma_biquad_config.a0 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.a0 has unexpected size % instead of 8", it.type.runtime_size);
                case "a1";
                    assert(it.offset_in_bytes == 40, "ma_biquad_config.a1 has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.a1 has unexpected size % instead of 8", it.type.runtime_size);
                case "a2";
                    assert(it.offset_in_bytes == 48, "ma_biquad_config.a2 has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad_config.a2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_biquad_config) == 56, "ma_biquad_config has size % instead of 56", size_of(ma_biquad_config));
    }

    {
        info := type_info(ma_biquad);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_biquad.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_biquad.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "b0";
                    assert(it.offset_in_bytes == 8, "ma_biquad.b0 has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.b0 has unexpected size % instead of 4", it.type.runtime_size);
                case "b1";
                    assert(it.offset_in_bytes == 12, "ma_biquad.b1 has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.b1 has unexpected size % instead of 4", it.type.runtime_size);
                case "b2";
                    assert(it.offset_in_bytes == 16, "ma_biquad.b2 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.b2 has unexpected size % instead of 4", it.type.runtime_size);
                case "a1";
                    assert(it.offset_in_bytes == 20, "ma_biquad.a1 has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.a1 has unexpected size % instead of 4", it.type.runtime_size);
                case "a2";
                    assert(it.offset_in_bytes == 24, "ma_biquad.a2 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad.a2 has unexpected size % instead of 4", it.type.runtime_size);
                case "pR1";
                    assert(it.offset_in_bytes == 32, "ma_biquad.pR1 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad.pR1 has unexpected size % instead of 8", it.type.runtime_size);
                case "pR2";
                    assert(it.offset_in_bytes == 40, "ma_biquad.pR2 has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad.pR2 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 48, "ma_biquad._pHeap has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_biquad._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 56, "ma_biquad._ownsHeap has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_biquad._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_biquad) == 64, "ma_biquad has size % instead of 64", size_of(ma_biquad));
    }

    {
        info := type_info(ma_lpf1_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_lpf1_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_lpf1_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_lpf1_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_lpf1_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf1_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 24, "ma_lpf1_config.q has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf1_config.q has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf1_config) == 32, "ma_lpf1_config has size % instead of 32", size_of(ma_lpf1_config));
    }

    {
        info := type_info(ma_lpf1);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_lpf1.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_lpf1.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "a";
                    assert(it.offset_in_bytes == 8, "ma_lpf1.a has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1.a has unexpected size % instead of 4", it.type.runtime_size);
                case "pR1";
                    assert(it.offset_in_bytes == 16, "ma_lpf1.pR1 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf1.pR1 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 24, "ma_lpf1._pHeap has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf1._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 32, "ma_lpf1._ownsHeap has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf1._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf1) == 40, "ma_lpf1 has size % instead of 40", size_of(ma_lpf1));
    }

    {
        info := type_info(ma_lpf2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_lpf2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_lpf2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf2) == 64, "ma_lpf2 has size % instead of 64", size_of(ma_lpf2));
    }

    {
        info := type_info(ma_lpf_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_lpf_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_lpf_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_lpf_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_lpf_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "order";
                    assert(it.offset_in_bytes == 24, "ma_lpf_config.order has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf_config.order has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf_config) == 32, "ma_lpf_config has size % instead of 32", size_of(ma_lpf_config));
    }

    {
        info := type_info(ma_lpf);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_lpf.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_lpf.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_lpf.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "lpf1Count";
                    assert(it.offset_in_bytes == 12, "ma_lpf.lpf1Count has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf.lpf1Count has unexpected size % instead of 4", it.type.runtime_size);
                case "lpf2Count";
                    assert(it.offset_in_bytes == 16, "ma_lpf.lpf2Count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf.lpf2Count has unexpected size % instead of 4", it.type.runtime_size);
                case "pLPF1";
                    assert(it.offset_in_bytes == 24, "ma_lpf.pLPF1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf.pLPF1 has unexpected size % instead of 8", it.type.runtime_size);
                case "pLPF2";
                    assert(it.offset_in_bytes == 32, "ma_lpf.pLPF2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf.pLPF2 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 40, "ma_lpf._pHeap has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_lpf._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 48, "ma_lpf._ownsHeap has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_lpf._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf) == 56, "ma_lpf has size % instead of 56", size_of(ma_lpf));
    }

    {
        info := type_info(ma_hpf1_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_hpf1_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_hpf1_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_hpf1_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_hpf1_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf1_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 24, "ma_hpf1_config.q has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf1_config.q has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf1_config) == 32, "ma_hpf1_config has size % instead of 32", size_of(ma_hpf1_config));
    }

    {
        info := type_info(ma_hpf1);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_hpf1.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_hpf1.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "a";
                    assert(it.offset_in_bytes == 8, "ma_hpf1.a has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1.a has unexpected size % instead of 4", it.type.runtime_size);
                case "pR1";
                    assert(it.offset_in_bytes == 16, "ma_hpf1.pR1 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf1.pR1 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 24, "ma_hpf1._pHeap has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf1._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 32, "ma_hpf1._ownsHeap has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf1._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf1) == 40, "ma_hpf1 has size % instead of 40", size_of(ma_hpf1));
    }

    {
        info := type_info(ma_hpf2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_hpf2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_hpf2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf2) == 64, "ma_hpf2 has size % instead of 64", size_of(ma_hpf2));
    }

    {
        info := type_info(ma_hpf_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_hpf_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_hpf_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_hpf_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_hpf_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "order";
                    assert(it.offset_in_bytes == 24, "ma_hpf_config.order has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf_config.order has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf_config) == 32, "ma_hpf_config has size % instead of 32", size_of(ma_hpf_config));
    }

    {
        info := type_info(ma_hpf);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_hpf.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_hpf.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_hpf.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "hpf1Count";
                    assert(it.offset_in_bytes == 12, "ma_hpf.hpf1Count has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf.hpf1Count has unexpected size % instead of 4", it.type.runtime_size);
                case "hpf2Count";
                    assert(it.offset_in_bytes == 16, "ma_hpf.hpf2Count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf.hpf2Count has unexpected size % instead of 4", it.type.runtime_size);
                case "pHPF1";
                    assert(it.offset_in_bytes == 24, "ma_hpf.pHPF1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf.pHPF1 has unexpected size % instead of 8", it.type.runtime_size);
                case "pHPF2";
                    assert(it.offset_in_bytes == 32, "ma_hpf.pHPF2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf.pHPF2 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 40, "ma_hpf._pHeap has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hpf._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 48, "ma_hpf._ownsHeap has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hpf._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf) == 56, "ma_hpf has size % instead of 56", size_of(ma_hpf));
    }

    {
        info := type_info(ma_bpf2_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_bpf2_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf2_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_bpf2_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf2_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_bpf2_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf2_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_bpf2_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_bpf2_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 24, "ma_bpf2_config.q has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_bpf2_config.q has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf2_config) == 32, "ma_bpf2_config has size % instead of 32", size_of(ma_bpf2_config));
    }

    {
        info := type_info(ma_bpf2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_bpf2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_bpf2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf2) == 64, "ma_bpf2 has size % instead of 64", size_of(ma_bpf2));
    }

    {
        info := type_info(ma_bpf_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_bpf_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_bpf_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_bpf_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cutoffFrequency";
                    assert(it.offset_in_bytes == 16, "ma_bpf_config.cutoffFrequency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_bpf_config.cutoffFrequency has unexpected size % instead of 8", it.type.runtime_size);
                case "order";
                    assert(it.offset_in_bytes == 24, "ma_bpf_config.order has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf_config.order has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf_config) == 32, "ma_bpf_config has size % instead of 32", size_of(ma_bpf_config));
    }

    {
        info := type_info(ma_bpf);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_bpf.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_bpf.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "bpf2Count";
                    assert(it.offset_in_bytes == 8, "ma_bpf.bpf2Count has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf.bpf2Count has unexpected size % instead of 4", it.type.runtime_size);
                case "pBPF2";
                    assert(it.offset_in_bytes == 16, "ma_bpf.pBPF2 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_bpf.pBPF2 has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 24, "ma_bpf._pHeap has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_bpf._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 32, "ma_bpf._ownsHeap has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_bpf._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf) == 40, "ma_bpf has size % instead of 40", size_of(ma_bpf));
    }

    {
        info := type_info(ma_notch2_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_notch2_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_notch2_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_notch2_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_notch2_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_notch2_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_notch2_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 16, "ma_notch2_config.q has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_notch2_config.q has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 24, "ma_notch2_config.frequency has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_notch2_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_notch2_config) == 32, "ma_notch2_config has size % instead of 32", size_of(ma_notch2_config));
    }

    {
        info := type_info(ma_notch2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_notch2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_notch2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_notch2) == 64, "ma_notch2 has size % instead of 64", size_of(ma_notch2));
    }

    {
        info := type_info(ma_peak2_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_peak2_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_peak2_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_peak2_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_peak2_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_peak2_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_peak2_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "gainDB";
                    assert(it.offset_in_bytes == 16, "ma_peak2_config.gainDB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_peak2_config.gainDB has unexpected size % instead of 8", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 24, "ma_peak2_config.q has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_peak2_config.q has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 32, "ma_peak2_config.frequency has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_peak2_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_peak2_config) == 40, "ma_peak2_config has size % instead of 40", size_of(ma_peak2_config));
    }

    {
        info := type_info(ma_peak2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_peak2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_peak2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_peak2) == 64, "ma_peak2 has size % instead of 64", size_of(ma_peak2));
    }

    {
        info := type_info(ma_loshelf2_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_loshelf2_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_loshelf2_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_loshelf2_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_loshelf2_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_loshelf2_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_loshelf2_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "gainDB";
                    assert(it.offset_in_bytes == 16, "ma_loshelf2_config.gainDB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_loshelf2_config.gainDB has unexpected size % instead of 8", it.type.runtime_size);
                case "shelfSlope";
                    assert(it.offset_in_bytes == 24, "ma_loshelf2_config.shelfSlope has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_loshelf2_config.shelfSlope has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 32, "ma_loshelf2_config.frequency has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_loshelf2_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_loshelf2_config) == 40, "ma_loshelf2_config has size % instead of 40", size_of(ma_loshelf2_config));
    }

    {
        info := type_info(ma_loshelf2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_loshelf2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_loshelf2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_loshelf2) == 64, "ma_loshelf2 has size % instead of 64", size_of(ma_loshelf2));
    }

    {
        info := type_info(ma_hishelf2_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_hishelf2_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hishelf2_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_hishelf2_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hishelf2_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_hishelf2_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_hishelf2_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "gainDB";
                    assert(it.offset_in_bytes == 16, "ma_hishelf2_config.gainDB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hishelf2_config.gainDB has unexpected size % instead of 8", it.type.runtime_size);
                case "shelfSlope";
                    assert(it.offset_in_bytes == 24, "ma_hishelf2_config.shelfSlope has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hishelf2_config.shelfSlope has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 32, "ma_hishelf2_config.frequency has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_hishelf2_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hishelf2_config) == 40, "ma_hishelf2_config has size % instead of 40", size_of(ma_hishelf2_config));
    }

    {
        info := type_info(ma_hishelf2);
        for info.members {
            if it.name == {
                case "bq";
                    assert(it.offset_in_bytes == 0, "ma_hishelf2.bq has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_hishelf2.bq has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hishelf2) == 64, "ma_hishelf2 has size % instead of 64", size_of(ma_hishelf2));
    }

    {
        info := type_info(ma_delay_config);
        for info.members {
            if it.name == {
                case "channels";
                    assert(it.offset_in_bytes == 0, "ma_delay_config.channels has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 4, "ma_delay_config.sampleRate has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "delayInFrames";
                    assert(it.offset_in_bytes == 8, "ma_delay_config.delayInFrames has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.delayInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "delayStart";
                    assert(it.offset_in_bytes == 12, "ma_delay_config.delayStart has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.delayStart has unexpected size % instead of 4", it.type.runtime_size);
                case "wet";
                    assert(it.offset_in_bytes == 16, "ma_delay_config.wet has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.wet has unexpected size % instead of 4", it.type.runtime_size);
                case "dry";
                    assert(it.offset_in_bytes == 20, "ma_delay_config.dry has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.dry has unexpected size % instead of 4", it.type.runtime_size);
                case "decay";
                    assert(it.offset_in_bytes == 24, "ma_delay_config.decay has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay_config.decay has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_delay_config) == 28, "ma_delay_config has size % instead of 28", size_of(ma_delay_config));
    }

    {
        info := type_info(ma_delay);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_delay.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "ma_delay.config has unexpected size % instead of 28", it.type.runtime_size);
                case "cursor";
                    assert(it.offset_in_bytes == 28, "ma_delay.cursor has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay.cursor has unexpected size % instead of 4", it.type.runtime_size);
                case "bufferSizeInFrames";
                    assert(it.offset_in_bytes == 32, "ma_delay.bufferSizeInFrames has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_delay.bufferSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "pBuffer";
                    assert(it.offset_in_bytes == 40, "ma_delay.pBuffer has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_delay.pBuffer has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_delay) == 48, "ma_delay has size % instead of 48", size_of(ma_delay));
    }

    {
        info := type_info(ma_gainer_config);
        for info.members {
            if it.name == {
                case "channels";
                    assert(it.offset_in_bytes == 0, "ma_gainer_config.channels has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_gainer_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "smoothTimeInFrames";
                    assert(it.offset_in_bytes == 4, "ma_gainer_config.smoothTimeInFrames has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_gainer_config.smoothTimeInFrames has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_gainer_config) == 8, "ma_gainer_config has size % instead of 8", size_of(ma_gainer_config));
    }

    {
        info := type_info(ma_gainer);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_gainer.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_gainer.config has unexpected size % instead of 8", it.type.runtime_size);
                case "t";
                    assert(it.offset_in_bytes == 8, "ma_gainer.t has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_gainer.t has unexpected size % instead of 4", it.type.runtime_size);
                case "masterVolume";
                    assert(it.offset_in_bytes == 12, "ma_gainer.masterVolume has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_gainer.masterVolume has unexpected size % instead of 4", it.type.runtime_size);
                case "pOldGains";
                    assert(it.offset_in_bytes == 16, "ma_gainer.pOldGains has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_gainer.pOldGains has unexpected size % instead of 8", it.type.runtime_size);
                case "pNewGains";
                    assert(it.offset_in_bytes == 24, "ma_gainer.pNewGains has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_gainer.pNewGains has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 32, "ma_gainer._pHeap has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_gainer._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 40, "ma_gainer._ownsHeap has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_gainer._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_gainer) == 48, "ma_gainer has size % instead of 48", size_of(ma_gainer));
    }

    {
        info := type_info(ma_panner_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_panner_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_panner_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "ma_panner_config.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner_config.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "pan";
                    assert(it.offset_in_bytes == 12, "ma_panner_config.pan has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner_config.pan has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_panner_config) == 16, "ma_panner_config has size % instead of 16", size_of(ma_panner_config));
    }

    {
        info := type_info(ma_panner);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_panner.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_panner.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "ma_panner.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "pan";
                    assert(it.offset_in_bytes == 12, "ma_panner.pan has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_panner.pan has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_panner) == 16, "ma_panner has size % instead of 16", size_of(ma_panner));
    }

    {
        info := type_info(ma_fader_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_fader_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fader_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_fader_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fader_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_fader_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fader_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_fader_config) == 12, "ma_fader_config has size % instead of 12", size_of(ma_fader_config));
    }

    {
        info := type_info(ma_fader);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_fader.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "ma_fader.config has unexpected size % instead of 12", it.type.runtime_size);
                case "volumeBeg";
                    assert(it.offset_in_bytes == 12, "ma_fader.volumeBeg has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fader.volumeBeg has unexpected size % instead of 4", it.type.runtime_size);
                case "volumeEnd";
                    assert(it.offset_in_bytes == 16, "ma_fader.volumeEnd has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fader.volumeEnd has unexpected size % instead of 4", it.type.runtime_size);
                case "lengthInFrames";
                    assert(it.offset_in_bytes == 24, "ma_fader.lengthInFrames has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_fader.lengthInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "cursorInFrames";
                    assert(it.offset_in_bytes == 32, "ma_fader.cursorInFrames has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_fader.cursorInFrames has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_fader) == 40, "ma_fader has size % instead of 40", size_of(ma_fader));
    }

    {
        info := type_info(ma_vec3f);
        for info.members {
            if it.name == {
                case "x";
                    assert(it.offset_in_bytes == 0, "ma_vec3f.x has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_vec3f.x has unexpected size % instead of 4", it.type.runtime_size);
                case "y";
                    assert(it.offset_in_bytes == 4, "ma_vec3f.y has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_vec3f.y has unexpected size % instead of 4", it.type.runtime_size);
                case "z";
                    assert(it.offset_in_bytes == 8, "ma_vec3f.z has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_vec3f.z has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_vec3f) == 12, "ma_vec3f has size % instead of 12", size_of(ma_vec3f));
    }

    {
        info := type_info(ma_atomic_vec3f);
        for info.members {
            if it.name == {
                case "v";
                    assert(it.offset_in_bytes == 0, "ma_atomic_vec3f.v has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "ma_atomic_vec3f.v has unexpected size % instead of 12", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 12, "ma_atomic_vec3f.lock has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_vec3f.lock has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_vec3f) == 16, "ma_atomic_vec3f has size % instead of 16", size_of(ma_atomic_vec3f));
    }

    {
        info := type_info(ma_spatializer_listener_config);
        for info.members {
            if it.name == {
                case "channelsOut";
                    assert(it.offset_in_bytes == 0, "ma_spatializer_listener_config.channelsOut has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapOut";
                    assert(it.offset_in_bytes == 8, "ma_spatializer_listener_config.pChannelMapOut has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer_listener_config.pChannelMapOut has unexpected size % instead of 8", it.type.runtime_size);
                case "handedness";
                    assert(it.offset_in_bytes == 16, "ma_spatializer_listener_config.handedness has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.handedness has unexpected size % instead of 4", it.type.runtime_size);
                case "coneInnerAngleInRadians";
                    assert(it.offset_in_bytes == 20, "ma_spatializer_listener_config.coneInnerAngleInRadians has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.coneInnerAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterAngleInRadians";
                    assert(it.offset_in_bytes == 24, "ma_spatializer_listener_config.coneOuterAngleInRadians has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.coneOuterAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterGain";
                    assert(it.offset_in_bytes == 28, "ma_spatializer_listener_config.coneOuterGain has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.coneOuterGain has unexpected size % instead of 4", it.type.runtime_size);
                case "speedOfSound";
                    assert(it.offset_in_bytes == 32, "ma_spatializer_listener_config.speedOfSound has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener_config.speedOfSound has unexpected size % instead of 4", it.type.runtime_size);
                case "worldUp";
                    assert(it.offset_in_bytes == 36, "ma_spatializer_listener_config.worldUp has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "ma_spatializer_listener_config.worldUp has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(ma_spatializer_listener_config) == 48, "ma_spatializer_listener_config has size % instead of 48", size_of(ma_spatializer_listener_config));
    }

    {
        info := type_info(ma_spatializer_listener);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_spatializer_listener.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_spatializer_listener.config has unexpected size % instead of 48", it.type.runtime_size);
                case "position";
                    assert(it.offset_in_bytes == 48, "ma_spatializer_listener.position has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer_listener.position has unexpected size % instead of 16", it.type.runtime_size);
                case "direction";
                    assert(it.offset_in_bytes == 64, "ma_spatializer_listener.direction has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer_listener.direction has unexpected size % instead of 16", it.type.runtime_size);
                case "velocity";
                    assert(it.offset_in_bytes == 80, "ma_spatializer_listener.velocity has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer_listener.velocity has unexpected size % instead of 16", it.type.runtime_size);
                case "isEnabled";
                    assert(it.offset_in_bytes == 96, "ma_spatializer_listener.isEnabled has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener.isEnabled has unexpected size % instead of 4", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 100, "ma_spatializer_listener._ownsHeap has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_listener._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 104, "ma_spatializer_listener._pHeap has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer_listener._pHeap has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_spatializer_listener) == 112, "ma_spatializer_listener has size % instead of 112", size_of(ma_spatializer_listener));
    }

    {
        info := type_info(ma_spatializer_config);
        for info.members {
            if it.name == {
                case "channelsIn";
                    assert(it.offset_in_bytes == 0, "ma_spatializer_config.channelsIn has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 4, "ma_spatializer_config.channelsOut has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapIn";
                    assert(it.offset_in_bytes == 8, "ma_spatializer_config.pChannelMapIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer_config.pChannelMapIn has unexpected size % instead of 8", it.type.runtime_size);
                case "attenuationModel";
                    assert(it.offset_in_bytes == 16, "ma_spatializer_config.attenuationModel has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.attenuationModel has unexpected size % instead of 4", it.type.runtime_size);
                case "positioning";
                    assert(it.offset_in_bytes == 20, "ma_spatializer_config.positioning has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.positioning has unexpected size % instead of 4", it.type.runtime_size);
                case "handedness";
                    assert(it.offset_in_bytes == 24, "ma_spatializer_config.handedness has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.handedness has unexpected size % instead of 4", it.type.runtime_size);
                case "minGain";
                    assert(it.offset_in_bytes == 28, "ma_spatializer_config.minGain has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.minGain has unexpected size % instead of 4", it.type.runtime_size);
                case "maxGain";
                    assert(it.offset_in_bytes == 32, "ma_spatializer_config.maxGain has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.maxGain has unexpected size % instead of 4", it.type.runtime_size);
                case "minDistance";
                    assert(it.offset_in_bytes == 36, "ma_spatializer_config.minDistance has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.minDistance has unexpected size % instead of 4", it.type.runtime_size);
                case "maxDistance";
                    assert(it.offset_in_bytes == 40, "ma_spatializer_config.maxDistance has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.maxDistance has unexpected size % instead of 4", it.type.runtime_size);
                case "rolloff";
                    assert(it.offset_in_bytes == 44, "ma_spatializer_config.rolloff has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.rolloff has unexpected size % instead of 4", it.type.runtime_size);
                case "coneInnerAngleInRadians";
                    assert(it.offset_in_bytes == 48, "ma_spatializer_config.coneInnerAngleInRadians has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.coneInnerAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterAngleInRadians";
                    assert(it.offset_in_bytes == 52, "ma_spatializer_config.coneOuterAngleInRadians has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.coneOuterAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterGain";
                    assert(it.offset_in_bytes == 56, "ma_spatializer_config.coneOuterGain has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.coneOuterGain has unexpected size % instead of 4", it.type.runtime_size);
                case "dopplerFactor";
                    assert(it.offset_in_bytes == 60, "ma_spatializer_config.dopplerFactor has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.dopplerFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "directionalAttenuationFactor";
                    assert(it.offset_in_bytes == 64, "ma_spatializer_config.directionalAttenuationFactor has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.directionalAttenuationFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "minSpatializationChannelGain";
                    assert(it.offset_in_bytes == 68, "ma_spatializer_config.minSpatializationChannelGain has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.minSpatializationChannelGain has unexpected size % instead of 4", it.type.runtime_size);
                case "gainSmoothTimeInFrames";
                    assert(it.offset_in_bytes == 72, "ma_spatializer_config.gainSmoothTimeInFrames has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer_config.gainSmoothTimeInFrames has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_spatializer_config) == 80, "ma_spatializer_config has size % instead of 80", size_of(ma_spatializer_config));
    }

    {
        info := type_info(ma_spatializer);
        for info.members {
            if it.name == {
                case "channelsIn";
                    assert(it.offset_in_bytes == 0, "ma_spatializer.channelsIn has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 4, "ma_spatializer.channelsOut has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapIn";
                    assert(it.offset_in_bytes == 8, "ma_spatializer.pChannelMapIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer.pChannelMapIn has unexpected size % instead of 8", it.type.runtime_size);
                case "attenuationModel";
                    assert(it.offset_in_bytes == 16, "ma_spatializer.attenuationModel has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.attenuationModel has unexpected size % instead of 4", it.type.runtime_size);
                case "positioning";
                    assert(it.offset_in_bytes == 20, "ma_spatializer.positioning has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.positioning has unexpected size % instead of 4", it.type.runtime_size);
                case "handedness";
                    assert(it.offset_in_bytes == 24, "ma_spatializer.handedness has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.handedness has unexpected size % instead of 4", it.type.runtime_size);
                case "minGain";
                    assert(it.offset_in_bytes == 28, "ma_spatializer.minGain has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.minGain has unexpected size % instead of 4", it.type.runtime_size);
                case "maxGain";
                    assert(it.offset_in_bytes == 32, "ma_spatializer.maxGain has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.maxGain has unexpected size % instead of 4", it.type.runtime_size);
                case "minDistance";
                    assert(it.offset_in_bytes == 36, "ma_spatializer.minDistance has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.minDistance has unexpected size % instead of 4", it.type.runtime_size);
                case "maxDistance";
                    assert(it.offset_in_bytes == 40, "ma_spatializer.maxDistance has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.maxDistance has unexpected size % instead of 4", it.type.runtime_size);
                case "rolloff";
                    assert(it.offset_in_bytes == 44, "ma_spatializer.rolloff has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.rolloff has unexpected size % instead of 4", it.type.runtime_size);
                case "coneInnerAngleInRadians";
                    assert(it.offset_in_bytes == 48, "ma_spatializer.coneInnerAngleInRadians has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.coneInnerAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterAngleInRadians";
                    assert(it.offset_in_bytes == 52, "ma_spatializer.coneOuterAngleInRadians has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.coneOuterAngleInRadians has unexpected size % instead of 4", it.type.runtime_size);
                case "coneOuterGain";
                    assert(it.offset_in_bytes == 56, "ma_spatializer.coneOuterGain has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.coneOuterGain has unexpected size % instead of 4", it.type.runtime_size);
                case "dopplerFactor";
                    assert(it.offset_in_bytes == 60, "ma_spatializer.dopplerFactor has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.dopplerFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "directionalAttenuationFactor";
                    assert(it.offset_in_bytes == 64, "ma_spatializer.directionalAttenuationFactor has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.directionalAttenuationFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "gainSmoothTimeInFrames";
                    assert(it.offset_in_bytes == 68, "ma_spatializer.gainSmoothTimeInFrames has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.gainSmoothTimeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "position";
                    assert(it.offset_in_bytes == 72, "ma_spatializer.position has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer.position has unexpected size % instead of 16", it.type.runtime_size);
                case "direction";
                    assert(it.offset_in_bytes == 88, "ma_spatializer.direction has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer.direction has unexpected size % instead of 16", it.type.runtime_size);
                case "velocity";
                    assert(it.offset_in_bytes == 104, "ma_spatializer.velocity has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_spatializer.velocity has unexpected size % instead of 16", it.type.runtime_size);
                case "dopplerPitch";
                    assert(it.offset_in_bytes == 120, "ma_spatializer.dopplerPitch has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.dopplerPitch has unexpected size % instead of 4", it.type.runtime_size);
                case "minSpatializationChannelGain";
                    assert(it.offset_in_bytes == 124, "ma_spatializer.minSpatializationChannelGain has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer.minSpatializationChannelGain has unexpected size % instead of 4", it.type.runtime_size);
                case "gainer";
                    assert(it.offset_in_bytes == 128, "ma_spatializer.gainer has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_spatializer.gainer has unexpected size % instead of 48", it.type.runtime_size);
                case "pNewChannelGainsOut";
                    assert(it.offset_in_bytes == 176, "ma_spatializer.pNewChannelGainsOut has unexpected offset % instead of 176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer.pNewChannelGainsOut has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 184, "ma_spatializer._pHeap has unexpected offset % instead of 184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_spatializer._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 192, "ma_spatializer._ownsHeap has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_spatializer._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_spatializer) == 200, "ma_spatializer has size % instead of 200", size_of(ma_spatializer));
    }

    {
        info := type_info(ma_linear_resampler_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_linear_resampler_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_linear_resampler_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateIn";
                    assert(it.offset_in_bytes == 8, "ma_linear_resampler_config.sampleRateIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler_config.sampleRateIn has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateOut";
                    assert(it.offset_in_bytes == 12, "ma_linear_resampler_config.sampleRateOut has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler_config.sampleRateOut has unexpected size % instead of 4", it.type.runtime_size);
                case "lpfOrder";
                    assert(it.offset_in_bytes == 16, "ma_linear_resampler_config.lpfOrder has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler_config.lpfOrder has unexpected size % instead of 4", it.type.runtime_size);
                case "lpfNyquistFactor";
                    assert(it.offset_in_bytes == 24, "ma_linear_resampler_config.lpfNyquistFactor has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_linear_resampler_config.lpfNyquistFactor has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_linear_resampler_config) == 32, "ma_linear_resampler_config has size % instead of 32", size_of(ma_linear_resampler_config));
    }

    {
        info := type_info(ma_linear_resampler);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_linear_resampler.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_linear_resampler.config has unexpected size % instead of 32", it.type.runtime_size);
                case "inAdvanceInt";
                    assert(it.offset_in_bytes == 32, "ma_linear_resampler.inAdvanceInt has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler.inAdvanceInt has unexpected size % instead of 4", it.type.runtime_size);
                case "inAdvanceFrac";
                    assert(it.offset_in_bytes == 36, "ma_linear_resampler.inAdvanceFrac has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler.inAdvanceFrac has unexpected size % instead of 4", it.type.runtime_size);
                case "inTimeInt";
                    assert(it.offset_in_bytes == 40, "ma_linear_resampler.inTimeInt has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler.inTimeInt has unexpected size % instead of 4", it.type.runtime_size);
                case "inTimeFrac";
                    assert(it.offset_in_bytes == 44, "ma_linear_resampler.inTimeFrac has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler.inTimeFrac has unexpected size % instead of 4", it.type.runtime_size);
                case "x0";
                    assert(it.offset_in_bytes == 48, "ma_linear_resampler.x0 has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_linear_resampler.x0 has unexpected size % instead of 8", it.type.runtime_size);
                case "x1";
                    assert(it.offset_in_bytes == 56, "ma_linear_resampler.x1 has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_linear_resampler.x1 has unexpected size % instead of 8", it.type.runtime_size);
                case "lpf";
                    assert(it.offset_in_bytes == 64, "ma_linear_resampler.lpf has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_linear_resampler.lpf has unexpected size % instead of 56", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 120, "ma_linear_resampler._pHeap has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_linear_resampler._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 128, "ma_linear_resampler._ownsHeap has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_linear_resampler._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_linear_resampler) == 136, "ma_linear_resampler has size % instead of 136", size_of(ma_linear_resampler));
    }

    {
        info := type_info(ma_resampling_backend_vtable);
        for info.members {
            if it.name == {
                case "onGetHeapSize";
                    assert(it.offset_in_bytes == 0, "ma_resampling_backend_vtable.onGetHeapSize has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onGetHeapSize has unexpected size % instead of 8", it.type.runtime_size);
                case "onInit";
                    assert(it.offset_in_bytes == 8, "ma_resampling_backend_vtable.onInit has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onInit has unexpected size % instead of 8", it.type.runtime_size);
                case "onUninit";
                    assert(it.offset_in_bytes == 16, "ma_resampling_backend_vtable.onUninit has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onUninit has unexpected size % instead of 8", it.type.runtime_size);
                case "onProcess";
                    assert(it.offset_in_bytes == 24, "ma_resampling_backend_vtable.onProcess has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onProcess has unexpected size % instead of 8", it.type.runtime_size);
                case "onSetRate";
                    assert(it.offset_in_bytes == 32, "ma_resampling_backend_vtable.onSetRate has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onSetRate has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetInputLatency";
                    assert(it.offset_in_bytes == 40, "ma_resampling_backend_vtable.onGetInputLatency has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onGetInputLatency has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetOutputLatency";
                    assert(it.offset_in_bytes == 48, "ma_resampling_backend_vtable.onGetOutputLatency has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onGetOutputLatency has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetRequiredInputFrameCount";
                    assert(it.offset_in_bytes == 56, "ma_resampling_backend_vtable.onGetRequiredInputFrameCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onGetRequiredInputFrameCount has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetExpectedOutputFrameCount";
                    assert(it.offset_in_bytes == 64, "ma_resampling_backend_vtable.onGetExpectedOutputFrameCount has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onGetExpectedOutputFrameCount has unexpected size % instead of 8", it.type.runtime_size);
                case "onReset";
                    assert(it.offset_in_bytes == 72, "ma_resampling_backend_vtable.onReset has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampling_backend_vtable.onReset has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resampling_backend_vtable) == 80, "ma_resampling_backend_vtable has size % instead of 80", size_of(ma_resampling_backend_vtable));
    }

    {
        info := type_info(ma_resampler_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_resampler_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_resampler_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateIn";
                    assert(it.offset_in_bytes == 8, "ma_resampler_config.sampleRateIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.sampleRateIn has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateOut";
                    assert(it.offset_in_bytes == 12, "ma_resampler_config.sampleRateOut has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.sampleRateOut has unexpected size % instead of 4", it.type.runtime_size);
                case "algorithm";
                    assert(it.offset_in_bytes == 16, "ma_resampler_config.algorithm has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.algorithm has unexpected size % instead of 4", it.type.runtime_size);
                case "pBackendVTable";
                    assert(it.offset_in_bytes == 24, "ma_resampler_config.pBackendVTable has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler_config.pBackendVTable has unexpected size % instead of 8", it.type.runtime_size);
                case "pBackendUserData";
                    assert(it.offset_in_bytes == 32, "ma_resampler_config.pBackendUserData has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler_config.pBackendUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "linear";
                    assert(it.offset_in_bytes == 40, "ma_resampler_config.linear has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler_config.linear has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resampler_config) == 48, "ma_resampler_config has size % instead of 48", size_of(ma_resampler_config));
    }

    {
        info := type_info(ma_resampler);
        for info.members {
            if it.name == {
                case "pBackend";
                    assert(it.offset_in_bytes == 0, "ma_resampler.pBackend has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler.pBackend has unexpected size % instead of 8", it.type.runtime_size);
                case "pBackendVTable";
                    assert(it.offset_in_bytes == 8, "ma_resampler.pBackendVTable has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler.pBackendVTable has unexpected size % instead of 8", it.type.runtime_size);
                case "pBackendUserData";
                    assert(it.offset_in_bytes == 16, "ma_resampler.pBackendUserData has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler.pBackendUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 24, "ma_resampler.format has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 28, "ma_resampler.channels has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateIn";
                    assert(it.offset_in_bytes == 32, "ma_resampler.sampleRateIn has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler.sampleRateIn has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateOut";
                    assert(it.offset_in_bytes == 36, "ma_resampler.sampleRateOut has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler.sampleRateOut has unexpected size % instead of 4", it.type.runtime_size);
                case "state";
                    assert(it.offset_in_bytes == 40, "ma_resampler.state has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 136, "ma_resampler.state has unexpected size % instead of 136", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 176, "ma_resampler._pHeap has unexpected offset % instead of 176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resampler._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 184, "ma_resampler._ownsHeap has unexpected offset % instead of 184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resampler._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resampler) == 192, "ma_resampler has size % instead of 192", size_of(ma_resampler));
    }

    {
        info := type_info(ma_channel_converter_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_channel_converter_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 4, "ma_channel_converter_config.channelsIn has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter_config.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 8, "ma_channel_converter_config.channelsOut has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapIn";
                    assert(it.offset_in_bytes == 16, "ma_channel_converter_config.pChannelMapIn has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter_config.pChannelMapIn has unexpected size % instead of 8", it.type.runtime_size);
                case "pChannelMapOut";
                    assert(it.offset_in_bytes == 24, "ma_channel_converter_config.pChannelMapOut has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter_config.pChannelMapOut has unexpected size % instead of 8", it.type.runtime_size);
                case "mixingMode";
                    assert(it.offset_in_bytes == 32, "ma_channel_converter_config.mixingMode has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter_config.mixingMode has unexpected size % instead of 4", it.type.runtime_size);
                case "calculateLFEFromSpatialChannels";
                    assert(it.offset_in_bytes == 36, "ma_channel_converter_config.calculateLFEFromSpatialChannels has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter_config.calculateLFEFromSpatialChannels has unexpected size % instead of 4", it.type.runtime_size);
                case "ppWeights";
                    assert(it.offset_in_bytes == 40, "ma_channel_converter_config.ppWeights has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter_config.ppWeights has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_channel_converter_config) == 48, "ma_channel_converter_config has size % instead of 48", size_of(ma_channel_converter_config));
    }

    {
        info := type_info(ma_channel_converter);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_channel_converter.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 4, "ma_channel_converter.channelsIn has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 8, "ma_channel_converter.channelsOut has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "mixingMode";
                    assert(it.offset_in_bytes == 12, "ma_channel_converter.mixingMode has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter.mixingMode has unexpected size % instead of 4", it.type.runtime_size);
                case "conversionPath";
                    assert(it.offset_in_bytes == 16, "ma_channel_converter.conversionPath has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter.conversionPath has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapIn";
                    assert(it.offset_in_bytes == 24, "ma_channel_converter.pChannelMapIn has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter.pChannelMapIn has unexpected size % instead of 8", it.type.runtime_size);
                case "pChannelMapOut";
                    assert(it.offset_in_bytes == 32, "ma_channel_converter.pChannelMapOut has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter.pChannelMapOut has unexpected size % instead of 8", it.type.runtime_size);
                case "pShuffleTable";
                    assert(it.offset_in_bytes == 40, "ma_channel_converter.pShuffleTable has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter.pShuffleTable has unexpected size % instead of 8", it.type.runtime_size);
                case "weights";
                    assert(it.offset_in_bytes == 48, "ma_channel_converter.weights has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter.weights has unexpected size % instead of 8", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 56, "ma_channel_converter._pHeap has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_channel_converter._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 64, "ma_channel_converter._ownsHeap has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_channel_converter._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_channel_converter) == 72, "ma_channel_converter has size % instead of 72", size_of(ma_channel_converter));
    }

    {
        info := type_info(ma_data_converter_config);
        for info.members {
            if it.name == {
                case "formatIn";
                    assert(it.offset_in_bytes == 0, "ma_data_converter_config.formatIn has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.formatIn has unexpected size % instead of 4", it.type.runtime_size);
                case "formatOut";
                    assert(it.offset_in_bytes == 4, "ma_data_converter_config.formatOut has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.formatOut has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 8, "ma_data_converter_config.channelsIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 12, "ma_data_converter_config.channelsOut has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateIn";
                    assert(it.offset_in_bytes == 16, "ma_data_converter_config.sampleRateIn has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.sampleRateIn has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateOut";
                    assert(it.offset_in_bytes == 20, "ma_data_converter_config.sampleRateOut has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.sampleRateOut has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMapIn";
                    assert(it.offset_in_bytes == 24, "ma_data_converter_config.pChannelMapIn has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_converter_config.pChannelMapIn has unexpected size % instead of 8", it.type.runtime_size);
                case "pChannelMapOut";
                    assert(it.offset_in_bytes == 32, "ma_data_converter_config.pChannelMapOut has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_converter_config.pChannelMapOut has unexpected size % instead of 8", it.type.runtime_size);
                case "ditherMode";
                    assert(it.offset_in_bytes == 40, "ma_data_converter_config.ditherMode has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.ditherMode has unexpected size % instead of 4", it.type.runtime_size);
                case "channelMixMode";
                    assert(it.offset_in_bytes == 44, "ma_data_converter_config.channelMixMode has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.channelMixMode has unexpected size % instead of 4", it.type.runtime_size);
                case "calculateLFEFromSpatialChannels";
                    assert(it.offset_in_bytes == 48, "ma_data_converter_config.calculateLFEFromSpatialChannels has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.calculateLFEFromSpatialChannels has unexpected size % instead of 4", it.type.runtime_size);
                case "ppChannelWeights";
                    assert(it.offset_in_bytes == 56, "ma_data_converter_config.ppChannelWeights has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_converter_config.ppChannelWeights has unexpected size % instead of 8", it.type.runtime_size);
                case "allowDynamicSampleRate";
                    assert(it.offset_in_bytes == 64, "ma_data_converter_config.allowDynamicSampleRate has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter_config.allowDynamicSampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 72, "ma_data_converter_config.resampling has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_data_converter_config.resampling has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_converter_config) == 120, "ma_data_converter_config has size % instead of 120", size_of(ma_data_converter_config));
    }

    {
        info := type_info(ma_data_converter);
        for info.members {
            if it.name == {
                case "formatIn";
                    assert(it.offset_in_bytes == 0, "ma_data_converter.formatIn has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.formatIn has unexpected size % instead of 4", it.type.runtime_size);
                case "formatOut";
                    assert(it.offset_in_bytes == 4, "ma_data_converter.formatOut has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.formatOut has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 8, "ma_data_converter.channelsIn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 12, "ma_data_converter.channelsOut has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateIn";
                    assert(it.offset_in_bytes == 16, "ma_data_converter.sampleRateIn has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.sampleRateIn has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRateOut";
                    assert(it.offset_in_bytes == 20, "ma_data_converter.sampleRateOut has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.sampleRateOut has unexpected size % instead of 4", it.type.runtime_size);
                case "ditherMode";
                    assert(it.offset_in_bytes == 24, "ma_data_converter.ditherMode has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.ditherMode has unexpected size % instead of 4", it.type.runtime_size);
                case "executionPath";
                    assert(it.offset_in_bytes == 28, "ma_data_converter.executionPath has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_converter.executionPath has unexpected size % instead of 4", it.type.runtime_size);
                case "channelConverter";
                    assert(it.offset_in_bytes == 32, "ma_data_converter.channelConverter has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_data_converter.channelConverter has unexpected size % instead of 72", it.type.runtime_size);
                case "resampler";
                    assert(it.offset_in_bytes == 104, "ma_data_converter.resampler has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 192, "ma_data_converter.resampler has unexpected size % instead of 192", it.type.runtime_size);
                case "hasPreFormatConversion";
                    assert(it.offset_in_bytes == 296, "ma_data_converter.hasPreFormatConversion has unexpected offset % instead of 296", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter.hasPreFormatConversion has unexpected size % instead of 1", it.type.runtime_size);
                case "hasPostFormatConversion";
                    assert(it.offset_in_bytes == 297, "ma_data_converter.hasPostFormatConversion has unexpected offset % instead of 297", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter.hasPostFormatConversion has unexpected size % instead of 1", it.type.runtime_size);
                case "hasChannelConverter";
                    assert(it.offset_in_bytes == 298, "ma_data_converter.hasChannelConverter has unexpected offset % instead of 298", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter.hasChannelConverter has unexpected size % instead of 1", it.type.runtime_size);
                case "hasResampler";
                    assert(it.offset_in_bytes == 299, "ma_data_converter.hasResampler has unexpected offset % instead of 299", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter.hasResampler has unexpected size % instead of 1", it.type.runtime_size);
                case "isPassthrough";
                    assert(it.offset_in_bytes == 300, "ma_data_converter.isPassthrough has unexpected offset % instead of 300", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter.isPassthrough has unexpected size % instead of 1", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 301, "ma_data_converter._ownsHeap has unexpected offset % instead of 301", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_data_converter._ownsHeap has unexpected size % instead of 1", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 304, "ma_data_converter._pHeap has unexpected offset % instead of 304", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_converter._pHeap has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_converter) == 312, "ma_data_converter has size % instead of 312", size_of(ma_data_converter));
    }

    {
        info := type_info(ma_data_source_vtable);
        for info.members {
            if it.name == {
                case "onRead";
                    assert(it.offset_in_bytes == 0, "ma_data_source_vtable.onRead has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onRead has unexpected size % instead of 8", it.type.runtime_size);
                case "onSeek";
                    assert(it.offset_in_bytes == 8, "ma_data_source_vtable.onSeek has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onSeek has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetDataFormat";
                    assert(it.offset_in_bytes == 16, "ma_data_source_vtable.onGetDataFormat has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onGetDataFormat has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetCursor";
                    assert(it.offset_in_bytes == 24, "ma_data_source_vtable.onGetCursor has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onGetCursor has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetLength";
                    assert(it.offset_in_bytes == 32, "ma_data_source_vtable.onGetLength has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onGetLength has unexpected size % instead of 8", it.type.runtime_size);
                case "onSetLooping";
                    assert(it.offset_in_bytes == 40, "ma_data_source_vtable.onSetLooping has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_vtable.onSetLooping has unexpected size % instead of 8", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 48, "ma_data_source_vtable.flags has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_source_vtable.flags has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_source_vtable) == 56, "ma_data_source_vtable has size % instead of 56", size_of(ma_data_source_vtable));
    }

    {
        info := type_info(ma_data_source_config);
        for info.members {
            if it.name == {
                case "vtable";
                    assert(it.offset_in_bytes == 0, "ma_data_source_config.vtable has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_config.vtable has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_source_config) == 8, "ma_data_source_config has size % instead of 8", size_of(ma_data_source_config));
    }

    {
        info := type_info(ma_data_source_base);
        for info.members {
            if it.name == {
                case "vtable";
                    assert(it.offset_in_bytes == 0, "ma_data_source_base.vtable has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.vtable has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeBegInFrames";
                    assert(it.offset_in_bytes == 8, "ma_data_source_base.rangeBegInFrames has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.rangeBegInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeEndInFrames";
                    assert(it.offset_in_bytes == 16, "ma_data_source_base.rangeEndInFrames has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.rangeEndInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopBegInFrames";
                    assert(it.offset_in_bytes == 24, "ma_data_source_base.loopBegInFrames has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.loopBegInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopEndInFrames";
                    assert(it.offset_in_bytes == 32, "ma_data_source_base.loopEndInFrames has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.loopEndInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "pCurrent";
                    assert(it.offset_in_bytes == 40, "ma_data_source_base.pCurrent has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.pCurrent has unexpected size % instead of 8", it.type.runtime_size);
                case "pNext";
                    assert(it.offset_in_bytes == 48, "ma_data_source_base.pNext has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.pNext has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetNext";
                    assert(it.offset_in_bytes == 56, "ma_data_source_base.onGetNext has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_base.onGetNext has unexpected size % instead of 8", it.type.runtime_size);
                case "isLooping";
                    assert(it.offset_in_bytes == 64, "ma_data_source_base.isLooping has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_data_source_base.isLooping has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_source_base) == 72, "ma_data_source_base has size % instead of 72", size_of(ma_data_source_base));
    }

    {
        info := type_info(ma_audio_buffer_ref);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_audio_buffer_ref.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_audio_buffer_ref.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 72, "ma_audio_buffer_ref.format has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_ref.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 76, "ma_audio_buffer_ref.channels has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_ref.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 80, "ma_audio_buffer_ref.sampleRate has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_ref.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "cursor";
                    assert(it.offset_in_bytes == 88, "ma_audio_buffer_ref.cursor has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_audio_buffer_ref.cursor has unexpected size % instead of 8", it.type.runtime_size);
                case "sizeInFrames";
                    assert(it.offset_in_bytes == 96, "ma_audio_buffer_ref.sizeInFrames has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_audio_buffer_ref.sizeInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "pData";
                    assert(it.offset_in_bytes == 104, "ma_audio_buffer_ref.pData has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_audio_buffer_ref.pData has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_audio_buffer_ref) == 112, "ma_audio_buffer_ref has size % instead of 112", size_of(ma_audio_buffer_ref));
    }

    {
        info := type_info(ma_audio_buffer_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_audio_buffer_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_audio_buffer_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_audio_buffer_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "sizeInFrames";
                    assert(it.offset_in_bytes == 16, "ma_audio_buffer_config.sizeInFrames has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_audio_buffer_config.sizeInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "pData";
                    assert(it.offset_in_bytes == 24, "ma_audio_buffer_config.pData has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_audio_buffer_config.pData has unexpected size % instead of 8", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 32, "ma_audio_buffer_config.allocationCallbacks has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_audio_buffer_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_audio_buffer_config) == 64, "ma_audio_buffer_config has size % instead of 64", size_of(ma_audio_buffer_config));
    }

    {
        info := type_info(ma_audio_buffer);
        for info.members {
            if it.name == {
                case "ref";
                    assert(it.offset_in_bytes == 0, "ma_audio_buffer.ref has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "ma_audio_buffer.ref has unexpected size % instead of 112", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 112, "ma_audio_buffer.allocationCallbacks has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_audio_buffer.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "ownsData";
                    assert(it.offset_in_bytes == 144, "ma_audio_buffer.ownsData has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_audio_buffer.ownsData has unexpected size % instead of 4", it.type.runtime_size);
                case "_pExtraData";
                    assert(it.offset_in_bytes == 148, "ma_audio_buffer._pExtraData has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_audio_buffer._pExtraData has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(ma_audio_buffer) == 152, "ma_audio_buffer has size % instead of 152", size_of(ma_audio_buffer));
    }

    {
        info := type_info(ma_paged_audio_buffer_page);
        for info.members {
            if it.name == {
                case "pNext";
                    assert(it.offset_in_bytes == 0, "ma_paged_audio_buffer_page.pNext has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer_page.pNext has unexpected size % instead of 8", it.type.runtime_size);
                case "sizeInFrames";
                    assert(it.offset_in_bytes == 8, "ma_paged_audio_buffer_page.sizeInFrames has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer_page.sizeInFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "pAudioData";
                    assert(it.offset_in_bytes == 16, "ma_paged_audio_buffer_page.pAudioData has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_paged_audio_buffer_page.pAudioData has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(ma_paged_audio_buffer_page) == 24, "ma_paged_audio_buffer_page has size % instead of 24", size_of(ma_paged_audio_buffer_page));
    }

    {
        info := type_info(ma_paged_audio_buffer_data);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_paged_audio_buffer_data.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_paged_audio_buffer_data.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_paged_audio_buffer_data.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_paged_audio_buffer_data.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "head";
                    assert(it.offset_in_bytes == 8, "ma_paged_audio_buffer_data.head has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_paged_audio_buffer_data.head has unexpected size % instead of 24", it.type.runtime_size);
                case "pTail";
                    assert(it.offset_in_bytes == 32, "ma_paged_audio_buffer_data.pTail has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer_data.pTail has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_paged_audio_buffer_data) == 40, "ma_paged_audio_buffer_data has size % instead of 40", size_of(ma_paged_audio_buffer_data));
    }

    {
        info := type_info(ma_paged_audio_buffer_config);
        for info.members {
            if it.name == {
                case "pData";
                    assert(it.offset_in_bytes == 0, "ma_paged_audio_buffer_config.pData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer_config.pData has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_paged_audio_buffer_config) == 8, "ma_paged_audio_buffer_config has size % instead of 8", size_of(ma_paged_audio_buffer_config));
    }

    {
        info := type_info(ma_paged_audio_buffer);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_paged_audio_buffer.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_paged_audio_buffer.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "pData";
                    assert(it.offset_in_bytes == 72, "ma_paged_audio_buffer.pData has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer.pData has unexpected size % instead of 8", it.type.runtime_size);
                case "pCurrent";
                    assert(it.offset_in_bytes == 80, "ma_paged_audio_buffer.pCurrent has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer.pCurrent has unexpected size % instead of 8", it.type.runtime_size);
                case "relativeCursor";
                    assert(it.offset_in_bytes == 88, "ma_paged_audio_buffer.relativeCursor has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer.relativeCursor has unexpected size % instead of 8", it.type.runtime_size);
                case "absoluteCursor";
                    assert(it.offset_in_bytes == 96, "ma_paged_audio_buffer.absoluteCursor has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_paged_audio_buffer.absoluteCursor has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_paged_audio_buffer) == 104, "ma_paged_audio_buffer has size % instead of 104", size_of(ma_paged_audio_buffer));
    }

    {
        info := type_info(ma_rb);
        for info.members {
            if it.name == {
                case "pBuffer";
                    assert(it.offset_in_bytes == 0, "ma_rb.pBuffer has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_rb.pBuffer has unexpected size % instead of 8", it.type.runtime_size);
                case "subbufferSizeInBytes";
                    assert(it.offset_in_bytes == 8, "ma_rb.subbufferSizeInBytes has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_rb.subbufferSizeInBytes has unexpected size % instead of 4", it.type.runtime_size);
                case "subbufferCount";
                    assert(it.offset_in_bytes == 12, "ma_rb.subbufferCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_rb.subbufferCount has unexpected size % instead of 4", it.type.runtime_size);
                case "subbufferStrideInBytes";
                    assert(it.offset_in_bytes == 16, "ma_rb.subbufferStrideInBytes has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_rb.subbufferStrideInBytes has unexpected size % instead of 4", it.type.runtime_size);
                case "encodedReadOffset";
                    assert(it.offset_in_bytes == 20, "ma_rb.encodedReadOffset has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_rb.encodedReadOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "encodedWriteOffset";
                    assert(it.offset_in_bytes == 24, "ma_rb.encodedWriteOffset has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_rb.encodedWriteOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "ownsBuffer";
                    assert(it.offset_in_bytes == 28, "ma_rb.ownsBuffer has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_rb.ownsBuffer has unexpected size % instead of 1", it.type.runtime_size);
                case "clearOnWriteAcquire";
                    assert(it.offset_in_bytes == 29, "ma_rb.clearOnWriteAcquire has unexpected offset % instead of 29", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_rb.clearOnWriteAcquire has unexpected size % instead of 1", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 32, "ma_rb.allocationCallbacks has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_rb.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_rb) == 64, "ma_rb has size % instead of 64", size_of(ma_rb));
    }

    {
        info := type_info(ma_pcm_rb);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_pcm_rb.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_pcm_rb.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "rb";
                    assert(it.offset_in_bytes == 72, "ma_pcm_rb.rb has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_pcm_rb.rb has unexpected size % instead of 64", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 136, "ma_pcm_rb.format has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pcm_rb.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 140, "ma_pcm_rb.channels has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pcm_rb.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 144, "ma_pcm_rb.sampleRate has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pcm_rb.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_pcm_rb) == 152, "ma_pcm_rb has size % instead of 152", size_of(ma_pcm_rb));
    }

    {
        info := type_info(ma_duplex_rb);
        for info.members {
            if it.name == {
                case "rb";
                    assert(it.offset_in_bytes == 0, "ma_duplex_rb.rb has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 152, "ma_duplex_rb.rb has unexpected size % instead of 152", it.type.runtime_size);
            }
        }
        assert(size_of(ma_duplex_rb) == 152, "ma_duplex_rb has size % instead of 152", size_of(ma_duplex_rb));
    }

    {
        info := type_info(ma_fence);
        for info.members {
            if it.name == {
                case "e";
                    assert(it.offset_in_bytes == 0, "ma_fence.e has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_fence.e has unexpected size % instead of 96", it.type.runtime_size);
                case "counter";
                    assert(it.offset_in_bytes == 96, "ma_fence.counter has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_fence.counter has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_fence) == 104, "ma_fence has size % instead of 104", size_of(ma_fence));
    }

    {
        info := type_info(ma_async_notification_callbacks);
        for info.members {
            if it.name == {
                case "onSignal";
                    assert(it.offset_in_bytes == 0, "ma_async_notification_callbacks.onSignal has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_async_notification_callbacks.onSignal has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_async_notification_callbacks) == 8, "ma_async_notification_callbacks has size % instead of 8", size_of(ma_async_notification_callbacks));
    }

    {
        info := type_info(ma_async_notification_poll);
        for info.members {
            if it.name == {
                case "cb";
                    assert(it.offset_in_bytes == 0, "ma_async_notification_poll.cb has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_async_notification_poll.cb has unexpected size % instead of 8", it.type.runtime_size);
                case "signalled";
                    assert(it.offset_in_bytes == 8, "ma_async_notification_poll.signalled has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_async_notification_poll.signalled has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_async_notification_poll) == 16, "ma_async_notification_poll has size % instead of 16", size_of(ma_async_notification_poll));
    }

    {
        info := type_info(ma_async_notification_event);
        for info.members {
            if it.name == {
                case "cb";
                    assert(it.offset_in_bytes == 0, "ma_async_notification_event.cb has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_async_notification_event.cb has unexpected size % instead of 8", it.type.runtime_size);
                case "e";
                    assert(it.offset_in_bytes == 8, "ma_async_notification_event.e has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_async_notification_event.e has unexpected size % instead of 96", it.type.runtime_size);
            }
        }
        assert(size_of(ma_async_notification_event) == 104, "ma_async_notification_event has size % instead of 104", size_of(ma_async_notification_event));
    }

    {
        info := type_info(ma_slot_allocator_config);
        for info.members {
            if it.name == {
                case "capacity";
                    assert(it.offset_in_bytes == 0, "ma_slot_allocator_config.capacity has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_slot_allocator_config.capacity has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_slot_allocator_config) == 4, "ma_slot_allocator_config has size % instead of 4", size_of(ma_slot_allocator_config));
    }

    {
        info := type_info(ma_slot_allocator_group);
        for info.members {
            if it.name == {
                case "bitfield";
                    assert(it.offset_in_bytes == 0, "ma_slot_allocator_group.bitfield has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_slot_allocator_group.bitfield has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_slot_allocator_group) == 4, "ma_slot_allocator_group has size % instead of 4", size_of(ma_slot_allocator_group));
    }

    {
        info := type_info(ma_slot_allocator);
        for info.members {
            if it.name == {
                case "pGroups";
                    assert(it.offset_in_bytes == 0, "ma_slot_allocator.pGroups has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_slot_allocator.pGroups has unexpected size % instead of 8", it.type.runtime_size);
                case "pSlots";
                    assert(it.offset_in_bytes == 8, "ma_slot_allocator.pSlots has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_slot_allocator.pSlots has unexpected size % instead of 8", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 16, "ma_slot_allocator.count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_slot_allocator.count has unexpected size % instead of 4", it.type.runtime_size);
                case "capacity";
                    assert(it.offset_in_bytes == 20, "ma_slot_allocator.capacity has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_slot_allocator.capacity has unexpected size % instead of 4", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 24, "ma_slot_allocator._ownsHeap has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_slot_allocator._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 32, "ma_slot_allocator._pHeap has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_slot_allocator._pHeap has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_slot_allocator) == 40, "ma_slot_allocator has size % instead of 40", size_of(ma_slot_allocator));
    }

    {
        info := type_info(ma_job);
        for info.members {
            if it.name == {
                case "toc";
                    assert(it.offset_in_bytes == 0, "ma_job.toc has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job.toc has unexpected size % instead of 8", it.type.runtime_size);
                case "next";
                    assert(it.offset_in_bytes == 8, "ma_job.next has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job.next has unexpected size % instead of 8", it.type.runtime_size);
                case "order";
                    assert(it.offset_in_bytes == 16, "ma_job.order has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job.order has unexpected size % instead of 4", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 24, "ma_job.data has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 80, "ma_job.data has unexpected size % instead of 80", it.type.runtime_size);
            }
        }
        assert(size_of(ma_job) == 104, "ma_job has size % instead of 104", size_of(ma_job));
    }

    {
        info := type_info(ma_job_queue_config);
        for info.members {
            if it.name == {
                case "flags";
                    assert(it.offset_in_bytes == 0, "ma_job_queue_config.flags has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue_config.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "capacity";
                    assert(it.offset_in_bytes == 4, "ma_job_queue_config.capacity has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue_config.capacity has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_job_queue_config) == 8, "ma_job_queue_config has size % instead of 8", size_of(ma_job_queue_config));
    }

    {
        info := type_info(ma_job_queue);
        for info.members {
            if it.name == {
                case "flags";
                    assert(it.offset_in_bytes == 0, "ma_job_queue.flags has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "capacity";
                    assert(it.offset_in_bytes == 4, "ma_job_queue.capacity has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue.capacity has unexpected size % instead of 4", it.type.runtime_size);
                case "head";
                    assert(it.offset_in_bytes == 8, "ma_job_queue.head has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job_queue.head has unexpected size % instead of 8", it.type.runtime_size);
                case "tail";
                    assert(it.offset_in_bytes == 16, "ma_job_queue.tail has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job_queue.tail has unexpected size % instead of 8", it.type.runtime_size);
                case "sem";
                    assert(it.offset_in_bytes == 24, "ma_job_queue.sem has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_job_queue.sem has unexpected size % instead of 96", it.type.runtime_size);
                case "allocator";
                    assert(it.offset_in_bytes == 120, "ma_job_queue.allocator has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_job_queue.allocator has unexpected size % instead of 40", it.type.runtime_size);
                case "pJobs";
                    assert(it.offset_in_bytes == 160, "ma_job_queue.pJobs has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job_queue.pJobs has unexpected size % instead of 8", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 168, "ma_job_queue.lock has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue.lock has unexpected size % instead of 4", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 176, "ma_job_queue._pHeap has unexpected offset % instead of 176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_job_queue._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 184, "ma_job_queue._ownsHeap has unexpected offset % instead of 184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_job_queue._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_job_queue) == 192, "ma_job_queue has size % instead of 192", size_of(ma_job_queue));
    }

    {
        info := type_info(ma_atomic_device_state);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "ma_atomic_device_state.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_atomic_device_state.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_atomic_device_state) == 4, "ma_atomic_device_state has size % instead of 4", size_of(ma_atomic_device_state));
    }

    {
        info := type_info(ma_device_job_thread_config);
        for info.members {
            if it.name == {
                case "noThread";
                    assert(it.offset_in_bytes == 0, "ma_device_job_thread_config.noThread has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_job_thread_config.noThread has unexpected size % instead of 4", it.type.runtime_size);
                case "jobQueueCapacity";
                    assert(it.offset_in_bytes == 4, "ma_device_job_thread_config.jobQueueCapacity has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_job_thread_config.jobQueueCapacity has unexpected size % instead of 4", it.type.runtime_size);
                case "jobQueueFlags";
                    assert(it.offset_in_bytes == 8, "ma_device_job_thread_config.jobQueueFlags has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_job_thread_config.jobQueueFlags has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_job_thread_config) == 12, "ma_device_job_thread_config has size % instead of 12", size_of(ma_device_job_thread_config));
    }

    {
        info := type_info(ma_device_job_thread);
        for info.members {
            if it.name == {
                case "thread";
                    assert(it.offset_in_bytes == 0, "ma_device_job_thread.thread has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_job_thread.thread has unexpected size % instead of 8", it.type.runtime_size);
                case "jobQueue";
                    assert(it.offset_in_bytes == 8, "ma_device_job_thread.jobQueue has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 192, "ma_device_job_thread.jobQueue has unexpected size % instead of 192", it.type.runtime_size);
                case "_hasThread";
                    assert(it.offset_in_bytes == 200, "ma_device_job_thread._hasThread has unexpected offset % instead of 200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_job_thread._hasThread has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_job_thread) == 208, "ma_device_job_thread has size % instead of 208", size_of(ma_device_job_thread));
    }

    {
        info := type_info(ma_device_notification);
        for info.members {
            if it.name == {
                case "pDevice";
                    assert(it.offset_in_bytes == 0, "ma_device_notification.pDevice has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_notification.pDevice has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "ma_device_notification.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_notification.type has unexpected size % instead of 4", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 12, "ma_device_notification.data has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_notification.data has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_notification) == 16, "ma_device_notification has size % instead of 16", size_of(ma_device_notification));
    }

    {
        info := type_info(ma_timer);
        for info.members {
            if it.name == {
                case "counter";
                    assert(it.offset_in_bytes == 0, "ma_timer.counter has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_timer.counter has unexpected size % instead of 8", it.type.runtime_size);
                case "counterD";
                    assert(it.offset_in_bytes == 0, "ma_timer.counterD has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_timer.counterD has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_timer) == 8, "ma_timer has size % instead of 8", size_of(ma_timer));
    }

    {
        info := type_info(ma_device_id);
        for info.members {
            if it.name == {
                case "alsa";
                    assert(it.offset_in_bytes == 0, "ma_device_id.alsa has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.alsa has unexpected size % instead of 256", it.type.runtime_size);
                case "wasapi";
                    assert(it.offset_in_bytes == 0, "ma_device_id.wasapi has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 128, "ma_device_id.wasapi has unexpected size % instead of 128", it.type.runtime_size);
                case "dsound";
                    assert(it.offset_in_bytes == 0, "ma_device_id.dsound has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_device_id.dsound has unexpected size % instead of 16", it.type.runtime_size);
                case "winmm";
                    assert(it.offset_in_bytes == 0, "ma_device_id.winmm has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_id.winmm has unexpected size % instead of 4", it.type.runtime_size);
                case "pulse";
                    assert(it.offset_in_bytes == 0, "ma_device_id.pulse has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.pulse has unexpected size % instead of 256", it.type.runtime_size);
                case "jack";
                    assert(it.offset_in_bytes == 0, "ma_device_id.jack has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_id.jack has unexpected size % instead of 4", it.type.runtime_size);
                case "coreaudio";
                    assert(it.offset_in_bytes == 0, "ma_device_id.coreaudio has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.coreaudio has unexpected size % instead of 256", it.type.runtime_size);
                case "sndio";
                    assert(it.offset_in_bytes == 0, "ma_device_id.sndio has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.sndio has unexpected size % instead of 256", it.type.runtime_size);
                case "audio4";
                    assert(it.offset_in_bytes == 0, "ma_device_id.audio4 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.audio4 has unexpected size % instead of 256", it.type.runtime_size);
                case "oss";
                    assert(it.offset_in_bytes == 0, "ma_device_id.oss has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_device_id.oss has unexpected size % instead of 64", it.type.runtime_size);
                case "aaudio";
                    assert(it.offset_in_bytes == 0, "ma_device_id.aaudio has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_id.aaudio has unexpected size % instead of 4", it.type.runtime_size);
                case "opensl";
                    assert(it.offset_in_bytes == 0, "ma_device_id.opensl has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_id.opensl has unexpected size % instead of 4", it.type.runtime_size);
                case "webaudio";
                    assert(it.offset_in_bytes == 0, "ma_device_id.webaudio has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_device_id.webaudio has unexpected size % instead of 32", it.type.runtime_size);
                case "custom";
                    assert(it.offset_in_bytes == 0, "ma_device_id.custom has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_id.custom has unexpected size % instead of 256", it.type.runtime_size);
                case "nullbackend";
                    assert(it.offset_in_bytes == 0, "ma_device_id.nullbackend has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_id.nullbackend has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_id) == 256, "ma_device_id has size % instead of 256", size_of(ma_device_id));
    }

    {
        info := type_info(ma_device_info);
        for info.members {
            if it.name == {
                case "id";
                    assert(it.offset_in_bytes == 0, "ma_device_info.id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_info.id has unexpected size % instead of 256", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 256, "ma_device_info.name has unexpected offset % instead of 256", it.offset_in_bytes);
                    assert(it.type.runtime_size == 256, "ma_device_info.name has unexpected size % instead of 256", it.type.runtime_size);
                case "isDefault";
                    assert(it.offset_in_bytes == 512, "ma_device_info.isDefault has unexpected offset % instead of 512", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_info.isDefault has unexpected size % instead of 4", it.type.runtime_size);
                case "nativeDataFormatCount";
                    assert(it.offset_in_bytes == 516, "ma_device_info.nativeDataFormatCount has unexpected offset % instead of 516", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_info.nativeDataFormatCount has unexpected size % instead of 4", it.type.runtime_size);
                case "nativeDataFormats";
                    assert(it.offset_in_bytes == 520, "ma_device_info.nativeDataFormats has unexpected offset % instead of 520", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1024, "ma_device_info.nativeDataFormats has unexpected size % instead of 1024", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_info) == 1544, "ma_device_info has size % instead of 1544", size_of(ma_device_info));
    }

    {
        info := type_info(ma_device_config);
        for info.members {
            if it.name == {
                case "deviceType";
                    assert(it.offset_in_bytes == 0, "ma_device_config.deviceType has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.deviceType has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 4, "ma_device_config.sampleRate has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "periodSizeInFrames";
                    assert(it.offset_in_bytes == 8, "ma_device_config.periodSizeInFrames has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.periodSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "periodSizeInMilliseconds";
                    assert(it.offset_in_bytes == 12, "ma_device_config.periodSizeInMilliseconds has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.periodSizeInMilliseconds has unexpected size % instead of 4", it.type.runtime_size);
                case "periods";
                    assert(it.offset_in_bytes == 16, "ma_device_config.periods has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.periods has unexpected size % instead of 4", it.type.runtime_size);
                case "performanceProfile";
                    assert(it.offset_in_bytes == 20, "ma_device_config.performanceProfile has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.performanceProfile has unexpected size % instead of 4", it.type.runtime_size);
                case "noPreSilencedOutputBuffer";
                    assert(it.offset_in_bytes == 24, "ma_device_config.noPreSilencedOutputBuffer has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device_config.noPreSilencedOutputBuffer has unexpected size % instead of 1", it.type.runtime_size);
                case "noClip";
                    assert(it.offset_in_bytes == 25, "ma_device_config.noClip has unexpected offset % instead of 25", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device_config.noClip has unexpected size % instead of 1", it.type.runtime_size);
                case "noDisableDenormals";
                    assert(it.offset_in_bytes == 26, "ma_device_config.noDisableDenormals has unexpected offset % instead of 26", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device_config.noDisableDenormals has unexpected size % instead of 1", it.type.runtime_size);
                case "noFixedSizedCallback";
                    assert(it.offset_in_bytes == 27, "ma_device_config.noFixedSizedCallback has unexpected offset % instead of 27", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device_config.noFixedSizedCallback has unexpected size % instead of 1", it.type.runtime_size);
                case "dataCallback";
                    assert(it.offset_in_bytes == 32, "ma_device_config.dataCallback has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_config.dataCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "notificationCallback";
                    assert(it.offset_in_bytes == 40, "ma_device_config.notificationCallback has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_config.notificationCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "stopCallback";
                    assert(it.offset_in_bytes == 48, "ma_device_config.stopCallback has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_config.stopCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 56, "ma_device_config.pUserData has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_config.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 64, "ma_device_config.resampling has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_device_config.resampling has unexpected size % instead of 48", it.type.runtime_size);
                case "playback";
                    assert(it.offset_in_bytes == 112, "ma_device_config.playback has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_device_config.playback has unexpected size % instead of 40", it.type.runtime_size);
                case "capture";
                    assert(it.offset_in_bytes == 152, "ma_device_config.capture has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_device_config.capture has unexpected size % instead of 40", it.type.runtime_size);
                case "wasapi";
                    assert(it.offset_in_bytes == 192, "ma_device_config.wasapi has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_device_config.wasapi has unexpected size % instead of 16", it.type.runtime_size);
                case "alsa";
                    assert(it.offset_in_bytes == 208, "ma_device_config.alsa has unexpected offset % instead of 208", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_device_config.alsa has unexpected size % instead of 16", it.type.runtime_size);
                case "pulse";
                    assert(it.offset_in_bytes == 224, "ma_device_config.pulse has unexpected offset % instead of 224", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_device_config.pulse has unexpected size % instead of 24", it.type.runtime_size);
                case "coreaudio";
                    assert(it.offset_in_bytes == 248, "ma_device_config.coreaudio has unexpected offset % instead of 248", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_config.coreaudio has unexpected size % instead of 4", it.type.runtime_size);
                case "opensl";
                    assert(it.offset_in_bytes == 252, "ma_device_config.opensl has unexpected offset % instead of 252", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "ma_device_config.opensl has unexpected size % instead of 12", it.type.runtime_size);
                case "aaudio";
                    assert(it.offset_in_bytes == 264, "ma_device_config.aaudio has unexpected offset % instead of 264", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "ma_device_config.aaudio has unexpected size % instead of 28", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_config) == 296, "ma_device_config has size % instead of 296", size_of(ma_device_config));
    }

    {
        info := type_info(ma_device_descriptor);
        for info.members {
            if it.name == {
                case "pDeviceID";
                    assert(it.offset_in_bytes == 0, "ma_device_descriptor.pDeviceID has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device_descriptor.pDeviceID has unexpected size % instead of 8", it.type.runtime_size);
                case "shareMode";
                    assert(it.offset_in_bytes == 8, "ma_device_descriptor.shareMode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.shareMode has unexpected size % instead of 4", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 12, "ma_device_descriptor.format has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 16, "ma_device_descriptor.channels has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 20, "ma_device_descriptor.sampleRate has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "channelMap";
                    assert(it.offset_in_bytes == 24, "ma_device_descriptor.channelMap has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 254, "ma_device_descriptor.channelMap has unexpected size % instead of 254", it.type.runtime_size);
                case "periodSizeInFrames";
                    assert(it.offset_in_bytes == 280, "ma_device_descriptor.periodSizeInFrames has unexpected offset % instead of 280", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.periodSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "periodSizeInMilliseconds";
                    assert(it.offset_in_bytes == 284, "ma_device_descriptor.periodSizeInMilliseconds has unexpected offset % instead of 284", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.periodSizeInMilliseconds has unexpected size % instead of 4", it.type.runtime_size);
                case "periodCount";
                    assert(it.offset_in_bytes == 288, "ma_device_descriptor.periodCount has unexpected offset % instead of 288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device_descriptor.periodCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device_descriptor) == 296, "ma_device_descriptor has size % instead of 296", size_of(ma_device_descriptor));
    }

    {
        info := type_info(ma_backend_callbacks);
        for info.members {
            if it.name == {
                case "onContextInit";
                    assert(it.offset_in_bytes == 0, "ma_backend_callbacks.onContextInit has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onContextInit has unexpected size % instead of 8", it.type.runtime_size);
                case "onContextUninit";
                    assert(it.offset_in_bytes == 8, "ma_backend_callbacks.onContextUninit has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onContextUninit has unexpected size % instead of 8", it.type.runtime_size);
                case "onContextEnumerateDevices";
                    assert(it.offset_in_bytes == 16, "ma_backend_callbacks.onContextEnumerateDevices has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onContextEnumerateDevices has unexpected size % instead of 8", it.type.runtime_size);
                case "onContextGetDeviceInfo";
                    assert(it.offset_in_bytes == 24, "ma_backend_callbacks.onContextGetDeviceInfo has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onContextGetDeviceInfo has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceInit";
                    assert(it.offset_in_bytes == 32, "ma_backend_callbacks.onDeviceInit has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceInit has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceUninit";
                    assert(it.offset_in_bytes == 40, "ma_backend_callbacks.onDeviceUninit has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceUninit has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceStart";
                    assert(it.offset_in_bytes == 48, "ma_backend_callbacks.onDeviceStart has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceStart has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceStop";
                    assert(it.offset_in_bytes == 56, "ma_backend_callbacks.onDeviceStop has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceStop has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceRead";
                    assert(it.offset_in_bytes == 64, "ma_backend_callbacks.onDeviceRead has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceRead has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceWrite";
                    assert(it.offset_in_bytes == 72, "ma_backend_callbacks.onDeviceWrite has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceWrite has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceDataLoop";
                    assert(it.offset_in_bytes == 80, "ma_backend_callbacks.onDeviceDataLoop has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceDataLoop has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceDataLoopWakeup";
                    assert(it.offset_in_bytes == 88, "ma_backend_callbacks.onDeviceDataLoopWakeup has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceDataLoopWakeup has unexpected size % instead of 8", it.type.runtime_size);
                case "onDeviceGetInfo";
                    assert(it.offset_in_bytes == 96, "ma_backend_callbacks.onDeviceGetInfo has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_backend_callbacks.onDeviceGetInfo has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_backend_callbacks) == 104, "ma_backend_callbacks has size % instead of 104", size_of(ma_backend_callbacks));
    }

    {
        info := type_info(ma_context_config);
        for info.members {
            if it.name == {
                case "pLog";
                    assert(it.offset_in_bytes == 0, "ma_context_config.pLog has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context_config.pLog has unexpected size % instead of 8", it.type.runtime_size);
                case "threadPriority";
                    assert(it.offset_in_bytes == 8, "ma_context_config.threadPriority has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context_config.threadPriority has unexpected size % instead of 4", it.type.runtime_size);
                case "threadStackSize";
                    assert(it.offset_in_bytes == 16, "ma_context_config.threadStackSize has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context_config.threadStackSize has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 24, "ma_context_config.pUserData has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context_config.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 32, "ma_context_config.allocationCallbacks has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_context_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "dsound";
                    assert(it.offset_in_bytes == 64, "ma_context_config.dsound has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context_config.dsound has unexpected size % instead of 8", it.type.runtime_size);
                case "alsa";
                    assert(it.offset_in_bytes == 72, "ma_context_config.alsa has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context_config.alsa has unexpected size % instead of 4", it.type.runtime_size);
                case "pulse";
                    assert(it.offset_in_bytes == 80, "ma_context_config.pulse has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_context_config.pulse has unexpected size % instead of 24", it.type.runtime_size);
                case "coreaudio";
                    assert(it.offset_in_bytes == 104, "ma_context_config.coreaudio has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_context_config.coreaudio has unexpected size % instead of 16", it.type.runtime_size);
                case "jack";
                    assert(it.offset_in_bytes == 120, "ma_context_config.jack has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_context_config.jack has unexpected size % instead of 16", it.type.runtime_size);
                case "custom";
                    assert(it.offset_in_bytes == 136, "ma_context_config.custom has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 104, "ma_context_config.custom has unexpected size % instead of 104", it.type.runtime_size);
            }
        }
        assert(size_of(ma_context_config) == 240, "ma_context_config has size % instead of 240", size_of(ma_context_config));
    }

    {
        info := type_info(ma_context_command__wasapi);
        for info.members {
            if it.name == {
                case "code";
                    assert(it.offset_in_bytes == 0, "ma_context_command__wasapi.code has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context_command__wasapi.code has unexpected size % instead of 4", it.type.runtime_size);
                case "pEvent";
                    assert(it.offset_in_bytes == 8, "ma_context_command__wasapi.pEvent has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context_command__wasapi.pEvent has unexpected size % instead of 8", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 16, "ma_context_command__wasapi.data has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_context_command__wasapi.data has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_context_command__wasapi) == 48, "ma_context_command__wasapi has size % instead of 48", size_of(ma_context_command__wasapi));
    }

    {
        info := type_info(ma_context);
        for info.members {
            if it.name == {
                case "callbacks";
                    assert(it.offset_in_bytes == 0, "ma_context.callbacks has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 104, "ma_context.callbacks has unexpected size % instead of 104", it.type.runtime_size);
                case "backend";
                    assert(it.offset_in_bytes == 104, "ma_context.backend has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context.backend has unexpected size % instead of 4", it.type.runtime_size);
                case "pLog";
                    assert(it.offset_in_bytes == 112, "ma_context.pLog has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context.pLog has unexpected size % instead of 8", it.type.runtime_size);
                case "log";
                    assert(it.offset_in_bytes == 120, "ma_context.log has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 144, "ma_context.log has unexpected size % instead of 144", it.type.runtime_size);
                case "threadPriority";
                    assert(it.offset_in_bytes == 264, "ma_context.threadPriority has unexpected offset % instead of 264", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context.threadPriority has unexpected size % instead of 4", it.type.runtime_size);
                case "threadStackSize";
                    assert(it.offset_in_bytes == 272, "ma_context.threadStackSize has unexpected offset % instead of 272", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context.threadStackSize has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 280, "ma_context.pUserData has unexpected offset % instead of 280", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 288, "ma_context.allocationCallbacks has unexpected offset % instead of 288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_context.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "deviceEnumLock";
                    assert(it.offset_in_bytes == 320, "ma_context.deviceEnumLock has unexpected offset % instead of 320", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_context.deviceEnumLock has unexpected size % instead of 40", it.type.runtime_size);
                case "deviceInfoLock";
                    assert(it.offset_in_bytes == 360, "ma_context.deviceInfoLock has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_context.deviceInfoLock has unexpected size % instead of 40", it.type.runtime_size);
                case "deviceInfoCapacity";
                    assert(it.offset_in_bytes == 400, "ma_context.deviceInfoCapacity has unexpected offset % instead of 400", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context.deviceInfoCapacity has unexpected size % instead of 4", it.type.runtime_size);
                case "playbackDeviceInfoCount";
                    assert(it.offset_in_bytes == 404, "ma_context.playbackDeviceInfoCount has unexpected offset % instead of 404", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context.playbackDeviceInfoCount has unexpected size % instead of 4", it.type.runtime_size);
                case "captureDeviceInfoCount";
                    assert(it.offset_in_bytes == 408, "ma_context.captureDeviceInfoCount has unexpected offset % instead of 408", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_context.captureDeviceInfoCount has unexpected size % instead of 4", it.type.runtime_size);
                case "pDeviceInfos";
                    assert(it.offset_in_bytes == 416, "ma_context.pDeviceInfos has unexpected offset % instead of 416", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_context.pDeviceInfos has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_context) == 1024, "ma_context has size % instead of 1024", size_of(ma_context));
    }

    {
        info := type_info(ma_device);
        for info.members {
            if it.name == {
                case "pContext";
                    assert(it.offset_in_bytes == 0, "ma_device.pContext has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.pContext has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "ma_device.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device.type has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 12, "ma_device.sampleRate has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "state";
                    assert(it.offset_in_bytes == 16, "ma_device.state has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device.state has unexpected size % instead of 4", it.type.runtime_size);
                case "onData";
                    assert(it.offset_in_bytes == 24, "ma_device.onData has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.onData has unexpected size % instead of 8", it.type.runtime_size);
                case "onNotification";
                    assert(it.offset_in_bytes == 32, "ma_device.onNotification has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.onNotification has unexpected size % instead of 8", it.type.runtime_size);
                case "onStop";
                    assert(it.offset_in_bytes == 40, "ma_device.onStop has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.onStop has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 48, "ma_device.pUserData has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "startStopLock";
                    assert(it.offset_in_bytes == 56, "ma_device.startStopLock has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_device.startStopLock has unexpected size % instead of 40", it.type.runtime_size);
                case "wakeupEvent";
                    assert(it.offset_in_bytes == 96, "ma_device.wakeupEvent has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_device.wakeupEvent has unexpected size % instead of 96", it.type.runtime_size);
                case "startEvent";
                    assert(it.offset_in_bytes == 192, "ma_device.startEvent has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_device.startEvent has unexpected size % instead of 96", it.type.runtime_size);
                case "stopEvent";
                    assert(it.offset_in_bytes == 288, "ma_device.stopEvent has unexpected offset % instead of 288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_device.stopEvent has unexpected size % instead of 96", it.type.runtime_size);
                case "thread";
                    assert(it.offset_in_bytes == 384, "ma_device.thread has unexpected offset % instead of 384", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_device.thread has unexpected size % instead of 8", it.type.runtime_size);
                case "workResult";
                    assert(it.offset_in_bytes == 392, "ma_device.workResult has unexpected offset % instead of 392", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device.workResult has unexpected size % instead of 4", it.type.runtime_size);
                case "isOwnerOfContext";
                    assert(it.offset_in_bytes == 396, "ma_device.isOwnerOfContext has unexpected offset % instead of 396", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device.isOwnerOfContext has unexpected size % instead of 1", it.type.runtime_size);
                case "noPreSilencedOutputBuffer";
                    assert(it.offset_in_bytes == 397, "ma_device.noPreSilencedOutputBuffer has unexpected offset % instead of 397", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device.noPreSilencedOutputBuffer has unexpected size % instead of 1", it.type.runtime_size);
                case "noClip";
                    assert(it.offset_in_bytes == 398, "ma_device.noClip has unexpected offset % instead of 398", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device.noClip has unexpected size % instead of 1", it.type.runtime_size);
                case "noDisableDenormals";
                    assert(it.offset_in_bytes == 399, "ma_device.noDisableDenormals has unexpected offset % instead of 399", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device.noDisableDenormals has unexpected size % instead of 1", it.type.runtime_size);
                case "noFixedSizedCallback";
                    assert(it.offset_in_bytes == 400, "ma_device.noFixedSizedCallback has unexpected offset % instead of 400", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_device.noFixedSizedCallback has unexpected size % instead of 1", it.type.runtime_size);
                case "masterVolumeFactor";
                    assert(it.offset_in_bytes == 404, "ma_device.masterVolumeFactor has unexpected offset % instead of 404", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_device.masterVolumeFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "duplexRB";
                    assert(it.offset_in_bytes == 408, "ma_device.duplexRB has unexpected offset % instead of 408", it.offset_in_bytes);
                    assert(it.type.runtime_size == 152, "ma_device.duplexRB has unexpected size % instead of 152", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 560, "ma_device.resampling has unexpected offset % instead of 560", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_device.resampling has unexpected size % instead of 32", it.type.runtime_size);
                case "playback";
                    assert(it.offset_in_bytes == 592, "ma_device.playback has unexpected offset % instead of 592", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1432, "ma_device.playback has unexpected size % instead of 1432", it.type.runtime_size);
                case "capture";
                    assert(it.offset_in_bytes == 2024, "ma_device.capture has unexpected offset % instead of 2024", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1400, "ma_device.capture has unexpected size % instead of 1400", it.type.runtime_size);
            }
        }
        assert(size_of(ma_device) == 3776, "ma_device has size % instead of 3776", size_of(ma_device));
    }

    {
        info := type_info(ma_file_info);
        for info.members {
            if it.name == {
                case "sizeInBytes";
                    assert(it.offset_in_bytes == 0, "ma_file_info.sizeInBytes has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_file_info.sizeInBytes has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_file_info) == 8, "ma_file_info has size % instead of 8", size_of(ma_file_info));
    }

    {
        info := type_info(ma_vfs_callbacks);
        for info.members {
            if it.name == {
                case "onOpen";
                    assert(it.offset_in_bytes == 0, "ma_vfs_callbacks.onOpen has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onOpen has unexpected size % instead of 8", it.type.runtime_size);
                case "onOpenW";
                    assert(it.offset_in_bytes == 8, "ma_vfs_callbacks.onOpenW has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onOpenW has unexpected size % instead of 8", it.type.runtime_size);
                case "onClose";
                    assert(it.offset_in_bytes == 16, "ma_vfs_callbacks.onClose has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onClose has unexpected size % instead of 8", it.type.runtime_size);
                case "onRead";
                    assert(it.offset_in_bytes == 24, "ma_vfs_callbacks.onRead has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onRead has unexpected size % instead of 8", it.type.runtime_size);
                case "onWrite";
                    assert(it.offset_in_bytes == 32, "ma_vfs_callbacks.onWrite has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onWrite has unexpected size % instead of 8", it.type.runtime_size);
                case "onSeek";
                    assert(it.offset_in_bytes == 40, "ma_vfs_callbacks.onSeek has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onSeek has unexpected size % instead of 8", it.type.runtime_size);
                case "onTell";
                    assert(it.offset_in_bytes == 48, "ma_vfs_callbacks.onTell has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onTell has unexpected size % instead of 8", it.type.runtime_size);
                case "onInfo";
                    assert(it.offset_in_bytes == 56, "ma_vfs_callbacks.onInfo has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_vfs_callbacks.onInfo has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_vfs_callbacks) == 64, "ma_vfs_callbacks has size % instead of 64", size_of(ma_vfs_callbacks));
    }

    {
        info := type_info(ma_default_vfs);
        for info.members {
            if it.name == {
                case "cb";
                    assert(it.offset_in_bytes == 0, "ma_default_vfs.cb has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_default_vfs.cb has unexpected size % instead of 64", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 64, "ma_default_vfs.allocationCallbacks has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_default_vfs.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_default_vfs) == 96, "ma_default_vfs has size % instead of 96", size_of(ma_default_vfs));
    }

    {
        info := type_info(ma_decoding_backend_config);
        for info.members {
            if it.name == {
                case "preferredFormat";
                    assert(it.offset_in_bytes == 0, "ma_decoding_backend_config.preferredFormat has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoding_backend_config.preferredFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "seekPointCount";
                    assert(it.offset_in_bytes == 4, "ma_decoding_backend_config.seekPointCount has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoding_backend_config.seekPointCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_decoding_backend_config) == 8, "ma_decoding_backend_config has size % instead of 8", size_of(ma_decoding_backend_config));
    }

    {
        info := type_info(ma_decoding_backend_vtable);
        for info.members {
            if it.name == {
                case "onInit";
                    assert(it.offset_in_bytes == 0, "ma_decoding_backend_vtable.onInit has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoding_backend_vtable.onInit has unexpected size % instead of 8", it.type.runtime_size);
                case "onInitFile";
                    assert(it.offset_in_bytes == 8, "ma_decoding_backend_vtable.onInitFile has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoding_backend_vtable.onInitFile has unexpected size % instead of 8", it.type.runtime_size);
                case "onInitFileW";
                    assert(it.offset_in_bytes == 16, "ma_decoding_backend_vtable.onInitFileW has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoding_backend_vtable.onInitFileW has unexpected size % instead of 8", it.type.runtime_size);
                case "onInitMemory";
                    assert(it.offset_in_bytes == 24, "ma_decoding_backend_vtable.onInitMemory has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoding_backend_vtable.onInitMemory has unexpected size % instead of 8", it.type.runtime_size);
                case "onUninit";
                    assert(it.offset_in_bytes == 32, "ma_decoding_backend_vtable.onUninit has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoding_backend_vtable.onUninit has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_decoding_backend_vtable) == 40, "ma_decoding_backend_vtable has size % instead of 40", size_of(ma_decoding_backend_vtable));
    }

    {
        info := type_info(ma_decoder_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_decoder_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_decoder_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_decoder_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "pChannelMap";
                    assert(it.offset_in_bytes == 16, "ma_decoder_config.pChannelMap has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder_config.pChannelMap has unexpected size % instead of 8", it.type.runtime_size);
                case "channelMixMode";
                    assert(it.offset_in_bytes == 24, "ma_decoder_config.channelMixMode has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.channelMixMode has unexpected size % instead of 4", it.type.runtime_size);
                case "ditherMode";
                    assert(it.offset_in_bytes == 28, "ma_decoder_config.ditherMode has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.ditherMode has unexpected size % instead of 4", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 32, "ma_decoder_config.resampling has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_decoder_config.resampling has unexpected size % instead of 48", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 80, "ma_decoder_config.allocationCallbacks has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_decoder_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "encodingFormat";
                    assert(it.offset_in_bytes == 112, "ma_decoder_config.encodingFormat has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.encodingFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "seekPointCount";
                    assert(it.offset_in_bytes == 116, "ma_decoder_config.seekPointCount has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.seekPointCount has unexpected size % instead of 4", it.type.runtime_size);
                case "ppCustomBackendVTables";
                    assert(it.offset_in_bytes == 120, "ma_decoder_config.ppCustomBackendVTables has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder_config.ppCustomBackendVTables has unexpected size % instead of 8", it.type.runtime_size);
                case "customBackendCount";
                    assert(it.offset_in_bytes == 128, "ma_decoder_config.customBackendCount has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder_config.customBackendCount has unexpected size % instead of 4", it.type.runtime_size);
                case "pCustomBackendUserData";
                    assert(it.offset_in_bytes == 136, "ma_decoder_config.pCustomBackendUserData has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder_config.pCustomBackendUserData has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_decoder_config) == 144, "ma_decoder_config has size % instead of 144", size_of(ma_decoder_config));
    }

    {
        info := type_info(ma_decoder);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_decoder.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_decoder.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "pBackend";
                    assert(it.offset_in_bytes == 72, "ma_decoder.pBackend has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.pBackend has unexpected size % instead of 8", it.type.runtime_size);
                case "pBackendVTable";
                    assert(it.offset_in_bytes == 80, "ma_decoder.pBackendVTable has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.pBackendVTable has unexpected size % instead of 8", it.type.runtime_size);
                case "pBackendUserData";
                    assert(it.offset_in_bytes == 88, "ma_decoder.pBackendUserData has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.pBackendUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "onRead";
                    assert(it.offset_in_bytes == 96, "ma_decoder.onRead has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.onRead has unexpected size % instead of 8", it.type.runtime_size);
                case "onSeek";
                    assert(it.offset_in_bytes == 104, "ma_decoder.onSeek has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.onSeek has unexpected size % instead of 8", it.type.runtime_size);
                case "onTell";
                    assert(it.offset_in_bytes == 112, "ma_decoder.onTell has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.onTell has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 120, "ma_decoder.pUserData has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "readPointerInPCMFrames";
                    assert(it.offset_in_bytes == 128, "ma_decoder.readPointerInPCMFrames has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.readPointerInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "outputFormat";
                    assert(it.offset_in_bytes == 136, "ma_decoder.outputFormat has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder.outputFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "outputChannels";
                    assert(it.offset_in_bytes == 140, "ma_decoder.outputChannels has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder.outputChannels has unexpected size % instead of 4", it.type.runtime_size);
                case "outputSampleRate";
                    assert(it.offset_in_bytes == 144, "ma_decoder.outputSampleRate has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_decoder.outputSampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "converter";
                    assert(it.offset_in_bytes == 152, "ma_decoder.converter has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 312, "ma_decoder.converter has unexpected size % instead of 312", it.type.runtime_size);
                case "pInputCache";
                    assert(it.offset_in_bytes == 464, "ma_decoder.pInputCache has unexpected offset % instead of 464", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.pInputCache has unexpected size % instead of 8", it.type.runtime_size);
                case "inputCacheCap";
                    assert(it.offset_in_bytes == 472, "ma_decoder.inputCacheCap has unexpected offset % instead of 472", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.inputCacheCap has unexpected size % instead of 8", it.type.runtime_size);
                case "inputCacheConsumed";
                    assert(it.offset_in_bytes == 480, "ma_decoder.inputCacheConsumed has unexpected offset % instead of 480", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.inputCacheConsumed has unexpected size % instead of 8", it.type.runtime_size);
                case "inputCacheRemaining";
                    assert(it.offset_in_bytes == 488, "ma_decoder.inputCacheRemaining has unexpected offset % instead of 488", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_decoder.inputCacheRemaining has unexpected size % instead of 8", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 496, "ma_decoder.allocationCallbacks has unexpected offset % instead of 496", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_decoder.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 528, "ma_decoder.data has unexpected offset % instead of 528", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_decoder.data has unexpected size % instead of 24", it.type.runtime_size);
            }
        }
        assert(size_of(ma_decoder) == 552, "ma_decoder has size % instead of 552", size_of(ma_decoder));
    }

    {
        info := type_info(ma_encoder_config);
        for info.members {
            if it.name == {
                case "encodingFormat";
                    assert(it.offset_in_bytes == 0, "ma_encoder_config.encodingFormat has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_encoder_config.encodingFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 4, "ma_encoder_config.format has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_encoder_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 8, "ma_encoder_config.channels has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_encoder_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 12, "ma_encoder_config.sampleRate has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_encoder_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 16, "ma_encoder_config.allocationCallbacks has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_encoder_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_encoder_config) == 48, "ma_encoder_config has size % instead of 48", size_of(ma_encoder_config));
    }

    {
        info := type_info(ma_encoder);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_encoder.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_encoder.config has unexpected size % instead of 48", it.type.runtime_size);
                case "onWrite";
                    assert(it.offset_in_bytes == 48, "ma_encoder.onWrite has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.onWrite has unexpected size % instead of 8", it.type.runtime_size);
                case "onSeek";
                    assert(it.offset_in_bytes == 56, "ma_encoder.onSeek has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.onSeek has unexpected size % instead of 8", it.type.runtime_size);
                case "onInit";
                    assert(it.offset_in_bytes == 64, "ma_encoder.onInit has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.onInit has unexpected size % instead of 8", it.type.runtime_size);
                case "onUninit";
                    assert(it.offset_in_bytes == 72, "ma_encoder.onUninit has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.onUninit has unexpected size % instead of 8", it.type.runtime_size);
                case "onWritePCMFrames";
                    assert(it.offset_in_bytes == 80, "ma_encoder.onWritePCMFrames has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.onWritePCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "pUserData";
                    assert(it.offset_in_bytes == 88, "ma_encoder.pUserData has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.pUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "pInternalEncoder";
                    assert(it.offset_in_bytes == 96, "ma_encoder.pInternalEncoder has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_encoder.pInternalEncoder has unexpected size % instead of 8", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 104, "ma_encoder.data has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_encoder.data has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(ma_encoder) == 120, "ma_encoder has size % instead of 120", size_of(ma_encoder));
    }

    {
        info := type_info(ma_waveform_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_waveform_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_waveform_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_waveform_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_waveform_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_waveform_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_waveform_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 12, "ma_waveform_config.type has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_waveform_config.type has unexpected size % instead of 4", it.type.runtime_size);
                case "amplitude";
                    assert(it.offset_in_bytes == 16, "ma_waveform_config.amplitude has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_waveform_config.amplitude has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 24, "ma_waveform_config.frequency has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_waveform_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_waveform_config) == 32, "ma_waveform_config has size % instead of 32", size_of(ma_waveform_config));
    }

    {
        info := type_info(ma_waveform);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_waveform.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_waveform.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "config";
                    assert(it.offset_in_bytes == 72, "ma_waveform.config has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_waveform.config has unexpected size % instead of 32", it.type.runtime_size);
                case "advance";
                    assert(it.offset_in_bytes == 104, "ma_waveform.advance has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_waveform.advance has unexpected size % instead of 8", it.type.runtime_size);
                case "time";
                    assert(it.offset_in_bytes == 112, "ma_waveform.time has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_waveform.time has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_waveform) == 120, "ma_waveform has size % instead of 120", size_of(ma_waveform));
    }

    {
        info := type_info(ma_pulsewave_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_pulsewave_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pulsewave_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_pulsewave_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pulsewave_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 8, "ma_pulsewave_config.sampleRate has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_pulsewave_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "dutyCycle";
                    assert(it.offset_in_bytes == 16, "ma_pulsewave_config.dutyCycle has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_pulsewave_config.dutyCycle has unexpected size % instead of 8", it.type.runtime_size);
                case "amplitude";
                    assert(it.offset_in_bytes == 24, "ma_pulsewave_config.amplitude has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_pulsewave_config.amplitude has unexpected size % instead of 8", it.type.runtime_size);
                case "frequency";
                    assert(it.offset_in_bytes == 32, "ma_pulsewave_config.frequency has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_pulsewave_config.frequency has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_pulsewave_config) == 40, "ma_pulsewave_config has size % instead of 40", size_of(ma_pulsewave_config));
    }

    {
        info := type_info(ma_pulsewave);
        for info.members {
            if it.name == {
                case "waveform";
                    assert(it.offset_in_bytes == 0, "ma_pulsewave.waveform has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 120, "ma_pulsewave.waveform has unexpected size % instead of 120", it.type.runtime_size);
                case "config";
                    assert(it.offset_in_bytes == 120, "ma_pulsewave.config has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_pulsewave.config has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_pulsewave) == 160, "ma_pulsewave has size % instead of 160", size_of(ma_pulsewave));
    }

    {
        info := type_info(ma_noise_config);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "ma_noise_config.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise_config.format has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 4, "ma_noise_config.channels has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "ma_noise_config.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise_config.type has unexpected size % instead of 4", it.type.runtime_size);
                case "seed";
                    assert(it.offset_in_bytes == 12, "ma_noise_config.seed has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise_config.seed has unexpected size % instead of 4", it.type.runtime_size);
                case "amplitude";
                    assert(it.offset_in_bytes == 16, "ma_noise_config.amplitude has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_noise_config.amplitude has unexpected size % instead of 8", it.type.runtime_size);
                case "duplicateChannels";
                    assert(it.offset_in_bytes == 24, "ma_noise_config.duplicateChannels has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise_config.duplicateChannels has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_noise_config) == 32, "ma_noise_config has size % instead of 32", size_of(ma_noise_config));
    }

    {
        info := type_info(ma_noise);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_noise.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_noise.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "config";
                    assert(it.offset_in_bytes == 72, "ma_noise.config has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_noise.config has unexpected size % instead of 32", it.type.runtime_size);
                case "lcg";
                    assert(it.offset_in_bytes == 104, "ma_noise.lcg has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise.lcg has unexpected size % instead of 4", it.type.runtime_size);
                case "state";
                    assert(it.offset_in_bytes == 112, "ma_noise.state has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_noise.state has unexpected size % instead of 24", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 136, "ma_noise._pHeap has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_noise._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 144, "ma_noise._ownsHeap has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_noise._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_noise) == 152, "ma_noise has size % instead of 152", size_of(ma_noise));
    }

    {
        info := type_info(ma_resource_manager_pipeline_stage_notification);
        for info.members {
            if it.name == {
                case "pNotification";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_pipeline_stage_notification.pNotification has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_pipeline_stage_notification.pNotification has unexpected size % instead of 8", it.type.runtime_size);
                case "pFence";
                    assert(it.offset_in_bytes == 8, "ma_resource_manager_pipeline_stage_notification.pFence has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_pipeline_stage_notification.pFence has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_pipeline_stage_notification) == 16, "ma_resource_manager_pipeline_stage_notification has size % instead of 16", size_of(ma_resource_manager_pipeline_stage_notification));
    }

    {
        info := type_info(ma_resource_manager_pipeline_notifications);
        for info.members {
            if it.name == {
                case "init";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_pipeline_notifications.init has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_resource_manager_pipeline_notifications.init has unexpected size % instead of 16", it.type.runtime_size);
                case "done";
                    assert(it.offset_in_bytes == 16, "ma_resource_manager_pipeline_notifications.done has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_resource_manager_pipeline_notifications.done has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_pipeline_notifications) == 32, "ma_resource_manager_pipeline_notifications has size % instead of 32", size_of(ma_resource_manager_pipeline_notifications));
    }

    {
        info := type_info(ma_resource_manager_data_source_config);
        for info.members {
            if it.name == {
                case "pFilePath";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_source_config.pFilePath has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.pFilePath has unexpected size % instead of 8", it.type.runtime_size);
                case "pFilePathW";
                    assert(it.offset_in_bytes == 8, "ma_resource_manager_data_source_config.pFilePathW has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.pFilePathW has unexpected size % instead of 8", it.type.runtime_size);
                case "pNotifications";
                    assert(it.offset_in_bytes == 16, "ma_resource_manager_data_source_config.pNotifications has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.pNotifications has unexpected size % instead of 8", it.type.runtime_size);
                case "initialSeekPointInPCMFrames";
                    assert(it.offset_in_bytes == 24, "ma_resource_manager_data_source_config.initialSeekPointInPCMFrames has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.initialSeekPointInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeBegInPCMFrames";
                    assert(it.offset_in_bytes == 32, "ma_resource_manager_data_source_config.rangeBegInPCMFrames has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.rangeBegInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeEndInPCMFrames";
                    assert(it.offset_in_bytes == 40, "ma_resource_manager_data_source_config.rangeEndInPCMFrames has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.rangeEndInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopPointBegInPCMFrames";
                    assert(it.offset_in_bytes == 48, "ma_resource_manager_data_source_config.loopPointBegInPCMFrames has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.loopPointBegInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopPointEndInPCMFrames";
                    assert(it.offset_in_bytes == 56, "ma_resource_manager_data_source_config.loopPointEndInPCMFrames has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_source_config.loopPointEndInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 64, "ma_resource_manager_data_source_config.flags has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_source_config.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "isLooping";
                    assert(it.offset_in_bytes == 68, "ma_resource_manager_data_source_config.isLooping has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_source_config.isLooping has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_source_config) == 72, "ma_resource_manager_data_source_config has size % instead of 72", size_of(ma_resource_manager_data_source_config));
    }

    {
        info := type_info(ma_resource_manager_data_supply);
        for info.members {
            if it.name == {
                case "type";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_supply.type has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_supply.type has unexpected size % instead of 4", it.type.runtime_size);
                case "backend";
                    assert(it.offset_in_bytes == 8, "ma_resource_manager_data_supply.backend has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_resource_manager_data_supply.backend has unexpected size % instead of 56", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_supply) == 64, "ma_resource_manager_data_supply has size % instead of 64", size_of(ma_resource_manager_data_supply));
    }

    {
        info := type_info(ma_resource_manager_data_buffer_node);
        for info.members {
            if it.name == {
                case "hashedName32";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_buffer_node.hashedName32 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.hashedName32 has unexpected size % instead of 4", it.type.runtime_size);
                case "refCount";
                    assert(it.offset_in_bytes == 4, "ma_resource_manager_data_buffer_node.refCount has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.refCount has unexpected size % instead of 4", it.type.runtime_size);
                case "result";
                    assert(it.offset_in_bytes == 8, "ma_resource_manager_data_buffer_node.result has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.result has unexpected size % instead of 4", it.type.runtime_size);
                case "executionCounter";
                    assert(it.offset_in_bytes == 12, "ma_resource_manager_data_buffer_node.executionCounter has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.executionCounter has unexpected size % instead of 4", it.type.runtime_size);
                case "executionPointer";
                    assert(it.offset_in_bytes == 16, "ma_resource_manager_data_buffer_node.executionPointer has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.executionPointer has unexpected size % instead of 4", it.type.runtime_size);
                case "isDataOwnedByResourceManager";
                    assert(it.offset_in_bytes == 20, "ma_resource_manager_data_buffer_node.isDataOwnedByResourceManager has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer_node.isDataOwnedByResourceManager has unexpected size % instead of 4", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 24, "ma_resource_manager_data_buffer_node.data has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_resource_manager_data_buffer_node.data has unexpected size % instead of 64", it.type.runtime_size);
                case "pParent";
                    assert(it.offset_in_bytes == 88, "ma_resource_manager_data_buffer_node.pParent has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer_node.pParent has unexpected size % instead of 8", it.type.runtime_size);
                case "pChildLo";
                    assert(it.offset_in_bytes == 96, "ma_resource_manager_data_buffer_node.pChildLo has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer_node.pChildLo has unexpected size % instead of 8", it.type.runtime_size);
                case "pChildHi";
                    assert(it.offset_in_bytes == 104, "ma_resource_manager_data_buffer_node.pChildHi has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer_node.pChildHi has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_buffer_node) == 112, "ma_resource_manager_data_buffer_node has size % instead of 112", size_of(ma_resource_manager_data_buffer_node));
    }

    {
        info := type_info(ma_resource_manager_data_buffer);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_buffer.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_resource_manager_data_buffer.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "pResourceManager";
                    assert(it.offset_in_bytes == 72, "ma_resource_manager_data_buffer.pResourceManager has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer.pResourceManager has unexpected size % instead of 8", it.type.runtime_size);
                case "pNode";
                    assert(it.offset_in_bytes == 80, "ma_resource_manager_data_buffer.pNode has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer.pNode has unexpected size % instead of 8", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 88, "ma_resource_manager_data_buffer.flags has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "executionCounter";
                    assert(it.offset_in_bytes == 92, "ma_resource_manager_data_buffer.executionCounter has unexpected offset % instead of 92", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.executionCounter has unexpected size % instead of 4", it.type.runtime_size);
                case "executionPointer";
                    assert(it.offset_in_bytes == 96, "ma_resource_manager_data_buffer.executionPointer has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.executionPointer has unexpected size % instead of 4", it.type.runtime_size);
                case "seekTargetInPCMFrames";
                    assert(it.offset_in_bytes == 104, "ma_resource_manager_data_buffer.seekTargetInPCMFrames has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_buffer.seekTargetInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "seekToCursorOnNextRead";
                    assert(it.offset_in_bytes == 112, "ma_resource_manager_data_buffer.seekToCursorOnNextRead has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.seekToCursorOnNextRead has unexpected size % instead of 4", it.type.runtime_size);
                case "result";
                    assert(it.offset_in_bytes == 116, "ma_resource_manager_data_buffer.result has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.result has unexpected size % instead of 4", it.type.runtime_size);
                case "isLooping";
                    assert(it.offset_in_bytes == 120, "ma_resource_manager_data_buffer.isLooping has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.isLooping has unexpected size % instead of 4", it.type.runtime_size);
                case "isConnectorInitialized";
                    assert(it.offset_in_bytes == 124, "ma_resource_manager_data_buffer.isConnectorInitialized has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_buffer.isConnectorInitialized has unexpected size % instead of 4", it.type.runtime_size);
                case "connector";
                    assert(it.offset_in_bytes == 128, "ma_resource_manager_data_buffer.connector has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 552, "ma_resource_manager_data_buffer.connector has unexpected size % instead of 552", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_buffer) == 680, "ma_resource_manager_data_buffer has size % instead of 680", size_of(ma_resource_manager_data_buffer));
    }

    {
        info := type_info(ma_resource_manager_data_stream);
        for info.members {
            if it.name == {
                case "ds";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_stream.ds has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 72, "ma_resource_manager_data_stream.ds has unexpected size % instead of 72", it.type.runtime_size);
                case "pResourceManager";
                    assert(it.offset_in_bytes == 72, "ma_resource_manager_data_stream.pResourceManager has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.pResourceManager has unexpected size % instead of 8", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 80, "ma_resource_manager_data_stream.flags has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "decoder";
                    assert(it.offset_in_bytes == 88, "ma_resource_manager_data_stream.decoder has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 552, "ma_resource_manager_data_stream.decoder has unexpected size % instead of 552", it.type.runtime_size);
                case "isDecoderInitialized";
                    assert(it.offset_in_bytes == 640, "ma_resource_manager_data_stream.isDecoderInitialized has unexpected offset % instead of 640", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.isDecoderInitialized has unexpected size % instead of 4", it.type.runtime_size);
                case "totalLengthInPCMFrames";
                    assert(it.offset_in_bytes == 648, "ma_resource_manager_data_stream.totalLengthInPCMFrames has unexpected offset % instead of 648", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.totalLengthInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "relativeCursor";
                    assert(it.offset_in_bytes == 656, "ma_resource_manager_data_stream.relativeCursor has unexpected offset % instead of 656", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.relativeCursor has unexpected size % instead of 4", it.type.runtime_size);
                case "absoluteCursor";
                    assert(it.offset_in_bytes == 664, "ma_resource_manager_data_stream.absoluteCursor has unexpected offset % instead of 664", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.absoluteCursor has unexpected size % instead of 8", it.type.runtime_size);
                case "currentPageIndex";
                    assert(it.offset_in_bytes == 672, "ma_resource_manager_data_stream.currentPageIndex has unexpected offset % instead of 672", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.currentPageIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "executionCounter";
                    assert(it.offset_in_bytes == 676, "ma_resource_manager_data_stream.executionCounter has unexpected offset % instead of 676", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.executionCounter has unexpected size % instead of 4", it.type.runtime_size);
                case "executionPointer";
                    assert(it.offset_in_bytes == 680, "ma_resource_manager_data_stream.executionPointer has unexpected offset % instead of 680", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.executionPointer has unexpected size % instead of 4", it.type.runtime_size);
                case "isLooping";
                    assert(it.offset_in_bytes == 684, "ma_resource_manager_data_stream.isLooping has unexpected offset % instead of 684", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.isLooping has unexpected size % instead of 4", it.type.runtime_size);
                case "pPageData";
                    assert(it.offset_in_bytes == 688, "ma_resource_manager_data_stream.pPageData has unexpected offset % instead of 688", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.pPageData has unexpected size % instead of 8", it.type.runtime_size);
                case "pageFrameCount";
                    assert(it.offset_in_bytes == 696, "ma_resource_manager_data_stream.pageFrameCount has unexpected offset % instead of 696", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.pageFrameCount has unexpected size % instead of 8", it.type.runtime_size);
                case "result";
                    assert(it.offset_in_bytes == 704, "ma_resource_manager_data_stream.result has unexpected offset % instead of 704", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.result has unexpected size % instead of 4", it.type.runtime_size);
                case "isDecoderAtEnd";
                    assert(it.offset_in_bytes == 708, "ma_resource_manager_data_stream.isDecoderAtEnd has unexpected offset % instead of 708", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.isDecoderAtEnd has unexpected size % instead of 4", it.type.runtime_size);
                case "isPageValid";
                    assert(it.offset_in_bytes == 712, "ma_resource_manager_data_stream.isPageValid has unexpected offset % instead of 712", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_data_stream.isPageValid has unexpected size % instead of 8", it.type.runtime_size);
                case "seekCounter";
                    assert(it.offset_in_bytes == 720, "ma_resource_manager_data_stream.seekCounter has unexpected offset % instead of 720", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_stream.seekCounter has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_stream) == 728, "ma_resource_manager_data_stream has size % instead of 728", size_of(ma_resource_manager_data_stream));
    }

    {
        info := type_info(ma_resource_manager_data_source);
        for info.members {
            if it.name == {
                case "backend";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_data_source.backend has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 728, "ma_resource_manager_data_source.backend has unexpected size % instead of 728", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 728, "ma_resource_manager_data_source.flags has unexpected offset % instead of 728", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_source.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "executionCounter";
                    assert(it.offset_in_bytes == 732, "ma_resource_manager_data_source.executionCounter has unexpected offset % instead of 732", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_source.executionCounter has unexpected size % instead of 4", it.type.runtime_size);
                case "executionPointer";
                    assert(it.offset_in_bytes == 736, "ma_resource_manager_data_source.executionPointer has unexpected offset % instead of 736", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_data_source.executionPointer has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_data_source) == 744, "ma_resource_manager_data_source has size % instead of 744", size_of(ma_resource_manager_data_source));
    }

    {
        info := type_info(ma_resource_manager_config);
        for info.members {
            if it.name == {
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager_config.allocationCallbacks has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_resource_manager_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "pLog";
                    assert(it.offset_in_bytes == 32, "ma_resource_manager_config.pLog has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_config.pLog has unexpected size % instead of 8", it.type.runtime_size);
                case "decodedFormat";
                    assert(it.offset_in_bytes == 40, "ma_resource_manager_config.decodedFormat has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.decodedFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "decodedChannels";
                    assert(it.offset_in_bytes == 44, "ma_resource_manager_config.decodedChannels has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.decodedChannels has unexpected size % instead of 4", it.type.runtime_size);
                case "decodedSampleRate";
                    assert(it.offset_in_bytes == 48, "ma_resource_manager_config.decodedSampleRate has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.decodedSampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "jobThreadCount";
                    assert(it.offset_in_bytes == 52, "ma_resource_manager_config.jobThreadCount has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.jobThreadCount has unexpected size % instead of 4", it.type.runtime_size);
                case "jobThreadStackSize";
                    assert(it.offset_in_bytes == 56, "ma_resource_manager_config.jobThreadStackSize has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_config.jobThreadStackSize has unexpected size % instead of 8", it.type.runtime_size);
                case "jobQueueCapacity";
                    assert(it.offset_in_bytes == 64, "ma_resource_manager_config.jobQueueCapacity has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.jobQueueCapacity has unexpected size % instead of 4", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 68, "ma_resource_manager_config.flags has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "pVFS";
                    assert(it.offset_in_bytes == 72, "ma_resource_manager_config.pVFS has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_config.pVFS has unexpected size % instead of 8", it.type.runtime_size);
                case "ppCustomDecodingBackendVTables";
                    assert(it.offset_in_bytes == 80, "ma_resource_manager_config.ppCustomDecodingBackendVTables has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_config.ppCustomDecodingBackendVTables has unexpected size % instead of 8", it.type.runtime_size);
                case "customDecodingBackendCount";
                    assert(it.offset_in_bytes == 88, "ma_resource_manager_config.customDecodingBackendCount has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_resource_manager_config.customDecodingBackendCount has unexpected size % instead of 4", it.type.runtime_size);
                case "pCustomDecodingBackendUserData";
                    assert(it.offset_in_bytes == 96, "ma_resource_manager_config.pCustomDecodingBackendUserData has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager_config.pCustomDecodingBackendUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 104, "ma_resource_manager_config.resampling has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_resource_manager_config.resampling has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager_config) == 152, "ma_resource_manager_config has size % instead of 152", size_of(ma_resource_manager_config));
    }

    {
        info := type_info(ma_resource_manager);
        for info.members {
            if it.name == {
                case "config";
                    assert(it.offset_in_bytes == 0, "ma_resource_manager.config has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 152, "ma_resource_manager.config has unexpected size % instead of 152", it.type.runtime_size);
                case "pRootDataBufferNode";
                    assert(it.offset_in_bytes == 152, "ma_resource_manager.pRootDataBufferNode has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_resource_manager.pRootDataBufferNode has unexpected size % instead of 8", it.type.runtime_size);
                case "dataBufferBSTLock";
                    assert(it.offset_in_bytes == 160, "ma_resource_manager.dataBufferBSTLock has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_resource_manager.dataBufferBSTLock has unexpected size % instead of 40", it.type.runtime_size);
                case "jobThreads";
                    assert(it.offset_in_bytes == 200, "ma_resource_manager.jobThreads has unexpected offset % instead of 200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 512, "ma_resource_manager.jobThreads has unexpected size % instead of 512", it.type.runtime_size);
                case "jobQueue";
                    assert(it.offset_in_bytes == 712, "ma_resource_manager.jobQueue has unexpected offset % instead of 712", it.offset_in_bytes);
                    assert(it.type.runtime_size == 192, "ma_resource_manager.jobQueue has unexpected size % instead of 192", it.type.runtime_size);
                case "defaultVFS";
                    assert(it.offset_in_bytes == 904, "ma_resource_manager.defaultVFS has unexpected offset % instead of 904", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "ma_resource_manager.defaultVFS has unexpected size % instead of 96", it.type.runtime_size);
                case "log";
                    assert(it.offset_in_bytes == 1000, "ma_resource_manager.log has unexpected offset % instead of 1000", it.offset_in_bytes);
                    assert(it.type.runtime_size == 144, "ma_resource_manager.log has unexpected size % instead of 144", it.type.runtime_size);
            }
        }
        assert(size_of(ma_resource_manager) == 1144, "ma_resource_manager has size % instead of 1144", size_of(ma_resource_manager));
    }

    {
        info := type_info(ma_stack);
        for info.members {
            if it.name == {
                case "offset";
                    assert(it.offset_in_bytes == 0, "ma_stack.offset has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_stack.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "sizeInBytes";
                    assert(it.offset_in_bytes == 8, "ma_stack.sizeInBytes has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_stack.sizeInBytes has unexpected size % instead of 8", it.type.runtime_size);
                case "_data";
                    assert(it.offset_in_bytes == 16, "ma_stack._data has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_stack._data has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(ma_stack) == 24, "ma_stack has size % instead of 24", size_of(ma_stack));
    }

    {
        info := type_info(ma_node_vtable);
        for info.members {
            if it.name == {
                case "onProcess";
                    assert(it.offset_in_bytes == 0, "ma_node_vtable.onProcess has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_vtable.onProcess has unexpected size % instead of 8", it.type.runtime_size);
                case "onGetRequiredInputFrameCount";
                    assert(it.offset_in_bytes == 8, "ma_node_vtable.onGetRequiredInputFrameCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_vtable.onGetRequiredInputFrameCount has unexpected size % instead of 8", it.type.runtime_size);
                case "inputBusCount";
                    assert(it.offset_in_bytes == 16, "ma_node_vtable.inputBusCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_vtable.inputBusCount has unexpected size % instead of 1", it.type.runtime_size);
                case "outputBusCount";
                    assert(it.offset_in_bytes == 17, "ma_node_vtable.outputBusCount has unexpected offset % instead of 17", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_vtable.outputBusCount has unexpected size % instead of 1", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 20, "ma_node_vtable.flags has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_vtable.flags has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_vtable) == 24, "ma_node_vtable has size % instead of 24", size_of(ma_node_vtable));
    }

    {
        info := type_info(ma_node_config);
        for info.members {
            if it.name == {
                case "vtable";
                    assert(it.offset_in_bytes == 0, "ma_node_config.vtable has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_config.vtable has unexpected size % instead of 8", it.type.runtime_size);
                case "initialState";
                    assert(it.offset_in_bytes == 8, "ma_node_config.initialState has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_config.initialState has unexpected size % instead of 4", it.type.runtime_size);
                case "inputBusCount";
                    assert(it.offset_in_bytes == 12, "ma_node_config.inputBusCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_config.inputBusCount has unexpected size % instead of 4", it.type.runtime_size);
                case "outputBusCount";
                    assert(it.offset_in_bytes == 16, "ma_node_config.outputBusCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_config.outputBusCount has unexpected size % instead of 4", it.type.runtime_size);
                case "pInputChannels";
                    assert(it.offset_in_bytes == 24, "ma_node_config.pInputChannels has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_config.pInputChannels has unexpected size % instead of 8", it.type.runtime_size);
                case "pOutputChannels";
                    assert(it.offset_in_bytes == 32, "ma_node_config.pOutputChannels has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_config.pOutputChannels has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_config) == 40, "ma_node_config has size % instead of 40", size_of(ma_node_config));
    }

    {
        info := type_info(ma_node_output_bus);
        for info.members {
            if it.name == {
                case "pNode";
                    assert(it.offset_in_bytes == 0, "ma_node_output_bus.pNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_output_bus.pNode has unexpected size % instead of 8", it.type.runtime_size);
                case "outputBusIndex";
                    assert(it.offset_in_bytes == 8, "ma_node_output_bus.outputBusIndex has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_output_bus.outputBusIndex has unexpected size % instead of 1", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 9, "ma_node_output_bus.channels has unexpected offset % instead of 9", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_output_bus.channels has unexpected size % instead of 1", it.type.runtime_size);
                case "inputNodeInputBusIndex";
                    assert(it.offset_in_bytes == 10, "ma_node_output_bus.inputNodeInputBusIndex has unexpected offset % instead of 10", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_output_bus.inputNodeInputBusIndex has unexpected size % instead of 1", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 12, "ma_node_output_bus.flags has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_output_bus.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "refCount";
                    assert(it.offset_in_bytes == 16, "ma_node_output_bus.refCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_output_bus.refCount has unexpected size % instead of 4", it.type.runtime_size);
                case "isAttached";
                    assert(it.offset_in_bytes == 20, "ma_node_output_bus.isAttached has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_output_bus.isAttached has unexpected size % instead of 4", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 24, "ma_node_output_bus.lock has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_output_bus.lock has unexpected size % instead of 4", it.type.runtime_size);
                case "volume";
                    assert(it.offset_in_bytes == 28, "ma_node_output_bus.volume has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_output_bus.volume has unexpected size % instead of 4", it.type.runtime_size);
                case "pNext";
                    assert(it.offset_in_bytes == 32, "ma_node_output_bus.pNext has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_output_bus.pNext has unexpected size % instead of 8", it.type.runtime_size);
                case "pPrev";
                    assert(it.offset_in_bytes == 40, "ma_node_output_bus.pPrev has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_output_bus.pPrev has unexpected size % instead of 8", it.type.runtime_size);
                case "pInputNode";
                    assert(it.offset_in_bytes == 48, "ma_node_output_bus.pInputNode has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_output_bus.pInputNode has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_output_bus) == 56, "ma_node_output_bus has size % instead of 56", size_of(ma_node_output_bus));
    }

    {
        info := type_info(ma_node_input_bus);
        for info.members {
            if it.name == {
                case "head";
                    assert(it.offset_in_bytes == 0, "ma_node_input_bus.head has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_node_input_bus.head has unexpected size % instead of 56", it.type.runtime_size);
                case "nextCounter";
                    assert(it.offset_in_bytes == 56, "ma_node_input_bus.nextCounter has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_input_bus.nextCounter has unexpected size % instead of 4", it.type.runtime_size);
                case "lock";
                    assert(it.offset_in_bytes == 60, "ma_node_input_bus.lock has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_input_bus.lock has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 64, "ma_node_input_bus.channels has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_node_input_bus.channels has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_input_bus) == 72, "ma_node_input_bus has size % instead of 72", size_of(ma_node_input_bus));
    }

    {
        info := type_info(ma_node_base);
        for info.members {
            if it.name == {
                case "pNodeGraph";
                    assert(it.offset_in_bytes == 0, "ma_node_base.pNodeGraph has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.pNodeGraph has unexpected size % instead of 8", it.type.runtime_size);
                case "vtable";
                    assert(it.offset_in_bytes == 8, "ma_node_base.vtable has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.vtable has unexpected size % instead of 8", it.type.runtime_size);
                case "inputBusCount";
                    assert(it.offset_in_bytes == 16, "ma_node_base.inputBusCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_base.inputBusCount has unexpected size % instead of 4", it.type.runtime_size);
                case "outputBusCount";
                    assert(it.offset_in_bytes == 20, "ma_node_base.outputBusCount has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_base.outputBusCount has unexpected size % instead of 4", it.type.runtime_size);
                case "pInputBuses";
                    assert(it.offset_in_bytes == 24, "ma_node_base.pInputBuses has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.pInputBuses has unexpected size % instead of 8", it.type.runtime_size);
                case "pOutputBuses";
                    assert(it.offset_in_bytes == 32, "ma_node_base.pOutputBuses has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.pOutputBuses has unexpected size % instead of 8", it.type.runtime_size);
                case "pCachedData";
                    assert(it.offset_in_bytes == 40, "ma_node_base.pCachedData has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.pCachedData has unexpected size % instead of 8", it.type.runtime_size);
                case "cachedDataCapInFramesPerBus";
                    assert(it.offset_in_bytes == 48, "ma_node_base.cachedDataCapInFramesPerBus has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "ma_node_base.cachedDataCapInFramesPerBus has unexpected size % instead of 2", it.type.runtime_size);
                case "cachedFrameCountOut";
                    assert(it.offset_in_bytes == 50, "ma_node_base.cachedFrameCountOut has unexpected offset % instead of 50", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "ma_node_base.cachedFrameCountOut has unexpected size % instead of 2", it.type.runtime_size);
                case "cachedFrameCountIn";
                    assert(it.offset_in_bytes == 52, "ma_node_base.cachedFrameCountIn has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "ma_node_base.cachedFrameCountIn has unexpected size % instead of 2", it.type.runtime_size);
                case "consumedFrameCountIn";
                    assert(it.offset_in_bytes == 54, "ma_node_base.consumedFrameCountIn has unexpected offset % instead of 54", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "ma_node_base.consumedFrameCountIn has unexpected size % instead of 2", it.type.runtime_size);
                case "state";
                    assert(it.offset_in_bytes == 56, "ma_node_base.state has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_base.state has unexpected size % instead of 4", it.type.runtime_size);
                case "stateTimes";
                    assert(it.offset_in_bytes == 64, "ma_node_base.stateTimes has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_node_base.stateTimes has unexpected size % instead of 16", it.type.runtime_size);
                case "localTime";
                    assert(it.offset_in_bytes == 80, "ma_node_base.localTime has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base.localTime has unexpected size % instead of 8", it.type.runtime_size);
                case "_inputBuses";
                    assert(it.offset_in_bytes == 88, "ma_node_base._inputBuses has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 144, "ma_node_base._inputBuses has unexpected size % instead of 144", it.type.runtime_size);
                case "_outputBuses";
                    assert(it.offset_in_bytes == 232, "ma_node_base._outputBuses has unexpected offset % instead of 232", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "ma_node_base._outputBuses has unexpected size % instead of 112", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 344, "ma_node_base._pHeap has unexpected offset % instead of 344", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_base._pHeap has unexpected size % instead of 8", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 352, "ma_node_base._ownsHeap has unexpected offset % instead of 352", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_base._ownsHeap has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_base) == 360, "ma_node_base has size % instead of 360", size_of(ma_node_base));
    }

    {
        info := type_info(ma_node_graph_config);
        for info.members {
            if it.name == {
                case "channels";
                    assert(it.offset_in_bytes == 0, "ma_node_graph_config.channels has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_graph_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "processingSizeInFrames";
                    assert(it.offset_in_bytes == 4, "ma_node_graph_config.processingSizeInFrames has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_graph_config.processingSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "preMixStackSizeInBytes";
                    assert(it.offset_in_bytes == 8, "ma_node_graph_config.preMixStackSizeInBytes has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_graph_config.preMixStackSizeInBytes has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_graph_config) == 16, "ma_node_graph_config has size % instead of 16", size_of(ma_node_graph_config));
    }

    {
        info := type_info(ma_node_graph);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "ma_node_graph.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_node_graph.base has unexpected size % instead of 360", it.type.runtime_size);
                case "endpoint";
                    assert(it.offset_in_bytes == 360, "ma_node_graph.endpoint has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_node_graph.endpoint has unexpected size % instead of 360", it.type.runtime_size);
                case "pProcessingCache";
                    assert(it.offset_in_bytes == 720, "ma_node_graph.pProcessingCache has unexpected offset % instead of 720", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_graph.pProcessingCache has unexpected size % instead of 8", it.type.runtime_size);
                case "processingCacheFramesRemaining";
                    assert(it.offset_in_bytes == 728, "ma_node_graph.processingCacheFramesRemaining has unexpected offset % instead of 728", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_graph.processingCacheFramesRemaining has unexpected size % instead of 4", it.type.runtime_size);
                case "processingSizeInFrames";
                    assert(it.offset_in_bytes == 732, "ma_node_graph.processingSizeInFrames has unexpected offset % instead of 732", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_graph.processingSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "isReading";
                    assert(it.offset_in_bytes == 736, "ma_node_graph.isReading has unexpected offset % instead of 736", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_node_graph.isReading has unexpected size % instead of 4", it.type.runtime_size);
                case "pPreMixStack";
                    assert(it.offset_in_bytes == 744, "ma_node_graph.pPreMixStack has unexpected offset % instead of 744", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_node_graph.pPreMixStack has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_node_graph) == 752, "ma_node_graph has size % instead of 752", size_of(ma_node_graph));
    }

    {
        info := type_info(ma_data_source_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_data_source_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_data_source_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "pDataSource";
                    assert(it.offset_in_bytes == 40, "ma_data_source_node_config.pDataSource has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_node_config.pDataSource has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_source_node_config) == 48, "ma_data_source_node_config has size % instead of 48", size_of(ma_data_source_node_config));
    }

    {
        info := type_info(ma_data_source_node);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "ma_data_source_node.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_data_source_node.base has unexpected size % instead of 360", it.type.runtime_size);
                case "pDataSource";
                    assert(it.offset_in_bytes == 360, "ma_data_source_node.pDataSource has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_data_source_node.pDataSource has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_data_source_node) == 368, "ma_data_source_node has size % instead of 368", size_of(ma_data_source_node));
    }

    {
        info := type_info(ma_splitter_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_splitter_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_splitter_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 40, "ma_splitter_node_config.channels has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_splitter_node_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "outputBusCount";
                    assert(it.offset_in_bytes == 44, "ma_splitter_node_config.outputBusCount has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_splitter_node_config.outputBusCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_splitter_node_config) == 48, "ma_splitter_node_config has size % instead of 48", size_of(ma_splitter_node_config));
    }

    {
        info := type_info(ma_splitter_node);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "ma_splitter_node.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_splitter_node.base has unexpected size % instead of 360", it.type.runtime_size);
            }
        }
        assert(size_of(ma_splitter_node) == 360, "ma_splitter_node has size % instead of 360", size_of(ma_splitter_node));
    }

    {
        info := type_info(ma_biquad_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_biquad_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_biquad_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "biquad";
                    assert(it.offset_in_bytes == 40, "ma_biquad_node_config.biquad has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_biquad_node_config.biquad has unexpected size % instead of 56", it.type.runtime_size);
            }
        }
        assert(size_of(ma_biquad_node_config) == 96, "ma_biquad_node_config has size % instead of 96", size_of(ma_biquad_node_config));
    }

    {
        info := type_info(ma_biquad_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_biquad_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_biquad_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "biquad";
                    assert(it.offset_in_bytes == 360, "ma_biquad_node.biquad has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_biquad_node.biquad has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_biquad_node) == 424, "ma_biquad_node has size % instead of 424", size_of(ma_biquad_node));
    }

    {
        info := type_info(ma_lpf_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_lpf_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_lpf_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "lpf";
                    assert(it.offset_in_bytes == 40, "ma_lpf_node_config.lpf has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_lpf_node_config.lpf has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf_node_config) == 72, "ma_lpf_node_config has size % instead of 72", size_of(ma_lpf_node_config));
    }

    {
        info := type_info(ma_lpf_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_lpf_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_lpf_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "lpf";
                    assert(it.offset_in_bytes == 360, "ma_lpf_node.lpf has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_lpf_node.lpf has unexpected size % instead of 56", it.type.runtime_size);
            }
        }
        assert(size_of(ma_lpf_node) == 416, "ma_lpf_node has size % instead of 416", size_of(ma_lpf_node));
    }

    {
        info := type_info(ma_hpf_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_hpf_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_hpf_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "hpf";
                    assert(it.offset_in_bytes == 40, "ma_hpf_node_config.hpf has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_hpf_node_config.hpf has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf_node_config) == 72, "ma_hpf_node_config has size % instead of 72", size_of(ma_hpf_node_config));
    }

    {
        info := type_info(ma_hpf_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_hpf_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_hpf_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "hpf";
                    assert(it.offset_in_bytes == 360, "ma_hpf_node.hpf has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 56, "ma_hpf_node.hpf has unexpected size % instead of 56", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hpf_node) == 416, "ma_hpf_node has size % instead of 416", size_of(ma_hpf_node));
    }

    {
        info := type_info(ma_bpf_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_bpf_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_bpf_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "bpf";
                    assert(it.offset_in_bytes == 40, "ma_bpf_node_config.bpf has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_bpf_node_config.bpf has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf_node_config) == 72, "ma_bpf_node_config has size % instead of 72", size_of(ma_bpf_node_config));
    }

    {
        info := type_info(ma_bpf_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_bpf_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_bpf_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "bpf";
                    assert(it.offset_in_bytes == 360, "ma_bpf_node.bpf has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_bpf_node.bpf has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_bpf_node) == 400, "ma_bpf_node has size % instead of 400", size_of(ma_bpf_node));
    }

    {
        info := type_info(ma_notch_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_notch_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_notch_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "notch";
                    assert(it.offset_in_bytes == 40, "ma_notch_node_config.notch has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_notch_node_config.notch has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(ma_notch_node_config) == 72, "ma_notch_node_config has size % instead of 72", size_of(ma_notch_node_config));
    }

    {
        info := type_info(ma_notch_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_notch_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_notch_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "notch";
                    assert(it.offset_in_bytes == 360, "ma_notch_node.notch has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_notch_node.notch has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_notch_node) == 424, "ma_notch_node has size % instead of 424", size_of(ma_notch_node));
    }

    {
        info := type_info(ma_peak_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_peak_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_peak_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "peak";
                    assert(it.offset_in_bytes == 40, "ma_peak_node_config.peak has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_peak_node_config.peak has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_peak_node_config) == 80, "ma_peak_node_config has size % instead of 80", size_of(ma_peak_node_config));
    }

    {
        info := type_info(ma_peak_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_peak_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_peak_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "peak";
                    assert(it.offset_in_bytes == 360, "ma_peak_node.peak has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_peak_node.peak has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_peak_node) == 424, "ma_peak_node has size % instead of 424", size_of(ma_peak_node));
    }

    {
        info := type_info(ma_loshelf_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_loshelf_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_loshelf_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "loshelf";
                    assert(it.offset_in_bytes == 40, "ma_loshelf_node_config.loshelf has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_loshelf_node_config.loshelf has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_loshelf_node_config) == 80, "ma_loshelf_node_config has size % instead of 80", size_of(ma_loshelf_node_config));
    }

    {
        info := type_info(ma_loshelf_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_loshelf_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_loshelf_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "loshelf";
                    assert(it.offset_in_bytes == 360, "ma_loshelf_node.loshelf has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_loshelf_node.loshelf has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_loshelf_node) == 424, "ma_loshelf_node has size % instead of 424", size_of(ma_loshelf_node));
    }

    {
        info := type_info(ma_hishelf_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_hishelf_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_hishelf_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "hishelf";
                    assert(it.offset_in_bytes == 40, "ma_hishelf_node_config.hishelf has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_hishelf_node_config.hishelf has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hishelf_node_config) == 80, "ma_hishelf_node_config has size % instead of 80", size_of(ma_hishelf_node_config));
    }

    {
        info := type_info(ma_hishelf_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_hishelf_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_hishelf_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "hishelf";
                    assert(it.offset_in_bytes == 360, "ma_hishelf_node.hishelf has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "ma_hishelf_node.hishelf has unexpected size % instead of 64", it.type.runtime_size);
            }
        }
        assert(size_of(ma_hishelf_node) == 424, "ma_hishelf_node has size % instead of 424", size_of(ma_hishelf_node));
    }

    {
        info := type_info(ma_delay_node_config);
        for info.members {
            if it.name == {
                case "nodeConfig";
                    assert(it.offset_in_bytes == 0, "ma_delay_node_config.nodeConfig has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_delay_node_config.nodeConfig has unexpected size % instead of 40", it.type.runtime_size);
                case "delay";
                    assert(it.offset_in_bytes == 40, "ma_delay_node_config.delay has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "ma_delay_node_config.delay has unexpected size % instead of 28", it.type.runtime_size);
            }
        }
        assert(size_of(ma_delay_node_config) == 72, "ma_delay_node_config has size % instead of 72", size_of(ma_delay_node_config));
    }

    {
        info := type_info(ma_delay_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_delay_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_delay_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "delay";
                    assert(it.offset_in_bytes == 360, "ma_delay_node.delay has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_delay_node.delay has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_delay_node) == 408, "ma_delay_node has size % instead of 408", size_of(ma_delay_node));
    }

    {
        info := type_info(ma_engine_node_config);
        for info.members {
            if it.name == {
                case "pEngine";
                    assert(it.offset_in_bytes == 0, "ma_engine_node_config.pEngine has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_node_config.pEngine has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "ma_engine_node_config.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.type has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 12, "ma_engine_node_config.channelsIn has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 16, "ma_engine_node_config.channelsOut has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 20, "ma_engine_node_config.sampleRate has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "volumeSmoothTimeInPCMFrames";
                    assert(it.offset_in_bytes == 24, "ma_engine_node_config.volumeSmoothTimeInPCMFrames has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.volumeSmoothTimeInPCMFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "monoExpansionMode";
                    assert(it.offset_in_bytes == 28, "ma_engine_node_config.monoExpansionMode has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node_config.monoExpansionMode has unexpected size % instead of 4", it.type.runtime_size);
                case "isPitchDisabled";
                    assert(it.offset_in_bytes == 32, "ma_engine_node_config.isPitchDisabled has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine_node_config.isPitchDisabled has unexpected size % instead of 1", it.type.runtime_size);
                case "isSpatializationDisabled";
                    assert(it.offset_in_bytes == 33, "ma_engine_node_config.isSpatializationDisabled has unexpected offset % instead of 33", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine_node_config.isSpatializationDisabled has unexpected size % instead of 1", it.type.runtime_size);
                case "pinnedListenerIndex";
                    assert(it.offset_in_bytes == 34, "ma_engine_node_config.pinnedListenerIndex has unexpected offset % instead of 34", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine_node_config.pinnedListenerIndex has unexpected size % instead of 1", it.type.runtime_size);
                case "resampling";
                    assert(it.offset_in_bytes == 40, "ma_engine_node_config.resampling has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_engine_node_config.resampling has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_engine_node_config) == 88, "ma_engine_node_config has size % instead of 88", size_of(ma_engine_node_config));
    }

    {
        info := type_info(ma_engine_node);
        for info.members {
            if it.name == {
                case "baseNode";
                    assert(it.offset_in_bytes == 0, "ma_engine_node.baseNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "ma_engine_node.baseNode has unexpected size % instead of 360", it.type.runtime_size);
                case "pEngine";
                    assert(it.offset_in_bytes == 360, "ma_engine_node.pEngine has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_node.pEngine has unexpected size % instead of 8", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 368, "ma_engine_node.sampleRate has unexpected offset % instead of 368", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "volumeSmoothTimeInPCMFrames";
                    assert(it.offset_in_bytes == 372, "ma_engine_node.volumeSmoothTimeInPCMFrames has unexpected offset % instead of 372", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.volumeSmoothTimeInPCMFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "monoExpansionMode";
                    assert(it.offset_in_bytes == 376, "ma_engine_node.monoExpansionMode has unexpected offset % instead of 376", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.monoExpansionMode has unexpected size % instead of 4", it.type.runtime_size);
                case "fader";
                    assert(it.offset_in_bytes == 384, "ma_engine_node.fader has unexpected offset % instead of 384", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "ma_engine_node.fader has unexpected size % instead of 40", it.type.runtime_size);
                case "resampler";
                    assert(it.offset_in_bytes == 424, "ma_engine_node.resampler has unexpected offset % instead of 424", it.offset_in_bytes);
                    assert(it.type.runtime_size == 192, "ma_engine_node.resampler has unexpected size % instead of 192", it.type.runtime_size);
                case "spatializer";
                    assert(it.offset_in_bytes == 616, "ma_engine_node.spatializer has unexpected offset % instead of 616", it.offset_in_bytes);
                    assert(it.type.runtime_size == 200, "ma_engine_node.spatializer has unexpected size % instead of 200", it.type.runtime_size);
                case "panner";
                    assert(it.offset_in_bytes == 816, "ma_engine_node.panner has unexpected offset % instead of 816", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ma_engine_node.panner has unexpected size % instead of 16", it.type.runtime_size);
                case "volumeGainer";
                    assert(it.offset_in_bytes == 832, "ma_engine_node.volumeGainer has unexpected offset % instead of 832", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_engine_node.volumeGainer has unexpected size % instead of 48", it.type.runtime_size);
                case "volume";
                    assert(it.offset_in_bytes == 880, "ma_engine_node.volume has unexpected offset % instead of 880", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.volume has unexpected size % instead of 4", it.type.runtime_size);
                case "oldVolume";
                    assert(it.offset_in_bytes == 884, "ma_engine_node.oldVolume has unexpected offset % instead of 884", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.oldVolume has unexpected size % instead of 4", it.type.runtime_size);
                case "pitch";
                    assert(it.offset_in_bytes == 888, "ma_engine_node.pitch has unexpected offset % instead of 888", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.pitch has unexpected size % instead of 4", it.type.runtime_size);
                case "oldPitch";
                    assert(it.offset_in_bytes == 892, "ma_engine_node.oldPitch has unexpected offset % instead of 892", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.oldPitch has unexpected size % instead of 4", it.type.runtime_size);
                case "oldDopplerPitch";
                    assert(it.offset_in_bytes == 896, "ma_engine_node.oldDopplerPitch has unexpected offset % instead of 896", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.oldDopplerPitch has unexpected size % instead of 4", it.type.runtime_size);
                case "isPitchDisabled";
                    assert(it.offset_in_bytes == 900, "ma_engine_node.isPitchDisabled has unexpected offset % instead of 900", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.isPitchDisabled has unexpected size % instead of 4", it.type.runtime_size);
                case "isSpatializationDisabled";
                    assert(it.offset_in_bytes == 904, "ma_engine_node.isSpatializationDisabled has unexpected offset % instead of 904", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.isSpatializationDisabled has unexpected size % instead of 4", it.type.runtime_size);
                case "pinnedListenerIndex";
                    assert(it.offset_in_bytes == 908, "ma_engine_node.pinnedListenerIndex has unexpected offset % instead of 908", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_node.pinnedListenerIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "fadeSettings";
                    assert(it.offset_in_bytes == 912, "ma_engine_node.fadeSettings has unexpected offset % instead of 912", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "ma_engine_node.fadeSettings has unexpected size % instead of 24", it.type.runtime_size);
                case "_ownsHeap";
                    assert(it.offset_in_bytes == 936, "ma_engine_node._ownsHeap has unexpected offset % instead of 936", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine_node._ownsHeap has unexpected size % instead of 1", it.type.runtime_size);
                case "_pHeap";
                    assert(it.offset_in_bytes == 944, "ma_engine_node._pHeap has unexpected offset % instead of 944", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_node._pHeap has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_engine_node) == 952, "ma_engine_node has size % instead of 952", size_of(ma_engine_node));
    }

    {
        info := type_info(ma_sound_config);
        for info.members {
            if it.name == {
                case "pFilePath";
                    assert(it.offset_in_bytes == 0, "ma_sound_config.pFilePath has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pFilePath has unexpected size % instead of 8", it.type.runtime_size);
                case "pFilePathW";
                    assert(it.offset_in_bytes == 8, "ma_sound_config.pFilePathW has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pFilePathW has unexpected size % instead of 8", it.type.runtime_size);
                case "pDataSource";
                    assert(it.offset_in_bytes == 16, "ma_sound_config.pDataSource has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pDataSource has unexpected size % instead of 8", it.type.runtime_size);
                case "pInitialAttachment";
                    assert(it.offset_in_bytes == 24, "ma_sound_config.pInitialAttachment has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pInitialAttachment has unexpected size % instead of 8", it.type.runtime_size);
                case "initialAttachmentInputBusIndex";
                    assert(it.offset_in_bytes == 32, "ma_sound_config.initialAttachmentInputBusIndex has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.initialAttachmentInputBusIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsIn";
                    assert(it.offset_in_bytes == 36, "ma_sound_config.channelsIn has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.channelsIn has unexpected size % instead of 4", it.type.runtime_size);
                case "channelsOut";
                    assert(it.offset_in_bytes == 40, "ma_sound_config.channelsOut has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.channelsOut has unexpected size % instead of 4", it.type.runtime_size);
                case "monoExpansionMode";
                    assert(it.offset_in_bytes == 44, "ma_sound_config.monoExpansionMode has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.monoExpansionMode has unexpected size % instead of 4", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 48, "ma_sound_config.flags has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "volumeSmoothTimeInPCMFrames";
                    assert(it.offset_in_bytes == 52, "ma_sound_config.volumeSmoothTimeInPCMFrames has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.volumeSmoothTimeInPCMFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "initialSeekPointInPCMFrames";
                    assert(it.offset_in_bytes == 56, "ma_sound_config.initialSeekPointInPCMFrames has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.initialSeekPointInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeBegInPCMFrames";
                    assert(it.offset_in_bytes == 64, "ma_sound_config.rangeBegInPCMFrames has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.rangeBegInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "rangeEndInPCMFrames";
                    assert(it.offset_in_bytes == 72, "ma_sound_config.rangeEndInPCMFrames has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.rangeEndInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopPointBegInPCMFrames";
                    assert(it.offset_in_bytes == 80, "ma_sound_config.loopPointBegInPCMFrames has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.loopPointBegInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "loopPointEndInPCMFrames";
                    assert(it.offset_in_bytes == 88, "ma_sound_config.loopPointEndInPCMFrames has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.loopPointEndInPCMFrames has unexpected size % instead of 8", it.type.runtime_size);
                case "endCallback";
                    assert(it.offset_in_bytes == 96, "ma_sound_config.endCallback has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.endCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "pEndCallbackUserData";
                    assert(it.offset_in_bytes == 104, "ma_sound_config.pEndCallbackUserData has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pEndCallbackUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "pitchResampling";
                    assert(it.offset_in_bytes == 112, "ma_sound_config.pitchResampling has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_sound_config.pitchResampling has unexpected size % instead of 48", it.type.runtime_size);
                case "initNotifications";
                    assert(it.offset_in_bytes == 160, "ma_sound_config.initNotifications has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_sound_config.initNotifications has unexpected size % instead of 32", it.type.runtime_size);
                case "pDoneFence";
                    assert(it.offset_in_bytes == 192, "ma_sound_config.pDoneFence has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_config.pDoneFence has unexpected size % instead of 8", it.type.runtime_size);
                case "isLooping";
                    assert(it.offset_in_bytes == 200, "ma_sound_config.isLooping has unexpected offset % instead of 200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound_config.isLooping has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ma_sound_config) == 208, "ma_sound_config has size % instead of 208", size_of(ma_sound_config));
    }

    {
        info := type_info(ma_sound);
        for info.members {
            if it.name == {
                case "engineNode";
                    assert(it.offset_in_bytes == 0, "ma_sound.engineNode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 952, "ma_sound.engineNode has unexpected size % instead of 952", it.type.runtime_size);
                case "pDataSource";
                    assert(it.offset_in_bytes == 952, "ma_sound.pDataSource has unexpected offset % instead of 952", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.pDataSource has unexpected size % instead of 8", it.type.runtime_size);
                case "seekTarget";
                    assert(it.offset_in_bytes == 960, "ma_sound.seekTarget has unexpected offset % instead of 960", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.seekTarget has unexpected size % instead of 8", it.type.runtime_size);
                case "atEnd";
                    assert(it.offset_in_bytes == 968, "ma_sound.atEnd has unexpected offset % instead of 968", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound.atEnd has unexpected size % instead of 4", it.type.runtime_size);
                case "endCallback";
                    assert(it.offset_in_bytes == 976, "ma_sound.endCallback has unexpected offset % instead of 976", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.endCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "pEndCallbackUserData";
                    assert(it.offset_in_bytes == 984, "ma_sound.pEndCallbackUserData has unexpected offset % instead of 984", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.pEndCallbackUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "pProcessingCache";
                    assert(it.offset_in_bytes == 992, "ma_sound.pProcessingCache has unexpected offset % instead of 992", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.pProcessingCache has unexpected size % instead of 8", it.type.runtime_size);
                case "processingCacheFramesRemaining";
                    assert(it.offset_in_bytes == 1000, "ma_sound.processingCacheFramesRemaining has unexpected offset % instead of 1000", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound.processingCacheFramesRemaining has unexpected size % instead of 4", it.type.runtime_size);
                case "processingCacheCap";
                    assert(it.offset_in_bytes == 1004, "ma_sound.processingCacheCap has unexpected offset % instead of 1004", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_sound.processingCacheCap has unexpected size % instead of 4", it.type.runtime_size);
                case "ownsDataSource";
                    assert(it.offset_in_bytes == 1008, "ma_sound.ownsDataSource has unexpected offset % instead of 1008", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_sound.ownsDataSource has unexpected size % instead of 1", it.type.runtime_size);
                case "pResourceManagerDataSource";
                    assert(it.offset_in_bytes == 1016, "ma_sound.pResourceManagerDataSource has unexpected offset % instead of 1016", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound.pResourceManagerDataSource has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_sound) == 1024, "ma_sound has size % instead of 1024", size_of(ma_sound));
    }

    {
        info := type_info(ma_sound_inlined);
        for info.members {
            if it.name == {
                case "sound";
                    assert(it.offset_in_bytes == 0, "ma_sound_inlined.sound has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1024, "ma_sound_inlined.sound has unexpected size % instead of 1024", it.type.runtime_size);
                case "pNext";
                    assert(it.offset_in_bytes == 1024, "ma_sound_inlined.pNext has unexpected offset % instead of 1024", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_inlined.pNext has unexpected size % instead of 8", it.type.runtime_size);
                case "pPrev";
                    assert(it.offset_in_bytes == 1032, "ma_sound_inlined.pPrev has unexpected offset % instead of 1032", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_sound_inlined.pPrev has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ma_sound_inlined) == 1040, "ma_sound_inlined has size % instead of 1040", size_of(ma_sound_inlined));
    }

    {
        info := type_info(ma_engine_config);
        for info.members {
            if it.name == {
                case "pResourceManager";
                    assert(it.offset_in_bytes == 0, "ma_engine_config.pResourceManager has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pResourceManager has unexpected size % instead of 8", it.type.runtime_size);
                case "pContext";
                    assert(it.offset_in_bytes == 8, "ma_engine_config.pContext has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pContext has unexpected size % instead of 8", it.type.runtime_size);
                case "pDevice";
                    assert(it.offset_in_bytes == 16, "ma_engine_config.pDevice has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pDevice has unexpected size % instead of 8", it.type.runtime_size);
                case "pPlaybackDeviceID";
                    assert(it.offset_in_bytes == 24, "ma_engine_config.pPlaybackDeviceID has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pPlaybackDeviceID has unexpected size % instead of 8", it.type.runtime_size);
                case "dataCallback";
                    assert(it.offset_in_bytes == 32, "ma_engine_config.dataCallback has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.dataCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "notificationCallback";
                    assert(it.offset_in_bytes == 40, "ma_engine_config.notificationCallback has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.notificationCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "pLog";
                    assert(it.offset_in_bytes == 48, "ma_engine_config.pLog has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pLog has unexpected size % instead of 8", it.type.runtime_size);
                case "listenerCount";
                    assert(it.offset_in_bytes == 56, "ma_engine_config.listenerCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.listenerCount has unexpected size % instead of 4", it.type.runtime_size);
                case "channels";
                    assert(it.offset_in_bytes == 60, "ma_engine_config.channels has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.channels has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 64, "ma_engine_config.sampleRate has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "periodSizeInFrames";
                    assert(it.offset_in_bytes == 68, "ma_engine_config.periodSizeInFrames has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.periodSizeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "periodSizeInMilliseconds";
                    assert(it.offset_in_bytes == 72, "ma_engine_config.periodSizeInMilliseconds has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.periodSizeInMilliseconds has unexpected size % instead of 4", it.type.runtime_size);
                case "gainSmoothTimeInFrames";
                    assert(it.offset_in_bytes == 76, "ma_engine_config.gainSmoothTimeInFrames has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.gainSmoothTimeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "gainSmoothTimeInMilliseconds";
                    assert(it.offset_in_bytes == 80, "ma_engine_config.gainSmoothTimeInMilliseconds has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.gainSmoothTimeInMilliseconds has unexpected size % instead of 4", it.type.runtime_size);
                case "defaultVolumeSmoothTimeInPCMFrames";
                    assert(it.offset_in_bytes == 84, "ma_engine_config.defaultVolumeSmoothTimeInPCMFrames has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.defaultVolumeSmoothTimeInPCMFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "preMixStackSizeInBytes";
                    assert(it.offset_in_bytes == 88, "ma_engine_config.preMixStackSizeInBytes has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.preMixStackSizeInBytes has unexpected size % instead of 4", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 96, "ma_engine_config.allocationCallbacks has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_engine_config.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "noAutoStart";
                    assert(it.offset_in_bytes == 128, "ma_engine_config.noAutoStart has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.noAutoStart has unexpected size % instead of 4", it.type.runtime_size);
                case "noDevice";
                    assert(it.offset_in_bytes == 132, "ma_engine_config.noDevice has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.noDevice has unexpected size % instead of 4", it.type.runtime_size);
                case "monoExpansionMode";
                    assert(it.offset_in_bytes == 136, "ma_engine_config.monoExpansionMode has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine_config.monoExpansionMode has unexpected size % instead of 4", it.type.runtime_size);
                case "pResourceManagerVFS";
                    assert(it.offset_in_bytes == 144, "ma_engine_config.pResourceManagerVFS has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pResourceManagerVFS has unexpected size % instead of 8", it.type.runtime_size);
                case "onProcess";
                    assert(it.offset_in_bytes == 152, "ma_engine_config.onProcess has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.onProcess has unexpected size % instead of 8", it.type.runtime_size);
                case "pProcessUserData";
                    assert(it.offset_in_bytes == 160, "ma_engine_config.pProcessUserData has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine_config.pProcessUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "resourceManagerResampling";
                    assert(it.offset_in_bytes == 168, "ma_engine_config.resourceManagerResampling has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_engine_config.resourceManagerResampling has unexpected size % instead of 48", it.type.runtime_size);
                case "pitchResampling";
                    assert(it.offset_in_bytes == 216, "ma_engine_config.pitchResampling has unexpected offset % instead of 216", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_engine_config.pitchResampling has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_engine_config) == 264, "ma_engine_config has size % instead of 264", size_of(ma_engine_config));
    }

    {
        info := type_info(ma_engine);
        for info.members {
            if it.name == {
                case "nodeGraph";
                    assert(it.offset_in_bytes == 0, "ma_engine.nodeGraph has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 752, "ma_engine.nodeGraph has unexpected size % instead of 752", it.type.runtime_size);
                case "pResourceManager";
                    assert(it.offset_in_bytes == 752, "ma_engine.pResourceManager has unexpected offset % instead of 752", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.pResourceManager has unexpected size % instead of 8", it.type.runtime_size);
                case "pDevice";
                    assert(it.offset_in_bytes == 760, "ma_engine.pDevice has unexpected offset % instead of 760", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.pDevice has unexpected size % instead of 8", it.type.runtime_size);
                case "pLog";
                    assert(it.offset_in_bytes == 768, "ma_engine.pLog has unexpected offset % instead of 768", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.pLog has unexpected size % instead of 8", it.type.runtime_size);
                case "sampleRate";
                    assert(it.offset_in_bytes == 776, "ma_engine.sampleRate has unexpected offset % instead of 776", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.sampleRate has unexpected size % instead of 4", it.type.runtime_size);
                case "listenerCount";
                    assert(it.offset_in_bytes == 780, "ma_engine.listenerCount has unexpected offset % instead of 780", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.listenerCount has unexpected size % instead of 4", it.type.runtime_size);
                case "listeners";
                    assert(it.offset_in_bytes == 784, "ma_engine.listeners has unexpected offset % instead of 784", it.offset_in_bytes);
                    assert(it.type.runtime_size == 448, "ma_engine.listeners has unexpected size % instead of 448", it.type.runtime_size);
                case "allocationCallbacks";
                    assert(it.offset_in_bytes == 1232, "ma_engine.allocationCallbacks has unexpected offset % instead of 1232", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "ma_engine.allocationCallbacks has unexpected size % instead of 32", it.type.runtime_size);
                case "ownsResourceManager";
                    assert(it.offset_in_bytes == 1264, "ma_engine.ownsResourceManager has unexpected offset % instead of 1264", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine.ownsResourceManager has unexpected size % instead of 1", it.type.runtime_size);
                case "ownsDevice";
                    assert(it.offset_in_bytes == 1265, "ma_engine.ownsDevice has unexpected offset % instead of 1265", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "ma_engine.ownsDevice has unexpected size % instead of 1", it.type.runtime_size);
                case "inlinedSoundLock";
                    assert(it.offset_in_bytes == 1268, "ma_engine.inlinedSoundLock has unexpected offset % instead of 1268", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.inlinedSoundLock has unexpected size % instead of 4", it.type.runtime_size);
                case "pInlinedSoundHead";
                    assert(it.offset_in_bytes == 1272, "ma_engine.pInlinedSoundHead has unexpected offset % instead of 1272", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.pInlinedSoundHead has unexpected size % instead of 8", it.type.runtime_size);
                case "inlinedSoundCount";
                    assert(it.offset_in_bytes == 1280, "ma_engine.inlinedSoundCount has unexpected offset % instead of 1280", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.inlinedSoundCount has unexpected size % instead of 4", it.type.runtime_size);
                case "gainSmoothTimeInFrames";
                    assert(it.offset_in_bytes == 1284, "ma_engine.gainSmoothTimeInFrames has unexpected offset % instead of 1284", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.gainSmoothTimeInFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "defaultVolumeSmoothTimeInPCMFrames";
                    assert(it.offset_in_bytes == 1288, "ma_engine.defaultVolumeSmoothTimeInPCMFrames has unexpected offset % instead of 1288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.defaultVolumeSmoothTimeInPCMFrames has unexpected size % instead of 4", it.type.runtime_size);
                case "monoExpansionMode";
                    assert(it.offset_in_bytes == 1292, "ma_engine.monoExpansionMode has unexpected offset % instead of 1292", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ma_engine.monoExpansionMode has unexpected size % instead of 4", it.type.runtime_size);
                case "onProcess";
                    assert(it.offset_in_bytes == 1296, "ma_engine.onProcess has unexpected offset % instead of 1296", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.onProcess has unexpected size % instead of 8", it.type.runtime_size);
                case "pProcessUserData";
                    assert(it.offset_in_bytes == 1304, "ma_engine.pProcessUserData has unexpected offset % instead of 1304", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ma_engine.pProcessUserData has unexpected size % instead of 8", it.type.runtime_size);
                case "pitchResamplingConfig";
                    assert(it.offset_in_bytes == 1312, "ma_engine.pitchResamplingConfig has unexpected offset % instead of 1312", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ma_engine.pitchResamplingConfig has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ma_engine) == 1360, "ma_engine has size % instead of 1360", size_of(ma_engine));
    }
}

