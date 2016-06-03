
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
    101a:	c7 44 24 04 58 1e 00 	movl   $0x1e58,0x4(%esp)
    1021:	00 
    1022:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1029:	e8 e6 07 00 00       	call   1814 <printf>
        exit();
    102e:	e8 39 06 00 00       	call   166c <exit>
    }
    numthreads = atoi(argv[1]);
    1033:	8b 43 04             	mov    0x4(%ebx),%eax
    1036:	83 c0 04             	add    $0x4,%eax
    1039:	8b 00                	mov    (%eax),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 97 05 00 00       	call   15da <atoi>
    1043:	a3 60 23 00 00       	mov    %eax,0x2360
    numpass = atoi(argv[2]);
    1048:	8b 43 04             	mov    0x4(%ebx),%eax
    104b:	83 c0 08             	add    $0x8,%eax
    104e:	8b 00                	mov    (%eax),%eax
    1050:	89 04 24             	mov    %eax,(%esp)
    1053:	e8 82 05 00 00       	call   15da <atoi>
    1058:	a3 64 23 00 00       	mov    %eax,0x2364

    void * slist[numthreads];
    105d:	a1 60 23 00 00       	mov    0x2360,%eax
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
    1099:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    10a0:	e8 59 0b 00 00       	call   1bfe <lock_init>
    ttable.total = 0;
    10a5:	c7 05 84 25 00 00 00 	movl   $0x0,0x2584
    10ac:	00 00 00 
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    10af:	c7 45 e0 84 23 00 00 	movl   $0x2384,-0x20(%ebp)
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
    10c5:	81 7d e0 84 25 00 00 	cmpl   $0x2584,-0x20(%ebp)
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
    10ee:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    10f5:	e8 04 0b 00 00       	call   1bfe <lock_init>
    frisbee.pass = 0;
    10fa:	c7 05 8c 25 00 00 00 	movl   $0x0,0x258c
    1101:	00 00 00 
    frisbee.holding_thread = 0;
    1104:	c7 05 90 25 00 00 00 	movl   $0x0,0x2590
    110b:	00 00 00 

    printf(1,"\nnum of threads %d \n",numthreads);
    110e:	a1 60 23 00 00       	mov    0x2360,%eax
    1113:	89 44 24 08          	mov    %eax,0x8(%esp)
    1117:	c7 44 24 04 6d 1e 00 	movl   $0x1e6d,0x4(%esp)
    111e:	00 
    111f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1126:	e8 e9 06 00 00       	call   1814 <printf>
    printf(1,"num of passes %d \n\n",numpass);
    112b:	a1 64 23 00 00       	mov    0x2364,%eax
    1130:	89 44 24 08          	mov    %eax,0x8(%esp)
    1134:	c7 44 24 04 82 1e 00 	movl   $0x1e82,0x4(%esp)
    113b:	00 
    113c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1143:	e8 cc 06 00 00       	call   1814 <printf>


    for(i=0; i<numthreads;i++){
    1148:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    114f:	eb 43                	jmp    1194 <main+0x194>
        void *stack = thread_create(pass_next,(void *)0);      
    1151:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1158:	00 
    1159:	c7 04 24 3d 12 00 00 	movl   $0x123d,(%esp)
    1160:	e8 e2 0a 00 00       	call   1c47 <thread_create>
    1165:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(stack == 0)
    1168:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    116c:	75 16                	jne    1184 <main+0x184>
            printf(1,"thread_create fail\n");
    116e:	c7 44 24 04 96 1e 00 	movl   $0x1e96,0x4(%esp)
    1175:	00 
    1176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    117d:	e8 92 06 00 00       	call   1814 <printf>
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
    1194:	a1 60 23 00 00       	mov    0x2360,%eax
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
    11b7:	a1 60 23 00 00       	mov    0x2360,%eax
    11bc:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    11bf:	7c e6                	jl     11a7 <main+0x1a7>
        if(wait() == -1)
            break;
    }
   // add printf for tid look up.  
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    11c1:	c7 45 e0 84 23 00 00 	movl   $0x2384,-0x20(%ebp)
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
    11dc:	c7 44 24 04 ac 1e 00 	movl   $0x1eac,0x4(%esp)
    11e3:	00 
    11e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11eb:	e8 24 06 00 00       	call   1814 <printf>
    for(i=0;i<numthreads;i++){
        if(wait() == -1)
            break;
    }
   // add printf for tid look up.  
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    11f0:	83 45 e0 08          	addl   $0x8,-0x20(%ebp)
    11f4:	81 7d e0 84 25 00 00 	cmpl   $0x2584,-0x20(%ebp)
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
    1225:	e8 9e 07 00 00       	call   19c8 <free>
        if(t->tid != 0)
            printf(1,"thread %d was killed! stack was freed.\n",t->tid);
    }

    //free stacks
    for(i=0;i<numthreads;i++){
    122a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    122e:	a1 60 23 00 00       	mov    0x2360,%eax
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
    124b:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    1252:	e8 b5 09 00 00       	call   1c0c <lock_acquire>
    for(t=ttable.thread;t < &ttable.thread[64];t++){
    1257:	c7 45 f4 84 23 00 00 	movl   $0x2384,-0xc(%ebp)
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
    1277:	81 7d f4 84 25 00 00 	cmpl   $0x2584,-0xc(%ebp)
    127e:	72 e0                	jb     1260 <pass_next+0x23>
        if(t->tid == 0){
            t->tid = tid;
            break;
        } 
    }
    ttable.total++;
    1280:	a1 84 25 00 00       	mov    0x2584,%eax
    1285:	83 c0 01             	add    $0x1,%eax
    1288:	a3 84 25 00 00       	mov    %eax,0x2584
    lock_release(&ttable.lock);
    128d:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    1294:	e8 93 09 00 00       	call   1c2c <lock_release>

   for(;;){
        lock_acquire(&ttable.lock);
    1299:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    12a0:	e8 67 09 00 00       	call   1c0c <lock_acquire>
        if(ttable.total == numthreads){
    12a5:	8b 15 84 25 00 00    	mov    0x2584,%edx
    12ab:	a1 60 23 00 00       	mov    0x2360,%eax
    12b0:	39 c2                	cmp    %eax,%edx
    12b2:	75 39                	jne    12ed <pass_next+0xb0>
            printf(1," tid %d ready to go\n",t->tid);
    12b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b7:	8b 00                	mov    (%eax),%eax
    12b9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12bd:	c7 44 24 04 d4 1e 00 	movl   $0x1ed4,0x4(%esp)
    12c4:	00 
    12c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12cc:	e8 43 05 00 00       	call   1814 <printf>
            barrier++;
    12d1:	a1 68 23 00 00       	mov    0x2368,%eax
    12d6:	83 c0 01             	add    $0x1,%eax
    12d9:	a3 68 23 00 00       	mov    %eax,0x2368
            goto start;
    12de:	90                   	nop
        lock_release(&ttable.lock);
    }
    
//barriar above
start:
     lock_release(&ttable.lock);
    12df:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    12e6:	e8 41 09 00 00       	call   1c2c <lock_release>
     while(barrier != numthreads);
    12eb:	eb 0e                	jmp    12fb <pass_next+0xbe>
        if(ttable.total == numthreads){
            printf(1," tid %d ready to go\n",t->tid);
            barrier++;
            goto start;
        }
        lock_release(&ttable.lock);
    12ed:	c7 04 24 80 23 00 00 	movl   $0x2380,(%esp)
    12f4:	e8 33 09 00 00       	call   1c2c <lock_release>
    }
    12f9:	eb 9e                	jmp    1299 <pass_next+0x5c>
    
//barriar above
start:
     lock_release(&ttable.lock);
     while(barrier != numthreads);
    12fb:	8b 15 68 23 00 00    	mov    0x2368,%edx
    1301:	a1 60 23 00 00       	mov    0x2360,%eax
    1306:	39 c2                	cmp    %eax,%edx
    1308:	75 f1                	jne    12fb <pass_next+0xbe>
    //throw frisbee
    do{
        lock_acquire(&frisbee.lock);
    130a:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    1311:	e8 f6 08 00 00       	call   1c0c <lock_acquire>
        if(frisbee.pass > numpass){
    1316:	8b 15 8c 25 00 00    	mov    0x258c,%edx
    131c:	a1 64 23 00 00       	mov    0x2364,%eax
    1321:	39 c2                	cmp    %eax,%edx
    1323:	7e 39                	jle    135e <pass_next+0x121>
            lock_release(&frisbee.lock);
    1325:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    132c:	e8 fb 08 00 00       	call   1c2c <lock_release>
            goto leaving;
    1331:	90                   	nop
        frisbee.holding_thread = tid;
        lock_release(&frisbee.lock);
    }while(1);

leaving: 
    lock_release(&frisbee.lock);
    1332:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    1339:	e8 ee 08 00 00       	call   1c2c <lock_release>
    printf(1,"thread %d out of game\n",tid);
    133e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1341:	89 44 24 08          	mov    %eax,0x8(%esp)
    1345:	c7 44 24 04 20 1f 00 	movl   $0x1f20,0x4(%esp)
    134c:	00 
    134d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1354:	e8 bb 04 00 00       	call   1814 <printf>
    texit();
    1359:	e8 b6 03 00 00       	call   1714 <texit>
        lock_acquire(&frisbee.lock);
        if(frisbee.pass > numpass){
            lock_release(&frisbee.lock);
            goto leaving;
        }
        if(frisbee.holding_thread == tid){
    135e:	a1 90 25 00 00       	mov    0x2590,%eax
    1363:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1366:	75 1b                	jne    1383 <pass_next+0x146>
            lock_release(&frisbee.lock);
    1368:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    136f:	e8 b8 08 00 00       	call   1c2c <lock_release>
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
    1383:	a1 8c 25 00 00       	mov    0x258c,%eax
    1388:	8b 55 f0             	mov    -0x10(%ebp),%edx
    138b:	89 54 24 0c          	mov    %edx,0xc(%esp)
    138f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1393:	c7 44 24 04 ec 1e 00 	movl   $0x1eec,0x4(%esp)
    139a:	00 
    139b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a2:	e8 6d 04 00 00       	call   1814 <printf>
                frisbee.pass, tid);
        frisbee.pass++;
    13a7:	a1 8c 25 00 00       	mov    0x258c,%eax
    13ac:	83 c0 01             	add    $0x1,%eax
    13af:	a3 8c 25 00 00       	mov    %eax,0x258c
        frisbee.holding_thread = tid;
    13b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b7:	a3 90 25 00 00       	mov    %eax,0x2590
        lock_release(&frisbee.lock);
    13bc:	c7 04 24 88 25 00 00 	movl   $0x2588,(%esp)
    13c3:	e8 64 08 00 00       	call   1c2c <lock_release>
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
    13da:	c7 45 f8 84 23 00 00 	movl   $0x2384,-0x8(%ebp)
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
    13f4:	81 7d f8 84 25 00 00 	cmpl   $0x2584,-0x8(%ebp)
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
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1664:	b8 01 00 00 00       	mov    $0x1,%eax
    1669:	cd 40                	int    $0x40
    166b:	c3                   	ret    

0000166c <exit>:
SYSCALL(exit)
    166c:	b8 02 00 00 00       	mov    $0x2,%eax
    1671:	cd 40                	int    $0x40
    1673:	c3                   	ret    

00001674 <wait>:
SYSCALL(wait)
    1674:	b8 03 00 00 00       	mov    $0x3,%eax
    1679:	cd 40                	int    $0x40
    167b:	c3                   	ret    

0000167c <pipe>:
SYSCALL(pipe)
    167c:	b8 04 00 00 00       	mov    $0x4,%eax
    1681:	cd 40                	int    $0x40
    1683:	c3                   	ret    

00001684 <read>:
SYSCALL(read)
    1684:	b8 05 00 00 00       	mov    $0x5,%eax
    1689:	cd 40                	int    $0x40
    168b:	c3                   	ret    

0000168c <write>:
SYSCALL(write)
    168c:	b8 10 00 00 00       	mov    $0x10,%eax
    1691:	cd 40                	int    $0x40
    1693:	c3                   	ret    

00001694 <close>:
SYSCALL(close)
    1694:	b8 15 00 00 00       	mov    $0x15,%eax
    1699:	cd 40                	int    $0x40
    169b:	c3                   	ret    

0000169c <kill>:
SYSCALL(kill)
    169c:	b8 06 00 00 00       	mov    $0x6,%eax
    16a1:	cd 40                	int    $0x40
    16a3:	c3                   	ret    

000016a4 <exec>:
SYSCALL(exec)
    16a4:	b8 07 00 00 00       	mov    $0x7,%eax
    16a9:	cd 40                	int    $0x40
    16ab:	c3                   	ret    

000016ac <open>:
SYSCALL(open)
    16ac:	b8 0f 00 00 00       	mov    $0xf,%eax
    16b1:	cd 40                	int    $0x40
    16b3:	c3                   	ret    

000016b4 <mknod>:
SYSCALL(mknod)
    16b4:	b8 11 00 00 00       	mov    $0x11,%eax
    16b9:	cd 40                	int    $0x40
    16bb:	c3                   	ret    

000016bc <unlink>:
SYSCALL(unlink)
    16bc:	b8 12 00 00 00       	mov    $0x12,%eax
    16c1:	cd 40                	int    $0x40
    16c3:	c3                   	ret    

000016c4 <fstat>:
SYSCALL(fstat)
    16c4:	b8 08 00 00 00       	mov    $0x8,%eax
    16c9:	cd 40                	int    $0x40
    16cb:	c3                   	ret    

000016cc <link>:
SYSCALL(link)
    16cc:	b8 13 00 00 00       	mov    $0x13,%eax
    16d1:	cd 40                	int    $0x40
    16d3:	c3                   	ret    

000016d4 <mkdir>:
SYSCALL(mkdir)
    16d4:	b8 14 00 00 00       	mov    $0x14,%eax
    16d9:	cd 40                	int    $0x40
    16db:	c3                   	ret    

000016dc <chdir>:
SYSCALL(chdir)
    16dc:	b8 09 00 00 00       	mov    $0x9,%eax
    16e1:	cd 40                	int    $0x40
    16e3:	c3                   	ret    

000016e4 <dup>:
SYSCALL(dup)
    16e4:	b8 0a 00 00 00       	mov    $0xa,%eax
    16e9:	cd 40                	int    $0x40
    16eb:	c3                   	ret    

000016ec <getpid>:
SYSCALL(getpid)
    16ec:	b8 0b 00 00 00       	mov    $0xb,%eax
    16f1:	cd 40                	int    $0x40
    16f3:	c3                   	ret    

000016f4 <sbrk>:
SYSCALL(sbrk)
    16f4:	b8 0c 00 00 00       	mov    $0xc,%eax
    16f9:	cd 40                	int    $0x40
    16fb:	c3                   	ret    

000016fc <sleep>:
SYSCALL(sleep)
    16fc:	b8 0d 00 00 00       	mov    $0xd,%eax
    1701:	cd 40                	int    $0x40
    1703:	c3                   	ret    

00001704 <uptime>:
SYSCALL(uptime)
    1704:	b8 0e 00 00 00       	mov    $0xe,%eax
    1709:	cd 40                	int    $0x40
    170b:	c3                   	ret    

0000170c <clone>:
SYSCALL(clone)
    170c:	b8 16 00 00 00       	mov    $0x16,%eax
    1711:	cd 40                	int    $0x40
    1713:	c3                   	ret    

00001714 <texit>:
SYSCALL(texit)
    1714:	b8 17 00 00 00       	mov    $0x17,%eax
    1719:	cd 40                	int    $0x40
    171b:	c3                   	ret    

0000171c <tsleep>:
SYSCALL(tsleep)
    171c:	b8 18 00 00 00       	mov    $0x18,%eax
    1721:	cd 40                	int    $0x40
    1723:	c3                   	ret    

00001724 <twakeup>:
SYSCALL(twakeup)
    1724:	b8 19 00 00 00       	mov    $0x19,%eax
    1729:	cd 40                	int    $0x40
    172b:	c3                   	ret    

0000172c <thread_yield>:
SYSCALL(thread_yield)
    172c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1731:	cd 40                	int    $0x40
    1733:	c3                   	ret    

00001734 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1734:	55                   	push   %ebp
    1735:	89 e5                	mov    %esp,%ebp
    1737:	83 ec 18             	sub    $0x18,%esp
    173a:	8b 45 0c             	mov    0xc(%ebp),%eax
    173d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1740:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1747:	00 
    1748:	8d 45 f4             	lea    -0xc(%ebp),%eax
    174b:	89 44 24 04          	mov    %eax,0x4(%esp)
    174f:	8b 45 08             	mov    0x8(%ebp),%eax
    1752:	89 04 24             	mov    %eax,(%esp)
    1755:	e8 32 ff ff ff       	call   168c <write>
}
    175a:	c9                   	leave  
    175b:	c3                   	ret    

0000175c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    175c:	55                   	push   %ebp
    175d:	89 e5                	mov    %esp,%ebp
    175f:	56                   	push   %esi
    1760:	53                   	push   %ebx
    1761:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1764:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    176b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    176f:	74 17                	je     1788 <printint+0x2c>
    1771:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1775:	79 11                	jns    1788 <printint+0x2c>
    neg = 1;
    1777:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    177e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1781:	f7 d8                	neg    %eax
    1783:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1786:	eb 06                	jmp    178e <printint+0x32>
  } else {
    x = xx;
    1788:	8b 45 0c             	mov    0xc(%ebp),%eax
    178b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    178e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1795:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1798:	8d 41 01             	lea    0x1(%ecx),%eax
    179b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    179e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    17a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a4:	ba 00 00 00 00       	mov    $0x0,%edx
    17a9:	f7 f3                	div    %ebx
    17ab:	89 d0                	mov    %edx,%eax
    17ad:	0f b6 80 3c 23 00 00 	movzbl 0x233c(%eax),%eax
    17b4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    17b8:	8b 75 10             	mov    0x10(%ebp),%esi
    17bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17be:	ba 00 00 00 00       	mov    $0x0,%edx
    17c3:	f7 f6                	div    %esi
    17c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17cc:	75 c7                	jne    1795 <printint+0x39>
  if(neg)
    17ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17d2:	74 10                	je     17e4 <printint+0x88>
    buf[i++] = '-';
    17d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d7:	8d 50 01             	lea    0x1(%eax),%edx
    17da:	89 55 f4             	mov    %edx,-0xc(%ebp)
    17dd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    17e2:	eb 1f                	jmp    1803 <printint+0xa7>
    17e4:	eb 1d                	jmp    1803 <printint+0xa7>
    putc(fd, buf[i]);
    17e6:	8d 55 dc             	lea    -0x24(%ebp),%edx
    17e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ec:	01 d0                	add    %edx,%eax
    17ee:	0f b6 00             	movzbl (%eax),%eax
    17f1:	0f be c0             	movsbl %al,%eax
    17f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f8:	8b 45 08             	mov    0x8(%ebp),%eax
    17fb:	89 04 24             	mov    %eax,(%esp)
    17fe:	e8 31 ff ff ff       	call   1734 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1803:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    180b:	79 d9                	jns    17e6 <printint+0x8a>
    putc(fd, buf[i]);
}
    180d:	83 c4 30             	add    $0x30,%esp
    1810:	5b                   	pop    %ebx
    1811:	5e                   	pop    %esi
    1812:	5d                   	pop    %ebp
    1813:	c3                   	ret    

00001814 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1814:	55                   	push   %ebp
    1815:	89 e5                	mov    %esp,%ebp
    1817:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    181a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1821:	8d 45 0c             	lea    0xc(%ebp),%eax
    1824:	83 c0 04             	add    $0x4,%eax
    1827:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    182a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1831:	e9 7c 01 00 00       	jmp    19b2 <printf+0x19e>
    c = fmt[i] & 0xff;
    1836:	8b 55 0c             	mov    0xc(%ebp),%edx
    1839:	8b 45 f0             	mov    -0x10(%ebp),%eax
    183c:	01 d0                	add    %edx,%eax
    183e:	0f b6 00             	movzbl (%eax),%eax
    1841:	0f be c0             	movsbl %al,%eax
    1844:	25 ff 00 00 00       	and    $0xff,%eax
    1849:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    184c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1850:	75 2c                	jne    187e <printf+0x6a>
      if(c == '%'){
    1852:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1856:	75 0c                	jne    1864 <printf+0x50>
        state = '%';
    1858:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    185f:	e9 4a 01 00 00       	jmp    19ae <printf+0x19a>
      } else {
        putc(fd, c);
    1864:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1867:	0f be c0             	movsbl %al,%eax
    186a:	89 44 24 04          	mov    %eax,0x4(%esp)
    186e:	8b 45 08             	mov    0x8(%ebp),%eax
    1871:	89 04 24             	mov    %eax,(%esp)
    1874:	e8 bb fe ff ff       	call   1734 <putc>
    1879:	e9 30 01 00 00       	jmp    19ae <printf+0x19a>
      }
    } else if(state == '%'){
    187e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1882:	0f 85 26 01 00 00    	jne    19ae <printf+0x19a>
      if(c == 'd'){
    1888:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    188c:	75 2d                	jne    18bb <printf+0xa7>
        printint(fd, *ap, 10, 1);
    188e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1891:	8b 00                	mov    (%eax),%eax
    1893:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    189a:	00 
    189b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    18a2:	00 
    18a3:	89 44 24 04          	mov    %eax,0x4(%esp)
    18a7:	8b 45 08             	mov    0x8(%ebp),%eax
    18aa:	89 04 24             	mov    %eax,(%esp)
    18ad:	e8 aa fe ff ff       	call   175c <printint>
        ap++;
    18b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18b6:	e9 ec 00 00 00       	jmp    19a7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    18bb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    18bf:	74 06                	je     18c7 <printf+0xb3>
    18c1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    18c5:	75 2d                	jne    18f4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    18c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18ca:	8b 00                	mov    (%eax),%eax
    18cc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    18d3:	00 
    18d4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    18db:	00 
    18dc:	89 44 24 04          	mov    %eax,0x4(%esp)
    18e0:	8b 45 08             	mov    0x8(%ebp),%eax
    18e3:	89 04 24             	mov    %eax,(%esp)
    18e6:	e8 71 fe ff ff       	call   175c <printint>
        ap++;
    18eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18ef:	e9 b3 00 00 00       	jmp    19a7 <printf+0x193>
      } else if(c == 's'){
    18f4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    18f8:	75 45                	jne    193f <printf+0x12b>
        s = (char*)*ap;
    18fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18fd:	8b 00                	mov    (%eax),%eax
    18ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1902:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1906:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    190a:	75 09                	jne    1915 <printf+0x101>
          s = "(null)";
    190c:	c7 45 f4 37 1f 00 00 	movl   $0x1f37,-0xc(%ebp)
        while(*s != 0){
    1913:	eb 1e                	jmp    1933 <printf+0x11f>
    1915:	eb 1c                	jmp    1933 <printf+0x11f>
          putc(fd, *s);
    1917:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191a:	0f b6 00             	movzbl (%eax),%eax
    191d:	0f be c0             	movsbl %al,%eax
    1920:	89 44 24 04          	mov    %eax,0x4(%esp)
    1924:	8b 45 08             	mov    0x8(%ebp),%eax
    1927:	89 04 24             	mov    %eax,(%esp)
    192a:	e8 05 fe ff ff       	call   1734 <putc>
          s++;
    192f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1933:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1936:	0f b6 00             	movzbl (%eax),%eax
    1939:	84 c0                	test   %al,%al
    193b:	75 da                	jne    1917 <printf+0x103>
    193d:	eb 68                	jmp    19a7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    193f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1943:	75 1d                	jne    1962 <printf+0x14e>
        putc(fd, *ap);
    1945:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1948:	8b 00                	mov    (%eax),%eax
    194a:	0f be c0             	movsbl %al,%eax
    194d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1951:	8b 45 08             	mov    0x8(%ebp),%eax
    1954:	89 04 24             	mov    %eax,(%esp)
    1957:	e8 d8 fd ff ff       	call   1734 <putc>
        ap++;
    195c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1960:	eb 45                	jmp    19a7 <printf+0x193>
      } else if(c == '%'){
    1962:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1966:	75 17                	jne    197f <printf+0x16b>
        putc(fd, c);
    1968:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    196b:	0f be c0             	movsbl %al,%eax
    196e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1972:	8b 45 08             	mov    0x8(%ebp),%eax
    1975:	89 04 24             	mov    %eax,(%esp)
    1978:	e8 b7 fd ff ff       	call   1734 <putc>
    197d:	eb 28                	jmp    19a7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    197f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1986:	00 
    1987:	8b 45 08             	mov    0x8(%ebp),%eax
    198a:	89 04 24             	mov    %eax,(%esp)
    198d:	e8 a2 fd ff ff       	call   1734 <putc>
        putc(fd, c);
    1992:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1995:	0f be c0             	movsbl %al,%eax
    1998:	89 44 24 04          	mov    %eax,0x4(%esp)
    199c:	8b 45 08             	mov    0x8(%ebp),%eax
    199f:	89 04 24             	mov    %eax,(%esp)
    19a2:	e8 8d fd ff ff       	call   1734 <putc>
      }
      state = 0;
    19a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    19ae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    19b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    19b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b8:	01 d0                	add    %edx,%eax
    19ba:	0f b6 00             	movzbl (%eax),%eax
    19bd:	84 c0                	test   %al,%al
    19bf:	0f 85 71 fe ff ff    	jne    1836 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    19c5:	c9                   	leave  
    19c6:	c3                   	ret    
    19c7:	90                   	nop

000019c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    19c8:	55                   	push   %ebp
    19c9:	89 e5                	mov    %esp,%ebp
    19cb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	83 e8 08             	sub    $0x8,%eax
    19d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19d7:	a1 74 23 00 00       	mov    0x2374,%eax
    19dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19df:	eb 24                	jmp    1a05 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e4:	8b 00                	mov    (%eax),%eax
    19e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19e9:	77 12                	ja     19fd <free+0x35>
    19eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19f1:	77 24                	ja     1a17 <free+0x4f>
    19f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f6:	8b 00                	mov    (%eax),%eax
    19f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19fb:	77 1a                	ja     1a17 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a00:	8b 00                	mov    (%eax),%eax
    1a02:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1a05:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a08:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a0b:	76 d4                	jbe    19e1 <free+0x19>
    1a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a10:	8b 00                	mov    (%eax),%eax
    1a12:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a15:	76 ca                	jbe    19e1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1a17:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a1a:	8b 40 04             	mov    0x4(%eax),%eax
    1a1d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1a24:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a27:	01 c2                	add    %eax,%edx
    1a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a2c:	8b 00                	mov    (%eax),%eax
    1a2e:	39 c2                	cmp    %eax,%edx
    1a30:	75 24                	jne    1a56 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1a32:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a35:	8b 50 04             	mov    0x4(%eax),%edx
    1a38:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a3b:	8b 00                	mov    (%eax),%eax
    1a3d:	8b 40 04             	mov    0x4(%eax),%eax
    1a40:	01 c2                	add    %eax,%edx
    1a42:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a45:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1a48:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a4b:	8b 00                	mov    (%eax),%eax
    1a4d:	8b 10                	mov    (%eax),%edx
    1a4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a52:	89 10                	mov    %edx,(%eax)
    1a54:	eb 0a                	jmp    1a60 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1a56:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a59:	8b 10                	mov    (%eax),%edx
    1a5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a5e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1a60:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a63:	8b 40 04             	mov    0x4(%eax),%eax
    1a66:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1a6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a70:	01 d0                	add    %edx,%eax
    1a72:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a75:	75 20                	jne    1a97 <free+0xcf>
    p->s.size += bp->s.size;
    1a77:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a7a:	8b 50 04             	mov    0x4(%eax),%edx
    1a7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a80:	8b 40 04             	mov    0x4(%eax),%eax
    1a83:	01 c2                	add    %eax,%edx
    1a85:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a88:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1a8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a8e:	8b 10                	mov    (%eax),%edx
    1a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a93:	89 10                	mov    %edx,(%eax)
    1a95:	eb 08                	jmp    1a9f <free+0xd7>
  } else
    p->s.ptr = bp;
    1a97:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a9a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a9d:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aa2:	a3 74 23 00 00       	mov    %eax,0x2374
}
    1aa7:	c9                   	leave  
    1aa8:	c3                   	ret    

00001aa9 <morecore>:

static Header*
morecore(uint nu)
{
    1aa9:	55                   	push   %ebp
    1aaa:	89 e5                	mov    %esp,%ebp
    1aac:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1aaf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1ab6:	77 07                	ja     1abf <morecore+0x16>
    nu = 4096;
    1ab8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1abf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac2:	c1 e0 03             	shl    $0x3,%eax
    1ac5:	89 04 24             	mov    %eax,(%esp)
    1ac8:	e8 27 fc ff ff       	call   16f4 <sbrk>
    1acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1ad0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1ad4:	75 07                	jne    1add <morecore+0x34>
    return 0;
    1ad6:	b8 00 00 00 00       	mov    $0x0,%eax
    1adb:	eb 22                	jmp    1aff <morecore+0x56>
  hp = (Header*)p;
    1add:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1ae3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ae6:	8b 55 08             	mov    0x8(%ebp),%edx
    1ae9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1aec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aef:	83 c0 08             	add    $0x8,%eax
    1af2:	89 04 24             	mov    %eax,(%esp)
    1af5:	e8 ce fe ff ff       	call   19c8 <free>
  return freep;
    1afa:	a1 74 23 00 00       	mov    0x2374,%eax
}
    1aff:	c9                   	leave  
    1b00:	c3                   	ret    

00001b01 <malloc>:

void*
malloc(uint nbytes)
{
    1b01:	55                   	push   %ebp
    1b02:	89 e5                	mov    %esp,%ebp
    1b04:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b07:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0a:	83 c0 07             	add    $0x7,%eax
    1b0d:	c1 e8 03             	shr    $0x3,%eax
    1b10:	83 c0 01             	add    $0x1,%eax
    1b13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1b16:	a1 74 23 00 00       	mov    0x2374,%eax
    1b1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b22:	75 23                	jne    1b47 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1b24:	c7 45 f0 6c 23 00 00 	movl   $0x236c,-0x10(%ebp)
    1b2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b2e:	a3 74 23 00 00       	mov    %eax,0x2374
    1b33:	a1 74 23 00 00       	mov    0x2374,%eax
    1b38:	a3 6c 23 00 00       	mov    %eax,0x236c
    base.s.size = 0;
    1b3d:	c7 05 70 23 00 00 00 	movl   $0x0,0x2370
    1b44:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b4a:	8b 00                	mov    (%eax),%eax
    1b4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b52:	8b 40 04             	mov    0x4(%eax),%eax
    1b55:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1b58:	72 4d                	jb     1ba7 <malloc+0xa6>
      if(p->s.size == nunits)
    1b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5d:	8b 40 04             	mov    0x4(%eax),%eax
    1b60:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1b63:	75 0c                	jne    1b71 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b68:	8b 10                	mov    (%eax),%edx
    1b6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b6d:	89 10                	mov    %edx,(%eax)
    1b6f:	eb 26                	jmp    1b97 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b74:	8b 40 04             	mov    0x4(%eax),%eax
    1b77:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1b7a:	89 c2                	mov    %eax,%edx
    1b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b7f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b85:	8b 40 04             	mov    0x4(%eax),%eax
    1b88:	c1 e0 03             	shl    $0x3,%eax
    1b8b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b91:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1b94:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b97:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9a:	a3 74 23 00 00       	mov    %eax,0x2374
      return (void*)(p + 1);
    1b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba2:	83 c0 08             	add    $0x8,%eax
    1ba5:	eb 38                	jmp    1bdf <malloc+0xde>
    }
    if(p == freep)
    1ba7:	a1 74 23 00 00       	mov    0x2374,%eax
    1bac:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1baf:	75 1b                	jne    1bcc <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1bb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bb4:	89 04 24             	mov    %eax,(%esp)
    1bb7:	e8 ed fe ff ff       	call   1aa9 <morecore>
    1bbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1bbf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bc3:	75 07                	jne    1bcc <malloc+0xcb>
        return 0;
    1bc5:	b8 00 00 00 00       	mov    $0x0,%eax
    1bca:	eb 13                	jmp    1bdf <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd5:	8b 00                	mov    (%eax),%eax
    1bd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1bda:	e9 70 ff ff ff       	jmp    1b4f <malloc+0x4e>
}
    1bdf:	c9                   	leave  
    1be0:	c3                   	ret    
    1be1:	66 90                	xchg   %ax,%ax
    1be3:	90                   	nop

00001be4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1be4:	55                   	push   %ebp
    1be5:	89 e5                	mov    %esp,%ebp
    1be7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1bea:	8b 55 08             	mov    0x8(%ebp),%edx
    1bed:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bf0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bf3:	f0 87 02             	lock xchg %eax,(%edx)
    1bf6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1bfc:	c9                   	leave  
    1bfd:	c3                   	ret    

00001bfe <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1bfe:	55                   	push   %ebp
    1bff:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1c01:	8b 45 08             	mov    0x8(%ebp),%eax
    1c04:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1c0a:	5d                   	pop    %ebp
    1c0b:	c3                   	ret    

00001c0c <lock_acquire>:
void lock_acquire(lock_t *lock){
    1c0c:	55                   	push   %ebp
    1c0d:	89 e5                	mov    %esp,%ebp
    1c0f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1c12:	90                   	nop
    1c13:	8b 45 08             	mov    0x8(%ebp),%eax
    1c16:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1c1d:	00 
    1c1e:	89 04 24             	mov    %eax,(%esp)
    1c21:	e8 be ff ff ff       	call   1be4 <xchg>
    1c26:	85 c0                	test   %eax,%eax
    1c28:	75 e9                	jne    1c13 <lock_acquire+0x7>
}
    1c2a:	c9                   	leave  
    1c2b:	c3                   	ret    

00001c2c <lock_release>:
void lock_release(lock_t *lock){
    1c2c:	55                   	push   %ebp
    1c2d:	89 e5                	mov    %esp,%ebp
    1c2f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1c32:	8b 45 08             	mov    0x8(%ebp),%eax
    1c35:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c3c:	00 
    1c3d:	89 04 24             	mov    %eax,(%esp)
    1c40:	e8 9f ff ff ff       	call   1be4 <xchg>
}
    1c45:	c9                   	leave  
    1c46:	c3                   	ret    

00001c47 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1c47:	55                   	push   %ebp
    1c48:	89 e5                	mov    %esp,%ebp
    1c4a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1c4d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1c54:	e8 a8 fe ff ff       	call   1b01 <malloc>
    1c59:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c65:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c6a:	85 c0                	test   %eax,%eax
    1c6c:	74 14                	je     1c82 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c71:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c76:	89 c2                	mov    %eax,%edx
    1c78:	b8 00 10 00 00       	mov    $0x1000,%eax
    1c7d:	29 d0                	sub    %edx,%eax
    1c7f:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1c82:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c86:	75 1b                	jne    1ca3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1c88:	c7 44 24 04 3e 1f 00 	movl   $0x1f3e,0x4(%esp)
    1c8f:	00 
    1c90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c97:	e8 78 fb ff ff       	call   1814 <printf>
        return 0;
    1c9c:	b8 00 00 00 00       	mov    $0x0,%eax
    1ca1:	eb 6f                	jmp    1d12 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1ca3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1ca6:	8b 55 08             	mov    0x8(%ebp),%edx
    1ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cac:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1cb0:	89 54 24 08          	mov    %edx,0x8(%esp)
    1cb4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1cbb:	00 
    1cbc:	89 04 24             	mov    %eax,(%esp)
    1cbf:	e8 48 fa ff ff       	call   170c <clone>
    1cc4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1cc7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ccb:	79 1b                	jns    1ce8 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1ccd:	c7 44 24 04 4c 1f 00 	movl   $0x1f4c,0x4(%esp)
    1cd4:	00 
    1cd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cdc:	e8 33 fb ff ff       	call   1814 <printf>
        return 0;
    1ce1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ce6:	eb 2a                	jmp    1d12 <thread_create+0xcb>
    }
    if(tid > 0){
    1ce8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cec:	7e 05                	jle    1cf3 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1cee:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cf1:	eb 1f                	jmp    1d12 <thread_create+0xcb>
    }
    if(tid == 0){
    1cf3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cf7:	75 14                	jne    1d0d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1cf9:	c7 44 24 04 59 1f 00 	movl   $0x1f59,0x4(%esp)
    1d00:	00 
    1d01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d08:	e8 07 fb ff ff       	call   1814 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1d0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d12:	c9                   	leave  
    1d13:	c3                   	ret    

00001d14 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1d14:	55                   	push   %ebp
    1d15:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1d17:	a1 50 23 00 00       	mov    0x2350,%eax
    1d1c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1d22:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1d27:	a3 50 23 00 00       	mov    %eax,0x2350
    return (int)(rands % max);
    1d2c:	a1 50 23 00 00       	mov    0x2350,%eax
    1d31:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d34:	ba 00 00 00 00       	mov    $0x0,%edx
    1d39:	f7 f1                	div    %ecx
    1d3b:	89 d0                	mov    %edx,%eax
}
    1d3d:	5d                   	pop    %ebp
    1d3e:	c3                   	ret    
    1d3f:	90                   	nop

00001d40 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1d40:	55                   	push   %ebp
    1d41:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1d43:	8b 45 08             	mov    0x8(%ebp),%eax
    1d46:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1d4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1d56:	8b 45 08             	mov    0x8(%ebp),%eax
    1d59:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1d60:	5d                   	pop    %ebp
    1d61:	c3                   	ret    

00001d62 <add_q>:

void add_q(struct queue *q, int v){
    1d62:	55                   	push   %ebp
    1d63:	89 e5                	mov    %esp,%ebp
    1d65:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1d68:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d6f:	e8 8d fd ff ff       	call   1b01 <malloc>
    1d74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d7a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d84:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d87:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d89:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8c:	8b 40 04             	mov    0x4(%eax),%eax
    1d8f:	85 c0                	test   %eax,%eax
    1d91:	75 0b                	jne    1d9e <add_q+0x3c>
        q->head = n;
    1d93:	8b 45 08             	mov    0x8(%ebp),%eax
    1d96:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d99:	89 50 04             	mov    %edx,0x4(%eax)
    1d9c:	eb 0c                	jmp    1daa <add_q+0x48>
    }else{
        q->tail->next = n;
    1d9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1da1:	8b 40 08             	mov    0x8(%eax),%eax
    1da4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1da7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1daa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1db0:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1db3:	8b 45 08             	mov    0x8(%ebp),%eax
    1db6:	8b 00                	mov    (%eax),%eax
    1db8:	8d 50 01             	lea    0x1(%eax),%edx
    1dbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbe:	89 10                	mov    %edx,(%eax)
}
    1dc0:	c9                   	leave  
    1dc1:	c3                   	ret    

00001dc2 <empty_q>:

int empty_q(struct queue *q){
    1dc2:	55                   	push   %ebp
    1dc3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1dc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc8:	8b 00                	mov    (%eax),%eax
    1dca:	85 c0                	test   %eax,%eax
    1dcc:	75 07                	jne    1dd5 <empty_q+0x13>
        return 1;
    1dce:	b8 01 00 00 00       	mov    $0x1,%eax
    1dd3:	eb 05                	jmp    1dda <empty_q+0x18>
    else
        return 0;
    1dd5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1dda:	5d                   	pop    %ebp
    1ddb:	c3                   	ret    

00001ddc <pop_q>:
int pop_q(struct queue *q){
    1ddc:	55                   	push   %ebp
    1ddd:	89 e5                	mov    %esp,%ebp
    1ddf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1de2:	8b 45 08             	mov    0x8(%ebp),%eax
    1de5:	89 04 24             	mov    %eax,(%esp)
    1de8:	e8 d5 ff ff ff       	call   1dc2 <empty_q>
    1ded:	85 c0                	test   %eax,%eax
    1def:	75 5d                	jne    1e4e <pop_q+0x72>
       val = q->head->value; 
    1df1:	8b 45 08             	mov    0x8(%ebp),%eax
    1df4:	8b 40 04             	mov    0x4(%eax),%eax
    1df7:	8b 00                	mov    (%eax),%eax
    1df9:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dff:	8b 40 04             	mov    0x4(%eax),%eax
    1e02:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1e05:	8b 45 08             	mov    0x8(%ebp),%eax
    1e08:	8b 40 04             	mov    0x4(%eax),%eax
    1e0b:	8b 50 04             	mov    0x4(%eax),%edx
    1e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e11:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1e14:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e17:	89 04 24             	mov    %eax,(%esp)
    1e1a:	e8 a9 fb ff ff       	call   19c8 <free>
       q->size--;
    1e1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e22:	8b 00                	mov    (%eax),%eax
    1e24:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e27:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	8b 00                	mov    (%eax),%eax
    1e31:	85 c0                	test   %eax,%eax
    1e33:	75 14                	jne    1e49 <pop_q+0x6d>
            q->head = 0;
    1e35:	8b 45 08             	mov    0x8(%ebp),%eax
    1e38:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1e3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e42:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e4c:	eb 05                	jmp    1e53 <pop_q+0x77>
    }
    return -1;
    1e4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e53:	c9                   	leave  
    1e54:	c3                   	ret    
