
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
    1009:	e8 76 02 00 00       	call   1284 <fork>
    100e:	85 c0                	test   %eax,%eax
    1010:	7e 0c                	jle    101e <main+0x1e>
    sleep(5);  // Let child exit before parent.
    1012:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1019:	e8 fe 02 00 00       	call   131c <sleep>
  exit();
    101e:	e8 69 02 00 00       	call   128c <exit>
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
    1055:	90                   	nop
    1056:	8b 45 08             	mov    0x8(%ebp),%eax
    1059:	8d 50 01             	lea    0x1(%eax),%edx
    105c:	89 55 08             	mov    %edx,0x8(%ebp)
    105f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1062:	8d 4a 01             	lea    0x1(%edx),%ecx
    1065:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1068:	0f b6 12             	movzbl (%edx),%edx
    106b:	88 10                	mov    %dl,(%eax)
    106d:	0f b6 00             	movzbl (%eax),%eax
    1070:	84 c0                	test   %al,%al
    1072:	75 e2                	jne    1056 <strcpy+0xd>
    ;
  return os;
    1074:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1077:	c9                   	leave  
    1078:	c3                   	ret    

00001079 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1079:	55                   	push   %ebp
    107a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    107c:	eb 08                	jmp    1086 <strcmp+0xd>
    p++, q++;
    107e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1082:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	0f b6 00             	movzbl (%eax),%eax
    108c:	84 c0                	test   %al,%al
    108e:	74 10                	je     10a0 <strcmp+0x27>
    1090:	8b 45 08             	mov    0x8(%ebp),%eax
    1093:	0f b6 10             	movzbl (%eax),%edx
    1096:	8b 45 0c             	mov    0xc(%ebp),%eax
    1099:	0f b6 00             	movzbl (%eax),%eax
    109c:	38 c2                	cmp    %al,%dl
    109e:	74 de                	je     107e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10a0:	8b 45 08             	mov    0x8(%ebp),%eax
    10a3:	0f b6 00             	movzbl (%eax),%eax
    10a6:	0f b6 d0             	movzbl %al,%edx
    10a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ac:	0f b6 00             	movzbl (%eax),%eax
    10af:	0f b6 c0             	movzbl %al,%eax
    10b2:	29 c2                	sub    %eax,%edx
    10b4:	89 d0                	mov    %edx,%eax
}
    10b6:	5d                   	pop    %ebp
    10b7:	c3                   	ret    

000010b8 <strlen>:

uint
strlen(char *s)
{
    10b8:	55                   	push   %ebp
    10b9:	89 e5                	mov    %esp,%ebp
    10bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10c5:	eb 04                	jmp    10cb <strlen+0x13>
    10c7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	01 d0                	add    %edx,%eax
    10d3:	0f b6 00             	movzbl (%eax),%eax
    10d6:	84 c0                	test   %al,%al
    10d8:	75 ed                	jne    10c7 <strlen+0xf>
    ;
  return n;
    10da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10dd:	c9                   	leave  
    10de:	c3                   	ret    

000010df <memset>:

void*
memset(void *dst, int c, uint n)
{
    10df:	55                   	push   %ebp
    10e0:	89 e5                	mov    %esp,%ebp
    10e2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    10e5:	8b 45 10             	mov    0x10(%ebp),%eax
    10e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	89 04 24             	mov    %eax,(%esp)
    10f9:	e8 26 ff ff ff       	call   1024 <stosb>
  return dst;
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <strchr>:

char*
strchr(const char *s, char c)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 ec 04             	sub    $0x4,%esp
    1109:	8b 45 0c             	mov    0xc(%ebp),%eax
    110c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    110f:	eb 14                	jmp    1125 <strchr+0x22>
    if(*s == c)
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	0f b6 00             	movzbl (%eax),%eax
    1117:	3a 45 fc             	cmp    -0x4(%ebp),%al
    111a:	75 05                	jne    1121 <strchr+0x1e>
      return (char*)s;
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	eb 13                	jmp    1134 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	0f b6 00             	movzbl (%eax),%eax
    112b:	84 c0                	test   %al,%al
    112d:	75 e2                	jne    1111 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    112f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1134:	c9                   	leave  
    1135:	c3                   	ret    

00001136 <gets>:

char*
gets(char *buf, int max)
{
    1136:	55                   	push   %ebp
    1137:	89 e5                	mov    %esp,%ebp
    1139:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    113c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1143:	eb 4c                	jmp    1191 <gets+0x5b>
    cc = read(0, &c, 1);
    1145:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    114c:	00 
    114d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1150:	89 44 24 04          	mov    %eax,0x4(%esp)
    1154:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115b:	e8 44 01 00 00       	call   12a4 <read>
    1160:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1163:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1167:	7f 02                	jg     116b <gets+0x35>
      break;
    1169:	eb 31                	jmp    119c <gets+0x66>
    buf[i++] = c;
    116b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116e:	8d 50 01             	lea    0x1(%eax),%edx
    1171:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1174:	89 c2                	mov    %eax,%edx
    1176:	8b 45 08             	mov    0x8(%ebp),%eax
    1179:	01 c2                	add    %eax,%edx
    117b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    117f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1181:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1185:	3c 0a                	cmp    $0xa,%al
    1187:	74 13                	je     119c <gets+0x66>
    1189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    118d:	3c 0d                	cmp    $0xd,%al
    118f:	74 0b                	je     119c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1191:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1194:	83 c0 01             	add    $0x1,%eax
    1197:	3b 45 0c             	cmp    0xc(%ebp),%eax
    119a:	7c a9                	jl     1145 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    119c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
    11a2:	01 d0                	add    %edx,%eax
    11a4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11aa:	c9                   	leave  
    11ab:	c3                   	ret    

000011ac <stat>:

int
stat(char *n, struct stat *st)
{
    11ac:	55                   	push   %ebp
    11ad:	89 e5                	mov    %esp,%ebp
    11af:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11b2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11b9:	00 
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	89 04 24             	mov    %eax,(%esp)
    11c0:	e8 07 01 00 00       	call   12cc <open>
    11c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11cc:	79 07                	jns    11d5 <stat+0x29>
    return -1;
    11ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11d3:	eb 23                	jmp    11f8 <stat+0x4c>
  r = fstat(fd, st);
    11d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11df:	89 04 24             	mov    %eax,(%esp)
    11e2:	e8 fd 00 00 00       	call   12e4 <fstat>
    11e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    11ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ed:	89 04 24             	mov    %eax,(%esp)
    11f0:	e8 bf 00 00 00       	call   12b4 <close>
  return r;
    11f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    11f8:	c9                   	leave  
    11f9:	c3                   	ret    

000011fa <atoi>:

int
atoi(const char *s)
{
    11fa:	55                   	push   %ebp
    11fb:	89 e5                	mov    %esp,%ebp
    11fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1200:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1207:	eb 25                	jmp    122e <atoi+0x34>
    n = n*10 + *s++ - '0';
    1209:	8b 55 fc             	mov    -0x4(%ebp),%edx
    120c:	89 d0                	mov    %edx,%eax
    120e:	c1 e0 02             	shl    $0x2,%eax
    1211:	01 d0                	add    %edx,%eax
    1213:	01 c0                	add    %eax,%eax
    1215:	89 c1                	mov    %eax,%ecx
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	8d 50 01             	lea    0x1(%eax),%edx
    121d:	89 55 08             	mov    %edx,0x8(%ebp)
    1220:	0f b6 00             	movzbl (%eax),%eax
    1223:	0f be c0             	movsbl %al,%eax
    1226:	01 c8                	add    %ecx,%eax
    1228:	83 e8 30             	sub    $0x30,%eax
    122b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    122e:	8b 45 08             	mov    0x8(%ebp),%eax
    1231:	0f b6 00             	movzbl (%eax),%eax
    1234:	3c 2f                	cmp    $0x2f,%al
    1236:	7e 0a                	jle    1242 <atoi+0x48>
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	0f b6 00             	movzbl (%eax),%eax
    123e:	3c 39                	cmp    $0x39,%al
    1240:	7e c7                	jle    1209 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1242:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1245:	c9                   	leave  
    1246:	c3                   	ret    

00001247 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1247:	55                   	push   %ebp
    1248:	89 e5                	mov    %esp,%ebp
    124a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1253:	8b 45 0c             	mov    0xc(%ebp),%eax
    1256:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1259:	eb 17                	jmp    1272 <memmove+0x2b>
    *dst++ = *src++;
    125b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125e:	8d 50 01             	lea    0x1(%eax),%edx
    1261:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1264:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1267:	8d 4a 01             	lea    0x1(%edx),%ecx
    126a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    126d:	0f b6 12             	movzbl (%edx),%edx
    1270:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1272:	8b 45 10             	mov    0x10(%ebp),%eax
    1275:	8d 50 ff             	lea    -0x1(%eax),%edx
    1278:	89 55 10             	mov    %edx,0x10(%ebp)
    127b:	85 c0                	test   %eax,%eax
    127d:	7f dc                	jg     125b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1282:	c9                   	leave  
    1283:	c3                   	ret    

00001284 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1284:	b8 01 00 00 00       	mov    $0x1,%eax
    1289:	cd 40                	int    $0x40
    128b:	c3                   	ret    

0000128c <exit>:
SYSCALL(exit)
    128c:	b8 02 00 00 00       	mov    $0x2,%eax
    1291:	cd 40                	int    $0x40
    1293:	c3                   	ret    

00001294 <wait>:
SYSCALL(wait)
    1294:	b8 03 00 00 00       	mov    $0x3,%eax
    1299:	cd 40                	int    $0x40
    129b:	c3                   	ret    

0000129c <pipe>:
SYSCALL(pipe)
    129c:	b8 04 00 00 00       	mov    $0x4,%eax
    12a1:	cd 40                	int    $0x40
    12a3:	c3                   	ret    

000012a4 <read>:
SYSCALL(read)
    12a4:	b8 05 00 00 00       	mov    $0x5,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <write>:
SYSCALL(write)
    12ac:	b8 10 00 00 00       	mov    $0x10,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <close>:
SYSCALL(close)
    12b4:	b8 15 00 00 00       	mov    $0x15,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <kill>:
SYSCALL(kill)
    12bc:	b8 06 00 00 00       	mov    $0x6,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <exec>:
SYSCALL(exec)
    12c4:	b8 07 00 00 00       	mov    $0x7,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <open>:
SYSCALL(open)
    12cc:	b8 0f 00 00 00       	mov    $0xf,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <mknod>:
SYSCALL(mknod)
    12d4:	b8 11 00 00 00       	mov    $0x11,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <unlink>:
SYSCALL(unlink)
    12dc:	b8 12 00 00 00       	mov    $0x12,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <fstat>:
SYSCALL(fstat)
    12e4:	b8 08 00 00 00       	mov    $0x8,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <link>:
SYSCALL(link)
    12ec:	b8 13 00 00 00       	mov    $0x13,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <mkdir>:
SYSCALL(mkdir)
    12f4:	b8 14 00 00 00       	mov    $0x14,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <chdir>:
SYSCALL(chdir)
    12fc:	b8 09 00 00 00       	mov    $0x9,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <dup>:
SYSCALL(dup)
    1304:	b8 0a 00 00 00       	mov    $0xa,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <getpid>:
SYSCALL(getpid)
    130c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <sbrk>:
SYSCALL(sbrk)
    1314:	b8 0c 00 00 00       	mov    $0xc,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <sleep>:
SYSCALL(sleep)
    131c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <uptime>:
SYSCALL(uptime)
    1324:	b8 0e 00 00 00       	mov    $0xe,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <clone>:
SYSCALL(clone)
    132c:	b8 16 00 00 00       	mov    $0x16,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <texit>:
SYSCALL(texit)
    1334:	b8 17 00 00 00       	mov    $0x17,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <tsleep>:
SYSCALL(tsleep)
    133c:	b8 18 00 00 00       	mov    $0x18,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <twakeup>:
SYSCALL(twakeup)
    1344:	b8 19 00 00 00       	mov    $0x19,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <thread_yield>:
SYSCALL(thread_yield)
    134c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1354:	55                   	push   %ebp
    1355:	89 e5                	mov    %esp,%ebp
    1357:	83 ec 18             	sub    $0x18,%esp
    135a:	8b 45 0c             	mov    0xc(%ebp),%eax
    135d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1360:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1367:	00 
    1368:	8d 45 f4             	lea    -0xc(%ebp),%eax
    136b:	89 44 24 04          	mov    %eax,0x4(%esp)
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	89 04 24             	mov    %eax,(%esp)
    1375:	e8 32 ff ff ff       	call   12ac <write>
}
    137a:	c9                   	leave  
    137b:	c3                   	ret    

0000137c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    137c:	55                   	push   %ebp
    137d:	89 e5                	mov    %esp,%ebp
    137f:	56                   	push   %esi
    1380:	53                   	push   %ebx
    1381:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1384:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    138b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    138f:	74 17                	je     13a8 <printint+0x2c>
    1391:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1395:	79 11                	jns    13a8 <printint+0x2c>
    neg = 1;
    1397:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    139e:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a1:	f7 d8                	neg    %eax
    13a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13a6:	eb 06                	jmp    13ae <printint+0x32>
  } else {
    x = xx;
    13a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b8:	8d 41 01             	lea    0x1(%ecx),%eax
    13bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13be:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13c4:	ba 00 00 00 00       	mov    $0x0,%edx
    13c9:	f7 f3                	div    %ebx
    13cb:	89 d0                	mov    %edx,%eax
    13cd:	0f b6 80 2c 1e 00 00 	movzbl 0x1e2c(%eax),%eax
    13d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    13d8:	8b 75 10             	mov    0x10(%ebp),%esi
    13db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13de:	ba 00 00 00 00       	mov    $0x0,%edx
    13e3:	f7 f6                	div    %esi
    13e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13ec:	75 c7                	jne    13b5 <printint+0x39>
  if(neg)
    13ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13f2:	74 10                	je     1404 <printint+0x88>
    buf[i++] = '-';
    13f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f7:	8d 50 01             	lea    0x1(%eax),%edx
    13fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1402:	eb 1f                	jmp    1423 <printint+0xa7>
    1404:	eb 1d                	jmp    1423 <printint+0xa7>
    putc(fd, buf[i]);
    1406:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1409:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140c:	01 d0                	add    %edx,%eax
    140e:	0f b6 00             	movzbl (%eax),%eax
    1411:	0f be c0             	movsbl %al,%eax
    1414:	89 44 24 04          	mov    %eax,0x4(%esp)
    1418:	8b 45 08             	mov    0x8(%ebp),%eax
    141b:	89 04 24             	mov    %eax,(%esp)
    141e:	e8 31 ff ff ff       	call   1354 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1423:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1427:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    142b:	79 d9                	jns    1406 <printint+0x8a>
    putc(fd, buf[i]);
}
    142d:	83 c4 30             	add    $0x30,%esp
    1430:	5b                   	pop    %ebx
    1431:	5e                   	pop    %esi
    1432:	5d                   	pop    %ebp
    1433:	c3                   	ret    

00001434 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1434:	55                   	push   %ebp
    1435:	89 e5                	mov    %esp,%ebp
    1437:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    143a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1441:	8d 45 0c             	lea    0xc(%ebp),%eax
    1444:	83 c0 04             	add    $0x4,%eax
    1447:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    144a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1451:	e9 7c 01 00 00       	jmp    15d2 <printf+0x19e>
    c = fmt[i] & 0xff;
    1456:	8b 55 0c             	mov    0xc(%ebp),%edx
    1459:	8b 45 f0             	mov    -0x10(%ebp),%eax
    145c:	01 d0                	add    %edx,%eax
    145e:	0f b6 00             	movzbl (%eax),%eax
    1461:	0f be c0             	movsbl %al,%eax
    1464:	25 ff 00 00 00       	and    $0xff,%eax
    1469:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    146c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1470:	75 2c                	jne    149e <printf+0x6a>
      if(c == '%'){
    1472:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1476:	75 0c                	jne    1484 <printf+0x50>
        state = '%';
    1478:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    147f:	e9 4a 01 00 00       	jmp    15ce <printf+0x19a>
      } else {
        putc(fd, c);
    1484:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1487:	0f be c0             	movsbl %al,%eax
    148a:	89 44 24 04          	mov    %eax,0x4(%esp)
    148e:	8b 45 08             	mov    0x8(%ebp),%eax
    1491:	89 04 24             	mov    %eax,(%esp)
    1494:	e8 bb fe ff ff       	call   1354 <putc>
    1499:	e9 30 01 00 00       	jmp    15ce <printf+0x19a>
      }
    } else if(state == '%'){
    149e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14a2:	0f 85 26 01 00 00    	jne    15ce <printf+0x19a>
      if(c == 'd'){
    14a8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14ac:	75 2d                	jne    14db <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14b1:	8b 00                	mov    (%eax),%eax
    14b3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14ba:	00 
    14bb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14c2:	00 
    14c3:	89 44 24 04          	mov    %eax,0x4(%esp)
    14c7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ca:	89 04 24             	mov    %eax,(%esp)
    14cd:	e8 aa fe ff ff       	call   137c <printint>
        ap++;
    14d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14d6:	e9 ec 00 00 00       	jmp    15c7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    14db:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14df:	74 06                	je     14e7 <printf+0xb3>
    14e1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    14e5:	75 2d                	jne    1514 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    14e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ea:	8b 00                	mov    (%eax),%eax
    14ec:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14f3:	00 
    14f4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    14fb:	00 
    14fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1500:	8b 45 08             	mov    0x8(%ebp),%eax
    1503:	89 04 24             	mov    %eax,(%esp)
    1506:	e8 71 fe ff ff       	call   137c <printint>
        ap++;
    150b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    150f:	e9 b3 00 00 00       	jmp    15c7 <printf+0x193>
      } else if(c == 's'){
    1514:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1518:	75 45                	jne    155f <printf+0x12b>
        s = (char*)*ap;
    151a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151d:	8b 00                	mov    (%eax),%eax
    151f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1522:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1526:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    152a:	75 09                	jne    1535 <printf+0x101>
          s = "(null)";
    152c:	c7 45 f4 75 1a 00 00 	movl   $0x1a75,-0xc(%ebp)
        while(*s != 0){
    1533:	eb 1e                	jmp    1553 <printf+0x11f>
    1535:	eb 1c                	jmp    1553 <printf+0x11f>
          putc(fd, *s);
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	0f b6 00             	movzbl (%eax),%eax
    153d:	0f be c0             	movsbl %al,%eax
    1540:	89 44 24 04          	mov    %eax,0x4(%esp)
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	89 04 24             	mov    %eax,(%esp)
    154a:	e8 05 fe ff ff       	call   1354 <putc>
          s++;
    154f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1556:	0f b6 00             	movzbl (%eax),%eax
    1559:	84 c0                	test   %al,%al
    155b:	75 da                	jne    1537 <printf+0x103>
    155d:	eb 68                	jmp    15c7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    155f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1563:	75 1d                	jne    1582 <printf+0x14e>
        putc(fd, *ap);
    1565:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1568:	8b 00                	mov    (%eax),%eax
    156a:	0f be c0             	movsbl %al,%eax
    156d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1571:	8b 45 08             	mov    0x8(%ebp),%eax
    1574:	89 04 24             	mov    %eax,(%esp)
    1577:	e8 d8 fd ff ff       	call   1354 <putc>
        ap++;
    157c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1580:	eb 45                	jmp    15c7 <printf+0x193>
      } else if(c == '%'){
    1582:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1586:	75 17                	jne    159f <printf+0x16b>
        putc(fd, c);
    1588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    158b:	0f be c0             	movsbl %al,%eax
    158e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1592:	8b 45 08             	mov    0x8(%ebp),%eax
    1595:	89 04 24             	mov    %eax,(%esp)
    1598:	e8 b7 fd ff ff       	call   1354 <putc>
    159d:	eb 28                	jmp    15c7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    159f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15a6:	00 
    15a7:	8b 45 08             	mov    0x8(%ebp),%eax
    15aa:	89 04 24             	mov    %eax,(%esp)
    15ad:	e8 a2 fd ff ff       	call   1354 <putc>
        putc(fd, c);
    15b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15b5:	0f be c0             	movsbl %al,%eax
    15b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
    15bf:	89 04 24             	mov    %eax,(%esp)
    15c2:	e8 8d fd ff ff       	call   1354 <putc>
      }
      state = 0;
    15c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15ce:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    15d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d8:	01 d0                	add    %edx,%eax
    15da:	0f b6 00             	movzbl (%eax),%eax
    15dd:	84 c0                	test   %al,%al
    15df:	0f 85 71 fe ff ff    	jne    1456 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15e5:	c9                   	leave  
    15e6:	c3                   	ret    
    15e7:	90                   	nop

000015e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e8:	55                   	push   %ebp
    15e9:	89 e5                	mov    %esp,%ebp
    15eb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15ee:	8b 45 08             	mov    0x8(%ebp),%eax
    15f1:	83 e8 08             	sub    $0x8,%eax
    15f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f7:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    15fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15ff:	eb 24                	jmp    1625 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1601:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1604:	8b 00                	mov    (%eax),%eax
    1606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1609:	77 12                	ja     161d <free+0x35>
    160b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    160e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1611:	77 24                	ja     1637 <free+0x4f>
    1613:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1616:	8b 00                	mov    (%eax),%eax
    1618:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    161b:	77 1a                	ja     1637 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1620:	8b 00                	mov    (%eax),%eax
    1622:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1625:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1628:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    162b:	76 d4                	jbe    1601 <free+0x19>
    162d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1630:	8b 00                	mov    (%eax),%eax
    1632:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1635:	76 ca                	jbe    1601 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1637:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163a:	8b 40 04             	mov    0x4(%eax),%eax
    163d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1644:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1647:	01 c2                	add    %eax,%edx
    1649:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	39 c2                	cmp    %eax,%edx
    1650:	75 24                	jne    1676 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1652:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1655:	8b 50 04             	mov    0x4(%eax),%edx
    1658:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165b:	8b 00                	mov    (%eax),%eax
    165d:	8b 40 04             	mov    0x4(%eax),%eax
    1660:	01 c2                	add    %eax,%edx
    1662:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1665:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1668:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166b:	8b 00                	mov    (%eax),%eax
    166d:	8b 10                	mov    (%eax),%edx
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	89 10                	mov    %edx,(%eax)
    1674:	eb 0a                	jmp    1680 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1676:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1679:	8b 10                	mov    (%eax),%edx
    167b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1683:	8b 40 04             	mov    0x4(%eax),%eax
    1686:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	01 d0                	add    %edx,%eax
    1692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1695:	75 20                	jne    16b7 <free+0xcf>
    p->s.size += bp->s.size;
    1697:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169a:	8b 50 04             	mov    0x4(%eax),%edx
    169d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a0:	8b 40 04             	mov    0x4(%eax),%eax
    16a3:	01 c2                	add    %eax,%edx
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ae:	8b 10                	mov    (%eax),%edx
    16b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b3:	89 10                	mov    %edx,(%eax)
    16b5:	eb 08                	jmp    16bf <free+0xd7>
  } else
    p->s.ptr = bp;
    16b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16bd:	89 10                	mov    %edx,(%eax)
  freep = p;
    16bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c2:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
}
    16c7:	c9                   	leave  
    16c8:	c3                   	ret    

000016c9 <morecore>:

static Header*
morecore(uint nu)
{
    16c9:	55                   	push   %ebp
    16ca:	89 e5                	mov    %esp,%ebp
    16cc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16cf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16d6:	77 07                	ja     16df <morecore+0x16>
    nu = 4096;
    16d8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16df:	8b 45 08             	mov    0x8(%ebp),%eax
    16e2:	c1 e0 03             	shl    $0x3,%eax
    16e5:	89 04 24             	mov    %eax,(%esp)
    16e8:	e8 27 fc ff ff       	call   1314 <sbrk>
    16ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    16f0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    16f4:	75 07                	jne    16fd <morecore+0x34>
    return 0;
    16f6:	b8 00 00 00 00       	mov    $0x0,%eax
    16fb:	eb 22                	jmp    171f <morecore+0x56>
  hp = (Header*)p;
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1703:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1706:	8b 55 08             	mov    0x8(%ebp),%edx
    1709:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    170c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    170f:	83 c0 08             	add    $0x8,%eax
    1712:	89 04 24             	mov    %eax,(%esp)
    1715:	e8 ce fe ff ff       	call   15e8 <free>
  return freep;
    171a:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
}
    171f:	c9                   	leave  
    1720:	c3                   	ret    

00001721 <malloc>:

void*
malloc(uint nbytes)
{
    1721:	55                   	push   %ebp
    1722:	89 e5                	mov    %esp,%ebp
    1724:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1727:	8b 45 08             	mov    0x8(%ebp),%eax
    172a:	83 c0 07             	add    $0x7,%eax
    172d:	c1 e8 03             	shr    $0x3,%eax
    1730:	83 c0 01             	add    $0x1,%eax
    1733:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1736:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    173b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    173e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1742:	75 23                	jne    1767 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1744:	c7 45 f0 44 1e 00 00 	movl   $0x1e44,-0x10(%ebp)
    174b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    174e:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
    1753:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    1758:	a3 44 1e 00 00       	mov    %eax,0x1e44
    base.s.size = 0;
    175d:	c7 05 48 1e 00 00 00 	movl   $0x0,0x1e48
    1764:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1767:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176a:	8b 00                	mov    (%eax),%eax
    176c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    176f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1772:	8b 40 04             	mov    0x4(%eax),%eax
    1775:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1778:	72 4d                	jb     17c7 <malloc+0xa6>
      if(p->s.size == nunits)
    177a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177d:	8b 40 04             	mov    0x4(%eax),%eax
    1780:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1783:	75 0c                	jne    1791 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1785:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1788:	8b 10                	mov    (%eax),%edx
    178a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178d:	89 10                	mov    %edx,(%eax)
    178f:	eb 26                	jmp    17b7 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	8b 40 04             	mov    0x4(%eax),%eax
    1797:	2b 45 ec             	sub    -0x14(%ebp),%eax
    179a:	89 c2                	mov    %eax,%edx
    179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	8b 40 04             	mov    0x4(%eax),%eax
    17a8:	c1 e0 03             	shl    $0x3,%eax
    17ab:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17b4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ba:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
      return (void*)(p + 1);
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	83 c0 08             	add    $0x8,%eax
    17c5:	eb 38                	jmp    17ff <malloc+0xde>
    }
    if(p == freep)
    17c7:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    17cc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17cf:	75 1b                	jne    17ec <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    17d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d4:	89 04 24             	mov    %eax,(%esp)
    17d7:	e8 ed fe ff ff       	call   16c9 <morecore>
    17dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17e3:	75 07                	jne    17ec <malloc+0xcb>
        return 0;
    17e5:	b8 00 00 00 00       	mov    $0x0,%eax
    17ea:	eb 13                	jmp    17ff <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	8b 00                	mov    (%eax),%eax
    17f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    17fa:	e9 70 ff ff ff       	jmp    176f <malloc+0x4e>
}
    17ff:	c9                   	leave  
    1800:	c3                   	ret    
    1801:	66 90                	xchg   %ax,%ax
    1803:	90                   	nop

00001804 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1804:	55                   	push   %ebp
    1805:	89 e5                	mov    %esp,%ebp
    1807:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    180a:	8b 55 08             	mov    0x8(%ebp),%edx
    180d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1810:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1813:	f0 87 02             	lock xchg %eax,(%edx)
    1816:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1819:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    181c:	c9                   	leave  
    181d:	c3                   	ret    

0000181e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    181e:	55                   	push   %ebp
    181f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1821:	8b 45 08             	mov    0x8(%ebp),%eax
    1824:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    182a:	5d                   	pop    %ebp
    182b:	c3                   	ret    

0000182c <lock_acquire>:
void lock_acquire(lock_t *lock){
    182c:	55                   	push   %ebp
    182d:	89 e5                	mov    %esp,%ebp
    182f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1832:	90                   	nop
    1833:	8b 45 08             	mov    0x8(%ebp),%eax
    1836:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    183d:	00 
    183e:	89 04 24             	mov    %eax,(%esp)
    1841:	e8 be ff ff ff       	call   1804 <xchg>
    1846:	85 c0                	test   %eax,%eax
    1848:	75 e9                	jne    1833 <lock_acquire+0x7>
}
    184a:	c9                   	leave  
    184b:	c3                   	ret    

0000184c <lock_release>:
void lock_release(lock_t *lock){
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    185c:	00 
    185d:	89 04 24             	mov    %eax,(%esp)
    1860:	e8 9f ff ff ff       	call   1804 <xchg>
}
    1865:	c9                   	leave  
    1866:	c3                   	ret    

00001867 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1867:	55                   	push   %ebp
    1868:	89 e5                	mov    %esp,%ebp
    186a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    186d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1874:	e8 a8 fe ff ff       	call   1721 <malloc>
    1879:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1882:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1885:	25 ff 0f 00 00       	and    $0xfff,%eax
    188a:	85 c0                	test   %eax,%eax
    188c:	74 14                	je     18a2 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	25 ff 0f 00 00       	and    $0xfff,%eax
    1896:	89 c2                	mov    %eax,%edx
    1898:	b8 00 10 00 00       	mov    $0x1000,%eax
    189d:	29 d0                	sub    %edx,%eax
    189f:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18a6:	75 1b                	jne    18c3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18a8:	c7 44 24 04 7c 1a 00 	movl   $0x1a7c,0x4(%esp)
    18af:	00 
    18b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18b7:	e8 78 fb ff ff       	call   1434 <printf>
        return 0;
    18bc:	b8 00 00 00 00       	mov    $0x0,%eax
    18c1:	eb 6f                	jmp    1932 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18c6:	8b 55 08             	mov    0x8(%ebp),%edx
    18c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18d0:	89 54 24 08          	mov    %edx,0x8(%esp)
    18d4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18db:	00 
    18dc:	89 04 24             	mov    %eax,(%esp)
    18df:	e8 48 fa ff ff       	call   132c <clone>
    18e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18eb:	79 1b                	jns    1908 <thread_create+0xa1>
        printf(1,"clone fails\n");
    18ed:	c7 44 24 04 8a 1a 00 	movl   $0x1a8a,0x4(%esp)
    18f4:	00 
    18f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fc:	e8 33 fb ff ff       	call   1434 <printf>
        return 0;
    1901:	b8 00 00 00 00       	mov    $0x0,%eax
    1906:	eb 2a                	jmp    1932 <thread_create+0xcb>
    }
    if(tid > 0){
    1908:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    190c:	7e 05                	jle    1913 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    190e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1911:	eb 1f                	jmp    1932 <thread_create+0xcb>
    }
    if(tid == 0){
    1913:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1917:	75 14                	jne    192d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1919:	c7 44 24 04 97 1a 00 	movl   $0x1a97,0x4(%esp)
    1920:	00 
    1921:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1928:	e8 07 fb ff ff       	call   1434 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    192d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1932:	c9                   	leave  
    1933:	c3                   	ret    

00001934 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1934:	55                   	push   %ebp
    1935:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1937:	a1 40 1e 00 00       	mov    0x1e40,%eax
    193c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1942:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1947:	a3 40 1e 00 00       	mov    %eax,0x1e40
    return (int)(rands % max);
    194c:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1951:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1954:	ba 00 00 00 00       	mov    $0x0,%edx
    1959:	f7 f1                	div    %ecx
    195b:	89 d0                	mov    %edx,%eax
}
    195d:	5d                   	pop    %ebp
    195e:	c3                   	ret    
    195f:	90                   	nop

00001960 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1960:	55                   	push   %ebp
    1961:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1963:	8b 45 08             	mov    0x8(%ebp),%eax
    1966:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    196c:	8b 45 08             	mov    0x8(%ebp),%eax
    196f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1976:	8b 45 08             	mov    0x8(%ebp),%eax
    1979:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1980:	5d                   	pop    %ebp
    1981:	c3                   	ret    

00001982 <add_q>:

void add_q(struct queue *q, int v){
    1982:	55                   	push   %ebp
    1983:	89 e5                	mov    %esp,%ebp
    1985:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1988:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    198f:	e8 8d fd ff ff       	call   1721 <malloc>
    1994:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1997:	8b 45 f4             	mov    -0xc(%ebp),%eax
    199a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19a7:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	8b 40 04             	mov    0x4(%eax),%eax
    19af:	85 c0                	test   %eax,%eax
    19b1:	75 0b                	jne    19be <add_q+0x3c>
        q->head = n;
    19b3:	8b 45 08             	mov    0x8(%ebp),%eax
    19b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19b9:	89 50 04             	mov    %edx,0x4(%eax)
    19bc:	eb 0c                	jmp    19ca <add_q+0x48>
    }else{
        q->tail->next = n;
    19be:	8b 45 08             	mov    0x8(%ebp),%eax
    19c1:	8b 40 08             	mov    0x8(%eax),%eax
    19c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19c7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19d0:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19d3:	8b 45 08             	mov    0x8(%ebp),%eax
    19d6:	8b 00                	mov    (%eax),%eax
    19d8:	8d 50 01             	lea    0x1(%eax),%edx
    19db:	8b 45 08             	mov    0x8(%ebp),%eax
    19de:	89 10                	mov    %edx,(%eax)
}
    19e0:	c9                   	leave  
    19e1:	c3                   	ret    

000019e2 <empty_q>:

int empty_q(struct queue *q){
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19e5:	8b 45 08             	mov    0x8(%ebp),%eax
    19e8:	8b 00                	mov    (%eax),%eax
    19ea:	85 c0                	test   %eax,%eax
    19ec:	75 07                	jne    19f5 <empty_q+0x13>
        return 1;
    19ee:	b8 01 00 00 00       	mov    $0x1,%eax
    19f3:	eb 05                	jmp    19fa <empty_q+0x18>
    else
        return 0;
    19f5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    19fa:	5d                   	pop    %ebp
    19fb:	c3                   	ret    

000019fc <pop_q>:
int pop_q(struct queue *q){
    19fc:	55                   	push   %ebp
    19fd:	89 e5                	mov    %esp,%ebp
    19ff:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	89 04 24             	mov    %eax,(%esp)
    1a08:	e8 d5 ff ff ff       	call   19e2 <empty_q>
    1a0d:	85 c0                	test   %eax,%eax
    1a0f:	75 5d                	jne    1a6e <pop_q+0x72>
       val = q->head->value; 
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 40 04             	mov    0x4(%eax),%eax
    1a17:	8b 00                	mov    (%eax),%eax
    1a19:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	8b 40 04             	mov    0x4(%eax),%eax
    1a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a25:	8b 45 08             	mov    0x8(%ebp),%eax
    1a28:	8b 40 04             	mov    0x4(%eax),%eax
    1a2b:	8b 50 04             	mov    0x4(%eax),%edx
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a34:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a37:	89 04 24             	mov    %eax,(%esp)
    1a3a:	e8 a9 fb ff ff       	call   15e8 <free>
       q->size--;
    1a3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a42:	8b 00                	mov    (%eax),%eax
    1a44:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	8b 00                	mov    (%eax),%eax
    1a51:	85 c0                	test   %eax,%eax
    1a53:	75 14                	jne    1a69 <pop_q+0x6d>
            q->head = 0;
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a62:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a6c:	eb 05                	jmp    1a73 <pop_q+0x77>
    }
    return -1;
    1a6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a73:	c9                   	leave  
    1a74:	c3                   	ret    
