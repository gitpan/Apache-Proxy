#ifdef MOD_PERL
#include "mod_perl.h"
#include "../proxy/mod_proxy.h"
#else
#include "modules/perl/mod_perl.h"
#include "modules/proxy/mod_proxy.h"
#endif

MODULE = Apache::Proxy		PACKAGE = Apache::Proxy		

int
pass(self, r, uri)
    SV *self
    Apache r
    char *uri

    PREINIT:
    struct cache_req *c = (struct cache_req *)safemalloc(sizeof(struct cache_req));

    CODE: 
    c->fp = NULL;
    c->req = r;

    RETVAL = ap_proxy_http_handler(r, c, uri, NULL, 0);
    safefree(c);
    OUTPUT:
    RETVAL
