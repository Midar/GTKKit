
// Our version of NS_ENUM.
#ifndef OF_ENUM
#define OF_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

// This macro sets the class used as the app delegate, and provides the
// main() function.
#define GTK_APPLICATION_DELEGATE(cls)                           \
of_thread_t objfw_thread;                                       \
const of_thread_attr_t objfw_thread_attr;                       \
static int *_argc;                                              \
static char ***_argv;                                           \
                                                                \
void                                                            \
gtkkit_application_main(id param)                               \
{                                                               \
   of_application_main(_argc, _argv, [cls class]);              \
}                                                               \
                                                                \
int                                                             \
main(int argc, char *argv[])                                    \
{                                                               \
   _argc = &argc;                                               \
   _argv = &argv;                                               \
   gtk_init(&argc, &argv);                                      \
   of_thread_new(&objfw_thread, &gtkkit_application_main,       \
                 nil, &objfw_thread_attr);                      \
   gtk_main();                                                  \
}                                                               \
