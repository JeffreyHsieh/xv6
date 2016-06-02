
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
    101f:	b8 a9 1a 00 00       	mov    $0x1aa9,%eax
    1024:	eb 05                	jmp    102b <main+0x2b>
    1026:	b8 ab 1a 00 00       	mov    $0x1aab,%eax
    102b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    102f:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
    1036:	8b 55 0c             	mov    0xc(%ebp),%edx
    1039:	01 ca                	add    %ecx,%edx
    103b:	8b 12                	mov    (%edx),%edx
    103d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1041:	89 54 24 08          	mov    %edx,0x8(%esp)
    1045:	c7 44 24 04 ad 1a 00 	movl   $0x1aad,0x4(%esp)
    104c:	00 
    104d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1054:	e8 1b 04 00 00       	call   1474 <printf>
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
    12cc:	b8 01 00 00 00       	mov    $0x1,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <exit>:
    12d4:	b8 02 00 00 00       	mov    $0x2,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <wait>:
    12dc:	b8 03 00 00 00       	mov    $0x3,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <pipe>:
    12e4:	b8 04 00 00 00       	mov    $0x4,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <read>:
    12ec:	b8 05 00 00 00       	mov    $0x5,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <write>:
    12f4:	b8 10 00 00 00       	mov    $0x10,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <close>:
    12fc:	b8 15 00 00 00       	mov    $0x15,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <kill>:
    1304:	b8 06 00 00 00       	mov    $0x6,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <exec>:
    130c:	b8 07 00 00 00       	mov    $0x7,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <open>:
    1314:	b8 0f 00 00 00       	mov    $0xf,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <mknod>:
    131c:	b8 11 00 00 00       	mov    $0x11,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <unlink>:
    1324:	b8 12 00 00 00       	mov    $0x12,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <fstat>:
    132c:	b8 08 00 00 00       	mov    $0x8,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <link>:
    1334:	b8 13 00 00 00       	mov    $0x13,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <mkdir>:
    133c:	b8 14 00 00 00       	mov    $0x14,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <chdir>:
    1344:	b8 09 00 00 00       	mov    $0x9,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <dup>:
    134c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <getpid>:
    1354:	b8 0b 00 00 00       	mov    $0xb,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <sbrk>:
    135c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <sleep>:
    1364:	b8 0d 00 00 00       	mov    $0xd,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <uptime>:
    136c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <clone>:
    1374:	b8 16 00 00 00       	mov    $0x16,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <texit>:
    137c:	b8 17 00 00 00       	mov    $0x17,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <tsleep>:
    1384:	b8 18 00 00 00       	mov    $0x18,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <twakeup>:
    138c:	b8 19 00 00 00       	mov    $0x19,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1394:	55                   	push   %ebp
    1395:	89 e5                	mov    %esp,%ebp
    1397:	83 ec 18             	sub    $0x18,%esp
    139a:	8b 45 0c             	mov    0xc(%ebp),%eax
    139d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13a7:	00 
    13a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    13af:	8b 45 08             	mov    0x8(%ebp),%eax
    13b2:	89 04 24             	mov    %eax,(%esp)
    13b5:	e8 3a ff ff ff       	call   12f4 <write>
}
    13ba:	c9                   	leave  
    13bb:	c3                   	ret    

000013bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13bc:	55                   	push   %ebp
    13bd:	89 e5                	mov    %esp,%ebp
    13bf:	56                   	push   %esi
    13c0:	53                   	push   %ebx
    13c1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13cb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13cf:	74 17                	je     13e8 <printint+0x2c>
    13d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d5:	79 11                	jns    13e8 <printint+0x2c>
    neg = 1;
    13d7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13de:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e1:	f7 d8                	neg    %eax
    13e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e6:	eb 06                	jmp    13ee <printint+0x32>
  } else {
    x = xx;
    13e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13f5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13f8:	8d 41 01             	lea    0x1(%ecx),%eax
    13fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13fe:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1401:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1404:	ba 00 00 00 00       	mov    $0x0,%edx
    1409:	f7 f3                	div    %ebx
    140b:	89 d0                	mov    %edx,%eax
    140d:	0f b6 80 0c 1e 00 00 	movzbl 0x1e0c(%eax),%eax
    1414:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1418:	8b 75 10             	mov    0x10(%ebp),%esi
    141b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141e:	ba 00 00 00 00       	mov    $0x0,%edx
    1423:	f7 f6                	div    %esi
    1425:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1428:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    142c:	75 c7                	jne    13f5 <printint+0x39>
  if(neg)
    142e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1432:	74 10                	je     1444 <printint+0x88>
    buf[i++] = '-';
    1434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1437:	8d 50 01             	lea    0x1(%eax),%edx
    143a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    143d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1442:	eb 1f                	jmp    1463 <printint+0xa7>
    1444:	eb 1d                	jmp    1463 <printint+0xa7>
    putc(fd, buf[i]);
    1446:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1449:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144c:	01 d0                	add    %edx,%eax
    144e:	0f b6 00             	movzbl (%eax),%eax
    1451:	0f be c0             	movsbl %al,%eax
    1454:	89 44 24 04          	mov    %eax,0x4(%esp)
    1458:	8b 45 08             	mov    0x8(%ebp),%eax
    145b:	89 04 24             	mov    %eax,(%esp)
    145e:	e8 31 ff ff ff       	call   1394 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1463:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1467:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    146b:	79 d9                	jns    1446 <printint+0x8a>
    putc(fd, buf[i]);
}
    146d:	83 c4 30             	add    $0x30,%esp
    1470:	5b                   	pop    %ebx
    1471:	5e                   	pop    %esi
    1472:	5d                   	pop    %ebp
    1473:	c3                   	ret    

00001474 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1474:	55                   	push   %ebp
    1475:	89 e5                	mov    %esp,%ebp
    1477:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    147a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1481:	8d 45 0c             	lea    0xc(%ebp),%eax
    1484:	83 c0 04             	add    $0x4,%eax
    1487:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    148a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1491:	e9 7c 01 00 00       	jmp    1612 <printf+0x19e>
    c = fmt[i] & 0xff;
    1496:	8b 55 0c             	mov    0xc(%ebp),%edx
    1499:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149c:	01 d0                	add    %edx,%eax
    149e:	0f b6 00             	movzbl (%eax),%eax
    14a1:	0f be c0             	movsbl %al,%eax
    14a4:	25 ff 00 00 00       	and    $0xff,%eax
    14a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b0:	75 2c                	jne    14de <printf+0x6a>
      if(c == '%'){
    14b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14b6:	75 0c                	jne    14c4 <printf+0x50>
        state = '%';
    14b8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14bf:	e9 4a 01 00 00       	jmp    160e <printf+0x19a>
      } else {
        putc(fd, c);
    14c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14c7:	0f be c0             	movsbl %al,%eax
    14ca:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ce:	8b 45 08             	mov    0x8(%ebp),%eax
    14d1:	89 04 24             	mov    %eax,(%esp)
    14d4:	e8 bb fe ff ff       	call   1394 <putc>
    14d9:	e9 30 01 00 00       	jmp    160e <printf+0x19a>
      }
    } else if(state == '%'){
    14de:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14e2:	0f 85 26 01 00 00    	jne    160e <printf+0x19a>
      if(c == 'd'){
    14e8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14ec:	75 2d                	jne    151b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f1:	8b 00                	mov    (%eax),%eax
    14f3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14fa:	00 
    14fb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1502:	00 
    1503:	89 44 24 04          	mov    %eax,0x4(%esp)
    1507:	8b 45 08             	mov    0x8(%ebp),%eax
    150a:	89 04 24             	mov    %eax,(%esp)
    150d:	e8 aa fe ff ff       	call   13bc <printint>
        ap++;
    1512:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1516:	e9 ec 00 00 00       	jmp    1607 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    151b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    151f:	74 06                	je     1527 <printf+0xb3>
    1521:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1525:	75 2d                	jne    1554 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1527:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152a:	8b 00                	mov    (%eax),%eax
    152c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1533:	00 
    1534:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    153b:	00 
    153c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1540:	8b 45 08             	mov    0x8(%ebp),%eax
    1543:	89 04 24             	mov    %eax,(%esp)
    1546:	e8 71 fe ff ff       	call   13bc <printint>
        ap++;
    154b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    154f:	e9 b3 00 00 00       	jmp    1607 <printf+0x193>
      } else if(c == 's'){
    1554:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1558:	75 45                	jne    159f <printf+0x12b>
        s = (char*)*ap;
    155a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    155d:	8b 00                	mov    (%eax),%eax
    155f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1562:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1566:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    156a:	75 09                	jne    1575 <printf+0x101>
          s = "(null)";
    156c:	c7 45 f4 b2 1a 00 00 	movl   $0x1ab2,-0xc(%ebp)
        while(*s != 0){
    1573:	eb 1e                	jmp    1593 <printf+0x11f>
    1575:	eb 1c                	jmp    1593 <printf+0x11f>
          putc(fd, *s);
    1577:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157a:	0f b6 00             	movzbl (%eax),%eax
    157d:	0f be c0             	movsbl %al,%eax
    1580:	89 44 24 04          	mov    %eax,0x4(%esp)
    1584:	8b 45 08             	mov    0x8(%ebp),%eax
    1587:	89 04 24             	mov    %eax,(%esp)
    158a:	e8 05 fe ff ff       	call   1394 <putc>
          s++;
    158f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1593:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1596:	0f b6 00             	movzbl (%eax),%eax
    1599:	84 c0                	test   %al,%al
    159b:	75 da                	jne    1577 <printf+0x103>
    159d:	eb 68                	jmp    1607 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    159f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15a3:	75 1d                	jne    15c2 <printf+0x14e>
        putc(fd, *ap);
    15a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a8:	8b 00                	mov    (%eax),%eax
    15aa:	0f be c0             	movsbl %al,%eax
    15ad:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b1:	8b 45 08             	mov    0x8(%ebp),%eax
    15b4:	89 04 24             	mov    %eax,(%esp)
    15b7:	e8 d8 fd ff ff       	call   1394 <putc>
        ap++;
    15bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15c0:	eb 45                	jmp    1607 <printf+0x193>
      } else if(c == '%'){
    15c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15c6:	75 17                	jne    15df <printf+0x16b>
        putc(fd, c);
    15c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15cb:	0f be c0             	movsbl %al,%eax
    15ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d2:	8b 45 08             	mov    0x8(%ebp),%eax
    15d5:	89 04 24             	mov    %eax,(%esp)
    15d8:	e8 b7 fd ff ff       	call   1394 <putc>
    15dd:	eb 28                	jmp    1607 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15df:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15e6:	00 
    15e7:	8b 45 08             	mov    0x8(%ebp),%eax
    15ea:	89 04 24             	mov    %eax,(%esp)
    15ed:	e8 a2 fd ff ff       	call   1394 <putc>
        putc(fd, c);
    15f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f5:	0f be c0             	movsbl %al,%eax
    15f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15fc:	8b 45 08             	mov    0x8(%ebp),%eax
    15ff:	89 04 24             	mov    %eax,(%esp)
    1602:	e8 8d fd ff ff       	call   1394 <putc>
      }
      state = 0;
    1607:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    160e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1612:	8b 55 0c             	mov    0xc(%ebp),%edx
    1615:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1618:	01 d0                	add    %edx,%eax
    161a:	0f b6 00             	movzbl (%eax),%eax
    161d:	84 c0                	test   %al,%al
    161f:	0f 85 71 fe ff ff    	jne    1496 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1625:	c9                   	leave  
    1626:	c3                   	ret    
    1627:	90                   	nop

00001628 <free>:
    1628:	55                   	push   %ebp
    1629:	89 e5                	mov    %esp,%ebp
    162b:	83 ec 10             	sub    $0x10,%esp
    162e:	8b 45 08             	mov    0x8(%ebp),%eax
    1631:	83 e8 08             	sub    $0x8,%eax
    1634:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1637:	a1 2c 1e 00 00       	mov    0x1e2c,%eax
    163c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    163f:	eb 24                	jmp    1665 <free+0x3d>
    1641:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1644:	8b 00                	mov    (%eax),%eax
    1646:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1649:	77 12                	ja     165d <free+0x35>
    164b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1651:	77 24                	ja     1677 <free+0x4f>
    1653:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1656:	8b 00                	mov    (%eax),%eax
    1658:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    165b:	77 1a                	ja     1677 <free+0x4f>
    165d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1660:	8b 00                	mov    (%eax),%eax
    1662:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1665:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1668:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    166b:	76 d4                	jbe    1641 <free+0x19>
    166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1675:	76 ca                	jbe    1641 <free+0x19>
    1677:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167a:	8b 40 04             	mov    0x4(%eax),%eax
    167d:	c1 e0 03             	shl    $0x3,%eax
    1680:	89 c2                	mov    %eax,%edx
    1682:	03 55 f8             	add    -0x8(%ebp),%edx
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	8b 00                	mov    (%eax),%eax
    168a:	39 c2                	cmp    %eax,%edx
    168c:	75 24                	jne    16b2 <free+0x8a>
    168e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1691:	8b 50 04             	mov    0x4(%eax),%edx
    1694:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1697:	8b 00                	mov    (%eax),%eax
    1699:	8b 40 04             	mov    0x4(%eax),%eax
    169c:	01 c2                	add    %eax,%edx
    169e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a1:	89 50 04             	mov    %edx,0x4(%eax)
    16a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a7:	8b 00                	mov    (%eax),%eax
    16a9:	8b 10                	mov    (%eax),%edx
    16ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ae:	89 10                	mov    %edx,(%eax)
    16b0:	eb 0a                	jmp    16bc <free+0x94>
    16b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b5:	8b 10                	mov    (%eax),%edx
    16b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ba:	89 10                	mov    %edx,(%eax)
    16bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bf:	8b 40 04             	mov    0x4(%eax),%eax
    16c2:	c1 e0 03             	shl    $0x3,%eax
    16c5:	03 45 fc             	add    -0x4(%ebp),%eax
    16c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16cb:	75 20                	jne    16ed <free+0xc5>
    16cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d0:	8b 50 04             	mov    0x4(%eax),%edx
    16d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d6:	8b 40 04             	mov    0x4(%eax),%eax
    16d9:	01 c2                	add    %eax,%edx
    16db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16de:	89 50 04             	mov    %edx,0x4(%eax)
    16e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e4:	8b 10                	mov    (%eax),%edx
    16e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e9:	89 10                	mov    %edx,(%eax)
    16eb:	eb 08                	jmp    16f5 <free+0xcd>
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16f3:	89 10                	mov    %edx,(%eax)
    16f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f8:	a3 2c 1e 00 00       	mov    %eax,0x1e2c
    16fd:	c9                   	leave  
    16fe:	c3                   	ret    

000016ff <morecore>:
    16ff:	55                   	push   %ebp
    1700:	89 e5                	mov    %esp,%ebp
    1702:	83 ec 28             	sub    $0x28,%esp
    1705:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    170c:	77 07                	ja     1715 <morecore+0x16>
    170e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1715:	8b 45 08             	mov    0x8(%ebp),%eax
    1718:	c1 e0 03             	shl    $0x3,%eax
    171b:	89 04 24             	mov    %eax,(%esp)
    171e:	e8 39 fc ff ff       	call   135c <sbrk>
    1723:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1726:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    172a:	75 07                	jne    1733 <morecore+0x34>
    172c:	b8 00 00 00 00       	mov    $0x0,%eax
    1731:	eb 22                	jmp    1755 <morecore+0x56>
    1733:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1736:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1739:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173c:	8b 55 08             	mov    0x8(%ebp),%edx
    173f:	89 50 04             	mov    %edx,0x4(%eax)
    1742:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1745:	83 c0 08             	add    $0x8,%eax
    1748:	89 04 24             	mov    %eax,(%esp)
    174b:	e8 d8 fe ff ff       	call   1628 <free>
    1750:	a1 2c 1e 00 00       	mov    0x1e2c,%eax
    1755:	c9                   	leave  
    1756:	c3                   	ret    

00001757 <malloc>:
    1757:	55                   	push   %ebp
    1758:	89 e5                	mov    %esp,%ebp
    175a:	83 ec 28             	sub    $0x28,%esp
    175d:	8b 45 08             	mov    0x8(%ebp),%eax
    1760:	83 c0 07             	add    $0x7,%eax
    1763:	c1 e8 03             	shr    $0x3,%eax
    1766:	83 c0 01             	add    $0x1,%eax
    1769:	89 45 f4             	mov    %eax,-0xc(%ebp)
    176c:	a1 2c 1e 00 00       	mov    0x1e2c,%eax
    1771:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1774:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1778:	75 23                	jne    179d <malloc+0x46>
    177a:	c7 45 f0 24 1e 00 00 	movl   $0x1e24,-0x10(%ebp)
    1781:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1784:	a3 2c 1e 00 00       	mov    %eax,0x1e2c
    1789:	a1 2c 1e 00 00       	mov    0x1e2c,%eax
    178e:	a3 24 1e 00 00       	mov    %eax,0x1e24
    1793:	c7 05 28 1e 00 00 00 	movl   $0x0,0x1e28
    179a:	00 00 00 
    179d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a0:	8b 00                	mov    (%eax),%eax
    17a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a8:	8b 40 04             	mov    0x4(%eax),%eax
    17ab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17ae:	72 4d                	jb     17fd <malloc+0xa6>
    17b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b3:	8b 40 04             	mov    0x4(%eax),%eax
    17b6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17b9:	75 0c                	jne    17c7 <malloc+0x70>
    17bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17be:	8b 10                	mov    (%eax),%edx
    17c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c3:	89 10                	mov    %edx,(%eax)
    17c5:	eb 26                	jmp    17ed <malloc+0x96>
    17c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ca:	8b 40 04             	mov    0x4(%eax),%eax
    17cd:	89 c2                	mov    %eax,%edx
    17cf:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d5:	89 50 04             	mov    %edx,0x4(%eax)
    17d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17db:	8b 40 04             	mov    0x4(%eax),%eax
    17de:	c1 e0 03             	shl    $0x3,%eax
    17e1:	01 45 ec             	add    %eax,-0x14(%ebp)
    17e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17ea:	89 50 04             	mov    %edx,0x4(%eax)
    17ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f0:	a3 2c 1e 00 00       	mov    %eax,0x1e2c
    17f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f8:	83 c0 08             	add    $0x8,%eax
    17fb:	eb 38                	jmp    1835 <malloc+0xde>
    17fd:	a1 2c 1e 00 00       	mov    0x1e2c,%eax
    1802:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1805:	75 1b                	jne    1822 <malloc+0xcb>
    1807:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180a:	89 04 24             	mov    %eax,(%esp)
    180d:	e8 ed fe ff ff       	call   16ff <morecore>
    1812:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1815:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1819:	75 07                	jne    1822 <malloc+0xcb>
    181b:	b8 00 00 00 00       	mov    $0x0,%eax
    1820:	eb 13                	jmp    1835 <malloc+0xde>
    1822:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1825:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1828:	8b 45 ec             	mov    -0x14(%ebp),%eax
    182b:	8b 00                	mov    (%eax),%eax
    182d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1830:	e9 70 ff ff ff       	jmp    17a5 <malloc+0x4e>
    1835:	c9                   	leave  
    1836:	c3                   	ret    
    1837:	90                   	nop

00001838 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1838:	55                   	push   %ebp
    1839:	89 e5                	mov    %esp,%ebp
    183b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    183e:	8b 55 08             	mov    0x8(%ebp),%edx
    1841:	8b 45 0c             	mov    0xc(%ebp),%eax
    1844:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1847:	f0 87 02             	lock xchg %eax,(%edx)
    184a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1850:	c9                   	leave  
    1851:	c3                   	ret    

00001852 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1852:	55                   	push   %ebp
    1853:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1855:	8b 45 08             	mov    0x8(%ebp),%eax
    1858:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    185e:	5d                   	pop    %ebp
    185f:	c3                   	ret    

00001860 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1860:	55                   	push   %ebp
    1861:	89 e5                	mov    %esp,%ebp
    1863:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1866:	90                   	nop
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1871:	00 
    1872:	89 04 24             	mov    %eax,(%esp)
    1875:	e8 be ff ff ff       	call   1838 <xchg>
    187a:	85 c0                	test   %eax,%eax
    187c:	75 e9                	jne    1867 <lock_acquire+0x7>
}
    187e:	c9                   	leave  
    187f:	c3                   	ret    

00001880 <lock_release>:
void lock_release(lock_t *lock){
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1890:	00 
    1891:	89 04 24             	mov    %eax,(%esp)
    1894:	e8 9f ff ff ff       	call   1838 <xchg>
}
    1899:	c9                   	leave  
    189a:	c3                   	ret    

0000189b <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    189b:	55                   	push   %ebp
    189c:	89 e5                	mov    %esp,%ebp
    189e:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18a1:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18a8:	e8 aa fe ff ff       	call   1757 <malloc>
    18ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18be:	85 c0                	test   %eax,%eax
    18c0:	74 14                	je     18d6 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c5:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ca:	89 c2                	mov    %eax,%edx
    18cc:	b8 00 10 00 00       	mov    $0x1000,%eax
    18d1:	29 d0                	sub    %edx,%eax
    18d3:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18da:	75 1b                	jne    18f7 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18dc:	c7 44 24 04 b9 1a 00 	movl   $0x1ab9,0x4(%esp)
    18e3:	00 
    18e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18eb:	e8 84 fb ff ff       	call   1474 <printf>
        return 0;
    18f0:	b8 00 00 00 00       	mov    $0x0,%eax
    18f5:	eb 6f                	jmp    1966 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18fa:	8b 55 08             	mov    0x8(%ebp),%edx
    18fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1900:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1904:	89 54 24 08          	mov    %edx,0x8(%esp)
    1908:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    190f:	00 
    1910:	89 04 24             	mov    %eax,(%esp)
    1913:	e8 5c fa ff ff       	call   1374 <clone>
    1918:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    191b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191f:	79 1b                	jns    193c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1921:	c7 44 24 04 c7 1a 00 	movl   $0x1ac7,0x4(%esp)
    1928:	00 
    1929:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1930:	e8 3f fb ff ff       	call   1474 <printf>
        return 0;
    1935:	b8 00 00 00 00       	mov    $0x0,%eax
    193a:	eb 2a                	jmp    1966 <thread_create+0xcb>
    }
    if(tid > 0){
    193c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1940:	7e 05                	jle    1947 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1942:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1945:	eb 1f                	jmp    1966 <thread_create+0xcb>
    }
    if(tid == 0){
    1947:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    194b:	75 14                	jne    1961 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    194d:	c7 44 24 04 d4 1a 00 	movl   $0x1ad4,0x4(%esp)
    1954:	00 
    1955:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    195c:	e8 13 fb ff ff       	call   1474 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1961:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1966:	c9                   	leave  
    1967:	c3                   	ret    

00001968 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1968:	55                   	push   %ebp
    1969:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    196b:	a1 20 1e 00 00       	mov    0x1e20,%eax
    1970:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1976:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    197b:	a3 20 1e 00 00       	mov    %eax,0x1e20
    return (int)(rands % max);
    1980:	a1 20 1e 00 00       	mov    0x1e20,%eax
    1985:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1988:	ba 00 00 00 00       	mov    $0x0,%edx
    198d:	f7 f1                	div    %ecx
    198f:	89 d0                	mov    %edx,%eax
}
    1991:	5d                   	pop    %ebp
    1992:	c3                   	ret    
    1993:	90                   	nop

00001994 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1994:	55                   	push   %ebp
    1995:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1997:	8b 45 08             	mov    0x8(%ebp),%eax
    199a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19a0:	8b 45 08             	mov    0x8(%ebp),%eax
    19a3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19aa:	8b 45 08             	mov    0x8(%ebp),%eax
    19ad:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19b4:	5d                   	pop    %ebp
    19b5:	c3                   	ret    

000019b6 <add_q>:

void add_q(struct queue *q, int v){
    19b6:	55                   	push   %ebp
    19b7:	89 e5                	mov    %esp,%ebp
    19b9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19bc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19c3:	e8 8f fd ff ff       	call   1757 <malloc>
    19c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ce:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19db:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19dd:	8b 45 08             	mov    0x8(%ebp),%eax
    19e0:	8b 40 04             	mov    0x4(%eax),%eax
    19e3:	85 c0                	test   %eax,%eax
    19e5:	75 0b                	jne    19f2 <add_q+0x3c>
        q->head = n;
    19e7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19ed:	89 50 04             	mov    %edx,0x4(%eax)
    19f0:	eb 0c                	jmp    19fe <add_q+0x48>
    }else{
        q->tail->next = n;
    19f2:	8b 45 08             	mov    0x8(%ebp),%eax
    19f5:	8b 40 08             	mov    0x8(%eax),%eax
    19f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19fb:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1a01:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a04:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	8b 00                	mov    (%eax),%eax
    1a0c:	8d 50 01             	lea    0x1(%eax),%edx
    1a0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a12:	89 10                	mov    %edx,(%eax)
}
    1a14:	c9                   	leave  
    1a15:	c3                   	ret    

00001a16 <empty_q>:

int empty_q(struct queue *q){
    1a16:	55                   	push   %ebp
    1a17:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1c:	8b 00                	mov    (%eax),%eax
    1a1e:	85 c0                	test   %eax,%eax
    1a20:	75 07                	jne    1a29 <empty_q+0x13>
        return 1;
    1a22:	b8 01 00 00 00       	mov    $0x1,%eax
    1a27:	eb 05                	jmp    1a2e <empty_q+0x18>
    else
        return 0;
    1a29:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a2e:	5d                   	pop    %ebp
    1a2f:	c3                   	ret    

00001a30 <pop_q>:
int pop_q(struct queue *q){
    1a30:	55                   	push   %ebp
    1a31:	89 e5                	mov    %esp,%ebp
    1a33:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a36:	8b 45 08             	mov    0x8(%ebp),%eax
    1a39:	89 04 24             	mov    %eax,(%esp)
    1a3c:	e8 d5 ff ff ff       	call   1a16 <empty_q>
    1a41:	85 c0                	test   %eax,%eax
    1a43:	75 5d                	jne    1aa2 <pop_q+0x72>
       val = q->head->value; 
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	8b 40 04             	mov    0x4(%eax),%eax
    1a4b:	8b 00                	mov    (%eax),%eax
    1a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a50:	8b 45 08             	mov    0x8(%ebp),%eax
    1a53:	8b 40 04             	mov    0x4(%eax),%eax
    1a56:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a59:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5c:	8b 40 04             	mov    0x4(%eax),%eax
    1a5f:	8b 50 04             	mov    0x4(%eax),%edx
    1a62:	8b 45 08             	mov    0x8(%ebp),%eax
    1a65:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a6b:	89 04 24             	mov    %eax,(%esp)
    1a6e:	e8 b5 fb ff ff       	call   1628 <free>
       q->size--;
    1a73:	8b 45 08             	mov    0x8(%ebp),%eax
    1a76:	8b 00                	mov    (%eax),%eax
    1a78:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a80:	8b 45 08             	mov    0x8(%ebp),%eax
    1a83:	8b 00                	mov    (%eax),%eax
    1a85:	85 c0                	test   %eax,%eax
    1a87:	75 14                	jne    1a9d <pop_q+0x6d>
            q->head = 0;
    1a89:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa0:	eb 05                	jmp    1aa7 <pop_q+0x77>
    }
    return -1;
    1aa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1aa7:	c9                   	leave  
    1aa8:	c3                   	ret    
