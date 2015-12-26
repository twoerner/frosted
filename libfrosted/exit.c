/*
 * Frosted version of exit.
 */

#include "frosted_api.h"
#include "syscall_table.h"
#include <errno.h>
#undef errno
extern int errno;
extern int sys_exit(int val);

int exit(int val)
{
    return sys_exit(val);
}

/* do not define _syscalls, they are defined by newlib syscall stubs */
/*
int _exit(int val) {
    return sys_exit(val);
}
*/

