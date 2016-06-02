
_test_sleep:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    int total;
}ttable;

void func(void *arg_ptr);

int main(int argc, char *argv[]){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    struct thread * t;
    int i;
    printf(1,"init ttable\n");
    1009:	c7 44 24 04 24 1c 00 	movl   $0x1c24,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 cf 05 00 00       	call   15ec <printf>
    lock_init(&ttable.lock);
    101d:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    1024:	e8 a1 09 00 00       	call   19ca <lock_init>
    ttable.total = 0;
    1029:	c7 05 84 21 00 00 00 	movl   $0x0,0x2184
    1030:	00 00 00 

    lock_acquire(&ttable.lock);
    1033:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    103a:	e8 99 09 00 00       	call   19d8 <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    103f:	c7 44 24 1c 84 20 00 	movl   $0x2084,0x1c(%esp)
    1046:	00 
    1047:	eb 0f                	jmp    1058 <main+0x58>
        t->tid = 0;
    1049:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    104d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    printf(1,"init ttable\n");
    lock_init(&ttable.lock);
    ttable.total = 0;

    lock_acquire(&ttable.lock);
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    1053:	83 44 24 1c 04       	addl   $0x4,0x1c(%esp)
    1058:	81 7c 24 1c 84 21 00 	cmpl   $0x2184,0x1c(%esp)
    105f:	00 
    1060:	72 e7                	jb     1049 <main+0x49>
        t->tid = 0;
    }
    lock_release(&ttable.lock);
    1062:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    1069:	e8 8a 09 00 00       	call   19f8 <lock_release>
    printf(1,"testing thread sleep and wakeup \n\n\n");
    106e:	c7 44 24 04 34 1c 00 	movl   $0x1c34,0x4(%esp)
    1075:	00 
    1076:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107d:	e8 6a 05 00 00       	call   15ec <printf>
    void *stack = thread_create(func,0);
    1082:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1089:	00 
    108a:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    1091:	e8 7d 09 00 00       	call   1a13 <thread_create>
    1096:	89 44 24 14          	mov    %eax,0x14(%esp)
    thread_create(func,0);
    109a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10a1:	00 
    10a2:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    10a9:	e8 65 09 00 00       	call   1a13 <thread_create>
    thread_create(func,0);
    10ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10b5:	00 
    10b6:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    10bd:	e8 51 09 00 00       	call   1a13 <thread_create>

    i=0;
    10c2:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    10c9:	00 
    while(i++ < 1000000);
    10ca:	90                   	nop
    10cb:	8b 44 24 18          	mov    0x18(%esp),%eax
    10cf:	8d 50 01             	lea    0x1(%eax),%edx
    10d2:	89 54 24 18          	mov    %edx,0x18(%esp)
    10d6:	3d 3f 42 0f 00       	cmp    $0xf423f,%eax
    10db:	7e ee                	jle    10cb <main+0xcb>
    //find that thread
    lock_acquire(&ttable.lock);
    10dd:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    10e4:	e8 ef 08 00 00       	call   19d8 <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    10e9:	c7 44 24 1c 84 20 00 	movl   $0x2084,0x1c(%esp)
    10f0:	00 
    10f1:	eb 40                	jmp    1133 <main+0x133>
        if(t->tid != 0){
    10f3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    10f7:	8b 00                	mov    (%eax),%eax
    10f9:	85 c0                	test   %eax,%eax
    10fb:	74 31                	je     112e <main+0x12e>
            printf(1,"found one... %d,   wake up lazy boy !!!\n",t->tid);
    10fd:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1101:	8b 00                	mov    (%eax),%eax
    1103:	89 44 24 08          	mov    %eax,0x8(%esp)
    1107:	c7 44 24 04 58 1c 00 	movl   $0x1c58,0x4(%esp)
    110e:	00 
    110f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1116:	e8 d1 04 00 00       	call   15ec <printf>
            twakeup(t->tid);
    111b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    111f:	8b 00                	mov    (%eax),%eax
    1121:	89 04 24             	mov    %eax,(%esp)
    1124:	e8 db 03 00 00       	call   1504 <twakeup>
            i++;
    1129:	83 44 24 18 01       	addl   $0x1,0x18(%esp)

    i=0;
    while(i++ < 1000000);
    //find that thread
    lock_acquire(&ttable.lock);
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    112e:	83 44 24 1c 04       	addl   $0x4,0x1c(%esp)
    1133:	81 7c 24 1c 84 21 00 	cmpl   $0x2184,0x1c(%esp)
    113a:	00 
    113b:	72 b6                	jb     10f3 <main+0xf3>
            printf(1,"found one... %d,   wake up lazy boy !!!\n",t->tid);
            twakeup(t->tid);
            i++;
        }
    }
    lock_release(&ttable.lock);
    113d:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    1144:	e8 af 08 00 00       	call   19f8 <lock_release>
    wait();
    1149:	e8 06 03 00 00       	call   1454 <wait>
    wait();
    114e:	e8 01 03 00 00       	call   1454 <wait>
    wait();
    1153:	e8 fc 02 00 00       	call   1454 <wait>
    free(stack);
    1158:	8b 44 24 14          	mov    0x14(%esp),%eax
    115c:	89 04 24             	mov    %eax,(%esp)
    115f:	e8 3c 06 00 00       	call   17a0 <free>
    exit();
    1164:	e8 e3 02 00 00       	call   144c <exit>

00001169 <func>:
}

void func(void *arg_ptr){
    1169:	55                   	push   %ebp
    116a:	89 e5                	mov    %esp,%ebp
    116c:	83 ec 28             	sub    $0x28,%esp
    int tid;
    tid = getpid();
    116f:	e8 58 03 00 00       	call   14cc <getpid>
    1174:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lock_acquire(&ttable.lock);
    1177:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    117e:	e8 55 08 00 00       	call   19d8 <lock_acquire>
    (ttable.threads[ttable.total]).tid = tid;
    1183:	a1 84 21 00 00       	mov    0x2184,%eax
    1188:	8b 55 f4             	mov    -0xc(%ebp),%edx
    118b:	89 14 85 84 20 00 00 	mov    %edx,0x2084(,%eax,4)
    ttable.total++;
    1192:	a1 84 21 00 00       	mov    0x2184,%eax
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	a3 84 21 00 00       	mov    %eax,0x2184
    lock_release(&ttable.lock);
    119f:	c7 04 24 80 20 00 00 	movl   $0x2080,(%esp)
    11a6:	e8 4d 08 00 00       	call   19f8 <lock_release>

    printf(1,"I am thread %d, is about to sleep\n",tid);
    11ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ae:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b2:	c7 44 24 04 84 1c 00 	movl   $0x1c84,0x4(%esp)
    11b9:	00 
    11ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c1:	e8 26 04 00 00       	call   15ec <printf>
    tsleep();
    11c6:	e8 31 03 00 00       	call   14fc <tsleep>
    printf(1,"I am wake up!\n");
    11cb:	c7 44 24 04 a7 1c 00 	movl   $0x1ca7,0x4(%esp)
    11d2:	00 
    11d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11da:	e8 0d 04 00 00       	call   15ec <printf>
    texit();
    11df:	e8 10 03 00 00       	call   14f4 <texit>

000011e4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11e4:	55                   	push   %ebp
    11e5:	89 e5                	mov    %esp,%ebp
    11e7:	57                   	push   %edi
    11e8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11ec:	8b 55 10             	mov    0x10(%ebp),%edx
    11ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f2:	89 cb                	mov    %ecx,%ebx
    11f4:	89 df                	mov    %ebx,%edi
    11f6:	89 d1                	mov    %edx,%ecx
    11f8:	fc                   	cld    
    11f9:	f3 aa                	rep stos %al,%es:(%edi)
    11fb:	89 ca                	mov    %ecx,%edx
    11fd:	89 fb                	mov    %edi,%ebx
    11ff:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1202:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1205:	5b                   	pop    %ebx
    1206:	5f                   	pop    %edi
    1207:	5d                   	pop    %ebp
    1208:	c3                   	ret    

00001209 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1209:	55                   	push   %ebp
    120a:	89 e5                	mov    %esp,%ebp
    120c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    120f:	8b 45 08             	mov    0x8(%ebp),%eax
    1212:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1215:	90                   	nop
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	8d 50 01             	lea    0x1(%eax),%edx
    121c:	89 55 08             	mov    %edx,0x8(%ebp)
    121f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1222:	8d 4a 01             	lea    0x1(%edx),%ecx
    1225:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1228:	0f b6 12             	movzbl (%edx),%edx
    122b:	88 10                	mov    %dl,(%eax)
    122d:	0f b6 00             	movzbl (%eax),%eax
    1230:	84 c0                	test   %al,%al
    1232:	75 e2                	jne    1216 <strcpy+0xd>
    ;
  return os;
    1234:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1237:	c9                   	leave  
    1238:	c3                   	ret    

00001239 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1239:	55                   	push   %ebp
    123a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    123c:	eb 08                	jmp    1246 <strcmp+0xd>
    p++, q++;
    123e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1242:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1246:	8b 45 08             	mov    0x8(%ebp),%eax
    1249:	0f b6 00             	movzbl (%eax),%eax
    124c:	84 c0                	test   %al,%al
    124e:	74 10                	je     1260 <strcmp+0x27>
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	0f b6 10             	movzbl (%eax),%edx
    1256:	8b 45 0c             	mov    0xc(%ebp),%eax
    1259:	0f b6 00             	movzbl (%eax),%eax
    125c:	38 c2                	cmp    %al,%dl
    125e:	74 de                	je     123e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1260:	8b 45 08             	mov    0x8(%ebp),%eax
    1263:	0f b6 00             	movzbl (%eax),%eax
    1266:	0f b6 d0             	movzbl %al,%edx
    1269:	8b 45 0c             	mov    0xc(%ebp),%eax
    126c:	0f b6 00             	movzbl (%eax),%eax
    126f:	0f b6 c0             	movzbl %al,%eax
    1272:	29 c2                	sub    %eax,%edx
    1274:	89 d0                	mov    %edx,%eax
}
    1276:	5d                   	pop    %ebp
    1277:	c3                   	ret    

00001278 <strlen>:

uint
strlen(char *s)
{
    1278:	55                   	push   %ebp
    1279:	89 e5                	mov    %esp,%ebp
    127b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    127e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1285:	eb 04                	jmp    128b <strlen+0x13>
    1287:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    128b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
    1291:	01 d0                	add    %edx,%eax
    1293:	0f b6 00             	movzbl (%eax),%eax
    1296:	84 c0                	test   %al,%al
    1298:	75 ed                	jne    1287 <strlen+0xf>
    ;
  return n;
    129a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    129d:	c9                   	leave  
    129e:	c3                   	ret    

0000129f <memset>:

void*
memset(void *dst, int c, uint n)
{
    129f:	55                   	push   %ebp
    12a0:	89 e5                	mov    %esp,%ebp
    12a2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    12a5:	8b 45 10             	mov    0x10(%ebp),%eax
    12a8:	89 44 24 08          	mov    %eax,0x8(%esp)
    12ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    12af:	89 44 24 04          	mov    %eax,0x4(%esp)
    12b3:	8b 45 08             	mov    0x8(%ebp),%eax
    12b6:	89 04 24             	mov    %eax,(%esp)
    12b9:	e8 26 ff ff ff       	call   11e4 <stosb>
  return dst;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c1:	c9                   	leave  
    12c2:	c3                   	ret    

000012c3 <strchr>:

char*
strchr(const char *s, char c)
{
    12c3:	55                   	push   %ebp
    12c4:	89 e5                	mov    %esp,%ebp
    12c6:	83 ec 04             	sub    $0x4,%esp
    12c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12cf:	eb 14                	jmp    12e5 <strchr+0x22>
    if(*s == c)
    12d1:	8b 45 08             	mov    0x8(%ebp),%eax
    12d4:	0f b6 00             	movzbl (%eax),%eax
    12d7:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12da:	75 05                	jne    12e1 <strchr+0x1e>
      return (char*)s;
    12dc:	8b 45 08             	mov    0x8(%ebp),%eax
    12df:	eb 13                	jmp    12f4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12e5:	8b 45 08             	mov    0x8(%ebp),%eax
    12e8:	0f b6 00             	movzbl (%eax),%eax
    12eb:	84 c0                	test   %al,%al
    12ed:	75 e2                	jne    12d1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12f4:	c9                   	leave  
    12f5:	c3                   	ret    

000012f6 <gets>:

char*
gets(char *buf, int max)
{
    12f6:	55                   	push   %ebp
    12f7:	89 e5                	mov    %esp,%ebp
    12f9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1303:	eb 4c                	jmp    1351 <gets+0x5b>
    cc = read(0, &c, 1);
    1305:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    130c:	00 
    130d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1310:	89 44 24 04          	mov    %eax,0x4(%esp)
    1314:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    131b:	e8 44 01 00 00       	call   1464 <read>
    1320:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1323:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1327:	7f 02                	jg     132b <gets+0x35>
      break;
    1329:	eb 31                	jmp    135c <gets+0x66>
    buf[i++] = c;
    132b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    132e:	8d 50 01             	lea    0x1(%eax),%edx
    1331:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1334:	89 c2                	mov    %eax,%edx
    1336:	8b 45 08             	mov    0x8(%ebp),%eax
    1339:	01 c2                	add    %eax,%edx
    133b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    133f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1341:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1345:	3c 0a                	cmp    $0xa,%al
    1347:	74 13                	je     135c <gets+0x66>
    1349:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    134d:	3c 0d                	cmp    $0xd,%al
    134f:	74 0b                	je     135c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1351:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1354:	83 c0 01             	add    $0x1,%eax
    1357:	3b 45 0c             	cmp    0xc(%ebp),%eax
    135a:	7c a9                	jl     1305 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    135c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    135f:	8b 45 08             	mov    0x8(%ebp),%eax
    1362:	01 d0                	add    %edx,%eax
    1364:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
}
    136a:	c9                   	leave  
    136b:	c3                   	ret    

0000136c <stat>:

int
stat(char *n, struct stat *st)
{
    136c:	55                   	push   %ebp
    136d:	89 e5                	mov    %esp,%ebp
    136f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1372:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1379:	00 
    137a:	8b 45 08             	mov    0x8(%ebp),%eax
    137d:	89 04 24             	mov    %eax,(%esp)
    1380:	e8 07 01 00 00       	call   148c <open>
    1385:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1388:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    138c:	79 07                	jns    1395 <stat+0x29>
    return -1;
    138e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1393:	eb 23                	jmp    13b8 <stat+0x4c>
  r = fstat(fd, st);
    1395:	8b 45 0c             	mov    0xc(%ebp),%eax
    1398:	89 44 24 04          	mov    %eax,0x4(%esp)
    139c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139f:	89 04 24             	mov    %eax,(%esp)
    13a2:	e8 fd 00 00 00       	call   14a4 <fstat>
    13a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    13aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ad:	89 04 24             	mov    %eax,(%esp)
    13b0:	e8 bf 00 00 00       	call   1474 <close>
  return r;
    13b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    13b8:	c9                   	leave  
    13b9:	c3                   	ret    

000013ba <atoi>:

int
atoi(const char *s)
{
    13ba:	55                   	push   %ebp
    13bb:	89 e5                	mov    %esp,%ebp
    13bd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13c7:	eb 25                	jmp    13ee <atoi+0x34>
    n = n*10 + *s++ - '0';
    13c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13cc:	89 d0                	mov    %edx,%eax
    13ce:	c1 e0 02             	shl    $0x2,%eax
    13d1:	01 d0                	add    %edx,%eax
    13d3:	01 c0                	add    %eax,%eax
    13d5:	89 c1                	mov    %eax,%ecx
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	8d 50 01             	lea    0x1(%eax),%edx
    13dd:	89 55 08             	mov    %edx,0x8(%ebp)
    13e0:	0f b6 00             	movzbl (%eax),%eax
    13e3:	0f be c0             	movsbl %al,%eax
    13e6:	01 c8                	add    %ecx,%eax
    13e8:	83 e8 30             	sub    $0x30,%eax
    13eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13ee:	8b 45 08             	mov    0x8(%ebp),%eax
    13f1:	0f b6 00             	movzbl (%eax),%eax
    13f4:	3c 2f                	cmp    $0x2f,%al
    13f6:	7e 0a                	jle    1402 <atoi+0x48>
    13f8:	8b 45 08             	mov    0x8(%ebp),%eax
    13fb:	0f b6 00             	movzbl (%eax),%eax
    13fe:	3c 39                	cmp    $0x39,%al
    1400:	7e c7                	jle    13c9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1402:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1405:	c9                   	leave  
    1406:	c3                   	ret    

00001407 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1407:	55                   	push   %ebp
    1408:	89 e5                	mov    %esp,%ebp
    140a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1413:	8b 45 0c             	mov    0xc(%ebp),%eax
    1416:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1419:	eb 17                	jmp    1432 <memmove+0x2b>
    *dst++ = *src++;
    141b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141e:	8d 50 01             	lea    0x1(%eax),%edx
    1421:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1424:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1427:	8d 4a 01             	lea    0x1(%edx),%ecx
    142a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    142d:	0f b6 12             	movzbl (%edx),%edx
    1430:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1432:	8b 45 10             	mov    0x10(%ebp),%eax
    1435:	8d 50 ff             	lea    -0x1(%eax),%edx
    1438:	89 55 10             	mov    %edx,0x10(%ebp)
    143b:	85 c0                	test   %eax,%eax
    143d:	7f dc                	jg     141b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    143f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1442:	c9                   	leave  
    1443:	c3                   	ret    

00001444 <fork>:
    1444:	b8 01 00 00 00       	mov    $0x1,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <exit>:
    144c:	b8 02 00 00 00       	mov    $0x2,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <wait>:
    1454:	b8 03 00 00 00       	mov    $0x3,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <pipe>:
    145c:	b8 04 00 00 00       	mov    $0x4,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <read>:
    1464:	b8 05 00 00 00       	mov    $0x5,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <write>:
    146c:	b8 10 00 00 00       	mov    $0x10,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <close>:
    1474:	b8 15 00 00 00       	mov    $0x15,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <kill>:
    147c:	b8 06 00 00 00       	mov    $0x6,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <exec>:
    1484:	b8 07 00 00 00       	mov    $0x7,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <open>:
    148c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <mknod>:
    1494:	b8 11 00 00 00       	mov    $0x11,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <unlink>:
    149c:	b8 12 00 00 00       	mov    $0x12,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <fstat>:
    14a4:	b8 08 00 00 00       	mov    $0x8,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <link>:
    14ac:	b8 13 00 00 00       	mov    $0x13,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <mkdir>:
    14b4:	b8 14 00 00 00       	mov    $0x14,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <chdir>:
    14bc:	b8 09 00 00 00       	mov    $0x9,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <dup>:
    14c4:	b8 0a 00 00 00       	mov    $0xa,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <getpid>:
    14cc:	b8 0b 00 00 00       	mov    $0xb,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <sbrk>:
    14d4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <sleep>:
    14dc:	b8 0d 00 00 00       	mov    $0xd,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <uptime>:
    14e4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14e9:	cd 40                	int    $0x40
    14eb:	c3                   	ret    

000014ec <clone>:
    14ec:	b8 16 00 00 00       	mov    $0x16,%eax
    14f1:	cd 40                	int    $0x40
    14f3:	c3                   	ret    

000014f4 <texit>:
    14f4:	b8 17 00 00 00       	mov    $0x17,%eax
    14f9:	cd 40                	int    $0x40
    14fb:	c3                   	ret    

000014fc <tsleep>:
    14fc:	b8 18 00 00 00       	mov    $0x18,%eax
    1501:	cd 40                	int    $0x40
    1503:	c3                   	ret    

00001504 <twakeup>:
    1504:	b8 19 00 00 00       	mov    $0x19,%eax
    1509:	cd 40                	int    $0x40
    150b:	c3                   	ret    

0000150c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    150c:	55                   	push   %ebp
    150d:	89 e5                	mov    %esp,%ebp
    150f:	83 ec 18             	sub    $0x18,%esp
    1512:	8b 45 0c             	mov    0xc(%ebp),%eax
    1515:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1518:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    151f:	00 
    1520:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1523:	89 44 24 04          	mov    %eax,0x4(%esp)
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 3a ff ff ff       	call   146c <write>
}
    1532:	c9                   	leave  
    1533:	c3                   	ret    

00001534 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1534:	55                   	push   %ebp
    1535:	89 e5                	mov    %esp,%ebp
    1537:	56                   	push   %esi
    1538:	53                   	push   %ebx
    1539:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    153c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1543:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1547:	74 17                	je     1560 <printint+0x2c>
    1549:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    154d:	79 11                	jns    1560 <printint+0x2c>
    neg = 1;
    154f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1556:	8b 45 0c             	mov    0xc(%ebp),%eax
    1559:	f7 d8                	neg    %eax
    155b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    155e:	eb 06                	jmp    1566 <printint+0x32>
  } else {
    x = xx;
    1560:	8b 45 0c             	mov    0xc(%ebp),%eax
    1563:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1566:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    156d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1570:	8d 41 01             	lea    0x1(%ecx),%eax
    1573:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1576:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1579:	8b 45 ec             	mov    -0x14(%ebp),%eax
    157c:	ba 00 00 00 00       	mov    $0x0,%edx
    1581:	f7 f3                	div    %ebx
    1583:	89 d0                	mov    %edx,%eax
    1585:	0f b6 80 2c 20 00 00 	movzbl 0x202c(%eax),%eax
    158c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1590:	8b 75 10             	mov    0x10(%ebp),%esi
    1593:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1596:	ba 00 00 00 00       	mov    $0x0,%edx
    159b:	f7 f6                	div    %esi
    159d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15a4:	75 c7                	jne    156d <printint+0x39>
  if(neg)
    15a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15aa:	74 10                	je     15bc <printint+0x88>
    buf[i++] = '-';
    15ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15af:	8d 50 01             	lea    0x1(%eax),%edx
    15b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15b5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    15ba:	eb 1f                	jmp    15db <printint+0xa7>
    15bc:	eb 1d                	jmp    15db <printint+0xa7>
    putc(fd, buf[i]);
    15be:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	0f be c0             	movsbl %al,%eax
    15cc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	89 04 24             	mov    %eax,(%esp)
    15d6:	e8 31 ff ff ff       	call   150c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15db:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15e3:	79 d9                	jns    15be <printint+0x8a>
    putc(fd, buf[i]);
}
    15e5:	83 c4 30             	add    $0x30,%esp
    15e8:	5b                   	pop    %ebx
    15e9:	5e                   	pop    %esi
    15ea:	5d                   	pop    %ebp
    15eb:	c3                   	ret    

000015ec <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15ec:	55                   	push   %ebp
    15ed:	89 e5                	mov    %esp,%ebp
    15ef:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15f9:	8d 45 0c             	lea    0xc(%ebp),%eax
    15fc:	83 c0 04             	add    $0x4,%eax
    15ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1602:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1609:	e9 7c 01 00 00       	jmp    178a <printf+0x19e>
    c = fmt[i] & 0xff;
    160e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1611:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1614:	01 d0                	add    %edx,%eax
    1616:	0f b6 00             	movzbl (%eax),%eax
    1619:	0f be c0             	movsbl %al,%eax
    161c:	25 ff 00 00 00       	and    $0xff,%eax
    1621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1624:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1628:	75 2c                	jne    1656 <printf+0x6a>
      if(c == '%'){
    162a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    162e:	75 0c                	jne    163c <printf+0x50>
        state = '%';
    1630:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1637:	e9 4a 01 00 00       	jmp    1786 <printf+0x19a>
      } else {
        putc(fd, c);
    163c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    163f:	0f be c0             	movsbl %al,%eax
    1642:	89 44 24 04          	mov    %eax,0x4(%esp)
    1646:	8b 45 08             	mov    0x8(%ebp),%eax
    1649:	89 04 24             	mov    %eax,(%esp)
    164c:	e8 bb fe ff ff       	call   150c <putc>
    1651:	e9 30 01 00 00       	jmp    1786 <printf+0x19a>
      }
    } else if(state == '%'){
    1656:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    165a:	0f 85 26 01 00 00    	jne    1786 <printf+0x19a>
      if(c == 'd'){
    1660:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1664:	75 2d                	jne    1693 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1666:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1669:	8b 00                	mov    (%eax),%eax
    166b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1672:	00 
    1673:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    167a:	00 
    167b:	89 44 24 04          	mov    %eax,0x4(%esp)
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	89 04 24             	mov    %eax,(%esp)
    1685:	e8 aa fe ff ff       	call   1534 <printint>
        ap++;
    168a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    168e:	e9 ec 00 00 00       	jmp    177f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1693:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1697:	74 06                	je     169f <printf+0xb3>
    1699:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    169d:	75 2d                	jne    16cc <printf+0xe0>
        printint(fd, *ap, 16, 0);
    169f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a2:	8b 00                	mov    (%eax),%eax
    16a4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16ab:	00 
    16ac:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    16b3:	00 
    16b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	89 04 24             	mov    %eax,(%esp)
    16be:	e8 71 fe ff ff       	call   1534 <printint>
        ap++;
    16c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16c7:	e9 b3 00 00 00       	jmp    177f <printf+0x193>
      } else if(c == 's'){
    16cc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16d0:	75 45                	jne    1717 <printf+0x12b>
        s = (char*)*ap;
    16d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d5:	8b 00                	mov    (%eax),%eax
    16d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16da:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16e2:	75 09                	jne    16ed <printf+0x101>
          s = "(null)";
    16e4:	c7 45 f4 b6 1c 00 00 	movl   $0x1cb6,-0xc(%ebp)
        while(*s != 0){
    16eb:	eb 1e                	jmp    170b <printf+0x11f>
    16ed:	eb 1c                	jmp    170b <printf+0x11f>
          putc(fd, *s);
    16ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f2:	0f b6 00             	movzbl (%eax),%eax
    16f5:	0f be c0             	movsbl %al,%eax
    16f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 04 24             	mov    %eax,(%esp)
    1702:	e8 05 fe ff ff       	call   150c <putc>
          s++;
    1707:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170e:	0f b6 00             	movzbl (%eax),%eax
    1711:	84 c0                	test   %al,%al
    1713:	75 da                	jne    16ef <printf+0x103>
    1715:	eb 68                	jmp    177f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1717:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    171b:	75 1d                	jne    173a <printf+0x14e>
        putc(fd, *ap);
    171d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1720:	8b 00                	mov    (%eax),%eax
    1722:	0f be c0             	movsbl %al,%eax
    1725:	89 44 24 04          	mov    %eax,0x4(%esp)
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	89 04 24             	mov    %eax,(%esp)
    172f:	e8 d8 fd ff ff       	call   150c <putc>
        ap++;
    1734:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1738:	eb 45                	jmp    177f <printf+0x193>
      } else if(c == '%'){
    173a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    173e:	75 17                	jne    1757 <printf+0x16b>
        putc(fd, c);
    1740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1743:	0f be c0             	movsbl %al,%eax
    1746:	89 44 24 04          	mov    %eax,0x4(%esp)
    174a:	8b 45 08             	mov    0x8(%ebp),%eax
    174d:	89 04 24             	mov    %eax,(%esp)
    1750:	e8 b7 fd ff ff       	call   150c <putc>
    1755:	eb 28                	jmp    177f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1757:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    175e:	00 
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	89 04 24             	mov    %eax,(%esp)
    1765:	e8 a2 fd ff ff       	call   150c <putc>
        putc(fd, c);
    176a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    176d:	0f be c0             	movsbl %al,%eax
    1770:	89 44 24 04          	mov    %eax,0x4(%esp)
    1774:	8b 45 08             	mov    0x8(%ebp),%eax
    1777:	89 04 24             	mov    %eax,(%esp)
    177a:	e8 8d fd ff ff       	call   150c <putc>
      }
      state = 0;
    177f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1786:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    178a:	8b 55 0c             	mov    0xc(%ebp),%edx
    178d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1790:	01 d0                	add    %edx,%eax
    1792:	0f b6 00             	movzbl (%eax),%eax
    1795:	84 c0                	test   %al,%al
    1797:	0f 85 71 fe ff ff    	jne    160e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    179d:	c9                   	leave  
    179e:	c3                   	ret    
    179f:	90                   	nop

000017a0 <free>:
    17a0:	55                   	push   %ebp
    17a1:	89 e5                	mov    %esp,%ebp
    17a3:	83 ec 10             	sub    $0x10,%esp
    17a6:	8b 45 08             	mov    0x8(%ebp),%eax
    17a9:	83 e8 08             	sub    $0x8,%eax
    17ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
    17af:	a1 68 20 00 00       	mov    0x2068,%eax
    17b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17b7:	eb 24                	jmp    17dd <free+0x3d>
    17b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17bc:	8b 00                	mov    (%eax),%eax
    17be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c1:	77 12                	ja     17d5 <free+0x35>
    17c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c9:	77 24                	ja     17ef <free+0x4f>
    17cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ce:	8b 00                	mov    (%eax),%eax
    17d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17d3:	77 1a                	ja     17ef <free+0x4f>
    17d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d8:	8b 00                	mov    (%eax),%eax
    17da:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17e3:	76 d4                	jbe    17b9 <free+0x19>
    17e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e8:	8b 00                	mov    (%eax),%eax
    17ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17ed:	76 ca                	jbe    17b9 <free+0x19>
    17ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f2:	8b 40 04             	mov    0x4(%eax),%eax
    17f5:	c1 e0 03             	shl    $0x3,%eax
    17f8:	89 c2                	mov    %eax,%edx
    17fa:	03 55 f8             	add    -0x8(%ebp),%edx
    17fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1800:	8b 00                	mov    (%eax),%eax
    1802:	39 c2                	cmp    %eax,%edx
    1804:	75 24                	jne    182a <free+0x8a>
    1806:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1809:	8b 50 04             	mov    0x4(%eax),%edx
    180c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180f:	8b 00                	mov    (%eax),%eax
    1811:	8b 40 04             	mov    0x4(%eax),%eax
    1814:	01 c2                	add    %eax,%edx
    1816:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1819:	89 50 04             	mov    %edx,0x4(%eax)
    181c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    181f:	8b 00                	mov    (%eax),%eax
    1821:	8b 10                	mov    (%eax),%edx
    1823:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1826:	89 10                	mov    %edx,(%eax)
    1828:	eb 0a                	jmp    1834 <free+0x94>
    182a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182d:	8b 10                	mov    (%eax),%edx
    182f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1832:	89 10                	mov    %edx,(%eax)
    1834:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1837:	8b 40 04             	mov    0x4(%eax),%eax
    183a:	c1 e0 03             	shl    $0x3,%eax
    183d:	03 45 fc             	add    -0x4(%ebp),%eax
    1840:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1843:	75 20                	jne    1865 <free+0xc5>
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	8b 50 04             	mov    0x4(%eax),%edx
    184b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    184e:	8b 40 04             	mov    0x4(%eax),%eax
    1851:	01 c2                	add    %eax,%edx
    1853:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1856:	89 50 04             	mov    %edx,0x4(%eax)
    1859:	8b 45 f8             	mov    -0x8(%ebp),%eax
    185c:	8b 10                	mov    (%eax),%edx
    185e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1861:	89 10                	mov    %edx,(%eax)
    1863:	eb 08                	jmp    186d <free+0xcd>
    1865:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1868:	8b 55 f8             	mov    -0x8(%ebp),%edx
    186b:	89 10                	mov    %edx,(%eax)
    186d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1870:	a3 68 20 00 00       	mov    %eax,0x2068
    1875:	c9                   	leave  
    1876:	c3                   	ret    

00001877 <morecore>:
    1877:	55                   	push   %ebp
    1878:	89 e5                	mov    %esp,%ebp
    187a:	83 ec 28             	sub    $0x28,%esp
    187d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1884:	77 07                	ja     188d <morecore+0x16>
    1886:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    188d:	8b 45 08             	mov    0x8(%ebp),%eax
    1890:	c1 e0 03             	shl    $0x3,%eax
    1893:	89 04 24             	mov    %eax,(%esp)
    1896:	e8 39 fc ff ff       	call   14d4 <sbrk>
    189b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    189e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    18a2:	75 07                	jne    18ab <morecore+0x34>
    18a4:	b8 00 00 00 00       	mov    $0x0,%eax
    18a9:	eb 22                	jmp    18cd <morecore+0x56>
    18ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b4:	8b 55 08             	mov    0x8(%ebp),%edx
    18b7:	89 50 04             	mov    %edx,0x4(%eax)
    18ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bd:	83 c0 08             	add    $0x8,%eax
    18c0:	89 04 24             	mov    %eax,(%esp)
    18c3:	e8 d8 fe ff ff       	call   17a0 <free>
    18c8:	a1 68 20 00 00       	mov    0x2068,%eax
    18cd:	c9                   	leave  
    18ce:	c3                   	ret    

000018cf <malloc>:
    18cf:	55                   	push   %ebp
    18d0:	89 e5                	mov    %esp,%ebp
    18d2:	83 ec 28             	sub    $0x28,%esp
    18d5:	8b 45 08             	mov    0x8(%ebp),%eax
    18d8:	83 c0 07             	add    $0x7,%eax
    18db:	c1 e8 03             	shr    $0x3,%eax
    18de:	83 c0 01             	add    $0x1,%eax
    18e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18e4:	a1 68 20 00 00       	mov    0x2068,%eax
    18e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18f0:	75 23                	jne    1915 <malloc+0x46>
    18f2:	c7 45 f0 60 20 00 00 	movl   $0x2060,-0x10(%ebp)
    18f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18fc:	a3 68 20 00 00       	mov    %eax,0x2068
    1901:	a1 68 20 00 00       	mov    0x2068,%eax
    1906:	a3 60 20 00 00       	mov    %eax,0x2060
    190b:	c7 05 64 20 00 00 00 	movl   $0x0,0x2064
    1912:	00 00 00 
    1915:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1918:	8b 00                	mov    (%eax),%eax
    191a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    191d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1920:	8b 40 04             	mov    0x4(%eax),%eax
    1923:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1926:	72 4d                	jb     1975 <malloc+0xa6>
    1928:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192b:	8b 40 04             	mov    0x4(%eax),%eax
    192e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1931:	75 0c                	jne    193f <malloc+0x70>
    1933:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1936:	8b 10                	mov    (%eax),%edx
    1938:	8b 45 f0             	mov    -0x10(%ebp),%eax
    193b:	89 10                	mov    %edx,(%eax)
    193d:	eb 26                	jmp    1965 <malloc+0x96>
    193f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1942:	8b 40 04             	mov    0x4(%eax),%eax
    1945:	89 c2                	mov    %eax,%edx
    1947:	2b 55 f4             	sub    -0xc(%ebp),%edx
    194a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    194d:	89 50 04             	mov    %edx,0x4(%eax)
    1950:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1953:	8b 40 04             	mov    0x4(%eax),%eax
    1956:	c1 e0 03             	shl    $0x3,%eax
    1959:	01 45 ec             	add    %eax,-0x14(%ebp)
    195c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    195f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1962:	89 50 04             	mov    %edx,0x4(%eax)
    1965:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1968:	a3 68 20 00 00       	mov    %eax,0x2068
    196d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1970:	83 c0 08             	add    $0x8,%eax
    1973:	eb 38                	jmp    19ad <malloc+0xde>
    1975:	a1 68 20 00 00       	mov    0x2068,%eax
    197a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    197d:	75 1b                	jne    199a <malloc+0xcb>
    197f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1982:	89 04 24             	mov    %eax,(%esp)
    1985:	e8 ed fe ff ff       	call   1877 <morecore>
    198a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    198d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1991:	75 07                	jne    199a <malloc+0xcb>
    1993:	b8 00 00 00 00       	mov    $0x0,%eax
    1998:	eb 13                	jmp    19ad <malloc+0xde>
    199a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    199d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19a3:	8b 00                	mov    (%eax),%eax
    19a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19a8:	e9 70 ff ff ff       	jmp    191d <malloc+0x4e>
    19ad:	c9                   	leave  
    19ae:	c3                   	ret    
    19af:	90                   	nop

000019b0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    19b6:	8b 55 08             	mov    0x8(%ebp),%edx
    19b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    19bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19bf:	f0 87 02             	lock xchg %eax,(%edx)
    19c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19c8:	c9                   	leave  
    19c9:	c3                   	ret    

000019ca <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19ca:	55                   	push   %ebp
    19cb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19cd:	8b 45 08             	mov    0x8(%ebp),%eax
    19d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19d6:	5d                   	pop    %ebp
    19d7:	c3                   	ret    

000019d8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19d8:	55                   	push   %ebp
    19d9:	89 e5                	mov    %esp,%ebp
    19db:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19de:	90                   	nop
    19df:	8b 45 08             	mov    0x8(%ebp),%eax
    19e2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19e9:	00 
    19ea:	89 04 24             	mov    %eax,(%esp)
    19ed:	e8 be ff ff ff       	call   19b0 <xchg>
    19f2:	85 c0                	test   %eax,%eax
    19f4:	75 e9                	jne    19df <lock_acquire+0x7>
}
    19f6:	c9                   	leave  
    19f7:	c3                   	ret    

000019f8 <lock_release>:
void lock_release(lock_t *lock){
    19f8:	55                   	push   %ebp
    19f9:	89 e5                	mov    %esp,%ebp
    19fb:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    19fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1a01:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a08:	00 
    1a09:	89 04 24             	mov    %eax,(%esp)
    1a0c:	e8 9f ff ff ff       	call   19b0 <xchg>
}
    1a11:	c9                   	leave  
    1a12:	c3                   	ret    

00001a13 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1a13:	55                   	push   %ebp
    1a14:	89 e5                	mov    %esp,%ebp
    1a16:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1a19:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a20:	e8 aa fe ff ff       	call   18cf <malloc>
    1a25:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a31:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a36:	85 c0                	test   %eax,%eax
    1a38:	74 14                	je     1a4e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a42:	89 c2                	mov    %eax,%edx
    1a44:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a49:	29 d0                	sub    %edx,%eax
    1a4b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a52:	75 1b                	jne    1a6f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a54:	c7 44 24 04 bd 1c 00 	movl   $0x1cbd,0x4(%esp)
    1a5b:	00 
    1a5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a63:	e8 84 fb ff ff       	call   15ec <printf>
        return 0;
    1a68:	b8 00 00 00 00       	mov    $0x0,%eax
    1a6d:	eb 6f                	jmp    1ade <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a6f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a72:	8b 55 08             	mov    0x8(%ebp),%edx
    1a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a78:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a7c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a80:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a87:	00 
    1a88:	89 04 24             	mov    %eax,(%esp)
    1a8b:	e8 5c fa ff ff       	call   14ec <clone>
    1a90:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a93:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a97:	79 1b                	jns    1ab4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1a99:	c7 44 24 04 cb 1c 00 	movl   $0x1ccb,0x4(%esp)
    1aa0:	00 
    1aa1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aa8:	e8 3f fb ff ff       	call   15ec <printf>
        return 0;
    1aad:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab2:	eb 2a                	jmp    1ade <thread_create+0xcb>
    }
    if(tid > 0){
    1ab4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ab8:	7e 05                	jle    1abf <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1aba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1abd:	eb 1f                	jmp    1ade <thread_create+0xcb>
    }
    if(tid == 0){
    1abf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ac3:	75 14                	jne    1ad9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1ac5:	c7 44 24 04 d8 1c 00 	movl   $0x1cd8,0x4(%esp)
    1acc:	00 
    1acd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ad4:	e8 13 fb ff ff       	call   15ec <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ad9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ade:	c9                   	leave  
    1adf:	c3                   	ret    

00001ae0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ae3:	a1 40 20 00 00       	mov    0x2040,%eax
    1ae8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1aee:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1af3:	a3 40 20 00 00       	mov    %eax,0x2040
    return (int)(rands % max);
    1af8:	a1 40 20 00 00       	mov    0x2040,%eax
    1afd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b00:	ba 00 00 00 00       	mov    $0x0,%edx
    1b05:	f7 f1                	div    %ecx
    1b07:	89 d0                	mov    %edx,%eax
}
    1b09:	5d                   	pop    %ebp
    1b0a:	c3                   	ret    
    1b0b:	90                   	nop

00001b0c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1b0c:	55                   	push   %ebp
    1b0d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1b0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b12:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1b18:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b22:	8b 45 08             	mov    0x8(%ebp),%eax
    1b25:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b2c:	5d                   	pop    %ebp
    1b2d:	c3                   	ret    

00001b2e <add_q>:

void add_q(struct queue *q, int v){
    1b2e:	55                   	push   %ebp
    1b2f:	89 e5                	mov    %esp,%ebp
    1b31:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b34:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b3b:	e8 8f fd ff ff       	call   18cf <malloc>
    1b40:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b46:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b50:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b53:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b55:	8b 45 08             	mov    0x8(%ebp),%eax
    1b58:	8b 40 04             	mov    0x4(%eax),%eax
    1b5b:	85 c0                	test   %eax,%eax
    1b5d:	75 0b                	jne    1b6a <add_q+0x3c>
        q->head = n;
    1b5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b62:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b65:	89 50 04             	mov    %edx,0x4(%eax)
    1b68:	eb 0c                	jmp    1b76 <add_q+0x48>
    }else{
        q->tail->next = n;
    1b6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6d:	8b 40 08             	mov    0x8(%eax),%eax
    1b70:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b73:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b7c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b82:	8b 00                	mov    (%eax),%eax
    1b84:	8d 50 01             	lea    0x1(%eax),%edx
    1b87:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8a:	89 10                	mov    %edx,(%eax)
}
    1b8c:	c9                   	leave  
    1b8d:	c3                   	ret    

00001b8e <empty_q>:

int empty_q(struct queue *q){
    1b8e:	55                   	push   %ebp
    1b8f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b91:	8b 45 08             	mov    0x8(%ebp),%eax
    1b94:	8b 00                	mov    (%eax),%eax
    1b96:	85 c0                	test   %eax,%eax
    1b98:	75 07                	jne    1ba1 <empty_q+0x13>
        return 1;
    1b9a:	b8 01 00 00 00       	mov    $0x1,%eax
    1b9f:	eb 05                	jmp    1ba6 <empty_q+0x18>
    else
        return 0;
    1ba1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1ba6:	5d                   	pop    %ebp
    1ba7:	c3                   	ret    

00001ba8 <pop_q>:
int pop_q(struct queue *q){
    1ba8:	55                   	push   %ebp
    1ba9:	89 e5                	mov    %esp,%ebp
    1bab:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1bae:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb1:	89 04 24             	mov    %eax,(%esp)
    1bb4:	e8 d5 ff ff ff       	call   1b8e <empty_q>
    1bb9:	85 c0                	test   %eax,%eax
    1bbb:	75 5d                	jne    1c1a <pop_q+0x72>
       val = q->head->value; 
    1bbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc0:	8b 40 04             	mov    0x4(%eax),%eax
    1bc3:	8b 00                	mov    (%eax),%eax
    1bc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1bc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcb:	8b 40 04             	mov    0x4(%eax),%eax
    1bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	8b 40 04             	mov    0x4(%eax),%eax
    1bd7:	8b 50 04             	mov    0x4(%eax),%edx
    1bda:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be3:	89 04 24             	mov    %eax,(%esp)
    1be6:	e8 b5 fb ff ff       	call   17a0 <free>
       q->size--;
    1beb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bee:	8b 00                	mov    (%eax),%eax
    1bf0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bf8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfb:	8b 00                	mov    (%eax),%eax
    1bfd:	85 c0                	test   %eax,%eax
    1bff:	75 14                	jne    1c15 <pop_q+0x6d>
            q->head = 0;
    1c01:	8b 45 08             	mov    0x8(%ebp),%eax
    1c04:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1c15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c18:	eb 05                	jmp    1c1f <pop_q+0x77>
    }
    return -1;
    1c1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c1f:	c9                   	leave  
    1c20:	c3                   	ret    
