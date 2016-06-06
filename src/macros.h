#define GTK_INVALID_INIT_METHOD				      \
	@try {						                        \
		[self doesNotRecognizeSelector: _cmd];	\
	} @catch (id e) {			              	    \
		@throw e;				                        \
	}						                              \
							                              \
	abort();
