
_river:     file format elf32-i386


Disassembly of section .text:

00001000 <init_qs>:
void init_qs(struct queues *);
void add_qs(struct queues *, int);
int empty_qs(struct queues *);
int pop_qs(struct queues *);

void init_qs(struct queues *q){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    q->sizes = 0;
    1003:	8b 45 08             	mov    0x8(%ebp),%eax
    1006:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->heads = 0;
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tails = 0;
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1020:	5d                   	pop    %ebp
    1021:	c3                   	ret    

00001022 <add_qs>:

void add_qs(struct queues *q, int v){
    1022:	55                   	push   %ebp
    1023:	89 e5                	mov    %esp,%ebp
    1025:	83 ec 28             	sub    $0x28,%esp
    struct nodes * n = malloc(sizeof(struct nodes));
    1028:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    102f:	e8 1d 19 00 00       	call   2951 <malloc>
    1034:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->nexts = 0;
    1037:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->values = v;
    1041:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1044:	8b 55 0c             	mov    0xc(%ebp),%edx
    1047:	89 10                	mov    %edx,(%eax)
    if(q->heads == 0){
    1049:	8b 45 08             	mov    0x8(%ebp),%eax
    104c:	8b 40 04             	mov    0x4(%eax),%eax
    104f:	85 c0                	test   %eax,%eax
    1051:	75 0b                	jne    105e <add_qs+0x3c>
        q->heads = n;
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1059:	89 50 04             	mov    %edx,0x4(%eax)
    105c:	eb 0c                	jmp    106a <add_qs+0x48>
    }else{
        q->tails->nexts = n;
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8b 40 08             	mov    0x8(%eax),%eax
    1064:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1067:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tails = n;
    106a:	8b 45 08             	mov    0x8(%ebp),%eax
    106d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1070:	89 50 08             	mov    %edx,0x8(%eax)
    q->sizes++;
    1073:	8b 45 08             	mov    0x8(%ebp),%eax
    1076:	8b 00                	mov    (%eax),%eax
    1078:	8d 50 01             	lea    0x1(%eax),%edx
    107b:	8b 45 08             	mov    0x8(%ebp),%eax
    107e:	89 10                	mov    %edx,(%eax)
}
    1080:	c9                   	leave  
    1081:	c3                   	ret    

00001082 <empty_qs>:

int empty_qs(struct queues *q){
    1082:	55                   	push   %ebp
    1083:	89 e5                	mov    %esp,%ebp
    if(q->sizes == 0)
    1085:	8b 45 08             	mov    0x8(%ebp),%eax
    1088:	8b 00                	mov    (%eax),%eax
    108a:	85 c0                	test   %eax,%eax
    108c:	75 07                	jne    1095 <empty_qs+0x13>
        return 1;
    108e:	b8 01 00 00 00       	mov    $0x1,%eax
    1093:	eb 05                	jmp    109a <empty_qs+0x18>
    else
        return 0;
    1095:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    109a:	5d                   	pop    %ebp
    109b:	c3                   	ret    

0000109c <pop_qs>:
int pop_qs(struct queues *q){
    109c:	55                   	push   %ebp
    109d:	89 e5                	mov    %esp,%ebp
    109f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct nodes *destroy;
    if(!empty_qs(q)){
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	89 04 24             	mov    %eax,(%esp)
    10a8:	e8 d5 ff ff ff       	call   1082 <empty_qs>
    10ad:	85 c0                	test   %eax,%eax
    10af:	75 5d                	jne    110e <pop_qs+0x72>
       val = q->heads->values; 
    10b1:	8b 45 08             	mov    0x8(%ebp),%eax
    10b4:	8b 40 04             	mov    0x4(%eax),%eax
    10b7:	8b 00                	mov    (%eax),%eax
    10b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->heads;
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	8b 40 04             	mov    0x4(%eax),%eax
    10c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->heads = q->heads->nexts;
    10c5:	8b 45 08             	mov    0x8(%ebp),%eax
    10c8:	8b 40 04             	mov    0x4(%eax),%eax
    10cb:	8b 50 04             	mov    0x4(%eax),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    10d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10d7:	89 04 24             	mov    %eax,(%esp)
    10da:	e8 39 17 00 00       	call   2818 <free>
       q->sizes--;
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 00                	mov    (%eax),%eax
    10e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	89 10                	mov    %edx,(%eax)
       if(q->sizes == 0){
    10ec:	8b 45 08             	mov    0x8(%ebp),%eax
    10ef:	8b 00                	mov    (%eax),%eax
    10f1:	85 c0                	test   %eax,%eax
    10f3:	75 14                	jne    1109 <pop_qs+0x6d>
            q->heads = 0;
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tails = 0;
    10ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1102:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1109:	8b 45 f4             	mov    -0xc(%ebp),%eax
    110c:	eb 05                	jmp    1113 <pop_qs+0x77>
    }
    return -1;
    110e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1113:	c9                   	leave  
    1114:	c3                   	ret    

00001115 <sem_init>:
  lock_t lock;
  struct queues pRobyn;
};

//Initialize Semaphore
void sem_init(struct Semaphore *s, int c){
    1115:	55                   	push   %ebp
    1116:	89 e5                	mov    %esp,%ebp
    1118:	83 ec 18             	sub    $0x18,%esp
  s->count = c;
    111b:	8b 45 08             	mov    0x8(%ebp),%eax
    111e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1121:	89 10                	mov    %edx,(%eax)
  s->maxCount = c;
    1123:	8b 45 08             	mov    0x8(%ebp),%eax
    1126:	8b 55 0c             	mov    0xc(%ebp),%edx
    1129:	89 50 04             	mov    %edx,0x4(%eax)
  init_qs(&(s->pRobyn));
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	83 c0 0c             	add    $0xc,%eax
    1132:	89 04 24             	mov    %eax,(%esp)
    1135:	e8 c6 fe ff ff       	call   1000 <init_qs>
  lock_init(&s->lock);
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
    113d:	83 c0 08             	add    $0x8,%eax
    1140:	89 04 24             	mov    %eax,(%esp)
    1143:	e8 06 19 00 00       	call   2a4e <lock_init>
}
    1148:	c9                   	leave  
    1149:	c3                   	ret    

0000114a <sem_acquire>:

//Acquire Semaphore
void sem_acquire(struct Semaphore *s){
    114a:	55                   	push   %ebp
    114b:	89 e5                	mov    %esp,%ebp
    114d:	83 ec 18             	sub    $0x18,%esp
  if(s->count > 0){
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	8b 00                	mov    (%eax),%eax
    1155:	85 c0                	test   %eax,%eax
    1157:	7e 2b                	jle    1184 <sem_acquire+0x3a>
    lock_acquire(&s->lock);
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	83 c0 08             	add    $0x8,%eax
    115f:	89 04 24             	mov    %eax,(%esp)
    1162:	e8 f5 18 00 00       	call   2a5c <lock_acquire>
    s->count--;
    1167:	8b 45 08             	mov    0x8(%ebp),%eax
    116a:	8b 00                	mov    (%eax),%eax
    116c:	8d 50 ff             	lea    -0x1(%eax),%edx
    116f:	8b 45 08             	mov    0x8(%ebp),%eax
    1172:	89 10                	mov    %edx,(%eax)
    lock_release(&s->lock);
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	83 c0 08             	add    $0x8,%eax
    117a:	89 04 24             	mov    %eax,(%esp)
    117d:	e8 fa 18 00 00       	call   2a7c <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 ca 18 00 00       	call   2a5c <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 a5 13 00 00       	call   253c <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 c5 18 00 00       	call   2a7c <lock_release>
    tsleep();
    11b7:	e8 b0 13 00 00       	call   256c <tsleep>
    sem_acquire(s);
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	89 04 24             	mov    %eax,(%esp)
    11c2:	e8 83 ff ff ff       	call   114a <sem_acquire>
  }
}
    11c7:	c9                   	leave  
    11c8:	c3                   	ret    

000011c9 <sem_signal>:

//Signal Semaphore
void sem_signal(struct Semaphore *s){
    11c9:	55                   	push   %ebp
    11ca:	89 e5                	mov    %esp,%ebp
    11cc:	83 ec 18             	sub    $0x18,%esp
	if(s->count < s->maxCount){
    11cf:	8b 45 08             	mov    0x8(%ebp),%eax
    11d2:	8b 10                	mov    (%eax),%edx
    11d4:	8b 45 08             	mov    0x8(%ebp),%eax
    11d7:	8b 40 04             	mov    0x4(%eax),%eax
    11da:	39 c2                	cmp    %eax,%edx
    11dc:	7d 51                	jge    122f <sem_signal+0x66>
		lock_acquire(&s->lock);
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	83 c0 08             	add    $0x8,%eax
    11e4:	89 04 24             	mov    %eax,(%esp)
    11e7:	e8 70 18 00 00       	call   2a5c <lock_acquire>
		s->count++;
    11ec:	8b 45 08             	mov    0x8(%ebp),%eax
    11ef:	8b 00                	mov    (%eax),%eax
    11f1:	8d 50 01             	lea    0x1(%eax),%edx
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	89 10                	mov    %edx,(%eax)
		lock_release(&s->lock);
    11f9:	8b 45 08             	mov    0x8(%ebp),%eax
    11fc:	83 c0 08             	add    $0x8,%eax
    11ff:	89 04 24             	mov    %eax,(%esp)
    1202:	e8 75 18 00 00       	call   2a7c <lock_release>
		
		if(empty_qs(&(s->pRobyn)) == 0){
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	83 c0 0c             	add    $0xc,%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 6d fe ff ff       	call   1082 <empty_qs>
    1215:	85 c0                	test   %eax,%eax
    1217:	75 16                	jne    122f <sem_signal+0x66>
			twakeup(pop_qs(&(s->pRobyn)));
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	83 c0 0c             	add    $0xc,%eax
    121f:	89 04 24             	mov    %eax,(%esp)
    1222:	e8 75 fe ff ff       	call   109c <pop_qs>
    1227:	89 04 24             	mov    %eax,(%esp)
    122a:	e8 45 13 00 00       	call   2574 <twakeup>
		}
	}
}
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <main>:
void MissionaryArrives();
void CannibalArrives();
void RowBoat();
void printAction(char a[]);

int main(){
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 e4 f0             	and    $0xfffffff0,%esp
    1237:	83 ec 10             	sub    $0x10,%esp
	boat = malloc(sizeof(struct Semaphore));
    123a:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1241:	e8 0b 17 00 00       	call   2951 <malloc>
    1246:	a3 14 34 00 00       	mov    %eax,0x3414
	p = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 fa 16 00 00       	call   2951 <malloc>
    1257:	a3 18 34 00 00       	mov    %eax,0x3418
	d = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 e9 16 00 00       	call   2951 <malloc>
    1268:	a3 1c 34 00 00       	mov    %eax,0x341c
	sem_init(d, 1);
    126d:	a1 1c 34 00 00       	mov    0x341c,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
	sem_init(p, 1);
    1282:	a1 18 34 00 00       	mov    0x3418,%eax
    1287:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    128e:	00 
    128f:	89 04 24             	mov    %eax,(%esp)
    1292:	e8 7e fe ff ff       	call   1115 <sem_init>
	//Test a-1: 2 missionary and 1 cannibal, arrival order: C->C->M->M->C->M
	printAction("Test 1: 2 Missionaries and 1 cannibal, arrival order: M->C->M\n");
    1297:	c7 04 24 a8 2c 00 00 	movl   $0x2ca8,(%esp)
    129e:	e8 73 0f 00 00       	call   2216 <printAction>
	sem_init(boat, 3);
    12a3:	a1 14 34 00 00       	mov    0x3414,%eax
    12a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    12af:	00 
    12b0:	89 04 24             	mov    %eax,(%esp)
    12b3:	e8 5d fe ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 1;
    12b8:	c7 05 20 34 00 00 01 	movl   $0x1,0x3420
    12bf:	00 00 00 
    // Current crossed set to 0
    crossed = 0;
    12c2:	c7 05 24 34 00 00 00 	movl   $0x0,0x3424
    12c9:	00 00 00 
    pass = 0;
    12cc:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    12d3:	00 00 00 

	tid = thread_create(MissionaryArrives, (void *) &arg);
    12d6:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    12dd:	00 
    12de:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    12e5:	e8 ad 17 00 00       	call   2a97 <thread_create>
    12ea:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    12ef:	a1 44 34 00 00       	mov    0x3444,%eax
    12f4:	85 c0                	test   %eax,%eax
    12f6:	75 11                	jne    1309 <main+0xd8>
		printAction("Failed to create a thread\n");
    12f8:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    12ff:	e8 12 0f 00 00       	call   2216 <printAction>
		exit();
    1304:	e8 b3 11 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1309:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1310:	00 00 00 
    1313:	eb 0d                	jmp    1322 <main+0xf1>
    1315:	a1 40 34 00 00       	mov    0x3440,%eax
    131a:	83 c0 01             	add    $0x1,%eax
    131d:	a3 40 34 00 00       	mov    %eax,0x3440
    1322:	a1 40 34 00 00       	mov    0x3440,%eax
    1327:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    132c:	7e e7                	jle    1315 <main+0xe4>
	tid = thread_create(CannibalArrives, (void *) &arg);
    132e:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1335:	00 
    1336:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    133d:	e8 55 17 00 00       	call   2a97 <thread_create>
    1342:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1347:	a1 44 34 00 00       	mov    0x3444,%eax
    134c:	85 c0                	test   %eax,%eax
    134e:	75 11                	jne    1361 <main+0x130>
		printAction("Failed to create a thread\n");
    1350:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1357:	e8 ba 0e 00 00       	call   2216 <printAction>
		exit();
    135c:	e8 5b 11 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1361:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1368:	00 00 00 
    136b:	eb 0d                	jmp    137a <main+0x149>
    136d:	a1 40 34 00 00       	mov    0x3440,%eax
    1372:	83 c0 01             	add    $0x1,%eax
    1375:	a3 40 34 00 00       	mov    %eax,0x3440
    137a:	a1 40 34 00 00       	mov    0x3440,%eax
    137f:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1384:	7e e7                	jle    136d <main+0x13c>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1386:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    138d:	00 
    138e:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1395:	e8 fd 16 00 00       	call   2a97 <thread_create>
    139a:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    139f:	a1 44 34 00 00       	mov    0x3444,%eax
    13a4:	85 c0                	test   %eax,%eax
    13a6:	75 11                	jne    13b9 <main+0x188>
		printAction("Failed to create a thread\n");
    13a8:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    13af:	e8 62 0e 00 00       	call   2216 <printAction>
		exit();
    13b4:	e8 03 11 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    13b9:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    13c0:	00 00 00 
    13c3:	eb 0d                	jmp    13d2 <main+0x1a1>
    13c5:	a1 40 34 00 00       	mov    0x3440,%eax
    13ca:	83 c0 01             	add    $0x1,%eax
    13cd:	a3 40 34 00 00       	mov    %eax,0x3440
    13d2:	a1 40 34 00 00       	mov    0x3440,%eax
    13d7:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13dc:	7e e7                	jle    13c5 <main+0x194>
	while(crossed != crossing)
    13de:	eb 6c                	jmp    144c <main+0x21b>
	{
	    if(boat->count == 0){
    13e0:	a1 14 34 00 00       	mov    0x3414,%eax
    13e5:	8b 00                	mov    (%eax),%eax
    13e7:	85 c0                	test   %eax,%eax
    13e9:	75 61                	jne    144c <main+0x21b>
    	    tid = thread_create(RowBoat, (void *) &arg);
    13eb:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    13f2:	00 
    13f3:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    13fa:	e8 98 16 00 00       	call   2a97 <thread_create>
    13ff:	a3 44 34 00 00       	mov    %eax,0x3444
        	if(tid <= 0){
    1404:	a1 44 34 00 00       	mov    0x3444,%eax
    1409:	85 c0                	test   %eax,%eax
    140b:	75 11                	jne    141e <main+0x1ed>
        		printAction("Failed to create a thread\n");
    140d:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1414:	e8 fd 0d 00 00       	call   2216 <printAction>
        		exit();
    1419:	e8 9e 10 00 00       	call   24bc <exit>
        	}
        	while(wait()>= 0);
    141e:	90                   	nop
    141f:	e8 a0 10 00 00       	call   24c4 <wait>
    1424:	85 c0                	test   %eax,%eax
    1426:	79 f7                	jns    141f <main+0x1ee>
        	sem_acquire(p);
    1428:	a1 18 34 00 00       	mov    0x3418,%eax
    142d:	89 04 24             	mov    %eax,(%esp)
    1430:	e8 15 fd ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    1435:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    143c:	00 00 00 
	    	sem_signal(p);
    143f:	a1 18 34 00 00       	mov    0x3418,%eax
    1444:	89 04 24             	mov    %eax,(%esp)
    1447:	e8 7d fd ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    144c:	8b 15 24 34 00 00    	mov    0x3424,%edx
    1452:	a1 20 34 00 00       	mov    0x3420,%eax
    1457:	39 c2                	cmp    %eax,%edx
    1459:	75 85                	jne    13e0 <main+0x1af>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    145b:	90                   	nop
    145c:	e8 63 10 00 00       	call   24c4 <wait>
    1461:	85 c0                	test   %eax,%eax
    1463:	79 f7                	jns    145c <main+0x22b>
	
	//Test 2: 3 missionaries and 3 cannibals, arrival order: C->C->M->M->C->M
	printAction("\nTest 2: 3 Missionaries and 3 cannibal, arrival order: C->C->M->M->C->M\n");
    1465:	c7 04 24 04 2d 00 00 	movl   $0x2d04,(%esp)
    146c:	e8 a5 0d 00 00       	call   2216 <printAction>
	sem_init(boat, 3);
    1471:	a1 14 34 00 00       	mov    0x3414,%eax
    1476:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    147d:	00 
    147e:	89 04 24             	mov    %eax,(%esp)
    1481:	e8 8f fc ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 2;
    1486:	c7 05 20 34 00 00 02 	movl   $0x2,0x3420
    148d:	00 00 00 
    crossed = 0;
    1490:	c7 05 24 34 00 00 00 	movl   $0x0,0x3424
    1497:	00 00 00 
    pass = 0;
    149a:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    14a1:	00 00 00 
	
	tid = thread_create(CannibalArrives, (void *) &arg);
    14a4:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    14ab:	00 
    14ac:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    14b3:	e8 df 15 00 00       	call   2a97 <thread_create>
    14b8:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    14bd:	a1 44 34 00 00       	mov    0x3444,%eax
    14c2:	85 c0                	test   %eax,%eax
    14c4:	75 11                	jne    14d7 <main+0x2a6>
		printAction("Failed to create a thread\n");
    14c6:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    14cd:	e8 44 0d 00 00       	call   2216 <printAction>
		exit();
    14d2:	e8 e5 0f 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    14d7:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    14de:	00 00 00 
    14e1:	eb 0d                	jmp    14f0 <main+0x2bf>
    14e3:	a1 40 34 00 00       	mov    0x3440,%eax
    14e8:	83 c0 01             	add    $0x1,%eax
    14eb:	a3 40 34 00 00       	mov    %eax,0x3440
    14f0:	a1 40 34 00 00       	mov    0x3440,%eax
    14f5:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    14fa:	7e e7                	jle    14e3 <main+0x2b2>
	tid = thread_create(CannibalArrives, (void *) &arg);
    14fc:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1503:	00 
    1504:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    150b:	e8 87 15 00 00       	call   2a97 <thread_create>
    1510:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1515:	a1 44 34 00 00       	mov    0x3444,%eax
    151a:	85 c0                	test   %eax,%eax
    151c:	75 11                	jne    152f <main+0x2fe>
		printAction("Failed to create a thread\n");
    151e:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1525:	e8 ec 0c 00 00       	call   2216 <printAction>
		exit();
    152a:	e8 8d 0f 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    152f:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1536:	00 00 00 
    1539:	eb 0d                	jmp    1548 <main+0x317>
    153b:	a1 40 34 00 00       	mov    0x3440,%eax
    1540:	83 c0 01             	add    $0x1,%eax
    1543:	a3 40 34 00 00       	mov    %eax,0x3440
    1548:	a1 40 34 00 00       	mov    0x3440,%eax
    154d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1552:	7e e7                	jle    153b <main+0x30a>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1554:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    155b:	00 
    155c:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1563:	e8 2f 15 00 00       	call   2a97 <thread_create>
    1568:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    156d:	a1 44 34 00 00       	mov    0x3444,%eax
    1572:	85 c0                	test   %eax,%eax
    1574:	75 11                	jne    1587 <main+0x356>
		printAction("Failed to create a thread\n");
    1576:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    157d:	e8 94 0c 00 00       	call   2216 <printAction>
		exit();
    1582:	e8 35 0f 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1587:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    158e:	00 00 00 
    1591:	eb 0d                	jmp    15a0 <main+0x36f>
    1593:	a1 40 34 00 00       	mov    0x3440,%eax
    1598:	83 c0 01             	add    $0x1,%eax
    159b:	a3 40 34 00 00       	mov    %eax,0x3440
    15a0:	a1 40 34 00 00       	mov    0x3440,%eax
    15a5:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15aa:	7e e7                	jle    1593 <main+0x362>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    15ac:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    15b3:	00 
    15b4:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    15bb:	e8 d7 14 00 00       	call   2a97 <thread_create>
    15c0:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    15c5:	a1 44 34 00 00       	mov    0x3444,%eax
    15ca:	85 c0                	test   %eax,%eax
    15cc:	75 11                	jne    15df <main+0x3ae>
		printAction("Failed to create a thread\n");
    15ce:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    15d5:	e8 3c 0c 00 00       	call   2216 <printAction>
		exit();
    15da:	e8 dd 0e 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    15df:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    15e6:	00 00 00 
    15e9:	eb 0d                	jmp    15f8 <main+0x3c7>
    15eb:	a1 40 34 00 00       	mov    0x3440,%eax
    15f0:	83 c0 01             	add    $0x1,%eax
    15f3:	a3 40 34 00 00       	mov    %eax,0x3440
    15f8:	a1 40 34 00 00       	mov    0x3440,%eax
    15fd:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1602:	7e e7                	jle    15eb <main+0x3ba>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1604:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    160b:	00 
    160c:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1613:	e8 7f 14 00 00       	call   2a97 <thread_create>
    1618:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    161d:	a1 44 34 00 00       	mov    0x3444,%eax
    1622:	85 c0                	test   %eax,%eax
    1624:	75 11                	jne    1637 <main+0x406>
		printAction("Failed to create a thread\n");
    1626:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    162d:	e8 e4 0b 00 00       	call   2216 <printAction>
		exit();
    1632:	e8 85 0e 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1637:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    163e:	00 00 00 
    1641:	eb 0d                	jmp    1650 <main+0x41f>
    1643:	a1 40 34 00 00       	mov    0x3440,%eax
    1648:	83 c0 01             	add    $0x1,%eax
    164b:	a3 40 34 00 00       	mov    %eax,0x3440
    1650:	a1 40 34 00 00       	mov    0x3440,%eax
    1655:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    165a:	7e e7                	jle    1643 <main+0x412>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    165c:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1663:	00 
    1664:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    166b:	e8 27 14 00 00       	call   2a97 <thread_create>
    1670:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1675:	a1 44 34 00 00       	mov    0x3444,%eax
    167a:	85 c0                	test   %eax,%eax
    167c:	75 11                	jne    168f <main+0x45e>
		printAction("Failed to create a thread\n");
    167e:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1685:	e8 8c 0b 00 00       	call   2216 <printAction>
		exit();
    168a:	e8 2d 0e 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    168f:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1696:	00 00 00 
    1699:	eb 0d                	jmp    16a8 <main+0x477>
    169b:	a1 40 34 00 00       	mov    0x3440,%eax
    16a0:	83 c0 01             	add    $0x1,%eax
    16a3:	a3 40 34 00 00       	mov    %eax,0x3440
    16a8:	a1 40 34 00 00       	mov    0x3440,%eax
    16ad:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    16b2:	7e e7                	jle    169b <main+0x46a>
	while(crossed != crossing)
    16b4:	eb 6c                	jmp    1722 <main+0x4f1>
	{
	    if(boat->count == 0){
    16b6:	a1 14 34 00 00       	mov    0x3414,%eax
    16bb:	8b 00                	mov    (%eax),%eax
    16bd:	85 c0                	test   %eax,%eax
    16bf:	75 61                	jne    1722 <main+0x4f1>
    	    tid = thread_create(RowBoat, (void *) &arg);
    16c1:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    16c8:	00 
    16c9:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    16d0:	e8 c2 13 00 00       	call   2a97 <thread_create>
    16d5:	a3 44 34 00 00       	mov    %eax,0x3444
        	if(tid <= 0){
    16da:	a1 44 34 00 00       	mov    0x3444,%eax
    16df:	85 c0                	test   %eax,%eax
    16e1:	75 11                	jne    16f4 <main+0x4c3>
        		printAction("Failed to create a thread\n");
    16e3:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    16ea:	e8 27 0b 00 00       	call   2216 <printAction>
        		exit();
    16ef:	e8 c8 0d 00 00       	call   24bc <exit>
        	}
        	while(wait()>= 0);
    16f4:	90                   	nop
    16f5:	e8 ca 0d 00 00       	call   24c4 <wait>
    16fa:	85 c0                	test   %eax,%eax
    16fc:	79 f7                	jns    16f5 <main+0x4c4>
        	sem_acquire(p);
    16fe:	a1 18 34 00 00       	mov    0x3418,%eax
    1703:	89 04 24             	mov    %eax,(%esp)
    1706:	e8 3f fa ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    170b:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1712:	00 00 00 
	    	sem_signal(p);
    1715:	a1 18 34 00 00       	mov    0x3418,%eax
    171a:	89 04 24             	mov    %eax,(%esp)
    171d:	e8 a7 fa ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    1722:	8b 15 24 34 00 00    	mov    0x3424,%edx
    1728:	a1 20 34 00 00       	mov    0x3420,%eax
    172d:	39 c2                	cmp    %eax,%edx
    172f:	75 85                	jne    16b6 <main+0x485>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    1731:	90                   	nop
    1732:	e8 8d 0d 00 00       	call   24c4 <wait>
    1737:	85 c0                	test   %eax,%eax
    1739:	79 f7                	jns    1732 <main+0x501>
    
	//Test 3: 4 missionaries and 2 cannibals, arrival order: M->C->C->M->M->M
	printAction("\nTest 3: 4 Missionaries and 2 cannibal, arrival order: M->C->C->M->M->M\n");
    173b:	c7 04 24 50 2d 00 00 	movl   $0x2d50,(%esp)
    1742:	e8 cf 0a 00 00       	call   2216 <printAction>
	sem_init(boat, 3);
    1747:	a1 14 34 00 00       	mov    0x3414,%eax
    174c:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1753:	00 
    1754:	89 04 24             	mov    %eax,(%esp)
    1757:	e8 b9 f9 ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 2;
    175c:	c7 05 20 34 00 00 02 	movl   $0x2,0x3420
    1763:	00 00 00 
    crossed = 0;
    1766:	c7 05 24 34 00 00 00 	movl   $0x0,0x3424
    176d:	00 00 00 
	pass = 0;
    1770:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1777:	00 00 00 
	
	tid = thread_create(MissionaryArrives, (void *) &arg);
    177a:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1781:	00 
    1782:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1789:	e8 09 13 00 00       	call   2a97 <thread_create>
    178e:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1793:	a1 44 34 00 00       	mov    0x3444,%eax
    1798:	85 c0                	test   %eax,%eax
    179a:	75 11                	jne    17ad <main+0x57c>
		printAction("Failed to create a thread\n");
    179c:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    17a3:	e8 6e 0a 00 00       	call   2216 <printAction>
		exit();
    17a8:	e8 0f 0d 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    17ad:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    17b4:	00 00 00 
    17b7:	eb 0d                	jmp    17c6 <main+0x595>
    17b9:	a1 40 34 00 00       	mov    0x3440,%eax
    17be:	83 c0 01             	add    $0x1,%eax
    17c1:	a3 40 34 00 00       	mov    %eax,0x3440
    17c6:	a1 40 34 00 00       	mov    0x3440,%eax
    17cb:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17d0:	7e e7                	jle    17b9 <main+0x588>
	tid = thread_create(CannibalArrives, (void *) &arg);
    17d2:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    17d9:	00 
    17da:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    17e1:	e8 b1 12 00 00       	call   2a97 <thread_create>
    17e6:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    17eb:	a1 44 34 00 00       	mov    0x3444,%eax
    17f0:	85 c0                	test   %eax,%eax
    17f2:	75 11                	jne    1805 <main+0x5d4>
		printAction("Failed to create a thread\n");
    17f4:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    17fb:	e8 16 0a 00 00       	call   2216 <printAction>
		exit();
    1800:	e8 b7 0c 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1805:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    180c:	00 00 00 
    180f:	eb 0d                	jmp    181e <main+0x5ed>
    1811:	a1 40 34 00 00       	mov    0x3440,%eax
    1816:	83 c0 01             	add    $0x1,%eax
    1819:	a3 40 34 00 00       	mov    %eax,0x3440
    181e:	a1 40 34 00 00       	mov    0x3440,%eax
    1823:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1828:	7e e7                	jle    1811 <main+0x5e0>
	tid = thread_create(CannibalArrives, (void *) &arg);
    182a:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1831:	00 
    1832:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1839:	e8 59 12 00 00       	call   2a97 <thread_create>
    183e:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1843:	a1 44 34 00 00       	mov    0x3444,%eax
    1848:	85 c0                	test   %eax,%eax
    184a:	75 11                	jne    185d <main+0x62c>
		printAction("Failed to create a thread\n");
    184c:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1853:	e8 be 09 00 00       	call   2216 <printAction>
		exit();
    1858:	e8 5f 0c 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    185d:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1864:	00 00 00 
    1867:	eb 0d                	jmp    1876 <main+0x645>
    1869:	a1 40 34 00 00       	mov    0x3440,%eax
    186e:	83 c0 01             	add    $0x1,%eax
    1871:	a3 40 34 00 00       	mov    %eax,0x3440
    1876:	a1 40 34 00 00       	mov    0x3440,%eax
    187b:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1880:	7e e7                	jle    1869 <main+0x638>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1882:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1889:	00 
    188a:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1891:	e8 01 12 00 00       	call   2a97 <thread_create>
    1896:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    189b:	a1 44 34 00 00       	mov    0x3444,%eax
    18a0:	85 c0                	test   %eax,%eax
    18a2:	75 11                	jne    18b5 <main+0x684>
		printAction("Failed to create a thread\n");
    18a4:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    18ab:	e8 66 09 00 00       	call   2216 <printAction>
		exit();
    18b0:	e8 07 0c 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    18b5:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    18bc:	00 00 00 
    18bf:	eb 0d                	jmp    18ce <main+0x69d>
    18c1:	a1 40 34 00 00       	mov    0x3440,%eax
    18c6:	83 c0 01             	add    $0x1,%eax
    18c9:	a3 40 34 00 00       	mov    %eax,0x3440
    18ce:	a1 40 34 00 00       	mov    0x3440,%eax
    18d3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    18d8:	7e e7                	jle    18c1 <main+0x690>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    18da:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    18e1:	00 
    18e2:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    18e9:	e8 a9 11 00 00       	call   2a97 <thread_create>
    18ee:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    18f3:	a1 44 34 00 00       	mov    0x3444,%eax
    18f8:	85 c0                	test   %eax,%eax
    18fa:	75 11                	jne    190d <main+0x6dc>
		printAction("Failed to create a thread\n");
    18fc:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1903:	e8 0e 09 00 00       	call   2216 <printAction>
		exit();
    1908:	e8 af 0b 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    190d:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1914:	00 00 00 
    1917:	eb 0d                	jmp    1926 <main+0x6f5>
    1919:	a1 40 34 00 00       	mov    0x3440,%eax
    191e:	83 c0 01             	add    $0x1,%eax
    1921:	a3 40 34 00 00       	mov    %eax,0x3440
    1926:	a1 40 34 00 00       	mov    0x3440,%eax
    192b:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1930:	7e e7                	jle    1919 <main+0x6e8>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1932:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1939:	00 
    193a:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1941:	e8 51 11 00 00       	call   2a97 <thread_create>
    1946:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    194b:	a1 44 34 00 00       	mov    0x3444,%eax
    1950:	85 c0                	test   %eax,%eax
    1952:	75 11                	jne    1965 <main+0x734>
		printAction("Failed to create a thread\n");
    1954:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    195b:	e8 b6 08 00 00       	call   2216 <printAction>
		exit();
    1960:	e8 57 0b 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1965:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    196c:	00 00 00 
    196f:	eb 0d                	jmp    197e <main+0x74d>
    1971:	a1 40 34 00 00       	mov    0x3440,%eax
    1976:	83 c0 01             	add    $0x1,%eax
    1979:	a3 40 34 00 00       	mov    %eax,0x3440
    197e:	a1 40 34 00 00       	mov    0x3440,%eax
    1983:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1988:	7e e7                	jle    1971 <main+0x740>
	while(crossed != crossing)
    198a:	eb 6c                	jmp    19f8 <main+0x7c7>
	{
	    if(boat->count == 0){
    198c:	a1 14 34 00 00       	mov    0x3414,%eax
    1991:	8b 00                	mov    (%eax),%eax
    1993:	85 c0                	test   %eax,%eax
    1995:	75 61                	jne    19f8 <main+0x7c7>
    	    tid = thread_create(RowBoat, (void *) &arg);
    1997:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    199e:	00 
    199f:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    19a6:	e8 ec 10 00 00       	call   2a97 <thread_create>
    19ab:	a3 44 34 00 00       	mov    %eax,0x3444
        	if(tid <= 0){
    19b0:	a1 44 34 00 00       	mov    0x3444,%eax
    19b5:	85 c0                	test   %eax,%eax
    19b7:	75 11                	jne    19ca <main+0x799>
        		printAction("Failed to create a thread\n");
    19b9:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    19c0:	e8 51 08 00 00       	call   2216 <printAction>
        		exit();
    19c5:	e8 f2 0a 00 00       	call   24bc <exit>
        	}
        	while(wait()>= 0);
    19ca:	90                   	nop
    19cb:	e8 f4 0a 00 00       	call   24c4 <wait>
    19d0:	85 c0                	test   %eax,%eax
    19d2:	79 f7                	jns    19cb <main+0x79a>
        	sem_acquire(p);
    19d4:	a1 18 34 00 00       	mov    0x3418,%eax
    19d9:	89 04 24             	mov    %eax,(%esp)
    19dc:	e8 69 f7 ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    19e1:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    19e8:	00 00 00 
	    	sem_signal(p);
    19eb:	a1 18 34 00 00       	mov    0x3418,%eax
    19f0:	89 04 24             	mov    %eax,(%esp)
    19f3:	e8 d1 f7 ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    19f8:	8b 15 24 34 00 00    	mov    0x3424,%edx
    19fe:	a1 20 34 00 00       	mov    0x3420,%eax
    1a03:	39 c2                	cmp    %eax,%edx
    1a05:	75 85                	jne    198c <main+0x75b>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    1a07:	90                   	nop
    1a08:	e8 b7 0a 00 00       	call   24c4 <wait>
    1a0d:	85 c0                	test   %eax,%eax
    1a0f:	79 f7                	jns    1a08 <main+0x7d7>
	
	//Test 4: 4 missionaries and 5 cannibals, arrival order: C->M->C->M->M->M->C->C->C
	printAction("\nTest 4: 4 Missionaries and 5 cannibal, arrival order: C->M->C->M->M->M->C->C->C\n");
    1a11:	c7 04 24 9c 2d 00 00 	movl   $0x2d9c,(%esp)
    1a18:	e8 f9 07 00 00       	call   2216 <printAction>
	sem_init(boat, 3);
    1a1d:	a1 14 34 00 00       	mov    0x3414,%eax
    1a22:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1a29:	00 
    1a2a:	89 04 24             	mov    %eax,(%esp)
    1a2d:	e8 e3 f6 ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 3;
    1a32:	c7 05 20 34 00 00 03 	movl   $0x3,0x3420
    1a39:	00 00 00 
    crossed = 0;
    1a3c:	c7 05 24 34 00 00 00 	movl   $0x0,0x3424
    1a43:	00 00 00 
	pass = 0;
    1a46:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1a4d:	00 00 00 
	
	tid = thread_create(CannibalArrives, (void *) &arg);
    1a50:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1a57:	00 
    1a58:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1a5f:	e8 33 10 00 00       	call   2a97 <thread_create>
    1a64:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1a69:	a1 44 34 00 00       	mov    0x3444,%eax
    1a6e:	85 c0                	test   %eax,%eax
    1a70:	75 11                	jne    1a83 <main+0x852>
		printAction("Failed to create a thread\n");
    1a72:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1a79:	e8 98 07 00 00       	call   2216 <printAction>
		exit();
    1a7e:	e8 39 0a 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1a83:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1a8a:	00 00 00 
    1a8d:	eb 0d                	jmp    1a9c <main+0x86b>
    1a8f:	a1 40 34 00 00       	mov    0x3440,%eax
    1a94:	83 c0 01             	add    $0x1,%eax
    1a97:	a3 40 34 00 00       	mov    %eax,0x3440
    1a9c:	a1 40 34 00 00       	mov    0x3440,%eax
    1aa1:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1aa6:	7e e7                	jle    1a8f <main+0x85e>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1aa8:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1aaf:	00 
    1ab0:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1ab7:	e8 db 0f 00 00       	call   2a97 <thread_create>
    1abc:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1ac1:	a1 44 34 00 00       	mov    0x3444,%eax
    1ac6:	85 c0                	test   %eax,%eax
    1ac8:	75 11                	jne    1adb <main+0x8aa>
		printAction("Failed to create a thread\n");
    1aca:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1ad1:	e8 40 07 00 00       	call   2216 <printAction>
		exit();
    1ad6:	e8 e1 09 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1adb:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1ae2:	00 00 00 
    1ae5:	eb 0d                	jmp    1af4 <main+0x8c3>
    1ae7:	a1 40 34 00 00       	mov    0x3440,%eax
    1aec:	83 c0 01             	add    $0x1,%eax
    1aef:	a3 40 34 00 00       	mov    %eax,0x3440
    1af4:	a1 40 34 00 00       	mov    0x3440,%eax
    1af9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1afe:	7e e7                	jle    1ae7 <main+0x8b6>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1b00:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1b07:	00 
    1b08:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1b0f:	e8 83 0f 00 00       	call   2a97 <thread_create>
    1b14:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1b19:	a1 44 34 00 00       	mov    0x3444,%eax
    1b1e:	85 c0                	test   %eax,%eax
    1b20:	75 11                	jne    1b33 <main+0x902>
		printAction("Failed to create a thread\n");
    1b22:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1b29:	e8 e8 06 00 00       	call   2216 <printAction>
		exit();
    1b2e:	e8 89 09 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1b33:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1b3a:	00 00 00 
    1b3d:	eb 0d                	jmp    1b4c <main+0x91b>
    1b3f:	a1 40 34 00 00       	mov    0x3440,%eax
    1b44:	83 c0 01             	add    $0x1,%eax
    1b47:	a3 40 34 00 00       	mov    %eax,0x3440
    1b4c:	a1 40 34 00 00       	mov    0x3440,%eax
    1b51:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1b56:	7e e7                	jle    1b3f <main+0x90e>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1b58:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1b5f:	00 
    1b60:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1b67:	e8 2b 0f 00 00       	call   2a97 <thread_create>
    1b6c:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1b71:	a1 44 34 00 00       	mov    0x3444,%eax
    1b76:	85 c0                	test   %eax,%eax
    1b78:	75 11                	jne    1b8b <main+0x95a>
		printAction("Failed to create a thread\n");
    1b7a:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1b81:	e8 90 06 00 00       	call   2216 <printAction>
		exit();
    1b86:	e8 31 09 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1b8b:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1b92:	00 00 00 
    1b95:	eb 0d                	jmp    1ba4 <main+0x973>
    1b97:	a1 40 34 00 00       	mov    0x3440,%eax
    1b9c:	83 c0 01             	add    $0x1,%eax
    1b9f:	a3 40 34 00 00       	mov    %eax,0x3440
    1ba4:	a1 40 34 00 00       	mov    0x3440,%eax
    1ba9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1bae:	7e e7                	jle    1b97 <main+0x966>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1bb0:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1bb7:	00 
    1bb8:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1bbf:	e8 d3 0e 00 00       	call   2a97 <thread_create>
    1bc4:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1bc9:	a1 44 34 00 00       	mov    0x3444,%eax
    1bce:	85 c0                	test   %eax,%eax
    1bd0:	75 11                	jne    1be3 <main+0x9b2>
		printAction("Failed to create a thread\n");
    1bd2:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1bd9:	e8 38 06 00 00       	call   2216 <printAction>
		exit();
    1bde:	e8 d9 08 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1be3:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1bea:	00 00 00 
    1bed:	eb 0d                	jmp    1bfc <main+0x9cb>
    1bef:	a1 40 34 00 00       	mov    0x3440,%eax
    1bf4:	83 c0 01             	add    $0x1,%eax
    1bf7:	a3 40 34 00 00       	mov    %eax,0x3440
    1bfc:	a1 40 34 00 00       	mov    0x3440,%eax
    1c01:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1c06:	7e e7                	jle    1bef <main+0x9be>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1c08:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1c0f:	00 
    1c10:	c7 04 24 19 1f 00 00 	movl   $0x1f19,(%esp)
    1c17:	e8 7b 0e 00 00       	call   2a97 <thread_create>
    1c1c:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1c21:	a1 44 34 00 00       	mov    0x3444,%eax
    1c26:	85 c0                	test   %eax,%eax
    1c28:	75 11                	jne    1c3b <main+0xa0a>
		printAction("Failed to create a thread\n");
    1c2a:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1c31:	e8 e0 05 00 00       	call   2216 <printAction>
		exit();
    1c36:	e8 81 08 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1c3b:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1c42:	00 00 00 
    1c45:	eb 0d                	jmp    1c54 <main+0xa23>
    1c47:	a1 40 34 00 00       	mov    0x3440,%eax
    1c4c:	83 c0 01             	add    $0x1,%eax
    1c4f:	a3 40 34 00 00       	mov    %eax,0x3440
    1c54:	a1 40 34 00 00       	mov    0x3440,%eax
    1c59:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1c5e:	7e e7                	jle    1c47 <main+0xa16>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1c60:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1c67:	00 
    1c68:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1c6f:	e8 23 0e 00 00       	call   2a97 <thread_create>
    1c74:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1c79:	a1 44 34 00 00       	mov    0x3444,%eax
    1c7e:	85 c0                	test   %eax,%eax
    1c80:	75 11                	jne    1c93 <main+0xa62>
		printAction("Failed to create a thread\n");
    1c82:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1c89:	e8 88 05 00 00       	call   2216 <printAction>
		exit();
    1c8e:	e8 29 08 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1c93:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1c9a:	00 00 00 
    1c9d:	eb 0d                	jmp    1cac <main+0xa7b>
    1c9f:	a1 40 34 00 00       	mov    0x3440,%eax
    1ca4:	83 c0 01             	add    $0x1,%eax
    1ca7:	a3 40 34 00 00       	mov    %eax,0x3440
    1cac:	a1 40 34 00 00       	mov    0x3440,%eax
    1cb1:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1cb6:	7e e7                	jle    1c9f <main+0xa6e>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1cb8:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1cbf:	00 
    1cc0:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1cc7:	e8 cb 0d 00 00       	call   2a97 <thread_create>
    1ccc:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1cd1:	a1 44 34 00 00       	mov    0x3444,%eax
    1cd6:	85 c0                	test   %eax,%eax
    1cd8:	75 11                	jne    1ceb <main+0xaba>
		printAction("Failed to create a thread\n");
    1cda:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1ce1:	e8 30 05 00 00       	call   2216 <printAction>
		exit();
    1ce6:	e8 d1 07 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1ceb:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1cf2:	00 00 00 
    1cf5:	eb 0d                	jmp    1d04 <main+0xad3>
    1cf7:	a1 40 34 00 00       	mov    0x3440,%eax
    1cfc:	83 c0 01             	add    $0x1,%eax
    1cff:	a3 40 34 00 00       	mov    %eax,0x3440
    1d04:	a1 40 34 00 00       	mov    0x3440,%eax
    1d09:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1d0e:	7e e7                	jle    1cf7 <main+0xac6>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1d10:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1d17:	00 
    1d18:	c7 04 24 de 1f 00 00 	movl   $0x1fde,(%esp)
    1d1f:	e8 73 0d 00 00       	call   2a97 <thread_create>
    1d24:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1d29:	a1 44 34 00 00       	mov    0x3444,%eax
    1d2e:	85 c0                	test   %eax,%eax
    1d30:	75 11                	jne    1d43 <main+0xb12>
		printAction("Failed to create a thread\n");
    1d32:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1d39:	e8 d8 04 00 00       	call   2216 <printAction>
		exit();
    1d3e:	e8 79 07 00 00       	call   24bc <exit>
	}
	for(i = 0; i < 999999; i++);
    1d43:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1d4a:	00 00 00 
    1d4d:	eb 0d                	jmp    1d5c <main+0xb2b>
    1d4f:	a1 40 34 00 00       	mov    0x3440,%eax
    1d54:	83 c0 01             	add    $0x1,%eax
    1d57:	a3 40 34 00 00       	mov    %eax,0x3440
    1d5c:	a1 40 34 00 00       	mov    0x3440,%eax
    1d61:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1d66:	7e e7                	jle    1d4f <main+0xb1e>
	
	while(boat->count != 0);
    1d68:	90                   	nop
    1d69:	a1 14 34 00 00       	mov    0x3414,%eax
    1d6e:	8b 00                	mov    (%eax),%eax
    1d70:	85 c0                	test   %eax,%eax
    1d72:	75 f5                	jne    1d69 <main+0xb38>
	tid = thread_create(RowBoat, (void *) &arg);
    1d74:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1d7b:	00 
    1d7c:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    1d83:	e8 0f 0d 00 00       	call   2a97 <thread_create>
    1d88:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1d8d:	a1 44 34 00 00       	mov    0x3444,%eax
    1d92:	85 c0                	test   %eax,%eax
    1d94:	75 11                	jne    1da7 <main+0xb76>
		printAction("Failed to create a thread\n");
    1d96:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1d9d:	e8 74 04 00 00       	call   2216 <printAction>
		exit();
    1da2:	e8 15 07 00 00       	call   24bc <exit>
	}
	sem_acquire(p);
    1da7:	a1 18 34 00 00       	mov    0x3418,%eax
    1dac:	89 04 24             	mov    %eax,(%esp)
    1daf:	e8 96 f3 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1db4:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1dbb:	00 00 00 
	sem_signal(p);
    1dbe:	a1 18 34 00 00       	mov    0x3418,%eax
    1dc3:	89 04 24             	mov    %eax,(%esp)
    1dc6:	e8 fe f3 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1dcb:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1dd2:	00 00 00 
    1dd5:	eb 0d                	jmp    1de4 <main+0xbb3>
    1dd7:	a1 40 34 00 00       	mov    0x3440,%eax
    1ddc:	83 c0 01             	add    $0x1,%eax
    1ddf:	a3 40 34 00 00       	mov    %eax,0x3440
    1de4:	a1 40 34 00 00       	mov    0x3440,%eax
    1de9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1dee:	7e e7                	jle    1dd7 <main+0xba6>
	
	while(boat->count != 0);
    1df0:	90                   	nop
    1df1:	a1 14 34 00 00       	mov    0x3414,%eax
    1df6:	8b 00                	mov    (%eax),%eax
    1df8:	85 c0                	test   %eax,%eax
    1dfa:	75 f5                	jne    1df1 <main+0xbc0>
	tid = thread_create(RowBoat, (void *) &arg);
    1dfc:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1e03:	00 
    1e04:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    1e0b:	e8 87 0c 00 00       	call   2a97 <thread_create>
    1e10:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1e15:	a1 44 34 00 00       	mov    0x3444,%eax
    1e1a:	85 c0                	test   %eax,%eax
    1e1c:	75 11                	jne    1e2f <main+0xbfe>
		printAction("Failed to create a thread\n");
    1e1e:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1e25:	e8 ec 03 00 00       	call   2216 <printAction>
		exit();
    1e2a:	e8 8d 06 00 00       	call   24bc <exit>
	}
	sem_acquire(p);
    1e2f:	a1 18 34 00 00       	mov    0x3418,%eax
    1e34:	89 04 24             	mov    %eax,(%esp)
    1e37:	e8 0e f3 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1e3c:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1e43:	00 00 00 
	sem_signal(p);
    1e46:	a1 18 34 00 00       	mov    0x3418,%eax
    1e4b:	89 04 24             	mov    %eax,(%esp)
    1e4e:	e8 76 f3 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1e53:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1e5a:	00 00 00 
    1e5d:	eb 0d                	jmp    1e6c <main+0xc3b>
    1e5f:	a1 40 34 00 00       	mov    0x3440,%eax
    1e64:	83 c0 01             	add    $0x1,%eax
    1e67:	a3 40 34 00 00       	mov    %eax,0x3440
    1e6c:	a1 40 34 00 00       	mov    0x3440,%eax
    1e71:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1e76:	7e e7                	jle    1e5f <main+0xc2e>
	
	while(boat->count != 0);
    1e78:	90                   	nop
    1e79:	a1 14 34 00 00       	mov    0x3414,%eax
    1e7e:	8b 00                	mov    (%eax),%eax
    1e80:	85 c0                	test   %eax,%eax
    1e82:	75 f5                	jne    1e79 <main+0xc48>
	tid = thread_create(RowBoat, (void *) &arg);
    1e84:	c7 44 24 04 f8 33 00 	movl   $0x33f8,0x4(%esp)
    1e8b:	00 
    1e8c:	c7 04 24 af 20 00 00 	movl   $0x20af,(%esp)
    1e93:	e8 ff 0b 00 00       	call   2a97 <thread_create>
    1e98:	a3 44 34 00 00       	mov    %eax,0x3444
	if(tid <= 0){
    1e9d:	a1 44 34 00 00       	mov    0x3444,%eax
    1ea2:	85 c0                	test   %eax,%eax
    1ea4:	75 11                	jne    1eb7 <main+0xc86>
		printAction("Failed to create a thread\n");
    1ea6:	c7 04 24 e7 2c 00 00 	movl   $0x2ce7,(%esp)
    1ead:	e8 64 03 00 00       	call   2216 <printAction>
		exit();
    1eb2:	e8 05 06 00 00       	call   24bc <exit>
	}
	while(wait()>= 0);
    1eb7:	90                   	nop
    1eb8:	e8 07 06 00 00       	call   24c4 <wait>
    1ebd:	85 c0                	test   %eax,%eax
    1ebf:	79 f7                	jns    1eb8 <main+0xc87>
	sem_acquire(p);
    1ec1:	a1 18 34 00 00       	mov    0x3418,%eax
    1ec6:	89 04 24             	mov    %eax,(%esp)
    1ec9:	e8 7c f2 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1ece:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    1ed5:	00 00 00 
	sem_signal(p);
    1ed8:	a1 18 34 00 00       	mov    0x3418,%eax
    1edd:	89 04 24             	mov    %eax,(%esp)
    1ee0:	e8 e4 f2 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1ee5:	c7 05 40 34 00 00 00 	movl   $0x0,0x3440
    1eec:	00 00 00 
    1eef:	eb 0d                	jmp    1efe <main+0xccd>
    1ef1:	a1 40 34 00 00       	mov    0x3440,%eax
    1ef6:	83 c0 01             	add    $0x1,%eax
    1ef9:	a3 40 34 00 00       	mov    %eax,0x3440
    1efe:	a1 40 34 00 00       	mov    0x3440,%eax
    1f03:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1f08:	7e e7                	jle    1ef1 <main+0xcc0>
    while(wait()>= 0);
    1f0a:	90                   	nop
    1f0b:	e8 b4 05 00 00       	call   24c4 <wait>
    1f10:	85 c0                	test   %eax,%eax
    1f12:	79 f7                	jns    1f0b <main+0xcda>
	
	exit();
    1f14:	e8 a3 05 00 00       	call   24bc <exit>

00001f19 <MissionaryArrives>:
	return 0;
}

// Missionary
void MissionaryArrives(){
    1f19:	55                   	push   %ebp
    1f1a:	89 e5                	mov    %esp,%ebp
    1f1c:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(d);
    1f1f:	a1 1c 34 00 00       	mov    0x341c,%eax
    1f24:	89 04 24             	mov    %eax,(%esp)
    1f27:	e8 1e f2 ff ff       	call   114a <sem_acquire>
	printAction("A missionary arrived\n");
    1f2c:	c7 04 24 ee 2d 00 00 	movl   $0x2dee,(%esp)
    1f33:	e8 de 02 00 00       	call   2216 <printAction>
	sem_signal(d);
    1f38:	a1 1c 34 00 00       	mov    0x341c,%eax
    1f3d:	89 04 24             	mov    %eax,(%esp)
    1f40:	e8 84 f2 ff ff       	call   11c9 <sem_signal>
	
	// If there are 2 cannibals, then wait.
	while(canni >= 2);
    1f45:	90                   	nop
    1f46:	a1 30 34 00 00       	mov    0x3430,%eax
    1f4b:	83 f8 01             	cmp    $0x1,%eax
    1f4e:	7f f6                	jg     1f46 <MissionaryArrives+0x2d>
	sem_acquire(d);
    1f50:	a1 1c 34 00 00       	mov    0x341c,%eax
    1f55:	89 04 24             	mov    %eax,(%esp)
    1f58:	e8 ed f1 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1f5d:	a1 1c 34 00 00       	mov    0x341c,%eax
    1f62:	89 04 24             	mov    %eax,(%esp)
    1f65:	e8 5f f2 ff ff       	call   11c9 <sem_signal>
	sem_acquire(boat);
    1f6a:	a1 14 34 00 00       	mov    0x3414,%eax
    1f6f:	89 04 24             	mov    %eax,(%esp)
    1f72:	e8 d3 f1 ff ff       	call   114a <sem_acquire>
	sem_acquire(d);
    1f77:	a1 1c 34 00 00       	mov    0x341c,%eax
    1f7c:	89 04 24             	mov    %eax,(%esp)
    1f7f:	e8 c6 f1 ff ff       	call   114a <sem_acquire>
	sem_acquire(p);
    1f84:	a1 18 34 00 00       	mov    0x3418,%eax
    1f89:	89 04 24             	mov    %eax,(%esp)
    1f8c:	e8 b9 f1 ff ff       	call   114a <sem_acquire>
	missi++;
    1f91:	a1 2c 34 00 00       	mov    0x342c,%eax
    1f96:	83 c0 01             	add    $0x1,%eax
    1f99:	a3 2c 34 00 00       	mov    %eax,0x342c
	sem_signal(p);
    1f9e:	a1 18 34 00 00       	mov    0x3418,%eax
    1fa3:	89 04 24             	mov    %eax,(%esp)
    1fa6:	e8 1e f2 ff ff       	call   11c9 <sem_signal>
	printAction("A missionary is waiting on the boat\n");
    1fab:	c7 04 24 04 2e 00 00 	movl   $0x2e04,(%esp)
    1fb2:	e8 5f 02 00 00       	call   2216 <printAction>
	// Missonary acquires a spot.
	sem_signal(d);
    1fb7:	a1 1c 34 00 00       	mov    0x341c,%eax
    1fbc:	89 04 24             	mov    %eax,(%esp)
    1fbf:	e8 05 f2 ff ff       	call   11c9 <sem_signal>
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
    1fc4:	90                   	nop
    1fc5:	a1 28 34 00 00       	mov    0x3428,%eax
    1fca:	85 c0                	test   %eax,%eax
    1fcc:	75 0b                	jne    1fd9 <MissionaryArrives+0xc0>
    1fce:	a1 14 34 00 00       	mov    0x3414,%eax
    1fd3:	8b 00                	mov    (%eax),%eax
    1fd5:	85 c0                	test   %eax,%eax
    1fd7:	75 ec                	jne    1fc5 <MissionaryArrives+0xac>
	// Signals for an open spot, then returns.
    //sem_signal(boat);
	texit();
    1fd9:	e8 86 05 00 00       	call   2564 <texit>

00001fde <CannibalArrives>:
}

// Cannibal
void CannibalArrives(){
    1fde:	55                   	push   %ebp
    1fdf:	89 e5                	mov    %esp,%ebp
    1fe1:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(d);
    1fe4:	a1 1c 34 00 00       	mov    0x341c,%eax
    1fe9:	89 04 24             	mov    %eax,(%esp)
    1fec:	e8 59 f1 ff ff       	call   114a <sem_acquire>
	printAction("A cannibal arrived\n");
    1ff1:	c7 04 24 29 2e 00 00 	movl   $0x2e29,(%esp)
    1ff8:	e8 19 02 00 00       	call   2216 <printAction>
	sem_signal(d);
    1ffd:	a1 1c 34 00 00       	mov    0x341c,%eax
    2002:	89 04 24             	mov    %eax,(%esp)
    2005:	e8 bf f1 ff ff       	call   11c9 <sem_signal>
	
	// If there is only one missionary and only 1 spot left, then wait.
	while(missi == 1 && boat->count == 1);
    200a:	90                   	nop
    200b:	a1 2c 34 00 00       	mov    0x342c,%eax
    2010:	83 f8 01             	cmp    $0x1,%eax
    2013:	75 0c                	jne    2021 <CannibalArrives+0x43>
    2015:	a1 14 34 00 00       	mov    0x3414,%eax
    201a:	8b 00                	mov    (%eax),%eax
    201c:	83 f8 01             	cmp    $0x1,%eax
    201f:	74 ea                	je     200b <CannibalArrives+0x2d>
	sem_acquire(d);
    2021:	a1 1c 34 00 00       	mov    0x341c,%eax
    2026:	89 04 24             	mov    %eax,(%esp)
    2029:	e8 1c f1 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    202e:	a1 1c 34 00 00       	mov    0x341c,%eax
    2033:	89 04 24             	mov    %eax,(%esp)
    2036:	e8 8e f1 ff ff       	call   11c9 <sem_signal>
	sem_acquire(boat);
    203b:	a1 14 34 00 00       	mov    0x3414,%eax
    2040:	89 04 24             	mov    %eax,(%esp)
    2043:	e8 02 f1 ff ff       	call   114a <sem_acquire>
	sem_acquire(d);
    2048:	a1 1c 34 00 00       	mov    0x341c,%eax
    204d:	89 04 24             	mov    %eax,(%esp)
    2050:	e8 f5 f0 ff ff       	call   114a <sem_acquire>
	sem_acquire(p);
    2055:	a1 18 34 00 00       	mov    0x3418,%eax
    205a:	89 04 24             	mov    %eax,(%esp)
    205d:	e8 e8 f0 ff ff       	call   114a <sem_acquire>
	canni++;
    2062:	a1 30 34 00 00       	mov    0x3430,%eax
    2067:	83 c0 01             	add    $0x1,%eax
    206a:	a3 30 34 00 00       	mov    %eax,0x3430
	sem_signal(p);
    206f:	a1 18 34 00 00       	mov    0x3418,%eax
    2074:	89 04 24             	mov    %eax,(%esp)
    2077:	e8 4d f1 ff ff       	call   11c9 <sem_signal>
	printAction("A cannibal is waiting on the boat\n");
    207c:	c7 04 24 40 2e 00 00 	movl   $0x2e40,(%esp)
    2083:	e8 8e 01 00 00       	call   2216 <printAction>
	// Cannibal acquires a spot.
	sem_signal(d);
    2088:	a1 1c 34 00 00       	mov    0x341c,%eax
    208d:	89 04 24             	mov    %eax,(%esp)
    2090:	e8 34 f1 ff ff       	call   11c9 <sem_signal>
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
    2095:	90                   	nop
    2096:	a1 28 34 00 00       	mov    0x3428,%eax
    209b:	85 c0                	test   %eax,%eax
    209d:	75 0b                	jne    20aa <CannibalArrives+0xcc>
    209f:	a1 14 34 00 00       	mov    0x3414,%eax
    20a4:	8b 00                	mov    (%eax),%eax
    20a6:	85 c0                	test   %eax,%eax
    20a8:	75 ec                	jne    2096 <CannibalArrives+0xb8>
	
	// Signals for an open spot, then returns.
	//sem_signal(boat);
	texit();
    20aa:	e8 b5 04 00 00       	call   2564 <texit>

000020af <RowBoat>:
}

// RowBoat
void RowBoat(){
    20af:	55                   	push   %ebp
    20b0:	89 e5                	mov    %esp,%ebp
    20b2:	83 ec 18             	sub    $0x18,%esp
	printAction("Preparing boat\n");
    20b5:	c7 04 24 63 2e 00 00 	movl   $0x2e63,(%esp)
    20bc:	e8 55 01 00 00       	call   2216 <printAction>
	sem_acquire(p);
    20c1:	a1 18 34 00 00       	mov    0x3418,%eax
    20c6:	89 04 24             	mov    %eax,(%esp)
    20c9:	e8 7c f0 ff ff       	call   114a <sem_acquire>
    pass = 0;
    20ce:	c7 05 28 34 00 00 00 	movl   $0x0,0x3428
    20d5:	00 00 00 
    sem_signal(p);
    20d8:	a1 18 34 00 00       	mov    0x3418,%eax
    20dd:	89 04 24             	mov    %eax,(%esp)
    20e0:	e8 e4 f0 ff ff       	call   11c9 <sem_signal>
    // While the boat is not full, wait.
    while(boat->count != 0);
    20e5:	90                   	nop
    20e6:	a1 14 34 00 00       	mov    0x3414,%eax
    20eb:	8b 00                	mov    (%eax),%eax
    20ed:	85 c0                	test   %eax,%eax
    20ef:	75 f5                	jne    20e6 <RowBoat+0x37>
    sem_acquire(d);
    20f1:	a1 1c 34 00 00       	mov    0x341c,%eax
    20f6:	89 04 24             	mov    %eax,(%esp)
    20f9:	e8 4c f0 ff ff       	call   114a <sem_acquire>
    printAction("Enjoy your trip, the boat is crossing!\n");
    20fe:	c7 04 24 74 2e 00 00 	movl   $0x2e74,(%esp)
    2105:	e8 0c 01 00 00       	call   2216 <printAction>
    // Signals available boat spots, reset.
    while(missi > 0){
    210a:	eb 33                	jmp    213f <RowBoat+0x90>
		printAction("Missionary crossed the river\n");
    210c:	c7 04 24 9c 2e 00 00 	movl   $0x2e9c,(%esp)
    2113:	e8 fe 00 00 00       	call   2216 <printAction>
		sem_acquire(p);
    2118:	a1 18 34 00 00       	mov    0x3418,%eax
    211d:	89 04 24             	mov    %eax,(%esp)
    2120:	e8 25 f0 ff ff       	call   114a <sem_acquire>
		missi--;
    2125:	a1 2c 34 00 00       	mov    0x342c,%eax
    212a:	83 e8 01             	sub    $0x1,%eax
    212d:	a3 2c 34 00 00       	mov    %eax,0x342c
		sem_signal(p);
    2132:	a1 18 34 00 00       	mov    0x3418,%eax
    2137:	89 04 24             	mov    %eax,(%esp)
    213a:	e8 8a f0 ff ff       	call   11c9 <sem_signal>
    // While the boat is not full, wait.
    while(boat->count != 0);
    sem_acquire(d);
    printAction("Enjoy your trip, the boat is crossing!\n");
    // Signals available boat spots, reset.
    while(missi > 0){
    213f:	a1 2c 34 00 00       	mov    0x342c,%eax
    2144:	85 c0                	test   %eax,%eax
    2146:	7f c4                	jg     210c <RowBoat+0x5d>
		printAction("Missionary crossed the river\n");
		sem_acquire(p);
		missi--;
		sem_signal(p);
    }
    while(canni > 0){
    2148:	eb 33                	jmp    217d <RowBoat+0xce>
		printAction("Cannibal crossed the river\n");
    214a:	c7 04 24 ba 2e 00 00 	movl   $0x2eba,(%esp)
    2151:	e8 c0 00 00 00       	call   2216 <printAction>
		sem_acquire(p);
    2156:	a1 18 34 00 00       	mov    0x3418,%eax
    215b:	89 04 24             	mov    %eax,(%esp)
    215e:	e8 e7 ef ff ff       	call   114a <sem_acquire>
		canni--;
    2163:	a1 30 34 00 00       	mov    0x3430,%eax
    2168:	83 e8 01             	sub    $0x1,%eax
    216b:	a3 30 34 00 00       	mov    %eax,0x3430
		sem_signal(p);
    2170:	a1 18 34 00 00       	mov    0x3418,%eax
    2175:	89 04 24             	mov    %eax,(%esp)
    2178:	e8 4c f0 ff ff       	call   11c9 <sem_signal>
		printAction("Missionary crossed the river\n");
		sem_acquire(p);
		missi--;
		sem_signal(p);
    }
    while(canni > 0){
    217d:	a1 30 34 00 00       	mov    0x3430,%eax
    2182:	85 c0                	test   %eax,%eax
    2184:	7f c4                	jg     214a <RowBoat+0x9b>
		printAction("Cannibal crossed the river\n");
		sem_acquire(p);
		canni--;
		sem_signal(p);
    }
    sem_acquire(p);
    2186:	a1 18 34 00 00       	mov    0x3418,%eax
    218b:	89 04 24             	mov    %eax,(%esp)
    218e:	e8 b7 ef ff ff       	call   114a <sem_acquire>
    pass = 1;
    2193:	c7 05 28 34 00 00 01 	movl   $0x1,0x3428
    219a:	00 00 00 
    sem_signal(p);
    219d:	a1 18 34 00 00       	mov    0x3418,%eax
    21a2:	89 04 24             	mov    %eax,(%esp)
    21a5:	e8 1f f0 ff ff       	call   11c9 <sem_signal>
    printAction("The boat is clear!\n");
    21aa:	c7 04 24 d6 2e 00 00 	movl   $0x2ed6,(%esp)
    21b1:	e8 60 00 00 00       	call   2216 <printAction>
    sem_acquire(p);
    21b6:	a1 18 34 00 00       	mov    0x3418,%eax
    21bb:	89 04 24             	mov    %eax,(%esp)
    21be:	e8 87 ef ff ff       	call   114a <sem_acquire>
    crossed++;
    21c3:	a1 24 34 00 00       	mov    0x3424,%eax
    21c8:	83 c0 01             	add    $0x1,%eax
    21cb:	a3 24 34 00 00       	mov    %eax,0x3424
    sem_signal(p);
    21d0:	a1 18 34 00 00       	mov    0x3418,%eax
    21d5:	89 04 24             	mov    %eax,(%esp)
    21d8:	e8 ec ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    21dd:	a1 14 34 00 00       	mov    0x3414,%eax
    21e2:	89 04 24             	mov    %eax,(%esp)
    21e5:	e8 df ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    21ea:	a1 14 34 00 00       	mov    0x3414,%eax
    21ef:	89 04 24             	mov    %eax,(%esp)
    21f2:	e8 d2 ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    21f7:	a1 14 34 00 00       	mov    0x3414,%eax
    21fc:	89 04 24             	mov    %eax,(%esp)
    21ff:	e8 c5 ef ff ff       	call   11c9 <sem_signal>
    sem_signal(d);
    2204:	a1 1c 34 00 00       	mov    0x341c,%eax
    2209:	89 04 24             	mov    %eax,(%esp)
    220c:	e8 b8 ef ff ff       	call   11c9 <sem_signal>
    
    texit();
    2211:	e8 4e 03 00 00       	call   2564 <texit>

00002216 <printAction>:
}

// PrintAction
void printAction(char a[]){
    2216:	55                   	push   %ebp
    2217:	89 e5                	mov    %esp,%ebp
    2219:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    221c:	a1 18 34 00 00       	mov    0x3418,%eax
    2221:	89 04 24             	mov    %eax,(%esp)
    2224:	e8 21 ef ff ff       	call   114a <sem_acquire>
	printf(1, "%s", a);
    2229:	8b 45 08             	mov    0x8(%ebp),%eax
    222c:	89 44 24 08          	mov    %eax,0x8(%esp)
    2230:	c7 44 24 04 ea 2e 00 	movl   $0x2eea,0x4(%esp)
    2237:	00 
    2238:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    223f:	e8 20 04 00 00       	call   2664 <printf>
	sem_signal(p);
    2244:	a1 18 34 00 00       	mov    0x3418,%eax
    2249:	89 04 24             	mov    %eax,(%esp)
    224c:	e8 78 ef ff ff       	call   11c9 <sem_signal>
}
    2251:	c9                   	leave  
    2252:	c3                   	ret    
    2253:	90                   	nop

00002254 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    2254:	55                   	push   %ebp
    2255:	89 e5                	mov    %esp,%ebp
    2257:	57                   	push   %edi
    2258:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    2259:	8b 4d 08             	mov    0x8(%ebp),%ecx
    225c:	8b 55 10             	mov    0x10(%ebp),%edx
    225f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2262:	89 cb                	mov    %ecx,%ebx
    2264:	89 df                	mov    %ebx,%edi
    2266:	89 d1                	mov    %edx,%ecx
    2268:	fc                   	cld    
    2269:	f3 aa                	rep stos %al,%es:(%edi)
    226b:	89 ca                	mov    %ecx,%edx
    226d:	89 fb                	mov    %edi,%ebx
    226f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    2272:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    2275:	5b                   	pop    %ebx
    2276:	5f                   	pop    %edi
    2277:	5d                   	pop    %ebp
    2278:	c3                   	ret    

00002279 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    2279:	55                   	push   %ebp
    227a:	89 e5                	mov    %esp,%ebp
    227c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    227f:	8b 45 08             	mov    0x8(%ebp),%eax
    2282:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    2285:	90                   	nop
    2286:	8b 45 08             	mov    0x8(%ebp),%eax
    2289:	8d 50 01             	lea    0x1(%eax),%edx
    228c:	89 55 08             	mov    %edx,0x8(%ebp)
    228f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2292:	8d 4a 01             	lea    0x1(%edx),%ecx
    2295:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    2298:	0f b6 12             	movzbl (%edx),%edx
    229b:	88 10                	mov    %dl,(%eax)
    229d:	0f b6 00             	movzbl (%eax),%eax
    22a0:	84 c0                	test   %al,%al
    22a2:	75 e2                	jne    2286 <strcpy+0xd>
    ;
  return os;
    22a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    22a7:	c9                   	leave  
    22a8:	c3                   	ret    

000022a9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    22a9:	55                   	push   %ebp
    22aa:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    22ac:	eb 08                	jmp    22b6 <strcmp+0xd>
    p++, q++;
    22ae:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    22b2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    22b6:	8b 45 08             	mov    0x8(%ebp),%eax
    22b9:	0f b6 00             	movzbl (%eax),%eax
    22bc:	84 c0                	test   %al,%al
    22be:	74 10                	je     22d0 <strcmp+0x27>
    22c0:	8b 45 08             	mov    0x8(%ebp),%eax
    22c3:	0f b6 10             	movzbl (%eax),%edx
    22c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    22c9:	0f b6 00             	movzbl (%eax),%eax
    22cc:	38 c2                	cmp    %al,%dl
    22ce:	74 de                	je     22ae <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    22d0:	8b 45 08             	mov    0x8(%ebp),%eax
    22d3:	0f b6 00             	movzbl (%eax),%eax
    22d6:	0f b6 d0             	movzbl %al,%edx
    22d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    22dc:	0f b6 00             	movzbl (%eax),%eax
    22df:	0f b6 c0             	movzbl %al,%eax
    22e2:	29 c2                	sub    %eax,%edx
    22e4:	89 d0                	mov    %edx,%eax
}
    22e6:	5d                   	pop    %ebp
    22e7:	c3                   	ret    

000022e8 <strlen>:

uint
strlen(char *s)
{
    22e8:	55                   	push   %ebp
    22e9:	89 e5                	mov    %esp,%ebp
    22eb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    22ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    22f5:	eb 04                	jmp    22fb <strlen+0x13>
    22f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    22fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    22fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2301:	01 d0                	add    %edx,%eax
    2303:	0f b6 00             	movzbl (%eax),%eax
    2306:	84 c0                	test   %al,%al
    2308:	75 ed                	jne    22f7 <strlen+0xf>
    ;
  return n;
    230a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    230d:	c9                   	leave  
    230e:	c3                   	ret    

0000230f <memset>:

void*
memset(void *dst, int c, uint n)
{
    230f:	55                   	push   %ebp
    2310:	89 e5                	mov    %esp,%ebp
    2312:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    2315:	8b 45 10             	mov    0x10(%ebp),%eax
    2318:	89 44 24 08          	mov    %eax,0x8(%esp)
    231c:	8b 45 0c             	mov    0xc(%ebp),%eax
    231f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2323:	8b 45 08             	mov    0x8(%ebp),%eax
    2326:	89 04 24             	mov    %eax,(%esp)
    2329:	e8 26 ff ff ff       	call   2254 <stosb>
  return dst;
    232e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2331:	c9                   	leave  
    2332:	c3                   	ret    

00002333 <strchr>:

char*
strchr(const char *s, char c)
{
    2333:	55                   	push   %ebp
    2334:	89 e5                	mov    %esp,%ebp
    2336:	83 ec 04             	sub    $0x4,%esp
    2339:	8b 45 0c             	mov    0xc(%ebp),%eax
    233c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    233f:	eb 14                	jmp    2355 <strchr+0x22>
    if(*s == c)
    2341:	8b 45 08             	mov    0x8(%ebp),%eax
    2344:	0f b6 00             	movzbl (%eax),%eax
    2347:	3a 45 fc             	cmp    -0x4(%ebp),%al
    234a:	75 05                	jne    2351 <strchr+0x1e>
      return (char*)s;
    234c:	8b 45 08             	mov    0x8(%ebp),%eax
    234f:	eb 13                	jmp    2364 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    2351:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    2355:	8b 45 08             	mov    0x8(%ebp),%eax
    2358:	0f b6 00             	movzbl (%eax),%eax
    235b:	84 c0                	test   %al,%al
    235d:	75 e2                	jne    2341 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    235f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2364:	c9                   	leave  
    2365:	c3                   	ret    

00002366 <gets>:

char*
gets(char *buf, int max)
{
    2366:	55                   	push   %ebp
    2367:	89 e5                	mov    %esp,%ebp
    2369:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    236c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2373:	eb 4c                	jmp    23c1 <gets+0x5b>
    cc = read(0, &c, 1);
    2375:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    237c:	00 
    237d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    2380:	89 44 24 04          	mov    %eax,0x4(%esp)
    2384:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    238b:	e8 44 01 00 00       	call   24d4 <read>
    2390:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    2393:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2397:	7f 02                	jg     239b <gets+0x35>
      break;
    2399:	eb 31                	jmp    23cc <gets+0x66>
    buf[i++] = c;
    239b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    239e:	8d 50 01             	lea    0x1(%eax),%edx
    23a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
    23a4:	89 c2                	mov    %eax,%edx
    23a6:	8b 45 08             	mov    0x8(%ebp),%eax
    23a9:	01 c2                	add    %eax,%edx
    23ab:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    23af:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    23b1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    23b5:	3c 0a                	cmp    $0xa,%al
    23b7:	74 13                	je     23cc <gets+0x66>
    23b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    23bd:	3c 0d                	cmp    $0xd,%al
    23bf:	74 0b                	je     23cc <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    23c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23c4:	83 c0 01             	add    $0x1,%eax
    23c7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    23ca:	7c a9                	jl     2375 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    23cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    23cf:	8b 45 08             	mov    0x8(%ebp),%eax
    23d2:	01 d0                	add    %edx,%eax
    23d4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    23d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    23da:	c9                   	leave  
    23db:	c3                   	ret    

000023dc <stat>:

int
stat(char *n, struct stat *st)
{
    23dc:	55                   	push   %ebp
    23dd:	89 e5                	mov    %esp,%ebp
    23df:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    23e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23e9:	00 
    23ea:	8b 45 08             	mov    0x8(%ebp),%eax
    23ed:	89 04 24             	mov    %eax,(%esp)
    23f0:	e8 07 01 00 00       	call   24fc <open>
    23f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    23f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23fc:	79 07                	jns    2405 <stat+0x29>
    return -1;
    23fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2403:	eb 23                	jmp    2428 <stat+0x4c>
  r = fstat(fd, st);
    2405:	8b 45 0c             	mov    0xc(%ebp),%eax
    2408:	89 44 24 04          	mov    %eax,0x4(%esp)
    240c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    240f:	89 04 24             	mov    %eax,(%esp)
    2412:	e8 fd 00 00 00       	call   2514 <fstat>
    2417:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    241a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    241d:	89 04 24             	mov    %eax,(%esp)
    2420:	e8 bf 00 00 00       	call   24e4 <close>
  return r;
    2425:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    2428:	c9                   	leave  
    2429:	c3                   	ret    

0000242a <atoi>:

int
atoi(const char *s)
{
    242a:	55                   	push   %ebp
    242b:	89 e5                	mov    %esp,%ebp
    242d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    2430:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    2437:	eb 25                	jmp    245e <atoi+0x34>
    n = n*10 + *s++ - '0';
    2439:	8b 55 fc             	mov    -0x4(%ebp),%edx
    243c:	89 d0                	mov    %edx,%eax
    243e:	c1 e0 02             	shl    $0x2,%eax
    2441:	01 d0                	add    %edx,%eax
    2443:	01 c0                	add    %eax,%eax
    2445:	89 c1                	mov    %eax,%ecx
    2447:	8b 45 08             	mov    0x8(%ebp),%eax
    244a:	8d 50 01             	lea    0x1(%eax),%edx
    244d:	89 55 08             	mov    %edx,0x8(%ebp)
    2450:	0f b6 00             	movzbl (%eax),%eax
    2453:	0f be c0             	movsbl %al,%eax
    2456:	01 c8                	add    %ecx,%eax
    2458:	83 e8 30             	sub    $0x30,%eax
    245b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    245e:	8b 45 08             	mov    0x8(%ebp),%eax
    2461:	0f b6 00             	movzbl (%eax),%eax
    2464:	3c 2f                	cmp    $0x2f,%al
    2466:	7e 0a                	jle    2472 <atoi+0x48>
    2468:	8b 45 08             	mov    0x8(%ebp),%eax
    246b:	0f b6 00             	movzbl (%eax),%eax
    246e:	3c 39                	cmp    $0x39,%al
    2470:	7e c7                	jle    2439 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    2472:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2475:	c9                   	leave  
    2476:	c3                   	ret    

00002477 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    2477:	55                   	push   %ebp
    2478:	89 e5                	mov    %esp,%ebp
    247a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    247d:	8b 45 08             	mov    0x8(%ebp),%eax
    2480:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    2483:	8b 45 0c             	mov    0xc(%ebp),%eax
    2486:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    2489:	eb 17                	jmp    24a2 <memmove+0x2b>
    *dst++ = *src++;
    248b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    248e:	8d 50 01             	lea    0x1(%eax),%edx
    2491:	89 55 fc             	mov    %edx,-0x4(%ebp)
    2494:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2497:	8d 4a 01             	lea    0x1(%edx),%ecx
    249a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    249d:	0f b6 12             	movzbl (%edx),%edx
    24a0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    24a2:	8b 45 10             	mov    0x10(%ebp),%eax
    24a5:	8d 50 ff             	lea    -0x1(%eax),%edx
    24a8:	89 55 10             	mov    %edx,0x10(%ebp)
    24ab:	85 c0                	test   %eax,%eax
    24ad:	7f dc                	jg     248b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    24af:	8b 45 08             	mov    0x8(%ebp),%eax
}
    24b2:	c9                   	leave  
    24b3:	c3                   	ret    

000024b4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    24b4:	b8 01 00 00 00       	mov    $0x1,%eax
    24b9:	cd 40                	int    $0x40
    24bb:	c3                   	ret    

000024bc <exit>:
SYSCALL(exit)
    24bc:	b8 02 00 00 00       	mov    $0x2,%eax
    24c1:	cd 40                	int    $0x40
    24c3:	c3                   	ret    

000024c4 <wait>:
SYSCALL(wait)
    24c4:	b8 03 00 00 00       	mov    $0x3,%eax
    24c9:	cd 40                	int    $0x40
    24cb:	c3                   	ret    

000024cc <pipe>:
SYSCALL(pipe)
    24cc:	b8 04 00 00 00       	mov    $0x4,%eax
    24d1:	cd 40                	int    $0x40
    24d3:	c3                   	ret    

000024d4 <read>:
SYSCALL(read)
    24d4:	b8 05 00 00 00       	mov    $0x5,%eax
    24d9:	cd 40                	int    $0x40
    24db:	c3                   	ret    

000024dc <write>:
SYSCALL(write)
    24dc:	b8 10 00 00 00       	mov    $0x10,%eax
    24e1:	cd 40                	int    $0x40
    24e3:	c3                   	ret    

000024e4 <close>:
SYSCALL(close)
    24e4:	b8 15 00 00 00       	mov    $0x15,%eax
    24e9:	cd 40                	int    $0x40
    24eb:	c3                   	ret    

000024ec <kill>:
SYSCALL(kill)
    24ec:	b8 06 00 00 00       	mov    $0x6,%eax
    24f1:	cd 40                	int    $0x40
    24f3:	c3                   	ret    

000024f4 <exec>:
SYSCALL(exec)
    24f4:	b8 07 00 00 00       	mov    $0x7,%eax
    24f9:	cd 40                	int    $0x40
    24fb:	c3                   	ret    

000024fc <open>:
SYSCALL(open)
    24fc:	b8 0f 00 00 00       	mov    $0xf,%eax
    2501:	cd 40                	int    $0x40
    2503:	c3                   	ret    

00002504 <mknod>:
SYSCALL(mknod)
    2504:	b8 11 00 00 00       	mov    $0x11,%eax
    2509:	cd 40                	int    $0x40
    250b:	c3                   	ret    

0000250c <unlink>:
SYSCALL(unlink)
    250c:	b8 12 00 00 00       	mov    $0x12,%eax
    2511:	cd 40                	int    $0x40
    2513:	c3                   	ret    

00002514 <fstat>:
SYSCALL(fstat)
    2514:	b8 08 00 00 00       	mov    $0x8,%eax
    2519:	cd 40                	int    $0x40
    251b:	c3                   	ret    

0000251c <link>:
SYSCALL(link)
    251c:	b8 13 00 00 00       	mov    $0x13,%eax
    2521:	cd 40                	int    $0x40
    2523:	c3                   	ret    

00002524 <mkdir>:
SYSCALL(mkdir)
    2524:	b8 14 00 00 00       	mov    $0x14,%eax
    2529:	cd 40                	int    $0x40
    252b:	c3                   	ret    

0000252c <chdir>:
SYSCALL(chdir)
    252c:	b8 09 00 00 00       	mov    $0x9,%eax
    2531:	cd 40                	int    $0x40
    2533:	c3                   	ret    

00002534 <dup>:
SYSCALL(dup)
    2534:	b8 0a 00 00 00       	mov    $0xa,%eax
    2539:	cd 40                	int    $0x40
    253b:	c3                   	ret    

0000253c <getpid>:
SYSCALL(getpid)
    253c:	b8 0b 00 00 00       	mov    $0xb,%eax
    2541:	cd 40                	int    $0x40
    2543:	c3                   	ret    

00002544 <sbrk>:
SYSCALL(sbrk)
    2544:	b8 0c 00 00 00       	mov    $0xc,%eax
    2549:	cd 40                	int    $0x40
    254b:	c3                   	ret    

0000254c <sleep>:
SYSCALL(sleep)
    254c:	b8 0d 00 00 00       	mov    $0xd,%eax
    2551:	cd 40                	int    $0x40
    2553:	c3                   	ret    

00002554 <uptime>:
SYSCALL(uptime)
    2554:	b8 0e 00 00 00       	mov    $0xe,%eax
    2559:	cd 40                	int    $0x40
    255b:	c3                   	ret    

0000255c <clone>:
SYSCALL(clone)
    255c:	b8 16 00 00 00       	mov    $0x16,%eax
    2561:	cd 40                	int    $0x40
    2563:	c3                   	ret    

00002564 <texit>:
SYSCALL(texit)
    2564:	b8 17 00 00 00       	mov    $0x17,%eax
    2569:	cd 40                	int    $0x40
    256b:	c3                   	ret    

0000256c <tsleep>:
SYSCALL(tsleep)
    256c:	b8 18 00 00 00       	mov    $0x18,%eax
    2571:	cd 40                	int    $0x40
    2573:	c3                   	ret    

00002574 <twakeup>:
SYSCALL(twakeup)
    2574:	b8 19 00 00 00       	mov    $0x19,%eax
    2579:	cd 40                	int    $0x40
    257b:	c3                   	ret    

0000257c <thread_yield>:
SYSCALL(thread_yield)
    257c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    2581:	cd 40                	int    $0x40
    2583:	c3                   	ret    

00002584 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    2584:	55                   	push   %ebp
    2585:	89 e5                	mov    %esp,%ebp
    2587:	83 ec 18             	sub    $0x18,%esp
    258a:	8b 45 0c             	mov    0xc(%ebp),%eax
    258d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    2590:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2597:	00 
    2598:	8d 45 f4             	lea    -0xc(%ebp),%eax
    259b:	89 44 24 04          	mov    %eax,0x4(%esp)
    259f:	8b 45 08             	mov    0x8(%ebp),%eax
    25a2:	89 04 24             	mov    %eax,(%esp)
    25a5:	e8 32 ff ff ff       	call   24dc <write>
}
    25aa:	c9                   	leave  
    25ab:	c3                   	ret    

000025ac <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    25ac:	55                   	push   %ebp
    25ad:	89 e5                	mov    %esp,%ebp
    25af:	56                   	push   %esi
    25b0:	53                   	push   %ebx
    25b1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    25b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    25bb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    25bf:	74 17                	je     25d8 <printint+0x2c>
    25c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    25c5:	79 11                	jns    25d8 <printint+0x2c>
    neg = 1;
    25c7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    25ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    25d1:	f7 d8                	neg    %eax
    25d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    25d6:	eb 06                	jmp    25de <printint+0x32>
  } else {
    x = xx;
    25d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    25db:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    25de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    25e5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    25e8:	8d 41 01             	lea    0x1(%ecx),%eax
    25eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    25ee:	8b 5d 10             	mov    0x10(%ebp),%ebx
    25f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25f4:	ba 00 00 00 00       	mov    $0x0,%edx
    25f9:	f7 f3                	div    %ebx
    25fb:	89 d0                	mov    %edx,%eax
    25fd:	0f b6 80 fc 33 00 00 	movzbl 0x33fc(%eax),%eax
    2604:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    2608:	8b 75 10             	mov    0x10(%ebp),%esi
    260b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    260e:	ba 00 00 00 00       	mov    $0x0,%edx
    2613:	f7 f6                	div    %esi
    2615:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2618:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    261c:	75 c7                	jne    25e5 <printint+0x39>
  if(neg)
    261e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2622:	74 10                	je     2634 <printint+0x88>
    buf[i++] = '-';
    2624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2627:	8d 50 01             	lea    0x1(%eax),%edx
    262a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    262d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    2632:	eb 1f                	jmp    2653 <printint+0xa7>
    2634:	eb 1d                	jmp    2653 <printint+0xa7>
    putc(fd, buf[i]);
    2636:	8d 55 dc             	lea    -0x24(%ebp),%edx
    2639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    263c:	01 d0                	add    %edx,%eax
    263e:	0f b6 00             	movzbl (%eax),%eax
    2641:	0f be c0             	movsbl %al,%eax
    2644:	89 44 24 04          	mov    %eax,0x4(%esp)
    2648:	8b 45 08             	mov    0x8(%ebp),%eax
    264b:	89 04 24             	mov    %eax,(%esp)
    264e:	e8 31 ff ff ff       	call   2584 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2653:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2657:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    265b:	79 d9                	jns    2636 <printint+0x8a>
    putc(fd, buf[i]);
}
    265d:	83 c4 30             	add    $0x30,%esp
    2660:	5b                   	pop    %ebx
    2661:	5e                   	pop    %esi
    2662:	5d                   	pop    %ebp
    2663:	c3                   	ret    

00002664 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2664:	55                   	push   %ebp
    2665:	89 e5                	mov    %esp,%ebp
    2667:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    266a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    2671:	8d 45 0c             	lea    0xc(%ebp),%eax
    2674:	83 c0 04             	add    $0x4,%eax
    2677:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    267a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2681:	e9 7c 01 00 00       	jmp    2802 <printf+0x19e>
    c = fmt[i] & 0xff;
    2686:	8b 55 0c             	mov    0xc(%ebp),%edx
    2689:	8b 45 f0             	mov    -0x10(%ebp),%eax
    268c:	01 d0                	add    %edx,%eax
    268e:	0f b6 00             	movzbl (%eax),%eax
    2691:	0f be c0             	movsbl %al,%eax
    2694:	25 ff 00 00 00       	and    $0xff,%eax
    2699:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    269c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    26a0:	75 2c                	jne    26ce <printf+0x6a>
      if(c == '%'){
    26a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    26a6:	75 0c                	jne    26b4 <printf+0x50>
        state = '%';
    26a8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    26af:	e9 4a 01 00 00       	jmp    27fe <printf+0x19a>
      } else {
        putc(fd, c);
    26b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26b7:	0f be c0             	movsbl %al,%eax
    26ba:	89 44 24 04          	mov    %eax,0x4(%esp)
    26be:	8b 45 08             	mov    0x8(%ebp),%eax
    26c1:	89 04 24             	mov    %eax,(%esp)
    26c4:	e8 bb fe ff ff       	call   2584 <putc>
    26c9:	e9 30 01 00 00       	jmp    27fe <printf+0x19a>
      }
    } else if(state == '%'){
    26ce:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    26d2:	0f 85 26 01 00 00    	jne    27fe <printf+0x19a>
      if(c == 'd'){
    26d8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    26dc:	75 2d                	jne    270b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    26de:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26e1:	8b 00                	mov    (%eax),%eax
    26e3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    26ea:	00 
    26eb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    26f2:	00 
    26f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    26f7:	8b 45 08             	mov    0x8(%ebp),%eax
    26fa:	89 04 24             	mov    %eax,(%esp)
    26fd:	e8 aa fe ff ff       	call   25ac <printint>
        ap++;
    2702:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2706:	e9 ec 00 00 00       	jmp    27f7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    270b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    270f:	74 06                	je     2717 <printf+0xb3>
    2711:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    2715:	75 2d                	jne    2744 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    2717:	8b 45 e8             	mov    -0x18(%ebp),%eax
    271a:	8b 00                	mov    (%eax),%eax
    271c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2723:	00 
    2724:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    272b:	00 
    272c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2730:	8b 45 08             	mov    0x8(%ebp),%eax
    2733:	89 04 24             	mov    %eax,(%esp)
    2736:	e8 71 fe ff ff       	call   25ac <printint>
        ap++;
    273b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    273f:	e9 b3 00 00 00       	jmp    27f7 <printf+0x193>
      } else if(c == 's'){
    2744:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    2748:	75 45                	jne    278f <printf+0x12b>
        s = (char*)*ap;
    274a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    274d:	8b 00                	mov    (%eax),%eax
    274f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    2752:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    2756:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    275a:	75 09                	jne    2765 <printf+0x101>
          s = "(null)";
    275c:	c7 45 f4 ed 2e 00 00 	movl   $0x2eed,-0xc(%ebp)
        while(*s != 0){
    2763:	eb 1e                	jmp    2783 <printf+0x11f>
    2765:	eb 1c                	jmp    2783 <printf+0x11f>
          putc(fd, *s);
    2767:	8b 45 f4             	mov    -0xc(%ebp),%eax
    276a:	0f b6 00             	movzbl (%eax),%eax
    276d:	0f be c0             	movsbl %al,%eax
    2770:	89 44 24 04          	mov    %eax,0x4(%esp)
    2774:	8b 45 08             	mov    0x8(%ebp),%eax
    2777:	89 04 24             	mov    %eax,(%esp)
    277a:	e8 05 fe ff ff       	call   2584 <putc>
          s++;
    277f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2783:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2786:	0f b6 00             	movzbl (%eax),%eax
    2789:	84 c0                	test   %al,%al
    278b:	75 da                	jne    2767 <printf+0x103>
    278d:	eb 68                	jmp    27f7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    278f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    2793:	75 1d                	jne    27b2 <printf+0x14e>
        putc(fd, *ap);
    2795:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2798:	8b 00                	mov    (%eax),%eax
    279a:	0f be c0             	movsbl %al,%eax
    279d:	89 44 24 04          	mov    %eax,0x4(%esp)
    27a1:	8b 45 08             	mov    0x8(%ebp),%eax
    27a4:	89 04 24             	mov    %eax,(%esp)
    27a7:	e8 d8 fd ff ff       	call   2584 <putc>
        ap++;
    27ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    27b0:	eb 45                	jmp    27f7 <printf+0x193>
      } else if(c == '%'){
    27b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    27b6:	75 17                	jne    27cf <printf+0x16b>
        putc(fd, c);
    27b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27bb:	0f be c0             	movsbl %al,%eax
    27be:	89 44 24 04          	mov    %eax,0x4(%esp)
    27c2:	8b 45 08             	mov    0x8(%ebp),%eax
    27c5:	89 04 24             	mov    %eax,(%esp)
    27c8:	e8 b7 fd ff ff       	call   2584 <putc>
    27cd:	eb 28                	jmp    27f7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    27cf:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    27d6:	00 
    27d7:	8b 45 08             	mov    0x8(%ebp),%eax
    27da:	89 04 24             	mov    %eax,(%esp)
    27dd:	e8 a2 fd ff ff       	call   2584 <putc>
        putc(fd, c);
    27e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27e5:	0f be c0             	movsbl %al,%eax
    27e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    27ec:	8b 45 08             	mov    0x8(%ebp),%eax
    27ef:	89 04 24             	mov    %eax,(%esp)
    27f2:	e8 8d fd ff ff       	call   2584 <putc>
      }
      state = 0;
    27f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    27fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2802:	8b 55 0c             	mov    0xc(%ebp),%edx
    2805:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2808:	01 d0                	add    %edx,%eax
    280a:	0f b6 00             	movzbl (%eax),%eax
    280d:	84 c0                	test   %al,%al
    280f:	0f 85 71 fe ff ff    	jne    2686 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2815:	c9                   	leave  
    2816:	c3                   	ret    
    2817:	90                   	nop

00002818 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2818:	55                   	push   %ebp
    2819:	89 e5                	mov    %esp,%ebp
    281b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    281e:	8b 45 08             	mov    0x8(%ebp),%eax
    2821:	83 e8 08             	sub    $0x8,%eax
    2824:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2827:	a1 3c 34 00 00       	mov    0x343c,%eax
    282c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    282f:	eb 24                	jmp    2855 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2831:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2834:	8b 00                	mov    (%eax),%eax
    2836:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2839:	77 12                	ja     284d <free+0x35>
    283b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    283e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2841:	77 24                	ja     2867 <free+0x4f>
    2843:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2846:	8b 00                	mov    (%eax),%eax
    2848:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    284b:	77 1a                	ja     2867 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    284d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2850:	8b 00                	mov    (%eax),%eax
    2852:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2855:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2858:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    285b:	76 d4                	jbe    2831 <free+0x19>
    285d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2860:	8b 00                	mov    (%eax),%eax
    2862:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2865:	76 ca                	jbe    2831 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    2867:	8b 45 f8             	mov    -0x8(%ebp),%eax
    286a:	8b 40 04             	mov    0x4(%eax),%eax
    286d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2874:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2877:	01 c2                	add    %eax,%edx
    2879:	8b 45 fc             	mov    -0x4(%ebp),%eax
    287c:	8b 00                	mov    (%eax),%eax
    287e:	39 c2                	cmp    %eax,%edx
    2880:	75 24                	jne    28a6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    2882:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2885:	8b 50 04             	mov    0x4(%eax),%edx
    2888:	8b 45 fc             	mov    -0x4(%ebp),%eax
    288b:	8b 00                	mov    (%eax),%eax
    288d:	8b 40 04             	mov    0x4(%eax),%eax
    2890:	01 c2                	add    %eax,%edx
    2892:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2895:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2898:	8b 45 fc             	mov    -0x4(%ebp),%eax
    289b:	8b 00                	mov    (%eax),%eax
    289d:	8b 10                	mov    (%eax),%edx
    289f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28a2:	89 10                	mov    %edx,(%eax)
    28a4:	eb 0a                	jmp    28b0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    28a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28a9:	8b 10                	mov    (%eax),%edx
    28ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28ae:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    28b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28b3:	8b 40 04             	mov    0x4(%eax),%eax
    28b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    28bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28c0:	01 d0                	add    %edx,%eax
    28c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    28c5:	75 20                	jne    28e7 <free+0xcf>
    p->s.size += bp->s.size;
    28c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28ca:	8b 50 04             	mov    0x4(%eax),%edx
    28cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28d0:	8b 40 04             	mov    0x4(%eax),%eax
    28d3:	01 c2                	add    %eax,%edx
    28d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28d8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    28db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28de:	8b 10                	mov    (%eax),%edx
    28e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28e3:	89 10                	mov    %edx,(%eax)
    28e5:	eb 08                	jmp    28ef <free+0xd7>
  } else
    p->s.ptr = bp;
    28e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28ea:	8b 55 f8             	mov    -0x8(%ebp),%edx
    28ed:	89 10                	mov    %edx,(%eax)
  freep = p;
    28ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28f2:	a3 3c 34 00 00       	mov    %eax,0x343c
}
    28f7:	c9                   	leave  
    28f8:	c3                   	ret    

000028f9 <morecore>:

static Header*
morecore(uint nu)
{
    28f9:	55                   	push   %ebp
    28fa:	89 e5                	mov    %esp,%ebp
    28fc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    28ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2906:	77 07                	ja     290f <morecore+0x16>
    nu = 4096;
    2908:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    290f:	8b 45 08             	mov    0x8(%ebp),%eax
    2912:	c1 e0 03             	shl    $0x3,%eax
    2915:	89 04 24             	mov    %eax,(%esp)
    2918:	e8 27 fc ff ff       	call   2544 <sbrk>
    291d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    2920:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2924:	75 07                	jne    292d <morecore+0x34>
    return 0;
    2926:	b8 00 00 00 00       	mov    $0x0,%eax
    292b:	eb 22                	jmp    294f <morecore+0x56>
  hp = (Header*)p;
    292d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2930:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    2933:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2936:	8b 55 08             	mov    0x8(%ebp),%edx
    2939:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    293c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    293f:	83 c0 08             	add    $0x8,%eax
    2942:	89 04 24             	mov    %eax,(%esp)
    2945:	e8 ce fe ff ff       	call   2818 <free>
  return freep;
    294a:	a1 3c 34 00 00       	mov    0x343c,%eax
}
    294f:	c9                   	leave  
    2950:	c3                   	ret    

00002951 <malloc>:

void*
malloc(uint nbytes)
{
    2951:	55                   	push   %ebp
    2952:	89 e5                	mov    %esp,%ebp
    2954:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2957:	8b 45 08             	mov    0x8(%ebp),%eax
    295a:	83 c0 07             	add    $0x7,%eax
    295d:	c1 e8 03             	shr    $0x3,%eax
    2960:	83 c0 01             	add    $0x1,%eax
    2963:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    2966:	a1 3c 34 00 00       	mov    0x343c,%eax
    296b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    296e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2972:	75 23                	jne    2997 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    2974:	c7 45 f0 34 34 00 00 	movl   $0x3434,-0x10(%ebp)
    297b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    297e:	a3 3c 34 00 00       	mov    %eax,0x343c
    2983:	a1 3c 34 00 00       	mov    0x343c,%eax
    2988:	a3 34 34 00 00       	mov    %eax,0x3434
    base.s.size = 0;
    298d:	c7 05 38 34 00 00 00 	movl   $0x0,0x3438
    2994:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2997:	8b 45 f0             	mov    -0x10(%ebp),%eax
    299a:	8b 00                	mov    (%eax),%eax
    299c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    299f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29a2:	8b 40 04             	mov    0x4(%eax),%eax
    29a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    29a8:	72 4d                	jb     29f7 <malloc+0xa6>
      if(p->s.size == nunits)
    29aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29ad:	8b 40 04             	mov    0x4(%eax),%eax
    29b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    29b3:	75 0c                	jne    29c1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    29b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29b8:	8b 10                	mov    (%eax),%edx
    29ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29bd:	89 10                	mov    %edx,(%eax)
    29bf:	eb 26                	jmp    29e7 <malloc+0x96>
      else {
        p->s.size -= nunits;
    29c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29c4:	8b 40 04             	mov    0x4(%eax),%eax
    29c7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    29ca:	89 c2                	mov    %eax,%edx
    29cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    29d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29d5:	8b 40 04             	mov    0x4(%eax),%eax
    29d8:	c1 e0 03             	shl    $0x3,%eax
    29db:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    29de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    29e4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    29e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29ea:	a3 3c 34 00 00       	mov    %eax,0x343c
      return (void*)(p + 1);
    29ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29f2:	83 c0 08             	add    $0x8,%eax
    29f5:	eb 38                	jmp    2a2f <malloc+0xde>
    }
    if(p == freep)
    29f7:	a1 3c 34 00 00       	mov    0x343c,%eax
    29fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    29ff:	75 1b                	jne    2a1c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    2a01:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2a04:	89 04 24             	mov    %eax,(%esp)
    2a07:	e8 ed fe ff ff       	call   28f9 <morecore>
    2a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a13:	75 07                	jne    2a1c <malloc+0xcb>
        return 0;
    2a15:	b8 00 00 00 00       	mov    $0x0,%eax
    2a1a:	eb 13                	jmp    2a2f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a25:	8b 00                	mov    (%eax),%eax
    2a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    2a2a:	e9 70 ff ff ff       	jmp    299f <malloc+0x4e>
}
    2a2f:	c9                   	leave  
    2a30:	c3                   	ret    
    2a31:	66 90                	xchg   %ax,%ax
    2a33:	90                   	nop

00002a34 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    2a34:	55                   	push   %ebp
    2a35:	89 e5                	mov    %esp,%ebp
    2a37:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    2a3a:	8b 55 08             	mov    0x8(%ebp),%edx
    2a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a40:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2a43:	f0 87 02             	lock xchg %eax,(%edx)
    2a46:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    2a49:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2a4c:	c9                   	leave  
    2a4d:	c3                   	ret    

00002a4e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    2a4e:	55                   	push   %ebp
    2a4f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    2a51:	8b 45 08             	mov    0x8(%ebp),%eax
    2a54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    2a5a:	5d                   	pop    %ebp
    2a5b:	c3                   	ret    

00002a5c <lock_acquire>:
void lock_acquire(lock_t *lock){
    2a5c:	55                   	push   %ebp
    2a5d:	89 e5                	mov    %esp,%ebp
    2a5f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    2a62:	90                   	nop
    2a63:	8b 45 08             	mov    0x8(%ebp),%eax
    2a66:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2a6d:	00 
    2a6e:	89 04 24             	mov    %eax,(%esp)
    2a71:	e8 be ff ff ff       	call   2a34 <xchg>
    2a76:	85 c0                	test   %eax,%eax
    2a78:	75 e9                	jne    2a63 <lock_acquire+0x7>
}
    2a7a:	c9                   	leave  
    2a7b:	c3                   	ret    

00002a7c <lock_release>:
void lock_release(lock_t *lock){
    2a7c:	55                   	push   %ebp
    2a7d:	89 e5                	mov    %esp,%ebp
    2a7f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    2a82:	8b 45 08             	mov    0x8(%ebp),%eax
    2a85:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a8c:	00 
    2a8d:	89 04 24             	mov    %eax,(%esp)
    2a90:	e8 9f ff ff ff       	call   2a34 <xchg>
}
    2a95:	c9                   	leave  
    2a96:	c3                   	ret    

00002a97 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    2a97:	55                   	push   %ebp
    2a98:	89 e5                	mov    %esp,%ebp
    2a9a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2a9d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2aa4:	e8 a8 fe ff ff       	call   2951 <malloc>
    2aa9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    2aac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2aaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    2ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ab5:	25 ff 0f 00 00       	and    $0xfff,%eax
    2aba:	85 c0                	test   %eax,%eax
    2abc:	74 14                	je     2ad2 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    2abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ac1:	25 ff 0f 00 00       	and    $0xfff,%eax
    2ac6:	89 c2                	mov    %eax,%edx
    2ac8:	b8 00 10 00 00       	mov    $0x1000,%eax
    2acd:	29 d0                	sub    %edx,%eax
    2acf:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    2ad2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ad6:	75 1b                	jne    2af3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    2ad8:	c7 44 24 04 f4 2e 00 	movl   $0x2ef4,0x4(%esp)
    2adf:	00 
    2ae0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ae7:	e8 78 fb ff ff       	call   2664 <printf>
        return 0;
    2aec:	b8 00 00 00 00       	mov    $0x0,%eax
    2af1:	eb 6f                	jmp    2b62 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    2af3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2af6:	8b 55 08             	mov    0x8(%ebp),%edx
    2af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2afc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    2b00:	89 54 24 08          	mov    %edx,0x8(%esp)
    2b04:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    2b0b:	00 
    2b0c:	89 04 24             	mov    %eax,(%esp)
    2b0f:	e8 48 fa ff ff       	call   255c <clone>
    2b14:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    2b17:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b1b:	79 1b                	jns    2b38 <thread_create+0xa1>
        printf(1,"clone fails\n");
    2b1d:	c7 44 24 04 02 2f 00 	movl   $0x2f02,0x4(%esp)
    2b24:	00 
    2b25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b2c:	e8 33 fb ff ff       	call   2664 <printf>
        return 0;
    2b31:	b8 00 00 00 00       	mov    $0x0,%eax
    2b36:	eb 2a                	jmp    2b62 <thread_create+0xcb>
    }
    if(tid > 0){
    2b38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b3c:	7e 05                	jle    2b43 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    2b3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b41:	eb 1f                	jmp    2b62 <thread_create+0xcb>
    }
    if(tid == 0){
    2b43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b47:	75 14                	jne    2b5d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    2b49:	c7 44 24 04 0f 2f 00 	movl   $0x2f0f,0x4(%esp)
    2b50:	00 
    2b51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b58:	e8 07 fb ff ff       	call   2664 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    2b5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2b62:	c9                   	leave  
    2b63:	c3                   	ret    

00002b64 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    2b64:	55                   	push   %ebp
    2b65:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    2b67:	a1 10 34 00 00       	mov    0x3410,%eax
    2b6c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    2b72:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    2b77:	a3 10 34 00 00       	mov    %eax,0x3410
    return (int)(rands % max);
    2b7c:	a1 10 34 00 00       	mov    0x3410,%eax
    2b81:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2b84:	ba 00 00 00 00       	mov    $0x0,%edx
    2b89:	f7 f1                	div    %ecx
    2b8b:	89 d0                	mov    %edx,%eax
}
    2b8d:	5d                   	pop    %ebp
    2b8e:	c3                   	ret    
    2b8f:	90                   	nop

00002b90 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    2b90:	55                   	push   %ebp
    2b91:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    2b93:	8b 45 08             	mov    0x8(%ebp),%eax
    2b96:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2b9c:	8b 45 08             	mov    0x8(%ebp),%eax
    2b9f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    2ba6:	8b 45 08             	mov    0x8(%ebp),%eax
    2ba9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    2bb0:	5d                   	pop    %ebp
    2bb1:	c3                   	ret    

00002bb2 <add_q>:

void add_q(struct queue *q, int v){
    2bb2:	55                   	push   %ebp
    2bb3:	89 e5                	mov    %esp,%ebp
    2bb5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2bb8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2bbf:	e8 8d fd ff ff       	call   2951 <malloc>
    2bc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    2bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bd4:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bd7:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    2bdc:	8b 40 04             	mov    0x4(%eax),%eax
    2bdf:	85 c0                	test   %eax,%eax
    2be1:	75 0b                	jne    2bee <add_q+0x3c>
        q->head = n;
    2be3:	8b 45 08             	mov    0x8(%ebp),%eax
    2be6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2be9:	89 50 04             	mov    %edx,0x4(%eax)
    2bec:	eb 0c                	jmp    2bfa <add_q+0x48>
    }else{
        q->tail->next = n;
    2bee:	8b 45 08             	mov    0x8(%ebp),%eax
    2bf1:	8b 40 08             	mov    0x8(%eax),%eax
    2bf4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2bf7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    2bfa:	8b 45 08             	mov    0x8(%ebp),%eax
    2bfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2c00:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    2c03:	8b 45 08             	mov    0x8(%ebp),%eax
    2c06:	8b 00                	mov    (%eax),%eax
    2c08:	8d 50 01             	lea    0x1(%eax),%edx
    2c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2c0e:	89 10                	mov    %edx,(%eax)
}
    2c10:	c9                   	leave  
    2c11:	c3                   	ret    

00002c12 <empty_q>:

int empty_q(struct queue *q){
    2c12:	55                   	push   %ebp
    2c13:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    2c15:	8b 45 08             	mov    0x8(%ebp),%eax
    2c18:	8b 00                	mov    (%eax),%eax
    2c1a:	85 c0                	test   %eax,%eax
    2c1c:	75 07                	jne    2c25 <empty_q+0x13>
        return 1;
    2c1e:	b8 01 00 00 00       	mov    $0x1,%eax
    2c23:	eb 05                	jmp    2c2a <empty_q+0x18>
    else
        return 0;
    2c25:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    2c2a:	5d                   	pop    %ebp
    2c2b:	c3                   	ret    

00002c2c <pop_q>:
int pop_q(struct queue *q){
    2c2c:	55                   	push   %ebp
    2c2d:	89 e5                	mov    %esp,%ebp
    2c2f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    2c32:	8b 45 08             	mov    0x8(%ebp),%eax
    2c35:	89 04 24             	mov    %eax,(%esp)
    2c38:	e8 d5 ff ff ff       	call   2c12 <empty_q>
    2c3d:	85 c0                	test   %eax,%eax
    2c3f:	75 5d                	jne    2c9e <pop_q+0x72>
       val = q->head->value; 
    2c41:	8b 45 08             	mov    0x8(%ebp),%eax
    2c44:	8b 40 04             	mov    0x4(%eax),%eax
    2c47:	8b 00                	mov    (%eax),%eax
    2c49:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    2c4c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c4f:	8b 40 04             	mov    0x4(%eax),%eax
    2c52:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    2c55:	8b 45 08             	mov    0x8(%ebp),%eax
    2c58:	8b 40 04             	mov    0x4(%eax),%eax
    2c5b:	8b 50 04             	mov    0x4(%eax),%edx
    2c5e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c61:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    2c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c67:	89 04 24             	mov    %eax,(%esp)
    2c6a:	e8 a9 fb ff ff       	call   2818 <free>
       q->size--;
    2c6f:	8b 45 08             	mov    0x8(%ebp),%eax
    2c72:	8b 00                	mov    (%eax),%eax
    2c74:	8d 50 ff             	lea    -0x1(%eax),%edx
    2c77:	8b 45 08             	mov    0x8(%ebp),%eax
    2c7a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    2c7c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c7f:	8b 00                	mov    (%eax),%eax
    2c81:	85 c0                	test   %eax,%eax
    2c83:	75 14                	jne    2c99 <pop_q+0x6d>
            q->head = 0;
    2c85:	8b 45 08             	mov    0x8(%ebp),%eax
    2c88:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    2c8f:	8b 45 08             	mov    0x8(%ebp),%eax
    2c92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c9c:	eb 05                	jmp    2ca3 <pop_q+0x77>
    }
    return -1;
    2c9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2ca3:	c9                   	leave  
    2ca4:	c3                   	ret    
