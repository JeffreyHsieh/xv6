
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
    1010:	e8 62 07 00 00       	call   1777 <malloc>
    1015:	89 44 24 18          	mov    %eax,0x18(%esp)
    int i;
    init_q(q);
    1019:	8b 44 24 18          	mov    0x18(%esp),%eax
    101d:	89 04 24             	mov    %eax,(%esp)
    1020:	e8 8f 09 00 00       	call   19b4 <init_q>
    for(i=0;i<10;i++){
    1025:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    102c:	00 
    102d:	eb 19                	jmp    1048 <main+0x48>
        add_q(q,i);
    102f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1033:	89 44 24 04          	mov    %eax,0x4(%esp)
    1037:	8b 44 24 18          	mov    0x18(%esp),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 93 09 00 00       	call   19d6 <add_q>

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
    1058:	e8 f3 09 00 00       	call   1a50 <pop_q>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 c9 1a 00 	movl   $0x1ac9,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 1f 04 00 00       	call   1494 <printf>
    int i;
    init_q(q);
    for(i=0;i<10;i++){
        add_q(q,i);
    }
    for(;!empty_q(q);){
    1075:	8b 44 24 18          	mov    0x18(%esp),%eax
    1079:	89 04 24             	mov    %eax,(%esp)
    107c:	e8 b5 09 00 00       	call   1a36 <empty_q>
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
    12ec:	b8 01 00 00 00       	mov    $0x1,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <exit>:
    12f4:	b8 02 00 00 00       	mov    $0x2,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <wait>:
    12fc:	b8 03 00 00 00       	mov    $0x3,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <pipe>:
    1304:	b8 04 00 00 00       	mov    $0x4,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <read>:
    130c:	b8 05 00 00 00       	mov    $0x5,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <write>:
    1314:	b8 10 00 00 00       	mov    $0x10,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <close>:
    131c:	b8 15 00 00 00       	mov    $0x15,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <kill>:
    1324:	b8 06 00 00 00       	mov    $0x6,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <exec>:
    132c:	b8 07 00 00 00       	mov    $0x7,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <open>:
    1334:	b8 0f 00 00 00       	mov    $0xf,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <mknod>:
    133c:	b8 11 00 00 00       	mov    $0x11,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <unlink>:
    1344:	b8 12 00 00 00       	mov    $0x12,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <fstat>:
    134c:	b8 08 00 00 00       	mov    $0x8,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <link>:
    1354:	b8 13 00 00 00       	mov    $0x13,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <mkdir>:
    135c:	b8 14 00 00 00       	mov    $0x14,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <chdir>:
    1364:	b8 09 00 00 00       	mov    $0x9,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <dup>:
    136c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <getpid>:
    1374:	b8 0b 00 00 00       	mov    $0xb,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <sbrk>:
    137c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <sleep>:
    1384:	b8 0d 00 00 00       	mov    $0xd,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <uptime>:
    138c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <clone>:
    1394:	b8 16 00 00 00       	mov    $0x16,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <texit>:
    139c:	b8 17 00 00 00       	mov    $0x17,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <tsleep>:
    13a4:	b8 18 00 00 00       	mov    $0x18,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <twakeup>:
    13ac:	b8 19 00 00 00       	mov    $0x19,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13b4:	55                   	push   %ebp
    13b5:	89 e5                	mov    %esp,%ebp
    13b7:	83 ec 18             	sub    $0x18,%esp
    13ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    13bd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13c0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13c7:	00 
    13c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13cb:	89 44 24 04          	mov    %eax,0x4(%esp)
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	89 04 24             	mov    %eax,(%esp)
    13d5:	e8 3a ff ff ff       	call   1314 <write>
}
    13da:	c9                   	leave  
    13db:	c3                   	ret    

000013dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13dc:	55                   	push   %ebp
    13dd:	89 e5                	mov    %esp,%ebp
    13df:	56                   	push   %esi
    13e0:	53                   	push   %ebx
    13e1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13eb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ef:	74 17                	je     1408 <printint+0x2c>
    13f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f5:	79 11                	jns    1408 <printint+0x2c>
    neg = 1;
    13f7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1401:	f7 d8                	neg    %eax
    1403:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1406:	eb 06                	jmp    140e <printint+0x32>
  } else {
    x = xx;
    1408:	8b 45 0c             	mov    0xc(%ebp),%eax
    140b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    140e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1415:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1418:	8d 41 01             	lea    0x1(%ecx),%eax
    141b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    141e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1421:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1424:	ba 00 00 00 00       	mov    $0x0,%edx
    1429:	f7 f3                	div    %ebx
    142b:	89 d0                	mov    %edx,%eax
    142d:	0f b6 80 28 1e 00 00 	movzbl 0x1e28(%eax),%eax
    1434:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1438:	8b 75 10             	mov    0x10(%ebp),%esi
    143b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    143e:	ba 00 00 00 00       	mov    $0x0,%edx
    1443:	f7 f6                	div    %esi
    1445:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1448:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    144c:	75 c7                	jne    1415 <printint+0x39>
  if(neg)
    144e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1452:	74 10                	je     1464 <printint+0x88>
    buf[i++] = '-';
    1454:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1457:	8d 50 01             	lea    0x1(%eax),%edx
    145a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    145d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1462:	eb 1f                	jmp    1483 <printint+0xa7>
    1464:	eb 1d                	jmp    1483 <printint+0xa7>
    putc(fd, buf[i]);
    1466:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146c:	01 d0                	add    %edx,%eax
    146e:	0f b6 00             	movzbl (%eax),%eax
    1471:	0f be c0             	movsbl %al,%eax
    1474:	89 44 24 04          	mov    %eax,0x4(%esp)
    1478:	8b 45 08             	mov    0x8(%ebp),%eax
    147b:	89 04 24             	mov    %eax,(%esp)
    147e:	e8 31 ff ff ff       	call   13b4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1483:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1487:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    148b:	79 d9                	jns    1466 <printint+0x8a>
    putc(fd, buf[i]);
}
    148d:	83 c4 30             	add    $0x30,%esp
    1490:	5b                   	pop    %ebx
    1491:	5e                   	pop    %esi
    1492:	5d                   	pop    %ebp
    1493:	c3                   	ret    

00001494 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1494:	55                   	push   %ebp
    1495:	89 e5                	mov    %esp,%ebp
    1497:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    149a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14a1:	8d 45 0c             	lea    0xc(%ebp),%eax
    14a4:	83 c0 04             	add    $0x4,%eax
    14a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b1:	e9 7c 01 00 00       	jmp    1632 <printf+0x19e>
    c = fmt[i] & 0xff;
    14b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14bc:	01 d0                	add    %edx,%eax
    14be:	0f b6 00             	movzbl (%eax),%eax
    14c1:	0f be c0             	movsbl %al,%eax
    14c4:	25 ff 00 00 00       	and    $0xff,%eax
    14c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14d0:	75 2c                	jne    14fe <printf+0x6a>
      if(c == '%'){
    14d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14d6:	75 0c                	jne    14e4 <printf+0x50>
        state = '%';
    14d8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14df:	e9 4a 01 00 00       	jmp    162e <printf+0x19a>
      } else {
        putc(fd, c);
    14e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14e7:	0f be c0             	movsbl %al,%eax
    14ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ee:	8b 45 08             	mov    0x8(%ebp),%eax
    14f1:	89 04 24             	mov    %eax,(%esp)
    14f4:	e8 bb fe ff ff       	call   13b4 <putc>
    14f9:	e9 30 01 00 00       	jmp    162e <printf+0x19a>
      }
    } else if(state == '%'){
    14fe:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1502:	0f 85 26 01 00 00    	jne    162e <printf+0x19a>
      if(c == 'd'){
    1508:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    150c:	75 2d                	jne    153b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    150e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1511:	8b 00                	mov    (%eax),%eax
    1513:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    151a:	00 
    151b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1522:	00 
    1523:	89 44 24 04          	mov    %eax,0x4(%esp)
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 aa fe ff ff       	call   13dc <printint>
        ap++;
    1532:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1536:	e9 ec 00 00 00       	jmp    1627 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    153b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    153f:	74 06                	je     1547 <printf+0xb3>
    1541:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1545:	75 2d                	jne    1574 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1547:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154a:	8b 00                	mov    (%eax),%eax
    154c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1553:	00 
    1554:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    155b:	00 
    155c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1560:	8b 45 08             	mov    0x8(%ebp),%eax
    1563:	89 04 24             	mov    %eax,(%esp)
    1566:	e8 71 fe ff ff       	call   13dc <printint>
        ap++;
    156b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    156f:	e9 b3 00 00 00       	jmp    1627 <printf+0x193>
      } else if(c == 's'){
    1574:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1578:	75 45                	jne    15bf <printf+0x12b>
        s = (char*)*ap;
    157a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    157d:	8b 00                	mov    (%eax),%eax
    157f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1582:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1586:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    158a:	75 09                	jne    1595 <printf+0x101>
          s = "(null)";
    158c:	c7 45 f4 d1 1a 00 00 	movl   $0x1ad1,-0xc(%ebp)
        while(*s != 0){
    1593:	eb 1e                	jmp    15b3 <printf+0x11f>
    1595:	eb 1c                	jmp    15b3 <printf+0x11f>
          putc(fd, *s);
    1597:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159a:	0f b6 00             	movzbl (%eax),%eax
    159d:	0f be c0             	movsbl %al,%eax
    15a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a4:	8b 45 08             	mov    0x8(%ebp),%eax
    15a7:	89 04 24             	mov    %eax,(%esp)
    15aa:	e8 05 fe ff ff       	call   13b4 <putc>
          s++;
    15af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b6:	0f b6 00             	movzbl (%eax),%eax
    15b9:	84 c0                	test   %al,%al
    15bb:	75 da                	jne    1597 <printf+0x103>
    15bd:	eb 68                	jmp    1627 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15bf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15c3:	75 1d                	jne    15e2 <printf+0x14e>
        putc(fd, *ap);
    15c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c8:	8b 00                	mov    (%eax),%eax
    15ca:	0f be c0             	movsbl %al,%eax
    15cd:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d1:	8b 45 08             	mov    0x8(%ebp),%eax
    15d4:	89 04 24             	mov    %eax,(%esp)
    15d7:	e8 d8 fd ff ff       	call   13b4 <putc>
        ap++;
    15dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15e0:	eb 45                	jmp    1627 <printf+0x193>
      } else if(c == '%'){
    15e2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15e6:	75 17                	jne    15ff <printf+0x16b>
        putc(fd, c);
    15e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15eb:	0f be c0             	movsbl %al,%eax
    15ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f2:	8b 45 08             	mov    0x8(%ebp),%eax
    15f5:	89 04 24             	mov    %eax,(%esp)
    15f8:	e8 b7 fd ff ff       	call   13b4 <putc>
    15fd:	eb 28                	jmp    1627 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ff:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1606:	00 
    1607:	8b 45 08             	mov    0x8(%ebp),%eax
    160a:	89 04 24             	mov    %eax,(%esp)
    160d:	e8 a2 fd ff ff       	call   13b4 <putc>
        putc(fd, c);
    1612:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1615:	0f be c0             	movsbl %al,%eax
    1618:	89 44 24 04          	mov    %eax,0x4(%esp)
    161c:	8b 45 08             	mov    0x8(%ebp),%eax
    161f:	89 04 24             	mov    %eax,(%esp)
    1622:	e8 8d fd ff ff       	call   13b4 <putc>
      }
      state = 0;
    1627:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    162e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1632:	8b 55 0c             	mov    0xc(%ebp),%edx
    1635:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1638:	01 d0                	add    %edx,%eax
    163a:	0f b6 00             	movzbl (%eax),%eax
    163d:	84 c0                	test   %al,%al
    163f:	0f 85 71 fe ff ff    	jne    14b6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1645:	c9                   	leave  
    1646:	c3                   	ret    
    1647:	90                   	nop

00001648 <free>:
    1648:	55                   	push   %ebp
    1649:	89 e5                	mov    %esp,%ebp
    164b:	83 ec 10             	sub    $0x10,%esp
    164e:	8b 45 08             	mov    0x8(%ebp),%eax
    1651:	83 e8 08             	sub    $0x8,%eax
    1654:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1657:	a1 48 1e 00 00       	mov    0x1e48,%eax
    165c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    165f:	eb 24                	jmp    1685 <free+0x3d>
    1661:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1669:	77 12                	ja     167d <free+0x35>
    166b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1671:	77 24                	ja     1697 <free+0x4f>
    1673:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1676:	8b 00                	mov    (%eax),%eax
    1678:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    167b:	77 1a                	ja     1697 <free+0x4f>
    167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1685:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1688:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    168b:	76 d4                	jbe    1661 <free+0x19>
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	8b 00                	mov    (%eax),%eax
    1692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1695:	76 ca                	jbe    1661 <free+0x19>
    1697:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169a:	8b 40 04             	mov    0x4(%eax),%eax
    169d:	c1 e0 03             	shl    $0x3,%eax
    16a0:	89 c2                	mov    %eax,%edx
    16a2:	03 55 f8             	add    -0x8(%ebp),%edx
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 00                	mov    (%eax),%eax
    16aa:	39 c2                	cmp    %eax,%edx
    16ac:	75 24                	jne    16d2 <free+0x8a>
    16ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b1:	8b 50 04             	mov    0x4(%eax),%edx
    16b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b7:	8b 00                	mov    (%eax),%eax
    16b9:	8b 40 04             	mov    0x4(%eax),%eax
    16bc:	01 c2                	add    %eax,%edx
    16be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c1:	89 50 04             	mov    %edx,0x4(%eax)
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	8b 00                	mov    (%eax),%eax
    16c9:	8b 10                	mov    (%eax),%edx
    16cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ce:	89 10                	mov    %edx,(%eax)
    16d0:	eb 0a                	jmp    16dc <free+0x94>
    16d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d5:	8b 10                	mov    (%eax),%edx
    16d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16da:	89 10                	mov    %edx,(%eax)
    16dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16df:	8b 40 04             	mov    0x4(%eax),%eax
    16e2:	c1 e0 03             	shl    $0x3,%eax
    16e5:	03 45 fc             	add    -0x4(%ebp),%eax
    16e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16eb:	75 20                	jne    170d <free+0xc5>
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 50 04             	mov    0x4(%eax),%edx
    16f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f6:	8b 40 04             	mov    0x4(%eax),%eax
    16f9:	01 c2                	add    %eax,%edx
    16fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fe:	89 50 04             	mov    %edx,0x4(%eax)
    1701:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1704:	8b 10                	mov    (%eax),%edx
    1706:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1709:	89 10                	mov    %edx,(%eax)
    170b:	eb 08                	jmp    1715 <free+0xcd>
    170d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1710:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1713:	89 10                	mov    %edx,(%eax)
    1715:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1718:	a3 48 1e 00 00       	mov    %eax,0x1e48
    171d:	c9                   	leave  
    171e:	c3                   	ret    

0000171f <morecore>:
    171f:	55                   	push   %ebp
    1720:	89 e5                	mov    %esp,%ebp
    1722:	83 ec 28             	sub    $0x28,%esp
    1725:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    172c:	77 07                	ja     1735 <morecore+0x16>
    172e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1735:	8b 45 08             	mov    0x8(%ebp),%eax
    1738:	c1 e0 03             	shl    $0x3,%eax
    173b:	89 04 24             	mov    %eax,(%esp)
    173e:	e8 39 fc ff ff       	call   137c <sbrk>
    1743:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1746:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    174a:	75 07                	jne    1753 <morecore+0x34>
    174c:	b8 00 00 00 00       	mov    $0x0,%eax
    1751:	eb 22                	jmp    1775 <morecore+0x56>
    1753:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1756:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 55 08             	mov    0x8(%ebp),%edx
    175f:	89 50 04             	mov    %edx,0x4(%eax)
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	83 c0 08             	add    $0x8,%eax
    1768:	89 04 24             	mov    %eax,(%esp)
    176b:	e8 d8 fe ff ff       	call   1648 <free>
    1770:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1775:	c9                   	leave  
    1776:	c3                   	ret    

00001777 <malloc>:
    1777:	55                   	push   %ebp
    1778:	89 e5                	mov    %esp,%ebp
    177a:	83 ec 28             	sub    $0x28,%esp
    177d:	8b 45 08             	mov    0x8(%ebp),%eax
    1780:	83 c0 07             	add    $0x7,%eax
    1783:	c1 e8 03             	shr    $0x3,%eax
    1786:	83 c0 01             	add    $0x1,%eax
    1789:	89 45 f4             	mov    %eax,-0xc(%ebp)
    178c:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1791:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1794:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1798:	75 23                	jne    17bd <malloc+0x46>
    179a:	c7 45 f0 40 1e 00 00 	movl   $0x1e40,-0x10(%ebp)
    17a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a4:	a3 48 1e 00 00       	mov    %eax,0x1e48
    17a9:	a1 48 1e 00 00       	mov    0x1e48,%eax
    17ae:	a3 40 1e 00 00       	mov    %eax,0x1e40
    17b3:	c7 05 44 1e 00 00 00 	movl   $0x0,0x1e44
    17ba:	00 00 00 
    17bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c0:	8b 00                	mov    (%eax),%eax
    17c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c8:	8b 40 04             	mov    0x4(%eax),%eax
    17cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17ce:	72 4d                	jb     181d <malloc+0xa6>
    17d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d3:	8b 40 04             	mov    0x4(%eax),%eax
    17d6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17d9:	75 0c                	jne    17e7 <malloc+0x70>
    17db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17de:	8b 10                	mov    (%eax),%edx
    17e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e3:	89 10                	mov    %edx,(%eax)
    17e5:	eb 26                	jmp    180d <malloc+0x96>
    17e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ea:	8b 40 04             	mov    0x4(%eax),%eax
    17ed:	89 c2                	mov    %eax,%edx
    17ef:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f5:	89 50 04             	mov    %edx,0x4(%eax)
    17f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17fb:	8b 40 04             	mov    0x4(%eax),%eax
    17fe:	c1 e0 03             	shl    $0x3,%eax
    1801:	01 45 ec             	add    %eax,-0x14(%ebp)
    1804:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1807:	8b 55 f4             	mov    -0xc(%ebp),%edx
    180a:	89 50 04             	mov    %edx,0x4(%eax)
    180d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1810:	a3 48 1e 00 00       	mov    %eax,0x1e48
    1815:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1818:	83 c0 08             	add    $0x8,%eax
    181b:	eb 38                	jmp    1855 <malloc+0xde>
    181d:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1822:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1825:	75 1b                	jne    1842 <malloc+0xcb>
    1827:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182a:	89 04 24             	mov    %eax,(%esp)
    182d:	e8 ed fe ff ff       	call   171f <morecore>
    1832:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1835:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1839:	75 07                	jne    1842 <malloc+0xcb>
    183b:	b8 00 00 00 00       	mov    $0x0,%eax
    1840:	eb 13                	jmp    1855 <malloc+0xde>
    1842:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1845:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1848:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184b:	8b 00                	mov    (%eax),%eax
    184d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1850:	e9 70 ff ff ff       	jmp    17c5 <malloc+0x4e>
    1855:	c9                   	leave  
    1856:	c3                   	ret    
    1857:	90                   	nop

00001858 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1858:	55                   	push   %ebp
    1859:	89 e5                	mov    %esp,%ebp
    185b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    185e:	8b 55 08             	mov    0x8(%ebp),%edx
    1861:	8b 45 0c             	mov    0xc(%ebp),%eax
    1864:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1867:	f0 87 02             	lock xchg %eax,(%edx)
    186a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    186d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1870:	c9                   	leave  
    1871:	c3                   	ret    

00001872 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1872:	55                   	push   %ebp
    1873:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    187e:	5d                   	pop    %ebp
    187f:	c3                   	ret    

00001880 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1886:	90                   	nop
    1887:	8b 45 08             	mov    0x8(%ebp),%eax
    188a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1891:	00 
    1892:	89 04 24             	mov    %eax,(%esp)
    1895:	e8 be ff ff ff       	call   1858 <xchg>
    189a:	85 c0                	test   %eax,%eax
    189c:	75 e9                	jne    1887 <lock_acquire+0x7>
}
    189e:	c9                   	leave  
    189f:	c3                   	ret    

000018a0 <lock_release>:
void lock_release(lock_t *lock){
    18a0:	55                   	push   %ebp
    18a1:	89 e5                	mov    %esp,%ebp
    18a3:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18a6:	8b 45 08             	mov    0x8(%ebp),%eax
    18a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18b0:	00 
    18b1:	89 04 24             	mov    %eax,(%esp)
    18b4:	e8 9f ff ff ff       	call   1858 <xchg>
}
    18b9:	c9                   	leave  
    18ba:	c3                   	ret    

000018bb <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18bb:	55                   	push   %ebp
    18bc:	89 e5                	mov    %esp,%ebp
    18be:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18c1:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18c8:	e8 aa fe ff ff       	call   1777 <malloc>
    18cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18de:	85 c0                	test   %eax,%eax
    18e0:	74 14                	je     18f6 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e5:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ea:	89 c2                	mov    %eax,%edx
    18ec:	b8 00 10 00 00       	mov    $0x1000,%eax
    18f1:	29 d0                	sub    %edx,%eax
    18f3:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18fa:	75 1b                	jne    1917 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18fc:	c7 44 24 04 d8 1a 00 	movl   $0x1ad8,0x4(%esp)
    1903:	00 
    1904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190b:	e8 84 fb ff ff       	call   1494 <printf>
        return 0;
    1910:	b8 00 00 00 00       	mov    $0x0,%eax
    1915:	eb 6f                	jmp    1986 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1917:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    191a:	8b 55 08             	mov    0x8(%ebp),%edx
    191d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1920:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1924:	89 54 24 08          	mov    %edx,0x8(%esp)
    1928:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    192f:	00 
    1930:	89 04 24             	mov    %eax,(%esp)
    1933:	e8 5c fa ff ff       	call   1394 <clone>
    1938:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    193b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193f:	79 1b                	jns    195c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1941:	c7 44 24 04 e6 1a 00 	movl   $0x1ae6,0x4(%esp)
    1948:	00 
    1949:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1950:	e8 3f fb ff ff       	call   1494 <printf>
        return 0;
    1955:	b8 00 00 00 00       	mov    $0x0,%eax
    195a:	eb 2a                	jmp    1986 <thread_create+0xcb>
    }
    if(tid > 0){
    195c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1960:	7e 05                	jle    1967 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1962:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1965:	eb 1f                	jmp    1986 <thread_create+0xcb>
    }
    if(tid == 0){
    1967:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    196b:	75 14                	jne    1981 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    196d:	c7 44 24 04 f3 1a 00 	movl   $0x1af3,0x4(%esp)
    1974:	00 
    1975:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197c:	e8 13 fb ff ff       	call   1494 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1981:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1986:	c9                   	leave  
    1987:	c3                   	ret    

00001988 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1988:	55                   	push   %ebp
    1989:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    198b:	a1 3c 1e 00 00       	mov    0x1e3c,%eax
    1990:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1996:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    199b:	a3 3c 1e 00 00       	mov    %eax,0x1e3c
    return (int)(rands % max);
    19a0:	a1 3c 1e 00 00       	mov    0x1e3c,%eax
    19a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19a8:	ba 00 00 00 00       	mov    $0x0,%edx
    19ad:	f7 f1                	div    %ecx
    19af:	89 d0                	mov    %edx,%eax
}
    19b1:	5d                   	pop    %ebp
    19b2:	c3                   	ret    
    19b3:	90                   	nop

000019b4 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19b4:	55                   	push   %ebp
    19b5:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19c0:	8b 45 08             	mov    0x8(%ebp),%eax
    19c3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19d4:	5d                   	pop    %ebp
    19d5:	c3                   	ret    

000019d6 <add_q>:

void add_q(struct queue *q, int v){
    19d6:	55                   	push   %ebp
    19d7:	89 e5                	mov    %esp,%ebp
    19d9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19dc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19e3:	e8 8f fd ff ff       	call   1777 <malloc>
    19e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ee:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19fb:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	8b 40 04             	mov    0x4(%eax),%eax
    1a03:	85 c0                	test   %eax,%eax
    1a05:	75 0b                	jne    1a12 <add_q+0x3c>
        q->head = n;
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0d:	89 50 04             	mov    %edx,0x4(%eax)
    1a10:	eb 0c                	jmp    1a1e <add_q+0x48>
    }else{
        q->tail->next = n;
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	8b 40 08             	mov    0x8(%eax),%eax
    1a18:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a1b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a24:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a27:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2a:	8b 00                	mov    (%eax),%eax
    1a2c:	8d 50 01             	lea    0x1(%eax),%edx
    1a2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a32:	89 10                	mov    %edx,(%eax)
}
    1a34:	c9                   	leave  
    1a35:	c3                   	ret    

00001a36 <empty_q>:

int empty_q(struct queue *q){
    1a36:	55                   	push   %ebp
    1a37:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a39:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3c:	8b 00                	mov    (%eax),%eax
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	75 07                	jne    1a49 <empty_q+0x13>
        return 1;
    1a42:	b8 01 00 00 00       	mov    $0x1,%eax
    1a47:	eb 05                	jmp    1a4e <empty_q+0x18>
    else
        return 0;
    1a49:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a4e:	5d                   	pop    %ebp
    1a4f:	c3                   	ret    

00001a50 <pop_q>:
int pop_q(struct queue *q){
    1a50:	55                   	push   %ebp
    1a51:	89 e5                	mov    %esp,%ebp
    1a53:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a56:	8b 45 08             	mov    0x8(%ebp),%eax
    1a59:	89 04 24             	mov    %eax,(%esp)
    1a5c:	e8 d5 ff ff ff       	call   1a36 <empty_q>
    1a61:	85 c0                	test   %eax,%eax
    1a63:	75 5d                	jne    1ac2 <pop_q+0x72>
       val = q->head->value; 
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	8b 40 04             	mov    0x4(%eax),%eax
    1a6b:	8b 00                	mov    (%eax),%eax
    1a6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 40 04             	mov    0x4(%eax),%eax
    1a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a79:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7c:	8b 40 04             	mov    0x4(%eax),%eax
    1a7f:	8b 50 04             	mov    0x4(%eax),%edx
    1a82:	8b 45 08             	mov    0x8(%ebp),%eax
    1a85:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a8b:	89 04 24             	mov    %eax,(%esp)
    1a8e:	e8 b5 fb ff ff       	call   1648 <free>
       q->size--;
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	8b 00                	mov    (%eax),%eax
    1a98:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa3:	8b 00                	mov    (%eax),%eax
    1aa5:	85 c0                	test   %eax,%eax
    1aa7:	75 14                	jne    1abd <pop_q+0x6d>
            q->head = 0;
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac0:	eb 05                	jmp    1ac7 <pop_q+0x77>
    }
    return -1;
    1ac2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ac7:	c9                   	leave  
    1ac8:	c3                   	ret    
