#include "types.h"
#include "user.h"
#include "semaphore.h"

//Semaphore for boat crossing
struct Semaphore *boat = 0;
//Semaphore for clean printing
struct Semaphore *p = 0;
struct Semaphore *d = 0;
//Int used in creating threads
int arg = 10;
int crossing = 0;
int crossed = 0;
int pass = 0;
int missi = 0;
int canni = 0;
int i;
//void * used for creating threads
void *tid;

void MissionaryArrives();
void CannibalArrives();
void RowBoat();
void printAction(char a[]);

int main(){
	boat = malloc(sizeof(struct Semaphore));
	p = malloc(sizeof(struct Semaphore));
	d = malloc(sizeof(struct Semaphore));
	sem_init(d, 1);
	sem_init(p, 1);
	//Test a-1: 2 missionary and 1 cannibal, arrival order: C->C->M->M->C->M
	printAction("Test 1: 2 Missionaries and 1 cannibal, arrival order: M->C->M\n");
	sem_init(boat, 3);
	// Number of cross for testing
    crossing = 1;
    // Current crossed set to 0
    crossed = 0;
    pass = 0;

	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
	{
	    if(boat->count == 0){
    	    tid = thread_create(RowBoat, (void *) &arg);
        	if(tid <= 0){
        		printAction("Failed to create a thread\n");
        		exit();
        	}
        	while(wait()>= 0);
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
	
	//Test 2: 3 missionaries and 3 cannibals, arrival order: C->C->M->M->C->M
	printAction("\nTest 2: 3 Missionaries and 3 cannibal, arrival order: C->C->M->M->C->M\n");
	sem_init(boat, 3);
	// Number of cross for testing
    crossing = 2;
    crossed = 0;
    pass = 0;
	
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
	{
	    if(boat->count == 0){
    	    tid = thread_create(RowBoat, (void *) &arg);
        	if(tid <= 0){
        		printAction("Failed to create a thread\n");
        		exit();
        	}
        	while(wait()>= 0);
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    
	//Test 3: 4 missionaries and 2 cannibals, arrival order: M->C->C->M->M->M
	printAction("\nTest 3: 4 Missionaries and 2 cannibal, arrival order: M->C->C->M->M->M\n");
	sem_init(boat, 3);
	// Number of cross for testing
    crossing = 2;
    crossed = 0;
	pass = 0;
	
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
	{
	    if(boat->count == 0){
    	    tid = thread_create(RowBoat, (void *) &arg);
        	if(tid <= 0){
        		printAction("Failed to create a thread\n");
        		exit();
        	}
        	while(wait()>= 0);
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
	
	//Test 4: 4 missionaries and 5 cannibals, arrival order: C->M->C->M->M->M->C->C->C
	printAction("\nTest 4: 4 Missionaries and 5 cannibal, arrival order: C->M->C->M->M->M->C->C->C\n");
	sem_init(boat, 3);
	// Number of cross for testing
    crossing = 3;
    crossed = 0;
	pass = 0;
	
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(MissionaryArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	tid = thread_create(CannibalArrives, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	
	while(boat->count != 0);
	tid = thread_create(RowBoat, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	sem_acquire(p);
	pass = 0;
	sem_signal(p);
	for(i = 0; i < 999999; i++);
	
	while(boat->count != 0);
	tid = thread_create(RowBoat, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	sem_acquire(p);
	pass = 0;
	sem_signal(p);
	for(i = 0; i < 999999; i++);
	
	while(boat->count != 0);
	tid = thread_create(RowBoat, (void *) &arg);
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	while(wait()>= 0);
	sem_acquire(p);
	pass = 0;
	sem_signal(p);
	for(i = 0; i < 999999; i++);
    while(wait()>= 0);
	
	exit();
	return 0;
}

// Missionary
void MissionaryArrives(){
	sem_acquire(d);
	printAction("A missionary arrived\n");
	sem_signal(d);
	
	// If there are 2 cannibals, then wait.
	while(canni >= 2);
	sem_acquire(d);
	sem_signal(d);
	sem_acquire(boat);
	sem_acquire(d);
	sem_acquire(p);
	missi++;
	sem_signal(p);
	printAction("A missionary is waiting on the boat\n");
	// Missonary acquires a spot.
	sem_signal(d);
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
	// Signals for an open spot, then returns.
    //sem_signal(boat);
	texit();
}

// Cannibal
void CannibalArrives(){
	sem_acquire(d);
	printAction("A cannibal arrived\n");
	sem_signal(d);
	
	// If there is only one missionary and only 1 spot left, then wait.
	while(missi == 1 && boat->count == 1);
	sem_acquire(d);
	sem_signal(d);
	sem_acquire(boat);
	sem_acquire(d);
	sem_acquire(p);
	canni++;
	sem_signal(p);
	printAction("A cannibal is waiting on the boat\n");
	// Cannibal acquires a spot.
	sem_signal(d);
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
	
	// Signals for an open spot, then returns.
	//sem_signal(boat);
	texit();
}

// RowBoat
void RowBoat(){
	printAction("Preparing boat\n");
	sem_acquire(p);
    pass = 0;
    sem_signal(p);
    // While the boat is not full, wait.
    while(boat->count != 0);
    sem_acquire(d);
    printAction("Enjoy your trip, the boat is crossing!\n");
    // Signals available boat spots, reset.
    while(missi > 0){
		printAction("Missionary crossed the river\n");
		sem_acquire(p);
		missi--;
		sem_signal(p);
    }
    while(canni > 0){
		printAction("Cannibal crossed the river\n");
		sem_acquire(p);
		canni--;
		sem_signal(p);
    }
    sem_acquire(p);
    pass = 1;
    sem_signal(p);
    printAction("The boat is clear!\n");
    sem_acquire(p);
    crossed++;
    sem_signal(p);
    sem_signal(boat);
    sem_signal(boat);
    sem_signal(boat);
    sem_signal(d);
    
    texit();
}

// PrintAction
void printAction(char a[]){
	sem_acquire(p);
	printf(1, "%s", a);
	sem_signal(p);
}
