
_rm:     file format elf32-i386


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
    printf(2, "Usage: rm files...\n");
    100f:	c7 44 24 04 e1 1a 00 	movl   $0x1ae1,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 7d 04 00 00       	call   14a0 <printf>
    exit();
    1023:	e8 d0 02 00 00       	call   12f8 <exit>
  }

  for(i = 1; i < argc; i++){
    1028:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    102f:	00 
    1030:	eb 4f                	jmp    1081 <main+0x81>
    if(unlink(argv[i]) < 0){
    1032:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1036:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    103d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1040:	01 d0                	add    %edx,%eax
    1042:	8b 00                	mov    (%eax),%eax
    1044:	89 04 24             	mov    %eax,(%esp)
    1047:	e8 fc 02 00 00       	call   1348 <unlink>
    104c:	85 c0                	test   %eax,%eax
    104e:	79 2c                	jns    107c <main+0x7c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    1050:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1054:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    105b:	8b 45 0c             	mov    0xc(%ebp),%eax
    105e:	01 d0                	add    %edx,%eax
    1060:	8b 00                	mov    (%eax),%eax
    1062:	89 44 24 08          	mov    %eax,0x8(%esp)
    1066:	c7 44 24 04 f5 1a 00 	movl   $0x1af5,0x4(%esp)
    106d:	00 
    106e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1075:	e8 26 04 00 00       	call   14a0 <printf>
      break;
    107a:	eb 0e                	jmp    108a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    107c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1081:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1085:	3b 45 08             	cmp    0x8(%ebp),%eax
    1088:	7c a8                	jl     1032 <main+0x32>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
    108a:	e8 69 02 00 00       	call   12f8 <exit>
    108f:	90                   	nop

00001090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	57                   	push   %edi
    1094:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1095:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1098:	8b 55 10             	mov    0x10(%ebp),%edx
    109b:	8b 45 0c             	mov    0xc(%ebp),%eax
    109e:	89 cb                	mov    %ecx,%ebx
    10a0:	89 df                	mov    %ebx,%edi
    10a2:	89 d1                	mov    %edx,%ecx
    10a4:	fc                   	cld    
    10a5:	f3 aa                	rep stos %al,%es:(%edi)
    10a7:	89 ca                	mov    %ecx,%edx
    10a9:	89 fb                	mov    %edi,%ebx
    10ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10b1:	5b                   	pop    %ebx
    10b2:	5f                   	pop    %edi
    10b3:	5d                   	pop    %ebp
    10b4:	c3                   	ret    

000010b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10b5:	55                   	push   %ebp
    10b6:	89 e5                	mov    %esp,%ebp
    10b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10bb:	8b 45 08             	mov    0x8(%ebp),%eax
    10be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10c1:	90                   	nop
    10c2:	8b 45 08             	mov    0x8(%ebp),%eax
    10c5:	8d 50 01             	lea    0x1(%eax),%edx
    10c8:	89 55 08             	mov    %edx,0x8(%ebp)
    10cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ce:	8d 4a 01             	lea    0x1(%edx),%ecx
    10d1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10d4:	0f b6 12             	movzbl (%edx),%edx
    10d7:	88 10                	mov    %dl,(%eax)
    10d9:	0f b6 00             	movzbl (%eax),%eax
    10dc:	84 c0                	test   %al,%al
    10de:	75 e2                	jne    10c2 <strcpy+0xd>
    ;
  return os;
    10e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10e3:	c9                   	leave  
    10e4:	c3                   	ret    

000010e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10e5:	55                   	push   %ebp
    10e6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10e8:	eb 08                	jmp    10f2 <strcmp+0xd>
    p++, q++;
    10ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	0f b6 00             	movzbl (%eax),%eax
    10f8:	84 c0                	test   %al,%al
    10fa:	74 10                	je     110c <strcmp+0x27>
    10fc:	8b 45 08             	mov    0x8(%ebp),%eax
    10ff:	0f b6 10             	movzbl (%eax),%edx
    1102:	8b 45 0c             	mov    0xc(%ebp),%eax
    1105:	0f b6 00             	movzbl (%eax),%eax
    1108:	38 c2                	cmp    %al,%dl
    110a:	74 de                	je     10ea <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    110c:	8b 45 08             	mov    0x8(%ebp),%eax
    110f:	0f b6 00             	movzbl (%eax),%eax
    1112:	0f b6 d0             	movzbl %al,%edx
    1115:	8b 45 0c             	mov    0xc(%ebp),%eax
    1118:	0f b6 00             	movzbl (%eax),%eax
    111b:	0f b6 c0             	movzbl %al,%eax
    111e:	29 c2                	sub    %eax,%edx
    1120:	89 d0                	mov    %edx,%eax
}
    1122:	5d                   	pop    %ebp
    1123:	c3                   	ret    

00001124 <strlen>:

uint
strlen(char *s)
{
    1124:	55                   	push   %ebp
    1125:	89 e5                	mov    %esp,%ebp
    1127:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    112a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1131:	eb 04                	jmp    1137 <strlen+0x13>
    1133:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1137:	8b 55 fc             	mov    -0x4(%ebp),%edx
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
    113d:	01 d0                	add    %edx,%eax
    113f:	0f b6 00             	movzbl (%eax),%eax
    1142:	84 c0                	test   %al,%al
    1144:	75 ed                	jne    1133 <strlen+0xf>
    ;
  return n;
    1146:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1149:	c9                   	leave  
    114a:	c3                   	ret    

0000114b <memset>:

void*
memset(void *dst, int c, uint n)
{
    114b:	55                   	push   %ebp
    114c:	89 e5                	mov    %esp,%ebp
    114e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1151:	8b 45 10             	mov    0x10(%ebp),%eax
    1154:	89 44 24 08          	mov    %eax,0x8(%esp)
    1158:	8b 45 0c             	mov    0xc(%ebp),%eax
    115b:	89 44 24 04          	mov    %eax,0x4(%esp)
    115f:	8b 45 08             	mov    0x8(%ebp),%eax
    1162:	89 04 24             	mov    %eax,(%esp)
    1165:	e8 26 ff ff ff       	call   1090 <stosb>
  return dst;
    116a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    116d:	c9                   	leave  
    116e:	c3                   	ret    

0000116f <strchr>:

char*
strchr(const char *s, char c)
{
    116f:	55                   	push   %ebp
    1170:	89 e5                	mov    %esp,%ebp
    1172:	83 ec 04             	sub    $0x4,%esp
    1175:	8b 45 0c             	mov    0xc(%ebp),%eax
    1178:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    117b:	eb 14                	jmp    1191 <strchr+0x22>
    if(*s == c)
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1186:	75 05                	jne    118d <strchr+0x1e>
      return (char*)s;
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	eb 13                	jmp    11a0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    118d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1191:	8b 45 08             	mov    0x8(%ebp),%eax
    1194:	0f b6 00             	movzbl (%eax),%eax
    1197:	84 c0                	test   %al,%al
    1199:	75 e2                	jne    117d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    119b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11a0:	c9                   	leave  
    11a1:	c3                   	ret    

000011a2 <gets>:

char*
gets(char *buf, int max)
{
    11a2:	55                   	push   %ebp
    11a3:	89 e5                	mov    %esp,%ebp
    11a5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11af:	eb 4c                	jmp    11fd <gets+0x5b>
    cc = read(0, &c, 1);
    11b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11b8:	00 
    11b9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    11c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11c7:	e8 44 01 00 00       	call   1310 <read>
    11cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11d3:	7f 02                	jg     11d7 <gets+0x35>
      break;
    11d5:	eb 31                	jmp    1208 <gets+0x66>
    buf[i++] = c;
    11d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11da:	8d 50 01             	lea    0x1(%eax),%edx
    11dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11e0:	89 c2                	mov    %eax,%edx
    11e2:	8b 45 08             	mov    0x8(%ebp),%eax
    11e5:	01 c2                	add    %eax,%edx
    11e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f1:	3c 0a                	cmp    $0xa,%al
    11f3:	74 13                	je     1208 <gets+0x66>
    11f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f9:	3c 0d                	cmp    $0xd,%al
    11fb:	74 0b                	je     1208 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1200:	83 c0 01             	add    $0x1,%eax
    1203:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1206:	7c a9                	jl     11b1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1208:	8b 55 f4             	mov    -0xc(%ebp),%edx
    120b:	8b 45 08             	mov    0x8(%ebp),%eax
    120e:	01 d0                	add    %edx,%eax
    1210:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1216:	c9                   	leave  
    1217:	c3                   	ret    

00001218 <stat>:

int
stat(char *n, struct stat *st)
{
    1218:	55                   	push   %ebp
    1219:	89 e5                	mov    %esp,%ebp
    121b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    121e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1225:	00 
    1226:	8b 45 08             	mov    0x8(%ebp),%eax
    1229:	89 04 24             	mov    %eax,(%esp)
    122c:	e8 07 01 00 00       	call   1338 <open>
    1231:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1234:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1238:	79 07                	jns    1241 <stat+0x29>
    return -1;
    123a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    123f:	eb 23                	jmp    1264 <stat+0x4c>
  r = fstat(fd, st);
    1241:	8b 45 0c             	mov    0xc(%ebp),%eax
    1244:	89 44 24 04          	mov    %eax,0x4(%esp)
    1248:	8b 45 f4             	mov    -0xc(%ebp),%eax
    124b:	89 04 24             	mov    %eax,(%esp)
    124e:	e8 fd 00 00 00       	call   1350 <fstat>
    1253:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1256:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1259:	89 04 24             	mov    %eax,(%esp)
    125c:	e8 bf 00 00 00       	call   1320 <close>
  return r;
    1261:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1264:	c9                   	leave  
    1265:	c3                   	ret    

00001266 <atoi>:

int
atoi(const char *s)
{
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    126c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1273:	eb 25                	jmp    129a <atoi+0x34>
    n = n*10 + *s++ - '0';
    1275:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1278:	89 d0                	mov    %edx,%eax
    127a:	c1 e0 02             	shl    $0x2,%eax
    127d:	01 d0                	add    %edx,%eax
    127f:	01 c0                	add    %eax,%eax
    1281:	89 c1                	mov    %eax,%ecx
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
    1286:	8d 50 01             	lea    0x1(%eax),%edx
    1289:	89 55 08             	mov    %edx,0x8(%ebp)
    128c:	0f b6 00             	movzbl (%eax),%eax
    128f:	0f be c0             	movsbl %al,%eax
    1292:	01 c8                	add    %ecx,%eax
    1294:	83 e8 30             	sub    $0x30,%eax
    1297:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    129a:	8b 45 08             	mov    0x8(%ebp),%eax
    129d:	0f b6 00             	movzbl (%eax),%eax
    12a0:	3c 2f                	cmp    $0x2f,%al
    12a2:	7e 0a                	jle    12ae <atoi+0x48>
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	0f b6 00             	movzbl (%eax),%eax
    12aa:	3c 39                	cmp    $0x39,%al
    12ac:	7e c7                	jle    1275 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12b1:	c9                   	leave  
    12b2:	c3                   	ret    

000012b3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12b3:	55                   	push   %ebp
    12b4:	89 e5                	mov    %esp,%ebp
    12b6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12b9:	8b 45 08             	mov    0x8(%ebp),%eax
    12bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12c5:	eb 17                	jmp    12de <memmove+0x2b>
    *dst++ = *src++;
    12c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ca:	8d 50 01             	lea    0x1(%eax),%edx
    12cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12d3:	8d 4a 01             	lea    0x1(%edx),%ecx
    12d6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12d9:	0f b6 12             	movzbl (%edx),%edx
    12dc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12de:	8b 45 10             	mov    0x10(%ebp),%eax
    12e1:	8d 50 ff             	lea    -0x1(%eax),%edx
    12e4:	89 55 10             	mov    %edx,0x10(%ebp)
    12e7:	85 c0                	test   %eax,%eax
    12e9:	7f dc                	jg     12c7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ee:	c9                   	leave  
    12ef:	c3                   	ret    

000012f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12f0:	b8 01 00 00 00       	mov    $0x1,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <exit>:
SYSCALL(exit)
    12f8:	b8 02 00 00 00       	mov    $0x2,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <wait>:
SYSCALL(wait)
    1300:	b8 03 00 00 00       	mov    $0x3,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <pipe>:
SYSCALL(pipe)
    1308:	b8 04 00 00 00       	mov    $0x4,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <read>:
SYSCALL(read)
    1310:	b8 05 00 00 00       	mov    $0x5,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <write>:
SYSCALL(write)
    1318:	b8 10 00 00 00       	mov    $0x10,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <close>:
SYSCALL(close)
    1320:	b8 15 00 00 00       	mov    $0x15,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <kill>:
SYSCALL(kill)
    1328:	b8 06 00 00 00       	mov    $0x6,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <exec>:
SYSCALL(exec)
    1330:	b8 07 00 00 00       	mov    $0x7,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <open>:
SYSCALL(open)
    1338:	b8 0f 00 00 00       	mov    $0xf,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <mknod>:
SYSCALL(mknod)
    1340:	b8 11 00 00 00       	mov    $0x11,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <unlink>:
SYSCALL(unlink)
    1348:	b8 12 00 00 00       	mov    $0x12,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <fstat>:
SYSCALL(fstat)
    1350:	b8 08 00 00 00       	mov    $0x8,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <link>:
SYSCALL(link)
    1358:	b8 13 00 00 00       	mov    $0x13,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <mkdir>:
SYSCALL(mkdir)
    1360:	b8 14 00 00 00       	mov    $0x14,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <chdir>:
SYSCALL(chdir)
    1368:	b8 09 00 00 00       	mov    $0x9,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <dup>:
SYSCALL(dup)
    1370:	b8 0a 00 00 00       	mov    $0xa,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <getpid>:
SYSCALL(getpid)
    1378:	b8 0b 00 00 00       	mov    $0xb,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <sbrk>:
SYSCALL(sbrk)
    1380:	b8 0c 00 00 00       	mov    $0xc,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <sleep>:
SYSCALL(sleep)
    1388:	b8 0d 00 00 00       	mov    $0xd,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <uptime>:
SYSCALL(uptime)
    1390:	b8 0e 00 00 00       	mov    $0xe,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <clone>:
SYSCALL(clone)
    1398:	b8 16 00 00 00       	mov    $0x16,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <texit>:
SYSCALL(texit)
    13a0:	b8 17 00 00 00       	mov    $0x17,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <tsleep>:
SYSCALL(tsleep)
    13a8:	b8 18 00 00 00       	mov    $0x18,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <twakeup>:
SYSCALL(twakeup)
    13b0:	b8 19 00 00 00       	mov    $0x19,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <thread_yield>:
SYSCALL(thread_yield)
    13b8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	83 ec 18             	sub    $0x18,%esp
    13c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13d3:	00 
    13d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13d7:	89 44 24 04          	mov    %eax,0x4(%esp)
    13db:	8b 45 08             	mov    0x8(%ebp),%eax
    13de:	89 04 24             	mov    %eax,(%esp)
    13e1:	e8 32 ff ff ff       	call   1318 <write>
}
    13e6:	c9                   	leave  
    13e7:	c3                   	ret    

000013e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13e8:	55                   	push   %ebp
    13e9:	89 e5                	mov    %esp,%ebp
    13eb:	56                   	push   %esi
    13ec:	53                   	push   %ebx
    13ed:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13f7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13fb:	74 17                	je     1414 <printint+0x2c>
    13fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1401:	79 11                	jns    1414 <printint+0x2c>
    neg = 1;
    1403:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    140a:	8b 45 0c             	mov    0xc(%ebp),%eax
    140d:	f7 d8                	neg    %eax
    140f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1412:	eb 06                	jmp    141a <printint+0x32>
  } else {
    x = xx;
    1414:	8b 45 0c             	mov    0xc(%ebp),%eax
    1417:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    141a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1421:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1424:	8d 41 01             	lea    0x1(%ecx),%eax
    1427:	89 45 f4             	mov    %eax,-0xc(%ebp)
    142a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    142d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1430:	ba 00 00 00 00       	mov    $0x0,%edx
    1435:	f7 f3                	div    %ebx
    1437:	89 d0                	mov    %edx,%eax
    1439:	0f b6 80 c8 1e 00 00 	movzbl 0x1ec8(%eax),%eax
    1440:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1444:	8b 75 10             	mov    0x10(%ebp),%esi
    1447:	8b 45 ec             	mov    -0x14(%ebp),%eax
    144a:	ba 00 00 00 00       	mov    $0x0,%edx
    144f:	f7 f6                	div    %esi
    1451:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1454:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1458:	75 c7                	jne    1421 <printint+0x39>
  if(neg)
    145a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    145e:	74 10                	je     1470 <printint+0x88>
    buf[i++] = '-';
    1460:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1463:	8d 50 01             	lea    0x1(%eax),%edx
    1466:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1469:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    146e:	eb 1f                	jmp    148f <printint+0xa7>
    1470:	eb 1d                	jmp    148f <printint+0xa7>
    putc(fd, buf[i]);
    1472:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1475:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1478:	01 d0                	add    %edx,%eax
    147a:	0f b6 00             	movzbl (%eax),%eax
    147d:	0f be c0             	movsbl %al,%eax
    1480:	89 44 24 04          	mov    %eax,0x4(%esp)
    1484:	8b 45 08             	mov    0x8(%ebp),%eax
    1487:	89 04 24             	mov    %eax,(%esp)
    148a:	e8 31 ff ff ff       	call   13c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    148f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1493:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1497:	79 d9                	jns    1472 <printint+0x8a>
    putc(fd, buf[i]);
}
    1499:	83 c4 30             	add    $0x30,%esp
    149c:	5b                   	pop    %ebx
    149d:	5e                   	pop    %esi
    149e:	5d                   	pop    %ebp
    149f:	c3                   	ret    

000014a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14ad:	8d 45 0c             	lea    0xc(%ebp),%eax
    14b0:	83 c0 04             	add    $0x4,%eax
    14b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14bd:	e9 7c 01 00 00       	jmp    163e <printf+0x19e>
    c = fmt[i] & 0xff;
    14c2:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c8:	01 d0                	add    %edx,%eax
    14ca:	0f b6 00             	movzbl (%eax),%eax
    14cd:	0f be c0             	movsbl %al,%eax
    14d0:	25 ff 00 00 00       	and    $0xff,%eax
    14d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14dc:	75 2c                	jne    150a <printf+0x6a>
      if(c == '%'){
    14de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14e2:	75 0c                	jne    14f0 <printf+0x50>
        state = '%';
    14e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14eb:	e9 4a 01 00 00       	jmp    163a <printf+0x19a>
      } else {
        putc(fd, c);
    14f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14f3:	0f be c0             	movsbl %al,%eax
    14f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fa:	8b 45 08             	mov    0x8(%ebp),%eax
    14fd:	89 04 24             	mov    %eax,(%esp)
    1500:	e8 bb fe ff ff       	call   13c0 <putc>
    1505:	e9 30 01 00 00       	jmp    163a <printf+0x19a>
      }
    } else if(state == '%'){
    150a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    150e:	0f 85 26 01 00 00    	jne    163a <printf+0x19a>
      if(c == 'd'){
    1514:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1518:	75 2d                	jne    1547 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    151a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151d:	8b 00                	mov    (%eax),%eax
    151f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1526:	00 
    1527:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    152e:	00 
    152f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1533:	8b 45 08             	mov    0x8(%ebp),%eax
    1536:	89 04 24             	mov    %eax,(%esp)
    1539:	e8 aa fe ff ff       	call   13e8 <printint>
        ap++;
    153e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1542:	e9 ec 00 00 00       	jmp    1633 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1547:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    154b:	74 06                	je     1553 <printf+0xb3>
    154d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1551:	75 2d                	jne    1580 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1553:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1556:	8b 00                	mov    (%eax),%eax
    1558:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    155f:	00 
    1560:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1567:	00 
    1568:	89 44 24 04          	mov    %eax,0x4(%esp)
    156c:	8b 45 08             	mov    0x8(%ebp),%eax
    156f:	89 04 24             	mov    %eax,(%esp)
    1572:	e8 71 fe ff ff       	call   13e8 <printint>
        ap++;
    1577:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    157b:	e9 b3 00 00 00       	jmp    1633 <printf+0x193>
      } else if(c == 's'){
    1580:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1584:	75 45                	jne    15cb <printf+0x12b>
        s = (char*)*ap;
    1586:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1589:	8b 00                	mov    (%eax),%eax
    158b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    158e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1592:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1596:	75 09                	jne    15a1 <printf+0x101>
          s = "(null)";
    1598:	c7 45 f4 0e 1b 00 00 	movl   $0x1b0e,-0xc(%ebp)
        while(*s != 0){
    159f:	eb 1e                	jmp    15bf <printf+0x11f>
    15a1:	eb 1c                	jmp    15bf <printf+0x11f>
          putc(fd, *s);
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	0f be c0             	movsbl %al,%eax
    15ac:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b0:	8b 45 08             	mov    0x8(%ebp),%eax
    15b3:	89 04 24             	mov    %eax,(%esp)
    15b6:	e8 05 fe ff ff       	call   13c0 <putc>
          s++;
    15bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	0f b6 00             	movzbl (%eax),%eax
    15c5:	84 c0                	test   %al,%al
    15c7:	75 da                	jne    15a3 <printf+0x103>
    15c9:	eb 68                	jmp    1633 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15cb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15cf:	75 1d                	jne    15ee <printf+0x14e>
        putc(fd, *ap);
    15d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d4:	8b 00                	mov    (%eax),%eax
    15d6:	0f be c0             	movsbl %al,%eax
    15d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    15dd:	8b 45 08             	mov    0x8(%ebp),%eax
    15e0:	89 04 24             	mov    %eax,(%esp)
    15e3:	e8 d8 fd ff ff       	call   13c0 <putc>
        ap++;
    15e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15ec:	eb 45                	jmp    1633 <printf+0x193>
      } else if(c == '%'){
    15ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15f2:	75 17                	jne    160b <printf+0x16b>
        putc(fd, c);
    15f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f7:	0f be c0             	movsbl %al,%eax
    15fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    15fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1601:	89 04 24             	mov    %eax,(%esp)
    1604:	e8 b7 fd ff ff       	call   13c0 <putc>
    1609:	eb 28                	jmp    1633 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    160b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1612:	00 
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	89 04 24             	mov    %eax,(%esp)
    1619:	e8 a2 fd ff ff       	call   13c0 <putc>
        putc(fd, c);
    161e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1621:	0f be c0             	movsbl %al,%eax
    1624:	89 44 24 04          	mov    %eax,0x4(%esp)
    1628:	8b 45 08             	mov    0x8(%ebp),%eax
    162b:	89 04 24             	mov    %eax,(%esp)
    162e:	e8 8d fd ff ff       	call   13c0 <putc>
      }
      state = 0;
    1633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    163a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    163e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1641:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1644:	01 d0                	add    %edx,%eax
    1646:	0f b6 00             	movzbl (%eax),%eax
    1649:	84 c0                	test   %al,%al
    164b:	0f 85 71 fe ff ff    	jne    14c2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1651:	c9                   	leave  
    1652:	c3                   	ret    
    1653:	90                   	nop

00001654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1654:	55                   	push   %ebp
    1655:	89 e5                	mov    %esp,%ebp
    1657:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    165a:	8b 45 08             	mov    0x8(%ebp),%eax
    165d:	83 e8 08             	sub    $0x8,%eax
    1660:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1663:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    1668:	89 45 fc             	mov    %eax,-0x4(%ebp)
    166b:	eb 24                	jmp    1691 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1675:	77 12                	ja     1689 <free+0x35>
    1677:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    167d:	77 24                	ja     16a3 <free+0x4f>
    167f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1682:	8b 00                	mov    (%eax),%eax
    1684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1687:	77 1a                	ja     16a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1689:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168c:	8b 00                	mov    (%eax),%eax
    168e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1691:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1697:	76 d4                	jbe    166d <free+0x19>
    1699:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169c:	8b 00                	mov    (%eax),%eax
    169e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16a1:	76 ca                	jbe    166d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a6:	8b 40 04             	mov    0x4(%eax),%eax
    16a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b3:	01 c2                	add    %eax,%edx
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	39 c2                	cmp    %eax,%edx
    16bc:	75 24                	jne    16e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    16be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c1:	8b 50 04             	mov    0x4(%eax),%edx
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	8b 00                	mov    (%eax),%eax
    16c9:	8b 40 04             	mov    0x4(%eax),%eax
    16cc:	01 c2                	add    %eax,%edx
    16ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d7:	8b 00                	mov    (%eax),%eax
    16d9:	8b 10                	mov    (%eax),%edx
    16db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16de:	89 10                	mov    %edx,(%eax)
    16e0:	eb 0a                	jmp    16ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    16e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e5:	8b 10                	mov    (%eax),%edx
    16e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ef:	8b 40 04             	mov    0x4(%eax),%eax
    16f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fc:	01 d0                	add    %edx,%eax
    16fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1701:	75 20                	jne    1723 <free+0xcf>
    p->s.size += bp->s.size;
    1703:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1706:	8b 50 04             	mov    0x4(%eax),%edx
    1709:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170c:	8b 40 04             	mov    0x4(%eax),%eax
    170f:	01 c2                	add    %eax,%edx
    1711:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1714:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1717:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171a:	8b 10                	mov    (%eax),%edx
    171c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171f:	89 10                	mov    %edx,(%eax)
    1721:	eb 08                	jmp    172b <free+0xd7>
  } else
    p->s.ptr = bp;
    1723:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1726:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1729:	89 10                	mov    %edx,(%eax)
  freep = p;
    172b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172e:	a3 e8 1e 00 00       	mov    %eax,0x1ee8
}
    1733:	c9                   	leave  
    1734:	c3                   	ret    

00001735 <morecore>:

static Header*
morecore(uint nu)
{
    1735:	55                   	push   %ebp
    1736:	89 e5                	mov    %esp,%ebp
    1738:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    173b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1742:	77 07                	ja     174b <morecore+0x16>
    nu = 4096;
    1744:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	c1 e0 03             	shl    $0x3,%eax
    1751:	89 04 24             	mov    %eax,(%esp)
    1754:	e8 27 fc ff ff       	call   1380 <sbrk>
    1759:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    175c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1760:	75 07                	jne    1769 <morecore+0x34>
    return 0;
    1762:	b8 00 00 00 00       	mov    $0x0,%eax
    1767:	eb 22                	jmp    178b <morecore+0x56>
  hp = (Header*)p;
    1769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    176f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1772:	8b 55 08             	mov    0x8(%ebp),%edx
    1775:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1778:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177b:	83 c0 08             	add    $0x8,%eax
    177e:	89 04 24             	mov    %eax,(%esp)
    1781:	e8 ce fe ff ff       	call   1654 <free>
  return freep;
    1786:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
}
    178b:	c9                   	leave  
    178c:	c3                   	ret    

0000178d <malloc>:

void*
malloc(uint nbytes)
{
    178d:	55                   	push   %ebp
    178e:	89 e5                	mov    %esp,%ebp
    1790:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1793:	8b 45 08             	mov    0x8(%ebp),%eax
    1796:	83 c0 07             	add    $0x7,%eax
    1799:	c1 e8 03             	shr    $0x3,%eax
    179c:	83 c0 01             	add    $0x1,%eax
    179f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    17a2:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    17a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17ae:	75 23                	jne    17d3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17b0:	c7 45 f0 e0 1e 00 00 	movl   $0x1ee0,-0x10(%ebp)
    17b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ba:	a3 e8 1e 00 00       	mov    %eax,0x1ee8
    17bf:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    17c4:	a3 e0 1e 00 00       	mov    %eax,0x1ee0
    base.s.size = 0;
    17c9:	c7 05 e4 1e 00 00 00 	movl   $0x0,0x1ee4
    17d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d6:	8b 00                	mov    (%eax),%eax
    17d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	8b 40 04             	mov    0x4(%eax),%eax
    17e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17e4:	72 4d                	jb     1833 <malloc+0xa6>
      if(p->s.size == nunits)
    17e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e9:	8b 40 04             	mov    0x4(%eax),%eax
    17ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17ef:	75 0c                	jne    17fd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f4:	8b 10                	mov    (%eax),%edx
    17f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f9:	89 10                	mov    %edx,(%eax)
    17fb:	eb 26                	jmp    1823 <malloc+0x96>
      else {
        p->s.size -= nunits;
    17fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1800:	8b 40 04             	mov    0x4(%eax),%eax
    1803:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1806:	89 c2                	mov    %eax,%edx
    1808:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1811:	8b 40 04             	mov    0x4(%eax),%eax
    1814:	c1 e0 03             	shl    $0x3,%eax
    1817:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1820:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1823:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1826:	a3 e8 1e 00 00       	mov    %eax,0x1ee8
      return (void*)(p + 1);
    182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182e:	83 c0 08             	add    $0x8,%eax
    1831:	eb 38                	jmp    186b <malloc+0xde>
    }
    if(p == freep)
    1833:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    1838:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    183b:	75 1b                	jne    1858 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    183d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1840:	89 04 24             	mov    %eax,(%esp)
    1843:	e8 ed fe ff ff       	call   1735 <morecore>
    1848:	89 45 f4             	mov    %eax,-0xc(%ebp)
    184b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    184f:	75 07                	jne    1858 <malloc+0xcb>
        return 0;
    1851:	b8 00 00 00 00       	mov    $0x0,%eax
    1856:	eb 13                	jmp    186b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1858:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1861:	8b 00                	mov    (%eax),%eax
    1863:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1866:	e9 70 ff ff ff       	jmp    17db <malloc+0x4e>
}
    186b:	c9                   	leave  
    186c:	c3                   	ret    
    186d:	66 90                	xchg   %ax,%ax
    186f:	90                   	nop

00001870 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1876:	8b 55 08             	mov    0x8(%ebp),%edx
    1879:	8b 45 0c             	mov    0xc(%ebp),%eax
    187c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    187f:	f0 87 02             	lock xchg %eax,(%edx)
    1882:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1885:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1888:	c9                   	leave  
    1889:	c3                   	ret    

0000188a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    188a:	55                   	push   %ebp
    188b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    188d:	8b 45 08             	mov    0x8(%ebp),%eax
    1890:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1896:	5d                   	pop    %ebp
    1897:	c3                   	ret    

00001898 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1898:	55                   	push   %ebp
    1899:	89 e5                	mov    %esp,%ebp
    189b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    189e:	90                   	nop
    189f:	8b 45 08             	mov    0x8(%ebp),%eax
    18a2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18a9:	00 
    18aa:	89 04 24             	mov    %eax,(%esp)
    18ad:	e8 be ff ff ff       	call   1870 <xchg>
    18b2:	85 c0                	test   %eax,%eax
    18b4:	75 e9                	jne    189f <lock_acquire+0x7>
}
    18b6:	c9                   	leave  
    18b7:	c3                   	ret    

000018b8 <lock_release>:
void lock_release(lock_t *lock){
    18b8:	55                   	push   %ebp
    18b9:	89 e5                	mov    %esp,%ebp
    18bb:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18c8:	00 
    18c9:	89 04 24             	mov    %eax,(%esp)
    18cc:	e8 9f ff ff ff       	call   1870 <xchg>
}
    18d1:	c9                   	leave  
    18d2:	c3                   	ret    

000018d3 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18d3:	55                   	push   %ebp
    18d4:	89 e5                	mov    %esp,%ebp
    18d6:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18d9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18e0:	e8 a8 fe ff ff       	call   178d <malloc>
    18e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f1:	25 ff 0f 00 00       	and    $0xfff,%eax
    18f6:	85 c0                	test   %eax,%eax
    18f8:	74 14                	je     190e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fd:	25 ff 0f 00 00       	and    $0xfff,%eax
    1902:	89 c2                	mov    %eax,%edx
    1904:	b8 00 10 00 00       	mov    $0x1000,%eax
    1909:	29 d0                	sub    %edx,%eax
    190b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    190e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1912:	75 1b                	jne    192f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1914:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    191b:	00 
    191c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1923:	e8 78 fb ff ff       	call   14a0 <printf>
        return 0;
    1928:	b8 00 00 00 00       	mov    $0x0,%eax
    192d:	eb 6f                	jmp    199e <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    192f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1932:	8b 55 08             	mov    0x8(%ebp),%edx
    1935:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1938:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    193c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1940:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1947:	00 
    1948:	89 04 24             	mov    %eax,(%esp)
    194b:	e8 48 fa ff ff       	call   1398 <clone>
    1950:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1953:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1957:	79 1b                	jns    1974 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1959:	c7 44 24 04 23 1b 00 	movl   $0x1b23,0x4(%esp)
    1960:	00 
    1961:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1968:	e8 33 fb ff ff       	call   14a0 <printf>
        return 0;
    196d:	b8 00 00 00 00       	mov    $0x0,%eax
    1972:	eb 2a                	jmp    199e <thread_create+0xcb>
    }
    if(tid > 0){
    1974:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1978:	7e 05                	jle    197f <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    197a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    197d:	eb 1f                	jmp    199e <thread_create+0xcb>
    }
    if(tid == 0){
    197f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1983:	75 14                	jne    1999 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1985:	c7 44 24 04 30 1b 00 	movl   $0x1b30,0x4(%esp)
    198c:	00 
    198d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1994:	e8 07 fb ff ff       	call   14a0 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1999:	b8 00 00 00 00       	mov    $0x0,%eax
}
    199e:	c9                   	leave  
    199f:	c3                   	ret    

000019a0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19a0:	55                   	push   %ebp
    19a1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19a3:	a1 dc 1e 00 00       	mov    0x1edc,%eax
    19a8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19ae:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19b3:	a3 dc 1e 00 00       	mov    %eax,0x1edc
    return (int)(rands % max);
    19b8:	a1 dc 1e 00 00       	mov    0x1edc,%eax
    19bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19c0:	ba 00 00 00 00       	mov    $0x0,%edx
    19c5:	f7 f1                	div    %ecx
    19c7:	89 d0                	mov    %edx,%eax
}
    19c9:	5d                   	pop    %ebp
    19ca:	c3                   	ret    
    19cb:	90                   	nop

000019cc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19cc:	55                   	push   %ebp
    19cd:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19cf:	8b 45 08             	mov    0x8(%ebp),%eax
    19d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19d8:	8b 45 08             	mov    0x8(%ebp),%eax
    19db:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19e2:	8b 45 08             	mov    0x8(%ebp),%eax
    19e5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19ec:	5d                   	pop    %ebp
    19ed:	c3                   	ret    

000019ee <add_q>:

void add_q(struct queue *q, int v){
    19ee:	55                   	push   %ebp
    19ef:	89 e5                	mov    %esp,%ebp
    19f1:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19f4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19fb:	e8 8d fd ff ff       	call   178d <malloc>
    1a00:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a06:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a10:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a13:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a15:	8b 45 08             	mov    0x8(%ebp),%eax
    1a18:	8b 40 04             	mov    0x4(%eax),%eax
    1a1b:	85 c0                	test   %eax,%eax
    1a1d:	75 0b                	jne    1a2a <add_q+0x3c>
        q->head = n;
    1a1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a22:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a25:	89 50 04             	mov    %edx,0x4(%eax)
    1a28:	eb 0c                	jmp    1a36 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	8b 40 08             	mov    0x8(%eax),%eax
    1a30:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a33:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a36:	8b 45 08             	mov    0x8(%ebp),%eax
    1a39:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a3c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a42:	8b 00                	mov    (%eax),%eax
    1a44:	8d 50 01             	lea    0x1(%eax),%edx
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	89 10                	mov    %edx,(%eax)
}
    1a4c:	c9                   	leave  
    1a4d:	c3                   	ret    

00001a4e <empty_q>:

int empty_q(struct queue *q){
    1a4e:	55                   	push   %ebp
    1a4f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a51:	8b 45 08             	mov    0x8(%ebp),%eax
    1a54:	8b 00                	mov    (%eax),%eax
    1a56:	85 c0                	test   %eax,%eax
    1a58:	75 07                	jne    1a61 <empty_q+0x13>
        return 1;
    1a5a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a5f:	eb 05                	jmp    1a66 <empty_q+0x18>
    else
        return 0;
    1a61:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a66:	5d                   	pop    %ebp
    1a67:	c3                   	ret    

00001a68 <pop_q>:
int pop_q(struct queue *q){
    1a68:	55                   	push   %ebp
    1a69:	89 e5                	mov    %esp,%ebp
    1a6b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a71:	89 04 24             	mov    %eax,(%esp)
    1a74:	e8 d5 ff ff ff       	call   1a4e <empty_q>
    1a79:	85 c0                	test   %eax,%eax
    1a7b:	75 5d                	jne    1ada <pop_q+0x72>
       val = q->head->value; 
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	8b 40 04             	mov    0x4(%eax),%eax
    1a83:	8b 00                	mov    (%eax),%eax
    1a85:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a88:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8b:	8b 40 04             	mov    0x4(%eax),%eax
    1a8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a91:	8b 45 08             	mov    0x8(%ebp),%eax
    1a94:	8b 40 04             	mov    0x4(%eax),%eax
    1a97:	8b 50 04             	mov    0x4(%eax),%edx
    1a9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aa3:	89 04 24             	mov    %eax,(%esp)
    1aa6:	e8 a9 fb ff ff       	call   1654 <free>
       q->size--;
    1aab:	8b 45 08             	mov    0x8(%ebp),%eax
    1aae:	8b 00                	mov    (%eax),%eax
    1ab0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ab8:	8b 45 08             	mov    0x8(%ebp),%eax
    1abb:	8b 00                	mov    (%eax),%eax
    1abd:	85 c0                	test   %eax,%eax
    1abf:	75 14                	jne    1ad5 <pop_q+0x6d>
            q->head = 0;
    1ac1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1acb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ace:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad8:	eb 05                	jmp    1adf <pop_q+0x77>
    }
    return -1;
    1ada:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1adf:	c9                   	leave  
    1ae0:	c3                   	ret    
