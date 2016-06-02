
_test_random:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"


int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
    printf(1,"random number %d\n",random(100));
    1009:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1010:	e8 bf 09 00 00       	call   19d4 <random>
    1015:	89 44 24 08          	mov    %eax,0x8(%esp)
    1019:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    1020:	00 
    1021:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1028:	e8 a7 04 00 00       	call   14d4 <printf>
    printf(1,"random number %d\n",random(100));
    102d:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1034:	e8 9b 09 00 00       	call   19d4 <random>
    1039:	89 44 24 08          	mov    %eax,0x8(%esp)
    103d:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104c:	e8 83 04 00 00       	call   14d4 <printf>
    printf(1,"random number %d\n",random(100));
    1051:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1058:	e8 77 09 00 00       	call   19d4 <random>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 5f 04 00 00       	call   14d4 <printf>
    printf(1,"random number %d\n",random(100));
    1075:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    107c:	e8 53 09 00 00       	call   19d4 <random>
    1081:	89 44 24 08          	mov    %eax,0x8(%esp)
    1085:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 3b 04 00 00       	call   14d4 <printf>
    printf(1,"random number %d\n",random(100));
    1099:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    10a0:	e8 2f 09 00 00       	call   19d4 <random>
    10a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    10a9:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    10b0:	00 
    10b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b8:	e8 17 04 00 00       	call   14d4 <printf>

    exit();
    10bd:	e8 6a 02 00 00       	call   132c <exit>
    10c2:	66 90                	xchg   %ax,%ax

000010c4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10c4:	55                   	push   %ebp
    10c5:	89 e5                	mov    %esp,%ebp
    10c7:	57                   	push   %edi
    10c8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    10c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10cc:	8b 55 10             	mov    0x10(%ebp),%edx
    10cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d2:	89 cb                	mov    %ecx,%ebx
    10d4:	89 df                	mov    %ebx,%edi
    10d6:	89 d1                	mov    %edx,%ecx
    10d8:	fc                   	cld    
    10d9:	f3 aa                	rep stos %al,%es:(%edi)
    10db:	89 ca                	mov    %ecx,%edx
    10dd:	89 fb                	mov    %edi,%ebx
    10df:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10e2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10e5:	5b                   	pop    %ebx
    10e6:	5f                   	pop    %edi
    10e7:	5d                   	pop    %ebp
    10e8:	c3                   	ret    

000010e9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10e9:	55                   	push   %ebp
    10ea:	89 e5                	mov    %esp,%ebp
    10ec:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10f5:	90                   	nop
    10f6:	8b 45 08             	mov    0x8(%ebp),%eax
    10f9:	8d 50 01             	lea    0x1(%eax),%edx
    10fc:	89 55 08             	mov    %edx,0x8(%ebp)
    10ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1102:	8d 4a 01             	lea    0x1(%edx),%ecx
    1105:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1108:	0f b6 12             	movzbl (%edx),%edx
    110b:	88 10                	mov    %dl,(%eax)
    110d:	0f b6 00             	movzbl (%eax),%eax
    1110:	84 c0                	test   %al,%al
    1112:	75 e2                	jne    10f6 <strcpy+0xd>
    ;
  return os;
    1114:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1117:	c9                   	leave  
    1118:	c3                   	ret    

00001119 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1119:	55                   	push   %ebp
    111a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    111c:	eb 08                	jmp    1126 <strcmp+0xd>
    p++, q++;
    111e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1122:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	0f b6 00             	movzbl (%eax),%eax
    112c:	84 c0                	test   %al,%al
    112e:	74 10                	je     1140 <strcmp+0x27>
    1130:	8b 45 08             	mov    0x8(%ebp),%eax
    1133:	0f b6 10             	movzbl (%eax),%edx
    1136:	8b 45 0c             	mov    0xc(%ebp),%eax
    1139:	0f b6 00             	movzbl (%eax),%eax
    113c:	38 c2                	cmp    %al,%dl
    113e:	74 de                	je     111e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	0f b6 00             	movzbl (%eax),%eax
    1146:	0f b6 d0             	movzbl %al,%edx
    1149:	8b 45 0c             	mov    0xc(%ebp),%eax
    114c:	0f b6 00             	movzbl (%eax),%eax
    114f:	0f b6 c0             	movzbl %al,%eax
    1152:	29 c2                	sub    %eax,%edx
    1154:	89 d0                	mov    %edx,%eax
}
    1156:	5d                   	pop    %ebp
    1157:	c3                   	ret    

00001158 <strlen>:

uint
strlen(char *s)
{
    1158:	55                   	push   %ebp
    1159:	89 e5                	mov    %esp,%ebp
    115b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1165:	eb 04                	jmp    116b <strlen+0x13>
    1167:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    116b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	01 d0                	add    %edx,%eax
    1173:	0f b6 00             	movzbl (%eax),%eax
    1176:	84 c0                	test   %al,%al
    1178:	75 ed                	jne    1167 <strlen+0xf>
    ;
  return n;
    117a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    117d:	c9                   	leave  
    117e:	c3                   	ret    

0000117f <memset>:

void*
memset(void *dst, int c, uint n)
{
    117f:	55                   	push   %ebp
    1180:	89 e5                	mov    %esp,%ebp
    1182:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1185:	8b 45 10             	mov    0x10(%ebp),%eax
    1188:	89 44 24 08          	mov    %eax,0x8(%esp)
    118c:	8b 45 0c             	mov    0xc(%ebp),%eax
    118f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	89 04 24             	mov    %eax,(%esp)
    1199:	e8 26 ff ff ff       	call   10c4 <stosb>
  return dst;
    119e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11a1:	c9                   	leave  
    11a2:	c3                   	ret    

000011a3 <strchr>:

char*
strchr(const char *s, char c)
{
    11a3:	55                   	push   %ebp
    11a4:	89 e5                	mov    %esp,%ebp
    11a6:	83 ec 04             	sub    $0x4,%esp
    11a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ac:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11af:	eb 14                	jmp    11c5 <strchr+0x22>
    if(*s == c)
    11b1:	8b 45 08             	mov    0x8(%ebp),%eax
    11b4:	0f b6 00             	movzbl (%eax),%eax
    11b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
    11ba:	75 05                	jne    11c1 <strchr+0x1e>
      return (char*)s;
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	eb 13                	jmp    11d4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11c5:	8b 45 08             	mov    0x8(%ebp),%eax
    11c8:	0f b6 00             	movzbl (%eax),%eax
    11cb:	84 c0                	test   %al,%al
    11cd:	75 e2                	jne    11b1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    11cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11d4:	c9                   	leave  
    11d5:	c3                   	ret    

000011d6 <gets>:

char*
gets(char *buf, int max)
{
    11d6:	55                   	push   %ebp
    11d7:	89 e5                	mov    %esp,%ebp
    11d9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11e3:	eb 4c                	jmp    1231 <gets+0x5b>
    cc = read(0, &c, 1);
    11e5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11ec:	00 
    11ed:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    11f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11fb:	e8 44 01 00 00       	call   1344 <read>
    1200:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1203:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1207:	7f 02                	jg     120b <gets+0x35>
      break;
    1209:	eb 31                	jmp    123c <gets+0x66>
    buf[i++] = c;
    120b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    120e:	8d 50 01             	lea    0x1(%eax),%edx
    1211:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1214:	89 c2                	mov    %eax,%edx
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	01 c2                	add    %eax,%edx
    121b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    121f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1221:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1225:	3c 0a                	cmp    $0xa,%al
    1227:	74 13                	je     123c <gets+0x66>
    1229:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    122d:	3c 0d                	cmp    $0xd,%al
    122f:	74 0b                	je     123c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1231:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1234:	83 c0 01             	add    $0x1,%eax
    1237:	3b 45 0c             	cmp    0xc(%ebp),%eax
    123a:	7c a9                	jl     11e5 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    123c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	01 d0                	add    %edx,%eax
    1244:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1247:	8b 45 08             	mov    0x8(%ebp),%eax
}
    124a:	c9                   	leave  
    124b:	c3                   	ret    

0000124c <stat>:

int
stat(char *n, struct stat *st)
{
    124c:	55                   	push   %ebp
    124d:	89 e5                	mov    %esp,%ebp
    124f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1252:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1259:	00 
    125a:	8b 45 08             	mov    0x8(%ebp),%eax
    125d:	89 04 24             	mov    %eax,(%esp)
    1260:	e8 07 01 00 00       	call   136c <open>
    1265:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1268:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    126c:	79 07                	jns    1275 <stat+0x29>
    return -1;
    126e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1273:	eb 23                	jmp    1298 <stat+0x4c>
  r = fstat(fd, st);
    1275:	8b 45 0c             	mov    0xc(%ebp),%eax
    1278:	89 44 24 04          	mov    %eax,0x4(%esp)
    127c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    127f:	89 04 24             	mov    %eax,(%esp)
    1282:	e8 fd 00 00 00       	call   1384 <fstat>
    1287:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    128a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    128d:	89 04 24             	mov    %eax,(%esp)
    1290:	e8 bf 00 00 00       	call   1354 <close>
  return r;
    1295:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1298:	c9                   	leave  
    1299:	c3                   	ret    

0000129a <atoi>:

int
atoi(const char *s)
{
    129a:	55                   	push   %ebp
    129b:	89 e5                	mov    %esp,%ebp
    129d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12a7:	eb 25                	jmp    12ce <atoi+0x34>
    n = n*10 + *s++ - '0';
    12a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12ac:	89 d0                	mov    %edx,%eax
    12ae:	c1 e0 02             	shl    $0x2,%eax
    12b1:	01 d0                	add    %edx,%eax
    12b3:	01 c0                	add    %eax,%eax
    12b5:	89 c1                	mov    %eax,%ecx
    12b7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ba:	8d 50 01             	lea    0x1(%eax),%edx
    12bd:	89 55 08             	mov    %edx,0x8(%ebp)
    12c0:	0f b6 00             	movzbl (%eax),%eax
    12c3:	0f be c0             	movsbl %al,%eax
    12c6:	01 c8                	add    %ecx,%eax
    12c8:	83 e8 30             	sub    $0x30,%eax
    12cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12ce:	8b 45 08             	mov    0x8(%ebp),%eax
    12d1:	0f b6 00             	movzbl (%eax),%eax
    12d4:	3c 2f                	cmp    $0x2f,%al
    12d6:	7e 0a                	jle    12e2 <atoi+0x48>
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
    12db:	0f b6 00             	movzbl (%eax),%eax
    12de:	3c 39                	cmp    $0x39,%al
    12e0:	7e c7                	jle    12a9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12e5:	c9                   	leave  
    12e6:	c3                   	ret    

000012e7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12e7:	55                   	push   %ebp
    12e8:	89 e5                	mov    %esp,%ebp
    12ea:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12f9:	eb 17                	jmp    1312 <memmove+0x2b>
    *dst++ = *src++;
    12fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12fe:	8d 50 01             	lea    0x1(%eax),%edx
    1301:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1304:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1307:	8d 4a 01             	lea    0x1(%edx),%ecx
    130a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    130d:	0f b6 12             	movzbl (%edx),%edx
    1310:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1312:	8b 45 10             	mov    0x10(%ebp),%eax
    1315:	8d 50 ff             	lea    -0x1(%eax),%edx
    1318:	89 55 10             	mov    %edx,0x10(%ebp)
    131b:	85 c0                	test   %eax,%eax
    131d:	7f dc                	jg     12fb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    131f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1322:	c9                   	leave  
    1323:	c3                   	ret    

00001324 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1324:	b8 01 00 00 00       	mov    $0x1,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <exit>:
SYSCALL(exit)
    132c:	b8 02 00 00 00       	mov    $0x2,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <wait>:
SYSCALL(wait)
    1334:	b8 03 00 00 00       	mov    $0x3,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <pipe>:
SYSCALL(pipe)
    133c:	b8 04 00 00 00       	mov    $0x4,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <read>:
SYSCALL(read)
    1344:	b8 05 00 00 00       	mov    $0x5,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <write>:
SYSCALL(write)
    134c:	b8 10 00 00 00       	mov    $0x10,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <close>:
SYSCALL(close)
    1354:	b8 15 00 00 00       	mov    $0x15,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <kill>:
SYSCALL(kill)
    135c:	b8 06 00 00 00       	mov    $0x6,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <exec>:
SYSCALL(exec)
    1364:	b8 07 00 00 00       	mov    $0x7,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <open>:
SYSCALL(open)
    136c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <mknod>:
SYSCALL(mknod)
    1374:	b8 11 00 00 00       	mov    $0x11,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <unlink>:
SYSCALL(unlink)
    137c:	b8 12 00 00 00       	mov    $0x12,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <fstat>:
SYSCALL(fstat)
    1384:	b8 08 00 00 00       	mov    $0x8,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <link>:
SYSCALL(link)
    138c:	b8 13 00 00 00       	mov    $0x13,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <mkdir>:
SYSCALL(mkdir)
    1394:	b8 14 00 00 00       	mov    $0x14,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <chdir>:
SYSCALL(chdir)
    139c:	b8 09 00 00 00       	mov    $0x9,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <dup>:
SYSCALL(dup)
    13a4:	b8 0a 00 00 00       	mov    $0xa,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <getpid>:
SYSCALL(getpid)
    13ac:	b8 0b 00 00 00       	mov    $0xb,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <sbrk>:
SYSCALL(sbrk)
    13b4:	b8 0c 00 00 00       	mov    $0xc,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <sleep>:
SYSCALL(sleep)
    13bc:	b8 0d 00 00 00       	mov    $0xd,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <uptime>:
SYSCALL(uptime)
    13c4:	b8 0e 00 00 00       	mov    $0xe,%eax
    13c9:	cd 40                	int    $0x40
    13cb:	c3                   	ret    

000013cc <clone>:
SYSCALL(clone)
    13cc:	b8 16 00 00 00       	mov    $0x16,%eax
    13d1:	cd 40                	int    $0x40
    13d3:	c3                   	ret    

000013d4 <texit>:
SYSCALL(texit)
    13d4:	b8 17 00 00 00       	mov    $0x17,%eax
    13d9:	cd 40                	int    $0x40
    13db:	c3                   	ret    

000013dc <tsleep>:
SYSCALL(tsleep)
    13dc:	b8 18 00 00 00       	mov    $0x18,%eax
    13e1:	cd 40                	int    $0x40
    13e3:	c3                   	ret    

000013e4 <twakeup>:
SYSCALL(twakeup)
    13e4:	b8 19 00 00 00       	mov    $0x19,%eax
    13e9:	cd 40                	int    $0x40
    13eb:	c3                   	ret    

000013ec <thread_yield>:
SYSCALL(thread_yield)
    13ec:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13f1:	cd 40                	int    $0x40
    13f3:	c3                   	ret    

000013f4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13f4:	55                   	push   %ebp
    13f5:	89 e5                	mov    %esp,%ebp
    13f7:	83 ec 18             	sub    $0x18,%esp
    13fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1400:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1407:	00 
    1408:	8d 45 f4             	lea    -0xc(%ebp),%eax
    140b:	89 44 24 04          	mov    %eax,0x4(%esp)
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	89 04 24             	mov    %eax,(%esp)
    1415:	e8 32 ff ff ff       	call   134c <write>
}
    141a:	c9                   	leave  
    141b:	c3                   	ret    

0000141c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    141c:	55                   	push   %ebp
    141d:	89 e5                	mov    %esp,%ebp
    141f:	56                   	push   %esi
    1420:	53                   	push   %ebx
    1421:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1424:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    142b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    142f:	74 17                	je     1448 <printint+0x2c>
    1431:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1435:	79 11                	jns    1448 <printint+0x2c>
    neg = 1;
    1437:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    143e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1441:	f7 d8                	neg    %eax
    1443:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1446:	eb 06                	jmp    144e <printint+0x32>
  } else {
    x = xx;
    1448:	8b 45 0c             	mov    0xc(%ebp),%eax
    144b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    144e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1455:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1458:	8d 41 01             	lea    0x1(%ecx),%eax
    145b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    145e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1461:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1464:	ba 00 00 00 00       	mov    $0x0,%edx
    1469:	f7 f3                	div    %ebx
    146b:	89 d0                	mov    %edx,%eax
    146d:	0f b6 80 e0 1e 00 00 	movzbl 0x1ee0(%eax),%eax
    1474:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1478:	8b 75 10             	mov    0x10(%ebp),%esi
    147b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    147e:	ba 00 00 00 00       	mov    $0x0,%edx
    1483:	f7 f6                	div    %esi
    1485:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1488:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    148c:	75 c7                	jne    1455 <printint+0x39>
  if(neg)
    148e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1492:	74 10                	je     14a4 <printint+0x88>
    buf[i++] = '-';
    1494:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1497:	8d 50 01             	lea    0x1(%eax),%edx
    149a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    149d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14a2:	eb 1f                	jmp    14c3 <printint+0xa7>
    14a4:	eb 1d                	jmp    14c3 <printint+0xa7>
    putc(fd, buf[i]);
    14a6:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ac:	01 d0                	add    %edx,%eax
    14ae:	0f b6 00             	movzbl (%eax),%eax
    14b1:	0f be c0             	movsbl %al,%eax
    14b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	89 04 24             	mov    %eax,(%esp)
    14be:	e8 31 ff ff ff       	call   13f4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14c3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    14c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14cb:	79 d9                	jns    14a6 <printint+0x8a>
    putc(fd, buf[i]);
}
    14cd:	83 c4 30             	add    $0x30,%esp
    14d0:	5b                   	pop    %ebx
    14d1:	5e                   	pop    %esi
    14d2:	5d                   	pop    %ebp
    14d3:	c3                   	ret    

000014d4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14d4:	55                   	push   %ebp
    14d5:	89 e5                	mov    %esp,%ebp
    14d7:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14e1:	8d 45 0c             	lea    0xc(%ebp),%eax
    14e4:	83 c0 04             	add    $0x4,%eax
    14e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14f1:	e9 7c 01 00 00       	jmp    1672 <printf+0x19e>
    c = fmt[i] & 0xff;
    14f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fc:	01 d0                	add    %edx,%eax
    14fe:	0f b6 00             	movzbl (%eax),%eax
    1501:	0f be c0             	movsbl %al,%eax
    1504:	25 ff 00 00 00       	and    $0xff,%eax
    1509:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    150c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1510:	75 2c                	jne    153e <printf+0x6a>
      if(c == '%'){
    1512:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1516:	75 0c                	jne    1524 <printf+0x50>
        state = '%';
    1518:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    151f:	e9 4a 01 00 00       	jmp    166e <printf+0x19a>
      } else {
        putc(fd, c);
    1524:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1527:	0f be c0             	movsbl %al,%eax
    152a:	89 44 24 04          	mov    %eax,0x4(%esp)
    152e:	8b 45 08             	mov    0x8(%ebp),%eax
    1531:	89 04 24             	mov    %eax,(%esp)
    1534:	e8 bb fe ff ff       	call   13f4 <putc>
    1539:	e9 30 01 00 00       	jmp    166e <printf+0x19a>
      }
    } else if(state == '%'){
    153e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1542:	0f 85 26 01 00 00    	jne    166e <printf+0x19a>
      if(c == 'd'){
    1548:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    154c:	75 2d                	jne    157b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    154e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1551:	8b 00                	mov    (%eax),%eax
    1553:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    155a:	00 
    155b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1562:	00 
    1563:	89 44 24 04          	mov    %eax,0x4(%esp)
    1567:	8b 45 08             	mov    0x8(%ebp),%eax
    156a:	89 04 24             	mov    %eax,(%esp)
    156d:	e8 aa fe ff ff       	call   141c <printint>
        ap++;
    1572:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1576:	e9 ec 00 00 00       	jmp    1667 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    157b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    157f:	74 06                	je     1587 <printf+0xb3>
    1581:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1585:	75 2d                	jne    15b4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1587:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158a:	8b 00                	mov    (%eax),%eax
    158c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1593:	00 
    1594:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    159b:	00 
    159c:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a0:	8b 45 08             	mov    0x8(%ebp),%eax
    15a3:	89 04 24             	mov    %eax,(%esp)
    15a6:	e8 71 fe ff ff       	call   141c <printint>
        ap++;
    15ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15af:	e9 b3 00 00 00       	jmp    1667 <printf+0x193>
      } else if(c == 's'){
    15b4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    15b8:	75 45                	jne    15ff <printf+0x12b>
        s = (char*)*ap;
    15ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15bd:	8b 00                	mov    (%eax),%eax
    15bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    15c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    15c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ca:	75 09                	jne    15d5 <printf+0x101>
          s = "(null)";
    15cc:	c7 45 f4 27 1b 00 00 	movl   $0x1b27,-0xc(%ebp)
        while(*s != 0){
    15d3:	eb 1e                	jmp    15f3 <printf+0x11f>
    15d5:	eb 1c                	jmp    15f3 <printf+0x11f>
          putc(fd, *s);
    15d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15da:	0f b6 00             	movzbl (%eax),%eax
    15dd:	0f be c0             	movsbl %al,%eax
    15e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e4:	8b 45 08             	mov    0x8(%ebp),%eax
    15e7:	89 04 24             	mov    %eax,(%esp)
    15ea:	e8 05 fe ff ff       	call   13f4 <putc>
          s++;
    15ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	84 c0                	test   %al,%al
    15fb:	75 da                	jne    15d7 <printf+0x103>
    15fd:	eb 68                	jmp    1667 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15ff:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1603:	75 1d                	jne    1622 <printf+0x14e>
        putc(fd, *ap);
    1605:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1608:	8b 00                	mov    (%eax),%eax
    160a:	0f be c0             	movsbl %al,%eax
    160d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1611:	8b 45 08             	mov    0x8(%ebp),%eax
    1614:	89 04 24             	mov    %eax,(%esp)
    1617:	e8 d8 fd ff ff       	call   13f4 <putc>
        ap++;
    161c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1620:	eb 45                	jmp    1667 <printf+0x193>
      } else if(c == '%'){
    1622:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1626:	75 17                	jne    163f <printf+0x16b>
        putc(fd, c);
    1628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    162b:	0f be c0             	movsbl %al,%eax
    162e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1632:	8b 45 08             	mov    0x8(%ebp),%eax
    1635:	89 04 24             	mov    %eax,(%esp)
    1638:	e8 b7 fd ff ff       	call   13f4 <putc>
    163d:	eb 28                	jmp    1667 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    163f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1646:	00 
    1647:	8b 45 08             	mov    0x8(%ebp),%eax
    164a:	89 04 24             	mov    %eax,(%esp)
    164d:	e8 a2 fd ff ff       	call   13f4 <putc>
        putc(fd, c);
    1652:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1655:	0f be c0             	movsbl %al,%eax
    1658:	89 44 24 04          	mov    %eax,0x4(%esp)
    165c:	8b 45 08             	mov    0x8(%ebp),%eax
    165f:	89 04 24             	mov    %eax,(%esp)
    1662:	e8 8d fd ff ff       	call   13f4 <putc>
      }
      state = 0;
    1667:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    166e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1672:	8b 55 0c             	mov    0xc(%ebp),%edx
    1675:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1678:	01 d0                	add    %edx,%eax
    167a:	0f b6 00             	movzbl (%eax),%eax
    167d:	84 c0                	test   %al,%al
    167f:	0f 85 71 fe ff ff    	jne    14f6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1685:	c9                   	leave  
    1686:	c3                   	ret    
    1687:	90                   	nop

00001688 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1688:	55                   	push   %ebp
    1689:	89 e5                	mov    %esp,%ebp
    168b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	83 e8 08             	sub    $0x8,%eax
    1694:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1697:	a1 00 1f 00 00       	mov    0x1f00,%eax
    169c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    169f:	eb 24                	jmp    16c5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16a9:	77 12                	ja     16bd <free+0x35>
    16ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16b1:	77 24                	ja     16d7 <free+0x4f>
    16b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b6:	8b 00                	mov    (%eax),%eax
    16b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16bb:	77 1a                	ja     16d7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c0:	8b 00                	mov    (%eax),%eax
    16c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16cb:	76 d4                	jbe    16a1 <free+0x19>
    16cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d0:	8b 00                	mov    (%eax),%eax
    16d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16d5:	76 ca                	jbe    16a1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16da:	8b 40 04             	mov    0x4(%eax),%eax
    16dd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e7:	01 c2                	add    %eax,%edx
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	8b 00                	mov    (%eax),%eax
    16ee:	39 c2                	cmp    %eax,%edx
    16f0:	75 24                	jne    1716 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    16f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f5:	8b 50 04             	mov    0x4(%eax),%edx
    16f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fb:	8b 00                	mov    (%eax),%eax
    16fd:	8b 40 04             	mov    0x4(%eax),%eax
    1700:	01 c2                	add    %eax,%edx
    1702:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1705:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1708:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170b:	8b 00                	mov    (%eax),%eax
    170d:	8b 10                	mov    (%eax),%edx
    170f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1712:	89 10                	mov    %edx,(%eax)
    1714:	eb 0a                	jmp    1720 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1716:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1719:	8b 10                	mov    (%eax),%edx
    171b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1720:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1723:	8b 40 04             	mov    0x4(%eax),%eax
    1726:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    172d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1730:	01 d0                	add    %edx,%eax
    1732:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1735:	75 20                	jne    1757 <free+0xcf>
    p->s.size += bp->s.size;
    1737:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173a:	8b 50 04             	mov    0x4(%eax),%edx
    173d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1740:	8b 40 04             	mov    0x4(%eax),%eax
    1743:	01 c2                	add    %eax,%edx
    1745:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1748:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    174b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174e:	8b 10                	mov    (%eax),%edx
    1750:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1753:	89 10                	mov    %edx,(%eax)
    1755:	eb 08                	jmp    175f <free+0xd7>
  } else
    p->s.ptr = bp;
    1757:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    175d:	89 10                	mov    %edx,(%eax)
  freep = p;
    175f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1762:	a3 00 1f 00 00       	mov    %eax,0x1f00
}
    1767:	c9                   	leave  
    1768:	c3                   	ret    

00001769 <morecore>:

static Header*
morecore(uint nu)
{
    1769:	55                   	push   %ebp
    176a:	89 e5                	mov    %esp,%ebp
    176c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    176f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1776:	77 07                	ja     177f <morecore+0x16>
    nu = 4096;
    1778:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    177f:	8b 45 08             	mov    0x8(%ebp),%eax
    1782:	c1 e0 03             	shl    $0x3,%eax
    1785:	89 04 24             	mov    %eax,(%esp)
    1788:	e8 27 fc ff ff       	call   13b4 <sbrk>
    178d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1790:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1794:	75 07                	jne    179d <morecore+0x34>
    return 0;
    1796:	b8 00 00 00 00       	mov    $0x0,%eax
    179b:	eb 22                	jmp    17bf <morecore+0x56>
  hp = (Header*)p;
    179d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a6:	8b 55 08             	mov    0x8(%ebp),%edx
    17a9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17af:	83 c0 08             	add    $0x8,%eax
    17b2:	89 04 24             	mov    %eax,(%esp)
    17b5:	e8 ce fe ff ff       	call   1688 <free>
  return freep;
    17ba:	a1 00 1f 00 00       	mov    0x1f00,%eax
}
    17bf:	c9                   	leave  
    17c0:	c3                   	ret    

000017c1 <malloc>:

void*
malloc(uint nbytes)
{
    17c1:	55                   	push   %ebp
    17c2:	89 e5                	mov    %esp,%ebp
    17c4:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17c7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ca:	83 c0 07             	add    $0x7,%eax
    17cd:	c1 e8 03             	shr    $0x3,%eax
    17d0:	83 c0 01             	add    $0x1,%eax
    17d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    17d6:	a1 00 1f 00 00       	mov    0x1f00,%eax
    17db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17e2:	75 23                	jne    1807 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17e4:	c7 45 f0 f8 1e 00 00 	movl   $0x1ef8,-0x10(%ebp)
    17eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ee:	a3 00 1f 00 00       	mov    %eax,0x1f00
    17f3:	a1 00 1f 00 00       	mov    0x1f00,%eax
    17f8:	a3 f8 1e 00 00       	mov    %eax,0x1ef8
    base.s.size = 0;
    17fd:	c7 05 fc 1e 00 00 00 	movl   $0x0,0x1efc
    1804:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1807:	8b 45 f0             	mov    -0x10(%ebp),%eax
    180a:	8b 00                	mov    (%eax),%eax
    180c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    180f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1812:	8b 40 04             	mov    0x4(%eax),%eax
    1815:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1818:	72 4d                	jb     1867 <malloc+0xa6>
      if(p->s.size == nunits)
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	8b 40 04             	mov    0x4(%eax),%eax
    1820:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1823:	75 0c                	jne    1831 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	8b 10                	mov    (%eax),%edx
    182a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    182d:	89 10                	mov    %edx,(%eax)
    182f:	eb 26                	jmp    1857 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1831:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1834:	8b 40 04             	mov    0x4(%eax),%eax
    1837:	2b 45 ec             	sub    -0x14(%ebp),%eax
    183a:	89 c2                	mov    %eax,%edx
    183c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1842:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1845:	8b 40 04             	mov    0x4(%eax),%eax
    1848:	c1 e0 03             	shl    $0x3,%eax
    184b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    184e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1851:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1854:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1857:	8b 45 f0             	mov    -0x10(%ebp),%eax
    185a:	a3 00 1f 00 00       	mov    %eax,0x1f00
      return (void*)(p + 1);
    185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1862:	83 c0 08             	add    $0x8,%eax
    1865:	eb 38                	jmp    189f <malloc+0xde>
    }
    if(p == freep)
    1867:	a1 00 1f 00 00       	mov    0x1f00,%eax
    186c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    186f:	75 1b                	jne    188c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1871:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1874:	89 04 24             	mov    %eax,(%esp)
    1877:	e8 ed fe ff ff       	call   1769 <morecore>
    187c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    187f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1883:	75 07                	jne    188c <malloc+0xcb>
        return 0;
    1885:	b8 00 00 00 00       	mov    $0x0,%eax
    188a:	eb 13                	jmp    189f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    188c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1892:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1895:	8b 00                	mov    (%eax),%eax
    1897:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    189a:	e9 70 ff ff ff       	jmp    180f <malloc+0x4e>
}
    189f:	c9                   	leave  
    18a0:	c3                   	ret    
    18a1:	66 90                	xchg   %ax,%ax
    18a3:	90                   	nop

000018a4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18a4:	55                   	push   %ebp
    18a5:	89 e5                	mov    %esp,%ebp
    18a7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18aa:	8b 55 08             	mov    0x8(%ebp),%edx
    18ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    18b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18b3:	f0 87 02             	lock xchg %eax,(%edx)
    18b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18bc:	c9                   	leave  
    18bd:	c3                   	ret    

000018be <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18be:	55                   	push   %ebp
    18bf:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18c1:	8b 45 08             	mov    0x8(%ebp),%eax
    18c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18ca:	5d                   	pop    %ebp
    18cb:	c3                   	ret    

000018cc <lock_acquire>:
void lock_acquire(lock_t *lock){
    18cc:	55                   	push   %ebp
    18cd:	89 e5                	mov    %esp,%ebp
    18cf:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18d2:	90                   	nop
    18d3:	8b 45 08             	mov    0x8(%ebp),%eax
    18d6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18dd:	00 
    18de:	89 04 24             	mov    %eax,(%esp)
    18e1:	e8 be ff ff ff       	call   18a4 <xchg>
    18e6:	85 c0                	test   %eax,%eax
    18e8:	75 e9                	jne    18d3 <lock_acquire+0x7>
}
    18ea:	c9                   	leave  
    18eb:	c3                   	ret    

000018ec <lock_release>:
void lock_release(lock_t *lock){
    18ec:	55                   	push   %ebp
    18ed:	89 e5                	mov    %esp,%ebp
    18ef:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18f2:	8b 45 08             	mov    0x8(%ebp),%eax
    18f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18fc:	00 
    18fd:	89 04 24             	mov    %eax,(%esp)
    1900:	e8 9f ff ff ff       	call   18a4 <xchg>
}
    1905:	c9                   	leave  
    1906:	c3                   	ret    

00001907 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1907:	55                   	push   %ebp
    1908:	89 e5                	mov    %esp,%ebp
    190a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    190d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1914:	e8 a8 fe ff ff       	call   17c1 <malloc>
    1919:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    191c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1922:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1925:	25 ff 0f 00 00       	and    $0xfff,%eax
    192a:	85 c0                	test   %eax,%eax
    192c:	74 14                	je     1942 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    192e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1931:	25 ff 0f 00 00       	and    $0xfff,%eax
    1936:	89 c2                	mov    %eax,%edx
    1938:	b8 00 10 00 00       	mov    $0x1000,%eax
    193d:	29 d0                	sub    %edx,%eax
    193f:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1942:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1946:	75 1b                	jne    1963 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1948:	c7 44 24 04 2e 1b 00 	movl   $0x1b2e,0x4(%esp)
    194f:	00 
    1950:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1957:	e8 78 fb ff ff       	call   14d4 <printf>
        return 0;
    195c:	b8 00 00 00 00       	mov    $0x0,%eax
    1961:	eb 6f                	jmp    19d2 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1963:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1966:	8b 55 08             	mov    0x8(%ebp),%edx
    1969:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1970:	89 54 24 08          	mov    %edx,0x8(%esp)
    1974:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    197b:	00 
    197c:	89 04 24             	mov    %eax,(%esp)
    197f:	e8 48 fa ff ff       	call   13cc <clone>
    1984:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1987:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    198b:	79 1b                	jns    19a8 <thread_create+0xa1>
        printf(1,"clone fails\n");
    198d:	c7 44 24 04 3c 1b 00 	movl   $0x1b3c,0x4(%esp)
    1994:	00 
    1995:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    199c:	e8 33 fb ff ff       	call   14d4 <printf>
        return 0;
    19a1:	b8 00 00 00 00       	mov    $0x0,%eax
    19a6:	eb 2a                	jmp    19d2 <thread_create+0xcb>
    }
    if(tid > 0){
    19a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19ac:	7e 05                	jle    19b3 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    19ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b1:	eb 1f                	jmp    19d2 <thread_create+0xcb>
    }
    if(tid == 0){
    19b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19b7:	75 14                	jne    19cd <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    19b9:	c7 44 24 04 49 1b 00 	movl   $0x1b49,0x4(%esp)
    19c0:	00 
    19c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19c8:	e8 07 fb ff ff       	call   14d4 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19d2:	c9                   	leave  
    19d3:	c3                   	ret    

000019d4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19d4:	55                   	push   %ebp
    19d5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19d7:	a1 f4 1e 00 00       	mov    0x1ef4,%eax
    19dc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19e2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19e7:	a3 f4 1e 00 00       	mov    %eax,0x1ef4
    return (int)(rands % max);
    19ec:	a1 f4 1e 00 00       	mov    0x1ef4,%eax
    19f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19f4:	ba 00 00 00 00       	mov    $0x0,%edx
    19f9:	f7 f1                	div    %ecx
    19fb:	89 d0                	mov    %edx,%eax
}
    19fd:	5d                   	pop    %ebp
    19fe:	c3                   	ret    
    19ff:	90                   	nop

00001a00 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a00:	55                   	push   %ebp
    1a01:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a03:	8b 45 08             	mov    0x8(%ebp),%eax
    1a06:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a16:	8b 45 08             	mov    0x8(%ebp),%eax
    1a19:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a20:	5d                   	pop    %ebp
    1a21:	c3                   	ret    

00001a22 <add_q>:

void add_q(struct queue *q, int v){
    1a22:	55                   	push   %ebp
    1a23:	89 e5                	mov    %esp,%ebp
    1a25:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a28:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a2f:	e8 8d fd ff ff       	call   17c1 <malloc>
    1a34:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a44:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a47:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a49:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4c:	8b 40 04             	mov    0x4(%eax),%eax
    1a4f:	85 c0                	test   %eax,%eax
    1a51:	75 0b                	jne    1a5e <add_q+0x3c>
        q->head = n;
    1a53:	8b 45 08             	mov    0x8(%ebp),%eax
    1a56:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a59:	89 50 04             	mov    %edx,0x4(%eax)
    1a5c:	eb 0c                	jmp    1a6a <add_q+0x48>
    }else{
        q->tail->next = n;
    1a5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a61:	8b 40 08             	mov    0x8(%eax),%eax
    1a64:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a67:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a70:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a73:	8b 45 08             	mov    0x8(%ebp),%eax
    1a76:	8b 00                	mov    (%eax),%eax
    1a78:	8d 50 01             	lea    0x1(%eax),%edx
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	89 10                	mov    %edx,(%eax)
}
    1a80:	c9                   	leave  
    1a81:	c3                   	ret    

00001a82 <empty_q>:

int empty_q(struct queue *q){
    1a82:	55                   	push   %ebp
    1a83:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	8b 00                	mov    (%eax),%eax
    1a8a:	85 c0                	test   %eax,%eax
    1a8c:	75 07                	jne    1a95 <empty_q+0x13>
        return 1;
    1a8e:	b8 01 00 00 00       	mov    $0x1,%eax
    1a93:	eb 05                	jmp    1a9a <empty_q+0x18>
    else
        return 0;
    1a95:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a9a:	5d                   	pop    %ebp
    1a9b:	c3                   	ret    

00001a9c <pop_q>:
int pop_q(struct queue *q){
    1a9c:	55                   	push   %ebp
    1a9d:	89 e5                	mov    %esp,%ebp
    1a9f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1aa2:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa5:	89 04 24             	mov    %eax,(%esp)
    1aa8:	e8 d5 ff ff ff       	call   1a82 <empty_q>
    1aad:	85 c0                	test   %eax,%eax
    1aaf:	75 5d                	jne    1b0e <pop_q+0x72>
       val = q->head->value; 
    1ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab4:	8b 40 04             	mov    0x4(%eax),%eax
    1ab7:	8b 00                	mov    (%eax),%eax
    1ab9:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1abc:	8b 45 08             	mov    0x8(%ebp),%eax
    1abf:	8b 40 04             	mov    0x4(%eax),%eax
    1ac2:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1ac5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac8:	8b 40 04             	mov    0x4(%eax),%eax
    1acb:	8b 50 04             	mov    0x4(%eax),%edx
    1ace:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad7:	89 04 24             	mov    %eax,(%esp)
    1ada:	e8 a9 fb ff ff       	call   1688 <free>
       q->size--;
    1adf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae2:	8b 00                	mov    (%eax),%eax
    1ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ae7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aea:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1aec:	8b 45 08             	mov    0x8(%ebp),%eax
    1aef:	8b 00                	mov    (%eax),%eax
    1af1:	85 c0                	test   %eax,%eax
    1af3:	75 14                	jne    1b09 <pop_q+0x6d>
            q->head = 0;
    1af5:	8b 45 08             	mov    0x8(%ebp),%eax
    1af8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1aff:	8b 45 08             	mov    0x8(%ebp),%eax
    1b02:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b0c:	eb 05                	jmp    1b13 <pop_q+0x77>
    }
    return -1;
    1b0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b13:	c9                   	leave  
    1b14:	c3                   	ret    
