
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
    1009:	e8 72 02 00 00       	call   1280 <fork>
    100e:	85 c0                	test   %eax,%eax
    1010:	7e 0c                	jle    101e <main+0x1e>
    sleep(5);  // Let child exit before parent.
    1012:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1019:	e8 fa 02 00 00       	call   1318 <sleep>
  exit();
    101e:	e8 65 02 00 00       	call   1288 <exit>
    1023:	90                   	nop

00001024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1024:	55                   	push   %ebp
    1025:	89 e5                	mov    %esp,%ebp
    1027:	57                   	push   %edi
    1028:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1029:	8b 4d 08             	mov    0x8(%ebp),%ecx
    102c:	8b 55 10             	mov    0x10(%ebp),%edx
    102f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1032:	89 cb                	mov    %ecx,%ebx
    1034:	89 df                	mov    %ebx,%edi
    1036:	89 d1                	mov    %edx,%ecx
    1038:	fc                   	cld    
    1039:	f3 aa                	rep stos %al,%es:(%edi)
    103b:	89 ca                	mov    %ecx,%edx
    103d:	89 fb                	mov    %edi,%ebx
    103f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1042:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1045:	5b                   	pop    %ebx
    1046:	5f                   	pop    %edi
    1047:	5d                   	pop    %ebp
    1048:	c3                   	ret    

00001049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1049:	55                   	push   %ebp
    104a:	89 e5                	mov    %esp,%ebp
    104c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    104f:	8b 45 08             	mov    0x8(%ebp),%eax
    1052:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1055:	8b 45 0c             	mov    0xc(%ebp),%eax
    1058:	0f b6 10             	movzbl (%eax),%edx
    105b:	8b 45 08             	mov    0x8(%ebp),%eax
    105e:	88 10                	mov    %dl,(%eax)
    1060:	8b 45 08             	mov    0x8(%ebp),%eax
    1063:	0f b6 00             	movzbl (%eax),%eax
    1066:	84 c0                	test   %al,%al
    1068:	0f 95 c0             	setne  %al
    106b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    106f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1073:	84 c0                	test   %al,%al
    1075:	75 de                	jne    1055 <strcpy+0xc>
    ;
  return os;
    1077:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    107a:	c9                   	leave  
    107b:	c3                   	ret    

0000107c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    107f:	eb 08                	jmp    1089 <strcmp+0xd>
    p++, q++;
    1081:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1085:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1089:	8b 45 08             	mov    0x8(%ebp),%eax
    108c:	0f b6 00             	movzbl (%eax),%eax
    108f:	84 c0                	test   %al,%al
    1091:	74 10                	je     10a3 <strcmp+0x27>
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	0f b6 10             	movzbl (%eax),%edx
    1099:	8b 45 0c             	mov    0xc(%ebp),%eax
    109c:	0f b6 00             	movzbl (%eax),%eax
    109f:	38 c2                	cmp    %al,%dl
    10a1:	74 de                	je     1081 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	0f b6 00             	movzbl (%eax),%eax
    10a9:	0f b6 d0             	movzbl %al,%edx
    10ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    10af:	0f b6 00             	movzbl (%eax),%eax
    10b2:	0f b6 c0             	movzbl %al,%eax
    10b5:	89 d1                	mov    %edx,%ecx
    10b7:	29 c1                	sub    %eax,%ecx
    10b9:	89 c8                	mov    %ecx,%eax
}
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    

000010bd <strlen>:

uint
strlen(char *s)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
    10c0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10ca:	eb 04                	jmp    10d0 <strlen+0x13>
    10cc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10d3:	03 45 08             	add    0x8(%ebp),%eax
    10d6:	0f b6 00             	movzbl (%eax),%eax
    10d9:	84 c0                	test   %al,%al
    10db:	75 ef                	jne    10cc <strlen+0xf>
    ;
  return n;
    10dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10e0:	c9                   	leave  
    10e1:	c3                   	ret    

000010e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10e2:	55                   	push   %ebp
    10e3:	89 e5                	mov    %esp,%ebp
    10e5:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    10e8:	8b 45 10             	mov    0x10(%ebp),%eax
    10eb:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    10f6:	8b 45 08             	mov    0x8(%ebp),%eax
    10f9:	89 04 24             	mov    %eax,(%esp)
    10fc:	e8 23 ff ff ff       	call   1024 <stosb>
  return dst;
    1101:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1104:	c9                   	leave  
    1105:	c3                   	ret    

00001106 <strchr>:

char*
strchr(const char *s, char c)
{
    1106:	55                   	push   %ebp
    1107:	89 e5                	mov    %esp,%ebp
    1109:	83 ec 04             	sub    $0x4,%esp
    110c:	8b 45 0c             	mov    0xc(%ebp),%eax
    110f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1112:	eb 14                	jmp    1128 <strchr+0x22>
    if(*s == c)
    1114:	8b 45 08             	mov    0x8(%ebp),%eax
    1117:	0f b6 00             	movzbl (%eax),%eax
    111a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    111d:	75 05                	jne    1124 <strchr+0x1e>
      return (char*)s;
    111f:	8b 45 08             	mov    0x8(%ebp),%eax
    1122:	eb 13                	jmp    1137 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1124:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1128:	8b 45 08             	mov    0x8(%ebp),%eax
    112b:	0f b6 00             	movzbl (%eax),%eax
    112e:	84 c0                	test   %al,%al
    1130:	75 e2                	jne    1114 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1132:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1137:	c9                   	leave  
    1138:	c3                   	ret    

00001139 <gets>:

char*
gets(char *buf, int max)
{
    1139:	55                   	push   %ebp
    113a:	89 e5                	mov    %esp,%ebp
    113c:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    113f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1146:	eb 44                	jmp    118c <gets+0x53>
    cc = read(0, &c, 1);
    1148:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    114f:	00 
    1150:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1153:	89 44 24 04          	mov    %eax,0x4(%esp)
    1157:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115e:	e8 3d 01 00 00       	call   12a0 <read>
    1163:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1166:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    116a:	7e 2d                	jle    1199 <gets+0x60>
      break;
    buf[i++] = c;
    116c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    116f:	03 45 08             	add    0x8(%ebp),%eax
    1172:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1176:	88 10                	mov    %dl,(%eax)
    1178:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    117c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1180:	3c 0a                	cmp    $0xa,%al
    1182:	74 16                	je     119a <gets+0x61>
    1184:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1188:	3c 0d                	cmp    $0xd,%al
    118a:	74 0e                	je     119a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    118c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    118f:	83 c0 01             	add    $0x1,%eax
    1192:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1195:	7c b1                	jl     1148 <gets+0xf>
    1197:	eb 01                	jmp    119a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1199:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    119a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    119d:	03 45 08             	add    0x8(%ebp),%eax
    11a0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11a6:	c9                   	leave  
    11a7:	c3                   	ret    

000011a8 <stat>:

int
stat(char *n, struct stat *st)
{
    11a8:	55                   	push   %ebp
    11a9:	89 e5                	mov    %esp,%ebp
    11ab:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11b5:	00 
    11b6:	8b 45 08             	mov    0x8(%ebp),%eax
    11b9:	89 04 24             	mov    %eax,(%esp)
    11bc:	e8 07 01 00 00       	call   12c8 <open>
    11c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    11c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11c8:	79 07                	jns    11d1 <stat+0x29>
    return -1;
    11ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11cf:	eb 23                	jmp    11f4 <stat+0x4c>
  r = fstat(fd, st);
    11d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11db:	89 04 24             	mov    %eax,(%esp)
    11de:	e8 fd 00 00 00       	call   12e0 <fstat>
    11e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    11e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e9:	89 04 24             	mov    %eax,(%esp)
    11ec:	e8 bf 00 00 00       	call   12b0 <close>
  return r;
    11f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    11f4:	c9                   	leave  
    11f5:	c3                   	ret    

000011f6 <atoi>:

int
atoi(const char *s)
{
    11f6:	55                   	push   %ebp
    11f7:	89 e5                	mov    %esp,%ebp
    11f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    11fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1203:	eb 24                	jmp    1229 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1205:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1208:	89 d0                	mov    %edx,%eax
    120a:	c1 e0 02             	shl    $0x2,%eax
    120d:	01 d0                	add    %edx,%eax
    120f:	01 c0                	add    %eax,%eax
    1211:	89 c2                	mov    %eax,%edx
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	0f b6 00             	movzbl (%eax),%eax
    1219:	0f be c0             	movsbl %al,%eax
    121c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    121f:	83 e8 30             	sub    $0x30,%eax
    1222:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1229:	8b 45 08             	mov    0x8(%ebp),%eax
    122c:	0f b6 00             	movzbl (%eax),%eax
    122f:	3c 2f                	cmp    $0x2f,%al
    1231:	7e 0a                	jle    123d <atoi+0x47>
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	0f b6 00             	movzbl (%eax),%eax
    1239:	3c 39                	cmp    $0x39,%al
    123b:	7e c8                	jle    1205 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    123d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1240:	c9                   	leave  
    1241:	c3                   	ret    

00001242 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1242:	55                   	push   %ebp
    1243:	89 e5                	mov    %esp,%ebp
    1245:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    124e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1251:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1254:	eb 13                	jmp    1269 <memmove+0x27>
    *dst++ = *src++;
    1256:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1259:	0f b6 10             	movzbl (%eax),%edx
    125c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125f:	88 10                	mov    %dl,(%eax)
    1261:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1265:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    126d:	0f 9f c0             	setg   %al
    1270:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1274:	84 c0                	test   %al,%al
    1276:	75 de                	jne    1256 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
}
    127b:	c9                   	leave  
    127c:	c3                   	ret    
    127d:	90                   	nop
    127e:	90                   	nop
    127f:	90                   	nop

00001280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1280:	b8 01 00 00 00       	mov    $0x1,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <exit>:
SYSCALL(exit)
    1288:	b8 02 00 00 00       	mov    $0x2,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <wait>:
SYSCALL(wait)
    1290:	b8 03 00 00 00       	mov    $0x3,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <pipe>:
SYSCALL(pipe)
    1298:	b8 04 00 00 00       	mov    $0x4,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <read>:
SYSCALL(read)
    12a0:	b8 05 00 00 00       	mov    $0x5,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <write>:
SYSCALL(write)
    12a8:	b8 10 00 00 00       	mov    $0x10,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <close>:
SYSCALL(close)
    12b0:	b8 15 00 00 00       	mov    $0x15,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <kill>:
SYSCALL(kill)
    12b8:	b8 06 00 00 00       	mov    $0x6,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <exec>:
SYSCALL(exec)
    12c0:	b8 07 00 00 00       	mov    $0x7,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <open>:
SYSCALL(open)
    12c8:	b8 0f 00 00 00       	mov    $0xf,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <mknod>:
SYSCALL(mknod)
    12d0:	b8 11 00 00 00       	mov    $0x11,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <unlink>:
SYSCALL(unlink)
    12d8:	b8 12 00 00 00       	mov    $0x12,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <fstat>:
SYSCALL(fstat)
    12e0:	b8 08 00 00 00       	mov    $0x8,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <link>:
SYSCALL(link)
    12e8:	b8 13 00 00 00       	mov    $0x13,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <mkdir>:
SYSCALL(mkdir)
    12f0:	b8 14 00 00 00       	mov    $0x14,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <chdir>:
SYSCALL(chdir)
    12f8:	b8 09 00 00 00       	mov    $0x9,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <dup>:
SYSCALL(dup)
    1300:	b8 0a 00 00 00       	mov    $0xa,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <getpid>:
SYSCALL(getpid)
    1308:	b8 0b 00 00 00       	mov    $0xb,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <sbrk>:
SYSCALL(sbrk)
    1310:	b8 0c 00 00 00       	mov    $0xc,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <sleep>:
SYSCALL(sleep)
    1318:	b8 0d 00 00 00       	mov    $0xd,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <uptime>:
SYSCALL(uptime)
    1320:	b8 0e 00 00 00       	mov    $0xe,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <clone>:
SYSCALL(clone)
    1328:	b8 16 00 00 00       	mov    $0x16,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <texit>:
SYSCALL(texit)
    1330:	b8 17 00 00 00       	mov    $0x17,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <tsleep>:
SYSCALL(tsleep)
    1338:	b8 18 00 00 00       	mov    $0x18,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <twakeup>:
SYSCALL(twakeup)
    1340:	b8 19 00 00 00       	mov    $0x19,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <thread_yield>:
SYSCALL(thread_yield)
    1348:	b8 1a 00 00 00       	mov    $0x1a,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	83 ec 28             	sub    $0x28,%esp
    1356:	8b 45 0c             	mov    0xc(%ebp),%eax
    1359:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    135c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1363:	00 
    1364:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1367:	89 44 24 04          	mov    %eax,0x4(%esp)
    136b:	8b 45 08             	mov    0x8(%ebp),%eax
    136e:	89 04 24             	mov    %eax,(%esp)
    1371:	e8 32 ff ff ff       	call   12a8 <write>
}
    1376:	c9                   	leave  
    1377:	c3                   	ret    

00001378 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1378:	55                   	push   %ebp
    1379:	89 e5                	mov    %esp,%ebp
    137b:	53                   	push   %ebx
    137c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    137f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1386:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    138a:	74 17                	je     13a3 <printint+0x2b>
    138c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1390:	79 11                	jns    13a3 <printint+0x2b>
    neg = 1;
    1392:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1399:	8b 45 0c             	mov    0xc(%ebp),%eax
    139c:	f7 d8                	neg    %eax
    139e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13a1:	eb 06                	jmp    13a9 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    13a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    13b0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13b3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b9:	ba 00 00 00 00       	mov    $0x0,%edx
    13be:	f7 f3                	div    %ebx
    13c0:	89 d0                	mov    %edx,%eax
    13c2:	0f b6 80 94 1a 00 00 	movzbl 0x1a94(%eax),%eax
    13c9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    13cd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    13d1:	8b 45 10             	mov    0x10(%ebp),%eax
    13d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    13d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13da:	ba 00 00 00 00       	mov    $0x0,%edx
    13df:	f7 75 d4             	divl   -0x2c(%ebp)
    13e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13e9:	75 c5                	jne    13b0 <printint+0x38>
  if(neg)
    13eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13ef:	74 28                	je     1419 <printint+0xa1>
    buf[i++] = '-';
    13f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13f4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    13f9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    13fd:	eb 1a                	jmp    1419 <printint+0xa1>
    putc(fd, buf[i]);
    13ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1402:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1407:	0f be c0             	movsbl %al,%eax
    140a:	89 44 24 04          	mov    %eax,0x4(%esp)
    140e:	8b 45 08             	mov    0x8(%ebp),%eax
    1411:	89 04 24             	mov    %eax,(%esp)
    1414:	e8 37 ff ff ff       	call   1350 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1419:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    141d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1421:	79 dc                	jns    13ff <printint+0x87>
    putc(fd, buf[i]);
}
    1423:	83 c4 44             	add    $0x44,%esp
    1426:	5b                   	pop    %ebx
    1427:	5d                   	pop    %ebp
    1428:	c3                   	ret    

00001429 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1429:	55                   	push   %ebp
    142a:	89 e5                	mov    %esp,%ebp
    142c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    142f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1436:	8d 45 0c             	lea    0xc(%ebp),%eax
    1439:	83 c0 04             	add    $0x4,%eax
    143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    143f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1446:	e9 7e 01 00 00       	jmp    15c9 <printf+0x1a0>
    c = fmt[i] & 0xff;
    144b:	8b 55 0c             	mov    0xc(%ebp),%edx
    144e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1451:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1454:	0f b6 00             	movzbl (%eax),%eax
    1457:	0f be c0             	movsbl %al,%eax
    145a:	25 ff 00 00 00       	and    $0xff,%eax
    145f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1462:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1466:	75 2c                	jne    1494 <printf+0x6b>
      if(c == '%'){
    1468:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    146c:	75 0c                	jne    147a <printf+0x51>
        state = '%';
    146e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1475:	e9 4b 01 00 00       	jmp    15c5 <printf+0x19c>
      } else {
        putc(fd, c);
    147a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    147d:	0f be c0             	movsbl %al,%eax
    1480:	89 44 24 04          	mov    %eax,0x4(%esp)
    1484:	8b 45 08             	mov    0x8(%ebp),%eax
    1487:	89 04 24             	mov    %eax,(%esp)
    148a:	e8 c1 fe ff ff       	call   1350 <putc>
    148f:	e9 31 01 00 00       	jmp    15c5 <printf+0x19c>
      }
    } else if(state == '%'){
    1494:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1498:	0f 85 27 01 00 00    	jne    15c5 <printf+0x19c>
      if(c == 'd'){
    149e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14a2:	75 2d                	jne    14d1 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    14a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a7:	8b 00                	mov    (%eax),%eax
    14a9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14b0:	00 
    14b1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14b8:	00 
    14b9:	89 44 24 04          	mov    %eax,0x4(%esp)
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	89 04 24             	mov    %eax,(%esp)
    14c3:	e8 b0 fe ff ff       	call   1378 <printint>
        ap++;
    14c8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    14cc:	e9 ed 00 00 00       	jmp    15be <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    14d1:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    14d5:	74 06                	je     14dd <printf+0xb4>
    14d7:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    14db:	75 2d                	jne    150a <printf+0xe1>
        printint(fd, *ap, 16, 0);
    14dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e0:	8b 00                	mov    (%eax),%eax
    14e2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14e9:	00 
    14ea:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    14f1:	00 
    14f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f6:	8b 45 08             	mov    0x8(%ebp),%eax
    14f9:	89 04 24             	mov    %eax,(%esp)
    14fc:	e8 77 fe ff ff       	call   1378 <printint>
        ap++;
    1501:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1505:	e9 b4 00 00 00       	jmp    15be <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    150a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    150e:	75 46                	jne    1556 <printf+0x12d>
        s = (char*)*ap;
    1510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1513:	8b 00                	mov    (%eax),%eax
    1515:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1518:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    151c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1520:	75 27                	jne    1549 <printf+0x120>
          s = "(null)";
    1522:	c7 45 e4 61 1a 00 00 	movl   $0x1a61,-0x1c(%ebp)
        while(*s != 0){
    1529:	eb 1f                	jmp    154a <printf+0x121>
          putc(fd, *s);
    152b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    152e:	0f b6 00             	movzbl (%eax),%eax
    1531:	0f be c0             	movsbl %al,%eax
    1534:	89 44 24 04          	mov    %eax,0x4(%esp)
    1538:	8b 45 08             	mov    0x8(%ebp),%eax
    153b:	89 04 24             	mov    %eax,(%esp)
    153e:	e8 0d fe ff ff       	call   1350 <putc>
          s++;
    1543:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1547:	eb 01                	jmp    154a <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1549:	90                   	nop
    154a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    154d:	0f b6 00             	movzbl (%eax),%eax
    1550:	84 c0                	test   %al,%al
    1552:	75 d7                	jne    152b <printf+0x102>
    1554:	eb 68                	jmp    15be <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1556:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    155a:	75 1d                	jne    1579 <printf+0x150>
        putc(fd, *ap);
    155c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155f:	8b 00                	mov    (%eax),%eax
    1561:	0f be c0             	movsbl %al,%eax
    1564:	89 44 24 04          	mov    %eax,0x4(%esp)
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	89 04 24             	mov    %eax,(%esp)
    156e:	e8 dd fd ff ff       	call   1350 <putc>
        ap++;
    1573:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1577:	eb 45                	jmp    15be <printf+0x195>
      } else if(c == '%'){
    1579:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    157d:	75 17                	jne    1596 <printf+0x16d>
        putc(fd, c);
    157f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1582:	0f be c0             	movsbl %al,%eax
    1585:	89 44 24 04          	mov    %eax,0x4(%esp)
    1589:	8b 45 08             	mov    0x8(%ebp),%eax
    158c:	89 04 24             	mov    %eax,(%esp)
    158f:	e8 bc fd ff ff       	call   1350 <putc>
    1594:	eb 28                	jmp    15be <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1596:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    159d:	00 
    159e:	8b 45 08             	mov    0x8(%ebp),%eax
    15a1:	89 04 24             	mov    %eax,(%esp)
    15a4:	e8 a7 fd ff ff       	call   1350 <putc>
        putc(fd, c);
    15a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ac:	0f be c0             	movsbl %al,%eax
    15af:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b3:	8b 45 08             	mov    0x8(%ebp),%eax
    15b6:	89 04 24             	mov    %eax,(%esp)
    15b9:	e8 92 fd ff ff       	call   1350 <putc>
      }
      state = 0;
    15be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15c5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    15cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15cf:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15d2:	0f b6 00             	movzbl (%eax),%eax
    15d5:	84 c0                	test   %al,%al
    15d7:	0f 85 6e fe ff ff    	jne    144b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15dd:	c9                   	leave  
    15de:	c3                   	ret    
    15df:	90                   	nop

000015e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15e6:	8b 45 08             	mov    0x8(%ebp),%eax
    15e9:	83 e8 08             	sub    $0x8,%eax
    15ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15ef:	a1 b4 1a 00 00       	mov    0x1ab4,%eax
    15f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15f7:	eb 24                	jmp    161d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15fc:	8b 00                	mov    (%eax),%eax
    15fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1601:	77 12                	ja     1615 <free+0x35>
    1603:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1609:	77 24                	ja     162f <free+0x4f>
    160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    160e:	8b 00                	mov    (%eax),%eax
    1610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1613:	77 1a                	ja     162f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1615:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1618:	8b 00                	mov    (%eax),%eax
    161a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    161d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1623:	76 d4                	jbe    15f9 <free+0x19>
    1625:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1628:	8b 00                	mov    (%eax),%eax
    162a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    162d:	76 ca                	jbe    15f9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1632:	8b 40 04             	mov    0x4(%eax),%eax
    1635:	c1 e0 03             	shl    $0x3,%eax
    1638:	89 c2                	mov    %eax,%edx
    163a:	03 55 f8             	add    -0x8(%ebp),%edx
    163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1640:	8b 00                	mov    (%eax),%eax
    1642:	39 c2                	cmp    %eax,%edx
    1644:	75 24                	jne    166a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1646:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1649:	8b 50 04             	mov    0x4(%eax),%edx
    164c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164f:	8b 00                	mov    (%eax),%eax
    1651:	8b 40 04             	mov    0x4(%eax),%eax
    1654:	01 c2                	add    %eax,%edx
    1656:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1659:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    165c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165f:	8b 00                	mov    (%eax),%eax
    1661:	8b 10                	mov    (%eax),%edx
    1663:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1666:	89 10                	mov    %edx,(%eax)
    1668:	eb 0a                	jmp    1674 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166d:	8b 10                	mov    (%eax),%edx
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1674:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1677:	8b 40 04             	mov    0x4(%eax),%eax
    167a:	c1 e0 03             	shl    $0x3,%eax
    167d:	03 45 fc             	add    -0x4(%ebp),%eax
    1680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1683:	75 20                	jne    16a5 <free+0xc5>
    p->s.size += bp->s.size;
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	8b 50 04             	mov    0x4(%eax),%edx
    168b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168e:	8b 40 04             	mov    0x4(%eax),%eax
    1691:	01 c2                	add    %eax,%edx
    1693:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1696:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1699:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169c:	8b 10                	mov    (%eax),%edx
    169e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a1:	89 10                	mov    %edx,(%eax)
    16a3:	eb 08                	jmp    16ad <free+0xcd>
  } else
    p->s.ptr = bp;
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ab:	89 10                	mov    %edx,(%eax)
  freep = p;
    16ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b0:	a3 b4 1a 00 00       	mov    %eax,0x1ab4
}
    16b5:	c9                   	leave  
    16b6:	c3                   	ret    

000016b7 <morecore>:

static Header*
morecore(uint nu)
{
    16b7:	55                   	push   %ebp
    16b8:	89 e5                	mov    %esp,%ebp
    16ba:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16c4:	77 07                	ja     16cd <morecore+0x16>
    nu = 4096;
    16c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
    16d0:	c1 e0 03             	shl    $0x3,%eax
    16d3:	89 04 24             	mov    %eax,(%esp)
    16d6:	e8 35 fc ff ff       	call   1310 <sbrk>
    16db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    16de:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    16e2:	75 07                	jne    16eb <morecore+0x34>
    return 0;
    16e4:	b8 00 00 00 00       	mov    $0x0,%eax
    16e9:	eb 22                	jmp    170d <morecore+0x56>
  hp = (Header*)p;
    16eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    16f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f4:	8b 55 08             	mov    0x8(%ebp),%edx
    16f7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    16fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fd:	83 c0 08             	add    $0x8,%eax
    1700:	89 04 24             	mov    %eax,(%esp)
    1703:	e8 d8 fe ff ff       	call   15e0 <free>
  return freep;
    1708:	a1 b4 1a 00 00       	mov    0x1ab4,%eax
}
    170d:	c9                   	leave  
    170e:	c3                   	ret    

0000170f <malloc>:

void*
malloc(uint nbytes)
{
    170f:	55                   	push   %ebp
    1710:	89 e5                	mov    %esp,%ebp
    1712:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1715:	8b 45 08             	mov    0x8(%ebp),%eax
    1718:	83 c0 07             	add    $0x7,%eax
    171b:	c1 e8 03             	shr    $0x3,%eax
    171e:	83 c0 01             	add    $0x1,%eax
    1721:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1724:	a1 b4 1a 00 00       	mov    0x1ab4,%eax
    1729:	89 45 f0             	mov    %eax,-0x10(%ebp)
    172c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1730:	75 23                	jne    1755 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1732:	c7 45 f0 ac 1a 00 00 	movl   $0x1aac,-0x10(%ebp)
    1739:	8b 45 f0             	mov    -0x10(%ebp),%eax
    173c:	a3 b4 1a 00 00       	mov    %eax,0x1ab4
    1741:	a1 b4 1a 00 00       	mov    0x1ab4,%eax
    1746:	a3 ac 1a 00 00       	mov    %eax,0x1aac
    base.s.size = 0;
    174b:	c7 05 b0 1a 00 00 00 	movl   $0x0,0x1ab0
    1752:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1755:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1758:	8b 00                	mov    (%eax),%eax
    175a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    175d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1760:	8b 40 04             	mov    0x4(%eax),%eax
    1763:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1766:	72 4d                	jb     17b5 <malloc+0xa6>
      if(p->s.size == nunits)
    1768:	8b 45 ec             	mov    -0x14(%ebp),%eax
    176b:	8b 40 04             	mov    0x4(%eax),%eax
    176e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1771:	75 0c                	jne    177f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1773:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1776:	8b 10                	mov    (%eax),%edx
    1778:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177b:	89 10                	mov    %edx,(%eax)
    177d:	eb 26                	jmp    17a5 <malloc+0x96>
      else {
        p->s.size -= nunits;
    177f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1782:	8b 40 04             	mov    0x4(%eax),%eax
    1785:	89 c2                	mov    %eax,%edx
    1787:	2b 55 f4             	sub    -0xc(%ebp),%edx
    178a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1790:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1793:	8b 40 04             	mov    0x4(%eax),%eax
    1796:	c1 e0 03             	shl    $0x3,%eax
    1799:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    179c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17a2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a8:	a3 b4 1a 00 00       	mov    %eax,0x1ab4
      return (void*)(p + 1);
    17ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b0:	83 c0 08             	add    $0x8,%eax
    17b3:	eb 38                	jmp    17ed <malloc+0xde>
    }
    if(p == freep)
    17b5:	a1 b4 1a 00 00       	mov    0x1ab4,%eax
    17ba:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17bd:	75 1b                	jne    17da <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	89 04 24             	mov    %eax,(%esp)
    17c5:	e8 ed fe ff ff       	call   16b7 <morecore>
    17ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17d1:	75 07                	jne    17da <malloc+0xcb>
        return 0;
    17d3:	b8 00 00 00 00       	mov    $0x0,%eax
    17d8:	eb 13                	jmp    17ed <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17da:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e3:	8b 00                	mov    (%eax),%eax
    17e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    17e8:	e9 70 ff ff ff       	jmp    175d <malloc+0x4e>
}
    17ed:	c9                   	leave  
    17ee:	c3                   	ret    
    17ef:	90                   	nop

000017f0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    17f6:	8b 55 08             	mov    0x8(%ebp),%edx
    17f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    17fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    17ff:	f0 87 02             	lock xchg %eax,(%edx)
    1802:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1805:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1808:	c9                   	leave  
    1809:	c3                   	ret    

0000180a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    180a:	55                   	push   %ebp
    180b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    180d:	8b 45 08             	mov    0x8(%ebp),%eax
    1810:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1816:	5d                   	pop    %ebp
    1817:	c3                   	ret    

00001818 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1818:	55                   	push   %ebp
    1819:	89 e5                	mov    %esp,%ebp
    181b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    181e:	8b 45 08             	mov    0x8(%ebp),%eax
    1821:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1828:	00 
    1829:	89 04 24             	mov    %eax,(%esp)
    182c:	e8 bf ff ff ff       	call   17f0 <xchg>
    1831:	85 c0                	test   %eax,%eax
    1833:	75 e9                	jne    181e <lock_acquire+0x6>
}
    1835:	c9                   	leave  
    1836:	c3                   	ret    

00001837 <lock_release>:
void lock_release(lock_t *lock){
    1837:	55                   	push   %ebp
    1838:	89 e5                	mov    %esp,%ebp
    183a:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    183d:	8b 45 08             	mov    0x8(%ebp),%eax
    1840:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1847:	00 
    1848:	89 04 24             	mov    %eax,(%esp)
    184b:	e8 a0 ff ff ff       	call   17f0 <xchg>
}
    1850:	c9                   	leave  
    1851:	c3                   	ret    

00001852 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1852:	55                   	push   %ebp
    1853:	89 e5                	mov    %esp,%ebp
    1855:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1858:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    185f:	e8 ab fe ff ff       	call   170f <malloc>
    1864:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1867:	8b 45 f0             	mov    -0x10(%ebp),%eax
    186a:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    186d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1870:	25 ff 0f 00 00       	and    $0xfff,%eax
    1875:	85 c0                	test   %eax,%eax
    1877:	74 15                	je     188e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1879:	8b 45 f0             	mov    -0x10(%ebp),%eax
    187c:	89 c2                	mov    %eax,%edx
    187e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1884:	b8 00 10 00 00       	mov    $0x1000,%eax
    1889:	29 d0                	sub    %edx,%eax
    188b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    188e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1892:	75 1b                	jne    18af <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1894:	c7 44 24 04 68 1a 00 	movl   $0x1a68,0x4(%esp)
    189b:	00 
    189c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18a3:	e8 81 fb ff ff       	call   1429 <printf>
        return 0;
    18a8:	b8 00 00 00 00       	mov    $0x0,%eax
    18ad:	eb 6f                	jmp    191e <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18af:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18b2:	8b 55 08             	mov    0x8(%ebp),%edx
    18b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18bc:	89 54 24 08          	mov    %edx,0x8(%esp)
    18c0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18c7:	00 
    18c8:	89 04 24             	mov    %eax,(%esp)
    18cb:	e8 58 fa ff ff       	call   1328 <clone>
    18d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18d7:	79 1b                	jns    18f4 <thread_create+0xa2>
        printf(1,"clone fails\n");
    18d9:	c7 44 24 04 76 1a 00 	movl   $0x1a76,0x4(%esp)
    18e0:	00 
    18e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e8:	e8 3c fb ff ff       	call   1429 <printf>
        return 0;
    18ed:	b8 00 00 00 00       	mov    $0x0,%eax
    18f2:	eb 2a                	jmp    191e <thread_create+0xcc>
    }
    if(tid > 0){
    18f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18f8:	7e 05                	jle    18ff <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    18fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fd:	eb 1f                	jmp    191e <thread_create+0xcc>
    }
    if(tid == 0){
    18ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1903:	75 14                	jne    1919 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1905:	c7 44 24 04 83 1a 00 	movl   $0x1a83,0x4(%esp)
    190c:	00 
    190d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1914:	e8 10 fb ff ff       	call   1429 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1919:	b8 00 00 00 00       	mov    $0x0,%eax
}
    191e:	c9                   	leave  
    191f:	c3                   	ret    

00001920 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1923:	a1 a8 1a 00 00       	mov    0x1aa8,%eax
    1928:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    192e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1933:	a3 a8 1a 00 00       	mov    %eax,0x1aa8
    return (int)(rands % max);
    1938:	a1 a8 1a 00 00       	mov    0x1aa8,%eax
    193d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1940:	ba 00 00 00 00       	mov    $0x0,%edx
    1945:	f7 f1                	div    %ecx
    1947:	89 d0                	mov    %edx,%eax
}
    1949:	5d                   	pop    %ebp
    194a:	c3                   	ret    
    194b:	90                   	nop

0000194c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    194c:	55                   	push   %ebp
    194d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    194f:	8b 45 08             	mov    0x8(%ebp),%eax
    1952:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1958:	8b 45 08             	mov    0x8(%ebp),%eax
    195b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1962:	8b 45 08             	mov    0x8(%ebp),%eax
    1965:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    196c:	5d                   	pop    %ebp
    196d:	c3                   	ret    

0000196e <add_q>:

void add_q(struct queue *q, int v){
    196e:	55                   	push   %ebp
    196f:	89 e5                	mov    %esp,%ebp
    1971:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1974:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    197b:	e8 8f fd ff ff       	call   170f <malloc>
    1980:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1983:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1986:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    198d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1990:	8b 55 0c             	mov    0xc(%ebp),%edx
    1993:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1995:	8b 45 08             	mov    0x8(%ebp),%eax
    1998:	8b 40 04             	mov    0x4(%eax),%eax
    199b:	85 c0                	test   %eax,%eax
    199d:	75 0b                	jne    19aa <add_q+0x3c>
        q->head = n;
    199f:	8b 45 08             	mov    0x8(%ebp),%eax
    19a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19a5:	89 50 04             	mov    %edx,0x4(%eax)
    19a8:	eb 0c                	jmp    19b6 <add_q+0x48>
    }else{
        q->tail->next = n;
    19aa:	8b 45 08             	mov    0x8(%ebp),%eax
    19ad:	8b 40 08             	mov    0x8(%eax),%eax
    19b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19b3:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19bc:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19bf:	8b 45 08             	mov    0x8(%ebp),%eax
    19c2:	8b 00                	mov    (%eax),%eax
    19c4:	8d 50 01             	lea    0x1(%eax),%edx
    19c7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ca:	89 10                	mov    %edx,(%eax)
}
    19cc:	c9                   	leave  
    19cd:	c3                   	ret    

000019ce <empty_q>:

int empty_q(struct queue *q){
    19ce:	55                   	push   %ebp
    19cf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	8b 00                	mov    (%eax),%eax
    19d6:	85 c0                	test   %eax,%eax
    19d8:	75 07                	jne    19e1 <empty_q+0x13>
        return 1;
    19da:	b8 01 00 00 00       	mov    $0x1,%eax
    19df:	eb 05                	jmp    19e6 <empty_q+0x18>
    else
        return 0;
    19e1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    19e6:	5d                   	pop    %ebp
    19e7:	c3                   	ret    

000019e8 <pop_q>:
int pop_q(struct queue *q){
    19e8:	55                   	push   %ebp
    19e9:	89 e5                	mov    %esp,%ebp
    19eb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	89 04 24             	mov    %eax,(%esp)
    19f4:	e8 d5 ff ff ff       	call   19ce <empty_q>
    19f9:	85 c0                	test   %eax,%eax
    19fb:	75 5d                	jne    1a5a <pop_q+0x72>
       val = q->head->value; 
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	8b 40 04             	mov    0x4(%eax),%eax
    1a03:	8b 00                	mov    (%eax),%eax
    1a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1a08:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0b:	8b 40 04             	mov    0x4(%eax),%eax
    1a0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 40 04             	mov    0x4(%eax),%eax
    1a17:	8b 50 04             	mov    0x4(%eax),%edx
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a23:	89 04 24             	mov    %eax,(%esp)
    1a26:	e8 b5 fb ff ff       	call   15e0 <free>
       q->size--;
    1a2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2e:	8b 00                	mov    (%eax),%eax
    1a30:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a38:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3b:	8b 00                	mov    (%eax),%eax
    1a3d:	85 c0                	test   %eax,%eax
    1a3f:	75 14                	jne    1a55 <pop_q+0x6d>
            q->head = 0;
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a58:	eb 05                	jmp    1a5f <pop_q+0x77>
    }
    return -1;
    1a5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a5f:	c9                   	leave  
    1a60:	c3                   	ret    
