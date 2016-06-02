
_h2o:     file format elf32-i386


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
    102f:	e8 7f 12 00 00       	call   22b3 <malloc>
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
    10da:	e8 a5 10 00 00       	call   2184 <free>
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
    1143:	e8 66 12 00 00       	call   23ae <lock_init>
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
    1162:	e8 55 12 00 00       	call   23bc <lock_acquire>
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
    117d:	e8 59 12 00 00       	call   23db <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 2a 12 00 00       	call   23bc <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 1d 0d 00 00       	call   1eb4 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 24 12 00 00       	call   23db <lock_release>
    tsleep();
    11b7:	e8 28 0d 00 00       	call   1ee4 <tsleep>
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
    11e7:	e8 d0 11 00 00       	call   23bc <lock_acquire>
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
    1202:	e8 d4 11 00 00       	call   23db <lock_release>
		
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
    122a:	e8 bd 0c 00 00       	call   1eec <twakeup>
		}
	}
}
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <main>:
int i;

void hReady();
void oReady();

int main(){
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 e4 f0             	and    $0xfffffff0,%esp
    1237:	83 ec 10             	sub    $0x10,%esp
	h = malloc(sizeof(struct Semaphore));
    123a:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1241:	e8 6d 10 00 00       	call   22b3 <malloc>
    1246:	a3 fc 28 00 00       	mov    %eax,0x28fc
	o = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 5c 10 00 00       	call   22b3 <malloc>
    1257:	a3 00 29 00 00       	mov    %eax,0x2900
	p = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 4b 10 00 00       	call   22b3 <malloc>
    1268:	a3 04 29 00 00       	mov    %eax,0x2904
	sem_init(p, 1);
    126d:	a1 04 29 00 00       	mov    0x2904,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>

	// Test 1: 2 hydrogen 1 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    1282:	a1 04 29 00 00       	mov    0x2904,%eax
    1287:	89 04 24             	mov    %eax,(%esp)
    128a:	e8 bb fe ff ff       	call   114a <sem_acquire>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
    128f:	c7 44 24 04 08 26 00 	movl   $0x2608,0x4(%esp)
    1296:	00 
    1297:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129e:	e8 2a 0d 00 00       	call   1fcd <printf>
	sem_signal(p);
    12a3:	a1 04 29 00 00       	mov    0x2904,%eax
    12a8:	89 04 24             	mov    %eax,(%esp)
    12ab:	e8 19 ff ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    12b0:	a1 fc 28 00 00       	mov    0x28fc,%eax
    12b5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12bc:	00 
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 50 fe ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    12c5:	a1 00 29 00 00       	mov    0x2900,%eax
    12ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 3b fe ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 1; water++){
    12da:	c7 05 14 29 00 00 00 	movl   $0x0,0x2914
    12e1:	00 00 00 
    12e4:	e9 7b 01 00 00       	jmp    1464 <main+0x233>
		tid = thread_create(hReady, (void *) &arg);
    12e9:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    12f0:	00 
    12f1:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    12f8:	e8 f9 10 00 00       	call   23f6 <thread_create>
    12fd:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    1302:	a1 1c 29 00 00       	mov    0x291c,%eax
    1307:	85 c0                	test   %eax,%eax
    1309:	75 33                	jne    133e <main+0x10d>
			sem_acquire(p);
    130b:	a1 04 29 00 00       	mov    0x2904,%eax
    1310:	89 04 24             	mov    %eax,(%esp)
    1313:	e8 32 fe ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1318:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    131f:	00 
    1320:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1327:	e8 a1 0c 00 00       	call   1fcd <printf>
			sem_signal(p);
    132c:	a1 04 29 00 00       	mov    0x2904,%eax
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 90 fe ff ff       	call   11c9 <sem_signal>
			exit();
    1339:	e8 f6 0a 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    133e:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1345:	00 00 00 
    1348:	eb 0d                	jmp    1357 <main+0x126>
    134a:	a1 18 29 00 00       	mov    0x2918,%eax
    134f:	83 c0 01             	add    $0x1,%eax
    1352:	a3 18 29 00 00       	mov    %eax,0x2918
    1357:	a1 18 29 00 00       	mov    0x2918,%eax
    135c:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1361:	7e e7                	jle    134a <main+0x119>
		tid = thread_create(hReady, (void *) &arg);
    1363:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    136a:	00 
    136b:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    1372:	e8 7f 10 00 00       	call   23f6 <thread_create>
    1377:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    137c:	a1 1c 29 00 00       	mov    0x291c,%eax
    1381:	85 c0                	test   %eax,%eax
    1383:	75 33                	jne    13b8 <main+0x187>
			sem_acquire(p);
    1385:	a1 04 29 00 00       	mov    0x2904,%eax
    138a:	89 04 24             	mov    %eax,(%esp)
    138d:	e8 b8 fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1392:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1399:	00 
    139a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a1:	e8 27 0c 00 00       	call   1fcd <printf>
			sem_signal(p);
    13a6:	a1 04 29 00 00       	mov    0x2904,%eax
    13ab:	89 04 24             	mov    %eax,(%esp)
    13ae:	e8 16 fe ff ff       	call   11c9 <sem_signal>
			exit();
    13b3:	e8 7c 0a 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    13b8:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    13bf:	00 00 00 
    13c2:	eb 0d                	jmp    13d1 <main+0x1a0>
    13c4:	a1 18 29 00 00       	mov    0x2918,%eax
    13c9:	83 c0 01             	add    $0x1,%eax
    13cc:	a3 18 29 00 00       	mov    %eax,0x2918
    13d1:	a1 18 29 00 00       	mov    0x2918,%eax
    13d6:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13db:	7e e7                	jle    13c4 <main+0x193>
		tid = thread_create(oReady, (void *) &arg);
    13dd:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    13e4:	00 
    13e5:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    13ec:	e8 05 10 00 00       	call   23f6 <thread_create>
    13f1:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    13f6:	a1 1c 29 00 00       	mov    0x291c,%eax
    13fb:	85 c0                	test   %eax,%eax
    13fd:	75 33                	jne    1432 <main+0x201>
			sem_acquire(p);
    13ff:	a1 04 29 00 00       	mov    0x2904,%eax
    1404:	89 04 24             	mov    %eax,(%esp)
    1407:	e8 3e fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    140c:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1413:	00 
    1414:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141b:	e8 ad 0b 00 00       	call   1fcd <printf>
			sem_signal(p);
    1420:	a1 04 29 00 00       	mov    0x2904,%eax
    1425:	89 04 24             	mov    %eax,(%esp)
    1428:	e8 9c fd ff ff       	call   11c9 <sem_signal>
			exit();
    142d:	e8 02 0a 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    1432:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1439:	00 00 00 
    143c:	eb 0d                	jmp    144b <main+0x21a>
    143e:	a1 18 29 00 00       	mov    0x2918,%eax
    1443:	83 c0 01             	add    $0x1,%eax
    1446:	a3 18 29 00 00       	mov    %eax,0x2918
    144b:	a1 18 29 00 00       	mov    0x2918,%eax
    1450:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1455:	7e e7                	jle    143e <main+0x20d>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 1; water++){
    1457:	a1 14 29 00 00       	mov    0x2914,%eax
    145c:	83 c0 01             	add    $0x1,%eax
    145f:	a3 14 29 00 00       	mov    %eax,0x2914
    1464:	a1 14 29 00 00       	mov    0x2914,%eax
    1469:	85 c0                	test   %eax,%eax
    146b:	0f 8e 78 fe ff ff    	jle    12e9 <main+0xb8>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1471:	90                   	nop
    1472:	e8 c5 09 00 00       	call   1e3c <wait>
    1477:	85 c0                	test   %eax,%eax
    1479:	79 f7                	jns    1472 <main+0x241>
	
	// Test 2: 20 hydrogen 10 oxygen (Thread creation order: O->H->H)
	sem_acquire(p);
    147b:	a1 04 29 00 00       	mov    0x2904,%eax
    1480:	89 04 24             	mov    %eax,(%esp)
    1483:	e8 c2 fc ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
    1488:	c7 44 24 04 64 26 00 	movl   $0x2664,0x4(%esp)
    148f:	00 
    1490:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1497:	e8 31 0b 00 00       	call   1fcd <printf>
	sem_signal(p);
    149c:	a1 04 29 00 00       	mov    0x2904,%eax
    14a1:	89 04 24             	mov    %eax,(%esp)
    14a4:	e8 20 fd ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    14a9:	a1 fc 28 00 00       	mov    0x28fc,%eax
    14ae:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    14b5:	00 
    14b6:	89 04 24             	mov    %eax,(%esp)
    14b9:	e8 57 fc ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    14be:	a1 00 29 00 00       	mov    0x2900,%eax
    14c3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    14ca:	00 
    14cb:	89 04 24             	mov    %eax,(%esp)
    14ce:	e8 42 fc ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    14d3:	c7 05 14 29 00 00 00 	movl   $0x0,0x2914
    14da:	00 00 00 
    14dd:	e9 7b 01 00 00       	jmp    165d <main+0x42c>
		tid = thread_create(oReady, (void *) &arg);
    14e2:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    14e9:	00 
    14ea:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    14f1:	e8 00 0f 00 00       	call   23f6 <thread_create>
    14f6:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    14fb:	a1 1c 29 00 00       	mov    0x291c,%eax
    1500:	85 c0                	test   %eax,%eax
    1502:	75 33                	jne    1537 <main+0x306>
			sem_acquire(p);
    1504:	a1 04 29 00 00       	mov    0x2904,%eax
    1509:	89 04 24             	mov    %eax,(%esp)
    150c:	e8 39 fc ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1511:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1518:	00 
    1519:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1520:	e8 a8 0a 00 00       	call   1fcd <printf>
			sem_signal(p);
    1525:	a1 04 29 00 00       	mov    0x2904,%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 97 fc ff ff       	call   11c9 <sem_signal>
			exit();
    1532:	e8 fd 08 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    1537:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    153e:	00 00 00 
    1541:	eb 0d                	jmp    1550 <main+0x31f>
    1543:	a1 18 29 00 00       	mov    0x2918,%eax
    1548:	83 c0 01             	add    $0x1,%eax
    154b:	a3 18 29 00 00       	mov    %eax,0x2918
    1550:	a1 18 29 00 00       	mov    0x2918,%eax
    1555:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    155a:	7e e7                	jle    1543 <main+0x312>
		tid = thread_create(hReady, (void *) &arg);
    155c:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    1563:	00 
    1564:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    156b:	e8 86 0e 00 00       	call   23f6 <thread_create>
    1570:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    1575:	a1 1c 29 00 00       	mov    0x291c,%eax
    157a:	85 c0                	test   %eax,%eax
    157c:	75 33                	jne    15b1 <main+0x380>
			sem_acquire(p);
    157e:	a1 04 29 00 00       	mov    0x2904,%eax
    1583:	89 04 24             	mov    %eax,(%esp)
    1586:	e8 bf fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    158b:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1592:	00 
    1593:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159a:	e8 2e 0a 00 00       	call   1fcd <printf>
			sem_signal(p);
    159f:	a1 04 29 00 00       	mov    0x2904,%eax
    15a4:	89 04 24             	mov    %eax,(%esp)
    15a7:	e8 1d fc ff ff       	call   11c9 <sem_signal>
			exit();
    15ac:	e8 83 08 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    15b1:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    15b8:	00 00 00 
    15bb:	eb 0d                	jmp    15ca <main+0x399>
    15bd:	a1 18 29 00 00       	mov    0x2918,%eax
    15c2:	83 c0 01             	add    $0x1,%eax
    15c5:	a3 18 29 00 00       	mov    %eax,0x2918
    15ca:	a1 18 29 00 00       	mov    0x2918,%eax
    15cf:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15d4:	7e e7                	jle    15bd <main+0x38c>
		tid = thread_create(hReady, (void *) &arg);
    15d6:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    15dd:	00 
    15de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    15e5:	e8 0c 0e 00 00       	call   23f6 <thread_create>
    15ea:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    15ef:	a1 1c 29 00 00       	mov    0x291c,%eax
    15f4:	85 c0                	test   %eax,%eax
    15f6:	75 33                	jne    162b <main+0x3fa>
			sem_acquire(p);
    15f8:	a1 04 29 00 00       	mov    0x2904,%eax
    15fd:	89 04 24             	mov    %eax,(%esp)
    1600:	e8 45 fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1605:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    160c:	00 
    160d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1614:	e8 b4 09 00 00       	call   1fcd <printf>
			sem_signal(p);
    1619:	a1 04 29 00 00       	mov    0x2904,%eax
    161e:	89 04 24             	mov    %eax,(%esp)
    1621:	e8 a3 fb ff ff       	call   11c9 <sem_signal>
			exit();
    1626:	e8 09 08 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    162b:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1632:	00 00 00 
    1635:	eb 0d                	jmp    1644 <main+0x413>
    1637:	a1 18 29 00 00       	mov    0x2918,%eax
    163c:	83 c0 01             	add    $0x1,%eax
    163f:	a3 18 29 00 00       	mov    %eax,0x2918
    1644:	a1 18 29 00 00       	mov    0x2918,%eax
    1649:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    164e:	7e e7                	jle    1637 <main+0x406>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1650:	a1 14 29 00 00       	mov    0x2914,%eax
    1655:	83 c0 01             	add    $0x1,%eax
    1658:	a3 14 29 00 00       	mov    %eax,0x2914
    165d:	a1 14 29 00 00       	mov    0x2914,%eax
    1662:	83 f8 09             	cmp    $0x9,%eax
    1665:	0f 8e 77 fe ff ff    	jle    14e2 <main+0x2b1>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    166b:	90                   	nop
    166c:	e8 cb 07 00 00       	call   1e3c <wait>
    1671:	85 c0                	test   %eax,%eax
    1673:	79 f7                	jns    166c <main+0x43b>
	
	// Test 3: 20 hydrogen 10 oxygen (Thread creation order: H->O->H)
	sem_acquire(p);
    1675:	a1 04 29 00 00       	mov    0x2904,%eax
    167a:	89 04 24             	mov    %eax,(%esp)
    167d:	e8 c8 fa ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
    1682:	c7 44 24 04 a8 26 00 	movl   $0x26a8,0x4(%esp)
    1689:	00 
    168a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1691:	e8 37 09 00 00       	call   1fcd <printf>
	sem_signal(p);
    1696:	a1 04 29 00 00       	mov    0x2904,%eax
    169b:	89 04 24             	mov    %eax,(%esp)
    169e:	e8 26 fb ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    16a3:	a1 fc 28 00 00       	mov    0x28fc,%eax
    16a8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    16af:	00 
    16b0:	89 04 24             	mov    %eax,(%esp)
    16b3:	e8 5d fa ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    16b8:	a1 00 29 00 00       	mov    0x2900,%eax
    16bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    16c4:	00 
    16c5:	89 04 24             	mov    %eax,(%esp)
    16c8:	e8 48 fa ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    16cd:	c7 05 14 29 00 00 00 	movl   $0x0,0x2914
    16d4:	00 00 00 
    16d7:	e9 7b 01 00 00       	jmp    1857 <main+0x626>
		tid = thread_create(hReady, (void *) &arg);
    16dc:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    16e3:	00 
    16e4:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    16eb:	e8 06 0d 00 00       	call   23f6 <thread_create>
    16f0:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    16f5:	a1 1c 29 00 00       	mov    0x291c,%eax
    16fa:	85 c0                	test   %eax,%eax
    16fc:	75 33                	jne    1731 <main+0x500>
			sem_acquire(p);
    16fe:	a1 04 29 00 00       	mov    0x2904,%eax
    1703:	89 04 24             	mov    %eax,(%esp)
    1706:	e8 3f fa ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    170b:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1712:	00 
    1713:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    171a:	e8 ae 08 00 00       	call   1fcd <printf>
			sem_signal(p);
    171f:	a1 04 29 00 00       	mov    0x2904,%eax
    1724:	89 04 24             	mov    %eax,(%esp)
    1727:	e8 9d fa ff ff       	call   11c9 <sem_signal>
			exit();
    172c:	e8 03 07 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    1731:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1738:	00 00 00 
    173b:	eb 0d                	jmp    174a <main+0x519>
    173d:	a1 18 29 00 00       	mov    0x2918,%eax
    1742:	83 c0 01             	add    $0x1,%eax
    1745:	a3 18 29 00 00       	mov    %eax,0x2918
    174a:	a1 18 29 00 00       	mov    0x2918,%eax
    174f:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1754:	7e e7                	jle    173d <main+0x50c>
		tid = thread_create(oReady, (void *) &arg);
    1756:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    175d:	00 
    175e:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    1765:	e8 8c 0c 00 00       	call   23f6 <thread_create>
    176a:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    176f:	a1 1c 29 00 00       	mov    0x291c,%eax
    1774:	85 c0                	test   %eax,%eax
    1776:	75 33                	jne    17ab <main+0x57a>
			sem_acquire(p);
    1778:	a1 04 29 00 00       	mov    0x2904,%eax
    177d:	89 04 24             	mov    %eax,(%esp)
    1780:	e8 c5 f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1785:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    178c:	00 
    178d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1794:	e8 34 08 00 00       	call   1fcd <printf>
			sem_signal(p);
    1799:	a1 04 29 00 00       	mov    0x2904,%eax
    179e:	89 04 24             	mov    %eax,(%esp)
    17a1:	e8 23 fa ff ff       	call   11c9 <sem_signal>
			exit();
    17a6:	e8 89 06 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    17ab:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    17b2:	00 00 00 
    17b5:	eb 0d                	jmp    17c4 <main+0x593>
    17b7:	a1 18 29 00 00       	mov    0x2918,%eax
    17bc:	83 c0 01             	add    $0x1,%eax
    17bf:	a3 18 29 00 00       	mov    %eax,0x2918
    17c4:	a1 18 29 00 00       	mov    0x2918,%eax
    17c9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17ce:	7e e7                	jle    17b7 <main+0x586>
		tid = thread_create(hReady, (void *) &arg);
    17d0:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    17d7:	00 
    17d8:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    17df:	e8 12 0c 00 00       	call   23f6 <thread_create>
    17e4:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    17e9:	a1 1c 29 00 00       	mov    0x291c,%eax
    17ee:	85 c0                	test   %eax,%eax
    17f0:	75 33                	jne    1825 <main+0x5f4>
			sem_acquire(p);
    17f2:	a1 04 29 00 00       	mov    0x2904,%eax
    17f7:	89 04 24             	mov    %eax,(%esp)
    17fa:	e8 4b f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    17ff:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1806:	00 
    1807:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    180e:	e8 ba 07 00 00       	call   1fcd <printf>
			sem_signal(p);
    1813:	a1 04 29 00 00       	mov    0x2904,%eax
    1818:	89 04 24             	mov    %eax,(%esp)
    181b:	e8 a9 f9 ff ff       	call   11c9 <sem_signal>
			exit();
    1820:	e8 0f 06 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    1825:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    182c:	00 00 00 
    182f:	eb 0d                	jmp    183e <main+0x60d>
    1831:	a1 18 29 00 00       	mov    0x2918,%eax
    1836:	83 c0 01             	add    $0x1,%eax
    1839:	a3 18 29 00 00       	mov    %eax,0x2918
    183e:	a1 18 29 00 00       	mov    0x2918,%eax
    1843:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1848:	7e e7                	jle    1831 <main+0x600>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    184a:	a1 14 29 00 00       	mov    0x2914,%eax
    184f:	83 c0 01             	add    $0x1,%eax
    1852:	a3 14 29 00 00       	mov    %eax,0x2914
    1857:	a1 14 29 00 00       	mov    0x2914,%eax
    185c:	83 f8 09             	cmp    $0x9,%eax
    185f:	0f 8e 77 fe ff ff    	jle    16dc <main+0x4ab>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1865:	90                   	nop
    1866:	e8 d1 05 00 00       	call   1e3c <wait>
    186b:	85 c0                	test   %eax,%eax
    186d:	79 f7                	jns    1866 <main+0x635>
	
	// Test 4: 20 hydrogen 10 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    186f:	a1 04 29 00 00       	mov    0x2904,%eax
    1874:	89 04 24             	mov    %eax,(%esp)
    1877:	e8 ce f8 ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
    187c:	c7 44 24 04 ec 26 00 	movl   $0x26ec,0x4(%esp)
    1883:	00 
    1884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    188b:	e8 3d 07 00 00       	call   1fcd <printf>
	sem_signal(p);
    1890:	a1 04 29 00 00       	mov    0x2904,%eax
    1895:	89 04 24             	mov    %eax,(%esp)
    1898:	e8 2c f9 ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    189d:	a1 fc 28 00 00       	mov    0x28fc,%eax
    18a2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    18a9:	00 
    18aa:	89 04 24             	mov    %eax,(%esp)
    18ad:	e8 63 f8 ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    18b2:	a1 00 29 00 00       	mov    0x2900,%eax
    18b7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18be:	00 
    18bf:	89 04 24             	mov    %eax,(%esp)
    18c2:	e8 4e f8 ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    18c7:	c7 05 14 29 00 00 00 	movl   $0x0,0x2914
    18ce:	00 00 00 
    18d1:	e9 7b 01 00 00       	jmp    1a51 <main+0x820>
		tid = thread_create(hReady, (void *) &arg);
    18d6:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    18dd:	00 
    18de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    18e5:	e8 0c 0b 00 00       	call   23f6 <thread_create>
    18ea:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    18ef:	a1 1c 29 00 00       	mov    0x291c,%eax
    18f4:	85 c0                	test   %eax,%eax
    18f6:	75 33                	jne    192b <main+0x6fa>
			sem_acquire(p);
    18f8:	a1 04 29 00 00       	mov    0x2904,%eax
    18fd:	89 04 24             	mov    %eax,(%esp)
    1900:	e8 45 f8 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1905:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    190c:	00 
    190d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1914:	e8 b4 06 00 00       	call   1fcd <printf>
			sem_signal(p);
    1919:	a1 04 29 00 00       	mov    0x2904,%eax
    191e:	89 04 24             	mov    %eax,(%esp)
    1921:	e8 a3 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    1926:	e8 09 05 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    192b:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1932:	00 00 00 
    1935:	eb 0d                	jmp    1944 <main+0x713>
    1937:	a1 18 29 00 00       	mov    0x2918,%eax
    193c:	83 c0 01             	add    $0x1,%eax
    193f:	a3 18 29 00 00       	mov    %eax,0x2918
    1944:	a1 18 29 00 00       	mov    0x2918,%eax
    1949:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    194e:	7e e7                	jle    1937 <main+0x706>
		tid = thread_create(hReady, (void *) &arg);
    1950:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    1957:	00 
    1958:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    195f:	e8 92 0a 00 00       	call   23f6 <thread_create>
    1964:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    1969:	a1 1c 29 00 00       	mov    0x291c,%eax
    196e:	85 c0                	test   %eax,%eax
    1970:	75 33                	jne    19a5 <main+0x774>
			sem_acquire(p);
    1972:	a1 04 29 00 00       	mov    0x2904,%eax
    1977:	89 04 24             	mov    %eax,(%esp)
    197a:	e8 cb f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    197f:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1986:	00 
    1987:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198e:	e8 3a 06 00 00       	call   1fcd <printf>
			sem_signal(p);
    1993:	a1 04 29 00 00       	mov    0x2904,%eax
    1998:	89 04 24             	mov    %eax,(%esp)
    199b:	e8 29 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    19a0:	e8 8f 04 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    19a5:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    19ac:	00 00 00 
    19af:	eb 0d                	jmp    19be <main+0x78d>
    19b1:	a1 18 29 00 00       	mov    0x2918,%eax
    19b6:	83 c0 01             	add    $0x1,%eax
    19b9:	a3 18 29 00 00       	mov    %eax,0x2918
    19be:	a1 18 29 00 00       	mov    0x2918,%eax
    19c3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    19c8:	7e e7                	jle    19b1 <main+0x780>
		tid = thread_create(oReady, (void *) &arg);
    19ca:	c7 44 24 04 e0 28 00 	movl   $0x28e0,0x4(%esp)
    19d1:	00 
    19d2:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    19d9:	e8 18 0a 00 00       	call   23f6 <thread_create>
    19de:	a3 1c 29 00 00       	mov    %eax,0x291c
		if(tid <= 0){
    19e3:	a1 1c 29 00 00       	mov    0x291c,%eax
    19e8:	85 c0                	test   %eax,%eax
    19ea:	75 33                	jne    1a1f <main+0x7ee>
			sem_acquire(p);
    19ec:	a1 04 29 00 00       	mov    0x2904,%eax
    19f1:	89 04 24             	mov    %eax,(%esp)
    19f4:	e8 51 f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    19f9:	c7 44 24 04 49 26 00 	movl   $0x2649,0x4(%esp)
    1a00:	00 
    1a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a08:	e8 c0 05 00 00       	call   1fcd <printf>
			sem_signal(p);
    1a0d:	a1 04 29 00 00       	mov    0x2904,%eax
    1a12:	89 04 24             	mov    %eax,(%esp)
    1a15:	e8 af f7 ff ff       	call   11c9 <sem_signal>
			exit();
    1a1a:	e8 15 04 00 00       	call   1e34 <exit>
		}
		for(i = 0; i < 999999; i++);
    1a1f:	c7 05 18 29 00 00 00 	movl   $0x0,0x2918
    1a26:	00 00 00 
    1a29:	eb 0d                	jmp    1a38 <main+0x807>
    1a2b:	a1 18 29 00 00       	mov    0x2918,%eax
    1a30:	83 c0 01             	add    $0x1,%eax
    1a33:	a3 18 29 00 00       	mov    %eax,0x2918
    1a38:	a1 18 29 00 00       	mov    0x2918,%eax
    1a3d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1a42:	7e e7                	jle    1a2b <main+0x7fa>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1a44:	a1 14 29 00 00       	mov    0x2914,%eax
    1a49:	83 c0 01             	add    $0x1,%eax
    1a4c:	a3 14 29 00 00       	mov    %eax,0x2914
    1a51:	a1 14 29 00 00       	mov    0x2914,%eax
    1a56:	83 f8 09             	cmp    $0x9,%eax
    1a59:	0f 8e 77 fe ff ff    	jle    18d6 <main+0x6a5>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1a5f:	90                   	nop
    1a60:	e8 d7 03 00 00       	call   1e3c <wait>
    1a65:	85 c0                	test   %eax,%eax
    1a67:	79 f7                	jns    1a60 <main+0x82f>
	
	exit();
    1a69:	e8 c6 03 00 00       	call   1e34 <exit>

00001a6e <hReady>:
	return 0;
}

//Hydrogen
void hReady(){
    1a6e:	55                   	push   %ebp
    1a6f:	89 e5                	mov    %esp,%ebp
    1a71:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1a74:	a1 04 29 00 00       	mov    0x2904,%eax
    1a79:	89 04 24             	mov    %eax,(%esp)
    1a7c:	e8 c9 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Hydrogen ready\n");
    1a81:	c7 44 24 04 30 27 00 	movl   $0x2730,0x4(%esp)
    1a88:	00 
    1a89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a90:	e8 38 05 00 00       	call   1fcd <printf>
	sem_signal(p);
    1a95:	a1 04 29 00 00       	mov    0x2904,%eax
    1a9a:	89 04 24             	mov    %eax,(%esp)
    1a9d:	e8 27 f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(h);
    1aa2:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1aa7:	89 04 24             	mov    %eax,(%esp)
    1aaa:	e8 9b f6 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1aaf:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1ab4:	8b 00                	mov    (%eax),%eax
    1ab6:	85 c0                	test   %eax,%eax
    1ab8:	75 60                	jne    1b1a <hReady+0xac>
    1aba:	a1 00 29 00 00       	mov    0x2900,%eax
    1abf:	8b 00                	mov    (%eax),%eax
    1ac1:	85 c0                	test   %eax,%eax
    1ac3:	75 55                	jne    1b1a <hReady+0xac>
		sem_acquire(p);
    1ac5:	a1 04 29 00 00       	mov    0x2904,%eax
    1aca:	89 04 24             	mov    %eax,(%esp)
    1acd:	e8 78 f6 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1ad2:	c7 44 24 04 40 27 00 	movl   $0x2740,0x4(%esp)
    1ad9:	00 
    1ada:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae1:	e8 e7 04 00 00       	call   1fcd <printf>
		sem_signal(p);
    1ae6:	a1 04 29 00 00       	mov    0x2904,%eax
    1aeb:	89 04 24             	mov    %eax,(%esp)
    1aee:	e8 d6 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1af3:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1af8:	89 04 24             	mov    %eax,(%esp)
    1afb:	e8 c9 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1b00:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1b05:	89 04 24             	mov    %eax,(%esp)
    1b08:	e8 bc f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1b0d:	a1 00 29 00 00       	mov    0x2900,%eax
    1b12:	89 04 24             	mov    %eax,(%esp)
    1b15:	e8 af f6 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1b1a:	e8 bd 03 00 00       	call   1edc <texit>

00001b1f <oReady>:
}

//Oxygen 
void oReady(){
    1b1f:	55                   	push   %ebp
    1b20:	89 e5                	mov    %esp,%ebp
    1b22:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1b25:	a1 04 29 00 00       	mov    0x2904,%eax
    1b2a:	89 04 24             	mov    %eax,(%esp)
    1b2d:	e8 18 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Oxygen ready\n");
    1b32:	c7 44 24 04 51 27 00 	movl   $0x2751,0x4(%esp)
    1b39:	00 
    1b3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b41:	e8 87 04 00 00       	call   1fcd <printf>
	sem_signal(p);
    1b46:	a1 04 29 00 00       	mov    0x2904,%eax
    1b4b:	89 04 24             	mov    %eax,(%esp)
    1b4e:	e8 76 f6 ff ff       	call   11c9 <sem_signal>
	sem_acquire(o);
    1b53:	a1 00 29 00 00       	mov    0x2900,%eax
    1b58:	89 04 24             	mov    %eax,(%esp)
    1b5b:	e8 ea f5 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1b60:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1b65:	8b 00                	mov    (%eax),%eax
    1b67:	85 c0                	test   %eax,%eax
    1b69:	75 60                	jne    1bcb <oReady+0xac>
    1b6b:	a1 00 29 00 00       	mov    0x2900,%eax
    1b70:	8b 00                	mov    (%eax),%eax
    1b72:	85 c0                	test   %eax,%eax
    1b74:	75 55                	jne    1bcb <oReady+0xac>
		sem_acquire(p);
    1b76:	a1 04 29 00 00       	mov    0x2904,%eax
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 c7 f5 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1b83:	c7 44 24 04 40 27 00 	movl   $0x2740,0x4(%esp)
    1b8a:	00 
    1b8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b92:	e8 36 04 00 00       	call   1fcd <printf>
		sem_signal(p);
    1b97:	a1 04 29 00 00       	mov    0x2904,%eax
    1b9c:	89 04 24             	mov    %eax,(%esp)
    1b9f:	e8 25 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1ba4:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1ba9:	89 04 24             	mov    %eax,(%esp)
    1bac:	e8 18 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1bb1:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1bb6:	89 04 24             	mov    %eax,(%esp)
    1bb9:	e8 0b f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1bbe:	a1 00 29 00 00       	mov    0x2900,%eax
    1bc3:	89 04 24             	mov    %eax,(%esp)
    1bc6:	e8 fe f5 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1bcb:	e8 0c 03 00 00       	call   1edc <texit>

00001bd0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1bd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bd8:	8b 55 10             	mov    0x10(%ebp),%edx
    1bdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bde:	89 cb                	mov    %ecx,%ebx
    1be0:	89 df                	mov    %ebx,%edi
    1be2:	89 d1                	mov    %edx,%ecx
    1be4:	fc                   	cld    
    1be5:	f3 aa                	rep stos %al,%es:(%edi)
    1be7:	89 ca                	mov    %ecx,%edx
    1be9:	89 fb                	mov    %edi,%ebx
    1beb:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1bee:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1bf1:	5b                   	pop    %ebx
    1bf2:	5f                   	pop    %edi
    1bf3:	5d                   	pop    %ebp
    1bf4:	c3                   	ret    

00001bf5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1bf5:	55                   	push   %ebp
    1bf6:	89 e5                	mov    %esp,%ebp
    1bf8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1bfb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1c01:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c04:	0f b6 10             	movzbl (%eax),%edx
    1c07:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0a:	88 10                	mov    %dl,(%eax)
    1c0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0f:	0f b6 00             	movzbl (%eax),%eax
    1c12:	84 c0                	test   %al,%al
    1c14:	0f 95 c0             	setne  %al
    1c17:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c1b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1c1f:	84 c0                	test   %al,%al
    1c21:	75 de                	jne    1c01 <strcpy+0xc>
    ;
  return os;
    1c23:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c26:	c9                   	leave  
    1c27:	c3                   	ret    

00001c28 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1c28:	55                   	push   %ebp
    1c29:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1c2b:	eb 08                	jmp    1c35 <strcmp+0xd>
    p++, q++;
    1c2d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c31:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	0f b6 00             	movzbl (%eax),%eax
    1c3b:	84 c0                	test   %al,%al
    1c3d:	74 10                	je     1c4f <strcmp+0x27>
    1c3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c42:	0f b6 10             	movzbl (%eax),%edx
    1c45:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c48:	0f b6 00             	movzbl (%eax),%eax
    1c4b:	38 c2                	cmp    %al,%dl
    1c4d:	74 de                	je     1c2d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1c4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c52:	0f b6 00             	movzbl (%eax),%eax
    1c55:	0f b6 d0             	movzbl %al,%edx
    1c58:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c5b:	0f b6 00             	movzbl (%eax),%eax
    1c5e:	0f b6 c0             	movzbl %al,%eax
    1c61:	89 d1                	mov    %edx,%ecx
    1c63:	29 c1                	sub    %eax,%ecx
    1c65:	89 c8                	mov    %ecx,%eax
}
    1c67:	5d                   	pop    %ebp
    1c68:	c3                   	ret    

00001c69 <strlen>:

uint
strlen(char *s)
{
    1c69:	55                   	push   %ebp
    1c6a:	89 e5                	mov    %esp,%ebp
    1c6c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1c6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1c76:	eb 04                	jmp    1c7c <strlen+0x13>
    1c78:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1c7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c7f:	03 45 08             	add    0x8(%ebp),%eax
    1c82:	0f b6 00             	movzbl (%eax),%eax
    1c85:	84 c0                	test   %al,%al
    1c87:	75 ef                	jne    1c78 <strlen+0xf>
    ;
  return n;
    1c89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c8c:	c9                   	leave  
    1c8d:	c3                   	ret    

00001c8e <memset>:

void*
memset(void *dst, int c, uint n)
{
    1c8e:	55                   	push   %ebp
    1c8f:	89 e5                	mov    %esp,%ebp
    1c91:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1c94:	8b 45 10             	mov    0x10(%ebp),%eax
    1c97:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c9e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ca2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca5:	89 04 24             	mov    %eax,(%esp)
    1ca8:	e8 23 ff ff ff       	call   1bd0 <stosb>
  return dst;
    1cad:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1cb0:	c9                   	leave  
    1cb1:	c3                   	ret    

00001cb2 <strchr>:

char*
strchr(const char *s, char c)
{
    1cb2:	55                   	push   %ebp
    1cb3:	89 e5                	mov    %esp,%ebp
    1cb5:	83 ec 04             	sub    $0x4,%esp
    1cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cbb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1cbe:	eb 14                	jmp    1cd4 <strchr+0x22>
    if(*s == c)
    1cc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc3:	0f b6 00             	movzbl (%eax),%eax
    1cc6:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1cc9:	75 05                	jne    1cd0 <strchr+0x1e>
      return (char*)s;
    1ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cce:	eb 13                	jmp    1ce3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1cd0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1cd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd7:	0f b6 00             	movzbl (%eax),%eax
    1cda:	84 c0                	test   %al,%al
    1cdc:	75 e2                	jne    1cc0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1cde:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ce3:	c9                   	leave  
    1ce4:	c3                   	ret    

00001ce5 <gets>:

char*
gets(char *buf, int max)
{
    1ce5:	55                   	push   %ebp
    1ce6:	89 e5                	mov    %esp,%ebp
    1ce8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1ceb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1cf2:	eb 44                	jmp    1d38 <gets+0x53>
    cc = read(0, &c, 1);
    1cf4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1cfb:	00 
    1cfc:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1cff:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d03:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d0a:	e8 3d 01 00 00       	call   1e4c <read>
    1d0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1d12:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d16:	7e 2d                	jle    1d45 <gets+0x60>
      break;
    buf[i++] = c;
    1d18:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d1b:	03 45 08             	add    0x8(%ebp),%eax
    1d1e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1d22:	88 10                	mov    %dl,(%eax)
    1d24:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1d28:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d2c:	3c 0a                	cmp    $0xa,%al
    1d2e:	74 16                	je     1d46 <gets+0x61>
    1d30:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d34:	3c 0d                	cmp    $0xd,%al
    1d36:	74 0e                	je     1d46 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d3b:	83 c0 01             	add    $0x1,%eax
    1d3e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d41:	7c b1                	jl     1cf4 <gets+0xf>
    1d43:	eb 01                	jmp    1d46 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1d45:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1d46:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d49:	03 45 08             	add    0x8(%ebp),%eax
    1d4c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1d4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1d52:	c9                   	leave  
    1d53:	c3                   	ret    

00001d54 <stat>:

int
stat(char *n, struct stat *st)
{
    1d54:	55                   	push   %ebp
    1d55:	89 e5                	mov    %esp,%ebp
    1d57:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1d5a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d61:	00 
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	89 04 24             	mov    %eax,(%esp)
    1d68:	e8 07 01 00 00       	call   1e74 <open>
    1d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1d70:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d74:	79 07                	jns    1d7d <stat+0x29>
    return -1;
    1d76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d7b:	eb 23                	jmp    1da0 <stat+0x4c>
  r = fstat(fd, st);
    1d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d80:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d84:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d87:	89 04 24             	mov    %eax,(%esp)
    1d8a:	e8 fd 00 00 00       	call   1e8c <fstat>
    1d8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1d92:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d95:	89 04 24             	mov    %eax,(%esp)
    1d98:	e8 bf 00 00 00       	call   1e5c <close>
  return r;
    1d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1da0:	c9                   	leave  
    1da1:	c3                   	ret    

00001da2 <atoi>:

int
atoi(const char *s)
{
    1da2:	55                   	push   %ebp
    1da3:	89 e5                	mov    %esp,%ebp
    1da5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1da8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1daf:	eb 24                	jmp    1dd5 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1db1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1db4:	89 d0                	mov    %edx,%eax
    1db6:	c1 e0 02             	shl    $0x2,%eax
    1db9:	01 d0                	add    %edx,%eax
    1dbb:	01 c0                	add    %eax,%eax
    1dbd:	89 c2                	mov    %eax,%edx
    1dbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc2:	0f b6 00             	movzbl (%eax),%eax
    1dc5:	0f be c0             	movsbl %al,%eax
    1dc8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1dcb:	83 e8 30             	sub    $0x30,%eax
    1dce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1dd1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1dd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd8:	0f b6 00             	movzbl (%eax),%eax
    1ddb:	3c 2f                	cmp    $0x2f,%al
    1ddd:	7e 0a                	jle    1de9 <atoi+0x47>
    1ddf:	8b 45 08             	mov    0x8(%ebp),%eax
    1de2:	0f b6 00             	movzbl (%eax),%eax
    1de5:	3c 39                	cmp    $0x39,%al
    1de7:	7e c8                	jle    1db1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1de9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1dec:	c9                   	leave  
    1ded:	c3                   	ret    

00001dee <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1dee:	55                   	push   %ebp
    1def:	89 e5                	mov    %esp,%ebp
    1df1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1df4:	8b 45 08             	mov    0x8(%ebp),%eax
    1df7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1dfa:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1e00:	eb 13                	jmp    1e15 <memmove+0x27>
    *dst++ = *src++;
    1e02:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1e05:	0f b6 10             	movzbl (%eax),%edx
    1e08:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e0b:	88 10                	mov    %dl,(%eax)
    1e0d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1e11:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e19:	0f 9f c0             	setg   %al
    1e1c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1e20:	84 c0                	test   %al,%al
    1e22:	75 de                	jne    1e02 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1e24:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1e27:	c9                   	leave  
    1e28:	c3                   	ret    
    1e29:	66 90                	xchg   %ax,%ax
    1e2b:	90                   	nop

00001e2c <fork>:
    1e2c:	b8 01 00 00 00       	mov    $0x1,%eax
    1e31:	cd 40                	int    $0x40
    1e33:	c3                   	ret    

00001e34 <exit>:
    1e34:	b8 02 00 00 00       	mov    $0x2,%eax
    1e39:	cd 40                	int    $0x40
    1e3b:	c3                   	ret    

00001e3c <wait>:
    1e3c:	b8 03 00 00 00       	mov    $0x3,%eax
    1e41:	cd 40                	int    $0x40
    1e43:	c3                   	ret    

00001e44 <pipe>:
    1e44:	b8 04 00 00 00       	mov    $0x4,%eax
    1e49:	cd 40                	int    $0x40
    1e4b:	c3                   	ret    

00001e4c <read>:
    1e4c:	b8 05 00 00 00       	mov    $0x5,%eax
    1e51:	cd 40                	int    $0x40
    1e53:	c3                   	ret    

00001e54 <write>:
    1e54:	b8 10 00 00 00       	mov    $0x10,%eax
    1e59:	cd 40                	int    $0x40
    1e5b:	c3                   	ret    

00001e5c <close>:
    1e5c:	b8 15 00 00 00       	mov    $0x15,%eax
    1e61:	cd 40                	int    $0x40
    1e63:	c3                   	ret    

00001e64 <kill>:
    1e64:	b8 06 00 00 00       	mov    $0x6,%eax
    1e69:	cd 40                	int    $0x40
    1e6b:	c3                   	ret    

00001e6c <exec>:
    1e6c:	b8 07 00 00 00       	mov    $0x7,%eax
    1e71:	cd 40                	int    $0x40
    1e73:	c3                   	ret    

00001e74 <open>:
    1e74:	b8 0f 00 00 00       	mov    $0xf,%eax
    1e79:	cd 40                	int    $0x40
    1e7b:	c3                   	ret    

00001e7c <mknod>:
    1e7c:	b8 11 00 00 00       	mov    $0x11,%eax
    1e81:	cd 40                	int    $0x40
    1e83:	c3                   	ret    

00001e84 <unlink>:
    1e84:	b8 12 00 00 00       	mov    $0x12,%eax
    1e89:	cd 40                	int    $0x40
    1e8b:	c3                   	ret    

00001e8c <fstat>:
    1e8c:	b8 08 00 00 00       	mov    $0x8,%eax
    1e91:	cd 40                	int    $0x40
    1e93:	c3                   	ret    

00001e94 <link>:
    1e94:	b8 13 00 00 00       	mov    $0x13,%eax
    1e99:	cd 40                	int    $0x40
    1e9b:	c3                   	ret    

00001e9c <mkdir>:
    1e9c:	b8 14 00 00 00       	mov    $0x14,%eax
    1ea1:	cd 40                	int    $0x40
    1ea3:	c3                   	ret    

00001ea4 <chdir>:
    1ea4:	b8 09 00 00 00       	mov    $0x9,%eax
    1ea9:	cd 40                	int    $0x40
    1eab:	c3                   	ret    

00001eac <dup>:
    1eac:	b8 0a 00 00 00       	mov    $0xa,%eax
    1eb1:	cd 40                	int    $0x40
    1eb3:	c3                   	ret    

00001eb4 <getpid>:
    1eb4:	b8 0b 00 00 00       	mov    $0xb,%eax
    1eb9:	cd 40                	int    $0x40
    1ebb:	c3                   	ret    

00001ebc <sbrk>:
    1ebc:	b8 0c 00 00 00       	mov    $0xc,%eax
    1ec1:	cd 40                	int    $0x40
    1ec3:	c3                   	ret    

00001ec4 <sleep>:
    1ec4:	b8 0d 00 00 00       	mov    $0xd,%eax
    1ec9:	cd 40                	int    $0x40
    1ecb:	c3                   	ret    

00001ecc <uptime>:
    1ecc:	b8 0e 00 00 00       	mov    $0xe,%eax
    1ed1:	cd 40                	int    $0x40
    1ed3:	c3                   	ret    

00001ed4 <clone>:
    1ed4:	b8 16 00 00 00       	mov    $0x16,%eax
    1ed9:	cd 40                	int    $0x40
    1edb:	c3                   	ret    

00001edc <texit>:
    1edc:	b8 17 00 00 00       	mov    $0x17,%eax
    1ee1:	cd 40                	int    $0x40
    1ee3:	c3                   	ret    

00001ee4 <tsleep>:
    1ee4:	b8 18 00 00 00       	mov    $0x18,%eax
    1ee9:	cd 40                	int    $0x40
    1eeb:	c3                   	ret    

00001eec <twakeup>:
    1eec:	b8 19 00 00 00       	mov    $0x19,%eax
    1ef1:	cd 40                	int    $0x40
    1ef3:	c3                   	ret    

00001ef4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1ef4:	55                   	push   %ebp
    1ef5:	89 e5                	mov    %esp,%ebp
    1ef7:	83 ec 28             	sub    $0x28,%esp
    1efa:	8b 45 0c             	mov    0xc(%ebp),%eax
    1efd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f00:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f07:	00 
    1f08:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f0b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f12:	89 04 24             	mov    %eax,(%esp)
    1f15:	e8 3a ff ff ff       	call   1e54 <write>
}
    1f1a:	c9                   	leave  
    1f1b:	c3                   	ret    

00001f1c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f1c:	55                   	push   %ebp
    1f1d:	89 e5                	mov    %esp,%ebp
    1f1f:	53                   	push   %ebx
    1f20:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f23:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f2a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f2e:	74 17                	je     1f47 <printint+0x2b>
    1f30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f34:	79 11                	jns    1f47 <printint+0x2b>
    neg = 1;
    1f36:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f40:	f7 d8                	neg    %eax
    1f42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1f45:	eb 06                	jmp    1f4d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1f47:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1f4d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1f54:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1f57:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1f5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f5d:	ba 00 00 00 00       	mov    $0x0,%edx
    1f62:	f7 f3                	div    %ebx
    1f64:	89 d0                	mov    %edx,%eax
    1f66:	0f b6 80 e4 28 00 00 	movzbl 0x28e4(%eax),%eax
    1f6d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1f71:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1f75:	8b 45 10             	mov    0x10(%ebp),%eax
    1f78:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1f7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f7e:	ba 00 00 00 00       	mov    $0x0,%edx
    1f83:	f7 75 d4             	divl   -0x2c(%ebp)
    1f86:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f8d:	75 c5                	jne    1f54 <printint+0x38>
  if(neg)
    1f8f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f93:	74 28                	je     1fbd <printint+0xa1>
    buf[i++] = '-';
    1f95:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f98:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1f9d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1fa1:	eb 1a                	jmp    1fbd <printint+0xa1>
    putc(fd, buf[i]);
    1fa3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fa6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1fab:	0f be c0             	movsbl %al,%eax
    1fae:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb5:	89 04 24             	mov    %eax,(%esp)
    1fb8:	e8 37 ff ff ff       	call   1ef4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1fbd:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1fc1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fc5:	79 dc                	jns    1fa3 <printint+0x87>
    putc(fd, buf[i]);
}
    1fc7:	83 c4 44             	add    $0x44,%esp
    1fca:	5b                   	pop    %ebx
    1fcb:	5d                   	pop    %ebp
    1fcc:	c3                   	ret    

00001fcd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1fcd:	55                   	push   %ebp
    1fce:	89 e5                	mov    %esp,%ebp
    1fd0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1fd3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1fda:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fdd:	83 c0 04             	add    $0x4,%eax
    1fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1fe3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fea:	e9 7e 01 00 00       	jmp    216d <printf+0x1a0>
    c = fmt[i] & 0xff;
    1fef:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ff2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ff5:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1ff8:	0f b6 00             	movzbl (%eax),%eax
    1ffb:	0f be c0             	movsbl %al,%eax
    1ffe:	25 ff 00 00 00       	and    $0xff,%eax
    2003:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    2006:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    200a:	75 2c                	jne    2038 <printf+0x6b>
      if(c == '%'){
    200c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2010:	75 0c                	jne    201e <printf+0x51>
        state = '%';
    2012:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    2019:	e9 4b 01 00 00       	jmp    2169 <printf+0x19c>
      } else {
        putc(fd, c);
    201e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2021:	0f be c0             	movsbl %al,%eax
    2024:	89 44 24 04          	mov    %eax,0x4(%esp)
    2028:	8b 45 08             	mov    0x8(%ebp),%eax
    202b:	89 04 24             	mov    %eax,(%esp)
    202e:	e8 c1 fe ff ff       	call   1ef4 <putc>
    2033:	e9 31 01 00 00       	jmp    2169 <printf+0x19c>
      }
    } else if(state == '%'){
    2038:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    203c:	0f 85 27 01 00 00    	jne    2169 <printf+0x19c>
      if(c == 'd'){
    2042:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    2046:	75 2d                	jne    2075 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    2048:	8b 45 f4             	mov    -0xc(%ebp),%eax
    204b:	8b 00                	mov    (%eax),%eax
    204d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2054:	00 
    2055:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    205c:	00 
    205d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2061:	8b 45 08             	mov    0x8(%ebp),%eax
    2064:	89 04 24             	mov    %eax,(%esp)
    2067:	e8 b0 fe ff ff       	call   1f1c <printint>
        ap++;
    206c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    2070:	e9 ed 00 00 00       	jmp    2162 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    2075:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    2079:	74 06                	je     2081 <printf+0xb4>
    207b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    207f:	75 2d                	jne    20ae <printf+0xe1>
        printint(fd, *ap, 16, 0);
    2081:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2084:	8b 00                	mov    (%eax),%eax
    2086:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    208d:	00 
    208e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    2095:	00 
    2096:	89 44 24 04          	mov    %eax,0x4(%esp)
    209a:	8b 45 08             	mov    0x8(%ebp),%eax
    209d:	89 04 24             	mov    %eax,(%esp)
    20a0:	e8 77 fe ff ff       	call   1f1c <printint>
        ap++;
    20a5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    20a9:	e9 b4 00 00 00       	jmp    2162 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    20ae:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    20b2:	75 46                	jne    20fa <printf+0x12d>
        s = (char*)*ap;
    20b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b7:	8b 00                	mov    (%eax),%eax
    20b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    20bc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    20c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    20c4:	75 27                	jne    20ed <printf+0x120>
          s = "(null)";
    20c6:	c7 45 e4 5f 27 00 00 	movl   $0x275f,-0x1c(%ebp)
        while(*s != 0){
    20cd:	eb 1f                	jmp    20ee <printf+0x121>
          putc(fd, *s);
    20cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20d2:	0f b6 00             	movzbl (%eax),%eax
    20d5:	0f be c0             	movsbl %al,%eax
    20d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    20dc:	8b 45 08             	mov    0x8(%ebp),%eax
    20df:	89 04 24             	mov    %eax,(%esp)
    20e2:	e8 0d fe ff ff       	call   1ef4 <putc>
          s++;
    20e7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20eb:	eb 01                	jmp    20ee <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    20ed:	90                   	nop
    20ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f1:	0f b6 00             	movzbl (%eax),%eax
    20f4:	84 c0                	test   %al,%al
    20f6:	75 d7                	jne    20cf <printf+0x102>
    20f8:	eb 68                	jmp    2162 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    20fa:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    20fe:	75 1d                	jne    211d <printf+0x150>
        putc(fd, *ap);
    2100:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2103:	8b 00                	mov    (%eax),%eax
    2105:	0f be c0             	movsbl %al,%eax
    2108:	89 44 24 04          	mov    %eax,0x4(%esp)
    210c:	8b 45 08             	mov    0x8(%ebp),%eax
    210f:	89 04 24             	mov    %eax,(%esp)
    2112:	e8 dd fd ff ff       	call   1ef4 <putc>
        ap++;
    2117:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    211b:	eb 45                	jmp    2162 <printf+0x195>
      } else if(c == '%'){
    211d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2121:	75 17                	jne    213a <printf+0x16d>
        putc(fd, c);
    2123:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2126:	0f be c0             	movsbl %al,%eax
    2129:	89 44 24 04          	mov    %eax,0x4(%esp)
    212d:	8b 45 08             	mov    0x8(%ebp),%eax
    2130:	89 04 24             	mov    %eax,(%esp)
    2133:	e8 bc fd ff ff       	call   1ef4 <putc>
    2138:	eb 28                	jmp    2162 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    213a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2141:	00 
    2142:	8b 45 08             	mov    0x8(%ebp),%eax
    2145:	89 04 24             	mov    %eax,(%esp)
    2148:	e8 a7 fd ff ff       	call   1ef4 <putc>
        putc(fd, c);
    214d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2150:	0f be c0             	movsbl %al,%eax
    2153:	89 44 24 04          	mov    %eax,0x4(%esp)
    2157:	8b 45 08             	mov    0x8(%ebp),%eax
    215a:	89 04 24             	mov    %eax,(%esp)
    215d:	e8 92 fd ff ff       	call   1ef4 <putc>
      }
      state = 0;
    2162:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2169:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    216d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2170:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2173:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2176:	0f b6 00             	movzbl (%eax),%eax
    2179:	84 c0                	test   %al,%al
    217b:	0f 85 6e fe ff ff    	jne    1fef <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2181:	c9                   	leave  
    2182:	c3                   	ret    
    2183:	90                   	nop

00002184 <free>:
    2184:	55                   	push   %ebp
    2185:	89 e5                	mov    %esp,%ebp
    2187:	83 ec 10             	sub    $0x10,%esp
    218a:	8b 45 08             	mov    0x8(%ebp),%eax
    218d:	83 e8 08             	sub    $0x8,%eax
    2190:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2193:	a1 10 29 00 00       	mov    0x2910,%eax
    2198:	89 45 fc             	mov    %eax,-0x4(%ebp)
    219b:	eb 24                	jmp    21c1 <free+0x3d>
    219d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21a0:	8b 00                	mov    (%eax),%eax
    21a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21a5:	77 12                	ja     21b9 <free+0x35>
    21a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21ad:	77 24                	ja     21d3 <free+0x4f>
    21af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21b2:	8b 00                	mov    (%eax),%eax
    21b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21b7:	77 1a                	ja     21d3 <free+0x4f>
    21b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21bc:	8b 00                	mov    (%eax),%eax
    21be:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21c7:	76 d4                	jbe    219d <free+0x19>
    21c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21cc:	8b 00                	mov    (%eax),%eax
    21ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21d1:	76 ca                	jbe    219d <free+0x19>
    21d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21d6:	8b 40 04             	mov    0x4(%eax),%eax
    21d9:	c1 e0 03             	shl    $0x3,%eax
    21dc:	89 c2                	mov    %eax,%edx
    21de:	03 55 f8             	add    -0x8(%ebp),%edx
    21e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21e4:	8b 00                	mov    (%eax),%eax
    21e6:	39 c2                	cmp    %eax,%edx
    21e8:	75 24                	jne    220e <free+0x8a>
    21ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21ed:	8b 50 04             	mov    0x4(%eax),%edx
    21f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21f3:	8b 00                	mov    (%eax),%eax
    21f5:	8b 40 04             	mov    0x4(%eax),%eax
    21f8:	01 c2                	add    %eax,%edx
    21fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21fd:	89 50 04             	mov    %edx,0x4(%eax)
    2200:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2203:	8b 00                	mov    (%eax),%eax
    2205:	8b 10                	mov    (%eax),%edx
    2207:	8b 45 f8             	mov    -0x8(%ebp),%eax
    220a:	89 10                	mov    %edx,(%eax)
    220c:	eb 0a                	jmp    2218 <free+0x94>
    220e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2211:	8b 10                	mov    (%eax),%edx
    2213:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2216:	89 10                	mov    %edx,(%eax)
    2218:	8b 45 fc             	mov    -0x4(%ebp),%eax
    221b:	8b 40 04             	mov    0x4(%eax),%eax
    221e:	c1 e0 03             	shl    $0x3,%eax
    2221:	03 45 fc             	add    -0x4(%ebp),%eax
    2224:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2227:	75 20                	jne    2249 <free+0xc5>
    2229:	8b 45 fc             	mov    -0x4(%ebp),%eax
    222c:	8b 50 04             	mov    0x4(%eax),%edx
    222f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2232:	8b 40 04             	mov    0x4(%eax),%eax
    2235:	01 c2                	add    %eax,%edx
    2237:	8b 45 fc             	mov    -0x4(%ebp),%eax
    223a:	89 50 04             	mov    %edx,0x4(%eax)
    223d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2240:	8b 10                	mov    (%eax),%edx
    2242:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2245:	89 10                	mov    %edx,(%eax)
    2247:	eb 08                	jmp    2251 <free+0xcd>
    2249:	8b 45 fc             	mov    -0x4(%ebp),%eax
    224c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    224f:	89 10                	mov    %edx,(%eax)
    2251:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2254:	a3 10 29 00 00       	mov    %eax,0x2910
    2259:	c9                   	leave  
    225a:	c3                   	ret    

0000225b <morecore>:
    225b:	55                   	push   %ebp
    225c:	89 e5                	mov    %esp,%ebp
    225e:	83 ec 28             	sub    $0x28,%esp
    2261:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2268:	77 07                	ja     2271 <morecore+0x16>
    226a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    2271:	8b 45 08             	mov    0x8(%ebp),%eax
    2274:	c1 e0 03             	shl    $0x3,%eax
    2277:	89 04 24             	mov    %eax,(%esp)
    227a:	e8 3d fc ff ff       	call   1ebc <sbrk>
    227f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2282:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    2286:	75 07                	jne    228f <morecore+0x34>
    2288:	b8 00 00 00 00       	mov    $0x0,%eax
    228d:	eb 22                	jmp    22b1 <morecore+0x56>
    228f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2292:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2295:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2298:	8b 55 08             	mov    0x8(%ebp),%edx
    229b:	89 50 04             	mov    %edx,0x4(%eax)
    229e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a1:	83 c0 08             	add    $0x8,%eax
    22a4:	89 04 24             	mov    %eax,(%esp)
    22a7:	e8 d8 fe ff ff       	call   2184 <free>
    22ac:	a1 10 29 00 00       	mov    0x2910,%eax
    22b1:	c9                   	leave  
    22b2:	c3                   	ret    

000022b3 <malloc>:
    22b3:	55                   	push   %ebp
    22b4:	89 e5                	mov    %esp,%ebp
    22b6:	83 ec 28             	sub    $0x28,%esp
    22b9:	8b 45 08             	mov    0x8(%ebp),%eax
    22bc:	83 c0 07             	add    $0x7,%eax
    22bf:	c1 e8 03             	shr    $0x3,%eax
    22c2:	83 c0 01             	add    $0x1,%eax
    22c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22c8:	a1 10 29 00 00       	mov    0x2910,%eax
    22cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22d4:	75 23                	jne    22f9 <malloc+0x46>
    22d6:	c7 45 f0 08 29 00 00 	movl   $0x2908,-0x10(%ebp)
    22dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22e0:	a3 10 29 00 00       	mov    %eax,0x2910
    22e5:	a1 10 29 00 00       	mov    0x2910,%eax
    22ea:	a3 08 29 00 00       	mov    %eax,0x2908
    22ef:	c7 05 0c 29 00 00 00 	movl   $0x0,0x290c
    22f6:	00 00 00 
    22f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22fc:	8b 00                	mov    (%eax),%eax
    22fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2301:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2304:	8b 40 04             	mov    0x4(%eax),%eax
    2307:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    230a:	72 4d                	jb     2359 <malloc+0xa6>
    230c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    230f:	8b 40 04             	mov    0x4(%eax),%eax
    2312:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2315:	75 0c                	jne    2323 <malloc+0x70>
    2317:	8b 45 ec             	mov    -0x14(%ebp),%eax
    231a:	8b 10                	mov    (%eax),%edx
    231c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    231f:	89 10                	mov    %edx,(%eax)
    2321:	eb 26                	jmp    2349 <malloc+0x96>
    2323:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2326:	8b 40 04             	mov    0x4(%eax),%eax
    2329:	89 c2                	mov    %eax,%edx
    232b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    232e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2331:	89 50 04             	mov    %edx,0x4(%eax)
    2334:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2337:	8b 40 04             	mov    0x4(%eax),%eax
    233a:	c1 e0 03             	shl    $0x3,%eax
    233d:	01 45 ec             	add    %eax,-0x14(%ebp)
    2340:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2343:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2346:	89 50 04             	mov    %edx,0x4(%eax)
    2349:	8b 45 f0             	mov    -0x10(%ebp),%eax
    234c:	a3 10 29 00 00       	mov    %eax,0x2910
    2351:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2354:	83 c0 08             	add    $0x8,%eax
    2357:	eb 38                	jmp    2391 <malloc+0xde>
    2359:	a1 10 29 00 00       	mov    0x2910,%eax
    235e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    2361:	75 1b                	jne    237e <malloc+0xcb>
    2363:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2366:	89 04 24             	mov    %eax,(%esp)
    2369:	e8 ed fe ff ff       	call   225b <morecore>
    236e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2371:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2375:	75 07                	jne    237e <malloc+0xcb>
    2377:	b8 00 00 00 00       	mov    $0x0,%eax
    237c:	eb 13                	jmp    2391 <malloc+0xde>
    237e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2381:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2384:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2387:	8b 00                	mov    (%eax),%eax
    2389:	89 45 ec             	mov    %eax,-0x14(%ebp)
    238c:	e9 70 ff ff ff       	jmp    2301 <malloc+0x4e>
    2391:	c9                   	leave  
    2392:	c3                   	ret    
    2393:	90                   	nop

00002394 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    2394:	55                   	push   %ebp
    2395:	89 e5                	mov    %esp,%ebp
    2397:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    239a:	8b 55 08             	mov    0x8(%ebp),%edx
    239d:	8b 45 0c             	mov    0xc(%ebp),%eax
    23a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23a3:	f0 87 02             	lock xchg %eax,(%edx)
    23a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    23a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    23ac:	c9                   	leave  
    23ad:	c3                   	ret    

000023ae <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    23ae:	55                   	push   %ebp
    23af:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    23b1:	8b 45 08             	mov    0x8(%ebp),%eax
    23b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    23ba:	5d                   	pop    %ebp
    23bb:	c3                   	ret    

000023bc <lock_acquire>:
void lock_acquire(lock_t *lock){
    23bc:	55                   	push   %ebp
    23bd:	89 e5                	mov    %esp,%ebp
    23bf:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    23c2:	8b 45 08             	mov    0x8(%ebp),%eax
    23c5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    23cc:	00 
    23cd:	89 04 24             	mov    %eax,(%esp)
    23d0:	e8 bf ff ff ff       	call   2394 <xchg>
    23d5:	85 c0                	test   %eax,%eax
    23d7:	75 e9                	jne    23c2 <lock_acquire+0x6>
}
    23d9:	c9                   	leave  
    23da:	c3                   	ret    

000023db <lock_release>:
void lock_release(lock_t *lock){
    23db:	55                   	push   %ebp
    23dc:	89 e5                	mov    %esp,%ebp
    23de:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    23e1:	8b 45 08             	mov    0x8(%ebp),%eax
    23e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23eb:	00 
    23ec:	89 04 24             	mov    %eax,(%esp)
    23ef:	e8 a0 ff ff ff       	call   2394 <xchg>
}
    23f4:	c9                   	leave  
    23f5:	c3                   	ret    

000023f6 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    23f6:	55                   	push   %ebp
    23f7:	89 e5                	mov    %esp,%ebp
    23f9:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    23fc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2403:	e8 ab fe ff ff       	call   22b3 <malloc>
    2408:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    240b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    240e:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    2411:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2414:	25 ff 0f 00 00       	and    $0xfff,%eax
    2419:	85 c0                	test   %eax,%eax
    241b:	74 15                	je     2432 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    241d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2420:	89 c2                	mov    %eax,%edx
    2422:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    2428:	b8 00 10 00 00       	mov    $0x1000,%eax
    242d:	29 d0                	sub    %edx,%eax
    242f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    2432:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2436:	75 1b                	jne    2453 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    2438:	c7 44 24 04 66 27 00 	movl   $0x2766,0x4(%esp)
    243f:	00 
    2440:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2447:	e8 81 fb ff ff       	call   1fcd <printf>
        return 0;
    244c:	b8 00 00 00 00       	mov    $0x0,%eax
    2451:	eb 6f                	jmp    24c2 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    2453:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2456:	8b 55 08             	mov    0x8(%ebp),%edx
    2459:	8b 45 f0             	mov    -0x10(%ebp),%eax
    245c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    2460:	89 54 24 08          	mov    %edx,0x8(%esp)
    2464:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    246b:	00 
    246c:	89 04 24             	mov    %eax,(%esp)
    246f:	e8 60 fa ff ff       	call   1ed4 <clone>
    2474:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    2477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    247b:	79 1b                	jns    2498 <thread_create+0xa2>
        printf(1,"clone fails\n");
    247d:	c7 44 24 04 74 27 00 	movl   $0x2774,0x4(%esp)
    2484:	00 
    2485:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    248c:	e8 3c fb ff ff       	call   1fcd <printf>
        return 0;
    2491:	b8 00 00 00 00       	mov    $0x0,%eax
    2496:	eb 2a                	jmp    24c2 <thread_create+0xcc>
    }
    if(tid > 0){
    2498:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    249c:	7e 05                	jle    24a3 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    249e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24a1:	eb 1f                	jmp    24c2 <thread_create+0xcc>
    }
    if(tid == 0){
    24a3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24a7:	75 14                	jne    24bd <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    24a9:	c7 44 24 04 81 27 00 	movl   $0x2781,0x4(%esp)
    24b0:	00 
    24b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b8:	e8 10 fb ff ff       	call   1fcd <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    24bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    24c2:	c9                   	leave  
    24c3:	c3                   	ret    

000024c4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    24c4:	55                   	push   %ebp
    24c5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    24c7:	a1 f8 28 00 00       	mov    0x28f8,%eax
    24cc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    24d2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    24d7:	a3 f8 28 00 00       	mov    %eax,0x28f8
    return (int)(rands % max);
    24dc:	a1 f8 28 00 00       	mov    0x28f8,%eax
    24e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    24e4:	ba 00 00 00 00       	mov    $0x0,%edx
    24e9:	f7 f1                	div    %ecx
    24eb:	89 d0                	mov    %edx,%eax
}
    24ed:	5d                   	pop    %ebp
    24ee:	c3                   	ret    
    24ef:	90                   	nop

000024f0 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    24f3:	8b 45 08             	mov    0x8(%ebp),%eax
    24f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    24fc:	8b 45 08             	mov    0x8(%ebp),%eax
    24ff:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    2506:	8b 45 08             	mov    0x8(%ebp),%eax
    2509:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    2510:	5d                   	pop    %ebp
    2511:	c3                   	ret    

00002512 <add_q>:

void add_q(struct queue *q, int v){
    2512:	55                   	push   %ebp
    2513:	89 e5                	mov    %esp,%ebp
    2515:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2518:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    251f:	e8 8f fd ff ff       	call   22b3 <malloc>
    2524:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    2527:	8b 45 f4             	mov    -0xc(%ebp),%eax
    252a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2531:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2534:	8b 55 0c             	mov    0xc(%ebp),%edx
    2537:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2539:	8b 45 08             	mov    0x8(%ebp),%eax
    253c:	8b 40 04             	mov    0x4(%eax),%eax
    253f:	85 c0                	test   %eax,%eax
    2541:	75 0b                	jne    254e <add_q+0x3c>
        q->head = n;
    2543:	8b 45 08             	mov    0x8(%ebp),%eax
    2546:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2549:	89 50 04             	mov    %edx,0x4(%eax)
    254c:	eb 0c                	jmp    255a <add_q+0x48>
    }else{
        q->tail->next = n;
    254e:	8b 45 08             	mov    0x8(%ebp),%eax
    2551:	8b 40 08             	mov    0x8(%eax),%eax
    2554:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2557:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    255a:	8b 45 08             	mov    0x8(%ebp),%eax
    255d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2560:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    2563:	8b 45 08             	mov    0x8(%ebp),%eax
    2566:	8b 00                	mov    (%eax),%eax
    2568:	8d 50 01             	lea    0x1(%eax),%edx
    256b:	8b 45 08             	mov    0x8(%ebp),%eax
    256e:	89 10                	mov    %edx,(%eax)
}
    2570:	c9                   	leave  
    2571:	c3                   	ret    

00002572 <empty_q>:

int empty_q(struct queue *q){
    2572:	55                   	push   %ebp
    2573:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    2575:	8b 45 08             	mov    0x8(%ebp),%eax
    2578:	8b 00                	mov    (%eax),%eax
    257a:	85 c0                	test   %eax,%eax
    257c:	75 07                	jne    2585 <empty_q+0x13>
        return 1;
    257e:	b8 01 00 00 00       	mov    $0x1,%eax
    2583:	eb 05                	jmp    258a <empty_q+0x18>
    else
        return 0;
    2585:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    258a:	5d                   	pop    %ebp
    258b:	c3                   	ret    

0000258c <pop_q>:
int pop_q(struct queue *q){
    258c:	55                   	push   %ebp
    258d:	89 e5                	mov    %esp,%ebp
    258f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    2592:	8b 45 08             	mov    0x8(%ebp),%eax
    2595:	89 04 24             	mov    %eax,(%esp)
    2598:	e8 d5 ff ff ff       	call   2572 <empty_q>
    259d:	85 c0                	test   %eax,%eax
    259f:	75 5d                	jne    25fe <pop_q+0x72>
       val = q->head->value; 
    25a1:	8b 45 08             	mov    0x8(%ebp),%eax
    25a4:	8b 40 04             	mov    0x4(%eax),%eax
    25a7:	8b 00                	mov    (%eax),%eax
    25a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    25ac:	8b 45 08             	mov    0x8(%ebp),%eax
    25af:	8b 40 04             	mov    0x4(%eax),%eax
    25b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    25b5:	8b 45 08             	mov    0x8(%ebp),%eax
    25b8:	8b 40 04             	mov    0x4(%eax),%eax
    25bb:	8b 50 04             	mov    0x4(%eax),%edx
    25be:	8b 45 08             	mov    0x8(%ebp),%eax
    25c1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    25c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25c7:	89 04 24             	mov    %eax,(%esp)
    25ca:	e8 b5 fb ff ff       	call   2184 <free>
       q->size--;
    25cf:	8b 45 08             	mov    0x8(%ebp),%eax
    25d2:	8b 00                	mov    (%eax),%eax
    25d4:	8d 50 ff             	lea    -0x1(%eax),%edx
    25d7:	8b 45 08             	mov    0x8(%ebp),%eax
    25da:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    25dc:	8b 45 08             	mov    0x8(%ebp),%eax
    25df:	8b 00                	mov    (%eax),%eax
    25e1:	85 c0                	test   %eax,%eax
    25e3:	75 14                	jne    25f9 <pop_q+0x6d>
            q->head = 0;
    25e5:	8b 45 08             	mov    0x8(%ebp),%eax
    25e8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    25ef:	8b 45 08             	mov    0x8(%ebp),%eax
    25f2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    25f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25fc:	eb 05                	jmp    2603 <pop_q+0x77>
    }
    return -1;
    25fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2603:	c9                   	leave  
    2604:	c3                   	ret    
