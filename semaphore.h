struct nodes{
    int values;
    struct nodes *nexts;
};

struct queues{
    int sizes;
    struct nodes * heads;
    struct nodes * tails;
};

// queue library
void init_qs(struct queues *);
void add_qs(struct queues *, int);
int empty_qs(struct queues *);
int pop_qs(struct queues *);

void init_qs(struct queues *q){
    q->sizes = 0;
    q->heads = 0;
    q->tails = 0;
}

void add_qs(struct queues *q, int v){
    struct nodes * n = malloc(sizeof(struct nodes));
    n->nexts = 0;
    n->values = v;
    if(q->heads == 0){
        q->heads = n;
    }else{
        q->tails->nexts = n;
    }
    q->tails = n;
    q->sizes++;
}

int empty_qs(struct queues *q){
    if(q->sizes == 0)
        return 1;
    else
        return 0;
} 
int pop_qs(struct queues *q){
    int val;
    struct nodes *destroy;
    if(!empty_qs(q)){
       val = q->heads->values; 
       destroy = q->heads;
       q->heads = q->heads->nexts;
       free(destroy);
       q->sizes--;
       if(q->sizes == 0){
            q->heads = 0;
            q->tails = 0;
       }
       return val;
    }
    return -1;
}

//Semaphore
struct Semaphore{
  int count;
  int maxCount;
  lock_t lock;
  struct queues pRobyn;
};

//Initialize Semaphore
void sem_init(struct Semaphore *s, int c){
  s->count = c;
  s->maxCount = c;
  init_qs(&(s->pRobyn));
  lock_init(&s->lock);
}

//Acquire Semaphore
void sem_acquire(struct Semaphore *s){
  if(s->count > 0){
    lock_acquire(&s->lock);
    s->count--;
    lock_release(&s->lock);
  }
  else{
    lock_acquire(&s->lock);
    add_qs(&(s->pRobyn), getpid());
    lock_release(&s->lock);
    tsleep();
    sem_acquire(s);
  }
}

//Signal Semaphore
void sem_signal(struct Semaphore *s){
	if(s->count < s->maxCount){
		lock_acquire(&s->lock);
		s->count++;
		lock_release(&s->lock);
		
		if(empty_qs(&(s->pRobyn)) == 0){
			twakeup(pop_qs(&(s->pRobyn)));
		}
	}
}

