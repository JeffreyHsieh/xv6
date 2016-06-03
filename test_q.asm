
_test_q:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"
#include "queue.h"

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    struct queue *q = malloc(sizeof(struct queue));
    1009:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    1010:	e8 74 07 00 00       	call   1789 <malloc>
    1015:	89 44 24 18          	mov    %eax,0x18(%esp)
    int i;
    init_q(q);
    1019:	8b 44 24 18          	mov    0x18(%esp),%eax
    101d:	89 04 24             	mov    %eax,(%esp)
    1020:	e8 a3 09 00 00       	call   19c8 <init_q>
    for(i=0;i<10;i++){
    1025:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    102c:	00 
    102d:	eb 19                	jmp    1048 <main+0x48>
        add_q(q,i);
    102f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1033:	89 44 24 04          	mov    %eax,0x4(%esp)
    1037:	8b 44 24 18          	mov    0x18(%esp),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 a7 09 00 00       	call   19ea <add_q>

int main(){
    struct queue *q = malloc(sizeof(struct queue));
    int i;
    init_q(q);
    for(i=0;i<10;i++){
    1043:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1048:	83 7c 24 1c 09       	cmpl   $0x9,0x1c(%esp)
    104d:	7e e0                	jle    102f <main+0x2f>
        add_q(q,i);
    }
    for(;!empty_q(q);){
    104f:	eb 24                	jmp    1075 <main+0x75>
        printf(1,"pop %d\n",pop_q(q));
    1051:	8b 44 24 18          	mov    0x18(%esp),%eax
    1055:	89 04 24             	mov    %eax,(%esp)
    1058:	e8 07 0a 00 00       	call   1a64 <pop_q>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 dd 1a 00 	movl   $0x1add,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 27 04 00 00       	call   149c <printf>
    int i;
    init_q(q);
    for(i=0;i<10;i++){
        add_q(q,i);
    }
    for(;!empty_q(q);){
    1075:	8b 44 24 18          	mov    0x18(%esp),%eax
    1079:	89 04 24             	mov    %eax,(%esp)
    107c:	e8 c9 09 00 00       	call   1a4a <empty_q>
    1081:	85 c0                	test   %eax,%eax
    1083:	74 cc                	je     1051 <main+0x51>
        printf(1,"pop %d\n",pop_q(q));
    }
    exit();
    1085:	e8 6a 02 00 00       	call   12f4 <exit>
    108a:	66 90                	xchg   %ax,%ax

0000108c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    108c:	55                   	push   %ebp
    108d:	89 e5                	mov    %esp,%ebp
    108f:	57                   	push   %edi
    1090:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1091:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1094:	8b 55 10             	mov    0x10(%ebp),%edx
    1097:	8b 45 0c             	mov    0xc(%ebp),%eax
    109a:	89 cb                	mov    %ecx,%ebx
    109c:	89 df                	mov    %ebx,%edi
    109e:	89 d1                	mov    %edx,%ecx
    10a0:	fc                   	cld    
    10a1:	f3 aa                	rep stos %al,%es:(%edi)
    10a3:	89 ca                	mov    %ecx,%edx
    10a5:	89 fb                	mov    %edi,%ebx
    10a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10aa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10ad:	5b                   	pop    %ebx
    10ae:	5f                   	pop    %edi
    10af:	5d                   	pop    %ebp
    10b0:	c3                   	ret    

000010b1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10b1:	55                   	push   %ebp
    10b2:	89 e5                	mov    %esp,%ebp
    10b4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10bd:	90                   	nop
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	8d 50 01             	lea    0x1(%eax),%edx
    10c4:	89 55 08             	mov    %edx,0x8(%ebp)
    10c7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ca:	8d 4a 01             	lea    0x1(%edx),%ecx
    10cd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10d0:	0f b6 12             	movzbl (%edx),%edx
    10d3:	88 10                	mov    %dl,(%eax)
    10d5:	0f b6 00             	movzbl (%eax),%eax
    10d8:	84 c0                	test   %al,%al
    10da:	75 e2                	jne    10be <strcpy+0xd>
    ;
  return os;
    10dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10df:	c9                   	leave  
    10e0:	c3                   	ret    

000010e1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10e1:	55                   	push   %ebp
    10e2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10e4:	eb 08                	jmp    10ee <strcmp+0xd>
    p++, q++;
    10e6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ea:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10ee:	8b 45 08             	mov    0x8(%ebp),%eax
    10f1:	0f b6 00             	movzbl (%eax),%eax
    10f4:	84 c0                	test   %al,%al
    10f6:	74 10                	je     1108 <strcmp+0x27>
    10f8:	8b 45 08             	mov    0x8(%ebp),%eax
    10fb:	0f b6 10             	movzbl (%eax),%edx
    10fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1101:	0f b6 00             	movzbl (%eax),%eax
    1104:	38 c2                	cmp    %al,%dl
    1106:	74 de                	je     10e6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1108:	8b 45 08             	mov    0x8(%ebp),%eax
    110b:	0f b6 00             	movzbl (%eax),%eax
    110e:	0f b6 d0             	movzbl %al,%edx
    1111:	8b 45 0c             	mov    0xc(%ebp),%eax
    1114:	0f b6 00             	movzbl (%eax),%eax
    1117:	0f b6 c0             	movzbl %al,%eax
    111a:	29 c2                	sub    %eax,%edx
    111c:	89 d0                	mov    %edx,%eax
}
    111e:	5d                   	pop    %ebp
    111f:	c3                   	ret    

00001120 <strlen>:

uint
strlen(char *s)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1126:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    112d:	eb 04                	jmp    1133 <strlen+0x13>
    112f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1133:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1136:	8b 45 08             	mov    0x8(%ebp),%eax
    1139:	01 d0                	add    %edx,%eax
    113b:	0f b6 00             	movzbl (%eax),%eax
    113e:	84 c0                	test   %al,%al
    1140:	75 ed                	jne    112f <strlen+0xf>
    ;
  return n;
    1142:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1145:	c9                   	leave  
    1146:	c3                   	ret    

00001147 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1147:	55                   	push   %ebp
    1148:	89 e5                	mov    %esp,%ebp
    114a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    114d:	8b 45 10             	mov    0x10(%ebp),%eax
    1150:	89 44 24 08          	mov    %eax,0x8(%esp)
    1154:	8b 45 0c             	mov    0xc(%ebp),%eax
    1157:	89 44 24 04          	mov    %eax,0x4(%esp)
    115b:	8b 45 08             	mov    0x8(%ebp),%eax
    115e:	89 04 24             	mov    %eax,(%esp)
    1161:	e8 26 ff ff ff       	call   108c <stosb>
  return dst;
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1169:	c9                   	leave  
    116a:	c3                   	ret    

0000116b <strchr>:

char*
strchr(const char *s, char c)
{
    116b:	55                   	push   %ebp
    116c:	89 e5                	mov    %esp,%ebp
    116e:	83 ec 04             	sub    $0x4,%esp
    1171:	8b 45 0c             	mov    0xc(%ebp),%eax
    1174:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1177:	eb 14                	jmp    118d <strchr+0x22>
    if(*s == c)
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
    117c:	0f b6 00             	movzbl (%eax),%eax
    117f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1182:	75 05                	jne    1189 <strchr+0x1e>
      return (char*)s;
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	eb 13                	jmp    119c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1189:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    118d:	8b 45 08             	mov    0x8(%ebp),%eax
    1190:	0f b6 00             	movzbl (%eax),%eax
    1193:	84 c0                	test   %al,%al
    1195:	75 e2                	jne    1179 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1197:	b8 00 00 00 00       	mov    $0x0,%eax
}
    119c:	c9                   	leave  
    119d:	c3                   	ret    

0000119e <gets>:

char*
gets(char *buf, int max)
{
    119e:	55                   	push   %ebp
    119f:	89 e5                	mov    %esp,%ebp
    11a1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11ab:	eb 4c                	jmp    11f9 <gets+0x5b>
    cc = read(0, &c, 1);
    11ad:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11b4:	00 
    11b5:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11c3:	e8 44 01 00 00       	call   130c <read>
    11c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11cf:	7f 02                	jg     11d3 <gets+0x35>
      break;
    11d1:	eb 31                	jmp    1204 <gets+0x66>
    buf[i++] = c;
    11d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11d6:	8d 50 01             	lea    0x1(%eax),%edx
    11d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11dc:	89 c2                	mov    %eax,%edx
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	01 c2                	add    %eax,%edx
    11e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11e9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ed:	3c 0a                	cmp    $0xa,%al
    11ef:	74 13                	je     1204 <gets+0x66>
    11f1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f5:	3c 0d                	cmp    $0xd,%al
    11f7:	74 0b                	je     1204 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11fc:	83 c0 01             	add    $0x1,%eax
    11ff:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1202:	7c a9                	jl     11ad <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1204:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	01 d0                	add    %edx,%eax
    120c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    120f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1212:	c9                   	leave  
    1213:	c3                   	ret    

00001214 <stat>:

int
stat(char *n, struct stat *st)
{
    1214:	55                   	push   %ebp
    1215:	89 e5                	mov    %esp,%ebp
    1217:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    121a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1221:	00 
    1222:	8b 45 08             	mov    0x8(%ebp),%eax
    1225:	89 04 24             	mov    %eax,(%esp)
    1228:	e8 07 01 00 00       	call   1334 <open>
    122d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1230:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1234:	79 07                	jns    123d <stat+0x29>
    return -1;
    1236:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    123b:	eb 23                	jmp    1260 <stat+0x4c>
  r = fstat(fd, st);
    123d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1240:	89 44 24 04          	mov    %eax,0x4(%esp)
    1244:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1247:	89 04 24             	mov    %eax,(%esp)
    124a:	e8 fd 00 00 00       	call   134c <fstat>
    124f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1252:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1255:	89 04 24             	mov    %eax,(%esp)
    1258:	e8 bf 00 00 00       	call   131c <close>
  return r;
    125d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1260:	c9                   	leave  
    1261:	c3                   	ret    

00001262 <atoi>:

int
atoi(const char *s)
{
    1262:	55                   	push   %ebp
    1263:	89 e5                	mov    %esp,%ebp
    1265:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1268:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126f:	eb 25                	jmp    1296 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1271:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1274:	89 d0                	mov    %edx,%eax
    1276:	c1 e0 02             	shl    $0x2,%eax
    1279:	01 d0                	add    %edx,%eax
    127b:	01 c0                	add    %eax,%eax
    127d:	89 c1                	mov    %eax,%ecx
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
    1282:	8d 50 01             	lea    0x1(%eax),%edx
    1285:	89 55 08             	mov    %edx,0x8(%ebp)
    1288:	0f b6 00             	movzbl (%eax),%eax
    128b:	0f be c0             	movsbl %al,%eax
    128e:	01 c8                	add    %ecx,%eax
    1290:	83 e8 30             	sub    $0x30,%eax
    1293:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	0f b6 00             	movzbl (%eax),%eax
    129c:	3c 2f                	cmp    $0x2f,%al
    129e:	7e 0a                	jle    12aa <atoi+0x48>
    12a0:	8b 45 08             	mov    0x8(%ebp),%eax
    12a3:	0f b6 00             	movzbl (%eax),%eax
    12a6:	3c 39                	cmp    $0x39,%al
    12a8:	7e c7                	jle    1271 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12ad:	c9                   	leave  
    12ae:	c3                   	ret    

000012af <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12af:	55                   	push   %ebp
    12b0:	89 e5                	mov    %esp,%ebp
    12b2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12b5:	8b 45 08             	mov    0x8(%ebp),%eax
    12b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    12be:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12c1:	eb 17                	jmp    12da <memmove+0x2b>
    *dst++ = *src++;
    12c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c6:	8d 50 01             	lea    0x1(%eax),%edx
    12c9:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12cf:	8d 4a 01             	lea    0x1(%edx),%ecx
    12d2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12d5:	0f b6 12             	movzbl (%edx),%edx
    12d8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12da:	8b 45 10             	mov    0x10(%ebp),%eax
    12dd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12e0:	89 55 10             	mov    %edx,0x10(%ebp)
    12e3:	85 c0                	test   %eax,%eax
    12e5:	7f dc                	jg     12c3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ea:	c9                   	leave  
    12eb:	c3                   	ret    

000012ec <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ec:	b8 01 00 00 00       	mov    $0x1,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <exit>:
SYSCALL(exit)
    12f4:	b8 02 00 00 00       	mov    $0x2,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <wait>:
SYSCALL(wait)
    12fc:	b8 03 00 00 00       	mov    $0x3,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <pipe>:
SYSCALL(pipe)
    1304:	b8 04 00 00 00       	mov    $0x4,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <read>:
SYSCALL(read)
    130c:	b8 05 00 00 00       	mov    $0x5,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <write>:
SYSCALL(write)
    1314:	b8 10 00 00 00       	mov    $0x10,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <close>:
SYSCALL(close)
    131c:	b8 15 00 00 00       	mov    $0x15,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <kill>:
SYSCALL(kill)
    1324:	b8 06 00 00 00       	mov    $0x6,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <exec>:
SYSCALL(exec)
    132c:	b8 07 00 00 00       	mov    $0x7,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <open>:
SYSCALL(open)
    1334:	b8 0f 00 00 00       	mov    $0xf,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <mknod>:
SYSCALL(mknod)
    133c:	b8 11 00 00 00       	mov    $0x11,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <unlink>:
SYSCALL(unlink)
    1344:	b8 12 00 00 00       	mov    $0x12,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <fstat>:
SYSCALL(fstat)
    134c:	b8 08 00 00 00       	mov    $0x8,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <link>:
SYSCALL(link)
    1354:	b8 13 00 00 00       	mov    $0x13,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <mkdir>:
SYSCALL(mkdir)
    135c:	b8 14 00 00 00       	mov    $0x14,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <chdir>:
SYSCALL(chdir)
    1364:	b8 09 00 00 00       	mov    $0x9,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <dup>:
SYSCALL(dup)
    136c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <getpid>:
SYSCALL(getpid)
    1374:	b8 0b 00 00 00       	mov    $0xb,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <sbrk>:
SYSCALL(sbrk)
    137c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <sleep>:
SYSCALL(sleep)
    1384:	b8 0d 00 00 00       	mov    $0xd,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <uptime>:
SYSCALL(uptime)
    138c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <clone>:
SYSCALL(clone)
    1394:	b8 16 00 00 00       	mov    $0x16,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <texit>:
SYSCALL(texit)
    139c:	b8 17 00 00 00       	mov    $0x17,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <tsleep>:
SYSCALL(tsleep)
    13a4:	b8 18 00 00 00       	mov    $0x18,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <twakeup>:
SYSCALL(twakeup)
    13ac:	b8 19 00 00 00       	mov    $0x19,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <thread_yield>:
SYSCALL(thread_yield)
    13b4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13bc:	55                   	push   %ebp
    13bd:	89 e5                	mov    %esp,%ebp
    13bf:	83 ec 18             	sub    $0x18,%esp
    13c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13cf:	00 
    13d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13d3:	89 44 24 04          	mov    %eax,0x4(%esp)
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	89 04 24             	mov    %eax,(%esp)
    13dd:	e8 32 ff ff ff       	call   1314 <write>
}
    13e2:	c9                   	leave  
    13e3:	c3                   	ret    

000013e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13e4:	55                   	push   %ebp
    13e5:	89 e5                	mov    %esp,%ebp
    13e7:	56                   	push   %esi
    13e8:	53                   	push   %ebx
    13e9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13f3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13f7:	74 17                	je     1410 <printint+0x2c>
    13f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13fd:	79 11                	jns    1410 <printint+0x2c>
    neg = 1;
    13ff:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1406:	8b 45 0c             	mov    0xc(%ebp),%eax
    1409:	f7 d8                	neg    %eax
    140b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    140e:	eb 06                	jmp    1416 <printint+0x32>
  } else {
    x = xx;
    1410:	8b 45 0c             	mov    0xc(%ebp),%eax
    1413:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1416:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    141d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1420:	8d 41 01             	lea    0x1(%ecx),%eax
    1423:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1426:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1429:	8b 45 ec             	mov    -0x14(%ebp),%eax
    142c:	ba 00 00 00 00       	mov    $0x0,%edx
    1431:	f7 f3                	div    %ebx
    1433:	89 d0                	mov    %edx,%eax
    1435:	0f b6 80 9c 1e 00 00 	movzbl 0x1e9c(%eax),%eax
    143c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1440:	8b 75 10             	mov    0x10(%ebp),%esi
    1443:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1446:	ba 00 00 00 00       	mov    $0x0,%edx
    144b:	f7 f6                	div    %esi
    144d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1450:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1454:	75 c7                	jne    141d <printint+0x39>
  if(neg)
    1456:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    145a:	74 10                	je     146c <printint+0x88>
    buf[i++] = '-';
    145c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145f:	8d 50 01             	lea    0x1(%eax),%edx
    1462:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1465:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    146a:	eb 1f                	jmp    148b <printint+0xa7>
    146c:	eb 1d                	jmp    148b <printint+0xa7>
    putc(fd, buf[i]);
    146e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1471:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1474:	01 d0                	add    %edx,%eax
    1476:	0f b6 00             	movzbl (%eax),%eax
    1479:	0f be c0             	movsbl %al,%eax
    147c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	89 04 24             	mov    %eax,(%esp)
    1486:	e8 31 ff ff ff       	call   13bc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    148b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    148f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1493:	79 d9                	jns    146e <printint+0x8a>
    putc(fd, buf[i]);
}
    1495:	83 c4 30             	add    $0x30,%esp
    1498:	5b                   	pop    %ebx
    1499:	5e                   	pop    %esi
    149a:	5d                   	pop    %ebp
    149b:	c3                   	ret    

0000149c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    149c:	55                   	push   %ebp
    149d:	89 e5                	mov    %esp,%ebp
    149f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14a9:	8d 45 0c             	lea    0xc(%ebp),%eax
    14ac:	83 c0 04             	add    $0x4,%eax
    14af:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b9:	e9 7c 01 00 00       	jmp    163a <printf+0x19e>
    c = fmt[i] & 0xff;
    14be:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c4:	01 d0                	add    %edx,%eax
    14c6:	0f b6 00             	movzbl (%eax),%eax
    14c9:	0f be c0             	movsbl %al,%eax
    14cc:	25 ff 00 00 00       	and    $0xff,%eax
    14d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14d8:	75 2c                	jne    1506 <printf+0x6a>
      if(c == '%'){
    14da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14de:	75 0c                	jne    14ec <printf+0x50>
        state = '%';
    14e0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14e7:	e9 4a 01 00 00       	jmp    1636 <printf+0x19a>
      } else {
        putc(fd, c);
    14ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14ef:	0f be c0             	movsbl %al,%eax
    14f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f6:	8b 45 08             	mov    0x8(%ebp),%eax
    14f9:	89 04 24             	mov    %eax,(%esp)
    14fc:	e8 bb fe ff ff       	call   13bc <putc>
    1501:	e9 30 01 00 00       	jmp    1636 <printf+0x19a>
      }
    } else if(state == '%'){
    1506:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    150a:	0f 85 26 01 00 00    	jne    1636 <printf+0x19a>
      if(c == 'd'){
    1510:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1514:	75 2d                	jne    1543 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1516:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1519:	8b 00                	mov    (%eax),%eax
    151b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1522:	00 
    1523:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    152a:	00 
    152b:	89 44 24 04          	mov    %eax,0x4(%esp)
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	89 04 24             	mov    %eax,(%esp)
    1535:	e8 aa fe ff ff       	call   13e4 <printint>
        ap++;
    153a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    153e:	e9 ec 00 00 00       	jmp    162f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1543:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1547:	74 06                	je     154f <printf+0xb3>
    1549:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    154d:	75 2d                	jne    157c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    154f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1552:	8b 00                	mov    (%eax),%eax
    1554:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    155b:	00 
    155c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1563:	00 
    1564:	89 44 24 04          	mov    %eax,0x4(%esp)
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	89 04 24             	mov    %eax,(%esp)
    156e:	e8 71 fe ff ff       	call   13e4 <printint>
        ap++;
    1573:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1577:	e9 b3 00 00 00       	jmp    162f <printf+0x193>
      } else if(c == 's'){
    157c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1580:	75 45                	jne    15c7 <printf+0x12b>
        s = (char*)*ap;
    1582:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1585:	8b 00                	mov    (%eax),%eax
    1587:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    158a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    158e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1592:	75 09                	jne    159d <printf+0x101>
          s = "(null)";
    1594:	c7 45 f4 e5 1a 00 00 	movl   $0x1ae5,-0xc(%ebp)
        while(*s != 0){
    159b:	eb 1e                	jmp    15bb <printf+0x11f>
    159d:	eb 1c                	jmp    15bb <printf+0x11f>
          putc(fd, *s);
    159f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a2:	0f b6 00             	movzbl (%eax),%eax
    15a5:	0f be c0             	movsbl %al,%eax
    15a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
    15af:	89 04 24             	mov    %eax,(%esp)
    15b2:	e8 05 fe ff ff       	call   13bc <putc>
          s++;
    15b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15be:	0f b6 00             	movzbl (%eax),%eax
    15c1:	84 c0                	test   %al,%al
    15c3:	75 da                	jne    159f <printf+0x103>
    15c5:	eb 68                	jmp    162f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15c7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15cb:	75 1d                	jne    15ea <printf+0x14e>
        putc(fd, *ap);
    15cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d0:	8b 00                	mov    (%eax),%eax
    15d2:	0f be c0             	movsbl %al,%eax
    15d5:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d9:	8b 45 08             	mov    0x8(%ebp),%eax
    15dc:	89 04 24             	mov    %eax,(%esp)
    15df:	e8 d8 fd ff ff       	call   13bc <putc>
        ap++;
    15e4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15e8:	eb 45                	jmp    162f <printf+0x193>
      } else if(c == '%'){
    15ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15ee:	75 17                	jne    1607 <printf+0x16b>
        putc(fd, c);
    15f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f3:	0f be c0             	movsbl %al,%eax
    15f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15fa:	8b 45 08             	mov    0x8(%ebp),%eax
    15fd:	89 04 24             	mov    %eax,(%esp)
    1600:	e8 b7 fd ff ff       	call   13bc <putc>
    1605:	eb 28                	jmp    162f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1607:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    160e:	00 
    160f:	8b 45 08             	mov    0x8(%ebp),%eax
    1612:	89 04 24             	mov    %eax,(%esp)
    1615:	e8 a2 fd ff ff       	call   13bc <putc>
        putc(fd, c);
    161a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    161d:	0f be c0             	movsbl %al,%eax
    1620:	89 44 24 04          	mov    %eax,0x4(%esp)
    1624:	8b 45 08             	mov    0x8(%ebp),%eax
    1627:	89 04 24             	mov    %eax,(%esp)
    162a:	e8 8d fd ff ff       	call   13bc <putc>
      }
      state = 0;
    162f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1636:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    163a:	8b 55 0c             	mov    0xc(%ebp),%edx
    163d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1640:	01 d0                	add    %edx,%eax
    1642:	0f b6 00             	movzbl (%eax),%eax
    1645:	84 c0                	test   %al,%al
    1647:	0f 85 71 fe ff ff    	jne    14be <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    164d:	c9                   	leave  
    164e:	c3                   	ret    
    164f:	90                   	nop

00001650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1656:	8b 45 08             	mov    0x8(%ebp),%eax
    1659:	83 e8 08             	sub    $0x8,%eax
    165c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    165f:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
    1664:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1667:	eb 24                	jmp    168d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1669:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166c:	8b 00                	mov    (%eax),%eax
    166e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1671:	77 12                	ja     1685 <free+0x35>
    1673:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1679:	77 24                	ja     169f <free+0x4f>
    167b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167e:	8b 00                	mov    (%eax),%eax
    1680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1683:	77 1a                	ja     169f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	8b 00                	mov    (%eax),%eax
    168a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    168d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1693:	76 d4                	jbe    1669 <free+0x19>
    1695:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1698:	8b 00                	mov    (%eax),%eax
    169a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    169d:	76 ca                	jbe    1669 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    169f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a2:	8b 40 04             	mov    0x4(%eax),%eax
    16a5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16af:	01 c2                	add    %eax,%edx
    16b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b4:	8b 00                	mov    (%eax),%eax
    16b6:	39 c2                	cmp    %eax,%edx
    16b8:	75 24                	jne    16de <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    16ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bd:	8b 50 04             	mov    0x4(%eax),%edx
    16c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c3:	8b 00                	mov    (%eax),%eax
    16c5:	8b 40 04             	mov    0x4(%eax),%eax
    16c8:	01 c2                	add    %eax,%edx
    16ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d3:	8b 00                	mov    (%eax),%eax
    16d5:	8b 10                	mov    (%eax),%edx
    16d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16da:	89 10                	mov    %edx,(%eax)
    16dc:	eb 0a                	jmp    16e8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    16de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e1:	8b 10                	mov    (%eax),%edx
    16e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16eb:	8b 40 04             	mov    0x4(%eax),%eax
    16ee:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f8:	01 d0                	add    %edx,%eax
    16fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16fd:	75 20                	jne    171f <free+0xcf>
    p->s.size += bp->s.size;
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	8b 50 04             	mov    0x4(%eax),%edx
    1705:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1708:	8b 40 04             	mov    0x4(%eax),%eax
    170b:	01 c2                	add    %eax,%edx
    170d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1710:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1713:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1716:	8b 10                	mov    (%eax),%edx
    1718:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171b:	89 10                	mov    %edx,(%eax)
    171d:	eb 08                	jmp    1727 <free+0xd7>
  } else
    p->s.ptr = bp;
    171f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1722:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1725:	89 10                	mov    %edx,(%eax)
  freep = p;
    1727:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172a:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
}
    172f:	c9                   	leave  
    1730:	c3                   	ret    

00001731 <morecore>:

static Header*
morecore(uint nu)
{
    1731:	55                   	push   %ebp
    1732:	89 e5                	mov    %esp,%ebp
    1734:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1737:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    173e:	77 07                	ja     1747 <morecore+0x16>
    nu = 4096;
    1740:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1747:	8b 45 08             	mov    0x8(%ebp),%eax
    174a:	c1 e0 03             	shl    $0x3,%eax
    174d:	89 04 24             	mov    %eax,(%esp)
    1750:	e8 27 fc ff ff       	call   137c <sbrk>
    1755:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1758:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    175c:	75 07                	jne    1765 <morecore+0x34>
    return 0;
    175e:	b8 00 00 00 00       	mov    $0x0,%eax
    1763:	eb 22                	jmp    1787 <morecore+0x56>
  hp = (Header*)p;
    1765:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1768:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    176b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176e:	8b 55 08             	mov    0x8(%ebp),%edx
    1771:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1774:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1777:	83 c0 08             	add    $0x8,%eax
    177a:	89 04 24             	mov    %eax,(%esp)
    177d:	e8 ce fe ff ff       	call   1650 <free>
  return freep;
    1782:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
}
    1787:	c9                   	leave  
    1788:	c3                   	ret    

00001789 <malloc>:

void*
malloc(uint nbytes)
{
    1789:	55                   	push   %ebp
    178a:	89 e5                	mov    %esp,%ebp
    178c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    178f:	8b 45 08             	mov    0x8(%ebp),%eax
    1792:	83 c0 07             	add    $0x7,%eax
    1795:	c1 e8 03             	shr    $0x3,%eax
    1798:	83 c0 01             	add    $0x1,%eax
    179b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    179e:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
    17a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17aa:	75 23                	jne    17cf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17ac:	c7 45 f0 b4 1e 00 00 	movl   $0x1eb4,-0x10(%ebp)
    17b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b6:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
    17bb:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
    17c0:	a3 b4 1e 00 00       	mov    %eax,0x1eb4
    base.s.size = 0;
    17c5:	c7 05 b8 1e 00 00 00 	movl   $0x0,0x1eb8
    17cc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d2:	8b 00                	mov    (%eax),%eax
    17d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17da:	8b 40 04             	mov    0x4(%eax),%eax
    17dd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17e0:	72 4d                	jb     182f <malloc+0xa6>
      if(p->s.size == nunits)
    17e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e5:	8b 40 04             	mov    0x4(%eax),%eax
    17e8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17eb:	75 0c                	jne    17f9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f0:	8b 10                	mov    (%eax),%edx
    17f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f5:	89 10                	mov    %edx,(%eax)
    17f7:	eb 26                	jmp    181f <malloc+0x96>
      else {
        p->s.size -= nunits;
    17f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fc:	8b 40 04             	mov    0x4(%eax),%eax
    17ff:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1802:	89 c2                	mov    %eax,%edx
    1804:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1807:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    180a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180d:	8b 40 04             	mov    0x4(%eax),%eax
    1810:	c1 e0 03             	shl    $0x3,%eax
    1813:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1816:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1819:	8b 55 ec             	mov    -0x14(%ebp),%edx
    181c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    181f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1822:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
      return (void*)(p + 1);
    1827:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182a:	83 c0 08             	add    $0x8,%eax
    182d:	eb 38                	jmp    1867 <malloc+0xde>
    }
    if(p == freep)
    182f:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
    1834:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1837:	75 1b                	jne    1854 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1839:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183c:	89 04 24             	mov    %eax,(%esp)
    183f:	e8 ed fe ff ff       	call   1731 <morecore>
    1844:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1847:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    184b:	75 07                	jne    1854 <malloc+0xcb>
        return 0;
    184d:	b8 00 00 00 00       	mov    $0x0,%eax
    1852:	eb 13                	jmp    1867 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1854:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1857:	89 45 f0             	mov    %eax,-0x10(%ebp)
    185a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185d:	8b 00                	mov    (%eax),%eax
    185f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1862:	e9 70 ff ff ff       	jmp    17d7 <malloc+0x4e>
}
    1867:	c9                   	leave  
    1868:	c3                   	ret    
    1869:	66 90                	xchg   %ax,%ax
    186b:	90                   	nop

0000186c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    186c:	55                   	push   %ebp
    186d:	89 e5                	mov    %esp,%ebp
    186f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1872:	8b 55 08             	mov    0x8(%ebp),%edx
    1875:	8b 45 0c             	mov    0xc(%ebp),%eax
    1878:	8b 4d 08             	mov    0x8(%ebp),%ecx
    187b:	f0 87 02             	lock xchg %eax,(%edx)
    187e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1881:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1884:	c9                   	leave  
    1885:	c3                   	ret    

00001886 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1886:	55                   	push   %ebp
    1887:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1889:	8b 45 08             	mov    0x8(%ebp),%eax
    188c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1892:	5d                   	pop    %ebp
    1893:	c3                   	ret    

00001894 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1894:	55                   	push   %ebp
    1895:	89 e5                	mov    %esp,%ebp
    1897:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    189a:	90                   	nop
    189b:	8b 45 08             	mov    0x8(%ebp),%eax
    189e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18a5:	00 
    18a6:	89 04 24             	mov    %eax,(%esp)
    18a9:	e8 be ff ff ff       	call   186c <xchg>
    18ae:	85 c0                	test   %eax,%eax
    18b0:	75 e9                	jne    189b <lock_acquire+0x7>
}
    18b2:	c9                   	leave  
    18b3:	c3                   	ret    

000018b4 <lock_release>:
void lock_release(lock_t *lock){
    18b4:	55                   	push   %ebp
    18b5:	89 e5                	mov    %esp,%ebp
    18b7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18ba:	8b 45 08             	mov    0x8(%ebp),%eax
    18bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18c4:	00 
    18c5:	89 04 24             	mov    %eax,(%esp)
    18c8:	e8 9f ff ff ff       	call   186c <xchg>
}
    18cd:	c9                   	leave  
    18ce:	c3                   	ret    

000018cf <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18cf:	55                   	push   %ebp
    18d0:	89 e5                	mov    %esp,%ebp
    18d2:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18d5:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18dc:	e8 a8 fe ff ff       	call   1789 <malloc>
    18e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ed:	25 ff 0f 00 00       	and    $0xfff,%eax
    18f2:	85 c0                	test   %eax,%eax
    18f4:	74 14                	je     190a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18fe:	89 c2                	mov    %eax,%edx
    1900:	b8 00 10 00 00       	mov    $0x1000,%eax
    1905:	29 d0                	sub    %edx,%eax
    1907:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    190a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    190e:	75 1b                	jne    192b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1910:	c7 44 24 04 ec 1a 00 	movl   $0x1aec,0x4(%esp)
    1917:	00 
    1918:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    191f:	e8 78 fb ff ff       	call   149c <printf>
        return 0;
    1924:	b8 00 00 00 00       	mov    $0x0,%eax
    1929:	eb 6f                	jmp    199a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    192b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    192e:	8b 55 08             	mov    0x8(%ebp),%edx
    1931:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1934:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1938:	89 54 24 08          	mov    %edx,0x8(%esp)
    193c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1943:	00 
    1944:	89 04 24             	mov    %eax,(%esp)
    1947:	e8 48 fa ff ff       	call   1394 <clone>
    194c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    194f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1953:	79 1b                	jns    1970 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1955:	c7 44 24 04 fa 1a 00 	movl   $0x1afa,0x4(%esp)
    195c:	00 
    195d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1964:	e8 33 fb ff ff       	call   149c <printf>
        return 0;
    1969:	b8 00 00 00 00       	mov    $0x0,%eax
    196e:	eb 2a                	jmp    199a <thread_create+0xcb>
    }
    if(tid > 0){
    1970:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1974:	7e 05                	jle    197b <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1976:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1979:	eb 1f                	jmp    199a <thread_create+0xcb>
    }
    if(tid == 0){
    197b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    197f:	75 14                	jne    1995 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1981:	c7 44 24 04 07 1b 00 	movl   $0x1b07,0x4(%esp)
    1988:	00 
    1989:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1990:	e8 07 fb ff ff       	call   149c <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1995:	b8 00 00 00 00       	mov    $0x0,%eax
}
    199a:	c9                   	leave  
    199b:	c3                   	ret    

0000199c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    199c:	55                   	push   %ebp
    199d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    199f:	a1 b0 1e 00 00       	mov    0x1eb0,%eax
    19a4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19aa:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19af:	a3 b0 1e 00 00       	mov    %eax,0x1eb0
    return (int)(rands % max);
    19b4:	a1 b0 1e 00 00       	mov    0x1eb0,%eax
    19b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19bc:	ba 00 00 00 00       	mov    $0x0,%edx
    19c1:	f7 f1                	div    %ecx
    19c3:	89 d0                	mov    %edx,%eax
}
    19c5:	5d                   	pop    %ebp
    19c6:	c3                   	ret    
    19c7:	90                   	nop

000019c8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19c8:	55                   	push   %ebp
    19c9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19cb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19de:	8b 45 08             	mov    0x8(%ebp),%eax
    19e1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19e8:	5d                   	pop    %ebp
    19e9:	c3                   	ret    

000019ea <add_q>:

void add_q(struct queue *q, int v){
    19ea:	55                   	push   %ebp
    19eb:	89 e5                	mov    %esp,%ebp
    19ed:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19f0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19f7:	e8 8d fd ff ff       	call   1789 <malloc>
    19fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a02:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a0f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 40 04             	mov    0x4(%eax),%eax
    1a17:	85 c0                	test   %eax,%eax
    1a19:	75 0b                	jne    1a26 <add_q+0x3c>
        q->head = n;
    1a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a21:	89 50 04             	mov    %edx,0x4(%eax)
    1a24:	eb 0c                	jmp    1a32 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a26:	8b 45 08             	mov    0x8(%ebp),%eax
    1a29:	8b 40 08             	mov    0x8(%eax),%eax
    1a2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a2f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a38:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3e:	8b 00                	mov    (%eax),%eax
    1a40:	8d 50 01             	lea    0x1(%eax),%edx
    1a43:	8b 45 08             	mov    0x8(%ebp),%eax
    1a46:	89 10                	mov    %edx,(%eax)
}
    1a48:	c9                   	leave  
    1a49:	c3                   	ret    

00001a4a <empty_q>:

int empty_q(struct queue *q){
    1a4a:	55                   	push   %ebp
    1a4b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a50:	8b 00                	mov    (%eax),%eax
    1a52:	85 c0                	test   %eax,%eax
    1a54:	75 07                	jne    1a5d <empty_q+0x13>
        return 1;
    1a56:	b8 01 00 00 00       	mov    $0x1,%eax
    1a5b:	eb 05                	jmp    1a62 <empty_q+0x18>
    else
        return 0;
    1a5d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a62:	5d                   	pop    %ebp
    1a63:	c3                   	ret    

00001a64 <pop_q>:
int pop_q(struct queue *q){
    1a64:	55                   	push   %ebp
    1a65:	89 e5                	mov    %esp,%ebp
    1a67:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6d:	89 04 24             	mov    %eax,(%esp)
    1a70:	e8 d5 ff ff ff       	call   1a4a <empty_q>
    1a75:	85 c0                	test   %eax,%eax
    1a77:	75 5d                	jne    1ad6 <pop_q+0x72>
       val = q->head->value; 
    1a79:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7c:	8b 40 04             	mov    0x4(%eax),%eax
    1a7f:	8b 00                	mov    (%eax),%eax
    1a81:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a84:	8b 45 08             	mov    0x8(%ebp),%eax
    1a87:	8b 40 04             	mov    0x4(%eax),%eax
    1a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	8b 40 04             	mov    0x4(%eax),%eax
    1a93:	8b 50 04             	mov    0x4(%eax),%edx
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a9f:	89 04 24             	mov    %eax,(%esp)
    1aa2:	e8 a9 fb ff ff       	call   1650 <free>
       q->size--;
    1aa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaa:	8b 00                	mov    (%eax),%eax
    1aac:	8d 50 ff             	lea    -0x1(%eax),%edx
    1aaf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ab4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab7:	8b 00                	mov    (%eax),%eax
    1ab9:	85 c0                	test   %eax,%eax
    1abb:	75 14                	jne    1ad1 <pop_q+0x6d>
            q->head = 0;
    1abd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aca:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad4:	eb 05                	jmp    1adb <pop_q+0x77>
    }
    return -1;
    1ad6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1adb:	c9                   	leave  
    1adc:	c3                   	ret    
