
_mkdir:     file format elf32-i386


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

  if(argc < 2){
    1009:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    100d:	7f 19                	jg     1028 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
    100f:	c7 44 24 04 c1 1a 00 	movl   $0x1ac1,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 66 04 00 00       	call   1489 <printf>
    exit();
    1023:	e8 c0 02 00 00       	call   12e8 <exit>
  }

  for(i = 1; i < argc; i++){
    1028:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    102f:	00 
    1030:	eb 43                	jmp    1075 <main+0x75>
    if(mkdir(argv[i]) < 0){
    1032:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1036:	c1 e0 02             	shl    $0x2,%eax
    1039:	03 45 0c             	add    0xc(%ebp),%eax
    103c:	8b 00                	mov    (%eax),%eax
    103e:	89 04 24             	mov    %eax,(%esp)
    1041:	e8 0a 03 00 00       	call   1350 <mkdir>
    1046:	85 c0                	test   %eax,%eax
    1048:	79 26                	jns    1070 <main+0x70>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
    104a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    104e:	c1 e0 02             	shl    $0x2,%eax
    1051:	03 45 0c             	add    0xc(%ebp),%eax
    1054:	8b 00                	mov    (%eax),%eax
    1056:	89 44 24 08          	mov    %eax,0x8(%esp)
    105a:	c7 44 24 04 d8 1a 00 	movl   $0x1ad8,0x4(%esp)
    1061:	00 
    1062:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1069:	e8 1b 04 00 00       	call   1489 <printf>
      break;
    106e:	eb 0e                	jmp    107e <main+0x7e>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    1070:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1075:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1079:	3b 45 08             	cmp    0x8(%ebp),%eax
    107c:	7c b4                	jl     1032 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
    107e:	e8 65 02 00 00       	call   12e8 <exit>
    1083:	90                   	nop

00001084 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	57                   	push   %edi
    1088:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1089:	8b 4d 08             	mov    0x8(%ebp),%ecx
    108c:	8b 55 10             	mov    0x10(%ebp),%edx
    108f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1092:	89 cb                	mov    %ecx,%ebx
    1094:	89 df                	mov    %ebx,%edi
    1096:	89 d1                	mov    %edx,%ecx
    1098:	fc                   	cld    
    1099:	f3 aa                	rep stos %al,%es:(%edi)
    109b:	89 ca                	mov    %ecx,%edx
    109d:	89 fb                	mov    %edi,%ebx
    109f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10a2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10a5:	5b                   	pop    %ebx
    10a6:	5f                   	pop    %edi
    10a7:	5d                   	pop    %ebp
    10a8:	c3                   	ret    

000010a9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10a9:	55                   	push   %ebp
    10aa:	89 e5                	mov    %esp,%ebp
    10ac:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10af:	8b 45 08             	mov    0x8(%ebp),%eax
    10b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b8:	0f b6 10             	movzbl (%eax),%edx
    10bb:	8b 45 08             	mov    0x8(%ebp),%eax
    10be:	88 10                	mov    %dl,(%eax)
    10c0:	8b 45 08             	mov    0x8(%ebp),%eax
    10c3:	0f b6 00             	movzbl (%eax),%eax
    10c6:	84 c0                	test   %al,%al
    10c8:	0f 95 c0             	setne  %al
    10cb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10cf:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10d3:	84 c0                	test   %al,%al
    10d5:	75 de                	jne    10b5 <strcpy+0xc>
    ;
  return os;
    10d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10da:	c9                   	leave  
    10db:	c3                   	ret    

000010dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10dc:	55                   	push   %ebp
    10dd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10df:	eb 08                	jmp    10e9 <strcmp+0xd>
    p++, q++;
    10e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10e5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10e9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ec:	0f b6 00             	movzbl (%eax),%eax
    10ef:	84 c0                	test   %al,%al
    10f1:	74 10                	je     1103 <strcmp+0x27>
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	0f b6 10             	movzbl (%eax),%edx
    10f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fc:	0f b6 00             	movzbl (%eax),%eax
    10ff:	38 c2                	cmp    %al,%dl
    1101:	74 de                	je     10e1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1103:	8b 45 08             	mov    0x8(%ebp),%eax
    1106:	0f b6 00             	movzbl (%eax),%eax
    1109:	0f b6 d0             	movzbl %al,%edx
    110c:	8b 45 0c             	mov    0xc(%ebp),%eax
    110f:	0f b6 00             	movzbl (%eax),%eax
    1112:	0f b6 c0             	movzbl %al,%eax
    1115:	89 d1                	mov    %edx,%ecx
    1117:	29 c1                	sub    %eax,%ecx
    1119:	89 c8                	mov    %ecx,%eax
}
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    

0000111d <strlen>:

uint
strlen(char *s)
{
    111d:	55                   	push   %ebp
    111e:	89 e5                	mov    %esp,%ebp
    1120:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1123:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    112a:	eb 04                	jmp    1130 <strlen+0x13>
    112c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1130:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1133:	03 45 08             	add    0x8(%ebp),%eax
    1136:	0f b6 00             	movzbl (%eax),%eax
    1139:	84 c0                	test   %al,%al
    113b:	75 ef                	jne    112c <strlen+0xf>
    ;
  return n;
    113d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1140:	c9                   	leave  
    1141:	c3                   	ret    

00001142 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1142:	55                   	push   %ebp
    1143:	89 e5                	mov    %esp,%ebp
    1145:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1148:	8b 45 10             	mov    0x10(%ebp),%eax
    114b:	89 44 24 08          	mov    %eax,0x8(%esp)
    114f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1152:	89 44 24 04          	mov    %eax,0x4(%esp)
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
    1159:	89 04 24             	mov    %eax,(%esp)
    115c:	e8 23 ff ff ff       	call   1084 <stosb>
  return dst;
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1164:	c9                   	leave  
    1165:	c3                   	ret    

00001166 <strchr>:

char*
strchr(const char *s, char c)
{
    1166:	55                   	push   %ebp
    1167:	89 e5                	mov    %esp,%ebp
    1169:	83 ec 04             	sub    $0x4,%esp
    116c:	8b 45 0c             	mov    0xc(%ebp),%eax
    116f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1172:	eb 14                	jmp    1188 <strchr+0x22>
    if(*s == c)
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	0f b6 00             	movzbl (%eax),%eax
    117a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    117d:	75 05                	jne    1184 <strchr+0x1e>
      return (char*)s;
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	eb 13                	jmp    1197 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	0f b6 00             	movzbl (%eax),%eax
    118e:	84 c0                	test   %al,%al
    1190:	75 e2                	jne    1174 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1192:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1197:	c9                   	leave  
    1198:	c3                   	ret    

00001199 <gets>:

char*
gets(char *buf, int max)
{
    1199:	55                   	push   %ebp
    119a:	89 e5                	mov    %esp,%ebp
    119c:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    119f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11a6:	eb 44                	jmp    11ec <gets+0x53>
    cc = read(0, &c, 1);
    11a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11af:	00 
    11b0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    11b7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11be:	e8 3d 01 00 00       	call   1300 <read>
    11c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    11c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ca:	7e 2d                	jle    11f9 <gets+0x60>
      break;
    buf[i++] = c;
    11cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11cf:	03 45 08             	add    0x8(%ebp),%eax
    11d2:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11d6:	88 10                	mov    %dl,(%eax)
    11d8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    11dc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e0:	3c 0a                	cmp    $0xa,%al
    11e2:	74 16                	je     11fa <gets+0x61>
    11e4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e8:	3c 0d                	cmp    $0xd,%al
    11ea:	74 0e                	je     11fa <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ef:	83 c0 01             	add    $0x1,%eax
    11f2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f5:	7c b1                	jl     11a8 <gets+0xf>
    11f7:	eb 01                	jmp    11fa <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    11f9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11fd:	03 45 08             	add    0x8(%ebp),%eax
    1200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1206:	c9                   	leave  
    1207:	c3                   	ret    

00001208 <stat>:

int
stat(char *n, struct stat *st)
{
    1208:	55                   	push   %ebp
    1209:	89 e5                	mov    %esp,%ebp
    120b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    120e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1215:	00 
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	89 04 24             	mov    %eax,(%esp)
    121c:	e8 07 01 00 00       	call   1328 <open>
    1221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1224:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1228:	79 07                	jns    1231 <stat+0x29>
    return -1;
    122a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    122f:	eb 23                	jmp    1254 <stat+0x4c>
  r = fstat(fd, st);
    1231:	8b 45 0c             	mov    0xc(%ebp),%eax
    1234:	89 44 24 04          	mov    %eax,0x4(%esp)
    1238:	8b 45 f0             	mov    -0x10(%ebp),%eax
    123b:	89 04 24             	mov    %eax,(%esp)
    123e:	e8 fd 00 00 00       	call   1340 <fstat>
    1243:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1246:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1249:	89 04 24             	mov    %eax,(%esp)
    124c:	e8 bf 00 00 00       	call   1310 <close>
  return r;
    1251:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1254:	c9                   	leave  
    1255:	c3                   	ret    

00001256 <atoi>:

int
atoi(const char *s)
{
    1256:	55                   	push   %ebp
    1257:	89 e5                	mov    %esp,%ebp
    1259:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    125c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1263:	eb 24                	jmp    1289 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1265:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1268:	89 d0                	mov    %edx,%eax
    126a:	c1 e0 02             	shl    $0x2,%eax
    126d:	01 d0                	add    %edx,%eax
    126f:	01 c0                	add    %eax,%eax
    1271:	89 c2                	mov    %eax,%edx
    1273:	8b 45 08             	mov    0x8(%ebp),%eax
    1276:	0f b6 00             	movzbl (%eax),%eax
    1279:	0f be c0             	movsbl %al,%eax
    127c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    127f:	83 e8 30             	sub    $0x30,%eax
    1282:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1285:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	0f b6 00             	movzbl (%eax),%eax
    128f:	3c 2f                	cmp    $0x2f,%al
    1291:	7e 0a                	jle    129d <atoi+0x47>
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	0f b6 00             	movzbl (%eax),%eax
    1299:	3c 39                	cmp    $0x39,%al
    129b:	7e c8                	jle    1265 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    129d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12a0:	c9                   	leave  
    12a1:	c3                   	ret    

000012a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12a2:	55                   	push   %ebp
    12a3:	89 e5                	mov    %esp,%ebp
    12a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    12ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    12b4:	eb 13                	jmp    12c9 <memmove+0x27>
    *dst++ = *src++;
    12b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b9:	0f b6 10             	movzbl (%eax),%edx
    12bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12bf:	88 10                	mov    %dl,(%eax)
    12c1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12c5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12cd:	0f 9f c0             	setg   %al
    12d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12d4:	84 c0                	test   %al,%al
    12d6:	75 de                	jne    12b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12db:	c9                   	leave  
    12dc:	c3                   	ret    
    12dd:	90                   	nop
    12de:	90                   	nop
    12df:	90                   	nop

000012e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12e0:	b8 01 00 00 00       	mov    $0x1,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <exit>:
SYSCALL(exit)
    12e8:	b8 02 00 00 00       	mov    $0x2,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <wait>:
SYSCALL(wait)
    12f0:	b8 03 00 00 00       	mov    $0x3,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <pipe>:
SYSCALL(pipe)
    12f8:	b8 04 00 00 00       	mov    $0x4,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <read>:
SYSCALL(read)
    1300:	b8 05 00 00 00       	mov    $0x5,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <write>:
SYSCALL(write)
    1308:	b8 10 00 00 00       	mov    $0x10,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <close>:
SYSCALL(close)
    1310:	b8 15 00 00 00       	mov    $0x15,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <kill>:
SYSCALL(kill)
    1318:	b8 06 00 00 00       	mov    $0x6,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <exec>:
SYSCALL(exec)
    1320:	b8 07 00 00 00       	mov    $0x7,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <open>:
SYSCALL(open)
    1328:	b8 0f 00 00 00       	mov    $0xf,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <mknod>:
SYSCALL(mknod)
    1330:	b8 11 00 00 00       	mov    $0x11,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <unlink>:
SYSCALL(unlink)
    1338:	b8 12 00 00 00       	mov    $0x12,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <fstat>:
SYSCALL(fstat)
    1340:	b8 08 00 00 00       	mov    $0x8,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <link>:
SYSCALL(link)
    1348:	b8 13 00 00 00       	mov    $0x13,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <mkdir>:
SYSCALL(mkdir)
    1350:	b8 14 00 00 00       	mov    $0x14,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <chdir>:
SYSCALL(chdir)
    1358:	b8 09 00 00 00       	mov    $0x9,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <dup>:
SYSCALL(dup)
    1360:	b8 0a 00 00 00       	mov    $0xa,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <getpid>:
SYSCALL(getpid)
    1368:	b8 0b 00 00 00       	mov    $0xb,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <sbrk>:
SYSCALL(sbrk)
    1370:	b8 0c 00 00 00       	mov    $0xc,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <sleep>:
SYSCALL(sleep)
    1378:	b8 0d 00 00 00       	mov    $0xd,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <uptime>:
SYSCALL(uptime)
    1380:	b8 0e 00 00 00       	mov    $0xe,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <clone>:
SYSCALL(clone)
    1388:	b8 16 00 00 00       	mov    $0x16,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <texit>:
SYSCALL(texit)
    1390:	b8 17 00 00 00       	mov    $0x17,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <tsleep>:
SYSCALL(tsleep)
    1398:	b8 18 00 00 00       	mov    $0x18,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <twakeup>:
SYSCALL(twakeup)
    13a0:	b8 19 00 00 00       	mov    $0x19,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <thread_yield>:
SYSCALL(thread_yield)
    13a8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	83 ec 28             	sub    $0x28,%esp
    13b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13c3:	00 
    13c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13c7:	89 44 24 04          	mov    %eax,0x4(%esp)
    13cb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ce:	89 04 24             	mov    %eax,(%esp)
    13d1:	e8 32 ff ff ff       	call   1308 <write>
}
    13d6:	c9                   	leave  
    13d7:	c3                   	ret    

000013d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13d8:	55                   	push   %ebp
    13d9:	89 e5                	mov    %esp,%ebp
    13db:	53                   	push   %ebx
    13dc:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13e6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ea:	74 17                	je     1403 <printint+0x2b>
    13ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f0:	79 11                	jns    1403 <printint+0x2b>
    neg = 1;
    13f2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fc:	f7 d8                	neg    %eax
    13fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1401:	eb 06                	jmp    1409 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1403:	8b 45 0c             	mov    0xc(%ebp),%eax
    1406:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1409:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1410:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1413:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1416:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1419:	ba 00 00 00 00       	mov    $0x0,%edx
    141e:	f7 f3                	div    %ebx
    1420:	89 d0                	mov    %edx,%eax
    1422:	0f b6 80 28 1b 00 00 	movzbl 0x1b28(%eax),%eax
    1429:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    142d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1431:	8b 45 10             	mov    0x10(%ebp),%eax
    1434:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1437:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143a:	ba 00 00 00 00       	mov    $0x0,%edx
    143f:	f7 75 d4             	divl   -0x2c(%ebp)
    1442:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1445:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1449:	75 c5                	jne    1410 <printint+0x38>
  if(neg)
    144b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    144f:	74 28                	je     1479 <printint+0xa1>
    buf[i++] = '-';
    1451:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1454:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1459:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    145d:	eb 1a                	jmp    1479 <printint+0xa1>
    putc(fd, buf[i]);
    145f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1462:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1467:	0f be c0             	movsbl %al,%eax
    146a:	89 44 24 04          	mov    %eax,0x4(%esp)
    146e:	8b 45 08             	mov    0x8(%ebp),%eax
    1471:	89 04 24             	mov    %eax,(%esp)
    1474:	e8 37 ff ff ff       	call   13b0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1479:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    147d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1481:	79 dc                	jns    145f <printint+0x87>
    putc(fd, buf[i]);
}
    1483:	83 c4 44             	add    $0x44,%esp
    1486:	5b                   	pop    %ebx
    1487:	5d                   	pop    %ebp
    1488:	c3                   	ret    

00001489 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1489:	55                   	push   %ebp
    148a:	89 e5                	mov    %esp,%ebp
    148c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    148f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1496:	8d 45 0c             	lea    0xc(%ebp),%eax
    1499:	83 c0 04             	add    $0x4,%eax
    149c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    149f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14a6:	e9 7e 01 00 00       	jmp    1629 <printf+0x1a0>
    c = fmt[i] & 0xff;
    14ab:	8b 55 0c             	mov    0xc(%ebp),%edx
    14ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14b4:	0f b6 00             	movzbl (%eax),%eax
    14b7:	0f be c0             	movsbl %al,%eax
    14ba:	25 ff 00 00 00       	and    $0xff,%eax
    14bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    14c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14c6:	75 2c                	jne    14f4 <printf+0x6b>
      if(c == '%'){
    14c8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14cc:	75 0c                	jne    14da <printf+0x51>
        state = '%';
    14ce:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14d5:	e9 4b 01 00 00       	jmp    1625 <printf+0x19c>
      } else {
        putc(fd, c);
    14da:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14dd:	0f be c0             	movsbl %al,%eax
    14e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
    14e7:	89 04 24             	mov    %eax,(%esp)
    14ea:	e8 c1 fe ff ff       	call   13b0 <putc>
    14ef:	e9 31 01 00 00       	jmp    1625 <printf+0x19c>
      }
    } else if(state == '%'){
    14f4:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14f8:	0f 85 27 01 00 00    	jne    1625 <printf+0x19c>
      if(c == 'd'){
    14fe:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1502:	75 2d                	jne    1531 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1504:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1507:	8b 00                	mov    (%eax),%eax
    1509:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1510:	00 
    1511:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1518:	00 
    1519:	89 44 24 04          	mov    %eax,0x4(%esp)
    151d:	8b 45 08             	mov    0x8(%ebp),%eax
    1520:	89 04 24             	mov    %eax,(%esp)
    1523:	e8 b0 fe ff ff       	call   13d8 <printint>
        ap++;
    1528:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    152c:	e9 ed 00 00 00       	jmp    161e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1531:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1535:	74 06                	je     153d <printf+0xb4>
    1537:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    153b:	75 2d                	jne    156a <printf+0xe1>
        printint(fd, *ap, 16, 0);
    153d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1540:	8b 00                	mov    (%eax),%eax
    1542:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1549:	00 
    154a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1551:	00 
    1552:	89 44 24 04          	mov    %eax,0x4(%esp)
    1556:	8b 45 08             	mov    0x8(%ebp),%eax
    1559:	89 04 24             	mov    %eax,(%esp)
    155c:	e8 77 fe ff ff       	call   13d8 <printint>
        ap++;
    1561:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1565:	e9 b4 00 00 00       	jmp    161e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    156a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    156e:	75 46                	jne    15b6 <printf+0x12d>
        s = (char*)*ap;
    1570:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1573:	8b 00                	mov    (%eax),%eax
    1575:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1578:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    157c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1580:	75 27                	jne    15a9 <printf+0x120>
          s = "(null)";
    1582:	c7 45 e4 f4 1a 00 00 	movl   $0x1af4,-0x1c(%ebp)
        while(*s != 0){
    1589:	eb 1f                	jmp    15aa <printf+0x121>
          putc(fd, *s);
    158b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    158e:	0f b6 00             	movzbl (%eax),%eax
    1591:	0f be c0             	movsbl %al,%eax
    1594:	89 44 24 04          	mov    %eax,0x4(%esp)
    1598:	8b 45 08             	mov    0x8(%ebp),%eax
    159b:	89 04 24             	mov    %eax,(%esp)
    159e:	e8 0d fe ff ff       	call   13b0 <putc>
          s++;
    15a3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    15a7:	eb 01                	jmp    15aa <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15a9:	90                   	nop
    15aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ad:	0f b6 00             	movzbl (%eax),%eax
    15b0:	84 c0                	test   %al,%al
    15b2:	75 d7                	jne    158b <printf+0x102>
    15b4:	eb 68                	jmp    161e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15b6:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15ba:	75 1d                	jne    15d9 <printf+0x150>
        putc(fd, *ap);
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	8b 00                	mov    (%eax),%eax
    15c1:	0f be c0             	movsbl %al,%eax
    15c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c8:	8b 45 08             	mov    0x8(%ebp),%eax
    15cb:	89 04 24             	mov    %eax,(%esp)
    15ce:	e8 dd fd ff ff       	call   13b0 <putc>
        ap++;
    15d3:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15d7:	eb 45                	jmp    161e <printf+0x195>
      } else if(c == '%'){
    15d9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15dd:	75 17                	jne    15f6 <printf+0x16d>
        putc(fd, c);
    15df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15e2:	0f be c0             	movsbl %al,%eax
    15e5:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ec:	89 04 24             	mov    %eax,(%esp)
    15ef:	e8 bc fd ff ff       	call   13b0 <putc>
    15f4:	eb 28                	jmp    161e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15f6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15fd:	00 
    15fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1601:	89 04 24             	mov    %eax,(%esp)
    1604:	e8 a7 fd ff ff       	call   13b0 <putc>
        putc(fd, c);
    1609:	8b 45 e8             	mov    -0x18(%ebp),%eax
    160c:	0f be c0             	movsbl %al,%eax
    160f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	89 04 24             	mov    %eax,(%esp)
    1619:	e8 92 fd ff ff       	call   13b0 <putc>
      }
      state = 0;
    161e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1625:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1629:	8b 55 0c             	mov    0xc(%ebp),%edx
    162c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    162f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1632:	0f b6 00             	movzbl (%eax),%eax
    1635:	84 c0                	test   %al,%al
    1637:	0f 85 6e fe ff ff    	jne    14ab <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    163d:	c9                   	leave  
    163e:	c3                   	ret    
    163f:	90                   	nop

00001640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1646:	8b 45 08             	mov    0x8(%ebp),%eax
    1649:	83 e8 08             	sub    $0x8,%eax
    164c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    164f:	a1 48 1b 00 00       	mov    0x1b48,%eax
    1654:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1657:	eb 24                	jmp    167d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1659:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165c:	8b 00                	mov    (%eax),%eax
    165e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1661:	77 12                	ja     1675 <free+0x35>
    1663:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1666:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1669:	77 24                	ja     168f <free+0x4f>
    166b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166e:	8b 00                	mov    (%eax),%eax
    1670:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1673:	77 1a                	ja     168f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1675:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1678:	8b 00                	mov    (%eax),%eax
    167a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    167d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1680:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1683:	76 d4                	jbe    1659 <free+0x19>
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	8b 00                	mov    (%eax),%eax
    168a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    168d:	76 ca                	jbe    1659 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    168f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1692:	8b 40 04             	mov    0x4(%eax),%eax
    1695:	c1 e0 03             	shl    $0x3,%eax
    1698:	89 c2                	mov    %eax,%edx
    169a:	03 55 f8             	add    -0x8(%ebp),%edx
    169d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a0:	8b 00                	mov    (%eax),%eax
    16a2:	39 c2                	cmp    %eax,%edx
    16a4:	75 24                	jne    16ca <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    16a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a9:	8b 50 04             	mov    0x4(%eax),%edx
    16ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16af:	8b 00                	mov    (%eax),%eax
    16b1:	8b 40 04             	mov    0x4(%eax),%eax
    16b4:	01 c2                	add    %eax,%edx
    16b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bf:	8b 00                	mov    (%eax),%eax
    16c1:	8b 10                	mov    (%eax),%edx
    16c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c6:	89 10                	mov    %edx,(%eax)
    16c8:	eb 0a                	jmp    16d4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    16ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cd:	8b 10                	mov    (%eax),%edx
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d7:	8b 40 04             	mov    0x4(%eax),%eax
    16da:	c1 e0 03             	shl    $0x3,%eax
    16dd:	03 45 fc             	add    -0x4(%ebp),%eax
    16e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16e3:	75 20                	jne    1705 <free+0xc5>
    p->s.size += bp->s.size;
    16e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e8:	8b 50 04             	mov    0x4(%eax),%edx
    16eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ee:	8b 40 04             	mov    0x4(%eax),%eax
    16f1:	01 c2                	add    %eax,%edx
    16f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fc:	8b 10                	mov    (%eax),%edx
    16fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1701:	89 10                	mov    %edx,(%eax)
    1703:	eb 08                	jmp    170d <free+0xcd>
  } else
    p->s.ptr = bp;
    1705:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1708:	8b 55 f8             	mov    -0x8(%ebp),%edx
    170b:	89 10                	mov    %edx,(%eax)
  freep = p;
    170d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1710:	a3 48 1b 00 00       	mov    %eax,0x1b48
}
    1715:	c9                   	leave  
    1716:	c3                   	ret    

00001717 <morecore>:

static Header*
morecore(uint nu)
{
    1717:	55                   	push   %ebp
    1718:	89 e5                	mov    %esp,%ebp
    171a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    171d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1724:	77 07                	ja     172d <morecore+0x16>
    nu = 4096;
    1726:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	c1 e0 03             	shl    $0x3,%eax
    1733:	89 04 24             	mov    %eax,(%esp)
    1736:	e8 35 fc ff ff       	call   1370 <sbrk>
    173b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    173e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1742:	75 07                	jne    174b <morecore+0x34>
    return 0;
    1744:	b8 00 00 00 00       	mov    $0x0,%eax
    1749:	eb 22                	jmp    176d <morecore+0x56>
  hp = (Header*)p;
    174b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    174e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1751:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1754:	8b 55 08             	mov    0x8(%ebp),%edx
    1757:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    175a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175d:	83 c0 08             	add    $0x8,%eax
    1760:	89 04 24             	mov    %eax,(%esp)
    1763:	e8 d8 fe ff ff       	call   1640 <free>
  return freep;
    1768:	a1 48 1b 00 00       	mov    0x1b48,%eax
}
    176d:	c9                   	leave  
    176e:	c3                   	ret    

0000176f <malloc>:

void*
malloc(uint nbytes)
{
    176f:	55                   	push   %ebp
    1770:	89 e5                	mov    %esp,%ebp
    1772:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1775:	8b 45 08             	mov    0x8(%ebp),%eax
    1778:	83 c0 07             	add    $0x7,%eax
    177b:	c1 e8 03             	shr    $0x3,%eax
    177e:	83 c0 01             	add    $0x1,%eax
    1781:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1784:	a1 48 1b 00 00       	mov    0x1b48,%eax
    1789:	89 45 f0             	mov    %eax,-0x10(%ebp)
    178c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1790:	75 23                	jne    17b5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1792:	c7 45 f0 40 1b 00 00 	movl   $0x1b40,-0x10(%ebp)
    1799:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179c:	a3 48 1b 00 00       	mov    %eax,0x1b48
    17a1:	a1 48 1b 00 00       	mov    0x1b48,%eax
    17a6:	a3 40 1b 00 00       	mov    %eax,0x1b40
    base.s.size = 0;
    17ab:	c7 05 44 1b 00 00 00 	movl   $0x0,0x1b44
    17b2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b8:	8b 00                	mov    (%eax),%eax
    17ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    17bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c0:	8b 40 04             	mov    0x4(%eax),%eax
    17c3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17c6:	72 4d                	jb     1815 <malloc+0xa6>
      if(p->s.size == nunits)
    17c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17cb:	8b 40 04             	mov    0x4(%eax),%eax
    17ce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17d1:	75 0c                	jne    17df <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d6:	8b 10                	mov    (%eax),%edx
    17d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17db:	89 10                	mov    %edx,(%eax)
    17dd:	eb 26                	jmp    1805 <malloc+0x96>
      else {
        p->s.size -= nunits;
    17df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e2:	8b 40 04             	mov    0x4(%eax),%eax
    17e5:	89 c2                	mov    %eax,%edx
    17e7:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f3:	8b 40 04             	mov    0x4(%eax),%eax
    17f6:	c1 e0 03             	shl    $0x3,%eax
    17f9:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    17fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1802:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1805:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1808:	a3 48 1b 00 00       	mov    %eax,0x1b48
      return (void*)(p + 1);
    180d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1810:	83 c0 08             	add    $0x8,%eax
    1813:	eb 38                	jmp    184d <malloc+0xde>
    }
    if(p == freep)
    1815:	a1 48 1b 00 00       	mov    0x1b48,%eax
    181a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    181d:	75 1b                	jne    183a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    181f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1822:	89 04 24             	mov    %eax,(%esp)
    1825:	e8 ed fe ff ff       	call   1717 <morecore>
    182a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    182d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1831:	75 07                	jne    183a <malloc+0xcb>
        return 0;
    1833:	b8 00 00 00 00       	mov    $0x0,%eax
    1838:	eb 13                	jmp    184d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    183a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1840:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1843:	8b 00                	mov    (%eax),%eax
    1845:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1848:	e9 70 ff ff ff       	jmp    17bd <malloc+0x4e>
}
    184d:	c9                   	leave  
    184e:	c3                   	ret    
    184f:	90                   	nop

00001850 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1856:	8b 55 08             	mov    0x8(%ebp),%edx
    1859:	8b 45 0c             	mov    0xc(%ebp),%eax
    185c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    185f:	f0 87 02             	lock xchg %eax,(%edx)
    1862:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1865:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1868:	c9                   	leave  
    1869:	c3                   	ret    

0000186a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    186a:	55                   	push   %ebp
    186b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1876:	5d                   	pop    %ebp
    1877:	c3                   	ret    

00001878 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1878:	55                   	push   %ebp
    1879:	89 e5                	mov    %esp,%ebp
    187b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    187e:	8b 45 08             	mov    0x8(%ebp),%eax
    1881:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1888:	00 
    1889:	89 04 24             	mov    %eax,(%esp)
    188c:	e8 bf ff ff ff       	call   1850 <xchg>
    1891:	85 c0                	test   %eax,%eax
    1893:	75 e9                	jne    187e <lock_acquire+0x6>
}
    1895:	c9                   	leave  
    1896:	c3                   	ret    

00001897 <lock_release>:
void lock_release(lock_t *lock){
    1897:	55                   	push   %ebp
    1898:	89 e5                	mov    %esp,%ebp
    189a:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    189d:	8b 45 08             	mov    0x8(%ebp),%eax
    18a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18a7:	00 
    18a8:	89 04 24             	mov    %eax,(%esp)
    18ab:	e8 a0 ff ff ff       	call   1850 <xchg>
}
    18b0:	c9                   	leave  
    18b1:	c3                   	ret    

000018b2 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18b2:	55                   	push   %ebp
    18b3:	89 e5                	mov    %esp,%ebp
    18b5:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18b8:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18bf:	e8 ab fe ff ff       	call   176f <malloc>
    18c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    18c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d0:	25 ff 0f 00 00       	and    $0xfff,%eax
    18d5:	85 c0                	test   %eax,%eax
    18d7:	74 15                	je     18ee <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    18d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dc:	89 c2                	mov    %eax,%edx
    18de:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18e4:	b8 00 10 00 00       	mov    $0x1000,%eax
    18e9:	29 d0                	sub    %edx,%eax
    18eb:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    18ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18f2:	75 1b                	jne    190f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    18f4:	c7 44 24 04 fb 1a 00 	movl   $0x1afb,0x4(%esp)
    18fb:	00 
    18fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1903:	e8 81 fb ff ff       	call   1489 <printf>
        return 0;
    1908:	b8 00 00 00 00       	mov    $0x0,%eax
    190d:	eb 6f                	jmp    197e <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    190f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1912:	8b 55 08             	mov    0x8(%ebp),%edx
    1915:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1918:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    191c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1920:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1927:	00 
    1928:	89 04 24             	mov    %eax,(%esp)
    192b:	e8 58 fa ff ff       	call   1388 <clone>
    1930:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1933:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1937:	79 1b                	jns    1954 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1939:	c7 44 24 04 09 1b 00 	movl   $0x1b09,0x4(%esp)
    1940:	00 
    1941:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1948:	e8 3c fb ff ff       	call   1489 <printf>
        return 0;
    194d:	b8 00 00 00 00       	mov    $0x0,%eax
    1952:	eb 2a                	jmp    197e <thread_create+0xcc>
    }
    if(tid > 0){
    1954:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1958:	7e 05                	jle    195f <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195d:	eb 1f                	jmp    197e <thread_create+0xcc>
    }
    if(tid == 0){
    195f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1963:	75 14                	jne    1979 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1965:	c7 44 24 04 16 1b 00 	movl   $0x1b16,0x4(%esp)
    196c:	00 
    196d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1974:	e8 10 fb ff ff       	call   1489 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1979:	b8 00 00 00 00       	mov    $0x0,%eax
}
    197e:	c9                   	leave  
    197f:	c3                   	ret    

00001980 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1980:	55                   	push   %ebp
    1981:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1983:	a1 3c 1b 00 00       	mov    0x1b3c,%eax
    1988:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    198e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1993:	a3 3c 1b 00 00       	mov    %eax,0x1b3c
    return (int)(rands % max);
    1998:	a1 3c 1b 00 00       	mov    0x1b3c,%eax
    199d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19a0:	ba 00 00 00 00       	mov    $0x0,%edx
    19a5:	f7 f1                	div    %ecx
    19a7:	89 d0                	mov    %edx,%eax
}
    19a9:	5d                   	pop    %ebp
    19aa:	c3                   	ret    
    19ab:	90                   	nop

000019ac <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19ac:	55                   	push   %ebp
    19ad:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19b8:	8b 45 08             	mov    0x8(%ebp),%eax
    19bb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19c2:	8b 45 08             	mov    0x8(%ebp),%eax
    19c5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19cc:	5d                   	pop    %ebp
    19cd:	c3                   	ret    

000019ce <add_q>:

void add_q(struct queue *q, int v){
    19ce:	55                   	push   %ebp
    19cf:	89 e5                	mov    %esp,%ebp
    19d1:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19d4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19db:	e8 8f fd ff ff       	call   176f <malloc>
    19e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    19f3:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19f5:	8b 45 08             	mov    0x8(%ebp),%eax
    19f8:	8b 40 04             	mov    0x4(%eax),%eax
    19fb:	85 c0                	test   %eax,%eax
    19fd:	75 0b                	jne    1a0a <add_q+0x3c>
        q->head = n;
    19ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a05:	89 50 04             	mov    %edx,0x4(%eax)
    1a08:	eb 0c                	jmp    1a16 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0d:	8b 40 08             	mov    0x8(%eax),%eax
    1a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a13:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a16:	8b 45 08             	mov    0x8(%ebp),%eax
    1a19:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a1c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a22:	8b 00                	mov    (%eax),%eax
    1a24:	8d 50 01             	lea    0x1(%eax),%edx
    1a27:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2a:	89 10                	mov    %edx,(%eax)
}
    1a2c:	c9                   	leave  
    1a2d:	c3                   	ret    

00001a2e <empty_q>:

int empty_q(struct queue *q){
    1a2e:	55                   	push   %ebp
    1a2f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a31:	8b 45 08             	mov    0x8(%ebp),%eax
    1a34:	8b 00                	mov    (%eax),%eax
    1a36:	85 c0                	test   %eax,%eax
    1a38:	75 07                	jne    1a41 <empty_q+0x13>
        return 1;
    1a3a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a3f:	eb 05                	jmp    1a46 <empty_q+0x18>
    else
        return 0;
    1a41:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a46:	5d                   	pop    %ebp
    1a47:	c3                   	ret    

00001a48 <pop_q>:
int pop_q(struct queue *q){
    1a48:	55                   	push   %ebp
    1a49:	89 e5                	mov    %esp,%ebp
    1a4b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a51:	89 04 24             	mov    %eax,(%esp)
    1a54:	e8 d5 ff ff ff       	call   1a2e <empty_q>
    1a59:	85 c0                	test   %eax,%eax
    1a5b:	75 5d                	jne    1aba <pop_q+0x72>
       val = q->head->value; 
    1a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a60:	8b 40 04             	mov    0x4(%eax),%eax
    1a63:	8b 00                	mov    (%eax),%eax
    1a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1a68:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6b:	8b 40 04             	mov    0x4(%eax),%eax
    1a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1a71:	8b 45 08             	mov    0x8(%ebp),%eax
    1a74:	8b 40 04             	mov    0x4(%eax),%eax
    1a77:	8b 50 04             	mov    0x4(%eax),%edx
    1a7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a83:	89 04 24             	mov    %eax,(%esp)
    1a86:	e8 b5 fb ff ff       	call   1640 <free>
       q->size--;
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	8b 00                	mov    (%eax),%eax
    1a90:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a98:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9b:	8b 00                	mov    (%eax),%eax
    1a9d:	85 c0                	test   %eax,%eax
    1a9f:	75 14                	jne    1ab5 <pop_q+0x6d>
            q->head = 0;
    1aa1:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1aab:	8b 45 08             	mov    0x8(%ebp),%eax
    1aae:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ab8:	eb 05                	jmp    1abf <pop_q+0x77>
    }
    return -1;
    1aba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1abf:	c9                   	leave  
    1ac0:	c3                   	ret    
