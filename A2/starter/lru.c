#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <getopt.h>
#include <stdlib.h>
#include "pagetable.h"


extern int memsize;

extern int debug;

extern struct frame *coremap;

// Create a location where to evict
int evict;

/* Page to evict is chosen using the accurate LRU algorithm.
 * Returns the page frame number (which is also the index in the coremap)
 * for the page that is to be evicted.
 */

int lru_evict() {
	
	int old = evict;
	// Create a victim and init as 0
	int page_frame  = 0;
	// 
	int i;
	for (i = 0; i < memsize; i++) {
		unsigned int new_timestamp = coremap[i].pte-> timestamp;
		if (new_timestamp < old) {
			old = new_timestamp;
			page_frame  = i;
		}
	}
	return page_frame;
}

/* This function is called on each access to a page to update any information
 * needed by the lru algorithm.
 * Input: The page table entry for the page that is being accessed.
 */
void lru_ref(pgtbl_entry_t *p) {
	// We set the timestamp of p to the evict
	p->timestamp = evict;
	// Then add one more page;
	evict++;
}


/* Initialize any data structures needed for this 
 * replacement algorithm 
 */
void lru_init() {
	evict = 0;
}
