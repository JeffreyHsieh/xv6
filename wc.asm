
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 48             	sub    $0x48,%esp
    1006:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1010:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1013:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1016:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1019:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1020:	eb 66                	jmp    1088 <wc+0x88>
    1022:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1029:	eb 55                	jmp    1080 <wc+0x80>
    102b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    102f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1032:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    1039:	3c 0a                	cmp    $0xa,%al
    103b:	75 04                	jne    1041 <wc+0x41>
    103d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1041:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1044:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    104b:	0f be c0             	movsbl %al,%eax
    104e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1052:	c7 04 24 01 1c 00 00 	movl   $0x1c01,(%esp)
    1059:	e8 45 02 00 00       	call   12a3 <strchr>
    105e:	85 c0                	test   %eax,%eax
    1060:	74 09                	je     106b <wc+0x6b>
    1062:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1069:	eb 11                	jmp    107c <wc+0x7c>
    106b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    106f:	75 0b                	jne    107c <wc+0x7c>
    1071:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1075:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    107c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1080:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1083:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1086:	7c a3                	jl     102b <wc+0x2b>
    1088:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    108f:	00 
    1090:	c7 44 24 04 c0 1f 00 	movl   $0x1fc0,0x4(%esp)
    1097:	00 
    1098:	8b 45 08             	mov    0x8(%ebp),%eax
    109b:	89 04 24             	mov    %eax,(%esp)
    109e:	e8 a1 03 00 00       	call   1444 <read>
    10a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10aa:	0f 8f 72 ff ff ff    	jg     1022 <wc+0x22>
    10b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10b4:	79 19                	jns    10cf <wc+0xcf>
    10b6:	c7 44 24 04 07 1c 00 	movl   $0x1c07,0x4(%esp)
    10bd:	00 
    10be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c5:	e8 02 05 00 00       	call   15cc <printf>
    10ca:	e8 5d 03 00 00       	call   142c <exit>
    10cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d2:	89 44 24 14          	mov    %eax,0x14(%esp)
    10d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10d9:	89 44 24 10          	mov    %eax,0x10(%esp)
    10dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10e7:	89 44 24 08          	mov    %eax,0x8(%esp)
    10eb:	c7 44 24 04 17 1c 00 	movl   $0x1c17,0x4(%esp)
    10f2:	00 
    10f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10fa:	e8 cd 04 00 00       	call   15cc <printf>
    10ff:	c9                   	leave  
    1100:	c3                   	ret    

00001101 <main>:
    1101:	55                   	push   %ebp
    1102:	89 e5                	mov    %esp,%ebp
    1104:	83 e4 f0             	and    $0xfffffff0,%esp
    1107:	83 ec 20             	sub    $0x20,%esp
    110a:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    110e:	7f 19                	jg     1129 <main+0x28>
    1110:	c7 44 24 04 24 1c 00 	movl   $0x1c24,0x4(%esp)
    1117:	00 
    1118:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    111f:	e8 dc fe ff ff       	call   1000 <wc>
    1124:	e8 03 03 00 00       	call   142c <exit>
    1129:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1130:	00 
    1131:	eb 7d                	jmp    11b0 <main+0xaf>
    1133:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1137:	c1 e0 02             	shl    $0x2,%eax
    113a:	03 45 0c             	add    0xc(%ebp),%eax
    113d:	8b 00                	mov    (%eax),%eax
    113f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1146:	00 
    1147:	89 04 24             	mov    %eax,(%esp)
    114a:	e8 1d 03 00 00       	call   146c <open>
    114f:	89 44 24 18          	mov    %eax,0x18(%esp)
    1153:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1158:	79 29                	jns    1183 <main+0x82>
    115a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    115e:	c1 e0 02             	shl    $0x2,%eax
    1161:	03 45 0c             	add    0xc(%ebp),%eax
    1164:	8b 00                	mov    (%eax),%eax
    1166:	89 44 24 08          	mov    %eax,0x8(%esp)
    116a:	c7 44 24 04 25 1c 00 	movl   $0x1c25,0x4(%esp)
    1171:	00 
    1172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1179:	e8 4e 04 00 00       	call   15cc <printf>
    117e:	e8 a9 02 00 00       	call   142c <exit>
    1183:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1187:	c1 e0 02             	shl    $0x2,%eax
    118a:	03 45 0c             	add    0xc(%ebp),%eax
    118d:	8b 00                	mov    (%eax),%eax
    118f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1193:	8b 44 24 18          	mov    0x18(%esp),%eax
    1197:	89 04 24             	mov    %eax,(%esp)
    119a:	e8 61 fe ff ff       	call   1000 <wc>
    119f:	8b 44 24 18          	mov    0x18(%esp),%eax
    11a3:	89 04 24             	mov    %eax,(%esp)
    11a6:	e8 a9 02 00 00       	call   1454 <close>
    11ab:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    11b0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    11b4:	3b 45 08             	cmp    0x8(%ebp),%eax
    11b7:	0f 8c 76 ff ff ff    	jl     1133 <main+0x32>
    11bd:	e8 6a 02 00 00       	call   142c <exit>
    11c2:	66 90                	xchg   %ax,%ax

000011c4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11c4:	55                   	push   %ebp
    11c5:	89 e5                	mov    %esp,%ebp
    11c7:	57                   	push   %edi
    11c8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11cc:	8b 55 10             	mov    0x10(%ebp),%edx
    11cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d2:	89 cb                	mov    %ecx,%ebx
    11d4:	89 df                	mov    %ebx,%edi
    11d6:	89 d1                	mov    %edx,%ecx
    11d8:	fc                   	cld    
    11d9:	f3 aa                	rep stos %al,%es:(%edi)
    11db:	89 ca                	mov    %ecx,%edx
    11dd:	89 fb                	mov    %edi,%ebx
    11df:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11e2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11e5:	5b                   	pop    %ebx
    11e6:	5f                   	pop    %edi
    11e7:	5d                   	pop    %ebp
    11e8:	c3                   	ret    

000011e9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11e9:	55                   	push   %ebp
    11ea:	89 e5                	mov    %esp,%ebp
    11ec:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    11f5:	90                   	nop
    11f6:	8b 45 08             	mov    0x8(%ebp),%eax
    11f9:	8d 50 01             	lea    0x1(%eax),%edx
    11fc:	89 55 08             	mov    %edx,0x8(%ebp)
    11ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1202:	8d 4a 01             	lea    0x1(%edx),%ecx
    1205:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1208:	0f b6 12             	movzbl (%edx),%edx
    120b:	88 10                	mov    %dl,(%eax)
    120d:	0f b6 00             	movzbl (%eax),%eax
    1210:	84 c0                	test   %al,%al
    1212:	75 e2                	jne    11f6 <strcpy+0xd>
    ;
  return os;
    1214:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1217:	c9                   	leave  
    1218:	c3                   	ret    

00001219 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1219:	55                   	push   %ebp
    121a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    121c:	eb 08                	jmp    1226 <strcmp+0xd>
    p++, q++;
    121e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1222:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1226:	8b 45 08             	mov    0x8(%ebp),%eax
    1229:	0f b6 00             	movzbl (%eax),%eax
    122c:	84 c0                	test   %al,%al
    122e:	74 10                	je     1240 <strcmp+0x27>
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	0f b6 10             	movzbl (%eax),%edx
    1236:	8b 45 0c             	mov    0xc(%ebp),%eax
    1239:	0f b6 00             	movzbl (%eax),%eax
    123c:	38 c2                	cmp    %al,%dl
    123e:	74 de                	je     121e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1240:	8b 45 08             	mov    0x8(%ebp),%eax
    1243:	0f b6 00             	movzbl (%eax),%eax
    1246:	0f b6 d0             	movzbl %al,%edx
    1249:	8b 45 0c             	mov    0xc(%ebp),%eax
    124c:	0f b6 00             	movzbl (%eax),%eax
    124f:	0f b6 c0             	movzbl %al,%eax
    1252:	29 c2                	sub    %eax,%edx
    1254:	89 d0                	mov    %edx,%eax
}
    1256:	5d                   	pop    %ebp
    1257:	c3                   	ret    

00001258 <strlen>:

uint
strlen(char *s)
{
    1258:	55                   	push   %ebp
    1259:	89 e5                	mov    %esp,%ebp
    125b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    125e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1265:	eb 04                	jmp    126b <strlen+0x13>
    1267:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    126b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	01 d0                	add    %edx,%eax
    1273:	0f b6 00             	movzbl (%eax),%eax
    1276:	84 c0                	test   %al,%al
    1278:	75 ed                	jne    1267 <strlen+0xf>
    ;
  return n;
    127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    127d:	c9                   	leave  
    127e:	c3                   	ret    

0000127f <memset>:

void*
memset(void *dst, int c, uint n)
{
    127f:	55                   	push   %ebp
    1280:	89 e5                	mov    %esp,%ebp
    1282:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1285:	8b 45 10             	mov    0x10(%ebp),%eax
    1288:	89 44 24 08          	mov    %eax,0x8(%esp)
    128c:	8b 45 0c             	mov    0xc(%ebp),%eax
    128f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	89 04 24             	mov    %eax,(%esp)
    1299:	e8 26 ff ff ff       	call   11c4 <stosb>
  return dst;
    129e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a1:	c9                   	leave  
    12a2:	c3                   	ret    

000012a3 <strchr>:

char*
strchr(const char *s, char c)
{
    12a3:	55                   	push   %ebp
    12a4:	89 e5                	mov    %esp,%ebp
    12a6:	83 ec 04             	sub    $0x4,%esp
    12a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ac:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12af:	eb 14                	jmp    12c5 <strchr+0x22>
    if(*s == c)
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	0f b6 00             	movzbl (%eax),%eax
    12b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12ba:	75 05                	jne    12c1 <strchr+0x1e>
      return (char*)s;
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	eb 13                	jmp    12d4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12c5:	8b 45 08             	mov    0x8(%ebp),%eax
    12c8:	0f b6 00             	movzbl (%eax),%eax
    12cb:	84 c0                	test   %al,%al
    12cd:	75 e2                	jne    12b1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12d4:	c9                   	leave  
    12d5:	c3                   	ret    

000012d6 <gets>:

char*
gets(char *buf, int max)
{
    12d6:	55                   	push   %ebp
    12d7:	89 e5                	mov    %esp,%ebp
    12d9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12e3:	eb 4c                	jmp    1331 <gets+0x5b>
    cc = read(0, &c, 1);
    12e5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12ec:	00 
    12ed:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12fb:	e8 44 01 00 00       	call   1444 <read>
    1300:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1303:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1307:	7f 02                	jg     130b <gets+0x35>
      break;
    1309:	eb 31                	jmp    133c <gets+0x66>
    buf[i++] = c;
    130b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    130e:	8d 50 01             	lea    0x1(%eax),%edx
    1311:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1314:	89 c2                	mov    %eax,%edx
    1316:	8b 45 08             	mov    0x8(%ebp),%eax
    1319:	01 c2                	add    %eax,%edx
    131b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    131f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1321:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1325:	3c 0a                	cmp    $0xa,%al
    1327:	74 13                	je     133c <gets+0x66>
    1329:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    132d:	3c 0d                	cmp    $0xd,%al
    132f:	74 0b                	je     133c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1331:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1334:	83 c0 01             	add    $0x1,%eax
    1337:	3b 45 0c             	cmp    0xc(%ebp),%eax
    133a:	7c a9                	jl     12e5 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    133c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    133f:	8b 45 08             	mov    0x8(%ebp),%eax
    1342:	01 d0                	add    %edx,%eax
    1344:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1347:	8b 45 08             	mov    0x8(%ebp),%eax
}
    134a:	c9                   	leave  
    134b:	c3                   	ret    

0000134c <stat>:

int
stat(char *n, struct stat *st)
{
    134c:	55                   	push   %ebp
    134d:	89 e5                	mov    %esp,%ebp
    134f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1352:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1359:	00 
    135a:	8b 45 08             	mov    0x8(%ebp),%eax
    135d:	89 04 24             	mov    %eax,(%esp)
    1360:	e8 07 01 00 00       	call   146c <open>
    1365:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1368:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    136c:	79 07                	jns    1375 <stat+0x29>
    return -1;
    136e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1373:	eb 23                	jmp    1398 <stat+0x4c>
  r = fstat(fd, st);
    1375:	8b 45 0c             	mov    0xc(%ebp),%eax
    1378:	89 44 24 04          	mov    %eax,0x4(%esp)
    137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137f:	89 04 24             	mov    %eax,(%esp)
    1382:	e8 fd 00 00 00       	call   1484 <fstat>
    1387:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    138a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    138d:	89 04 24             	mov    %eax,(%esp)
    1390:	e8 bf 00 00 00       	call   1454 <close>
  return r;
    1395:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1398:	c9                   	leave  
    1399:	c3                   	ret    

0000139a <atoi>:

int
atoi(const char *s)
{
    139a:	55                   	push   %ebp
    139b:	89 e5                	mov    %esp,%ebp
    139d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13a7:	eb 25                	jmp    13ce <atoi+0x34>
    n = n*10 + *s++ - '0';
    13a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13ac:	89 d0                	mov    %edx,%eax
    13ae:	c1 e0 02             	shl    $0x2,%eax
    13b1:	01 d0                	add    %edx,%eax
    13b3:	01 c0                	add    %eax,%eax
    13b5:	89 c1                	mov    %eax,%ecx
    13b7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ba:	8d 50 01             	lea    0x1(%eax),%edx
    13bd:	89 55 08             	mov    %edx,0x8(%ebp)
    13c0:	0f b6 00             	movzbl (%eax),%eax
    13c3:	0f be c0             	movsbl %al,%eax
    13c6:	01 c8                	add    %ecx,%eax
    13c8:	83 e8 30             	sub    $0x30,%eax
    13cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13ce:	8b 45 08             	mov    0x8(%ebp),%eax
    13d1:	0f b6 00             	movzbl (%eax),%eax
    13d4:	3c 2f                	cmp    $0x2f,%al
    13d6:	7e 0a                	jle    13e2 <atoi+0x48>
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	0f b6 00             	movzbl (%eax),%eax
    13de:	3c 39                	cmp    $0x39,%al
    13e0:	7e c7                	jle    13a9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    13e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13e5:	c9                   	leave  
    13e6:	c3                   	ret    

000013e7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13e7:	55                   	push   %ebp
    13e8:	89 e5                	mov    %esp,%ebp
    13ea:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    13ed:	8b 45 08             	mov    0x8(%ebp),%eax
    13f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    13f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    13f9:	eb 17                	jmp    1412 <memmove+0x2b>
    *dst++ = *src++;
    13fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13fe:	8d 50 01             	lea    0x1(%eax),%edx
    1401:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1404:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1407:	8d 4a 01             	lea    0x1(%edx),%ecx
    140a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    140d:	0f b6 12             	movzbl (%edx),%edx
    1410:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1412:	8b 45 10             	mov    0x10(%ebp),%eax
    1415:	8d 50 ff             	lea    -0x1(%eax),%edx
    1418:	89 55 10             	mov    %edx,0x10(%ebp)
    141b:	85 c0                	test   %eax,%eax
    141d:	7f dc                	jg     13fb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1422:	c9                   	leave  
    1423:	c3                   	ret    

00001424 <fork>:
    1424:	b8 01 00 00 00       	mov    $0x1,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <exit>:
    142c:	b8 02 00 00 00       	mov    $0x2,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <wait>:
    1434:	b8 03 00 00 00       	mov    $0x3,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <pipe>:
    143c:	b8 04 00 00 00       	mov    $0x4,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <read>:
    1444:	b8 05 00 00 00       	mov    $0x5,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <write>:
    144c:	b8 10 00 00 00       	mov    $0x10,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <close>:
    1454:	b8 15 00 00 00       	mov    $0x15,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <kill>:
    145c:	b8 06 00 00 00       	mov    $0x6,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <exec>:
    1464:	b8 07 00 00 00       	mov    $0x7,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <open>:
    146c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <mknod>:
    1474:	b8 11 00 00 00       	mov    $0x11,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <unlink>:
    147c:	b8 12 00 00 00       	mov    $0x12,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <fstat>:
    1484:	b8 08 00 00 00       	mov    $0x8,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <link>:
    148c:	b8 13 00 00 00       	mov    $0x13,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <mkdir>:
    1494:	b8 14 00 00 00       	mov    $0x14,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <chdir>:
    149c:	b8 09 00 00 00       	mov    $0x9,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <dup>:
    14a4:	b8 0a 00 00 00       	mov    $0xa,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <getpid>:
    14ac:	b8 0b 00 00 00       	mov    $0xb,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <sbrk>:
    14b4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <sleep>:
    14bc:	b8 0d 00 00 00       	mov    $0xd,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <uptime>:
    14c4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <clone>:
    14cc:	b8 16 00 00 00       	mov    $0x16,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <texit>:
    14d4:	b8 17 00 00 00       	mov    $0x17,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <tsleep>:
    14dc:	b8 18 00 00 00       	mov    $0x18,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <twakeup>:
    14e4:	b8 19 00 00 00       	mov    $0x19,%eax
    14e9:	cd 40                	int    $0x40
    14eb:	c3                   	ret    

000014ec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14ec:	55                   	push   %ebp
    14ed:	89 e5                	mov    %esp,%ebp
    14ef:	83 ec 18             	sub    $0x18,%esp
    14f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14ff:	00 
    1500:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1503:	89 44 24 04          	mov    %eax,0x4(%esp)
    1507:	8b 45 08             	mov    0x8(%ebp),%eax
    150a:	89 04 24             	mov    %eax,(%esp)
    150d:	e8 3a ff ff ff       	call   144c <write>
}
    1512:	c9                   	leave  
    1513:	c3                   	ret    

00001514 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1514:	55                   	push   %ebp
    1515:	89 e5                	mov    %esp,%ebp
    1517:	56                   	push   %esi
    1518:	53                   	push   %ebx
    1519:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    151c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1523:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1527:	74 17                	je     1540 <printint+0x2c>
    1529:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    152d:	79 11                	jns    1540 <printint+0x2c>
    neg = 1;
    152f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1536:	8b 45 0c             	mov    0xc(%ebp),%eax
    1539:	f7 d8                	neg    %eax
    153b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    153e:	eb 06                	jmp    1546 <printint+0x32>
  } else {
    x = xx;
    1540:	8b 45 0c             	mov    0xc(%ebp),%eax
    1543:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1546:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    154d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1550:	8d 41 01             	lea    0x1(%ecx),%eax
    1553:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1556:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1559:	8b 45 ec             	mov    -0x14(%ebp),%eax
    155c:	ba 00 00 00 00       	mov    $0x0,%edx
    1561:	f7 f3                	div    %ebx
    1563:	89 d0                	mov    %edx,%eax
    1565:	0f b6 80 74 1f 00 00 	movzbl 0x1f74(%eax),%eax
    156c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1570:	8b 75 10             	mov    0x10(%ebp),%esi
    1573:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1576:	ba 00 00 00 00       	mov    $0x0,%edx
    157b:	f7 f6                	div    %esi
    157d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1580:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1584:	75 c7                	jne    154d <printint+0x39>
  if(neg)
    1586:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    158a:	74 10                	je     159c <printint+0x88>
    buf[i++] = '-';
    158c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158f:	8d 50 01             	lea    0x1(%eax),%edx
    1592:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1595:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    159a:	eb 1f                	jmp    15bb <printint+0xa7>
    159c:	eb 1d                	jmp    15bb <printint+0xa7>
    putc(fd, buf[i]);
    159e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a4:	01 d0                	add    %edx,%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	0f be c0             	movsbl %al,%eax
    15ac:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b0:	8b 45 08             	mov    0x8(%ebp),%eax
    15b3:	89 04 24             	mov    %eax,(%esp)
    15b6:	e8 31 ff ff ff       	call   14ec <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15bb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15c3:	79 d9                	jns    159e <printint+0x8a>
    putc(fd, buf[i]);
}
    15c5:	83 c4 30             	add    $0x30,%esp
    15c8:	5b                   	pop    %ebx
    15c9:	5e                   	pop    %esi
    15ca:	5d                   	pop    %ebp
    15cb:	c3                   	ret    

000015cc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15cc:	55                   	push   %ebp
    15cd:	89 e5                	mov    %esp,%ebp
    15cf:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15d9:	8d 45 0c             	lea    0xc(%ebp),%eax
    15dc:	83 c0 04             	add    $0x4,%eax
    15df:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15e9:	e9 7c 01 00 00       	jmp    176a <printf+0x19e>
    c = fmt[i] & 0xff;
    15ee:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f4:	01 d0                	add    %edx,%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	25 ff 00 00 00       	and    $0xff,%eax
    1601:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1604:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1608:	75 2c                	jne    1636 <printf+0x6a>
      if(c == '%'){
    160a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    160e:	75 0c                	jne    161c <printf+0x50>
        state = '%';
    1610:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1617:	e9 4a 01 00 00       	jmp    1766 <printf+0x19a>
      } else {
        putc(fd, c);
    161c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    161f:	0f be c0             	movsbl %al,%eax
    1622:	89 44 24 04          	mov    %eax,0x4(%esp)
    1626:	8b 45 08             	mov    0x8(%ebp),%eax
    1629:	89 04 24             	mov    %eax,(%esp)
    162c:	e8 bb fe ff ff       	call   14ec <putc>
    1631:	e9 30 01 00 00       	jmp    1766 <printf+0x19a>
      }
    } else if(state == '%'){
    1636:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    163a:	0f 85 26 01 00 00    	jne    1766 <printf+0x19a>
      if(c == 'd'){
    1640:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1644:	75 2d                	jne    1673 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1646:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1649:	8b 00                	mov    (%eax),%eax
    164b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1652:	00 
    1653:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    165a:	00 
    165b:	89 44 24 04          	mov    %eax,0x4(%esp)
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	89 04 24             	mov    %eax,(%esp)
    1665:	e8 aa fe ff ff       	call   1514 <printint>
        ap++;
    166a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    166e:	e9 ec 00 00 00       	jmp    175f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1673:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1677:	74 06                	je     167f <printf+0xb3>
    1679:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    167d:	75 2d                	jne    16ac <printf+0xe0>
        printint(fd, *ap, 16, 0);
    167f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1682:	8b 00                	mov    (%eax),%eax
    1684:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    168b:	00 
    168c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1693:	00 
    1694:	89 44 24 04          	mov    %eax,0x4(%esp)
    1698:	8b 45 08             	mov    0x8(%ebp),%eax
    169b:	89 04 24             	mov    %eax,(%esp)
    169e:	e8 71 fe ff ff       	call   1514 <printint>
        ap++;
    16a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16a7:	e9 b3 00 00 00       	jmp    175f <printf+0x193>
      } else if(c == 's'){
    16ac:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16b0:	75 45                	jne    16f7 <printf+0x12b>
        s = (char*)*ap;
    16b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16b5:	8b 00                	mov    (%eax),%eax
    16b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c2:	75 09                	jne    16cd <printf+0x101>
          s = "(null)";
    16c4:	c7 45 f4 39 1c 00 00 	movl   $0x1c39,-0xc(%ebp)
        while(*s != 0){
    16cb:	eb 1e                	jmp    16eb <printf+0x11f>
    16cd:	eb 1c                	jmp    16eb <printf+0x11f>
          putc(fd, *s);
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	0f b6 00             	movzbl (%eax),%eax
    16d5:	0f be c0             	movsbl %al,%eax
    16d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16dc:	8b 45 08             	mov    0x8(%ebp),%eax
    16df:	89 04 24             	mov    %eax,(%esp)
    16e2:	e8 05 fe ff ff       	call   14ec <putc>
          s++;
    16e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ee:	0f b6 00             	movzbl (%eax),%eax
    16f1:	84 c0                	test   %al,%al
    16f3:	75 da                	jne    16cf <printf+0x103>
    16f5:	eb 68                	jmp    175f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16f7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    16fb:	75 1d                	jne    171a <printf+0x14e>
        putc(fd, *ap);
    16fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1700:	8b 00                	mov    (%eax),%eax
    1702:	0f be c0             	movsbl %al,%eax
    1705:	89 44 24 04          	mov    %eax,0x4(%esp)
    1709:	8b 45 08             	mov    0x8(%ebp),%eax
    170c:	89 04 24             	mov    %eax,(%esp)
    170f:	e8 d8 fd ff ff       	call   14ec <putc>
        ap++;
    1714:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1718:	eb 45                	jmp    175f <printf+0x193>
      } else if(c == '%'){
    171a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    171e:	75 17                	jne    1737 <printf+0x16b>
        putc(fd, c);
    1720:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1723:	0f be c0             	movsbl %al,%eax
    1726:	89 44 24 04          	mov    %eax,0x4(%esp)
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	89 04 24             	mov    %eax,(%esp)
    1730:	e8 b7 fd ff ff       	call   14ec <putc>
    1735:	eb 28                	jmp    175f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1737:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    173e:	00 
    173f:	8b 45 08             	mov    0x8(%ebp),%eax
    1742:	89 04 24             	mov    %eax,(%esp)
    1745:	e8 a2 fd ff ff       	call   14ec <putc>
        putc(fd, c);
    174a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    174d:	0f be c0             	movsbl %al,%eax
    1750:	89 44 24 04          	mov    %eax,0x4(%esp)
    1754:	8b 45 08             	mov    0x8(%ebp),%eax
    1757:	89 04 24             	mov    %eax,(%esp)
    175a:	e8 8d fd ff ff       	call   14ec <putc>
      }
      state = 0;
    175f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1766:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    176a:	8b 55 0c             	mov    0xc(%ebp),%edx
    176d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1770:	01 d0                	add    %edx,%eax
    1772:	0f b6 00             	movzbl (%eax),%eax
    1775:	84 c0                	test   %al,%al
    1777:	0f 85 71 fe ff ff    	jne    15ee <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    177d:	c9                   	leave  
    177e:	c3                   	ret    
    177f:	90                   	nop

00001780 <free>:
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	83 ec 10             	sub    $0x10,%esp
    1786:	8b 45 08             	mov    0x8(%ebp),%eax
    1789:	83 e8 08             	sub    $0x8,%eax
    178c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    178f:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    1794:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1797:	eb 24                	jmp    17bd <free+0x3d>
    1799:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179c:	8b 00                	mov    (%eax),%eax
    179e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a1:	77 12                	ja     17b5 <free+0x35>
    17a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a9:	77 24                	ja     17cf <free+0x4f>
    17ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ae:	8b 00                	mov    (%eax),%eax
    17b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17b3:	77 1a                	ja     17cf <free+0x4f>
    17b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b8:	8b 00                	mov    (%eax),%eax
    17ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c3:	76 d4                	jbe    1799 <free+0x19>
    17c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c8:	8b 00                	mov    (%eax),%eax
    17ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17cd:	76 ca                	jbe    1799 <free+0x19>
    17cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d2:	8b 40 04             	mov    0x4(%eax),%eax
    17d5:	c1 e0 03             	shl    $0x3,%eax
    17d8:	89 c2                	mov    %eax,%edx
    17da:	03 55 f8             	add    -0x8(%ebp),%edx
    17dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e0:	8b 00                	mov    (%eax),%eax
    17e2:	39 c2                	cmp    %eax,%edx
    17e4:	75 24                	jne    180a <free+0x8a>
    17e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e9:	8b 50 04             	mov    0x4(%eax),%edx
    17ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ef:	8b 00                	mov    (%eax),%eax
    17f1:	8b 40 04             	mov    0x4(%eax),%eax
    17f4:	01 c2                	add    %eax,%edx
    17f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f9:	89 50 04             	mov    %edx,0x4(%eax)
    17fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ff:	8b 00                	mov    (%eax),%eax
    1801:	8b 10                	mov    (%eax),%edx
    1803:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1806:	89 10                	mov    %edx,(%eax)
    1808:	eb 0a                	jmp    1814 <free+0x94>
    180a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180d:	8b 10                	mov    (%eax),%edx
    180f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1812:	89 10                	mov    %edx,(%eax)
    1814:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1817:	8b 40 04             	mov    0x4(%eax),%eax
    181a:	c1 e0 03             	shl    $0x3,%eax
    181d:	03 45 fc             	add    -0x4(%ebp),%eax
    1820:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1823:	75 20                	jne    1845 <free+0xc5>
    1825:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1828:	8b 50 04             	mov    0x4(%eax),%edx
    182b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182e:	8b 40 04             	mov    0x4(%eax),%eax
    1831:	01 c2                	add    %eax,%edx
    1833:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1836:	89 50 04             	mov    %edx,0x4(%eax)
    1839:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183c:	8b 10                	mov    (%eax),%edx
    183e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1841:	89 10                	mov    %edx,(%eax)
    1843:	eb 08                	jmp    184d <free+0xcd>
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	8b 55 f8             	mov    -0x8(%ebp),%edx
    184b:	89 10                	mov    %edx,(%eax)
    184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1850:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
    1855:	c9                   	leave  
    1856:	c3                   	ret    

00001857 <morecore>:
    1857:	55                   	push   %ebp
    1858:	89 e5                	mov    %esp,%ebp
    185a:	83 ec 28             	sub    $0x28,%esp
    185d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1864:	77 07                	ja     186d <morecore+0x16>
    1866:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	c1 e0 03             	shl    $0x3,%eax
    1873:	89 04 24             	mov    %eax,(%esp)
    1876:	e8 39 fc ff ff       	call   14b4 <sbrk>
    187b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    187e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1882:	75 07                	jne    188b <morecore+0x34>
    1884:	b8 00 00 00 00       	mov    $0x0,%eax
    1889:	eb 22                	jmp    18ad <morecore+0x56>
    188b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1891:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1894:	8b 55 08             	mov    0x8(%ebp),%edx
    1897:	89 50 04             	mov    %edx,0x4(%eax)
    189a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189d:	83 c0 08             	add    $0x8,%eax
    18a0:	89 04 24             	mov    %eax,(%esp)
    18a3:	e8 d8 fe ff ff       	call   1780 <free>
    18a8:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    18ad:	c9                   	leave  
    18ae:	c3                   	ret    

000018af <malloc>:
    18af:	55                   	push   %ebp
    18b0:	89 e5                	mov    %esp,%ebp
    18b2:	83 ec 28             	sub    $0x28,%esp
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	83 c0 07             	add    $0x7,%eax
    18bb:	c1 e8 03             	shr    $0x3,%eax
    18be:	83 c0 01             	add    $0x1,%eax
    18c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18c4:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    18c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d0:	75 23                	jne    18f5 <malloc+0x46>
    18d2:	c7 45 f0 a0 1f 00 00 	movl   $0x1fa0,-0x10(%ebp)
    18d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dc:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
    18e1:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    18e6:	a3 a0 1f 00 00       	mov    %eax,0x1fa0
    18eb:	c7 05 a4 1f 00 00 00 	movl   $0x0,0x1fa4
    18f2:	00 00 00 
    18f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f8:	8b 00                	mov    (%eax),%eax
    18fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1900:	8b 40 04             	mov    0x4(%eax),%eax
    1903:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1906:	72 4d                	jb     1955 <malloc+0xa6>
    1908:	8b 45 ec             	mov    -0x14(%ebp),%eax
    190b:	8b 40 04             	mov    0x4(%eax),%eax
    190e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1911:	75 0c                	jne    191f <malloc+0x70>
    1913:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1916:	8b 10                	mov    (%eax),%edx
    1918:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191b:	89 10                	mov    %edx,(%eax)
    191d:	eb 26                	jmp    1945 <malloc+0x96>
    191f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1922:	8b 40 04             	mov    0x4(%eax),%eax
    1925:	89 c2                	mov    %eax,%edx
    1927:	2b 55 f4             	sub    -0xc(%ebp),%edx
    192a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192d:	89 50 04             	mov    %edx,0x4(%eax)
    1930:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1933:	8b 40 04             	mov    0x4(%eax),%eax
    1936:	c1 e0 03             	shl    $0x3,%eax
    1939:	01 45 ec             	add    %eax,-0x14(%ebp)
    193c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    193f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1942:	89 50 04             	mov    %edx,0x4(%eax)
    1945:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1948:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
    194d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1950:	83 c0 08             	add    $0x8,%eax
    1953:	eb 38                	jmp    198d <malloc+0xde>
    1955:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    195a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    195d:	75 1b                	jne    197a <malloc+0xcb>
    195f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1962:	89 04 24             	mov    %eax,(%esp)
    1965:	e8 ed fe ff ff       	call   1857 <morecore>
    196a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    196d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1971:	75 07                	jne    197a <malloc+0xcb>
    1973:	b8 00 00 00 00       	mov    $0x0,%eax
    1978:	eb 13                	jmp    198d <malloc+0xde>
    197a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    197d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1980:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1983:	8b 00                	mov    (%eax),%eax
    1985:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1988:	e9 70 ff ff ff       	jmp    18fd <malloc+0x4e>
    198d:	c9                   	leave  
    198e:	c3                   	ret    
    198f:	90                   	nop

00001990 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    1993:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1996:	8b 55 08             	mov    0x8(%ebp),%edx
    1999:	8b 45 0c             	mov    0xc(%ebp),%eax
    199c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    199f:	f0 87 02             	lock xchg %eax,(%edx)
    19a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19a8:	c9                   	leave  
    19a9:	c3                   	ret    

000019aa <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19aa:	55                   	push   %ebp
    19ab:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19ad:	8b 45 08             	mov    0x8(%ebp),%eax
    19b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19b6:	5d                   	pop    %ebp
    19b7:	c3                   	ret    

000019b8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19b8:	55                   	push   %ebp
    19b9:	89 e5                	mov    %esp,%ebp
    19bb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19be:	90                   	nop
    19bf:	8b 45 08             	mov    0x8(%ebp),%eax
    19c2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19c9:	00 
    19ca:	89 04 24             	mov    %eax,(%esp)
    19cd:	e8 be ff ff ff       	call   1990 <xchg>
    19d2:	85 c0                	test   %eax,%eax
    19d4:	75 e9                	jne    19bf <lock_acquire+0x7>
}
    19d6:	c9                   	leave  
    19d7:	c3                   	ret    

000019d8 <lock_release>:
void lock_release(lock_t *lock){
    19d8:	55                   	push   %ebp
    19d9:	89 e5                	mov    %esp,%ebp
    19db:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    19de:	8b 45 08             	mov    0x8(%ebp),%eax
    19e1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19e8:	00 
    19e9:	89 04 24             	mov    %eax,(%esp)
    19ec:	e8 9f ff ff ff       	call   1990 <xchg>
}
    19f1:	c9                   	leave  
    19f2:	c3                   	ret    

000019f3 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    19f3:	55                   	push   %ebp
    19f4:	89 e5                	mov    %esp,%ebp
    19f6:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    19f9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a00:	e8 aa fe ff ff       	call   18af <malloc>
    1a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a11:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a16:	85 c0                	test   %eax,%eax
    1a18:	74 14                	je     1a2e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a22:	89 c2                	mov    %eax,%edx
    1a24:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a29:	29 d0                	sub    %edx,%eax
    1a2b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a32:	75 1b                	jne    1a4f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a34:	c7 44 24 04 40 1c 00 	movl   $0x1c40,0x4(%esp)
    1a3b:	00 
    1a3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a43:	e8 84 fb ff ff       	call   15cc <printf>
        return 0;
    1a48:	b8 00 00 00 00       	mov    $0x0,%eax
    1a4d:	eb 6f                	jmp    1abe <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a4f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a52:	8b 55 08             	mov    0x8(%ebp),%edx
    1a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a58:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a5c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a60:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a67:	00 
    1a68:	89 04 24             	mov    %eax,(%esp)
    1a6b:	e8 5c fa ff ff       	call   14cc <clone>
    1a70:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a77:	79 1b                	jns    1a94 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1a79:	c7 44 24 04 4e 1c 00 	movl   $0x1c4e,0x4(%esp)
    1a80:	00 
    1a81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a88:	e8 3f fb ff ff       	call   15cc <printf>
        return 0;
    1a8d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a92:	eb 2a                	jmp    1abe <thread_create+0xcb>
    }
    if(tid > 0){
    1a94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a98:	7e 05                	jle    1a9f <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a9d:	eb 1f                	jmp    1abe <thread_create+0xcb>
    }
    if(tid == 0){
    1a9f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa3:	75 14                	jne    1ab9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1aa5:	c7 44 24 04 5b 1c 00 	movl   $0x1c5b,0x4(%esp)
    1aac:	00 
    1aad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab4:	e8 13 fb ff ff       	call   15cc <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ab9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1abe:	c9                   	leave  
    1abf:	c3                   	ret    

00001ac0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ac3:	a1 88 1f 00 00       	mov    0x1f88,%eax
    1ac8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1ace:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ad3:	a3 88 1f 00 00       	mov    %eax,0x1f88
    return (int)(rands % max);
    1ad8:	a1 88 1f 00 00       	mov    0x1f88,%eax
    1add:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ae0:	ba 00 00 00 00       	mov    $0x0,%edx
    1ae5:	f7 f1                	div    %ecx
    1ae7:	89 d0                	mov    %edx,%eax
}
    1ae9:	5d                   	pop    %ebp
    1aea:	c3                   	ret    
    1aeb:	90                   	nop

00001aec <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1aec:	55                   	push   %ebp
    1aed:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1aef:	8b 45 08             	mov    0x8(%ebp),%eax
    1af2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1af8:	8b 45 08             	mov    0x8(%ebp),%eax
    1afb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b02:	8b 45 08             	mov    0x8(%ebp),%eax
    1b05:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b0c:	5d                   	pop    %ebp
    1b0d:	c3                   	ret    

00001b0e <add_q>:

void add_q(struct queue *q, int v){
    1b0e:	55                   	push   %ebp
    1b0f:	89 e5                	mov    %esp,%ebp
    1b11:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b14:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b1b:	e8 8f fd ff ff       	call   18af <malloc>
    1b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b26:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b30:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b33:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b35:	8b 45 08             	mov    0x8(%ebp),%eax
    1b38:	8b 40 04             	mov    0x4(%eax),%eax
    1b3b:	85 c0                	test   %eax,%eax
    1b3d:	75 0b                	jne    1b4a <add_q+0x3c>
        q->head = n;
    1b3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b42:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b45:	89 50 04             	mov    %edx,0x4(%eax)
    1b48:	eb 0c                	jmp    1b56 <add_q+0x48>
    }else{
        q->tail->next = n;
    1b4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4d:	8b 40 08             	mov    0x8(%eax),%eax
    1b50:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b53:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b56:	8b 45 08             	mov    0x8(%ebp),%eax
    1b59:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b5c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b62:	8b 00                	mov    (%eax),%eax
    1b64:	8d 50 01             	lea    0x1(%eax),%edx
    1b67:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6a:	89 10                	mov    %edx,(%eax)
}
    1b6c:	c9                   	leave  
    1b6d:	c3                   	ret    

00001b6e <empty_q>:

int empty_q(struct queue *q){
    1b6e:	55                   	push   %ebp
    1b6f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b71:	8b 45 08             	mov    0x8(%ebp),%eax
    1b74:	8b 00                	mov    (%eax),%eax
    1b76:	85 c0                	test   %eax,%eax
    1b78:	75 07                	jne    1b81 <empty_q+0x13>
        return 1;
    1b7a:	b8 01 00 00 00       	mov    $0x1,%eax
    1b7f:	eb 05                	jmp    1b86 <empty_q+0x18>
    else
        return 0;
    1b81:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1b86:	5d                   	pop    %ebp
    1b87:	c3                   	ret    

00001b88 <pop_q>:
int pop_q(struct queue *q){
    1b88:	55                   	push   %ebp
    1b89:	89 e5                	mov    %esp,%ebp
    1b8b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b91:	89 04 24             	mov    %eax,(%esp)
    1b94:	e8 d5 ff ff ff       	call   1b6e <empty_q>
    1b99:	85 c0                	test   %eax,%eax
    1b9b:	75 5d                	jne    1bfa <pop_q+0x72>
       val = q->head->value; 
    1b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba0:	8b 40 04             	mov    0x4(%eax),%eax
    1ba3:	8b 00                	mov    (%eax),%eax
    1ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1ba8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bab:	8b 40 04             	mov    0x4(%eax),%eax
    1bae:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1bb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb4:	8b 40 04             	mov    0x4(%eax),%eax
    1bb7:	8b 50 04             	mov    0x4(%eax),%edx
    1bba:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bc3:	89 04 24             	mov    %eax,(%esp)
    1bc6:	e8 b5 fb ff ff       	call   1780 <free>
       q->size--;
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8b 00                	mov    (%eax),%eax
    1bd0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdb:	8b 00                	mov    (%eax),%eax
    1bdd:	85 c0                	test   %eax,%eax
    1bdf:	75 14                	jne    1bf5 <pop_q+0x6d>
            q->head = 0;
    1be1:	8b 45 08             	mov    0x8(%ebp),%eax
    1be4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1beb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bee:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf8:	eb 05                	jmp    1bff <pop_q+0x77>
    }
    return -1;
    1bfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1bff:	c9                   	leave  
    1c00:	c3                   	ret    
