
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
    100c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
    1013:	73 74 72 65 
    1017:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
    101e:	73 73 66 73 
    1022:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
    1029:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
    102c:	c7 44 24 04 05 1c 00 	movl   $0x1c05,0x4(%esp)
    1033:	00 
    1034:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103b:	e8 84 05 00 00       	call   15c4 <printf>
  memset(data, 'a', sizeof(data));
    1040:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1047:	00 
    1048:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
    104f:	00 
    1050:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    1054:	89 04 24             	mov    %eax,(%esp)
    1057:	e8 13 02 00 00       	call   126f <memset>

  for(i = 0; i < 4; i++)
    105c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    1063:	00 00 00 00 
    1067:	eb 13                	jmp    107c <main+0x7c>
    if(fork() > 0)
    1069:	e8 a6 03 00 00       	call   1414 <fork>
    106e:	85 c0                	test   %eax,%eax
    1070:	7e 02                	jle    1074 <main+0x74>
      break;
    1072:	eb 12                	jmp    1086 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
    1074:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    107b:	01 
    107c:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
    1083:	03 
    1084:	7e e3                	jle    1069 <main+0x69>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
    1086:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
    108d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1091:	c7 44 24 04 18 1c 00 	movl   $0x1c18,0x4(%esp)
    1098:	00 
    1099:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a0:	e8 1f 05 00 00       	call   15c4 <printf>

  path[8] += i;
    10a5:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
    10ac:	00 
    10ad:	89 c2                	mov    %eax,%edx
    10af:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
    10b6:	01 d0                	add    %edx,%eax
    10b8:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
    10bf:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    10c6:	00 
    10c7:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
    10ce:	89 04 24             	mov    %eax,(%esp)
    10d1:	e8 86 03 00 00       	call   145c <open>
    10d6:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
    10dd:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    10e4:	00 00 00 00 
    10e8:	eb 27                	jmp    1111 <main+0x111>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10ea:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    10f1:	00 
    10f2:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    10f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    10fa:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1101:	89 04 24             	mov    %eax,(%esp)
    1104:	e8 33 03 00 00       	call   143c <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
    1109:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    1110:	01 
    1111:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
    1118:	13 
    1119:	7e cf                	jle    10ea <main+0xea>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
    111b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1122:	89 04 24             	mov    %eax,(%esp)
    1125:	e8 1a 03 00 00       	call   1444 <close>

  printf(1, "read\n");
    112a:	c7 44 24 04 22 1c 00 	movl   $0x1c22,0x4(%esp)
    1131:	00 
    1132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1139:	e8 86 04 00 00       	call   15c4 <printf>

  fd = open(path, O_RDONLY);
    113e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1145:	00 
    1146:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
    114d:	89 04 24             	mov    %eax,(%esp)
    1150:	e8 07 03 00 00       	call   145c <open>
    1155:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
    115c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    1163:	00 00 00 00 
    1167:	eb 27                	jmp    1190 <main+0x190>
    read(fd, data, sizeof(data));
    1169:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1170:	00 
    1171:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    1175:	89 44 24 04          	mov    %eax,0x4(%esp)
    1179:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1180:	89 04 24             	mov    %eax,(%esp)
    1183:	e8 ac 02 00 00       	call   1434 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
    1188:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    118f:	01 
    1190:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
    1197:	13 
    1198:	7e cf                	jle    1169 <main+0x169>
    read(fd, data, sizeof(data));
  close(fd);
    119a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    11a1:	89 04 24             	mov    %eax,(%esp)
    11a4:	e8 9b 02 00 00       	call   1444 <close>

  wait();
    11a9:	e8 76 02 00 00       	call   1424 <wait>
  
  exit();
    11ae:	e8 69 02 00 00       	call   141c <exit>
    11b3:	90                   	nop

000011b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
    11b7:	57                   	push   %edi
    11b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11bc:	8b 55 10             	mov    0x10(%ebp),%edx
    11bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c2:	89 cb                	mov    %ecx,%ebx
    11c4:	89 df                	mov    %ebx,%edi
    11c6:	89 d1                	mov    %edx,%ecx
    11c8:	fc                   	cld    
    11c9:	f3 aa                	rep stos %al,%es:(%edi)
    11cb:	89 ca                	mov    %ecx,%edx
    11cd:	89 fb                	mov    %edi,%ebx
    11cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11d5:	5b                   	pop    %ebx
    11d6:	5f                   	pop    %edi
    11d7:	5d                   	pop    %ebp
    11d8:	c3                   	ret    

000011d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11d9:	55                   	push   %ebp
    11da:	89 e5                	mov    %esp,%ebp
    11dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
    11e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    11e5:	90                   	nop
    11e6:	8b 45 08             	mov    0x8(%ebp),%eax
    11e9:	8d 50 01             	lea    0x1(%eax),%edx
    11ec:	89 55 08             	mov    %edx,0x8(%ebp)
    11ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f2:	8d 4a 01             	lea    0x1(%edx),%ecx
    11f5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    11f8:	0f b6 12             	movzbl (%edx),%edx
    11fb:	88 10                	mov    %dl,(%eax)
    11fd:	0f b6 00             	movzbl (%eax),%eax
    1200:	84 c0                	test   %al,%al
    1202:	75 e2                	jne    11e6 <strcpy+0xd>
    ;
  return os;
    1204:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1207:	c9                   	leave  
    1208:	c3                   	ret    

00001209 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1209:	55                   	push   %ebp
    120a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    120c:	eb 08                	jmp    1216 <strcmp+0xd>
    p++, q++;
    120e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1212:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	0f b6 00             	movzbl (%eax),%eax
    121c:	84 c0                	test   %al,%al
    121e:	74 10                	je     1230 <strcmp+0x27>
    1220:	8b 45 08             	mov    0x8(%ebp),%eax
    1223:	0f b6 10             	movzbl (%eax),%edx
    1226:	8b 45 0c             	mov    0xc(%ebp),%eax
    1229:	0f b6 00             	movzbl (%eax),%eax
    122c:	38 c2                	cmp    %al,%dl
    122e:	74 de                	je     120e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	0f b6 00             	movzbl (%eax),%eax
    1236:	0f b6 d0             	movzbl %al,%edx
    1239:	8b 45 0c             	mov    0xc(%ebp),%eax
    123c:	0f b6 00             	movzbl (%eax),%eax
    123f:	0f b6 c0             	movzbl %al,%eax
    1242:	29 c2                	sub    %eax,%edx
    1244:	89 d0                	mov    %edx,%eax
}
    1246:	5d                   	pop    %ebp
    1247:	c3                   	ret    

00001248 <strlen>:

uint
strlen(char *s)
{
    1248:	55                   	push   %ebp
    1249:	89 e5                	mov    %esp,%ebp
    124b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    124e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1255:	eb 04                	jmp    125b <strlen+0x13>
    1257:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    125b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    125e:	8b 45 08             	mov    0x8(%ebp),%eax
    1261:	01 d0                	add    %edx,%eax
    1263:	0f b6 00             	movzbl (%eax),%eax
    1266:	84 c0                	test   %al,%al
    1268:	75 ed                	jne    1257 <strlen+0xf>
    ;
  return n;
    126a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    126d:	c9                   	leave  
    126e:	c3                   	ret    

0000126f <memset>:

void*
memset(void *dst, int c, uint n)
{
    126f:	55                   	push   %ebp
    1270:	89 e5                	mov    %esp,%ebp
    1272:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1275:	8b 45 10             	mov    0x10(%ebp),%eax
    1278:	89 44 24 08          	mov    %eax,0x8(%esp)
    127c:	8b 45 0c             	mov    0xc(%ebp),%eax
    127f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
    1286:	89 04 24             	mov    %eax,(%esp)
    1289:	e8 26 ff ff ff       	call   11b4 <stosb>
  return dst;
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1291:	c9                   	leave  
    1292:	c3                   	ret    

00001293 <strchr>:

char*
strchr(const char *s, char c)
{
    1293:	55                   	push   %ebp
    1294:	89 e5                	mov    %esp,%ebp
    1296:	83 ec 04             	sub    $0x4,%esp
    1299:	8b 45 0c             	mov    0xc(%ebp),%eax
    129c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    129f:	eb 14                	jmp    12b5 <strchr+0x22>
    if(*s == c)
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	0f b6 00             	movzbl (%eax),%eax
    12a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12aa:	75 05                	jne    12b1 <strchr+0x1e>
      return (char*)s;
    12ac:	8b 45 08             	mov    0x8(%ebp),%eax
    12af:	eb 13                	jmp    12c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12b5:	8b 45 08             	mov    0x8(%ebp),%eax
    12b8:	0f b6 00             	movzbl (%eax),%eax
    12bb:	84 c0                	test   %al,%al
    12bd:	75 e2                	jne    12a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12c4:	c9                   	leave  
    12c5:	c3                   	ret    

000012c6 <gets>:

char*
gets(char *buf, int max)
{
    12c6:	55                   	push   %ebp
    12c7:	89 e5                	mov    %esp,%ebp
    12c9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12d3:	eb 4c                	jmp    1321 <gets+0x5b>
    cc = read(0, &c, 1);
    12d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12dc:	00 
    12dd:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12eb:	e8 44 01 00 00       	call   1434 <read>
    12f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    12f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12f7:	7f 02                	jg     12fb <gets+0x35>
      break;
    12f9:	eb 31                	jmp    132c <gets+0x66>
    buf[i++] = c;
    12fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12fe:	8d 50 01             	lea    0x1(%eax),%edx
    1301:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1304:	89 c2                	mov    %eax,%edx
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
    1309:	01 c2                	add    %eax,%edx
    130b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    130f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1311:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1315:	3c 0a                	cmp    $0xa,%al
    1317:	74 13                	je     132c <gets+0x66>
    1319:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    131d:	3c 0d                	cmp    $0xd,%al
    131f:	74 0b                	je     132c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1321:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1324:	83 c0 01             	add    $0x1,%eax
    1327:	3b 45 0c             	cmp    0xc(%ebp),%eax
    132a:	7c a9                	jl     12d5 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    132c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    132f:	8b 45 08             	mov    0x8(%ebp),%eax
    1332:	01 d0                	add    %edx,%eax
    1334:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1337:	8b 45 08             	mov    0x8(%ebp),%eax
}
    133a:	c9                   	leave  
    133b:	c3                   	ret    

0000133c <stat>:

int
stat(char *n, struct stat *st)
{
    133c:	55                   	push   %ebp
    133d:	89 e5                	mov    %esp,%ebp
    133f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1342:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1349:	00 
    134a:	8b 45 08             	mov    0x8(%ebp),%eax
    134d:	89 04 24             	mov    %eax,(%esp)
    1350:	e8 07 01 00 00       	call   145c <open>
    1355:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1358:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    135c:	79 07                	jns    1365 <stat+0x29>
    return -1;
    135e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1363:	eb 23                	jmp    1388 <stat+0x4c>
  r = fstat(fd, st);
    1365:	8b 45 0c             	mov    0xc(%ebp),%eax
    1368:	89 44 24 04          	mov    %eax,0x4(%esp)
    136c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    136f:	89 04 24             	mov    %eax,(%esp)
    1372:	e8 fd 00 00 00       	call   1474 <fstat>
    1377:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    137a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137d:	89 04 24             	mov    %eax,(%esp)
    1380:	e8 bf 00 00 00       	call   1444 <close>
  return r;
    1385:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1388:	c9                   	leave  
    1389:	c3                   	ret    

0000138a <atoi>:

int
atoi(const char *s)
{
    138a:	55                   	push   %ebp
    138b:	89 e5                	mov    %esp,%ebp
    138d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1390:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1397:	eb 25                	jmp    13be <atoi+0x34>
    n = n*10 + *s++ - '0';
    1399:	8b 55 fc             	mov    -0x4(%ebp),%edx
    139c:	89 d0                	mov    %edx,%eax
    139e:	c1 e0 02             	shl    $0x2,%eax
    13a1:	01 d0                	add    %edx,%eax
    13a3:	01 c0                	add    %eax,%eax
    13a5:	89 c1                	mov    %eax,%ecx
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	8d 50 01             	lea    0x1(%eax),%edx
    13ad:	89 55 08             	mov    %edx,0x8(%ebp)
    13b0:	0f b6 00             	movzbl (%eax),%eax
    13b3:	0f be c0             	movsbl %al,%eax
    13b6:	01 c8                	add    %ecx,%eax
    13b8:	83 e8 30             	sub    $0x30,%eax
    13bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
    13c1:	0f b6 00             	movzbl (%eax),%eax
    13c4:	3c 2f                	cmp    $0x2f,%al
    13c6:	7e 0a                	jle    13d2 <atoi+0x48>
    13c8:	8b 45 08             	mov    0x8(%ebp),%eax
    13cb:	0f b6 00             	movzbl (%eax),%eax
    13ce:	3c 39                	cmp    $0x39,%al
    13d0:	7e c7                	jle    1399 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    13d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13d5:	c9                   	leave  
    13d6:	c3                   	ret    

000013d7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13d7:	55                   	push   %ebp
    13d8:	89 e5                	mov    %esp,%ebp
    13da:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    13dd:	8b 45 08             	mov    0x8(%ebp),%eax
    13e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    13e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    13e9:	eb 17                	jmp    1402 <memmove+0x2b>
    *dst++ = *src++;
    13eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ee:	8d 50 01             	lea    0x1(%eax),%edx
    13f1:	89 55 fc             	mov    %edx,-0x4(%ebp)
    13f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13f7:	8d 4a 01             	lea    0x1(%edx),%ecx
    13fa:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    13fd:	0f b6 12             	movzbl (%edx),%edx
    1400:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1402:	8b 45 10             	mov    0x10(%ebp),%eax
    1405:	8d 50 ff             	lea    -0x1(%eax),%edx
    1408:	89 55 10             	mov    %edx,0x10(%ebp)
    140b:	85 c0                	test   %eax,%eax
    140d:	7f dc                	jg     13eb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1412:	c9                   	leave  
    1413:	c3                   	ret    

00001414 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1414:	b8 01 00 00 00       	mov    $0x1,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <exit>:
SYSCALL(exit)
    141c:	b8 02 00 00 00       	mov    $0x2,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <wait>:
SYSCALL(wait)
    1424:	b8 03 00 00 00       	mov    $0x3,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <pipe>:
SYSCALL(pipe)
    142c:	b8 04 00 00 00       	mov    $0x4,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <read>:
SYSCALL(read)
    1434:	b8 05 00 00 00       	mov    $0x5,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <write>:
SYSCALL(write)
    143c:	b8 10 00 00 00       	mov    $0x10,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <close>:
SYSCALL(close)
    1444:	b8 15 00 00 00       	mov    $0x15,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <kill>:
SYSCALL(kill)
    144c:	b8 06 00 00 00       	mov    $0x6,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <exec>:
SYSCALL(exec)
    1454:	b8 07 00 00 00       	mov    $0x7,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <open>:
SYSCALL(open)
    145c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <mknod>:
SYSCALL(mknod)
    1464:	b8 11 00 00 00       	mov    $0x11,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <unlink>:
SYSCALL(unlink)
    146c:	b8 12 00 00 00       	mov    $0x12,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <fstat>:
SYSCALL(fstat)
    1474:	b8 08 00 00 00       	mov    $0x8,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <link>:
SYSCALL(link)
    147c:	b8 13 00 00 00       	mov    $0x13,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <mkdir>:
SYSCALL(mkdir)
    1484:	b8 14 00 00 00       	mov    $0x14,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <chdir>:
SYSCALL(chdir)
    148c:	b8 09 00 00 00       	mov    $0x9,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <dup>:
SYSCALL(dup)
    1494:	b8 0a 00 00 00       	mov    $0xa,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <getpid>:
SYSCALL(getpid)
    149c:	b8 0b 00 00 00       	mov    $0xb,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <sbrk>:
SYSCALL(sbrk)
    14a4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <sleep>:
SYSCALL(sleep)
    14ac:	b8 0d 00 00 00       	mov    $0xd,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <uptime>:
SYSCALL(uptime)
    14b4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <clone>:
SYSCALL(clone)
    14bc:	b8 16 00 00 00       	mov    $0x16,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <texit>:
SYSCALL(texit)
    14c4:	b8 17 00 00 00       	mov    $0x17,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <tsleep>:
SYSCALL(tsleep)
    14cc:	b8 18 00 00 00       	mov    $0x18,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <twakeup>:
SYSCALL(twakeup)
    14d4:	b8 19 00 00 00       	mov    $0x19,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <thread_yield>:
SYSCALL(thread_yield)
    14dc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14e4:	55                   	push   %ebp
    14e5:	89 e5                	mov    %esp,%ebp
    14e7:	83 ec 18             	sub    $0x18,%esp
    14ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ed:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14f7:	00 
    14f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14fb:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	89 04 24             	mov    %eax,(%esp)
    1505:	e8 32 ff ff ff       	call   143c <write>
}
    150a:	c9                   	leave  
    150b:	c3                   	ret    

0000150c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    150c:	55                   	push   %ebp
    150d:	89 e5                	mov    %esp,%ebp
    150f:	56                   	push   %esi
    1510:	53                   	push   %ebx
    1511:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1514:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    151b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    151f:	74 17                	je     1538 <printint+0x2c>
    1521:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1525:	79 11                	jns    1538 <printint+0x2c>
    neg = 1;
    1527:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    152e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1531:	f7 d8                	neg    %eax
    1533:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1536:	eb 06                	jmp    153e <printint+0x32>
  } else {
    x = xx;
    1538:	8b 45 0c             	mov    0xc(%ebp),%eax
    153b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    153e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1545:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1548:	8d 41 01             	lea    0x1(%ecx),%eax
    154b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    154e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1551:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1554:	ba 00 00 00 00       	mov    $0x0,%edx
    1559:	f7 f3                	div    %ebx
    155b:	89 d0                	mov    %edx,%eax
    155d:	0f b6 80 e0 1f 00 00 	movzbl 0x1fe0(%eax),%eax
    1564:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1568:	8b 75 10             	mov    0x10(%ebp),%esi
    156b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    156e:	ba 00 00 00 00       	mov    $0x0,%edx
    1573:	f7 f6                	div    %esi
    1575:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1578:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    157c:	75 c7                	jne    1545 <printint+0x39>
  if(neg)
    157e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1582:	74 10                	je     1594 <printint+0x88>
    buf[i++] = '-';
    1584:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1587:	8d 50 01             	lea    0x1(%eax),%edx
    158a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    158d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1592:	eb 1f                	jmp    15b3 <printint+0xa7>
    1594:	eb 1d                	jmp    15b3 <printint+0xa7>
    putc(fd, buf[i]);
    1596:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1599:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159c:	01 d0                	add    %edx,%eax
    159e:	0f b6 00             	movzbl (%eax),%eax
    15a1:	0f be c0             	movsbl %al,%eax
    15a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	89 04 24             	mov    %eax,(%esp)
    15ae:	e8 31 ff ff ff       	call   14e4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15b3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15bb:	79 d9                	jns    1596 <printint+0x8a>
    putc(fd, buf[i]);
}
    15bd:	83 c4 30             	add    $0x30,%esp
    15c0:	5b                   	pop    %ebx
    15c1:	5e                   	pop    %esi
    15c2:	5d                   	pop    %ebp
    15c3:	c3                   	ret    

000015c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15c4:	55                   	push   %ebp
    15c5:	89 e5                	mov    %esp,%ebp
    15c7:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15d1:	8d 45 0c             	lea    0xc(%ebp),%eax
    15d4:	83 c0 04             	add    $0x4,%eax
    15d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15e1:	e9 7c 01 00 00       	jmp    1762 <printf+0x19e>
    c = fmt[i] & 0xff;
    15e6:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ec:	01 d0                	add    %edx,%eax
    15ee:	0f b6 00             	movzbl (%eax),%eax
    15f1:	0f be c0             	movsbl %al,%eax
    15f4:	25 ff 00 00 00       	and    $0xff,%eax
    15f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    15fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1600:	75 2c                	jne    162e <printf+0x6a>
      if(c == '%'){
    1602:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1606:	75 0c                	jne    1614 <printf+0x50>
        state = '%';
    1608:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    160f:	e9 4a 01 00 00       	jmp    175e <printf+0x19a>
      } else {
        putc(fd, c);
    1614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1617:	0f be c0             	movsbl %al,%eax
    161a:	89 44 24 04          	mov    %eax,0x4(%esp)
    161e:	8b 45 08             	mov    0x8(%ebp),%eax
    1621:	89 04 24             	mov    %eax,(%esp)
    1624:	e8 bb fe ff ff       	call   14e4 <putc>
    1629:	e9 30 01 00 00       	jmp    175e <printf+0x19a>
      }
    } else if(state == '%'){
    162e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1632:	0f 85 26 01 00 00    	jne    175e <printf+0x19a>
      if(c == 'd'){
    1638:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    163c:	75 2d                	jne    166b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    163e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1641:	8b 00                	mov    (%eax),%eax
    1643:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    164a:	00 
    164b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1652:	00 
    1653:	89 44 24 04          	mov    %eax,0x4(%esp)
    1657:	8b 45 08             	mov    0x8(%ebp),%eax
    165a:	89 04 24             	mov    %eax,(%esp)
    165d:	e8 aa fe ff ff       	call   150c <printint>
        ap++;
    1662:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1666:	e9 ec 00 00 00       	jmp    1757 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    166b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    166f:	74 06                	je     1677 <printf+0xb3>
    1671:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1675:	75 2d                	jne    16a4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1677:	8b 45 e8             	mov    -0x18(%ebp),%eax
    167a:	8b 00                	mov    (%eax),%eax
    167c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1683:	00 
    1684:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    168b:	00 
    168c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	89 04 24             	mov    %eax,(%esp)
    1696:	e8 71 fe ff ff       	call   150c <printint>
        ap++;
    169b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    169f:	e9 b3 00 00 00       	jmp    1757 <printf+0x193>
      } else if(c == 's'){
    16a4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16a8:	75 45                	jne    16ef <printf+0x12b>
        s = (char*)*ap;
    16aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16ad:	8b 00                	mov    (%eax),%eax
    16af:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16ba:	75 09                	jne    16c5 <printf+0x101>
          s = "(null)";
    16bc:	c7 45 f4 28 1c 00 00 	movl   $0x1c28,-0xc(%ebp)
        while(*s != 0){
    16c3:	eb 1e                	jmp    16e3 <printf+0x11f>
    16c5:	eb 1c                	jmp    16e3 <printf+0x11f>
          putc(fd, *s);
    16c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ca:	0f b6 00             	movzbl (%eax),%eax
    16cd:	0f be c0             	movsbl %al,%eax
    16d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	89 04 24             	mov    %eax,(%esp)
    16da:	e8 05 fe ff ff       	call   14e4 <putc>
          s++;
    16df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	0f b6 00             	movzbl (%eax),%eax
    16e9:	84 c0                	test   %al,%al
    16eb:	75 da                	jne    16c7 <printf+0x103>
    16ed:	eb 68                	jmp    1757 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16ef:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    16f3:	75 1d                	jne    1712 <printf+0x14e>
        putc(fd, *ap);
    16f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16f8:	8b 00                	mov    (%eax),%eax
    16fa:	0f be c0             	movsbl %al,%eax
    16fd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1701:	8b 45 08             	mov    0x8(%ebp),%eax
    1704:	89 04 24             	mov    %eax,(%esp)
    1707:	e8 d8 fd ff ff       	call   14e4 <putc>
        ap++;
    170c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1710:	eb 45                	jmp    1757 <printf+0x193>
      } else if(c == '%'){
    1712:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1716:	75 17                	jne    172f <printf+0x16b>
        putc(fd, c);
    1718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    171b:	0f be c0             	movsbl %al,%eax
    171e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1722:	8b 45 08             	mov    0x8(%ebp),%eax
    1725:	89 04 24             	mov    %eax,(%esp)
    1728:	e8 b7 fd ff ff       	call   14e4 <putc>
    172d:	eb 28                	jmp    1757 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    172f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1736:	00 
    1737:	8b 45 08             	mov    0x8(%ebp),%eax
    173a:	89 04 24             	mov    %eax,(%esp)
    173d:	e8 a2 fd ff ff       	call   14e4 <putc>
        putc(fd, c);
    1742:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1745:	0f be c0             	movsbl %al,%eax
    1748:	89 44 24 04          	mov    %eax,0x4(%esp)
    174c:	8b 45 08             	mov    0x8(%ebp),%eax
    174f:	89 04 24             	mov    %eax,(%esp)
    1752:	e8 8d fd ff ff       	call   14e4 <putc>
      }
      state = 0;
    1757:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    175e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1762:	8b 55 0c             	mov    0xc(%ebp),%edx
    1765:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1768:	01 d0                	add    %edx,%eax
    176a:	0f b6 00             	movzbl (%eax),%eax
    176d:	84 c0                	test   %al,%al
    176f:	0f 85 71 fe ff ff    	jne    15e6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1775:	c9                   	leave  
    1776:	c3                   	ret    
    1777:	90                   	nop

00001778 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1778:	55                   	push   %ebp
    1779:	89 e5                	mov    %esp,%ebp
    177b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    177e:	8b 45 08             	mov    0x8(%ebp),%eax
    1781:	83 e8 08             	sub    $0x8,%eax
    1784:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1787:	a1 00 20 00 00       	mov    0x2000,%eax
    178c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    178f:	eb 24                	jmp    17b5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	8b 00                	mov    (%eax),%eax
    1796:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1799:	77 12                	ja     17ad <free+0x35>
    179b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a1:	77 24                	ja     17c7 <free+0x4f>
    17a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a6:	8b 00                	mov    (%eax),%eax
    17a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17ab:	77 1a                	ja     17c7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b0:	8b 00                	mov    (%eax),%eax
    17b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17bb:	76 d4                	jbe    1791 <free+0x19>
    17bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c0:	8b 00                	mov    (%eax),%eax
    17c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17c5:	76 ca                	jbe    1791 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    17c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ca:	8b 40 04             	mov    0x4(%eax),%eax
    17cd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    17d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d7:	01 c2                	add    %eax,%edx
    17d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17dc:	8b 00                	mov    (%eax),%eax
    17de:	39 c2                	cmp    %eax,%edx
    17e0:	75 24                	jne    1806 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    17e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e5:	8b 50 04             	mov    0x4(%eax),%edx
    17e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17eb:	8b 00                	mov    (%eax),%eax
    17ed:	8b 40 04             	mov    0x4(%eax),%eax
    17f0:	01 c2                	add    %eax,%edx
    17f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    17f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17fb:	8b 00                	mov    (%eax),%eax
    17fd:	8b 10                	mov    (%eax),%edx
    17ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1802:	89 10                	mov    %edx,(%eax)
    1804:	eb 0a                	jmp    1810 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1806:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1809:	8b 10                	mov    (%eax),%edx
    180b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1810:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1813:	8b 40 04             	mov    0x4(%eax),%eax
    1816:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    181d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1820:	01 d0                	add    %edx,%eax
    1822:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1825:	75 20                	jne    1847 <free+0xcf>
    p->s.size += bp->s.size;
    1827:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182a:	8b 50 04             	mov    0x4(%eax),%edx
    182d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1830:	8b 40 04             	mov    0x4(%eax),%eax
    1833:	01 c2                	add    %eax,%edx
    1835:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1838:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    183b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183e:	8b 10                	mov    (%eax),%edx
    1840:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1843:	89 10                	mov    %edx,(%eax)
    1845:	eb 08                	jmp    184f <free+0xd7>
  } else
    p->s.ptr = bp;
    1847:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    184d:	89 10                	mov    %edx,(%eax)
  freep = p;
    184f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1852:	a3 00 20 00 00       	mov    %eax,0x2000
}
    1857:	c9                   	leave  
    1858:	c3                   	ret    

00001859 <morecore>:

static Header*
morecore(uint nu)
{
    1859:	55                   	push   %ebp
    185a:	89 e5                	mov    %esp,%ebp
    185c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    185f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1866:	77 07                	ja     186f <morecore+0x16>
    nu = 4096;
    1868:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    186f:	8b 45 08             	mov    0x8(%ebp),%eax
    1872:	c1 e0 03             	shl    $0x3,%eax
    1875:	89 04 24             	mov    %eax,(%esp)
    1878:	e8 27 fc ff ff       	call   14a4 <sbrk>
    187d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1880:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1884:	75 07                	jne    188d <morecore+0x34>
    return 0;
    1886:	b8 00 00 00 00       	mov    $0x0,%eax
    188b:	eb 22                	jmp    18af <morecore+0x56>
  hp = (Header*)p;
    188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1893:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1896:	8b 55 08             	mov    0x8(%ebp),%edx
    1899:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    189c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    189f:	83 c0 08             	add    $0x8,%eax
    18a2:	89 04 24             	mov    %eax,(%esp)
    18a5:	e8 ce fe ff ff       	call   1778 <free>
  return freep;
    18aa:	a1 00 20 00 00       	mov    0x2000,%eax
}
    18af:	c9                   	leave  
    18b0:	c3                   	ret    

000018b1 <malloc>:

void*
malloc(uint nbytes)
{
    18b1:	55                   	push   %ebp
    18b2:	89 e5                	mov    %esp,%ebp
    18b4:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18b7:	8b 45 08             	mov    0x8(%ebp),%eax
    18ba:	83 c0 07             	add    $0x7,%eax
    18bd:	c1 e8 03             	shr    $0x3,%eax
    18c0:	83 c0 01             	add    $0x1,%eax
    18c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    18c6:	a1 00 20 00 00       	mov    0x2000,%eax
    18cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d2:	75 23                	jne    18f7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    18d4:	c7 45 f0 f8 1f 00 00 	movl   $0x1ff8,-0x10(%ebp)
    18db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18de:	a3 00 20 00 00       	mov    %eax,0x2000
    18e3:	a1 00 20 00 00       	mov    0x2000,%eax
    18e8:	a3 f8 1f 00 00       	mov    %eax,0x1ff8
    base.s.size = 0;
    18ed:	c7 05 fc 1f 00 00 00 	movl   $0x0,0x1ffc
    18f4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18fa:	8b 00                	mov    (%eax),%eax
    18fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1902:	8b 40 04             	mov    0x4(%eax),%eax
    1905:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1908:	72 4d                	jb     1957 <malloc+0xa6>
      if(p->s.size == nunits)
    190a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190d:	8b 40 04             	mov    0x4(%eax),%eax
    1910:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1913:	75 0c                	jne    1921 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1915:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1918:	8b 10                	mov    (%eax),%edx
    191a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191d:	89 10                	mov    %edx,(%eax)
    191f:	eb 26                	jmp    1947 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1921:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1924:	8b 40 04             	mov    0x4(%eax),%eax
    1927:	2b 45 ec             	sub    -0x14(%ebp),%eax
    192a:	89 c2                	mov    %eax,%edx
    192c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1932:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1935:	8b 40 04             	mov    0x4(%eax),%eax
    1938:	c1 e0 03             	shl    $0x3,%eax
    193b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    193e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1941:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1944:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1947:	8b 45 f0             	mov    -0x10(%ebp),%eax
    194a:	a3 00 20 00 00       	mov    %eax,0x2000
      return (void*)(p + 1);
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	83 c0 08             	add    $0x8,%eax
    1955:	eb 38                	jmp    198f <malloc+0xde>
    }
    if(p == freep)
    1957:	a1 00 20 00 00       	mov    0x2000,%eax
    195c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    195f:	75 1b                	jne    197c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1961:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1964:	89 04 24             	mov    %eax,(%esp)
    1967:	e8 ed fe ff ff       	call   1859 <morecore>
    196c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    196f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1973:	75 07                	jne    197c <malloc+0xcb>
        return 0;
    1975:	b8 00 00 00 00       	mov    $0x0,%eax
    197a:	eb 13                	jmp    198f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    197c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1982:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1985:	8b 00                	mov    (%eax),%eax
    1987:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    198a:	e9 70 ff ff ff       	jmp    18ff <malloc+0x4e>
}
    198f:	c9                   	leave  
    1990:	c3                   	ret    
    1991:	66 90                	xchg   %ax,%ax
    1993:	90                   	nop

00001994 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1994:	55                   	push   %ebp
    1995:	89 e5                	mov    %esp,%ebp
    1997:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    199a:	8b 55 08             	mov    0x8(%ebp),%edx
    199d:	8b 45 0c             	mov    0xc(%ebp),%eax
    19a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19a3:	f0 87 02             	lock xchg %eax,(%edx)
    19a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19ac:	c9                   	leave  
    19ad:	c3                   	ret    

000019ae <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19ae:	55                   	push   %ebp
    19af:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19b1:	8b 45 08             	mov    0x8(%ebp),%eax
    19b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19ba:	5d                   	pop    %ebp
    19bb:	c3                   	ret    

000019bc <lock_acquire>:
void lock_acquire(lock_t *lock){
    19bc:	55                   	push   %ebp
    19bd:	89 e5                	mov    %esp,%ebp
    19bf:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19c2:	90                   	nop
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19cd:	00 
    19ce:	89 04 24             	mov    %eax,(%esp)
    19d1:	e8 be ff ff ff       	call   1994 <xchg>
    19d6:	85 c0                	test   %eax,%eax
    19d8:	75 e9                	jne    19c3 <lock_acquire+0x7>
}
    19da:	c9                   	leave  
    19db:	c3                   	ret    

000019dc <lock_release>:
void lock_release(lock_t *lock){
    19dc:	55                   	push   %ebp
    19dd:	89 e5                	mov    %esp,%ebp
    19df:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    19e2:	8b 45 08             	mov    0x8(%ebp),%eax
    19e5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19ec:	00 
    19ed:	89 04 24             	mov    %eax,(%esp)
    19f0:	e8 9f ff ff ff       	call   1994 <xchg>
}
    19f5:	c9                   	leave  
    19f6:	c3                   	ret    

000019f7 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    19f7:	55                   	push   %ebp
    19f8:	89 e5                	mov    %esp,%ebp
    19fa:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    19fd:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a04:	e8 a8 fe ff ff       	call   18b1 <malloc>
    1a09:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a15:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a1a:	85 c0                	test   %eax,%eax
    1a1c:	74 14                	je     1a32 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a21:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a26:	89 c2                	mov    %eax,%edx
    1a28:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a2d:	29 d0                	sub    %edx,%eax
    1a2f:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a32:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a36:	75 1b                	jne    1a53 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a38:	c7 44 24 04 2f 1c 00 	movl   $0x1c2f,0x4(%esp)
    1a3f:	00 
    1a40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a47:	e8 78 fb ff ff       	call   15c4 <printf>
        return 0;
    1a4c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a51:	eb 6f                	jmp    1ac2 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a56:	8b 55 08             	mov    0x8(%ebp),%edx
    1a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a60:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a64:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a6b:	00 
    1a6c:	89 04 24             	mov    %eax,(%esp)
    1a6f:	e8 48 fa ff ff       	call   14bc <clone>
    1a74:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a77:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a7b:	79 1b                	jns    1a98 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1a7d:	c7 44 24 04 3d 1c 00 	movl   $0x1c3d,0x4(%esp)
    1a84:	00 
    1a85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a8c:	e8 33 fb ff ff       	call   15c4 <printf>
        return 0;
    1a91:	b8 00 00 00 00       	mov    $0x0,%eax
    1a96:	eb 2a                	jmp    1ac2 <thread_create+0xcb>
    }
    if(tid > 0){
    1a98:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a9c:	7e 05                	jle    1aa3 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aa1:	eb 1f                	jmp    1ac2 <thread_create+0xcb>
    }
    if(tid == 0){
    1aa3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa7:	75 14                	jne    1abd <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1aa9:	c7 44 24 04 4a 1c 00 	movl   $0x1c4a,0x4(%esp)
    1ab0:	00 
    1ab1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab8:	e8 07 fb ff ff       	call   15c4 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1abd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ac2:	c9                   	leave  
    1ac3:	c3                   	ret    

00001ac4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ac4:	55                   	push   %ebp
    1ac5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ac7:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1acc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1ad2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ad7:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    return (int)(rands % max);
    1adc:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1ae1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ae4:	ba 00 00 00 00       	mov    $0x0,%edx
    1ae9:	f7 f1                	div    %ecx
    1aeb:	89 d0                	mov    %edx,%eax
}
    1aed:	5d                   	pop    %ebp
    1aee:	c3                   	ret    
    1aef:	90                   	nop

00001af0 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1af0:	55                   	push   %ebp
    1af1:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1af3:	8b 45 08             	mov    0x8(%ebp),%eax
    1af6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1afc:	8b 45 08             	mov    0x8(%ebp),%eax
    1aff:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b06:	8b 45 08             	mov    0x8(%ebp),%eax
    1b09:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b10:	5d                   	pop    %ebp
    1b11:	c3                   	ret    

00001b12 <add_q>:

void add_q(struct queue *q, int v){
    1b12:	55                   	push   %ebp
    1b13:	89 e5                	mov    %esp,%ebp
    1b15:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b18:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b1f:	e8 8d fd ff ff       	call   18b1 <malloc>
    1b24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b2a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b34:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b37:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b39:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3c:	8b 40 04             	mov    0x4(%eax),%eax
    1b3f:	85 c0                	test   %eax,%eax
    1b41:	75 0b                	jne    1b4e <add_q+0x3c>
        q->head = n;
    1b43:	8b 45 08             	mov    0x8(%ebp),%eax
    1b46:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b49:	89 50 04             	mov    %edx,0x4(%eax)
    1b4c:	eb 0c                	jmp    1b5a <add_q+0x48>
    }else{
        q->tail->next = n;
    1b4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b51:	8b 40 08             	mov    0x8(%eax),%eax
    1b54:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b57:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b60:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b63:	8b 45 08             	mov    0x8(%ebp),%eax
    1b66:	8b 00                	mov    (%eax),%eax
    1b68:	8d 50 01             	lea    0x1(%eax),%edx
    1b6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6e:	89 10                	mov    %edx,(%eax)
}
    1b70:	c9                   	leave  
    1b71:	c3                   	ret    

00001b72 <empty_q>:

int empty_q(struct queue *q){
    1b72:	55                   	push   %ebp
    1b73:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b75:	8b 45 08             	mov    0x8(%ebp),%eax
    1b78:	8b 00                	mov    (%eax),%eax
    1b7a:	85 c0                	test   %eax,%eax
    1b7c:	75 07                	jne    1b85 <empty_q+0x13>
        return 1;
    1b7e:	b8 01 00 00 00       	mov    $0x1,%eax
    1b83:	eb 05                	jmp    1b8a <empty_q+0x18>
    else
        return 0;
    1b85:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1b8a:	5d                   	pop    %ebp
    1b8b:	c3                   	ret    

00001b8c <pop_q>:
int pop_q(struct queue *q){
    1b8c:	55                   	push   %ebp
    1b8d:	89 e5                	mov    %esp,%ebp
    1b8f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1b92:	8b 45 08             	mov    0x8(%ebp),%eax
    1b95:	89 04 24             	mov    %eax,(%esp)
    1b98:	e8 d5 ff ff ff       	call   1b72 <empty_q>
    1b9d:	85 c0                	test   %eax,%eax
    1b9f:	75 5d                	jne    1bfe <pop_q+0x72>
       val = q->head->value; 
    1ba1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba4:	8b 40 04             	mov    0x4(%eax),%eax
    1ba7:	8b 00                	mov    (%eax),%eax
    1ba9:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1bac:	8b 45 08             	mov    0x8(%ebp),%eax
    1baf:	8b 40 04             	mov    0x4(%eax),%eax
    1bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1bb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb8:	8b 40 04             	mov    0x4(%eax),%eax
    1bbb:	8b 50 04             	mov    0x4(%eax),%edx
    1bbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bc7:	89 04 24             	mov    %eax,(%esp)
    1bca:	e8 a9 fb ff ff       	call   1778 <free>
       q->size--;
    1bcf:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd2:	8b 00                	mov    (%eax),%eax
    1bd4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bda:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdf:	8b 00                	mov    (%eax),%eax
    1be1:	85 c0                	test   %eax,%eax
    1be3:	75 14                	jne    1bf9 <pop_q+0x6d>
            q->head = 0;
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1bef:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bfc:	eb 05                	jmp    1c03 <pop_q+0x77>
    }
    return -1;
    1bfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c03:	c9                   	leave  
    1c04:	c3                   	ret    
