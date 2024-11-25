/* sdl_block_screensaver_inhibit.c */

#include <stdio.h>

#ifdef __i386__
static char* arch = "x86";
#else
static char* arch = "x64";
#endif

void SDL_DisableScreenSaver(void) {
	fprintf(stderr, "[%s] prevented SDL_DisableScreenSaver()\n", arch);
}
