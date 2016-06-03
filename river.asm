
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
    102f:	e8 1b 19 00 00       	call   294f <malloc>
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
    10b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->heads;
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	8b 40 04             	mov    0x4(%eax),%eax
    10c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->heads = q->heads->nexts;
    10c5:	8b 45 08             	mov    0x8(%ebp),%eax
    10c8:	8b 40 04             	mov    0x4(%eax),%eax
    10cb:	8b 50 04             	mov    0x4(%eax),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    10d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d7:	89 04 24             	mov    %eax,(%esp)
    10da:	e8 41 17 00 00       	call   2820 <free>
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
    1109:	8b 45 f0             	mov    -0x10(%ebp),%eax
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
    1143:	e8 02 19 00 00       	call   2a4a <lock_init>
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
    1162:	e8 f1 18 00 00       	call   2a58 <lock_acquire>
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
    117d:	e8 f5 18 00 00       	call   2a77 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 c6 18 00 00       	call   2a58 <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 b1 13 00 00       	call   2548 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 c0 18 00 00       	call   2a77 <lock_release>
    tsleep();
    11b7:	e8 bc 13 00 00       	call   2578 <tsleep>
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
    11e7:	e8 6c 18 00 00       	call   2a58 <lock_acquire>
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
    1202:	e8 70 18 00 00       	call   2a77 <lock_release>
		
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
    122a:	e8 51 13 00 00       	call   2580 <twakeup>
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
    1241:	e8 09 17 00 00       	call   294f <malloc>
    1246:	a3 38 2f 00 00       	mov    %eax,0x2f38
	p = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 f8 16 00 00       	call   294f <malloc>
    1257:	a3 3c 2f 00 00       	mov    %eax,0x2f3c
	d = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 e7 16 00 00       	call   294f <malloc>
    1268:	a3 40 2f 00 00       	mov    %eax,0x2f40
	sem_init(d, 1);
    126d:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
	sem_init(p, 1);
    1282:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1287:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    128e:	00 
    128f:	89 04 24             	mov    %eax,(%esp)
    1292:	e8 7e fe ff ff       	call   1115 <sem_init>
	//Test a-1: 2 missionary and 1 cannibal, arrival order: C->C->M->M->C->M
	printAction("Test 1: 2 Missionaries and 1 cannibal, arrival order: M->C->M\n");
    1297:	c7 04 24 a4 2c 00 00 	movl   $0x2ca4,(%esp)
    129e:	e8 81 0f 00 00       	call   2224 <printAction>
	sem_init(boat, 3);
    12a3:	a1 38 2f 00 00       	mov    0x2f38,%eax
    12a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    12af:	00 
    12b0:	89 04 24             	mov    %eax,(%esp)
    12b3:	e8 5d fe ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 1;
    12b8:	c7 05 44 2f 00 00 01 	movl   $0x1,0x2f44
    12bf:	00 00 00 
    // Current crossed set to 0
    crossed = 0;
    12c2:	c7 05 48 2f 00 00 00 	movl   $0x0,0x2f48
    12c9:	00 00 00 
    pass = 0;
    12cc:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    12d3:	00 00 00 

	tid = thread_create(MissionaryArrives, (void *) &arg);
    12d6:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    12db:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    12e2:	00 
    12e3:	89 04 24             	mov    %eax,(%esp)
    12e6:	e8 a7 17 00 00       	call   2a92 <thread_create>
    12eb:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    12f0:	a1 68 2f 00 00       	mov    0x2f68,%eax
    12f5:	85 c0                	test   %eax,%eax
    12f7:	75 11                	jne    130a <main+0xd9>
		printAction("Failed to create a thread\n");
    12f9:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1300:	e8 1f 0f 00 00       	call   2224 <printAction>
		exit();
    1305:	e8 be 11 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    130a:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1311:	00 00 00 
    1314:	eb 0d                	jmp    1323 <main+0xf2>
    1316:	a1 64 2f 00 00       	mov    0x2f64,%eax
    131b:	83 c0 01             	add    $0x1,%eax
    131e:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1323:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1328:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    132d:	7e e7                	jle    1316 <main+0xe5>
	tid = thread_create(CannibalArrives, (void *) &arg);
    132f:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1334:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    133b:	00 
    133c:	89 04 24             	mov    %eax,(%esp)
    133f:	e8 4e 17 00 00       	call   2a92 <thread_create>
    1344:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1349:	a1 68 2f 00 00       	mov    0x2f68,%eax
    134e:	85 c0                	test   %eax,%eax
    1350:	75 11                	jne    1363 <main+0x132>
		printAction("Failed to create a thread\n");
    1352:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1359:	e8 c6 0e 00 00       	call   2224 <printAction>
		exit();
    135e:	e8 65 11 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1363:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    136a:	00 00 00 
    136d:	eb 0d                	jmp    137c <main+0x14b>
    136f:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1374:	83 c0 01             	add    $0x1,%eax
    1377:	a3 64 2f 00 00       	mov    %eax,0x2f64
    137c:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1381:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1386:	7e e7                	jle    136f <main+0x13e>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1388:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    138d:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1394:	00 
    1395:	89 04 24             	mov    %eax,(%esp)
    1398:	e8 f5 16 00 00       	call   2a92 <thread_create>
    139d:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    13a2:	a1 68 2f 00 00       	mov    0x2f68,%eax
    13a7:	85 c0                	test   %eax,%eax
    13a9:	75 11                	jne    13bc <main+0x18b>
		printAction("Failed to create a thread\n");
    13ab:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    13b2:	e8 6d 0e 00 00       	call   2224 <printAction>
		exit();
    13b7:	e8 0c 11 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    13bc:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    13c3:	00 00 00 
    13c6:	eb 0d                	jmp    13d5 <main+0x1a4>
    13c8:	a1 64 2f 00 00       	mov    0x2f64,%eax
    13cd:	83 c0 01             	add    $0x1,%eax
    13d0:	a3 64 2f 00 00       	mov    %eax,0x2f64
    13d5:	a1 64 2f 00 00       	mov    0x2f64,%eax
    13da:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13df:	7e e7                	jle    13c8 <main+0x197>
	while(crossed != crossing)
    13e1:	eb 6c                	jmp    144f <main+0x21e>
	{
	    if(boat->count == 0){
    13e3:	a1 38 2f 00 00       	mov    0x2f38,%eax
    13e8:	8b 00                	mov    (%eax),%eax
    13ea:	85 c0                	test   %eax,%eax
    13ec:	75 61                	jne    144f <main+0x21e>
    	    tid = thread_create(RowBoat, (void *) &arg);
    13ee:	b8 be 20 00 00       	mov    $0x20be,%eax
    13f3:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    13fa:	00 
    13fb:	89 04 24             	mov    %eax,(%esp)
    13fe:	e8 8f 16 00 00       	call   2a92 <thread_create>
    1403:	a3 68 2f 00 00       	mov    %eax,0x2f68
        	if(tid <= 0){
    1408:	a1 68 2f 00 00       	mov    0x2f68,%eax
    140d:	85 c0                	test   %eax,%eax
    140f:	75 11                	jne    1422 <main+0x1f1>
        		printAction("Failed to create a thread\n");
    1411:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1418:	e8 07 0e 00 00       	call   2224 <printAction>
        		exit();
    141d:	e8 a6 10 00 00       	call   24c8 <exit>
        	}
        	while(wait()>= 0);
    1422:	e8 a9 10 00 00       	call   24d0 <wait>
    1427:	85 c0                	test   %eax,%eax
    1429:	79 f7                	jns    1422 <main+0x1f1>
        	sem_acquire(p);
    142b:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1430:	89 04 24             	mov    %eax,(%esp)
    1433:	e8 12 fd ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    1438:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    143f:	00 00 00 
	    	sem_signal(p);
    1442:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1447:	89 04 24             	mov    %eax,(%esp)
    144a:	e8 7a fd ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    144f:	8b 15 48 2f 00 00    	mov    0x2f48,%edx
    1455:	a1 44 2f 00 00       	mov    0x2f44,%eax
    145a:	39 c2                	cmp    %eax,%edx
    145c:	75 85                	jne    13e3 <main+0x1b2>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    145e:	e8 6d 10 00 00       	call   24d0 <wait>
    1463:	85 c0                	test   %eax,%eax
    1465:	79 f7                	jns    145e <main+0x22d>
	
	//Test 2: 3 missionaries and 3 cannibals, arrival order: C->C->M->M->C->M
	printAction("\nTest 2: 3 Missionaries and 3 cannibal, arrival order: C->C->M->M->C->M\n");
    1467:	c7 04 24 00 2d 00 00 	movl   $0x2d00,(%esp)
    146e:	e8 b1 0d 00 00       	call   2224 <printAction>
	sem_init(boat, 3);
    1473:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1478:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    147f:	00 
    1480:	89 04 24             	mov    %eax,(%esp)
    1483:	e8 8d fc ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 2;
    1488:	c7 05 44 2f 00 00 02 	movl   $0x2,0x2f44
    148f:	00 00 00 
    crossed = 0;
    1492:	c7 05 48 2f 00 00 00 	movl   $0x0,0x2f48
    1499:	00 00 00 
    pass = 0;
    149c:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    14a3:	00 00 00 
	
	tid = thread_create(CannibalArrives, (void *) &arg);
    14a6:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    14ab:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    14b2:	00 
    14b3:	89 04 24             	mov    %eax,(%esp)
    14b6:	e8 d7 15 00 00       	call   2a92 <thread_create>
    14bb:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    14c0:	a1 68 2f 00 00       	mov    0x2f68,%eax
    14c5:	85 c0                	test   %eax,%eax
    14c7:	75 11                	jne    14da <main+0x2a9>
		printAction("Failed to create a thread\n");
    14c9:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    14d0:	e8 4f 0d 00 00       	call   2224 <printAction>
		exit();
    14d5:	e8 ee 0f 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    14da:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    14e1:	00 00 00 
    14e4:	eb 0d                	jmp    14f3 <main+0x2c2>
    14e6:	a1 64 2f 00 00       	mov    0x2f64,%eax
    14eb:	83 c0 01             	add    $0x1,%eax
    14ee:	a3 64 2f 00 00       	mov    %eax,0x2f64
    14f3:	a1 64 2f 00 00       	mov    0x2f64,%eax
    14f8:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    14fd:	7e e7                	jle    14e6 <main+0x2b5>
	tid = thread_create(CannibalArrives, (void *) &arg);
    14ff:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1504:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    150b:	00 
    150c:	89 04 24             	mov    %eax,(%esp)
    150f:	e8 7e 15 00 00       	call   2a92 <thread_create>
    1514:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1519:	a1 68 2f 00 00       	mov    0x2f68,%eax
    151e:	85 c0                	test   %eax,%eax
    1520:	75 11                	jne    1533 <main+0x302>
		printAction("Failed to create a thread\n");
    1522:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1529:	e8 f6 0c 00 00       	call   2224 <printAction>
		exit();
    152e:	e8 95 0f 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1533:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    153a:	00 00 00 
    153d:	eb 0d                	jmp    154c <main+0x31b>
    153f:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1544:	83 c0 01             	add    $0x1,%eax
    1547:	a3 64 2f 00 00       	mov    %eax,0x2f64
    154c:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1551:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1556:	7e e7                	jle    153f <main+0x30e>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1558:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    155d:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1564:	00 
    1565:	89 04 24             	mov    %eax,(%esp)
    1568:	e8 25 15 00 00       	call   2a92 <thread_create>
    156d:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1572:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1577:	85 c0                	test   %eax,%eax
    1579:	75 11                	jne    158c <main+0x35b>
		printAction("Failed to create a thread\n");
    157b:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1582:	e8 9d 0c 00 00       	call   2224 <printAction>
		exit();
    1587:	e8 3c 0f 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    158c:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1593:	00 00 00 
    1596:	eb 0d                	jmp    15a5 <main+0x374>
    1598:	a1 64 2f 00 00       	mov    0x2f64,%eax
    159d:	83 c0 01             	add    $0x1,%eax
    15a0:	a3 64 2f 00 00       	mov    %eax,0x2f64
    15a5:	a1 64 2f 00 00       	mov    0x2f64,%eax
    15aa:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15af:	7e e7                	jle    1598 <main+0x367>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    15b1:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    15b6:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    15bd:	00 
    15be:	89 04 24             	mov    %eax,(%esp)
    15c1:	e8 cc 14 00 00       	call   2a92 <thread_create>
    15c6:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    15cb:	a1 68 2f 00 00       	mov    0x2f68,%eax
    15d0:	85 c0                	test   %eax,%eax
    15d2:	75 11                	jne    15e5 <main+0x3b4>
		printAction("Failed to create a thread\n");
    15d4:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    15db:	e8 44 0c 00 00       	call   2224 <printAction>
		exit();
    15e0:	e8 e3 0e 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    15e5:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    15ec:	00 00 00 
    15ef:	eb 0d                	jmp    15fe <main+0x3cd>
    15f1:	a1 64 2f 00 00       	mov    0x2f64,%eax
    15f6:	83 c0 01             	add    $0x1,%eax
    15f9:	a3 64 2f 00 00       	mov    %eax,0x2f64
    15fe:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1603:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1608:	7e e7                	jle    15f1 <main+0x3c0>
	tid = thread_create(CannibalArrives, (void *) &arg);
    160a:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    160f:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1616:	00 
    1617:	89 04 24             	mov    %eax,(%esp)
    161a:	e8 73 14 00 00       	call   2a92 <thread_create>
    161f:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1624:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1629:	85 c0                	test   %eax,%eax
    162b:	75 11                	jne    163e <main+0x40d>
		printAction("Failed to create a thread\n");
    162d:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1634:	e8 eb 0b 00 00       	call   2224 <printAction>
		exit();
    1639:	e8 8a 0e 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    163e:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1645:	00 00 00 
    1648:	eb 0d                	jmp    1657 <main+0x426>
    164a:	a1 64 2f 00 00       	mov    0x2f64,%eax
    164f:	83 c0 01             	add    $0x1,%eax
    1652:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1657:	a1 64 2f 00 00       	mov    0x2f64,%eax
    165c:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1661:	7e e7                	jle    164a <main+0x419>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1663:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1668:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    166f:	00 
    1670:	89 04 24             	mov    %eax,(%esp)
    1673:	e8 1a 14 00 00       	call   2a92 <thread_create>
    1678:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    167d:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1682:	85 c0                	test   %eax,%eax
    1684:	75 11                	jne    1697 <main+0x466>
		printAction("Failed to create a thread\n");
    1686:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    168d:	e8 92 0b 00 00       	call   2224 <printAction>
		exit();
    1692:	e8 31 0e 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1697:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    169e:	00 00 00 
    16a1:	eb 0d                	jmp    16b0 <main+0x47f>
    16a3:	a1 64 2f 00 00       	mov    0x2f64,%eax
    16a8:	83 c0 01             	add    $0x1,%eax
    16ab:	a3 64 2f 00 00       	mov    %eax,0x2f64
    16b0:	a1 64 2f 00 00       	mov    0x2f64,%eax
    16b5:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    16ba:	7e e7                	jle    16a3 <main+0x472>
	while(crossed != crossing)
    16bc:	eb 6c                	jmp    172a <main+0x4f9>
	{
	    if(boat->count == 0){
    16be:	a1 38 2f 00 00       	mov    0x2f38,%eax
    16c3:	8b 00                	mov    (%eax),%eax
    16c5:	85 c0                	test   %eax,%eax
    16c7:	75 61                	jne    172a <main+0x4f9>
    	    tid = thread_create(RowBoat, (void *) &arg);
    16c9:	b8 be 20 00 00       	mov    $0x20be,%eax
    16ce:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    16d5:	00 
    16d6:	89 04 24             	mov    %eax,(%esp)
    16d9:	e8 b4 13 00 00       	call   2a92 <thread_create>
    16de:	a3 68 2f 00 00       	mov    %eax,0x2f68
        	if(tid <= 0){
    16e3:	a1 68 2f 00 00       	mov    0x2f68,%eax
    16e8:	85 c0                	test   %eax,%eax
    16ea:	75 11                	jne    16fd <main+0x4cc>
        		printAction("Failed to create a thread\n");
    16ec:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    16f3:	e8 2c 0b 00 00       	call   2224 <printAction>
        		exit();
    16f8:	e8 cb 0d 00 00       	call   24c8 <exit>
        	}
        	while(wait()>= 0);
    16fd:	e8 ce 0d 00 00       	call   24d0 <wait>
    1702:	85 c0                	test   %eax,%eax
    1704:	79 f7                	jns    16fd <main+0x4cc>
        	sem_acquire(p);
    1706:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    170b:	89 04 24             	mov    %eax,(%esp)
    170e:	e8 37 fa ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    1713:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    171a:	00 00 00 
	    	sem_signal(p);
    171d:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1722:	89 04 24             	mov    %eax,(%esp)
    1725:	e8 9f fa ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    172a:	8b 15 48 2f 00 00    	mov    0x2f48,%edx
    1730:	a1 44 2f 00 00       	mov    0x2f44,%eax
    1735:	39 c2                	cmp    %eax,%edx
    1737:	75 85                	jne    16be <main+0x48d>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    1739:	e8 92 0d 00 00       	call   24d0 <wait>
    173e:	85 c0                	test   %eax,%eax
    1740:	79 f7                	jns    1739 <main+0x508>
    
	//Test 3: 4 missionaries and 2 cannibals, arrival order: M->C->C->M->M->M
	printAction("\nTest 3: 4 Missionaries and 2 cannibal, arrival order: M->C->C->M->M->M\n");
    1742:	c7 04 24 4c 2d 00 00 	movl   $0x2d4c,(%esp)
    1749:	e8 d6 0a 00 00       	call   2224 <printAction>
	sem_init(boat, 3);
    174e:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1753:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    175a:	00 
    175b:	89 04 24             	mov    %eax,(%esp)
    175e:	e8 b2 f9 ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 2;
    1763:	c7 05 44 2f 00 00 02 	movl   $0x2,0x2f44
    176a:	00 00 00 
    crossed = 0;
    176d:	c7 05 48 2f 00 00 00 	movl   $0x0,0x2f48
    1774:	00 00 00 
	pass = 0;
    1777:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    177e:	00 00 00 
	
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1781:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1786:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    178d:	00 
    178e:	89 04 24             	mov    %eax,(%esp)
    1791:	e8 fc 12 00 00       	call   2a92 <thread_create>
    1796:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    179b:	a1 68 2f 00 00       	mov    0x2f68,%eax
    17a0:	85 c0                	test   %eax,%eax
    17a2:	75 11                	jne    17b5 <main+0x584>
		printAction("Failed to create a thread\n");
    17a4:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    17ab:	e8 74 0a 00 00       	call   2224 <printAction>
		exit();
    17b0:	e8 13 0d 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    17b5:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    17bc:	00 00 00 
    17bf:	eb 0d                	jmp    17ce <main+0x59d>
    17c1:	a1 64 2f 00 00       	mov    0x2f64,%eax
    17c6:	83 c0 01             	add    $0x1,%eax
    17c9:	a3 64 2f 00 00       	mov    %eax,0x2f64
    17ce:	a1 64 2f 00 00       	mov    0x2f64,%eax
    17d3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17d8:	7e e7                	jle    17c1 <main+0x590>
	tid = thread_create(CannibalArrives, (void *) &arg);
    17da:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    17df:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    17e6:	00 
    17e7:	89 04 24             	mov    %eax,(%esp)
    17ea:	e8 a3 12 00 00       	call   2a92 <thread_create>
    17ef:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    17f4:	a1 68 2f 00 00       	mov    0x2f68,%eax
    17f9:	85 c0                	test   %eax,%eax
    17fb:	75 11                	jne    180e <main+0x5dd>
		printAction("Failed to create a thread\n");
    17fd:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1804:	e8 1b 0a 00 00       	call   2224 <printAction>
		exit();
    1809:	e8 ba 0c 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    180e:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1815:	00 00 00 
    1818:	eb 0d                	jmp    1827 <main+0x5f6>
    181a:	a1 64 2f 00 00       	mov    0x2f64,%eax
    181f:	83 c0 01             	add    $0x1,%eax
    1822:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1827:	a1 64 2f 00 00       	mov    0x2f64,%eax
    182c:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1831:	7e e7                	jle    181a <main+0x5e9>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1833:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1838:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    183f:	00 
    1840:	89 04 24             	mov    %eax,(%esp)
    1843:	e8 4a 12 00 00       	call   2a92 <thread_create>
    1848:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    184d:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1852:	85 c0                	test   %eax,%eax
    1854:	75 11                	jne    1867 <main+0x636>
		printAction("Failed to create a thread\n");
    1856:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    185d:	e8 c2 09 00 00       	call   2224 <printAction>
		exit();
    1862:	e8 61 0c 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1867:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    186e:	00 00 00 
    1871:	eb 0d                	jmp    1880 <main+0x64f>
    1873:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1878:	83 c0 01             	add    $0x1,%eax
    187b:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1880:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1885:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    188a:	7e e7                	jle    1873 <main+0x642>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    188c:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1891:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1898:	00 
    1899:	89 04 24             	mov    %eax,(%esp)
    189c:	e8 f1 11 00 00       	call   2a92 <thread_create>
    18a1:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    18a6:	a1 68 2f 00 00       	mov    0x2f68,%eax
    18ab:	85 c0                	test   %eax,%eax
    18ad:	75 11                	jne    18c0 <main+0x68f>
		printAction("Failed to create a thread\n");
    18af:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    18b6:	e8 69 09 00 00       	call   2224 <printAction>
		exit();
    18bb:	e8 08 0c 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    18c0:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    18c7:	00 00 00 
    18ca:	eb 0d                	jmp    18d9 <main+0x6a8>
    18cc:	a1 64 2f 00 00       	mov    0x2f64,%eax
    18d1:	83 c0 01             	add    $0x1,%eax
    18d4:	a3 64 2f 00 00       	mov    %eax,0x2f64
    18d9:	a1 64 2f 00 00       	mov    0x2f64,%eax
    18de:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    18e3:	7e e7                	jle    18cc <main+0x69b>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    18e5:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    18ea:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    18f1:	00 
    18f2:	89 04 24             	mov    %eax,(%esp)
    18f5:	e8 98 11 00 00       	call   2a92 <thread_create>
    18fa:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    18ff:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1904:	85 c0                	test   %eax,%eax
    1906:	75 11                	jne    1919 <main+0x6e8>
		printAction("Failed to create a thread\n");
    1908:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    190f:	e8 10 09 00 00       	call   2224 <printAction>
		exit();
    1914:	e8 af 0b 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1919:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1920:	00 00 00 
    1923:	eb 0d                	jmp    1932 <main+0x701>
    1925:	a1 64 2f 00 00       	mov    0x2f64,%eax
    192a:	83 c0 01             	add    $0x1,%eax
    192d:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1932:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1937:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    193c:	7e e7                	jle    1925 <main+0x6f4>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    193e:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1943:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    194a:	00 
    194b:	89 04 24             	mov    %eax,(%esp)
    194e:	e8 3f 11 00 00       	call   2a92 <thread_create>
    1953:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1958:	a1 68 2f 00 00       	mov    0x2f68,%eax
    195d:	85 c0                	test   %eax,%eax
    195f:	75 11                	jne    1972 <main+0x741>
		printAction("Failed to create a thread\n");
    1961:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1968:	e8 b7 08 00 00       	call   2224 <printAction>
		exit();
    196d:	e8 56 0b 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1972:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1979:	00 00 00 
    197c:	eb 0d                	jmp    198b <main+0x75a>
    197e:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1983:	83 c0 01             	add    $0x1,%eax
    1986:	a3 64 2f 00 00       	mov    %eax,0x2f64
    198b:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1990:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1995:	7e e7                	jle    197e <main+0x74d>
	while(crossed != crossing)
    1997:	eb 6c                	jmp    1a05 <main+0x7d4>
	{
	    if(boat->count == 0){
    1999:	a1 38 2f 00 00       	mov    0x2f38,%eax
    199e:	8b 00                	mov    (%eax),%eax
    19a0:	85 c0                	test   %eax,%eax
    19a2:	75 61                	jne    1a05 <main+0x7d4>
    	    tid = thread_create(RowBoat, (void *) &arg);
    19a4:	b8 be 20 00 00       	mov    $0x20be,%eax
    19a9:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    19b0:	00 
    19b1:	89 04 24             	mov    %eax,(%esp)
    19b4:	e8 d9 10 00 00       	call   2a92 <thread_create>
    19b9:	a3 68 2f 00 00       	mov    %eax,0x2f68
        	if(tid <= 0){
    19be:	a1 68 2f 00 00       	mov    0x2f68,%eax
    19c3:	85 c0                	test   %eax,%eax
    19c5:	75 11                	jne    19d8 <main+0x7a7>
        		printAction("Failed to create a thread\n");
    19c7:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    19ce:	e8 51 08 00 00       	call   2224 <printAction>
        		exit();
    19d3:	e8 f0 0a 00 00       	call   24c8 <exit>
        	}
        	while(wait()>= 0);
    19d8:	e8 f3 0a 00 00       	call   24d0 <wait>
    19dd:	85 c0                	test   %eax,%eax
    19df:	79 f7                	jns    19d8 <main+0x7a7>
        	sem_acquire(p);
    19e1:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    19e6:	89 04 24             	mov    %eax,(%esp)
    19e9:	e8 5c f7 ff ff       	call   114a <sem_acquire>
	    	pass = 0;
    19ee:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    19f5:	00 00 00 
	    	sem_signal(p);
    19f8:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    19fd:	89 04 24             	mov    %eax,(%esp)
    1a00:	e8 c4 f7 ff ff       	call   11c9 <sem_signal>
	if(tid <= 0){
		printAction("Failed to create a thread\n");
		exit();
	}
	for(i = 0; i < 999999; i++);
	while(crossed != crossing)
    1a05:	8b 15 48 2f 00 00    	mov    0x2f48,%edx
    1a0b:	a1 44 2f 00 00       	mov    0x2f44,%eax
    1a10:	39 c2                	cmp    %eax,%edx
    1a12:	75 85                	jne    1999 <main+0x768>
        	sem_acquire(p);
	    	pass = 0;
	    	sem_signal(p);
	    }
	}
    while(wait()>= 0);
    1a14:	e8 b7 0a 00 00       	call   24d0 <wait>
    1a19:	85 c0                	test   %eax,%eax
    1a1b:	79 f7                	jns    1a14 <main+0x7e3>
	
	//Test 4: 4 missionaries and 5 cannibals, arrival order: C->M->C->M->M->M->C->C->C
	printAction("\nTest 4: 4 Missionaries and 5 cannibal, arrival order: C->M->C->M->M->M->C->C->C\n");
    1a1d:	c7 04 24 98 2d 00 00 	movl   $0x2d98,(%esp)
    1a24:	e8 fb 07 00 00       	call   2224 <printAction>
	sem_init(boat, 3);
    1a29:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1a2e:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1a35:	00 
    1a36:	89 04 24             	mov    %eax,(%esp)
    1a39:	e8 d7 f6 ff ff       	call   1115 <sem_init>
	// Number of cross for testing
    crossing = 3;
    1a3e:	c7 05 44 2f 00 00 03 	movl   $0x3,0x2f44
    1a45:	00 00 00 
    crossed = 0;
    1a48:	c7 05 48 2f 00 00 00 	movl   $0x0,0x2f48
    1a4f:	00 00 00 
	pass = 0;
    1a52:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    1a59:	00 00 00 
	
	tid = thread_create(CannibalArrives, (void *) &arg);
    1a5c:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1a61:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1a68:	00 
    1a69:	89 04 24             	mov    %eax,(%esp)
    1a6c:	e8 21 10 00 00       	call   2a92 <thread_create>
    1a71:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1a76:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1a7b:	85 c0                	test   %eax,%eax
    1a7d:	75 11                	jne    1a90 <main+0x85f>
		printAction("Failed to create a thread\n");
    1a7f:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1a86:	e8 99 07 00 00       	call   2224 <printAction>
		exit();
    1a8b:	e8 38 0a 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1a90:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1a97:	00 00 00 
    1a9a:	eb 0d                	jmp    1aa9 <main+0x878>
    1a9c:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1aa1:	83 c0 01             	add    $0x1,%eax
    1aa4:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1aa9:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1aae:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1ab3:	7e e7                	jle    1a9c <main+0x86b>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1ab5:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1aba:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1ac1:	00 
    1ac2:	89 04 24             	mov    %eax,(%esp)
    1ac5:	e8 c8 0f 00 00       	call   2a92 <thread_create>
    1aca:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1acf:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1ad4:	85 c0                	test   %eax,%eax
    1ad6:	75 11                	jne    1ae9 <main+0x8b8>
		printAction("Failed to create a thread\n");
    1ad8:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1adf:	e8 40 07 00 00       	call   2224 <printAction>
		exit();
    1ae4:	e8 df 09 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1ae9:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1af0:	00 00 00 
    1af3:	eb 0d                	jmp    1b02 <main+0x8d1>
    1af5:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1afa:	83 c0 01             	add    $0x1,%eax
    1afd:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1b02:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1b07:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1b0c:	7e e7                	jle    1af5 <main+0x8c4>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1b0e:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1b13:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1b1a:	00 
    1b1b:	89 04 24             	mov    %eax,(%esp)
    1b1e:	e8 6f 0f 00 00       	call   2a92 <thread_create>
    1b23:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1b28:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1b2d:	85 c0                	test   %eax,%eax
    1b2f:	75 11                	jne    1b42 <main+0x911>
		printAction("Failed to create a thread\n");
    1b31:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1b38:	e8 e7 06 00 00       	call   2224 <printAction>
		exit();
    1b3d:	e8 86 09 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1b42:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1b49:	00 00 00 
    1b4c:	eb 0d                	jmp    1b5b <main+0x92a>
    1b4e:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1b53:	83 c0 01             	add    $0x1,%eax
    1b56:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1b5b:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1b60:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1b65:	7e e7                	jle    1b4e <main+0x91d>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1b67:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1b6c:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1b73:	00 
    1b74:	89 04 24             	mov    %eax,(%esp)
    1b77:	e8 16 0f 00 00       	call   2a92 <thread_create>
    1b7c:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1b81:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1b86:	85 c0                	test   %eax,%eax
    1b88:	75 11                	jne    1b9b <main+0x96a>
		printAction("Failed to create a thread\n");
    1b8a:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1b91:	e8 8e 06 00 00       	call   2224 <printAction>
		exit();
    1b96:	e8 2d 09 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1b9b:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1ba2:	00 00 00 
    1ba5:	eb 0d                	jmp    1bb4 <main+0x983>
    1ba7:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1bac:	83 c0 01             	add    $0x1,%eax
    1baf:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1bb4:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1bb9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1bbe:	7e e7                	jle    1ba7 <main+0x976>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1bc0:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1bc5:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1bcc:	00 
    1bcd:	89 04 24             	mov    %eax,(%esp)
    1bd0:	e8 bd 0e 00 00       	call   2a92 <thread_create>
    1bd5:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1bda:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1bdf:	85 c0                	test   %eax,%eax
    1be1:	75 11                	jne    1bf4 <main+0x9c3>
		printAction("Failed to create a thread\n");
    1be3:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1bea:	e8 35 06 00 00       	call   2224 <printAction>
		exit();
    1bef:	e8 d4 08 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1bf4:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1bfb:	00 00 00 
    1bfe:	eb 0d                	jmp    1c0d <main+0x9dc>
    1c00:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1c05:	83 c0 01             	add    $0x1,%eax
    1c08:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1c0d:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1c12:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1c17:	7e e7                	jle    1c00 <main+0x9cf>
	tid = thread_create(MissionaryArrives, (void *) &arg);
    1c19:	b8 2c 1f 00 00       	mov    $0x1f2c,%eax
    1c1e:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1c25:	00 
    1c26:	89 04 24             	mov    %eax,(%esp)
    1c29:	e8 64 0e 00 00       	call   2a92 <thread_create>
    1c2e:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1c33:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1c38:	85 c0                	test   %eax,%eax
    1c3a:	75 11                	jne    1c4d <main+0xa1c>
		printAction("Failed to create a thread\n");
    1c3c:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1c43:	e8 dc 05 00 00       	call   2224 <printAction>
		exit();
    1c48:	e8 7b 08 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1c4d:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1c54:	00 00 00 
    1c57:	eb 0d                	jmp    1c66 <main+0xa35>
    1c59:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1c5e:	83 c0 01             	add    $0x1,%eax
    1c61:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1c66:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1c6b:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1c70:	7e e7                	jle    1c59 <main+0xa28>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1c72:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1c77:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1c7e:	00 
    1c7f:	89 04 24             	mov    %eax,(%esp)
    1c82:	e8 0b 0e 00 00       	call   2a92 <thread_create>
    1c87:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1c8c:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1c91:	85 c0                	test   %eax,%eax
    1c93:	75 11                	jne    1ca6 <main+0xa75>
		printAction("Failed to create a thread\n");
    1c95:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1c9c:	e8 83 05 00 00       	call   2224 <printAction>
		exit();
    1ca1:	e8 22 08 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1ca6:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1cad:	00 00 00 
    1cb0:	eb 0d                	jmp    1cbf <main+0xa8e>
    1cb2:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1cb7:	83 c0 01             	add    $0x1,%eax
    1cba:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1cbf:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1cc4:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1cc9:	7e e7                	jle    1cb2 <main+0xa81>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1ccb:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1cd0:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1cd7:	00 
    1cd8:	89 04 24             	mov    %eax,(%esp)
    1cdb:	e8 b2 0d 00 00       	call   2a92 <thread_create>
    1ce0:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1ce5:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1cea:	85 c0                	test   %eax,%eax
    1cec:	75 11                	jne    1cff <main+0xace>
		printAction("Failed to create a thread\n");
    1cee:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1cf5:	e8 2a 05 00 00       	call   2224 <printAction>
		exit();
    1cfa:	e8 c9 07 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1cff:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1d06:	00 00 00 
    1d09:	eb 0d                	jmp    1d18 <main+0xae7>
    1d0b:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1d10:	83 c0 01             	add    $0x1,%eax
    1d13:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1d18:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1d1d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1d22:	7e e7                	jle    1d0b <main+0xada>
	tid = thread_create(CannibalArrives, (void *) &arg);
    1d24:	b8 ef 1f 00 00       	mov    $0x1fef,%eax
    1d29:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1d30:	00 
    1d31:	89 04 24             	mov    %eax,(%esp)
    1d34:	e8 59 0d 00 00       	call   2a92 <thread_create>
    1d39:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1d3e:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1d43:	85 c0                	test   %eax,%eax
    1d45:	75 11                	jne    1d58 <main+0xb27>
		printAction("Failed to create a thread\n");
    1d47:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1d4e:	e8 d1 04 00 00       	call   2224 <printAction>
		exit();
    1d53:	e8 70 07 00 00       	call   24c8 <exit>
	}
	for(i = 0; i < 999999; i++);
    1d58:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1d5f:	00 00 00 
    1d62:	eb 0d                	jmp    1d71 <main+0xb40>
    1d64:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1d69:	83 c0 01             	add    $0x1,%eax
    1d6c:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1d71:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1d76:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1d7b:	7e e7                	jle    1d64 <main+0xb33>
	
	while(boat->count != 0);
    1d7d:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1d82:	8b 00                	mov    (%eax),%eax
    1d84:	85 c0                	test   %eax,%eax
    1d86:	75 f5                	jne    1d7d <main+0xb4c>
	tid = thread_create(RowBoat, (void *) &arg);
    1d88:	b8 be 20 00 00       	mov    $0x20be,%eax
    1d8d:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1d94:	00 
    1d95:	89 04 24             	mov    %eax,(%esp)
    1d98:	e8 f5 0c 00 00       	call   2a92 <thread_create>
    1d9d:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1da2:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1da7:	85 c0                	test   %eax,%eax
    1da9:	75 11                	jne    1dbc <main+0xb8b>
		printAction("Failed to create a thread\n");
    1dab:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1db2:	e8 6d 04 00 00       	call   2224 <printAction>
		exit();
    1db7:	e8 0c 07 00 00       	call   24c8 <exit>
	}
	sem_acquire(p);
    1dbc:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1dc1:	89 04 24             	mov    %eax,(%esp)
    1dc4:	e8 81 f3 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1dc9:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    1dd0:	00 00 00 
	sem_signal(p);
    1dd3:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1dd8:	89 04 24             	mov    %eax,(%esp)
    1ddb:	e8 e9 f3 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1de0:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1de7:	00 00 00 
    1dea:	eb 0d                	jmp    1df9 <main+0xbc8>
    1dec:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1df1:	83 c0 01             	add    $0x1,%eax
    1df4:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1df9:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1dfe:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1e03:	7e e7                	jle    1dec <main+0xbbb>
	
	while(boat->count != 0);
    1e05:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1e0a:	8b 00                	mov    (%eax),%eax
    1e0c:	85 c0                	test   %eax,%eax
    1e0e:	75 f5                	jne    1e05 <main+0xbd4>
	tid = thread_create(RowBoat, (void *) &arg);
    1e10:	b8 be 20 00 00       	mov    $0x20be,%eax
    1e15:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1e1c:	00 
    1e1d:	89 04 24             	mov    %eax,(%esp)
    1e20:	e8 6d 0c 00 00       	call   2a92 <thread_create>
    1e25:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1e2a:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1e2f:	85 c0                	test   %eax,%eax
    1e31:	75 11                	jne    1e44 <main+0xc13>
		printAction("Failed to create a thread\n");
    1e33:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1e3a:	e8 e5 03 00 00       	call   2224 <printAction>
		exit();
    1e3f:	e8 84 06 00 00       	call   24c8 <exit>
	}
	sem_acquire(p);
    1e44:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1e49:	89 04 24             	mov    %eax,(%esp)
    1e4c:	e8 f9 f2 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1e51:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    1e58:	00 00 00 
	sem_signal(p);
    1e5b:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1e60:	89 04 24             	mov    %eax,(%esp)
    1e63:	e8 61 f3 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1e68:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1e6f:	00 00 00 
    1e72:	eb 0d                	jmp    1e81 <main+0xc50>
    1e74:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1e79:	83 c0 01             	add    $0x1,%eax
    1e7c:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1e81:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1e86:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1e8b:	7e e7                	jle    1e74 <main+0xc43>
	
	while(boat->count != 0);
    1e8d:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1e92:	8b 00                	mov    (%eax),%eax
    1e94:	85 c0                	test   %eax,%eax
    1e96:	75 f5                	jne    1e8d <main+0xc5c>
	tid = thread_create(RowBoat, (void *) &arg);
    1e98:	b8 be 20 00 00       	mov    $0x20be,%eax
    1e9d:	c7 44 24 04 1c 2f 00 	movl   $0x2f1c,0x4(%esp)
    1ea4:	00 
    1ea5:	89 04 24             	mov    %eax,(%esp)
    1ea8:	e8 e5 0b 00 00       	call   2a92 <thread_create>
    1ead:	a3 68 2f 00 00       	mov    %eax,0x2f68
	if(tid <= 0){
    1eb2:	a1 68 2f 00 00       	mov    0x2f68,%eax
    1eb7:	85 c0                	test   %eax,%eax
    1eb9:	75 11                	jne    1ecc <main+0xc9b>
		printAction("Failed to create a thread\n");
    1ebb:	c7 04 24 e3 2c 00 00 	movl   $0x2ce3,(%esp)
    1ec2:	e8 5d 03 00 00       	call   2224 <printAction>
		exit();
    1ec7:	e8 fc 05 00 00       	call   24c8 <exit>
	}
	while(wait()>= 0);
    1ecc:	e8 ff 05 00 00       	call   24d0 <wait>
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	79 f7                	jns    1ecc <main+0xc9b>
	sem_acquire(p);
    1ed5:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1eda:	89 04 24             	mov    %eax,(%esp)
    1edd:	e8 68 f2 ff ff       	call   114a <sem_acquire>
	pass = 0;
    1ee2:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    1ee9:	00 00 00 
	sem_signal(p);
    1eec:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1ef1:	89 04 24             	mov    %eax,(%esp)
    1ef4:	e8 d0 f2 ff ff       	call   11c9 <sem_signal>
	for(i = 0; i < 999999; i++);
    1ef9:	c7 05 64 2f 00 00 00 	movl   $0x0,0x2f64
    1f00:	00 00 00 
    1f03:	eb 0d                	jmp    1f12 <main+0xce1>
    1f05:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1f0a:	83 c0 01             	add    $0x1,%eax
    1f0d:	a3 64 2f 00 00       	mov    %eax,0x2f64
    1f12:	a1 64 2f 00 00       	mov    0x2f64,%eax
    1f17:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1f1c:	7e e7                	jle    1f05 <main+0xcd4>
    while(wait()>= 0);
    1f1e:	e8 ad 05 00 00       	call   24d0 <wait>
    1f23:	85 c0                	test   %eax,%eax
    1f25:	79 f7                	jns    1f1e <main+0xced>
	
	exit();
    1f27:	e8 9c 05 00 00       	call   24c8 <exit>

00001f2c <MissionaryArrives>:
	return 0;
}

// Missionary
void MissionaryArrives(){
    1f2c:	55                   	push   %ebp
    1f2d:	89 e5                	mov    %esp,%ebp
    1f2f:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(d);
    1f32:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1f37:	89 04 24             	mov    %eax,(%esp)
    1f3a:	e8 0b f2 ff ff       	call   114a <sem_acquire>
	printAction("A missionary arrived\n");
    1f3f:	c7 04 24 ea 2d 00 00 	movl   $0x2dea,(%esp)
    1f46:	e8 d9 02 00 00       	call   2224 <printAction>
	sem_signal(d);
    1f4b:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1f50:	89 04 24             	mov    %eax,(%esp)
    1f53:	e8 71 f2 ff ff       	call   11c9 <sem_signal>
	
	// If there are 2 cannibals, then wait.
	while(canni >= 2);
    1f58:	a1 54 2f 00 00       	mov    0x2f54,%eax
    1f5d:	83 f8 01             	cmp    $0x1,%eax
    1f60:	7f f6                	jg     1f58 <MissionaryArrives+0x2c>
	sem_acquire(d);
    1f62:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1f67:	89 04 24             	mov    %eax,(%esp)
    1f6a:	e8 db f1 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1f6f:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1f74:	89 04 24             	mov    %eax,(%esp)
    1f77:	e8 4d f2 ff ff       	call   11c9 <sem_signal>
	sem_acquire(boat);
    1f7c:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1f81:	89 04 24             	mov    %eax,(%esp)
    1f84:	e8 c1 f1 ff ff       	call   114a <sem_acquire>
	sem_acquire(d);
    1f89:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1f8e:	89 04 24             	mov    %eax,(%esp)
    1f91:	e8 b4 f1 ff ff       	call   114a <sem_acquire>
	sem_acquire(p);
    1f96:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1f9b:	89 04 24             	mov    %eax,(%esp)
    1f9e:	e8 a7 f1 ff ff       	call   114a <sem_acquire>
	missi++;
    1fa3:	a1 50 2f 00 00       	mov    0x2f50,%eax
    1fa8:	83 c0 01             	add    $0x1,%eax
    1fab:	a3 50 2f 00 00       	mov    %eax,0x2f50
	sem_signal(p);
    1fb0:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    1fb5:	89 04 24             	mov    %eax,(%esp)
    1fb8:	e8 0c f2 ff ff       	call   11c9 <sem_signal>
	printAction("A missionary is waiting on the boat\n");
    1fbd:	c7 04 24 00 2e 00 00 	movl   $0x2e00,(%esp)
    1fc4:	e8 5b 02 00 00       	call   2224 <printAction>
	// Missonary acquires a spot.
	sem_signal(d);
    1fc9:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1fce:	89 04 24             	mov    %eax,(%esp)
    1fd1:	e8 f3 f1 ff ff       	call   11c9 <sem_signal>
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
    1fd6:	a1 4c 2f 00 00       	mov    0x2f4c,%eax
    1fdb:	85 c0                	test   %eax,%eax
    1fdd:	75 0b                	jne    1fea <MissionaryArrives+0xbe>
    1fdf:	a1 38 2f 00 00       	mov    0x2f38,%eax
    1fe4:	8b 00                	mov    (%eax),%eax
    1fe6:	85 c0                	test   %eax,%eax
    1fe8:	75 ec                	jne    1fd6 <MissionaryArrives+0xaa>
	// Signals for an open spot, then returns.
    //sem_signal(boat);
	texit();
    1fea:	e8 81 05 00 00       	call   2570 <texit>

00001fef <CannibalArrives>:
}

// Cannibal
void CannibalArrives(){
    1fef:	55                   	push   %ebp
    1ff0:	89 e5                	mov    %esp,%ebp
    1ff2:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(d);
    1ff5:	a1 40 2f 00 00       	mov    0x2f40,%eax
    1ffa:	89 04 24             	mov    %eax,(%esp)
    1ffd:	e8 48 f1 ff ff       	call   114a <sem_acquire>
	printAction("A cannibal arrived\n");
    2002:	c7 04 24 25 2e 00 00 	movl   $0x2e25,(%esp)
    2009:	e8 16 02 00 00       	call   2224 <printAction>
	sem_signal(d);
    200e:	a1 40 2f 00 00       	mov    0x2f40,%eax
    2013:	89 04 24             	mov    %eax,(%esp)
    2016:	e8 ae f1 ff ff       	call   11c9 <sem_signal>
	
	// If there is only one missionary and only 1 spot left, then wait.
	while(missi == 1 && boat->count == 1);
    201b:	a1 50 2f 00 00       	mov    0x2f50,%eax
    2020:	83 f8 01             	cmp    $0x1,%eax
    2023:	75 0c                	jne    2031 <CannibalArrives+0x42>
    2025:	a1 38 2f 00 00       	mov    0x2f38,%eax
    202a:	8b 00                	mov    (%eax),%eax
    202c:	83 f8 01             	cmp    $0x1,%eax
    202f:	74 ea                	je     201b <CannibalArrives+0x2c>
	sem_acquire(d);
    2031:	a1 40 2f 00 00       	mov    0x2f40,%eax
    2036:	89 04 24             	mov    %eax,(%esp)
    2039:	e8 0c f1 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    203e:	a1 40 2f 00 00       	mov    0x2f40,%eax
    2043:	89 04 24             	mov    %eax,(%esp)
    2046:	e8 7e f1 ff ff       	call   11c9 <sem_signal>
	sem_acquire(boat);
    204b:	a1 38 2f 00 00       	mov    0x2f38,%eax
    2050:	89 04 24             	mov    %eax,(%esp)
    2053:	e8 f2 f0 ff ff       	call   114a <sem_acquire>
	sem_acquire(d);
    2058:	a1 40 2f 00 00       	mov    0x2f40,%eax
    205d:	89 04 24             	mov    %eax,(%esp)
    2060:	e8 e5 f0 ff ff       	call   114a <sem_acquire>
	sem_acquire(p);
    2065:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    206a:	89 04 24             	mov    %eax,(%esp)
    206d:	e8 d8 f0 ff ff       	call   114a <sem_acquire>
	canni++;
    2072:	a1 54 2f 00 00       	mov    0x2f54,%eax
    2077:	83 c0 01             	add    $0x1,%eax
    207a:	a3 54 2f 00 00       	mov    %eax,0x2f54
	sem_signal(p);
    207f:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2084:	89 04 24             	mov    %eax,(%esp)
    2087:	e8 3d f1 ff ff       	call   11c9 <sem_signal>
	printAction("A cannibal is waiting on the boat\n");
    208c:	c7 04 24 3c 2e 00 00 	movl   $0x2e3c,(%esp)
    2093:	e8 8c 01 00 00       	call   2224 <printAction>
	// Cannibal acquires a spot.
	sem_signal(d);
    2098:	a1 40 2f 00 00       	mov    0x2f40,%eax
    209d:	89 04 24             	mov    %eax,(%esp)
    20a0:	e8 24 f1 ff ff       	call   11c9 <sem_signal>
	// While it is not the time to pass yet; boat is not full.
	while(pass == 0 && boat->count != 0);
    20a5:	a1 4c 2f 00 00       	mov    0x2f4c,%eax
    20aa:	85 c0                	test   %eax,%eax
    20ac:	75 0b                	jne    20b9 <CannibalArrives+0xca>
    20ae:	a1 38 2f 00 00       	mov    0x2f38,%eax
    20b3:	8b 00                	mov    (%eax),%eax
    20b5:	85 c0                	test   %eax,%eax
    20b7:	75 ec                	jne    20a5 <CannibalArrives+0xb6>
	
	// Signals for an open spot, then returns.
	//sem_signal(boat);
	texit();
    20b9:	e8 b2 04 00 00       	call   2570 <texit>

000020be <RowBoat>:
}

// RowBoat
void RowBoat(){
    20be:	55                   	push   %ebp
    20bf:	89 e5                	mov    %esp,%ebp
    20c1:	83 ec 18             	sub    $0x18,%esp
	printAction("Preparing boat\n");
    20c4:	c7 04 24 5f 2e 00 00 	movl   $0x2e5f,(%esp)
    20cb:	e8 54 01 00 00       	call   2224 <printAction>
	sem_acquire(p);
    20d0:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    20d5:	89 04 24             	mov    %eax,(%esp)
    20d8:	e8 6d f0 ff ff       	call   114a <sem_acquire>
    pass = 0;
    20dd:	c7 05 4c 2f 00 00 00 	movl   $0x0,0x2f4c
    20e4:	00 00 00 
    sem_signal(p);
    20e7:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    20ec:	89 04 24             	mov    %eax,(%esp)
    20ef:	e8 d5 f0 ff ff       	call   11c9 <sem_signal>
    // While the boat is not full, wait.
    while(boat->count != 0);
    20f4:	a1 38 2f 00 00       	mov    0x2f38,%eax
    20f9:	8b 00                	mov    (%eax),%eax
    20fb:	85 c0                	test   %eax,%eax
    20fd:	75 f5                	jne    20f4 <RowBoat+0x36>
    sem_acquire(d);
    20ff:	a1 40 2f 00 00       	mov    0x2f40,%eax
    2104:	89 04 24             	mov    %eax,(%esp)
    2107:	e8 3e f0 ff ff       	call   114a <sem_acquire>
    printAction("Enjoy your trip, the boat is crossing!\n");
    210c:	c7 04 24 70 2e 00 00 	movl   $0x2e70,(%esp)
    2113:	e8 0c 01 00 00       	call   2224 <printAction>
    // Signals available boat spots, reset.
    while(missi > 0){
    2118:	eb 33                	jmp    214d <RowBoat+0x8f>
		printAction("Missionary crossed the river\n");
    211a:	c7 04 24 98 2e 00 00 	movl   $0x2e98,(%esp)
    2121:	e8 fe 00 00 00       	call   2224 <printAction>
		sem_acquire(p);
    2126:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    212b:	89 04 24             	mov    %eax,(%esp)
    212e:	e8 17 f0 ff ff       	call   114a <sem_acquire>
		missi--;
    2133:	a1 50 2f 00 00       	mov    0x2f50,%eax
    2138:	83 e8 01             	sub    $0x1,%eax
    213b:	a3 50 2f 00 00       	mov    %eax,0x2f50
		sem_signal(p);
    2140:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2145:	89 04 24             	mov    %eax,(%esp)
    2148:	e8 7c f0 ff ff       	call   11c9 <sem_signal>
    // While the boat is not full, wait.
    while(boat->count != 0);
    sem_acquire(d);
    printAction("Enjoy your trip, the boat is crossing!\n");
    // Signals available boat spots, reset.
    while(missi > 0){
    214d:	a1 50 2f 00 00       	mov    0x2f50,%eax
    2152:	85 c0                	test   %eax,%eax
    2154:	7f c4                	jg     211a <RowBoat+0x5c>
		printAction("Missionary crossed the river\n");
		sem_acquire(p);
		missi--;
		sem_signal(p);
    }
    while(canni > 0){
    2156:	eb 33                	jmp    218b <RowBoat+0xcd>
		printAction("Cannibal crossed the river\n");
    2158:	c7 04 24 b6 2e 00 00 	movl   $0x2eb6,(%esp)
    215f:	e8 c0 00 00 00       	call   2224 <printAction>
		sem_acquire(p);
    2164:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2169:	89 04 24             	mov    %eax,(%esp)
    216c:	e8 d9 ef ff ff       	call   114a <sem_acquire>
		canni--;
    2171:	a1 54 2f 00 00       	mov    0x2f54,%eax
    2176:	83 e8 01             	sub    $0x1,%eax
    2179:	a3 54 2f 00 00       	mov    %eax,0x2f54
		sem_signal(p);
    217e:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2183:	89 04 24             	mov    %eax,(%esp)
    2186:	e8 3e f0 ff ff       	call   11c9 <sem_signal>
		printAction("Missionary crossed the river\n");
		sem_acquire(p);
		missi--;
		sem_signal(p);
    }
    while(canni > 0){
    218b:	a1 54 2f 00 00       	mov    0x2f54,%eax
    2190:	85 c0                	test   %eax,%eax
    2192:	7f c4                	jg     2158 <RowBoat+0x9a>
		printAction("Cannibal crossed the river\n");
		sem_acquire(p);
		canni--;
		sem_signal(p);
    }
    sem_acquire(p);
    2194:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2199:	89 04 24             	mov    %eax,(%esp)
    219c:	e8 a9 ef ff ff       	call   114a <sem_acquire>
    pass = 1;
    21a1:	c7 05 4c 2f 00 00 01 	movl   $0x1,0x2f4c
    21a8:	00 00 00 
    sem_signal(p);
    21ab:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    21b0:	89 04 24             	mov    %eax,(%esp)
    21b3:	e8 11 f0 ff ff       	call   11c9 <sem_signal>
    printAction("The boat is clear!\n");
    21b8:	c7 04 24 d2 2e 00 00 	movl   $0x2ed2,(%esp)
    21bf:	e8 60 00 00 00       	call   2224 <printAction>
    sem_acquire(p);
    21c4:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    21c9:	89 04 24             	mov    %eax,(%esp)
    21cc:	e8 79 ef ff ff       	call   114a <sem_acquire>
    crossed++;
    21d1:	a1 48 2f 00 00       	mov    0x2f48,%eax
    21d6:	83 c0 01             	add    $0x1,%eax
    21d9:	a3 48 2f 00 00       	mov    %eax,0x2f48
    sem_signal(p);
    21de:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    21e3:	89 04 24             	mov    %eax,(%esp)
    21e6:	e8 de ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    21eb:	a1 38 2f 00 00       	mov    0x2f38,%eax
    21f0:	89 04 24             	mov    %eax,(%esp)
    21f3:	e8 d1 ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    21f8:	a1 38 2f 00 00       	mov    0x2f38,%eax
    21fd:	89 04 24             	mov    %eax,(%esp)
    2200:	e8 c4 ef ff ff       	call   11c9 <sem_signal>
    sem_signal(boat);
    2205:	a1 38 2f 00 00       	mov    0x2f38,%eax
    220a:	89 04 24             	mov    %eax,(%esp)
    220d:	e8 b7 ef ff ff       	call   11c9 <sem_signal>
    sem_signal(d);
    2212:	a1 40 2f 00 00       	mov    0x2f40,%eax
    2217:	89 04 24             	mov    %eax,(%esp)
    221a:	e8 aa ef ff ff       	call   11c9 <sem_signal>
    
    texit();
    221f:	e8 4c 03 00 00       	call   2570 <texit>

00002224 <printAction>:
}

// PrintAction
void printAction(char a[]){
    2224:	55                   	push   %ebp
    2225:	89 e5                	mov    %esp,%ebp
    2227:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    222a:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    222f:	89 04 24             	mov    %eax,(%esp)
    2232:	e8 13 ef ff ff       	call   114a <sem_acquire>
	printf(1, "%s", a);
    2237:	8b 45 08             	mov    0x8(%ebp),%eax
    223a:	89 44 24 08          	mov    %eax,0x8(%esp)
    223e:	c7 44 24 04 e6 2e 00 	movl   $0x2ee6,0x4(%esp)
    2245:	00 
    2246:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    224d:	e8 17 04 00 00       	call   2669 <printf>
	sem_signal(p);
    2252:	a1 3c 2f 00 00       	mov    0x2f3c,%eax
    2257:	89 04 24             	mov    %eax,(%esp)
    225a:	e8 6a ef ff ff       	call   11c9 <sem_signal>
}
    225f:	c9                   	leave  
    2260:	c3                   	ret    
    2261:	90                   	nop
    2262:	90                   	nop
    2263:	90                   	nop

00002264 <stosb>:
    2264:	55                   	push   %ebp
    2265:	89 e5                	mov    %esp,%ebp
    2267:	57                   	push   %edi
    2268:	53                   	push   %ebx
    2269:	8b 4d 08             	mov    0x8(%ebp),%ecx
    226c:	8b 55 10             	mov    0x10(%ebp),%edx
    226f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2272:	89 cb                	mov    %ecx,%ebx
    2274:	89 df                	mov    %ebx,%edi
    2276:	89 d1                	mov    %edx,%ecx
    2278:	fc                   	cld    
    2279:	f3 aa                	rep stos %al,%es:(%edi)
    227b:	89 ca                	mov    %ecx,%edx
    227d:	89 fb                	mov    %edi,%ebx
    227f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    2282:	89 55 10             	mov    %edx,0x10(%ebp)
    2285:	5b                   	pop    %ebx
    2286:	5f                   	pop    %edi
    2287:	5d                   	pop    %ebp
    2288:	c3                   	ret    

00002289 <strcpy>:
    2289:	55                   	push   %ebp
    228a:	89 e5                	mov    %esp,%ebp
    228c:	83 ec 10             	sub    $0x10,%esp
    228f:	8b 45 08             	mov    0x8(%ebp),%eax
    2292:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2295:	8b 45 0c             	mov    0xc(%ebp),%eax
    2298:	0f b6 10             	movzbl (%eax),%edx
    229b:	8b 45 08             	mov    0x8(%ebp),%eax
    229e:	88 10                	mov    %dl,(%eax)
    22a0:	8b 45 08             	mov    0x8(%ebp),%eax
    22a3:	0f b6 00             	movzbl (%eax),%eax
    22a6:	84 c0                	test   %al,%al
    22a8:	0f 95 c0             	setne  %al
    22ab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    22af:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    22b3:	84 c0                	test   %al,%al
    22b5:	75 de                	jne    2295 <strcpy+0xc>
    22b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22ba:	c9                   	leave  
    22bb:	c3                   	ret    

000022bc <strcmp>:
    22bc:	55                   	push   %ebp
    22bd:	89 e5                	mov    %esp,%ebp
    22bf:	eb 08                	jmp    22c9 <strcmp+0xd>
    22c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    22c5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    22c9:	8b 45 08             	mov    0x8(%ebp),%eax
    22cc:	0f b6 00             	movzbl (%eax),%eax
    22cf:	84 c0                	test   %al,%al
    22d1:	74 10                	je     22e3 <strcmp+0x27>
    22d3:	8b 45 08             	mov    0x8(%ebp),%eax
    22d6:	0f b6 10             	movzbl (%eax),%edx
    22d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    22dc:	0f b6 00             	movzbl (%eax),%eax
    22df:	38 c2                	cmp    %al,%dl
    22e1:	74 de                	je     22c1 <strcmp+0x5>
    22e3:	8b 45 08             	mov    0x8(%ebp),%eax
    22e6:	0f b6 00             	movzbl (%eax),%eax
    22e9:	0f b6 d0             	movzbl %al,%edx
    22ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    22ef:	0f b6 00             	movzbl (%eax),%eax
    22f2:	0f b6 c0             	movzbl %al,%eax
    22f5:	89 d1                	mov    %edx,%ecx
    22f7:	29 c1                	sub    %eax,%ecx
    22f9:	89 c8                	mov    %ecx,%eax
    22fb:	5d                   	pop    %ebp
    22fc:	c3                   	ret    

000022fd <strlen>:
    22fd:	55                   	push   %ebp
    22fe:	89 e5                	mov    %esp,%ebp
    2300:	83 ec 10             	sub    $0x10,%esp
    2303:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    230a:	eb 04                	jmp    2310 <strlen+0x13>
    230c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    2310:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2313:	03 45 08             	add    0x8(%ebp),%eax
    2316:	0f b6 00             	movzbl (%eax),%eax
    2319:	84 c0                	test   %al,%al
    231b:	75 ef                	jne    230c <strlen+0xf>
    231d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2320:	c9                   	leave  
    2321:	c3                   	ret    

00002322 <memset>:
    2322:	55                   	push   %ebp
    2323:	89 e5                	mov    %esp,%ebp
    2325:	83 ec 0c             	sub    $0xc,%esp
    2328:	8b 45 10             	mov    0x10(%ebp),%eax
    232b:	89 44 24 08          	mov    %eax,0x8(%esp)
    232f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2332:	89 44 24 04          	mov    %eax,0x4(%esp)
    2336:	8b 45 08             	mov    0x8(%ebp),%eax
    2339:	89 04 24             	mov    %eax,(%esp)
    233c:	e8 23 ff ff ff       	call   2264 <stosb>
    2341:	8b 45 08             	mov    0x8(%ebp),%eax
    2344:	c9                   	leave  
    2345:	c3                   	ret    

00002346 <strchr>:
    2346:	55                   	push   %ebp
    2347:	89 e5                	mov    %esp,%ebp
    2349:	83 ec 04             	sub    $0x4,%esp
    234c:	8b 45 0c             	mov    0xc(%ebp),%eax
    234f:	88 45 fc             	mov    %al,-0x4(%ebp)
    2352:	eb 14                	jmp    2368 <strchr+0x22>
    2354:	8b 45 08             	mov    0x8(%ebp),%eax
    2357:	0f b6 00             	movzbl (%eax),%eax
    235a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    235d:	75 05                	jne    2364 <strchr+0x1e>
    235f:	8b 45 08             	mov    0x8(%ebp),%eax
    2362:	eb 13                	jmp    2377 <strchr+0x31>
    2364:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    2368:	8b 45 08             	mov    0x8(%ebp),%eax
    236b:	0f b6 00             	movzbl (%eax),%eax
    236e:	84 c0                	test   %al,%al
    2370:	75 e2                	jne    2354 <strchr+0xe>
    2372:	b8 00 00 00 00       	mov    $0x0,%eax
    2377:	c9                   	leave  
    2378:	c3                   	ret    

00002379 <gets>:
    2379:	55                   	push   %ebp
    237a:	89 e5                	mov    %esp,%ebp
    237c:	83 ec 28             	sub    $0x28,%esp
    237f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2386:	eb 44                	jmp    23cc <gets+0x53>
    2388:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    238f:	00 
    2390:	8d 45 ef             	lea    -0x11(%ebp),%eax
    2393:	89 44 24 04          	mov    %eax,0x4(%esp)
    2397:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    239e:	e8 3d 01 00 00       	call   24e0 <read>
    23a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    23a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23aa:	7e 2d                	jle    23d9 <gets+0x60>
    23ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23af:	03 45 08             	add    0x8(%ebp),%eax
    23b2:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    23b6:	88 10                	mov    %dl,(%eax)
    23b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    23bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    23c0:	3c 0a                	cmp    $0xa,%al
    23c2:	74 16                	je     23da <gets+0x61>
    23c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    23c8:	3c 0d                	cmp    $0xd,%al
    23ca:	74 0e                	je     23da <gets+0x61>
    23cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23cf:	83 c0 01             	add    $0x1,%eax
    23d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    23d5:	7c b1                	jl     2388 <gets+0xf>
    23d7:	eb 01                	jmp    23da <gets+0x61>
    23d9:	90                   	nop
    23da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23dd:	03 45 08             	add    0x8(%ebp),%eax
    23e0:	c6 00 00             	movb   $0x0,(%eax)
    23e3:	8b 45 08             	mov    0x8(%ebp),%eax
    23e6:	c9                   	leave  
    23e7:	c3                   	ret    

000023e8 <stat>:
    23e8:	55                   	push   %ebp
    23e9:	89 e5                	mov    %esp,%ebp
    23eb:	83 ec 28             	sub    $0x28,%esp
    23ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23f5:	00 
    23f6:	8b 45 08             	mov    0x8(%ebp),%eax
    23f9:	89 04 24             	mov    %eax,(%esp)
    23fc:	e8 07 01 00 00       	call   2508 <open>
    2401:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2404:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2408:	79 07                	jns    2411 <stat+0x29>
    240a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    240f:	eb 23                	jmp    2434 <stat+0x4c>
    2411:	8b 45 0c             	mov    0xc(%ebp),%eax
    2414:	89 44 24 04          	mov    %eax,0x4(%esp)
    2418:	8b 45 f0             	mov    -0x10(%ebp),%eax
    241b:	89 04 24             	mov    %eax,(%esp)
    241e:	e8 fd 00 00 00       	call   2520 <fstat>
    2423:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2426:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2429:	89 04 24             	mov    %eax,(%esp)
    242c:	e8 bf 00 00 00       	call   24f0 <close>
    2431:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2434:	c9                   	leave  
    2435:	c3                   	ret    

00002436 <atoi>:
    2436:	55                   	push   %ebp
    2437:	89 e5                	mov    %esp,%ebp
    2439:	83 ec 10             	sub    $0x10,%esp
    243c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    2443:	eb 24                	jmp    2469 <atoi+0x33>
    2445:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2448:	89 d0                	mov    %edx,%eax
    244a:	c1 e0 02             	shl    $0x2,%eax
    244d:	01 d0                	add    %edx,%eax
    244f:	01 c0                	add    %eax,%eax
    2451:	89 c2                	mov    %eax,%edx
    2453:	8b 45 08             	mov    0x8(%ebp),%eax
    2456:	0f b6 00             	movzbl (%eax),%eax
    2459:	0f be c0             	movsbl %al,%eax
    245c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    245f:	83 e8 30             	sub    $0x30,%eax
    2462:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2465:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    2469:	8b 45 08             	mov    0x8(%ebp),%eax
    246c:	0f b6 00             	movzbl (%eax),%eax
    246f:	3c 2f                	cmp    $0x2f,%al
    2471:	7e 0a                	jle    247d <atoi+0x47>
    2473:	8b 45 08             	mov    0x8(%ebp),%eax
    2476:	0f b6 00             	movzbl (%eax),%eax
    2479:	3c 39                	cmp    $0x39,%al
    247b:	7e c8                	jle    2445 <atoi+0xf>
    247d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2480:	c9                   	leave  
    2481:	c3                   	ret    

00002482 <memmove>:
    2482:	55                   	push   %ebp
    2483:	89 e5                	mov    %esp,%ebp
    2485:	83 ec 10             	sub    $0x10,%esp
    2488:	8b 45 08             	mov    0x8(%ebp),%eax
    248b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    248e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2491:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2494:	eb 13                	jmp    24a9 <memmove+0x27>
    2496:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2499:	0f b6 10             	movzbl (%eax),%edx
    249c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    249f:	88 10                	mov    %dl,(%eax)
    24a1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    24a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    24a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    24ad:	0f 9f c0             	setg   %al
    24b0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    24b4:	84 c0                	test   %al,%al
    24b6:	75 de                	jne    2496 <memmove+0x14>
    24b8:	8b 45 08             	mov    0x8(%ebp),%eax
    24bb:	c9                   	leave  
    24bc:	c3                   	ret    
    24bd:	90                   	nop
    24be:	90                   	nop
    24bf:	90                   	nop

000024c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    24c0:	b8 01 00 00 00       	mov    $0x1,%eax
    24c5:	cd 40                	int    $0x40
    24c7:	c3                   	ret    

000024c8 <exit>:
SYSCALL(exit)
    24c8:	b8 02 00 00 00       	mov    $0x2,%eax
    24cd:	cd 40                	int    $0x40
    24cf:	c3                   	ret    

000024d0 <wait>:
SYSCALL(wait)
    24d0:	b8 03 00 00 00       	mov    $0x3,%eax
    24d5:	cd 40                	int    $0x40
    24d7:	c3                   	ret    

000024d8 <pipe>:
SYSCALL(pipe)
    24d8:	b8 04 00 00 00       	mov    $0x4,%eax
    24dd:	cd 40                	int    $0x40
    24df:	c3                   	ret    

000024e0 <read>:
SYSCALL(read)
    24e0:	b8 05 00 00 00       	mov    $0x5,%eax
    24e5:	cd 40                	int    $0x40
    24e7:	c3                   	ret    

000024e8 <write>:
SYSCALL(write)
    24e8:	b8 10 00 00 00       	mov    $0x10,%eax
    24ed:	cd 40                	int    $0x40
    24ef:	c3                   	ret    

000024f0 <close>:
SYSCALL(close)
    24f0:	b8 15 00 00 00       	mov    $0x15,%eax
    24f5:	cd 40                	int    $0x40
    24f7:	c3                   	ret    

000024f8 <kill>:
SYSCALL(kill)
    24f8:	b8 06 00 00 00       	mov    $0x6,%eax
    24fd:	cd 40                	int    $0x40
    24ff:	c3                   	ret    

00002500 <exec>:
SYSCALL(exec)
    2500:	b8 07 00 00 00       	mov    $0x7,%eax
    2505:	cd 40                	int    $0x40
    2507:	c3                   	ret    

00002508 <open>:
SYSCALL(open)
    2508:	b8 0f 00 00 00       	mov    $0xf,%eax
    250d:	cd 40                	int    $0x40
    250f:	c3                   	ret    

00002510 <mknod>:
SYSCALL(mknod)
    2510:	b8 11 00 00 00       	mov    $0x11,%eax
    2515:	cd 40                	int    $0x40
    2517:	c3                   	ret    

00002518 <unlink>:
SYSCALL(unlink)
    2518:	b8 12 00 00 00       	mov    $0x12,%eax
    251d:	cd 40                	int    $0x40
    251f:	c3                   	ret    

00002520 <fstat>:
SYSCALL(fstat)
    2520:	b8 08 00 00 00       	mov    $0x8,%eax
    2525:	cd 40                	int    $0x40
    2527:	c3                   	ret    

00002528 <link>:
SYSCALL(link)
    2528:	b8 13 00 00 00       	mov    $0x13,%eax
    252d:	cd 40                	int    $0x40
    252f:	c3                   	ret    

00002530 <mkdir>:
SYSCALL(mkdir)
    2530:	b8 14 00 00 00       	mov    $0x14,%eax
    2535:	cd 40                	int    $0x40
    2537:	c3                   	ret    

00002538 <chdir>:
SYSCALL(chdir)
    2538:	b8 09 00 00 00       	mov    $0x9,%eax
    253d:	cd 40                	int    $0x40
    253f:	c3                   	ret    

00002540 <dup>:
SYSCALL(dup)
    2540:	b8 0a 00 00 00       	mov    $0xa,%eax
    2545:	cd 40                	int    $0x40
    2547:	c3                   	ret    

00002548 <getpid>:
SYSCALL(getpid)
    2548:	b8 0b 00 00 00       	mov    $0xb,%eax
    254d:	cd 40                	int    $0x40
    254f:	c3                   	ret    

00002550 <sbrk>:
SYSCALL(sbrk)
    2550:	b8 0c 00 00 00       	mov    $0xc,%eax
    2555:	cd 40                	int    $0x40
    2557:	c3                   	ret    

00002558 <sleep>:
SYSCALL(sleep)
    2558:	b8 0d 00 00 00       	mov    $0xd,%eax
    255d:	cd 40                	int    $0x40
    255f:	c3                   	ret    

00002560 <uptime>:
SYSCALL(uptime)
    2560:	b8 0e 00 00 00       	mov    $0xe,%eax
    2565:	cd 40                	int    $0x40
    2567:	c3                   	ret    

00002568 <clone>:
SYSCALL(clone)
    2568:	b8 16 00 00 00       	mov    $0x16,%eax
    256d:	cd 40                	int    $0x40
    256f:	c3                   	ret    

00002570 <texit>:
SYSCALL(texit)
    2570:	b8 17 00 00 00       	mov    $0x17,%eax
    2575:	cd 40                	int    $0x40
    2577:	c3                   	ret    

00002578 <tsleep>:
SYSCALL(tsleep)
    2578:	b8 18 00 00 00       	mov    $0x18,%eax
    257d:	cd 40                	int    $0x40
    257f:	c3                   	ret    

00002580 <twakeup>:
SYSCALL(twakeup)
    2580:	b8 19 00 00 00       	mov    $0x19,%eax
    2585:	cd 40                	int    $0x40
    2587:	c3                   	ret    

00002588 <thread_yield>:
SYSCALL(thread_yield)
    2588:	b8 1a 00 00 00       	mov    $0x1a,%eax
    258d:	cd 40                	int    $0x40
    258f:	c3                   	ret    

00002590 <putc>:
    2590:	55                   	push   %ebp
    2591:	89 e5                	mov    %esp,%ebp
    2593:	83 ec 28             	sub    $0x28,%esp
    2596:	8b 45 0c             	mov    0xc(%ebp),%eax
    2599:	88 45 f4             	mov    %al,-0xc(%ebp)
    259c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    25a3:	00 
    25a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    25a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    25ab:	8b 45 08             	mov    0x8(%ebp),%eax
    25ae:	89 04 24             	mov    %eax,(%esp)
    25b1:	e8 32 ff ff ff       	call   24e8 <write>
    25b6:	c9                   	leave  
    25b7:	c3                   	ret    

000025b8 <printint>:
    25b8:	55                   	push   %ebp
    25b9:	89 e5                	mov    %esp,%ebp
    25bb:	53                   	push   %ebx
    25bc:	83 ec 44             	sub    $0x44,%esp
    25bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    25c6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    25ca:	74 17                	je     25e3 <printint+0x2b>
    25cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    25d0:	79 11                	jns    25e3 <printint+0x2b>
    25d2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    25d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    25dc:	f7 d8                	neg    %eax
    25de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    25e1:	eb 06                	jmp    25e9 <printint+0x31>
    25e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    25e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    25e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    25f0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    25f3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    25f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25f9:	ba 00 00 00 00       	mov    $0x0,%edx
    25fe:	f7 f3                	div    %ebx
    2600:	89 d0                	mov    %edx,%eax
    2602:	0f b6 80 20 2f 00 00 	movzbl 0x2f20(%eax),%eax
    2609:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    260d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2611:	8b 45 10             	mov    0x10(%ebp),%eax
    2614:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    2617:	8b 45 f4             	mov    -0xc(%ebp),%eax
    261a:	ba 00 00 00 00       	mov    $0x0,%edx
    261f:	f7 75 d4             	divl   -0x2c(%ebp)
    2622:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2625:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2629:	75 c5                	jne    25f0 <printint+0x38>
    262b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    262f:	74 28                	je     2659 <printint+0xa1>
    2631:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2634:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    2639:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    263d:	eb 1a                	jmp    2659 <printint+0xa1>
    263f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2642:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    2647:	0f be c0             	movsbl %al,%eax
    264a:	89 44 24 04          	mov    %eax,0x4(%esp)
    264e:	8b 45 08             	mov    0x8(%ebp),%eax
    2651:	89 04 24             	mov    %eax,(%esp)
    2654:	e8 37 ff ff ff       	call   2590 <putc>
    2659:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    265d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2661:	79 dc                	jns    263f <printint+0x87>
    2663:	83 c4 44             	add    $0x44,%esp
    2666:	5b                   	pop    %ebx
    2667:	5d                   	pop    %ebp
    2668:	c3                   	ret    

00002669 <printf>:
    2669:	55                   	push   %ebp
    266a:	89 e5                	mov    %esp,%ebp
    266c:	83 ec 38             	sub    $0x38,%esp
    266f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2676:	8d 45 0c             	lea    0xc(%ebp),%eax
    2679:	83 c0 04             	add    $0x4,%eax
    267c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    267f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2686:	e9 7e 01 00 00       	jmp    2809 <printf+0x1a0>
    268b:	8b 55 0c             	mov    0xc(%ebp),%edx
    268e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2691:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2694:	0f b6 00             	movzbl (%eax),%eax
    2697:	0f be c0             	movsbl %al,%eax
    269a:	25 ff 00 00 00       	and    $0xff,%eax
    269f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    26a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    26a6:	75 2c                	jne    26d4 <printf+0x6b>
    26a8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    26ac:	75 0c                	jne    26ba <printf+0x51>
    26ae:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    26b5:	e9 4b 01 00 00       	jmp    2805 <printf+0x19c>
    26ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26bd:	0f be c0             	movsbl %al,%eax
    26c0:	89 44 24 04          	mov    %eax,0x4(%esp)
    26c4:	8b 45 08             	mov    0x8(%ebp),%eax
    26c7:	89 04 24             	mov    %eax,(%esp)
    26ca:	e8 c1 fe ff ff       	call   2590 <putc>
    26cf:	e9 31 01 00 00       	jmp    2805 <printf+0x19c>
    26d4:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    26d8:	0f 85 27 01 00 00    	jne    2805 <printf+0x19c>
    26de:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    26e2:	75 2d                	jne    2711 <printf+0xa8>
    26e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26e7:	8b 00                	mov    (%eax),%eax
    26e9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    26f0:	00 
    26f1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    26f8:	00 
    26f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    26fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2700:	89 04 24             	mov    %eax,(%esp)
    2703:	e8 b0 fe ff ff       	call   25b8 <printint>
    2708:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    270c:	e9 ed 00 00 00       	jmp    27fe <printf+0x195>
    2711:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    2715:	74 06                	je     271d <printf+0xb4>
    2717:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    271b:	75 2d                	jne    274a <printf+0xe1>
    271d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2720:	8b 00                	mov    (%eax),%eax
    2722:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2729:	00 
    272a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    2731:	00 
    2732:	89 44 24 04          	mov    %eax,0x4(%esp)
    2736:	8b 45 08             	mov    0x8(%ebp),%eax
    2739:	89 04 24             	mov    %eax,(%esp)
    273c:	e8 77 fe ff ff       	call   25b8 <printint>
    2741:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    2745:	e9 b4 00 00 00       	jmp    27fe <printf+0x195>
    274a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    274e:	75 46                	jne    2796 <printf+0x12d>
    2750:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2753:	8b 00                	mov    (%eax),%eax
    2755:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2758:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    275c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2760:	75 27                	jne    2789 <printf+0x120>
    2762:	c7 45 e4 e9 2e 00 00 	movl   $0x2ee9,-0x1c(%ebp)
    2769:	eb 1f                	jmp    278a <printf+0x121>
    276b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    276e:	0f b6 00             	movzbl (%eax),%eax
    2771:	0f be c0             	movsbl %al,%eax
    2774:	89 44 24 04          	mov    %eax,0x4(%esp)
    2778:	8b 45 08             	mov    0x8(%ebp),%eax
    277b:	89 04 24             	mov    %eax,(%esp)
    277e:	e8 0d fe ff ff       	call   2590 <putc>
    2783:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2787:	eb 01                	jmp    278a <printf+0x121>
    2789:	90                   	nop
    278a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    278d:	0f b6 00             	movzbl (%eax),%eax
    2790:	84 c0                	test   %al,%al
    2792:	75 d7                	jne    276b <printf+0x102>
    2794:	eb 68                	jmp    27fe <printf+0x195>
    2796:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    279a:	75 1d                	jne    27b9 <printf+0x150>
    279c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    279f:	8b 00                	mov    (%eax),%eax
    27a1:	0f be c0             	movsbl %al,%eax
    27a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    27a8:	8b 45 08             	mov    0x8(%ebp),%eax
    27ab:	89 04 24             	mov    %eax,(%esp)
    27ae:	e8 dd fd ff ff       	call   2590 <putc>
    27b3:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    27b7:	eb 45                	jmp    27fe <printf+0x195>
    27b9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    27bd:	75 17                	jne    27d6 <printf+0x16d>
    27bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    27c2:	0f be c0             	movsbl %al,%eax
    27c5:	89 44 24 04          	mov    %eax,0x4(%esp)
    27c9:	8b 45 08             	mov    0x8(%ebp),%eax
    27cc:	89 04 24             	mov    %eax,(%esp)
    27cf:	e8 bc fd ff ff       	call   2590 <putc>
    27d4:	eb 28                	jmp    27fe <printf+0x195>
    27d6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    27dd:	00 
    27de:	8b 45 08             	mov    0x8(%ebp),%eax
    27e1:	89 04 24             	mov    %eax,(%esp)
    27e4:	e8 a7 fd ff ff       	call   2590 <putc>
    27e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    27ec:	0f be c0             	movsbl %al,%eax
    27ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    27f3:	8b 45 08             	mov    0x8(%ebp),%eax
    27f6:	89 04 24             	mov    %eax,(%esp)
    27f9:	e8 92 fd ff ff       	call   2590 <putc>
    27fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2805:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2809:	8b 55 0c             	mov    0xc(%ebp),%edx
    280c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    280f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2812:	0f b6 00             	movzbl (%eax),%eax
    2815:	84 c0                	test   %al,%al
    2817:	0f 85 6e fe ff ff    	jne    268b <printf+0x22>
    281d:	c9                   	leave  
    281e:	c3                   	ret    
    281f:	90                   	nop

00002820 <free>:
    2820:	55                   	push   %ebp
    2821:	89 e5                	mov    %esp,%ebp
    2823:	83 ec 10             	sub    $0x10,%esp
    2826:	8b 45 08             	mov    0x8(%ebp),%eax
    2829:	83 e8 08             	sub    $0x8,%eax
    282c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    282f:	a1 60 2f 00 00       	mov    0x2f60,%eax
    2834:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2837:	eb 24                	jmp    285d <free+0x3d>
    2839:	8b 45 fc             	mov    -0x4(%ebp),%eax
    283c:	8b 00                	mov    (%eax),%eax
    283e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2841:	77 12                	ja     2855 <free+0x35>
    2843:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2846:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2849:	77 24                	ja     286f <free+0x4f>
    284b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    284e:	8b 00                	mov    (%eax),%eax
    2850:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2853:	77 1a                	ja     286f <free+0x4f>
    2855:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2858:	8b 00                	mov    (%eax),%eax
    285a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    285d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2860:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2863:	76 d4                	jbe    2839 <free+0x19>
    2865:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2868:	8b 00                	mov    (%eax),%eax
    286a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    286d:	76 ca                	jbe    2839 <free+0x19>
    286f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2872:	8b 40 04             	mov    0x4(%eax),%eax
    2875:	c1 e0 03             	shl    $0x3,%eax
    2878:	89 c2                	mov    %eax,%edx
    287a:	03 55 f8             	add    -0x8(%ebp),%edx
    287d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2880:	8b 00                	mov    (%eax),%eax
    2882:	39 c2                	cmp    %eax,%edx
    2884:	75 24                	jne    28aa <free+0x8a>
    2886:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2889:	8b 50 04             	mov    0x4(%eax),%edx
    288c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    288f:	8b 00                	mov    (%eax),%eax
    2891:	8b 40 04             	mov    0x4(%eax),%eax
    2894:	01 c2                	add    %eax,%edx
    2896:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2899:	89 50 04             	mov    %edx,0x4(%eax)
    289c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    289f:	8b 00                	mov    (%eax),%eax
    28a1:	8b 10                	mov    (%eax),%edx
    28a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28a6:	89 10                	mov    %edx,(%eax)
    28a8:	eb 0a                	jmp    28b4 <free+0x94>
    28aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28ad:	8b 10                	mov    (%eax),%edx
    28af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28b2:	89 10                	mov    %edx,(%eax)
    28b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28b7:	8b 40 04             	mov    0x4(%eax),%eax
    28ba:	c1 e0 03             	shl    $0x3,%eax
    28bd:	03 45 fc             	add    -0x4(%ebp),%eax
    28c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    28c3:	75 20                	jne    28e5 <free+0xc5>
    28c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28c8:	8b 50 04             	mov    0x4(%eax),%edx
    28cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28ce:	8b 40 04             	mov    0x4(%eax),%eax
    28d1:	01 c2                	add    %eax,%edx
    28d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28d6:	89 50 04             	mov    %edx,0x4(%eax)
    28d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    28dc:	8b 10                	mov    (%eax),%edx
    28de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28e1:	89 10                	mov    %edx,(%eax)
    28e3:	eb 08                	jmp    28ed <free+0xcd>
    28e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    28eb:	89 10                	mov    %edx,(%eax)
    28ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    28f0:	a3 60 2f 00 00       	mov    %eax,0x2f60
    28f5:	c9                   	leave  
    28f6:	c3                   	ret    

000028f7 <morecore>:
    28f7:	55                   	push   %ebp
    28f8:	89 e5                	mov    %esp,%ebp
    28fa:	83 ec 28             	sub    $0x28,%esp
    28fd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2904:	77 07                	ja     290d <morecore+0x16>
    2906:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    290d:	8b 45 08             	mov    0x8(%ebp),%eax
    2910:	c1 e0 03             	shl    $0x3,%eax
    2913:	89 04 24             	mov    %eax,(%esp)
    2916:	e8 35 fc ff ff       	call   2550 <sbrk>
    291b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    291e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    2922:	75 07                	jne    292b <morecore+0x34>
    2924:	b8 00 00 00 00       	mov    $0x0,%eax
    2929:	eb 22                	jmp    294d <morecore+0x56>
    292b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    292e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2931:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2934:	8b 55 08             	mov    0x8(%ebp),%edx
    2937:	89 50 04             	mov    %edx,0x4(%eax)
    293a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    293d:	83 c0 08             	add    $0x8,%eax
    2940:	89 04 24             	mov    %eax,(%esp)
    2943:	e8 d8 fe ff ff       	call   2820 <free>
    2948:	a1 60 2f 00 00       	mov    0x2f60,%eax
    294d:	c9                   	leave  
    294e:	c3                   	ret    

0000294f <malloc>:
    294f:	55                   	push   %ebp
    2950:	89 e5                	mov    %esp,%ebp
    2952:	83 ec 28             	sub    $0x28,%esp
    2955:	8b 45 08             	mov    0x8(%ebp),%eax
    2958:	83 c0 07             	add    $0x7,%eax
    295b:	c1 e8 03             	shr    $0x3,%eax
    295e:	83 c0 01             	add    $0x1,%eax
    2961:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2964:	a1 60 2f 00 00       	mov    0x2f60,%eax
    2969:	89 45 f0             	mov    %eax,-0x10(%ebp)
    296c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2970:	75 23                	jne    2995 <malloc+0x46>
    2972:	c7 45 f0 58 2f 00 00 	movl   $0x2f58,-0x10(%ebp)
    2979:	8b 45 f0             	mov    -0x10(%ebp),%eax
    297c:	a3 60 2f 00 00       	mov    %eax,0x2f60
    2981:	a1 60 2f 00 00       	mov    0x2f60,%eax
    2986:	a3 58 2f 00 00       	mov    %eax,0x2f58
    298b:	c7 05 5c 2f 00 00 00 	movl   $0x0,0x2f5c
    2992:	00 00 00 
    2995:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2998:	8b 00                	mov    (%eax),%eax
    299a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    299d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29a0:	8b 40 04             	mov    0x4(%eax),%eax
    29a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    29a6:	72 4d                	jb     29f5 <malloc+0xa6>
    29a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29ab:	8b 40 04             	mov    0x4(%eax),%eax
    29ae:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    29b1:	75 0c                	jne    29bf <malloc+0x70>
    29b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29b6:	8b 10                	mov    (%eax),%edx
    29b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29bb:	89 10                	mov    %edx,(%eax)
    29bd:	eb 26                	jmp    29e5 <malloc+0x96>
    29bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29c2:	8b 40 04             	mov    0x4(%eax),%eax
    29c5:	89 c2                	mov    %eax,%edx
    29c7:	2b 55 f4             	sub    -0xc(%ebp),%edx
    29ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29cd:	89 50 04             	mov    %edx,0x4(%eax)
    29d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29d3:	8b 40 04             	mov    0x4(%eax),%eax
    29d6:	c1 e0 03             	shl    $0x3,%eax
    29d9:	01 45 ec             	add    %eax,-0x14(%ebp)
    29dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29df:	8b 55 f4             	mov    -0xc(%ebp),%edx
    29e2:	89 50 04             	mov    %edx,0x4(%eax)
    29e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29e8:	a3 60 2f 00 00       	mov    %eax,0x2f60
    29ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29f0:	83 c0 08             	add    $0x8,%eax
    29f3:	eb 38                	jmp    2a2d <malloc+0xde>
    29f5:	a1 60 2f 00 00       	mov    0x2f60,%eax
    29fa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    29fd:	75 1b                	jne    2a1a <malloc+0xcb>
    29ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a02:	89 04 24             	mov    %eax,(%esp)
    2a05:	e8 ed fe ff ff       	call   28f7 <morecore>
    2a0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2a0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2a11:	75 07                	jne    2a1a <malloc+0xcb>
    2a13:	b8 00 00 00 00       	mov    $0x0,%eax
    2a18:	eb 13                	jmp    2a2d <malloc+0xde>
    2a1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2a1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2a20:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2a23:	8b 00                	mov    (%eax),%eax
    2a25:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2a28:	e9 70 ff ff ff       	jmp    299d <malloc+0x4e>
    2a2d:	c9                   	leave  
    2a2e:	c3                   	ret    
    2a2f:	90                   	nop

00002a30 <xchg>:
    2a30:	55                   	push   %ebp
    2a31:	89 e5                	mov    %esp,%ebp
    2a33:	83 ec 10             	sub    $0x10,%esp
    2a36:	8b 55 08             	mov    0x8(%ebp),%edx
    2a39:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a3c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2a3f:	f0 87 02             	lock xchg %eax,(%edx)
    2a42:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2a45:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2a48:	c9                   	leave  
    2a49:	c3                   	ret    

00002a4a <lock_init>:
    2a4a:	55                   	push   %ebp
    2a4b:	89 e5                	mov    %esp,%ebp
    2a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    2a56:	5d                   	pop    %ebp
    2a57:	c3                   	ret    

00002a58 <lock_acquire>:
    2a58:	55                   	push   %ebp
    2a59:	89 e5                	mov    %esp,%ebp
    2a5b:	83 ec 08             	sub    $0x8,%esp
    2a5e:	8b 45 08             	mov    0x8(%ebp),%eax
    2a61:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2a68:	00 
    2a69:	89 04 24             	mov    %eax,(%esp)
    2a6c:	e8 bf ff ff ff       	call   2a30 <xchg>
    2a71:	85 c0                	test   %eax,%eax
    2a73:	75 e9                	jne    2a5e <lock_acquire+0x6>
    2a75:	c9                   	leave  
    2a76:	c3                   	ret    

00002a77 <lock_release>:
    2a77:	55                   	push   %ebp
    2a78:	89 e5                	mov    %esp,%ebp
    2a7a:	83 ec 08             	sub    $0x8,%esp
    2a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a80:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a87:	00 
    2a88:	89 04 24             	mov    %eax,(%esp)
    2a8b:	e8 a0 ff ff ff       	call   2a30 <xchg>
    2a90:	c9                   	leave  
    2a91:	c3                   	ret    

00002a92 <thread_create>:
    2a92:	55                   	push   %ebp
    2a93:	89 e5                	mov    %esp,%ebp
    2a95:	83 ec 28             	sub    $0x28,%esp
    2a98:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2a9f:	e8 ab fe ff ff       	call   294f <malloc>
    2aa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2aa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2aaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ab0:	25 ff 0f 00 00       	and    $0xfff,%eax
    2ab5:	85 c0                	test   %eax,%eax
    2ab7:	74 15                	je     2ace <thread_create+0x3c>
    2ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2abc:	89 c2                	mov    %eax,%edx
    2abe:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    2ac4:	b8 00 10 00 00       	mov    $0x1000,%eax
    2ac9:	29 d0                	sub    %edx,%eax
    2acb:	01 45 f0             	add    %eax,-0x10(%ebp)
    2ace:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2ad2:	75 1b                	jne    2aef <thread_create+0x5d>
    2ad4:	c7 44 24 04 f0 2e 00 	movl   $0x2ef0,0x4(%esp)
    2adb:	00 
    2adc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ae3:	e8 81 fb ff ff       	call   2669 <printf>
    2ae8:	b8 00 00 00 00       	mov    $0x0,%eax
    2aed:	eb 6f                	jmp    2b5e <thread_create+0xcc>
    2aef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2af2:	8b 55 08             	mov    0x8(%ebp),%edx
    2af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2af8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    2afc:	89 54 24 08          	mov    %edx,0x8(%esp)
    2b00:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    2b07:	00 
    2b08:	89 04 24             	mov    %eax,(%esp)
    2b0b:	e8 58 fa ff ff       	call   2568 <clone>
    2b10:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2b13:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b17:	79 1b                	jns    2b34 <thread_create+0xa2>
    2b19:	c7 44 24 04 fe 2e 00 	movl   $0x2efe,0x4(%esp)
    2b20:	00 
    2b21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b28:	e8 3c fb ff ff       	call   2669 <printf>
    2b2d:	b8 00 00 00 00       	mov    $0x0,%eax
    2b32:	eb 2a                	jmp    2b5e <thread_create+0xcc>
    2b34:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b38:	7e 05                	jle    2b3f <thread_create+0xad>
    2b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b3d:	eb 1f                	jmp    2b5e <thread_create+0xcc>
    2b3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b43:	75 14                	jne    2b59 <thread_create+0xc7>
    2b45:	c7 44 24 04 0b 2f 00 	movl   $0x2f0b,0x4(%esp)
    2b4c:	00 
    2b4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b54:	e8 10 fb ff ff       	call   2669 <printf>
    2b59:	b8 00 00 00 00       	mov    $0x0,%eax
    2b5e:	c9                   	leave  
    2b5f:	c3                   	ret    

00002b60 <random>:
    2b60:	55                   	push   %ebp
    2b61:	89 e5                	mov    %esp,%ebp
    2b63:	a1 34 2f 00 00       	mov    0x2f34,%eax
    2b68:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    2b6e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    2b73:	a3 34 2f 00 00       	mov    %eax,0x2f34
    2b78:	a1 34 2f 00 00       	mov    0x2f34,%eax
    2b7d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2b80:	ba 00 00 00 00       	mov    $0x0,%edx
    2b85:	f7 f1                	div    %ecx
    2b87:	89 d0                	mov    %edx,%eax
    2b89:	5d                   	pop    %ebp
    2b8a:	c3                   	ret    
    2b8b:	90                   	nop

00002b8c <init_q>:
    2b8c:	55                   	push   %ebp
    2b8d:	89 e5                	mov    %esp,%ebp
    2b8f:	8b 45 08             	mov    0x8(%ebp),%eax
    2b92:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    2b98:	8b 45 08             	mov    0x8(%ebp),%eax
    2b9b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    2ba2:	8b 45 08             	mov    0x8(%ebp),%eax
    2ba5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    2bac:	5d                   	pop    %ebp
    2bad:	c3                   	ret    

00002bae <add_q>:
    2bae:	55                   	push   %ebp
    2baf:	89 e5                	mov    %esp,%ebp
    2bb1:	83 ec 28             	sub    $0x28,%esp
    2bb4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2bbb:	e8 8f fd ff ff       	call   294f <malloc>
    2bc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bc6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    2bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bd0:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bd3:	89 10                	mov    %edx,(%eax)
    2bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    2bd8:	8b 40 04             	mov    0x4(%eax),%eax
    2bdb:	85 c0                	test   %eax,%eax
    2bdd:	75 0b                	jne    2bea <add_q+0x3c>
    2bdf:	8b 45 08             	mov    0x8(%ebp),%eax
    2be2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2be5:	89 50 04             	mov    %edx,0x4(%eax)
    2be8:	eb 0c                	jmp    2bf6 <add_q+0x48>
    2bea:	8b 45 08             	mov    0x8(%ebp),%eax
    2bed:	8b 40 08             	mov    0x8(%eax),%eax
    2bf0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2bf3:	89 50 04             	mov    %edx,0x4(%eax)
    2bf6:	8b 45 08             	mov    0x8(%ebp),%eax
    2bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2bfc:	89 50 08             	mov    %edx,0x8(%eax)
    2bff:	8b 45 08             	mov    0x8(%ebp),%eax
    2c02:	8b 00                	mov    (%eax),%eax
    2c04:	8d 50 01             	lea    0x1(%eax),%edx
    2c07:	8b 45 08             	mov    0x8(%ebp),%eax
    2c0a:	89 10                	mov    %edx,(%eax)
    2c0c:	c9                   	leave  
    2c0d:	c3                   	ret    

00002c0e <empty_q>:
    2c0e:	55                   	push   %ebp
    2c0f:	89 e5                	mov    %esp,%ebp
    2c11:	8b 45 08             	mov    0x8(%ebp),%eax
    2c14:	8b 00                	mov    (%eax),%eax
    2c16:	85 c0                	test   %eax,%eax
    2c18:	75 07                	jne    2c21 <empty_q+0x13>
    2c1a:	b8 01 00 00 00       	mov    $0x1,%eax
    2c1f:	eb 05                	jmp    2c26 <empty_q+0x18>
    2c21:	b8 00 00 00 00       	mov    $0x0,%eax
    2c26:	5d                   	pop    %ebp
    2c27:	c3                   	ret    

00002c28 <pop_q>:
    2c28:	55                   	push   %ebp
    2c29:	89 e5                	mov    %esp,%ebp
    2c2b:	83 ec 28             	sub    $0x28,%esp
    2c2e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c31:	89 04 24             	mov    %eax,(%esp)
    2c34:	e8 d5 ff ff ff       	call   2c0e <empty_q>
    2c39:	85 c0                	test   %eax,%eax
    2c3b:	75 5d                	jne    2c9a <pop_q+0x72>
    2c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    2c40:	8b 40 04             	mov    0x4(%eax),%eax
    2c43:	8b 00                	mov    (%eax),%eax
    2c45:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2c48:	8b 45 08             	mov    0x8(%ebp),%eax
    2c4b:	8b 40 04             	mov    0x4(%eax),%eax
    2c4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2c51:	8b 45 08             	mov    0x8(%ebp),%eax
    2c54:	8b 40 04             	mov    0x4(%eax),%eax
    2c57:	8b 50 04             	mov    0x4(%eax),%edx
    2c5a:	8b 45 08             	mov    0x8(%ebp),%eax
    2c5d:	89 50 04             	mov    %edx,0x4(%eax)
    2c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c63:	89 04 24             	mov    %eax,(%esp)
    2c66:	e8 b5 fb ff ff       	call   2820 <free>
    2c6b:	8b 45 08             	mov    0x8(%ebp),%eax
    2c6e:	8b 00                	mov    (%eax),%eax
    2c70:	8d 50 ff             	lea    -0x1(%eax),%edx
    2c73:	8b 45 08             	mov    0x8(%ebp),%eax
    2c76:	89 10                	mov    %edx,(%eax)
    2c78:	8b 45 08             	mov    0x8(%ebp),%eax
    2c7b:	8b 00                	mov    (%eax),%eax
    2c7d:	85 c0                	test   %eax,%eax
    2c7f:	75 14                	jne    2c95 <pop_q+0x6d>
    2c81:	8b 45 08             	mov    0x8(%ebp),%eax
    2c84:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    2c8b:	8b 45 08             	mov    0x8(%ebp),%eax
    2c8e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    2c95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c98:	eb 05                	jmp    2c9f <pop_q+0x77>
    2c9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2c9f:	c9                   	leave  
    2ca0:	c3                   	ret    
