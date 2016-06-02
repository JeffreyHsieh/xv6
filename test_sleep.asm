
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
    1009:	c7 44 24 04 38 1c 00 	movl   $0x1c38,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 d7 05 00 00       	call   15f4 <printf>
    lock_init(&ttable.lock);
    101d:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    1024:	e8 b5 09 00 00       	call   19de <lock_init>
    ttable.total = 0;
    1029:	c7 05 e4 21 00 00 00 	movl   $0x0,0x21e4
    1030:	00 00 00 

    lock_acquire(&ttable.lock);
    1033:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    103a:	e8 ad 09 00 00       	call   19ec <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    103f:	c7 44 24 1c e4 20 00 	movl   $0x20e4,0x1c(%esp)
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
    1058:	81 7c 24 1c e4 21 00 	cmpl   $0x21e4,0x1c(%esp)
    105f:	00 
    1060:	72 e7                	jb     1049 <main+0x49>
        t->tid = 0;
    }
    lock_release(&ttable.lock);
    1062:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    1069:	e8 9e 09 00 00       	call   1a0c <lock_release>
    printf(1,"testing thread sleep and wakeup \n\n\n");
    106e:	c7 44 24 04 48 1c 00 	movl   $0x1c48,0x4(%esp)
    1075:	00 
    1076:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107d:	e8 72 05 00 00       	call   15f4 <printf>
    void *stack = thread_create(func,0);
    1082:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1089:	00 
    108a:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    1091:	e8 91 09 00 00       	call   1a27 <thread_create>
    1096:	89 44 24 14          	mov    %eax,0x14(%esp)
    thread_create(func,0);
    109a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10a1:	00 
    10a2:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    10a9:	e8 79 09 00 00       	call   1a27 <thread_create>
    thread_create(func,0);
    10ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10b5:	00 
    10b6:	c7 04 24 69 11 00 00 	movl   $0x1169,(%esp)
    10bd:	e8 65 09 00 00       	call   1a27 <thread_create>

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
    10dd:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    10e4:	e8 03 09 00 00       	call   19ec <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    10e9:	c7 44 24 1c e4 20 00 	movl   $0x20e4,0x1c(%esp)
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
    1107:	c7 44 24 04 6c 1c 00 	movl   $0x1c6c,0x4(%esp)
    110e:	00 
    110f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1116:	e8 d9 04 00 00       	call   15f4 <printf>
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
    1133:	81 7c 24 1c e4 21 00 	cmpl   $0x21e4,0x1c(%esp)
    113a:	00 
    113b:	72 b6                	jb     10f3 <main+0xf3>
            printf(1,"found one... %d,   wake up lazy boy !!!\n",t->tid);
            twakeup(t->tid);
            i++;
        }
    }
    lock_release(&ttable.lock);
    113d:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    1144:	e8 c3 08 00 00       	call   1a0c <lock_release>
    wait();
    1149:	e8 06 03 00 00       	call   1454 <wait>
    wait();
    114e:	e8 01 03 00 00       	call   1454 <wait>
    wait();
    1153:	e8 fc 02 00 00       	call   1454 <wait>
    free(stack);
    1158:	8b 44 24 14          	mov    0x14(%esp),%eax
    115c:	89 04 24             	mov    %eax,(%esp)
    115f:	e8 44 06 00 00       	call   17a8 <free>
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
    1177:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    117e:	e8 69 08 00 00       	call   19ec <lock_acquire>
    (ttable.threads[ttable.total]).tid = tid;
    1183:	a1 e4 21 00 00       	mov    0x21e4,%eax
    1188:	8b 55 f4             	mov    -0xc(%ebp),%edx
    118b:	89 14 85 e4 20 00 00 	mov    %edx,0x20e4(,%eax,4)
    ttable.total++;
    1192:	a1 e4 21 00 00       	mov    0x21e4,%eax
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	a3 e4 21 00 00       	mov    %eax,0x21e4
    lock_release(&ttable.lock);
    119f:	c7 04 24 e0 20 00 00 	movl   $0x20e0,(%esp)
    11a6:	e8 61 08 00 00       	call   1a0c <lock_release>

    printf(1,"I am thread %d, is about to sleep\n",tid);
    11ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ae:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b2:	c7 44 24 04 98 1c 00 	movl   $0x1c98,0x4(%esp)
    11b9:	00 
    11ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c1:	e8 2e 04 00 00       	call   15f4 <printf>
    tsleep();
    11c6:	e8 31 03 00 00       	call   14fc <tsleep>
    printf(1,"I am wake up!\n");
    11cb:	c7 44 24 04 bb 1c 00 	movl   $0x1cbb,0x4(%esp)
    11d2:	00 
    11d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11da:	e8 15 04 00 00       	call   15f4 <printf>
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
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1444:	b8 01 00 00 00       	mov    $0x1,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <exit>:
SYSCALL(exit)
    144c:	b8 02 00 00 00       	mov    $0x2,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <wait>:
SYSCALL(wait)
    1454:	b8 03 00 00 00       	mov    $0x3,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <pipe>:
SYSCALL(pipe)
    145c:	b8 04 00 00 00       	mov    $0x4,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <read>:
SYSCALL(read)
    1464:	b8 05 00 00 00       	mov    $0x5,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <write>:
SYSCALL(write)
    146c:	b8 10 00 00 00       	mov    $0x10,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <close>:
SYSCALL(close)
    1474:	b8 15 00 00 00       	mov    $0x15,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <kill>:
SYSCALL(kill)
    147c:	b8 06 00 00 00       	mov    $0x6,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <exec>:
SYSCALL(exec)
    1484:	b8 07 00 00 00       	mov    $0x7,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <open>:
SYSCALL(open)
    148c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <mknod>:
SYSCALL(mknod)
    1494:	b8 11 00 00 00       	mov    $0x11,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <unlink>:
SYSCALL(unlink)
    149c:	b8 12 00 00 00       	mov    $0x12,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <fstat>:
SYSCALL(fstat)
    14a4:	b8 08 00 00 00       	mov    $0x8,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <link>:
SYSCALL(link)
    14ac:	b8 13 00 00 00       	mov    $0x13,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <mkdir>:
SYSCALL(mkdir)
    14b4:	b8 14 00 00 00       	mov    $0x14,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <chdir>:
SYSCALL(chdir)
    14bc:	b8 09 00 00 00       	mov    $0x9,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <dup>:
SYSCALL(dup)
    14c4:	b8 0a 00 00 00       	mov    $0xa,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <getpid>:
SYSCALL(getpid)
    14cc:	b8 0b 00 00 00       	mov    $0xb,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <sbrk>:
SYSCALL(sbrk)
    14d4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <sleep>:
SYSCALL(sleep)
    14dc:	b8 0d 00 00 00       	mov    $0xd,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <uptime>:
SYSCALL(uptime)
    14e4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14e9:	cd 40                	int    $0x40
    14eb:	c3                   	ret    

000014ec <clone>:
SYSCALL(clone)
    14ec:	b8 16 00 00 00       	mov    $0x16,%eax
    14f1:	cd 40                	int    $0x40
    14f3:	c3                   	ret    

000014f4 <texit>:
SYSCALL(texit)
    14f4:	b8 17 00 00 00       	mov    $0x17,%eax
    14f9:	cd 40                	int    $0x40
    14fb:	c3                   	ret    

000014fc <tsleep>:
SYSCALL(tsleep)
    14fc:	b8 18 00 00 00       	mov    $0x18,%eax
    1501:	cd 40                	int    $0x40
    1503:	c3                   	ret    

00001504 <twakeup>:
SYSCALL(twakeup)
    1504:	b8 19 00 00 00       	mov    $0x19,%eax
    1509:	cd 40                	int    $0x40
    150b:	c3                   	ret    

0000150c <thread_yield>:
SYSCALL(thread_yield)
    150c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1511:	cd 40                	int    $0x40
    1513:	c3                   	ret    

00001514 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1514:	55                   	push   %ebp
    1515:	89 e5                	mov    %esp,%ebp
    1517:	83 ec 18             	sub    $0x18,%esp
    151a:	8b 45 0c             	mov    0xc(%ebp),%eax
    151d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1520:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1527:	00 
    1528:	8d 45 f4             	lea    -0xc(%ebp),%eax
    152b:	89 44 24 04          	mov    %eax,0x4(%esp)
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	89 04 24             	mov    %eax,(%esp)
    1535:	e8 32 ff ff ff       	call   146c <write>
}
    153a:	c9                   	leave  
    153b:	c3                   	ret    

0000153c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    153c:	55                   	push   %ebp
    153d:	89 e5                	mov    %esp,%ebp
    153f:	56                   	push   %esi
    1540:	53                   	push   %ebx
    1541:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1544:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    154b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    154f:	74 17                	je     1568 <printint+0x2c>
    1551:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1555:	79 11                	jns    1568 <printint+0x2c>
    neg = 1;
    1557:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    155e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1561:	f7 d8                	neg    %eax
    1563:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1566:	eb 06                	jmp    156e <printint+0x32>
  } else {
    x = xx;
    1568:	8b 45 0c             	mov    0xc(%ebp),%eax
    156b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    156e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1575:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1578:	8d 41 01             	lea    0x1(%ecx),%eax
    157b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    157e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1581:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1584:	ba 00 00 00 00       	mov    $0x0,%edx
    1589:	f7 f3                	div    %ebx
    158b:	89 d0                	mov    %edx,%eax
    158d:	0f b6 80 a0 20 00 00 	movzbl 0x20a0(%eax),%eax
    1594:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1598:	8b 75 10             	mov    0x10(%ebp),%esi
    159b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    159e:	ba 00 00 00 00       	mov    $0x0,%edx
    15a3:	f7 f6                	div    %esi
    15a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15ac:	75 c7                	jne    1575 <printint+0x39>
  if(neg)
    15ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15b2:	74 10                	je     15c4 <printint+0x88>
    buf[i++] = '-';
    15b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b7:	8d 50 01             	lea    0x1(%eax),%edx
    15ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15bd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    15c2:	eb 1f                	jmp    15e3 <printint+0xa7>
    15c4:	eb 1d                	jmp    15e3 <printint+0xa7>
    putc(fd, buf[i]);
    15c6:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	01 d0                	add    %edx,%eax
    15ce:	0f b6 00             	movzbl (%eax),%eax
    15d1:	0f be c0             	movsbl %al,%eax
    15d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	89 04 24             	mov    %eax,(%esp)
    15de:	e8 31 ff ff ff       	call   1514 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15e3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15eb:	79 d9                	jns    15c6 <printint+0x8a>
    putc(fd, buf[i]);
}
    15ed:	83 c4 30             	add    $0x30,%esp
    15f0:	5b                   	pop    %ebx
    15f1:	5e                   	pop    %esi
    15f2:	5d                   	pop    %ebp
    15f3:	c3                   	ret    

000015f4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15f4:	55                   	push   %ebp
    15f5:	89 e5                	mov    %esp,%ebp
    15f7:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1601:	8d 45 0c             	lea    0xc(%ebp),%eax
    1604:	83 c0 04             	add    $0x4,%eax
    1607:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    160a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1611:	e9 7c 01 00 00       	jmp    1792 <printf+0x19e>
    c = fmt[i] & 0xff;
    1616:	8b 55 0c             	mov    0xc(%ebp),%edx
    1619:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161c:	01 d0                	add    %edx,%eax
    161e:	0f b6 00             	movzbl (%eax),%eax
    1621:	0f be c0             	movsbl %al,%eax
    1624:	25 ff 00 00 00       	and    $0xff,%eax
    1629:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    162c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1630:	75 2c                	jne    165e <printf+0x6a>
      if(c == '%'){
    1632:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1636:	75 0c                	jne    1644 <printf+0x50>
        state = '%';
    1638:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    163f:	e9 4a 01 00 00       	jmp    178e <printf+0x19a>
      } else {
        putc(fd, c);
    1644:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1647:	0f be c0             	movsbl %al,%eax
    164a:	89 44 24 04          	mov    %eax,0x4(%esp)
    164e:	8b 45 08             	mov    0x8(%ebp),%eax
    1651:	89 04 24             	mov    %eax,(%esp)
    1654:	e8 bb fe ff ff       	call   1514 <putc>
    1659:	e9 30 01 00 00       	jmp    178e <printf+0x19a>
      }
    } else if(state == '%'){
    165e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1662:	0f 85 26 01 00 00    	jne    178e <printf+0x19a>
      if(c == 'd'){
    1668:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    166c:	75 2d                	jne    169b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    166e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1671:	8b 00                	mov    (%eax),%eax
    1673:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    167a:	00 
    167b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1682:	00 
    1683:	89 44 24 04          	mov    %eax,0x4(%esp)
    1687:	8b 45 08             	mov    0x8(%ebp),%eax
    168a:	89 04 24             	mov    %eax,(%esp)
    168d:	e8 aa fe ff ff       	call   153c <printint>
        ap++;
    1692:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1696:	e9 ec 00 00 00       	jmp    1787 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    169b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    169f:	74 06                	je     16a7 <printf+0xb3>
    16a1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    16a5:	75 2d                	jne    16d4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    16a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16aa:	8b 00                	mov    (%eax),%eax
    16ac:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16b3:	00 
    16b4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    16bb:	00 
    16bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    16c0:	8b 45 08             	mov    0x8(%ebp),%eax
    16c3:	89 04 24             	mov    %eax,(%esp)
    16c6:	e8 71 fe ff ff       	call   153c <printint>
        ap++;
    16cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16cf:	e9 b3 00 00 00       	jmp    1787 <printf+0x193>
      } else if(c == 's'){
    16d4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16d8:	75 45                	jne    171f <printf+0x12b>
        s = (char*)*ap;
    16da:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16dd:	8b 00                	mov    (%eax),%eax
    16df:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16ea:	75 09                	jne    16f5 <printf+0x101>
          s = "(null)";
    16ec:	c7 45 f4 ca 1c 00 00 	movl   $0x1cca,-0xc(%ebp)
        while(*s != 0){
    16f3:	eb 1e                	jmp    1713 <printf+0x11f>
    16f5:	eb 1c                	jmp    1713 <printf+0x11f>
          putc(fd, *s);
    16f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fa:	0f b6 00             	movzbl (%eax),%eax
    16fd:	0f be c0             	movsbl %al,%eax
    1700:	89 44 24 04          	mov    %eax,0x4(%esp)
    1704:	8b 45 08             	mov    0x8(%ebp),%eax
    1707:	89 04 24             	mov    %eax,(%esp)
    170a:	e8 05 fe ff ff       	call   1514 <putc>
          s++;
    170f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1713:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1716:	0f b6 00             	movzbl (%eax),%eax
    1719:	84 c0                	test   %al,%al
    171b:	75 da                	jne    16f7 <printf+0x103>
    171d:	eb 68                	jmp    1787 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    171f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1723:	75 1d                	jne    1742 <printf+0x14e>
        putc(fd, *ap);
    1725:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1728:	8b 00                	mov    (%eax),%eax
    172a:	0f be c0             	movsbl %al,%eax
    172d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1731:	8b 45 08             	mov    0x8(%ebp),%eax
    1734:	89 04 24             	mov    %eax,(%esp)
    1737:	e8 d8 fd ff ff       	call   1514 <putc>
        ap++;
    173c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1740:	eb 45                	jmp    1787 <printf+0x193>
      } else if(c == '%'){
    1742:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1746:	75 17                	jne    175f <printf+0x16b>
        putc(fd, c);
    1748:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    174b:	0f be c0             	movsbl %al,%eax
    174e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1752:	8b 45 08             	mov    0x8(%ebp),%eax
    1755:	89 04 24             	mov    %eax,(%esp)
    1758:	e8 b7 fd ff ff       	call   1514 <putc>
    175d:	eb 28                	jmp    1787 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    175f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1766:	00 
    1767:	8b 45 08             	mov    0x8(%ebp),%eax
    176a:	89 04 24             	mov    %eax,(%esp)
    176d:	e8 a2 fd ff ff       	call   1514 <putc>
        putc(fd, c);
    1772:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1775:	0f be c0             	movsbl %al,%eax
    1778:	89 44 24 04          	mov    %eax,0x4(%esp)
    177c:	8b 45 08             	mov    0x8(%ebp),%eax
    177f:	89 04 24             	mov    %eax,(%esp)
    1782:	e8 8d fd ff ff       	call   1514 <putc>
      }
      state = 0;
    1787:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    178e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1792:	8b 55 0c             	mov    0xc(%ebp),%edx
    1795:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1798:	01 d0                	add    %edx,%eax
    179a:	0f b6 00             	movzbl (%eax),%eax
    179d:	84 c0                	test   %al,%al
    179f:	0f 85 71 fe ff ff    	jne    1616 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17a5:	c9                   	leave  
    17a6:	c3                   	ret    
    17a7:	90                   	nop

000017a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17a8:	55                   	push   %ebp
    17a9:	89 e5                	mov    %esp,%ebp
    17ab:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17ae:	8b 45 08             	mov    0x8(%ebp),%eax
    17b1:	83 e8 08             	sub    $0x8,%eax
    17b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17b7:	a1 c8 20 00 00       	mov    0x20c8,%eax
    17bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17bf:	eb 24                	jmp    17e5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c4:	8b 00                	mov    (%eax),%eax
    17c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c9:	77 12                	ja     17dd <free+0x35>
    17cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17d1:	77 24                	ja     17f7 <free+0x4f>
    17d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d6:	8b 00                	mov    (%eax),%eax
    17d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17db:	77 1a                	ja     17f7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e0:	8b 00                	mov    (%eax),%eax
    17e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17eb:	76 d4                	jbe    17c1 <free+0x19>
    17ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f0:	8b 00                	mov    (%eax),%eax
    17f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17f5:	76 ca                	jbe    17c1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    17f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17fa:	8b 40 04             	mov    0x4(%eax),%eax
    17fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1804:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1807:	01 c2                	add    %eax,%edx
    1809:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180c:	8b 00                	mov    (%eax),%eax
    180e:	39 c2                	cmp    %eax,%edx
    1810:	75 24                	jne    1836 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1812:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1815:	8b 50 04             	mov    0x4(%eax),%edx
    1818:	8b 45 fc             	mov    -0x4(%ebp),%eax
    181b:	8b 00                	mov    (%eax),%eax
    181d:	8b 40 04             	mov    0x4(%eax),%eax
    1820:	01 c2                	add    %eax,%edx
    1822:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1825:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1828:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182b:	8b 00                	mov    (%eax),%eax
    182d:	8b 10                	mov    (%eax),%edx
    182f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1832:	89 10                	mov    %edx,(%eax)
    1834:	eb 0a                	jmp    1840 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1836:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1839:	8b 10                	mov    (%eax),%edx
    183b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1840:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1843:	8b 40 04             	mov    0x4(%eax),%eax
    1846:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1850:	01 d0                	add    %edx,%eax
    1852:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1855:	75 20                	jne    1877 <free+0xcf>
    p->s.size += bp->s.size;
    1857:	8b 45 fc             	mov    -0x4(%ebp),%eax
    185a:	8b 50 04             	mov    0x4(%eax),%edx
    185d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1860:	8b 40 04             	mov    0x4(%eax),%eax
    1863:	01 c2                	add    %eax,%edx
    1865:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1868:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    186b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    186e:	8b 10                	mov    (%eax),%edx
    1870:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1873:	89 10                	mov    %edx,(%eax)
    1875:	eb 08                	jmp    187f <free+0xd7>
  } else
    p->s.ptr = bp;
    1877:	8b 45 fc             	mov    -0x4(%ebp),%eax
    187a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    187d:	89 10                	mov    %edx,(%eax)
  freep = p;
    187f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1882:	a3 c8 20 00 00       	mov    %eax,0x20c8
}
    1887:	c9                   	leave  
    1888:	c3                   	ret    

00001889 <morecore>:

static Header*
morecore(uint nu)
{
    1889:	55                   	push   %ebp
    188a:	89 e5                	mov    %esp,%ebp
    188c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    188f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1896:	77 07                	ja     189f <morecore+0x16>
    nu = 4096;
    1898:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    189f:	8b 45 08             	mov    0x8(%ebp),%eax
    18a2:	c1 e0 03             	shl    $0x3,%eax
    18a5:	89 04 24             	mov    %eax,(%esp)
    18a8:	e8 27 fc ff ff       	call   14d4 <sbrk>
    18ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    18b0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    18b4:	75 07                	jne    18bd <morecore+0x34>
    return 0;
    18b6:	b8 00 00 00 00       	mov    $0x0,%eax
    18bb:	eb 22                	jmp    18df <morecore+0x56>
  hp = (Header*)p;
    18bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    18c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c6:	8b 55 08             	mov    0x8(%ebp),%edx
    18c9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18cf:	83 c0 08             	add    $0x8,%eax
    18d2:	89 04 24             	mov    %eax,(%esp)
    18d5:	e8 ce fe ff ff       	call   17a8 <free>
  return freep;
    18da:	a1 c8 20 00 00       	mov    0x20c8,%eax
}
    18df:	c9                   	leave  
    18e0:	c3                   	ret    

000018e1 <malloc>:

void*
malloc(uint nbytes)
{
    18e1:	55                   	push   %ebp
    18e2:	89 e5                	mov    %esp,%ebp
    18e4:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18e7:	8b 45 08             	mov    0x8(%ebp),%eax
    18ea:	83 c0 07             	add    $0x7,%eax
    18ed:	c1 e8 03             	shr    $0x3,%eax
    18f0:	83 c0 01             	add    $0x1,%eax
    18f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    18f6:	a1 c8 20 00 00       	mov    0x20c8,%eax
    18fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18fe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1902:	75 23                	jne    1927 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1904:	c7 45 f0 c0 20 00 00 	movl   $0x20c0,-0x10(%ebp)
    190b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    190e:	a3 c8 20 00 00       	mov    %eax,0x20c8
    1913:	a1 c8 20 00 00       	mov    0x20c8,%eax
    1918:	a3 c0 20 00 00       	mov    %eax,0x20c0
    base.s.size = 0;
    191d:	c7 05 c4 20 00 00 00 	movl   $0x0,0x20c4
    1924:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1927:	8b 45 f0             	mov    -0x10(%ebp),%eax
    192a:	8b 00                	mov    (%eax),%eax
    192c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    192f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1932:	8b 40 04             	mov    0x4(%eax),%eax
    1935:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1938:	72 4d                	jb     1987 <malloc+0xa6>
      if(p->s.size == nunits)
    193a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    193d:	8b 40 04             	mov    0x4(%eax),%eax
    1940:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1943:	75 0c                	jne    1951 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1948:	8b 10                	mov    (%eax),%edx
    194a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    194d:	89 10                	mov    %edx,(%eax)
    194f:	eb 26                	jmp    1977 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1951:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1954:	8b 40 04             	mov    0x4(%eax),%eax
    1957:	2b 45 ec             	sub    -0x14(%ebp),%eax
    195a:	89 c2                	mov    %eax,%edx
    195c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1962:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1965:	8b 40 04             	mov    0x4(%eax),%eax
    1968:	c1 e0 03             	shl    $0x3,%eax
    196b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1971:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1974:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1977:	8b 45 f0             	mov    -0x10(%ebp),%eax
    197a:	a3 c8 20 00 00       	mov    %eax,0x20c8
      return (void*)(p + 1);
    197f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1982:	83 c0 08             	add    $0x8,%eax
    1985:	eb 38                	jmp    19bf <malloc+0xde>
    }
    if(p == freep)
    1987:	a1 c8 20 00 00       	mov    0x20c8,%eax
    198c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    198f:	75 1b                	jne    19ac <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1991:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1994:	89 04 24             	mov    %eax,(%esp)
    1997:	e8 ed fe ff ff       	call   1889 <morecore>
    199c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    199f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19a3:	75 07                	jne    19ac <malloc+0xcb>
        return 0;
    19a5:	b8 00 00 00 00       	mov    $0x0,%eax
    19aa:	eb 13                	jmp    19bf <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b5:	8b 00                	mov    (%eax),%eax
    19b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    19ba:	e9 70 ff ff ff       	jmp    192f <malloc+0x4e>
}
    19bf:	c9                   	leave  
    19c0:	c3                   	ret    
    19c1:	66 90                	xchg   %ax,%ax
    19c3:	90                   	nop

000019c4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    19c4:	55                   	push   %ebp
    19c5:	89 e5                	mov    %esp,%ebp
    19c7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    19ca:	8b 55 08             	mov    0x8(%ebp),%edx
    19cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    19d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19d3:	f0 87 02             	lock xchg %eax,(%edx)
    19d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19dc:	c9                   	leave  
    19dd:	c3                   	ret    

000019de <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19de:	55                   	push   %ebp
    19df:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19e1:	8b 45 08             	mov    0x8(%ebp),%eax
    19e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19ea:	5d                   	pop    %ebp
    19eb:	c3                   	ret    

000019ec <lock_acquire>:
void lock_acquire(lock_t *lock){
    19ec:	55                   	push   %ebp
    19ed:	89 e5                	mov    %esp,%ebp
    19ef:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19f2:	90                   	nop
    19f3:	8b 45 08             	mov    0x8(%ebp),%eax
    19f6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19fd:	00 
    19fe:	89 04 24             	mov    %eax,(%esp)
    1a01:	e8 be ff ff ff       	call   19c4 <xchg>
    1a06:	85 c0                	test   %eax,%eax
    1a08:	75 e9                	jne    19f3 <lock_acquire+0x7>
}
    1a0a:	c9                   	leave  
    1a0b:	c3                   	ret    

00001a0c <lock_release>:
void lock_release(lock_t *lock){
    1a0c:	55                   	push   %ebp
    1a0d:	89 e5                	mov    %esp,%ebp
    1a0f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a1c:	00 
    1a1d:	89 04 24             	mov    %eax,(%esp)
    1a20:	e8 9f ff ff ff       	call   19c4 <xchg>
}
    1a25:	c9                   	leave  
    1a26:	c3                   	ret    

00001a27 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1a27:	55                   	push   %ebp
    1a28:	89 e5                	mov    %esp,%ebp
    1a2a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1a2d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a34:	e8 a8 fe ff ff       	call   18e1 <malloc>
    1a39:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a45:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a4a:	85 c0                	test   %eax,%eax
    1a4c:	74 14                	je     1a62 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a51:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a56:	89 c2                	mov    %eax,%edx
    1a58:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a5d:	29 d0                	sub    %edx,%eax
    1a5f:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a62:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a66:	75 1b                	jne    1a83 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a68:	c7 44 24 04 d1 1c 00 	movl   $0x1cd1,0x4(%esp)
    1a6f:	00 
    1a70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a77:	e8 78 fb ff ff       	call   15f4 <printf>
        return 0;
    1a7c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a81:	eb 6f                	jmp    1af2 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a83:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a86:	8b 55 08             	mov    0x8(%ebp),%edx
    1a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a90:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a94:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a9b:	00 
    1a9c:	89 04 24             	mov    %eax,(%esp)
    1a9f:	e8 48 fa ff ff       	call   14ec <clone>
    1aa4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1aa7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aab:	79 1b                	jns    1ac8 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1aad:	c7 44 24 04 df 1c 00 	movl   $0x1cdf,0x4(%esp)
    1ab4:	00 
    1ab5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1abc:	e8 33 fb ff ff       	call   15f4 <printf>
        return 0;
    1ac1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ac6:	eb 2a                	jmp    1af2 <thread_create+0xcb>
    }
    if(tid > 0){
    1ac8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1acc:	7e 05                	jle    1ad3 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad1:	eb 1f                	jmp    1af2 <thread_create+0xcb>
    }
    if(tid == 0){
    1ad3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ad7:	75 14                	jne    1aed <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1ad9:	c7 44 24 04 ec 1c 00 	movl   $0x1cec,0x4(%esp)
    1ae0:	00 
    1ae1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae8:	e8 07 fb ff ff       	call   15f4 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1aed:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1af2:	c9                   	leave  
    1af3:	c3                   	ret    

00001af4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1af4:	55                   	push   %ebp
    1af5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1af7:	a1 b4 20 00 00       	mov    0x20b4,%eax
    1afc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1b02:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1b07:	a3 b4 20 00 00       	mov    %eax,0x20b4
    return (int)(rands % max);
    1b0c:	a1 b4 20 00 00       	mov    0x20b4,%eax
    1b11:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b14:	ba 00 00 00 00       	mov    $0x0,%edx
    1b19:	f7 f1                	div    %ecx
    1b1b:	89 d0                	mov    %edx,%eax
}
    1b1d:	5d                   	pop    %ebp
    1b1e:	c3                   	ret    
    1b1f:	90                   	nop

00001b20 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1b20:	55                   	push   %ebp
    1b21:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1b23:	8b 45 08             	mov    0x8(%ebp),%eax
    1b26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1b2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b36:	8b 45 08             	mov    0x8(%ebp),%eax
    1b39:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b40:	5d                   	pop    %ebp
    1b41:	c3                   	ret    

00001b42 <add_q>:

void add_q(struct queue *q, int v){
    1b42:	55                   	push   %ebp
    1b43:	89 e5                	mov    %esp,%ebp
    1b45:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b48:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b4f:	e8 8d fd ff ff       	call   18e1 <malloc>
    1b54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b64:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b67:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b69:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6c:	8b 40 04             	mov    0x4(%eax),%eax
    1b6f:	85 c0                	test   %eax,%eax
    1b71:	75 0b                	jne    1b7e <add_q+0x3c>
        q->head = n;
    1b73:	8b 45 08             	mov    0x8(%ebp),%eax
    1b76:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b79:	89 50 04             	mov    %edx,0x4(%eax)
    1b7c:	eb 0c                	jmp    1b8a <add_q+0x48>
    }else{
        q->tail->next = n;
    1b7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b81:	8b 40 08             	mov    0x8(%eax),%eax
    1b84:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b87:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b90:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b93:	8b 45 08             	mov    0x8(%ebp),%eax
    1b96:	8b 00                	mov    (%eax),%eax
    1b98:	8d 50 01             	lea    0x1(%eax),%edx
    1b9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9e:	89 10                	mov    %edx,(%eax)
}
    1ba0:	c9                   	leave  
    1ba1:	c3                   	ret    

00001ba2 <empty_q>:

int empty_q(struct queue *q){
    1ba2:	55                   	push   %ebp
    1ba3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1ba5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba8:	8b 00                	mov    (%eax),%eax
    1baa:	85 c0                	test   %eax,%eax
    1bac:	75 07                	jne    1bb5 <empty_q+0x13>
        return 1;
    1bae:	b8 01 00 00 00       	mov    $0x1,%eax
    1bb3:	eb 05                	jmp    1bba <empty_q+0x18>
    else
        return 0;
    1bb5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1bba:	5d                   	pop    %ebp
    1bbb:	c3                   	ret    

00001bbc <pop_q>:
int pop_q(struct queue *q){
    1bbc:	55                   	push   %ebp
    1bbd:	89 e5                	mov    %esp,%ebp
    1bbf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1bc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc5:	89 04 24             	mov    %eax,(%esp)
    1bc8:	e8 d5 ff ff ff       	call   1ba2 <empty_q>
    1bcd:	85 c0                	test   %eax,%eax
    1bcf:	75 5d                	jne    1c2e <pop_q+0x72>
       val = q->head->value; 
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	8b 40 04             	mov    0x4(%eax),%eax
    1bd7:	8b 00                	mov    (%eax),%eax
    1bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1bdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdf:	8b 40 04             	mov    0x4(%eax),%eax
    1be2:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	8b 40 04             	mov    0x4(%eax),%eax
    1beb:	8b 50 04             	mov    0x4(%eax),%edx
    1bee:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf7:	89 04 24             	mov    %eax,(%esp)
    1bfa:	e8 a9 fb ff ff       	call   17a8 <free>
       q->size--;
    1bff:	8b 45 08             	mov    0x8(%ebp),%eax
    1c02:	8b 00                	mov    (%eax),%eax
    1c04:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c07:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1c0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0f:	8b 00                	mov    (%eax),%eax
    1c11:	85 c0                	test   %eax,%eax
    1c13:	75 14                	jne    1c29 <pop_q+0x6d>
            q->head = 0;
    1c15:	8b 45 08             	mov    0x8(%ebp),%eax
    1c18:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1c1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2c:	eb 05                	jmp    1c33 <pop_q+0x77>
    }
    return -1;
    1c2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c33:	c9                   	leave  
    1c34:	c3                   	ret    
