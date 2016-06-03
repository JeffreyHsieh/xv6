#include "types.h"
#include "user.h"

// Test functions for yielding, prints "beep" and "boop".
void beep(void * arg_ptr);
void boop(void * arg_ptr);

int main(){
  int arg = 10;
  void *tid = thread_create(beep, (void *) &arg);
  if(tid <= 0){
    printf(1, "Thread Creation Failed\n");
    exit();
  }
  while(wait()>=0);

  exit();
  return 0;
}

// Beep
void beep(void *arg_ptr){
  printf(1, "beep\n");
  texit();
}

// Boop
void boop(void *arg_ptr){
  printf(1, "boop\n");
  texit();
}

