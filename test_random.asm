
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
    1010:	e8 ab 09 00 00       	call   19c0 <random>
    1015:	89 44 24 08          	mov    %eax,0x8(%esp)
    1019:	c7 44 24 04 01 1b 00 	movl   $0x1b01,0x4(%esp)
    1020:	00 
    1021:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1028:	e8 9c 04 00 00       	call   14c9 <printf>
    printf(1,"random number %d\n",random(100));
    102d:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1034:	e8 87 09 00 00       	call   19c0 <random>
    1039:	89 44 24 08          	mov    %eax,0x8(%esp)
    103d:	c7 44 24 04 01 1b 00 	movl   $0x1b01,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104c:	e8 78 04 00 00       	call   14c9 <printf>
    printf(1,"random number %d\n",random(100));
    1051:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1058:	e8 63 09 00 00       	call   19c0 <random>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 01 1b 00 	movl   $0x1b01,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 54 04 00 00       	call   14c9 <printf>
    printf(1,"random number %d\n",random(100));
    1075:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    107c:	e8 3f 09 00 00       	call   19c0 <random>
    1081:	89 44 24 08          	mov    %eax,0x8(%esp)
    1085:	c7 44 24 04 01 1b 00 	movl   $0x1b01,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 30 04 00 00       	call   14c9 <printf>
    printf(1,"random number %d\n",random(100));
    1099:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    10a0:	e8 1b 09 00 00       	call   19c0 <random>
    10a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    10a9:	c7 44 24 04 01 1b 00 	movl   $0x1b01,0x4(%esp)
    10b0:	00 
    10b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b8:	e8 0c 04 00 00       	call   14c9 <printf>

    exit();
    10bd:	e8 66 02 00 00       	call   1328 <exit>
    10c2:	90                   	nop
    10c3:	90                   	nop

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
    10f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f8:	0f b6 10             	movzbl (%eax),%edx
    10fb:	8b 45 08             	mov    0x8(%ebp),%eax
    10fe:	88 10                	mov    %dl,(%eax)
    1100:	8b 45 08             	mov    0x8(%ebp),%eax
    1103:	0f b6 00             	movzbl (%eax),%eax
    1106:	84 c0                	test   %al,%al
    1108:	0f 95 c0             	setne  %al
    110b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    110f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1113:	84 c0                	test   %al,%al
    1115:	75 de                	jne    10f5 <strcpy+0xc>
    ;
  return os;
    1117:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    111a:	c9                   	leave  
    111b:	c3                   	ret    

0000111c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    111c:	55                   	push   %ebp
    111d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    111f:	eb 08                	jmp    1129 <strcmp+0xd>
    p++, q++;
    1121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1125:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1129:	8b 45 08             	mov    0x8(%ebp),%eax
    112c:	0f b6 00             	movzbl (%eax),%eax
    112f:	84 c0                	test   %al,%al
    1131:	74 10                	je     1143 <strcmp+0x27>
    1133:	8b 45 08             	mov    0x8(%ebp),%eax
    1136:	0f b6 10             	movzbl (%eax),%edx
    1139:	8b 45 0c             	mov    0xc(%ebp),%eax
    113c:	0f b6 00             	movzbl (%eax),%eax
    113f:	38 c2                	cmp    %al,%dl
    1141:	74 de                	je     1121 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	0f b6 00             	movzbl (%eax),%eax
    1149:	0f b6 d0             	movzbl %al,%edx
    114c:	8b 45 0c             	mov    0xc(%ebp),%eax
    114f:	0f b6 00             	movzbl (%eax),%eax
    1152:	0f b6 c0             	movzbl %al,%eax
    1155:	89 d1                	mov    %edx,%ecx
    1157:	29 c1                	sub    %eax,%ecx
    1159:	89 c8                	mov    %ecx,%eax
}
    115b:	5d                   	pop    %ebp
    115c:	c3                   	ret    

0000115d <strlen>:

uint
strlen(char *s)
{
    115d:	55                   	push   %ebp
    115e:	89 e5                	mov    %esp,%ebp
    1160:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1163:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    116a:	eb 04                	jmp    1170 <strlen+0x13>
    116c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1170:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1173:	03 45 08             	add    0x8(%ebp),%eax
    1176:	0f b6 00             	movzbl (%eax),%eax
    1179:	84 c0                	test   %al,%al
    117b:	75 ef                	jne    116c <strlen+0xf>
    ;
  return n;
    117d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1180:	c9                   	leave  
    1181:	c3                   	ret    

00001182 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1182:	55                   	push   %ebp
    1183:	89 e5                	mov    %esp,%ebp
    1185:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1188:	8b 45 10             	mov    0x10(%ebp),%eax
    118b:	89 44 24 08          	mov    %eax,0x8(%esp)
    118f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1192:	89 44 24 04          	mov    %eax,0x4(%esp)
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	89 04 24             	mov    %eax,(%esp)
    119c:	e8 23 ff ff ff       	call   10c4 <stosb>
  return dst;
    11a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11a4:	c9                   	leave  
    11a5:	c3                   	ret    

000011a6 <strchr>:

char*
strchr(const char *s, char c)
{
    11a6:	55                   	push   %ebp
    11a7:	89 e5                	mov    %esp,%ebp
    11a9:	83 ec 04             	sub    $0x4,%esp
    11ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    11af:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11b2:	eb 14                	jmp    11c8 <strchr+0x22>
    if(*s == c)
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	0f b6 00             	movzbl (%eax),%eax
    11ba:	3a 45 fc             	cmp    -0x4(%ebp),%al
    11bd:	75 05                	jne    11c4 <strchr+0x1e>
      return (char*)s;
    11bf:	8b 45 08             	mov    0x8(%ebp),%eax
    11c2:	eb 13                	jmp    11d7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	0f b6 00             	movzbl (%eax),%eax
    11ce:	84 c0                	test   %al,%al
    11d0:	75 e2                	jne    11b4 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    11d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11d7:	c9                   	leave  
    11d8:	c3                   	ret    

000011d9 <gets>:

char*
gets(char *buf, int max)
{
    11d9:	55                   	push   %ebp
    11da:	89 e5                	mov    %esp,%ebp
    11dc:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11e6:	eb 44                	jmp    122c <gets+0x53>
    cc = read(0, &c, 1);
    11e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11ef:	00 
    11f0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    11f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11fe:	e8 3d 01 00 00       	call   1340 <read>
    1203:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1206:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    120a:	7e 2d                	jle    1239 <gets+0x60>
      break;
    buf[i++] = c;
    120c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    120f:	03 45 08             	add    0x8(%ebp),%eax
    1212:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1216:	88 10                	mov    %dl,(%eax)
    1218:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    121c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1220:	3c 0a                	cmp    $0xa,%al
    1222:	74 16                	je     123a <gets+0x61>
    1224:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1228:	3c 0d                	cmp    $0xd,%al
    122a:	74 0e                	je     123a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    122c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    122f:	83 c0 01             	add    $0x1,%eax
    1232:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1235:	7c b1                	jl     11e8 <gets+0xf>
    1237:	eb 01                	jmp    123a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1239:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    123a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    123d:	03 45 08             	add    0x8(%ebp),%eax
    1240:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1246:	c9                   	leave  
    1247:	c3                   	ret    

00001248 <stat>:

int
stat(char *n, struct stat *st)
{
    1248:	55                   	push   %ebp
    1249:	89 e5                	mov    %esp,%ebp
    124b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    124e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1255:	00 
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	89 04 24             	mov    %eax,(%esp)
    125c:	e8 07 01 00 00       	call   1368 <open>
    1261:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1264:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1268:	79 07                	jns    1271 <stat+0x29>
    return -1;
    126a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    126f:	eb 23                	jmp    1294 <stat+0x4c>
  r = fstat(fd, st);
    1271:	8b 45 0c             	mov    0xc(%ebp),%eax
    1274:	89 44 24 04          	mov    %eax,0x4(%esp)
    1278:	8b 45 f0             	mov    -0x10(%ebp),%eax
    127b:	89 04 24             	mov    %eax,(%esp)
    127e:	e8 fd 00 00 00       	call   1380 <fstat>
    1283:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1286:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1289:	89 04 24             	mov    %eax,(%esp)
    128c:	e8 bf 00 00 00       	call   1350 <close>
  return r;
    1291:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1294:	c9                   	leave  
    1295:	c3                   	ret    

00001296 <atoi>:

int
atoi(const char *s)
{
    1296:	55                   	push   %ebp
    1297:	89 e5                	mov    %esp,%ebp
    1299:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    129c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12a3:	eb 24                	jmp    12c9 <atoi+0x33>
    n = n*10 + *s++ - '0';
    12a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12a8:	89 d0                	mov    %edx,%eax
    12aa:	c1 e0 02             	shl    $0x2,%eax
    12ad:	01 d0                	add    %edx,%eax
    12af:	01 c0                	add    %eax,%eax
    12b1:	89 c2                	mov    %eax,%edx
    12b3:	8b 45 08             	mov    0x8(%ebp),%eax
    12b6:	0f b6 00             	movzbl (%eax),%eax
    12b9:	0f be c0             	movsbl %al,%eax
    12bc:	8d 04 02             	lea    (%edx,%eax,1),%eax
    12bf:	83 e8 30             	sub    $0x30,%eax
    12c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12c9:	8b 45 08             	mov    0x8(%ebp),%eax
    12cc:	0f b6 00             	movzbl (%eax),%eax
    12cf:	3c 2f                	cmp    $0x2f,%al
    12d1:	7e 0a                	jle    12dd <atoi+0x47>
    12d3:	8b 45 08             	mov    0x8(%ebp),%eax
    12d6:	0f b6 00             	movzbl (%eax),%eax
    12d9:	3c 39                	cmp    $0x39,%al
    12db:	7e c8                	jle    12a5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12e0:	c9                   	leave  
    12e1:	c3                   	ret    

000012e2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12e2:	55                   	push   %ebp
    12e3:	89 e5                	mov    %esp,%ebp
    12e5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12e8:	8b 45 08             	mov    0x8(%ebp),%eax
    12eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    12ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    12f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    12f4:	eb 13                	jmp    1309 <memmove+0x27>
    *dst++ = *src++;
    12f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12f9:	0f b6 10             	movzbl (%eax),%edx
    12fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12ff:	88 10                	mov    %dl,(%eax)
    1301:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1305:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1309:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    130d:	0f 9f c0             	setg   %al
    1310:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1314:	84 c0                	test   %al,%al
    1316:	75 de                	jne    12f6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
}
    131b:	c9                   	leave  
    131c:	c3                   	ret    
    131d:	90                   	nop
    131e:	90                   	nop
    131f:	90                   	nop

00001320 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1320:	b8 01 00 00 00       	mov    $0x1,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <exit>:
SYSCALL(exit)
    1328:	b8 02 00 00 00       	mov    $0x2,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <wait>:
SYSCALL(wait)
    1330:	b8 03 00 00 00       	mov    $0x3,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <pipe>:
SYSCALL(pipe)
    1338:	b8 04 00 00 00       	mov    $0x4,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <read>:
SYSCALL(read)
    1340:	b8 05 00 00 00       	mov    $0x5,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <write>:
SYSCALL(write)
    1348:	b8 10 00 00 00       	mov    $0x10,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <close>:
SYSCALL(close)
    1350:	b8 15 00 00 00       	mov    $0x15,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <kill>:
SYSCALL(kill)
    1358:	b8 06 00 00 00       	mov    $0x6,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <exec>:
SYSCALL(exec)
    1360:	b8 07 00 00 00       	mov    $0x7,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <open>:
SYSCALL(open)
    1368:	b8 0f 00 00 00       	mov    $0xf,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <mknod>:
SYSCALL(mknod)
    1370:	b8 11 00 00 00       	mov    $0x11,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <unlink>:
SYSCALL(unlink)
    1378:	b8 12 00 00 00       	mov    $0x12,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <fstat>:
SYSCALL(fstat)
    1380:	b8 08 00 00 00       	mov    $0x8,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <link>:
SYSCALL(link)
    1388:	b8 13 00 00 00       	mov    $0x13,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <mkdir>:
SYSCALL(mkdir)
    1390:	b8 14 00 00 00       	mov    $0x14,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <chdir>:
SYSCALL(chdir)
    1398:	b8 09 00 00 00       	mov    $0x9,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <dup>:
SYSCALL(dup)
    13a0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <getpid>:
SYSCALL(getpid)
    13a8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <sbrk>:
SYSCALL(sbrk)
    13b0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <sleep>:
SYSCALL(sleep)
    13b8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <uptime>:
SYSCALL(uptime)
    13c0:	b8 0e 00 00 00       	mov    $0xe,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <clone>:
SYSCALL(clone)
    13c8:	b8 16 00 00 00       	mov    $0x16,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <texit>:
SYSCALL(texit)
    13d0:	b8 17 00 00 00       	mov    $0x17,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <tsleep>:
SYSCALL(tsleep)
    13d8:	b8 18 00 00 00       	mov    $0x18,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <twakeup>:
SYSCALL(twakeup)
    13e0:	b8 19 00 00 00       	mov    $0x19,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <thread_yield>:
SYSCALL(thread_yield)
    13e8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 28             	sub    $0x28,%esp
    13f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1403:	00 
    1404:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1407:	89 44 24 04          	mov    %eax,0x4(%esp)
    140b:	8b 45 08             	mov    0x8(%ebp),%eax
    140e:	89 04 24             	mov    %eax,(%esp)
    1411:	e8 32 ff ff ff       	call   1348 <write>
}
    1416:	c9                   	leave  
    1417:	c3                   	ret    

00001418 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1418:	55                   	push   %ebp
    1419:	89 e5                	mov    %esp,%ebp
    141b:	53                   	push   %ebx
    141c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    141f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1426:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    142a:	74 17                	je     1443 <printint+0x2b>
    142c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1430:	79 11                	jns    1443 <printint+0x2b>
    neg = 1;
    1432:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1439:	8b 45 0c             	mov    0xc(%ebp),%eax
    143c:	f7 d8                	neg    %eax
    143e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1441:	eb 06                	jmp    1449 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1443:	8b 45 0c             	mov    0xc(%ebp),%eax
    1446:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1449:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1450:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1453:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1456:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1459:	ba 00 00 00 00       	mov    $0x0,%edx
    145e:	f7 f3                	div    %ebx
    1460:	89 d0                	mov    %edx,%eax
    1462:	0f b6 80 48 1b 00 00 	movzbl 0x1b48(%eax),%eax
    1469:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    146d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1471:	8b 45 10             	mov    0x10(%ebp),%eax
    1474:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1477:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147a:	ba 00 00 00 00       	mov    $0x0,%edx
    147f:	f7 75 d4             	divl   -0x2c(%ebp)
    1482:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1485:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1489:	75 c5                	jne    1450 <printint+0x38>
  if(neg)
    148b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    148f:	74 28                	je     14b9 <printint+0xa1>
    buf[i++] = '-';
    1491:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1494:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1499:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    149d:	eb 1a                	jmp    14b9 <printint+0xa1>
    putc(fd, buf[i]);
    149f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14a2:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    14a7:	0f be c0             	movsbl %al,%eax
    14aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ae:	8b 45 08             	mov    0x8(%ebp),%eax
    14b1:	89 04 24             	mov    %eax,(%esp)
    14b4:	e8 37 ff ff ff       	call   13f0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14b9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    14bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14c1:	79 dc                	jns    149f <printint+0x87>
    putc(fd, buf[i]);
}
    14c3:	83 c4 44             	add    $0x44,%esp
    14c6:	5b                   	pop    %ebx
    14c7:	5d                   	pop    %ebp
    14c8:	c3                   	ret    

000014c9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14c9:	55                   	push   %ebp
    14ca:	89 e5                	mov    %esp,%ebp
    14cc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14d6:	8d 45 0c             	lea    0xc(%ebp),%eax
    14d9:	83 c0 04             	add    $0x4,%eax
    14dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    14df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14e6:	e9 7e 01 00 00       	jmp    1669 <printf+0x1a0>
    c = fmt[i] & 0xff;
    14eb:	8b 55 0c             	mov    0xc(%ebp),%edx
    14ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14f1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14f4:	0f b6 00             	movzbl (%eax),%eax
    14f7:	0f be c0             	movsbl %al,%eax
    14fa:	25 ff 00 00 00       	and    $0xff,%eax
    14ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1502:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1506:	75 2c                	jne    1534 <printf+0x6b>
      if(c == '%'){
    1508:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    150c:	75 0c                	jne    151a <printf+0x51>
        state = '%';
    150e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1515:	e9 4b 01 00 00       	jmp    1665 <printf+0x19c>
      } else {
        putc(fd, c);
    151a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151d:	0f be c0             	movsbl %al,%eax
    1520:	89 44 24 04          	mov    %eax,0x4(%esp)
    1524:	8b 45 08             	mov    0x8(%ebp),%eax
    1527:	89 04 24             	mov    %eax,(%esp)
    152a:	e8 c1 fe ff ff       	call   13f0 <putc>
    152f:	e9 31 01 00 00       	jmp    1665 <printf+0x19c>
      }
    } else if(state == '%'){
    1534:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1538:	0f 85 27 01 00 00    	jne    1665 <printf+0x19c>
      if(c == 'd'){
    153e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1542:	75 2d                	jne    1571 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1544:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1547:	8b 00                	mov    (%eax),%eax
    1549:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1550:	00 
    1551:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1558:	00 
    1559:	89 44 24 04          	mov    %eax,0x4(%esp)
    155d:	8b 45 08             	mov    0x8(%ebp),%eax
    1560:	89 04 24             	mov    %eax,(%esp)
    1563:	e8 b0 fe ff ff       	call   1418 <printint>
        ap++;
    1568:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    156c:	e9 ed 00 00 00       	jmp    165e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1571:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1575:	74 06                	je     157d <printf+0xb4>
    1577:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    157b:	75 2d                	jne    15aa <printf+0xe1>
        printint(fd, *ap, 16, 0);
    157d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1580:	8b 00                	mov    (%eax),%eax
    1582:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1589:	00 
    158a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1591:	00 
    1592:	89 44 24 04          	mov    %eax,0x4(%esp)
    1596:	8b 45 08             	mov    0x8(%ebp),%eax
    1599:	89 04 24             	mov    %eax,(%esp)
    159c:	e8 77 fe ff ff       	call   1418 <printint>
        ap++;
    15a1:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15a5:	e9 b4 00 00 00       	jmp    165e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15aa:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    15ae:	75 46                	jne    15f6 <printf+0x12d>
        s = (char*)*ap;
    15b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b3:	8b 00                	mov    (%eax),%eax
    15b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    15b8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    15bc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    15c0:	75 27                	jne    15e9 <printf+0x120>
          s = "(null)";
    15c2:	c7 45 e4 13 1b 00 00 	movl   $0x1b13,-0x1c(%ebp)
        while(*s != 0){
    15c9:	eb 1f                	jmp    15ea <printf+0x121>
          putc(fd, *s);
    15cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ce:	0f b6 00             	movzbl (%eax),%eax
    15d1:	0f be c0             	movsbl %al,%eax
    15d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	89 04 24             	mov    %eax,(%esp)
    15de:	e8 0d fe ff ff       	call   13f0 <putc>
          s++;
    15e3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    15e7:	eb 01                	jmp    15ea <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15e9:	90                   	nop
    15ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ed:	0f b6 00             	movzbl (%eax),%eax
    15f0:	84 c0                	test   %al,%al
    15f2:	75 d7                	jne    15cb <printf+0x102>
    15f4:	eb 68                	jmp    165e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15f6:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15fa:	75 1d                	jne    1619 <printf+0x150>
        putc(fd, *ap);
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	8b 00                	mov    (%eax),%eax
    1601:	0f be c0             	movsbl %al,%eax
    1604:	89 44 24 04          	mov    %eax,0x4(%esp)
    1608:	8b 45 08             	mov    0x8(%ebp),%eax
    160b:	89 04 24             	mov    %eax,(%esp)
    160e:	e8 dd fd ff ff       	call   13f0 <putc>
        ap++;
    1613:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1617:	eb 45                	jmp    165e <printf+0x195>
      } else if(c == '%'){
    1619:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    161d:	75 17                	jne    1636 <printf+0x16d>
        putc(fd, c);
    161f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1622:	0f be c0             	movsbl %al,%eax
    1625:	89 44 24 04          	mov    %eax,0x4(%esp)
    1629:	8b 45 08             	mov    0x8(%ebp),%eax
    162c:	89 04 24             	mov    %eax,(%esp)
    162f:	e8 bc fd ff ff       	call   13f0 <putc>
    1634:	eb 28                	jmp    165e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1636:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    163d:	00 
    163e:	8b 45 08             	mov    0x8(%ebp),%eax
    1641:	89 04 24             	mov    %eax,(%esp)
    1644:	e8 a7 fd ff ff       	call   13f0 <putc>
        putc(fd, c);
    1649:	8b 45 e8             	mov    -0x18(%ebp),%eax
    164c:	0f be c0             	movsbl %al,%eax
    164f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1653:	8b 45 08             	mov    0x8(%ebp),%eax
    1656:	89 04 24             	mov    %eax,(%esp)
    1659:	e8 92 fd ff ff       	call   13f0 <putc>
      }
      state = 0;
    165e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1665:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1669:	8b 55 0c             	mov    0xc(%ebp),%edx
    166c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    166f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1672:	0f b6 00             	movzbl (%eax),%eax
    1675:	84 c0                	test   %al,%al
    1677:	0f 85 6e fe ff ff    	jne    14eb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    167d:	c9                   	leave  
    167e:	c3                   	ret    
    167f:	90                   	nop

00001680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	83 e8 08             	sub    $0x8,%eax
    168c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    168f:	a1 68 1b 00 00       	mov    0x1b68,%eax
    1694:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1697:	eb 24                	jmp    16bd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1699:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169c:	8b 00                	mov    (%eax),%eax
    169e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16a1:	77 12                	ja     16b5 <free+0x35>
    16a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16a9:	77 24                	ja     16cf <free+0x4f>
    16ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ae:	8b 00                	mov    (%eax),%eax
    16b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16b3:	77 1a                	ja     16cf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16c3:	76 d4                	jbe    1699 <free+0x19>
    16c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c8:	8b 00                	mov    (%eax),%eax
    16ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16cd:	76 ca                	jbe    1699 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	8b 40 04             	mov    0x4(%eax),%eax
    16d5:	c1 e0 03             	shl    $0x3,%eax
    16d8:	89 c2                	mov    %eax,%edx
    16da:	03 55 f8             	add    -0x8(%ebp),%edx
    16dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e0:	8b 00                	mov    (%eax),%eax
    16e2:	39 c2                	cmp    %eax,%edx
    16e4:	75 24                	jne    170a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    16e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e9:	8b 50 04             	mov    0x4(%eax),%edx
    16ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ef:	8b 00                	mov    (%eax),%eax
    16f1:	8b 40 04             	mov    0x4(%eax),%eax
    16f4:	01 c2                	add    %eax,%edx
    16f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ff:	8b 00                	mov    (%eax),%eax
    1701:	8b 10                	mov    (%eax),%edx
    1703:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1706:	89 10                	mov    %edx,(%eax)
    1708:	eb 0a                	jmp    1714 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    170a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170d:	8b 10                	mov    (%eax),%edx
    170f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1712:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1714:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1717:	8b 40 04             	mov    0x4(%eax),%eax
    171a:	c1 e0 03             	shl    $0x3,%eax
    171d:	03 45 fc             	add    -0x4(%ebp),%eax
    1720:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1723:	75 20                	jne    1745 <free+0xc5>
    p->s.size += bp->s.size;
    1725:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1728:	8b 50 04             	mov    0x4(%eax),%edx
    172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    172e:	8b 40 04             	mov    0x4(%eax),%eax
    1731:	01 c2                	add    %eax,%edx
    1733:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1736:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1739:	8b 45 f8             	mov    -0x8(%ebp),%eax
    173c:	8b 10                	mov    (%eax),%edx
    173e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1741:	89 10                	mov    %edx,(%eax)
    1743:	eb 08                	jmp    174d <free+0xcd>
  } else
    p->s.ptr = bp;
    1745:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1748:	8b 55 f8             	mov    -0x8(%ebp),%edx
    174b:	89 10                	mov    %edx,(%eax)
  freep = p;
    174d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1750:	a3 68 1b 00 00       	mov    %eax,0x1b68
}
    1755:	c9                   	leave  
    1756:	c3                   	ret    

00001757 <morecore>:

static Header*
morecore(uint nu)
{
    1757:	55                   	push   %ebp
    1758:	89 e5                	mov    %esp,%ebp
    175a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    175d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1764:	77 07                	ja     176d <morecore+0x16>
    nu = 4096;
    1766:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    176d:	8b 45 08             	mov    0x8(%ebp),%eax
    1770:	c1 e0 03             	shl    $0x3,%eax
    1773:	89 04 24             	mov    %eax,(%esp)
    1776:	e8 35 fc ff ff       	call   13b0 <sbrk>
    177b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    177e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1782:	75 07                	jne    178b <morecore+0x34>
    return 0;
    1784:	b8 00 00 00 00       	mov    $0x0,%eax
    1789:	eb 22                	jmp    17ad <morecore+0x56>
  hp = (Header*)p;
    178b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	8b 55 08             	mov    0x8(%ebp),%edx
    1797:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    179a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179d:	83 c0 08             	add    $0x8,%eax
    17a0:	89 04 24             	mov    %eax,(%esp)
    17a3:	e8 d8 fe ff ff       	call   1680 <free>
  return freep;
    17a8:	a1 68 1b 00 00       	mov    0x1b68,%eax
}
    17ad:	c9                   	leave  
    17ae:	c3                   	ret    

000017af <malloc>:

void*
malloc(uint nbytes)
{
    17af:	55                   	push   %ebp
    17b0:	89 e5                	mov    %esp,%ebp
    17b2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	83 c0 07             	add    $0x7,%eax
    17bb:	c1 e8 03             	shr    $0x3,%eax
    17be:	83 c0 01             	add    $0x1,%eax
    17c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    17c4:	a1 68 1b 00 00       	mov    0x1b68,%eax
    17c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17d0:	75 23                	jne    17f5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17d2:	c7 45 f0 60 1b 00 00 	movl   $0x1b60,-0x10(%ebp)
    17d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17dc:	a3 68 1b 00 00       	mov    %eax,0x1b68
    17e1:	a1 68 1b 00 00       	mov    0x1b68,%eax
    17e6:	a3 60 1b 00 00       	mov    %eax,0x1b60
    base.s.size = 0;
    17eb:	c7 05 64 1b 00 00 00 	movl   $0x0,0x1b64
    17f2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f8:	8b 00                	mov    (%eax),%eax
    17fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    17fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1800:	8b 40 04             	mov    0x4(%eax),%eax
    1803:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1806:	72 4d                	jb     1855 <malloc+0xa6>
      if(p->s.size == nunits)
    1808:	8b 45 ec             	mov    -0x14(%ebp),%eax
    180b:	8b 40 04             	mov    0x4(%eax),%eax
    180e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1811:	75 0c                	jne    181f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1813:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1816:	8b 10                	mov    (%eax),%edx
    1818:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181b:	89 10                	mov    %edx,(%eax)
    181d:	eb 26                	jmp    1845 <malloc+0x96>
      else {
        p->s.size -= nunits;
    181f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1822:	8b 40 04             	mov    0x4(%eax),%eax
    1825:	89 c2                	mov    %eax,%edx
    1827:	2b 55 f4             	sub    -0xc(%ebp),%edx
    182a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    182d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1830:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1833:	8b 40 04             	mov    0x4(%eax),%eax
    1836:	c1 e0 03             	shl    $0x3,%eax
    1839:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    183c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1842:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1845:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1848:	a3 68 1b 00 00       	mov    %eax,0x1b68
      return (void*)(p + 1);
    184d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1850:	83 c0 08             	add    $0x8,%eax
    1853:	eb 38                	jmp    188d <malloc+0xde>
    }
    if(p == freep)
    1855:	a1 68 1b 00 00       	mov    0x1b68,%eax
    185a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    185d:	75 1b                	jne    187a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1862:	89 04 24             	mov    %eax,(%esp)
    1865:	e8 ed fe ff ff       	call   1757 <morecore>
    186a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    186d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1871:	75 07                	jne    187a <malloc+0xcb>
        return 0;
    1873:	b8 00 00 00 00       	mov    $0x0,%eax
    1878:	eb 13                	jmp    188d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    187a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    187d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1880:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1883:	8b 00                	mov    (%eax),%eax
    1885:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1888:	e9 70 ff ff ff       	jmp    17fd <malloc+0x4e>
}
    188d:	c9                   	leave  
    188e:	c3                   	ret    
    188f:	90                   	nop

00001890 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1896:	8b 55 08             	mov    0x8(%ebp),%edx
    1899:	8b 45 0c             	mov    0xc(%ebp),%eax
    189c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    189f:	f0 87 02             	lock xchg %eax,(%edx)
    18a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18a8:	c9                   	leave  
    18a9:	c3                   	ret    

000018aa <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18aa:	55                   	push   %ebp
    18ab:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18ad:	8b 45 08             	mov    0x8(%ebp),%eax
    18b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18b6:	5d                   	pop    %ebp
    18b7:	c3                   	ret    

000018b8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    18b8:	55                   	push   %ebp
    18b9:	89 e5                	mov    %esp,%ebp
    18bb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18c8:	00 
    18c9:	89 04 24             	mov    %eax,(%esp)
    18cc:	e8 bf ff ff ff       	call   1890 <xchg>
    18d1:	85 c0                	test   %eax,%eax
    18d3:	75 e9                	jne    18be <lock_acquire+0x6>
}
    18d5:	c9                   	leave  
    18d6:	c3                   	ret    

000018d7 <lock_release>:
void lock_release(lock_t *lock){
    18d7:	55                   	push   %ebp
    18d8:	89 e5                	mov    %esp,%ebp
    18da:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18dd:	8b 45 08             	mov    0x8(%ebp),%eax
    18e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18e7:	00 
    18e8:	89 04 24             	mov    %eax,(%esp)
    18eb:	e8 a0 ff ff ff       	call   1890 <xchg>
}
    18f0:	c9                   	leave  
    18f1:	c3                   	ret    

000018f2 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18f2:	55                   	push   %ebp
    18f3:	89 e5                	mov    %esp,%ebp
    18f5:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18f8:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18ff:	e8 ab fe ff ff       	call   17af <malloc>
    1904:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1907:	8b 45 f0             	mov    -0x10(%ebp),%eax
    190a:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    190d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1910:	25 ff 0f 00 00       	and    $0xfff,%eax
    1915:	85 c0                	test   %eax,%eax
    1917:	74 15                	je     192e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1919:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191c:	89 c2                	mov    %eax,%edx
    191e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1924:	b8 00 10 00 00       	mov    $0x1000,%eax
    1929:	29 d0                	sub    %edx,%eax
    192b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    192e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1932:	75 1b                	jne    194f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1934:	c7 44 24 04 1a 1b 00 	movl   $0x1b1a,0x4(%esp)
    193b:	00 
    193c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1943:	e8 81 fb ff ff       	call   14c9 <printf>
        return 0;
    1948:	b8 00 00 00 00       	mov    $0x0,%eax
    194d:	eb 6f                	jmp    19be <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    194f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1952:	8b 55 08             	mov    0x8(%ebp),%edx
    1955:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1958:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    195c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1960:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1967:	00 
    1968:	89 04 24             	mov    %eax,(%esp)
    196b:	e8 58 fa ff ff       	call   13c8 <clone>
    1970:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1973:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1977:	79 1b                	jns    1994 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1979:	c7 44 24 04 28 1b 00 	movl   $0x1b28,0x4(%esp)
    1980:	00 
    1981:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1988:	e8 3c fb ff ff       	call   14c9 <printf>
        return 0;
    198d:	b8 00 00 00 00       	mov    $0x0,%eax
    1992:	eb 2a                	jmp    19be <thread_create+0xcc>
    }
    if(tid > 0){
    1994:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1998:	7e 05                	jle    199f <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    199a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    199d:	eb 1f                	jmp    19be <thread_create+0xcc>
    }
    if(tid == 0){
    199f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19a3:	75 14                	jne    19b9 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    19a5:	c7 44 24 04 35 1b 00 	movl   $0x1b35,0x4(%esp)
    19ac:	00 
    19ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19b4:	e8 10 fb ff ff       	call   14c9 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19be:	c9                   	leave  
    19bf:	c3                   	ret    

000019c0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19c3:	a1 5c 1b 00 00       	mov    0x1b5c,%eax
    19c8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19ce:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19d3:	a3 5c 1b 00 00       	mov    %eax,0x1b5c
    return (int)(rands % max);
    19d8:	a1 5c 1b 00 00       	mov    0x1b5c,%eax
    19dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19e0:	ba 00 00 00 00       	mov    $0x0,%edx
    19e5:	f7 f1                	div    %ecx
    19e7:	89 d0                	mov    %edx,%eax
}
    19e9:	5d                   	pop    %ebp
    19ea:	c3                   	ret    
    19eb:	90                   	nop

000019ec <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19ec:	55                   	push   %ebp
    19ed:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19ef:	8b 45 08             	mov    0x8(%ebp),%eax
    19f2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19f8:	8b 45 08             	mov    0x8(%ebp),%eax
    19fb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a0c:	5d                   	pop    %ebp
    1a0d:	c3                   	ret    

00001a0e <add_q>:

void add_q(struct queue *q, int v){
    1a0e:	55                   	push   %ebp
    1a0f:	89 e5                	mov    %esp,%ebp
    1a11:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a14:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a1b:	e8 8f fd ff ff       	call   17af <malloc>
    1a20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a26:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a30:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a33:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	8b 40 04             	mov    0x4(%eax),%eax
    1a3b:	85 c0                	test   %eax,%eax
    1a3d:	75 0b                	jne    1a4a <add_q+0x3c>
        q->head = n;
    1a3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a42:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a45:	89 50 04             	mov    %edx,0x4(%eax)
    1a48:	eb 0c                	jmp    1a56 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4d:	8b 40 08             	mov    0x8(%eax),%eax
    1a50:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a53:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a56:	8b 45 08             	mov    0x8(%ebp),%eax
    1a59:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a5c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a62:	8b 00                	mov    (%eax),%eax
    1a64:	8d 50 01             	lea    0x1(%eax),%edx
    1a67:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6a:	89 10                	mov    %edx,(%eax)
}
    1a6c:	c9                   	leave  
    1a6d:	c3                   	ret    

00001a6e <empty_q>:

int empty_q(struct queue *q){
    1a6e:	55                   	push   %ebp
    1a6f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a71:	8b 45 08             	mov    0x8(%ebp),%eax
    1a74:	8b 00                	mov    (%eax),%eax
    1a76:	85 c0                	test   %eax,%eax
    1a78:	75 07                	jne    1a81 <empty_q+0x13>
        return 1;
    1a7a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a7f:	eb 05                	jmp    1a86 <empty_q+0x18>
    else
        return 0;
    1a81:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a86:	5d                   	pop    %ebp
    1a87:	c3                   	ret    

00001a88 <pop_q>:
int pop_q(struct queue *q){
    1a88:	55                   	push   %ebp
    1a89:	89 e5                	mov    %esp,%ebp
    1a8b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a91:	89 04 24             	mov    %eax,(%esp)
    1a94:	e8 d5 ff ff ff       	call   1a6e <empty_q>
    1a99:	85 c0                	test   %eax,%eax
    1a9b:	75 5d                	jne    1afa <pop_q+0x72>
       val = q->head->value; 
    1a9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa0:	8b 40 04             	mov    0x4(%eax),%eax
    1aa3:	8b 00                	mov    (%eax),%eax
    1aa5:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1aa8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aab:	8b 40 04             	mov    0x4(%eax),%eax
    1aae:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab4:	8b 40 04             	mov    0x4(%eax),%eax
    1ab7:	8b 50 04             	mov    0x4(%eax),%edx
    1aba:	8b 45 08             	mov    0x8(%ebp),%eax
    1abd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac3:	89 04 24             	mov    %eax,(%esp)
    1ac6:	e8 b5 fb ff ff       	call   1680 <free>
       q->size--;
    1acb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ace:	8b 00                	mov    (%eax),%eax
    1ad0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ad3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    1adb:	8b 00                	mov    (%eax),%eax
    1add:	85 c0                	test   %eax,%eax
    1adf:	75 14                	jne    1af5 <pop_q+0x6d>
            q->head = 0;
    1ae1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1aeb:	8b 45 08             	mov    0x8(%ebp),%eax
    1aee:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1af8:	eb 05                	jmp    1aff <pop_q+0x77>
    }
    return -1;
    1afa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1aff:	c9                   	leave  
    1b00:	c3                   	ret    
