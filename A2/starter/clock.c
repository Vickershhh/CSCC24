#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <getopt.h>
#include <stdlib.h>
#include "pagetable.h"


extern int memsize;

extern int debug;

extern struct frame *coremap;

int evict = 0;

/* Page to evict is chosen using the clock algorithm.
 * Returns the page frame number (which is also the index in the coremap)
 * for the page that is to be evicted.
 */

int clock_evict() {

	// Create a loop to find the page
	while ((coremap[evict].pte->frame) & PG_REF) {
		// Set the frame  to REF
		coremap[evict].pte->frame &= ~PG_REF;
		// add one more evict
		evict++;
		// if next is the last evict, go to the first one
		// If we dont have this code,it will cause segment fault.
		if (evict == memsize) {
			evict = 0;
		}
	}
	// return evict
	return evict;
}

/* This function is called on each access to a page to update any information
 * needed by the clock algorithm.
 * Input: The page table entry for the page that is being accessed.
 */
void clock_ref(pgtbl_entry_t *p) {

	// Set the Ref Bit High
	p->frame |= PG_REF;

}

/* Initialize any data structures needed for this replacement
 * algorithm. 
 */
void clock_init() {
	evict = 0;
}