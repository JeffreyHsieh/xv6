
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
    102f:	e8 d5 12 00 00       	call   2309 <malloc>
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
    10da:	e8 f1 10 00 00       	call   21d0 <free>
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
    117d:	e8 b2 12 00 00       	call   2434 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 82 12 00 00       	call   2414 <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 5d 0d 00 00       	call   1ef4 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 7d 12 00 00       	call   2434 <lock_release>
    tsleep();
    11b7:	e8 68 0d 00 00       	call   1f24 <tsleep>
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
    1202:	e8 2d 12 00 00       	call   2434 <lock_release>
		
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
    122a:	e8 fd 0c 00 00       	call   1f2c <twakeup>
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
    1241:	e8 c3 10 00 00       	call   2309 <malloc>
    1246:	a3 88 2e 00 00       	mov    %eax,0x2e88
	p = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 b2 10 00 00       	call   2309 <malloc>
    1257:	a3 8c 2e 00 00       	mov    %eax,0x2e8c
	d = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 a1 10 00 00       	call   2309 <malloc>
    1268:	a3 90 2e 00 00       	mov    %eax,0x2e90
	sem_init(d, 1);
    126d:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
	sem_init(p, 1);
    1282:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1287:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    128e:	00 
    128f:	89 04 24             	mov    %eax,(%esp)
    1292:	e8 7e fe ff ff       	call   1115 <sem_init>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
    1297:	c7 04 24 60 26 00 00 	movl   $0x2660,(%esp)
    129e:	e8 2a 09 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    12a3:	a1 88 2e 00 00       	mov    0x2e88,%eax
    12a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    12af:	00 
    12b0:	89 04 24             	mov    %eax,(%esp)
    12b3:	e8 5d fe ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 3; colony++){
    12b8:	c7 05 a4 2e 00 00 00 	movl   $0x0,0x2ea4
    12bf:	00 00 00 
    12c2:	eb 40                	jmp    1304 <main+0xd3>
		tid = thread_create(nMonkey, (void *) &arg);
    12c4:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    12cb:	00 
    12cc:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    12d3:	e8 77 11 00 00       	call   244f <thread_create>
    12d8:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
		if(tid <= 0){
    12dd:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    12e2:	85 c0                	test   %eax,%eax
    12e4:	75 11                	jne    12f7 <main+0xc6>
			printAction("Failed to create a thread\n");
    12e6:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    12ed:	e8 db 08 00 00       	call   1bcd <printAction>
			exit();
    12f2:	e8 7d 0b 00 00       	call   1e74 <exit>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 3; colony++){
    12f7:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    12fc:	83 c0 01             	add    $0x1,%eax
    12ff:	a3 a4 2e 00 00       	mov    %eax,0x2ea4
    1304:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    1309:	83 f8 02             	cmp    $0x2,%eax
    130c:	7e b6                	jle    12c4 <main+0x93>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    130e:	90                   	nop
    130f:	e8 68 0b 00 00       	call   1e7c <wait>
    1314:	85 c0                	test   %eax,%eax
    1316:	79 f7                	jns    130f <main+0xde>
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
    1318:	c7 04 24 98 26 00 00 	movl   $0x2698,(%esp)
    131f:	e8 a9 08 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1324:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1329:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1330:	00 
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 dc fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 6; colony++){
    1339:	c7 05 a4 2e 00 00 00 	movl   $0x0,0x2ea4
    1340:	00 00 00 
    1343:	eb 40                	jmp    1385 <main+0x154>
		tid = thread_create(nMonkey, (void *) &arg);
    1345:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    134c:	00 
    134d:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1354:	e8 f6 10 00 00       	call   244f <thread_create>
    1359:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
		if(tid <= 0){
    135e:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1363:	85 c0                	test   %eax,%eax
    1365:	75 11                	jne    1378 <main+0x147>
			printAction("Failed to create a thread\n");
    1367:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    136e:	e8 5a 08 00 00       	call   1bcd <printAction>
			exit();
    1373:	e8 fc 0a 00 00       	call   1e74 <exit>
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 6; colony++){
    1378:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    137d:	83 c0 01             	add    $0x1,%eax
    1380:	a3 a4 2e 00 00       	mov    %eax,0x2ea4
    1385:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    138a:	83 f8 05             	cmp    $0x5,%eax
    138d:	7e b6                	jle    1345 <main+0x114>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    138f:	90                   	nop
    1390:	e8 e7 0a 00 00       	call   1e7c <wait>
    1395:	85 c0                	test   %eax,%eax
    1397:	79 f7                	jns    1390 <main+0x15f>
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
    1399:	c7 04 24 b8 26 00 00 	movl   $0x26b8,(%esp)
    13a0:	e8 28 08 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    13a5:	a1 88 2e 00 00       	mov    0x2e88,%eax
    13aa:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    13b1:	00 
    13b2:	89 04 24             	mov    %eax,(%esp)
    13b5:	e8 5b fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 12; colony++){
    13ba:	c7 05 a4 2e 00 00 00 	movl   $0x0,0x2ea4
    13c1:	00 00 00 
    13c4:	eb 40                	jmp    1406 <main+0x1d5>
		tid = thread_create(nMonkey, (void *) &arg);
    13c6:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    13cd:	00 
    13ce:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    13d5:	e8 75 10 00 00       	call   244f <thread_create>
    13da:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
		if(tid <= 0){
    13df:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    13e4:	85 c0                	test   %eax,%eax
    13e6:	75 11                	jne    13f9 <main+0x1c8>
			printAction("Failed to create a thread\n");
    13e8:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    13ef:	e8 d9 07 00 00       	call   1bcd <printAction>
			exit();
    13f4:	e8 7b 0a 00 00       	call   1e74 <exit>
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 12; colony++){
    13f9:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    13fe:	83 c0 01             	add    $0x1,%eax
    1401:	a3 a4 2e 00 00       	mov    %eax,0x2ea4
    1406:	a1 a4 2e 00 00       	mov    0x2ea4,%eax
    140b:	83 f8 0b             	cmp    $0xb,%eax
    140e:	7e b6                	jle    13c6 <main+0x195>
		if(tid <= 0){
			printAction("Failed to create a thread\n");
			exit();
		}
	}
	while(wait()>= 0);
    1410:	90                   	nop
    1411:	e8 66 0a 00 00       	call   1e7c <wait>
    1416:	85 c0                	test   %eax,%eax
    1418:	79 f7                	jns    1411 <main+0x1e0>
	
	//Test c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N)
	printAction("\nTest c-1: 3 normal monkeys 1 dominant monkey (Thread creation order: D->N->N->N):\n");
    141a:	c7 04 24 d8 26 00 00 	movl   $0x26d8,(%esp)
    1421:	e8 a7 07 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1426:	a1 88 2e 00 00       	mov    0x2e88,%eax
    142b:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1432:	00 
    1433:	89 04 24             	mov    %eax,(%esp)
    1436:	e8 da fc ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    143b:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1442:	00 
    1443:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    144a:	e8 00 10 00 00       	call   244f <thread_create>
    144f:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1454:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1459:	85 c0                	test   %eax,%eax
    145b:	75 11                	jne    146e <main+0x23d>
		printAction("Failed to create a thread\n");
    145d:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1464:	e8 64 07 00 00       	call   1bcd <printAction>
		exit();
    1469:	e8 06 0a 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    146e:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1475:	00 
    1476:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    147d:	e8 cd 0f 00 00       	call   244f <thread_create>
    1482:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1487:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    148c:	85 c0                	test   %eax,%eax
    148e:	75 11                	jne    14a1 <main+0x270>
		printAction("Failed to create a thread\n");
    1490:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1497:	e8 31 07 00 00       	call   1bcd <printAction>
		exit();
    149c:	e8 d3 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14a1:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    14a8:	00 
    14a9:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    14b0:	e8 9a 0f 00 00       	call   244f <thread_create>
    14b5:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    14ba:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    14bf:	85 c0                	test   %eax,%eax
    14c1:	75 11                	jne    14d4 <main+0x2a3>
		printAction("Failed to create a thread\n");
    14c3:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    14ca:	e8 fe 06 00 00       	call   1bcd <printAction>
		exit();
    14cf:	e8 a0 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14d4:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    14db:	00 
    14dc:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    14e3:	e8 67 0f 00 00       	call   244f <thread_create>
    14e8:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    14ed:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    14f2:	85 c0                	test   %eax,%eax
    14f4:	75 11                	jne    1507 <main+0x2d6>
		printAction("Failed to create a thread\n");
    14f6:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    14fd:	e8 cb 06 00 00       	call   1bcd <printAction>
		exit();
    1502:	e8 6d 09 00 00       	call   1e74 <exit>
	}
	while(wait()>= 0);
    1507:	90                   	nop
    1508:	e8 6f 09 00 00       	call   1e7c <wait>
    150d:	85 c0                	test   %eax,%eax
    150f:	79 f7                	jns    1508 <main+0x2d7>
	
	//Test c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D)
	printAction("\nTest c-2: 3 normal monkeys 1 dominant monkey (Thread creation order: N->N->N->D):\n");
    1511:	c7 04 24 2c 27 00 00 	movl   $0x272c,(%esp)
    1518:	e8 b0 06 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    151d:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1522:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1529:	00 
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 e3 fb ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    1532:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1539:	00 
    153a:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1541:	e8 09 0f 00 00       	call   244f <thread_create>
    1546:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    154b:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1550:	85 c0                	test   %eax,%eax
    1552:	75 11                	jne    1565 <main+0x334>
		printAction("Failed to create a thread\n");
    1554:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    155b:	e8 6d 06 00 00       	call   1bcd <printAction>
		exit();
    1560:	e8 0f 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1565:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    156c:	00 
    156d:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1574:	e8 d6 0e 00 00       	call   244f <thread_create>
    1579:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    157e:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1583:	85 c0                	test   %eax,%eax
    1585:	75 11                	jne    1598 <main+0x367>
		printAction("Failed to create a thread\n");
    1587:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    158e:	e8 3a 06 00 00       	call   1bcd <printAction>
		exit();
    1593:	e8 dc 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1598:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    159f:	00 
    15a0:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    15a7:	e8 a3 0e 00 00       	call   244f <thread_create>
    15ac:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    15b1:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    15b6:	85 c0                	test   %eax,%eax
    15b8:	75 11                	jne    15cb <main+0x39a>
		printAction("Failed to create a thread\n");
    15ba:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    15c1:	e8 07 06 00 00       	call   1bcd <printAction>
		exit();
    15c6:	e8 a9 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    15cb:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    15d2:	00 
    15d3:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    15da:	e8 70 0e 00 00       	call   244f <thread_create>
    15df:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    15e4:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    15e9:	85 c0                	test   %eax,%eax
    15eb:	75 11                	jne    15fe <main+0x3cd>
		printAction("Failed to create a thread\n");
    15ed:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    15f4:	e8 d4 05 00 00       	call   1bcd <printAction>
		exit();
    15f9:	e8 76 08 00 00       	call   1e74 <exit>
	}
	while(wait()>= 0);
    15fe:	90                   	nop
    15ff:	e8 78 08 00 00       	call   1e7c <wait>
    1604:	85 c0                	test   %eax,%eax
    1606:	79 f7                	jns    15ff <main+0x3ce>
	
	//Test c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N)
	printAction("\nTest c-3: 4 normal monkeys 2 dominant monkey (Thread creation order: N->N->D->N->D->N):\n");
    1608:	c7 04 24 80 27 00 00 	movl   $0x2780,(%esp)
    160f:	e8 b9 05 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1614:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1619:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1620:	00 
    1621:	89 04 24             	mov    %eax,(%esp)
    1624:	e8 ec fa ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    1629:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1630:	00 
    1631:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1638:	e8 12 0e 00 00       	call   244f <thread_create>
    163d:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1642:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1647:	85 c0                	test   %eax,%eax
    1649:	75 11                	jne    165c <main+0x42b>
		printAction("Failed to create a thread\n");
    164b:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1652:	e8 76 05 00 00       	call   1bcd <printAction>
		exit();
    1657:	e8 18 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    165c:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1663:	00 
    1664:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    166b:	e8 df 0d 00 00       	call   244f <thread_create>
    1670:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1675:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    167a:	85 c0                	test   %eax,%eax
    167c:	75 11                	jne    168f <main+0x45e>
		printAction("Failed to create a thread\n");
    167e:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1685:	e8 43 05 00 00       	call   1bcd <printAction>
		exit();
    168a:	e8 e5 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    168f:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1696:	00 
    1697:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    169e:	e8 ac 0d 00 00       	call   244f <thread_create>
    16a3:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    16a8:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    16ad:	85 c0                	test   %eax,%eax
    16af:	75 11                	jne    16c2 <main+0x491>
		printAction("Failed to create a thread\n");
    16b1:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    16b8:	e8 10 05 00 00       	call   1bcd <printAction>
		exit();
    16bd:	e8 b2 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    16c2:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    16c9:	00 
    16ca:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    16d1:	e8 79 0d 00 00       	call   244f <thread_create>
    16d6:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    16db:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    16e0:	85 c0                	test   %eax,%eax
    16e2:	75 11                	jne    16f5 <main+0x4c4>
		printAction("Failed to create a thread\n");
    16e4:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    16eb:	e8 dd 04 00 00       	call   1bcd <printAction>
		exit();
    16f0:	e8 7f 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    16f5:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    16fc:	00 
    16fd:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1704:	e8 46 0d 00 00       	call   244f <thread_create>
    1709:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    170e:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1713:	85 c0                	test   %eax,%eax
    1715:	75 11                	jne    1728 <main+0x4f7>
		printAction("Failed to create a thread\n");
    1717:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    171e:	e8 aa 04 00 00       	call   1bcd <printAction>
		exit();
    1723:	e8 4c 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1728:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    172f:	00 
    1730:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1737:	e8 13 0d 00 00       	call   244f <thread_create>
    173c:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1741:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1746:	85 c0                	test   %eax,%eax
    1748:	75 11                	jne    175b <main+0x52a>
		printAction("Failed to create a thread\n");
    174a:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1751:	e8 77 04 00 00       	call   1bcd <printAction>
		exit();
    1756:	e8 19 07 00 00       	call   1e74 <exit>
	}
	while(wait()>= 0);
    175b:	90                   	nop
    175c:	e8 1b 07 00 00       	call   1e7c <wait>
    1761:	85 c0                	test   %eax,%eax
    1763:	79 f7                	jns    175c <main+0x52b>
	
	//Test c-4: 2 normal monkeys 3 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-4: 2 normal monkeys 4 dominant monkey (Thread creation order: D->D->D->N->N->D):\n");
    1765:	c7 04 24 dc 27 00 00 	movl   $0x27dc,(%esp)
    176c:	e8 5c 04 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1771:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1776:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    177d:	00 
    177e:	89 04 24             	mov    %eax,(%esp)
    1781:	e8 8f f9 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    1786:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    178d:	00 
    178e:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1795:	e8 b5 0c 00 00       	call   244f <thread_create>
    179a:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    179f:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    17a4:	85 c0                	test   %eax,%eax
    17a6:	75 11                	jne    17b9 <main+0x588>
		printAction("Failed to create a thread\n");
    17a8:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    17af:	e8 19 04 00 00       	call   1bcd <printAction>
		exit();
    17b4:	e8 bb 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17b9:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    17c0:	00 
    17c1:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    17c8:	e8 82 0c 00 00       	call   244f <thread_create>
    17cd:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    17d2:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    17d7:	85 c0                	test   %eax,%eax
    17d9:	75 11                	jne    17ec <main+0x5bb>
		printAction("Failed to create a thread\n");
    17db:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    17e2:	e8 e6 03 00 00       	call   1bcd <printAction>
		exit();
    17e7:	e8 88 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17ec:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    17f3:	00 
    17f4:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    17fb:	e8 4f 0c 00 00       	call   244f <thread_create>
    1800:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1805:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    180a:	85 c0                	test   %eax,%eax
    180c:	75 11                	jne    181f <main+0x5ee>
		printAction("Failed to create a thread\n");
    180e:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1815:	e8 b3 03 00 00       	call   1bcd <printAction>
		exit();
    181a:	e8 55 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    181f:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1826:	00 
    1827:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    182e:	e8 1c 0c 00 00       	call   244f <thread_create>
    1833:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1838:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    183d:	85 c0                	test   %eax,%eax
    183f:	75 11                	jne    1852 <main+0x621>
		printAction("Failed to create a thread\n");
    1841:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1848:	e8 80 03 00 00       	call   1bcd <printAction>
		exit();
    184d:	e8 22 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1852:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1859:	00 
    185a:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1861:	e8 e9 0b 00 00       	call   244f <thread_create>
    1866:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    186b:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1870:	85 c0                	test   %eax,%eax
    1872:	75 11                	jne    1885 <main+0x654>
		printAction("Failed to create a thread\n");
    1874:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    187b:	e8 4d 03 00 00       	call   1bcd <printAction>
		exit();
    1880:	e8 ef 05 00 00       	call   1e74 <exit>
	}

	tid = thread_create(dMonkey, (void *) &arg);
    1885:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    188c:	00 
    188d:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1894:	e8 b6 0b 00 00       	call   244f <thread_create>
    1899:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    189e:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    18a3:	85 c0                	test   %eax,%eax
    18a5:	75 11                	jne    18b8 <main+0x687>
		printAction("Failed to create a thread\n");
    18a7:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    18ae:	e8 1a 03 00 00       	call   1bcd <printAction>
		exit();
    18b3:	e8 bc 05 00 00       	call   1e74 <exit>
	}
	while(wait()>= 0);
    18b8:	90                   	nop
    18b9:	e8 be 05 00 00       	call   1e7c <wait>
    18be:	85 c0                	test   %eax,%eax
    18c0:	79 f7                	jns    18b9 <main+0x688>
	
	//Test c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->D->D->N->N->D)
	printAction("\nTest c-5: 1 normal monkeys 5 dominant monkey (Thread creation order: D->N->D->D->D->D):\n");
    18c2:	c7 04 24 38 28 00 00 	movl   $0x2838,(%esp)
    18c9:	e8 ff 02 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    18ce:	a1 88 2e 00 00       	mov    0x2e88,%eax
    18d3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    18da:	00 
    18db:	89 04 24             	mov    %eax,(%esp)
    18de:	e8 32 f8 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    18e3:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    18ea:	00 
    18eb:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    18f2:	e8 58 0b 00 00       	call   244f <thread_create>
    18f7:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    18fc:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1901:	85 c0                	test   %eax,%eax
    1903:	75 11                	jne    1916 <main+0x6e5>
		printAction("Failed to create a thread\n");
    1905:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    190c:	e8 bc 02 00 00       	call   1bcd <printAction>
		exit();
    1911:	e8 5e 05 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1916:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    191d:	00 
    191e:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1925:	e8 25 0b 00 00       	call   244f <thread_create>
    192a:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    192f:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1934:	85 c0                	test   %eax,%eax
    1936:	75 11                	jne    1949 <main+0x718>
		printAction("Failed to create a thread\n");
    1938:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    193f:	e8 89 02 00 00       	call   1bcd <printAction>
		exit();
    1944:	e8 2b 05 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    1949:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1950:	00 
    1951:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1958:	e8 f2 0a 00 00       	call   244f <thread_create>
    195d:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1962:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1967:	85 c0                	test   %eax,%eax
    1969:	75 11                	jne    197c <main+0x74b>
		printAction("Failed to create a thread\n");
    196b:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1972:	e8 56 02 00 00       	call   1bcd <printAction>
		exit();
    1977:	e8 f8 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    197c:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    1983:	00 
    1984:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    198b:	e8 bf 0a 00 00       	call   244f <thread_create>
    1990:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    1995:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    199a:	85 c0                	test   %eax,%eax
    199c:	75 11                	jne    19af <main+0x77e>
		printAction("Failed to create a thread\n");
    199e:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    19a5:	e8 23 02 00 00       	call   1bcd <printAction>
		exit();
    19aa:	e8 c5 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19af:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    19b6:	00 
    19b7:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    19be:	e8 8c 0a 00 00       	call   244f <thread_create>
    19c3:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    19c8:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    19cd:	85 c0                	test   %eax,%eax
    19cf:	75 11                	jne    19e2 <main+0x7b1>
		printAction("Failed to create a thread\n");
    19d1:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    19d8:	e8 f0 01 00 00       	call   1bcd <printAction>
		exit();
    19dd:	e8 92 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19e2:	c7 44 24 04 6c 2e 00 	movl   $0x2e6c,0x4(%esp)
    19e9:	00 
    19ea:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    19f1:	e8 59 0a 00 00       	call   244f <thread_create>
    19f6:	a3 a8 2e 00 00       	mov    %eax,0x2ea8
	if(tid <= 0){
    19fb:	a1 a8 2e 00 00       	mov    0x2ea8,%eax
    1a00:	85 c0                	test   %eax,%eax
    1a02:	75 11                	jne    1a15 <main+0x7e4>
		printAction("Failed to create a thread\n");
    1a04:	c7 04 24 7d 26 00 00 	movl   $0x267d,(%esp)
    1a0b:	e8 bd 01 00 00       	call   1bcd <printAction>
		exit();
    1a10:	e8 5f 04 00 00       	call   1e74 <exit>
	}
	while(wait()>= 0);
    1a15:	90                   	nop
    1a16:	e8 61 04 00 00       	call   1e7c <wait>
    1a1b:	85 c0                	test   %eax,%eax
    1a1d:	79 f7                	jns    1a16 <main+0x7e5>
	exit();
    1a1f:	e8 50 04 00 00       	call   1e74 <exit>

00001a24 <nMonkey>:
	return 0;
}

void nMonkey(){
    1a24:	55                   	push   %ebp
    1a25:	89 e5                	mov    %esp,%ebp
    1a27:	83 ec 28             	sub    $0x28,%esp
	sem_acquire(d);
    1a2a:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1a2f:	89 04 24             	mov    %eax,(%esp)
    1a32:	e8 13 f7 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1a37:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1a3c:	89 04 24             	mov    %eax,(%esp)
    1a3f:	e8 85 f7 ff ff       	call   11c9 <sem_signal>
	printAction("Normal monkey begins climbing\n");
    1a44:	c7 04 24 94 28 00 00 	movl   $0x2894,(%esp)
    1a4b:	e8 7d 01 00 00       	call   1bcd <printAction>
	
	int i;
	for(i = 0; i < 2999999; i++){
    1a50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a57:	eb 20                	jmp    1a79 <nMonkey+0x55>
		if(domClimbing > 0){
    1a59:	a1 94 2e 00 00       	mov    0x2e94,%eax
    1a5e:	85 c0                	test   %eax,%eax
    1a60:	7e 13                	jle    1a75 <nMonkey+0x51>
			printAction("Normal monkey waits\n");
    1a62:	c7 04 24 b3 28 00 00 	movl   $0x28b3,(%esp)
    1a69:	e8 5f 01 00 00       	call   1bcd <printAction>
			i = 29999999;
    1a6e:	c7 45 f4 7f c3 c9 01 	movl   $0x1c9c37f,-0xc(%ebp)
	sem_acquire(d);
	sem_signal(d);
	printAction("Normal monkey begins climbing\n");
	
	int i;
	for(i = 0; i < 2999999; i++){
    1a75:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a79:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1a80:	7e d7                	jle    1a59 <nMonkey+0x35>
			printAction("Normal monkey waits\n");
			i = 29999999;
		}
	}
	
	sem_acquire(d);
    1a82:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1a87:	89 04 24             	mov    %eax,(%esp)
    1a8a:	e8 bb f6 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1a8f:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1a94:	89 04 24             	mov    %eax,(%esp)
    1a97:	e8 2d f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(tree);
    1a9c:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1aa1:	89 04 24             	mov    %eax,(%esp)
    1aa4:	e8 a1 f6 ff ff       	call   114a <sem_acquire>
	printAction("Normal monkey acquires coconut (Semaphore)\n");
    1aa9:	c7 04 24 c8 28 00 00 	movl   $0x28c8,(%esp)
    1ab0:	e8 18 01 00 00       	call   1bcd <printAction>
	
	for(i = 0; i < 2999999; i++);
    1ab5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1abc:	eb 04                	jmp    1ac2 <nMonkey+0x9e>
    1abe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ac2:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1ac9:	7e f3                	jle    1abe <nMonkey+0x9a>
	
	printAction("Normal monkey descends\n");
    1acb:	c7 04 24 f4 28 00 00 	movl   $0x28f4,(%esp)
    1ad2:	e8 f6 00 00 00       	call   1bcd <printAction>

	sem_signal(tree);
    1ad7:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1adc:	89 04 24             	mov    %eax,(%esp)
    1adf:	e8 e5 f6 ff ff       	call   11c9 <sem_signal>
	
	texit();
    1ae4:	e8 33 04 00 00       	call   1f1c <texit>

00001ae9 <dMonkey>:
}

void dMonkey(){
    1ae9:	55                   	push   %ebp
    1aea:	89 e5                	mov    %esp,%ebp
    1aec:	83 ec 28             	sub    $0x28,%esp
	sem_acquire(d);
    1aef:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1af4:	89 04 24             	mov    %eax,(%esp)
    1af7:	e8 4e f6 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey begins climbing\n");
    1afc:	c7 04 24 0c 29 00 00 	movl   $0x290c,(%esp)
    1b03:	e8 c5 00 00 00       	call   1bcd <printAction>
	sem_acquire(p);
    1b08:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1b0d:	89 04 24             	mov    %eax,(%esp)
    1b10:	e8 35 f6 ff ff       	call   114a <sem_acquire>
	domClimbing++;
    1b15:	a1 94 2e 00 00       	mov    0x2e94,%eax
    1b1a:	83 c0 01             	add    $0x1,%eax
    1b1d:	a3 94 2e 00 00       	mov    %eax,0x2e94
	sem_signal(p);
    1b22:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1b27:	89 04 24             	mov    %eax,(%esp)
    1b2a:	e8 9a f6 ff ff       	call   11c9 <sem_signal>

	int i = 0;
    1b2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(i = 0; i < 2999999; i++);
    1b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b3d:	eb 04                	jmp    1b43 <dMonkey+0x5a>
    1b3f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b43:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1b4a:	7e f3                	jle    1b3f <dMonkey+0x56>

	sem_acquire(tree);
    1b4c:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1b51:	89 04 24             	mov    %eax,(%esp)
    1b54:	e8 f1 f5 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey acquires coconut (Semaphore)\n");
    1b59:	c7 04 24 30 29 00 00 	movl   $0x2930,(%esp)
    1b60:	e8 68 00 00 00       	call   1bcd <printAction>
	sem_acquire(p);
    1b65:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1b6a:	89 04 24             	mov    %eax,(%esp)
    1b6d:	e8 d8 f5 ff ff       	call   114a <sem_acquire>
	domClimbing--;
    1b72:	a1 94 2e 00 00       	mov    0x2e94,%eax
    1b77:	83 e8 01             	sub    $0x1,%eax
    1b7a:	a3 94 2e 00 00       	mov    %eax,0x2e94
	sem_signal(p);
    1b7f:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1b84:	89 04 24             	mov    %eax,(%esp)
    1b87:	e8 3d f6 ff ff       	call   11c9 <sem_signal>
	sem_signal(d);
    1b8c:	a1 90 2e 00 00       	mov    0x2e90,%eax
    1b91:	89 04 24             	mov    %eax,(%esp)
    1b94:	e8 30 f6 ff ff       	call   11c9 <sem_signal>

	for(i = 0; i < 2999999; i++);
    1b99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ba0:	eb 04                	jmp    1ba6 <dMonkey+0xbd>
    1ba2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ba6:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1bad:	7e f3                	jle    1ba2 <dMonkey+0xb9>
	
	printAction("Dominant monkey descends\n");
    1baf:	c7 04 24 5e 29 00 00 	movl   $0x295e,(%esp)
    1bb6:	e8 12 00 00 00       	call   1bcd <printAction>
	
	sem_signal(tree);
    1bbb:	a1 88 2e 00 00       	mov    0x2e88,%eax
    1bc0:	89 04 24             	mov    %eax,(%esp)
    1bc3:	e8 01 f6 ff ff       	call   11c9 <sem_signal>
	
	texit();
    1bc8:	e8 4f 03 00 00       	call   1f1c <texit>

00001bcd <printAction>:
}

void printAction(char a[]){
    1bcd:	55                   	push   %ebp
    1bce:	89 e5                	mov    %esp,%ebp
    1bd0:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1bd3:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1bd8:	89 04 24             	mov    %eax,(%esp)
    1bdb:	e8 6a f5 ff ff       	call   114a <sem_acquire>
	printf(1, "%s", a);
    1be0:	8b 45 08             	mov    0x8(%ebp),%eax
    1be3:	89 44 24 08          	mov    %eax,0x8(%esp)
    1be7:	c7 44 24 04 78 29 00 	movl   $0x2978,0x4(%esp)
    1bee:	00 
    1bef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bf6:	e8 21 04 00 00       	call   201c <printf>
	sem_signal(p);
    1bfb:	a1 8c 2e 00 00       	mov    0x2e8c,%eax
    1c00:	89 04 24             	mov    %eax,(%esp)
    1c03:	e8 c1 f5 ff ff       	call   11c9 <sem_signal>
}
    1c08:	c9                   	leave  
    1c09:	c3                   	ret    
    1c0a:	66 90                	xchg   %ax,%ax

00001c0c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1c0c:	55                   	push   %ebp
    1c0d:	89 e5                	mov    %esp,%ebp
    1c0f:	57                   	push   %edi
    1c10:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1c11:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c14:	8b 55 10             	mov    0x10(%ebp),%edx
    1c17:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c1a:	89 cb                	mov    %ecx,%ebx
    1c1c:	89 df                	mov    %ebx,%edi
    1c1e:	89 d1                	mov    %edx,%ecx
    1c20:	fc                   	cld    
    1c21:	f3 aa                	rep stos %al,%es:(%edi)
    1c23:	89 ca                	mov    %ecx,%edx
    1c25:	89 fb                	mov    %edi,%ebx
    1c27:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1c2a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1c2d:	5b                   	pop    %ebx
    1c2e:	5f                   	pop    %edi
    1c2f:	5d                   	pop    %ebp
    1c30:	c3                   	ret    

00001c31 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1c31:	55                   	push   %ebp
    1c32:	89 e5                	mov    %esp,%ebp
    1c34:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1c37:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1c3d:	90                   	nop
    1c3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c41:	8d 50 01             	lea    0x1(%eax),%edx
    1c44:	89 55 08             	mov    %edx,0x8(%ebp)
    1c47:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c4a:	8d 4a 01             	lea    0x1(%edx),%ecx
    1c4d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1c50:	0f b6 12             	movzbl (%edx),%edx
    1c53:	88 10                	mov    %dl,(%eax)
    1c55:	0f b6 00             	movzbl (%eax),%eax
    1c58:	84 c0                	test   %al,%al
    1c5a:	75 e2                	jne    1c3e <strcpy+0xd>
    ;
  return os;
    1c5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c5f:	c9                   	leave  
    1c60:	c3                   	ret    

00001c61 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1c61:	55                   	push   %ebp
    1c62:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1c64:	eb 08                	jmp    1c6e <strcmp+0xd>
    p++, q++;
    1c66:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c6a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c71:	0f b6 00             	movzbl (%eax),%eax
    1c74:	84 c0                	test   %al,%al
    1c76:	74 10                	je     1c88 <strcmp+0x27>
    1c78:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7b:	0f b6 10             	movzbl (%eax),%edx
    1c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c81:	0f b6 00             	movzbl (%eax),%eax
    1c84:	38 c2                	cmp    %al,%dl
    1c86:	74 de                	je     1c66 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1c88:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8b:	0f b6 00             	movzbl (%eax),%eax
    1c8e:	0f b6 d0             	movzbl %al,%edx
    1c91:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c94:	0f b6 00             	movzbl (%eax),%eax
    1c97:	0f b6 c0             	movzbl %al,%eax
    1c9a:	29 c2                	sub    %eax,%edx
    1c9c:	89 d0                	mov    %edx,%eax
}
    1c9e:	5d                   	pop    %ebp
    1c9f:	c3                   	ret    

00001ca0 <strlen>:

uint
strlen(char *s)
{
    1ca0:	55                   	push   %ebp
    1ca1:	89 e5                	mov    %esp,%ebp
    1ca3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1ca6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1cad:	eb 04                	jmp    1cb3 <strlen+0x13>
    1caf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1cb3:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	01 d0                	add    %edx,%eax
    1cbb:	0f b6 00             	movzbl (%eax),%eax
    1cbe:	84 c0                	test   %al,%al
    1cc0:	75 ed                	jne    1caf <strlen+0xf>
    ;
  return n;
    1cc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1cc5:	c9                   	leave  
    1cc6:	c3                   	ret    

00001cc7 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1cc7:	55                   	push   %ebp
    1cc8:	89 e5                	mov    %esp,%ebp
    1cca:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1ccd:	8b 45 10             	mov    0x10(%ebp),%eax
    1cd0:	89 44 24 08          	mov    %eax,0x8(%esp)
    1cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cd7:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cde:	89 04 24             	mov    %eax,(%esp)
    1ce1:	e8 26 ff ff ff       	call   1c0c <stosb>
  return dst;
    1ce6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1ce9:	c9                   	leave  
    1cea:	c3                   	ret    

00001ceb <strchr>:

char*
strchr(const char *s, char c)
{
    1ceb:	55                   	push   %ebp
    1cec:	89 e5                	mov    %esp,%ebp
    1cee:	83 ec 04             	sub    $0x4,%esp
    1cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cf4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1cf7:	eb 14                	jmp    1d0d <strchr+0x22>
    if(*s == c)
    1cf9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfc:	0f b6 00             	movzbl (%eax),%eax
    1cff:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1d02:	75 05                	jne    1d09 <strchr+0x1e>
      return (char*)s;
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	eb 13                	jmp    1d1c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1d09:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1d0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d10:	0f b6 00             	movzbl (%eax),%eax
    1d13:	84 c0                	test   %al,%al
    1d15:	75 e2                	jne    1cf9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1d17:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d1c:	c9                   	leave  
    1d1d:	c3                   	ret    

00001d1e <gets>:

char*
gets(char *buf, int max)
{
    1d1e:	55                   	push   %ebp
    1d1f:	89 e5                	mov    %esp,%ebp
    1d21:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d2b:	eb 4c                	jmp    1d79 <gets+0x5b>
    cc = read(0, &c, 1);
    1d2d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1d34:	00 
    1d35:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1d38:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d3c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d43:	e8 44 01 00 00       	call   1e8c <read>
    1d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1d4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d4f:	7f 02                	jg     1d53 <gets+0x35>
      break;
    1d51:	eb 31                	jmp    1d84 <gets+0x66>
    buf[i++] = c;
    1d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d56:	8d 50 01             	lea    0x1(%eax),%edx
    1d59:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1d5c:	89 c2                	mov    %eax,%edx
    1d5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d61:	01 c2                	add    %eax,%edx
    1d63:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d67:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1d69:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d6d:	3c 0a                	cmp    $0xa,%al
    1d6f:	74 13                	je     1d84 <gets+0x66>
    1d71:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d75:	3c 0d                	cmp    $0xd,%al
    1d77:	74 0b                	je     1d84 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d7c:	83 c0 01             	add    $0x1,%eax
    1d7f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d82:	7c a9                	jl     1d2d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1d84:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d87:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8a:	01 d0                	add    %edx,%eax
    1d8c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1d8f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1d92:	c9                   	leave  
    1d93:	c3                   	ret    

00001d94 <stat>:

int
stat(char *n, struct stat *st)
{
    1d94:	55                   	push   %ebp
    1d95:	89 e5                	mov    %esp,%ebp
    1d97:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1d9a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1da1:	00 
    1da2:	8b 45 08             	mov    0x8(%ebp),%eax
    1da5:	89 04 24             	mov    %eax,(%esp)
    1da8:	e8 07 01 00 00       	call   1eb4 <open>
    1dad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1db0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1db4:	79 07                	jns    1dbd <stat+0x29>
    return -1;
    1db6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1dbb:	eb 23                	jmp    1de0 <stat+0x4c>
  r = fstat(fd, st);
    1dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dc0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc7:	89 04 24             	mov    %eax,(%esp)
    1dca:	e8 fd 00 00 00       	call   1ecc <fstat>
    1dcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1dd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd5:	89 04 24             	mov    %eax,(%esp)
    1dd8:	e8 bf 00 00 00       	call   1e9c <close>
  return r;
    1ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1de0:	c9                   	leave  
    1de1:	c3                   	ret    

00001de2 <atoi>:

int
atoi(const char *s)
{
    1de2:	55                   	push   %ebp
    1de3:	89 e5                	mov    %esp,%ebp
    1de5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1de8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1def:	eb 25                	jmp    1e16 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1df1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1df4:	89 d0                	mov    %edx,%eax
    1df6:	c1 e0 02             	shl    $0x2,%eax
    1df9:	01 d0                	add    %edx,%eax
    1dfb:	01 c0                	add    %eax,%eax
    1dfd:	89 c1                	mov    %eax,%ecx
    1dff:	8b 45 08             	mov    0x8(%ebp),%eax
    1e02:	8d 50 01             	lea    0x1(%eax),%edx
    1e05:	89 55 08             	mov    %edx,0x8(%ebp)
    1e08:	0f b6 00             	movzbl (%eax),%eax
    1e0b:	0f be c0             	movsbl %al,%eax
    1e0e:	01 c8                	add    %ecx,%eax
    1e10:	83 e8 30             	sub    $0x30,%eax
    1e13:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1e16:	8b 45 08             	mov    0x8(%ebp),%eax
    1e19:	0f b6 00             	movzbl (%eax),%eax
    1e1c:	3c 2f                	cmp    $0x2f,%al
    1e1e:	7e 0a                	jle    1e2a <atoi+0x48>
    1e20:	8b 45 08             	mov    0x8(%ebp),%eax
    1e23:	0f b6 00             	movzbl (%eax),%eax
    1e26:	3c 39                	cmp    $0x39,%al
    1e28:	7e c7                	jle    1df1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1e2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1e2d:	c9                   	leave  
    1e2e:	c3                   	ret    

00001e2f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1e2f:	55                   	push   %ebp
    1e30:	89 e5                	mov    %esp,%ebp
    1e32:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1e35:	8b 45 08             	mov    0x8(%ebp),%eax
    1e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1e41:	eb 17                	jmp    1e5a <memmove+0x2b>
    *dst++ = *src++;
    1e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1e46:	8d 50 01             	lea    0x1(%eax),%edx
    1e49:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1e4c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1e4f:	8d 4a 01             	lea    0x1(%edx),%ecx
    1e52:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1e55:	0f b6 12             	movzbl (%edx),%edx
    1e58:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e5a:	8b 45 10             	mov    0x10(%ebp),%eax
    1e5d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e60:	89 55 10             	mov    %edx,0x10(%ebp)
    1e63:	85 c0                	test   %eax,%eax
    1e65:	7f dc                	jg     1e43 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1e67:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1e6a:	c9                   	leave  
    1e6b:	c3                   	ret    

00001e6c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1e6c:	b8 01 00 00 00       	mov    $0x1,%eax
    1e71:	cd 40                	int    $0x40
    1e73:	c3                   	ret    

00001e74 <exit>:
SYSCALL(exit)
    1e74:	b8 02 00 00 00       	mov    $0x2,%eax
    1e79:	cd 40                	int    $0x40
    1e7b:	c3                   	ret    

00001e7c <wait>:
SYSCALL(wait)
    1e7c:	b8 03 00 00 00       	mov    $0x3,%eax
    1e81:	cd 40                	int    $0x40
    1e83:	c3                   	ret    

00001e84 <pipe>:
SYSCALL(pipe)
    1e84:	b8 04 00 00 00       	mov    $0x4,%eax
    1e89:	cd 40                	int    $0x40
    1e8b:	c3                   	ret    

00001e8c <read>:
SYSCALL(read)
    1e8c:	b8 05 00 00 00       	mov    $0x5,%eax
    1e91:	cd 40                	int    $0x40
    1e93:	c3                   	ret    

00001e94 <write>:
SYSCALL(write)
    1e94:	b8 10 00 00 00       	mov    $0x10,%eax
    1e99:	cd 40                	int    $0x40
    1e9b:	c3                   	ret    

00001e9c <close>:
SYSCALL(close)
    1e9c:	b8 15 00 00 00       	mov    $0x15,%eax
    1ea1:	cd 40                	int    $0x40
    1ea3:	c3                   	ret    

00001ea4 <kill>:
SYSCALL(kill)
    1ea4:	b8 06 00 00 00       	mov    $0x6,%eax
    1ea9:	cd 40                	int    $0x40
    1eab:	c3                   	ret    

00001eac <exec>:
SYSCALL(exec)
    1eac:	b8 07 00 00 00       	mov    $0x7,%eax
    1eb1:	cd 40                	int    $0x40
    1eb3:	c3                   	ret    

00001eb4 <open>:
SYSCALL(open)
    1eb4:	b8 0f 00 00 00       	mov    $0xf,%eax
    1eb9:	cd 40                	int    $0x40
    1ebb:	c3                   	ret    

00001ebc <mknod>:
SYSCALL(mknod)
    1ebc:	b8 11 00 00 00       	mov    $0x11,%eax
    1ec1:	cd 40                	int    $0x40
    1ec3:	c3                   	ret    

00001ec4 <unlink>:
SYSCALL(unlink)
    1ec4:	b8 12 00 00 00       	mov    $0x12,%eax
    1ec9:	cd 40                	int    $0x40
    1ecb:	c3                   	ret    

00001ecc <fstat>:
SYSCALL(fstat)
    1ecc:	b8 08 00 00 00       	mov    $0x8,%eax
    1ed1:	cd 40                	int    $0x40
    1ed3:	c3                   	ret    

00001ed4 <link>:
SYSCALL(link)
    1ed4:	b8 13 00 00 00       	mov    $0x13,%eax
    1ed9:	cd 40                	int    $0x40
    1edb:	c3                   	ret    

00001edc <mkdir>:
SYSCALL(mkdir)
    1edc:	b8 14 00 00 00       	mov    $0x14,%eax
    1ee1:	cd 40                	int    $0x40
    1ee3:	c3                   	ret    

00001ee4 <chdir>:
SYSCALL(chdir)
    1ee4:	b8 09 00 00 00       	mov    $0x9,%eax
    1ee9:	cd 40                	int    $0x40
    1eeb:	c3                   	ret    

00001eec <dup>:
SYSCALL(dup)
    1eec:	b8 0a 00 00 00       	mov    $0xa,%eax
    1ef1:	cd 40                	int    $0x40
    1ef3:	c3                   	ret    

00001ef4 <getpid>:
SYSCALL(getpid)
    1ef4:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ef9:	cd 40                	int    $0x40
    1efb:	c3                   	ret    

00001efc <sbrk>:
SYSCALL(sbrk)
    1efc:	b8 0c 00 00 00       	mov    $0xc,%eax
    1f01:	cd 40                	int    $0x40
    1f03:	c3                   	ret    

00001f04 <sleep>:
SYSCALL(sleep)
    1f04:	b8 0d 00 00 00       	mov    $0xd,%eax
    1f09:	cd 40                	int    $0x40
    1f0b:	c3                   	ret    

00001f0c <uptime>:
SYSCALL(uptime)
    1f0c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1f11:	cd 40                	int    $0x40
    1f13:	c3                   	ret    

00001f14 <clone>:
SYSCALL(clone)
    1f14:	b8 16 00 00 00       	mov    $0x16,%eax
    1f19:	cd 40                	int    $0x40
    1f1b:	c3                   	ret    

00001f1c <texit>:
SYSCALL(texit)
    1f1c:	b8 17 00 00 00       	mov    $0x17,%eax
    1f21:	cd 40                	int    $0x40
    1f23:	c3                   	ret    

00001f24 <tsleep>:
SYSCALL(tsleep)
    1f24:	b8 18 00 00 00       	mov    $0x18,%eax
    1f29:	cd 40                	int    $0x40
    1f2b:	c3                   	ret    

00001f2c <twakeup>:
SYSCALL(twakeup)
    1f2c:	b8 19 00 00 00       	mov    $0x19,%eax
    1f31:	cd 40                	int    $0x40
    1f33:	c3                   	ret    

00001f34 <thread_yield>:
SYSCALL(thread_yield)
    1f34:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1f39:	cd 40                	int    $0x40
    1f3b:	c3                   	ret    

00001f3c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1f3c:	55                   	push   %ebp
    1f3d:	89 e5                	mov    %esp,%ebp
    1f3f:	83 ec 18             	sub    $0x18,%esp
    1f42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f45:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f48:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f4f:	00 
    1f50:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f53:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f57:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5a:	89 04 24             	mov    %eax,(%esp)
    1f5d:	e8 32 ff ff ff       	call   1e94 <write>
}
    1f62:	c9                   	leave  
    1f63:	c3                   	ret    

00001f64 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f64:	55                   	push   %ebp
    1f65:	89 e5                	mov    %esp,%ebp
    1f67:	56                   	push   %esi
    1f68:	53                   	push   %ebx
    1f69:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f6c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f73:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f77:	74 17                	je     1f90 <printint+0x2c>
    1f79:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f7d:	79 11                	jns    1f90 <printint+0x2c>
    neg = 1;
    1f7f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f86:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f89:	f7 d8                	neg    %eax
    1f8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f8e:	eb 06                	jmp    1f96 <printint+0x32>
  } else {
    x = xx;
    1f90:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1f96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1f9d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1fa0:	8d 41 01             	lea    0x1(%ecx),%eax
    1fa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1fa6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1fa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fac:	ba 00 00 00 00       	mov    $0x0,%edx
    1fb1:	f7 f3                	div    %ebx
    1fb3:	89 d0                	mov    %edx,%eax
    1fb5:	0f b6 80 70 2e 00 00 	movzbl 0x2e70(%eax),%eax
    1fbc:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1fc0:	8b 75 10             	mov    0x10(%ebp),%esi
    1fc3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fc6:	ba 00 00 00 00       	mov    $0x0,%edx
    1fcb:	f7 f6                	div    %esi
    1fcd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1fd0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fd4:	75 c7                	jne    1f9d <printint+0x39>
  if(neg)
    1fd6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fda:	74 10                	je     1fec <printint+0x88>
    buf[i++] = '-';
    1fdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fdf:	8d 50 01             	lea    0x1(%eax),%edx
    1fe2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1fe5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1fea:	eb 1f                	jmp    200b <printint+0xa7>
    1fec:	eb 1d                	jmp    200b <printint+0xa7>
    putc(fd, buf[i]);
    1fee:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ff4:	01 d0                	add    %edx,%eax
    1ff6:	0f b6 00             	movzbl (%eax),%eax
    1ff9:	0f be c0             	movsbl %al,%eax
    1ffc:	89 44 24 04          	mov    %eax,0x4(%esp)
    2000:	8b 45 08             	mov    0x8(%ebp),%eax
    2003:	89 04 24             	mov    %eax,(%esp)
    2006:	e8 31 ff ff ff       	call   1f3c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    200b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    200f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2013:	79 d9                	jns    1fee <printint+0x8a>
    putc(fd, buf[i]);
}
    2015:	83 c4 30             	add    $0x30,%esp
    2018:	5b                   	pop    %ebx
    2019:	5e                   	pop    %esi
    201a:	5d                   	pop    %ebp
    201b:	c3                   	ret    

0000201c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    201c:	55                   	push   %ebp
    201d:	89 e5                	mov    %esp,%ebp
    201f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    2022:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    2029:	8d 45 0c             	lea    0xc(%ebp),%eax
    202c:	83 c0 04             	add    $0x4,%eax
    202f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    2032:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2039:	e9 7c 01 00 00       	jmp    21ba <printf+0x19e>
    c = fmt[i] & 0xff;
    203e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2041:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2044:	01 d0                	add    %edx,%eax
    2046:	0f b6 00             	movzbl (%eax),%eax
    2049:	0f be c0             	movsbl %al,%eax
    204c:	25 ff 00 00 00       	and    $0xff,%eax
    2051:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    2054:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2058:	75 2c                	jne    2086 <printf+0x6a>
      if(c == '%'){
    205a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    205e:	75 0c                	jne    206c <printf+0x50>
        state = '%';
    2060:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    2067:	e9 4a 01 00 00       	jmp    21b6 <printf+0x19a>
      } else {
        putc(fd, c);
    206c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    206f:	0f be c0             	movsbl %al,%eax
    2072:	89 44 24 04          	mov    %eax,0x4(%esp)
    2076:	8b 45 08             	mov    0x8(%ebp),%eax
    2079:	89 04 24             	mov    %eax,(%esp)
    207c:	e8 bb fe ff ff       	call   1f3c <putc>
    2081:	e9 30 01 00 00       	jmp    21b6 <printf+0x19a>
      }
    } else if(state == '%'){
    2086:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    208a:	0f 85 26 01 00 00    	jne    21b6 <printf+0x19a>
      if(c == 'd'){
    2090:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    2094:	75 2d                	jne    20c3 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    2096:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2099:	8b 00                	mov    (%eax),%eax
    209b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    20a2:	00 
    20a3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    20aa:	00 
    20ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    20af:	8b 45 08             	mov    0x8(%ebp),%eax
    20b2:	89 04 24             	mov    %eax,(%esp)
    20b5:	e8 aa fe ff ff       	call   1f64 <printint>
        ap++;
    20ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20be:	e9 ec 00 00 00       	jmp    21af <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    20c3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    20c7:	74 06                	je     20cf <printf+0xb3>
    20c9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    20cd:	75 2d                	jne    20fc <printf+0xe0>
        printint(fd, *ap, 16, 0);
    20cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20d2:	8b 00                	mov    (%eax),%eax
    20d4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    20db:	00 
    20dc:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    20e3:	00 
    20e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    20e8:	8b 45 08             	mov    0x8(%ebp),%eax
    20eb:	89 04 24             	mov    %eax,(%esp)
    20ee:	e8 71 fe ff ff       	call   1f64 <printint>
        ap++;
    20f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20f7:	e9 b3 00 00 00       	jmp    21af <printf+0x193>
      } else if(c == 's'){
    20fc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    2100:	75 45                	jne    2147 <printf+0x12b>
        s = (char*)*ap;
    2102:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2105:	8b 00                	mov    (%eax),%eax
    2107:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    210a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    210e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2112:	75 09                	jne    211d <printf+0x101>
          s = "(null)";
    2114:	c7 45 f4 7b 29 00 00 	movl   $0x297b,-0xc(%ebp)
        while(*s != 0){
    211b:	eb 1e                	jmp    213b <printf+0x11f>
    211d:	eb 1c                	jmp    213b <printf+0x11f>
          putc(fd, *s);
    211f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2122:	0f b6 00             	movzbl (%eax),%eax
    2125:	0f be c0             	movsbl %al,%eax
    2128:	89 44 24 04          	mov    %eax,0x4(%esp)
    212c:	8b 45 08             	mov    0x8(%ebp),%eax
    212f:	89 04 24             	mov    %eax,(%esp)
    2132:	e8 05 fe ff ff       	call   1f3c <putc>
          s++;
    2137:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    213b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    213e:	0f b6 00             	movzbl (%eax),%eax
    2141:	84 c0                	test   %al,%al
    2143:	75 da                	jne    211f <printf+0x103>
    2145:	eb 68                	jmp    21af <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2147:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    214b:	75 1d                	jne    216a <printf+0x14e>
        putc(fd, *ap);
    214d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2150:	8b 00                	mov    (%eax),%eax
    2152:	0f be c0             	movsbl %al,%eax
    2155:	89 44 24 04          	mov    %eax,0x4(%esp)
    2159:	8b 45 08             	mov    0x8(%ebp),%eax
    215c:	89 04 24             	mov    %eax,(%esp)
    215f:	e8 d8 fd ff ff       	call   1f3c <putc>
        ap++;
    2164:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2168:	eb 45                	jmp    21af <printf+0x193>
      } else if(c == '%'){
    216a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    216e:	75 17                	jne    2187 <printf+0x16b>
        putc(fd, c);
    2170:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2173:	0f be c0             	movsbl %al,%eax
    2176:	89 44 24 04          	mov    %eax,0x4(%esp)
    217a:	8b 45 08             	mov    0x8(%ebp),%eax
    217d:	89 04 24             	mov    %eax,(%esp)
    2180:	e8 b7 fd ff ff       	call   1f3c <putc>
    2185:	eb 28                	jmp    21af <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2187:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    218e:	00 
    218f:	8b 45 08             	mov    0x8(%ebp),%eax
    2192:	89 04 24             	mov    %eax,(%esp)
    2195:	e8 a2 fd ff ff       	call   1f3c <putc>
        putc(fd, c);
    219a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    219d:	0f be c0             	movsbl %al,%eax
    21a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    21a4:	8b 45 08             	mov    0x8(%ebp),%eax
    21a7:	89 04 24             	mov    %eax,(%esp)
    21aa:	e8 8d fd ff ff       	call   1f3c <putc>
      }
      state = 0;
    21af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    21b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    21ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    21bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c0:	01 d0                	add    %edx,%eax
    21c2:	0f b6 00             	movzbl (%eax),%eax
    21c5:	84 c0                	test   %al,%al
    21c7:	0f 85 71 fe ff ff    	jne    203e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    21cd:	c9                   	leave  
    21ce:	c3                   	ret    
    21cf:	90                   	nop

000021d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    21d0:	55                   	push   %ebp
    21d1:	89 e5                	mov    %esp,%ebp
    21d3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    21d6:	8b 45 08             	mov    0x8(%ebp),%eax
    21d9:	83 e8 08             	sub    $0x8,%eax
    21dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    21df:	a1 a0 2e 00 00       	mov    0x2ea0,%eax
    21e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21e7:	eb 24                	jmp    220d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    21e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21ec:	8b 00                	mov    (%eax),%eax
    21ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21f1:	77 12                	ja     2205 <free+0x35>
    21f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21f9:	77 24                	ja     221f <free+0x4f>
    21fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21fe:	8b 00                	mov    (%eax),%eax
    2200:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2203:	77 1a                	ja     221f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2205:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2208:	8b 00                	mov    (%eax),%eax
    220a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    220d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2210:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2213:	76 d4                	jbe    21e9 <free+0x19>
    2215:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2218:	8b 00                	mov    (%eax),%eax
    221a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    221d:	76 ca                	jbe    21e9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    221f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2222:	8b 40 04             	mov    0x4(%eax),%eax
    2225:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    222c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    222f:	01 c2                	add    %eax,%edx
    2231:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2234:	8b 00                	mov    (%eax),%eax
    2236:	39 c2                	cmp    %eax,%edx
    2238:	75 24                	jne    225e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    223a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    223d:	8b 50 04             	mov    0x4(%eax),%edx
    2240:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2243:	8b 00                	mov    (%eax),%eax
    2245:	8b 40 04             	mov    0x4(%eax),%eax
    2248:	01 c2                	add    %eax,%edx
    224a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    224d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2250:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2253:	8b 00                	mov    (%eax),%eax
    2255:	8b 10                	mov    (%eax),%edx
    2257:	8b 45 f8             	mov    -0x8(%ebp),%eax
    225a:	89 10                	mov    %edx,(%eax)
    225c:	eb 0a                	jmp    2268 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    225e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2261:	8b 10                	mov    (%eax),%edx
    2263:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2266:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    2268:	8b 45 fc             	mov    -0x4(%ebp),%eax
    226b:	8b 40 04             	mov    0x4(%eax),%eax
    226e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2275:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2278:	01 d0                	add    %edx,%eax
    227a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    227d:	75 20                	jne    229f <free+0xcf>
    p->s.size += bp->s.size;
    227f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2282:	8b 50 04             	mov    0x4(%eax),%edx
    2285:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2288:	8b 40 04             	mov    0x4(%eax),%eax
    228b:	01 c2                	add    %eax,%edx
    228d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2290:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2293:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2296:	8b 10                	mov    (%eax),%edx
    2298:	8b 45 fc             	mov    -0x4(%ebp),%eax
    229b:	89 10                	mov    %edx,(%eax)
    229d:	eb 08                	jmp    22a7 <free+0xd7>
  } else
    p->s.ptr = bp;
    229f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
    22a5:	89 10                	mov    %edx,(%eax)
  freep = p;
    22a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22aa:	a3 a0 2e 00 00       	mov    %eax,0x2ea0
}
    22af:	c9                   	leave  
    22b0:	c3                   	ret    

000022b1 <morecore>:

static Header*
morecore(uint nu)
{
    22b1:	55                   	push   %ebp
    22b2:	89 e5                	mov    %esp,%ebp
    22b4:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    22b7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    22be:	77 07                	ja     22c7 <morecore+0x16>
    nu = 4096;
    22c0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    22c7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ca:	c1 e0 03             	shl    $0x3,%eax
    22cd:	89 04 24             	mov    %eax,(%esp)
    22d0:	e8 27 fc ff ff       	call   1efc <sbrk>
    22d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    22d8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    22dc:	75 07                	jne    22e5 <morecore+0x34>
    return 0;
    22de:	b8 00 00 00 00       	mov    $0x0,%eax
    22e3:	eb 22                	jmp    2307 <morecore+0x56>
  hp = (Header*)p;
    22e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    22eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22ee:	8b 55 08             	mov    0x8(%ebp),%edx
    22f1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    22f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22f7:	83 c0 08             	add    $0x8,%eax
    22fa:	89 04 24             	mov    %eax,(%esp)
    22fd:	e8 ce fe ff ff       	call   21d0 <free>
  return freep;
    2302:	a1 a0 2e 00 00       	mov    0x2ea0,%eax
}
    2307:	c9                   	leave  
    2308:	c3                   	ret    

00002309 <malloc>:

void*
malloc(uint nbytes)
{
    2309:	55                   	push   %ebp
    230a:	89 e5                	mov    %esp,%ebp
    230c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    230f:	8b 45 08             	mov    0x8(%ebp),%eax
    2312:	83 c0 07             	add    $0x7,%eax
    2315:	c1 e8 03             	shr    $0x3,%eax
    2318:	83 c0 01             	add    $0x1,%eax
    231b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    231e:	a1 a0 2e 00 00       	mov    0x2ea0,%eax
    2323:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2326:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    232a:	75 23                	jne    234f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    232c:	c7 45 f0 98 2e 00 00 	movl   $0x2e98,-0x10(%ebp)
    2333:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2336:	a3 a0 2e 00 00       	mov    %eax,0x2ea0
    233b:	a1 a0 2e 00 00       	mov    0x2ea0,%eax
    2340:	a3 98 2e 00 00       	mov    %eax,0x2e98
    base.s.size = 0;
    2345:	c7 05 9c 2e 00 00 00 	movl   $0x0,0x2e9c
    234c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    234f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2352:	8b 00                	mov    (%eax),%eax
    2354:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    2357:	8b 45 f4             	mov    -0xc(%ebp),%eax
    235a:	8b 40 04             	mov    0x4(%eax),%eax
    235d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2360:	72 4d                	jb     23af <malloc+0xa6>
      if(p->s.size == nunits)
    2362:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2365:	8b 40 04             	mov    0x4(%eax),%eax
    2368:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    236b:	75 0c                	jne    2379 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    236d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2370:	8b 10                	mov    (%eax),%edx
    2372:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2375:	89 10                	mov    %edx,(%eax)
    2377:	eb 26                	jmp    239f <malloc+0x96>
      else {
        p->s.size -= nunits;
    2379:	8b 45 f4             	mov    -0xc(%ebp),%eax
    237c:	8b 40 04             	mov    0x4(%eax),%eax
    237f:	2b 45 ec             	sub    -0x14(%ebp),%eax
    2382:	89 c2                	mov    %eax,%edx
    2384:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2387:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    238a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    238d:	8b 40 04             	mov    0x4(%eax),%eax
    2390:	c1 e0 03             	shl    $0x3,%eax
    2393:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    2396:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2399:	8b 55 ec             	mov    -0x14(%ebp),%edx
    239c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    239f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23a2:	a3 a0 2e 00 00       	mov    %eax,0x2ea0
      return (void*)(p + 1);
    23a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23aa:	83 c0 08             	add    $0x8,%eax
    23ad:	eb 38                	jmp    23e7 <malloc+0xde>
    }
    if(p == freep)
    23af:	a1 a0 2e 00 00       	mov    0x2ea0,%eax
    23b4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    23b7:	75 1b                	jne    23d4 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    23b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23bc:	89 04 24             	mov    %eax,(%esp)
    23bf:	e8 ed fe ff ff       	call   22b1 <morecore>
    23c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    23c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23cb:	75 07                	jne    23d4 <malloc+0xcb>
        return 0;
    23cd:	b8 00 00 00 00       	mov    $0x0,%eax
    23d2:	eb 13                	jmp    23e7 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    23d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23dd:	8b 00                	mov    (%eax),%eax
    23df:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    23e2:	e9 70 ff ff ff       	jmp    2357 <malloc+0x4e>
}
    23e7:	c9                   	leave  
    23e8:	c3                   	ret    
    23e9:	66 90                	xchg   %ax,%ax
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
    241a:	90                   	nop
    241b:	8b 45 08             	mov    0x8(%ebp),%eax
    241e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2425:	00 
    2426:	89 04 24             	mov    %eax,(%esp)
    2429:	e8 be ff ff ff       	call   23ec <xchg>
    242e:	85 c0                	test   %eax,%eax
    2430:	75 e9                	jne    241b <lock_acquire+0x7>
}
    2432:	c9                   	leave  
    2433:	c3                   	ret    

00002434 <lock_release>:
void lock_release(lock_t *lock){
    2434:	55                   	push   %ebp
    2435:	89 e5                	mov    %esp,%ebp
    2437:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    243a:	8b 45 08             	mov    0x8(%ebp),%eax
    243d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2444:	00 
    2445:	89 04 24             	mov    %eax,(%esp)
    2448:	e8 9f ff ff ff       	call   23ec <xchg>
}
    244d:	c9                   	leave  
    244e:	c3                   	ret    

0000244f <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    244f:	55                   	push   %ebp
    2450:	89 e5                	mov    %esp,%ebp
    2452:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2455:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    245c:	e8 a8 fe ff ff       	call   2309 <malloc>
    2461:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    2464:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2467:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    246a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    246d:	25 ff 0f 00 00       	and    $0xfff,%eax
    2472:	85 c0                	test   %eax,%eax
    2474:	74 14                	je     248a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    2476:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2479:	25 ff 0f 00 00       	and    $0xfff,%eax
    247e:	89 c2                	mov    %eax,%edx
    2480:	b8 00 10 00 00       	mov    $0x1000,%eax
    2485:	29 d0                	sub    %edx,%eax
    2487:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    248a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    248e:	75 1b                	jne    24ab <thread_create+0x5c>

        printf(1,"malloc fail \n");
    2490:	c7 44 24 04 82 29 00 	movl   $0x2982,0x4(%esp)
    2497:	00 
    2498:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    249f:	e8 78 fb ff ff       	call   201c <printf>
        return 0;
    24a4:	b8 00 00 00 00       	mov    $0x0,%eax
    24a9:	eb 6f                	jmp    251a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    24ab:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    24ae:	8b 55 08             	mov    0x8(%ebp),%edx
    24b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24b4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    24b8:	89 54 24 08          	mov    %edx,0x8(%esp)
    24bc:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    24c3:	00 
    24c4:	89 04 24             	mov    %eax,(%esp)
    24c7:	e8 48 fa ff ff       	call   1f14 <clone>
    24cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    24cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24d3:	79 1b                	jns    24f0 <thread_create+0xa1>
        printf(1,"clone fails\n");
    24d5:	c7 44 24 04 90 29 00 	movl   $0x2990,0x4(%esp)
    24dc:	00 
    24dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24e4:	e8 33 fb ff ff       	call   201c <printf>
        return 0;
    24e9:	b8 00 00 00 00       	mov    $0x0,%eax
    24ee:	eb 2a                	jmp    251a <thread_create+0xcb>
    }
    if(tid > 0){
    24f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24f4:	7e 05                	jle    24fb <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    24f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24f9:	eb 1f                	jmp    251a <thread_create+0xcb>
    }
    if(tid == 0){
    24fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24ff:	75 14                	jne    2515 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    2501:	c7 44 24 04 9d 29 00 	movl   $0x299d,0x4(%esp)
    2508:	00 
    2509:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2510:	e8 07 fb ff ff       	call   201c <printf>
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
    251f:	a1 84 2e 00 00       	mov    0x2e84,%eax
    2524:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    252a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    252f:	a3 84 2e 00 00       	mov    %eax,0x2e84
    return (int)(rands % max);
    2534:	a1 84 2e 00 00       	mov    0x2e84,%eax
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
    2577:	e8 8d fd ff ff       	call   2309 <malloc>
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
    2601:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    2604:	8b 45 08             	mov    0x8(%ebp),%eax
    2607:	8b 40 04             	mov    0x4(%eax),%eax
    260a:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    260d:	8b 45 08             	mov    0x8(%ebp),%eax
    2610:	8b 40 04             	mov    0x4(%eax),%eax
    2613:	8b 50 04             	mov    0x4(%eax),%edx
    2616:	8b 45 08             	mov    0x8(%ebp),%eax
    2619:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    261c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    261f:	89 04 24             	mov    %eax,(%esp)
    2622:	e8 a9 fb ff ff       	call   21d0 <free>
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
    2651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2654:	eb 05                	jmp    265b <pop_q+0x77>
    }
    return -1;
    2656:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    265b:	c9                   	leave  
    265c:	c3                   	ret    
