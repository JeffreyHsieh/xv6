
_monkey:     file format elf32-i386


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
    102f:	e8 d7 12 00 00       	call   230b <malloc>
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
    10da:	e8 fd 10 00 00       	call   21dc <free>
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
    1143:	e8 be 12 00 00       	call   2406 <lock_init>
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
    1162:	e8 ad 12 00 00       	call   2414 <lock_acquire>
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
    117d:	e8 b1 12 00 00       	call   2433 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 82 12 00 00       	call   2414 <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 6d 0d 00 00       	call   1f04 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 7c 12 00 00       	call   2433 <lock_release>
    tsleep();
    11b7:	e8 78 0d 00 00       	call   1f34 <tsleep>
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
    11e7:	e8 28 12 00 00       	call   2414 <lock_acquire>
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
    1202:	e8 2c 12 00 00       	call   2433 <lock_release>
		
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
    122a:	e8 0d 0d 00 00       	call   1f3c <twakeup>
		}
	}
}
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <main>:

void nMonkey();
void dMonkey();
void printAction(char a[]);

int main(){
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 e4 f0             	and    $0xfffffff0,%esp
    1237:	83 ec 10             	sub    $0x10,%esp
	tree = malloc(sizeof(struct Semaphore));
    123a:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1241:	e8 c5 10 00 00       	call   230b <malloc>
    1246:	a3 cc 29 00 00       	mov    %eax,0x29cc
	p = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 b4 10 00 00       	call   230b <malloc>
    1257:	a3 d0 29 00 00       	mov    %eax,0x29d0
	d = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 a3 10 00 00       	call   230b <malloc>
    1268:	a3 d4 29 00 00       	mov    %eax,0x29d4
	sem_init(d, 1);
    126d:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
	sem_init(p, 1);
    1282:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1287:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    128e:	00 
    128f:	89 04 24             	mov    %eax,(%esp)
    1292:	e8 7e fe ff ff       	call   1115 <sem_init>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
    1297:	c7 04 24 60 26 00 00 	movl   $0x2660,(%esp)
    129e:	e8 3f 09 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    12a3:	a1 cc 29 00 00       	mov    0x29cc,%eax
    12a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    12af:	00 
    12b0:	89 04 24             	mov    %eax,(%esp)
    12b3:	e8 5d fe ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 3; colony++){
    12b8:	c7 05 e8 29 00 00 00 	movl   $0x0,0x29e8
    12bf:	00 00 00 
    12c2:	eb 41                	jmp    1305 <main+0xd4>
		tid = thread_create(nMonkey, (void *) &arg);
    12c4:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    12c9:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    12d0:	00 
    12d1:	89 04 24             	mov    %eax,(%esp)
    12d4:	e8 75 11 00 00       	call   244e <thread_create>
    12d9:	a3 ec 29 00 00       	mov    %eax,0x29ec
		if(tid <= 0){
    12de:	a1 ec 29 00 00       	mov    0x29ec,%eax
    12e3:	85 c0                	test   %eax,%eax
    12e5:	75 11                	jne    12f8 <main+0xc7>
			printAction("Failed to create a thread\n");
    12e7:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    12ee:	e8 ef 08 00 00       	call   1be2 <printAction>
			exit();
    12f3:	e8 8c 0b 00 00       	call   1e84 <exit>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 3; colony++){
    12f8:	a1 e8 29 00 00       	mov    0x29e8,%eax
    12fd:	83 c0 01             	add    $0x1,%eax
    1300:	a3 e8 29 00 00       	mov    %eax,0x29e8
    1305:	a1 e8 29 00 00       	mov    0x29e8,%eax
    130a:	83 f8 02             	cmp    $0x2,%eax
    130d:	7e b5                	jle    12c4 <main+0x93>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    130f:	e8 78 0b 00 00       	call   1e8c <wait>
    1314:	85 c0                	test   %eax,%eax
    1316:	79 f7                	jns    130f <main+0xde>
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
    1318:	c7 04 24 98 26 00 00 	movl   $0x2698,(%esp)
    131f:	e8 be 08 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    1324:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1329:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1330:	00 
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 dc fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 6; colony++){
    1339:	c7 05 e8 29 00 00 00 	movl   $0x0,0x29e8
    1340:	00 00 00 
    1343:	eb 41                	jmp    1386 <main+0x155>
		tid = thread_create(nMonkey, (void *) &arg);
    1345:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    134a:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1351:	00 
    1352:	89 04 24             	mov    %eax,(%esp)
    1355:	e8 f4 10 00 00       	call   244e <thread_create>
    135a:	a3 ec 29 00 00       	mov    %eax,0x29ec
		if(tid <= 0){
    135f:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1364:	85 c0                	test   %eax,%eax
    1366:	75 11                	jne    1379 <main+0x148>
			printAction("Failed to create a thread\n");
    1368:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    136f:	e8 6e 08 00 00       	call   1be2 <printAction>
			exit();
    1374:	e8 0b 0b 00 00       	call   1e84 <exit>
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 6; colony++){
    1379:	a1 e8 29 00 00       	mov    0x29e8,%eax
    137e:	83 c0 01             	add    $0x1,%eax
    1381:	a3 e8 29 00 00       	mov    %eax,0x29e8
    1386:	a1 e8 29 00 00       	mov    0x29e8,%eax
    138b:	83 f8 05             	cmp    $0x5,%eax
    138e:	7e b5                	jle    1345 <main+0x114>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    1390:	e8 f7 0a 00 00       	call   1e8c <wait>
    1395:	85 c0                	test   %eax,%eax
    1397:	79 f7                	jns    1390 <main+0x15f>
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
    1399:	c7 04 24 b8 26 00 00 	movl   $0x26b8,(%esp)
    13a0:	e8 3d 08 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    13a5:	a1 cc 29 00 00       	mov    0x29cc,%eax
    13aa:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    13b1:	00 
    13b2:	89 04 24             	mov    %eax,(%esp)
    13b5:	e8 5b fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 12; colony++){
    13ba:	c7 05 e8 29 00 00 00 	movl   $0x0,0x29e8
    13c1:	00 00 00 
    13c4:	eb 41                	jmp    1407 <main+0x1d6>
		tid = thread_create(nMonkey, (void *) &arg);
    13c6:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    13cb:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    13d2:	00 
    13d3:	89 04 24             	mov    %eax,(%esp)
    13d6:	e8 73 10 00 00       	call   244e <thread_create>
    13db:	a3 ec 29 00 00       	mov    %eax,0x29ec
		if(tid <= 0){
    13e0:	a1 ec 29 00 00       	mov    0x29ec,%eax
    13e5:	85 c0                	test   %eax,%eax
    13e7:	75 11                	jne    13fa <main+0x1c9>
			printAction("Failed to create a thread\n");
    13e9:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    13f0:	e8 ed 07 00 00       	call   1be2 <printAction>
			exit();
    13f5:	e8 8a 0a 00 00       	call   1e84 <exit>
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 12; colony++){
    13fa:	a1 e8 29 00 00       	mov    0x29e8,%eax
    13ff:	83 c0 01             	add    $0x1,%eax
    1402:	a3 e8 29 00 00       	mov    %eax,0x29e8
    1407:	a1 e8 29 00 00       	mov    0x29e8,%eax
    140c:	83 f8 0b             	cmp    $0xb,%eax
    140f:	7e b5                	jle    13c6 <main+0x195>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    1411:	e8 76 0a 00 00       	call   1e8c <wait>
    1416:	85 c0                	test   %eax,%eax
    1418:	79 f7                	jns    1411 <main+0x1e0>
	
	//Test c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N)
	printAction("\nTest c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N):\n");
    141a:	c7 04 24 d8 26 00 00 	movl   $0x26d8,(%esp)
    1421:	e8 bc 07 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    1426:	a1 cc 29 00 00       	mov    0x29cc,%eax
    142b:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1432:	00 
    1433:	89 04 24             	mov    %eax,(%esp)
    1436:	e8 da fc ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    143b:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    1440:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1447:	00 
    1448:	89 04 24             	mov    %eax,(%esp)
    144b:	e8 fe 0f 00 00       	call   244e <thread_create>
    1450:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1455:	a1 ec 29 00 00       	mov    0x29ec,%eax
    145a:	85 c0                	test   %eax,%eax
    145c:	75 11                	jne    146f <main+0x23e>
		printAction("Failed to create a thread\n");
    145e:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1465:	e8 78 07 00 00       	call   1be2 <printAction>
		exit();
    146a:	e8 15 0a 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    146f:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1474:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    147b:	00 
    147c:	89 04 24             	mov    %eax,(%esp)
    147f:	e8 ca 0f 00 00       	call   244e <thread_create>
    1484:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1489:	a1 ec 29 00 00       	mov    0x29ec,%eax
    148e:	85 c0                	test   %eax,%eax
    1490:	75 11                	jne    14a3 <main+0x272>
		printAction("Failed to create a thread\n");
    1492:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1499:	e8 44 07 00 00       	call   1be2 <printAction>
		exit();
    149e:	e8 e1 09 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14a3:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    14a8:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    14af:	00 
    14b0:	89 04 24             	mov    %eax,(%esp)
    14b3:	e8 96 0f 00 00       	call   244e <thread_create>
    14b8:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    14bd:	a1 ec 29 00 00       	mov    0x29ec,%eax
    14c2:	85 c0                	test   %eax,%eax
    14c4:	75 11                	jne    14d7 <main+0x2a6>
		printAction("Failed to create a thread\n");
    14c6:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    14cd:	e8 10 07 00 00       	call   1be2 <printAction>
		exit();
    14d2:	e8 ad 09 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14d7:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    14dc:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    14e3:	00 
    14e4:	89 04 24             	mov    %eax,(%esp)
    14e7:	e8 62 0f 00 00       	call   244e <thread_create>
    14ec:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    14f1:	a1 ec 29 00 00       	mov    0x29ec,%eax
    14f6:	85 c0                	test   %eax,%eax
    14f8:	75 11                	jne    150b <main+0x2da>
		printAction("Failed to create a thread\n");
    14fa:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1501:	e8 dc 06 00 00       	call   1be2 <printAction>
		exit();
    1506:	e8 79 09 00 00       	call   1e84 <exit>
	}
	while(wait()>= 0);
    150b:	e8 7c 09 00 00       	call   1e8c <wait>
    1510:	85 c0                	test   %eax,%eax
    1512:	79 f7                	jns    150b <main+0x2da>
	
	//Test c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D)
	printAction("\nTest c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D):\n");
    1514:	c7 04 24 2c 27 00 00 	movl   $0x272c,(%esp)
    151b:	e8 c2 06 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    1520:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1525:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    152c:	00 
    152d:	89 04 24             	mov    %eax,(%esp)
    1530:	e8 e0 fb ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    1535:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    153a:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1541:	00 
    1542:	89 04 24             	mov    %eax,(%esp)
    1545:	e8 04 0f 00 00       	call   244e <thread_create>
    154a:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    154f:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1554:	85 c0                	test   %eax,%eax
    1556:	75 11                	jne    1569 <main+0x338>
		printAction("Failed to create a thread\n");
    1558:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    155f:	e8 7e 06 00 00       	call   1be2 <printAction>
		exit();
    1564:	e8 1b 09 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1569:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    156e:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1575:	00 
    1576:	89 04 24             	mov    %eax,(%esp)
    1579:	e8 d0 0e 00 00       	call   244e <thread_create>
    157e:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1583:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1588:	85 c0                	test   %eax,%eax
    158a:	75 11                	jne    159d <main+0x36c>
		printAction("Failed to create a thread\n");
    158c:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1593:	e8 4a 06 00 00       	call   1be2 <printAction>
		exit();
    1598:	e8 e7 08 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    159d:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    15a2:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    15a9:	00 
    15aa:	89 04 24             	mov    %eax,(%esp)
    15ad:	e8 9c 0e 00 00       	call   244e <thread_create>
    15b2:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    15b7:	a1 ec 29 00 00       	mov    0x29ec,%eax
    15bc:	85 c0                	test   %eax,%eax
    15be:	75 11                	jne    15d1 <main+0x3a0>
		printAction("Failed to create a thread\n");
    15c0:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    15c7:	e8 16 06 00 00       	call   1be2 <printAction>
		exit();
    15cc:	e8 b3 08 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    15d1:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    15d6:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    15dd:	00 
    15de:	89 04 24             	mov    %eax,(%esp)
    15e1:	e8 68 0e 00 00       	call   244e <thread_create>
    15e6:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    15eb:	a1 ec 29 00 00       	mov    0x29ec,%eax
    15f0:	85 c0                	test   %eax,%eax
    15f2:	75 11                	jne    1605 <main+0x3d4>
		printAction("Failed to create a thread\n");
    15f4:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    15fb:	e8 e2 05 00 00       	call   1be2 <printAction>
		exit();
    1600:	e8 7f 08 00 00       	call   1e84 <exit>
	}
	while(wait()>= 0);
    1605:	e8 82 08 00 00       	call   1e8c <wait>
    160a:	85 c0                	test   %eax,%eax
    160c:	79 f7                	jns    1605 <main+0x3d4>
	
	//Test c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N)
	printAction("\nTest c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N):\n");
    160e:	c7 04 24 80 27 00 00 	movl   $0x2780,(%esp)
    1615:	e8 c8 05 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    161a:	a1 cc 29 00 00       	mov    0x29cc,%eax
    161f:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1626:	00 
    1627:	89 04 24             	mov    %eax,(%esp)
    162a:	e8 e6 fa ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    162f:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1634:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    163b:	00 
    163c:	89 04 24             	mov    %eax,(%esp)
    163f:	e8 0a 0e 00 00       	call   244e <thread_create>
    1644:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1649:	a1 ec 29 00 00       	mov    0x29ec,%eax
    164e:	85 c0                	test   %eax,%eax
    1650:	75 11                	jne    1663 <main+0x432>
		printAction("Failed to create a thread\n");
    1652:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1659:	e8 84 05 00 00       	call   1be2 <printAction>
		exit();
    165e:	e8 21 08 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1663:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1668:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    166f:	00 
    1670:	89 04 24             	mov    %eax,(%esp)
    1673:	e8 d6 0d 00 00       	call   244e <thread_create>
    1678:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    167d:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1682:	85 c0                	test   %eax,%eax
    1684:	75 11                	jne    1697 <main+0x466>
		printAction("Failed to create a thread\n");
    1686:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    168d:	e8 50 05 00 00       	call   1be2 <printAction>
		exit();
    1692:	e8 ed 07 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    1697:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    169c:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    16a3:	00 
    16a4:	89 04 24             	mov    %eax,(%esp)
    16a7:	e8 a2 0d 00 00       	call   244e <thread_create>
    16ac:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    16b1:	a1 ec 29 00 00       	mov    0x29ec,%eax
    16b6:	85 c0                	test   %eax,%eax
    16b8:	75 11                	jne    16cb <main+0x49a>
		printAction("Failed to create a thread\n");
    16ba:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    16c1:	e8 1c 05 00 00       	call   1be2 <printAction>
		exit();
    16c6:	e8 b9 07 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    16cb:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    16d0:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    16d7:	00 
    16d8:	89 04 24             	mov    %eax,(%esp)
    16db:	e8 6e 0d 00 00       	call   244e <thread_create>
    16e0:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    16e5:	a1 ec 29 00 00       	mov    0x29ec,%eax
    16ea:	85 c0                	test   %eax,%eax
    16ec:	75 11                	jne    16ff <main+0x4ce>
		printAction("Failed to create a thread\n");
    16ee:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    16f5:	e8 e8 04 00 00       	call   1be2 <printAction>
		exit();
    16fa:	e8 85 07 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    16ff:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    1704:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    170b:	00 
    170c:	89 04 24             	mov    %eax,(%esp)
    170f:	e8 3a 0d 00 00       	call   244e <thread_create>
    1714:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1719:	a1 ec 29 00 00       	mov    0x29ec,%eax
    171e:	85 c0                	test   %eax,%eax
    1720:	75 11                	jne    1733 <main+0x502>
		printAction("Failed to create a thread\n");
    1722:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1729:	e8 b4 04 00 00       	call   1be2 <printAction>
		exit();
    172e:	e8 51 07 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1733:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1738:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    173f:	00 
    1740:	89 04 24             	mov    %eax,(%esp)
    1743:	e8 06 0d 00 00       	call   244e <thread_create>
    1748:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    174d:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1752:	85 c0                	test   %eax,%eax
    1754:	75 11                	jne    1767 <main+0x536>
		printAction("Failed to create a thread\n");
    1756:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    175d:	e8 80 04 00 00       	call   1be2 <printAction>
		exit();
    1762:	e8 1d 07 00 00       	call   1e84 <exit>
	}
	while(wait()>= 0);
    1767:	e8 20 07 00 00       	call   1e8c <wait>
    176c:	85 c0                	test   %eax,%eax
    176e:	79 f7                	jns    1767 <main+0x536>
	
	//Test c-4: 2 normal monkeys 3 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-4: 2 normal monkeys 4 dominant monkey (Thread creation order: D->D->D->N->N->D):\n");
    1770:	c7 04 24 dc 27 00 00 	movl   $0x27dc,(%esp)
    1777:	e8 66 04 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    177c:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1781:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1788:	00 
    1789:	89 04 24             	mov    %eax,(%esp)
    178c:	e8 84 f9 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    1791:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    1796:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    179d:	00 
    179e:	89 04 24             	mov    %eax,(%esp)
    17a1:	e8 a8 0c 00 00       	call   244e <thread_create>
    17a6:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    17ab:	a1 ec 29 00 00       	mov    0x29ec,%eax
    17b0:	85 c0                	test   %eax,%eax
    17b2:	75 11                	jne    17c5 <main+0x594>
		printAction("Failed to create a thread\n");
    17b4:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    17bb:	e8 22 04 00 00       	call   1be2 <printAction>
		exit();
    17c0:	e8 bf 06 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17c5:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    17ca:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    17d1:	00 
    17d2:	89 04 24             	mov    %eax,(%esp)
    17d5:	e8 74 0c 00 00       	call   244e <thread_create>
    17da:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    17df:	a1 ec 29 00 00       	mov    0x29ec,%eax
    17e4:	85 c0                	test   %eax,%eax
    17e6:	75 11                	jne    17f9 <main+0x5c8>
		printAction("Failed to create a thread\n");
    17e8:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    17ef:	e8 ee 03 00 00       	call   1be2 <printAction>
		exit();
    17f4:	e8 8b 06 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17f9:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    17fe:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1805:	00 
    1806:	89 04 24             	mov    %eax,(%esp)
    1809:	e8 40 0c 00 00       	call   244e <thread_create>
    180e:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1813:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1818:	85 c0                	test   %eax,%eax
    181a:	75 11                	jne    182d <main+0x5fc>
		printAction("Failed to create a thread\n");
    181c:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1823:	e8 ba 03 00 00       	call   1be2 <printAction>
		exit();
    1828:	e8 57 06 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    182d:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1832:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1839:	00 
    183a:	89 04 24             	mov    %eax,(%esp)
    183d:	e8 0c 0c 00 00       	call   244e <thread_create>
    1842:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1847:	a1 ec 29 00 00       	mov    0x29ec,%eax
    184c:	85 c0                	test   %eax,%eax
    184e:	75 11                	jne    1861 <main+0x630>
		printAction("Failed to create a thread\n");
    1850:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1857:	e8 86 03 00 00       	call   1be2 <printAction>
		exit();
    185c:	e8 23 06 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1861:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    1866:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    186d:	00 
    186e:	89 04 24             	mov    %eax,(%esp)
    1871:	e8 d8 0b 00 00       	call   244e <thread_create>
    1876:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    187b:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1880:	85 c0                	test   %eax,%eax
    1882:	75 11                	jne    1895 <main+0x664>
		printAction("Failed to create a thread\n");
    1884:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    188b:	e8 52 03 00 00       	call   1be2 <printAction>
		exit();
    1890:	e8 ef 05 00 00       	call   1e84 <exit>
	}

	tid = thread_create(dMonkey, (void *) &arg);
    1895:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    189a:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    18a1:	00 
    18a2:	89 04 24             	mov    %eax,(%esp)
    18a5:	e8 a4 0b 00 00       	call   244e <thread_create>
    18aa:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    18af:	a1 ec 29 00 00       	mov    0x29ec,%eax
    18b4:	85 c0                	test   %eax,%eax
    18b6:	75 11                	jne    18c9 <main+0x698>
		printAction("Failed to create a thread\n");
    18b8:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    18bf:	e8 1e 03 00 00       	call   1be2 <printAction>
		exit();
    18c4:	e8 bb 05 00 00       	call   1e84 <exit>
	}
	while(wait()>= 0);
    18c9:	e8 be 05 00 00       	call   1e8c <wait>
    18ce:	85 c0                	test   %eax,%eax
    18d0:	79 f7                	jns    18c9 <main+0x698>
	
	//Test c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->N->D->D->D->D):\n");
    18d2:	c7 04 24 38 28 00 00 	movl   $0x2838,(%esp)
    18d9:	e8 04 03 00 00       	call   1be2 <printAction>
	sem_init(tree, 3);
    18de:	a1 cc 29 00 00       	mov    0x29cc,%eax
    18e3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    18ea:	00 
    18eb:	89 04 24             	mov    %eax,(%esp)
    18ee:	e8 22 f8 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    18f3:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    18f8:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    18ff:	00 
    1900:	89 04 24             	mov    %eax,(%esp)
    1903:	e8 46 0b 00 00       	call   244e <thread_create>
    1908:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    190d:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1912:	85 c0                	test   %eax,%eax
    1914:	75 11                	jne    1927 <main+0x6f6>
		printAction("Failed to create a thread\n");
    1916:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    191d:	e8 c0 02 00 00       	call   1be2 <printAction>
		exit();
    1922:	e8 5d 05 00 00       	call   1e84 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1927:	b8 39 1a 00 00       	mov    $0x1a39,%eax
    192c:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1933:	00 
    1934:	89 04 24             	mov    %eax,(%esp)
    1937:	e8 12 0b 00 00       	call   244e <thread_create>
    193c:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1941:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1946:	85 c0                	test   %eax,%eax
    1948:	75 11                	jne    195b <main+0x72a>
		printAction("Failed to create a thread\n");
    194a:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1951:	e8 8c 02 00 00       	call   1be2 <printAction>
		exit();
    1956:	e8 29 05 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    195b:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    1960:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1967:	00 
    1968:	89 04 24             	mov    %eax,(%esp)
    196b:	e8 de 0a 00 00       	call   244e <thread_create>
    1970:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1975:	a1 ec 29 00 00       	mov    0x29ec,%eax
    197a:	85 c0                	test   %eax,%eax
    197c:	75 11                	jne    198f <main+0x75e>
		printAction("Failed to create a thread\n");
    197e:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1985:	e8 58 02 00 00       	call   1be2 <printAction>
		exit();
    198a:	e8 f5 04 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    198f:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    1994:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    199b:	00 
    199c:	89 04 24             	mov    %eax,(%esp)
    199f:	e8 aa 0a 00 00       	call   244e <thread_create>
    19a4:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    19a9:	a1 ec 29 00 00       	mov    0x29ec,%eax
    19ae:	85 c0                	test   %eax,%eax
    19b0:	75 11                	jne    19c3 <main+0x792>
		printAction("Failed to create a thread\n");
    19b2:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    19b9:	e8 24 02 00 00       	call   1be2 <printAction>
		exit();
    19be:	e8 c1 04 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19c3:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    19c8:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    19cf:	00 
    19d0:	89 04 24             	mov    %eax,(%esp)
    19d3:	e8 76 0a 00 00       	call   244e <thread_create>
    19d8:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    19dd:	a1 ec 29 00 00       	mov    0x29ec,%eax
    19e2:	85 c0                	test   %eax,%eax
    19e4:	75 11                	jne    19f7 <main+0x7c6>
		printAction("Failed to create a thread\n");
    19e6:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    19ed:	e8 f0 01 00 00       	call   1be2 <printAction>
		exit();
    19f2:	e8 8d 04 00 00       	call   1e84 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19f7:	b8 fe 1a 00 00       	mov    $0x1afe,%eax
    19fc:	c7 44 24 04 b0 29 00 	movl   $0x29b0,0x4(%esp)
    1a03:	00 
    1a04:	89 04 24             	mov    %eax,(%esp)
    1a07:	e8 42 0a 00 00       	call   244e <thread_create>
    1a0c:	a3 ec 29 00 00       	mov    %eax,0x29ec
	if(tid <= 0){
    1a11:	a1 ec 29 00 00       	mov    0x29ec,%eax
    1a16:	85 c0                	test   %eax,%eax
    1a18:	75 11                	jne    1a2b <main+0x7fa>
		printAction("Failed to create a thread\n");
    1a1a:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1a21:	e8 bc 01 00 00       	call   1be2 <printAction>
		exit();
    1a26:	e8 59 04 00 00       	call   1e84 <exit>
	}
	while(wait()>= 0);
    1a2b:	e8 5c 04 00 00       	call   1e8c <wait>
    1a30:	85 c0                	test   %eax,%eax
    1a32:	79 f7                	jns    1a2b <main+0x7fa>
	exit();
    1a34:	e8 4b 04 00 00       	call   1e84 <exit>

00001a39 <nMonkey>:
	return 0;
}

void nMonkey(){
    1a39:	55                   	push   %ebp
    1a3a:	89 e5                	mov    %esp,%ebp
    1a3c:	83 ec 28             	sub    $0x28,%esp
	sem_acquire(d);
    1a3f:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1a44:	89 04 24             	mov    %eax,(%esp)
    1a47:	e8 fe f6 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1a4c:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1a51:	89 04 24             	mov    %eax,(%esp)
    1a54:	e8 70 f7 ff ff       	call   11c9 <sem_signal>
	printAction("Normal monkey begins climbing\n");
    1a59:	c7 04 24 94 28 00 00 	movl   $0x2894,(%esp)
    1a60:	e8 7d 01 00 00       	call   1be2 <printAction>
	
	int i;
	for(i = 0; i < 2999999; i++){
    1a65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a6c:	eb 20                	jmp    1a8e <nMonkey+0x55>
		if(domClimbing > 0){
    1a6e:	a1 d8 29 00 00       	mov    0x29d8,%eax
    1a73:	85 c0                	test   %eax,%eax
    1a75:	7e 13                	jle    1a8a <nMonkey+0x51>
			printAction("Normal monkey waits\n");
    1a77:	c7 04 24 b3 28 00 00 	movl   $0x28b3,(%esp)
    1a7e:	e8 5f 01 00 00       	call   1be2 <printAction>
			i = 29999999;
    1a83:	c7 45 f4 7f c3 c9 01 	movl   $0x1c9c37f,-0xc(%ebp)
	sem_acquire(d);
	sem_signal(d);
	printAction("Normal monkey begins climbing\n");
	
	int i;
	for(i = 0; i < 2999999; i++){
    1a8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a8e:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1a95:	7e d7                	jle    1a6e <nMonkey+0x35>
			printAction("Normal monkey waits\n");
			i = 29999999;
		}
	}
	
	sem_acquire(d);
    1a97:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1a9c:	89 04 24             	mov    %eax,(%esp)
    1a9f:	e8 a6 f6 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1aa4:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1aa9:	89 04 24             	mov    %eax,(%esp)
    1aac:	e8 18 f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(tree);
    1ab1:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1ab6:	89 04 24             	mov    %eax,(%esp)
    1ab9:	e8 8c f6 ff ff       	call   114a <sem_acquire>
	printAction("Normal monkey acquires coconut (Semaphore)\n");
    1abe:	c7 04 24 c8 28 00 00 	movl   $0x28c8,(%esp)
    1ac5:	e8 18 01 00 00       	call   1be2 <printAction>
	
	for(i = 0; i < 2999999; i++);
    1aca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ad1:	eb 04                	jmp    1ad7 <nMonkey+0x9e>
    1ad3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ad7:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1ade:	7e f3                	jle    1ad3 <nMonkey+0x9a>
	
	printAction("Normal monkey descends\n");
    1ae0:	c7 04 24 f4 28 00 00 	movl   $0x28f4,(%esp)
    1ae7:	e8 f6 00 00 00       	call   1be2 <printAction>

	sem_signal(tree);
    1aec:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1af1:	89 04 24             	mov    %eax,(%esp)
    1af4:	e8 d0 f6 ff ff       	call   11c9 <sem_signal>
	
	texit();
    1af9:	e8 2e 04 00 00       	call   1f2c <texit>

00001afe <dMonkey>:
}

void dMonkey(){
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    1b01:	83 ec 28             	sub    $0x28,%esp
	sem_acquire(d);
    1b04:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1b09:	89 04 24             	mov    %eax,(%esp)
    1b0c:	e8 39 f6 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey begins climbing\n");
    1b11:	c7 04 24 0c 29 00 00 	movl   $0x290c,(%esp)
    1b18:	e8 c5 00 00 00       	call   1be2 <printAction>
	sem_acquire(p);
    1b1d:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1b22:	89 04 24             	mov    %eax,(%esp)
    1b25:	e8 20 f6 ff ff       	call   114a <sem_acquire>
	domClimbing++;
    1b2a:	a1 d8 29 00 00       	mov    0x29d8,%eax
    1b2f:	83 c0 01             	add    $0x1,%eax
    1b32:	a3 d8 29 00 00       	mov    %eax,0x29d8
	sem_signal(p);
    1b37:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1b3c:	89 04 24             	mov    %eax,(%esp)
    1b3f:	e8 85 f6 ff ff       	call   11c9 <sem_signal>

	int i = 0;
    1b44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(i = 0; i < 2999999; i++);
    1b4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b52:	eb 04                	jmp    1b58 <dMonkey+0x5a>
    1b54:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b58:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1b5f:	7e f3                	jle    1b54 <dMonkey+0x56>

	sem_acquire(tree);
    1b61:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1b66:	89 04 24             	mov    %eax,(%esp)
    1b69:	e8 dc f5 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey acquires coconut (Semaphore)\n");
    1b6e:	c7 04 24 30 29 00 00 	movl   $0x2930,(%esp)
    1b75:	e8 68 00 00 00       	call   1be2 <printAction>
	sem_acquire(p);
    1b7a:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1b7f:	89 04 24             	mov    %eax,(%esp)
    1b82:	e8 c3 f5 ff ff       	call   114a <sem_acquire>
	domClimbing--;
    1b87:	a1 d8 29 00 00       	mov    0x29d8,%eax
    1b8c:	83 e8 01             	sub    $0x1,%eax
    1b8f:	a3 d8 29 00 00       	mov    %eax,0x29d8
	sem_signal(p);
    1b94:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1b99:	89 04 24             	mov    %eax,(%esp)
    1b9c:	e8 28 f6 ff ff       	call   11c9 <sem_signal>
	sem_signal(d);
    1ba1:	a1 d4 29 00 00       	mov    0x29d4,%eax
    1ba6:	89 04 24             	mov    %eax,(%esp)
    1ba9:	e8 1b f6 ff ff       	call   11c9 <sem_signal>

	for(i = 0; i < 2999999; i++);
    1bae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bb5:	eb 04                	jmp    1bbb <dMonkey+0xbd>
    1bb7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1bbb:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1bc2:	7e f3                	jle    1bb7 <dMonkey+0xb9>
	
	printAction("Dominant monkey descends\n");
    1bc4:	c7 04 24 5e 29 00 00 	movl   $0x295e,(%esp)
    1bcb:	e8 12 00 00 00       	call   1be2 <printAction>
	
	sem_signal(tree);
    1bd0:	a1 cc 29 00 00       	mov    0x29cc,%eax
    1bd5:	89 04 24             	mov    %eax,(%esp)
    1bd8:	e8 ec f5 ff ff       	call   11c9 <sem_signal>
	
	texit();
    1bdd:	e8 4a 03 00 00       	call   1f2c <texit>

00001be2 <printAction>:
}

void printAction(char a[]){
    1be2:	55                   	push   %ebp
    1be3:	89 e5                	mov    %esp,%ebp
    1be5:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1be8:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1bed:	89 04 24             	mov    %eax,(%esp)
    1bf0:	e8 55 f5 ff ff       	call   114a <sem_acquire>
	printf(1, "%s", a);
    1bf5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf8:	89 44 24 08          	mov    %eax,0x8(%esp)
    1bfc:	c7 44 24 04 78 29 00 	movl   $0x2978,0x4(%esp)
    1c03:	00 
    1c04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c0b:	e8 15 04 00 00       	call   2025 <printf>
	sem_signal(p);
    1c10:	a1 d0 29 00 00       	mov    0x29d0,%eax
    1c15:	89 04 24             	mov    %eax,(%esp)
    1c18:	e8 ac f5 ff ff       	call   11c9 <sem_signal>
}
    1c1d:	c9                   	leave  
    1c1e:	c3                   	ret    
    1c1f:	90                   	nop

00001c20 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1c20:	55                   	push   %ebp
    1c21:	89 e5                	mov    %esp,%ebp
    1c23:	57                   	push   %edi
    1c24:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1c25:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c28:	8b 55 10             	mov    0x10(%ebp),%edx
    1c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c2e:	89 cb                	mov    %ecx,%ebx
    1c30:	89 df                	mov    %ebx,%edi
    1c32:	89 d1                	mov    %edx,%ecx
    1c34:	fc                   	cld    
    1c35:	f3 aa                	rep stos %al,%es:(%edi)
    1c37:	89 ca                	mov    %ecx,%edx
    1c39:	89 fb                	mov    %edi,%ebx
    1c3b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1c3e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1c41:	5b                   	pop    %ebx
    1c42:	5f                   	pop    %edi
    1c43:	5d                   	pop    %ebp
    1c44:	c3                   	ret    

00001c45 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1c45:	55                   	push   %ebp
    1c46:	89 e5                	mov    %esp,%ebp
    1c48:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1c4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1c51:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c54:	0f b6 10             	movzbl (%eax),%edx
    1c57:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5a:	88 10                	mov    %dl,(%eax)
    1c5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5f:	0f b6 00             	movzbl (%eax),%eax
    1c62:	84 c0                	test   %al,%al
    1c64:	0f 95 c0             	setne  %al
    1c67:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c6b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1c6f:	84 c0                	test   %al,%al
    1c71:	75 de                	jne    1c51 <strcpy+0xc>
    ;
  return os;
    1c73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c76:	c9                   	leave  
    1c77:	c3                   	ret    

00001c78 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1c78:	55                   	push   %ebp
    1c79:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1c7b:	eb 08                	jmp    1c85 <strcmp+0xd>
    p++, q++;
    1c7d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c81:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1c85:	8b 45 08             	mov    0x8(%ebp),%eax
    1c88:	0f b6 00             	movzbl (%eax),%eax
    1c8b:	84 c0                	test   %al,%al
    1c8d:	74 10                	je     1c9f <strcmp+0x27>
    1c8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c92:	0f b6 10             	movzbl (%eax),%edx
    1c95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c98:	0f b6 00             	movzbl (%eax),%eax
    1c9b:	38 c2                	cmp    %al,%dl
    1c9d:	74 de                	je     1c7d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1c9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca2:	0f b6 00             	movzbl (%eax),%eax
    1ca5:	0f b6 d0             	movzbl %al,%edx
    1ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cab:	0f b6 00             	movzbl (%eax),%eax
    1cae:	0f b6 c0             	movzbl %al,%eax
    1cb1:	89 d1                	mov    %edx,%ecx
    1cb3:	29 c1                	sub    %eax,%ecx
    1cb5:	89 c8                	mov    %ecx,%eax
}
    1cb7:	5d                   	pop    %ebp
    1cb8:	c3                   	ret    

00001cb9 <strlen>:

uint
strlen(char *s)
{
    1cb9:	55                   	push   %ebp
    1cba:	89 e5                	mov    %esp,%ebp
    1cbc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1cbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1cc6:	eb 04                	jmp    1ccc <strlen+0x13>
    1cc8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1ccc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ccf:	03 45 08             	add    0x8(%ebp),%eax
    1cd2:	0f b6 00             	movzbl (%eax),%eax
    1cd5:	84 c0                	test   %al,%al
    1cd7:	75 ef                	jne    1cc8 <strlen+0xf>
    ;
  return n;
    1cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1cdc:	c9                   	leave  
    1cdd:	c3                   	ret    

00001cde <memset>:

void*
memset(void *dst, int c, uint n)
{
    1cde:	55                   	push   %ebp
    1cdf:	89 e5                	mov    %esp,%ebp
    1ce1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1ce4:	8b 45 10             	mov    0x10(%ebp),%eax
    1ce7:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cee:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf5:	89 04 24             	mov    %eax,(%esp)
    1cf8:	e8 23 ff ff ff       	call   1c20 <stosb>
  return dst;
    1cfd:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1d00:	c9                   	leave  
    1d01:	c3                   	ret    

00001d02 <strchr>:

char*
strchr(const char *s, char c)
{
    1d02:	55                   	push   %ebp
    1d03:	89 e5                	mov    %esp,%ebp
    1d05:	83 ec 04             	sub    $0x4,%esp
    1d08:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d0b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1d0e:	eb 14                	jmp    1d24 <strchr+0x22>
    if(*s == c)
    1d10:	8b 45 08             	mov    0x8(%ebp),%eax
    1d13:	0f b6 00             	movzbl (%eax),%eax
    1d16:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1d19:	75 05                	jne    1d20 <strchr+0x1e>
      return (char*)s;
    1d1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1e:	eb 13                	jmp    1d33 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1d20:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1d24:	8b 45 08             	mov    0x8(%ebp),%eax
    1d27:	0f b6 00             	movzbl (%eax),%eax
    1d2a:	84 c0                	test   %al,%al
    1d2c:	75 e2                	jne    1d10 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1d2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d33:	c9                   	leave  
    1d34:	c3                   	ret    

00001d35 <gets>:

char*
gets(char *buf, int max)
{
    1d35:	55                   	push   %ebp
    1d36:	89 e5                	mov    %esp,%ebp
    1d38:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d3b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1d42:	eb 44                	jmp    1d88 <gets+0x53>
    cc = read(0, &c, 1);
    1d44:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1d4b:	00 
    1d4c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1d4f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d53:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d5a:	e8 3d 01 00 00       	call   1e9c <read>
    1d5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1d62:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d66:	7e 2d                	jle    1d95 <gets+0x60>
      break;
    buf[i++] = c;
    1d68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d6b:	03 45 08             	add    0x8(%ebp),%eax
    1d6e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1d72:	88 10                	mov    %dl,(%eax)
    1d74:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1d78:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d7c:	3c 0a                	cmp    $0xa,%al
    1d7e:	74 16                	je     1d96 <gets+0x61>
    1d80:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d84:	3c 0d                	cmp    $0xd,%al
    1d86:	74 0e                	je     1d96 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d8b:	83 c0 01             	add    $0x1,%eax
    1d8e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d91:	7c b1                	jl     1d44 <gets+0xf>
    1d93:	eb 01                	jmp    1d96 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1d95:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1d96:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d99:	03 45 08             	add    0x8(%ebp),%eax
    1d9c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1d9f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1da2:	c9                   	leave  
    1da3:	c3                   	ret    

00001da4 <stat>:

int
stat(char *n, struct stat *st)
{
    1da4:	55                   	push   %ebp
    1da5:	89 e5                	mov    %esp,%ebp
    1da7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1daa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1db1:	00 
    1db2:	8b 45 08             	mov    0x8(%ebp),%eax
    1db5:	89 04 24             	mov    %eax,(%esp)
    1db8:	e8 07 01 00 00       	call   1ec4 <open>
    1dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1dc0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1dc4:	79 07                	jns    1dcd <stat+0x29>
    return -1;
    1dc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1dcb:	eb 23                	jmp    1df0 <stat+0x4c>
  r = fstat(fd, st);
    1dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dd0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dd7:	89 04 24             	mov    %eax,(%esp)
    1dda:	e8 fd 00 00 00       	call   1edc <fstat>
    1ddf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1de2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1de5:	89 04 24             	mov    %eax,(%esp)
    1de8:	e8 bf 00 00 00       	call   1eac <close>
  return r;
    1ded:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1df0:	c9                   	leave  
    1df1:	c3                   	ret    

00001df2 <atoi>:

int
atoi(const char *s)
{
    1df2:	55                   	push   %ebp
    1df3:	89 e5                	mov    %esp,%ebp
    1df5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1df8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1dff:	eb 24                	jmp    1e25 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1e01:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1e04:	89 d0                	mov    %edx,%eax
    1e06:	c1 e0 02             	shl    $0x2,%eax
    1e09:	01 d0                	add    %edx,%eax
    1e0b:	01 c0                	add    %eax,%eax
    1e0d:	89 c2                	mov    %eax,%edx
    1e0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e12:	0f b6 00             	movzbl (%eax),%eax
    1e15:	0f be c0             	movsbl %al,%eax
    1e18:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1e1b:	83 e8 30             	sub    $0x30,%eax
    1e1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e21:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1e25:	8b 45 08             	mov    0x8(%ebp),%eax
    1e28:	0f b6 00             	movzbl (%eax),%eax
    1e2b:	3c 2f                	cmp    $0x2f,%al
    1e2d:	7e 0a                	jle    1e39 <atoi+0x47>
    1e2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e32:	0f b6 00             	movzbl (%eax),%eax
    1e35:	3c 39                	cmp    $0x39,%al
    1e37:	7e c8                	jle    1e01 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1e39:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1e3c:	c9                   	leave  
    1e3d:	c3                   	ret    

00001e3e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1e3e:	55                   	push   %ebp
    1e3f:	89 e5                	mov    %esp,%ebp
    1e41:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1e44:	8b 45 08             	mov    0x8(%ebp),%eax
    1e47:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1e50:	eb 13                	jmp    1e65 <memmove+0x27>
    *dst++ = *src++;
    1e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1e55:	0f b6 10             	movzbl (%eax),%edx
    1e58:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e5b:	88 10                	mov    %dl,(%eax)
    1e5d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1e61:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e69:	0f 9f c0             	setg   %al
    1e6c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1e70:	84 c0                	test   %al,%al
    1e72:	75 de                	jne    1e52 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1e74:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1e77:	c9                   	leave  
    1e78:	c3                   	ret    
    1e79:	90                   	nop
    1e7a:	90                   	nop
    1e7b:	90                   	nop

00001e7c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1e7c:	b8 01 00 00 00       	mov    $0x1,%eax
    1e81:	cd 40                	int    $0x40
    1e83:	c3                   	ret    

00001e84 <exit>:
SYSCALL(exit)
    1e84:	b8 02 00 00 00       	mov    $0x2,%eax
    1e89:	cd 40                	int    $0x40
    1e8b:	c3                   	ret    

00001e8c <wait>:
SYSCALL(wait)
    1e8c:	b8 03 00 00 00       	mov    $0x3,%eax
    1e91:	cd 40                	int    $0x40
    1e93:	c3                   	ret    

00001e94 <pipe>:
SYSCALL(pipe)
    1e94:	b8 04 00 00 00       	mov    $0x4,%eax
    1e99:	cd 40                	int    $0x40
    1e9b:	c3                   	ret    

00001e9c <read>:
SYSCALL(read)
    1e9c:	b8 05 00 00 00       	mov    $0x5,%eax
    1ea1:	cd 40                	int    $0x40
    1ea3:	c3                   	ret    

00001ea4 <write>:
SYSCALL(write)
    1ea4:	b8 10 00 00 00       	mov    $0x10,%eax
    1ea9:	cd 40                	int    $0x40
    1eab:	c3                   	ret    

00001eac <close>:
SYSCALL(close)
    1eac:	b8 15 00 00 00       	mov    $0x15,%eax
    1eb1:	cd 40                	int    $0x40
    1eb3:	c3                   	ret    

00001eb4 <kill>:
SYSCALL(kill)
    1eb4:	b8 06 00 00 00       	mov    $0x6,%eax
    1eb9:	cd 40                	int    $0x40
    1ebb:	c3                   	ret    

00001ebc <exec>:
SYSCALL(exec)
    1ebc:	b8 07 00 00 00       	mov    $0x7,%eax
    1ec1:	cd 40                	int    $0x40
    1ec3:	c3                   	ret    

00001ec4 <open>:
SYSCALL(open)
    1ec4:	b8 0f 00 00 00       	mov    $0xf,%eax
    1ec9:	cd 40                	int    $0x40
    1ecb:	c3                   	ret    

00001ecc <mknod>:
SYSCALL(mknod)
    1ecc:	b8 11 00 00 00       	mov    $0x11,%eax
    1ed1:	cd 40                	int    $0x40
    1ed3:	c3                   	ret    

00001ed4 <unlink>:
SYSCALL(unlink)
    1ed4:	b8 12 00 00 00       	mov    $0x12,%eax
    1ed9:	cd 40                	int    $0x40
    1edb:	c3                   	ret    

00001edc <fstat>:
SYSCALL(fstat)
    1edc:	b8 08 00 00 00       	mov    $0x8,%eax
    1ee1:	cd 40                	int    $0x40
    1ee3:	c3                   	ret    

00001ee4 <link>:
SYSCALL(link)
    1ee4:	b8 13 00 00 00       	mov    $0x13,%eax
    1ee9:	cd 40                	int    $0x40
    1eeb:	c3                   	ret    

00001eec <mkdir>:
SYSCALL(mkdir)
    1eec:	b8 14 00 00 00       	mov    $0x14,%eax
    1ef1:	cd 40                	int    $0x40
    1ef3:	c3                   	ret    

00001ef4 <chdir>:
SYSCALL(chdir)
    1ef4:	b8 09 00 00 00       	mov    $0x9,%eax
    1ef9:	cd 40                	int    $0x40
    1efb:	c3                   	ret    

00001efc <dup>:
SYSCALL(dup)
    1efc:	b8 0a 00 00 00       	mov    $0xa,%eax
    1f01:	cd 40                	int    $0x40
    1f03:	c3                   	ret    

00001f04 <getpid>:
SYSCALL(getpid)
    1f04:	b8 0b 00 00 00       	mov    $0xb,%eax
    1f09:	cd 40                	int    $0x40
    1f0b:	c3                   	ret    

00001f0c <sbrk>:
SYSCALL(sbrk)
    1f0c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1f11:	cd 40                	int    $0x40
    1f13:	c3                   	ret    

00001f14 <sleep>:
SYSCALL(sleep)
    1f14:	b8 0d 00 00 00       	mov    $0xd,%eax
    1f19:	cd 40                	int    $0x40
    1f1b:	c3                   	ret    

00001f1c <uptime>:
SYSCALL(uptime)
    1f1c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1f21:	cd 40                	int    $0x40
    1f23:	c3                   	ret    

00001f24 <clone>:
SYSCALL(clone)
    1f24:	b8 16 00 00 00       	mov    $0x16,%eax
    1f29:	cd 40                	int    $0x40
    1f2b:	c3                   	ret    

00001f2c <texit>:
SYSCALL(texit)
    1f2c:	b8 17 00 00 00       	mov    $0x17,%eax
    1f31:	cd 40                	int    $0x40
    1f33:	c3                   	ret    

00001f34 <tsleep>:
SYSCALL(tsleep)
    1f34:	b8 18 00 00 00       	mov    $0x18,%eax
    1f39:	cd 40                	int    $0x40
    1f3b:	c3                   	ret    

00001f3c <twakeup>:
SYSCALL(twakeup)
    1f3c:	b8 19 00 00 00       	mov    $0x19,%eax
    1f41:	cd 40                	int    $0x40
    1f43:	c3                   	ret    

00001f44 <thread_yield>:
SYSCALL(thread_yield)
    1f44:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1f49:	cd 40                	int    $0x40
    1f4b:	c3                   	ret    

00001f4c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1f4c:	55                   	push   %ebp
    1f4d:	89 e5                	mov    %esp,%ebp
    1f4f:	83 ec 28             	sub    $0x28,%esp
    1f52:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f55:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f58:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f5f:	00 
    1f60:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f63:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f67:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6a:	89 04 24             	mov    %eax,(%esp)
    1f6d:	e8 32 ff ff ff       	call   1ea4 <write>
}
    1f72:	c9                   	leave  
    1f73:	c3                   	ret    

00001f74 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f74:	55                   	push   %ebp
    1f75:	89 e5                	mov    %esp,%ebp
    1f77:	53                   	push   %ebx
    1f78:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f7b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f82:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f86:	74 17                	je     1f9f <printint+0x2b>
    1f88:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f8c:	79 11                	jns    1f9f <printint+0x2b>
    neg = 1;
    1f8e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f98:	f7 d8                	neg    %eax
    1f9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1f9d:	eb 06                	jmp    1fa5 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1fa5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1fac:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1faf:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb5:	ba 00 00 00 00       	mov    $0x0,%edx
    1fba:	f7 f3                	div    %ebx
    1fbc:	89 d0                	mov    %edx,%eax
    1fbe:	0f b6 80 b4 29 00 00 	movzbl 0x29b4(%eax),%eax
    1fc5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1fc9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1fcd:	8b 45 10             	mov    0x10(%ebp),%eax
    1fd0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1fd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd6:	ba 00 00 00 00       	mov    $0x0,%edx
    1fdb:	f7 75 d4             	divl   -0x2c(%ebp)
    1fde:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1fe1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fe5:	75 c5                	jne    1fac <printint+0x38>
  if(neg)
    1fe7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1feb:	74 28                	je     2015 <printint+0xa1>
    buf[i++] = '-';
    1fed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ff0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1ff5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1ff9:	eb 1a                	jmp    2015 <printint+0xa1>
    putc(fd, buf[i]);
    1ffb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ffe:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    2003:	0f be c0             	movsbl %al,%eax
    2006:	89 44 24 04          	mov    %eax,0x4(%esp)
    200a:	8b 45 08             	mov    0x8(%ebp),%eax
    200d:	89 04 24             	mov    %eax,(%esp)
    2010:	e8 37 ff ff ff       	call   1f4c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2015:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    2019:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    201d:	79 dc                	jns    1ffb <printint+0x87>
    putc(fd, buf[i]);
}
    201f:	83 c4 44             	add    $0x44,%esp
    2022:	5b                   	pop    %ebx
    2023:	5d                   	pop    %ebp
    2024:	c3                   	ret    

00002025 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2025:	55                   	push   %ebp
    2026:	89 e5                	mov    %esp,%ebp
    2028:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    202b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    2032:	8d 45 0c             	lea    0xc(%ebp),%eax
    2035:	83 c0 04             	add    $0x4,%eax
    2038:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    203b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2042:	e9 7e 01 00 00       	jmp    21c5 <printf+0x1a0>
    c = fmt[i] & 0xff;
    2047:	8b 55 0c             	mov    0xc(%ebp),%edx
    204a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    204d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2050:	0f b6 00             	movzbl (%eax),%eax
    2053:	0f be c0             	movsbl %al,%eax
    2056:	25 ff 00 00 00       	and    $0xff,%eax
    205b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    205e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2062:	75 2c                	jne    2090 <printf+0x6b>
      if(c == '%'){
    2064:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2068:	75 0c                	jne    2076 <printf+0x51>
        state = '%';
    206a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    2071:	e9 4b 01 00 00       	jmp    21c1 <printf+0x19c>
      } else {
        putc(fd, c);
    2076:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2079:	0f be c0             	movsbl %al,%eax
    207c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2080:	8b 45 08             	mov    0x8(%ebp),%eax
    2083:	89 04 24             	mov    %eax,(%esp)
    2086:	e8 c1 fe ff ff       	call   1f4c <putc>
    208b:	e9 31 01 00 00       	jmp    21c1 <printf+0x19c>
      }
    } else if(state == '%'){
    2090:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    2094:	0f 85 27 01 00 00    	jne    21c1 <printf+0x19c>
      if(c == 'd'){
    209a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    209e:	75 2d                	jne    20cd <printf+0xa8>
        printint(fd, *ap, 10, 1);
    20a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a3:	8b 00                	mov    (%eax),%eax
    20a5:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    20ac:	00 
    20ad:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    20b4:	00 
    20b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    20b9:	8b 45 08             	mov    0x8(%ebp),%eax
    20bc:	89 04 24             	mov    %eax,(%esp)
    20bf:	e8 b0 fe ff ff       	call   1f74 <printint>
        ap++;
    20c4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    20c8:	e9 ed 00 00 00       	jmp    21ba <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    20cd:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    20d1:	74 06                	je     20d9 <printf+0xb4>
    20d3:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    20d7:	75 2d                	jne    2106 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    20d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20dc:	8b 00                	mov    (%eax),%eax
    20de:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    20e5:	00 
    20e6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    20ed:	00 
    20ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    20f2:	8b 45 08             	mov    0x8(%ebp),%eax
    20f5:	89 04 24             	mov    %eax,(%esp)
    20f8:	e8 77 fe ff ff       	call   1f74 <printint>
        ap++;
    20fd:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2101:	e9 b4 00 00 00       	jmp    21ba <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2106:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    210a:	75 46                	jne    2152 <printf+0x12d>
        s = (char*)*ap;
    210c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    210f:	8b 00                	mov    (%eax),%eax
    2111:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    2114:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    2118:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    211c:	75 27                	jne    2145 <printf+0x120>
          s = "(null)";
    211e:	c7 45 e4 7b 29 00 00 	movl   $0x297b,-0x1c(%ebp)
        while(*s != 0){
    2125:	eb 1f                	jmp    2146 <printf+0x121>
          putc(fd, *s);
    2127:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212a:	0f b6 00             	movzbl (%eax),%eax
    212d:	0f be c0             	movsbl %al,%eax
    2130:	89 44 24 04          	mov    %eax,0x4(%esp)
    2134:	8b 45 08             	mov    0x8(%ebp),%eax
    2137:	89 04 24             	mov    %eax,(%esp)
    213a:	e8 0d fe ff ff       	call   1f4c <putc>
          s++;
    213f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2143:	eb 01                	jmp    2146 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2145:	90                   	nop
    2146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2149:	0f b6 00             	movzbl (%eax),%eax
    214c:	84 c0                	test   %al,%al
    214e:	75 d7                	jne    2127 <printf+0x102>
    2150:	eb 68                	jmp    21ba <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2152:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    2156:	75 1d                	jne    2175 <printf+0x150>
        putc(fd, *ap);
    2158:	8b 45 f4             	mov    -0xc(%ebp),%eax
    215b:	8b 00                	mov    (%eax),%eax
    215d:	0f be c0             	movsbl %al,%eax
    2160:	89 44 24 04          	mov    %eax,0x4(%esp)
    2164:	8b 45 08             	mov    0x8(%ebp),%eax
    2167:	89 04 24             	mov    %eax,(%esp)
    216a:	e8 dd fd ff ff       	call   1f4c <putc>
        ap++;
    216f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    2173:	eb 45                	jmp    21ba <printf+0x195>
      } else if(c == '%'){
    2175:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2179:	75 17                	jne    2192 <printf+0x16d>
        putc(fd, c);
    217b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    217e:	0f be c0             	movsbl %al,%eax
    2181:	89 44 24 04          	mov    %eax,0x4(%esp)
    2185:	8b 45 08             	mov    0x8(%ebp),%eax
    2188:	89 04 24             	mov    %eax,(%esp)
    218b:	e8 bc fd ff ff       	call   1f4c <putc>
    2190:	eb 28                	jmp    21ba <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2192:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2199:	00 
    219a:	8b 45 08             	mov    0x8(%ebp),%eax
    219d:	89 04 24             	mov    %eax,(%esp)
    21a0:	e8 a7 fd ff ff       	call   1f4c <putc>
        putc(fd, c);
    21a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21a8:	0f be c0             	movsbl %al,%eax
    21ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    21af:	8b 45 08             	mov    0x8(%ebp),%eax
    21b2:	89 04 24             	mov    %eax,(%esp)
    21b5:	e8 92 fd ff ff       	call   1f4c <putc>
      }
      state = 0;
    21ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    21c1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    21c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21cb:	8d 04 02             	lea    (%edx,%eax,1),%eax
    21ce:	0f b6 00             	movzbl (%eax),%eax
    21d1:	84 c0                	test   %al,%al
    21d3:	0f 85 6e fe ff ff    	jne    2047 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    21d9:	c9                   	leave  
    21da:	c3                   	ret    
    21db:	90                   	nop

000021dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    21dc:	55                   	push   %ebp
    21dd:	89 e5                	mov    %esp,%ebp
    21df:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    21e2:	8b 45 08             	mov    0x8(%ebp),%eax
    21e5:	83 e8 08             	sub    $0x8,%eax
    21e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    21eb:	a1 e4 29 00 00       	mov    0x29e4,%eax
    21f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21f3:	eb 24                	jmp    2219 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    21f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21f8:	8b 00                	mov    (%eax),%eax
    21fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21fd:	77 12                	ja     2211 <free+0x35>
    21ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2202:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2205:	77 24                	ja     222b <free+0x4f>
    2207:	8b 45 fc             	mov    -0x4(%ebp),%eax
    220a:	8b 00                	mov    (%eax),%eax
    220c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    220f:	77 1a                	ja     222b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2211:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2214:	8b 00                	mov    (%eax),%eax
    2216:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2219:	8b 45 f8             	mov    -0x8(%ebp),%eax
    221c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    221f:	76 d4                	jbe    21f5 <free+0x19>
    2221:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2224:	8b 00                	mov    (%eax),%eax
    2226:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2229:	76 ca                	jbe    21f5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    222b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    222e:	8b 40 04             	mov    0x4(%eax),%eax
    2231:	c1 e0 03             	shl    $0x3,%eax
    2234:	89 c2                	mov    %eax,%edx
    2236:	03 55 f8             	add    -0x8(%ebp),%edx
    2239:	8b 45 fc             	mov    -0x4(%ebp),%eax
    223c:	8b 00                	mov    (%eax),%eax
    223e:	39 c2                	cmp    %eax,%edx
    2240:	75 24                	jne    2266 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    2242:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2245:	8b 50 04             	mov    0x4(%eax),%edx
    2248:	8b 45 fc             	mov    -0x4(%ebp),%eax
    224b:	8b 00                	mov    (%eax),%eax
    224d:	8b 40 04             	mov    0x4(%eax),%eax
    2250:	01 c2                	add    %eax,%edx
    2252:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2255:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2258:	8b 45 fc             	mov    -0x4(%ebp),%eax
    225b:	8b 00                	mov    (%eax),%eax
    225d:	8b 10                	mov    (%eax),%edx
    225f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2262:	89 10                	mov    %edx,(%eax)
    2264:	eb 0a                	jmp    2270 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    2266:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2269:	8b 10                	mov    (%eax),%edx
    226b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    226e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    2270:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2273:	8b 40 04             	mov    0x4(%eax),%eax
    2276:	c1 e0 03             	shl    $0x3,%eax
    2279:	03 45 fc             	add    -0x4(%ebp),%eax
    227c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    227f:	75 20                	jne    22a1 <free+0xc5>
    p->s.size += bp->s.size;
    2281:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2284:	8b 50 04             	mov    0x4(%eax),%edx
    2287:	8b 45 f8             	mov    -0x8(%ebp),%eax
    228a:	8b 40 04             	mov    0x4(%eax),%eax
    228d:	01 c2                	add    %eax,%edx
    228f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2292:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2295:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2298:	8b 10                	mov    (%eax),%edx
    229a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    229d:	89 10                	mov    %edx,(%eax)
    229f:	eb 08                	jmp    22a9 <free+0xcd>
  } else
    p->s.ptr = bp;
    22a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    22a7:	89 10                	mov    %edx,(%eax)
  freep = p;
    22a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22ac:	a3 e4 29 00 00       	mov    %eax,0x29e4
}
    22b1:	c9                   	leave  
    22b2:	c3                   	ret    

000022b3 <morecore>:

static Header*
morecore(uint nu)
{
    22b3:	55                   	push   %ebp
    22b4:	89 e5                	mov    %esp,%ebp
    22b6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    22b9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    22c0:	77 07                	ja     22c9 <morecore+0x16>
    nu = 4096;
    22c2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    22c9:	8b 45 08             	mov    0x8(%ebp),%eax
    22cc:	c1 e0 03             	shl    $0x3,%eax
    22cf:	89 04 24             	mov    %eax,(%esp)
    22d2:	e8 35 fc ff ff       	call   1f0c <sbrk>
    22d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    22da:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    22de:	75 07                	jne    22e7 <morecore+0x34>
    return 0;
    22e0:	b8 00 00 00 00       	mov    $0x0,%eax
    22e5:	eb 22                	jmp    2309 <morecore+0x56>
  hp = (Header*)p;
    22e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    22ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22f0:	8b 55 08             	mov    0x8(%ebp),%edx
    22f3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    22f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22f9:	83 c0 08             	add    $0x8,%eax
    22fc:	89 04 24             	mov    %eax,(%esp)
    22ff:	e8 d8 fe ff ff       	call   21dc <free>
  return freep;
    2304:	a1 e4 29 00 00       	mov    0x29e4,%eax
}
    2309:	c9                   	leave  
    230a:	c3                   	ret    

0000230b <malloc>:

void*
malloc(uint nbytes)
{
    230b:	55                   	push   %ebp
    230c:	89 e5                	mov    %esp,%ebp
    230e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2311:	8b 45 08             	mov    0x8(%ebp),%eax
    2314:	83 c0 07             	add    $0x7,%eax
    2317:	c1 e8 03             	shr    $0x3,%eax
    231a:	83 c0 01             	add    $0x1,%eax
    231d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    2320:	a1 e4 29 00 00       	mov    0x29e4,%eax
    2325:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2328:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    232c:	75 23                	jne    2351 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    232e:	c7 45 f0 dc 29 00 00 	movl   $0x29dc,-0x10(%ebp)
    2335:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2338:	a3 e4 29 00 00       	mov    %eax,0x29e4
    233d:	a1 e4 29 00 00       	mov    0x29e4,%eax
    2342:	a3 dc 29 00 00       	mov    %eax,0x29dc
    base.s.size = 0;
    2347:	c7 05 e0 29 00 00 00 	movl   $0x0,0x29e0
    234e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2351:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2354:	8b 00                	mov    (%eax),%eax
    2356:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    2359:	8b 45 ec             	mov    -0x14(%ebp),%eax
    235c:	8b 40 04             	mov    0x4(%eax),%eax
    235f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2362:	72 4d                	jb     23b1 <malloc+0xa6>
      if(p->s.size == nunits)
    2364:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2367:	8b 40 04             	mov    0x4(%eax),%eax
    236a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    236d:	75 0c                	jne    237b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    236f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2372:	8b 10                	mov    (%eax),%edx
    2374:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2377:	89 10                	mov    %edx,(%eax)
    2379:	eb 26                	jmp    23a1 <malloc+0x96>
      else {
        p->s.size -= nunits;
    237b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    237e:	8b 40 04             	mov    0x4(%eax),%eax
    2381:	89 c2                	mov    %eax,%edx
    2383:	2b 55 f4             	sub    -0xc(%ebp),%edx
    2386:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2389:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    238c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    238f:	8b 40 04             	mov    0x4(%eax),%eax
    2392:	c1 e0 03             	shl    $0x3,%eax
    2395:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    2398:	8b 45 ec             	mov    -0x14(%ebp),%eax
    239b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    239e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    23a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23a4:	a3 e4 29 00 00       	mov    %eax,0x29e4
      return (void*)(p + 1);
    23a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23ac:	83 c0 08             	add    $0x8,%eax
    23af:	eb 38                	jmp    23e9 <malloc+0xde>
    }
    if(p == freep)
    23b1:	a1 e4 29 00 00       	mov    0x29e4,%eax
    23b6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    23b9:	75 1b                	jne    23d6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    23bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23be:	89 04 24             	mov    %eax,(%esp)
    23c1:	e8 ed fe ff ff       	call   22b3 <morecore>
    23c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    23c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    23cd:	75 07                	jne    23d6 <malloc+0xcb>
        return 0;
    23cf:	b8 00 00 00 00       	mov    $0x0,%eax
    23d4:	eb 13                	jmp    23e9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    23d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23df:	8b 00                	mov    (%eax),%eax
    23e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    23e4:	e9 70 ff ff ff       	jmp    2359 <malloc+0x4e>
}
    23e9:	c9                   	leave  
    23ea:	c3                   	ret    
    23eb:	90                   	nop

000023ec <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    23ec:	55                   	push   %ebp
    23ed:	89 e5                	mov    %esp,%ebp
    23ef:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    23f2:	8b 55 08             	mov    0x8(%ebp),%edx
    23f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    23f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23fb:	f0 87 02             	lock xchg %eax,(%edx)
    23fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    2401:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2404:	c9                   	leave  
    2405:	c3                   	ret    

00002406 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    2406:	55                   	push   %ebp
    2407:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    2409:	8b 45 08             	mov    0x8(%ebp),%eax
    240c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    2412:	5d                   	pop    %ebp
    2413:	c3                   	ret    

00002414 <lock_acquire>:
void lock_acquire(lock_t *lock){
    2414:	55                   	push   %ebp
    2415:	89 e5                	mov    %esp,%ebp
    2417:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    241a:	8b 45 08             	mov    0x8(%ebp),%eax
    241d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2424:	00 
    2425:	89 04 24             	mov    %eax,(%esp)
    2428:	e8 bf ff ff ff       	call   23ec <xchg>
    242d:	85 c0                	test   %eax,%eax
    242f:	75 e9                	jne    241a <lock_acquire+0x6>
}
    2431:	c9                   	leave  
    2432:	c3                   	ret    

00002433 <lock_release>:
void lock_release(lock_t *lock){
    2433:	55                   	push   %ebp
    2434:	89 e5                	mov    %esp,%ebp
    2436:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    2439:	8b 45 08             	mov    0x8(%ebp),%eax
    243c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2443:	00 
    2444:	89 04 24             	mov    %eax,(%esp)
    2447:	e8 a0 ff ff ff       	call   23ec <xchg>
}
    244c:	c9                   	leave  
    244d:	c3                   	ret    

0000244e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    244e:	55                   	push   %ebp
    244f:	89 e5                	mov    %esp,%ebp
    2451:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2454:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    245b:	e8 ab fe ff ff       	call   230b <malloc>
    2460:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    2463:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2466:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    2469:	8b 45 f0             	mov    -0x10(%ebp),%eax
    246c:	25 ff 0f 00 00       	and    $0xfff,%eax
    2471:	85 c0                	test   %eax,%eax
    2473:	74 15                	je     248a <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    2475:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2478:	89 c2                	mov    %eax,%edx
    247a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    2480:	b8 00 10 00 00       	mov    $0x1000,%eax
    2485:	29 d0                	sub    %edx,%eax
    2487:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    248a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    248e:	75 1b                	jne    24ab <thread_create+0x5d>

        printf(1,"malloc fail \n");
    2490:	c7 44 24 04 82 29 00 	movl   $0x2982,0x4(%esp)
    2497:	00 
    2498:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    249f:	e8 81 fb ff ff       	call   2025 <printf>
        return 0;
    24a4:	b8 00 00 00 00       	mov    $0x0,%eax
    24a9:	eb 6f                	jmp    251a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    24ab:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    24ae:	8b 55 08             	mov    0x8(%ebp),%edx
    24b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24b4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    24b8:	89 54 24 08          	mov    %edx,0x8(%esp)
    24bc:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    24c3:	00 
    24c4:	89 04 24             	mov    %eax,(%esp)
    24c7:	e8 58 fa ff ff       	call   1f24 <clone>
    24cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    24cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24d3:	79 1b                	jns    24f0 <thread_create+0xa2>
        printf(1,"clone fails\n");
    24d5:	c7 44 24 04 90 29 00 	movl   $0x2990,0x4(%esp)
    24dc:	00 
    24dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24e4:	e8 3c fb ff ff       	call   2025 <printf>
        return 0;
    24e9:	b8 00 00 00 00       	mov    $0x0,%eax
    24ee:	eb 2a                	jmp    251a <thread_create+0xcc>
    }
    if(tid > 0){
    24f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24f4:	7e 05                	jle    24fb <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    24f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24f9:	eb 1f                	jmp    251a <thread_create+0xcc>
    }
    if(tid == 0){
    24fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24ff:	75 14                	jne    2515 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    2501:	c7 44 24 04 9d 29 00 	movl   $0x299d,0x4(%esp)
    2508:	00 
    2509:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2510:	e8 10 fb ff ff       	call   2025 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    2515:	b8 00 00 00 00       	mov    $0x0,%eax
}
    251a:	c9                   	leave  
    251b:	c3                   	ret    

0000251c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    251c:	55                   	push   %ebp
    251d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    251f:	a1 c8 29 00 00       	mov    0x29c8,%eax
    2524:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    252a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    252f:	a3 c8 29 00 00       	mov    %eax,0x29c8
    return (int)(rands % max);
    2534:	a1 c8 29 00 00       	mov    0x29c8,%eax
    2539:	8b 4d 08             	mov    0x8(%ebp),%ecx
    253c:	ba 00 00 00 00       	mov    $0x0,%edx
    2541:	f7 f1                	div    %ecx
    2543:	89 d0                	mov    %edx,%eax
}
    2545:	5d                   	pop    %ebp
    2546:	c3                   	ret    
    2547:	90                   	nop

00002548 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    2548:	55                   	push   %ebp
    2549:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    254b:	8b 45 08             	mov    0x8(%ebp),%eax
    254e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2554:	8b 45 08             	mov    0x8(%ebp),%eax
    2557:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    255e:	8b 45 08             	mov    0x8(%ebp),%eax
    2561:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    2568:	5d                   	pop    %ebp
    2569:	c3                   	ret    

0000256a <add_q>:

void add_q(struct queue *q, int v){
    256a:	55                   	push   %ebp
    256b:	89 e5                	mov    %esp,%ebp
    256d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2570:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2577:	e8 8f fd ff ff       	call   230b <malloc>
    257c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    257f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2582:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2589:	8b 45 f4             	mov    -0xc(%ebp),%eax
    258c:	8b 55 0c             	mov    0xc(%ebp),%edx
    258f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2591:	8b 45 08             	mov    0x8(%ebp),%eax
    2594:	8b 40 04             	mov    0x4(%eax),%eax
    2597:	85 c0                	test   %eax,%eax
    2599:	75 0b                	jne    25a6 <add_q+0x3c>
        q->head = n;
    259b:	8b 45 08             	mov    0x8(%ebp),%eax
    259e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    25a1:	89 50 04             	mov    %edx,0x4(%eax)
    25a4:	eb 0c                	jmp    25b2 <add_q+0x48>
    }else{
        q->tail->next = n;
    25a6:	8b 45 08             	mov    0x8(%ebp),%eax
    25a9:	8b 40 08             	mov    0x8(%eax),%eax
    25ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    25af:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    25b2:	8b 45 08             	mov    0x8(%ebp),%eax
    25b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    25b8:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    25bb:	8b 45 08             	mov    0x8(%ebp),%eax
    25be:	8b 00                	mov    (%eax),%eax
    25c0:	8d 50 01             	lea    0x1(%eax),%edx
    25c3:	8b 45 08             	mov    0x8(%ebp),%eax
    25c6:	89 10                	mov    %edx,(%eax)
}
    25c8:	c9                   	leave  
    25c9:	c3                   	ret    

000025ca <empty_q>:

int empty_q(struct queue *q){
    25ca:	55                   	push   %ebp
    25cb:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    25cd:	8b 45 08             	mov    0x8(%ebp),%eax
    25d0:	8b 00                	mov    (%eax),%eax
    25d2:	85 c0                	test   %eax,%eax
    25d4:	75 07                	jne    25dd <empty_q+0x13>
        return 1;
    25d6:	b8 01 00 00 00       	mov    $0x1,%eax
    25db:	eb 05                	jmp    25e2 <empty_q+0x18>
    else
        return 0;
    25dd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    25e2:	5d                   	pop    %ebp
    25e3:	c3                   	ret    

000025e4 <pop_q>:
int pop_q(struct queue *q){
    25e4:	55                   	push   %ebp
    25e5:	89 e5                	mov    %esp,%ebp
    25e7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    25ea:	8b 45 08             	mov    0x8(%ebp),%eax
    25ed:	89 04 24             	mov    %eax,(%esp)
    25f0:	e8 d5 ff ff ff       	call   25ca <empty_q>
    25f5:	85 c0                	test   %eax,%eax
    25f7:	75 5d                	jne    2656 <pop_q+0x72>
       val = q->head->value; 
    25f9:	8b 45 08             	mov    0x8(%ebp),%eax
    25fc:	8b 40 04             	mov    0x4(%eax),%eax
    25ff:	8b 00                	mov    (%eax),%eax
    2601:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    2604:	8b 45 08             	mov    0x8(%ebp),%eax
    2607:	8b 40 04             	mov    0x4(%eax),%eax
    260a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    260d:	8b 45 08             	mov    0x8(%ebp),%eax
    2610:	8b 40 04             	mov    0x4(%eax),%eax
    2613:	8b 50 04             	mov    0x4(%eax),%edx
    2616:	8b 45 08             	mov    0x8(%ebp),%eax
    2619:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    261c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    261f:	89 04 24             	mov    %eax,(%esp)
    2622:	e8 b5 fb ff ff       	call   21dc <free>
       q->size--;
    2627:	8b 45 08             	mov    0x8(%ebp),%eax
    262a:	8b 00                	mov    (%eax),%eax
    262c:	8d 50 ff             	lea    -0x1(%eax),%edx
    262f:	8b 45 08             	mov    0x8(%ebp),%eax
    2632:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    2634:	8b 45 08             	mov    0x8(%ebp),%eax
    2637:	8b 00                	mov    (%eax),%eax
    2639:	85 c0                	test   %eax,%eax
    263b:	75 14                	jne    2651 <pop_q+0x6d>
            q->head = 0;
    263d:	8b 45 08             	mov    0x8(%ebp),%eax
    2640:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    2647:	8b 45 08             	mov    0x8(%ebp),%eax
    264a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2651:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2654:	eb 05                	jmp    265b <pop_q+0x77>
    }
    return -1;
    2656:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    265b:	c9                   	leave  
    265c:	c3                   	ret    
