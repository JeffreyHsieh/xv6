
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
    102f:	e8 c3 12 00 00       	call   22f7 <malloc>
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
    10da:	e8 e9 10 00 00       	call   21c8 <free>
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
    1143:	e8 aa 12 00 00       	call   23f2 <lock_init>
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
    1162:	e8 99 12 00 00       	call   2400 <lock_acquire>
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
    117d:	e8 9e 12 00 00       	call   2420 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 6e 12 00 00       	call   2400 <lock_acquire>
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
    11b2:	e8 69 12 00 00       	call   2420 <lock_release>
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
    11e7:	e8 14 12 00 00       	call   2400 <lock_acquire>
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
    1202:	e8 19 12 00 00       	call   2420 <lock_release>
		
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
    1241:	e8 b1 10 00 00       	call   22f7 <malloc>
    1246:	a3 14 2e 00 00       	mov    %eax,0x2e14
	p = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 a0 10 00 00       	call   22f7 <malloc>
    1257:	a3 18 2e 00 00       	mov    %eax,0x2e18
	d = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 8f 10 00 00       	call   22f7 <malloc>
    1268:	a3 1c 2e 00 00       	mov    %eax,0x2e1c
	sem_init(d, 1);
    126d:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
	sem_init(p, 1);
    1282:	a1 18 2e 00 00       	mov    0x2e18,%eax
    1287:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    128e:	00 
    128f:	89 04 24             	mov    %eax,(%esp)
    1292:	e8 7e fe ff ff       	call   1115 <sem_init>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
    1297:	c7 04 24 4c 26 00 00 	movl   $0x264c,(%esp)
    129e:	e8 2a 09 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    12a3:	a1 14 2e 00 00       	mov    0x2e14,%eax
    12a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    12af:	00 
    12b0:	89 04 24             	mov    %eax,(%esp)
    12b3:	e8 5d fe ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 3; colony++){
    12b8:	c7 05 30 2e 00 00 00 	movl   $0x0,0x2e30
    12bf:	00 00 00 
    12c2:	eb 40                	jmp    1304 <main+0xd3>
		tid = thread_create(nMonkey, (void *) &arg);
    12c4:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    12cb:	00 
    12cc:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    12d3:	e8 63 11 00 00       	call   243b <thread_create>
    12d8:	a3 34 2e 00 00       	mov    %eax,0x2e34
		if(tid <= 0){
    12dd:	a1 34 2e 00 00       	mov    0x2e34,%eax
    12e2:	85 c0                	test   %eax,%eax
    12e4:	75 11                	jne    12f7 <main+0xc6>
			printAction("Failed to create a thread\n");
    12e6:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    12ed:	e8 db 08 00 00       	call   1bcd <printAction>
			exit();
    12f2:	e8 7d 0b 00 00       	call   1e74 <exit>

	//Test a-1: 3 monkeys go up tree
	printAction("Test a-1: 3 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 3; colony++){
    12f7:	a1 30 2e 00 00       	mov    0x2e30,%eax
    12fc:	83 c0 01             	add    $0x1,%eax
    12ff:	a3 30 2e 00 00       	mov    %eax,0x2e30
    1304:	a1 30 2e 00 00       	mov    0x2e30,%eax
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
    1318:	c7 04 24 84 26 00 00 	movl   $0x2684,(%esp)
    131f:	e8 a9 08 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1324:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1329:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1330:	00 
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 dc fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 6; colony++){
    1339:	c7 05 30 2e 00 00 00 	movl   $0x0,0x2e30
    1340:	00 00 00 
    1343:	eb 40                	jmp    1385 <main+0x154>
		tid = thread_create(nMonkey, (void *) &arg);
    1345:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    134c:	00 
    134d:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1354:	e8 e2 10 00 00       	call   243b <thread_create>
    1359:	a3 34 2e 00 00       	mov    %eax,0x2e34
		if(tid <= 0){
    135e:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1363:	85 c0                	test   %eax,%eax
    1365:	75 11                	jne    1378 <main+0x147>
			printAction("Failed to create a thread\n");
    1367:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    136e:	e8 5a 08 00 00       	call   1bcd <printAction>
			exit();
    1373:	e8 fc 0a 00 00       	call   1e74 <exit>
	
	//Test a-2: 6 monkeys go up tree
	printAction("\nTest a-2: 6 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 6; colony++){
    1378:	a1 30 2e 00 00       	mov    0x2e30,%eax
    137d:	83 c0 01             	add    $0x1,%eax
    1380:	a3 30 2e 00 00       	mov    %eax,0x2e30
    1385:	a1 30 2e 00 00       	mov    0x2e30,%eax
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
    1399:	c7 04 24 a4 26 00 00 	movl   $0x26a4,(%esp)
    13a0:	e8 28 08 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    13a5:	a1 14 2e 00 00       	mov    0x2e14,%eax
    13aa:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    13b1:	00 
    13b2:	89 04 24             	mov    %eax,(%esp)
    13b5:	e8 5b fd ff ff       	call   1115 <sem_init>
	
	for(colony = 0; colony < 12; colony++){
    13ba:	c7 05 30 2e 00 00 00 	movl   $0x0,0x2e30
    13c1:	00 00 00 
    13c4:	eb 40                	jmp    1406 <main+0x1d5>
		tid = thread_create(nMonkey, (void *) &arg);
    13c6:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    13cd:	00 
    13ce:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    13d5:	e8 61 10 00 00       	call   243b <thread_create>
    13da:	a3 34 2e 00 00       	mov    %eax,0x2e34
		if(tid <= 0){
    13df:	a1 34 2e 00 00       	mov    0x2e34,%eax
    13e4:	85 c0                	test   %eax,%eax
    13e6:	75 11                	jne    13f9 <main+0x1c8>
			printAction("Failed to create a thread\n");
    13e8:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    13ef:	e8 d9 07 00 00       	call   1bcd <printAction>
			exit();
    13f4:	e8 7b 0a 00 00       	call   1e74 <exit>
	
	//Test a-3: 12 monkeys go up tree
	printAction("\nTest a-3: 12 normal monkeys:\n");
	sem_init(tree, 3);
	
	for(colony = 0; colony < 12; colony++){
    13f9:	a1 30 2e 00 00       	mov    0x2e30,%eax
    13fe:	83 c0 01             	add    $0x1,%eax
    1401:	a3 30 2e 00 00       	mov    %eax,0x2e30
    1406:	a1 30 2e 00 00       	mov    0x2e30,%eax
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
    141a:	c7 04 24 c4 26 00 00 	movl   $0x26c4,(%esp)
    1421:	e8 a7 07 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1426:	a1 14 2e 00 00       	mov    0x2e14,%eax
    142b:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1432:	00 
    1433:	89 04 24             	mov    %eax,(%esp)
    1436:	e8 da fc ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    143b:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1442:	00 
    1443:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    144a:	e8 ec 0f 00 00       	call   243b <thread_create>
    144f:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1454:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1459:	85 c0                	test   %eax,%eax
    145b:	75 11                	jne    146e <main+0x23d>
		printAction("Failed to create a thread\n");
    145d:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1464:	e8 64 07 00 00       	call   1bcd <printAction>
		exit();
    1469:	e8 06 0a 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    146e:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1475:	00 
    1476:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    147d:	e8 b9 0f 00 00       	call   243b <thread_create>
    1482:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1487:	a1 34 2e 00 00       	mov    0x2e34,%eax
    148c:	85 c0                	test   %eax,%eax
    148e:	75 11                	jne    14a1 <main+0x270>
		printAction("Failed to create a thread\n");
    1490:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1497:	e8 31 07 00 00       	call   1bcd <printAction>
		exit();
    149c:	e8 d3 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14a1:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    14a8:	00 
    14a9:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    14b0:	e8 86 0f 00 00       	call   243b <thread_create>
    14b5:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    14ba:	a1 34 2e 00 00       	mov    0x2e34,%eax
    14bf:	85 c0                	test   %eax,%eax
    14c1:	75 11                	jne    14d4 <main+0x2a3>
		printAction("Failed to create a thread\n");
    14c3:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    14ca:	e8 fe 06 00 00       	call   1bcd <printAction>
		exit();
    14cf:	e8 a0 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    14d4:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    14db:	00 
    14dc:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    14e3:	e8 53 0f 00 00       	call   243b <thread_create>
    14e8:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    14ed:	a1 34 2e 00 00       	mov    0x2e34,%eax
    14f2:	85 c0                	test   %eax,%eax
    14f4:	75 11                	jne    1507 <main+0x2d6>
		printAction("Failed to create a thread\n");
    14f6:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
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
    1511:	c7 04 24 18 27 00 00 	movl   $0x2718,(%esp)
    1518:	e8 b0 06 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    151d:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1522:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1529:	00 
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 e3 fb ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    1532:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1539:	00 
    153a:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1541:	e8 f5 0e 00 00       	call   243b <thread_create>
    1546:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    154b:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1550:	85 c0                	test   %eax,%eax
    1552:	75 11                	jne    1565 <main+0x334>
		printAction("Failed to create a thread\n");
    1554:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    155b:	e8 6d 06 00 00       	call   1bcd <printAction>
		exit();
    1560:	e8 0f 09 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1565:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    156c:	00 
    156d:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1574:	e8 c2 0e 00 00       	call   243b <thread_create>
    1579:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    157e:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1583:	85 c0                	test   %eax,%eax
    1585:	75 11                	jne    1598 <main+0x367>
		printAction("Failed to create a thread\n");
    1587:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    158e:	e8 3a 06 00 00       	call   1bcd <printAction>
		exit();
    1593:	e8 dc 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1598:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    159f:	00 
    15a0:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    15a7:	e8 8f 0e 00 00       	call   243b <thread_create>
    15ac:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    15b1:	a1 34 2e 00 00       	mov    0x2e34,%eax
    15b6:	85 c0                	test   %eax,%eax
    15b8:	75 11                	jne    15cb <main+0x39a>
		printAction("Failed to create a thread\n");
    15ba:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    15c1:	e8 07 06 00 00       	call   1bcd <printAction>
		exit();
    15c6:	e8 a9 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    15cb:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    15d2:	00 
    15d3:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    15da:	e8 5c 0e 00 00       	call   243b <thread_create>
    15df:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    15e4:	a1 34 2e 00 00       	mov    0x2e34,%eax
    15e9:	85 c0                	test   %eax,%eax
    15eb:	75 11                	jne    15fe <main+0x3cd>
		printAction("Failed to create a thread\n");
    15ed:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
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
    1608:	c7 04 24 6c 27 00 00 	movl   $0x276c,(%esp)
    160f:	e8 b9 05 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1614:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1619:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    1620:	00 
    1621:	89 04 24             	mov    %eax,(%esp)
    1624:	e8 ec fa ff ff       	call   1115 <sem_init>
	
	tid = thread_create(nMonkey, (void *) &arg);
    1629:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1630:	00 
    1631:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1638:	e8 fe 0d 00 00       	call   243b <thread_create>
    163d:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1642:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1647:	85 c0                	test   %eax,%eax
    1649:	75 11                	jne    165c <main+0x42b>
		printAction("Failed to create a thread\n");
    164b:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1652:	e8 76 05 00 00       	call   1bcd <printAction>
		exit();
    1657:	e8 18 08 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    165c:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1663:	00 
    1664:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    166b:	e8 cb 0d 00 00       	call   243b <thread_create>
    1670:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1675:	a1 34 2e 00 00       	mov    0x2e34,%eax
    167a:	85 c0                	test   %eax,%eax
    167c:	75 11                	jne    168f <main+0x45e>
		printAction("Failed to create a thread\n");
    167e:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1685:	e8 43 05 00 00       	call   1bcd <printAction>
		exit();
    168a:	e8 e5 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    168f:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1696:	00 
    1697:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    169e:	e8 98 0d 00 00       	call   243b <thread_create>
    16a3:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    16a8:	a1 34 2e 00 00       	mov    0x2e34,%eax
    16ad:	85 c0                	test   %eax,%eax
    16af:	75 11                	jne    16c2 <main+0x491>
		printAction("Failed to create a thread\n");
    16b1:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    16b8:	e8 10 05 00 00       	call   1bcd <printAction>
		exit();
    16bd:	e8 b2 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    16c2:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    16c9:	00 
    16ca:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    16d1:	e8 65 0d 00 00       	call   243b <thread_create>
    16d6:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    16db:	a1 34 2e 00 00       	mov    0x2e34,%eax
    16e0:	85 c0                	test   %eax,%eax
    16e2:	75 11                	jne    16f5 <main+0x4c4>
		printAction("Failed to create a thread\n");
    16e4:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    16eb:	e8 dd 04 00 00       	call   1bcd <printAction>
		exit();
    16f0:	e8 7f 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    16f5:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    16fc:	00 
    16fd:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1704:	e8 32 0d 00 00       	call   243b <thread_create>
    1709:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    170e:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1713:	85 c0                	test   %eax,%eax
    1715:	75 11                	jne    1728 <main+0x4f7>
		printAction("Failed to create a thread\n");
    1717:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    171e:	e8 aa 04 00 00       	call   1bcd <printAction>
		exit();
    1723:	e8 4c 07 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1728:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    172f:	00 
    1730:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1737:	e8 ff 0c 00 00       	call   243b <thread_create>
    173c:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1741:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1746:	85 c0                	test   %eax,%eax
    1748:	75 11                	jne    175b <main+0x52a>
		printAction("Failed to create a thread\n");
    174a:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
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
    1765:	c7 04 24 c8 27 00 00 	movl   $0x27c8,(%esp)
    176c:	e8 5c 04 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    1771:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1776:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    177d:	00 
    177e:	89 04 24             	mov    %eax,(%esp)
    1781:	e8 8f f9 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    1786:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    178d:	00 
    178e:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1795:	e8 a1 0c 00 00       	call   243b <thread_create>
    179a:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    179f:	a1 34 2e 00 00       	mov    0x2e34,%eax
    17a4:	85 c0                	test   %eax,%eax
    17a6:	75 11                	jne    17b9 <main+0x588>
		printAction("Failed to create a thread\n");
    17a8:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    17af:	e8 19 04 00 00       	call   1bcd <printAction>
		exit();
    17b4:	e8 bb 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17b9:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    17c0:	00 
    17c1:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    17c8:	e8 6e 0c 00 00       	call   243b <thread_create>
    17cd:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    17d2:	a1 34 2e 00 00       	mov    0x2e34,%eax
    17d7:	85 c0                	test   %eax,%eax
    17d9:	75 11                	jne    17ec <main+0x5bb>
		printAction("Failed to create a thread\n");
    17db:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    17e2:	e8 e6 03 00 00       	call   1bcd <printAction>
		exit();
    17e7:	e8 88 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    17ec:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    17f3:	00 
    17f4:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    17fb:	e8 3b 0c 00 00       	call   243b <thread_create>
    1800:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1805:	a1 34 2e 00 00       	mov    0x2e34,%eax
    180a:	85 c0                	test   %eax,%eax
    180c:	75 11                	jne    181f <main+0x5ee>
		printAction("Failed to create a thread\n");
    180e:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1815:	e8 b3 03 00 00       	call   1bcd <printAction>
		exit();
    181a:	e8 55 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    181f:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1826:	00 
    1827:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    182e:	e8 08 0c 00 00       	call   243b <thread_create>
    1833:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1838:	a1 34 2e 00 00       	mov    0x2e34,%eax
    183d:	85 c0                	test   %eax,%eax
    183f:	75 11                	jne    1852 <main+0x621>
		printAction("Failed to create a thread\n");
    1841:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1848:	e8 80 03 00 00       	call   1bcd <printAction>
		exit();
    184d:	e8 22 06 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1852:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1859:	00 
    185a:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1861:	e8 d5 0b 00 00       	call   243b <thread_create>
    1866:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    186b:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1870:	85 c0                	test   %eax,%eax
    1872:	75 11                	jne    1885 <main+0x654>
		printAction("Failed to create a thread\n");
    1874:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    187b:	e8 4d 03 00 00       	call   1bcd <printAction>
		exit();
    1880:	e8 ef 05 00 00       	call   1e74 <exit>
	}

	tid = thread_create(dMonkey, (void *) &arg);
    1885:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    188c:	00 
    188d:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1894:	e8 a2 0b 00 00       	call   243b <thread_create>
    1899:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    189e:	a1 34 2e 00 00       	mov    0x2e34,%eax
    18a3:	85 c0                	test   %eax,%eax
    18a5:	75 11                	jne    18b8 <main+0x687>
		printAction("Failed to create a thread\n");
    18a7:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
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
    18c2:	c7 04 24 24 28 00 00 	movl   $0x2824,(%esp)
    18c9:	e8 ff 02 00 00       	call   1bcd <printAction>
	sem_init(tree, 3);
    18ce:	a1 14 2e 00 00       	mov    0x2e14,%eax
    18d3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    18da:	00 
    18db:	89 04 24             	mov    %eax,(%esp)
    18de:	e8 32 f8 ff ff       	call   1115 <sem_init>
	
	tid = thread_create(dMonkey, (void *) &arg);
    18e3:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    18ea:	00 
    18eb:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    18f2:	e8 44 0b 00 00       	call   243b <thread_create>
    18f7:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    18fc:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1901:	85 c0                	test   %eax,%eax
    1903:	75 11                	jne    1916 <main+0x6e5>
		printAction("Failed to create a thread\n");
    1905:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    190c:	e8 bc 02 00 00       	call   1bcd <printAction>
		exit();
    1911:	e8 5e 05 00 00       	call   1e74 <exit>
	}
	tid = thread_create(nMonkey, (void *) &arg);
    1916:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    191d:	00 
    191e:	c7 04 24 24 1a 00 00 	movl   $0x1a24,(%esp)
    1925:	e8 11 0b 00 00       	call   243b <thread_create>
    192a:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    192f:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1934:	85 c0                	test   %eax,%eax
    1936:	75 11                	jne    1949 <main+0x718>
		printAction("Failed to create a thread\n");
    1938:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    193f:	e8 89 02 00 00       	call   1bcd <printAction>
		exit();
    1944:	e8 2b 05 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    1949:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1950:	00 
    1951:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    1958:	e8 de 0a 00 00       	call   243b <thread_create>
    195d:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1962:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1967:	85 c0                	test   %eax,%eax
    1969:	75 11                	jne    197c <main+0x74b>
		printAction("Failed to create a thread\n");
    196b:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    1972:	e8 56 02 00 00       	call   1bcd <printAction>
		exit();
    1977:	e8 f8 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    197c:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    1983:	00 
    1984:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    198b:	e8 ab 0a 00 00       	call   243b <thread_create>
    1990:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    1995:	a1 34 2e 00 00       	mov    0x2e34,%eax
    199a:	85 c0                	test   %eax,%eax
    199c:	75 11                	jne    19af <main+0x77e>
		printAction("Failed to create a thread\n");
    199e:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    19a5:	e8 23 02 00 00       	call   1bcd <printAction>
		exit();
    19aa:	e8 c5 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19af:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    19b6:	00 
    19b7:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    19be:	e8 78 0a 00 00       	call   243b <thread_create>
    19c3:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    19c8:	a1 34 2e 00 00       	mov    0x2e34,%eax
    19cd:	85 c0                	test   %eax,%eax
    19cf:	75 11                	jne    19e2 <main+0x7b1>
		printAction("Failed to create a thread\n");
    19d1:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
    19d8:	e8 f0 01 00 00       	call   1bcd <printAction>
		exit();
    19dd:	e8 92 04 00 00       	call   1e74 <exit>
	}
	tid = thread_create(dMonkey, (void *) &arg);
    19e2:	c7 44 24 04 f8 2d 00 	movl   $0x2df8,0x4(%esp)
    19e9:	00 
    19ea:	c7 04 24 e9 1a 00 00 	movl   $0x1ae9,(%esp)
    19f1:	e8 45 0a 00 00       	call   243b <thread_create>
    19f6:	a3 34 2e 00 00       	mov    %eax,0x2e34
	if(tid <= 0){
    19fb:	a1 34 2e 00 00       	mov    0x2e34,%eax
    1a00:	85 c0                	test   %eax,%eax
    1a02:	75 11                	jne    1a15 <main+0x7e4>
		printAction("Failed to create a thread\n");
    1a04:	c7 04 24 69 26 00 00 	movl   $0x2669,(%esp)
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
    1a2a:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1a2f:	89 04 24             	mov    %eax,(%esp)
    1a32:	e8 13 f7 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1a37:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1a3c:	89 04 24             	mov    %eax,(%esp)
    1a3f:	e8 85 f7 ff ff       	call   11c9 <sem_signal>
	printAction("Normal monkey begins climbing\n");
    1a44:	c7 04 24 80 28 00 00 	movl   $0x2880,(%esp)
    1a4b:	e8 7d 01 00 00       	call   1bcd <printAction>
	
	int i;
	for(i = 0; i < 2999999; i++){
    1a50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a57:	eb 20                	jmp    1a79 <nMonkey+0x55>
		if(domClimbing > 0){
    1a59:	a1 20 2e 00 00       	mov    0x2e20,%eax
    1a5e:	85 c0                	test   %eax,%eax
    1a60:	7e 13                	jle    1a75 <nMonkey+0x51>
			printAction("Normal monkey waits\n");
    1a62:	c7 04 24 9f 28 00 00 	movl   $0x289f,(%esp)
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
    1a82:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1a87:	89 04 24             	mov    %eax,(%esp)
    1a8a:	e8 bb f6 ff ff       	call   114a <sem_acquire>
	sem_signal(d);
    1a8f:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1a94:	89 04 24             	mov    %eax,(%esp)
    1a97:	e8 2d f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(tree);
    1a9c:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1aa1:	89 04 24             	mov    %eax,(%esp)
    1aa4:	e8 a1 f6 ff ff       	call   114a <sem_acquire>
	printAction("Normal monkey acquires coconut (Semaphore)\n");
    1aa9:	c7 04 24 b4 28 00 00 	movl   $0x28b4,(%esp)
    1ab0:	e8 18 01 00 00       	call   1bcd <printAction>
	
	for(i = 0; i < 2999999; i++);
    1ab5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1abc:	eb 04                	jmp    1ac2 <nMonkey+0x9e>
    1abe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ac2:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1ac9:	7e f3                	jle    1abe <nMonkey+0x9a>
	
	printAction("Normal monkey descends\n");
    1acb:	c7 04 24 e0 28 00 00 	movl   $0x28e0,(%esp)
    1ad2:	e8 f6 00 00 00       	call   1bcd <printAction>

	sem_signal(tree);
    1ad7:	a1 14 2e 00 00       	mov    0x2e14,%eax
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
    1aef:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1af4:	89 04 24             	mov    %eax,(%esp)
    1af7:	e8 4e f6 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey begins climbing\n");
    1afc:	c7 04 24 f8 28 00 00 	movl   $0x28f8,(%esp)
    1b03:	e8 c5 00 00 00       	call   1bcd <printAction>
	sem_acquire(p);
    1b08:	a1 18 2e 00 00       	mov    0x2e18,%eax
    1b0d:	89 04 24             	mov    %eax,(%esp)
    1b10:	e8 35 f6 ff ff       	call   114a <sem_acquire>
	domClimbing++;
    1b15:	a1 20 2e 00 00       	mov    0x2e20,%eax
    1b1a:	83 c0 01             	add    $0x1,%eax
    1b1d:	a3 20 2e 00 00       	mov    %eax,0x2e20
	sem_signal(p);
    1b22:	a1 18 2e 00 00       	mov    0x2e18,%eax
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
    1b4c:	a1 14 2e 00 00       	mov    0x2e14,%eax
    1b51:	89 04 24             	mov    %eax,(%esp)
    1b54:	e8 f1 f5 ff ff       	call   114a <sem_acquire>
	printAction("Dominant monkey acquires coconut (Semaphore)\n");
    1b59:	c7 04 24 1c 29 00 00 	movl   $0x291c,(%esp)
    1b60:	e8 68 00 00 00       	call   1bcd <printAction>
	sem_acquire(p);
    1b65:	a1 18 2e 00 00       	mov    0x2e18,%eax
    1b6a:	89 04 24             	mov    %eax,(%esp)
    1b6d:	e8 d8 f5 ff ff       	call   114a <sem_acquire>
	domClimbing--;
    1b72:	a1 20 2e 00 00       	mov    0x2e20,%eax
    1b77:	83 e8 01             	sub    $0x1,%eax
    1b7a:	a3 20 2e 00 00       	mov    %eax,0x2e20
	sem_signal(p);
    1b7f:	a1 18 2e 00 00       	mov    0x2e18,%eax
    1b84:	89 04 24             	mov    %eax,(%esp)
    1b87:	e8 3d f6 ff ff       	call   11c9 <sem_signal>
	sem_signal(d);
    1b8c:	a1 1c 2e 00 00       	mov    0x2e1c,%eax
    1b91:	89 04 24             	mov    %eax,(%esp)
    1b94:	e8 30 f6 ff ff       	call   11c9 <sem_signal>

	for(i = 0; i < 2999999; i++);
    1b99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ba0:	eb 04                	jmp    1ba6 <dMonkey+0xbd>
    1ba2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ba6:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1bad:	7e f3                	jle    1ba2 <dMonkey+0xb9>
	
	printAction("Dominant monkey descends\n");
    1baf:	c7 04 24 4a 29 00 00 	movl   $0x294a,(%esp)
    1bb6:	e8 12 00 00 00       	call   1bcd <printAction>
	
	sem_signal(tree);
    1bbb:	a1 14 2e 00 00       	mov    0x2e14,%eax
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
    1bd3:	a1 18 2e 00 00       	mov    0x2e18,%eax
    1bd8:	89 04 24             	mov    %eax,(%esp)
    1bdb:	e8 6a f5 ff ff       	call   114a <sem_acquire>
	printf(1, "%s", a);
    1be0:	8b 45 08             	mov    0x8(%ebp),%eax
    1be3:	89 44 24 08          	mov    %eax,0x8(%esp)
    1be7:	c7 44 24 04 64 29 00 	movl   $0x2964,0x4(%esp)
    1bee:	00 
    1bef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bf6:	e8 19 04 00 00       	call   2014 <printf>
	sem_signal(p);
    1bfb:	a1 18 2e 00 00       	mov    0x2e18,%eax
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
    1e6c:	b8 01 00 00 00       	mov    $0x1,%eax
    1e71:	cd 40                	int    $0x40
    1e73:	c3                   	ret    

00001e74 <exit>:
    1e74:	b8 02 00 00 00       	mov    $0x2,%eax
    1e79:	cd 40                	int    $0x40
    1e7b:	c3                   	ret    

00001e7c <wait>:
    1e7c:	b8 03 00 00 00       	mov    $0x3,%eax
    1e81:	cd 40                	int    $0x40
    1e83:	c3                   	ret    

00001e84 <pipe>:
    1e84:	b8 04 00 00 00       	mov    $0x4,%eax
    1e89:	cd 40                	int    $0x40
    1e8b:	c3                   	ret    

00001e8c <read>:
    1e8c:	b8 05 00 00 00       	mov    $0x5,%eax
    1e91:	cd 40                	int    $0x40
    1e93:	c3                   	ret    

00001e94 <write>:
    1e94:	b8 10 00 00 00       	mov    $0x10,%eax
    1e99:	cd 40                	int    $0x40
    1e9b:	c3                   	ret    

00001e9c <close>:
    1e9c:	b8 15 00 00 00       	mov    $0x15,%eax
    1ea1:	cd 40                	int    $0x40
    1ea3:	c3                   	ret    

00001ea4 <kill>:
    1ea4:	b8 06 00 00 00       	mov    $0x6,%eax
    1ea9:	cd 40                	int    $0x40
    1eab:	c3                   	ret    

00001eac <exec>:
    1eac:	b8 07 00 00 00       	mov    $0x7,%eax
    1eb1:	cd 40                	int    $0x40
    1eb3:	c3                   	ret    

00001eb4 <open>:
    1eb4:	b8 0f 00 00 00       	mov    $0xf,%eax
    1eb9:	cd 40                	int    $0x40
    1ebb:	c3                   	ret    

00001ebc <mknod>:
    1ebc:	b8 11 00 00 00       	mov    $0x11,%eax
    1ec1:	cd 40                	int    $0x40
    1ec3:	c3                   	ret    

00001ec4 <unlink>:
    1ec4:	b8 12 00 00 00       	mov    $0x12,%eax
    1ec9:	cd 40                	int    $0x40
    1ecb:	c3                   	ret    

00001ecc <fstat>:
    1ecc:	b8 08 00 00 00       	mov    $0x8,%eax
    1ed1:	cd 40                	int    $0x40
    1ed3:	c3                   	ret    

00001ed4 <link>:
    1ed4:	b8 13 00 00 00       	mov    $0x13,%eax
    1ed9:	cd 40                	int    $0x40
    1edb:	c3                   	ret    

00001edc <mkdir>:
    1edc:	b8 14 00 00 00       	mov    $0x14,%eax
    1ee1:	cd 40                	int    $0x40
    1ee3:	c3                   	ret    

00001ee4 <chdir>:
    1ee4:	b8 09 00 00 00       	mov    $0x9,%eax
    1ee9:	cd 40                	int    $0x40
    1eeb:	c3                   	ret    

00001eec <dup>:
    1eec:	b8 0a 00 00 00       	mov    $0xa,%eax
    1ef1:	cd 40                	int    $0x40
    1ef3:	c3                   	ret    

00001ef4 <getpid>:
    1ef4:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ef9:	cd 40                	int    $0x40
    1efb:	c3                   	ret    

00001efc <sbrk>:
    1efc:	b8 0c 00 00 00       	mov    $0xc,%eax
    1f01:	cd 40                	int    $0x40
    1f03:	c3                   	ret    

00001f04 <sleep>:
    1f04:	b8 0d 00 00 00       	mov    $0xd,%eax
    1f09:	cd 40                	int    $0x40
    1f0b:	c3                   	ret    

00001f0c <uptime>:
    1f0c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1f11:	cd 40                	int    $0x40
    1f13:	c3                   	ret    

00001f14 <clone>:
    1f14:	b8 16 00 00 00       	mov    $0x16,%eax
    1f19:	cd 40                	int    $0x40
    1f1b:	c3                   	ret    

00001f1c <texit>:
    1f1c:	b8 17 00 00 00       	mov    $0x17,%eax
    1f21:	cd 40                	int    $0x40
    1f23:	c3                   	ret    

00001f24 <tsleep>:
    1f24:	b8 18 00 00 00       	mov    $0x18,%eax
    1f29:	cd 40                	int    $0x40
    1f2b:	c3                   	ret    

00001f2c <twakeup>:
    1f2c:	b8 19 00 00 00       	mov    $0x19,%eax
    1f31:	cd 40                	int    $0x40
    1f33:	c3                   	ret    

00001f34 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1f34:	55                   	push   %ebp
    1f35:	89 e5                	mov    %esp,%ebp
    1f37:	83 ec 18             	sub    $0x18,%esp
    1f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f3d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f40:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f47:	00 
    1f48:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f4b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f52:	89 04 24             	mov    %eax,(%esp)
    1f55:	e8 3a ff ff ff       	call   1e94 <write>
}
    1f5a:	c9                   	leave  
    1f5b:	c3                   	ret    

00001f5c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f5c:	55                   	push   %ebp
    1f5d:	89 e5                	mov    %esp,%ebp
    1f5f:	56                   	push   %esi
    1f60:	53                   	push   %ebx
    1f61:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f64:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f6b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f6f:	74 17                	je     1f88 <printint+0x2c>
    1f71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f75:	79 11                	jns    1f88 <printint+0x2c>
    neg = 1;
    1f77:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f81:	f7 d8                	neg    %eax
    1f83:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f86:	eb 06                	jmp    1f8e <printint+0x32>
  } else {
    x = xx;
    1f88:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1f8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1f95:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1f98:	8d 41 01             	lea    0x1(%ecx),%eax
    1f9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f9e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1fa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fa4:	ba 00 00 00 00       	mov    $0x0,%edx
    1fa9:	f7 f3                	div    %ebx
    1fab:	89 d0                	mov    %edx,%eax
    1fad:	0f b6 80 fc 2d 00 00 	movzbl 0x2dfc(%eax),%eax
    1fb4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1fb8:	8b 75 10             	mov    0x10(%ebp),%esi
    1fbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fbe:	ba 00 00 00 00       	mov    $0x0,%edx
    1fc3:	f7 f6                	div    %esi
    1fc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1fc8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fcc:	75 c7                	jne    1f95 <printint+0x39>
  if(neg)
    1fce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fd2:	74 10                	je     1fe4 <printint+0x88>
    buf[i++] = '-';
    1fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd7:	8d 50 01             	lea    0x1(%eax),%edx
    1fda:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1fdd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1fe2:	eb 1f                	jmp    2003 <printint+0xa7>
    1fe4:	eb 1d                	jmp    2003 <printint+0xa7>
    putc(fd, buf[i]);
    1fe6:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1fe9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fec:	01 d0                	add    %edx,%eax
    1fee:	0f b6 00             	movzbl (%eax),%eax
    1ff1:	0f be c0             	movsbl %al,%eax
    1ff4:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ff8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffb:	89 04 24             	mov    %eax,(%esp)
    1ffe:	e8 31 ff ff ff       	call   1f34 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2003:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2007:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    200b:	79 d9                	jns    1fe6 <printint+0x8a>
    putc(fd, buf[i]);
}
    200d:	83 c4 30             	add    $0x30,%esp
    2010:	5b                   	pop    %ebx
    2011:	5e                   	pop    %esi
    2012:	5d                   	pop    %ebp
    2013:	c3                   	ret    

00002014 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2014:	55                   	push   %ebp
    2015:	89 e5                	mov    %esp,%ebp
    2017:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    201a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    2021:	8d 45 0c             	lea    0xc(%ebp),%eax
    2024:	83 c0 04             	add    $0x4,%eax
    2027:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    202a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2031:	e9 7c 01 00 00       	jmp    21b2 <printf+0x19e>
    c = fmt[i] & 0xff;
    2036:	8b 55 0c             	mov    0xc(%ebp),%edx
    2039:	8b 45 f0             	mov    -0x10(%ebp),%eax
    203c:	01 d0                	add    %edx,%eax
    203e:	0f b6 00             	movzbl (%eax),%eax
    2041:	0f be c0             	movsbl %al,%eax
    2044:	25 ff 00 00 00       	and    $0xff,%eax
    2049:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    204c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2050:	75 2c                	jne    207e <printf+0x6a>
      if(c == '%'){
    2052:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2056:	75 0c                	jne    2064 <printf+0x50>
        state = '%';
    2058:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    205f:	e9 4a 01 00 00       	jmp    21ae <printf+0x19a>
      } else {
        putc(fd, c);
    2064:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2067:	0f be c0             	movsbl %al,%eax
    206a:	89 44 24 04          	mov    %eax,0x4(%esp)
    206e:	8b 45 08             	mov    0x8(%ebp),%eax
    2071:	89 04 24             	mov    %eax,(%esp)
    2074:	e8 bb fe ff ff       	call   1f34 <putc>
    2079:	e9 30 01 00 00       	jmp    21ae <printf+0x19a>
      }
    } else if(state == '%'){
    207e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    2082:	0f 85 26 01 00 00    	jne    21ae <printf+0x19a>
      if(c == 'd'){
    2088:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    208c:	75 2d                	jne    20bb <printf+0xa7>
        printint(fd, *ap, 10, 1);
    208e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2091:	8b 00                	mov    (%eax),%eax
    2093:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    209a:	00 
    209b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    20a2:	00 
    20a3:	89 44 24 04          	mov    %eax,0x4(%esp)
    20a7:	8b 45 08             	mov    0x8(%ebp),%eax
    20aa:	89 04 24             	mov    %eax,(%esp)
    20ad:	e8 aa fe ff ff       	call   1f5c <printint>
        ap++;
    20b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20b6:	e9 ec 00 00 00       	jmp    21a7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    20bb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    20bf:	74 06                	je     20c7 <printf+0xb3>
    20c1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    20c5:	75 2d                	jne    20f4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    20c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20ca:	8b 00                	mov    (%eax),%eax
    20cc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    20d3:	00 
    20d4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    20db:	00 
    20dc:	89 44 24 04          	mov    %eax,0x4(%esp)
    20e0:	8b 45 08             	mov    0x8(%ebp),%eax
    20e3:	89 04 24             	mov    %eax,(%esp)
    20e6:	e8 71 fe ff ff       	call   1f5c <printint>
        ap++;
    20eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20ef:	e9 b3 00 00 00       	jmp    21a7 <printf+0x193>
      } else if(c == 's'){
    20f4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    20f8:	75 45                	jne    213f <printf+0x12b>
        s = (char*)*ap;
    20fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20fd:	8b 00                	mov    (%eax),%eax
    20ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    2102:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    2106:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    210a:	75 09                	jne    2115 <printf+0x101>
          s = "(null)";
    210c:	c7 45 f4 67 29 00 00 	movl   $0x2967,-0xc(%ebp)
        while(*s != 0){
    2113:	eb 1e                	jmp    2133 <printf+0x11f>
    2115:	eb 1c                	jmp    2133 <printf+0x11f>
          putc(fd, *s);
    2117:	8b 45 f4             	mov    -0xc(%ebp),%eax
    211a:	0f b6 00             	movzbl (%eax),%eax
    211d:	0f be c0             	movsbl %al,%eax
    2120:	89 44 24 04          	mov    %eax,0x4(%esp)
    2124:	8b 45 08             	mov    0x8(%ebp),%eax
    2127:	89 04 24             	mov    %eax,(%esp)
    212a:	e8 05 fe ff ff       	call   1f34 <putc>
          s++;
    212f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2133:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2136:	0f b6 00             	movzbl (%eax),%eax
    2139:	84 c0                	test   %al,%al
    213b:	75 da                	jne    2117 <printf+0x103>
    213d:	eb 68                	jmp    21a7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    213f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    2143:	75 1d                	jne    2162 <printf+0x14e>
        putc(fd, *ap);
    2145:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2148:	8b 00                	mov    (%eax),%eax
    214a:	0f be c0             	movsbl %al,%eax
    214d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2151:	8b 45 08             	mov    0x8(%ebp),%eax
    2154:	89 04 24             	mov    %eax,(%esp)
    2157:	e8 d8 fd ff ff       	call   1f34 <putc>
        ap++;
    215c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2160:	eb 45                	jmp    21a7 <printf+0x193>
      } else if(c == '%'){
    2162:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2166:	75 17                	jne    217f <printf+0x16b>
        putc(fd, c);
    2168:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    216b:	0f be c0             	movsbl %al,%eax
    216e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2172:	8b 45 08             	mov    0x8(%ebp),%eax
    2175:	89 04 24             	mov    %eax,(%esp)
    2178:	e8 b7 fd ff ff       	call   1f34 <putc>
    217d:	eb 28                	jmp    21a7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    217f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2186:	00 
    2187:	8b 45 08             	mov    0x8(%ebp),%eax
    218a:	89 04 24             	mov    %eax,(%esp)
    218d:	e8 a2 fd ff ff       	call   1f34 <putc>
        putc(fd, c);
    2192:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2195:	0f be c0             	movsbl %al,%eax
    2198:	89 44 24 04          	mov    %eax,0x4(%esp)
    219c:	8b 45 08             	mov    0x8(%ebp),%eax
    219f:	89 04 24             	mov    %eax,(%esp)
    21a2:	e8 8d fd ff ff       	call   1f34 <putc>
      }
      state = 0;
    21a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    21ae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    21b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    21b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21b8:	01 d0                	add    %edx,%eax
    21ba:	0f b6 00             	movzbl (%eax),%eax
    21bd:	84 c0                	test   %al,%al
    21bf:	0f 85 71 fe ff ff    	jne    2036 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    21c5:	c9                   	leave  
    21c6:	c3                   	ret    
    21c7:	90                   	nop

000021c8 <free>:
    21c8:	55                   	push   %ebp
    21c9:	89 e5                	mov    %esp,%ebp
    21cb:	83 ec 10             	sub    $0x10,%esp
    21ce:	8b 45 08             	mov    0x8(%ebp),%eax
    21d1:	83 e8 08             	sub    $0x8,%eax
    21d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21d7:	a1 2c 2e 00 00       	mov    0x2e2c,%eax
    21dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21df:	eb 24                	jmp    2205 <free+0x3d>
    21e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21e4:	8b 00                	mov    (%eax),%eax
    21e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21e9:	77 12                	ja     21fd <free+0x35>
    21eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21f1:	77 24                	ja     2217 <free+0x4f>
    21f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21f6:	8b 00                	mov    (%eax),%eax
    21f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21fb:	77 1a                	ja     2217 <free+0x4f>
    21fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2200:	8b 00                	mov    (%eax),%eax
    2202:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2205:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2208:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    220b:	76 d4                	jbe    21e1 <free+0x19>
    220d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2210:	8b 00                	mov    (%eax),%eax
    2212:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2215:	76 ca                	jbe    21e1 <free+0x19>
    2217:	8b 45 f8             	mov    -0x8(%ebp),%eax
    221a:	8b 40 04             	mov    0x4(%eax),%eax
    221d:	c1 e0 03             	shl    $0x3,%eax
    2220:	89 c2                	mov    %eax,%edx
    2222:	03 55 f8             	add    -0x8(%ebp),%edx
    2225:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2228:	8b 00                	mov    (%eax),%eax
    222a:	39 c2                	cmp    %eax,%edx
    222c:	75 24                	jne    2252 <free+0x8a>
    222e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2231:	8b 50 04             	mov    0x4(%eax),%edx
    2234:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2237:	8b 00                	mov    (%eax),%eax
    2239:	8b 40 04             	mov    0x4(%eax),%eax
    223c:	01 c2                	add    %eax,%edx
    223e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2241:	89 50 04             	mov    %edx,0x4(%eax)
    2244:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2247:	8b 00                	mov    (%eax),%eax
    2249:	8b 10                	mov    (%eax),%edx
    224b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    224e:	89 10                	mov    %edx,(%eax)
    2250:	eb 0a                	jmp    225c <free+0x94>
    2252:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2255:	8b 10                	mov    (%eax),%edx
    2257:	8b 45 f8             	mov    -0x8(%ebp),%eax
    225a:	89 10                	mov    %edx,(%eax)
    225c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    225f:	8b 40 04             	mov    0x4(%eax),%eax
    2262:	c1 e0 03             	shl    $0x3,%eax
    2265:	03 45 fc             	add    -0x4(%ebp),%eax
    2268:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    226b:	75 20                	jne    228d <free+0xc5>
    226d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2270:	8b 50 04             	mov    0x4(%eax),%edx
    2273:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2276:	8b 40 04             	mov    0x4(%eax),%eax
    2279:	01 c2                	add    %eax,%edx
    227b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    227e:	89 50 04             	mov    %edx,0x4(%eax)
    2281:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2284:	8b 10                	mov    (%eax),%edx
    2286:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2289:	89 10                	mov    %edx,(%eax)
    228b:	eb 08                	jmp    2295 <free+0xcd>
    228d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2290:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2293:	89 10                	mov    %edx,(%eax)
    2295:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2298:	a3 2c 2e 00 00       	mov    %eax,0x2e2c
    229d:	c9                   	leave  
    229e:	c3                   	ret    

0000229f <morecore>:
    229f:	55                   	push   %ebp
    22a0:	89 e5                	mov    %esp,%ebp
    22a2:	83 ec 28             	sub    $0x28,%esp
    22a5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    22ac:	77 07                	ja     22b5 <morecore+0x16>
    22ae:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    22b5:	8b 45 08             	mov    0x8(%ebp),%eax
    22b8:	c1 e0 03             	shl    $0x3,%eax
    22bb:	89 04 24             	mov    %eax,(%esp)
    22be:	e8 39 fc ff ff       	call   1efc <sbrk>
    22c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22c6:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    22ca:	75 07                	jne    22d3 <morecore+0x34>
    22cc:	b8 00 00 00 00       	mov    $0x0,%eax
    22d1:	eb 22                	jmp    22f5 <morecore+0x56>
    22d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22dc:	8b 55 08             	mov    0x8(%ebp),%edx
    22df:	89 50 04             	mov    %edx,0x4(%eax)
    22e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22e5:	83 c0 08             	add    $0x8,%eax
    22e8:	89 04 24             	mov    %eax,(%esp)
    22eb:	e8 d8 fe ff ff       	call   21c8 <free>
    22f0:	a1 2c 2e 00 00       	mov    0x2e2c,%eax
    22f5:	c9                   	leave  
    22f6:	c3                   	ret    

000022f7 <malloc>:
    22f7:	55                   	push   %ebp
    22f8:	89 e5                	mov    %esp,%ebp
    22fa:	83 ec 28             	sub    $0x28,%esp
    22fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2300:	83 c0 07             	add    $0x7,%eax
    2303:	c1 e8 03             	shr    $0x3,%eax
    2306:	83 c0 01             	add    $0x1,%eax
    2309:	89 45 f4             	mov    %eax,-0xc(%ebp)
    230c:	a1 2c 2e 00 00       	mov    0x2e2c,%eax
    2311:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2314:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2318:	75 23                	jne    233d <malloc+0x46>
    231a:	c7 45 f0 24 2e 00 00 	movl   $0x2e24,-0x10(%ebp)
    2321:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2324:	a3 2c 2e 00 00       	mov    %eax,0x2e2c
    2329:	a1 2c 2e 00 00       	mov    0x2e2c,%eax
    232e:	a3 24 2e 00 00       	mov    %eax,0x2e24
    2333:	c7 05 28 2e 00 00 00 	movl   $0x0,0x2e28
    233a:	00 00 00 
    233d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2340:	8b 00                	mov    (%eax),%eax
    2342:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2345:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2348:	8b 40 04             	mov    0x4(%eax),%eax
    234b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    234e:	72 4d                	jb     239d <malloc+0xa6>
    2350:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2353:	8b 40 04             	mov    0x4(%eax),%eax
    2356:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2359:	75 0c                	jne    2367 <malloc+0x70>
    235b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    235e:	8b 10                	mov    (%eax),%edx
    2360:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2363:	89 10                	mov    %edx,(%eax)
    2365:	eb 26                	jmp    238d <malloc+0x96>
    2367:	8b 45 ec             	mov    -0x14(%ebp),%eax
    236a:	8b 40 04             	mov    0x4(%eax),%eax
    236d:	89 c2                	mov    %eax,%edx
    236f:	2b 55 f4             	sub    -0xc(%ebp),%edx
    2372:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2375:	89 50 04             	mov    %edx,0x4(%eax)
    2378:	8b 45 ec             	mov    -0x14(%ebp),%eax
    237b:	8b 40 04             	mov    0x4(%eax),%eax
    237e:	c1 e0 03             	shl    $0x3,%eax
    2381:	01 45 ec             	add    %eax,-0x14(%ebp)
    2384:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2387:	8b 55 f4             	mov    -0xc(%ebp),%edx
    238a:	89 50 04             	mov    %edx,0x4(%eax)
    238d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2390:	a3 2c 2e 00 00       	mov    %eax,0x2e2c
    2395:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2398:	83 c0 08             	add    $0x8,%eax
    239b:	eb 38                	jmp    23d5 <malloc+0xde>
    239d:	a1 2c 2e 00 00       	mov    0x2e2c,%eax
    23a2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    23a5:	75 1b                	jne    23c2 <malloc+0xcb>
    23a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23aa:	89 04 24             	mov    %eax,(%esp)
    23ad:	e8 ed fe ff ff       	call   229f <morecore>
    23b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    23b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    23b9:	75 07                	jne    23c2 <malloc+0xcb>
    23bb:	b8 00 00 00 00       	mov    $0x0,%eax
    23c0:	eb 13                	jmp    23d5 <malloc+0xde>
    23c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23cb:	8b 00                	mov    (%eax),%eax
    23cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    23d0:	e9 70 ff ff ff       	jmp    2345 <malloc+0x4e>
    23d5:	c9                   	leave  
    23d6:	c3                   	ret    
    23d7:	90                   	nop

000023d8 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    23d8:	55                   	push   %ebp
    23d9:	89 e5                	mov    %esp,%ebp
    23db:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    23de:	8b 55 08             	mov    0x8(%ebp),%edx
    23e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    23e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23e7:	f0 87 02             	lock xchg %eax,(%edx)
    23ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    23ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    23f0:	c9                   	leave  
    23f1:	c3                   	ret    

000023f2 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    23f2:	55                   	push   %ebp
    23f3:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    23f5:	8b 45 08             	mov    0x8(%ebp),%eax
    23f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    23fe:	5d                   	pop    %ebp
    23ff:	c3                   	ret    

00002400 <lock_acquire>:
void lock_acquire(lock_t *lock){
    2400:	55                   	push   %ebp
    2401:	89 e5                	mov    %esp,%ebp
    2403:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    2406:	90                   	nop
    2407:	8b 45 08             	mov    0x8(%ebp),%eax
    240a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2411:	00 
    2412:	89 04 24             	mov    %eax,(%esp)
    2415:	e8 be ff ff ff       	call   23d8 <xchg>
    241a:	85 c0                	test   %eax,%eax
    241c:	75 e9                	jne    2407 <lock_acquire+0x7>
}
    241e:	c9                   	leave  
    241f:	c3                   	ret    

00002420 <lock_release>:
void lock_release(lock_t *lock){
    2420:	55                   	push   %ebp
    2421:	89 e5                	mov    %esp,%ebp
    2423:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    2426:	8b 45 08             	mov    0x8(%ebp),%eax
    2429:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2430:	00 
    2431:	89 04 24             	mov    %eax,(%esp)
    2434:	e8 9f ff ff ff       	call   23d8 <xchg>
}
    2439:	c9                   	leave  
    243a:	c3                   	ret    

0000243b <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    243b:	55                   	push   %ebp
    243c:	89 e5                	mov    %esp,%ebp
    243e:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2441:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2448:	e8 aa fe ff ff       	call   22f7 <malloc>
    244d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    2450:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2453:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    2456:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2459:	25 ff 0f 00 00       	and    $0xfff,%eax
    245e:	85 c0                	test   %eax,%eax
    2460:	74 14                	je     2476 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    2462:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2465:	25 ff 0f 00 00       	and    $0xfff,%eax
    246a:	89 c2                	mov    %eax,%edx
    246c:	b8 00 10 00 00       	mov    $0x1000,%eax
    2471:	29 d0                	sub    %edx,%eax
    2473:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    2476:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    247a:	75 1b                	jne    2497 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    247c:	c7 44 24 04 6e 29 00 	movl   $0x296e,0x4(%esp)
    2483:	00 
    2484:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    248b:	e8 84 fb ff ff       	call   2014 <printf>
        return 0;
    2490:	b8 00 00 00 00       	mov    $0x0,%eax
    2495:	eb 6f                	jmp    2506 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    2497:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    249a:	8b 55 08             	mov    0x8(%ebp),%edx
    249d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24a0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    24a4:	89 54 24 08          	mov    %edx,0x8(%esp)
    24a8:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    24af:	00 
    24b0:	89 04 24             	mov    %eax,(%esp)
    24b3:	e8 5c fa ff ff       	call   1f14 <clone>
    24b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    24bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24bf:	79 1b                	jns    24dc <thread_create+0xa1>
        printf(1,"clone fails\n");
    24c1:	c7 44 24 04 7c 29 00 	movl   $0x297c,0x4(%esp)
    24c8:	00 
    24c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d0:	e8 3f fb ff ff       	call   2014 <printf>
        return 0;
    24d5:	b8 00 00 00 00       	mov    $0x0,%eax
    24da:	eb 2a                	jmp    2506 <thread_create+0xcb>
    }
    if(tid > 0){
    24dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24e0:	7e 05                	jle    24e7 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    24e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24e5:	eb 1f                	jmp    2506 <thread_create+0xcb>
    }
    if(tid == 0){
    24e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24eb:	75 14                	jne    2501 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    24ed:	c7 44 24 04 89 29 00 	movl   $0x2989,0x4(%esp)
    24f4:	00 
    24f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24fc:	e8 13 fb ff ff       	call   2014 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    2501:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2506:	c9                   	leave  
    2507:	c3                   	ret    

00002508 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    2508:	55                   	push   %ebp
    2509:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    250b:	a1 10 2e 00 00       	mov    0x2e10,%eax
    2510:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    2516:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    251b:	a3 10 2e 00 00       	mov    %eax,0x2e10
    return (int)(rands % max);
    2520:	a1 10 2e 00 00       	mov    0x2e10,%eax
    2525:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2528:	ba 00 00 00 00       	mov    $0x0,%edx
    252d:	f7 f1                	div    %ecx
    252f:	89 d0                	mov    %edx,%eax
}
    2531:	5d                   	pop    %ebp
    2532:	c3                   	ret    
    2533:	90                   	nop

00002534 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    2534:	55                   	push   %ebp
    2535:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    2537:	8b 45 08             	mov    0x8(%ebp),%eax
    253a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2540:	8b 45 08             	mov    0x8(%ebp),%eax
    2543:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    254a:	8b 45 08             	mov    0x8(%ebp),%eax
    254d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    2554:	5d                   	pop    %ebp
    2555:	c3                   	ret    

00002556 <add_q>:

void add_q(struct queue *q, int v){
    2556:	55                   	push   %ebp
    2557:	89 e5                	mov    %esp,%ebp
    2559:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    255c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2563:	e8 8f fd ff ff       	call   22f7 <malloc>
    2568:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    256b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    256e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2575:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2578:	8b 55 0c             	mov    0xc(%ebp),%edx
    257b:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    257d:	8b 45 08             	mov    0x8(%ebp),%eax
    2580:	8b 40 04             	mov    0x4(%eax),%eax
    2583:	85 c0                	test   %eax,%eax
    2585:	75 0b                	jne    2592 <add_q+0x3c>
        q->head = n;
    2587:	8b 45 08             	mov    0x8(%ebp),%eax
    258a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    258d:	89 50 04             	mov    %edx,0x4(%eax)
    2590:	eb 0c                	jmp    259e <add_q+0x48>
    }else{
        q->tail->next = n;
    2592:	8b 45 08             	mov    0x8(%ebp),%eax
    2595:	8b 40 08             	mov    0x8(%eax),%eax
    2598:	8b 55 f4             	mov    -0xc(%ebp),%edx
    259b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    259e:	8b 45 08             	mov    0x8(%ebp),%eax
    25a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    25a4:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    25a7:	8b 45 08             	mov    0x8(%ebp),%eax
    25aa:	8b 00                	mov    (%eax),%eax
    25ac:	8d 50 01             	lea    0x1(%eax),%edx
    25af:	8b 45 08             	mov    0x8(%ebp),%eax
    25b2:	89 10                	mov    %edx,(%eax)
}
    25b4:	c9                   	leave  
    25b5:	c3                   	ret    

000025b6 <empty_q>:

int empty_q(struct queue *q){
    25b6:	55                   	push   %ebp
    25b7:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    25b9:	8b 45 08             	mov    0x8(%ebp),%eax
    25bc:	8b 00                	mov    (%eax),%eax
    25be:	85 c0                	test   %eax,%eax
    25c0:	75 07                	jne    25c9 <empty_q+0x13>
        return 1;
    25c2:	b8 01 00 00 00       	mov    $0x1,%eax
    25c7:	eb 05                	jmp    25ce <empty_q+0x18>
    else
        return 0;
    25c9:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    25ce:	5d                   	pop    %ebp
    25cf:	c3                   	ret    

000025d0 <pop_q>:
int pop_q(struct queue *q){
    25d0:	55                   	push   %ebp
    25d1:	89 e5                	mov    %esp,%ebp
    25d3:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    25d6:	8b 45 08             	mov    0x8(%ebp),%eax
    25d9:	89 04 24             	mov    %eax,(%esp)
    25dc:	e8 d5 ff ff ff       	call   25b6 <empty_q>
    25e1:	85 c0                	test   %eax,%eax
    25e3:	75 5d                	jne    2642 <pop_q+0x72>
       val = q->head->value; 
    25e5:	8b 45 08             	mov    0x8(%ebp),%eax
    25e8:	8b 40 04             	mov    0x4(%eax),%eax
    25eb:	8b 00                	mov    (%eax),%eax
    25ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    25f0:	8b 45 08             	mov    0x8(%ebp),%eax
    25f3:	8b 40 04             	mov    0x4(%eax),%eax
    25f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    25f9:	8b 45 08             	mov    0x8(%ebp),%eax
    25fc:	8b 40 04             	mov    0x4(%eax),%eax
    25ff:	8b 50 04             	mov    0x4(%eax),%edx
    2602:	8b 45 08             	mov    0x8(%ebp),%eax
    2605:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    2608:	8b 45 f0             	mov    -0x10(%ebp),%eax
    260b:	89 04 24             	mov    %eax,(%esp)
    260e:	e8 b5 fb ff ff       	call   21c8 <free>
       q->size--;
    2613:	8b 45 08             	mov    0x8(%ebp),%eax
    2616:	8b 00                	mov    (%eax),%eax
    2618:	8d 50 ff             	lea    -0x1(%eax),%edx
    261b:	8b 45 08             	mov    0x8(%ebp),%eax
    261e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    2620:	8b 45 08             	mov    0x8(%ebp),%eax
    2623:	8b 00                	mov    (%eax),%eax
    2625:	85 c0                	test   %eax,%eax
    2627:	75 14                	jne    263d <pop_q+0x6d>
            q->head = 0;
    2629:	8b 45 08             	mov    0x8(%ebp),%eax
    262c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    2633:	8b 45 08             	mov    0x8(%ebp),%eax
    2636:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    263d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2640:	eb 05                	jmp    2647 <pop_q+0x77>
    }
    return -1;
    2642:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2647:	c9                   	leave  
    2648:	c3                   	ret    
