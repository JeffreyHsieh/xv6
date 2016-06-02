
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
    102f:	e8 87 12 00 00       	call   22bb <malloc>
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
    10da:	e8 ad 10 00 00       	call   218c <free>
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
    1143:	e8 6e 12 00 00       	call   23b6 <lock_init>
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
    1162:	e8 5d 12 00 00       	call   23c4 <lock_acquire>
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
    117d:	e8 62 12 00 00       	call   23e4 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 32 12 00 00       	call   23c4 <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 21 0d 00 00       	call   1eb8 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 2d 12 00 00       	call   23e4 <lock_release>
    tsleep();
    11b7:	e8 2c 0d 00 00       	call   1ee8 <tsleep>
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
    11e7:	e8 d8 11 00 00       	call   23c4 <lock_acquire>
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
    1202:	e8 dd 11 00 00       	call   23e4 <lock_release>
		
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
    122a:	e8 c1 0c 00 00       	call   1ef0 <twakeup>
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
    1241:	e8 75 10 00 00       	call   22bb <malloc>
    1246:	a3 f4 2b 00 00       	mov    %eax,0x2bf4
	o = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 64 10 00 00       	call   22bb <malloc>
    1257:	a3 f8 2b 00 00       	mov    %eax,0x2bf8
	p = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 53 10 00 00       	call   22bb <malloc>
    1268:	a3 fc 2b 00 00       	mov    %eax,0x2bfc
	sem_init(p, 1);
    126d:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>

	// Test 1: 2 hydrogen 1 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    1282:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1287:	89 04 24             	mov    %eax,(%esp)
    128a:	e8 bb fe ff ff       	call   114a <sem_acquire>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
    128f:	c7 44 24 04 10 26 00 	movl   $0x2610,0x4(%esp)
    1296:	00 
    1297:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129e:	e8 35 0d 00 00       	call   1fd8 <printf>
	sem_signal(p);
    12a3:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    12a8:	89 04 24             	mov    %eax,(%esp)
    12ab:	e8 19 ff ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    12b0:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    12b5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12bc:	00 
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 50 fe ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    12c5:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    12ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 3b fe ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 1; water++){
    12da:	c7 05 0c 2c 00 00 00 	movl   $0x0,0x2c0c
    12e1:	00 00 00 
    12e4:	e9 7b 01 00 00       	jmp    1464 <main+0x233>
		tid = thread_create(hReady, (void *) &arg);
    12e9:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    12f0:	00 
    12f1:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    12f8:	e8 02 11 00 00       	call   23ff <thread_create>
    12fd:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    1302:	a1 14 2c 00 00       	mov    0x2c14,%eax
    1307:	85 c0                	test   %eax,%eax
    1309:	75 33                	jne    133e <main+0x10d>
			sem_acquire(p);
    130b:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1310:	89 04 24             	mov    %eax,(%esp)
    1313:	e8 32 fe ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1318:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    131f:	00 
    1320:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1327:	e8 ac 0c 00 00       	call   1fd8 <printf>
			sem_signal(p);
    132c:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 90 fe ff ff       	call   11c9 <sem_signal>
			exit();
    1339:	e8 fa 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    133e:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1345:	00 00 00 
    1348:	eb 0d                	jmp    1357 <main+0x126>
    134a:	a1 10 2c 00 00       	mov    0x2c10,%eax
    134f:	83 c0 01             	add    $0x1,%eax
    1352:	a3 10 2c 00 00       	mov    %eax,0x2c10
    1357:	a1 10 2c 00 00       	mov    0x2c10,%eax
    135c:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1361:	7e e7                	jle    134a <main+0x119>
		tid = thread_create(hReady, (void *) &arg);
    1363:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    136a:	00 
    136b:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    1372:	e8 88 10 00 00       	call   23ff <thread_create>
    1377:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    137c:	a1 14 2c 00 00       	mov    0x2c14,%eax
    1381:	85 c0                	test   %eax,%eax
    1383:	75 33                	jne    13b8 <main+0x187>
			sem_acquire(p);
    1385:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    138a:	89 04 24             	mov    %eax,(%esp)
    138d:	e8 b8 fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1392:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1399:	00 
    139a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a1:	e8 32 0c 00 00       	call   1fd8 <printf>
			sem_signal(p);
    13a6:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    13ab:	89 04 24             	mov    %eax,(%esp)
    13ae:	e8 16 fe ff ff       	call   11c9 <sem_signal>
			exit();
    13b3:	e8 80 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    13b8:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    13bf:	00 00 00 
    13c2:	eb 0d                	jmp    13d1 <main+0x1a0>
    13c4:	a1 10 2c 00 00       	mov    0x2c10,%eax
    13c9:	83 c0 01             	add    $0x1,%eax
    13cc:	a3 10 2c 00 00       	mov    %eax,0x2c10
    13d1:	a1 10 2c 00 00       	mov    0x2c10,%eax
    13d6:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13db:	7e e7                	jle    13c4 <main+0x193>
		tid = thread_create(oReady, (void *) &arg);
    13dd:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    13e4:	00 
    13e5:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    13ec:	e8 0e 10 00 00       	call   23ff <thread_create>
    13f1:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    13f6:	a1 14 2c 00 00       	mov    0x2c14,%eax
    13fb:	85 c0                	test   %eax,%eax
    13fd:	75 33                	jne    1432 <main+0x201>
			sem_acquire(p);
    13ff:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1404:	89 04 24             	mov    %eax,(%esp)
    1407:	e8 3e fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    140c:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1413:	00 
    1414:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141b:	e8 b8 0b 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1420:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1425:	89 04 24             	mov    %eax,(%esp)
    1428:	e8 9c fd ff ff       	call   11c9 <sem_signal>
			exit();
    142d:	e8 06 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1432:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1439:	00 00 00 
    143c:	eb 0d                	jmp    144b <main+0x21a>
    143e:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1443:	83 c0 01             	add    $0x1,%eax
    1446:	a3 10 2c 00 00       	mov    %eax,0x2c10
    144b:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1450:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1455:	7e e7                	jle    143e <main+0x20d>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 1; water++){
    1457:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    145c:	83 c0 01             	add    $0x1,%eax
    145f:	a3 0c 2c 00 00       	mov    %eax,0x2c0c
    1464:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    1469:	85 c0                	test   %eax,%eax
    146b:	0f 8e 78 fe ff ff    	jle    12e9 <main+0xb8>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1471:	90                   	nop
    1472:	e8 c9 09 00 00       	call   1e40 <wait>
    1477:	85 c0                	test   %eax,%eax
    1479:	79 f7                	jns    1472 <main+0x241>
	
	// Test 2: 20 hydrogen 10 oxygen (Thread creation order: O->H->H)
	sem_acquire(p);
    147b:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1480:	89 04 24             	mov    %eax,(%esp)
    1483:	e8 c2 fc ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
    1488:	c7 44 24 04 6c 26 00 	movl   $0x266c,0x4(%esp)
    148f:	00 
    1490:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1497:	e8 3c 0b 00 00       	call   1fd8 <printf>
	sem_signal(p);
    149c:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    14a1:	89 04 24             	mov    %eax,(%esp)
    14a4:	e8 20 fd ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    14a9:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    14ae:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    14b5:	00 
    14b6:	89 04 24             	mov    %eax,(%esp)
    14b9:	e8 57 fc ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    14be:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    14c3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    14ca:	00 
    14cb:	89 04 24             	mov    %eax,(%esp)
    14ce:	e8 42 fc ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    14d3:	c7 05 0c 2c 00 00 00 	movl   $0x0,0x2c0c
    14da:	00 00 00 
    14dd:	e9 7b 01 00 00       	jmp    165d <main+0x42c>
		tid = thread_create(oReady, (void *) &arg);
    14e2:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    14e9:	00 
    14ea:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    14f1:	e8 09 0f 00 00       	call   23ff <thread_create>
    14f6:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    14fb:	a1 14 2c 00 00       	mov    0x2c14,%eax
    1500:	85 c0                	test   %eax,%eax
    1502:	75 33                	jne    1537 <main+0x306>
			sem_acquire(p);
    1504:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1509:	89 04 24             	mov    %eax,(%esp)
    150c:	e8 39 fc ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1511:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1518:	00 
    1519:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1520:	e8 b3 0a 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1525:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 97 fc ff ff       	call   11c9 <sem_signal>
			exit();
    1532:	e8 01 09 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1537:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    153e:	00 00 00 
    1541:	eb 0d                	jmp    1550 <main+0x31f>
    1543:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1548:	83 c0 01             	add    $0x1,%eax
    154b:	a3 10 2c 00 00       	mov    %eax,0x2c10
    1550:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1555:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    155a:	7e e7                	jle    1543 <main+0x312>
		tid = thread_create(hReady, (void *) &arg);
    155c:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    1563:	00 
    1564:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    156b:	e8 8f 0e 00 00       	call   23ff <thread_create>
    1570:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    1575:	a1 14 2c 00 00       	mov    0x2c14,%eax
    157a:	85 c0                	test   %eax,%eax
    157c:	75 33                	jne    15b1 <main+0x380>
			sem_acquire(p);
    157e:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1583:	89 04 24             	mov    %eax,(%esp)
    1586:	e8 bf fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    158b:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1592:	00 
    1593:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159a:	e8 39 0a 00 00       	call   1fd8 <printf>
			sem_signal(p);
    159f:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    15a4:	89 04 24             	mov    %eax,(%esp)
    15a7:	e8 1d fc ff ff       	call   11c9 <sem_signal>
			exit();
    15ac:	e8 87 08 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    15b1:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    15b8:	00 00 00 
    15bb:	eb 0d                	jmp    15ca <main+0x399>
    15bd:	a1 10 2c 00 00       	mov    0x2c10,%eax
    15c2:	83 c0 01             	add    $0x1,%eax
    15c5:	a3 10 2c 00 00       	mov    %eax,0x2c10
    15ca:	a1 10 2c 00 00       	mov    0x2c10,%eax
    15cf:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15d4:	7e e7                	jle    15bd <main+0x38c>
		tid = thread_create(hReady, (void *) &arg);
    15d6:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    15dd:	00 
    15de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    15e5:	e8 15 0e 00 00       	call   23ff <thread_create>
    15ea:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    15ef:	a1 14 2c 00 00       	mov    0x2c14,%eax
    15f4:	85 c0                	test   %eax,%eax
    15f6:	75 33                	jne    162b <main+0x3fa>
			sem_acquire(p);
    15f8:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    15fd:	89 04 24             	mov    %eax,(%esp)
    1600:	e8 45 fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1605:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    160c:	00 
    160d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1614:	e8 bf 09 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1619:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    161e:	89 04 24             	mov    %eax,(%esp)
    1621:	e8 a3 fb ff ff       	call   11c9 <sem_signal>
			exit();
    1626:	e8 0d 08 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    162b:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1632:	00 00 00 
    1635:	eb 0d                	jmp    1644 <main+0x413>
    1637:	a1 10 2c 00 00       	mov    0x2c10,%eax
    163c:	83 c0 01             	add    $0x1,%eax
    163f:	a3 10 2c 00 00       	mov    %eax,0x2c10
    1644:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1649:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    164e:	7e e7                	jle    1637 <main+0x406>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1650:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    1655:	83 c0 01             	add    $0x1,%eax
    1658:	a3 0c 2c 00 00       	mov    %eax,0x2c0c
    165d:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    1662:	83 f8 09             	cmp    $0x9,%eax
    1665:	0f 8e 77 fe ff ff    	jle    14e2 <main+0x2b1>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    166b:	90                   	nop
    166c:	e8 cf 07 00 00       	call   1e40 <wait>
    1671:	85 c0                	test   %eax,%eax
    1673:	79 f7                	jns    166c <main+0x43b>
	
	// Test 3: 20 hydrogen 10 oxygen (Thread creation order: H->O->H)
	sem_acquire(p);
    1675:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    167a:	89 04 24             	mov    %eax,(%esp)
    167d:	e8 c8 fa ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
    1682:	c7 44 24 04 b0 26 00 	movl   $0x26b0,0x4(%esp)
    1689:	00 
    168a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1691:	e8 42 09 00 00       	call   1fd8 <printf>
	sem_signal(p);
    1696:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    169b:	89 04 24             	mov    %eax,(%esp)
    169e:	e8 26 fb ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    16a3:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    16a8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    16af:	00 
    16b0:	89 04 24             	mov    %eax,(%esp)
    16b3:	e8 5d fa ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    16b8:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    16bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    16c4:	00 
    16c5:	89 04 24             	mov    %eax,(%esp)
    16c8:	e8 48 fa ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    16cd:	c7 05 0c 2c 00 00 00 	movl   $0x0,0x2c0c
    16d4:	00 00 00 
    16d7:	e9 7b 01 00 00       	jmp    1857 <main+0x626>
		tid = thread_create(hReady, (void *) &arg);
    16dc:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    16e3:	00 
    16e4:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    16eb:	e8 0f 0d 00 00       	call   23ff <thread_create>
    16f0:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    16f5:	a1 14 2c 00 00       	mov    0x2c14,%eax
    16fa:	85 c0                	test   %eax,%eax
    16fc:	75 33                	jne    1731 <main+0x500>
			sem_acquire(p);
    16fe:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1703:	89 04 24             	mov    %eax,(%esp)
    1706:	e8 3f fa ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    170b:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1712:	00 
    1713:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    171a:	e8 b9 08 00 00       	call   1fd8 <printf>
			sem_signal(p);
    171f:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1724:	89 04 24             	mov    %eax,(%esp)
    1727:	e8 9d fa ff ff       	call   11c9 <sem_signal>
			exit();
    172c:	e8 07 07 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1731:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1738:	00 00 00 
    173b:	eb 0d                	jmp    174a <main+0x519>
    173d:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1742:	83 c0 01             	add    $0x1,%eax
    1745:	a3 10 2c 00 00       	mov    %eax,0x2c10
    174a:	a1 10 2c 00 00       	mov    0x2c10,%eax
    174f:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1754:	7e e7                	jle    173d <main+0x50c>
		tid = thread_create(oReady, (void *) &arg);
    1756:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    175d:	00 
    175e:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    1765:	e8 95 0c 00 00       	call   23ff <thread_create>
    176a:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    176f:	a1 14 2c 00 00       	mov    0x2c14,%eax
    1774:	85 c0                	test   %eax,%eax
    1776:	75 33                	jne    17ab <main+0x57a>
			sem_acquire(p);
    1778:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    177d:	89 04 24             	mov    %eax,(%esp)
    1780:	e8 c5 f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1785:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    178c:	00 
    178d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1794:	e8 3f 08 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1799:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    179e:	89 04 24             	mov    %eax,(%esp)
    17a1:	e8 23 fa ff ff       	call   11c9 <sem_signal>
			exit();
    17a6:	e8 8d 06 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    17ab:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    17b2:	00 00 00 
    17b5:	eb 0d                	jmp    17c4 <main+0x593>
    17b7:	a1 10 2c 00 00       	mov    0x2c10,%eax
    17bc:	83 c0 01             	add    $0x1,%eax
    17bf:	a3 10 2c 00 00       	mov    %eax,0x2c10
    17c4:	a1 10 2c 00 00       	mov    0x2c10,%eax
    17c9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17ce:	7e e7                	jle    17b7 <main+0x586>
		tid = thread_create(hReady, (void *) &arg);
    17d0:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    17d7:	00 
    17d8:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    17df:	e8 1b 0c 00 00       	call   23ff <thread_create>
    17e4:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    17e9:	a1 14 2c 00 00       	mov    0x2c14,%eax
    17ee:	85 c0                	test   %eax,%eax
    17f0:	75 33                	jne    1825 <main+0x5f4>
			sem_acquire(p);
    17f2:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    17f7:	89 04 24             	mov    %eax,(%esp)
    17fa:	e8 4b f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    17ff:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1806:	00 
    1807:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    180e:	e8 c5 07 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1813:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1818:	89 04 24             	mov    %eax,(%esp)
    181b:	e8 a9 f9 ff ff       	call   11c9 <sem_signal>
			exit();
    1820:	e8 13 06 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1825:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    182c:	00 00 00 
    182f:	eb 0d                	jmp    183e <main+0x60d>
    1831:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1836:	83 c0 01             	add    $0x1,%eax
    1839:	a3 10 2c 00 00       	mov    %eax,0x2c10
    183e:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1843:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1848:	7e e7                	jle    1831 <main+0x600>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    184a:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    184f:	83 c0 01             	add    $0x1,%eax
    1852:	a3 0c 2c 00 00       	mov    %eax,0x2c0c
    1857:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    185c:	83 f8 09             	cmp    $0x9,%eax
    185f:	0f 8e 77 fe ff ff    	jle    16dc <main+0x4ab>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1865:	90                   	nop
    1866:	e8 d5 05 00 00       	call   1e40 <wait>
    186b:	85 c0                	test   %eax,%eax
    186d:	79 f7                	jns    1866 <main+0x635>
	
	// Test 4: 20 hydrogen 10 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    186f:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1874:	89 04 24             	mov    %eax,(%esp)
    1877:	e8 ce f8 ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
    187c:	c7 44 24 04 f4 26 00 	movl   $0x26f4,0x4(%esp)
    1883:	00 
    1884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    188b:	e8 48 07 00 00       	call   1fd8 <printf>
	sem_signal(p);
    1890:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1895:	89 04 24             	mov    %eax,(%esp)
    1898:	e8 2c f9 ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    189d:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    18a2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    18a9:	00 
    18aa:	89 04 24             	mov    %eax,(%esp)
    18ad:	e8 63 f8 ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    18b2:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    18b7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18be:	00 
    18bf:	89 04 24             	mov    %eax,(%esp)
    18c2:	e8 4e f8 ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    18c7:	c7 05 0c 2c 00 00 00 	movl   $0x0,0x2c0c
    18ce:	00 00 00 
    18d1:	e9 7b 01 00 00       	jmp    1a51 <main+0x820>
		tid = thread_create(hReady, (void *) &arg);
    18d6:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    18dd:	00 
    18de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    18e5:	e8 15 0b 00 00       	call   23ff <thread_create>
    18ea:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    18ef:	a1 14 2c 00 00       	mov    0x2c14,%eax
    18f4:	85 c0                	test   %eax,%eax
    18f6:	75 33                	jne    192b <main+0x6fa>
			sem_acquire(p);
    18f8:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    18fd:	89 04 24             	mov    %eax,(%esp)
    1900:	e8 45 f8 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1905:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    190c:	00 
    190d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1914:	e8 bf 06 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1919:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    191e:	89 04 24             	mov    %eax,(%esp)
    1921:	e8 a3 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    1926:	e8 0d 05 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    192b:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1932:	00 00 00 
    1935:	eb 0d                	jmp    1944 <main+0x713>
    1937:	a1 10 2c 00 00       	mov    0x2c10,%eax
    193c:	83 c0 01             	add    $0x1,%eax
    193f:	a3 10 2c 00 00       	mov    %eax,0x2c10
    1944:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1949:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    194e:	7e e7                	jle    1937 <main+0x706>
		tid = thread_create(hReady, (void *) &arg);
    1950:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    1957:	00 
    1958:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    195f:	e8 9b 0a 00 00       	call   23ff <thread_create>
    1964:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    1969:	a1 14 2c 00 00       	mov    0x2c14,%eax
    196e:	85 c0                	test   %eax,%eax
    1970:	75 33                	jne    19a5 <main+0x774>
			sem_acquire(p);
    1972:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1977:	89 04 24             	mov    %eax,(%esp)
    197a:	e8 cb f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    197f:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1986:	00 
    1987:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198e:	e8 45 06 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1993:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1998:	89 04 24             	mov    %eax,(%esp)
    199b:	e8 29 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    19a0:	e8 93 04 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    19a5:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    19ac:	00 00 00 
    19af:	eb 0d                	jmp    19be <main+0x78d>
    19b1:	a1 10 2c 00 00       	mov    0x2c10,%eax
    19b6:	83 c0 01             	add    $0x1,%eax
    19b9:	a3 10 2c 00 00       	mov    %eax,0x2c10
    19be:	a1 10 2c 00 00       	mov    0x2c10,%eax
    19c3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    19c8:	7e e7                	jle    19b1 <main+0x780>
		tid = thread_create(oReady, (void *) &arg);
    19ca:	c7 44 24 04 d8 2b 00 	movl   $0x2bd8,0x4(%esp)
    19d1:	00 
    19d2:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    19d9:	e8 21 0a 00 00       	call   23ff <thread_create>
    19de:	a3 14 2c 00 00       	mov    %eax,0x2c14
		if(tid <= 0){
    19e3:	a1 14 2c 00 00       	mov    0x2c14,%eax
    19e8:	85 c0                	test   %eax,%eax
    19ea:	75 33                	jne    1a1f <main+0x7ee>
			sem_acquire(p);
    19ec:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    19f1:	89 04 24             	mov    %eax,(%esp)
    19f4:	e8 51 f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    19f9:	c7 44 24 04 51 26 00 	movl   $0x2651,0x4(%esp)
    1a00:	00 
    1a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a08:	e8 cb 05 00 00       	call   1fd8 <printf>
			sem_signal(p);
    1a0d:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1a12:	89 04 24             	mov    %eax,(%esp)
    1a15:	e8 af f7 ff ff       	call   11c9 <sem_signal>
			exit();
    1a1a:	e8 19 04 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1a1f:	c7 05 10 2c 00 00 00 	movl   $0x0,0x2c10
    1a26:	00 00 00 
    1a29:	eb 0d                	jmp    1a38 <main+0x807>
    1a2b:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1a30:	83 c0 01             	add    $0x1,%eax
    1a33:	a3 10 2c 00 00       	mov    %eax,0x2c10
    1a38:	a1 10 2c 00 00       	mov    0x2c10,%eax
    1a3d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1a42:	7e e7                	jle    1a2b <main+0x7fa>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1a44:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    1a49:	83 c0 01             	add    $0x1,%eax
    1a4c:	a3 0c 2c 00 00       	mov    %eax,0x2c0c
    1a51:	a1 0c 2c 00 00       	mov    0x2c0c,%eax
    1a56:	83 f8 09             	cmp    $0x9,%eax
    1a59:	0f 8e 77 fe ff ff    	jle    18d6 <main+0x6a5>
			sem_signal(p);
			exit();
		}
		for(i = 0; i < 999999; i++);
	}
	while(wait()>= 0);
    1a5f:	90                   	nop
    1a60:	e8 db 03 00 00       	call   1e40 <wait>
    1a65:	85 c0                	test   %eax,%eax
    1a67:	79 f7                	jns    1a60 <main+0x82f>
	
	exit();
    1a69:	e8 ca 03 00 00       	call   1e38 <exit>

00001a6e <hReady>:
	return 0;
}

//Hydrogen
void hReady(){
    1a6e:	55                   	push   %ebp
    1a6f:	89 e5                	mov    %esp,%ebp
    1a71:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1a74:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1a79:	89 04 24             	mov    %eax,(%esp)
    1a7c:	e8 c9 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Hydrogen ready\n");
    1a81:	c7 44 24 04 38 27 00 	movl   $0x2738,0x4(%esp)
    1a88:	00 
    1a89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a90:	e8 43 05 00 00       	call   1fd8 <printf>
	sem_signal(p);
    1a95:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1a9a:	89 04 24             	mov    %eax,(%esp)
    1a9d:	e8 27 f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(h);
    1aa2:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1aa7:	89 04 24             	mov    %eax,(%esp)
    1aaa:	e8 9b f6 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1aaf:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1ab4:	8b 00                	mov    (%eax),%eax
    1ab6:	85 c0                	test   %eax,%eax
    1ab8:	75 60                	jne    1b1a <hReady+0xac>
    1aba:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    1abf:	8b 00                	mov    (%eax),%eax
    1ac1:	85 c0                	test   %eax,%eax
    1ac3:	75 55                	jne    1b1a <hReady+0xac>
		sem_acquire(p);
    1ac5:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1aca:	89 04 24             	mov    %eax,(%esp)
    1acd:	e8 78 f6 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1ad2:	c7 44 24 04 48 27 00 	movl   $0x2748,0x4(%esp)
    1ad9:	00 
    1ada:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae1:	e8 f2 04 00 00       	call   1fd8 <printf>
		sem_signal(p);
    1ae6:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1aeb:	89 04 24             	mov    %eax,(%esp)
    1aee:	e8 d6 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1af3:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1af8:	89 04 24             	mov    %eax,(%esp)
    1afb:	e8 c9 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1b00:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1b05:	89 04 24             	mov    %eax,(%esp)
    1b08:	e8 bc f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1b0d:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    1b12:	89 04 24             	mov    %eax,(%esp)
    1b15:	e8 af f6 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1b1a:	e8 c1 03 00 00       	call   1ee0 <texit>

00001b1f <oReady>:
}

//Oxygen 
void oReady(){
    1b1f:	55                   	push   %ebp
    1b20:	89 e5                	mov    %esp,%ebp
    1b22:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1b25:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1b2a:	89 04 24             	mov    %eax,(%esp)
    1b2d:	e8 18 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Oxygen ready\n");
    1b32:	c7 44 24 04 59 27 00 	movl   $0x2759,0x4(%esp)
    1b39:	00 
    1b3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b41:	e8 92 04 00 00       	call   1fd8 <printf>
	sem_signal(p);
    1b46:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1b4b:	89 04 24             	mov    %eax,(%esp)
    1b4e:	e8 76 f6 ff ff       	call   11c9 <sem_signal>
	sem_acquire(o);
    1b53:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    1b58:	89 04 24             	mov    %eax,(%esp)
    1b5b:	e8 ea f5 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1b60:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1b65:	8b 00                	mov    (%eax),%eax
    1b67:	85 c0                	test   %eax,%eax
    1b69:	75 60                	jne    1bcb <oReady+0xac>
    1b6b:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    1b70:	8b 00                	mov    (%eax),%eax
    1b72:	85 c0                	test   %eax,%eax
    1b74:	75 55                	jne    1bcb <oReady+0xac>
		sem_acquire(p);
    1b76:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 c7 f5 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1b83:	c7 44 24 04 48 27 00 	movl   $0x2748,0x4(%esp)
    1b8a:	00 
    1b8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b92:	e8 41 04 00 00       	call   1fd8 <printf>
		sem_signal(p);
    1b97:	a1 fc 2b 00 00       	mov    0x2bfc,%eax
    1b9c:	89 04 24             	mov    %eax,(%esp)
    1b9f:	e8 25 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1ba4:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1ba9:	89 04 24             	mov    %eax,(%esp)
    1bac:	e8 18 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1bb1:	a1 f4 2b 00 00       	mov    0x2bf4,%eax
    1bb6:	89 04 24             	mov    %eax,(%esp)
    1bb9:	e8 0b f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1bbe:	a1 f8 2b 00 00       	mov    0x2bf8,%eax
    1bc3:	89 04 24             	mov    %eax,(%esp)
    1bc6:	e8 fe f5 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1bcb:	e8 10 03 00 00       	call   1ee0 <texit>

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
    1c01:	90                   	nop
    1c02:	8b 45 08             	mov    0x8(%ebp),%eax
    1c05:	8d 50 01             	lea    0x1(%eax),%edx
    1c08:	89 55 08             	mov    %edx,0x8(%ebp)
    1c0b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c0e:	8d 4a 01             	lea    0x1(%edx),%ecx
    1c11:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1c14:	0f b6 12             	movzbl (%edx),%edx
    1c17:	88 10                	mov    %dl,(%eax)
    1c19:	0f b6 00             	movzbl (%eax),%eax
    1c1c:	84 c0                	test   %al,%al
    1c1e:	75 e2                	jne    1c02 <strcpy+0xd>
    ;
  return os;
    1c20:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c23:	c9                   	leave  
    1c24:	c3                   	ret    

00001c25 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1c25:	55                   	push   %ebp
    1c26:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1c28:	eb 08                	jmp    1c32 <strcmp+0xd>
    p++, q++;
    1c2a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c2e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1c32:	8b 45 08             	mov    0x8(%ebp),%eax
    1c35:	0f b6 00             	movzbl (%eax),%eax
    1c38:	84 c0                	test   %al,%al
    1c3a:	74 10                	je     1c4c <strcmp+0x27>
    1c3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3f:	0f b6 10             	movzbl (%eax),%edx
    1c42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c45:	0f b6 00             	movzbl (%eax),%eax
    1c48:	38 c2                	cmp    %al,%dl
    1c4a:	74 de                	je     1c2a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1c4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4f:	0f b6 00             	movzbl (%eax),%eax
    1c52:	0f b6 d0             	movzbl %al,%edx
    1c55:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c58:	0f b6 00             	movzbl (%eax),%eax
    1c5b:	0f b6 c0             	movzbl %al,%eax
    1c5e:	29 c2                	sub    %eax,%edx
    1c60:	89 d0                	mov    %edx,%eax
}
    1c62:	5d                   	pop    %ebp
    1c63:	c3                   	ret    

00001c64 <strlen>:

uint
strlen(char *s)
{
    1c64:	55                   	push   %ebp
    1c65:	89 e5                	mov    %esp,%ebp
    1c67:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1c6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1c71:	eb 04                	jmp    1c77 <strlen+0x13>
    1c73:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1c77:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1c7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7d:	01 d0                	add    %edx,%eax
    1c7f:	0f b6 00             	movzbl (%eax),%eax
    1c82:	84 c0                	test   %al,%al
    1c84:	75 ed                	jne    1c73 <strlen+0xf>
    ;
  return n;
    1c86:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c89:	c9                   	leave  
    1c8a:	c3                   	ret    

00001c8b <memset>:

void*
memset(void *dst, int c, uint n)
{
    1c8b:	55                   	push   %ebp
    1c8c:	89 e5                	mov    %esp,%ebp
    1c8e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1c91:	8b 45 10             	mov    0x10(%ebp),%eax
    1c94:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c98:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c9b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca2:	89 04 24             	mov    %eax,(%esp)
    1ca5:	e8 26 ff ff ff       	call   1bd0 <stosb>
  return dst;
    1caa:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1cad:	c9                   	leave  
    1cae:	c3                   	ret    

00001caf <strchr>:

char*
strchr(const char *s, char c)
{
    1caf:	55                   	push   %ebp
    1cb0:	89 e5                	mov    %esp,%ebp
    1cb2:	83 ec 04             	sub    $0x4,%esp
    1cb5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cb8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1cbb:	eb 14                	jmp    1cd1 <strchr+0x22>
    if(*s == c)
    1cbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc0:	0f b6 00             	movzbl (%eax),%eax
    1cc3:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1cc6:	75 05                	jne    1ccd <strchr+0x1e>
      return (char*)s;
    1cc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccb:	eb 13                	jmp    1ce0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1ccd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1cd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd4:	0f b6 00             	movzbl (%eax),%eax
    1cd7:	84 c0                	test   %al,%al
    1cd9:	75 e2                	jne    1cbd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1cdb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ce0:	c9                   	leave  
    1ce1:	c3                   	ret    

00001ce2 <gets>:

char*
gets(char *buf, int max)
{
    1ce2:	55                   	push   %ebp
    1ce3:	89 e5                	mov    %esp,%ebp
    1ce5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1cef:	eb 4c                	jmp    1d3d <gets+0x5b>
    cc = read(0, &c, 1);
    1cf1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1cf8:	00 
    1cf9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1cfc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d00:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d07:	e8 44 01 00 00       	call   1e50 <read>
    1d0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1d0f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d13:	7f 02                	jg     1d17 <gets+0x35>
      break;
    1d15:	eb 31                	jmp    1d48 <gets+0x66>
    buf[i++] = c;
    1d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d1a:	8d 50 01             	lea    0x1(%eax),%edx
    1d1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1d20:	89 c2                	mov    %eax,%edx
    1d22:	8b 45 08             	mov    0x8(%ebp),%eax
    1d25:	01 c2                	add    %eax,%edx
    1d27:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d2b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1d2d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d31:	3c 0a                	cmp    $0xa,%al
    1d33:	74 13                	je     1d48 <gets+0x66>
    1d35:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d39:	3c 0d                	cmp    $0xd,%al
    1d3b:	74 0b                	je     1d48 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d40:	83 c0 01             	add    $0x1,%eax
    1d43:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d46:	7c a9                	jl     1cf1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1d48:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4e:	01 d0                	add    %edx,%eax
    1d50:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1d53:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1d56:	c9                   	leave  
    1d57:	c3                   	ret    

00001d58 <stat>:

int
stat(char *n, struct stat *st)
{
    1d58:	55                   	push   %ebp
    1d59:	89 e5                	mov    %esp,%ebp
    1d5b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1d5e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d65:	00 
    1d66:	8b 45 08             	mov    0x8(%ebp),%eax
    1d69:	89 04 24             	mov    %eax,(%esp)
    1d6c:	e8 07 01 00 00       	call   1e78 <open>
    1d71:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1d74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d78:	79 07                	jns    1d81 <stat+0x29>
    return -1;
    1d7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d7f:	eb 23                	jmp    1da4 <stat+0x4c>
  r = fstat(fd, st);
    1d81:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d84:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d8b:	89 04 24             	mov    %eax,(%esp)
    1d8e:	e8 fd 00 00 00       	call   1e90 <fstat>
    1d93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d99:	89 04 24             	mov    %eax,(%esp)
    1d9c:	e8 bf 00 00 00       	call   1e60 <close>
  return r;
    1da1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1da4:	c9                   	leave  
    1da5:	c3                   	ret    

00001da6 <atoi>:

int
atoi(const char *s)
{
    1da6:	55                   	push   %ebp
    1da7:	89 e5                	mov    %esp,%ebp
    1da9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1dac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1db3:	eb 25                	jmp    1dda <atoi+0x34>
    n = n*10 + *s++ - '0';
    1db5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1db8:	89 d0                	mov    %edx,%eax
    1dba:	c1 e0 02             	shl    $0x2,%eax
    1dbd:	01 d0                	add    %edx,%eax
    1dbf:	01 c0                	add    %eax,%eax
    1dc1:	89 c1                	mov    %eax,%ecx
    1dc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc6:	8d 50 01             	lea    0x1(%eax),%edx
    1dc9:	89 55 08             	mov    %edx,0x8(%ebp)
    1dcc:	0f b6 00             	movzbl (%eax),%eax
    1dcf:	0f be c0             	movsbl %al,%eax
    1dd2:	01 c8                	add    %ecx,%eax
    1dd4:	83 e8 30             	sub    $0x30,%eax
    1dd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1dda:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddd:	0f b6 00             	movzbl (%eax),%eax
    1de0:	3c 2f                	cmp    $0x2f,%al
    1de2:	7e 0a                	jle    1dee <atoi+0x48>
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	0f b6 00             	movzbl (%eax),%eax
    1dea:	3c 39                	cmp    $0x39,%al
    1dec:	7e c7                	jle    1db5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1df1:	c9                   	leave  
    1df2:	c3                   	ret    

00001df3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1df3:	55                   	push   %ebp
    1df4:	89 e5                	mov    %esp,%ebp
    1df6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1df9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1dff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e02:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1e05:	eb 17                	jmp    1e1e <memmove+0x2b>
    *dst++ = *src++;
    1e07:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1e0a:	8d 50 01             	lea    0x1(%eax),%edx
    1e0d:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1e10:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1e13:	8d 4a 01             	lea    0x1(%edx),%ecx
    1e16:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1e19:	0f b6 12             	movzbl (%edx),%edx
    1e1c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e1e:	8b 45 10             	mov    0x10(%ebp),%eax
    1e21:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e24:	89 55 10             	mov    %edx,0x10(%ebp)
    1e27:	85 c0                	test   %eax,%eax
    1e29:	7f dc                	jg     1e07 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1e2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1e2e:	c9                   	leave  
    1e2f:	c3                   	ret    

00001e30 <fork>:
    1e30:	b8 01 00 00 00       	mov    $0x1,%eax
    1e35:	cd 40                	int    $0x40
    1e37:	c3                   	ret    

00001e38 <exit>:
    1e38:	b8 02 00 00 00       	mov    $0x2,%eax
    1e3d:	cd 40                	int    $0x40
    1e3f:	c3                   	ret    

00001e40 <wait>:
    1e40:	b8 03 00 00 00       	mov    $0x3,%eax
    1e45:	cd 40                	int    $0x40
    1e47:	c3                   	ret    

00001e48 <pipe>:
    1e48:	b8 04 00 00 00       	mov    $0x4,%eax
    1e4d:	cd 40                	int    $0x40
    1e4f:	c3                   	ret    

00001e50 <read>:
    1e50:	b8 05 00 00 00       	mov    $0x5,%eax
    1e55:	cd 40                	int    $0x40
    1e57:	c3                   	ret    

00001e58 <write>:
    1e58:	b8 10 00 00 00       	mov    $0x10,%eax
    1e5d:	cd 40                	int    $0x40
    1e5f:	c3                   	ret    

00001e60 <close>:
    1e60:	b8 15 00 00 00       	mov    $0x15,%eax
    1e65:	cd 40                	int    $0x40
    1e67:	c3                   	ret    

00001e68 <kill>:
    1e68:	b8 06 00 00 00       	mov    $0x6,%eax
    1e6d:	cd 40                	int    $0x40
    1e6f:	c3                   	ret    

00001e70 <exec>:
    1e70:	b8 07 00 00 00       	mov    $0x7,%eax
    1e75:	cd 40                	int    $0x40
    1e77:	c3                   	ret    

00001e78 <open>:
    1e78:	b8 0f 00 00 00       	mov    $0xf,%eax
    1e7d:	cd 40                	int    $0x40
    1e7f:	c3                   	ret    

00001e80 <mknod>:
    1e80:	b8 11 00 00 00       	mov    $0x11,%eax
    1e85:	cd 40                	int    $0x40
    1e87:	c3                   	ret    

00001e88 <unlink>:
    1e88:	b8 12 00 00 00       	mov    $0x12,%eax
    1e8d:	cd 40                	int    $0x40
    1e8f:	c3                   	ret    

00001e90 <fstat>:
    1e90:	b8 08 00 00 00       	mov    $0x8,%eax
    1e95:	cd 40                	int    $0x40
    1e97:	c3                   	ret    

00001e98 <link>:
    1e98:	b8 13 00 00 00       	mov    $0x13,%eax
    1e9d:	cd 40                	int    $0x40
    1e9f:	c3                   	ret    

00001ea0 <mkdir>:
    1ea0:	b8 14 00 00 00       	mov    $0x14,%eax
    1ea5:	cd 40                	int    $0x40
    1ea7:	c3                   	ret    

00001ea8 <chdir>:
    1ea8:	b8 09 00 00 00       	mov    $0x9,%eax
    1ead:	cd 40                	int    $0x40
    1eaf:	c3                   	ret    

00001eb0 <dup>:
    1eb0:	b8 0a 00 00 00       	mov    $0xa,%eax
    1eb5:	cd 40                	int    $0x40
    1eb7:	c3                   	ret    

00001eb8 <getpid>:
    1eb8:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ebd:	cd 40                	int    $0x40
    1ebf:	c3                   	ret    

00001ec0 <sbrk>:
    1ec0:	b8 0c 00 00 00       	mov    $0xc,%eax
    1ec5:	cd 40                	int    $0x40
    1ec7:	c3                   	ret    

00001ec8 <sleep>:
    1ec8:	b8 0d 00 00 00       	mov    $0xd,%eax
    1ecd:	cd 40                	int    $0x40
    1ecf:	c3                   	ret    

00001ed0 <uptime>:
    1ed0:	b8 0e 00 00 00       	mov    $0xe,%eax
    1ed5:	cd 40                	int    $0x40
    1ed7:	c3                   	ret    

00001ed8 <clone>:
    1ed8:	b8 16 00 00 00       	mov    $0x16,%eax
    1edd:	cd 40                	int    $0x40
    1edf:	c3                   	ret    

00001ee0 <texit>:
    1ee0:	b8 17 00 00 00       	mov    $0x17,%eax
    1ee5:	cd 40                	int    $0x40
    1ee7:	c3                   	ret    

00001ee8 <tsleep>:
    1ee8:	b8 18 00 00 00       	mov    $0x18,%eax
    1eed:	cd 40                	int    $0x40
    1eef:	c3                   	ret    

00001ef0 <twakeup>:
    1ef0:	b8 19 00 00 00       	mov    $0x19,%eax
    1ef5:	cd 40                	int    $0x40
    1ef7:	c3                   	ret    

00001ef8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1ef8:	55                   	push   %ebp
    1ef9:	89 e5                	mov    %esp,%ebp
    1efb:	83 ec 18             	sub    $0x18,%esp
    1efe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f01:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f04:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f0b:	00 
    1f0c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f0f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f13:	8b 45 08             	mov    0x8(%ebp),%eax
    1f16:	89 04 24             	mov    %eax,(%esp)
    1f19:	e8 3a ff ff ff       	call   1e58 <write>
}
    1f1e:	c9                   	leave  
    1f1f:	c3                   	ret    

00001f20 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f20:	55                   	push   %ebp
    1f21:	89 e5                	mov    %esp,%ebp
    1f23:	56                   	push   %esi
    1f24:	53                   	push   %ebx
    1f25:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f28:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f2f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f33:	74 17                	je     1f4c <printint+0x2c>
    1f35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f39:	79 11                	jns    1f4c <printint+0x2c>
    neg = 1;
    1f3b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f45:	f7 d8                	neg    %eax
    1f47:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f4a:	eb 06                	jmp    1f52 <printint+0x32>
  } else {
    x = xx;
    1f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1f52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1f59:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1f5c:	8d 41 01             	lea    0x1(%ecx),%eax
    1f5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f62:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1f65:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f68:	ba 00 00 00 00       	mov    $0x0,%edx
    1f6d:	f7 f3                	div    %ebx
    1f6f:	89 d0                	mov    %edx,%eax
    1f71:	0f b6 80 dc 2b 00 00 	movzbl 0x2bdc(%eax),%eax
    1f78:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1f7c:	8b 75 10             	mov    0x10(%ebp),%esi
    1f7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f82:	ba 00 00 00 00       	mov    $0x0,%edx
    1f87:	f7 f6                	div    %esi
    1f89:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f8c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f90:	75 c7                	jne    1f59 <printint+0x39>
  if(neg)
    1f92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f96:	74 10                	je     1fa8 <printint+0x88>
    buf[i++] = '-';
    1f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f9b:	8d 50 01             	lea    0x1(%eax),%edx
    1f9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1fa1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1fa6:	eb 1f                	jmp    1fc7 <printint+0xa7>
    1fa8:	eb 1d                	jmp    1fc7 <printint+0xa7>
    putc(fd, buf[i]);
    1faa:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb0:	01 d0                	add    %edx,%eax
    1fb2:	0f b6 00             	movzbl (%eax),%eax
    1fb5:	0f be c0             	movsbl %al,%eax
    1fb8:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbf:	89 04 24             	mov    %eax,(%esp)
    1fc2:	e8 31 ff ff ff       	call   1ef8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1fc7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1fcb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fcf:	79 d9                	jns    1faa <printint+0x8a>
    putc(fd, buf[i]);
}
    1fd1:	83 c4 30             	add    $0x30,%esp
    1fd4:	5b                   	pop    %ebx
    1fd5:	5e                   	pop    %esi
    1fd6:	5d                   	pop    %ebp
    1fd7:	c3                   	ret    

00001fd8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1fd8:	55                   	push   %ebp
    1fd9:	89 e5                	mov    %esp,%ebp
    1fdb:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1fde:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1fe5:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fe8:	83 c0 04             	add    $0x4,%eax
    1feb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1fee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ff5:	e9 7c 01 00 00       	jmp    2176 <printf+0x19e>
    c = fmt[i] & 0xff;
    1ffa:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ffd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2000:	01 d0                	add    %edx,%eax
    2002:	0f b6 00             	movzbl (%eax),%eax
    2005:	0f be c0             	movsbl %al,%eax
    2008:	25 ff 00 00 00       	and    $0xff,%eax
    200d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    2010:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2014:	75 2c                	jne    2042 <printf+0x6a>
      if(c == '%'){
    2016:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    201a:	75 0c                	jne    2028 <printf+0x50>
        state = '%';
    201c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    2023:	e9 4a 01 00 00       	jmp    2172 <printf+0x19a>
      } else {
        putc(fd, c);
    2028:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    202b:	0f be c0             	movsbl %al,%eax
    202e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2032:	8b 45 08             	mov    0x8(%ebp),%eax
    2035:	89 04 24             	mov    %eax,(%esp)
    2038:	e8 bb fe ff ff       	call   1ef8 <putc>
    203d:	e9 30 01 00 00       	jmp    2172 <printf+0x19a>
      }
    } else if(state == '%'){
    2042:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    2046:	0f 85 26 01 00 00    	jne    2172 <printf+0x19a>
      if(c == 'd'){
    204c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    2050:	75 2d                	jne    207f <printf+0xa7>
        printint(fd, *ap, 10, 1);
    2052:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2055:	8b 00                	mov    (%eax),%eax
    2057:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    205e:	00 
    205f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2066:	00 
    2067:	89 44 24 04          	mov    %eax,0x4(%esp)
    206b:	8b 45 08             	mov    0x8(%ebp),%eax
    206e:	89 04 24             	mov    %eax,(%esp)
    2071:	e8 aa fe ff ff       	call   1f20 <printint>
        ap++;
    2076:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    207a:	e9 ec 00 00 00       	jmp    216b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    207f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    2083:	74 06                	je     208b <printf+0xb3>
    2085:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    2089:	75 2d                	jne    20b8 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    208b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    208e:	8b 00                	mov    (%eax),%eax
    2090:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2097:	00 
    2098:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    209f:	00 
    20a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    20a4:	8b 45 08             	mov    0x8(%ebp),%eax
    20a7:	89 04 24             	mov    %eax,(%esp)
    20aa:	e8 71 fe ff ff       	call   1f20 <printint>
        ap++;
    20af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20b3:	e9 b3 00 00 00       	jmp    216b <printf+0x193>
      } else if(c == 's'){
    20b8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    20bc:	75 45                	jne    2103 <printf+0x12b>
        s = (char*)*ap;
    20be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20c1:	8b 00                	mov    (%eax),%eax
    20c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    20c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    20ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20ce:	75 09                	jne    20d9 <printf+0x101>
          s = "(null)";
    20d0:	c7 45 f4 67 27 00 00 	movl   $0x2767,-0xc(%ebp)
        while(*s != 0){
    20d7:	eb 1e                	jmp    20f7 <printf+0x11f>
    20d9:	eb 1c                	jmp    20f7 <printf+0x11f>
          putc(fd, *s);
    20db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20de:	0f b6 00             	movzbl (%eax),%eax
    20e1:	0f be c0             	movsbl %al,%eax
    20e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    20e8:	8b 45 08             	mov    0x8(%ebp),%eax
    20eb:	89 04 24             	mov    %eax,(%esp)
    20ee:	e8 05 fe ff ff       	call   1ef8 <putc>
          s++;
    20f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    20f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20fa:	0f b6 00             	movzbl (%eax),%eax
    20fd:	84 c0                	test   %al,%al
    20ff:	75 da                	jne    20db <printf+0x103>
    2101:	eb 68                	jmp    216b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2103:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    2107:	75 1d                	jne    2126 <printf+0x14e>
        putc(fd, *ap);
    2109:	8b 45 e8             	mov    -0x18(%ebp),%eax
    210c:	8b 00                	mov    (%eax),%eax
    210e:	0f be c0             	movsbl %al,%eax
    2111:	89 44 24 04          	mov    %eax,0x4(%esp)
    2115:	8b 45 08             	mov    0x8(%ebp),%eax
    2118:	89 04 24             	mov    %eax,(%esp)
    211b:	e8 d8 fd ff ff       	call   1ef8 <putc>
        ap++;
    2120:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2124:	eb 45                	jmp    216b <printf+0x193>
      } else if(c == '%'){
    2126:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    212a:	75 17                	jne    2143 <printf+0x16b>
        putc(fd, c);
    212c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212f:	0f be c0             	movsbl %al,%eax
    2132:	89 44 24 04          	mov    %eax,0x4(%esp)
    2136:	8b 45 08             	mov    0x8(%ebp),%eax
    2139:	89 04 24             	mov    %eax,(%esp)
    213c:	e8 b7 fd ff ff       	call   1ef8 <putc>
    2141:	eb 28                	jmp    216b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2143:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    214a:	00 
    214b:	8b 45 08             	mov    0x8(%ebp),%eax
    214e:	89 04 24             	mov    %eax,(%esp)
    2151:	e8 a2 fd ff ff       	call   1ef8 <putc>
        putc(fd, c);
    2156:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2159:	0f be c0             	movsbl %al,%eax
    215c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2160:	8b 45 08             	mov    0x8(%ebp),%eax
    2163:	89 04 24             	mov    %eax,(%esp)
    2166:	e8 8d fd ff ff       	call   1ef8 <putc>
      }
      state = 0;
    216b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2172:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2176:	8b 55 0c             	mov    0xc(%ebp),%edx
    2179:	8b 45 f0             	mov    -0x10(%ebp),%eax
    217c:	01 d0                	add    %edx,%eax
    217e:	0f b6 00             	movzbl (%eax),%eax
    2181:	84 c0                	test   %al,%al
    2183:	0f 85 71 fe ff ff    	jne    1ffa <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2189:	c9                   	leave  
    218a:	c3                   	ret    
    218b:	90                   	nop

0000218c <free>:
    218c:	55                   	push   %ebp
    218d:	89 e5                	mov    %esp,%ebp
    218f:	83 ec 10             	sub    $0x10,%esp
    2192:	8b 45 08             	mov    0x8(%ebp),%eax
    2195:	83 e8 08             	sub    $0x8,%eax
    2198:	89 45 f8             	mov    %eax,-0x8(%ebp)
    219b:	a1 08 2c 00 00       	mov    0x2c08,%eax
    21a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21a3:	eb 24                	jmp    21c9 <free+0x3d>
    21a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21a8:	8b 00                	mov    (%eax),%eax
    21aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21ad:	77 12                	ja     21c1 <free+0x35>
    21af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21b5:	77 24                	ja     21db <free+0x4f>
    21b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21ba:	8b 00                	mov    (%eax),%eax
    21bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21bf:	77 1a                	ja     21db <free+0x4f>
    21c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21c4:	8b 00                	mov    (%eax),%eax
    21c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21cf:	76 d4                	jbe    21a5 <free+0x19>
    21d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21d4:	8b 00                	mov    (%eax),%eax
    21d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21d9:	76 ca                	jbe    21a5 <free+0x19>
    21db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21de:	8b 40 04             	mov    0x4(%eax),%eax
    21e1:	c1 e0 03             	shl    $0x3,%eax
    21e4:	89 c2                	mov    %eax,%edx
    21e6:	03 55 f8             	add    -0x8(%ebp),%edx
    21e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21ec:	8b 00                	mov    (%eax),%eax
    21ee:	39 c2                	cmp    %eax,%edx
    21f0:	75 24                	jne    2216 <free+0x8a>
    21f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21f5:	8b 50 04             	mov    0x4(%eax),%edx
    21f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21fb:	8b 00                	mov    (%eax),%eax
    21fd:	8b 40 04             	mov    0x4(%eax),%eax
    2200:	01 c2                	add    %eax,%edx
    2202:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2205:	89 50 04             	mov    %edx,0x4(%eax)
    2208:	8b 45 fc             	mov    -0x4(%ebp),%eax
    220b:	8b 00                	mov    (%eax),%eax
    220d:	8b 10                	mov    (%eax),%edx
    220f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2212:	89 10                	mov    %edx,(%eax)
    2214:	eb 0a                	jmp    2220 <free+0x94>
    2216:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2219:	8b 10                	mov    (%eax),%edx
    221b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    221e:	89 10                	mov    %edx,(%eax)
    2220:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2223:	8b 40 04             	mov    0x4(%eax),%eax
    2226:	c1 e0 03             	shl    $0x3,%eax
    2229:	03 45 fc             	add    -0x4(%ebp),%eax
    222c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    222f:	75 20                	jne    2251 <free+0xc5>
    2231:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2234:	8b 50 04             	mov    0x4(%eax),%edx
    2237:	8b 45 f8             	mov    -0x8(%ebp),%eax
    223a:	8b 40 04             	mov    0x4(%eax),%eax
    223d:	01 c2                	add    %eax,%edx
    223f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2242:	89 50 04             	mov    %edx,0x4(%eax)
    2245:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2248:	8b 10                	mov    (%eax),%edx
    224a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    224d:	89 10                	mov    %edx,(%eax)
    224f:	eb 08                	jmp    2259 <free+0xcd>
    2251:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2254:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2257:	89 10                	mov    %edx,(%eax)
    2259:	8b 45 fc             	mov    -0x4(%ebp),%eax
    225c:	a3 08 2c 00 00       	mov    %eax,0x2c08
    2261:	c9                   	leave  
    2262:	c3                   	ret    

00002263 <morecore>:
    2263:	55                   	push   %ebp
    2264:	89 e5                	mov    %esp,%ebp
    2266:	83 ec 28             	sub    $0x28,%esp
    2269:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2270:	77 07                	ja     2279 <morecore+0x16>
    2272:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    2279:	8b 45 08             	mov    0x8(%ebp),%eax
    227c:	c1 e0 03             	shl    $0x3,%eax
    227f:	89 04 24             	mov    %eax,(%esp)
    2282:	e8 39 fc ff ff       	call   1ec0 <sbrk>
    2287:	89 45 f0             	mov    %eax,-0x10(%ebp)
    228a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    228e:	75 07                	jne    2297 <morecore+0x34>
    2290:	b8 00 00 00 00       	mov    $0x0,%eax
    2295:	eb 22                	jmp    22b9 <morecore+0x56>
    2297:	8b 45 f0             	mov    -0x10(%ebp),%eax
    229a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    229d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a0:	8b 55 08             	mov    0x8(%ebp),%edx
    22a3:	89 50 04             	mov    %edx,0x4(%eax)
    22a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a9:	83 c0 08             	add    $0x8,%eax
    22ac:	89 04 24             	mov    %eax,(%esp)
    22af:	e8 d8 fe ff ff       	call   218c <free>
    22b4:	a1 08 2c 00 00       	mov    0x2c08,%eax
    22b9:	c9                   	leave  
    22ba:	c3                   	ret    

000022bb <malloc>:
    22bb:	55                   	push   %ebp
    22bc:	89 e5                	mov    %esp,%ebp
    22be:	83 ec 28             	sub    $0x28,%esp
    22c1:	8b 45 08             	mov    0x8(%ebp),%eax
    22c4:	83 c0 07             	add    $0x7,%eax
    22c7:	c1 e8 03             	shr    $0x3,%eax
    22ca:	83 c0 01             	add    $0x1,%eax
    22cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22d0:	a1 08 2c 00 00       	mov    0x2c08,%eax
    22d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22dc:	75 23                	jne    2301 <malloc+0x46>
    22de:	c7 45 f0 00 2c 00 00 	movl   $0x2c00,-0x10(%ebp)
    22e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22e8:	a3 08 2c 00 00       	mov    %eax,0x2c08
    22ed:	a1 08 2c 00 00       	mov    0x2c08,%eax
    22f2:	a3 00 2c 00 00       	mov    %eax,0x2c00
    22f7:	c7 05 04 2c 00 00 00 	movl   $0x0,0x2c04
    22fe:	00 00 00 
    2301:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2304:	8b 00                	mov    (%eax),%eax
    2306:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2309:	8b 45 ec             	mov    -0x14(%ebp),%eax
    230c:	8b 40 04             	mov    0x4(%eax),%eax
    230f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2312:	72 4d                	jb     2361 <malloc+0xa6>
    2314:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2317:	8b 40 04             	mov    0x4(%eax),%eax
    231a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    231d:	75 0c                	jne    232b <malloc+0x70>
    231f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2322:	8b 10                	mov    (%eax),%edx
    2324:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2327:	89 10                	mov    %edx,(%eax)
    2329:	eb 26                	jmp    2351 <malloc+0x96>
    232b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    232e:	8b 40 04             	mov    0x4(%eax),%eax
    2331:	89 c2                	mov    %eax,%edx
    2333:	2b 55 f4             	sub    -0xc(%ebp),%edx
    2336:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2339:	89 50 04             	mov    %edx,0x4(%eax)
    233c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    233f:	8b 40 04             	mov    0x4(%eax),%eax
    2342:	c1 e0 03             	shl    $0x3,%eax
    2345:	01 45 ec             	add    %eax,-0x14(%ebp)
    2348:	8b 45 ec             	mov    -0x14(%ebp),%eax
    234b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    234e:	89 50 04             	mov    %edx,0x4(%eax)
    2351:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2354:	a3 08 2c 00 00       	mov    %eax,0x2c08
    2359:	8b 45 ec             	mov    -0x14(%ebp),%eax
    235c:	83 c0 08             	add    $0x8,%eax
    235f:	eb 38                	jmp    2399 <malloc+0xde>
    2361:	a1 08 2c 00 00       	mov    0x2c08,%eax
    2366:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    2369:	75 1b                	jne    2386 <malloc+0xcb>
    236b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    236e:	89 04 24             	mov    %eax,(%esp)
    2371:	e8 ed fe ff ff       	call   2263 <morecore>
    2376:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2379:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    237d:	75 07                	jne    2386 <malloc+0xcb>
    237f:	b8 00 00 00 00       	mov    $0x0,%eax
    2384:	eb 13                	jmp    2399 <malloc+0xde>
    2386:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2389:	89 45 f0             	mov    %eax,-0x10(%ebp)
    238c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    238f:	8b 00                	mov    (%eax),%eax
    2391:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2394:	e9 70 ff ff ff       	jmp    2309 <malloc+0x4e>
    2399:	c9                   	leave  
    239a:	c3                   	ret    
    239b:	90                   	nop

0000239c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    239c:	55                   	push   %ebp
    239d:	89 e5                	mov    %esp,%ebp
    239f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    23a2:	8b 55 08             	mov    0x8(%ebp),%edx
    23a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    23a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23ab:	f0 87 02             	lock xchg %eax,(%edx)
    23ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    23b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    23b4:	c9                   	leave  
    23b5:	c3                   	ret    

000023b6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    23b6:	55                   	push   %ebp
    23b7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    23b9:	8b 45 08             	mov    0x8(%ebp),%eax
    23bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    23c2:	5d                   	pop    %ebp
    23c3:	c3                   	ret    

000023c4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    23c4:	55                   	push   %ebp
    23c5:	89 e5                	mov    %esp,%ebp
    23c7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    23ca:	90                   	nop
    23cb:	8b 45 08             	mov    0x8(%ebp),%eax
    23ce:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    23d5:	00 
    23d6:	89 04 24             	mov    %eax,(%esp)
    23d9:	e8 be ff ff ff       	call   239c <xchg>
    23de:	85 c0                	test   %eax,%eax
    23e0:	75 e9                	jne    23cb <lock_acquire+0x7>
}
    23e2:	c9                   	leave  
    23e3:	c3                   	ret    

000023e4 <lock_release>:
void lock_release(lock_t *lock){
    23e4:	55                   	push   %ebp
    23e5:	89 e5                	mov    %esp,%ebp
    23e7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    23ea:	8b 45 08             	mov    0x8(%ebp),%eax
    23ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23f4:	00 
    23f5:	89 04 24             	mov    %eax,(%esp)
    23f8:	e8 9f ff ff ff       	call   239c <xchg>
}
    23fd:	c9                   	leave  
    23fe:	c3                   	ret    

000023ff <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    23ff:	55                   	push   %ebp
    2400:	89 e5                	mov    %esp,%ebp
    2402:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2405:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    240c:	e8 aa fe ff ff       	call   22bb <malloc>
    2411:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    2414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2417:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    241a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    241d:	25 ff 0f 00 00       	and    $0xfff,%eax
    2422:	85 c0                	test   %eax,%eax
    2424:	74 14                	je     243a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    2426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2429:	25 ff 0f 00 00       	and    $0xfff,%eax
    242e:	89 c2                	mov    %eax,%edx
    2430:	b8 00 10 00 00       	mov    $0x1000,%eax
    2435:	29 d0                	sub    %edx,%eax
    2437:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    243a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    243e:	75 1b                	jne    245b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    2440:	c7 44 24 04 6e 27 00 	movl   $0x276e,0x4(%esp)
    2447:	00 
    2448:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    244f:	e8 84 fb ff ff       	call   1fd8 <printf>
        return 0;
    2454:	b8 00 00 00 00       	mov    $0x0,%eax
    2459:	eb 6f                	jmp    24ca <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    245b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    245e:	8b 55 08             	mov    0x8(%ebp),%edx
    2461:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2464:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    2468:	89 54 24 08          	mov    %edx,0x8(%esp)
    246c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    2473:	00 
    2474:	89 04 24             	mov    %eax,(%esp)
    2477:	e8 5c fa ff ff       	call   1ed8 <clone>
    247c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    247f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2483:	79 1b                	jns    24a0 <thread_create+0xa1>
        printf(1,"clone fails\n");
    2485:	c7 44 24 04 7c 27 00 	movl   $0x277c,0x4(%esp)
    248c:	00 
    248d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2494:	e8 3f fb ff ff       	call   1fd8 <printf>
        return 0;
    2499:	b8 00 00 00 00       	mov    $0x0,%eax
    249e:	eb 2a                	jmp    24ca <thread_create+0xcb>
    }
    if(tid > 0){
    24a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24a4:	7e 05                	jle    24ab <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    24a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24a9:	eb 1f                	jmp    24ca <thread_create+0xcb>
    }
    if(tid == 0){
    24ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24af:	75 14                	jne    24c5 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    24b1:	c7 44 24 04 89 27 00 	movl   $0x2789,0x4(%esp)
    24b8:	00 
    24b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24c0:	e8 13 fb ff ff       	call   1fd8 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    24c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    24ca:	c9                   	leave  
    24cb:	c3                   	ret    

000024cc <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    24cc:	55                   	push   %ebp
    24cd:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    24cf:	a1 f0 2b 00 00       	mov    0x2bf0,%eax
    24d4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    24da:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    24df:	a3 f0 2b 00 00       	mov    %eax,0x2bf0
    return (int)(rands % max);
    24e4:	a1 f0 2b 00 00       	mov    0x2bf0,%eax
    24e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    24ec:	ba 00 00 00 00       	mov    $0x0,%edx
    24f1:	f7 f1                	div    %ecx
    24f3:	89 d0                	mov    %edx,%eax
}
    24f5:	5d                   	pop    %ebp
    24f6:	c3                   	ret    
    24f7:	90                   	nop

000024f8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    24f8:	55                   	push   %ebp
    24f9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    24fb:	8b 45 08             	mov    0x8(%ebp),%eax
    24fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2504:	8b 45 08             	mov    0x8(%ebp),%eax
    2507:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    250e:	8b 45 08             	mov    0x8(%ebp),%eax
    2511:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    2518:	5d                   	pop    %ebp
    2519:	c3                   	ret    

0000251a <add_q>:

void add_q(struct queue *q, int v){
    251a:	55                   	push   %ebp
    251b:	89 e5                	mov    %esp,%ebp
    251d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2520:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2527:	e8 8f fd ff ff       	call   22bb <malloc>
    252c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    252f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2532:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2539:	8b 45 f4             	mov    -0xc(%ebp),%eax
    253c:	8b 55 0c             	mov    0xc(%ebp),%edx
    253f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2541:	8b 45 08             	mov    0x8(%ebp),%eax
    2544:	8b 40 04             	mov    0x4(%eax),%eax
    2547:	85 c0                	test   %eax,%eax
    2549:	75 0b                	jne    2556 <add_q+0x3c>
        q->head = n;
    254b:	8b 45 08             	mov    0x8(%ebp),%eax
    254e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2551:	89 50 04             	mov    %edx,0x4(%eax)
    2554:	eb 0c                	jmp    2562 <add_q+0x48>
    }else{
        q->tail->next = n;
    2556:	8b 45 08             	mov    0x8(%ebp),%eax
    2559:	8b 40 08             	mov    0x8(%eax),%eax
    255c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    255f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    2562:	8b 45 08             	mov    0x8(%ebp),%eax
    2565:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2568:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    256b:	8b 45 08             	mov    0x8(%ebp),%eax
    256e:	8b 00                	mov    (%eax),%eax
    2570:	8d 50 01             	lea    0x1(%eax),%edx
    2573:	8b 45 08             	mov    0x8(%ebp),%eax
    2576:	89 10                	mov    %edx,(%eax)
}
    2578:	c9                   	leave  
    2579:	c3                   	ret    

0000257a <empty_q>:

int empty_q(struct queue *q){
    257a:	55                   	push   %ebp
    257b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    257d:	8b 45 08             	mov    0x8(%ebp),%eax
    2580:	8b 00                	mov    (%eax),%eax
    2582:	85 c0                	test   %eax,%eax
    2584:	75 07                	jne    258d <empty_q+0x13>
        return 1;
    2586:	b8 01 00 00 00       	mov    $0x1,%eax
    258b:	eb 05                	jmp    2592 <empty_q+0x18>
    else
        return 0;
    258d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    2592:	5d                   	pop    %ebp
    2593:	c3                   	ret    

00002594 <pop_q>:
int pop_q(struct queue *q){
    2594:	55                   	push   %ebp
    2595:	89 e5                	mov    %esp,%ebp
    2597:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    259a:	8b 45 08             	mov    0x8(%ebp),%eax
    259d:	89 04 24             	mov    %eax,(%esp)
    25a0:	e8 d5 ff ff ff       	call   257a <empty_q>
    25a5:	85 c0                	test   %eax,%eax
    25a7:	75 5d                	jne    2606 <pop_q+0x72>
       val = q->head->value; 
    25a9:	8b 45 08             	mov    0x8(%ebp),%eax
    25ac:	8b 40 04             	mov    0x4(%eax),%eax
    25af:	8b 00                	mov    (%eax),%eax
    25b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    25b4:	8b 45 08             	mov    0x8(%ebp),%eax
    25b7:	8b 40 04             	mov    0x4(%eax),%eax
    25ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    25bd:	8b 45 08             	mov    0x8(%ebp),%eax
    25c0:	8b 40 04             	mov    0x4(%eax),%eax
    25c3:	8b 50 04             	mov    0x4(%eax),%edx
    25c6:	8b 45 08             	mov    0x8(%ebp),%eax
    25c9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    25cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25cf:	89 04 24             	mov    %eax,(%esp)
    25d2:	e8 b5 fb ff ff       	call   218c <free>
       q->size--;
    25d7:	8b 45 08             	mov    0x8(%ebp),%eax
    25da:	8b 00                	mov    (%eax),%eax
    25dc:	8d 50 ff             	lea    -0x1(%eax),%edx
    25df:	8b 45 08             	mov    0x8(%ebp),%eax
    25e2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    25e4:	8b 45 08             	mov    0x8(%ebp),%eax
    25e7:	8b 00                	mov    (%eax),%eax
    25e9:	85 c0                	test   %eax,%eax
    25eb:	75 14                	jne    2601 <pop_q+0x6d>
            q->head = 0;
    25ed:	8b 45 08             	mov    0x8(%ebp),%eax
    25f0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    25f7:	8b 45 08             	mov    0x8(%ebp),%eax
    25fa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2604:	eb 05                	jmp    260b <pop_q+0x77>
    }
    return -1;
    2606:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    260b:	c9                   	leave  
    260c:	c3                   	ret    
