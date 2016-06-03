
_ln:     file format elf32-i386


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
    1006:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
    1009:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    100d:	74 19                	je     1028 <main+0x28>
    printf(2, "Usage: ln old new\n");
    100f:	c7 44 24 04 cd 1a 00 	movl   $0x1acd,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 69 04 00 00       	call   148c <printf>
    exit();
    1023:	e8 bc 02 00 00       	call   12e4 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
    1028:	8b 45 0c             	mov    0xc(%ebp),%eax
    102b:	83 c0 08             	add    $0x8,%eax
    102e:	8b 10                	mov    (%eax),%edx
    1030:	8b 45 0c             	mov    0xc(%ebp),%eax
    1033:	83 c0 04             	add    $0x4,%eax
    1036:	8b 00                	mov    (%eax),%eax
    1038:	89 54 24 04          	mov    %edx,0x4(%esp)
    103c:	89 04 24             	mov    %eax,(%esp)
    103f:	e8 00 03 00 00       	call   1344 <link>
    1044:	85 c0                	test   %eax,%eax
    1046:	79 2c                	jns    1074 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1048:	8b 45 0c             	mov    0xc(%ebp),%eax
    104b:	83 c0 08             	add    $0x8,%eax
    104e:	8b 10                	mov    (%eax),%edx
    1050:	8b 45 0c             	mov    0xc(%ebp),%eax
    1053:	83 c0 04             	add    $0x4,%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	89 54 24 0c          	mov    %edx,0xc(%esp)
    105c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1060:	c7 44 24 04 e0 1a 00 	movl   $0x1ae0,0x4(%esp)
    1067:	00 
    1068:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    106f:	e8 18 04 00 00       	call   148c <printf>
  exit();
    1074:	e8 6b 02 00 00       	call   12e4 <exit>
    1079:	66 90                	xchg   %ax,%ax
    107b:	90                   	nop

0000107c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	57                   	push   %edi
    1080:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1081:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1084:	8b 55 10             	mov    0x10(%ebp),%edx
    1087:	8b 45 0c             	mov    0xc(%ebp),%eax
    108a:	89 cb                	mov    %ecx,%ebx
    108c:	89 df                	mov    %ebx,%edi
    108e:	89 d1                	mov    %edx,%ecx
    1090:	fc                   	cld    
    1091:	f3 aa                	rep stos %al,%es:(%edi)
    1093:	89 ca                	mov    %ecx,%edx
    1095:	89 fb                	mov    %edi,%ebx
    1097:	89 5d 08             	mov    %ebx,0x8(%ebp)
    109a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    109d:	5b                   	pop    %ebx
    109e:	5f                   	pop    %edi
    109f:	5d                   	pop    %ebp
    10a0:	c3                   	ret    

000010a1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10a7:	8b 45 08             	mov    0x8(%ebp),%eax
    10aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10ad:	90                   	nop
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	8d 50 01             	lea    0x1(%eax),%edx
    10b4:	89 55 08             	mov    %edx,0x8(%ebp)
    10b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ba:	8d 4a 01             	lea    0x1(%edx),%ecx
    10bd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10c0:	0f b6 12             	movzbl (%edx),%edx
    10c3:	88 10                	mov    %dl,(%eax)
    10c5:	0f b6 00             	movzbl (%eax),%eax
    10c8:	84 c0                	test   %al,%al
    10ca:	75 e2                	jne    10ae <strcpy+0xd>
    ;
  return os;
    10cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10cf:	c9                   	leave  
    10d0:	c3                   	ret    

000010d1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d1:	55                   	push   %ebp
    10d2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10d4:	eb 08                	jmp    10de <strcmp+0xd>
    p++, q++;
    10d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10da:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10de:	8b 45 08             	mov    0x8(%ebp),%eax
    10e1:	0f b6 00             	movzbl (%eax),%eax
    10e4:	84 c0                	test   %al,%al
    10e6:	74 10                	je     10f8 <strcmp+0x27>
    10e8:	8b 45 08             	mov    0x8(%ebp),%eax
    10eb:	0f b6 10             	movzbl (%eax),%edx
    10ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f1:	0f b6 00             	movzbl (%eax),%eax
    10f4:	38 c2                	cmp    %al,%dl
    10f6:	74 de                	je     10d6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10f8:	8b 45 08             	mov    0x8(%ebp),%eax
    10fb:	0f b6 00             	movzbl (%eax),%eax
    10fe:	0f b6 d0             	movzbl %al,%edx
    1101:	8b 45 0c             	mov    0xc(%ebp),%eax
    1104:	0f b6 00             	movzbl (%eax),%eax
    1107:	0f b6 c0             	movzbl %al,%eax
    110a:	29 c2                	sub    %eax,%edx
    110c:	89 d0                	mov    %edx,%eax
}
    110e:	5d                   	pop    %ebp
    110f:	c3                   	ret    

00001110 <strlen>:

uint
strlen(char *s)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    111d:	eb 04                	jmp    1123 <strlen+0x13>
    111f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1123:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	01 d0                	add    %edx,%eax
    112b:	0f b6 00             	movzbl (%eax),%eax
    112e:	84 c0                	test   %al,%al
    1130:	75 ed                	jne    111f <strlen+0xf>
    ;
  return n;
    1132:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1135:	c9                   	leave  
    1136:	c3                   	ret    

00001137 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1137:	55                   	push   %ebp
    1138:	89 e5                	mov    %esp,%ebp
    113a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    113d:	8b 45 10             	mov    0x10(%ebp),%eax
    1140:	89 44 24 08          	mov    %eax,0x8(%esp)
    1144:	8b 45 0c             	mov    0xc(%ebp),%eax
    1147:	89 44 24 04          	mov    %eax,0x4(%esp)
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	89 04 24             	mov    %eax,(%esp)
    1151:	e8 26 ff ff ff       	call   107c <stosb>
  return dst;
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1159:	c9                   	leave  
    115a:	c3                   	ret    

0000115b <strchr>:

char*
strchr(const char *s, char c)
{
    115b:	55                   	push   %ebp
    115c:	89 e5                	mov    %esp,%ebp
    115e:	83 ec 04             	sub    $0x4,%esp
    1161:	8b 45 0c             	mov    0xc(%ebp),%eax
    1164:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1167:	eb 14                	jmp    117d <strchr+0x22>
    if(*s == c)
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	0f b6 00             	movzbl (%eax),%eax
    116f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1172:	75 05                	jne    1179 <strchr+0x1e>
      return (char*)s;
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	eb 13                	jmp    118c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1179:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	84 c0                	test   %al,%al
    1185:	75 e2                	jne    1169 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1187:	b8 00 00 00 00       	mov    $0x0,%eax
}
    118c:	c9                   	leave  
    118d:	c3                   	ret    

0000118e <gets>:

char*
gets(char *buf, int max)
{
    118e:	55                   	push   %ebp
    118f:	89 e5                	mov    %esp,%ebp
    1191:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    119b:	eb 4c                	jmp    11e9 <gets+0x5b>
    cc = read(0, &c, 1);
    119d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11a4:	00 
    11a5:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11b3:	e8 44 01 00 00       	call   12fc <read>
    11b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11bf:	7f 02                	jg     11c3 <gets+0x35>
      break;
    11c1:	eb 31                	jmp    11f4 <gets+0x66>
    buf[i++] = c;
    11c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c6:	8d 50 01             	lea    0x1(%eax),%edx
    11c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11cc:	89 c2                	mov    %eax,%edx
    11ce:	8b 45 08             	mov    0x8(%ebp),%eax
    11d1:	01 c2                	add    %eax,%edx
    11d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11dd:	3c 0a                	cmp    $0xa,%al
    11df:	74 13                	je     11f4 <gets+0x66>
    11e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e5:	3c 0d                	cmp    $0xd,%al
    11e7:	74 0b                	je     11f4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ec:	83 c0 01             	add    $0x1,%eax
    11ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f2:	7c a9                	jl     119d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f7:	8b 45 08             	mov    0x8(%ebp),%eax
    11fa:	01 d0                	add    %edx,%eax
    11fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1202:	c9                   	leave  
    1203:	c3                   	ret    

00001204 <stat>:

int
stat(char *n, struct stat *st)
{
    1204:	55                   	push   %ebp
    1205:	89 e5                	mov    %esp,%ebp
    1207:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    120a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1211:	00 
    1212:	8b 45 08             	mov    0x8(%ebp),%eax
    1215:	89 04 24             	mov    %eax,(%esp)
    1218:	e8 07 01 00 00       	call   1324 <open>
    121d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1220:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1224:	79 07                	jns    122d <stat+0x29>
    return -1;
    1226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    122b:	eb 23                	jmp    1250 <stat+0x4c>
  r = fstat(fd, st);
    122d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1230:	89 44 24 04          	mov    %eax,0x4(%esp)
    1234:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1237:	89 04 24             	mov    %eax,(%esp)
    123a:	e8 fd 00 00 00       	call   133c <fstat>
    123f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1242:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1245:	89 04 24             	mov    %eax,(%esp)
    1248:	e8 bf 00 00 00       	call   130c <close>
  return r;
    124d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1250:	c9                   	leave  
    1251:	c3                   	ret    

00001252 <atoi>:

int
atoi(const char *s)
{
    1252:	55                   	push   %ebp
    1253:	89 e5                	mov    %esp,%ebp
    1255:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    125f:	eb 25                	jmp    1286 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1261:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1264:	89 d0                	mov    %edx,%eax
    1266:	c1 e0 02             	shl    $0x2,%eax
    1269:	01 d0                	add    %edx,%eax
    126b:	01 c0                	add    %eax,%eax
    126d:	89 c1                	mov    %eax,%ecx
    126f:	8b 45 08             	mov    0x8(%ebp),%eax
    1272:	8d 50 01             	lea    0x1(%eax),%edx
    1275:	89 55 08             	mov    %edx,0x8(%ebp)
    1278:	0f b6 00             	movzbl (%eax),%eax
    127b:	0f be c0             	movsbl %al,%eax
    127e:	01 c8                	add    %ecx,%eax
    1280:	83 e8 30             	sub    $0x30,%eax
    1283:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	0f b6 00             	movzbl (%eax),%eax
    128c:	3c 2f                	cmp    $0x2f,%al
    128e:	7e 0a                	jle    129a <atoi+0x48>
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	0f b6 00             	movzbl (%eax),%eax
    1296:	3c 39                	cmp    $0x39,%al
    1298:	7e c7                	jle    1261 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    129a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    129d:	c9                   	leave  
    129e:	c3                   	ret    

0000129f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    129f:	55                   	push   %ebp
    12a0:	89 e5                	mov    %esp,%ebp
    12a2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12a5:	8b 45 08             	mov    0x8(%ebp),%eax
    12a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12b1:	eb 17                	jmp    12ca <memmove+0x2b>
    *dst++ = *src++;
    12b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b6:	8d 50 01             	lea    0x1(%eax),%edx
    12b9:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12bf:	8d 4a 01             	lea    0x1(%edx),%ecx
    12c2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12c5:	0f b6 12             	movzbl (%edx),%edx
    12c8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ca:	8b 45 10             	mov    0x10(%ebp),%eax
    12cd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12d0:	89 55 10             	mov    %edx,0x10(%ebp)
    12d3:	85 c0                	test   %eax,%eax
    12d5:	7f dc                	jg     12b3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12da:	c9                   	leave  
    12db:	c3                   	ret    

000012dc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12dc:	b8 01 00 00 00       	mov    $0x1,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <exit>:
SYSCALL(exit)
    12e4:	b8 02 00 00 00       	mov    $0x2,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <wait>:
SYSCALL(wait)
    12ec:	b8 03 00 00 00       	mov    $0x3,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <pipe>:
SYSCALL(pipe)
    12f4:	b8 04 00 00 00       	mov    $0x4,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <read>:
SYSCALL(read)
    12fc:	b8 05 00 00 00       	mov    $0x5,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <write>:
SYSCALL(write)
    1304:	b8 10 00 00 00       	mov    $0x10,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <close>:
SYSCALL(close)
    130c:	b8 15 00 00 00       	mov    $0x15,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <kill>:
SYSCALL(kill)
    1314:	b8 06 00 00 00       	mov    $0x6,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <exec>:
SYSCALL(exec)
    131c:	b8 07 00 00 00       	mov    $0x7,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <open>:
SYSCALL(open)
    1324:	b8 0f 00 00 00       	mov    $0xf,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <mknod>:
SYSCALL(mknod)
    132c:	b8 11 00 00 00       	mov    $0x11,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <unlink>:
SYSCALL(unlink)
    1334:	b8 12 00 00 00       	mov    $0x12,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <fstat>:
SYSCALL(fstat)
    133c:	b8 08 00 00 00       	mov    $0x8,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <link>:
SYSCALL(link)
    1344:	b8 13 00 00 00       	mov    $0x13,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <mkdir>:
SYSCALL(mkdir)
    134c:	b8 14 00 00 00       	mov    $0x14,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <chdir>:
SYSCALL(chdir)
    1354:	b8 09 00 00 00       	mov    $0x9,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <dup>:
SYSCALL(dup)
    135c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <getpid>:
SYSCALL(getpid)
    1364:	b8 0b 00 00 00       	mov    $0xb,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <sbrk>:
SYSCALL(sbrk)
    136c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <sleep>:
SYSCALL(sleep)
    1374:	b8 0d 00 00 00       	mov    $0xd,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <uptime>:
SYSCALL(uptime)
    137c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <clone>:
SYSCALL(clone)
    1384:	b8 16 00 00 00       	mov    $0x16,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <texit>:
SYSCALL(texit)
    138c:	b8 17 00 00 00       	mov    $0x17,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <tsleep>:
SYSCALL(tsleep)
    1394:	b8 18 00 00 00       	mov    $0x18,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <twakeup>:
SYSCALL(twakeup)
    139c:	b8 19 00 00 00       	mov    $0x19,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <thread_yield>:
SYSCALL(thread_yield)
    13a4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	83 ec 18             	sub    $0x18,%esp
    13b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13bf:	00 
    13c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13c3:	89 44 24 04          	mov    %eax,0x4(%esp)
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	89 04 24             	mov    %eax,(%esp)
    13cd:	e8 32 ff ff ff       	call   1304 <write>
}
    13d2:	c9                   	leave  
    13d3:	c3                   	ret    

000013d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13d4:	55                   	push   %ebp
    13d5:	89 e5                	mov    %esp,%ebp
    13d7:	56                   	push   %esi
    13d8:	53                   	push   %ebx
    13d9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13e3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13e7:	74 17                	je     1400 <printint+0x2c>
    13e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13ed:	79 11                	jns    1400 <printint+0x2c>
    neg = 1;
    13ef:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f9:	f7 d8                	neg    %eax
    13fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13fe:	eb 06                	jmp    1406 <printint+0x32>
  } else {
    x = xx;
    1400:	8b 45 0c             	mov    0xc(%ebp),%eax
    1403:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1406:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    140d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1410:	8d 41 01             	lea    0x1(%ecx),%eax
    1413:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1416:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1419:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141c:	ba 00 00 00 00       	mov    $0x0,%edx
    1421:	f7 f3                	div    %ebx
    1423:	89 d0                	mov    %edx,%eax
    1425:	0f b6 80 ac 1e 00 00 	movzbl 0x1eac(%eax),%eax
    142c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1430:	8b 75 10             	mov    0x10(%ebp),%esi
    1433:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1436:	ba 00 00 00 00       	mov    $0x0,%edx
    143b:	f7 f6                	div    %esi
    143d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1440:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1444:	75 c7                	jne    140d <printint+0x39>
  if(neg)
    1446:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    144a:	74 10                	je     145c <printint+0x88>
    buf[i++] = '-';
    144c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144f:	8d 50 01             	lea    0x1(%eax),%edx
    1452:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1455:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    145a:	eb 1f                	jmp    147b <printint+0xa7>
    145c:	eb 1d                	jmp    147b <printint+0xa7>
    putc(fd, buf[i]);
    145e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1461:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1464:	01 d0                	add    %edx,%eax
    1466:	0f b6 00             	movzbl (%eax),%eax
    1469:	0f be c0             	movsbl %al,%eax
    146c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	89 04 24             	mov    %eax,(%esp)
    1476:	e8 31 ff ff ff       	call   13ac <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    147b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    147f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1483:	79 d9                	jns    145e <printint+0x8a>
    putc(fd, buf[i]);
}
    1485:	83 c4 30             	add    $0x30,%esp
    1488:	5b                   	pop    %ebx
    1489:	5e                   	pop    %esi
    148a:	5d                   	pop    %ebp
    148b:	c3                   	ret    

0000148c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    148c:	55                   	push   %ebp
    148d:	89 e5                	mov    %esp,%ebp
    148f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1499:	8d 45 0c             	lea    0xc(%ebp),%eax
    149c:	83 c0 04             	add    $0x4,%eax
    149f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14a9:	e9 7c 01 00 00       	jmp    162a <printf+0x19e>
    c = fmt[i] & 0xff;
    14ae:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14b4:	01 d0                	add    %edx,%eax
    14b6:	0f b6 00             	movzbl (%eax),%eax
    14b9:	0f be c0             	movsbl %al,%eax
    14bc:	25 ff 00 00 00       	and    $0xff,%eax
    14c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14c8:	75 2c                	jne    14f6 <printf+0x6a>
      if(c == '%'){
    14ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14ce:	75 0c                	jne    14dc <printf+0x50>
        state = '%';
    14d0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14d7:	e9 4a 01 00 00       	jmp    1626 <printf+0x19a>
      } else {
        putc(fd, c);
    14dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14df:	0f be c0             	movsbl %al,%eax
    14e2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e6:	8b 45 08             	mov    0x8(%ebp),%eax
    14e9:	89 04 24             	mov    %eax,(%esp)
    14ec:	e8 bb fe ff ff       	call   13ac <putc>
    14f1:	e9 30 01 00 00       	jmp    1626 <printf+0x19a>
      }
    } else if(state == '%'){
    14f6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14fa:	0f 85 26 01 00 00    	jne    1626 <printf+0x19a>
      if(c == 'd'){
    1500:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1504:	75 2d                	jne    1533 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1506:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1509:	8b 00                	mov    (%eax),%eax
    150b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1512:	00 
    1513:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    151a:	00 
    151b:	89 44 24 04          	mov    %eax,0x4(%esp)
    151f:	8b 45 08             	mov    0x8(%ebp),%eax
    1522:	89 04 24             	mov    %eax,(%esp)
    1525:	e8 aa fe ff ff       	call   13d4 <printint>
        ap++;
    152a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    152e:	e9 ec 00 00 00       	jmp    161f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1533:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1537:	74 06                	je     153f <printf+0xb3>
    1539:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    153d:	75 2d                	jne    156c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    153f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1542:	8b 00                	mov    (%eax),%eax
    1544:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    154b:	00 
    154c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1553:	00 
    1554:	89 44 24 04          	mov    %eax,0x4(%esp)
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	89 04 24             	mov    %eax,(%esp)
    155e:	e8 71 fe ff ff       	call   13d4 <printint>
        ap++;
    1563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1567:	e9 b3 00 00 00       	jmp    161f <printf+0x193>
      } else if(c == 's'){
    156c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1570:	75 45                	jne    15b7 <printf+0x12b>
        s = (char*)*ap;
    1572:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1575:	8b 00                	mov    (%eax),%eax
    1577:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    157a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    157e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1582:	75 09                	jne    158d <printf+0x101>
          s = "(null)";
    1584:	c7 45 f4 f4 1a 00 00 	movl   $0x1af4,-0xc(%ebp)
        while(*s != 0){
    158b:	eb 1e                	jmp    15ab <printf+0x11f>
    158d:	eb 1c                	jmp    15ab <printf+0x11f>
          putc(fd, *s);
    158f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1592:	0f b6 00             	movzbl (%eax),%eax
    1595:	0f be c0             	movsbl %al,%eax
    1598:	89 44 24 04          	mov    %eax,0x4(%esp)
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	89 04 24             	mov    %eax,(%esp)
    15a2:	e8 05 fe ff ff       	call   13ac <putc>
          s++;
    15a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ae:	0f b6 00             	movzbl (%eax),%eax
    15b1:	84 c0                	test   %al,%al
    15b3:	75 da                	jne    158f <printf+0x103>
    15b5:	eb 68                	jmp    161f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15bb:	75 1d                	jne    15da <printf+0x14e>
        putc(fd, *ap);
    15bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c0:	8b 00                	mov    (%eax),%eax
    15c2:	0f be c0             	movsbl %al,%eax
    15c5:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
    15cc:	89 04 24             	mov    %eax,(%esp)
    15cf:	e8 d8 fd ff ff       	call   13ac <putc>
        ap++;
    15d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15d8:	eb 45                	jmp    161f <printf+0x193>
      } else if(c == '%'){
    15da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15de:	75 17                	jne    15f7 <printf+0x16b>
        putc(fd, c);
    15e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15e3:	0f be c0             	movsbl %al,%eax
    15e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ea:	8b 45 08             	mov    0x8(%ebp),%eax
    15ed:	89 04 24             	mov    %eax,(%esp)
    15f0:	e8 b7 fd ff ff       	call   13ac <putc>
    15f5:	eb 28                	jmp    161f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15f7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15fe:	00 
    15ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1602:	89 04 24             	mov    %eax,(%esp)
    1605:	e8 a2 fd ff ff       	call   13ac <putc>
        putc(fd, c);
    160a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    160d:	0f be c0             	movsbl %al,%eax
    1610:	89 44 24 04          	mov    %eax,0x4(%esp)
    1614:	8b 45 08             	mov    0x8(%ebp),%eax
    1617:	89 04 24             	mov    %eax,(%esp)
    161a:	e8 8d fd ff ff       	call   13ac <putc>
      }
      state = 0;
    161f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1626:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    162a:	8b 55 0c             	mov    0xc(%ebp),%edx
    162d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1630:	01 d0                	add    %edx,%eax
    1632:	0f b6 00             	movzbl (%eax),%eax
    1635:	84 c0                	test   %al,%al
    1637:	0f 85 71 fe ff ff    	jne    14ae <printf+0x22>
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
    164f:	a1 cc 1e 00 00       	mov    0x1ecc,%eax
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
    1695:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    169c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169f:	01 c2                	add    %eax,%edx
    16a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	39 c2                	cmp    %eax,%edx
    16a8:	75 24                	jne    16ce <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    16aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ad:	8b 50 04             	mov    0x4(%eax),%edx
    16b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b3:	8b 00                	mov    (%eax),%eax
    16b5:	8b 40 04             	mov    0x4(%eax),%eax
    16b8:	01 c2                	add    %eax,%edx
    16ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c3:	8b 00                	mov    (%eax),%eax
    16c5:	8b 10                	mov    (%eax),%edx
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	89 10                	mov    %edx,(%eax)
    16cc:	eb 0a                	jmp    16d8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    16ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d1:	8b 10                	mov    (%eax),%edx
    16d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16db:	8b 40 04             	mov    0x4(%eax),%eax
    16de:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e8:	01 d0                	add    %edx,%eax
    16ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ed:	75 20                	jne    170f <free+0xcf>
    p->s.size += bp->s.size;
    16ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f2:	8b 50 04             	mov    0x4(%eax),%edx
    16f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f8:	8b 40 04             	mov    0x4(%eax),%eax
    16fb:	01 c2                	add    %eax,%edx
    16fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1700:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1703:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1706:	8b 10                	mov    (%eax),%edx
    1708:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170b:	89 10                	mov    %edx,(%eax)
    170d:	eb 08                	jmp    1717 <free+0xd7>
  } else
    p->s.ptr = bp;
    170f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1712:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1715:	89 10                	mov    %edx,(%eax)
  freep = p;
    1717:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171a:	a3 cc 1e 00 00       	mov    %eax,0x1ecc
}
    171f:	c9                   	leave  
    1720:	c3                   	ret    

00001721 <morecore>:

static Header*
morecore(uint nu)
{
    1721:	55                   	push   %ebp
    1722:	89 e5                	mov    %esp,%ebp
    1724:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1727:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    172e:	77 07                	ja     1737 <morecore+0x16>
    nu = 4096;
    1730:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1737:	8b 45 08             	mov    0x8(%ebp),%eax
    173a:	c1 e0 03             	shl    $0x3,%eax
    173d:	89 04 24             	mov    %eax,(%esp)
    1740:	e8 27 fc ff ff       	call   136c <sbrk>
    1745:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1748:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    174c:	75 07                	jne    1755 <morecore+0x34>
    return 0;
    174e:	b8 00 00 00 00       	mov    $0x0,%eax
    1753:	eb 22                	jmp    1777 <morecore+0x56>
  hp = (Header*)p;
    1755:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1758:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    175b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    175e:	8b 55 08             	mov    0x8(%ebp),%edx
    1761:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1764:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1767:	83 c0 08             	add    $0x8,%eax
    176a:	89 04 24             	mov    %eax,(%esp)
    176d:	e8 ce fe ff ff       	call   1640 <free>
  return freep;
    1772:	a1 cc 1e 00 00       	mov    0x1ecc,%eax
}
    1777:	c9                   	leave  
    1778:	c3                   	ret    

00001779 <malloc>:

void*
malloc(uint nbytes)
{
    1779:	55                   	push   %ebp
    177a:	89 e5                	mov    %esp,%ebp
    177c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    177f:	8b 45 08             	mov    0x8(%ebp),%eax
    1782:	83 c0 07             	add    $0x7,%eax
    1785:	c1 e8 03             	shr    $0x3,%eax
    1788:	83 c0 01             	add    $0x1,%eax
    178b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    178e:	a1 cc 1e 00 00       	mov    0x1ecc,%eax
    1793:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1796:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    179a:	75 23                	jne    17bf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    179c:	c7 45 f0 c4 1e 00 00 	movl   $0x1ec4,-0x10(%ebp)
    17a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a6:	a3 cc 1e 00 00       	mov    %eax,0x1ecc
    17ab:	a1 cc 1e 00 00       	mov    0x1ecc,%eax
    17b0:	a3 c4 1e 00 00       	mov    %eax,0x1ec4
    base.s.size = 0;
    17b5:	c7 05 c8 1e 00 00 00 	movl   $0x0,0x1ec8
    17bc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c2:	8b 00                	mov    (%eax),%eax
    17c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	8b 40 04             	mov    0x4(%eax),%eax
    17cd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17d0:	72 4d                	jb     181f <malloc+0xa6>
      if(p->s.size == nunits)
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d5:	8b 40 04             	mov    0x4(%eax),%eax
    17d8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17db:	75 0c                	jne    17e9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e0:	8b 10                	mov    (%eax),%edx
    17e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e5:	89 10                	mov    %edx,(%eax)
    17e7:	eb 26                	jmp    180f <malloc+0x96>
      else {
        p->s.size -= nunits;
    17e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ec:	8b 40 04             	mov    0x4(%eax),%eax
    17ef:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17f2:	89 c2                	mov    %eax,%edx
    17f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fd:	8b 40 04             	mov    0x4(%eax),%eax
    1800:	c1 e0 03             	shl    $0x3,%eax
    1803:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1806:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1809:	8b 55 ec             	mov    -0x14(%ebp),%edx
    180c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    180f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1812:	a3 cc 1e 00 00       	mov    %eax,0x1ecc
      return (void*)(p + 1);
    1817:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181a:	83 c0 08             	add    $0x8,%eax
    181d:	eb 38                	jmp    1857 <malloc+0xde>
    }
    if(p == freep)
    181f:	a1 cc 1e 00 00       	mov    0x1ecc,%eax
    1824:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1827:	75 1b                	jne    1844 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1829:	8b 45 ec             	mov    -0x14(%ebp),%eax
    182c:	89 04 24             	mov    %eax,(%esp)
    182f:	e8 ed fe ff ff       	call   1721 <morecore>
    1834:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1837:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    183b:	75 07                	jne    1844 <malloc+0xcb>
        return 0;
    183d:	b8 00 00 00 00       	mov    $0x0,%eax
    1842:	eb 13                	jmp    1857 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1844:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1847:	89 45 f0             	mov    %eax,-0x10(%ebp)
    184a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184d:	8b 00                	mov    (%eax),%eax
    184f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1852:	e9 70 ff ff ff       	jmp    17c7 <malloc+0x4e>
}
    1857:	c9                   	leave  
    1858:	c3                   	ret    
    1859:	66 90                	xchg   %ax,%ax
    185b:	90                   	nop

0000185c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    185c:	55                   	push   %ebp
    185d:	89 e5                	mov    %esp,%ebp
    185f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1862:	8b 55 08             	mov    0x8(%ebp),%edx
    1865:	8b 45 0c             	mov    0xc(%ebp),%eax
    1868:	8b 4d 08             	mov    0x8(%ebp),%ecx
    186b:	f0 87 02             	lock xchg %eax,(%edx)
    186e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1871:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1874:	c9                   	leave  
    1875:	c3                   	ret    

00001876 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1876:	55                   	push   %ebp
    1877:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1879:	8b 45 08             	mov    0x8(%ebp),%eax
    187c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1882:	5d                   	pop    %ebp
    1883:	c3                   	ret    

00001884 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1884:	55                   	push   %ebp
    1885:	89 e5                	mov    %esp,%ebp
    1887:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    188a:	90                   	nop
    188b:	8b 45 08             	mov    0x8(%ebp),%eax
    188e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1895:	00 
    1896:	89 04 24             	mov    %eax,(%esp)
    1899:	e8 be ff ff ff       	call   185c <xchg>
    189e:	85 c0                	test   %eax,%eax
    18a0:	75 e9                	jne    188b <lock_acquire+0x7>
}
    18a2:	c9                   	leave  
    18a3:	c3                   	ret    

000018a4 <lock_release>:
void lock_release(lock_t *lock){
    18a4:	55                   	push   %ebp
    18a5:	89 e5                	mov    %esp,%ebp
    18a7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18aa:	8b 45 08             	mov    0x8(%ebp),%eax
    18ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18b4:	00 
    18b5:	89 04 24             	mov    %eax,(%esp)
    18b8:	e8 9f ff ff ff       	call   185c <xchg>
}
    18bd:	c9                   	leave  
    18be:	c3                   	ret    

000018bf <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18bf:	55                   	push   %ebp
    18c0:	89 e5                	mov    %esp,%ebp
    18c2:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18c5:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18cc:	e8 a8 fe ff ff       	call   1779 <malloc>
    18d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18dd:	25 ff 0f 00 00       	and    $0xfff,%eax
    18e2:	85 c0                	test   %eax,%eax
    18e4:	74 14                	je     18fa <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ee:	89 c2                	mov    %eax,%edx
    18f0:	b8 00 10 00 00       	mov    $0x1000,%eax
    18f5:	29 d0                	sub    %edx,%eax
    18f7:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18fe:	75 1b                	jne    191b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1900:	c7 44 24 04 fb 1a 00 	movl   $0x1afb,0x4(%esp)
    1907:	00 
    1908:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190f:	e8 78 fb ff ff       	call   148c <printf>
        return 0;
    1914:	b8 00 00 00 00       	mov    $0x0,%eax
    1919:	eb 6f                	jmp    198a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    191b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    191e:	8b 55 08             	mov    0x8(%ebp),%edx
    1921:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1924:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1928:	89 54 24 08          	mov    %edx,0x8(%esp)
    192c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1933:	00 
    1934:	89 04 24             	mov    %eax,(%esp)
    1937:	e8 48 fa ff ff       	call   1384 <clone>
    193c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    193f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1943:	79 1b                	jns    1960 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1945:	c7 44 24 04 09 1b 00 	movl   $0x1b09,0x4(%esp)
    194c:	00 
    194d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1954:	e8 33 fb ff ff       	call   148c <printf>
        return 0;
    1959:	b8 00 00 00 00       	mov    $0x0,%eax
    195e:	eb 2a                	jmp    198a <thread_create+0xcb>
    }
    if(tid > 0){
    1960:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1964:	7e 05                	jle    196b <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1966:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1969:	eb 1f                	jmp    198a <thread_create+0xcb>
    }
    if(tid == 0){
    196b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    196f:	75 14                	jne    1985 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1971:	c7 44 24 04 16 1b 00 	movl   $0x1b16,0x4(%esp)
    1978:	00 
    1979:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1980:	e8 07 fb ff ff       	call   148c <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1985:	b8 00 00 00 00       	mov    $0x0,%eax
}
    198a:	c9                   	leave  
    198b:	c3                   	ret    

0000198c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    198c:	55                   	push   %ebp
    198d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    198f:	a1 c0 1e 00 00       	mov    0x1ec0,%eax
    1994:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    199a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    199f:	a3 c0 1e 00 00       	mov    %eax,0x1ec0
    return (int)(rands % max);
    19a4:	a1 c0 1e 00 00       	mov    0x1ec0,%eax
    19a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19ac:	ba 00 00 00 00       	mov    $0x0,%edx
    19b1:	f7 f1                	div    %ecx
    19b3:	89 d0                	mov    %edx,%eax
}
    19b5:	5d                   	pop    %ebp
    19b6:	c3                   	ret    
    19b7:	90                   	nop

000019b8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19b8:	55                   	push   %ebp
    19b9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19d8:	5d                   	pop    %ebp
    19d9:	c3                   	ret    

000019da <add_q>:

void add_q(struct queue *q, int v){
    19da:	55                   	push   %ebp
    19db:	89 e5                	mov    %esp,%ebp
    19dd:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19e0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19e7:	e8 8d fd ff ff       	call   1779 <malloc>
    19ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    19ff:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	8b 40 04             	mov    0x4(%eax),%eax
    1a07:	85 c0                	test   %eax,%eax
    1a09:	75 0b                	jne    1a16 <add_q+0x3c>
        q->head = n;
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a11:	89 50 04             	mov    %edx,0x4(%eax)
    1a14:	eb 0c                	jmp    1a22 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a16:	8b 45 08             	mov    0x8(%ebp),%eax
    1a19:	8b 40 08             	mov    0x8(%eax),%eax
    1a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a1f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a22:	8b 45 08             	mov    0x8(%ebp),%eax
    1a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a28:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2e:	8b 00                	mov    (%eax),%eax
    1a30:	8d 50 01             	lea    0x1(%eax),%edx
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	89 10                	mov    %edx,(%eax)
}
    1a38:	c9                   	leave  
    1a39:	c3                   	ret    

00001a3a <empty_q>:

int empty_q(struct queue *q){
    1a3a:	55                   	push   %ebp
    1a3b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a40:	8b 00                	mov    (%eax),%eax
    1a42:	85 c0                	test   %eax,%eax
    1a44:	75 07                	jne    1a4d <empty_q+0x13>
        return 1;
    1a46:	b8 01 00 00 00       	mov    $0x1,%eax
    1a4b:	eb 05                	jmp    1a52 <empty_q+0x18>
    else
        return 0;
    1a4d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a52:	5d                   	pop    %ebp
    1a53:	c3                   	ret    

00001a54 <pop_q>:
int pop_q(struct queue *q){
    1a54:	55                   	push   %ebp
    1a55:	89 e5                	mov    %esp,%ebp
    1a57:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5d:	89 04 24             	mov    %eax,(%esp)
    1a60:	e8 d5 ff ff ff       	call   1a3a <empty_q>
    1a65:	85 c0                	test   %eax,%eax
    1a67:	75 5d                	jne    1ac6 <pop_q+0x72>
       val = q->head->value; 
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8b 40 04             	mov    0x4(%eax),%eax
    1a6f:	8b 00                	mov    (%eax),%eax
    1a71:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a74:	8b 45 08             	mov    0x8(%ebp),%eax
    1a77:	8b 40 04             	mov    0x4(%eax),%eax
    1a7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	8b 40 04             	mov    0x4(%eax),%eax
    1a83:	8b 50 04             	mov    0x4(%eax),%edx
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a8f:	89 04 24             	mov    %eax,(%esp)
    1a92:	e8 a9 fb ff ff       	call   1640 <free>
       q->size--;
    1a97:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9a:	8b 00                	mov    (%eax),%eax
    1a9c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1aa4:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa7:	8b 00                	mov    (%eax),%eax
    1aa9:	85 c0                	test   %eax,%eax
    1aab:	75 14                	jne    1ac1 <pop_q+0x6d>
            q->head = 0;
    1aad:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ab7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aba:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac4:	eb 05                	jmp    1acb <pop_q+0x77>
    }
    return -1;
    1ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1acb:	c9                   	leave  
    1acc:	c3                   	ret    
