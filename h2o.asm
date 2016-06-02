
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
    102f:	e8 99 12 00 00       	call   22cd <malloc>
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
    10da:	e8 b5 10 00 00       	call   2194 <free>
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
    1143:	e8 82 12 00 00       	call   23ca <lock_init>
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
    1162:	e8 71 12 00 00       	call   23d8 <lock_acquire>
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
    117d:	e8 76 12 00 00       	call   23f8 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 46 12 00 00       	call   23d8 <lock_acquire>
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
    11b2:	e8 41 12 00 00       	call   23f8 <lock_release>
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
    11e7:	e8 ec 11 00 00       	call   23d8 <lock_acquire>
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
    1202:	e8 f1 11 00 00       	call   23f8 <lock_release>
		
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
    1241:	e8 87 10 00 00       	call   22cd <malloc>
    1246:	a3 68 2c 00 00       	mov    %eax,0x2c68
	o = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 76 10 00 00       	call   22cd <malloc>
    1257:	a3 6c 2c 00 00       	mov    %eax,0x2c6c
	p = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 65 10 00 00       	call   22cd <malloc>
    1268:	a3 70 2c 00 00       	mov    %eax,0x2c70
	sem_init(p, 1);
    126d:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>

	// Test 1: 2 hydrogen 1 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    1282:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1287:	89 04 24             	mov    %eax,(%esp)
    128a:	e8 bb fe ff ff       	call   114a <sem_acquire>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
    128f:	c7 44 24 04 24 26 00 	movl   $0x2624,0x4(%esp)
    1296:	00 
    1297:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129e:	e8 3d 0d 00 00       	call   1fe0 <printf>
	sem_signal(p);
    12a3:	a1 70 2c 00 00       	mov    0x2c70,%eax
    12a8:	89 04 24             	mov    %eax,(%esp)
    12ab:	e8 19 ff ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    12b0:	a1 68 2c 00 00       	mov    0x2c68,%eax
    12b5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12bc:	00 
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 50 fe ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    12c5:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    12ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 3b fe ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 1; water++){
    12da:	c7 05 80 2c 00 00 00 	movl   $0x0,0x2c80
    12e1:	00 00 00 
    12e4:	e9 7b 01 00 00       	jmp    1464 <main+0x233>
		tid = thread_create(hReady, (void *) &arg);
    12e9:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    12f0:	00 
    12f1:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    12f8:	e8 16 11 00 00       	call   2413 <thread_create>
    12fd:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    1302:	a1 88 2c 00 00       	mov    0x2c88,%eax
    1307:	85 c0                	test   %eax,%eax
    1309:	75 33                	jne    133e <main+0x10d>
			sem_acquire(p);
    130b:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1310:	89 04 24             	mov    %eax,(%esp)
    1313:	e8 32 fe ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1318:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    131f:	00 
    1320:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1327:	e8 b4 0c 00 00       	call   1fe0 <printf>
			sem_signal(p);
    132c:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 90 fe ff ff       	call   11c9 <sem_signal>
			exit();
    1339:	e8 fa 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    133e:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1345:	00 00 00 
    1348:	eb 0d                	jmp    1357 <main+0x126>
    134a:	a1 84 2c 00 00       	mov    0x2c84,%eax
    134f:	83 c0 01             	add    $0x1,%eax
    1352:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1357:	a1 84 2c 00 00       	mov    0x2c84,%eax
    135c:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1361:	7e e7                	jle    134a <main+0x119>
		tid = thread_create(hReady, (void *) &arg);
    1363:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    136a:	00 
    136b:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    1372:	e8 9c 10 00 00       	call   2413 <thread_create>
    1377:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    137c:	a1 88 2c 00 00       	mov    0x2c88,%eax
    1381:	85 c0                	test   %eax,%eax
    1383:	75 33                	jne    13b8 <main+0x187>
			sem_acquire(p);
    1385:	a1 70 2c 00 00       	mov    0x2c70,%eax
    138a:	89 04 24             	mov    %eax,(%esp)
    138d:	e8 b8 fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1392:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1399:	00 
    139a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a1:	e8 3a 0c 00 00       	call   1fe0 <printf>
			sem_signal(p);
    13a6:	a1 70 2c 00 00       	mov    0x2c70,%eax
    13ab:	89 04 24             	mov    %eax,(%esp)
    13ae:	e8 16 fe ff ff       	call   11c9 <sem_signal>
			exit();
    13b3:	e8 80 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    13b8:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    13bf:	00 00 00 
    13c2:	eb 0d                	jmp    13d1 <main+0x1a0>
    13c4:	a1 84 2c 00 00       	mov    0x2c84,%eax
    13c9:	83 c0 01             	add    $0x1,%eax
    13cc:	a3 84 2c 00 00       	mov    %eax,0x2c84
    13d1:	a1 84 2c 00 00       	mov    0x2c84,%eax
    13d6:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13db:	7e e7                	jle    13c4 <main+0x193>
		tid = thread_create(oReady, (void *) &arg);
    13dd:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    13e4:	00 
    13e5:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    13ec:	e8 22 10 00 00       	call   2413 <thread_create>
    13f1:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    13f6:	a1 88 2c 00 00       	mov    0x2c88,%eax
    13fb:	85 c0                	test   %eax,%eax
    13fd:	75 33                	jne    1432 <main+0x201>
			sem_acquire(p);
    13ff:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1404:	89 04 24             	mov    %eax,(%esp)
    1407:	e8 3e fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    140c:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1413:	00 
    1414:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141b:	e8 c0 0b 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1420:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1425:	89 04 24             	mov    %eax,(%esp)
    1428:	e8 9c fd ff ff       	call   11c9 <sem_signal>
			exit();
    142d:	e8 06 0a 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1432:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1439:	00 00 00 
    143c:	eb 0d                	jmp    144b <main+0x21a>
    143e:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1443:	83 c0 01             	add    $0x1,%eax
    1446:	a3 84 2c 00 00       	mov    %eax,0x2c84
    144b:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1450:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1455:	7e e7                	jle    143e <main+0x20d>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 1; water++){
    1457:	a1 80 2c 00 00       	mov    0x2c80,%eax
    145c:	83 c0 01             	add    $0x1,%eax
    145f:	a3 80 2c 00 00       	mov    %eax,0x2c80
    1464:	a1 80 2c 00 00       	mov    0x2c80,%eax
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
    147b:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1480:	89 04 24             	mov    %eax,(%esp)
    1483:	e8 c2 fc ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
    1488:	c7 44 24 04 80 26 00 	movl   $0x2680,0x4(%esp)
    148f:	00 
    1490:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1497:	e8 44 0b 00 00       	call   1fe0 <printf>
	sem_signal(p);
    149c:	a1 70 2c 00 00       	mov    0x2c70,%eax
    14a1:	89 04 24             	mov    %eax,(%esp)
    14a4:	e8 20 fd ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    14a9:	a1 68 2c 00 00       	mov    0x2c68,%eax
    14ae:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    14b5:	00 
    14b6:	89 04 24             	mov    %eax,(%esp)
    14b9:	e8 57 fc ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    14be:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    14c3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    14ca:	00 
    14cb:	89 04 24             	mov    %eax,(%esp)
    14ce:	e8 42 fc ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    14d3:	c7 05 80 2c 00 00 00 	movl   $0x0,0x2c80
    14da:	00 00 00 
    14dd:	e9 7b 01 00 00       	jmp    165d <main+0x42c>
		tid = thread_create(oReady, (void *) &arg);
    14e2:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    14e9:	00 
    14ea:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    14f1:	e8 1d 0f 00 00       	call   2413 <thread_create>
    14f6:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    14fb:	a1 88 2c 00 00       	mov    0x2c88,%eax
    1500:	85 c0                	test   %eax,%eax
    1502:	75 33                	jne    1537 <main+0x306>
			sem_acquire(p);
    1504:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1509:	89 04 24             	mov    %eax,(%esp)
    150c:	e8 39 fc ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1511:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1518:	00 
    1519:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1520:	e8 bb 0a 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1525:	a1 70 2c 00 00       	mov    0x2c70,%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 97 fc ff ff       	call   11c9 <sem_signal>
			exit();
    1532:	e8 01 09 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1537:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    153e:	00 00 00 
    1541:	eb 0d                	jmp    1550 <main+0x31f>
    1543:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1548:	83 c0 01             	add    $0x1,%eax
    154b:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1550:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1555:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    155a:	7e e7                	jle    1543 <main+0x312>
		tid = thread_create(hReady, (void *) &arg);
    155c:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    1563:	00 
    1564:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    156b:	e8 a3 0e 00 00       	call   2413 <thread_create>
    1570:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    1575:	a1 88 2c 00 00       	mov    0x2c88,%eax
    157a:	85 c0                	test   %eax,%eax
    157c:	75 33                	jne    15b1 <main+0x380>
			sem_acquire(p);
    157e:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1583:	89 04 24             	mov    %eax,(%esp)
    1586:	e8 bf fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    158b:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1592:	00 
    1593:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159a:	e8 41 0a 00 00       	call   1fe0 <printf>
			sem_signal(p);
    159f:	a1 70 2c 00 00       	mov    0x2c70,%eax
    15a4:	89 04 24             	mov    %eax,(%esp)
    15a7:	e8 1d fc ff ff       	call   11c9 <sem_signal>
			exit();
    15ac:	e8 87 08 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    15b1:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    15b8:	00 00 00 
    15bb:	eb 0d                	jmp    15ca <main+0x399>
    15bd:	a1 84 2c 00 00       	mov    0x2c84,%eax
    15c2:	83 c0 01             	add    $0x1,%eax
    15c5:	a3 84 2c 00 00       	mov    %eax,0x2c84
    15ca:	a1 84 2c 00 00       	mov    0x2c84,%eax
    15cf:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15d4:	7e e7                	jle    15bd <main+0x38c>
		tid = thread_create(hReady, (void *) &arg);
    15d6:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    15dd:	00 
    15de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    15e5:	e8 29 0e 00 00       	call   2413 <thread_create>
    15ea:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    15ef:	a1 88 2c 00 00       	mov    0x2c88,%eax
    15f4:	85 c0                	test   %eax,%eax
    15f6:	75 33                	jne    162b <main+0x3fa>
			sem_acquire(p);
    15f8:	a1 70 2c 00 00       	mov    0x2c70,%eax
    15fd:	89 04 24             	mov    %eax,(%esp)
    1600:	e8 45 fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1605:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    160c:	00 
    160d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1614:	e8 c7 09 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1619:	a1 70 2c 00 00       	mov    0x2c70,%eax
    161e:	89 04 24             	mov    %eax,(%esp)
    1621:	e8 a3 fb ff ff       	call   11c9 <sem_signal>
			exit();
    1626:	e8 0d 08 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    162b:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1632:	00 00 00 
    1635:	eb 0d                	jmp    1644 <main+0x413>
    1637:	a1 84 2c 00 00       	mov    0x2c84,%eax
    163c:	83 c0 01             	add    $0x1,%eax
    163f:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1644:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1649:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    164e:	7e e7                	jle    1637 <main+0x406>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1650:	a1 80 2c 00 00       	mov    0x2c80,%eax
    1655:	83 c0 01             	add    $0x1,%eax
    1658:	a3 80 2c 00 00       	mov    %eax,0x2c80
    165d:	a1 80 2c 00 00       	mov    0x2c80,%eax
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
    1675:	a1 70 2c 00 00       	mov    0x2c70,%eax
    167a:	89 04 24             	mov    %eax,(%esp)
    167d:	e8 c8 fa ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
    1682:	c7 44 24 04 c4 26 00 	movl   $0x26c4,0x4(%esp)
    1689:	00 
    168a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1691:	e8 4a 09 00 00       	call   1fe0 <printf>
	sem_signal(p);
    1696:	a1 70 2c 00 00       	mov    0x2c70,%eax
    169b:	89 04 24             	mov    %eax,(%esp)
    169e:	e8 26 fb ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    16a3:	a1 68 2c 00 00       	mov    0x2c68,%eax
    16a8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    16af:	00 
    16b0:	89 04 24             	mov    %eax,(%esp)
    16b3:	e8 5d fa ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    16b8:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    16bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    16c4:	00 
    16c5:	89 04 24             	mov    %eax,(%esp)
    16c8:	e8 48 fa ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    16cd:	c7 05 80 2c 00 00 00 	movl   $0x0,0x2c80
    16d4:	00 00 00 
    16d7:	e9 7b 01 00 00       	jmp    1857 <main+0x626>
		tid = thread_create(hReady, (void *) &arg);
    16dc:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    16e3:	00 
    16e4:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    16eb:	e8 23 0d 00 00       	call   2413 <thread_create>
    16f0:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    16f5:	a1 88 2c 00 00       	mov    0x2c88,%eax
    16fa:	85 c0                	test   %eax,%eax
    16fc:	75 33                	jne    1731 <main+0x500>
			sem_acquire(p);
    16fe:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1703:	89 04 24             	mov    %eax,(%esp)
    1706:	e8 3f fa ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    170b:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1712:	00 
    1713:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    171a:	e8 c1 08 00 00       	call   1fe0 <printf>
			sem_signal(p);
    171f:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1724:	89 04 24             	mov    %eax,(%esp)
    1727:	e8 9d fa ff ff       	call   11c9 <sem_signal>
			exit();
    172c:	e8 07 07 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1731:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1738:	00 00 00 
    173b:	eb 0d                	jmp    174a <main+0x519>
    173d:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1742:	83 c0 01             	add    $0x1,%eax
    1745:	a3 84 2c 00 00       	mov    %eax,0x2c84
    174a:	a1 84 2c 00 00       	mov    0x2c84,%eax
    174f:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1754:	7e e7                	jle    173d <main+0x50c>
		tid = thread_create(oReady, (void *) &arg);
    1756:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    175d:	00 
    175e:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    1765:	e8 a9 0c 00 00       	call   2413 <thread_create>
    176a:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    176f:	a1 88 2c 00 00       	mov    0x2c88,%eax
    1774:	85 c0                	test   %eax,%eax
    1776:	75 33                	jne    17ab <main+0x57a>
			sem_acquire(p);
    1778:	a1 70 2c 00 00       	mov    0x2c70,%eax
    177d:	89 04 24             	mov    %eax,(%esp)
    1780:	e8 c5 f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1785:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    178c:	00 
    178d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1794:	e8 47 08 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1799:	a1 70 2c 00 00       	mov    0x2c70,%eax
    179e:	89 04 24             	mov    %eax,(%esp)
    17a1:	e8 23 fa ff ff       	call   11c9 <sem_signal>
			exit();
    17a6:	e8 8d 06 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    17ab:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    17b2:	00 00 00 
    17b5:	eb 0d                	jmp    17c4 <main+0x593>
    17b7:	a1 84 2c 00 00       	mov    0x2c84,%eax
    17bc:	83 c0 01             	add    $0x1,%eax
    17bf:	a3 84 2c 00 00       	mov    %eax,0x2c84
    17c4:	a1 84 2c 00 00       	mov    0x2c84,%eax
    17c9:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17ce:	7e e7                	jle    17b7 <main+0x586>
		tid = thread_create(hReady, (void *) &arg);
    17d0:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    17d7:	00 
    17d8:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    17df:	e8 2f 0c 00 00       	call   2413 <thread_create>
    17e4:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    17e9:	a1 88 2c 00 00       	mov    0x2c88,%eax
    17ee:	85 c0                	test   %eax,%eax
    17f0:	75 33                	jne    1825 <main+0x5f4>
			sem_acquire(p);
    17f2:	a1 70 2c 00 00       	mov    0x2c70,%eax
    17f7:	89 04 24             	mov    %eax,(%esp)
    17fa:	e8 4b f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    17ff:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1806:	00 
    1807:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    180e:	e8 cd 07 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1813:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1818:	89 04 24             	mov    %eax,(%esp)
    181b:	e8 a9 f9 ff ff       	call   11c9 <sem_signal>
			exit();
    1820:	e8 13 06 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1825:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    182c:	00 00 00 
    182f:	eb 0d                	jmp    183e <main+0x60d>
    1831:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1836:	83 c0 01             	add    $0x1,%eax
    1839:	a3 84 2c 00 00       	mov    %eax,0x2c84
    183e:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1843:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1848:	7e e7                	jle    1831 <main+0x600>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    184a:	a1 80 2c 00 00       	mov    0x2c80,%eax
    184f:	83 c0 01             	add    $0x1,%eax
    1852:	a3 80 2c 00 00       	mov    %eax,0x2c80
    1857:	a1 80 2c 00 00       	mov    0x2c80,%eax
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
    186f:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1874:	89 04 24             	mov    %eax,(%esp)
    1877:	e8 ce f8 ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
    187c:	c7 44 24 04 08 27 00 	movl   $0x2708,0x4(%esp)
    1883:	00 
    1884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    188b:	e8 50 07 00 00       	call   1fe0 <printf>
	sem_signal(p);
    1890:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1895:	89 04 24             	mov    %eax,(%esp)
    1898:	e8 2c f9 ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    189d:	a1 68 2c 00 00       	mov    0x2c68,%eax
    18a2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    18a9:	00 
    18aa:	89 04 24             	mov    %eax,(%esp)
    18ad:	e8 63 f8 ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    18b2:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    18b7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18be:	00 
    18bf:	89 04 24             	mov    %eax,(%esp)
    18c2:	e8 4e f8 ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    18c7:	c7 05 80 2c 00 00 00 	movl   $0x0,0x2c80
    18ce:	00 00 00 
    18d1:	e9 7b 01 00 00       	jmp    1a51 <main+0x820>
		tid = thread_create(hReady, (void *) &arg);
    18d6:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    18dd:	00 
    18de:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    18e5:	e8 29 0b 00 00       	call   2413 <thread_create>
    18ea:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    18ef:	a1 88 2c 00 00       	mov    0x2c88,%eax
    18f4:	85 c0                	test   %eax,%eax
    18f6:	75 33                	jne    192b <main+0x6fa>
			sem_acquire(p);
    18f8:	a1 70 2c 00 00       	mov    0x2c70,%eax
    18fd:	89 04 24             	mov    %eax,(%esp)
    1900:	e8 45 f8 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1905:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    190c:	00 
    190d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1914:	e8 c7 06 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1919:	a1 70 2c 00 00       	mov    0x2c70,%eax
    191e:	89 04 24             	mov    %eax,(%esp)
    1921:	e8 a3 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    1926:	e8 0d 05 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    192b:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1932:	00 00 00 
    1935:	eb 0d                	jmp    1944 <main+0x713>
    1937:	a1 84 2c 00 00       	mov    0x2c84,%eax
    193c:	83 c0 01             	add    $0x1,%eax
    193f:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1944:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1949:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    194e:	7e e7                	jle    1937 <main+0x706>
		tid = thread_create(hReady, (void *) &arg);
    1950:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    1957:	00 
    1958:	c7 04 24 6e 1a 00 00 	movl   $0x1a6e,(%esp)
    195f:	e8 af 0a 00 00       	call   2413 <thread_create>
    1964:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    1969:	a1 88 2c 00 00       	mov    0x2c88,%eax
    196e:	85 c0                	test   %eax,%eax
    1970:	75 33                	jne    19a5 <main+0x774>
			sem_acquire(p);
    1972:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1977:	89 04 24             	mov    %eax,(%esp)
    197a:	e8 cb f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    197f:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1986:	00 
    1987:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198e:	e8 4d 06 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1993:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1998:	89 04 24             	mov    %eax,(%esp)
    199b:	e8 29 f8 ff ff       	call   11c9 <sem_signal>
			exit();
    19a0:	e8 93 04 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    19a5:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    19ac:	00 00 00 
    19af:	eb 0d                	jmp    19be <main+0x78d>
    19b1:	a1 84 2c 00 00       	mov    0x2c84,%eax
    19b6:	83 c0 01             	add    $0x1,%eax
    19b9:	a3 84 2c 00 00       	mov    %eax,0x2c84
    19be:	a1 84 2c 00 00       	mov    0x2c84,%eax
    19c3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    19c8:	7e e7                	jle    19b1 <main+0x780>
		tid = thread_create(oReady, (void *) &arg);
    19ca:	c7 44 24 04 4c 2c 00 	movl   $0x2c4c,0x4(%esp)
    19d1:	00 
    19d2:	c7 04 24 1f 1b 00 00 	movl   $0x1b1f,(%esp)
    19d9:	e8 35 0a 00 00       	call   2413 <thread_create>
    19de:	a3 88 2c 00 00       	mov    %eax,0x2c88
		if(tid <= 0){
    19e3:	a1 88 2c 00 00       	mov    0x2c88,%eax
    19e8:	85 c0                	test   %eax,%eax
    19ea:	75 33                	jne    1a1f <main+0x7ee>
			sem_acquire(p);
    19ec:	a1 70 2c 00 00       	mov    0x2c70,%eax
    19f1:	89 04 24             	mov    %eax,(%esp)
    19f4:	e8 51 f7 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    19f9:	c7 44 24 04 65 26 00 	movl   $0x2665,0x4(%esp)
    1a00:	00 
    1a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a08:	e8 d3 05 00 00       	call   1fe0 <printf>
			sem_signal(p);
    1a0d:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1a12:	89 04 24             	mov    %eax,(%esp)
    1a15:	e8 af f7 ff ff       	call   11c9 <sem_signal>
			exit();
    1a1a:	e8 19 04 00 00       	call   1e38 <exit>
		}
		for(i = 0; i < 999999; i++);
    1a1f:	c7 05 84 2c 00 00 00 	movl   $0x0,0x2c84
    1a26:	00 00 00 
    1a29:	eb 0d                	jmp    1a38 <main+0x807>
    1a2b:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1a30:	83 c0 01             	add    $0x1,%eax
    1a33:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1a38:	a1 84 2c 00 00       	mov    0x2c84,%eax
    1a3d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1a42:	7e e7                	jle    1a2b <main+0x7fa>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1a44:	a1 80 2c 00 00       	mov    0x2c80,%eax
    1a49:	83 c0 01             	add    $0x1,%eax
    1a4c:	a3 80 2c 00 00       	mov    %eax,0x2c80
    1a51:	a1 80 2c 00 00       	mov    0x2c80,%eax
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
    1a74:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1a79:	89 04 24             	mov    %eax,(%esp)
    1a7c:	e8 c9 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Hydrogen ready\n");
    1a81:	c7 44 24 04 4c 27 00 	movl   $0x274c,0x4(%esp)
    1a88:	00 
    1a89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a90:	e8 4b 05 00 00       	call   1fe0 <printf>
	sem_signal(p);
    1a95:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1a9a:	89 04 24             	mov    %eax,(%esp)
    1a9d:	e8 27 f7 ff ff       	call   11c9 <sem_signal>
	sem_acquire(h);
    1aa2:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1aa7:	89 04 24             	mov    %eax,(%esp)
    1aaa:	e8 9b f6 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1aaf:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1ab4:	8b 00                	mov    (%eax),%eax
    1ab6:	85 c0                	test   %eax,%eax
    1ab8:	75 60                	jne    1b1a <hReady+0xac>
    1aba:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    1abf:	8b 00                	mov    (%eax),%eax
    1ac1:	85 c0                	test   %eax,%eax
    1ac3:	75 55                	jne    1b1a <hReady+0xac>
		sem_acquire(p);
    1ac5:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1aca:	89 04 24             	mov    %eax,(%esp)
    1acd:	e8 78 f6 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1ad2:	c7 44 24 04 5c 27 00 	movl   $0x275c,0x4(%esp)
    1ad9:	00 
    1ada:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae1:	e8 fa 04 00 00       	call   1fe0 <printf>
		sem_signal(p);
    1ae6:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1aeb:	89 04 24             	mov    %eax,(%esp)
    1aee:	e8 d6 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1af3:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1af8:	89 04 24             	mov    %eax,(%esp)
    1afb:	e8 c9 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1b00:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1b05:	89 04 24             	mov    %eax,(%esp)
    1b08:	e8 bc f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1b0d:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
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
    1b25:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1b2a:	89 04 24             	mov    %eax,(%esp)
    1b2d:	e8 18 f6 ff ff       	call   114a <sem_acquire>
	printf(1, "Oxygen ready\n");
    1b32:	c7 44 24 04 6d 27 00 	movl   $0x276d,0x4(%esp)
    1b39:	00 
    1b3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b41:	e8 9a 04 00 00       	call   1fe0 <printf>
	sem_signal(p);
    1b46:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1b4b:	89 04 24             	mov    %eax,(%esp)
    1b4e:	e8 76 f6 ff ff       	call   11c9 <sem_signal>
	sem_acquire(o);
    1b53:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    1b58:	89 04 24             	mov    %eax,(%esp)
    1b5b:	e8 ea f5 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    1b60:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1b65:	8b 00                	mov    (%eax),%eax
    1b67:	85 c0                	test   %eax,%eax
    1b69:	75 60                	jne    1bcb <oReady+0xac>
    1b6b:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
    1b70:	8b 00                	mov    (%eax),%eax
    1b72:	85 c0                	test   %eax,%eax
    1b74:	75 55                	jne    1bcb <oReady+0xac>
		sem_acquire(p);
    1b76:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 c7 f5 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    1b83:	c7 44 24 04 5c 27 00 	movl   $0x275c,0x4(%esp)
    1b8a:	00 
    1b8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b92:	e8 49 04 00 00       	call   1fe0 <printf>
		sem_signal(p);
    1b97:	a1 70 2c 00 00       	mov    0x2c70,%eax
    1b9c:	89 04 24             	mov    %eax,(%esp)
    1b9f:	e8 25 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1ba4:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1ba9:	89 04 24             	mov    %eax,(%esp)
    1bac:	e8 18 f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    1bb1:	a1 68 2c 00 00       	mov    0x2c68,%eax
    1bb6:	89 04 24             	mov    %eax,(%esp)
    1bb9:	e8 0b f6 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1bbe:	a1 6c 2c 00 00       	mov    0x2c6c,%eax
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
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1e30:	b8 01 00 00 00       	mov    $0x1,%eax
    1e35:	cd 40                	int    $0x40
    1e37:	c3                   	ret    

00001e38 <exit>:
SYSCALL(exit)
    1e38:	b8 02 00 00 00       	mov    $0x2,%eax
    1e3d:	cd 40                	int    $0x40
    1e3f:	c3                   	ret    

00001e40 <wait>:
SYSCALL(wait)
    1e40:	b8 03 00 00 00       	mov    $0x3,%eax
    1e45:	cd 40                	int    $0x40
    1e47:	c3                   	ret    

00001e48 <pipe>:
SYSCALL(pipe)
    1e48:	b8 04 00 00 00       	mov    $0x4,%eax
    1e4d:	cd 40                	int    $0x40
    1e4f:	c3                   	ret    

00001e50 <read>:
SYSCALL(read)
    1e50:	b8 05 00 00 00       	mov    $0x5,%eax
    1e55:	cd 40                	int    $0x40
    1e57:	c3                   	ret    

00001e58 <write>:
SYSCALL(write)
    1e58:	b8 10 00 00 00       	mov    $0x10,%eax
    1e5d:	cd 40                	int    $0x40
    1e5f:	c3                   	ret    

00001e60 <close>:
SYSCALL(close)
    1e60:	b8 15 00 00 00       	mov    $0x15,%eax
    1e65:	cd 40                	int    $0x40
    1e67:	c3                   	ret    

00001e68 <kill>:
SYSCALL(kill)
    1e68:	b8 06 00 00 00       	mov    $0x6,%eax
    1e6d:	cd 40                	int    $0x40
    1e6f:	c3                   	ret    

00001e70 <exec>:
SYSCALL(exec)
    1e70:	b8 07 00 00 00       	mov    $0x7,%eax
    1e75:	cd 40                	int    $0x40
    1e77:	c3                   	ret    

00001e78 <open>:
SYSCALL(open)
    1e78:	b8 0f 00 00 00       	mov    $0xf,%eax
    1e7d:	cd 40                	int    $0x40
    1e7f:	c3                   	ret    

00001e80 <mknod>:
SYSCALL(mknod)
    1e80:	b8 11 00 00 00       	mov    $0x11,%eax
    1e85:	cd 40                	int    $0x40
    1e87:	c3                   	ret    

00001e88 <unlink>:
SYSCALL(unlink)
    1e88:	b8 12 00 00 00       	mov    $0x12,%eax
    1e8d:	cd 40                	int    $0x40
    1e8f:	c3                   	ret    

00001e90 <fstat>:
SYSCALL(fstat)
    1e90:	b8 08 00 00 00       	mov    $0x8,%eax
    1e95:	cd 40                	int    $0x40
    1e97:	c3                   	ret    

00001e98 <link>:
SYSCALL(link)
    1e98:	b8 13 00 00 00       	mov    $0x13,%eax
    1e9d:	cd 40                	int    $0x40
    1e9f:	c3                   	ret    

00001ea0 <mkdir>:
SYSCALL(mkdir)
    1ea0:	b8 14 00 00 00       	mov    $0x14,%eax
    1ea5:	cd 40                	int    $0x40
    1ea7:	c3                   	ret    

00001ea8 <chdir>:
SYSCALL(chdir)
    1ea8:	b8 09 00 00 00       	mov    $0x9,%eax
    1ead:	cd 40                	int    $0x40
    1eaf:	c3                   	ret    

00001eb0 <dup>:
SYSCALL(dup)
    1eb0:	b8 0a 00 00 00       	mov    $0xa,%eax
    1eb5:	cd 40                	int    $0x40
    1eb7:	c3                   	ret    

00001eb8 <getpid>:
SYSCALL(getpid)
    1eb8:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ebd:	cd 40                	int    $0x40
    1ebf:	c3                   	ret    

00001ec0 <sbrk>:
SYSCALL(sbrk)
    1ec0:	b8 0c 00 00 00       	mov    $0xc,%eax
    1ec5:	cd 40                	int    $0x40
    1ec7:	c3                   	ret    

00001ec8 <sleep>:
SYSCALL(sleep)
    1ec8:	b8 0d 00 00 00       	mov    $0xd,%eax
    1ecd:	cd 40                	int    $0x40
    1ecf:	c3                   	ret    

00001ed0 <uptime>:
SYSCALL(uptime)
    1ed0:	b8 0e 00 00 00       	mov    $0xe,%eax
    1ed5:	cd 40                	int    $0x40
    1ed7:	c3                   	ret    

00001ed8 <clone>:
SYSCALL(clone)
    1ed8:	b8 16 00 00 00       	mov    $0x16,%eax
    1edd:	cd 40                	int    $0x40
    1edf:	c3                   	ret    

00001ee0 <texit>:
SYSCALL(texit)
    1ee0:	b8 17 00 00 00       	mov    $0x17,%eax
    1ee5:	cd 40                	int    $0x40
    1ee7:	c3                   	ret    

00001ee8 <tsleep>:
SYSCALL(tsleep)
    1ee8:	b8 18 00 00 00       	mov    $0x18,%eax
    1eed:	cd 40                	int    $0x40
    1eef:	c3                   	ret    

00001ef0 <twakeup>:
SYSCALL(twakeup)
    1ef0:	b8 19 00 00 00       	mov    $0x19,%eax
    1ef5:	cd 40                	int    $0x40
    1ef7:	c3                   	ret    

00001ef8 <thread_yield>:
SYSCALL(thread_yield)
    1ef8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1efd:	cd 40                	int    $0x40
    1eff:	c3                   	ret    

00001f00 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1f00:	55                   	push   %ebp
    1f01:	89 e5                	mov    %esp,%ebp
    1f03:	83 ec 18             	sub    $0x18,%esp
    1f06:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f09:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1f0c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f13:	00 
    1f14:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f17:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1e:	89 04 24             	mov    %eax,(%esp)
    1f21:	e8 32 ff ff ff       	call   1e58 <write>
}
    1f26:	c9                   	leave  
    1f27:	c3                   	ret    

00001f28 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f28:	55                   	push   %ebp
    1f29:	89 e5                	mov    %esp,%ebp
    1f2b:	56                   	push   %esi
    1f2c:	53                   	push   %ebx
    1f2d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1f30:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1f37:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f3b:	74 17                	je     1f54 <printint+0x2c>
    1f3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f41:	79 11                	jns    1f54 <printint+0x2c>
    neg = 1;
    1f43:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f4d:	f7 d8                	neg    %eax
    1f4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f52:	eb 06                	jmp    1f5a <printint+0x32>
  } else {
    x = xx;
    1f54:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f57:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1f5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1f61:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1f64:	8d 41 01             	lea    0x1(%ecx),%eax
    1f67:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f6a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1f6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f70:	ba 00 00 00 00       	mov    $0x0,%edx
    1f75:	f7 f3                	div    %ebx
    1f77:	89 d0                	mov    %edx,%eax
    1f79:	0f b6 80 50 2c 00 00 	movzbl 0x2c50(%eax),%eax
    1f80:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1f84:	8b 75 10             	mov    0x10(%ebp),%esi
    1f87:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f8a:	ba 00 00 00 00       	mov    $0x0,%edx
    1f8f:	f7 f6                	div    %esi
    1f91:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f98:	75 c7                	jne    1f61 <printint+0x39>
  if(neg)
    1f9a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f9e:	74 10                	je     1fb0 <printint+0x88>
    buf[i++] = '-';
    1fa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fa3:	8d 50 01             	lea    0x1(%eax),%edx
    1fa6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1fa9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1fae:	eb 1f                	jmp    1fcf <printint+0xa7>
    1fb0:	eb 1d                	jmp    1fcf <printint+0xa7>
    putc(fd, buf[i]);
    1fb2:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb8:	01 d0                	add    %edx,%eax
    1fba:	0f b6 00             	movzbl (%eax),%eax
    1fbd:	0f be c0             	movsbl %al,%eax
    1fc0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc7:	89 04 24             	mov    %eax,(%esp)
    1fca:	e8 31 ff ff ff       	call   1f00 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1fcf:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1fd3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fd7:	79 d9                	jns    1fb2 <printint+0x8a>
    putc(fd, buf[i]);
}
    1fd9:	83 c4 30             	add    $0x30,%esp
    1fdc:	5b                   	pop    %ebx
    1fdd:	5e                   	pop    %esi
    1fde:	5d                   	pop    %ebp
    1fdf:	c3                   	ret    

00001fe0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1fe0:	55                   	push   %ebp
    1fe1:	89 e5                	mov    %esp,%ebp
    1fe3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1fe6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1fed:	8d 45 0c             	lea    0xc(%ebp),%eax
    1ff0:	83 c0 04             	add    $0x4,%eax
    1ff3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1ff6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ffd:	e9 7c 01 00 00       	jmp    217e <printf+0x19e>
    c = fmt[i] & 0xff;
    2002:	8b 55 0c             	mov    0xc(%ebp),%edx
    2005:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2008:	01 d0                	add    %edx,%eax
    200a:	0f b6 00             	movzbl (%eax),%eax
    200d:	0f be c0             	movsbl %al,%eax
    2010:	25 ff 00 00 00       	and    $0xff,%eax
    2015:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    2018:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    201c:	75 2c                	jne    204a <printf+0x6a>
      if(c == '%'){
    201e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2022:	75 0c                	jne    2030 <printf+0x50>
        state = '%';
    2024:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    202b:	e9 4a 01 00 00       	jmp    217a <printf+0x19a>
      } else {
        putc(fd, c);
    2030:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2033:	0f be c0             	movsbl %al,%eax
    2036:	89 44 24 04          	mov    %eax,0x4(%esp)
    203a:	8b 45 08             	mov    0x8(%ebp),%eax
    203d:	89 04 24             	mov    %eax,(%esp)
    2040:	e8 bb fe ff ff       	call   1f00 <putc>
    2045:	e9 30 01 00 00       	jmp    217a <printf+0x19a>
      }
    } else if(state == '%'){
    204a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    204e:	0f 85 26 01 00 00    	jne    217a <printf+0x19a>
      if(c == 'd'){
    2054:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    2058:	75 2d                	jne    2087 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    205a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    205d:	8b 00                	mov    (%eax),%eax
    205f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2066:	00 
    2067:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    206e:	00 
    206f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2073:	8b 45 08             	mov    0x8(%ebp),%eax
    2076:	89 04 24             	mov    %eax,(%esp)
    2079:	e8 aa fe ff ff       	call   1f28 <printint>
        ap++;
    207e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2082:	e9 ec 00 00 00       	jmp    2173 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    2087:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    208b:	74 06                	je     2093 <printf+0xb3>
    208d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    2091:	75 2d                	jne    20c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    2093:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2096:	8b 00                	mov    (%eax),%eax
    2098:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    209f:	00 
    20a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    20a7:	00 
    20a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    20ac:	8b 45 08             	mov    0x8(%ebp),%eax
    20af:	89 04 24             	mov    %eax,(%esp)
    20b2:	e8 71 fe ff ff       	call   1f28 <printint>
        ap++;
    20b7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    20bb:	e9 b3 00 00 00       	jmp    2173 <printf+0x193>
      } else if(c == 's'){
    20c0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    20c4:	75 45                	jne    210b <printf+0x12b>
        s = (char*)*ap;
    20c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20c9:	8b 00                	mov    (%eax),%eax
    20cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    20ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    20d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20d6:	75 09                	jne    20e1 <printf+0x101>
          s = "(null)";
    20d8:	c7 45 f4 7b 27 00 00 	movl   $0x277b,-0xc(%ebp)
        while(*s != 0){
    20df:	eb 1e                	jmp    20ff <printf+0x11f>
    20e1:	eb 1c                	jmp    20ff <printf+0x11f>
          putc(fd, *s);
    20e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20e6:	0f b6 00             	movzbl (%eax),%eax
    20e9:	0f be c0             	movsbl %al,%eax
    20ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    20f0:	8b 45 08             	mov    0x8(%ebp),%eax
    20f3:	89 04 24             	mov    %eax,(%esp)
    20f6:	e8 05 fe ff ff       	call   1f00 <putc>
          s++;
    20fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    20ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2102:	0f b6 00             	movzbl (%eax),%eax
    2105:	84 c0                	test   %al,%al
    2107:	75 da                	jne    20e3 <printf+0x103>
    2109:	eb 68                	jmp    2173 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    210b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    210f:	75 1d                	jne    212e <printf+0x14e>
        putc(fd, *ap);
    2111:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2114:	8b 00                	mov    (%eax),%eax
    2116:	0f be c0             	movsbl %al,%eax
    2119:	89 44 24 04          	mov    %eax,0x4(%esp)
    211d:	8b 45 08             	mov    0x8(%ebp),%eax
    2120:	89 04 24             	mov    %eax,(%esp)
    2123:	e8 d8 fd ff ff       	call   1f00 <putc>
        ap++;
    2128:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    212c:	eb 45                	jmp    2173 <printf+0x193>
      } else if(c == '%'){
    212e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2132:	75 17                	jne    214b <printf+0x16b>
        putc(fd, c);
    2134:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2137:	0f be c0             	movsbl %al,%eax
    213a:	89 44 24 04          	mov    %eax,0x4(%esp)
    213e:	8b 45 08             	mov    0x8(%ebp),%eax
    2141:	89 04 24             	mov    %eax,(%esp)
    2144:	e8 b7 fd ff ff       	call   1f00 <putc>
    2149:	eb 28                	jmp    2173 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    214b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2152:	00 
    2153:	8b 45 08             	mov    0x8(%ebp),%eax
    2156:	89 04 24             	mov    %eax,(%esp)
    2159:	e8 a2 fd ff ff       	call   1f00 <putc>
        putc(fd, c);
    215e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2161:	0f be c0             	movsbl %al,%eax
    2164:	89 44 24 04          	mov    %eax,0x4(%esp)
    2168:	8b 45 08             	mov    0x8(%ebp),%eax
    216b:	89 04 24             	mov    %eax,(%esp)
    216e:	e8 8d fd ff ff       	call   1f00 <putc>
      }
      state = 0;
    2173:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    217a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    217e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2181:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2184:	01 d0                	add    %edx,%eax
    2186:	0f b6 00             	movzbl (%eax),%eax
    2189:	84 c0                	test   %al,%al
    218b:	0f 85 71 fe ff ff    	jne    2002 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2191:	c9                   	leave  
    2192:	c3                   	ret    
    2193:	90                   	nop

00002194 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2194:	55                   	push   %ebp
    2195:	89 e5                	mov    %esp,%ebp
    2197:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    219a:	8b 45 08             	mov    0x8(%ebp),%eax
    219d:	83 e8 08             	sub    $0x8,%eax
    21a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    21a3:	a1 7c 2c 00 00       	mov    0x2c7c,%eax
    21a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21ab:	eb 24                	jmp    21d1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    21ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21b0:	8b 00                	mov    (%eax),%eax
    21b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21b5:	77 12                	ja     21c9 <free+0x35>
    21b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21bd:	77 24                	ja     21e3 <free+0x4f>
    21bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21c2:	8b 00                	mov    (%eax),%eax
    21c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21c7:	77 1a                	ja     21e3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    21c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21cc:	8b 00                	mov    (%eax),%eax
    21ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21d7:	76 d4                	jbe    21ad <free+0x19>
    21d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21dc:	8b 00                	mov    (%eax),%eax
    21de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21e1:	76 ca                	jbe    21ad <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    21e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21e6:	8b 40 04             	mov    0x4(%eax),%eax
    21e9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    21f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21f3:	01 c2                	add    %eax,%edx
    21f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21f8:	8b 00                	mov    (%eax),%eax
    21fa:	39 c2                	cmp    %eax,%edx
    21fc:	75 24                	jne    2222 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    21fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2201:	8b 50 04             	mov    0x4(%eax),%edx
    2204:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2207:	8b 00                	mov    (%eax),%eax
    2209:	8b 40 04             	mov    0x4(%eax),%eax
    220c:	01 c2                	add    %eax,%edx
    220e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2211:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2214:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2217:	8b 00                	mov    (%eax),%eax
    2219:	8b 10                	mov    (%eax),%edx
    221b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    221e:	89 10                	mov    %edx,(%eax)
    2220:	eb 0a                	jmp    222c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    2222:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2225:	8b 10                	mov    (%eax),%edx
    2227:	8b 45 f8             	mov    -0x8(%ebp),%eax
    222a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    222c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    222f:	8b 40 04             	mov    0x4(%eax),%eax
    2232:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2239:	8b 45 fc             	mov    -0x4(%ebp),%eax
    223c:	01 d0                	add    %edx,%eax
    223e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2241:	75 20                	jne    2263 <free+0xcf>
    p->s.size += bp->s.size;
    2243:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2246:	8b 50 04             	mov    0x4(%eax),%edx
    2249:	8b 45 f8             	mov    -0x8(%ebp),%eax
    224c:	8b 40 04             	mov    0x4(%eax),%eax
    224f:	01 c2                	add    %eax,%edx
    2251:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2254:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2257:	8b 45 f8             	mov    -0x8(%ebp),%eax
    225a:	8b 10                	mov    (%eax),%edx
    225c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    225f:	89 10                	mov    %edx,(%eax)
    2261:	eb 08                	jmp    226b <free+0xd7>
  } else
    p->s.ptr = bp;
    2263:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2266:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2269:	89 10                	mov    %edx,(%eax)
  freep = p;
    226b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    226e:	a3 7c 2c 00 00       	mov    %eax,0x2c7c
}
    2273:	c9                   	leave  
    2274:	c3                   	ret    

00002275 <morecore>:

static Header*
morecore(uint nu)
{
    2275:	55                   	push   %ebp
    2276:	89 e5                	mov    %esp,%ebp
    2278:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    227b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2282:	77 07                	ja     228b <morecore+0x16>
    nu = 4096;
    2284:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    228b:	8b 45 08             	mov    0x8(%ebp),%eax
    228e:	c1 e0 03             	shl    $0x3,%eax
    2291:	89 04 24             	mov    %eax,(%esp)
    2294:	e8 27 fc ff ff       	call   1ec0 <sbrk>
    2299:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    229c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    22a0:	75 07                	jne    22a9 <morecore+0x34>
    return 0;
    22a2:	b8 00 00 00 00       	mov    $0x0,%eax
    22a7:	eb 22                	jmp    22cb <morecore+0x56>
  hp = (Header*)p;
    22a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    22af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22b2:	8b 55 08             	mov    0x8(%ebp),%edx
    22b5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    22b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22bb:	83 c0 08             	add    $0x8,%eax
    22be:	89 04 24             	mov    %eax,(%esp)
    22c1:	e8 ce fe ff ff       	call   2194 <free>
  return freep;
    22c6:	a1 7c 2c 00 00       	mov    0x2c7c,%eax
}
    22cb:	c9                   	leave  
    22cc:	c3                   	ret    

000022cd <malloc>:

void*
malloc(uint nbytes)
{
    22cd:	55                   	push   %ebp
    22ce:	89 e5                	mov    %esp,%ebp
    22d0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    22d3:	8b 45 08             	mov    0x8(%ebp),%eax
    22d6:	83 c0 07             	add    $0x7,%eax
    22d9:	c1 e8 03             	shr    $0x3,%eax
    22dc:	83 c0 01             	add    $0x1,%eax
    22df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    22e2:	a1 7c 2c 00 00       	mov    0x2c7c,%eax
    22e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22ee:	75 23                	jne    2313 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    22f0:	c7 45 f0 74 2c 00 00 	movl   $0x2c74,-0x10(%ebp)
    22f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22fa:	a3 7c 2c 00 00       	mov    %eax,0x2c7c
    22ff:	a1 7c 2c 00 00       	mov    0x2c7c,%eax
    2304:	a3 74 2c 00 00       	mov    %eax,0x2c74
    base.s.size = 0;
    2309:	c7 05 78 2c 00 00 00 	movl   $0x0,0x2c78
    2310:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2313:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2316:	8b 00                	mov    (%eax),%eax
    2318:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    231b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    231e:	8b 40 04             	mov    0x4(%eax),%eax
    2321:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2324:	72 4d                	jb     2373 <malloc+0xa6>
      if(p->s.size == nunits)
    2326:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2329:	8b 40 04             	mov    0x4(%eax),%eax
    232c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    232f:	75 0c                	jne    233d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    2331:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2334:	8b 10                	mov    (%eax),%edx
    2336:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2339:	89 10                	mov    %edx,(%eax)
    233b:	eb 26                	jmp    2363 <malloc+0x96>
      else {
        p->s.size -= nunits;
    233d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2340:	8b 40 04             	mov    0x4(%eax),%eax
    2343:	2b 45 ec             	sub    -0x14(%ebp),%eax
    2346:	89 c2                	mov    %eax,%edx
    2348:	8b 45 f4             	mov    -0xc(%ebp),%eax
    234b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    234e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2351:	8b 40 04             	mov    0x4(%eax),%eax
    2354:	c1 e0 03             	shl    $0x3,%eax
    2357:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    235a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    235d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2360:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    2363:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2366:	a3 7c 2c 00 00       	mov    %eax,0x2c7c
      return (void*)(p + 1);
    236b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    236e:	83 c0 08             	add    $0x8,%eax
    2371:	eb 38                	jmp    23ab <malloc+0xde>
    }
    if(p == freep)
    2373:	a1 7c 2c 00 00       	mov    0x2c7c,%eax
    2378:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    237b:	75 1b                	jne    2398 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    237d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2380:	89 04 24             	mov    %eax,(%esp)
    2383:	e8 ed fe ff ff       	call   2275 <morecore>
    2388:	89 45 f4             	mov    %eax,-0xc(%ebp)
    238b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    238f:	75 07                	jne    2398 <malloc+0xcb>
        return 0;
    2391:	b8 00 00 00 00       	mov    $0x0,%eax
    2396:	eb 13                	jmp    23ab <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    239b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    239e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23a1:	8b 00                	mov    (%eax),%eax
    23a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    23a6:	e9 70 ff ff ff       	jmp    231b <malloc+0x4e>
}
    23ab:	c9                   	leave  
    23ac:	c3                   	ret    
    23ad:	66 90                	xchg   %ax,%ax
    23af:	90                   	nop

000023b0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    23b0:	55                   	push   %ebp
    23b1:	89 e5                	mov    %esp,%ebp
    23b3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    23b6:	8b 55 08             	mov    0x8(%ebp),%edx
    23b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    23bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23bf:	f0 87 02             	lock xchg %eax,(%edx)
    23c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    23c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    23c8:	c9                   	leave  
    23c9:	c3                   	ret    

000023ca <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    23ca:	55                   	push   %ebp
    23cb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    23cd:	8b 45 08             	mov    0x8(%ebp),%eax
    23d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    23d6:	5d                   	pop    %ebp
    23d7:	c3                   	ret    

000023d8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    23d8:	55                   	push   %ebp
    23d9:	89 e5                	mov    %esp,%ebp
    23db:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    23de:	90                   	nop
    23df:	8b 45 08             	mov    0x8(%ebp),%eax
    23e2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    23e9:	00 
    23ea:	89 04 24             	mov    %eax,(%esp)
    23ed:	e8 be ff ff ff       	call   23b0 <xchg>
    23f2:	85 c0                	test   %eax,%eax
    23f4:	75 e9                	jne    23df <lock_acquire+0x7>
}
    23f6:	c9                   	leave  
    23f7:	c3                   	ret    

000023f8 <lock_release>:
void lock_release(lock_t *lock){
    23f8:	55                   	push   %ebp
    23f9:	89 e5                	mov    %esp,%ebp
    23fb:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    23fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2401:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2408:	00 
    2409:	89 04 24             	mov    %eax,(%esp)
    240c:	e8 9f ff ff ff       	call   23b0 <xchg>
}
    2411:	c9                   	leave  
    2412:	c3                   	ret    

00002413 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    2413:	55                   	push   %ebp
    2414:	89 e5                	mov    %esp,%ebp
    2416:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2419:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2420:	e8 a8 fe ff ff       	call   22cd <malloc>
    2425:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    2428:	8b 45 f4             	mov    -0xc(%ebp),%eax
    242b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    242e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2431:	25 ff 0f 00 00       	and    $0xfff,%eax
    2436:	85 c0                	test   %eax,%eax
    2438:	74 14                	je     244e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    243a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    243d:	25 ff 0f 00 00       	and    $0xfff,%eax
    2442:	89 c2                	mov    %eax,%edx
    2444:	b8 00 10 00 00       	mov    $0x1000,%eax
    2449:	29 d0                	sub    %edx,%eax
    244b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    244e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2452:	75 1b                	jne    246f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    2454:	c7 44 24 04 82 27 00 	movl   $0x2782,0x4(%esp)
    245b:	00 
    245c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2463:	e8 78 fb ff ff       	call   1fe0 <printf>
        return 0;
    2468:	b8 00 00 00 00       	mov    $0x0,%eax
    246d:	eb 6f                	jmp    24de <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    246f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2472:	8b 55 08             	mov    0x8(%ebp),%edx
    2475:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2478:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    247c:	89 54 24 08          	mov    %edx,0x8(%esp)
    2480:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    2487:	00 
    2488:	89 04 24             	mov    %eax,(%esp)
    248b:	e8 48 fa ff ff       	call   1ed8 <clone>
    2490:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    2493:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2497:	79 1b                	jns    24b4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    2499:	c7 44 24 04 90 27 00 	movl   $0x2790,0x4(%esp)
    24a0:	00 
    24a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24a8:	e8 33 fb ff ff       	call   1fe0 <printf>
        return 0;
    24ad:	b8 00 00 00 00       	mov    $0x0,%eax
    24b2:	eb 2a                	jmp    24de <thread_create+0xcb>
    }
    if(tid > 0){
    24b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24b8:	7e 05                	jle    24bf <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    24ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24bd:	eb 1f                	jmp    24de <thread_create+0xcb>
    }
    if(tid == 0){
    24bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24c3:	75 14                	jne    24d9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    24c5:	c7 44 24 04 9d 27 00 	movl   $0x279d,0x4(%esp)
    24cc:	00 
    24cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d4:	e8 07 fb ff ff       	call   1fe0 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    24d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    24de:	c9                   	leave  
    24df:	c3                   	ret    

000024e0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    24e0:	55                   	push   %ebp
    24e1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    24e3:	a1 64 2c 00 00       	mov    0x2c64,%eax
    24e8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    24ee:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    24f3:	a3 64 2c 00 00       	mov    %eax,0x2c64
    return (int)(rands % max);
    24f8:	a1 64 2c 00 00       	mov    0x2c64,%eax
    24fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2500:	ba 00 00 00 00       	mov    $0x0,%edx
    2505:	f7 f1                	div    %ecx
    2507:	89 d0                	mov    %edx,%eax
}
    2509:	5d                   	pop    %ebp
    250a:	c3                   	ret    
    250b:	90                   	nop

0000250c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    250c:	55                   	push   %ebp
    250d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    250f:	8b 45 08             	mov    0x8(%ebp),%eax
    2512:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2518:	8b 45 08             	mov    0x8(%ebp),%eax
    251b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    2522:	8b 45 08             	mov    0x8(%ebp),%eax
    2525:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    252c:	5d                   	pop    %ebp
    252d:	c3                   	ret    

0000252e <add_q>:

void add_q(struct queue *q, int v){
    252e:	55                   	push   %ebp
    252f:	89 e5                	mov    %esp,%ebp
    2531:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2534:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    253b:	e8 8d fd ff ff       	call   22cd <malloc>
    2540:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    2543:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2546:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    254d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2550:	8b 55 0c             	mov    0xc(%ebp),%edx
    2553:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2555:	8b 45 08             	mov    0x8(%ebp),%eax
    2558:	8b 40 04             	mov    0x4(%eax),%eax
    255b:	85 c0                	test   %eax,%eax
    255d:	75 0b                	jne    256a <add_q+0x3c>
        q->head = n;
    255f:	8b 45 08             	mov    0x8(%ebp),%eax
    2562:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2565:	89 50 04             	mov    %edx,0x4(%eax)
    2568:	eb 0c                	jmp    2576 <add_q+0x48>
    }else{
        q->tail->next = n;
    256a:	8b 45 08             	mov    0x8(%ebp),%eax
    256d:	8b 40 08             	mov    0x8(%eax),%eax
    2570:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2573:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    2576:	8b 45 08             	mov    0x8(%ebp),%eax
    2579:	8b 55 f4             	mov    -0xc(%ebp),%edx
    257c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    257f:	8b 45 08             	mov    0x8(%ebp),%eax
    2582:	8b 00                	mov    (%eax),%eax
    2584:	8d 50 01             	lea    0x1(%eax),%edx
    2587:	8b 45 08             	mov    0x8(%ebp),%eax
    258a:	89 10                	mov    %edx,(%eax)
}
    258c:	c9                   	leave  
    258d:	c3                   	ret    

0000258e <empty_q>:

int empty_q(struct queue *q){
    258e:	55                   	push   %ebp
    258f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    2591:	8b 45 08             	mov    0x8(%ebp),%eax
    2594:	8b 00                	mov    (%eax),%eax
    2596:	85 c0                	test   %eax,%eax
    2598:	75 07                	jne    25a1 <empty_q+0x13>
        return 1;
    259a:	b8 01 00 00 00       	mov    $0x1,%eax
    259f:	eb 05                	jmp    25a6 <empty_q+0x18>
    else
        return 0;
    25a1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    25a6:	5d                   	pop    %ebp
    25a7:	c3                   	ret    

000025a8 <pop_q>:
int pop_q(struct queue *q){
    25a8:	55                   	push   %ebp
    25a9:	89 e5                	mov    %esp,%ebp
    25ab:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    25ae:	8b 45 08             	mov    0x8(%ebp),%eax
    25b1:	89 04 24             	mov    %eax,(%esp)
    25b4:	e8 d5 ff ff ff       	call   258e <empty_q>
    25b9:	85 c0                	test   %eax,%eax
    25bb:	75 5d                	jne    261a <pop_q+0x72>
       val = q->head->value; 
    25bd:	8b 45 08             	mov    0x8(%ebp),%eax
    25c0:	8b 40 04             	mov    0x4(%eax),%eax
    25c3:	8b 00                	mov    (%eax),%eax
    25c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    25c8:	8b 45 08             	mov    0x8(%ebp),%eax
    25cb:	8b 40 04             	mov    0x4(%eax),%eax
    25ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    25d1:	8b 45 08             	mov    0x8(%ebp),%eax
    25d4:	8b 40 04             	mov    0x4(%eax),%eax
    25d7:	8b 50 04             	mov    0x4(%eax),%edx
    25da:	8b 45 08             	mov    0x8(%ebp),%eax
    25dd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    25e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25e3:	89 04 24             	mov    %eax,(%esp)
    25e6:	e8 a9 fb ff ff       	call   2194 <free>
       q->size--;
    25eb:	8b 45 08             	mov    0x8(%ebp),%eax
    25ee:	8b 00                	mov    (%eax),%eax
    25f0:	8d 50 ff             	lea    -0x1(%eax),%edx
    25f3:	8b 45 08             	mov    0x8(%ebp),%eax
    25f6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    25f8:	8b 45 08             	mov    0x8(%ebp),%eax
    25fb:	8b 00                	mov    (%eax),%eax
    25fd:	85 c0                	test   %eax,%eax
    25ff:	75 14                	jne    2615 <pop_q+0x6d>
            q->head = 0;
    2601:	8b 45 08             	mov    0x8(%ebp),%eax
    2604:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    260b:	8b 45 08             	mov    0x8(%ebp),%eax
    260e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2618:	eb 05                	jmp    261f <pop_q+0x77>
    }
    return -1;
    261a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    261f:	c9                   	leave  
    2620:	c3                   	ret    
