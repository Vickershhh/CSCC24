#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <getopt.h>
#include <stdlib.h>
#include "pagetable.h"
#include "sim.h"

#define MAXLINE 256

extern int debug;

extern struct frame *coremap;

// this buf store all flie from trace file
char buf[MAXLINE];

// the total length of trace
unsigned long total_length;

// store all address of all trace file
addr_t *buf_trace;

// current address
unsigned long curr;


/* Page to evict is chosen using the optimal (aka MIN) algorithm. 
 * Returns the page frame number (which is also the index in the coremap)
 * for the page that is to be evicted.
 */
int opt_evict() {
	unsigned long init = 0;
	// we will go through the coremap to find the biggest time stamp
	int i;
	int page_frame = 0;
	for (i = 0; i < memsize; i++) {
		unsigned int stamp =  coremap[i].pte->timestamp;
		if (init < stamp) {
			init = stamp;
			page_frame = i;
		}
	}
	// return the page
	return page_frame;
}

/* This function is called on each access to a page to update any information
 * needed by the opt algorithm.
 * Input: The page table entry for the page that is being accessed.
 */
void opt_ref(pgtbl_entry_t *p) {

	// start at the next location of curr
	unsigned long i = curr + 1;
	// set a signal
	int signal = 0;
	while (i < total_length) {
		if ((p->frame >> PAGE_SHIFT) == buf_trace[i]) {
			p->timestamp = i-curr;
			signal = 1;
			break;
		}
		i++;
	}
	if (signal == 0) {
		p->timestamp = total_length - curr;
	}
	curr++;
}

/* Initializes any data structures needed for this
 * replacement algorithm.
 */
// initialize by reading all the trace files and storing them into 
void opt_init() {

	// create a FILE object
	FILE *file_open;
	// try to read trace file
	// and exit if fail
	if(!(file_open = fopen(tracefile, "r"))) {
		exit(1);
	}

	// caculate the total length of trace file
	total_length = 0;
	while(fgets(buf, MAXLINE, file_open) != NULL) {
		if(buf[0] != '=') {
			total_length++;
		}
	}
	int m = 0;
	// malloc space
	buf_trace = (addr_t *)malloc(total_length * sizeof(addr_t));
	addr_t read_trace;
	char type;
	while(fgets(buf, MAXLINE, file_open) != NULL) {
		if(buf[0] != '=') {
			sscanf(buf, "%c %lx", &type, &read_trace);
			// I shift the lower 12 bits in order to get the frame number
			buf_trace[m] = read_trace >> PAGE_SHIFT;
			m++;
		}
	}

	// initialize curr as 0
	curr = 0;

	fclose(file_open);

}