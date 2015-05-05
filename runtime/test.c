#include "runtime.h"
#include <stdio.h>

int main() {
    pyobj a;
    big_pyobj b;
    tag(a);
    copy(a);

    is_int(a);
    is_bool(a);
    is_big(a);
    is_function(a);
    is_object(a);
    is_class(a);
    is_unbound_method(a);
    is_bound_method(a);

    inject_int(0);
    inject_bool(0);
    inject_big(&b);

    project_int(a);
    project_bool(a);
    project_big(a);

    is_true(a);
    print_any(a);
    input_int();

    create_list(a);
    create_dict();
    set_subscript(a, a, a);
    get_subscript(a, a);

    add(&b, &b);
    equal(&b, &b);
    not_equal(&b, &b);

    //pyobj a = inject_int(9);
    //printf("My int, %d", project_int(a));
}
