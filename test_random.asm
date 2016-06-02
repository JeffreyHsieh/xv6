
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
    1010:	e8 a3 09 00 00       	call   19b8 <random>
    1015:	89 44 24 08          	mov    %eax,0x8(%esp)
    1019:	c7 44 24 04 f9 1a 00 	movl   $0x1af9,0x4(%esp)
    1020:	00 
    1021:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1028:	e8 94 04 00 00       	call   14c1 <printf>
    printf(1,"random number %d\n",random(100));
    102d:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1034:	e8 7f 09 00 00       	call   19b8 <random>
    1039:	89 44 24 08          	mov    %eax,0x8(%esp)
    103d:	c7 44 24 04 f9 1a 00 	movl   $0x1af9,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104c:	e8 70 04 00 00       	call   14c1 <printf>
    printf(1,"random number %d\n",random(100));
    1051:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    1058:	e8 5b 09 00 00       	call   19b8 <random>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 f9 1a 00 	movl   $0x1af9,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 4c 04 00 00       	call   14c1 <printf>
    printf(1,"random number %d\n",random(100));
    1075:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    107c:	e8 37 09 00 00       	call   19b8 <random>
    1081:	89 44 24 08          	mov    %eax,0x8(%esp)
    1085:	c7 44 24 04 f9 1a 00 	movl   $0x1af9,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 28 04 00 00       	call   14c1 <printf>
    printf(1,"random number %d\n",random(100));
    1099:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    10a0:	e8 13 09 00 00       	call   19b8 <random>
    10a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    10a9:	c7 44 24 04 f9 1a 00 	movl   $0x1af9,0x4(%esp)
    10b0:	00 
    10b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b8:	e8 04 04 00 00       	call   14c1 <printf>

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
    1320:	b8 01 00 00 00       	mov    $0x1,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <exit>:
    1328:	b8 02 00 00 00       	mov    $0x2,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <wait>:
    1330:	b8 03 00 00 00       	mov    $0x3,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <pipe>:
    1338:	b8 04 00 00 00       	mov    $0x4,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <read>:
    1340:	b8 05 00 00 00       	mov    $0x5,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <write>:
    1348:	b8 10 00 00 00       	mov    $0x10,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <close>:
    1350:	b8 15 00 00 00       	mov    $0x15,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <kill>:
    1358:	b8 06 00 00 00       	mov    $0x6,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <exec>:
    1360:	b8 07 00 00 00       	mov    $0x7,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <open>:
    1368:	b8 0f 00 00 00       	mov    $0xf,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <mknod>:
    1370:	b8 11 00 00 00       	mov    $0x11,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <unlink>:
    1378:	b8 12 00 00 00       	mov    $0x12,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <fstat>:
    1380:	b8 08 00 00 00       	mov    $0x8,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <link>:
    1388:	b8 13 00 00 00       	mov    $0x13,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <mkdir>:
    1390:	b8 14 00 00 00       	mov    $0x14,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <chdir>:
    1398:	b8 09 00 00 00       	mov    $0x9,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <dup>:
    13a0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <getpid>:
    13a8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <sbrk>:
    13b0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <sleep>:
    13b8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <uptime>:
    13c0:	b8 0e 00 00 00       	mov    $0xe,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <clone>:
    13c8:	b8 16 00 00 00       	mov    $0x16,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <texit>:
    13d0:	b8 17 00 00 00       	mov    $0x17,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <tsleep>:
    13d8:	b8 18 00 00 00       	mov    $0x18,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <twakeup>:
    13e0:	b8 19 00 00 00       	mov    $0x19,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13e8:	55                   	push   %ebp
    13e9:	89 e5                	mov    %esp,%ebp
    13eb:	83 ec 28             	sub    $0x28,%esp
    13ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13fb:	00 
    13fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13ff:	89 44 24 04          	mov    %eax,0x4(%esp)
    1403:	8b 45 08             	mov    0x8(%ebp),%eax
    1406:	89 04 24             	mov    %eax,(%esp)
    1409:	e8 3a ff ff ff       	call   1348 <write>
}
    140e:	c9                   	leave  
    140f:	c3                   	ret    

00001410 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	53                   	push   %ebx
    1414:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1417:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    141e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1422:	74 17                	je     143b <printint+0x2b>
    1424:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1428:	79 11                	jns    143b <printint+0x2b>
    neg = 1;
    142a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1431:	8b 45 0c             	mov    0xc(%ebp),%eax
    1434:	f7 d8                	neg    %eax
    1436:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1439:	eb 06                	jmp    1441 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    143b:	8b 45 0c             	mov    0xc(%ebp),%eax
    143e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1441:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1448:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    144b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    144e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1451:	ba 00 00 00 00       	mov    $0x0,%edx
    1456:	f7 f3                	div    %ebx
    1458:	89 d0                	mov    %edx,%eax
    145a:	0f b6 80 40 1b 00 00 	movzbl 0x1b40(%eax),%eax
    1461:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1465:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1469:	8b 45 10             	mov    0x10(%ebp),%eax
    146c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    146f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1472:	ba 00 00 00 00       	mov    $0x0,%edx
    1477:	f7 75 d4             	divl   -0x2c(%ebp)
    147a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    147d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1481:	75 c5                	jne    1448 <printint+0x38>
  if(neg)
    1483:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1487:	74 28                	je     14b1 <printint+0xa1>
    buf[i++] = '-';
    1489:	8b 45 ec             	mov    -0x14(%ebp),%eax
    148c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1491:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1495:	eb 1a                	jmp    14b1 <printint+0xa1>
    putc(fd, buf[i]);
    1497:	8b 45 ec             	mov    -0x14(%ebp),%eax
    149a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    149f:	0f be c0             	movsbl %al,%eax
    14a2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14a6:	8b 45 08             	mov    0x8(%ebp),%eax
    14a9:	89 04 24             	mov    %eax,(%esp)
    14ac:	e8 37 ff ff ff       	call   13e8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14b1:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    14b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b9:	79 dc                	jns    1497 <printint+0x87>
    putc(fd, buf[i]);
}
    14bb:	83 c4 44             	add    $0x44,%esp
    14be:	5b                   	pop    %ebx
    14bf:	5d                   	pop    %ebp
    14c0:	c3                   	ret    

000014c1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14c1:	55                   	push   %ebp
    14c2:	89 e5                	mov    %esp,%ebp
    14c4:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14ce:	8d 45 0c             	lea    0xc(%ebp),%eax
    14d1:	83 c0 04             	add    $0x4,%eax
    14d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    14d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14de:	e9 7e 01 00 00       	jmp    1661 <printf+0x1a0>
    c = fmt[i] & 0xff;
    14e3:	8b 55 0c             	mov    0xc(%ebp),%edx
    14e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e9:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14ec:	0f b6 00             	movzbl (%eax),%eax
    14ef:	0f be c0             	movsbl %al,%eax
    14f2:	25 ff 00 00 00       	and    $0xff,%eax
    14f7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    14fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14fe:	75 2c                	jne    152c <printf+0x6b>
      if(c == '%'){
    1500:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1504:	75 0c                	jne    1512 <printf+0x51>
        state = '%';
    1506:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    150d:	e9 4b 01 00 00       	jmp    165d <printf+0x19c>
      } else {
        putc(fd, c);
    1512:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1515:	0f be c0             	movsbl %al,%eax
    1518:	89 44 24 04          	mov    %eax,0x4(%esp)
    151c:	8b 45 08             	mov    0x8(%ebp),%eax
    151f:	89 04 24             	mov    %eax,(%esp)
    1522:	e8 c1 fe ff ff       	call   13e8 <putc>
    1527:	e9 31 01 00 00       	jmp    165d <printf+0x19c>
      }
    } else if(state == '%'){
    152c:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1530:	0f 85 27 01 00 00    	jne    165d <printf+0x19c>
      if(c == 'd'){
    1536:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    153a:	75 2d                	jne    1569 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    153c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153f:	8b 00                	mov    (%eax),%eax
    1541:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1548:	00 
    1549:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1550:	00 
    1551:	89 44 24 04          	mov    %eax,0x4(%esp)
    1555:	8b 45 08             	mov    0x8(%ebp),%eax
    1558:	89 04 24             	mov    %eax,(%esp)
    155b:	e8 b0 fe ff ff       	call   1410 <printint>
        ap++;
    1560:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1564:	e9 ed 00 00 00       	jmp    1656 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1569:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    156d:	74 06                	je     1575 <printf+0xb4>
    156f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1573:	75 2d                	jne    15a2 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1575:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1578:	8b 00                	mov    (%eax),%eax
    157a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1581:	00 
    1582:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1589:	00 
    158a:	89 44 24 04          	mov    %eax,0x4(%esp)
    158e:	8b 45 08             	mov    0x8(%ebp),%eax
    1591:	89 04 24             	mov    %eax,(%esp)
    1594:	e8 77 fe ff ff       	call   1410 <printint>
        ap++;
    1599:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    159d:	e9 b4 00 00 00       	jmp    1656 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15a2:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    15a6:	75 46                	jne    15ee <printf+0x12d>
        s = (char*)*ap;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	8b 00                	mov    (%eax),%eax
    15ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    15b0:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    15b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    15b8:	75 27                	jne    15e1 <printf+0x120>
          s = "(null)";
    15ba:	c7 45 e4 0b 1b 00 00 	movl   $0x1b0b,-0x1c(%ebp)
        while(*s != 0){
    15c1:	eb 1f                	jmp    15e2 <printf+0x121>
          putc(fd, *s);
    15c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	0f be c0             	movsbl %al,%eax
    15cc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	89 04 24             	mov    %eax,(%esp)
    15d6:	e8 0d fe ff ff       	call   13e8 <putc>
          s++;
    15db:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    15df:	eb 01                	jmp    15e2 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15e1:	90                   	nop
    15e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15e5:	0f b6 00             	movzbl (%eax),%eax
    15e8:	84 c0                	test   %al,%al
    15ea:	75 d7                	jne    15c3 <printf+0x102>
    15ec:	eb 68                	jmp    1656 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15ee:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15f2:	75 1d                	jne    1611 <printf+0x150>
        putc(fd, *ap);
    15f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f7:	8b 00                	mov    (%eax),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	89 04 24             	mov    %eax,(%esp)
    1606:	e8 dd fd ff ff       	call   13e8 <putc>
        ap++;
    160b:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    160f:	eb 45                	jmp    1656 <printf+0x195>
      } else if(c == '%'){
    1611:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1615:	75 17                	jne    162e <printf+0x16d>
        putc(fd, c);
    1617:	8b 45 e8             	mov    -0x18(%ebp),%eax
    161a:	0f be c0             	movsbl %al,%eax
    161d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1621:	8b 45 08             	mov    0x8(%ebp),%eax
    1624:	89 04 24             	mov    %eax,(%esp)
    1627:	e8 bc fd ff ff       	call   13e8 <putc>
    162c:	eb 28                	jmp    1656 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    162e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1635:	00 
    1636:	8b 45 08             	mov    0x8(%ebp),%eax
    1639:	89 04 24             	mov    %eax,(%esp)
    163c:	e8 a7 fd ff ff       	call   13e8 <putc>
        putc(fd, c);
    1641:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1644:	0f be c0             	movsbl %al,%eax
    1647:	89 44 24 04          	mov    %eax,0x4(%esp)
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	89 04 24             	mov    %eax,(%esp)
    1651:	e8 92 fd ff ff       	call   13e8 <putc>
      }
      state = 0;
    1656:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    165d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1661:	8b 55 0c             	mov    0xc(%ebp),%edx
    1664:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1667:	8d 04 02             	lea    (%edx,%eax,1),%eax
    166a:	0f b6 00             	movzbl (%eax),%eax
    166d:	84 c0                	test   %al,%al
    166f:	0f 85 6e fe ff ff    	jne    14e3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1675:	c9                   	leave  
    1676:	c3                   	ret    
    1677:	90                   	nop

00001678 <free>:
    1678:	55                   	push   %ebp
    1679:	89 e5                	mov    %esp,%ebp
    167b:	83 ec 10             	sub    $0x10,%esp
    167e:	8b 45 08             	mov    0x8(%ebp),%eax
    1681:	83 e8 08             	sub    $0x8,%eax
    1684:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1687:	a1 60 1b 00 00       	mov    0x1b60,%eax
    168c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    168f:	eb 24                	jmp    16b5 <free+0x3d>
    1691:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1699:	77 12                	ja     16ad <free+0x35>
    169b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16a1:	77 24                	ja     16c7 <free+0x4f>
    16a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a6:	8b 00                	mov    (%eax),%eax
    16a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ab:	77 1a                	ja     16c7 <free+0x4f>
    16ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b0:	8b 00                	mov    (%eax),%eax
    16b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16bb:	76 d4                	jbe    1691 <free+0x19>
    16bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c0:	8b 00                	mov    (%eax),%eax
    16c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16c5:	76 ca                	jbe    1691 <free+0x19>
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	8b 40 04             	mov    0x4(%eax),%eax
    16cd:	c1 e0 03             	shl    $0x3,%eax
    16d0:	89 c2                	mov    %eax,%edx
    16d2:	03 55 f8             	add    -0x8(%ebp),%edx
    16d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d8:	8b 00                	mov    (%eax),%eax
    16da:	39 c2                	cmp    %eax,%edx
    16dc:	75 24                	jne    1702 <free+0x8a>
    16de:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e1:	8b 50 04             	mov    0x4(%eax),%edx
    16e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e7:	8b 00                	mov    (%eax),%eax
    16e9:	8b 40 04             	mov    0x4(%eax),%eax
    16ec:	01 c2                	add    %eax,%edx
    16ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f1:	89 50 04             	mov    %edx,0x4(%eax)
    16f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f7:	8b 00                	mov    (%eax),%eax
    16f9:	8b 10                	mov    (%eax),%edx
    16fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fe:	89 10                	mov    %edx,(%eax)
    1700:	eb 0a                	jmp    170c <free+0x94>
    1702:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1705:	8b 10                	mov    (%eax),%edx
    1707:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170a:	89 10                	mov    %edx,(%eax)
    170c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170f:	8b 40 04             	mov    0x4(%eax),%eax
    1712:	c1 e0 03             	shl    $0x3,%eax
    1715:	03 45 fc             	add    -0x4(%ebp),%eax
    1718:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    171b:	75 20                	jne    173d <free+0xc5>
    171d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1720:	8b 50 04             	mov    0x4(%eax),%edx
    1723:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1726:	8b 40 04             	mov    0x4(%eax),%eax
    1729:	01 c2                	add    %eax,%edx
    172b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172e:	89 50 04             	mov    %edx,0x4(%eax)
    1731:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1734:	8b 10                	mov    (%eax),%edx
    1736:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1739:	89 10                	mov    %edx,(%eax)
    173b:	eb 08                	jmp    1745 <free+0xcd>
    173d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1740:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1743:	89 10                	mov    %edx,(%eax)
    1745:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1748:	a3 60 1b 00 00       	mov    %eax,0x1b60
    174d:	c9                   	leave  
    174e:	c3                   	ret    

0000174f <morecore>:
    174f:	55                   	push   %ebp
    1750:	89 e5                	mov    %esp,%ebp
    1752:	83 ec 28             	sub    $0x28,%esp
    1755:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    175c:	77 07                	ja     1765 <morecore+0x16>
    175e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1765:	8b 45 08             	mov    0x8(%ebp),%eax
    1768:	c1 e0 03             	shl    $0x3,%eax
    176b:	89 04 24             	mov    %eax,(%esp)
    176e:	e8 3d fc ff ff       	call   13b0 <sbrk>
    1773:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1776:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    177a:	75 07                	jne    1783 <morecore+0x34>
    177c:	b8 00 00 00 00       	mov    $0x0,%eax
    1781:	eb 22                	jmp    17a5 <morecore+0x56>
    1783:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1786:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1789:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178c:	8b 55 08             	mov    0x8(%ebp),%edx
    178f:	89 50 04             	mov    %edx,0x4(%eax)
    1792:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1795:	83 c0 08             	add    $0x8,%eax
    1798:	89 04 24             	mov    %eax,(%esp)
    179b:	e8 d8 fe ff ff       	call   1678 <free>
    17a0:	a1 60 1b 00 00       	mov    0x1b60,%eax
    17a5:	c9                   	leave  
    17a6:	c3                   	ret    

000017a7 <malloc>:
    17a7:	55                   	push   %ebp
    17a8:	89 e5                	mov    %esp,%ebp
    17aa:	83 ec 28             	sub    $0x28,%esp
    17ad:	8b 45 08             	mov    0x8(%ebp),%eax
    17b0:	83 c0 07             	add    $0x7,%eax
    17b3:	c1 e8 03             	shr    $0x3,%eax
    17b6:	83 c0 01             	add    $0x1,%eax
    17b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17bc:	a1 60 1b 00 00       	mov    0x1b60,%eax
    17c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17c8:	75 23                	jne    17ed <malloc+0x46>
    17ca:	c7 45 f0 58 1b 00 00 	movl   $0x1b58,-0x10(%ebp)
    17d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d4:	a3 60 1b 00 00       	mov    %eax,0x1b60
    17d9:	a1 60 1b 00 00       	mov    0x1b60,%eax
    17de:	a3 58 1b 00 00       	mov    %eax,0x1b58
    17e3:	c7 05 5c 1b 00 00 00 	movl   $0x0,0x1b5c
    17ea:	00 00 00 
    17ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f0:	8b 00                	mov    (%eax),%eax
    17f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f8:	8b 40 04             	mov    0x4(%eax),%eax
    17fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17fe:	72 4d                	jb     184d <malloc+0xa6>
    1800:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1803:	8b 40 04             	mov    0x4(%eax),%eax
    1806:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1809:	75 0c                	jne    1817 <malloc+0x70>
    180b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    180e:	8b 10                	mov    (%eax),%edx
    1810:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1813:	89 10                	mov    %edx,(%eax)
    1815:	eb 26                	jmp    183d <malloc+0x96>
    1817:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181a:	8b 40 04             	mov    0x4(%eax),%eax
    181d:	89 c2                	mov    %eax,%edx
    181f:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1822:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1825:	89 50 04             	mov    %edx,0x4(%eax)
    1828:	8b 45 ec             	mov    -0x14(%ebp),%eax
    182b:	8b 40 04             	mov    0x4(%eax),%eax
    182e:	c1 e0 03             	shl    $0x3,%eax
    1831:	01 45 ec             	add    %eax,-0x14(%ebp)
    1834:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1837:	8b 55 f4             	mov    -0xc(%ebp),%edx
    183a:	89 50 04             	mov    %edx,0x4(%eax)
    183d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1840:	a3 60 1b 00 00       	mov    %eax,0x1b60
    1845:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1848:	83 c0 08             	add    $0x8,%eax
    184b:	eb 38                	jmp    1885 <malloc+0xde>
    184d:	a1 60 1b 00 00       	mov    0x1b60,%eax
    1852:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1855:	75 1b                	jne    1872 <malloc+0xcb>
    1857:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185a:	89 04 24             	mov    %eax,(%esp)
    185d:	e8 ed fe ff ff       	call   174f <morecore>
    1862:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1865:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1869:	75 07                	jne    1872 <malloc+0xcb>
    186b:	b8 00 00 00 00       	mov    $0x0,%eax
    1870:	eb 13                	jmp    1885 <malloc+0xde>
    1872:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1875:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1878:	8b 45 ec             	mov    -0x14(%ebp),%eax
    187b:	8b 00                	mov    (%eax),%eax
    187d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1880:	e9 70 ff ff ff       	jmp    17f5 <malloc+0x4e>
    1885:	c9                   	leave  
    1886:	c3                   	ret    
    1887:	90                   	nop

00001888 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1888:	55                   	push   %ebp
    1889:	89 e5                	mov    %esp,%ebp
    188b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    188e:	8b 55 08             	mov    0x8(%ebp),%edx
    1891:	8b 45 0c             	mov    0xc(%ebp),%eax
    1894:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1897:	f0 87 02             	lock xchg %eax,(%edx)
    189a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    189d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18a0:	c9                   	leave  
    18a1:	c3                   	ret    

000018a2 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18a2:	55                   	push   %ebp
    18a3:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18ae:	5d                   	pop    %ebp
    18af:	c3                   	ret    

000018b0 <lock_acquire>:
void lock_acquire(lock_t *lock){
    18b0:	55                   	push   %ebp
    18b1:	89 e5                	mov    %esp,%ebp
    18b3:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18b6:	8b 45 08             	mov    0x8(%ebp),%eax
    18b9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18c0:	00 
    18c1:	89 04 24             	mov    %eax,(%esp)
    18c4:	e8 bf ff ff ff       	call   1888 <xchg>
    18c9:	85 c0                	test   %eax,%eax
    18cb:	75 e9                	jne    18b6 <lock_acquire+0x6>
}
    18cd:	c9                   	leave  
    18ce:	c3                   	ret    

000018cf <lock_release>:
void lock_release(lock_t *lock){
    18cf:	55                   	push   %ebp
    18d0:	89 e5                	mov    %esp,%ebp
    18d2:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18d5:	8b 45 08             	mov    0x8(%ebp),%eax
    18d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18df:	00 
    18e0:	89 04 24             	mov    %eax,(%esp)
    18e3:	e8 a0 ff ff ff       	call   1888 <xchg>
}
    18e8:	c9                   	leave  
    18e9:	c3                   	ret    

000018ea <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18ea:	55                   	push   %ebp
    18eb:	89 e5                	mov    %esp,%ebp
    18ed:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18f0:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18f7:	e8 ab fe ff ff       	call   17a7 <malloc>
    18fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    18ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1902:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1905:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1908:	25 ff 0f 00 00       	and    $0xfff,%eax
    190d:	85 c0                	test   %eax,%eax
    190f:	74 15                	je     1926 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1911:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1914:	89 c2                	mov    %eax,%edx
    1916:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    191c:	b8 00 10 00 00       	mov    $0x1000,%eax
    1921:	29 d0                	sub    %edx,%eax
    1923:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1926:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    192a:	75 1b                	jne    1947 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    192c:	c7 44 24 04 12 1b 00 	movl   $0x1b12,0x4(%esp)
    1933:	00 
    1934:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    193b:	e8 81 fb ff ff       	call   14c1 <printf>
        return 0;
    1940:	b8 00 00 00 00       	mov    $0x0,%eax
    1945:	eb 6f                	jmp    19b6 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1947:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    194a:	8b 55 08             	mov    0x8(%ebp),%edx
    194d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1950:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1954:	89 54 24 08          	mov    %edx,0x8(%esp)
    1958:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    195f:	00 
    1960:	89 04 24             	mov    %eax,(%esp)
    1963:	e8 60 fa ff ff       	call   13c8 <clone>
    1968:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    196b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    196f:	79 1b                	jns    198c <thread_create+0xa2>
        printf(1,"clone fails\n");
    1971:	c7 44 24 04 20 1b 00 	movl   $0x1b20,0x4(%esp)
    1978:	00 
    1979:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1980:	e8 3c fb ff ff       	call   14c1 <printf>
        return 0;
    1985:	b8 00 00 00 00       	mov    $0x0,%eax
    198a:	eb 2a                	jmp    19b6 <thread_create+0xcc>
    }
    if(tid > 0){
    198c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1990:	7e 05                	jle    1997 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1992:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1995:	eb 1f                	jmp    19b6 <thread_create+0xcc>
    }
    if(tid == 0){
    1997:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    199b:	75 14                	jne    19b1 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    199d:	c7 44 24 04 2d 1b 00 	movl   $0x1b2d,0x4(%esp)
    19a4:	00 
    19a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19ac:	e8 10 fb ff ff       	call   14c1 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19b6:	c9                   	leave  
    19b7:	c3                   	ret    

000019b8 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19b8:	55                   	push   %ebp
    19b9:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19bb:	a1 54 1b 00 00       	mov    0x1b54,%eax
    19c0:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19c6:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19cb:	a3 54 1b 00 00       	mov    %eax,0x1b54
    return (int)(rands % max);
    19d0:	a1 54 1b 00 00       	mov    0x1b54,%eax
    19d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19d8:	ba 00 00 00 00       	mov    $0x0,%edx
    19dd:	f7 f1                	div    %ecx
    19df:	89 d0                	mov    %edx,%eax
}
    19e1:	5d                   	pop    %ebp
    19e2:	c3                   	ret    
    19e3:	90                   	nop

000019e4 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19e4:	55                   	push   %ebp
    19e5:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19e7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19f0:	8b 45 08             	mov    0x8(%ebp),%eax
    19f3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19fa:	8b 45 08             	mov    0x8(%ebp),%eax
    19fd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a04:	5d                   	pop    %ebp
    1a05:	c3                   	ret    

00001a06 <add_q>:

void add_q(struct queue *q, int v){
    1a06:	55                   	push   %ebp
    1a07:	89 e5                	mov    %esp,%ebp
    1a09:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a0c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a13:	e8 8f fd ff ff       	call   17a7 <malloc>
    1a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a28:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a2b:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a30:	8b 40 04             	mov    0x4(%eax),%eax
    1a33:	85 c0                	test   %eax,%eax
    1a35:	75 0b                	jne    1a42 <add_q+0x3c>
        q->head = n;
    1a37:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a3d:	89 50 04             	mov    %edx,0x4(%eax)
    1a40:	eb 0c                	jmp    1a4e <add_q+0x48>
    }else{
        q->tail->next = n;
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 40 08             	mov    0x8(%eax),%eax
    1a48:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a4b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a51:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a54:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a57:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5a:	8b 00                	mov    (%eax),%eax
    1a5c:	8d 50 01             	lea    0x1(%eax),%edx
    1a5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a62:	89 10                	mov    %edx,(%eax)
}
    1a64:	c9                   	leave  
    1a65:	c3                   	ret    

00001a66 <empty_q>:

int empty_q(struct queue *q){
    1a66:	55                   	push   %ebp
    1a67:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8b 00                	mov    (%eax),%eax
    1a6e:	85 c0                	test   %eax,%eax
    1a70:	75 07                	jne    1a79 <empty_q+0x13>
        return 1;
    1a72:	b8 01 00 00 00       	mov    $0x1,%eax
    1a77:	eb 05                	jmp    1a7e <empty_q+0x18>
    else
        return 0;
    1a79:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a7e:	5d                   	pop    %ebp
    1a7f:	c3                   	ret    

00001a80 <pop_q>:
int pop_q(struct queue *q){
    1a80:	55                   	push   %ebp
    1a81:	89 e5                	mov    %esp,%ebp
    1a83:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	89 04 24             	mov    %eax,(%esp)
    1a8c:	e8 d5 ff ff ff       	call   1a66 <empty_q>
    1a91:	85 c0                	test   %eax,%eax
    1a93:	75 5d                	jne    1af2 <pop_q+0x72>
       val = q->head->value; 
    1a95:	8b 45 08             	mov    0x8(%ebp),%eax
    1a98:	8b 40 04             	mov    0x4(%eax),%eax
    1a9b:	8b 00                	mov    (%eax),%eax
    1a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa3:	8b 40 04             	mov    0x4(%eax),%eax
    1aa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	8b 40 04             	mov    0x4(%eax),%eax
    1aaf:	8b 50 04             	mov    0x4(%eax),%edx
    1ab2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab5:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abb:	89 04 24             	mov    %eax,(%esp)
    1abe:	e8 b5 fb ff ff       	call   1678 <free>
       q->size--;
    1ac3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac6:	8b 00                	mov    (%eax),%eax
    1ac8:	8d 50 ff             	lea    -0x1(%eax),%edx
    1acb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ace:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ad0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad3:	8b 00                	mov    (%eax),%eax
    1ad5:	85 c0                	test   %eax,%eax
    1ad7:	75 14                	jne    1aed <pop_q+0x6d>
            q->head = 0;
    1ad9:	8b 45 08             	mov    0x8(%ebp),%eax
    1adc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ae3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1af0:	eb 05                	jmp    1af7 <pop_q+0x77>
    }
    return -1;
    1af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1af7:	c9                   	leave  
    1af8:	c3                   	ret    
