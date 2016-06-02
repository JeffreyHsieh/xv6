/*
 * This works the majority of the time but is slightly buggy.
 * Somtimes it will not run and sometimes it will print at the incorrect
 * times. These errors are likely due to thread synchronization.
 */

#include "types.h"
#include "user.h"
#include "semaphore.h"

//Semaphore for hydrogens
struct Semaphore *h =  0;
//Semaphore for oxygens
struct Semaphore *o = 0;
//Semaphore for clean printing
struct Semaphore *p = 0;
//Int used in creating threads
int arg = 10;
//int for number of water to be printed in a test
int water;
//void * used for creating threads
void *tid;
int i;

void hReady();
void oReady();

int main(){
	h = malloc(sizeof(struct Semaphore));
	o = malloc(sizeof(struct Semaphore));
	p = malloc(sizeof(struct Semaphore));
	sem_init(p, 1);

	// Test 1: 2 hydrogen 1 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 1; water++){
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(oReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
	
	// Test 2: 20 hydrogen 10 oxygen (Thread creation order: O->H->H)
	sem_acquire(p);
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
		tid = thread_create(oReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
	
	// Test 3: 20 hydrogen 10 oxygen (Thread creation order: H->O->H)
	sem_acquire(p);
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(oReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
	
	// Test 4: 20 hydrogen 10 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(hReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
		tid = thread_create(oReady, (void *) &arg);
		if(tid <= 0){
			sem_acquire(p);
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
	
	exit();
	return 0;
}

//Hydrogen
void hReady(){
	sem_acquire(p);
	printf(1, "Hydrogen ready\n");
	sem_signal(p);
	sem_acquire(h);
	if(h->count == 0 && o->count == 0){
		sem_acquire(p);
		printf(1, "*Water created*\n");
		sem_signal(p);
		sem_signal(h);
		sem_signal(h);
		sem_signal(o);
	}
	texit();
}

//Oxygen 
void oReady(){
	sem_acquire(p);
	printf(1, "Oxygen ready\n");
	sem_signal(p);
	sem_acquire(o);
	if(h->count == 0 && o->count == 0){
		sem_acquire(p);
		printf(1, "*Water created*\n");
		sem_signal(p);
		sem_signal(h);
		sem_signal(h);
		sem_signal(o);
	}
	texit();
}
