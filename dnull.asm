
_dnull:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int *null = 0;
    1009:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1010:	00 
  printf(1,"Dereferencing Null Pointer\n");
    1011:	c7 44 24 04 99 1a 00 	movl   $0x1a99,0x4(%esp)
    1018:	00 
    1019:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1020:	e8 33 04 00 00       	call   1458 <printf>
  printf(1,"%d\n", *null);
    1025:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1029:	8b 00                	mov    (%eax),%eax
    102b:	89 44 24 08          	mov    %eax,0x8(%esp)
    102f:	c7 44 24 04 b5 1a 00 	movl   $0x1ab5,0x4(%esp)
    1036:	00 
    1037:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103e:	e8 15 04 00 00       	call   1458 <printf>

  exit();
    1043:	e8 68 02 00 00       	call   12b0 <exit>

00001048 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1048:	55                   	push   %ebp
    1049:	89 e5                	mov    %esp,%ebp
    104b:	57                   	push   %edi
    104c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    104d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1050:	8b 55 10             	mov    0x10(%ebp),%edx
    1053:	8b 45 0c             	mov    0xc(%ebp),%eax
    1056:	89 cb                	mov    %ecx,%ebx
    1058:	89 df                	mov    %ebx,%edi
    105a:	89 d1                	mov    %edx,%ecx
    105c:	fc                   	cld    
    105d:	f3 aa                	rep stos %al,%es:(%edi)
    105f:	89 ca                	mov    %ecx,%edx
    1061:	89 fb                	mov    %edi,%ebx
    1063:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1066:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1069:	5b                   	pop    %ebx
    106a:	5f                   	pop    %edi
    106b:	5d                   	pop    %ebp
    106c:	c3                   	ret    

0000106d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    106d:	55                   	push   %ebp
    106e:	89 e5                	mov    %esp,%ebp
    1070:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1073:	8b 45 08             	mov    0x8(%ebp),%eax
    1076:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1079:	90                   	nop
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	8d 50 01             	lea    0x1(%eax),%edx
    1080:	89 55 08             	mov    %edx,0x8(%ebp)
    1083:	8b 55 0c             	mov    0xc(%ebp),%edx
    1086:	8d 4a 01             	lea    0x1(%edx),%ecx
    1089:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    108c:	0f b6 12             	movzbl (%edx),%edx
    108f:	88 10                	mov    %dl,(%eax)
    1091:	0f b6 00             	movzbl (%eax),%eax
    1094:	84 c0                	test   %al,%al
    1096:	75 e2                	jne    107a <strcpy+0xd>
    ;
  return os;
    1098:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    109b:	c9                   	leave  
    109c:	c3                   	ret    

0000109d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    109d:	55                   	push   %ebp
    109e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10a0:	eb 08                	jmp    10aa <strcmp+0xd>
    p++, q++;
    10a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10a6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10aa:	8b 45 08             	mov    0x8(%ebp),%eax
    10ad:	0f b6 00             	movzbl (%eax),%eax
    10b0:	84 c0                	test   %al,%al
    10b2:	74 10                	je     10c4 <strcmp+0x27>
    10b4:	8b 45 08             	mov    0x8(%ebp),%eax
    10b7:	0f b6 10             	movzbl (%eax),%edx
    10ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    10bd:	0f b6 00             	movzbl (%eax),%eax
    10c0:	38 c2                	cmp    %al,%dl
    10c2:	74 de                	je     10a2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	0f b6 00             	movzbl (%eax),%eax
    10ca:	0f b6 d0             	movzbl %al,%edx
    10cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d0:	0f b6 00             	movzbl (%eax),%eax
    10d3:	0f b6 c0             	movzbl %al,%eax
    10d6:	29 c2                	sub    %eax,%edx
    10d8:	89 d0                	mov    %edx,%eax
}
    10da:	5d                   	pop    %ebp
    10db:	c3                   	ret    

000010dc <strlen>:

uint
strlen(char *s)
{
    10dc:	55                   	push   %ebp
    10dd:	89 e5                	mov    %esp,%ebp
    10df:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10e9:	eb 04                	jmp    10ef <strlen+0x13>
    10eb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	01 d0                	add    %edx,%eax
    10f7:	0f b6 00             	movzbl (%eax),%eax
    10fa:	84 c0                	test   %al,%al
    10fc:	75 ed                	jne    10eb <strlen+0xf>
    ;
  return n;
    10fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1109:	8b 45 10             	mov    0x10(%ebp),%eax
    110c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1110:	8b 45 0c             	mov    0xc(%ebp),%eax
    1113:	89 44 24 04          	mov    %eax,0x4(%esp)
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	89 04 24             	mov    %eax,(%esp)
    111d:	e8 26 ff ff ff       	call   1048 <stosb>
  return dst;
    1122:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1125:	c9                   	leave  
    1126:	c3                   	ret    

00001127 <strchr>:

char*
strchr(const char *s, char c)
{
    1127:	55                   	push   %ebp
    1128:	89 e5                	mov    %esp,%ebp
    112a:	83 ec 04             	sub    $0x4,%esp
    112d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1130:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1133:	eb 14                	jmp    1149 <strchr+0x22>
    if(*s == c)
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	0f b6 00             	movzbl (%eax),%eax
    113b:	3a 45 fc             	cmp    -0x4(%ebp),%al
    113e:	75 05                	jne    1145 <strchr+0x1e>
      return (char*)s;
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	eb 13                	jmp    1158 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1145:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	0f b6 00             	movzbl (%eax),%eax
    114f:	84 c0                	test   %al,%al
    1151:	75 e2                	jne    1135 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1153:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1158:	c9                   	leave  
    1159:	c3                   	ret    

0000115a <gets>:

char*
gets(char *buf, int max)
{
    115a:	55                   	push   %ebp
    115b:	89 e5                	mov    %esp,%ebp
    115d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1160:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1167:	eb 4c                	jmp    11b5 <gets+0x5b>
    cc = read(0, &c, 1);
    1169:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1170:	00 
    1171:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1174:	89 44 24 04          	mov    %eax,0x4(%esp)
    1178:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    117f:	e8 44 01 00 00       	call   12c8 <read>
    1184:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1187:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    118b:	7f 02                	jg     118f <gets+0x35>
      break;
    118d:	eb 31                	jmp    11c0 <gets+0x66>
    buf[i++] = c;
    118f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1192:	8d 50 01             	lea    0x1(%eax),%edx
    1195:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1198:	89 c2                	mov    %eax,%edx
    119a:	8b 45 08             	mov    0x8(%ebp),%eax
    119d:	01 c2                	add    %eax,%edx
    119f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a9:	3c 0a                	cmp    $0xa,%al
    11ab:	74 13                	je     11c0 <gets+0x66>
    11ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b1:	3c 0d                	cmp    $0xd,%al
    11b3:	74 0b                	je     11c0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b8:	83 c0 01             	add    $0x1,%eax
    11bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11be:	7c a9                	jl     1169 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11c3:	8b 45 08             	mov    0x8(%ebp),%eax
    11c6:	01 d0                	add    %edx,%eax
    11c8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ce:	c9                   	leave  
    11cf:	c3                   	ret    

000011d0 <stat>:

int
stat(char *n, struct stat *st)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11dd:	00 
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	89 04 24             	mov    %eax,(%esp)
    11e4:	e8 07 01 00 00       	call   12f0 <open>
    11e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11f0:	79 07                	jns    11f9 <stat+0x29>
    return -1;
    11f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11f7:	eb 23                	jmp    121c <stat+0x4c>
  r = fstat(fd, st);
    11f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1200:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1203:	89 04 24             	mov    %eax,(%esp)
    1206:	e8 fd 00 00 00       	call   1308 <fstat>
    120b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    120e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1211:	89 04 24             	mov    %eax,(%esp)
    1214:	e8 bf 00 00 00       	call   12d8 <close>
  return r;
    1219:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    121c:	c9                   	leave  
    121d:	c3                   	ret    

0000121e <atoi>:

int
atoi(const char *s)
{
    121e:	55                   	push   %ebp
    121f:	89 e5                	mov    %esp,%ebp
    1221:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1224:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    122b:	eb 25                	jmp    1252 <atoi+0x34>
    n = n*10 + *s++ - '0';
    122d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1230:	89 d0                	mov    %edx,%eax
    1232:	c1 e0 02             	shl    $0x2,%eax
    1235:	01 d0                	add    %edx,%eax
    1237:	01 c0                	add    %eax,%eax
    1239:	89 c1                	mov    %eax,%ecx
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	8d 50 01             	lea    0x1(%eax),%edx
    1241:	89 55 08             	mov    %edx,0x8(%ebp)
    1244:	0f b6 00             	movzbl (%eax),%eax
    1247:	0f be c0             	movsbl %al,%eax
    124a:	01 c8                	add    %ecx,%eax
    124c:	83 e8 30             	sub    $0x30,%eax
    124f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1252:	8b 45 08             	mov    0x8(%ebp),%eax
    1255:	0f b6 00             	movzbl (%eax),%eax
    1258:	3c 2f                	cmp    $0x2f,%al
    125a:	7e 0a                	jle    1266 <atoi+0x48>
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	0f b6 00             	movzbl (%eax),%eax
    1262:	3c 39                	cmp    $0x39,%al
    1264:	7e c7                	jle    122d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1266:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1269:	c9                   	leave  
    126a:	c3                   	ret    

0000126b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    126b:	55                   	push   %ebp
    126c:	89 e5                	mov    %esp,%ebp
    126e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1271:	8b 45 08             	mov    0x8(%ebp),%eax
    1274:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1277:	8b 45 0c             	mov    0xc(%ebp),%eax
    127a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    127d:	eb 17                	jmp    1296 <memmove+0x2b>
    *dst++ = *src++;
    127f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1282:	8d 50 01             	lea    0x1(%eax),%edx
    1285:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1288:	8b 55 f8             	mov    -0x8(%ebp),%edx
    128b:	8d 4a 01             	lea    0x1(%edx),%ecx
    128e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1291:	0f b6 12             	movzbl (%edx),%edx
    1294:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1296:	8b 45 10             	mov    0x10(%ebp),%eax
    1299:	8d 50 ff             	lea    -0x1(%eax),%edx
    129c:	89 55 10             	mov    %edx,0x10(%ebp)
    129f:	85 c0                	test   %eax,%eax
    12a1:	7f dc                	jg     127f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a6:	c9                   	leave  
    12a7:	c3                   	ret    

000012a8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12a8:	b8 01 00 00 00       	mov    $0x1,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <exit>:
SYSCALL(exit)
    12b0:	b8 02 00 00 00       	mov    $0x2,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <wait>:
SYSCALL(wait)
    12b8:	b8 03 00 00 00       	mov    $0x3,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <pipe>:
SYSCALL(pipe)
    12c0:	b8 04 00 00 00       	mov    $0x4,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <read>:
SYSCALL(read)
    12c8:	b8 05 00 00 00       	mov    $0x5,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <write>:
SYSCALL(write)
    12d0:	b8 10 00 00 00       	mov    $0x10,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <close>:
SYSCALL(close)
    12d8:	b8 15 00 00 00       	mov    $0x15,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <kill>:
SYSCALL(kill)
    12e0:	b8 06 00 00 00       	mov    $0x6,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <exec>:
SYSCALL(exec)
    12e8:	b8 07 00 00 00       	mov    $0x7,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <open>:
SYSCALL(open)
    12f0:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <mknod>:
SYSCALL(mknod)
    12f8:	b8 11 00 00 00       	mov    $0x11,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <unlink>:
SYSCALL(unlink)
    1300:	b8 12 00 00 00       	mov    $0x12,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <fstat>:
SYSCALL(fstat)
    1308:	b8 08 00 00 00       	mov    $0x8,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <link>:
SYSCALL(link)
    1310:	b8 13 00 00 00       	mov    $0x13,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <mkdir>:
SYSCALL(mkdir)
    1318:	b8 14 00 00 00       	mov    $0x14,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <chdir>:
SYSCALL(chdir)
    1320:	b8 09 00 00 00       	mov    $0x9,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <dup>:
SYSCALL(dup)
    1328:	b8 0a 00 00 00       	mov    $0xa,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <getpid>:
SYSCALL(getpid)
    1330:	b8 0b 00 00 00       	mov    $0xb,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <sbrk>:
SYSCALL(sbrk)
    1338:	b8 0c 00 00 00       	mov    $0xc,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <sleep>:
SYSCALL(sleep)
    1340:	b8 0d 00 00 00       	mov    $0xd,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <uptime>:
SYSCALL(uptime)
    1348:	b8 0e 00 00 00       	mov    $0xe,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <clone>:
SYSCALL(clone)
    1350:	b8 16 00 00 00       	mov    $0x16,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <texit>:
SYSCALL(texit)
    1358:	b8 17 00 00 00       	mov    $0x17,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <tsleep>:
SYSCALL(tsleep)
    1360:	b8 18 00 00 00       	mov    $0x18,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <twakeup>:
SYSCALL(twakeup)
    1368:	b8 19 00 00 00       	mov    $0x19,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <thread_yield>:
SYSCALL(thread_yield)
    1370:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1378:	55                   	push   %ebp
    1379:	89 e5                	mov    %esp,%ebp
    137b:	83 ec 18             	sub    $0x18,%esp
    137e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1381:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1384:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    138b:	00 
    138c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    138f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1393:	8b 45 08             	mov    0x8(%ebp),%eax
    1396:	89 04 24             	mov    %eax,(%esp)
    1399:	e8 32 ff ff ff       	call   12d0 <write>
}
    139e:	c9                   	leave  
    139f:	c3                   	ret    

000013a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	56                   	push   %esi
    13a4:	53                   	push   %ebx
    13a5:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13af:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13b3:	74 17                	je     13cc <printint+0x2c>
    13b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13b9:	79 11                	jns    13cc <printint+0x2c>
    neg = 1;
    13bb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c5:	f7 d8                	neg    %eax
    13c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13ca:	eb 06                	jmp    13d2 <printint+0x32>
  } else {
    x = xx;
    13cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13d9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13dc:	8d 41 01             	lea    0x1(%ecx),%eax
    13df:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e8:	ba 00 00 00 00       	mov    $0x0,%edx
    13ed:	f7 f3                	div    %ebx
    13ef:	89 d0                	mov    %edx,%eax
    13f1:	0f b6 80 70 1e 00 00 	movzbl 0x1e70(%eax),%eax
    13f8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    13fc:	8b 75 10             	mov    0x10(%ebp),%esi
    13ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1402:	ba 00 00 00 00       	mov    $0x0,%edx
    1407:	f7 f6                	div    %esi
    1409:	89 45 ec             	mov    %eax,-0x14(%ebp)
    140c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1410:	75 c7                	jne    13d9 <printint+0x39>
  if(neg)
    1412:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1416:	74 10                	je     1428 <printint+0x88>
    buf[i++] = '-';
    1418:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141b:	8d 50 01             	lea    0x1(%eax),%edx
    141e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1421:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1426:	eb 1f                	jmp    1447 <printint+0xa7>
    1428:	eb 1d                	jmp    1447 <printint+0xa7>
    putc(fd, buf[i]);
    142a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    142d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1430:	01 d0                	add    %edx,%eax
    1432:	0f b6 00             	movzbl (%eax),%eax
    1435:	0f be c0             	movsbl %al,%eax
    1438:	89 44 24 04          	mov    %eax,0x4(%esp)
    143c:	8b 45 08             	mov    0x8(%ebp),%eax
    143f:	89 04 24             	mov    %eax,(%esp)
    1442:	e8 31 ff ff ff       	call   1378 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1447:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    144b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    144f:	79 d9                	jns    142a <printint+0x8a>
    putc(fd, buf[i]);
}
    1451:	83 c4 30             	add    $0x30,%esp
    1454:	5b                   	pop    %ebx
    1455:	5e                   	pop    %esi
    1456:	5d                   	pop    %ebp
    1457:	c3                   	ret    

00001458 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1458:	55                   	push   %ebp
    1459:	89 e5                	mov    %esp,%ebp
    145b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    145e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1465:	8d 45 0c             	lea    0xc(%ebp),%eax
    1468:	83 c0 04             	add    $0x4,%eax
    146b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    146e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1475:	e9 7c 01 00 00       	jmp    15f6 <printf+0x19e>
    c = fmt[i] & 0xff;
    147a:	8b 55 0c             	mov    0xc(%ebp),%edx
    147d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1480:	01 d0                	add    %edx,%eax
    1482:	0f b6 00             	movzbl (%eax),%eax
    1485:	0f be c0             	movsbl %al,%eax
    1488:	25 ff 00 00 00       	and    $0xff,%eax
    148d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1490:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1494:	75 2c                	jne    14c2 <printf+0x6a>
      if(c == '%'){
    1496:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    149a:	75 0c                	jne    14a8 <printf+0x50>
        state = '%';
    149c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14a3:	e9 4a 01 00 00       	jmp    15f2 <printf+0x19a>
      } else {
        putc(fd, c);
    14a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14ab:	0f be c0             	movsbl %al,%eax
    14ae:	89 44 24 04          	mov    %eax,0x4(%esp)
    14b2:	8b 45 08             	mov    0x8(%ebp),%eax
    14b5:	89 04 24             	mov    %eax,(%esp)
    14b8:	e8 bb fe ff ff       	call   1378 <putc>
    14bd:	e9 30 01 00 00       	jmp    15f2 <printf+0x19a>
      }
    } else if(state == '%'){
    14c2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14c6:	0f 85 26 01 00 00    	jne    15f2 <printf+0x19a>
      if(c == 'd'){
    14cc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14d0:	75 2d                	jne    14ff <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14d5:	8b 00                	mov    (%eax),%eax
    14d7:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14de:	00 
    14df:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14e6:	00 
    14e7:	89 44 24 04          	mov    %eax,0x4(%esp)
    14eb:	8b 45 08             	mov    0x8(%ebp),%eax
    14ee:	89 04 24             	mov    %eax,(%esp)
    14f1:	e8 aa fe ff ff       	call   13a0 <printint>
        ap++;
    14f6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14fa:	e9 ec 00 00 00       	jmp    15eb <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    14ff:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1503:	74 06                	je     150b <printf+0xb3>
    1505:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1509:	75 2d                	jne    1538 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    150b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    150e:	8b 00                	mov    (%eax),%eax
    1510:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1517:	00 
    1518:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    151f:	00 
    1520:	89 44 24 04          	mov    %eax,0x4(%esp)
    1524:	8b 45 08             	mov    0x8(%ebp),%eax
    1527:	89 04 24             	mov    %eax,(%esp)
    152a:	e8 71 fe ff ff       	call   13a0 <printint>
        ap++;
    152f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1533:	e9 b3 00 00 00       	jmp    15eb <printf+0x193>
      } else if(c == 's'){
    1538:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    153c:	75 45                	jne    1583 <printf+0x12b>
        s = (char*)*ap;
    153e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1541:	8b 00                	mov    (%eax),%eax
    1543:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1546:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    154a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    154e:	75 09                	jne    1559 <printf+0x101>
          s = "(null)";
    1550:	c7 45 f4 b9 1a 00 00 	movl   $0x1ab9,-0xc(%ebp)
        while(*s != 0){
    1557:	eb 1e                	jmp    1577 <printf+0x11f>
    1559:	eb 1c                	jmp    1577 <printf+0x11f>
          putc(fd, *s);
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	0f b6 00             	movzbl (%eax),%eax
    1561:	0f be c0             	movsbl %al,%eax
    1564:	89 44 24 04          	mov    %eax,0x4(%esp)
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	89 04 24             	mov    %eax,(%esp)
    156e:	e8 05 fe ff ff       	call   1378 <putc>
          s++;
    1573:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1577:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157a:	0f b6 00             	movzbl (%eax),%eax
    157d:	84 c0                	test   %al,%al
    157f:	75 da                	jne    155b <printf+0x103>
    1581:	eb 68                	jmp    15eb <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1583:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1587:	75 1d                	jne    15a6 <printf+0x14e>
        putc(fd, *ap);
    1589:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158c:	8b 00                	mov    (%eax),%eax
    158e:	0f be c0             	movsbl %al,%eax
    1591:	89 44 24 04          	mov    %eax,0x4(%esp)
    1595:	8b 45 08             	mov    0x8(%ebp),%eax
    1598:	89 04 24             	mov    %eax,(%esp)
    159b:	e8 d8 fd ff ff       	call   1378 <putc>
        ap++;
    15a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15a4:	eb 45                	jmp    15eb <printf+0x193>
      } else if(c == '%'){
    15a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15aa:	75 17                	jne    15c3 <printf+0x16b>
        putc(fd, c);
    15ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15af:	0f be c0             	movsbl %al,%eax
    15b2:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b6:	8b 45 08             	mov    0x8(%ebp),%eax
    15b9:	89 04 24             	mov    %eax,(%esp)
    15bc:	e8 b7 fd ff ff       	call   1378 <putc>
    15c1:	eb 28                	jmp    15eb <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15c3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15ca:	00 
    15cb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ce:	89 04 24             	mov    %eax,(%esp)
    15d1:	e8 a2 fd ff ff       	call   1378 <putc>
        putc(fd, c);
    15d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d9:	0f be c0             	movsbl %al,%eax
    15dc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e0:	8b 45 08             	mov    0x8(%ebp),%eax
    15e3:	89 04 24             	mov    %eax,(%esp)
    15e6:	e8 8d fd ff ff       	call   1378 <putc>
      }
      state = 0;
    15eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15f2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15fc:	01 d0                	add    %edx,%eax
    15fe:	0f b6 00             	movzbl (%eax),%eax
    1601:	84 c0                	test   %al,%al
    1603:	0f 85 71 fe ff ff    	jne    147a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1609:	c9                   	leave  
    160a:	c3                   	ret    
    160b:	90                   	nop

0000160c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    160c:	55                   	push   %ebp
    160d:	89 e5                	mov    %esp,%ebp
    160f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1612:	8b 45 08             	mov    0x8(%ebp),%eax
    1615:	83 e8 08             	sub    $0x8,%eax
    1618:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    161b:	a1 90 1e 00 00       	mov    0x1e90,%eax
    1620:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1623:	eb 24                	jmp    1649 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1625:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1628:	8b 00                	mov    (%eax),%eax
    162a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    162d:	77 12                	ja     1641 <free+0x35>
    162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1632:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1635:	77 24                	ja     165b <free+0x4f>
    1637:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163a:	8b 00                	mov    (%eax),%eax
    163c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    163f:	77 1a                	ja     165b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1641:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1644:	8b 00                	mov    (%eax),%eax
    1646:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1649:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    164f:	76 d4                	jbe    1625 <free+0x19>
    1651:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1654:	8b 00                	mov    (%eax),%eax
    1656:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1659:	76 ca                	jbe    1625 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    165b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165e:	8b 40 04             	mov    0x4(%eax),%eax
    1661:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1668:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166b:	01 c2                	add    %eax,%edx
    166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	39 c2                	cmp    %eax,%edx
    1674:	75 24                	jne    169a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1676:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1679:	8b 50 04             	mov    0x4(%eax),%edx
    167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167f:	8b 00                	mov    (%eax),%eax
    1681:	8b 40 04             	mov    0x4(%eax),%eax
    1684:	01 c2                	add    %eax,%edx
    1686:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1689:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    168c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168f:	8b 00                	mov    (%eax),%eax
    1691:	8b 10                	mov    (%eax),%edx
    1693:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1696:	89 10                	mov    %edx,(%eax)
    1698:	eb 0a                	jmp    16a4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    169a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169d:	8b 10                	mov    (%eax),%edx
    169f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a7:	8b 40 04             	mov    0x4(%eax),%eax
    16aa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b4:	01 d0                	add    %edx,%eax
    16b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16b9:	75 20                	jne    16db <free+0xcf>
    p->s.size += bp->s.size;
    16bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16be:	8b 50 04             	mov    0x4(%eax),%edx
    16c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c4:	8b 40 04             	mov    0x4(%eax),%eax
    16c7:	01 c2                	add    %eax,%edx
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	8b 10                	mov    (%eax),%edx
    16d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d7:	89 10                	mov    %edx,(%eax)
    16d9:	eb 08                	jmp    16e3 <free+0xd7>
  } else
    p->s.ptr = bp;
    16db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16de:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16e1:	89 10                	mov    %edx,(%eax)
  freep = p;
    16e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e6:	a3 90 1e 00 00       	mov    %eax,0x1e90
}
    16eb:	c9                   	leave  
    16ec:	c3                   	ret    

000016ed <morecore>:

static Header*
morecore(uint nu)
{
    16ed:	55                   	push   %ebp
    16ee:	89 e5                	mov    %esp,%ebp
    16f0:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16f3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16fa:	77 07                	ja     1703 <morecore+0x16>
    nu = 4096;
    16fc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1703:	8b 45 08             	mov    0x8(%ebp),%eax
    1706:	c1 e0 03             	shl    $0x3,%eax
    1709:	89 04 24             	mov    %eax,(%esp)
    170c:	e8 27 fc ff ff       	call   1338 <sbrk>
    1711:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1714:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1718:	75 07                	jne    1721 <morecore+0x34>
    return 0;
    171a:	b8 00 00 00 00       	mov    $0x0,%eax
    171f:	eb 22                	jmp    1743 <morecore+0x56>
  hp = (Header*)p;
    1721:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1724:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1727:	8b 45 f0             	mov    -0x10(%ebp),%eax
    172a:	8b 55 08             	mov    0x8(%ebp),%edx
    172d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1730:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1733:	83 c0 08             	add    $0x8,%eax
    1736:	89 04 24             	mov    %eax,(%esp)
    1739:	e8 ce fe ff ff       	call   160c <free>
  return freep;
    173e:	a1 90 1e 00 00       	mov    0x1e90,%eax
}
    1743:	c9                   	leave  
    1744:	c3                   	ret    

00001745 <malloc>:

void*
malloc(uint nbytes)
{
    1745:	55                   	push   %ebp
    1746:	89 e5                	mov    %esp,%ebp
    1748:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	83 c0 07             	add    $0x7,%eax
    1751:	c1 e8 03             	shr    $0x3,%eax
    1754:	83 c0 01             	add    $0x1,%eax
    1757:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    175a:	a1 90 1e 00 00       	mov    0x1e90,%eax
    175f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1762:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1766:	75 23                	jne    178b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1768:	c7 45 f0 88 1e 00 00 	movl   $0x1e88,-0x10(%ebp)
    176f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1772:	a3 90 1e 00 00       	mov    %eax,0x1e90
    1777:	a1 90 1e 00 00       	mov    0x1e90,%eax
    177c:	a3 88 1e 00 00       	mov    %eax,0x1e88
    base.s.size = 0;
    1781:	c7 05 8c 1e 00 00 00 	movl   $0x0,0x1e8c
    1788:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    178b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178e:	8b 00                	mov    (%eax),%eax
    1790:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1793:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1796:	8b 40 04             	mov    0x4(%eax),%eax
    1799:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    179c:	72 4d                	jb     17eb <malloc+0xa6>
      if(p->s.size == nunits)
    179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a1:	8b 40 04             	mov    0x4(%eax),%eax
    17a4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17a7:	75 0c                	jne    17b5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ac:	8b 10                	mov    (%eax),%edx
    17ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b1:	89 10                	mov    %edx,(%eax)
    17b3:	eb 26                	jmp    17db <malloc+0x96>
      else {
        p->s.size -= nunits;
    17b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b8:	8b 40 04             	mov    0x4(%eax),%eax
    17bb:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17be:	89 c2                	mov    %eax,%edx
    17c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c9:	8b 40 04             	mov    0x4(%eax),%eax
    17cc:	c1 e0 03             	shl    $0x3,%eax
    17cf:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17de:	a3 90 1e 00 00       	mov    %eax,0x1e90
      return (void*)(p + 1);
    17e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e6:	83 c0 08             	add    $0x8,%eax
    17e9:	eb 38                	jmp    1823 <malloc+0xde>
    }
    if(p == freep)
    17eb:	a1 90 1e 00 00       	mov    0x1e90,%eax
    17f0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17f3:	75 1b                	jne    1810 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    17f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f8:	89 04 24             	mov    %eax,(%esp)
    17fb:	e8 ed fe ff ff       	call   16ed <morecore>
    1800:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1803:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1807:	75 07                	jne    1810 <malloc+0xcb>
        return 0;
    1809:	b8 00 00 00 00       	mov    $0x0,%eax
    180e:	eb 13                	jmp    1823 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1810:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1813:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1816:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1819:	8b 00                	mov    (%eax),%eax
    181b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    181e:	e9 70 ff ff ff       	jmp    1793 <malloc+0x4e>
}
    1823:	c9                   	leave  
    1824:	c3                   	ret    
    1825:	66 90                	xchg   %ax,%ax
    1827:	90                   	nop

00001828 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1828:	55                   	push   %ebp
    1829:	89 e5                	mov    %esp,%ebp
    182b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    182e:	8b 55 08             	mov    0x8(%ebp),%edx
    1831:	8b 45 0c             	mov    0xc(%ebp),%eax
    1834:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1837:	f0 87 02             	lock xchg %eax,(%edx)
    183a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    183d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1840:	c9                   	leave  
    1841:	c3                   	ret    

00001842 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1842:	55                   	push   %ebp
    1843:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    184e:	5d                   	pop    %ebp
    184f:	c3                   	ret    

00001850 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1856:	90                   	nop
    1857:	8b 45 08             	mov    0x8(%ebp),%eax
    185a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1861:	00 
    1862:	89 04 24             	mov    %eax,(%esp)
    1865:	e8 be ff ff ff       	call   1828 <xchg>
    186a:	85 c0                	test   %eax,%eax
    186c:	75 e9                	jne    1857 <lock_acquire+0x7>
}
    186e:	c9                   	leave  
    186f:	c3                   	ret    

00001870 <lock_release>:
void lock_release(lock_t *lock){
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1880:	00 
    1881:	89 04 24             	mov    %eax,(%esp)
    1884:	e8 9f ff ff ff       	call   1828 <xchg>
}
    1889:	c9                   	leave  
    188a:	c3                   	ret    

0000188b <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    188b:	55                   	push   %ebp
    188c:	89 e5                	mov    %esp,%ebp
    188e:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1891:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1898:	e8 a8 fe ff ff       	call   1745 <malloc>
    189d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ae:	85 c0                	test   %eax,%eax
    18b0:	74 14                	je     18c6 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b5:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ba:	89 c2                	mov    %eax,%edx
    18bc:	b8 00 10 00 00       	mov    $0x1000,%eax
    18c1:	29 d0                	sub    %edx,%eax
    18c3:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18ca:	75 1b                	jne    18e7 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18cc:	c7 44 24 04 c0 1a 00 	movl   $0x1ac0,0x4(%esp)
    18d3:	00 
    18d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18db:	e8 78 fb ff ff       	call   1458 <printf>
        return 0;
    18e0:	b8 00 00 00 00       	mov    $0x0,%eax
    18e5:	eb 6f                	jmp    1956 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18ea:	8b 55 08             	mov    0x8(%ebp),%edx
    18ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18f4:	89 54 24 08          	mov    %edx,0x8(%esp)
    18f8:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18ff:	00 
    1900:	89 04 24             	mov    %eax,(%esp)
    1903:	e8 48 fa ff ff       	call   1350 <clone>
    1908:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    190b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    190f:	79 1b                	jns    192c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1911:	c7 44 24 04 ce 1a 00 	movl   $0x1ace,0x4(%esp)
    1918:	00 
    1919:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1920:	e8 33 fb ff ff       	call   1458 <printf>
        return 0;
    1925:	b8 00 00 00 00       	mov    $0x0,%eax
    192a:	eb 2a                	jmp    1956 <thread_create+0xcb>
    }
    if(tid > 0){
    192c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1930:	7e 05                	jle    1937 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1932:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1935:	eb 1f                	jmp    1956 <thread_create+0xcb>
    }
    if(tid == 0){
    1937:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193b:	75 14                	jne    1951 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    193d:	c7 44 24 04 db 1a 00 	movl   $0x1adb,0x4(%esp)
    1944:	00 
    1945:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    194c:	e8 07 fb ff ff       	call   1458 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1951:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1956:	c9                   	leave  
    1957:	c3                   	ret    

00001958 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1958:	55                   	push   %ebp
    1959:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    195b:	a1 84 1e 00 00       	mov    0x1e84,%eax
    1960:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1966:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    196b:	a3 84 1e 00 00       	mov    %eax,0x1e84
    return (int)(rands % max);
    1970:	a1 84 1e 00 00       	mov    0x1e84,%eax
    1975:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1978:	ba 00 00 00 00       	mov    $0x0,%edx
    197d:	f7 f1                	div    %ecx
    197f:	89 d0                	mov    %edx,%eax
}
    1981:	5d                   	pop    %ebp
    1982:	c3                   	ret    
    1983:	90                   	nop

00001984 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1984:	55                   	push   %ebp
    1985:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1987:	8b 45 08             	mov    0x8(%ebp),%eax
    198a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1990:	8b 45 08             	mov    0x8(%ebp),%eax
    1993:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19a4:	5d                   	pop    %ebp
    19a5:	c3                   	ret    

000019a6 <add_q>:

void add_q(struct queue *q, int v){
    19a6:	55                   	push   %ebp
    19a7:	89 e5                	mov    %esp,%ebp
    19a9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19ac:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19b3:	e8 8d fd ff ff       	call   1745 <malloc>
    19b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19be:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19cb:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19cd:	8b 45 08             	mov    0x8(%ebp),%eax
    19d0:	8b 40 04             	mov    0x4(%eax),%eax
    19d3:	85 c0                	test   %eax,%eax
    19d5:	75 0b                	jne    19e2 <add_q+0x3c>
        q->head = n;
    19d7:	8b 45 08             	mov    0x8(%ebp),%eax
    19da:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19dd:	89 50 04             	mov    %edx,0x4(%eax)
    19e0:	eb 0c                	jmp    19ee <add_q+0x48>
    }else{
        q->tail->next = n;
    19e2:	8b 45 08             	mov    0x8(%ebp),%eax
    19e5:	8b 40 08             	mov    0x8(%eax),%eax
    19e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19eb:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19f4:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19f7:	8b 45 08             	mov    0x8(%ebp),%eax
    19fa:	8b 00                	mov    (%eax),%eax
    19fc:	8d 50 01             	lea    0x1(%eax),%edx
    19ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1a02:	89 10                	mov    %edx,(%eax)
}
    1a04:	c9                   	leave  
    1a05:	c3                   	ret    

00001a06 <empty_q>:

int empty_q(struct queue *q){
    1a06:	55                   	push   %ebp
    1a07:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a09:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0c:	8b 00                	mov    (%eax),%eax
    1a0e:	85 c0                	test   %eax,%eax
    1a10:	75 07                	jne    1a19 <empty_q+0x13>
        return 1;
    1a12:	b8 01 00 00 00       	mov    $0x1,%eax
    1a17:	eb 05                	jmp    1a1e <empty_q+0x18>
    else
        return 0;
    1a19:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a1e:	5d                   	pop    %ebp
    1a1f:	c3                   	ret    

00001a20 <pop_q>:
int pop_q(struct queue *q){
    1a20:	55                   	push   %ebp
    1a21:	89 e5                	mov    %esp,%ebp
    1a23:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a26:	8b 45 08             	mov    0x8(%ebp),%eax
    1a29:	89 04 24             	mov    %eax,(%esp)
    1a2c:	e8 d5 ff ff ff       	call   1a06 <empty_q>
    1a31:	85 c0                	test   %eax,%eax
    1a33:	75 5d                	jne    1a92 <pop_q+0x72>
       val = q->head->value; 
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	8b 40 04             	mov    0x4(%eax),%eax
    1a3b:	8b 00                	mov    (%eax),%eax
    1a3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a40:	8b 45 08             	mov    0x8(%ebp),%eax
    1a43:	8b 40 04             	mov    0x4(%eax),%eax
    1a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a49:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4c:	8b 40 04             	mov    0x4(%eax),%eax
    1a4f:	8b 50 04             	mov    0x4(%eax),%edx
    1a52:	8b 45 08             	mov    0x8(%ebp),%eax
    1a55:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a5b:	89 04 24             	mov    %eax,(%esp)
    1a5e:	e8 a9 fb ff ff       	call   160c <free>
       q->size--;
    1a63:	8b 45 08             	mov    0x8(%ebp),%eax
    1a66:	8b 00                	mov    (%eax),%eax
    1a68:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 00                	mov    (%eax),%eax
    1a75:	85 c0                	test   %eax,%eax
    1a77:	75 14                	jne    1a8d <pop_q+0x6d>
            q->head = 0;
    1a79:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a83:	8b 45 08             	mov    0x8(%ebp),%eax
    1a86:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a90:	eb 05                	jmp    1a97 <pop_q+0x77>
    }
    return -1;
    1a92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a97:	c9                   	leave  
    1a98:	c3                   	ret    
