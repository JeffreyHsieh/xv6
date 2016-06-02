
_frisbee:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
void pass_next(void *arg);
int lookup();



int main(int argc, char *argv[]){
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	56                   	push   %esi
    100e:	53                   	push   %ebx
    100f:	51                   	push   %ecx
    1010:	83 ec 3c             	sub    $0x3c,%esp
    1013:	89 cb                	mov    %ecx,%ebx

    int i;
    struct thread *t;
//    void * sp;

    if(argc != 3){
    1015:	83 3b 03             	cmpl   $0x3,(%ebx)
    1018:	74 19                	je     1033 <main+0x33>
        printf(1,"argc is not match !\n");
    101a:	c7 44 24 04 44 1e 00 	movl   $0x1e44,0x4(%esp)
    1021:	00 
    1022:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1029:	e8 de 07 00 00       	call   180c <printf>
        exit();
    102e:	e8 39 06 00 00       	call   166c <exit>
    }
    numthreads = atoi(argv[1]);
    1033:	8b 43 04             	mov    0x4(%ebx),%eax
    1036:	83 c0 04             	add    $0x4,%eax
    1039:	8b 00                	mov    (%eax),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 97 05 00 00       	call   15da <atoi>
    1043:	a3 e0 22 00 00       	mov    %eax,0x22e0
    numpass = atoi(argv[2]);
    1048:	8b 43 04             	mov    0x4(%ebx),%eax
    104b:	83 c0 08             	add    $0x8,%eax
    104e:	8b 00                	mov    (%eax),%eax
    1050:	89 04 24             	mov    %eax,(%esp)
    1053:	e8 82 05 00 00       	call   15da <atoi>
    1058:	a3 e4 22 00 00       	mov    %eax,0x22e4

    void * slist[numthreads];
    105d:	a1 e0 22 00 00       	mov    0x22e0,%eax
    1062:	8d 50 ff             	lea    -0x1(%eax),%edx
    1065:	89 55 dc             	mov    %edx,-0x24(%ebp)
    1068:	c1 e0 02             	shl    $0x2,%eax
    106b:	8d 50 03             	lea    0x3(%eax),%edx
    106e:	b8 10 00 00 00       	mov    $0x10,%eax
    1073:	83 e8 01             	sub    $0x1,%eax
    1076:	01 d0                	add    %edx,%eax
    1078:	be 10 00 00 00       	mov    $0x10,%esi
    107d:	ba 00 00 00 00       	mov    $0x0,%edx
    1082:	f7 f6                	div    %esi
    1084:	6b c0 10             	imul   $0x10,%eax,%eax
    1087:	29 c4                	sub    %eax,%esp
    1089:	8d 44 24 0c          	lea    0xc(%esp),%eax
    108d:	83 c0 03             	add    $0x3,%eax
    1090:	c1 e8 02             	shr    $0x2,%eax
    1093:	c1 e0 02             	shl    $0x2,%eax
    1096:	89 45 d8             	mov    %eax,-0x28(%ebp)

    //init ttable;
    lock_init(&ttable.lock);
    1099:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    10a0:	e8 45 0b 00 00       	call   1bea <lock_init>
    ttable.total = 0;
    10a5:	c7 05 04 25 00 00 00 	movl   $0x0,0x2504
    10ac:	00 00 00 
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    10af:	c7 45 e0 04 23 00 00 	movl   $0x2304,-0x20(%ebp)
    10b6:	eb 0d                	jmp    10c5 <main+0xc5>
        t->tid = 0;
    10b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    void * slist[numthreads];

    //init ttable;
    lock_init(&ttable.lock);
    ttable.total = 0;
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    10c1:	83 45 e0 08          	addl   $0x8,-0x20(%ebp)
    10c5:	81 7d e0 04 25 00 00 	cmpl   $0x2504,-0x20(%ebp)
    10cc:	72 ea                	jb     10b8 <main+0xb8>
        t->tid = 0;
    }
    //init stack list
    for(i = 0; i < 64;i++){
    10ce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    10d5:	eb 11                	jmp    10e8 <main+0xe8>
        slist[i]=0;
    10d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    10dd:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
    ttable.total = 0;
    for(t=ttable.thread;t < &ttable.thread[64];t++){
        t->tid = 0;
    }
    //init stack list
    for(i = 0; i < 64;i++){
    10e4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    10e8:	83 7d e4 3f          	cmpl   $0x3f,-0x1c(%ebp)
    10ec:	7e e9                	jle    10d7 <main+0xd7>
        slist[i]=0;
    }
    //init frisbee
    lock_init(&frisbee.lock);
    10ee:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    10f5:	e8 f0 0a 00 00       	call   1bea <lock_init>
    frisbee.pass = 0;
    10fa:	c7 05 0c 25 00 00 00 	movl   $0x0,0x250c
    1101:	00 00 00 
    frisbee.holding_thread = 0;
    1104:	c7 05 10 25 00 00 00 	movl   $0x0,0x2510
    110b:	00 00 00 

    printf(1,"\nnum of threads %d \n",numthreads);
    110e:	a1 e0 22 00 00       	mov    0x22e0,%eax
    1113:	89 44 24 08          	mov    %eax,0x8(%esp)
    1117:	c7 44 24 04 59 1e 00 	movl   $0x1e59,0x4(%esp)
    111e:	00 
    111f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1126:	e8 e1 06 00 00       	call   180c <printf>
    printf(1,"num of passes %d \n\n",numpass);
    112b:	a1 e4 22 00 00       	mov    0x22e4,%eax
    1130:	89 44 24 08          	mov    %eax,0x8(%esp)
    1134:	c7 44 24 04 6e 1e 00 	movl   $0x1e6e,0x4(%esp)
    113b:	00 
    113c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1143:	e8 c4 06 00 00       	call   180c <printf>


    for(i=0; i<numthreads;i++){
    1148:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    114f:	eb 43                	jmp    1194 <main+0x194>
        void *stack = thread_create(pass_next,(void *)0);      
    1151:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1158:	00 
    1159:	c7 04 24 3d 12 00 00 	movl   $0x123d,(%esp)
    1160:	e8 ce 0a 00 00       	call   1c33 <thread_create>
    1165:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(stack == 0)
    1168:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    116c:	75 16                	jne    1184 <main+0x184>
            printf(1,"thread_create fail\n");
    116e:	c7 44 24 04 82 1e 00 	movl   $0x1e82,0x4(%esp)
    1175:	00 
    1176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    117d:	e8 8a 06 00 00       	call   180c <printf>
    1182:	eb 0c                	jmp    1190 <main+0x190>
        else{
            slist[i] = stack;
    1184:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1187:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    118a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    118d:	89 0c 90             	mov    %ecx,(%eax,%edx,4)

    printf(1,"\nnum of threads %d \n",numthreads);
    printf(1,"num of passes %d \n\n",numpass);


    for(i=0; i<numthreads;i++){
    1190:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1194:	a1 e0 22 00 00       	mov    0x22e0,%eax
    1199:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    119c:	7c b3                	jl     1151 <main+0x151>
        else{
            slist[i] = stack;
        }
    }
//    sleep(5);
    for(i=0;i<numthreads;i++){
    119e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    11a5:	eb 10                	jmp    11b7 <main+0x1b7>
        if(wait() == -1)
    11a7:	e8 c8 04 00 00       	call   1674 <wait>
    11ac:	83 f8 ff             	cmp    $0xffffffff,%eax
    11af:	75 02                	jne    11b3 <main+0x1b3>
            break;
    11b1:	eb 0e                	jmp    11c1 <main+0x1c1>
        else{
            slist[i] = stack;
        }
    }
//    sleep(5);
    for(i=0;i<numthreads;i++){
    11b3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11b7:	a1 e0 22 00 00       	mov    0x22e0,%eax
    11bc:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    11bf:	7c e6                	jl     11a7 <main+0x1a7>
        if(wait() == -1)
            break;
    }
   // add printf for tid look up.  
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    11c1:	c7 45 e0 04 23 00 00 	movl   $0x2304,-0x20(%ebp)
    11c8:	eb 2a                	jmp    11f4 <main+0x1f4>
        if(t->tid != 0)
    11ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11cd:	8b 00                	mov    (%eax),%eax
    11cf:	85 c0                	test   %eax,%eax
    11d1:	74 1d                	je     11f0 <main+0x1f0>
            printf(1,"thread %d was killed! stack was freed.\n",t->tid);
    11d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11d6:	8b 00                	mov    (%eax),%eax
    11d8:	89 44 24 08          	mov    %eax,0x8(%esp)
    11dc:	c7 44 24 04 98 1e 00 	movl   $0x1e98,0x4(%esp)
    11e3:	00 
    11e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11eb:	e8 1c 06 00 00       	call   180c <printf>
    for(i=0;i<numthreads;i++){
        if(wait() == -1)
            break;
    }
   // add printf for tid look up.  
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    11f0:	83 45 e0 08          	addl   $0x8,-0x20(%ebp)
    11f4:	81 7d e0 04 25 00 00 	cmpl   $0x2504,-0x20(%ebp)
    11fb:	72 cd                	jb     11ca <main+0x1ca>
        if(t->tid != 0)
            printf(1,"thread %d was killed! stack was freed.\n",t->tid);
    }

    //free stacks
    for(i=0;i<numthreads;i++){
    11fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1204:	eb 28                	jmp    122e <main+0x22e>
        if(slist[i] != 0){
    1206:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1209:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    120c:	8b 04 90             	mov    (%eax,%edx,4),%eax
    120f:	85 c0                	test   %eax,%eax
    1211:	74 17                	je     122a <main+0x22a>
            void * f = slist[i];
    1213:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1216:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1219:	8b 04 90             	mov    (%eax,%edx,4),%eax
    121c:	89 45 d0             	mov    %eax,-0x30(%ebp)
            free(f);
    121f:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1222:	89 04 24             	mov    %eax,(%esp)
    1225:	e8 96 07 00 00       	call   19c0 <free>
        if(t->tid != 0)
            printf(1,"thread %d was killed! stack was freed.\n",t->tid);
    }

    //free stacks
    for(i=0;i<numthreads;i++){
    122a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    122e:	a1 e0 22 00 00       	mov    0x22e0,%eax
    1233:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    1236:	7c ce                	jl     1206 <main+0x206>
        if(slist[i] != 0){
            void * f = slist[i];
            free(f);
        }
    }
    exit();
    1238:	e8 2f 04 00 00       	call   166c <exit>

0000123d <pass_next>:
}

void pass_next(void *arg){
    123d:	55                   	push   %ebp
    123e:	89 e5                	mov    %esp,%ebp
    1240:	83 ec 28             	sub    $0x28,%esp
    struct thread *t;
    int tid;

    tid = getpid();
    1243:	e8 a4 04 00 00       	call   16ec <getpid>
    1248:	89 45 f0             	mov    %eax,-0x10(%ebp)

    lock_acquire(&ttable.lock);
    124b:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    1252:	e8 a1 09 00 00       	call   1bf8 <lock_acquire>
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    1257:	c7 45 f4 04 23 00 00 	movl   $0x2304,-0xc(%ebp)
    125e:	eb 17                	jmp    1277 <pass_next+0x3a>
        if(t->tid == 0){
    1260:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1263:	8b 00                	mov    (%eax),%eax
    1265:	85 c0                	test   %eax,%eax
    1267:	75 0a                	jne    1273 <pass_next+0x36>
            t->tid = tid;
    1269:	8b 45 f4             	mov    -0xc(%ebp),%eax
    126c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    126f:	89 10                	mov    %edx,(%eax)
            break;
    1271:	eb 0d                	jmp    1280 <pass_next+0x43>
    int tid;

    tid = getpid();

    lock_acquire(&ttable.lock);
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    1273:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
    1277:	81 7d f4 04 25 00 00 	cmpl   $0x2504,-0xc(%ebp)
    127e:	72 e0                	jb     1260 <pass_next+0x23>
        if(t->tid == 0){
            t->tid = tid;
            break;
        } 
    }
    ttable.total++;
    1280:	a1 04 25 00 00       	mov    0x2504,%eax
    1285:	83 c0 01             	add    $0x1,%eax
    1288:	a3 04 25 00 00       	mov    %eax,0x2504
    lock_release(&ttable.lock);
    128d:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    1294:	e8 7f 09 00 00       	call   1c18 <lock_release>

   for(;;){
        lock_acquire(&ttable.lock);
    1299:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    12a0:	e8 53 09 00 00       	call   1bf8 <lock_acquire>
        if(ttable.total == numthreads){
    12a5:	8b 15 04 25 00 00    	mov    0x2504,%edx
    12ab:	a1 e0 22 00 00       	mov    0x22e0,%eax
    12b0:	39 c2                	cmp    %eax,%edx
    12b2:	75 39                	jne    12ed <pass_next+0xb0>
            printf(1," tid %d ready to go\n",t->tid);
    12b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b7:	8b 00                	mov    (%eax),%eax
    12b9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12bd:	c7 44 24 04 c0 1e 00 	movl   $0x1ec0,0x4(%esp)
    12c4:	00 
    12c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12cc:	e8 3b 05 00 00       	call   180c <printf>
            barrier++;
    12d1:	a1 e8 22 00 00       	mov    0x22e8,%eax
    12d6:	83 c0 01             	add    $0x1,%eax
    12d9:	a3 e8 22 00 00       	mov    %eax,0x22e8
            goto start;
    12de:	90                   	nop
        lock_release(&ttable.lock);
    }
    
//barriar above
start:
     lock_release(&ttable.lock);
    12df:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    12e6:	e8 2d 09 00 00       	call   1c18 <lock_release>
     while(barrier != numthreads);
    12eb:	eb 0e                	jmp    12fb <pass_next+0xbe>
        if(ttable.total == numthreads){
            printf(1," tid %d ready to go\n",t->tid);
            barrier++;
            goto start;
        }
        lock_release(&ttable.lock);
    12ed:	c7 04 24 00 23 00 00 	movl   $0x2300,(%esp)
    12f4:	e8 1f 09 00 00       	call   1c18 <lock_release>
    }
    12f9:	eb 9e                	jmp    1299 <pass_next+0x5c>
    
//barriar above
start:
     lock_release(&ttable.lock);
     while(barrier != numthreads);
    12fb:	8b 15 e8 22 00 00    	mov    0x22e8,%edx
    1301:	a1 e0 22 00 00       	mov    0x22e0,%eax
    1306:	39 c2                	cmp    %eax,%edx
    1308:	75 f1                	jne    12fb <pass_next+0xbe>
    //throw frisbee
    do{
        lock_acquire(&frisbee.lock);
    130a:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    1311:	e8 e2 08 00 00       	call   1bf8 <lock_acquire>
        if(frisbee.pass > numpass){
    1316:	8b 15 0c 25 00 00    	mov    0x250c,%edx
    131c:	a1 e4 22 00 00       	mov    0x22e4,%eax
    1321:	39 c2                	cmp    %eax,%edx
    1323:	7e 39                	jle    135e <pass_next+0x121>
            lock_release(&frisbee.lock);
    1325:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    132c:	e8 e7 08 00 00       	call   1c18 <lock_release>
            goto leaving;
    1331:	90                   	nop
        frisbee.holding_thread = tid;
        lock_release(&frisbee.lock);
    }while(1);

leaving: 
    lock_release(&frisbee.lock);
    1332:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    1339:	e8 da 08 00 00       	call   1c18 <lock_release>
    printf(1,"thread %d out of game\n",tid);
    133e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1341:	89 44 24 08          	mov    %eax,0x8(%esp)
    1345:	c7 44 24 04 0c 1f 00 	movl   $0x1f0c,0x4(%esp)
    134c:	00 
    134d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1354:	e8 b3 04 00 00       	call   180c <printf>
    texit();
    1359:	e8 b6 03 00 00       	call   1714 <texit>
        lock_acquire(&frisbee.lock);
        if(frisbee.pass > numpass){
            lock_release(&frisbee.lock);
            goto leaving;
        }
        if(frisbee.holding_thread == tid){
    135e:	a1 10 25 00 00       	mov    0x2510,%eax
    1363:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1366:	75 1b                	jne    1383 <pass_next+0x146>
            lock_release(&frisbee.lock);
    1368:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    136f:	e8 a4 08 00 00       	call   1c18 <lock_release>
            sleep(5);
    1374:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    137b:	e8 7c 03 00 00       	call   16fc <sleep>
            continue;
    1380:	90                   	nop
        printf(1,"pass: %d, thread %d catch the frisbee. throwing...\n",
                frisbee.pass, tid);
        frisbee.pass++;
        frisbee.holding_thread = tid;
        lock_release(&frisbee.lock);
    }while(1);
    1381:	eb 87                	jmp    130a <pass_next+0xcd>
        if(frisbee.holding_thread == tid){
            lock_release(&frisbee.lock);
            sleep(5);
            continue;
        }
        printf(1,"pass: %d, thread %d catch the frisbee. throwing...\n",
    1383:	a1 0c 25 00 00       	mov    0x250c,%eax
    1388:	8b 55 f0             	mov    -0x10(%ebp),%edx
    138b:	89 54 24 0c          	mov    %edx,0xc(%esp)
    138f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1393:	c7 44 24 04 d8 1e 00 	movl   $0x1ed8,0x4(%esp)
    139a:	00 
    139b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a2:	e8 65 04 00 00       	call   180c <printf>
                frisbee.pass, tid);
        frisbee.pass++;
    13a7:	a1 0c 25 00 00       	mov    0x250c,%eax
    13ac:	83 c0 01             	add    $0x1,%eax
    13af:	a3 0c 25 00 00       	mov    %eax,0x250c
        frisbee.holding_thread = tid;
    13b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b7:	a3 10 25 00 00       	mov    %eax,0x2510
        lock_release(&frisbee.lock);
    13bc:	c7 04 24 08 25 00 00 	movl   $0x2508,(%esp)
    13c3:	e8 50 08 00 00       	call   1c18 <lock_release>
    }while(1);
    13c8:	e9 3d ff ff ff       	jmp    130a <pass_next+0xcd>

000013cd <lookup>:
    lock_release(&frisbee.lock);
    printf(1,"thread %d out of game\n",tid);
    texit();
}

int lookup(int num_threads){
    13cd:	55                   	push   %ebp
    13ce:	89 e5                	mov    %esp,%ebp
    13d0:	83 ec 10             	sub    $0x10,%esp
    int i;
    struct thread *t;
    i = 0;
    13d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(t=ttable.thread;t<&ttable.thread[64];t++){
    13da:	c7 45 f8 04 23 00 00 	movl   $0x2304,-0x8(%ebp)
    13e1:	eb 11                	jmp    13f4 <lookup+0x27>
        if(t->tid != 0){
    13e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13e6:	8b 00                	mov    (%eax),%eax
    13e8:	85 c0                	test   %eax,%eax
    13ea:	74 04                	je     13f0 <lookup+0x23>
            i++;
    13ec:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)

int lookup(int num_threads){
    int i;
    struct thread *t;
    i = 0;
    for(t=ttable.thread;t<&ttable.thread[64];t++){
    13f0:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
    13f4:	81 7d f8 04 25 00 00 	cmpl   $0x2504,-0x8(%ebp)
    13fb:	72 e6                	jb     13e3 <lookup+0x16>
        if(t->tid != 0){
            i++;
        }
    }
    return i;
    13fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1400:	c9                   	leave  
    1401:	c3                   	ret    
    1402:	66 90                	xchg   %ax,%ax

00001404 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1404:	55                   	push   %ebp
    1405:	89 e5                	mov    %esp,%ebp
    1407:	57                   	push   %edi
    1408:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1409:	8b 4d 08             	mov    0x8(%ebp),%ecx
    140c:	8b 55 10             	mov    0x10(%ebp),%edx
    140f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1412:	89 cb                	mov    %ecx,%ebx
    1414:	89 df                	mov    %ebx,%edi
    1416:	89 d1                	mov    %edx,%ecx
    1418:	fc                   	cld    
    1419:	f3 aa                	rep stos %al,%es:(%edi)
    141b:	89 ca                	mov    %ecx,%edx
    141d:	89 fb                	mov    %edi,%ebx
    141f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1422:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1425:	5b                   	pop    %ebx
    1426:	5f                   	pop    %edi
    1427:	5d                   	pop    %ebp
    1428:	c3                   	ret    

00001429 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1429:	55                   	push   %ebp
    142a:	89 e5                	mov    %esp,%ebp
    142c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1435:	90                   	nop
    1436:	8b 45 08             	mov    0x8(%ebp),%eax
    1439:	8d 50 01             	lea    0x1(%eax),%edx
    143c:	89 55 08             	mov    %edx,0x8(%ebp)
    143f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1442:	8d 4a 01             	lea    0x1(%edx),%ecx
    1445:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1448:	0f b6 12             	movzbl (%edx),%edx
    144b:	88 10                	mov    %dl,(%eax)
    144d:	0f b6 00             	movzbl (%eax),%eax
    1450:	84 c0                	test   %al,%al
    1452:	75 e2                	jne    1436 <strcpy+0xd>
    ;
  return os;
    1454:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1457:	c9                   	leave  
    1458:	c3                   	ret    

00001459 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1459:	55                   	push   %ebp
    145a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    145c:	eb 08                	jmp    1466 <strcmp+0xd>
    p++, q++;
    145e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1462:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	0f b6 00             	movzbl (%eax),%eax
    146c:	84 c0                	test   %al,%al
    146e:	74 10                	je     1480 <strcmp+0x27>
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	0f b6 10             	movzbl (%eax),%edx
    1476:	8b 45 0c             	mov    0xc(%ebp),%eax
    1479:	0f b6 00             	movzbl (%eax),%eax
    147c:	38 c2                	cmp    %al,%dl
    147e:	74 de                	je     145e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	0f b6 00             	movzbl (%eax),%eax
    1486:	0f b6 d0             	movzbl %al,%edx
    1489:	8b 45 0c             	mov    0xc(%ebp),%eax
    148c:	0f b6 00             	movzbl (%eax),%eax
    148f:	0f b6 c0             	movzbl %al,%eax
    1492:	29 c2                	sub    %eax,%edx
    1494:	89 d0                	mov    %edx,%eax
}
    1496:	5d                   	pop    %ebp
    1497:	c3                   	ret    

00001498 <strlen>:

uint
strlen(char *s)
{
    1498:	55                   	push   %ebp
    1499:	89 e5                	mov    %esp,%ebp
    149b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    149e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    14a5:	eb 04                	jmp    14ab <strlen+0x13>
    14a7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    14ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14ae:	8b 45 08             	mov    0x8(%ebp),%eax
    14b1:	01 d0                	add    %edx,%eax
    14b3:	0f b6 00             	movzbl (%eax),%eax
    14b6:	84 c0                	test   %al,%al
    14b8:	75 ed                	jne    14a7 <strlen+0xf>
    ;
  return n;
    14ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14bd:	c9                   	leave  
    14be:	c3                   	ret    

000014bf <memset>:

void*
memset(void *dst, int c, uint n)
{
    14bf:	55                   	push   %ebp
    14c0:	89 e5                	mov    %esp,%ebp
    14c2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    14c5:	8b 45 10             	mov    0x10(%ebp),%eax
    14c8:	89 44 24 08          	mov    %eax,0x8(%esp)
    14cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    14cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d3:	8b 45 08             	mov    0x8(%ebp),%eax
    14d6:	89 04 24             	mov    %eax,(%esp)
    14d9:	e8 26 ff ff ff       	call   1404 <stosb>
  return dst;
    14de:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14e1:	c9                   	leave  
    14e2:	c3                   	ret    

000014e3 <strchr>:

char*
strchr(const char *s, char c)
{
    14e3:	55                   	push   %ebp
    14e4:	89 e5                	mov    %esp,%ebp
    14e6:	83 ec 04             	sub    $0x4,%esp
    14e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ec:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    14ef:	eb 14                	jmp    1505 <strchr+0x22>
    if(*s == c)
    14f1:	8b 45 08             	mov    0x8(%ebp),%eax
    14f4:	0f b6 00             	movzbl (%eax),%eax
    14f7:	3a 45 fc             	cmp    -0x4(%ebp),%al
    14fa:	75 05                	jne    1501 <strchr+0x1e>
      return (char*)s;
    14fc:	8b 45 08             	mov    0x8(%ebp),%eax
    14ff:	eb 13                	jmp    1514 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1501:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1505:	8b 45 08             	mov    0x8(%ebp),%eax
    1508:	0f b6 00             	movzbl (%eax),%eax
    150b:	84 c0                	test   %al,%al
    150d:	75 e2                	jne    14f1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    150f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1514:	c9                   	leave  
    1515:	c3                   	ret    

00001516 <gets>:

char*
gets(char *buf, int max)
{
    1516:	55                   	push   %ebp
    1517:	89 e5                	mov    %esp,%ebp
    1519:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    151c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1523:	eb 4c                	jmp    1571 <gets+0x5b>
    cc = read(0, &c, 1);
    1525:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    152c:	00 
    152d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1530:	89 44 24 04          	mov    %eax,0x4(%esp)
    1534:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    153b:	e8 44 01 00 00       	call   1684 <read>
    1540:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1543:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1547:	7f 02                	jg     154b <gets+0x35>
      break;
    1549:	eb 31                	jmp    157c <gets+0x66>
    buf[i++] = c;
    154b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154e:	8d 50 01             	lea    0x1(%eax),%edx
    1551:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1554:	89 c2                	mov    %eax,%edx
    1556:	8b 45 08             	mov    0x8(%ebp),%eax
    1559:	01 c2                	add    %eax,%edx
    155b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    155f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1561:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1565:	3c 0a                	cmp    $0xa,%al
    1567:	74 13                	je     157c <gets+0x66>
    1569:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    156d:	3c 0d                	cmp    $0xd,%al
    156f:	74 0b                	je     157c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1571:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1574:	83 c0 01             	add    $0x1,%eax
    1577:	3b 45 0c             	cmp    0xc(%ebp),%eax
    157a:	7c a9                	jl     1525 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    157c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    157f:	8b 45 08             	mov    0x8(%ebp),%eax
    1582:	01 d0                	add    %edx,%eax
    1584:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1587:	8b 45 08             	mov    0x8(%ebp),%eax
}
    158a:	c9                   	leave  
    158b:	c3                   	ret    

0000158c <stat>:

int
stat(char *n, struct stat *st)
{
    158c:	55                   	push   %ebp
    158d:	89 e5                	mov    %esp,%ebp
    158f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1592:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1599:	00 
    159a:	8b 45 08             	mov    0x8(%ebp),%eax
    159d:	89 04 24             	mov    %eax,(%esp)
    15a0:	e8 07 01 00 00       	call   16ac <open>
    15a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    15a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ac:	79 07                	jns    15b5 <stat+0x29>
    return -1;
    15ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    15b3:	eb 23                	jmp    15d8 <stat+0x4c>
  r = fstat(fd, st);
    15b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    15b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	89 04 24             	mov    %eax,(%esp)
    15c2:	e8 fd 00 00 00       	call   16c4 <fstat>
    15c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    15ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cd:	89 04 24             	mov    %eax,(%esp)
    15d0:	e8 bf 00 00 00       	call   1694 <close>
  return r;
    15d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    15d8:	c9                   	leave  
    15d9:	c3                   	ret    

000015da <atoi>:

int
atoi(const char *s)
{
    15da:	55                   	push   %ebp
    15db:	89 e5                	mov    %esp,%ebp
    15dd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    15e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    15e7:	eb 25                	jmp    160e <atoi+0x34>
    n = n*10 + *s++ - '0';
    15e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    15ec:	89 d0                	mov    %edx,%eax
    15ee:	c1 e0 02             	shl    $0x2,%eax
    15f1:	01 d0                	add    %edx,%eax
    15f3:	01 c0                	add    %eax,%eax
    15f5:	89 c1                	mov    %eax,%ecx
    15f7:	8b 45 08             	mov    0x8(%ebp),%eax
    15fa:	8d 50 01             	lea    0x1(%eax),%edx
    15fd:	89 55 08             	mov    %edx,0x8(%ebp)
    1600:	0f b6 00             	movzbl (%eax),%eax
    1603:	0f be c0             	movsbl %al,%eax
    1606:	01 c8                	add    %ecx,%eax
    1608:	83 e8 30             	sub    $0x30,%eax
    160b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    160e:	8b 45 08             	mov    0x8(%ebp),%eax
    1611:	0f b6 00             	movzbl (%eax),%eax
    1614:	3c 2f                	cmp    $0x2f,%al
    1616:	7e 0a                	jle    1622 <atoi+0x48>
    1618:	8b 45 08             	mov    0x8(%ebp),%eax
    161b:	0f b6 00             	movzbl (%eax),%eax
    161e:	3c 39                	cmp    $0x39,%al
    1620:	7e c7                	jle    15e9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1622:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1625:	c9                   	leave  
    1626:	c3                   	ret    

00001627 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1627:	55                   	push   %ebp
    1628:	89 e5                	mov    %esp,%ebp
    162a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    162d:	8b 45 08             	mov    0x8(%ebp),%eax
    1630:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1633:	8b 45 0c             	mov    0xc(%ebp),%eax
    1636:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1639:	eb 17                	jmp    1652 <memmove+0x2b>
    *dst++ = *src++;
    163b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163e:	8d 50 01             	lea    0x1(%eax),%edx
    1641:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1644:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1647:	8d 4a 01             	lea    0x1(%edx),%ecx
    164a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    164d:	0f b6 12             	movzbl (%edx),%edx
    1650:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1652:	8b 45 10             	mov    0x10(%ebp),%eax
    1655:	8d 50 ff             	lea    -0x1(%eax),%edx
    1658:	89 55 10             	mov    %edx,0x10(%ebp)
    165b:	85 c0                	test   %eax,%eax
    165d:	7f dc                	jg     163b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1662:	c9                   	leave  
    1663:	c3                   	ret    

00001664 <fork>:
    1664:	b8 01 00 00 00       	mov    $0x1,%eax
    1669:	cd 40                	int    $0x40
    166b:	c3                   	ret    

0000166c <exit>:
    166c:	b8 02 00 00 00       	mov    $0x2,%eax
    1671:	cd 40                	int    $0x40
    1673:	c3                   	ret    

00001674 <wait>:
    1674:	b8 03 00 00 00       	mov    $0x3,%eax
    1679:	cd 40                	int    $0x40
    167b:	c3                   	ret    

0000167c <pipe>:
    167c:	b8 04 00 00 00       	mov    $0x4,%eax
    1681:	cd 40                	int    $0x40
    1683:	c3                   	ret    

00001684 <read>:
    1684:	b8 05 00 00 00       	mov    $0x5,%eax
    1689:	cd 40                	int    $0x40
    168b:	c3                   	ret    

0000168c <write>:
    168c:	b8 10 00 00 00       	mov    $0x10,%eax
    1691:	cd 40                	int    $0x40
    1693:	c3                   	ret    

00001694 <close>:
    1694:	b8 15 00 00 00       	mov    $0x15,%eax
    1699:	cd 40                	int    $0x40
    169b:	c3                   	ret    

0000169c <kill>:
    169c:	b8 06 00 00 00       	mov    $0x6,%eax
    16a1:	cd 40                	int    $0x40
    16a3:	c3                   	ret    

000016a4 <exec>:
    16a4:	b8 07 00 00 00       	mov    $0x7,%eax
    16a9:	cd 40                	int    $0x40
    16ab:	c3                   	ret    

000016ac <open>:
    16ac:	b8 0f 00 00 00       	mov    $0xf,%eax
    16b1:	cd 40                	int    $0x40
    16b3:	c3                   	ret    

000016b4 <mknod>:
    16b4:	b8 11 00 00 00       	mov    $0x11,%eax
    16b9:	cd 40                	int    $0x40
    16bb:	c3                   	ret    

000016bc <unlink>:
    16bc:	b8 12 00 00 00       	mov    $0x12,%eax
    16c1:	cd 40                	int    $0x40
    16c3:	c3                   	ret    

000016c4 <fstat>:
    16c4:	b8 08 00 00 00       	mov    $0x8,%eax
    16c9:	cd 40                	int    $0x40
    16cb:	c3                   	ret    

000016cc <link>:
    16cc:	b8 13 00 00 00       	mov    $0x13,%eax
    16d1:	cd 40                	int    $0x40
    16d3:	c3                   	ret    

000016d4 <mkdir>:
    16d4:	b8 14 00 00 00       	mov    $0x14,%eax
    16d9:	cd 40                	int    $0x40
    16db:	c3                   	ret    

000016dc <chdir>:
    16dc:	b8 09 00 00 00       	mov    $0x9,%eax
    16e1:	cd 40                	int    $0x40
    16e3:	c3                   	ret    

000016e4 <dup>:
    16e4:	b8 0a 00 00 00       	mov    $0xa,%eax
    16e9:	cd 40                	int    $0x40
    16eb:	c3                   	ret    

000016ec <getpid>:
    16ec:	b8 0b 00 00 00       	mov    $0xb,%eax
    16f1:	cd 40                	int    $0x40
    16f3:	c3                   	ret    

000016f4 <sbrk>:
    16f4:	b8 0c 00 00 00       	mov    $0xc,%eax
    16f9:	cd 40                	int    $0x40
    16fb:	c3                   	ret    

000016fc <sleep>:
    16fc:	b8 0d 00 00 00       	mov    $0xd,%eax
    1701:	cd 40                	int    $0x40
    1703:	c3                   	ret    

00001704 <uptime>:
    1704:	b8 0e 00 00 00       	mov    $0xe,%eax
    1709:	cd 40                	int    $0x40
    170b:	c3                   	ret    

0000170c <clone>:
    170c:	b8 16 00 00 00       	mov    $0x16,%eax
    1711:	cd 40                	int    $0x40
    1713:	c3                   	ret    

00001714 <texit>:
    1714:	b8 17 00 00 00       	mov    $0x17,%eax
    1719:	cd 40                	int    $0x40
    171b:	c3                   	ret    

0000171c <tsleep>:
    171c:	b8 18 00 00 00       	mov    $0x18,%eax
    1721:	cd 40                	int    $0x40
    1723:	c3                   	ret    

00001724 <twakeup>:
    1724:	b8 19 00 00 00       	mov    $0x19,%eax
    1729:	cd 40                	int    $0x40
    172b:	c3                   	ret    

0000172c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    172c:	55                   	push   %ebp
    172d:	89 e5                	mov    %esp,%ebp
    172f:	83 ec 18             	sub    $0x18,%esp
    1732:	8b 45 0c             	mov    0xc(%ebp),%eax
    1735:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1738:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    173f:	00 
    1740:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1743:	89 44 24 04          	mov    %eax,0x4(%esp)
    1747:	8b 45 08             	mov    0x8(%ebp),%eax
    174a:	89 04 24             	mov    %eax,(%esp)
    174d:	e8 3a ff ff ff       	call   168c <write>
}
    1752:	c9                   	leave  
    1753:	c3                   	ret    

00001754 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1754:	55                   	push   %ebp
    1755:	89 e5                	mov    %esp,%ebp
    1757:	56                   	push   %esi
    1758:	53                   	push   %ebx
    1759:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    175c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1763:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1767:	74 17                	je     1780 <printint+0x2c>
    1769:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    176d:	79 11                	jns    1780 <printint+0x2c>
    neg = 1;
    176f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1776:	8b 45 0c             	mov    0xc(%ebp),%eax
    1779:	f7 d8                	neg    %eax
    177b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    177e:	eb 06                	jmp    1786 <printint+0x32>
  } else {
    x = xx;
    1780:	8b 45 0c             	mov    0xc(%ebp),%eax
    1783:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1786:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    178d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1790:	8d 41 01             	lea    0x1(%ecx),%eax
    1793:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1796:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1799:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179c:	ba 00 00 00 00       	mov    $0x0,%edx
    17a1:	f7 f3                	div    %ebx
    17a3:	89 d0                	mov    %edx,%eax
    17a5:	0f b6 80 c8 22 00 00 	movzbl 0x22c8(%eax),%eax
    17ac:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    17b0:	8b 75 10             	mov    0x10(%ebp),%esi
    17b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b6:	ba 00 00 00 00       	mov    $0x0,%edx
    17bb:	f7 f6                	div    %esi
    17bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17c4:	75 c7                	jne    178d <printint+0x39>
  if(neg)
    17c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17ca:	74 10                	je     17dc <printint+0x88>
    buf[i++] = '-';
    17cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cf:	8d 50 01             	lea    0x1(%eax),%edx
    17d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    17d5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    17da:	eb 1f                	jmp    17fb <printint+0xa7>
    17dc:	eb 1d                	jmp    17fb <printint+0xa7>
    putc(fd, buf[i]);
    17de:	8d 55 dc             	lea    -0x24(%ebp),%edx
    17e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e4:	01 d0                	add    %edx,%eax
    17e6:	0f b6 00             	movzbl (%eax),%eax
    17e9:	0f be c0             	movsbl %al,%eax
    17ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f0:	8b 45 08             	mov    0x8(%ebp),%eax
    17f3:	89 04 24             	mov    %eax,(%esp)
    17f6:	e8 31 ff ff ff       	call   172c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    17fb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    17ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1803:	79 d9                	jns    17de <printint+0x8a>
    putc(fd, buf[i]);
}
    1805:	83 c4 30             	add    $0x30,%esp
    1808:	5b                   	pop    %ebx
    1809:	5e                   	pop    %esi
    180a:	5d                   	pop    %ebp
    180b:	c3                   	ret    

0000180c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    180c:	55                   	push   %ebp
    180d:	89 e5                	mov    %esp,%ebp
    180f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1812:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1819:	8d 45 0c             	lea    0xc(%ebp),%eax
    181c:	83 c0 04             	add    $0x4,%eax
    181f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1822:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1829:	e9 7c 01 00 00       	jmp    19aa <printf+0x19e>
    c = fmt[i] & 0xff;
    182e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1831:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1834:	01 d0                	add    %edx,%eax
    1836:	0f b6 00             	movzbl (%eax),%eax
    1839:	0f be c0             	movsbl %al,%eax
    183c:	25 ff 00 00 00       	and    $0xff,%eax
    1841:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1844:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1848:	75 2c                	jne    1876 <printf+0x6a>
      if(c == '%'){
    184a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    184e:	75 0c                	jne    185c <printf+0x50>
        state = '%';
    1850:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1857:	e9 4a 01 00 00       	jmp    19a6 <printf+0x19a>
      } else {
        putc(fd, c);
    185c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    185f:	0f be c0             	movsbl %al,%eax
    1862:	89 44 24 04          	mov    %eax,0x4(%esp)
    1866:	8b 45 08             	mov    0x8(%ebp),%eax
    1869:	89 04 24             	mov    %eax,(%esp)
    186c:	e8 bb fe ff ff       	call   172c <putc>
    1871:	e9 30 01 00 00       	jmp    19a6 <printf+0x19a>
      }
    } else if(state == '%'){
    1876:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    187a:	0f 85 26 01 00 00    	jne    19a6 <printf+0x19a>
      if(c == 'd'){
    1880:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1884:	75 2d                	jne    18b3 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1886:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1889:	8b 00                	mov    (%eax),%eax
    188b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1892:	00 
    1893:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    189a:	00 
    189b:	89 44 24 04          	mov    %eax,0x4(%esp)
    189f:	8b 45 08             	mov    0x8(%ebp),%eax
    18a2:	89 04 24             	mov    %eax,(%esp)
    18a5:	e8 aa fe ff ff       	call   1754 <printint>
        ap++;
    18aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18ae:	e9 ec 00 00 00       	jmp    199f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    18b3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    18b7:	74 06                	je     18bf <printf+0xb3>
    18b9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    18bd:	75 2d                	jne    18ec <printf+0xe0>
        printint(fd, *ap, 16, 0);
    18bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18c2:	8b 00                	mov    (%eax),%eax
    18c4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    18cb:	00 
    18cc:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    18d3:	00 
    18d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    18d8:	8b 45 08             	mov    0x8(%ebp),%eax
    18db:	89 04 24             	mov    %eax,(%esp)
    18de:	e8 71 fe ff ff       	call   1754 <printint>
        ap++;
    18e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18e7:	e9 b3 00 00 00       	jmp    199f <printf+0x193>
      } else if(c == 's'){
    18ec:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    18f0:	75 45                	jne    1937 <printf+0x12b>
        s = (char*)*ap;
    18f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18f5:	8b 00                	mov    (%eax),%eax
    18f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    18fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    18fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1902:	75 09                	jne    190d <printf+0x101>
          s = "(null)";
    1904:	c7 45 f4 23 1f 00 00 	movl   $0x1f23,-0xc(%ebp)
        while(*s != 0){
    190b:	eb 1e                	jmp    192b <printf+0x11f>
    190d:	eb 1c                	jmp    192b <printf+0x11f>
          putc(fd, *s);
    190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1912:	0f b6 00             	movzbl (%eax),%eax
    1915:	0f be c0             	movsbl %al,%eax
    1918:	89 44 24 04          	mov    %eax,0x4(%esp)
    191c:	8b 45 08             	mov    0x8(%ebp),%eax
    191f:	89 04 24             	mov    %eax,(%esp)
    1922:	e8 05 fe ff ff       	call   172c <putc>
          s++;
    1927:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192e:	0f b6 00             	movzbl (%eax),%eax
    1931:	84 c0                	test   %al,%al
    1933:	75 da                	jne    190f <printf+0x103>
    1935:	eb 68                	jmp    199f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1937:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    193b:	75 1d                	jne    195a <printf+0x14e>
        putc(fd, *ap);
    193d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1940:	8b 00                	mov    (%eax),%eax
    1942:	0f be c0             	movsbl %al,%eax
    1945:	89 44 24 04          	mov    %eax,0x4(%esp)
    1949:	8b 45 08             	mov    0x8(%ebp),%eax
    194c:	89 04 24             	mov    %eax,(%esp)
    194f:	e8 d8 fd ff ff       	call   172c <putc>
        ap++;
    1954:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1958:	eb 45                	jmp    199f <printf+0x193>
      } else if(c == '%'){
    195a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    195e:	75 17                	jne    1977 <printf+0x16b>
        putc(fd, c);
    1960:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1963:	0f be c0             	movsbl %al,%eax
    1966:	89 44 24 04          	mov    %eax,0x4(%esp)
    196a:	8b 45 08             	mov    0x8(%ebp),%eax
    196d:	89 04 24             	mov    %eax,(%esp)
    1970:	e8 b7 fd ff ff       	call   172c <putc>
    1975:	eb 28                	jmp    199f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1977:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    197e:	00 
    197f:	8b 45 08             	mov    0x8(%ebp),%eax
    1982:	89 04 24             	mov    %eax,(%esp)
    1985:	e8 a2 fd ff ff       	call   172c <putc>
        putc(fd, c);
    198a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    198d:	0f be c0             	movsbl %al,%eax
    1990:	89 44 24 04          	mov    %eax,0x4(%esp)
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	89 04 24             	mov    %eax,(%esp)
    199a:	e8 8d fd ff ff       	call   172c <putc>
      }
      state = 0;
    199f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    19a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    19aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    19ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b0:	01 d0                	add    %edx,%eax
    19b2:	0f b6 00             	movzbl (%eax),%eax
    19b5:	84 c0                	test   %al,%al
    19b7:	0f 85 71 fe ff ff    	jne    182e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    19bd:	c9                   	leave  
    19be:	c3                   	ret    
    19bf:	90                   	nop

000019c0 <free>:
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    19c3:	83 ec 10             	sub    $0x10,%esp
    19c6:	8b 45 08             	mov    0x8(%ebp),%eax
    19c9:	83 e8 08             	sub    $0x8,%eax
    19cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
    19cf:	a1 f4 22 00 00       	mov    0x22f4,%eax
    19d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19d7:	eb 24                	jmp    19fd <free+0x3d>
    19d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19dc:	8b 00                	mov    (%eax),%eax
    19de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19e1:	77 12                	ja     19f5 <free+0x35>
    19e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19e9:	77 24                	ja     1a0f <free+0x4f>
    19eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ee:	8b 00                	mov    (%eax),%eax
    19f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19f3:	77 1a                	ja     1a0f <free+0x4f>
    19f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f8:	8b 00                	mov    (%eax),%eax
    19fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a00:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a03:	76 d4                	jbe    19d9 <free+0x19>
    1a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a08:	8b 00                	mov    (%eax),%eax
    1a0a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a0d:	76 ca                	jbe    19d9 <free+0x19>
    1a0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a12:	8b 40 04             	mov    0x4(%eax),%eax
    1a15:	c1 e0 03             	shl    $0x3,%eax
    1a18:	89 c2                	mov    %eax,%edx
    1a1a:	03 55 f8             	add    -0x8(%ebp),%edx
    1a1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a20:	8b 00                	mov    (%eax),%eax
    1a22:	39 c2                	cmp    %eax,%edx
    1a24:	75 24                	jne    1a4a <free+0x8a>
    1a26:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a29:	8b 50 04             	mov    0x4(%eax),%edx
    1a2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a2f:	8b 00                	mov    (%eax),%eax
    1a31:	8b 40 04             	mov    0x4(%eax),%eax
    1a34:	01 c2                	add    %eax,%edx
    1a36:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a39:	89 50 04             	mov    %edx,0x4(%eax)
    1a3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a3f:	8b 00                	mov    (%eax),%eax
    1a41:	8b 10                	mov    (%eax),%edx
    1a43:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a46:	89 10                	mov    %edx,(%eax)
    1a48:	eb 0a                	jmp    1a54 <free+0x94>
    1a4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a4d:	8b 10                	mov    (%eax),%edx
    1a4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a52:	89 10                	mov    %edx,(%eax)
    1a54:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a57:	8b 40 04             	mov    0x4(%eax),%eax
    1a5a:	c1 e0 03             	shl    $0x3,%eax
    1a5d:	03 45 fc             	add    -0x4(%ebp),%eax
    1a60:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a63:	75 20                	jne    1a85 <free+0xc5>
    1a65:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a68:	8b 50 04             	mov    0x4(%eax),%edx
    1a6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a6e:	8b 40 04             	mov    0x4(%eax),%eax
    1a71:	01 c2                	add    %eax,%edx
    1a73:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a76:	89 50 04             	mov    %edx,0x4(%eax)
    1a79:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a7c:	8b 10                	mov    (%eax),%edx
    1a7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a81:	89 10                	mov    %edx,(%eax)
    1a83:	eb 08                	jmp    1a8d <free+0xcd>
    1a85:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a88:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a8b:	89 10                	mov    %edx,(%eax)
    1a8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a90:	a3 f4 22 00 00       	mov    %eax,0x22f4
    1a95:	c9                   	leave  
    1a96:	c3                   	ret    

00001a97 <morecore>:
    1a97:	55                   	push   %ebp
    1a98:	89 e5                	mov    %esp,%ebp
    1a9a:	83 ec 28             	sub    $0x28,%esp
    1a9d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1aa4:	77 07                	ja     1aad <morecore+0x16>
    1aa6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1aad:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab0:	c1 e0 03             	shl    $0x3,%eax
    1ab3:	89 04 24             	mov    %eax,(%esp)
    1ab6:	e8 39 fc ff ff       	call   16f4 <sbrk>
    1abb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1abe:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1ac2:	75 07                	jne    1acb <morecore+0x34>
    1ac4:	b8 00 00 00 00       	mov    $0x0,%eax
    1ac9:	eb 22                	jmp    1aed <morecore+0x56>
    1acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ace:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad4:	8b 55 08             	mov    0x8(%ebp),%edx
    1ad7:	89 50 04             	mov    %edx,0x4(%eax)
    1ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1add:	83 c0 08             	add    $0x8,%eax
    1ae0:	89 04 24             	mov    %eax,(%esp)
    1ae3:	e8 d8 fe ff ff       	call   19c0 <free>
    1ae8:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1aed:	c9                   	leave  
    1aee:	c3                   	ret    

00001aef <malloc>:
    1aef:	55                   	push   %ebp
    1af0:	89 e5                	mov    %esp,%ebp
    1af2:	83 ec 28             	sub    $0x28,%esp
    1af5:	8b 45 08             	mov    0x8(%ebp),%eax
    1af8:	83 c0 07             	add    $0x7,%eax
    1afb:	c1 e8 03             	shr    $0x3,%eax
    1afe:	83 c0 01             	add    $0x1,%eax
    1b01:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b04:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1b09:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b10:	75 23                	jne    1b35 <malloc+0x46>
    1b12:	c7 45 f0 ec 22 00 00 	movl   $0x22ec,-0x10(%ebp)
    1b19:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b1c:	a3 f4 22 00 00       	mov    %eax,0x22f4
    1b21:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1b26:	a3 ec 22 00 00       	mov    %eax,0x22ec
    1b2b:	c7 05 f0 22 00 00 00 	movl   $0x0,0x22f0
    1b32:	00 00 00 
    1b35:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b38:	8b 00                	mov    (%eax),%eax
    1b3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b40:	8b 40 04             	mov    0x4(%eax),%eax
    1b43:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1b46:	72 4d                	jb     1b95 <malloc+0xa6>
    1b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b4b:	8b 40 04             	mov    0x4(%eax),%eax
    1b4e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1b51:	75 0c                	jne    1b5f <malloc+0x70>
    1b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b56:	8b 10                	mov    (%eax),%edx
    1b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b5b:	89 10                	mov    %edx,(%eax)
    1b5d:	eb 26                	jmp    1b85 <malloc+0x96>
    1b5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b62:	8b 40 04             	mov    0x4(%eax),%eax
    1b65:	89 c2                	mov    %eax,%edx
    1b67:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1b6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b6d:	89 50 04             	mov    %edx,0x4(%eax)
    1b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b73:	8b 40 04             	mov    0x4(%eax),%eax
    1b76:	c1 e0 03             	shl    $0x3,%eax
    1b79:	01 45 ec             	add    %eax,-0x14(%ebp)
    1b7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b82:	89 50 04             	mov    %edx,0x4(%eax)
    1b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b88:	a3 f4 22 00 00       	mov    %eax,0x22f4
    1b8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b90:	83 c0 08             	add    $0x8,%eax
    1b93:	eb 38                	jmp    1bcd <malloc+0xde>
    1b95:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1b9a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1b9d:	75 1b                	jne    1bba <malloc+0xcb>
    1b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba2:	89 04 24             	mov    %eax,(%esp)
    1ba5:	e8 ed fe ff ff       	call   1a97 <morecore>
    1baa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1bad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bb1:	75 07                	jne    1bba <malloc+0xcb>
    1bb3:	b8 00 00 00 00       	mov    $0x0,%eax
    1bb8:	eb 13                	jmp    1bcd <malloc+0xde>
    1bba:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bc0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bc3:	8b 00                	mov    (%eax),%eax
    1bc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1bc8:	e9 70 ff ff ff       	jmp    1b3d <malloc+0x4e>
    1bcd:	c9                   	leave  
    1bce:	c3                   	ret    
    1bcf:	90                   	nop

00001bd0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1bd6:	8b 55 08             	mov    0x8(%ebp),%edx
    1bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bdc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bdf:	f0 87 02             	lock xchg %eax,(%edx)
    1be2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1be5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1be8:	c9                   	leave  
    1be9:	c3                   	ret    

00001bea <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1bea:	55                   	push   %ebp
    1beb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1bed:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1bf6:	5d                   	pop    %ebp
    1bf7:	c3                   	ret    

00001bf8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1bf8:	55                   	push   %ebp
    1bf9:	89 e5                	mov    %esp,%ebp
    1bfb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1bfe:	90                   	nop
    1bff:	8b 45 08             	mov    0x8(%ebp),%eax
    1c02:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1c09:	00 
    1c0a:	89 04 24             	mov    %eax,(%esp)
    1c0d:	e8 be ff ff ff       	call   1bd0 <xchg>
    1c12:	85 c0                	test   %eax,%eax
    1c14:	75 e9                	jne    1bff <lock_acquire+0x7>
}
    1c16:	c9                   	leave  
    1c17:	c3                   	ret    

00001c18 <lock_release>:
void lock_release(lock_t *lock){
    1c18:	55                   	push   %ebp
    1c19:	89 e5                	mov    %esp,%ebp
    1c1b:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1c1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c21:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c28:	00 
    1c29:	89 04 24             	mov    %eax,(%esp)
    1c2c:	e8 9f ff ff ff       	call   1bd0 <xchg>
}
    1c31:	c9                   	leave  
    1c32:	c3                   	ret    

00001c33 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1c33:	55                   	push   %ebp
    1c34:	89 e5                	mov    %esp,%ebp
    1c36:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1c39:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1c40:	e8 aa fe ff ff       	call   1aef <malloc>
    1c45:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c51:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c56:	85 c0                	test   %eax,%eax
    1c58:	74 14                	je     1c6e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c62:	89 c2                	mov    %eax,%edx
    1c64:	b8 00 10 00 00       	mov    $0x1000,%eax
    1c69:	29 d0                	sub    %edx,%eax
    1c6b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1c6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c72:	75 1b                	jne    1c8f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1c74:	c7 44 24 04 2a 1f 00 	movl   $0x1f2a,0x4(%esp)
    1c7b:	00 
    1c7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c83:	e8 84 fb ff ff       	call   180c <printf>
        return 0;
    1c88:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8d:	eb 6f                	jmp    1cfe <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1c8f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c92:	8b 55 08             	mov    0x8(%ebp),%edx
    1c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c98:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1c9c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1ca0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1ca7:	00 
    1ca8:	89 04 24             	mov    %eax,(%esp)
    1cab:	e8 5c fa ff ff       	call   170c <clone>
    1cb0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1cb3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cb7:	79 1b                	jns    1cd4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1cb9:	c7 44 24 04 38 1f 00 	movl   $0x1f38,0x4(%esp)
    1cc0:	00 
    1cc1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cc8:	e8 3f fb ff ff       	call   180c <printf>
        return 0;
    1ccd:	b8 00 00 00 00       	mov    $0x0,%eax
    1cd2:	eb 2a                	jmp    1cfe <thread_create+0xcb>
    }
    if(tid > 0){
    1cd4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cd8:	7e 05                	jle    1cdf <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1cda:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cdd:	eb 1f                	jmp    1cfe <thread_create+0xcb>
    }
    if(tid == 0){
    1cdf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ce3:	75 14                	jne    1cf9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1ce5:	c7 44 24 04 45 1f 00 	movl   $0x1f45,0x4(%esp)
    1cec:	00 
    1ced:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cf4:	e8 13 fb ff ff       	call   180c <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1cf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1cfe:	c9                   	leave  
    1cff:	c3                   	ret    

00001d00 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1d03:	a1 dc 22 00 00       	mov    0x22dc,%eax
    1d08:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1d0e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1d13:	a3 dc 22 00 00       	mov    %eax,0x22dc
    return (int)(rands % max);
    1d18:	a1 dc 22 00 00       	mov    0x22dc,%eax
    1d1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d20:	ba 00 00 00 00       	mov    $0x0,%edx
    1d25:	f7 f1                	div    %ecx
    1d27:	89 d0                	mov    %edx,%eax
}
    1d29:	5d                   	pop    %ebp
    1d2a:	c3                   	ret    
    1d2b:	90                   	nop

00001d2c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1d2c:	55                   	push   %ebp
    1d2d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1d2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1d38:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1d42:	8b 45 08             	mov    0x8(%ebp),%eax
    1d45:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1d4c:	5d                   	pop    %ebp
    1d4d:	c3                   	ret    

00001d4e <add_q>:

void add_q(struct queue *q, int v){
    1d4e:	55                   	push   %ebp
    1d4f:	89 e5                	mov    %esp,%ebp
    1d51:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1d54:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d5b:	e8 8f fd ff ff       	call   1aef <malloc>
    1d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d66:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d70:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d73:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d75:	8b 45 08             	mov    0x8(%ebp),%eax
    1d78:	8b 40 04             	mov    0x4(%eax),%eax
    1d7b:	85 c0                	test   %eax,%eax
    1d7d:	75 0b                	jne    1d8a <add_q+0x3c>
        q->head = n;
    1d7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d82:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d85:	89 50 04             	mov    %edx,0x4(%eax)
    1d88:	eb 0c                	jmp    1d96 <add_q+0x48>
    }else{
        q->tail->next = n;
    1d8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8d:	8b 40 08             	mov    0x8(%eax),%eax
    1d90:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d93:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1d96:	8b 45 08             	mov    0x8(%ebp),%eax
    1d99:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d9c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1d9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1da2:	8b 00                	mov    (%eax),%eax
    1da4:	8d 50 01             	lea    0x1(%eax),%edx
    1da7:	8b 45 08             	mov    0x8(%ebp),%eax
    1daa:	89 10                	mov    %edx,(%eax)
}
    1dac:	c9                   	leave  
    1dad:	c3                   	ret    

00001dae <empty_q>:

int empty_q(struct queue *q){
    1dae:	55                   	push   %ebp
    1daf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1db1:	8b 45 08             	mov    0x8(%ebp),%eax
    1db4:	8b 00                	mov    (%eax),%eax
    1db6:	85 c0                	test   %eax,%eax
    1db8:	75 07                	jne    1dc1 <empty_q+0x13>
        return 1;
    1dba:	b8 01 00 00 00       	mov    $0x1,%eax
    1dbf:	eb 05                	jmp    1dc6 <empty_q+0x18>
    else
        return 0;
    1dc1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1dc6:	5d                   	pop    %ebp
    1dc7:	c3                   	ret    

00001dc8 <pop_q>:
int pop_q(struct queue *q){
    1dc8:	55                   	push   %ebp
    1dc9:	89 e5                	mov    %esp,%ebp
    1dcb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1dce:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd1:	89 04 24             	mov    %eax,(%esp)
    1dd4:	e8 d5 ff ff ff       	call   1dae <empty_q>
    1dd9:	85 c0                	test   %eax,%eax
    1ddb:	75 5d                	jne    1e3a <pop_q+0x72>
       val = q->head->value; 
    1ddd:	8b 45 08             	mov    0x8(%ebp),%eax
    1de0:	8b 40 04             	mov    0x4(%eax),%eax
    1de3:	8b 00                	mov    (%eax),%eax
    1de5:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1de8:	8b 45 08             	mov    0x8(%ebp),%eax
    1deb:	8b 40 04             	mov    0x4(%eax),%eax
    1dee:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1df1:	8b 45 08             	mov    0x8(%ebp),%eax
    1df4:	8b 40 04             	mov    0x4(%eax),%eax
    1df7:	8b 50 04             	mov    0x4(%eax),%edx
    1dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1e00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e03:	89 04 24             	mov    %eax,(%esp)
    1e06:	e8 b5 fb ff ff       	call   19c0 <free>
       q->size--;
    1e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0e:	8b 00                	mov    (%eax),%eax
    1e10:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e13:	8b 45 08             	mov    0x8(%ebp),%eax
    1e16:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1e18:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1b:	8b 00                	mov    (%eax),%eax
    1e1d:	85 c0                	test   %eax,%eax
    1e1f:	75 14                	jne    1e35 <pop_q+0x6d>
            q->head = 0;
    1e21:	8b 45 08             	mov    0x8(%ebp),%eax
    1e24:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1e2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e38:	eb 05                	jmp    1e3f <pop_q+0x77>
    }
    return -1;
    1e3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e3f:	c9                   	leave  
    1e40:	c3                   	ret    
