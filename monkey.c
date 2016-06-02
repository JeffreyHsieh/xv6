// Hello Robyn ~ Thank you so much for doing this, really. I added additional
// cases you asked for, which includes nMonkey going in between several dMonkeys (D-D-D-N-N-D).
// This test case shows that normal ones were pushed back, which I think its good.
// For my part, I couldn't figure out what to insert for the queue, I thought it would work but
// turns out it didn't. 

/*
 * This works the majority of the time but is slightly buggy.
 * Somtimes it will not run and sometimes it will print at the incorrect
 * times. These errors are likely due to thread synchronization.
 */

#include "types.h"
#include "user.h"
#include "semaphore.h"

//Semaphore for tree climbing
struct Semaphore *tree = 0;
//Semaphore for clean printing
struct Semaphore *p = 0;
struct Semaphore *d = 0;
//Int used in creating threads
int arg = 10;
int colony;
int domClimbing = 0;
//void * used for creating threads
void *tid;

void nMonkey();
void dMonkey();
void printAction(char a[]);

int main(){
	tree = malloc(sizeof(struct Semaphore));
	p = malloc(sizeof(struct Semaphore));
	d = malloc(sizeof(struct Semaphore));
	sem_init(d, 1);
	sem_init(p, 1);

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 3; colony++){
		tid = thread_create(nMonkey, (void *) &arg);
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 6; colony++){
		tid = thread_create(nMonkey, (void *) &arg);
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 12; colony++){
		tid = thread_create(nMonkey, (void *) &arg);
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
	
	//Test c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N)
	printAction("\nTest c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N):\n");
	sem_init(tree, 3);
	
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	
	//Test c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D)
	printAction("\nTest c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D):\n");
	sem_init(tree, 3);
	
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	
	//Test c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N)
	printAction("\nTest c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N):\n");
	sem_init(tree, 3);
	
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	
	//Test c-4: 2 normal monkeys 3 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-4: 2 normal monkeys 4 dominant monkey (Thread creation order: D->D->D->N->N->D):\n");
	sem_init(tree, 3);
	
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}

	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	
	//Test c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->N->D->D->D->D):\n");
	sem_init(tree, 3);
	
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(nMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	tid = thread_create(dMonkey, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	exit();
	return 0;
}

void nMonkey(){
	sem_acquire(d);
	sem_signal(d);
	printAction("Normal monkey begins climbing\n");
	
	int i;
	for(i = 0; i < 2999999; i++){
		if(domClimbing > 0){
			printAction("Normal monkey waits\n");
			i = 29999999;
		}
	}
	
	sem_acquire(d);
	sem_signal(d);
	sem_acquire(tree);
	printAction("Normal monkey acquires coconut (Semaphore)\n");
	
	for(i = 0; i < 2999999; i++);
	
	printAction("Normal monkey descends\n");

	sem_signal(tree);
	
	texit();
}

void dMonkey(){
	sem_acquire(d);
	printAction("Dominant monkey begins climbing\n");
	sem_acquire(p);
	domClimbing++;
	sem_signal(p);

	int i = 0;
	for(i = 0; i < 2999999; i++);

	sem_acquire(tree);
	printAction("Dominant monkey acquires coconut (Semaphore)\n");
	sem_acquire(p);
	domClimbing--;
	sem_signal(p);
	sem_signal(d);

	for(i = 0; i < 2999999; i++);
	
	printAction("Dominant monkey descends\n");
	
	sem_signal(tree);
	
	texit();
}

void printAction(char a[]){
	sem_acquire(p);
	printf(1, "%s", a);
	sem_signal(p);
}
