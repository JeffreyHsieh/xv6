
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
    102f:	e8 cb 10 00 00       	call   20ff <malloc>
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
    10da:	e8 f1 0e 00 00       	call   1fd0 <free>
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
    1143:	e8 b2 10 00 00       	call   21fa <lock_init>
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
    1162:	e8 a1 10 00 00       	call   2208 <lock_acquire>
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
    117d:	e8 a5 10 00 00       	call   2227 <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
  }
  else{
    lock_acquire(&s->lock);
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 76 10 00 00       	call   2208 <lock_acquire>
    add_qs(&(s->pRobyn), getpid());
    1192:	e8 69 0b 00 00       	call   1d00 <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    lock_release(&s->lock);
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 70 10 00 00       	call   2227 <lock_release>
    tsleep();
    11b7:	e8 74 0b 00 00       	call   1d30 <tsleep>
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
    11e7:	e8 1c 10 00 00       	call   2208 <lock_acquire>
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
    1202:	e8 20 10 00 00       	call   2227 <lock_release>
		
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
    122a:	e8 09 0b 00 00       	call   1d38 <twakeup>
		}
	}
}
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <main>:
void *tid;

void hReady();
void oReady();

int main(){
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 e4 f0             	and    $0xfffffff0,%esp
    1237:	83 ec 10             	sub    $0x10,%esp
	h = malloc(sizeof(struct Semaphore));
    123a:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1241:	e8 b9 0e 00 00       	call   20ff <malloc>
    1246:	a3 fc 25 00 00       	mov    %eax,0x25fc
	o = malloc(sizeof(struct Semaphore));
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 a8 0e 00 00       	call   20ff <malloc>
    1257:	a3 00 26 00 00       	mov    %eax,0x2600
	p = malloc(sizeof(struct Semaphore));
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 97 0e 00 00       	call   20ff <malloc>
    1268:	a3 04 26 00 00       	mov    %eax,0x2604
	sem_init(p, 1);
    126d:	a1 04 26 00 00       	mov    0x2604,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>

	// Test 1: 2 hydrogen 1 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    1282:	a1 04 26 00 00       	mov    0x2604,%eax
    1287:	89 04 24             	mov    %eax,(%esp)
    128a:	e8 bb fe ff ff       	call   114a <sem_acquire>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
    128f:	c7 44 24 04 54 24 00 	movl   $0x2454,0x4(%esp)
    1296:	00 
    1297:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129e:	e8 76 0b 00 00       	call   1e19 <printf>
	sem_signal(p);
    12a3:	a1 04 26 00 00       	mov    0x2604,%eax
    12a8:	89 04 24             	mov    %eax,(%esp)
    12ab:	e8 19 ff ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    12b0:	a1 fc 25 00 00       	mov    0x25fc,%eax
    12b5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12bc:	00 
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 50 fe ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    12c5:	a1 00 26 00 00       	mov    0x2600,%eax
    12ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 3b fe ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 1; water++){
    12da:	c7 05 14 26 00 00 00 	movl   $0x0,0x2614
    12e1:	00 00 00 
    12e4:	e9 0f 01 00 00       	jmp    13f8 <main+0x1c7>
		tid = thread_create(oReady, (void *) &arg);
    12e9:	b8 6b 19 00 00       	mov    $0x196b,%eax
    12ee:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    12f5:	00 
    12f6:	89 04 24             	mov    %eax,(%esp)
    12f9:	e8 44 0f 00 00       	call   2242 <thread_create>
    12fe:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    1303:	a1 18 26 00 00       	mov    0x2618,%eax
    1308:	85 c0                	test   %eax,%eax
    130a:	75 33                	jne    133f <main+0x10e>
			sem_acquire(p);
    130c:	a1 04 26 00 00       	mov    0x2604,%eax
    1311:	89 04 24             	mov    %eax,(%esp)
    1314:	e8 31 fe ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1319:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1320:	00 
    1321:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1328:	e8 ec 0a 00 00       	call   1e19 <printf>
			sem_signal(p);
    132d:	a1 04 26 00 00       	mov    0x2604,%eax
    1332:	89 04 24             	mov    %eax,(%esp)
    1335:	e8 8f fe ff ff       	call   11c9 <sem_signal>
			exit();
    133a:	e8 41 09 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    133f:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    1344:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    134b:	00 
    134c:	89 04 24             	mov    %eax,(%esp)
    134f:	e8 ee 0e 00 00       	call   2242 <thread_create>
    1354:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    1359:	a1 18 26 00 00       	mov    0x2618,%eax
    135e:	85 c0                	test   %eax,%eax
    1360:	75 33                	jne    1395 <main+0x164>
			sem_acquire(p);
    1362:	a1 04 26 00 00       	mov    0x2604,%eax
    1367:	89 04 24             	mov    %eax,(%esp)
    136a:	e8 db fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    136f:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1376:	00 
    1377:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137e:	e8 96 0a 00 00       	call   1e19 <printf>
			sem_signal(p);
    1383:	a1 04 26 00 00       	mov    0x2604,%eax
    1388:	89 04 24             	mov    %eax,(%esp)
    138b:	e8 39 fe ff ff       	call   11c9 <sem_signal>
			exit();
    1390:	e8 eb 08 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    1395:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    139a:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    13a1:	00 
    13a2:	89 04 24             	mov    %eax,(%esp)
    13a5:	e8 98 0e 00 00       	call   2242 <thread_create>
    13aa:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    13af:	a1 18 26 00 00       	mov    0x2618,%eax
    13b4:	85 c0                	test   %eax,%eax
    13b6:	75 33                	jne    13eb <main+0x1ba>
			sem_acquire(p);
    13b8:	a1 04 26 00 00       	mov    0x2604,%eax
    13bd:	89 04 24             	mov    %eax,(%esp)
    13c0:	e8 85 fd ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    13c5:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    13cc:	00 
    13cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13d4:	e8 40 0a 00 00       	call   1e19 <printf>
			sem_signal(p);
    13d9:	a1 04 26 00 00       	mov    0x2604,%eax
    13de:	89 04 24             	mov    %eax,(%esp)
    13e1:	e8 e3 fd ff ff       	call   11c9 <sem_signal>
			exit();
    13e6:	e8 95 08 00 00       	call   1c80 <exit>
	printf(1, "Test 1: 2 Hydrogen, 1 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 1; water++){
    13eb:	a1 14 26 00 00       	mov    0x2614,%eax
    13f0:	83 c0 01             	add    $0x1,%eax
    13f3:	a3 14 26 00 00       	mov    %eax,0x2614
    13f8:	a1 14 26 00 00       	mov    0x2614,%eax
    13fd:	85 c0                	test   %eax,%eax
    13ff:	0f 8e e4 fe ff ff    	jle    12e9 <main+0xb8>
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
	}
	while(wait()>= 0);
    1405:	e8 7e 08 00 00       	call   1c88 <wait>
    140a:	85 c0                	test   %eax,%eax
    140c:	79 f7                	jns    1405 <main+0x1d4>
	
	// Test 2: 20 hydrogen 10 oxygen (Thread creation order: O->H->H)
	sem_acquire(p);
    140e:	a1 04 26 00 00       	mov    0x2604,%eax
    1413:	89 04 24             	mov    %eax,(%esp)
    1416:	e8 2f fd ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
    141b:	c7 44 24 04 b0 24 00 	movl   $0x24b0,0x4(%esp)
    1422:	00 
    1423:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142a:	e8 ea 09 00 00       	call   1e19 <printf>
	sem_signal(p);
    142f:	a1 04 26 00 00       	mov    0x2604,%eax
    1434:	89 04 24             	mov    %eax,(%esp)
    1437:	e8 8d fd ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    143c:	a1 fc 25 00 00       	mov    0x25fc,%eax
    1441:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1448:	00 
    1449:	89 04 24             	mov    %eax,(%esp)
    144c:	e8 c4 fc ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    1451:	a1 00 26 00 00       	mov    0x2600,%eax
    1456:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    145d:	00 
    145e:	89 04 24             	mov    %eax,(%esp)
    1461:	e8 af fc ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    1466:	c7 05 14 26 00 00 00 	movl   $0x0,0x2614
    146d:	00 00 00 
    1470:	e9 0f 01 00 00       	jmp    1584 <main+0x353>
		tid = thread_create(oReady, (void *) &arg);
    1475:	b8 6b 19 00 00       	mov    $0x196b,%eax
    147a:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    1481:	00 
    1482:	89 04 24             	mov    %eax,(%esp)
    1485:	e8 b8 0d 00 00       	call   2242 <thread_create>
    148a:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    148f:	a1 18 26 00 00       	mov    0x2618,%eax
    1494:	85 c0                	test   %eax,%eax
    1496:	75 33                	jne    14cb <main+0x29a>
			sem_acquire(p);
    1498:	a1 04 26 00 00       	mov    0x2604,%eax
    149d:	89 04 24             	mov    %eax,(%esp)
    14a0:	e8 a5 fc ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    14a5:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    14ac:	00 
    14ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14b4:	e8 60 09 00 00       	call   1e19 <printf>
			sem_signal(p);
    14b9:	a1 04 26 00 00       	mov    0x2604,%eax
    14be:	89 04 24             	mov    %eax,(%esp)
    14c1:	e8 03 fd ff ff       	call   11c9 <sem_signal>
			exit();
    14c6:	e8 b5 07 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    14cb:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    14d0:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    14d7:	00 
    14d8:	89 04 24             	mov    %eax,(%esp)
    14db:	e8 62 0d 00 00       	call   2242 <thread_create>
    14e0:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    14e5:	a1 18 26 00 00       	mov    0x2618,%eax
    14ea:	85 c0                	test   %eax,%eax
    14ec:	75 33                	jne    1521 <main+0x2f0>
			sem_acquire(p);
    14ee:	a1 04 26 00 00       	mov    0x2604,%eax
    14f3:	89 04 24             	mov    %eax,(%esp)
    14f6:	e8 4f fc ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    14fb:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1502:	00 
    1503:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    150a:	e8 0a 09 00 00       	call   1e19 <printf>
			sem_signal(p);
    150f:	a1 04 26 00 00       	mov    0x2604,%eax
    1514:	89 04 24             	mov    %eax,(%esp)
    1517:	e8 ad fc ff ff       	call   11c9 <sem_signal>
			exit();
    151c:	e8 5f 07 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    1521:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    1526:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    152d:	00 
    152e:	89 04 24             	mov    %eax,(%esp)
    1531:	e8 0c 0d 00 00       	call   2242 <thread_create>
    1536:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    153b:	a1 18 26 00 00       	mov    0x2618,%eax
    1540:	85 c0                	test   %eax,%eax
    1542:	75 33                	jne    1577 <main+0x346>
			sem_acquire(p);
    1544:	a1 04 26 00 00       	mov    0x2604,%eax
    1549:	89 04 24             	mov    %eax,(%esp)
    154c:	e8 f9 fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1551:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1558:	00 
    1559:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1560:	e8 b4 08 00 00       	call   1e19 <printf>
			sem_signal(p);
    1565:	a1 04 26 00 00       	mov    0x2604,%eax
    156a:	89 04 24             	mov    %eax,(%esp)
    156d:	e8 57 fc ff ff       	call   11c9 <sem_signal>
			exit();
    1572:	e8 09 07 00 00       	call   1c80 <exit>
	printf(1, "\nTest 2: 20 Hydrogen, 10 Oxygen (Thread creation order: O->H->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1577:	a1 14 26 00 00       	mov    0x2614,%eax
    157c:	83 c0 01             	add    $0x1,%eax
    157f:	a3 14 26 00 00       	mov    %eax,0x2614
    1584:	a1 14 26 00 00       	mov    0x2614,%eax
    1589:	83 f8 09             	cmp    $0x9,%eax
    158c:	0f 8e e3 fe ff ff    	jle    1475 <main+0x244>
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
	}
	while(wait()>= 0);
    1592:	e8 f1 06 00 00       	call   1c88 <wait>
    1597:	85 c0                	test   %eax,%eax
    1599:	79 f7                	jns    1592 <main+0x361>
	
	// Test 3: 20 hydrogen 10 oxygen (Thread creation order: H->O->H)
	sem_acquire(p);
    159b:	a1 04 26 00 00       	mov    0x2604,%eax
    15a0:	89 04 24             	mov    %eax,(%esp)
    15a3:	e8 a2 fb ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
    15a8:	c7 44 24 04 f4 24 00 	movl   $0x24f4,0x4(%esp)
    15af:	00 
    15b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15b7:	e8 5d 08 00 00       	call   1e19 <printf>
	sem_signal(p);
    15bc:	a1 04 26 00 00       	mov    0x2604,%eax
    15c1:	89 04 24             	mov    %eax,(%esp)
    15c4:	e8 00 fc ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    15c9:	a1 fc 25 00 00       	mov    0x25fc,%eax
    15ce:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    15d5:	00 
    15d6:	89 04 24             	mov    %eax,(%esp)
    15d9:	e8 37 fb ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    15de:	a1 00 26 00 00       	mov    0x2600,%eax
    15e3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    15ea:	00 
    15eb:	89 04 24             	mov    %eax,(%esp)
    15ee:	e8 22 fb ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    15f3:	c7 05 14 26 00 00 00 	movl   $0x0,0x2614
    15fa:	00 00 00 
    15fd:	e9 0f 01 00 00       	jmp    1711 <main+0x4e0>
		tid = thread_create(hReady, (void *) &arg);
    1602:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    1607:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    160e:	00 
    160f:	89 04 24             	mov    %eax,(%esp)
    1612:	e8 2b 0c 00 00       	call   2242 <thread_create>
    1617:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    161c:	a1 18 26 00 00       	mov    0x2618,%eax
    1621:	85 c0                	test   %eax,%eax
    1623:	75 33                	jne    1658 <main+0x427>
			sem_acquire(p);
    1625:	a1 04 26 00 00       	mov    0x2604,%eax
    162a:	89 04 24             	mov    %eax,(%esp)
    162d:	e8 18 fb ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1632:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1639:	00 
    163a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1641:	e8 d3 07 00 00       	call   1e19 <printf>
			sem_signal(p);
    1646:	a1 04 26 00 00       	mov    0x2604,%eax
    164b:	89 04 24             	mov    %eax,(%esp)
    164e:	e8 76 fb ff ff       	call   11c9 <sem_signal>
			exit();
    1653:	e8 28 06 00 00       	call   1c80 <exit>
		}
		tid = thread_create(oReady, (void *) &arg);
    1658:	b8 6b 19 00 00       	mov    $0x196b,%eax
    165d:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    1664:	00 
    1665:	89 04 24             	mov    %eax,(%esp)
    1668:	e8 d5 0b 00 00       	call   2242 <thread_create>
    166d:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    1672:	a1 18 26 00 00       	mov    0x2618,%eax
    1677:	85 c0                	test   %eax,%eax
    1679:	75 33                	jne    16ae <main+0x47d>
			sem_acquire(p);
    167b:	a1 04 26 00 00       	mov    0x2604,%eax
    1680:	89 04 24             	mov    %eax,(%esp)
    1683:	e8 c2 fa ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1688:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    168f:	00 
    1690:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1697:	e8 7d 07 00 00       	call   1e19 <printf>
			sem_signal(p);
    169c:	a1 04 26 00 00       	mov    0x2604,%eax
    16a1:	89 04 24             	mov    %eax,(%esp)
    16a4:	e8 20 fb ff ff       	call   11c9 <sem_signal>
			exit();
    16a9:	e8 d2 05 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    16ae:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    16b3:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    16ba:	00 
    16bb:	89 04 24             	mov    %eax,(%esp)
    16be:	e8 7f 0b 00 00       	call   2242 <thread_create>
    16c3:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    16c8:	a1 18 26 00 00       	mov    0x2618,%eax
    16cd:	85 c0                	test   %eax,%eax
    16cf:	75 33                	jne    1704 <main+0x4d3>
			sem_acquire(p);
    16d1:	a1 04 26 00 00       	mov    0x2604,%eax
    16d6:	89 04 24             	mov    %eax,(%esp)
    16d9:	e8 6c fa ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    16de:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    16e5:	00 
    16e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16ed:	e8 27 07 00 00       	call   1e19 <printf>
			sem_signal(p);
    16f2:	a1 04 26 00 00       	mov    0x2604,%eax
    16f7:	89 04 24             	mov    %eax,(%esp)
    16fa:	e8 ca fa ff ff       	call   11c9 <sem_signal>
			exit();
    16ff:	e8 7c 05 00 00       	call   1c80 <exit>
	printf(1, "\nTest 3: 20 Hydrogen, 10 Oxygen (Thread creation order: H->O->H): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1704:	a1 14 26 00 00       	mov    0x2614,%eax
    1709:	83 c0 01             	add    $0x1,%eax
    170c:	a3 14 26 00 00       	mov    %eax,0x2614
    1711:	a1 14 26 00 00       	mov    0x2614,%eax
    1716:	83 f8 09             	cmp    $0x9,%eax
    1719:	0f 8e e3 fe ff ff    	jle    1602 <main+0x3d1>
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
	}
	while(wait()>= 0);
    171f:	e8 64 05 00 00       	call   1c88 <wait>
    1724:	85 c0                	test   %eax,%eax
    1726:	79 f7                	jns    171f <main+0x4ee>
	
	// Test 4: 20 hydrogen 10 oxygen (Thread creation order: H->H->O)
	sem_acquire(p);
    1728:	a1 04 26 00 00       	mov    0x2604,%eax
    172d:	89 04 24             	mov    %eax,(%esp)
    1730:	e8 15 fa ff ff       	call   114a <sem_acquire>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
    1735:	c7 44 24 04 38 25 00 	movl   $0x2538,0x4(%esp)
    173c:	00 
    173d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1744:	e8 d0 06 00 00       	call   1e19 <printf>
	sem_signal(p);
    1749:	a1 04 26 00 00       	mov    0x2604,%eax
    174e:	89 04 24             	mov    %eax,(%esp)
    1751:	e8 73 fa ff ff       	call   11c9 <sem_signal>
	sem_init(h, 2);
    1756:	a1 fc 25 00 00       	mov    0x25fc,%eax
    175b:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1762:	00 
    1763:	89 04 24             	mov    %eax,(%esp)
    1766:	e8 aa f9 ff ff       	call   1115 <sem_init>
	sem_init(o, 1);
    176b:	a1 00 26 00 00       	mov    0x2600,%eax
    1770:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1777:	00 
    1778:	89 04 24             	mov    %eax,(%esp)
    177b:	e8 95 f9 ff ff       	call   1115 <sem_init>
	
	for(water = 0; water < 10; water++){
    1780:	c7 05 14 26 00 00 00 	movl   $0x0,0x2614
    1787:	00 00 00 
    178a:	e9 0f 01 00 00       	jmp    189e <main+0x66d>
		tid = thread_create(hReady, (void *) &arg);
    178f:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    1794:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    179b:	00 
    179c:	89 04 24             	mov    %eax,(%esp)
    179f:	e8 9e 0a 00 00       	call   2242 <thread_create>
    17a4:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    17a9:	a1 18 26 00 00       	mov    0x2618,%eax
    17ae:	85 c0                	test   %eax,%eax
    17b0:	75 33                	jne    17e5 <main+0x5b4>
			sem_acquire(p);
    17b2:	a1 04 26 00 00       	mov    0x2604,%eax
    17b7:	89 04 24             	mov    %eax,(%esp)
    17ba:	e8 8b f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    17bf:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    17c6:	00 
    17c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ce:	e8 46 06 00 00       	call   1e19 <printf>
			sem_signal(p);
    17d3:	a1 04 26 00 00       	mov    0x2604,%eax
    17d8:	89 04 24             	mov    %eax,(%esp)
    17db:	e8 e9 f9 ff ff       	call   11c9 <sem_signal>
			exit();
    17e0:	e8 9b 04 00 00       	call   1c80 <exit>
		}
		tid = thread_create(hReady, (void *) &arg);
    17e5:	b8 ba 18 00 00       	mov    $0x18ba,%eax
    17ea:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    17f1:	00 
    17f2:	89 04 24             	mov    %eax,(%esp)
    17f5:	e8 48 0a 00 00       	call   2242 <thread_create>
    17fa:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    17ff:	a1 18 26 00 00       	mov    0x2618,%eax
    1804:	85 c0                	test   %eax,%eax
    1806:	75 33                	jne    183b <main+0x60a>
			sem_acquire(p);
    1808:	a1 04 26 00 00       	mov    0x2604,%eax
    180d:	89 04 24             	mov    %eax,(%esp)
    1810:	e8 35 f9 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    1815:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    181c:	00 
    181d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1824:	e8 f0 05 00 00       	call   1e19 <printf>
			sem_signal(p);
    1829:	a1 04 26 00 00       	mov    0x2604,%eax
    182e:	89 04 24             	mov    %eax,(%esp)
    1831:	e8 93 f9 ff ff       	call   11c9 <sem_signal>
			exit();
    1836:	e8 45 04 00 00       	call   1c80 <exit>
		}
		tid = thread_create(oReady, (void *) &arg);
    183b:	b8 6b 19 00 00       	mov    $0x196b,%eax
    1840:	c7 44 24 04 e0 25 00 	movl   $0x25e0,0x4(%esp)
    1847:	00 
    1848:	89 04 24             	mov    %eax,(%esp)
    184b:	e8 f2 09 00 00       	call   2242 <thread_create>
    1850:	a3 18 26 00 00       	mov    %eax,0x2618
		if(tid <= 0){
    1855:	a1 18 26 00 00       	mov    0x2618,%eax
    185a:	85 c0                	test   %eax,%eax
    185c:	75 33                	jne    1891 <main+0x660>
			sem_acquire(p);
    185e:	a1 04 26 00 00       	mov    0x2604,%eax
    1863:	89 04 24             	mov    %eax,(%esp)
    1866:	e8 df f8 ff ff       	call   114a <sem_acquire>
			printf(1, "Failed to create a thread\n");
    186b:	c7 44 24 04 95 24 00 	movl   $0x2495,0x4(%esp)
    1872:	00 
    1873:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    187a:	e8 9a 05 00 00       	call   1e19 <printf>
			sem_signal(p);
    187f:	a1 04 26 00 00       	mov    0x2604,%eax
    1884:	89 04 24             	mov    %eax,(%esp)
    1887:	e8 3d f9 ff ff       	call   11c9 <sem_signal>
			exit();
    188c:	e8 ef 03 00 00       	call   1c80 <exit>
	printf(1, "\nTest 4: 20 Hydrogen, 10 Oxygen (Thread creation order: H->H->O): \n");
	sem_signal(p);
	sem_init(h, 2);
	sem_init(o, 1);
	
	for(water = 0; water < 10; water++){
    1891:	a1 14 26 00 00       	mov    0x2614,%eax
    1896:	83 c0 01             	add    $0x1,%eax
    1899:	a3 14 26 00 00       	mov    %eax,0x2614
    189e:	a1 14 26 00 00       	mov    0x2614,%eax
    18a3:	83 f8 09             	cmp    $0x9,%eax
    18a6:	0f 8e e3 fe ff ff    	jle    178f <main+0x55e>
			printf(1, "Failed to create a thread\n");
			sem_signal(p);
			exit();
		}
	}
	while(wait()>= 0);
    18ac:	e8 d7 03 00 00       	call   1c88 <wait>
    18b1:	85 c0                	test   %eax,%eax
    18b3:	79 f7                	jns    18ac <main+0x67b>
	
	exit();
    18b5:	e8 c6 03 00 00       	call   1c80 <exit>

000018ba <hReady>:
	return 0;
}

//Hydrogen
void hReady(){
    18ba:	55                   	push   %ebp
    18bb:	89 e5                	mov    %esp,%ebp
    18bd:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    18c0:	a1 04 26 00 00       	mov    0x2604,%eax
    18c5:	89 04 24             	mov    %eax,(%esp)
    18c8:	e8 7d f8 ff ff       	call   114a <sem_acquire>
	printf(1, "Hydrogen ready\n");
    18cd:	c7 44 24 04 7c 25 00 	movl   $0x257c,0x4(%esp)
    18d4:	00 
    18d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18dc:	e8 38 05 00 00       	call   1e19 <printf>
	sem_signal(p);
    18e1:	a1 04 26 00 00       	mov    0x2604,%eax
    18e6:	89 04 24             	mov    %eax,(%esp)
    18e9:	e8 db f8 ff ff       	call   11c9 <sem_signal>
	sem_acquire(h);
    18ee:	a1 fc 25 00 00       	mov    0x25fc,%eax
    18f3:	89 04 24             	mov    %eax,(%esp)
    18f6:	e8 4f f8 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    18fb:	a1 fc 25 00 00       	mov    0x25fc,%eax
    1900:	8b 00                	mov    (%eax),%eax
    1902:	85 c0                	test   %eax,%eax
    1904:	75 60                	jne    1966 <hReady+0xac>
    1906:	a1 00 26 00 00       	mov    0x2600,%eax
    190b:	8b 00                	mov    (%eax),%eax
    190d:	85 c0                	test   %eax,%eax
    190f:	75 55                	jne    1966 <hReady+0xac>
		sem_acquire(p);
    1911:	a1 04 26 00 00       	mov    0x2604,%eax
    1916:	89 04 24             	mov    %eax,(%esp)
    1919:	e8 2c f8 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    191e:	c7 44 24 04 8c 25 00 	movl   $0x258c,0x4(%esp)
    1925:	00 
    1926:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    192d:	e8 e7 04 00 00       	call   1e19 <printf>
		sem_signal(p);
    1932:	a1 04 26 00 00       	mov    0x2604,%eax
    1937:	89 04 24             	mov    %eax,(%esp)
    193a:	e8 8a f8 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    193f:	a1 fc 25 00 00       	mov    0x25fc,%eax
    1944:	89 04 24             	mov    %eax,(%esp)
    1947:	e8 7d f8 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    194c:	a1 fc 25 00 00       	mov    0x25fc,%eax
    1951:	89 04 24             	mov    %eax,(%esp)
    1954:	e8 70 f8 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1959:	a1 00 26 00 00       	mov    0x2600,%eax
    195e:	89 04 24             	mov    %eax,(%esp)
    1961:	e8 63 f8 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1966:	e8 bd 03 00 00       	call   1d28 <texit>

0000196b <oReady>:
}

//Oxygen 
void oReady(){
    196b:	55                   	push   %ebp
    196c:	89 e5                	mov    %esp,%ebp
    196e:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(p);
    1971:	a1 04 26 00 00       	mov    0x2604,%eax
    1976:	89 04 24             	mov    %eax,(%esp)
    1979:	e8 cc f7 ff ff       	call   114a <sem_acquire>
	printf(1, "Oxygen ready\n");
    197e:	c7 44 24 04 9d 25 00 	movl   $0x259d,0x4(%esp)
    1985:	00 
    1986:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198d:	e8 87 04 00 00       	call   1e19 <printf>
	sem_signal(p);
    1992:	a1 04 26 00 00       	mov    0x2604,%eax
    1997:	89 04 24             	mov    %eax,(%esp)
    199a:	e8 2a f8 ff ff       	call   11c9 <sem_signal>
	sem_acquire(o);
    199f:	a1 00 26 00 00       	mov    0x2600,%eax
    19a4:	89 04 24             	mov    %eax,(%esp)
    19a7:	e8 9e f7 ff ff       	call   114a <sem_acquire>
	if(h->count == 0 && o->count == 0){
    19ac:	a1 fc 25 00 00       	mov    0x25fc,%eax
    19b1:	8b 00                	mov    (%eax),%eax
    19b3:	85 c0                	test   %eax,%eax
    19b5:	75 60                	jne    1a17 <oReady+0xac>
    19b7:	a1 00 26 00 00       	mov    0x2600,%eax
    19bc:	8b 00                	mov    (%eax),%eax
    19be:	85 c0                	test   %eax,%eax
    19c0:	75 55                	jne    1a17 <oReady+0xac>
		sem_acquire(p);
    19c2:	a1 04 26 00 00       	mov    0x2604,%eax
    19c7:	89 04 24             	mov    %eax,(%esp)
    19ca:	e8 7b f7 ff ff       	call   114a <sem_acquire>
		printf(1, "*Water created*\n");
    19cf:	c7 44 24 04 8c 25 00 	movl   $0x258c,0x4(%esp)
    19d6:	00 
    19d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19de:	e8 36 04 00 00       	call   1e19 <printf>
		sem_signal(p);
    19e3:	a1 04 26 00 00       	mov    0x2604,%eax
    19e8:	89 04 24             	mov    %eax,(%esp)
    19eb:	e8 d9 f7 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    19f0:	a1 fc 25 00 00       	mov    0x25fc,%eax
    19f5:	89 04 24             	mov    %eax,(%esp)
    19f8:	e8 cc f7 ff ff       	call   11c9 <sem_signal>
		sem_signal(h);
    19fd:	a1 fc 25 00 00       	mov    0x25fc,%eax
    1a02:	89 04 24             	mov    %eax,(%esp)
    1a05:	e8 bf f7 ff ff       	call   11c9 <sem_signal>
		sem_signal(o);
    1a0a:	a1 00 26 00 00       	mov    0x2600,%eax
    1a0f:	89 04 24             	mov    %eax,(%esp)
    1a12:	e8 b2 f7 ff ff       	call   11c9 <sem_signal>
	}
	texit();
    1a17:	e8 0c 03 00 00       	call   1d28 <texit>

00001a1c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1a1c:	55                   	push   %ebp
    1a1d:	89 e5                	mov    %esp,%ebp
    1a1f:	57                   	push   %edi
    1a20:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1a21:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a24:	8b 55 10             	mov    0x10(%ebp),%edx
    1a27:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2a:	89 cb                	mov    %ecx,%ebx
    1a2c:	89 df                	mov    %ebx,%edi
    1a2e:	89 d1                	mov    %edx,%ecx
    1a30:	fc                   	cld    
    1a31:	f3 aa                	rep stos %al,%es:(%edi)
    1a33:	89 ca                	mov    %ecx,%edx
    1a35:	89 fb                	mov    %edi,%ebx
    1a37:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1a3a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1a3d:	5b                   	pop    %ebx
    1a3e:	5f                   	pop    %edi
    1a3f:	5d                   	pop    %ebp
    1a40:	c3                   	ret    

00001a41 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1a41:	55                   	push   %ebp
    1a42:	89 e5                	mov    %esp,%ebp
    1a44:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1a4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a50:	0f b6 10             	movzbl (%eax),%edx
    1a53:	8b 45 08             	mov    0x8(%ebp),%eax
    1a56:	88 10                	mov    %dl,(%eax)
    1a58:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5b:	0f b6 00             	movzbl (%eax),%eax
    1a5e:	84 c0                	test   %al,%al
    1a60:	0f 95 c0             	setne  %al
    1a63:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1a67:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1a6b:	84 c0                	test   %al,%al
    1a6d:	75 de                	jne    1a4d <strcpy+0xc>
    ;
  return os;
    1a6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1a72:	c9                   	leave  
    1a73:	c3                   	ret    

00001a74 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1a74:	55                   	push   %ebp
    1a75:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1a77:	eb 08                	jmp    1a81 <strcmp+0xd>
    p++, q++;
    1a79:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1a7d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1a81:	8b 45 08             	mov    0x8(%ebp),%eax
    1a84:	0f b6 00             	movzbl (%eax),%eax
    1a87:	84 c0                	test   %al,%al
    1a89:	74 10                	je     1a9b <strcmp+0x27>
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	0f b6 10             	movzbl (%eax),%edx
    1a91:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a94:	0f b6 00             	movzbl (%eax),%eax
    1a97:	38 c2                	cmp    %al,%dl
    1a99:	74 de                	je     1a79 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	0f b6 00             	movzbl (%eax),%eax
    1aa1:	0f b6 d0             	movzbl %al,%edx
    1aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa7:	0f b6 00             	movzbl (%eax),%eax
    1aaa:	0f b6 c0             	movzbl %al,%eax
    1aad:	89 d1                	mov    %edx,%ecx
    1aaf:	29 c1                	sub    %eax,%ecx
    1ab1:	89 c8                	mov    %ecx,%eax
}
    1ab3:	5d                   	pop    %ebp
    1ab4:	c3                   	ret    

00001ab5 <strlen>:

uint
strlen(char *s)
{
    1ab5:	55                   	push   %ebp
    1ab6:	89 e5                	mov    %esp,%ebp
    1ab8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1abb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1ac2:	eb 04                	jmp    1ac8 <strlen+0x13>
    1ac4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1ac8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1acb:	03 45 08             	add    0x8(%ebp),%eax
    1ace:	0f b6 00             	movzbl (%eax),%eax
    1ad1:	84 c0                	test   %al,%al
    1ad3:	75 ef                	jne    1ac4 <strlen+0xf>
    ;
  return n;
    1ad5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1ad8:	c9                   	leave  
    1ad9:	c3                   	ret    

00001ada <memset>:

void*
memset(void *dst, int c, uint n)
{
    1ada:	55                   	push   %ebp
    1adb:	89 e5                	mov    %esp,%ebp
    1add:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1ae0:	8b 45 10             	mov    0x10(%ebp),%eax
    1ae3:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aea:	89 44 24 04          	mov    %eax,0x4(%esp)
    1aee:	8b 45 08             	mov    0x8(%ebp),%eax
    1af1:	89 04 24             	mov    %eax,(%esp)
    1af4:	e8 23 ff ff ff       	call   1a1c <stosb>
  return dst;
    1af9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1afc:	c9                   	leave  
    1afd:	c3                   	ret    

00001afe <strchr>:

char*
strchr(const char *s, char c)
{
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    1b01:	83 ec 04             	sub    $0x4,%esp
    1b04:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b07:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1b0a:	eb 14                	jmp    1b20 <strchr+0x22>
    if(*s == c)
    1b0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0f:	0f b6 00             	movzbl (%eax),%eax
    1b12:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1b15:	75 05                	jne    1b1c <strchr+0x1e>
      return (char*)s;
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	eb 13                	jmp    1b2f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1b1c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1b20:	8b 45 08             	mov    0x8(%ebp),%eax
    1b23:	0f b6 00             	movzbl (%eax),%eax
    1b26:	84 c0                	test   %al,%al
    1b28:	75 e2                	jne    1b0c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1b2a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b2f:	c9                   	leave  
    1b30:	c3                   	ret    

00001b31 <gets>:

char*
gets(char *buf, int max)
{
    1b31:	55                   	push   %ebp
    1b32:	89 e5                	mov    %esp,%ebp
    1b34:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1b37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1b3e:	eb 44                	jmp    1b84 <gets+0x53>
    cc = read(0, &c, 1);
    1b40:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1b47:	00 
    1b48:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b4f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b56:	e8 3d 01 00 00       	call   1c98 <read>
    1b5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1b5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b62:	7e 2d                	jle    1b91 <gets+0x60>
      break;
    buf[i++] = c;
    1b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b67:	03 45 08             	add    0x8(%ebp),%eax
    1b6a:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1b6e:	88 10                	mov    %dl,(%eax)
    1b70:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1b74:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1b78:	3c 0a                	cmp    $0xa,%al
    1b7a:	74 16                	je     1b92 <gets+0x61>
    1b7c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1b80:	3c 0d                	cmp    $0xd,%al
    1b82:	74 0e                	je     1b92 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1b84:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b87:	83 c0 01             	add    $0x1,%eax
    1b8a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1b8d:	7c b1                	jl     1b40 <gets+0xf>
    1b8f:	eb 01                	jmp    1b92 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1b91:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1b92:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b95:	03 45 08             	add    0x8(%ebp),%eax
    1b98:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1b9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1b9e:	c9                   	leave  
    1b9f:	c3                   	ret    

00001ba0 <stat>:

int
stat(char *n, struct stat *st)
{
    1ba0:	55                   	push   %ebp
    1ba1:	89 e5                	mov    %esp,%ebp
    1ba3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1ba6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1bad:	00 
    1bae:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb1:	89 04 24             	mov    %eax,(%esp)
    1bb4:	e8 07 01 00 00       	call   1cc0 <open>
    1bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1bbc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bc0:	79 07                	jns    1bc9 <stat+0x29>
    return -1;
    1bc2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1bc7:	eb 23                	jmp    1bec <stat+0x4c>
  r = fstat(fd, st);
    1bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1bd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bd3:	89 04 24             	mov    %eax,(%esp)
    1bd6:	e8 fd 00 00 00       	call   1cd8 <fstat>
    1bdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1bde:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be1:	89 04 24             	mov    %eax,(%esp)
    1be4:	e8 bf 00 00 00       	call   1ca8 <close>
  return r;
    1be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1bec:	c9                   	leave  
    1bed:	c3                   	ret    

00001bee <atoi>:

int
atoi(const char *s)
{
    1bee:	55                   	push   %ebp
    1bef:	89 e5                	mov    %esp,%ebp
    1bf1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1bf4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1bfb:	eb 24                	jmp    1c21 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1bfd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1c00:	89 d0                	mov    %edx,%eax
    1c02:	c1 e0 02             	shl    $0x2,%eax
    1c05:	01 d0                	add    %edx,%eax
    1c07:	01 c0                	add    %eax,%eax
    1c09:	89 c2                	mov    %eax,%edx
    1c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0e:	0f b6 00             	movzbl (%eax),%eax
    1c11:	0f be c0             	movsbl %al,%eax
    1c14:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1c17:	83 e8 30             	sub    $0x30,%eax
    1c1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1c1d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1c21:	8b 45 08             	mov    0x8(%ebp),%eax
    1c24:	0f b6 00             	movzbl (%eax),%eax
    1c27:	3c 2f                	cmp    $0x2f,%al
    1c29:	7e 0a                	jle    1c35 <atoi+0x47>
    1c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2e:	0f b6 00             	movzbl (%eax),%eax
    1c31:	3c 39                	cmp    $0x39,%al
    1c33:	7e c8                	jle    1bfd <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1c35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1c38:	c9                   	leave  
    1c39:	c3                   	ret    

00001c3a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1c3a:	55                   	push   %ebp
    1c3b:	89 e5                	mov    %esp,%ebp
    1c3d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1c40:	8b 45 08             	mov    0x8(%ebp),%eax
    1c43:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1c46:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c49:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1c4c:	eb 13                	jmp    1c61 <memmove+0x27>
    *dst++ = *src++;
    1c4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c51:	0f b6 10             	movzbl (%eax),%edx
    1c54:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c57:	88 10                	mov    %dl,(%eax)
    1c59:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1c5d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1c61:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1c65:	0f 9f c0             	setg   %al
    1c68:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1c6c:	84 c0                	test   %al,%al
    1c6e:	75 de                	jne    1c4e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1c70:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1c73:	c9                   	leave  
    1c74:	c3                   	ret    
    1c75:	90                   	nop
    1c76:	90                   	nop
    1c77:	90                   	nop

00001c78 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1c78:	b8 01 00 00 00       	mov    $0x1,%eax
    1c7d:	cd 40                	int    $0x40
    1c7f:	c3                   	ret    

00001c80 <exit>:
SYSCALL(exit)
    1c80:	b8 02 00 00 00       	mov    $0x2,%eax
    1c85:	cd 40                	int    $0x40
    1c87:	c3                   	ret    

00001c88 <wait>:
SYSCALL(wait)
    1c88:	b8 03 00 00 00       	mov    $0x3,%eax
    1c8d:	cd 40                	int    $0x40
    1c8f:	c3                   	ret    

00001c90 <pipe>:
SYSCALL(pipe)
    1c90:	b8 04 00 00 00       	mov    $0x4,%eax
    1c95:	cd 40                	int    $0x40
    1c97:	c3                   	ret    

00001c98 <read>:
SYSCALL(read)
    1c98:	b8 05 00 00 00       	mov    $0x5,%eax
    1c9d:	cd 40                	int    $0x40
    1c9f:	c3                   	ret    

00001ca0 <write>:
SYSCALL(write)
    1ca0:	b8 10 00 00 00       	mov    $0x10,%eax
    1ca5:	cd 40                	int    $0x40
    1ca7:	c3                   	ret    

00001ca8 <close>:
SYSCALL(close)
    1ca8:	b8 15 00 00 00       	mov    $0x15,%eax
    1cad:	cd 40                	int    $0x40
    1caf:	c3                   	ret    

00001cb0 <kill>:
SYSCALL(kill)
    1cb0:	b8 06 00 00 00       	mov    $0x6,%eax
    1cb5:	cd 40                	int    $0x40
    1cb7:	c3                   	ret    

00001cb8 <exec>:
SYSCALL(exec)
    1cb8:	b8 07 00 00 00       	mov    $0x7,%eax
    1cbd:	cd 40                	int    $0x40
    1cbf:	c3                   	ret    

00001cc0 <open>:
SYSCALL(open)
    1cc0:	b8 0f 00 00 00       	mov    $0xf,%eax
    1cc5:	cd 40                	int    $0x40
    1cc7:	c3                   	ret    

00001cc8 <mknod>:
SYSCALL(mknod)
    1cc8:	b8 11 00 00 00       	mov    $0x11,%eax
    1ccd:	cd 40                	int    $0x40
    1ccf:	c3                   	ret    

00001cd0 <unlink>:
SYSCALL(unlink)
    1cd0:	b8 12 00 00 00       	mov    $0x12,%eax
    1cd5:	cd 40                	int    $0x40
    1cd7:	c3                   	ret    

00001cd8 <fstat>:
SYSCALL(fstat)
    1cd8:	b8 08 00 00 00       	mov    $0x8,%eax
    1cdd:	cd 40                	int    $0x40
    1cdf:	c3                   	ret    

00001ce0 <link>:
SYSCALL(link)
    1ce0:	b8 13 00 00 00       	mov    $0x13,%eax
    1ce5:	cd 40                	int    $0x40
    1ce7:	c3                   	ret    

00001ce8 <mkdir>:
SYSCALL(mkdir)
    1ce8:	b8 14 00 00 00       	mov    $0x14,%eax
    1ced:	cd 40                	int    $0x40
    1cef:	c3                   	ret    

00001cf0 <chdir>:
SYSCALL(chdir)
    1cf0:	b8 09 00 00 00       	mov    $0x9,%eax
    1cf5:	cd 40                	int    $0x40
    1cf7:	c3                   	ret    

00001cf8 <dup>:
SYSCALL(dup)
    1cf8:	b8 0a 00 00 00       	mov    $0xa,%eax
    1cfd:	cd 40                	int    $0x40
    1cff:	c3                   	ret    

00001d00 <getpid>:
SYSCALL(getpid)
    1d00:	b8 0b 00 00 00       	mov    $0xb,%eax
    1d05:	cd 40                	int    $0x40
    1d07:	c3                   	ret    

00001d08 <sbrk>:
SYSCALL(sbrk)
    1d08:	b8 0c 00 00 00       	mov    $0xc,%eax
    1d0d:	cd 40                	int    $0x40
    1d0f:	c3                   	ret    

00001d10 <sleep>:
SYSCALL(sleep)
    1d10:	b8 0d 00 00 00       	mov    $0xd,%eax
    1d15:	cd 40                	int    $0x40
    1d17:	c3                   	ret    

00001d18 <uptime>:
SYSCALL(uptime)
    1d18:	b8 0e 00 00 00       	mov    $0xe,%eax
    1d1d:	cd 40                	int    $0x40
    1d1f:	c3                   	ret    

00001d20 <clone>:
SYSCALL(clone)
    1d20:	b8 16 00 00 00       	mov    $0x16,%eax
    1d25:	cd 40                	int    $0x40
    1d27:	c3                   	ret    

00001d28 <texit>:
SYSCALL(texit)
    1d28:	b8 17 00 00 00       	mov    $0x17,%eax
    1d2d:	cd 40                	int    $0x40
    1d2f:	c3                   	ret    

00001d30 <tsleep>:
SYSCALL(tsleep)
    1d30:	b8 18 00 00 00       	mov    $0x18,%eax
    1d35:	cd 40                	int    $0x40
    1d37:	c3                   	ret    

00001d38 <twakeup>:
SYSCALL(twakeup)
    1d38:	b8 19 00 00 00       	mov    $0x19,%eax
    1d3d:	cd 40                	int    $0x40
    1d3f:	c3                   	ret    

00001d40 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1d40:	55                   	push   %ebp
    1d41:	89 e5                	mov    %esp,%ebp
    1d43:	83 ec 28             	sub    $0x28,%esp
    1d46:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d49:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1d4c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1d53:	00 
    1d54:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1d57:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5e:	89 04 24             	mov    %eax,(%esp)
    1d61:	e8 3a ff ff ff       	call   1ca0 <write>
}
    1d66:	c9                   	leave  
    1d67:	c3                   	ret    

00001d68 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1d68:	55                   	push   %ebp
    1d69:	89 e5                	mov    %esp,%ebp
    1d6b:	53                   	push   %ebx
    1d6c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1d6f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1d76:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1d7a:	74 17                	je     1d93 <printint+0x2b>
    1d7c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d80:	79 11                	jns    1d93 <printint+0x2b>
    neg = 1;
    1d82:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1d89:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d8c:	f7 d8                	neg    %eax
    1d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1d91:	eb 06                	jmp    1d99 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1d93:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d96:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1d99:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1da0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1da3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da9:	ba 00 00 00 00       	mov    $0x0,%edx
    1dae:	f7 f3                	div    %ebx
    1db0:	89 d0                	mov    %edx,%eax
    1db2:	0f b6 80 e4 25 00 00 	movzbl 0x25e4(%eax),%eax
    1db9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1dbd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1dc1:	8b 45 10             	mov    0x10(%ebp),%eax
    1dc4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dca:	ba 00 00 00 00       	mov    $0x0,%edx
    1dcf:	f7 75 d4             	divl   -0x2c(%ebp)
    1dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1dd5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dd9:	75 c5                	jne    1da0 <printint+0x38>
  if(neg)
    1ddb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ddf:	74 28                	je     1e09 <printint+0xa1>
    buf[i++] = '-';
    1de1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1de4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1de9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1ded:	eb 1a                	jmp    1e09 <printint+0xa1>
    putc(fd, buf[i]);
    1def:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1df2:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1df7:	0f be c0             	movsbl %al,%eax
    1dfa:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1e01:	89 04 24             	mov    %eax,(%esp)
    1e04:	e8 37 ff ff ff       	call   1d40 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1e09:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1e0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e11:	79 dc                	jns    1def <printint+0x87>
    putc(fd, buf[i]);
}
    1e13:	83 c4 44             	add    $0x44,%esp
    1e16:	5b                   	pop    %ebx
    1e17:	5d                   	pop    %ebp
    1e18:	c3                   	ret    

00001e19 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1e19:	55                   	push   %ebp
    1e1a:	89 e5                	mov    %esp,%ebp
    1e1c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1e1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1e26:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e29:	83 c0 04             	add    $0x4,%eax
    1e2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1e2f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1e36:	e9 7e 01 00 00       	jmp    1fb9 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e41:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1e44:	0f b6 00             	movzbl (%eax),%eax
    1e47:	0f be c0             	movsbl %al,%eax
    1e4a:	25 ff 00 00 00       	and    $0xff,%eax
    1e4f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1e52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e56:	75 2c                	jne    1e84 <printf+0x6b>
      if(c == '%'){
    1e58:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1e5c:	75 0c                	jne    1e6a <printf+0x51>
        state = '%';
    1e5e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1e65:	e9 4b 01 00 00       	jmp    1fb5 <printf+0x19c>
      } else {
        putc(fd, c);
    1e6a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1e6d:	0f be c0             	movsbl %al,%eax
    1e70:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e74:	8b 45 08             	mov    0x8(%ebp),%eax
    1e77:	89 04 24             	mov    %eax,(%esp)
    1e7a:	e8 c1 fe ff ff       	call   1d40 <putc>
    1e7f:	e9 31 01 00 00       	jmp    1fb5 <printf+0x19c>
      }
    } else if(state == '%'){
    1e84:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1e88:	0f 85 27 01 00 00    	jne    1fb5 <printf+0x19c>
      if(c == 'd'){
    1e8e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1e92:	75 2d                	jne    1ec1 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1e94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e97:	8b 00                	mov    (%eax),%eax
    1e99:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1ea0:	00 
    1ea1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1ea8:	00 
    1ea9:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ead:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb0:	89 04 24             	mov    %eax,(%esp)
    1eb3:	e8 b0 fe ff ff       	call   1d68 <printint>
        ap++;
    1eb8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1ebc:	e9 ed 00 00 00       	jmp    1fae <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1ec1:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1ec5:	74 06                	je     1ecd <printf+0xb4>
    1ec7:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1ecb:	75 2d                	jne    1efa <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1ecd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ed0:	8b 00                	mov    (%eax),%eax
    1ed2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1ed9:	00 
    1eda:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1ee1:	00 
    1ee2:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ee6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee9:	89 04 24             	mov    %eax,(%esp)
    1eec:	e8 77 fe ff ff       	call   1d68 <printint>
        ap++;
    1ef1:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1ef5:	e9 b4 00 00 00       	jmp    1fae <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1efa:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1efe:	75 46                	jne    1f46 <printf+0x12d>
        s = (char*)*ap;
    1f00:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f03:	8b 00                	mov    (%eax),%eax
    1f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1f08:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1f0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1f10:	75 27                	jne    1f39 <printf+0x120>
          s = "(null)";
    1f12:	c7 45 e4 ab 25 00 00 	movl   $0x25ab,-0x1c(%ebp)
        while(*s != 0){
    1f19:	eb 1f                	jmp    1f3a <printf+0x121>
          putc(fd, *s);
    1f1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f1e:	0f b6 00             	movzbl (%eax),%eax
    1f21:	0f be c0             	movsbl %al,%eax
    1f24:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f28:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2b:	89 04 24             	mov    %eax,(%esp)
    1f2e:	e8 0d fe ff ff       	call   1d40 <putc>
          s++;
    1f33:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f37:	eb 01                	jmp    1f3a <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1f39:	90                   	nop
    1f3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f3d:	0f b6 00             	movzbl (%eax),%eax
    1f40:	84 c0                	test   %al,%al
    1f42:	75 d7                	jne    1f1b <printf+0x102>
    1f44:	eb 68                	jmp    1fae <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1f46:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1f4a:	75 1d                	jne    1f69 <printf+0x150>
        putc(fd, *ap);
    1f4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f4f:	8b 00                	mov    (%eax),%eax
    1f51:	0f be c0             	movsbl %al,%eax
    1f54:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f58:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5b:	89 04 24             	mov    %eax,(%esp)
    1f5e:	e8 dd fd ff ff       	call   1d40 <putc>
        ap++;
    1f63:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1f67:	eb 45                	jmp    1fae <printf+0x195>
      } else if(c == '%'){
    1f69:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f6d:	75 17                	jne    1f86 <printf+0x16d>
        putc(fd, c);
    1f6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f72:	0f be c0             	movsbl %al,%eax
    1f75:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f79:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7c:	89 04 24             	mov    %eax,(%esp)
    1f7f:	e8 bc fd ff ff       	call   1d40 <putc>
    1f84:	eb 28                	jmp    1fae <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1f86:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1f8d:	00 
    1f8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f91:	89 04 24             	mov    %eax,(%esp)
    1f94:	e8 a7 fd ff ff       	call   1d40 <putc>
        putc(fd, c);
    1f99:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f9c:	0f be c0             	movsbl %al,%eax
    1f9f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fa3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa6:	89 04 24             	mov    %eax,(%esp)
    1fa9:	e8 92 fd ff ff       	call   1d40 <putc>
      }
      state = 0;
    1fae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1fb5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1fb9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fbf:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1fc2:	0f b6 00             	movzbl (%eax),%eax
    1fc5:	84 c0                	test   %al,%al
    1fc7:	0f 85 6e fe ff ff    	jne    1e3b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1fcd:	c9                   	leave  
    1fce:	c3                   	ret    
    1fcf:	90                   	nop

00001fd0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1fd0:	55                   	push   %ebp
    1fd1:	89 e5                	mov    %esp,%ebp
    1fd3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd9:	83 e8 08             	sub    $0x8,%eax
    1fdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1fdf:	a1 10 26 00 00       	mov    0x2610,%eax
    1fe4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1fe7:	eb 24                	jmp    200d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1fe9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1fec:	8b 00                	mov    (%eax),%eax
    1fee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ff1:	77 12                	ja     2005 <free+0x35>
    1ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ff6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ff9:	77 24                	ja     201f <free+0x4f>
    1ffb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ffe:	8b 00                	mov    (%eax),%eax
    2000:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2003:	77 1a                	ja     201f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2005:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2008:	8b 00                	mov    (%eax),%eax
    200a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    200d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2010:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2013:	76 d4                	jbe    1fe9 <free+0x19>
    2015:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2018:	8b 00                	mov    (%eax),%eax
    201a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    201d:	76 ca                	jbe    1fe9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    201f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2022:	8b 40 04             	mov    0x4(%eax),%eax
    2025:	c1 e0 03             	shl    $0x3,%eax
    2028:	89 c2                	mov    %eax,%edx
    202a:	03 55 f8             	add    -0x8(%ebp),%edx
    202d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2030:	8b 00                	mov    (%eax),%eax
    2032:	39 c2                	cmp    %eax,%edx
    2034:	75 24                	jne    205a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    2036:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2039:	8b 50 04             	mov    0x4(%eax),%edx
    203c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    203f:	8b 00                	mov    (%eax),%eax
    2041:	8b 40 04             	mov    0x4(%eax),%eax
    2044:	01 c2                	add    %eax,%edx
    2046:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2049:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    204c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    204f:	8b 00                	mov    (%eax),%eax
    2051:	8b 10                	mov    (%eax),%edx
    2053:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2056:	89 10                	mov    %edx,(%eax)
    2058:	eb 0a                	jmp    2064 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    205a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    205d:	8b 10                	mov    (%eax),%edx
    205f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2062:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    2064:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2067:	8b 40 04             	mov    0x4(%eax),%eax
    206a:	c1 e0 03             	shl    $0x3,%eax
    206d:	03 45 fc             	add    -0x4(%ebp),%eax
    2070:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2073:	75 20                	jne    2095 <free+0xc5>
    p->s.size += bp->s.size;
    2075:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2078:	8b 50 04             	mov    0x4(%eax),%edx
    207b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207e:	8b 40 04             	mov    0x4(%eax),%eax
    2081:	01 c2                	add    %eax,%edx
    2083:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2086:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2089:	8b 45 f8             	mov    -0x8(%ebp),%eax
    208c:	8b 10                	mov    (%eax),%edx
    208e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2091:	89 10                	mov    %edx,(%eax)
    2093:	eb 08                	jmp    209d <free+0xcd>
  } else
    p->s.ptr = bp;
    2095:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2098:	8b 55 f8             	mov    -0x8(%ebp),%edx
    209b:	89 10                	mov    %edx,(%eax)
  freep = p;
    209d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20a0:	a3 10 26 00 00       	mov    %eax,0x2610
}
    20a5:	c9                   	leave  
    20a6:	c3                   	ret    

000020a7 <morecore>:

static Header*
morecore(uint nu)
{
    20a7:	55                   	push   %ebp
    20a8:	89 e5                	mov    %esp,%ebp
    20aa:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    20ad:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    20b4:	77 07                	ja     20bd <morecore+0x16>
    nu = 4096;
    20b6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    20bd:	8b 45 08             	mov    0x8(%ebp),%eax
    20c0:	c1 e0 03             	shl    $0x3,%eax
    20c3:	89 04 24             	mov    %eax,(%esp)
    20c6:	e8 3d fc ff ff       	call   1d08 <sbrk>
    20cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    20ce:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    20d2:	75 07                	jne    20db <morecore+0x34>
    return 0;
    20d4:	b8 00 00 00 00       	mov    $0x0,%eax
    20d9:	eb 22                	jmp    20fd <morecore+0x56>
  hp = (Header*)p;
    20db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    20e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20e4:	8b 55 08             	mov    0x8(%ebp),%edx
    20e7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    20ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ed:	83 c0 08             	add    $0x8,%eax
    20f0:	89 04 24             	mov    %eax,(%esp)
    20f3:	e8 d8 fe ff ff       	call   1fd0 <free>
  return freep;
    20f8:	a1 10 26 00 00       	mov    0x2610,%eax
}
    20fd:	c9                   	leave  
    20fe:	c3                   	ret    

000020ff <malloc>:

void*
malloc(uint nbytes)
{
    20ff:	55                   	push   %ebp
    2100:	89 e5                	mov    %esp,%ebp
    2102:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2105:	8b 45 08             	mov    0x8(%ebp),%eax
    2108:	83 c0 07             	add    $0x7,%eax
    210b:	c1 e8 03             	shr    $0x3,%eax
    210e:	83 c0 01             	add    $0x1,%eax
    2111:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    2114:	a1 10 26 00 00       	mov    0x2610,%eax
    2119:	89 45 f0             	mov    %eax,-0x10(%ebp)
    211c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2120:	75 23                	jne    2145 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    2122:	c7 45 f0 08 26 00 00 	movl   $0x2608,-0x10(%ebp)
    2129:	8b 45 f0             	mov    -0x10(%ebp),%eax
    212c:	a3 10 26 00 00       	mov    %eax,0x2610
    2131:	a1 10 26 00 00       	mov    0x2610,%eax
    2136:	a3 08 26 00 00       	mov    %eax,0x2608
    base.s.size = 0;
    213b:	c7 05 0c 26 00 00 00 	movl   $0x0,0x260c
    2142:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2145:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2148:	8b 00                	mov    (%eax),%eax
    214a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    214d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2150:	8b 40 04             	mov    0x4(%eax),%eax
    2153:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2156:	72 4d                	jb     21a5 <malloc+0xa6>
      if(p->s.size == nunits)
    2158:	8b 45 ec             	mov    -0x14(%ebp),%eax
    215b:	8b 40 04             	mov    0x4(%eax),%eax
    215e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2161:	75 0c                	jne    216f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    2163:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2166:	8b 10                	mov    (%eax),%edx
    2168:	8b 45 f0             	mov    -0x10(%ebp),%eax
    216b:	89 10                	mov    %edx,(%eax)
    216d:	eb 26                	jmp    2195 <malloc+0x96>
      else {
        p->s.size -= nunits;
    216f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2172:	8b 40 04             	mov    0x4(%eax),%eax
    2175:	89 c2                	mov    %eax,%edx
    2177:	2b 55 f4             	sub    -0xc(%ebp),%edx
    217a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    217d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    2180:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2183:	8b 40 04             	mov    0x4(%eax),%eax
    2186:	c1 e0 03             	shl    $0x3,%eax
    2189:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    218c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    218f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2192:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    2195:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2198:	a3 10 26 00 00       	mov    %eax,0x2610
      return (void*)(p + 1);
    219d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21a0:	83 c0 08             	add    $0x8,%eax
    21a3:	eb 38                	jmp    21dd <malloc+0xde>
    }
    if(p == freep)
    21a5:	a1 10 26 00 00       	mov    0x2610,%eax
    21aa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    21ad:	75 1b                	jne    21ca <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    21af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b2:	89 04 24             	mov    %eax,(%esp)
    21b5:	e8 ed fe ff ff       	call   20a7 <morecore>
    21ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
    21bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    21c1:	75 07                	jne    21ca <malloc+0xcb>
        return 0;
    21c3:	b8 00 00 00 00       	mov    $0x0,%eax
    21c8:	eb 13                	jmp    21dd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    21ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21d3:	8b 00                	mov    (%eax),%eax
    21d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    21d8:	e9 70 ff ff ff       	jmp    214d <malloc+0x4e>
}
    21dd:	c9                   	leave  
    21de:	c3                   	ret    
    21df:	90                   	nop

000021e0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    21e0:	55                   	push   %ebp
    21e1:	89 e5                	mov    %esp,%ebp
    21e3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    21e6:	8b 55 08             	mov    0x8(%ebp),%edx
    21e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    21ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
    21ef:	f0 87 02             	lock xchg %eax,(%edx)
    21f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    21f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    21f8:	c9                   	leave  
    21f9:	c3                   	ret    

000021fa <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    21fa:	55                   	push   %ebp
    21fb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    21fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2200:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    2206:	5d                   	pop    %ebp
    2207:	c3                   	ret    

00002208 <lock_acquire>:
void lock_acquire(lock_t *lock){
    2208:	55                   	push   %ebp
    2209:	89 e5                	mov    %esp,%ebp
    220b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    220e:	8b 45 08             	mov    0x8(%ebp),%eax
    2211:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2218:	00 
    2219:	89 04 24             	mov    %eax,(%esp)
    221c:	e8 bf ff ff ff       	call   21e0 <xchg>
    2221:	85 c0                	test   %eax,%eax
    2223:	75 e9                	jne    220e <lock_acquire+0x6>
}
    2225:	c9                   	leave  
    2226:	c3                   	ret    

00002227 <lock_release>:
void lock_release(lock_t *lock){
    2227:	55                   	push   %ebp
    2228:	89 e5                	mov    %esp,%ebp
    222a:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    222d:	8b 45 08             	mov    0x8(%ebp),%eax
    2230:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2237:	00 
    2238:	89 04 24             	mov    %eax,(%esp)
    223b:	e8 a0 ff ff ff       	call   21e0 <xchg>
}
    2240:	c9                   	leave  
    2241:	c3                   	ret    

00002242 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    2242:	55                   	push   %ebp
    2243:	89 e5                	mov    %esp,%ebp
    2245:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    2248:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    224f:	e8 ab fe ff ff       	call   20ff <malloc>
    2254:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    2257:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225a:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    225d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2260:	25 ff 0f 00 00       	and    $0xfff,%eax
    2265:	85 c0                	test   %eax,%eax
    2267:	74 15                	je     227e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    2269:	8b 45 f0             	mov    -0x10(%ebp),%eax
    226c:	89 c2                	mov    %eax,%edx
    226e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    2274:	b8 00 10 00 00       	mov    $0x1000,%eax
    2279:	29 d0                	sub    %edx,%eax
    227b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    227e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2282:	75 1b                	jne    229f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    2284:	c7 44 24 04 b2 25 00 	movl   $0x25b2,0x4(%esp)
    228b:	00 
    228c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2293:	e8 81 fb ff ff       	call   1e19 <printf>
        return 0;
    2298:	b8 00 00 00 00       	mov    $0x0,%eax
    229d:	eb 6f                	jmp    230e <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    229f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    22a2:	8b 55 08             	mov    0x8(%ebp),%edx
    22a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22a8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    22ac:	89 54 24 08          	mov    %edx,0x8(%esp)
    22b0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    22b7:	00 
    22b8:	89 04 24             	mov    %eax,(%esp)
    22bb:	e8 60 fa ff ff       	call   1d20 <clone>
    22c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    22c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    22c7:	79 1b                	jns    22e4 <thread_create+0xa2>
        printf(1,"clone fails\n");
    22c9:	c7 44 24 04 c0 25 00 	movl   $0x25c0,0x4(%esp)
    22d0:	00 
    22d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22d8:	e8 3c fb ff ff       	call   1e19 <printf>
        return 0;
    22dd:	b8 00 00 00 00       	mov    $0x0,%eax
    22e2:	eb 2a                	jmp    230e <thread_create+0xcc>
    }
    if(tid > 0){
    22e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    22e8:	7e 05                	jle    22ef <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    22ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22ed:	eb 1f                	jmp    230e <thread_create+0xcc>
    }
    if(tid == 0){
    22ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    22f3:	75 14                	jne    2309 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    22f5:	c7 44 24 04 cd 25 00 	movl   $0x25cd,0x4(%esp)
    22fc:	00 
    22fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2304:	e8 10 fb ff ff       	call   1e19 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    2309:	b8 00 00 00 00       	mov    $0x0,%eax
}
    230e:	c9                   	leave  
    230f:	c3                   	ret    

00002310 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    2310:	55                   	push   %ebp
    2311:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    2313:	a1 f8 25 00 00       	mov    0x25f8,%eax
    2318:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    231e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    2323:	a3 f8 25 00 00       	mov    %eax,0x25f8
    return (int)(rands % max);
    2328:	a1 f8 25 00 00       	mov    0x25f8,%eax
    232d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2330:	ba 00 00 00 00       	mov    $0x0,%edx
    2335:	f7 f1                	div    %ecx
    2337:	89 d0                	mov    %edx,%eax
}
    2339:	5d                   	pop    %ebp
    233a:	c3                   	ret    
    233b:	90                   	nop

0000233c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    233c:	55                   	push   %ebp
    233d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    233f:	8b 45 08             	mov    0x8(%ebp),%eax
    2342:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    2348:	8b 45 08             	mov    0x8(%ebp),%eax
    234b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    2352:	8b 45 08             	mov    0x8(%ebp),%eax
    2355:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    235c:	5d                   	pop    %ebp
    235d:	c3                   	ret    

0000235e <add_q>:

void add_q(struct queue *q, int v){
    235e:	55                   	push   %ebp
    235f:	89 e5                	mov    %esp,%ebp
    2361:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    2364:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    236b:	e8 8f fd ff ff       	call   20ff <malloc>
    2370:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    2373:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2376:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    237d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2380:	8b 55 0c             	mov    0xc(%ebp),%edx
    2383:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2385:	8b 45 08             	mov    0x8(%ebp),%eax
    2388:	8b 40 04             	mov    0x4(%eax),%eax
    238b:	85 c0                	test   %eax,%eax
    238d:	75 0b                	jne    239a <add_q+0x3c>
        q->head = n;
    238f:	8b 45 08             	mov    0x8(%ebp),%eax
    2392:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2395:	89 50 04             	mov    %edx,0x4(%eax)
    2398:	eb 0c                	jmp    23a6 <add_q+0x48>
    }else{
        q->tail->next = n;
    239a:	8b 45 08             	mov    0x8(%ebp),%eax
    239d:	8b 40 08             	mov    0x8(%eax),%eax
    23a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    23a3:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    23a6:	8b 45 08             	mov    0x8(%ebp),%eax
    23a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    23ac:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    23af:	8b 45 08             	mov    0x8(%ebp),%eax
    23b2:	8b 00                	mov    (%eax),%eax
    23b4:	8d 50 01             	lea    0x1(%eax),%edx
    23b7:	8b 45 08             	mov    0x8(%ebp),%eax
    23ba:	89 10                	mov    %edx,(%eax)
}
    23bc:	c9                   	leave  
    23bd:	c3                   	ret    

000023be <empty_q>:

int empty_q(struct queue *q){
    23be:	55                   	push   %ebp
    23bf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    23c1:	8b 45 08             	mov    0x8(%ebp),%eax
    23c4:	8b 00                	mov    (%eax),%eax
    23c6:	85 c0                	test   %eax,%eax
    23c8:	75 07                	jne    23d1 <empty_q+0x13>
        return 1;
    23ca:	b8 01 00 00 00       	mov    $0x1,%eax
    23cf:	eb 05                	jmp    23d6 <empty_q+0x18>
    else
        return 0;
    23d1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    23d6:	5d                   	pop    %ebp
    23d7:	c3                   	ret    

000023d8 <pop_q>:
int pop_q(struct queue *q){
    23d8:	55                   	push   %ebp
    23d9:	89 e5                	mov    %esp,%ebp
    23db:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    23de:	8b 45 08             	mov    0x8(%ebp),%eax
    23e1:	89 04 24             	mov    %eax,(%esp)
    23e4:	e8 d5 ff ff ff       	call   23be <empty_q>
    23e9:	85 c0                	test   %eax,%eax
    23eb:	75 5d                	jne    244a <pop_q+0x72>
       val = q->head->value; 
    23ed:	8b 45 08             	mov    0x8(%ebp),%eax
    23f0:	8b 40 04             	mov    0x4(%eax),%eax
    23f3:	8b 00                	mov    (%eax),%eax
    23f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    23f8:	8b 45 08             	mov    0x8(%ebp),%eax
    23fb:	8b 40 04             	mov    0x4(%eax),%eax
    23fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    2401:	8b 45 08             	mov    0x8(%ebp),%eax
    2404:	8b 40 04             	mov    0x4(%eax),%eax
    2407:	8b 50 04             	mov    0x4(%eax),%edx
    240a:	8b 45 08             	mov    0x8(%ebp),%eax
    240d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    2410:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2413:	89 04 24             	mov    %eax,(%esp)
    2416:	e8 b5 fb ff ff       	call   1fd0 <free>
       q->size--;
    241b:	8b 45 08             	mov    0x8(%ebp),%eax
    241e:	8b 00                	mov    (%eax),%eax
    2420:	8d 50 ff             	lea    -0x1(%eax),%edx
    2423:	8b 45 08             	mov    0x8(%ebp),%eax
    2426:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    2428:	8b 45 08             	mov    0x8(%ebp),%eax
    242b:	8b 00                	mov    (%eax),%eax
    242d:	85 c0                	test   %eax,%eax
    242f:	75 14                	jne    2445 <pop_q+0x6d>
            q->head = 0;
    2431:	8b 45 08             	mov    0x8(%ebp),%eax
    2434:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    243b:	8b 45 08             	mov    0x8(%ebp),%eax
    243e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2445:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2448:	eb 05                	jmp    244f <pop_q+0x77>
    }
    return -1;
    244a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    244f:	c9                   	leave  
    2450:	c3                   	ret    
