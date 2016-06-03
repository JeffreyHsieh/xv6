
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    1009:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 64 1b 00 00 	movl   $0x1b64,(%esp)
    1018:	e8 9b 03 00 00       	call   13b8 <open>
    101d:	85 c0                	test   %eax,%eax
    101f:	79 30                	jns    1051 <main+0x51>
    mknod("console", 1, 1);
    1021:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1028:	00 
    1029:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1030:	00 
    1031:	c7 04 24 64 1b 00 00 	movl   $0x1b64,(%esp)
    1038:	e8 83 03 00 00       	call   13c0 <mknod>
    open("console", O_RDWR);
    103d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 64 1b 00 00 	movl   $0x1b64,(%esp)
    104c:	e8 67 03 00 00       	call   13b8 <open>
  }
  dup(0);  // stdout
    1051:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1058:	e8 93 03 00 00       	call   13f0 <dup>
  dup(0);  // stderr
    105d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1064:	e8 87 03 00 00       	call   13f0 <dup>

  for(;;){
    printf(1, "init: starting sh\n");
    1069:	c7 44 24 04 6c 1b 00 	movl   $0x1b6c,0x4(%esp)
    1070:	00 
    1071:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1078:	e8 a3 04 00 00       	call   1520 <printf>
    pid = fork();
    107d:	e8 ee 02 00 00       	call   1370 <fork>
    1082:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
    1086:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    108b:	79 19                	jns    10a6 <main+0xa6>
      printf(1, "init: fork failed\n");
    108d:	c7 44 24 04 7f 1b 00 	movl   $0x1b7f,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109c:	e8 7f 04 00 00       	call   1520 <printf>
      exit();
    10a1:	e8 d2 02 00 00       	call   1378 <exit>
    }
    if(pid == 0){
    10a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10ab:	75 2d                	jne    10da <main+0xda>
      exec("sh", argv);
    10ad:	c7 44 24 04 68 1f 00 	movl   $0x1f68,0x4(%esp)
    10b4:	00 
    10b5:	c7 04 24 61 1b 00 00 	movl   $0x1b61,(%esp)
    10bc:	e8 ef 02 00 00       	call   13b0 <exec>
      printf(1, "init: exec sh failed\n");
    10c1:	c7 44 24 04 92 1b 00 	movl   $0x1b92,0x4(%esp)
    10c8:	00 
    10c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d0:	e8 4b 04 00 00       	call   1520 <printf>
      exit();
    10d5:	e8 9e 02 00 00       	call   1378 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    10da:	eb 14                	jmp    10f0 <main+0xf0>
      printf(1, "zombie!\n");
    10dc:	c7 44 24 04 a8 1b 00 	movl   $0x1ba8,0x4(%esp)
    10e3:	00 
    10e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10eb:	e8 30 04 00 00       	call   1520 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    10f0:	e8 8b 02 00 00       	call   1380 <wait>
    10f5:	89 44 24 18          	mov    %eax,0x18(%esp)
    10f9:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10fe:	78 0a                	js     110a <main+0x10a>
    1100:	8b 44 24 18          	mov    0x18(%esp),%eax
    1104:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
    1108:	75 d2                	jne    10dc <main+0xdc>
      printf(1, "zombie!\n");
  }
    110a:	e9 5a ff ff ff       	jmp    1069 <main+0x69>
    110f:	90                   	nop

00001110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	57                   	push   %edi
    1114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1115:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1118:	8b 55 10             	mov    0x10(%ebp),%edx
    111b:	8b 45 0c             	mov    0xc(%ebp),%eax
    111e:	89 cb                	mov    %ecx,%ebx
    1120:	89 df                	mov    %ebx,%edi
    1122:	89 d1                	mov    %edx,%ecx
    1124:	fc                   	cld    
    1125:	f3 aa                	rep stos %al,%es:(%edi)
    1127:	89 ca                	mov    %ecx,%edx
    1129:	89 fb                	mov    %edi,%ebx
    112b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    112e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1131:	5b                   	pop    %ebx
    1132:	5f                   	pop    %edi
    1133:	5d                   	pop    %ebp
    1134:	c3                   	ret    

00001135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1135:	55                   	push   %ebp
    1136:	89 e5                	mov    %esp,%ebp
    1138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1141:	90                   	nop
    1142:	8b 45 08             	mov    0x8(%ebp),%eax
    1145:	8d 50 01             	lea    0x1(%eax),%edx
    1148:	89 55 08             	mov    %edx,0x8(%ebp)
    114b:	8b 55 0c             	mov    0xc(%ebp),%edx
    114e:	8d 4a 01             	lea    0x1(%edx),%ecx
    1151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1154:	0f b6 12             	movzbl (%edx),%edx
    1157:	88 10                	mov    %dl,(%eax)
    1159:	0f b6 00             	movzbl (%eax),%eax
    115c:	84 c0                	test   %al,%al
    115e:	75 e2                	jne    1142 <strcpy+0xd>
    ;
  return os;
    1160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1163:	c9                   	leave  
    1164:	c3                   	ret    

00001165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1165:	55                   	push   %ebp
    1166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1168:	eb 08                	jmp    1172 <strcmp+0xd>
    p++, q++;
    116a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    116e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1172:	8b 45 08             	mov    0x8(%ebp),%eax
    1175:	0f b6 00             	movzbl (%eax),%eax
    1178:	84 c0                	test   %al,%al
    117a:	74 10                	je     118c <strcmp+0x27>
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	0f b6 10             	movzbl (%eax),%edx
    1182:	8b 45 0c             	mov    0xc(%ebp),%eax
    1185:	0f b6 00             	movzbl (%eax),%eax
    1188:	38 c2                	cmp    %al,%dl
    118a:	74 de                	je     116a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    118c:	8b 45 08             	mov    0x8(%ebp),%eax
    118f:	0f b6 00             	movzbl (%eax),%eax
    1192:	0f b6 d0             	movzbl %al,%edx
    1195:	8b 45 0c             	mov    0xc(%ebp),%eax
    1198:	0f b6 00             	movzbl (%eax),%eax
    119b:	0f b6 c0             	movzbl %al,%eax
    119e:	29 c2                	sub    %eax,%edx
    11a0:	89 d0                	mov    %edx,%eax
}
    11a2:	5d                   	pop    %ebp
    11a3:	c3                   	ret    

000011a4 <strlen>:

uint
strlen(char *s)
{
    11a4:	55                   	push   %ebp
    11a5:	89 e5                	mov    %esp,%ebp
    11a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11b1:	eb 04                	jmp    11b7 <strlen+0x13>
    11b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	01 d0                	add    %edx,%eax
    11bf:	0f b6 00             	movzbl (%eax),%eax
    11c2:	84 c0                	test   %al,%al
    11c4:	75 ed                	jne    11b3 <strlen+0xf>
    ;
  return n;
    11c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11c9:	c9                   	leave  
    11ca:	c3                   	ret    

000011cb <memset>:

void*
memset(void *dst, int c, uint n)
{
    11cb:	55                   	push   %ebp
    11cc:	89 e5                	mov    %esp,%ebp
    11ce:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    11d1:	8b 45 10             	mov    0x10(%ebp),%eax
    11d4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11db:	89 44 24 04          	mov    %eax,0x4(%esp)
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
    11e2:	89 04 24             	mov    %eax,(%esp)
    11e5:	e8 26 ff ff ff       	call   1110 <stosb>
  return dst;
    11ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ed:	c9                   	leave  
    11ee:	c3                   	ret    

000011ef <strchr>:

char*
strchr(const char *s, char c)
{
    11ef:	55                   	push   %ebp
    11f0:	89 e5                	mov    %esp,%ebp
    11f2:	83 ec 04             	sub    $0x4,%esp
    11f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11fb:	eb 14                	jmp    1211 <strchr+0x22>
    if(*s == c)
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	0f b6 00             	movzbl (%eax),%eax
    1203:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1206:	75 05                	jne    120d <strchr+0x1e>
      return (char*)s;
    1208:	8b 45 08             	mov    0x8(%ebp),%eax
    120b:	eb 13                	jmp    1220 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    120d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1211:	8b 45 08             	mov    0x8(%ebp),%eax
    1214:	0f b6 00             	movzbl (%eax),%eax
    1217:	84 c0                	test   %al,%al
    1219:	75 e2                	jne    11fd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    121b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1220:	c9                   	leave  
    1221:	c3                   	ret    

00001222 <gets>:

char*
gets(char *buf, int max)
{
    1222:	55                   	push   %ebp
    1223:	89 e5                	mov    %esp,%ebp
    1225:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1228:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    122f:	eb 4c                	jmp    127d <gets+0x5b>
    cc = read(0, &c, 1);
    1231:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1238:	00 
    1239:	8d 45 ef             	lea    -0x11(%ebp),%eax
    123c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1240:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1247:	e8 44 01 00 00       	call   1390 <read>
    124c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    124f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1253:	7f 02                	jg     1257 <gets+0x35>
      break;
    1255:	eb 31                	jmp    1288 <gets+0x66>
    buf[i++] = c;
    1257:	8b 45 f4             	mov    -0xc(%ebp),%eax
    125a:	8d 50 01             	lea    0x1(%eax),%edx
    125d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1260:	89 c2                	mov    %eax,%edx
    1262:	8b 45 08             	mov    0x8(%ebp),%eax
    1265:	01 c2                	add    %eax,%edx
    1267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    126b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    126d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1271:	3c 0a                	cmp    $0xa,%al
    1273:	74 13                	je     1288 <gets+0x66>
    1275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1279:	3c 0d                	cmp    $0xd,%al
    127b:	74 0b                	je     1288 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    127d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1280:	83 c0 01             	add    $0x1,%eax
    1283:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1286:	7c a9                	jl     1231 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1288:	8b 55 f4             	mov    -0xc(%ebp),%edx
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	01 d0                	add    %edx,%eax
    1290:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1296:	c9                   	leave  
    1297:	c3                   	ret    

00001298 <stat>:

int
stat(char *n, struct stat *st)
{
    1298:	55                   	push   %ebp
    1299:	89 e5                	mov    %esp,%ebp
    129b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    129e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12a5:	00 
    12a6:	8b 45 08             	mov    0x8(%ebp),%eax
    12a9:	89 04 24             	mov    %eax,(%esp)
    12ac:	e8 07 01 00 00       	call   13b8 <open>
    12b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    12b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12b8:	79 07                	jns    12c1 <stat+0x29>
    return -1;
    12ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12bf:	eb 23                	jmp    12e4 <stat+0x4c>
  r = fstat(fd, st);
    12c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    12c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12cb:	89 04 24             	mov    %eax,(%esp)
    12ce:	e8 fd 00 00 00       	call   13d0 <fstat>
    12d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    12d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12d9:	89 04 24             	mov    %eax,(%esp)
    12dc:	e8 bf 00 00 00       	call   13a0 <close>
  return r;
    12e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    12e4:	c9                   	leave  
    12e5:	c3                   	ret    

000012e6 <atoi>:

int
atoi(const char *s)
{
    12e6:	55                   	push   %ebp
    12e7:	89 e5                	mov    %esp,%ebp
    12e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12f3:	eb 25                	jmp    131a <atoi+0x34>
    n = n*10 + *s++ - '0';
    12f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12f8:	89 d0                	mov    %edx,%eax
    12fa:	c1 e0 02             	shl    $0x2,%eax
    12fd:	01 d0                	add    %edx,%eax
    12ff:	01 c0                	add    %eax,%eax
    1301:	89 c1                	mov    %eax,%ecx
    1303:	8b 45 08             	mov    0x8(%ebp),%eax
    1306:	8d 50 01             	lea    0x1(%eax),%edx
    1309:	89 55 08             	mov    %edx,0x8(%ebp)
    130c:	0f b6 00             	movzbl (%eax),%eax
    130f:	0f be c0             	movsbl %al,%eax
    1312:	01 c8                	add    %ecx,%eax
    1314:	83 e8 30             	sub    $0x30,%eax
    1317:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    131a:	8b 45 08             	mov    0x8(%ebp),%eax
    131d:	0f b6 00             	movzbl (%eax),%eax
    1320:	3c 2f                	cmp    $0x2f,%al
    1322:	7e 0a                	jle    132e <atoi+0x48>
    1324:	8b 45 08             	mov    0x8(%ebp),%eax
    1327:	0f b6 00             	movzbl (%eax),%eax
    132a:	3c 39                	cmp    $0x39,%al
    132c:	7e c7                	jle    12f5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    132e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1331:	c9                   	leave  
    1332:	c3                   	ret    

00001333 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1333:	55                   	push   %ebp
    1334:	89 e5                	mov    %esp,%ebp
    1336:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1339:	8b 45 08             	mov    0x8(%ebp),%eax
    133c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    133f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1342:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1345:	eb 17                	jmp    135e <memmove+0x2b>
    *dst++ = *src++;
    1347:	8b 45 fc             	mov    -0x4(%ebp),%eax
    134a:	8d 50 01             	lea    0x1(%eax),%edx
    134d:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1350:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1353:	8d 4a 01             	lea    0x1(%edx),%ecx
    1356:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1359:	0f b6 12             	movzbl (%edx),%edx
    135c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    135e:	8b 45 10             	mov    0x10(%ebp),%eax
    1361:	8d 50 ff             	lea    -0x1(%eax),%edx
    1364:	89 55 10             	mov    %edx,0x10(%ebp)
    1367:	85 c0                	test   %eax,%eax
    1369:	7f dc                	jg     1347 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    136b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    136e:	c9                   	leave  
    136f:	c3                   	ret    

00001370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1370:	b8 01 00 00 00       	mov    $0x1,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <exit>:
SYSCALL(exit)
    1378:	b8 02 00 00 00       	mov    $0x2,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <wait>:
SYSCALL(wait)
    1380:	b8 03 00 00 00       	mov    $0x3,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <pipe>:
SYSCALL(pipe)
    1388:	b8 04 00 00 00       	mov    $0x4,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <read>:
SYSCALL(read)
    1390:	b8 05 00 00 00       	mov    $0x5,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <write>:
SYSCALL(write)
    1398:	b8 10 00 00 00       	mov    $0x10,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <close>:
SYSCALL(close)
    13a0:	b8 15 00 00 00       	mov    $0x15,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <kill>:
SYSCALL(kill)
    13a8:	b8 06 00 00 00       	mov    $0x6,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <exec>:
SYSCALL(exec)
    13b0:	b8 07 00 00 00       	mov    $0x7,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <open>:
SYSCALL(open)
    13b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <mknod>:
SYSCALL(mknod)
    13c0:	b8 11 00 00 00       	mov    $0x11,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <unlink>:
SYSCALL(unlink)
    13c8:	b8 12 00 00 00       	mov    $0x12,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <fstat>:
SYSCALL(fstat)
    13d0:	b8 08 00 00 00       	mov    $0x8,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <link>:
SYSCALL(link)
    13d8:	b8 13 00 00 00       	mov    $0x13,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <mkdir>:
SYSCALL(mkdir)
    13e0:	b8 14 00 00 00       	mov    $0x14,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <chdir>:
SYSCALL(chdir)
    13e8:	b8 09 00 00 00       	mov    $0x9,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <dup>:
SYSCALL(dup)
    13f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <getpid>:
SYSCALL(getpid)
    13f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <sbrk>:
SYSCALL(sbrk)
    1400:	b8 0c 00 00 00       	mov    $0xc,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <sleep>:
SYSCALL(sleep)
    1408:	b8 0d 00 00 00       	mov    $0xd,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <uptime>:
SYSCALL(uptime)
    1410:	b8 0e 00 00 00       	mov    $0xe,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <clone>:
SYSCALL(clone)
    1418:	b8 16 00 00 00       	mov    $0x16,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <texit>:
SYSCALL(texit)
    1420:	b8 17 00 00 00       	mov    $0x17,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <tsleep>:
SYSCALL(tsleep)
    1428:	b8 18 00 00 00       	mov    $0x18,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <twakeup>:
SYSCALL(twakeup)
    1430:	b8 19 00 00 00       	mov    $0x19,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <thread_yield>:
SYSCALL(thread_yield)
    1438:	b8 1a 00 00 00       	mov    $0x1a,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	83 ec 18             	sub    $0x18,%esp
    1446:	8b 45 0c             	mov    0xc(%ebp),%eax
    1449:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    144c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1453:	00 
    1454:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1457:	89 44 24 04          	mov    %eax,0x4(%esp)
    145b:	8b 45 08             	mov    0x8(%ebp),%eax
    145e:	89 04 24             	mov    %eax,(%esp)
    1461:	e8 32 ff ff ff       	call   1398 <write>
}
    1466:	c9                   	leave  
    1467:	c3                   	ret    

00001468 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1468:	55                   	push   %ebp
    1469:	89 e5                	mov    %esp,%ebp
    146b:	56                   	push   %esi
    146c:	53                   	push   %ebx
    146d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1477:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    147b:	74 17                	je     1494 <printint+0x2c>
    147d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1481:	79 11                	jns    1494 <printint+0x2c>
    neg = 1;
    1483:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    148a:	8b 45 0c             	mov    0xc(%ebp),%eax
    148d:	f7 d8                	neg    %eax
    148f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1492:	eb 06                	jmp    149a <printint+0x32>
  } else {
    x = xx;
    1494:	8b 45 0c             	mov    0xc(%ebp),%eax
    1497:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    149a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    14a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14a4:	8d 41 01             	lea    0x1(%ecx),%eax
    14a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14aa:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b0:	ba 00 00 00 00       	mov    $0x0,%edx
    14b5:	f7 f3                	div    %ebx
    14b7:	89 d0                	mov    %edx,%eax
    14b9:	0f b6 80 70 1f 00 00 	movzbl 0x1f70(%eax),%eax
    14c0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    14c4:	8b 75 10             	mov    0x10(%ebp),%esi
    14c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14ca:	ba 00 00 00 00       	mov    $0x0,%edx
    14cf:	f7 f6                	div    %esi
    14d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14d8:	75 c7                	jne    14a1 <printint+0x39>
  if(neg)
    14da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14de:	74 10                	je     14f0 <printint+0x88>
    buf[i++] = '-';
    14e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e3:	8d 50 01             	lea    0x1(%eax),%edx
    14e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14e9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14ee:	eb 1f                	jmp    150f <printint+0xa7>
    14f0:	eb 1d                	jmp    150f <printint+0xa7>
    putc(fd, buf[i]);
    14f2:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f8:	01 d0                	add    %edx,%eax
    14fa:	0f b6 00             	movzbl (%eax),%eax
    14fd:	0f be c0             	movsbl %al,%eax
    1500:	89 44 24 04          	mov    %eax,0x4(%esp)
    1504:	8b 45 08             	mov    0x8(%ebp),%eax
    1507:	89 04 24             	mov    %eax,(%esp)
    150a:	e8 31 ff ff ff       	call   1440 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    150f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1517:	79 d9                	jns    14f2 <printint+0x8a>
    putc(fd, buf[i]);
}
    1519:	83 c4 30             	add    $0x30,%esp
    151c:	5b                   	pop    %ebx
    151d:	5e                   	pop    %esi
    151e:	5d                   	pop    %ebp
    151f:	c3                   	ret    

00001520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1520:	55                   	push   %ebp
    1521:	89 e5                	mov    %esp,%ebp
    1523:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1526:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    152d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1530:	83 c0 04             	add    $0x4,%eax
    1533:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1536:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    153d:	e9 7c 01 00 00       	jmp    16be <printf+0x19e>
    c = fmt[i] & 0xff;
    1542:	8b 55 0c             	mov    0xc(%ebp),%edx
    1545:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1548:	01 d0                	add    %edx,%eax
    154a:	0f b6 00             	movzbl (%eax),%eax
    154d:	0f be c0             	movsbl %al,%eax
    1550:	25 ff 00 00 00       	and    $0xff,%eax
    1555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1558:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    155c:	75 2c                	jne    158a <printf+0x6a>
      if(c == '%'){
    155e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1562:	75 0c                	jne    1570 <printf+0x50>
        state = '%';
    1564:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    156b:	e9 4a 01 00 00       	jmp    16ba <printf+0x19a>
      } else {
        putc(fd, c);
    1570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1573:	0f be c0             	movsbl %al,%eax
    1576:	89 44 24 04          	mov    %eax,0x4(%esp)
    157a:	8b 45 08             	mov    0x8(%ebp),%eax
    157d:	89 04 24             	mov    %eax,(%esp)
    1580:	e8 bb fe ff ff       	call   1440 <putc>
    1585:	e9 30 01 00 00       	jmp    16ba <printf+0x19a>
      }
    } else if(state == '%'){
    158a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    158e:	0f 85 26 01 00 00    	jne    16ba <printf+0x19a>
      if(c == 'd'){
    1594:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1598:	75 2d                	jne    15c7 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    159a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    159d:	8b 00                	mov    (%eax),%eax
    159f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    15a6:	00 
    15a7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    15ae:	00 
    15af:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b3:	8b 45 08             	mov    0x8(%ebp),%eax
    15b6:	89 04 24             	mov    %eax,(%esp)
    15b9:	e8 aa fe ff ff       	call   1468 <printint>
        ap++;
    15be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15c2:	e9 ec 00 00 00       	jmp    16b3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    15c7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15cb:	74 06                	je     15d3 <printf+0xb3>
    15cd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15d1:	75 2d                	jne    1600 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    15d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d6:	8b 00                	mov    (%eax),%eax
    15d8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15df:	00 
    15e0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15e7:	00 
    15e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ec:	8b 45 08             	mov    0x8(%ebp),%eax
    15ef:	89 04 24             	mov    %eax,(%esp)
    15f2:	e8 71 fe ff ff       	call   1468 <printint>
        ap++;
    15f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15fb:	e9 b3 00 00 00       	jmp    16b3 <printf+0x193>
      } else if(c == 's'){
    1600:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1604:	75 45                	jne    164b <printf+0x12b>
        s = (char*)*ap;
    1606:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1609:	8b 00                	mov    (%eax),%eax
    160b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    160e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1612:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1616:	75 09                	jne    1621 <printf+0x101>
          s = "(null)";
    1618:	c7 45 f4 b1 1b 00 00 	movl   $0x1bb1,-0xc(%ebp)
        while(*s != 0){
    161f:	eb 1e                	jmp    163f <printf+0x11f>
    1621:	eb 1c                	jmp    163f <printf+0x11f>
          putc(fd, *s);
    1623:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1626:	0f b6 00             	movzbl (%eax),%eax
    1629:	0f be c0             	movsbl %al,%eax
    162c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1630:	8b 45 08             	mov    0x8(%ebp),%eax
    1633:	89 04 24             	mov    %eax,(%esp)
    1636:	e8 05 fe ff ff       	call   1440 <putc>
          s++;
    163b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1642:	0f b6 00             	movzbl (%eax),%eax
    1645:	84 c0                	test   %al,%al
    1647:	75 da                	jne    1623 <printf+0x103>
    1649:	eb 68                	jmp    16b3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    164b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    164f:	75 1d                	jne    166e <printf+0x14e>
        putc(fd, *ap);
    1651:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1654:	8b 00                	mov    (%eax),%eax
    1656:	0f be c0             	movsbl %al,%eax
    1659:	89 44 24 04          	mov    %eax,0x4(%esp)
    165d:	8b 45 08             	mov    0x8(%ebp),%eax
    1660:	89 04 24             	mov    %eax,(%esp)
    1663:	e8 d8 fd ff ff       	call   1440 <putc>
        ap++;
    1668:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    166c:	eb 45                	jmp    16b3 <printf+0x193>
      } else if(c == '%'){
    166e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1672:	75 17                	jne    168b <printf+0x16b>
        putc(fd, c);
    1674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1677:	0f be c0             	movsbl %al,%eax
    167a:	89 44 24 04          	mov    %eax,0x4(%esp)
    167e:	8b 45 08             	mov    0x8(%ebp),%eax
    1681:	89 04 24             	mov    %eax,(%esp)
    1684:	e8 b7 fd ff ff       	call   1440 <putc>
    1689:	eb 28                	jmp    16b3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    168b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1692:	00 
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	89 04 24             	mov    %eax,(%esp)
    1699:	e8 a2 fd ff ff       	call   1440 <putc>
        putc(fd, c);
    169e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16a1:	0f be c0             	movsbl %al,%eax
    16a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16a8:	8b 45 08             	mov    0x8(%ebp),%eax
    16ab:	89 04 24             	mov    %eax,(%esp)
    16ae:	e8 8d fd ff ff       	call   1440 <putc>
      }
      state = 0;
    16b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16be:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c4:	01 d0                	add    %edx,%eax
    16c6:	0f b6 00             	movzbl (%eax),%eax
    16c9:	84 c0                	test   %al,%al
    16cb:	0f 85 71 fe ff ff    	jne    1542 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    16d1:	c9                   	leave  
    16d2:	c3                   	ret    
    16d3:	90                   	nop

000016d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16d4:	55                   	push   %ebp
    16d5:	89 e5                	mov    %esp,%ebp
    16d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16da:	8b 45 08             	mov    0x8(%ebp),%eax
    16dd:	83 e8 08             	sub    $0x8,%eax
    16e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16e3:	a1 90 1f 00 00       	mov    0x1f90,%eax
    16e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16eb:	eb 24                	jmp    1711 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 00                	mov    (%eax),%eax
    16f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16f5:	77 12                	ja     1709 <free+0x35>
    16f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16fd:	77 24                	ja     1723 <free+0x4f>
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	8b 00                	mov    (%eax),%eax
    1704:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1707:	77 1a                	ja     1723 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1709:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170c:	8b 00                	mov    (%eax),%eax
    170e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1711:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1714:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1717:	76 d4                	jbe    16ed <free+0x19>
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1721:	76 ca                	jbe    16ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1723:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1726:	8b 40 04             	mov    0x4(%eax),%eax
    1729:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1730:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1733:	01 c2                	add    %eax,%edx
    1735:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1738:	8b 00                	mov    (%eax),%eax
    173a:	39 c2                	cmp    %eax,%edx
    173c:	75 24                	jne    1762 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    173e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1741:	8b 50 04             	mov    0x4(%eax),%edx
    1744:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1747:	8b 00                	mov    (%eax),%eax
    1749:	8b 40 04             	mov    0x4(%eax),%eax
    174c:	01 c2                	add    %eax,%edx
    174e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1751:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1754:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1757:	8b 00                	mov    (%eax),%eax
    1759:	8b 10                	mov    (%eax),%edx
    175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175e:	89 10                	mov    %edx,(%eax)
    1760:	eb 0a                	jmp    176c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1762:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1765:	8b 10                	mov    (%eax),%edx
    1767:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    176c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176f:	8b 40 04             	mov    0x4(%eax),%eax
    1772:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1779:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177c:	01 d0                	add    %edx,%eax
    177e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1781:	75 20                	jne    17a3 <free+0xcf>
    p->s.size += bp->s.size;
    1783:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1786:	8b 50 04             	mov    0x4(%eax),%edx
    1789:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178c:	8b 40 04             	mov    0x4(%eax),%eax
    178f:	01 c2                	add    %eax,%edx
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1797:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179a:	8b 10                	mov    (%eax),%edx
    179c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179f:	89 10                	mov    %edx,(%eax)
    17a1:	eb 08                	jmp    17ab <free+0xd7>
  } else
    p->s.ptr = bp;
    17a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17a9:	89 10                	mov    %edx,(%eax)
  freep = p;
    17ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ae:	a3 90 1f 00 00       	mov    %eax,0x1f90
}
    17b3:	c9                   	leave  
    17b4:	c3                   	ret    

000017b5 <morecore>:

static Header*
morecore(uint nu)
{
    17b5:	55                   	push   %ebp
    17b6:	89 e5                	mov    %esp,%ebp
    17b8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    17bb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17c2:	77 07                	ja     17cb <morecore+0x16>
    nu = 4096;
    17c4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17cb:	8b 45 08             	mov    0x8(%ebp),%eax
    17ce:	c1 e0 03             	shl    $0x3,%eax
    17d1:	89 04 24             	mov    %eax,(%esp)
    17d4:	e8 27 fc ff ff       	call   1400 <sbrk>
    17d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    17dc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    17e0:	75 07                	jne    17e9 <morecore+0x34>
    return 0;
    17e2:	b8 00 00 00 00       	mov    $0x0,%eax
    17e7:	eb 22                	jmp    180b <morecore+0x56>
  hp = (Header*)p;
    17e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f2:	8b 55 08             	mov    0x8(%ebp),%edx
    17f5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fb:	83 c0 08             	add    $0x8,%eax
    17fe:	89 04 24             	mov    %eax,(%esp)
    1801:	e8 ce fe ff ff       	call   16d4 <free>
  return freep;
    1806:	a1 90 1f 00 00       	mov    0x1f90,%eax
}
    180b:	c9                   	leave  
    180c:	c3                   	ret    

0000180d <malloc>:

void*
malloc(uint nbytes)
{
    180d:	55                   	push   %ebp
    180e:	89 e5                	mov    %esp,%ebp
    1810:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1813:	8b 45 08             	mov    0x8(%ebp),%eax
    1816:	83 c0 07             	add    $0x7,%eax
    1819:	c1 e8 03             	shr    $0x3,%eax
    181c:	83 c0 01             	add    $0x1,%eax
    181f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1822:	a1 90 1f 00 00       	mov    0x1f90,%eax
    1827:	89 45 f0             	mov    %eax,-0x10(%ebp)
    182a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    182e:	75 23                	jne    1853 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1830:	c7 45 f0 88 1f 00 00 	movl   $0x1f88,-0x10(%ebp)
    1837:	8b 45 f0             	mov    -0x10(%ebp),%eax
    183a:	a3 90 1f 00 00       	mov    %eax,0x1f90
    183f:	a1 90 1f 00 00       	mov    0x1f90,%eax
    1844:	a3 88 1f 00 00       	mov    %eax,0x1f88
    base.s.size = 0;
    1849:	c7 05 8c 1f 00 00 00 	movl   $0x0,0x1f8c
    1850:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1853:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1856:	8b 00                	mov    (%eax),%eax
    1858:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    185b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185e:	8b 40 04             	mov    0x4(%eax),%eax
    1861:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1864:	72 4d                	jb     18b3 <malloc+0xa6>
      if(p->s.size == nunits)
    1866:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1869:	8b 40 04             	mov    0x4(%eax),%eax
    186c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    186f:	75 0c                	jne    187d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1871:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1874:	8b 10                	mov    (%eax),%edx
    1876:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1879:	89 10                	mov    %edx,(%eax)
    187b:	eb 26                	jmp    18a3 <malloc+0x96>
      else {
        p->s.size -= nunits;
    187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1880:	8b 40 04             	mov    0x4(%eax),%eax
    1883:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1886:	89 c2                	mov    %eax,%edx
    1888:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	8b 40 04             	mov    0x4(%eax),%eax
    1894:	c1 e0 03             	shl    $0x3,%eax
    1897:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    189a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18a0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    18a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18a6:	a3 90 1f 00 00       	mov    %eax,0x1f90
      return (void*)(p + 1);
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	83 c0 08             	add    $0x8,%eax
    18b1:	eb 38                	jmp    18eb <malloc+0xde>
    }
    if(p == freep)
    18b3:	a1 90 1f 00 00       	mov    0x1f90,%eax
    18b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    18bb:	75 1b                	jne    18d8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    18bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18c0:	89 04 24             	mov    %eax,(%esp)
    18c3:	e8 ed fe ff ff       	call   17b5 <morecore>
    18c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18cf:	75 07                	jne    18d8 <malloc+0xcb>
        return 0;
    18d1:	b8 00 00 00 00       	mov    $0x0,%eax
    18d6:	eb 13                	jmp    18eb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e1:	8b 00                	mov    (%eax),%eax
    18e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    18e6:	e9 70 ff ff ff       	jmp    185b <malloc+0x4e>
}
    18eb:	c9                   	leave  
    18ec:	c3                   	ret    
    18ed:	66 90                	xchg   %ax,%ax
    18ef:	90                   	nop

000018f0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18f0:	55                   	push   %ebp
    18f1:	89 e5                	mov    %esp,%ebp
    18f3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18f6:	8b 55 08             	mov    0x8(%ebp),%edx
    18f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    18fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18ff:	f0 87 02             	lock xchg %eax,(%edx)
    1902:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1905:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1908:	c9                   	leave  
    1909:	c3                   	ret    

0000190a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    190a:	55                   	push   %ebp
    190b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    190d:	8b 45 08             	mov    0x8(%ebp),%eax
    1910:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1916:	5d                   	pop    %ebp
    1917:	c3                   	ret    

00001918 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1918:	55                   	push   %ebp
    1919:	89 e5                	mov    %esp,%ebp
    191b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    191e:	90                   	nop
    191f:	8b 45 08             	mov    0x8(%ebp),%eax
    1922:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1929:	00 
    192a:	89 04 24             	mov    %eax,(%esp)
    192d:	e8 be ff ff ff       	call   18f0 <xchg>
    1932:	85 c0                	test   %eax,%eax
    1934:	75 e9                	jne    191f <lock_acquire+0x7>
}
    1936:	c9                   	leave  
    1937:	c3                   	ret    

00001938 <lock_release>:
void lock_release(lock_t *lock){
    1938:	55                   	push   %ebp
    1939:	89 e5                	mov    %esp,%ebp
    193b:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    193e:	8b 45 08             	mov    0x8(%ebp),%eax
    1941:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1948:	00 
    1949:	89 04 24             	mov    %eax,(%esp)
    194c:	e8 9f ff ff ff       	call   18f0 <xchg>
}
    1951:	c9                   	leave  
    1952:	c3                   	ret    

00001953 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1953:	55                   	push   %ebp
    1954:	89 e5                	mov    %esp,%ebp
    1956:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1959:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1960:	e8 a8 fe ff ff       	call   180d <malloc>
    1965:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1968:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1971:	25 ff 0f 00 00       	and    $0xfff,%eax
    1976:	85 c0                	test   %eax,%eax
    1978:	74 14                	je     198e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1982:	89 c2                	mov    %eax,%edx
    1984:	b8 00 10 00 00       	mov    $0x1000,%eax
    1989:	29 d0                	sub    %edx,%eax
    198b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    198e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1992:	75 1b                	jne    19af <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1994:	c7 44 24 04 b8 1b 00 	movl   $0x1bb8,0x4(%esp)
    199b:	00 
    199c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19a3:	e8 78 fb ff ff       	call   1520 <printf>
        return 0;
    19a8:	b8 00 00 00 00       	mov    $0x0,%eax
    19ad:	eb 6f                	jmp    1a1e <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    19af:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    19b2:	8b 55 08             	mov    0x8(%ebp),%edx
    19b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    19bc:	89 54 24 08          	mov    %edx,0x8(%esp)
    19c0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    19c7:	00 
    19c8:	89 04 24             	mov    %eax,(%esp)
    19cb:	e8 48 fa ff ff       	call   1418 <clone>
    19d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    19d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19d7:	79 1b                	jns    19f4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    19d9:	c7 44 24 04 c6 1b 00 	movl   $0x1bc6,0x4(%esp)
    19e0:	00 
    19e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19e8:	e8 33 fb ff ff       	call   1520 <printf>
        return 0;
    19ed:	b8 00 00 00 00       	mov    $0x0,%eax
    19f2:	eb 2a                	jmp    1a1e <thread_create+0xcb>
    }
    if(tid > 0){
    19f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19f8:	7e 05                	jle    19ff <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    19fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19fd:	eb 1f                	jmp    1a1e <thread_create+0xcb>
    }
    if(tid == 0){
    19ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a03:	75 14                	jne    1a19 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1a05:	c7 44 24 04 d3 1b 00 	movl   $0x1bd3,0x4(%esp)
    1a0c:	00 
    1a0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a14:	e8 07 fb ff ff       	call   1520 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1a19:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a1e:	c9                   	leave  
    1a1f:	c3                   	ret    

00001a20 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1a20:	55                   	push   %ebp
    1a21:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1a23:	a1 84 1f 00 00       	mov    0x1f84,%eax
    1a28:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a2e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a33:	a3 84 1f 00 00       	mov    %eax,0x1f84
    return (int)(rands % max);
    1a38:	a1 84 1f 00 00       	mov    0x1f84,%eax
    1a3d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a40:	ba 00 00 00 00       	mov    $0x0,%edx
    1a45:	f7 f1                	div    %ecx
    1a47:	89 d0                	mov    %edx,%eax
}
    1a49:	5d                   	pop    %ebp
    1a4a:	c3                   	ret    
    1a4b:	90                   	nop

00001a4c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a4c:	55                   	push   %ebp
    1a4d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a58:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a62:	8b 45 08             	mov    0x8(%ebp),%eax
    1a65:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a6c:	5d                   	pop    %ebp
    1a6d:	c3                   	ret    

00001a6e <add_q>:

void add_q(struct queue *q, int v){
    1a6e:	55                   	push   %ebp
    1a6f:	89 e5                	mov    %esp,%ebp
    1a71:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a74:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a7b:	e8 8d fd ff ff       	call   180d <malloc>
    1a80:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a86:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a90:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a93:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a95:	8b 45 08             	mov    0x8(%ebp),%eax
    1a98:	8b 40 04             	mov    0x4(%eax),%eax
    1a9b:	85 c0                	test   %eax,%eax
    1a9d:	75 0b                	jne    1aaa <add_q+0x3c>
        q->head = n;
    1a9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1aa5:	89 50 04             	mov    %edx,0x4(%eax)
    1aa8:	eb 0c                	jmp    1ab6 <add_q+0x48>
    }else{
        q->tail->next = n;
    1aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    1aad:	8b 40 08             	mov    0x8(%eax),%eax
    1ab0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ab3:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1ab6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1abc:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1abf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac2:	8b 00                	mov    (%eax),%eax
    1ac4:	8d 50 01             	lea    0x1(%eax),%edx
    1ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aca:	89 10                	mov    %edx,(%eax)
}
    1acc:	c9                   	leave  
    1acd:	c3                   	ret    

00001ace <empty_q>:

int empty_q(struct queue *q){
    1ace:	55                   	push   %ebp
    1acf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1ad1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad4:	8b 00                	mov    (%eax),%eax
    1ad6:	85 c0                	test   %eax,%eax
    1ad8:	75 07                	jne    1ae1 <empty_q+0x13>
        return 1;
    1ada:	b8 01 00 00 00       	mov    $0x1,%eax
    1adf:	eb 05                	jmp    1ae6 <empty_q+0x18>
    else
        return 0;
    1ae1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1ae6:	5d                   	pop    %ebp
    1ae7:	c3                   	ret    

00001ae8 <pop_q>:
int pop_q(struct queue *q){
    1ae8:	55                   	push   %ebp
    1ae9:	89 e5                	mov    %esp,%ebp
    1aeb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1aee:	8b 45 08             	mov    0x8(%ebp),%eax
    1af1:	89 04 24             	mov    %eax,(%esp)
    1af4:	e8 d5 ff ff ff       	call   1ace <empty_q>
    1af9:	85 c0                	test   %eax,%eax
    1afb:	75 5d                	jne    1b5a <pop_q+0x72>
       val = q->head->value; 
    1afd:	8b 45 08             	mov    0x8(%ebp),%eax
    1b00:	8b 40 04             	mov    0x4(%eax),%eax
    1b03:	8b 00                	mov    (%eax),%eax
    1b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1b08:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0b:	8b 40 04             	mov    0x4(%eax),%eax
    1b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1b11:	8b 45 08             	mov    0x8(%ebp),%eax
    1b14:	8b 40 04             	mov    0x4(%eax),%eax
    1b17:	8b 50 04             	mov    0x4(%eax),%edx
    1b1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b23:	89 04 24             	mov    %eax,(%esp)
    1b26:	e8 a9 fb ff ff       	call   16d4 <free>
       q->size--;
    1b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2e:	8b 00                	mov    (%eax),%eax
    1b30:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b33:	8b 45 08             	mov    0x8(%ebp),%eax
    1b36:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1b38:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3b:	8b 00                	mov    (%eax),%eax
    1b3d:	85 c0                	test   %eax,%eax
    1b3f:	75 14                	jne    1b55 <pop_q+0x6d>
            q->head = 0;
    1b41:	8b 45 08             	mov    0x8(%ebp),%eax
    1b44:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b58:	eb 05                	jmp    1b5f <pop_q+0x77>
    }
    return -1;
    1b5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b5f:	c9                   	leave  
    1b60:	c3                   	ret    
