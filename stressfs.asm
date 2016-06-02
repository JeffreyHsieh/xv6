
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
    102c:	c7 44 24 04 f1 1b 00 	movl   $0x1bf1,0x4(%esp)
    1033:	00 
    1034:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103b:	e8 7c 05 00 00       	call   15bc <printf>
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
    1091:	c7 44 24 04 04 1c 00 	movl   $0x1c04,0x4(%esp)
    1098:	00 
    1099:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a0:	e8 17 05 00 00       	call   15bc <printf>

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
    112a:	c7 44 24 04 0e 1c 00 	movl   $0x1c0e,0x4(%esp)
    1131:	00 
    1132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1139:	e8 7e 04 00 00       	call   15bc <printf>

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
    1414:	b8 01 00 00 00       	mov    $0x1,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <exit>:
    141c:	b8 02 00 00 00       	mov    $0x2,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <wait>:
    1424:	b8 03 00 00 00       	mov    $0x3,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <pipe>:
    142c:	b8 04 00 00 00       	mov    $0x4,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <read>:
    1434:	b8 05 00 00 00       	mov    $0x5,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <write>:
    143c:	b8 10 00 00 00       	mov    $0x10,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <close>:
    1444:	b8 15 00 00 00       	mov    $0x15,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <kill>:
    144c:	b8 06 00 00 00       	mov    $0x6,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <exec>:
    1454:	b8 07 00 00 00       	mov    $0x7,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <open>:
    145c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <mknod>:
    1464:	b8 11 00 00 00       	mov    $0x11,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <unlink>:
    146c:	b8 12 00 00 00       	mov    $0x12,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <fstat>:
    1474:	b8 08 00 00 00       	mov    $0x8,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <link>:
    147c:	b8 13 00 00 00       	mov    $0x13,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <mkdir>:
    1484:	b8 14 00 00 00       	mov    $0x14,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <chdir>:
    148c:	b8 09 00 00 00       	mov    $0x9,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <dup>:
    1494:	b8 0a 00 00 00       	mov    $0xa,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <getpid>:
    149c:	b8 0b 00 00 00       	mov    $0xb,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <sbrk>:
    14a4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <sleep>:
    14ac:	b8 0d 00 00 00       	mov    $0xd,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <uptime>:
    14b4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <clone>:
    14bc:	b8 16 00 00 00       	mov    $0x16,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <texit>:
    14c4:	b8 17 00 00 00       	mov    $0x17,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <tsleep>:
    14cc:	b8 18 00 00 00       	mov    $0x18,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <twakeup>:
    14d4:	b8 19 00 00 00       	mov    $0x19,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14dc:	55                   	push   %ebp
    14dd:	89 e5                	mov    %esp,%ebp
    14df:	83 ec 18             	sub    $0x18,%esp
    14e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14ef:	00 
    14f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f7:	8b 45 08             	mov    0x8(%ebp),%eax
    14fa:	89 04 24             	mov    %eax,(%esp)
    14fd:	e8 3a ff ff ff       	call   143c <write>
}
    1502:	c9                   	leave  
    1503:	c3                   	ret    

00001504 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1504:	55                   	push   %ebp
    1505:	89 e5                	mov    %esp,%ebp
    1507:	56                   	push   %esi
    1508:	53                   	push   %ebx
    1509:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    150c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1513:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1517:	74 17                	je     1530 <printint+0x2c>
    1519:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    151d:	79 11                	jns    1530 <printint+0x2c>
    neg = 1;
    151f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1526:	8b 45 0c             	mov    0xc(%ebp),%eax
    1529:	f7 d8                	neg    %eax
    152b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    152e:	eb 06                	jmp    1536 <printint+0x32>
  } else {
    x = xx;
    1530:	8b 45 0c             	mov    0xc(%ebp),%eax
    1533:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1536:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    153d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1540:	8d 41 01             	lea    0x1(%ecx),%eax
    1543:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1546:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1549:	8b 45 ec             	mov    -0x14(%ebp),%eax
    154c:	ba 00 00 00 00       	mov    $0x0,%edx
    1551:	f7 f3                	div    %ebx
    1553:	89 d0                	mov    %edx,%eax
    1555:	0f b6 80 6c 1f 00 00 	movzbl 0x1f6c(%eax),%eax
    155c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1560:	8b 75 10             	mov    0x10(%ebp),%esi
    1563:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1566:	ba 00 00 00 00       	mov    $0x0,%edx
    156b:	f7 f6                	div    %esi
    156d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1570:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1574:	75 c7                	jne    153d <printint+0x39>
  if(neg)
    1576:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    157a:	74 10                	je     158c <printint+0x88>
    buf[i++] = '-';
    157c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157f:	8d 50 01             	lea    0x1(%eax),%edx
    1582:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1585:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    158a:	eb 1f                	jmp    15ab <printint+0xa7>
    158c:	eb 1d                	jmp    15ab <printint+0xa7>
    putc(fd, buf[i]);
    158e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1594:	01 d0                	add    %edx,%eax
    1596:	0f b6 00             	movzbl (%eax),%eax
    1599:	0f be c0             	movsbl %al,%eax
    159c:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a0:	8b 45 08             	mov    0x8(%ebp),%eax
    15a3:	89 04 24             	mov    %eax,(%esp)
    15a6:	e8 31 ff ff ff       	call   14dc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15ab:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15b3:	79 d9                	jns    158e <printint+0x8a>
    putc(fd, buf[i]);
}
    15b5:	83 c4 30             	add    $0x30,%esp
    15b8:	5b                   	pop    %ebx
    15b9:	5e                   	pop    %esi
    15ba:	5d                   	pop    %ebp
    15bb:	c3                   	ret    

000015bc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15bc:	55                   	push   %ebp
    15bd:	89 e5                	mov    %esp,%ebp
    15bf:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15c2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15c9:	8d 45 0c             	lea    0xc(%ebp),%eax
    15cc:	83 c0 04             	add    $0x4,%eax
    15cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15d9:	e9 7c 01 00 00       	jmp    175a <printf+0x19e>
    c = fmt[i] & 0xff;
    15de:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e4:	01 d0                	add    %edx,%eax
    15e6:	0f b6 00             	movzbl (%eax),%eax
    15e9:	0f be c0             	movsbl %al,%eax
    15ec:	25 ff 00 00 00       	and    $0xff,%eax
    15f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    15f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15f8:	75 2c                	jne    1626 <printf+0x6a>
      if(c == '%'){
    15fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15fe:	75 0c                	jne    160c <printf+0x50>
        state = '%';
    1600:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1607:	e9 4a 01 00 00       	jmp    1756 <printf+0x19a>
      } else {
        putc(fd, c);
    160c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    160f:	0f be c0             	movsbl %al,%eax
    1612:	89 44 24 04          	mov    %eax,0x4(%esp)
    1616:	8b 45 08             	mov    0x8(%ebp),%eax
    1619:	89 04 24             	mov    %eax,(%esp)
    161c:	e8 bb fe ff ff       	call   14dc <putc>
    1621:	e9 30 01 00 00       	jmp    1756 <printf+0x19a>
      }
    } else if(state == '%'){
    1626:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    162a:	0f 85 26 01 00 00    	jne    1756 <printf+0x19a>
      if(c == 'd'){
    1630:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1634:	75 2d                	jne    1663 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1636:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1639:	8b 00                	mov    (%eax),%eax
    163b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1642:	00 
    1643:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    164a:	00 
    164b:	89 44 24 04          	mov    %eax,0x4(%esp)
    164f:	8b 45 08             	mov    0x8(%ebp),%eax
    1652:	89 04 24             	mov    %eax,(%esp)
    1655:	e8 aa fe ff ff       	call   1504 <printint>
        ap++;
    165a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    165e:	e9 ec 00 00 00       	jmp    174f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1663:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1667:	74 06                	je     166f <printf+0xb3>
    1669:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    166d:	75 2d                	jne    169c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    166f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1672:	8b 00                	mov    (%eax),%eax
    1674:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    167b:	00 
    167c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1683:	00 
    1684:	89 44 24 04          	mov    %eax,0x4(%esp)
    1688:	8b 45 08             	mov    0x8(%ebp),%eax
    168b:	89 04 24             	mov    %eax,(%esp)
    168e:	e8 71 fe ff ff       	call   1504 <printint>
        ap++;
    1693:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1697:	e9 b3 00 00 00       	jmp    174f <printf+0x193>
      } else if(c == 's'){
    169c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16a0:	75 45                	jne    16e7 <printf+0x12b>
        s = (char*)*ap;
    16a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a5:	8b 00                	mov    (%eax),%eax
    16a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16b2:	75 09                	jne    16bd <printf+0x101>
          s = "(null)";
    16b4:	c7 45 f4 14 1c 00 00 	movl   $0x1c14,-0xc(%ebp)
        while(*s != 0){
    16bb:	eb 1e                	jmp    16db <printf+0x11f>
    16bd:	eb 1c                	jmp    16db <printf+0x11f>
          putc(fd, *s);
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	0f b6 00             	movzbl (%eax),%eax
    16c5:	0f be c0             	movsbl %al,%eax
    16c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	89 04 24             	mov    %eax,(%esp)
    16d2:	e8 05 fe ff ff       	call   14dc <putc>
          s++;
    16d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16de:	0f b6 00             	movzbl (%eax),%eax
    16e1:	84 c0                	test   %al,%al
    16e3:	75 da                	jne    16bf <printf+0x103>
    16e5:	eb 68                	jmp    174f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    16eb:	75 1d                	jne    170a <printf+0x14e>
        putc(fd, *ap);
    16ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16f0:	8b 00                	mov    (%eax),%eax
    16f2:	0f be c0             	movsbl %al,%eax
    16f5:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f9:	8b 45 08             	mov    0x8(%ebp),%eax
    16fc:	89 04 24             	mov    %eax,(%esp)
    16ff:	e8 d8 fd ff ff       	call   14dc <putc>
        ap++;
    1704:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1708:	eb 45                	jmp    174f <printf+0x193>
      } else if(c == '%'){
    170a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    170e:	75 17                	jne    1727 <printf+0x16b>
        putc(fd, c);
    1710:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1713:	0f be c0             	movsbl %al,%eax
    1716:	89 44 24 04          	mov    %eax,0x4(%esp)
    171a:	8b 45 08             	mov    0x8(%ebp),%eax
    171d:	89 04 24             	mov    %eax,(%esp)
    1720:	e8 b7 fd ff ff       	call   14dc <putc>
    1725:	eb 28                	jmp    174f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1727:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    172e:	00 
    172f:	8b 45 08             	mov    0x8(%ebp),%eax
    1732:	89 04 24             	mov    %eax,(%esp)
    1735:	e8 a2 fd ff ff       	call   14dc <putc>
        putc(fd, c);
    173a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    173d:	0f be c0             	movsbl %al,%eax
    1740:	89 44 24 04          	mov    %eax,0x4(%esp)
    1744:	8b 45 08             	mov    0x8(%ebp),%eax
    1747:	89 04 24             	mov    %eax,(%esp)
    174a:	e8 8d fd ff ff       	call   14dc <putc>
      }
      state = 0;
    174f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1756:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    175a:	8b 55 0c             	mov    0xc(%ebp),%edx
    175d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1760:	01 d0                	add    %edx,%eax
    1762:	0f b6 00             	movzbl (%eax),%eax
    1765:	84 c0                	test   %al,%al
    1767:	0f 85 71 fe ff ff    	jne    15de <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    176d:	c9                   	leave  
    176e:	c3                   	ret    
    176f:	90                   	nop

00001770 <free>:
    1770:	55                   	push   %ebp
    1771:	89 e5                	mov    %esp,%ebp
    1773:	83 ec 10             	sub    $0x10,%esp
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	83 e8 08             	sub    $0x8,%eax
    177c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    177f:	a1 8c 1f 00 00       	mov    0x1f8c,%eax
    1784:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1787:	eb 24                	jmp    17ad <free+0x3d>
    1789:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178c:	8b 00                	mov    (%eax),%eax
    178e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1791:	77 12                	ja     17a5 <free+0x35>
    1793:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1796:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1799:	77 24                	ja     17bf <free+0x4f>
    179b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179e:	8b 00                	mov    (%eax),%eax
    17a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17a3:	77 1a                	ja     17bf <free+0x4f>
    17a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a8:	8b 00                	mov    (%eax),%eax
    17aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17b3:	76 d4                	jbe    1789 <free+0x19>
    17b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b8:	8b 00                	mov    (%eax),%eax
    17ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17bd:	76 ca                	jbe    1789 <free+0x19>
    17bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c2:	8b 40 04             	mov    0x4(%eax),%eax
    17c5:	c1 e0 03             	shl    $0x3,%eax
    17c8:	89 c2                	mov    %eax,%edx
    17ca:	03 55 f8             	add    -0x8(%ebp),%edx
    17cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d0:	8b 00                	mov    (%eax),%eax
    17d2:	39 c2                	cmp    %eax,%edx
    17d4:	75 24                	jne    17fa <free+0x8a>
    17d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d9:	8b 50 04             	mov    0x4(%eax),%edx
    17dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17df:	8b 00                	mov    (%eax),%eax
    17e1:	8b 40 04             	mov    0x4(%eax),%eax
    17e4:	01 c2                	add    %eax,%edx
    17e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e9:	89 50 04             	mov    %edx,0x4(%eax)
    17ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ef:	8b 00                	mov    (%eax),%eax
    17f1:	8b 10                	mov    (%eax),%edx
    17f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f6:	89 10                	mov    %edx,(%eax)
    17f8:	eb 0a                	jmp    1804 <free+0x94>
    17fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17fd:	8b 10                	mov    (%eax),%edx
    17ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1802:	89 10                	mov    %edx,(%eax)
    1804:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1807:	8b 40 04             	mov    0x4(%eax),%eax
    180a:	c1 e0 03             	shl    $0x3,%eax
    180d:	03 45 fc             	add    -0x4(%ebp),%eax
    1810:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1813:	75 20                	jne    1835 <free+0xc5>
    1815:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1818:	8b 50 04             	mov    0x4(%eax),%edx
    181b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181e:	8b 40 04             	mov    0x4(%eax),%eax
    1821:	01 c2                	add    %eax,%edx
    1823:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1826:	89 50 04             	mov    %edx,0x4(%eax)
    1829:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182c:	8b 10                	mov    (%eax),%edx
    182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1831:	89 10                	mov    %edx,(%eax)
    1833:	eb 08                	jmp    183d <free+0xcd>
    1835:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1838:	8b 55 f8             	mov    -0x8(%ebp),%edx
    183b:	89 10                	mov    %edx,(%eax)
    183d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1840:	a3 8c 1f 00 00       	mov    %eax,0x1f8c
    1845:	c9                   	leave  
    1846:	c3                   	ret    

00001847 <morecore>:
    1847:	55                   	push   %ebp
    1848:	89 e5                	mov    %esp,%ebp
    184a:	83 ec 28             	sub    $0x28,%esp
    184d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1854:	77 07                	ja     185d <morecore+0x16>
    1856:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	c1 e0 03             	shl    $0x3,%eax
    1863:	89 04 24             	mov    %eax,(%esp)
    1866:	e8 39 fc ff ff       	call   14a4 <sbrk>
    186b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    186e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1872:	75 07                	jne    187b <morecore+0x34>
    1874:	b8 00 00 00 00       	mov    $0x0,%eax
    1879:	eb 22                	jmp    189d <morecore+0x56>
    187b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    187e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1881:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1884:	8b 55 08             	mov    0x8(%ebp),%edx
    1887:	89 50 04             	mov    %edx,0x4(%eax)
    188a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188d:	83 c0 08             	add    $0x8,%eax
    1890:	89 04 24             	mov    %eax,(%esp)
    1893:	e8 d8 fe ff ff       	call   1770 <free>
    1898:	a1 8c 1f 00 00       	mov    0x1f8c,%eax
    189d:	c9                   	leave  
    189e:	c3                   	ret    

0000189f <malloc>:
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    18a2:	83 ec 28             	sub    $0x28,%esp
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	83 c0 07             	add    $0x7,%eax
    18ab:	c1 e8 03             	shr    $0x3,%eax
    18ae:	83 c0 01             	add    $0x1,%eax
    18b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b4:	a1 8c 1f 00 00       	mov    0x1f8c,%eax
    18b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18c0:	75 23                	jne    18e5 <malloc+0x46>
    18c2:	c7 45 f0 84 1f 00 00 	movl   $0x1f84,-0x10(%ebp)
    18c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18cc:	a3 8c 1f 00 00       	mov    %eax,0x1f8c
    18d1:	a1 8c 1f 00 00       	mov    0x1f8c,%eax
    18d6:	a3 84 1f 00 00       	mov    %eax,0x1f84
    18db:	c7 05 88 1f 00 00 00 	movl   $0x0,0x1f88
    18e2:	00 00 00 
    18e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e8:	8b 00                	mov    (%eax),%eax
    18ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18f0:	8b 40 04             	mov    0x4(%eax),%eax
    18f3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18f6:	72 4d                	jb     1945 <malloc+0xa6>
    18f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18fb:	8b 40 04             	mov    0x4(%eax),%eax
    18fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1901:	75 0c                	jne    190f <malloc+0x70>
    1903:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1906:	8b 10                	mov    (%eax),%edx
    1908:	8b 45 f0             	mov    -0x10(%ebp),%eax
    190b:	89 10                	mov    %edx,(%eax)
    190d:	eb 26                	jmp    1935 <malloc+0x96>
    190f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1912:	8b 40 04             	mov    0x4(%eax),%eax
    1915:	89 c2                	mov    %eax,%edx
    1917:	2b 55 f4             	sub    -0xc(%ebp),%edx
    191a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    191d:	89 50 04             	mov    %edx,0x4(%eax)
    1920:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1923:	8b 40 04             	mov    0x4(%eax),%eax
    1926:	c1 e0 03             	shl    $0x3,%eax
    1929:	01 45 ec             	add    %eax,-0x14(%ebp)
    192c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1932:	89 50 04             	mov    %edx,0x4(%eax)
    1935:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1938:	a3 8c 1f 00 00       	mov    %eax,0x1f8c
    193d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1940:	83 c0 08             	add    $0x8,%eax
    1943:	eb 38                	jmp    197d <malloc+0xde>
    1945:	a1 8c 1f 00 00       	mov    0x1f8c,%eax
    194a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    194d:	75 1b                	jne    196a <malloc+0xcb>
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	89 04 24             	mov    %eax,(%esp)
    1955:	e8 ed fe ff ff       	call   1847 <morecore>
    195a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    195d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1961:	75 07                	jne    196a <malloc+0xcb>
    1963:	b8 00 00 00 00       	mov    $0x0,%eax
    1968:	eb 13                	jmp    197d <malloc+0xde>
    196a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    196d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1970:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1973:	8b 00                	mov    (%eax),%eax
    1975:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1978:	e9 70 ff ff ff       	jmp    18ed <malloc+0x4e>
    197d:	c9                   	leave  
    197e:	c3                   	ret    
    197f:	90                   	nop

00001980 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1980:	55                   	push   %ebp
    1981:	89 e5                	mov    %esp,%ebp
    1983:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1986:	8b 55 08             	mov    0x8(%ebp),%edx
    1989:	8b 45 0c             	mov    0xc(%ebp),%eax
    198c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    198f:	f0 87 02             	lock xchg %eax,(%edx)
    1992:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1995:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1998:	c9                   	leave  
    1999:	c3                   	ret    

0000199a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    199a:	55                   	push   %ebp
    199b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    199d:	8b 45 08             	mov    0x8(%ebp),%eax
    19a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19a6:	5d                   	pop    %ebp
    19a7:	c3                   	ret    

000019a8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19a8:	55                   	push   %ebp
    19a9:	89 e5                	mov    %esp,%ebp
    19ab:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19ae:	90                   	nop
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19b9:	00 
    19ba:	89 04 24             	mov    %eax,(%esp)
    19bd:	e8 be ff ff ff       	call   1980 <xchg>
    19c2:	85 c0                	test   %eax,%eax
    19c4:	75 e9                	jne    19af <lock_acquire+0x7>
}
    19c6:	c9                   	leave  
    19c7:	c3                   	ret    

000019c8 <lock_release>:
void lock_release(lock_t *lock){
    19c8:	55                   	push   %ebp
    19c9:	89 e5                	mov    %esp,%ebp
    19cb:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19d8:	00 
    19d9:	89 04 24             	mov    %eax,(%esp)
    19dc:	e8 9f ff ff ff       	call   1980 <xchg>
}
    19e1:	c9                   	leave  
    19e2:	c3                   	ret    

000019e3 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    19e3:	55                   	push   %ebp
    19e4:	89 e5                	mov    %esp,%ebp
    19e6:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    19e9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    19f0:	e8 aa fe ff ff       	call   189f <malloc>
    19f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    19f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    19fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a01:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a06:	85 c0                	test   %eax,%eax
    1a08:	74 14                	je     1a1e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a12:	89 c2                	mov    %eax,%edx
    1a14:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a19:	29 d0                	sub    %edx,%eax
    1a1b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a22:	75 1b                	jne    1a3f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a24:	c7 44 24 04 1b 1c 00 	movl   $0x1c1b,0x4(%esp)
    1a2b:	00 
    1a2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a33:	e8 84 fb ff ff       	call   15bc <printf>
        return 0;
    1a38:	b8 00 00 00 00       	mov    $0x0,%eax
    1a3d:	eb 6f                	jmp    1aae <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a3f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a42:	8b 55 08             	mov    0x8(%ebp),%edx
    1a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a48:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a4c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a50:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a57:	00 
    1a58:	89 04 24             	mov    %eax,(%esp)
    1a5b:	e8 5c fa ff ff       	call   14bc <clone>
    1a60:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a63:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a67:	79 1b                	jns    1a84 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1a69:	c7 44 24 04 29 1c 00 	movl   $0x1c29,0x4(%esp)
    1a70:	00 
    1a71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a78:	e8 3f fb ff ff       	call   15bc <printf>
        return 0;
    1a7d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a82:	eb 2a                	jmp    1aae <thread_create+0xcb>
    }
    if(tid > 0){
    1a84:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a88:	7e 05                	jle    1a8f <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a8d:	eb 1f                	jmp    1aae <thread_create+0xcb>
    }
    if(tid == 0){
    1a8f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a93:	75 14                	jne    1aa9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1a95:	c7 44 24 04 36 1c 00 	movl   $0x1c36,0x4(%esp)
    1a9c:	00 
    1a9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aa4:	e8 13 fb ff ff       	call   15bc <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1aa9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1aae:	c9                   	leave  
    1aaf:	c3                   	ret    

00001ab0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ab0:	55                   	push   %ebp
    1ab1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ab3:	a1 80 1f 00 00       	mov    0x1f80,%eax
    1ab8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1abe:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ac3:	a3 80 1f 00 00       	mov    %eax,0x1f80
    return (int)(rands % max);
    1ac8:	a1 80 1f 00 00       	mov    0x1f80,%eax
    1acd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ad0:	ba 00 00 00 00       	mov    $0x0,%edx
    1ad5:	f7 f1                	div    %ecx
    1ad7:	89 d0                	mov    %edx,%eax
}
    1ad9:	5d                   	pop    %ebp
    1ada:	c3                   	ret    
    1adb:	90                   	nop

00001adc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1adc:	55                   	push   %ebp
    1add:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1adf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1afc:	5d                   	pop    %ebp
    1afd:	c3                   	ret    

00001afe <add_q>:

void add_q(struct queue *q, int v){
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    1b01:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b04:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b0b:	e8 8f fd ff ff       	call   189f <malloc>
    1b10:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b16:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b20:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b23:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b25:	8b 45 08             	mov    0x8(%ebp),%eax
    1b28:	8b 40 04             	mov    0x4(%eax),%eax
    1b2b:	85 c0                	test   %eax,%eax
    1b2d:	75 0b                	jne    1b3a <add_q+0x3c>
        q->head = n;
    1b2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b32:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b35:	89 50 04             	mov    %edx,0x4(%eax)
    1b38:	eb 0c                	jmp    1b46 <add_q+0x48>
    }else{
        q->tail->next = n;
    1b3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3d:	8b 40 08             	mov    0x8(%eax),%eax
    1b40:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b43:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b46:	8b 45 08             	mov    0x8(%ebp),%eax
    1b49:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b4c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b52:	8b 00                	mov    (%eax),%eax
    1b54:	8d 50 01             	lea    0x1(%eax),%edx
    1b57:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5a:	89 10                	mov    %edx,(%eax)
}
    1b5c:	c9                   	leave  
    1b5d:	c3                   	ret    

00001b5e <empty_q>:

int empty_q(struct queue *q){
    1b5e:	55                   	push   %ebp
    1b5f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b61:	8b 45 08             	mov    0x8(%ebp),%eax
    1b64:	8b 00                	mov    (%eax),%eax
    1b66:	85 c0                	test   %eax,%eax
    1b68:	75 07                	jne    1b71 <empty_q+0x13>
        return 1;
    1b6a:	b8 01 00 00 00       	mov    $0x1,%eax
    1b6f:	eb 05                	jmp    1b76 <empty_q+0x18>
    else
        return 0;
    1b71:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1b76:	5d                   	pop    %ebp
    1b77:	c3                   	ret    

00001b78 <pop_q>:
int pop_q(struct queue *q){
    1b78:	55                   	push   %ebp
    1b79:	89 e5                	mov    %esp,%ebp
    1b7b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1b7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b81:	89 04 24             	mov    %eax,(%esp)
    1b84:	e8 d5 ff ff ff       	call   1b5e <empty_q>
    1b89:	85 c0                	test   %eax,%eax
    1b8b:	75 5d                	jne    1bea <pop_q+0x72>
       val = q->head->value; 
    1b8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b90:	8b 40 04             	mov    0x4(%eax),%eax
    1b93:	8b 00                	mov    (%eax),%eax
    1b95:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1b98:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9b:	8b 40 04             	mov    0x4(%eax),%eax
    1b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1ba1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba4:	8b 40 04             	mov    0x4(%eax),%eax
    1ba7:	8b 50 04             	mov    0x4(%eax),%edx
    1baa:	8b 45 08             	mov    0x8(%ebp),%eax
    1bad:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bb3:	89 04 24             	mov    %eax,(%esp)
    1bb6:	e8 b5 fb ff ff       	call   1770 <free>
       q->size--;
    1bbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbe:	8b 00                	mov    (%eax),%eax
    1bc0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcb:	8b 00                	mov    (%eax),%eax
    1bcd:	85 c0                	test   %eax,%eax
    1bcf:	75 14                	jne    1be5 <pop_q+0x6d>
            q->head = 0;
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1bdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bde:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be8:	eb 05                	jmp    1bef <pop_q+0x77>
    }
    return -1;
    1bea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1bef:	c9                   	leave  
    1bf0:	c3                   	ret    
