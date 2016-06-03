
_echo:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int i;

  for(i = 1; i < argc; i++)
    1009:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1010:	00 
    1011:	eb 4b                	jmp    105e <main+0x5e>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1013:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1017:	83 c0 01             	add    $0x1,%eax
    101a:	3b 45 08             	cmp    0x8(%ebp),%eax
    101d:	7d 07                	jge    1026 <main+0x26>
    101f:	b8 bd 1a 00 00       	mov    $0x1abd,%eax
    1024:	eb 05                	jmp    102b <main+0x2b>
    1026:	b8 bf 1a 00 00       	mov    $0x1abf,%eax
    102b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    102f:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
    1036:	8b 55 0c             	mov    0xc(%ebp),%edx
    1039:	01 ca                	add    %ecx,%edx
    103b:	8b 12                	mov    (%edx),%edx
    103d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1041:	89 54 24 08          	mov    %edx,0x8(%esp)
    1045:	c7 44 24 04 c1 1a 00 	movl   $0x1ac1,0x4(%esp)
    104c:	00 
    104d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1054:	e8 23 04 00 00       	call   147c <printf>
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
    1059:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    105e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1062:	3b 45 08             	cmp    0x8(%ebp),%eax
    1065:	7c ac                	jl     1013 <main+0x13>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
    1067:	e8 68 02 00 00       	call   12d4 <exit>

0000106c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    106c:	55                   	push   %ebp
    106d:	89 e5                	mov    %esp,%ebp
    106f:	57                   	push   %edi
    1070:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1071:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1074:	8b 55 10             	mov    0x10(%ebp),%edx
    1077:	8b 45 0c             	mov    0xc(%ebp),%eax
    107a:	89 cb                	mov    %ecx,%ebx
    107c:	89 df                	mov    %ebx,%edi
    107e:	89 d1                	mov    %edx,%ecx
    1080:	fc                   	cld    
    1081:	f3 aa                	rep stos %al,%es:(%edi)
    1083:	89 ca                	mov    %ecx,%edx
    1085:	89 fb                	mov    %edi,%ebx
    1087:	89 5d 08             	mov    %ebx,0x8(%ebp)
    108a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    108d:	5b                   	pop    %ebx
    108e:	5f                   	pop    %edi
    108f:	5d                   	pop    %ebp
    1090:	c3                   	ret    

00001091 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1091:	55                   	push   %ebp
    1092:	89 e5                	mov    %esp,%ebp
    1094:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1097:	8b 45 08             	mov    0x8(%ebp),%eax
    109a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    109d:	90                   	nop
    109e:	8b 45 08             	mov    0x8(%ebp),%eax
    10a1:	8d 50 01             	lea    0x1(%eax),%edx
    10a4:	89 55 08             	mov    %edx,0x8(%ebp)
    10a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10aa:	8d 4a 01             	lea    0x1(%edx),%ecx
    10ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10b0:	0f b6 12             	movzbl (%edx),%edx
    10b3:	88 10                	mov    %dl,(%eax)
    10b5:	0f b6 00             	movzbl (%eax),%eax
    10b8:	84 c0                	test   %al,%al
    10ba:	75 e2                	jne    109e <strcpy+0xd>
    ;
  return os;
    10bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10bf:	c9                   	leave  
    10c0:	c3                   	ret    

000010c1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10c1:	55                   	push   %ebp
    10c2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10c4:	eb 08                	jmp    10ce <strcmp+0xd>
    p++, q++;
    10c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	0f b6 00             	movzbl (%eax),%eax
    10d4:	84 c0                	test   %al,%al
    10d6:	74 10                	je     10e8 <strcmp+0x27>
    10d8:	8b 45 08             	mov    0x8(%ebp),%eax
    10db:	0f b6 10             	movzbl (%eax),%edx
    10de:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e1:	0f b6 00             	movzbl (%eax),%eax
    10e4:	38 c2                	cmp    %al,%dl
    10e6:	74 de                	je     10c6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10e8:	8b 45 08             	mov    0x8(%ebp),%eax
    10eb:	0f b6 00             	movzbl (%eax),%eax
    10ee:	0f b6 d0             	movzbl %al,%edx
    10f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f4:	0f b6 00             	movzbl (%eax),%eax
    10f7:	0f b6 c0             	movzbl %al,%eax
    10fa:	29 c2                	sub    %eax,%edx
    10fc:	89 d0                	mov    %edx,%eax
}
    10fe:	5d                   	pop    %ebp
    10ff:	c3                   	ret    

00001100 <strlen>:

uint
strlen(char *s)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    110d:	eb 04                	jmp    1113 <strlen+0x13>
    110f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1113:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1116:	8b 45 08             	mov    0x8(%ebp),%eax
    1119:	01 d0                	add    %edx,%eax
    111b:	0f b6 00             	movzbl (%eax),%eax
    111e:	84 c0                	test   %al,%al
    1120:	75 ed                	jne    110f <strlen+0xf>
    ;
  return n;
    1122:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1125:	c9                   	leave  
    1126:	c3                   	ret    

00001127 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1127:	55                   	push   %ebp
    1128:	89 e5                	mov    %esp,%ebp
    112a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    112d:	8b 45 10             	mov    0x10(%ebp),%eax
    1130:	89 44 24 08          	mov    %eax,0x8(%esp)
    1134:	8b 45 0c             	mov    0xc(%ebp),%eax
    1137:	89 44 24 04          	mov    %eax,0x4(%esp)
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	89 04 24             	mov    %eax,(%esp)
    1141:	e8 26 ff ff ff       	call   106c <stosb>
  return dst;
    1146:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1149:	c9                   	leave  
    114a:	c3                   	ret    

0000114b <strchr>:

char*
strchr(const char *s, char c)
{
    114b:	55                   	push   %ebp
    114c:	89 e5                	mov    %esp,%ebp
    114e:	83 ec 04             	sub    $0x4,%esp
    1151:	8b 45 0c             	mov    0xc(%ebp),%eax
    1154:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1157:	eb 14                	jmp    116d <strchr+0x22>
    if(*s == c)
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	0f b6 00             	movzbl (%eax),%eax
    115f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1162:	75 05                	jne    1169 <strchr+0x1e>
      return (char*)s;
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	eb 13                	jmp    117c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	0f b6 00             	movzbl (%eax),%eax
    1173:	84 c0                	test   %al,%al
    1175:	75 e2                	jne    1159 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1177:	b8 00 00 00 00       	mov    $0x0,%eax
}
    117c:	c9                   	leave  
    117d:	c3                   	ret    

0000117e <gets>:

char*
gets(char *buf, int max)
{
    117e:	55                   	push   %ebp
    117f:	89 e5                	mov    %esp,%ebp
    1181:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    118b:	eb 4c                	jmp    11d9 <gets+0x5b>
    cc = read(0, &c, 1);
    118d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1194:	00 
    1195:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1198:	89 44 24 04          	mov    %eax,0x4(%esp)
    119c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11a3:	e8 44 01 00 00       	call   12ec <read>
    11a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11af:	7f 02                	jg     11b3 <gets+0x35>
      break;
    11b1:	eb 31                	jmp    11e4 <gets+0x66>
    buf[i++] = c;
    11b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b6:	8d 50 01             	lea    0x1(%eax),%edx
    11b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11bc:	89 c2                	mov    %eax,%edx
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	01 c2                	add    %eax,%edx
    11c3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11cd:	3c 0a                	cmp    $0xa,%al
    11cf:	74 13                	je     11e4 <gets+0x66>
    11d1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d5:	3c 0d                	cmp    $0xd,%al
    11d7:	74 0b                	je     11e4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11dc:	83 c0 01             	add    $0x1,%eax
    11df:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11e2:	7c a9                	jl     118d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	01 d0                	add    %edx,%eax
    11ec:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11f2:	c9                   	leave  
    11f3:	c3                   	ret    

000011f4 <stat>:

int
stat(char *n, struct stat *st)
{
    11f4:	55                   	push   %ebp
    11f5:	89 e5                	mov    %esp,%ebp
    11f7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11fa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1201:	00 
    1202:	8b 45 08             	mov    0x8(%ebp),%eax
    1205:	89 04 24             	mov    %eax,(%esp)
    1208:	e8 07 01 00 00       	call   1314 <open>
    120d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1210:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1214:	79 07                	jns    121d <stat+0x29>
    return -1;
    1216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    121b:	eb 23                	jmp    1240 <stat+0x4c>
  r = fstat(fd, st);
    121d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1220:	89 44 24 04          	mov    %eax,0x4(%esp)
    1224:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1227:	89 04 24             	mov    %eax,(%esp)
    122a:	e8 fd 00 00 00       	call   132c <fstat>
    122f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1232:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1235:	89 04 24             	mov    %eax,(%esp)
    1238:	e8 bf 00 00 00       	call   12fc <close>
  return r;
    123d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1240:	c9                   	leave  
    1241:	c3                   	ret    

00001242 <atoi>:

int
atoi(const char *s)
{
    1242:	55                   	push   %ebp
    1243:	89 e5                	mov    %esp,%ebp
    1245:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    124f:	eb 25                	jmp    1276 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1251:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1254:	89 d0                	mov    %edx,%eax
    1256:	c1 e0 02             	shl    $0x2,%eax
    1259:	01 d0                	add    %edx,%eax
    125b:	01 c0                	add    %eax,%eax
    125d:	89 c1                	mov    %eax,%ecx
    125f:	8b 45 08             	mov    0x8(%ebp),%eax
    1262:	8d 50 01             	lea    0x1(%eax),%edx
    1265:	89 55 08             	mov    %edx,0x8(%ebp)
    1268:	0f b6 00             	movzbl (%eax),%eax
    126b:	0f be c0             	movsbl %al,%eax
    126e:	01 c8                	add    %ecx,%eax
    1270:	83 e8 30             	sub    $0x30,%eax
    1273:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	0f b6 00             	movzbl (%eax),%eax
    127c:	3c 2f                	cmp    $0x2f,%al
    127e:	7e 0a                	jle    128a <atoi+0x48>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	0f b6 00             	movzbl (%eax),%eax
    1286:	3c 39                	cmp    $0x39,%al
    1288:	7e c7                	jle    1251 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    128d:	c9                   	leave  
    128e:	c3                   	ret    

0000128f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    128f:	55                   	push   %ebp
    1290:	89 e5                	mov    %esp,%ebp
    1292:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1295:	8b 45 08             	mov    0x8(%ebp),%eax
    1298:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    129b:	8b 45 0c             	mov    0xc(%ebp),%eax
    129e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12a1:	eb 17                	jmp    12ba <memmove+0x2b>
    *dst++ = *src++;
    12a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a6:	8d 50 01             	lea    0x1(%eax),%edx
    12a9:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12af:	8d 4a 01             	lea    0x1(%edx),%ecx
    12b2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12b5:	0f b6 12             	movzbl (%edx),%edx
    12b8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ba:	8b 45 10             	mov    0x10(%ebp),%eax
    12bd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12c0:	89 55 10             	mov    %edx,0x10(%ebp)
    12c3:	85 c0                	test   %eax,%eax
    12c5:	7f dc                	jg     12a3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ca:	c9                   	leave  
    12cb:	c3                   	ret    

000012cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12cc:	b8 01 00 00 00       	mov    $0x1,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <exit>:
SYSCALL(exit)
    12d4:	b8 02 00 00 00       	mov    $0x2,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <wait>:
SYSCALL(wait)
    12dc:	b8 03 00 00 00       	mov    $0x3,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <pipe>:
SYSCALL(pipe)
    12e4:	b8 04 00 00 00       	mov    $0x4,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <read>:
SYSCALL(read)
    12ec:	b8 05 00 00 00       	mov    $0x5,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <write>:
SYSCALL(write)
    12f4:	b8 10 00 00 00       	mov    $0x10,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <close>:
SYSCALL(close)
    12fc:	b8 15 00 00 00       	mov    $0x15,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <kill>:
SYSCALL(kill)
    1304:	b8 06 00 00 00       	mov    $0x6,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <exec>:
SYSCALL(exec)
    130c:	b8 07 00 00 00       	mov    $0x7,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <open>:
SYSCALL(open)
    1314:	b8 0f 00 00 00       	mov    $0xf,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <mknod>:
SYSCALL(mknod)
    131c:	b8 11 00 00 00       	mov    $0x11,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <unlink>:
SYSCALL(unlink)
    1324:	b8 12 00 00 00       	mov    $0x12,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <fstat>:
SYSCALL(fstat)
    132c:	b8 08 00 00 00       	mov    $0x8,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <link>:
SYSCALL(link)
    1334:	b8 13 00 00 00       	mov    $0x13,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <mkdir>:
SYSCALL(mkdir)
    133c:	b8 14 00 00 00       	mov    $0x14,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <chdir>:
SYSCALL(chdir)
    1344:	b8 09 00 00 00       	mov    $0x9,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <dup>:
SYSCALL(dup)
    134c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <getpid>:
SYSCALL(getpid)
    1354:	b8 0b 00 00 00       	mov    $0xb,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <sbrk>:
SYSCALL(sbrk)
    135c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <sleep>:
SYSCALL(sleep)
    1364:	b8 0d 00 00 00       	mov    $0xd,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <uptime>:
SYSCALL(uptime)
    136c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <clone>:
SYSCALL(clone)
    1374:	b8 16 00 00 00       	mov    $0x16,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <texit>:
SYSCALL(texit)
    137c:	b8 17 00 00 00       	mov    $0x17,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <tsleep>:
SYSCALL(tsleep)
    1384:	b8 18 00 00 00       	mov    $0x18,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <twakeup>:
SYSCALL(twakeup)
    138c:	b8 19 00 00 00       	mov    $0x19,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <thread_yield>:
SYSCALL(thread_yield)
    1394:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    139c:	55                   	push   %ebp
    139d:	89 e5                	mov    %esp,%ebp
    139f:	83 ec 18             	sub    $0x18,%esp
    13a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13af:	00 
    13b0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    13b7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ba:	89 04 24             	mov    %eax,(%esp)
    13bd:	e8 32 ff ff ff       	call   12f4 <write>
}
    13c2:	c9                   	leave  
    13c3:	c3                   	ret    

000013c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13c4:	55                   	push   %ebp
    13c5:	89 e5                	mov    %esp,%ebp
    13c7:	56                   	push   %esi
    13c8:	53                   	push   %ebx
    13c9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13d3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13d7:	74 17                	je     13f0 <printint+0x2c>
    13d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13dd:	79 11                	jns    13f0 <printint+0x2c>
    neg = 1;
    13df:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e9:	f7 d8                	neg    %eax
    13eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13ee:	eb 06                	jmp    13f6 <printint+0x32>
  } else {
    x = xx;
    13f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13fd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1400:	8d 41 01             	lea    0x1(%ecx),%eax
    1403:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1406:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1409:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140c:	ba 00 00 00 00       	mov    $0x0,%edx
    1411:	f7 f3                	div    %ebx
    1413:	89 d0                	mov    %edx,%eax
    1415:	0f b6 80 80 1e 00 00 	movzbl 0x1e80(%eax),%eax
    141c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1420:	8b 75 10             	mov    0x10(%ebp),%esi
    1423:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1426:	ba 00 00 00 00       	mov    $0x0,%edx
    142b:	f7 f6                	div    %esi
    142d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1430:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1434:	75 c7                	jne    13fd <printint+0x39>
  if(neg)
    1436:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    143a:	74 10                	je     144c <printint+0x88>
    buf[i++] = '-';
    143c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143f:	8d 50 01             	lea    0x1(%eax),%edx
    1442:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1445:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    144a:	eb 1f                	jmp    146b <printint+0xa7>
    144c:	eb 1d                	jmp    146b <printint+0xa7>
    putc(fd, buf[i]);
    144e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1454:	01 d0                	add    %edx,%eax
    1456:	0f b6 00             	movzbl (%eax),%eax
    1459:	0f be c0             	movsbl %al,%eax
    145c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
    1463:	89 04 24             	mov    %eax,(%esp)
    1466:	e8 31 ff ff ff       	call   139c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    146b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    146f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1473:	79 d9                	jns    144e <printint+0x8a>
    putc(fd, buf[i]);
}
    1475:	83 c4 30             	add    $0x30,%esp
    1478:	5b                   	pop    %ebx
    1479:	5e                   	pop    %esi
    147a:	5d                   	pop    %ebp
    147b:	c3                   	ret    

0000147c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    147c:	55                   	push   %ebp
    147d:	89 e5                	mov    %esp,%ebp
    147f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1482:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1489:	8d 45 0c             	lea    0xc(%ebp),%eax
    148c:	83 c0 04             	add    $0x4,%eax
    148f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1492:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1499:	e9 7c 01 00 00       	jmp    161a <printf+0x19e>
    c = fmt[i] & 0xff;
    149e:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14a4:	01 d0                	add    %edx,%eax
    14a6:	0f b6 00             	movzbl (%eax),%eax
    14a9:	0f be c0             	movsbl %al,%eax
    14ac:	25 ff 00 00 00       	and    $0xff,%eax
    14b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b8:	75 2c                	jne    14e6 <printf+0x6a>
      if(c == '%'){
    14ba:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14be:	75 0c                	jne    14cc <printf+0x50>
        state = '%';
    14c0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14c7:	e9 4a 01 00 00       	jmp    1616 <printf+0x19a>
      } else {
        putc(fd, c);
    14cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14cf:	0f be c0             	movsbl %al,%eax
    14d2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
    14d9:	89 04 24             	mov    %eax,(%esp)
    14dc:	e8 bb fe ff ff       	call   139c <putc>
    14e1:	e9 30 01 00 00       	jmp    1616 <printf+0x19a>
      }
    } else if(state == '%'){
    14e6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14ea:	0f 85 26 01 00 00    	jne    1616 <printf+0x19a>
      if(c == 'd'){
    14f0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14f4:	75 2d                	jne    1523 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f9:	8b 00                	mov    (%eax),%eax
    14fb:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1502:	00 
    1503:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    150a:	00 
    150b:	89 44 24 04          	mov    %eax,0x4(%esp)
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	89 04 24             	mov    %eax,(%esp)
    1515:	e8 aa fe ff ff       	call   13c4 <printint>
        ap++;
    151a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    151e:	e9 ec 00 00 00       	jmp    160f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1523:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1527:	74 06                	je     152f <printf+0xb3>
    1529:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    152d:	75 2d                	jne    155c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    152f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1532:	8b 00                	mov    (%eax),%eax
    1534:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    153b:	00 
    153c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1543:	00 
    1544:	89 44 24 04          	mov    %eax,0x4(%esp)
    1548:	8b 45 08             	mov    0x8(%ebp),%eax
    154b:	89 04 24             	mov    %eax,(%esp)
    154e:	e8 71 fe ff ff       	call   13c4 <printint>
        ap++;
    1553:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1557:	e9 b3 00 00 00       	jmp    160f <printf+0x193>
      } else if(c == 's'){
    155c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1560:	75 45                	jne    15a7 <printf+0x12b>
        s = (char*)*ap;
    1562:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1565:	8b 00                	mov    (%eax),%eax
    1567:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    156a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    156e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1572:	75 09                	jne    157d <printf+0x101>
          s = "(null)";
    1574:	c7 45 f4 c6 1a 00 00 	movl   $0x1ac6,-0xc(%ebp)
        while(*s != 0){
    157b:	eb 1e                	jmp    159b <printf+0x11f>
    157d:	eb 1c                	jmp    159b <printf+0x11f>
          putc(fd, *s);
    157f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1582:	0f b6 00             	movzbl (%eax),%eax
    1585:	0f be c0             	movsbl %al,%eax
    1588:	89 44 24 04          	mov    %eax,0x4(%esp)
    158c:	8b 45 08             	mov    0x8(%ebp),%eax
    158f:	89 04 24             	mov    %eax,(%esp)
    1592:	e8 05 fe ff ff       	call   139c <putc>
          s++;
    1597:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	0f b6 00             	movzbl (%eax),%eax
    15a1:	84 c0                	test   %al,%al
    15a3:	75 da                	jne    157f <printf+0x103>
    15a5:	eb 68                	jmp    160f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15a7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15ab:	75 1d                	jne    15ca <printf+0x14e>
        putc(fd, *ap);
    15ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b0:	8b 00                	mov    (%eax),%eax
    15b2:	0f be c0             	movsbl %al,%eax
    15b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b9:	8b 45 08             	mov    0x8(%ebp),%eax
    15bc:	89 04 24             	mov    %eax,(%esp)
    15bf:	e8 d8 fd ff ff       	call   139c <putc>
        ap++;
    15c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15c8:	eb 45                	jmp    160f <printf+0x193>
      } else if(c == '%'){
    15ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15ce:	75 17                	jne    15e7 <printf+0x16b>
        putc(fd, c);
    15d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d3:	0f be c0             	movsbl %al,%eax
    15d6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15da:	8b 45 08             	mov    0x8(%ebp),%eax
    15dd:	89 04 24             	mov    %eax,(%esp)
    15e0:	e8 b7 fd ff ff       	call   139c <putc>
    15e5:	eb 28                	jmp    160f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15e7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15ee:	00 
    15ef:	8b 45 08             	mov    0x8(%ebp),%eax
    15f2:	89 04 24             	mov    %eax,(%esp)
    15f5:	e8 a2 fd ff ff       	call   139c <putc>
        putc(fd, c);
    15fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15fd:	0f be c0             	movsbl %al,%eax
    1600:	89 44 24 04          	mov    %eax,0x4(%esp)
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	89 04 24             	mov    %eax,(%esp)
    160a:	e8 8d fd ff ff       	call   139c <putc>
      }
      state = 0;
    160f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1616:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    161a:	8b 55 0c             	mov    0xc(%ebp),%edx
    161d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1620:	01 d0                	add    %edx,%eax
    1622:	0f b6 00             	movzbl (%eax),%eax
    1625:	84 c0                	test   %al,%al
    1627:	0f 85 71 fe ff ff    	jne    149e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    162d:	c9                   	leave  
    162e:	c3                   	ret    
    162f:	90                   	nop

00001630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1636:	8b 45 08             	mov    0x8(%ebp),%eax
    1639:	83 e8 08             	sub    $0x8,%eax
    163c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    163f:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
    1644:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1647:	eb 24                	jmp    166d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1649:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1651:	77 12                	ja     1665 <free+0x35>
    1653:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1659:	77 24                	ja     167f <free+0x4f>
    165b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165e:	8b 00                	mov    (%eax),%eax
    1660:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1663:	77 1a                	ja     167f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1665:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1668:	8b 00                	mov    (%eax),%eax
    166a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    166d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1670:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1673:	76 d4                	jbe    1649 <free+0x19>
    1675:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1678:	8b 00                	mov    (%eax),%eax
    167a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    167d:	76 ca                	jbe    1649 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    167f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1682:	8b 40 04             	mov    0x4(%eax),%eax
    1685:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    168c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168f:	01 c2                	add    %eax,%edx
    1691:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	39 c2                	cmp    %eax,%edx
    1698:	75 24                	jne    16be <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    169a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169d:	8b 50 04             	mov    0x4(%eax),%edx
    16a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a3:	8b 00                	mov    (%eax),%eax
    16a5:	8b 40 04             	mov    0x4(%eax),%eax
    16a8:	01 c2                	add    %eax,%edx
    16aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ad:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b3:	8b 00                	mov    (%eax),%eax
    16b5:	8b 10                	mov    (%eax),%edx
    16b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ba:	89 10                	mov    %edx,(%eax)
    16bc:	eb 0a                	jmp    16c8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    16be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c1:	8b 10                	mov    (%eax),%edx
    16c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cb:	8b 40 04             	mov    0x4(%eax),%eax
    16ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d8:	01 d0                	add    %edx,%eax
    16da:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16dd:	75 20                	jne    16ff <free+0xcf>
    p->s.size += bp->s.size;
    16df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e2:	8b 50 04             	mov    0x4(%eax),%edx
    16e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e8:	8b 40 04             	mov    0x4(%eax),%eax
    16eb:	01 c2                	add    %eax,%edx
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f6:	8b 10                	mov    (%eax),%edx
    16f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fb:	89 10                	mov    %edx,(%eax)
    16fd:	eb 08                	jmp    1707 <free+0xd7>
  } else
    p->s.ptr = bp;
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1705:	89 10                	mov    %edx,(%eax)
  freep = p;
    1707:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170a:	a3 a0 1e 00 00       	mov    %eax,0x1ea0
}
    170f:	c9                   	leave  
    1710:	c3                   	ret    

00001711 <morecore>:

static Header*
morecore(uint nu)
{
    1711:	55                   	push   %ebp
    1712:	89 e5                	mov    %esp,%ebp
    1714:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1717:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    171e:	77 07                	ja     1727 <morecore+0x16>
    nu = 4096;
    1720:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1727:	8b 45 08             	mov    0x8(%ebp),%eax
    172a:	c1 e0 03             	shl    $0x3,%eax
    172d:	89 04 24             	mov    %eax,(%esp)
    1730:	e8 27 fc ff ff       	call   135c <sbrk>
    1735:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1738:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    173c:	75 07                	jne    1745 <morecore+0x34>
    return 0;
    173e:	b8 00 00 00 00       	mov    $0x0,%eax
    1743:	eb 22                	jmp    1767 <morecore+0x56>
  hp = (Header*)p;
    1745:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1748:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    174b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    174e:	8b 55 08             	mov    0x8(%ebp),%edx
    1751:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1754:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1757:	83 c0 08             	add    $0x8,%eax
    175a:	89 04 24             	mov    %eax,(%esp)
    175d:	e8 ce fe ff ff       	call   1630 <free>
  return freep;
    1762:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
}
    1767:	c9                   	leave  
    1768:	c3                   	ret    

00001769 <malloc>:

void*
malloc(uint nbytes)
{
    1769:	55                   	push   %ebp
    176a:	89 e5                	mov    %esp,%ebp
    176c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    176f:	8b 45 08             	mov    0x8(%ebp),%eax
    1772:	83 c0 07             	add    $0x7,%eax
    1775:	c1 e8 03             	shr    $0x3,%eax
    1778:	83 c0 01             	add    $0x1,%eax
    177b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    177e:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
    1783:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1786:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    178a:	75 23                	jne    17af <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    178c:	c7 45 f0 98 1e 00 00 	movl   $0x1e98,-0x10(%ebp)
    1793:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1796:	a3 a0 1e 00 00       	mov    %eax,0x1ea0
    179b:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
    17a0:	a3 98 1e 00 00       	mov    %eax,0x1e98
    base.s.size = 0;
    17a5:	c7 05 9c 1e 00 00 00 	movl   $0x0,0x1e9c
    17ac:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b2:	8b 00                	mov    (%eax),%eax
    17b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ba:	8b 40 04             	mov    0x4(%eax),%eax
    17bd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17c0:	72 4d                	jb     180f <malloc+0xa6>
      if(p->s.size == nunits)
    17c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c5:	8b 40 04             	mov    0x4(%eax),%eax
    17c8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17cb:	75 0c                	jne    17d9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	8b 10                	mov    (%eax),%edx
    17d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d5:	89 10                	mov    %edx,(%eax)
    17d7:	eb 26                	jmp    17ff <malloc+0x96>
      else {
        p->s.size -= nunits;
    17d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17dc:	8b 40 04             	mov    0x4(%eax),%eax
    17df:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17e2:	89 c2                	mov    %eax,%edx
    17e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ed:	8b 40 04             	mov    0x4(%eax),%eax
    17f0:	c1 e0 03             	shl    $0x3,%eax
    17f3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17fc:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1802:	a3 a0 1e 00 00       	mov    %eax,0x1ea0
      return (void*)(p + 1);
    1807:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180a:	83 c0 08             	add    $0x8,%eax
    180d:	eb 38                	jmp    1847 <malloc+0xde>
    }
    if(p == freep)
    180f:	a1 a0 1e 00 00       	mov    0x1ea0,%eax
    1814:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1817:	75 1b                	jne    1834 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1819:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181c:	89 04 24             	mov    %eax,(%esp)
    181f:	e8 ed fe ff ff       	call   1711 <morecore>
    1824:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1827:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    182b:	75 07                	jne    1834 <malloc+0xcb>
        return 0;
    182d:	b8 00 00 00 00       	mov    $0x0,%eax
    1832:	eb 13                	jmp    1847 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1834:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1837:	89 45 f0             	mov    %eax,-0x10(%ebp)
    183a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183d:	8b 00                	mov    (%eax),%eax
    183f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1842:	e9 70 ff ff ff       	jmp    17b7 <malloc+0x4e>
}
    1847:	c9                   	leave  
    1848:	c3                   	ret    
    1849:	66 90                	xchg   %ax,%ax
    184b:	90                   	nop

0000184c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1852:	8b 55 08             	mov    0x8(%ebp),%edx
    1855:	8b 45 0c             	mov    0xc(%ebp),%eax
    1858:	8b 4d 08             	mov    0x8(%ebp),%ecx
    185b:	f0 87 02             	lock xchg %eax,(%edx)
    185e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1861:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1864:	c9                   	leave  
    1865:	c3                   	ret    

00001866 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1866:	55                   	push   %ebp
    1867:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1869:	8b 45 08             	mov    0x8(%ebp),%eax
    186c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1872:	5d                   	pop    %ebp
    1873:	c3                   	ret    

00001874 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1874:	55                   	push   %ebp
    1875:	89 e5                	mov    %esp,%ebp
    1877:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    187a:	90                   	nop
    187b:	8b 45 08             	mov    0x8(%ebp),%eax
    187e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1885:	00 
    1886:	89 04 24             	mov    %eax,(%esp)
    1889:	e8 be ff ff ff       	call   184c <xchg>
    188e:	85 c0                	test   %eax,%eax
    1890:	75 e9                	jne    187b <lock_acquire+0x7>
}
    1892:	c9                   	leave  
    1893:	c3                   	ret    

00001894 <lock_release>:
void lock_release(lock_t *lock){
    1894:	55                   	push   %ebp
    1895:	89 e5                	mov    %esp,%ebp
    1897:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    189a:	8b 45 08             	mov    0x8(%ebp),%eax
    189d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18a4:	00 
    18a5:	89 04 24             	mov    %eax,(%esp)
    18a8:	e8 9f ff ff ff       	call   184c <xchg>
}
    18ad:	c9                   	leave  
    18ae:	c3                   	ret    

000018af <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18af:	55                   	push   %ebp
    18b0:	89 e5                	mov    %esp,%ebp
    18b2:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18b5:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18bc:	e8 a8 fe ff ff       	call   1769 <malloc>
    18c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cd:	25 ff 0f 00 00       	and    $0xfff,%eax
    18d2:	85 c0                	test   %eax,%eax
    18d4:	74 14                	je     18ea <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18de:	89 c2                	mov    %eax,%edx
    18e0:	b8 00 10 00 00       	mov    $0x1000,%eax
    18e5:	29 d0                	sub    %edx,%eax
    18e7:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18ee:	75 1b                	jne    190b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18f0:	c7 44 24 04 cd 1a 00 	movl   $0x1acd,0x4(%esp)
    18f7:	00 
    18f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18ff:	e8 78 fb ff ff       	call   147c <printf>
        return 0;
    1904:	b8 00 00 00 00       	mov    $0x0,%eax
    1909:	eb 6f                	jmp    197a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    190b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    190e:	8b 55 08             	mov    0x8(%ebp),%edx
    1911:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1914:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1918:	89 54 24 08          	mov    %edx,0x8(%esp)
    191c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1923:	00 
    1924:	89 04 24             	mov    %eax,(%esp)
    1927:	e8 48 fa ff ff       	call   1374 <clone>
    192c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    192f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1933:	79 1b                	jns    1950 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1935:	c7 44 24 04 db 1a 00 	movl   $0x1adb,0x4(%esp)
    193c:	00 
    193d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1944:	e8 33 fb ff ff       	call   147c <printf>
        return 0;
    1949:	b8 00 00 00 00       	mov    $0x0,%eax
    194e:	eb 2a                	jmp    197a <thread_create+0xcb>
    }
    if(tid > 0){
    1950:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1954:	7e 05                	jle    195b <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1956:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1959:	eb 1f                	jmp    197a <thread_create+0xcb>
    }
    if(tid == 0){
    195b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    195f:	75 14                	jne    1975 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1961:	c7 44 24 04 e8 1a 00 	movl   $0x1ae8,0x4(%esp)
    1968:	00 
    1969:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1970:	e8 07 fb ff ff       	call   147c <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1975:	b8 00 00 00 00       	mov    $0x0,%eax
}
    197a:	c9                   	leave  
    197b:	c3                   	ret    

0000197c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    197c:	55                   	push   %ebp
    197d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    197f:	a1 94 1e 00 00       	mov    0x1e94,%eax
    1984:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    198a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    198f:	a3 94 1e 00 00       	mov    %eax,0x1e94
    return (int)(rands % max);
    1994:	a1 94 1e 00 00       	mov    0x1e94,%eax
    1999:	8b 4d 08             	mov    0x8(%ebp),%ecx
    199c:	ba 00 00 00 00       	mov    $0x0,%edx
    19a1:	f7 f1                	div    %ecx
    19a3:	89 d0                	mov    %edx,%eax
}
    19a5:	5d                   	pop    %ebp
    19a6:	c3                   	ret    
    19a7:	90                   	nop

000019a8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19a8:	55                   	push   %ebp
    19a9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19ab:	8b 45 08             	mov    0x8(%ebp),%eax
    19ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19b4:	8b 45 08             	mov    0x8(%ebp),%eax
    19b7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19be:	8b 45 08             	mov    0x8(%ebp),%eax
    19c1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19c8:	5d                   	pop    %ebp
    19c9:	c3                   	ret    

000019ca <add_q>:

void add_q(struct queue *q, int v){
    19ca:	55                   	push   %ebp
    19cb:	89 e5                	mov    %esp,%ebp
    19cd:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19d0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19d7:	e8 8d fd ff ff       	call   1769 <malloc>
    19dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ec:	8b 55 0c             	mov    0xc(%ebp),%edx
    19ef:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19f1:	8b 45 08             	mov    0x8(%ebp),%eax
    19f4:	8b 40 04             	mov    0x4(%eax),%eax
    19f7:	85 c0                	test   %eax,%eax
    19f9:	75 0b                	jne    1a06 <add_q+0x3c>
        q->head = n;
    19fb:	8b 45 08             	mov    0x8(%ebp),%eax
    19fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a01:	89 50 04             	mov    %edx,0x4(%eax)
    1a04:	eb 0c                	jmp    1a12 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a06:	8b 45 08             	mov    0x8(%ebp),%eax
    1a09:	8b 40 08             	mov    0x8(%eax),%eax
    1a0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a18:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1e:	8b 00                	mov    (%eax),%eax
    1a20:	8d 50 01             	lea    0x1(%eax),%edx
    1a23:	8b 45 08             	mov    0x8(%ebp),%eax
    1a26:	89 10                	mov    %edx,(%eax)
}
    1a28:	c9                   	leave  
    1a29:	c3                   	ret    

00001a2a <empty_q>:

int empty_q(struct queue *q){
    1a2a:	55                   	push   %ebp
    1a2b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a30:	8b 00                	mov    (%eax),%eax
    1a32:	85 c0                	test   %eax,%eax
    1a34:	75 07                	jne    1a3d <empty_q+0x13>
        return 1;
    1a36:	b8 01 00 00 00       	mov    $0x1,%eax
    1a3b:	eb 05                	jmp    1a42 <empty_q+0x18>
    else
        return 0;
    1a3d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a42:	5d                   	pop    %ebp
    1a43:	c3                   	ret    

00001a44 <pop_q>:
int pop_q(struct queue *q){
    1a44:	55                   	push   %ebp
    1a45:	89 e5                	mov    %esp,%ebp
    1a47:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4d:	89 04 24             	mov    %eax,(%esp)
    1a50:	e8 d5 ff ff ff       	call   1a2a <empty_q>
    1a55:	85 c0                	test   %eax,%eax
    1a57:	75 5d                	jne    1ab6 <pop_q+0x72>
       val = q->head->value; 
    1a59:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5c:	8b 40 04             	mov    0x4(%eax),%eax
    1a5f:	8b 00                	mov    (%eax),%eax
    1a61:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a64:	8b 45 08             	mov    0x8(%ebp),%eax
    1a67:	8b 40 04             	mov    0x4(%eax),%eax
    1a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a70:	8b 40 04             	mov    0x4(%eax),%eax
    1a73:	8b 50 04             	mov    0x4(%eax),%edx
    1a76:	8b 45 08             	mov    0x8(%ebp),%eax
    1a79:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7f:	89 04 24             	mov    %eax,(%esp)
    1a82:	e8 a9 fb ff ff       	call   1630 <free>
       q->size--;
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	8b 00                	mov    (%eax),%eax
    1a8c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a94:	8b 45 08             	mov    0x8(%ebp),%eax
    1a97:	8b 00                	mov    (%eax),%eax
    1a99:	85 c0                	test   %eax,%eax
    1a9b:	75 14                	jne    1ab1 <pop_q+0x6d>
            q->head = 0;
    1a9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1aa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab4:	eb 05                	jmp    1abb <pop_q+0x77>
    }
    return -1;
    1ab6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1abb:	c9                   	leave  
    1abc:	c3                   	ret    
