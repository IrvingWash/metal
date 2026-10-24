#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER                 = DEBUG,
    TEMP_ALLOCATOR_OVERWRITE_MEMORY = DEBUG,
);

Renderer :: #import,dir "Renderer"()(DEBUG = DEBUG);

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    print("Hello, Sailor!\n");

    reset_temporary_storage();
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
