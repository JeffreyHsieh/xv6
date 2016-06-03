#include "types.h"
#include "user.h"

// Test functions for yielding, prints "beep" and "boop".
void one(void * arg_ptr);
void two(void * arg_ptr);

int i;

int main(){
  int arg = 10;
  void *tid;

	tid = thread_create(one, (void *) &arg);
	if(tid <= 0){
		printf(1, "Thread Creation Failed\n");
		exit();
	}
	for(i = 0; i < 2999999; i++);
	tid = thread_create(two, (void *) &arg);
	if(tid <= 0){
		printf(1, "Thread Creation Failed\n");
		exit();
	}
	for(i = 0; i < 2999999; i++);
  while(wait()>=0);

  exit();
  return 0;
}

// Beep
void one(void *arg_ptr){
	for(i = 0; i < 20; i++){
		printf(1, "fdaaa\n");
		thread_yield();
		printf(1, "one\n");
	}
  texit();
}

// Boop
void two(void *arg_ptr){
	for(i = 0; i < 20; i++){
		printf(1, "gfsd\n");
		thread_yield();
		printf(1, "two\n");
	}
  texit();
}

