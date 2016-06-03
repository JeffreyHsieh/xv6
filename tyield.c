#include "types.h"
#include "user.h"

// Test functions for yielding, prints "beep" and "boop".
void one(void * arg_ptr);
void two(void * arg_ptr);

int main(){
  int arg = 10;
  void *tid;
  int i;

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

void one(void *arg_ptr){
	int j;
	
	for(j = 0; j < 2999999; j++);
	thread_yield();
	printf(1, "one\n");
	
	for(j = 0; j < 2999999; j++);
	thread_yield();
	printf(1, "one\n");
	
	for(j = 0; j < 2999999; j++);
	thread_yield();
	printf(1, "one\n");
	
	for(j = 0; j < 2999999; j++);
	thread_yield();
	printf(1, "one\n");
	
	for(j = 0; j < 2999999; j++);
	thread_yield();
	printf(1, "one\n");
	
  texit();
}

void two(void *arg_ptr){
	int j;
	
	for(j = 0; j < 2999999; j++);
	printf(1, "two\n");
	thread_yield();
	
	for(j = 0; j < 2999999; j++);
	printf(1, "two\n");
	thread_yield();
	
	for(j = 0; j < 2999999; j++);
	printf(1, "two\n");
	thread_yield();
	
	for(j = 0; j < 2999999; j++);
	printf(1, "two\n");
	thread_yield();
	
	for(j = 0; j < 2999999; j++);
	printf(1, "two\n");
	
  texit();
}

