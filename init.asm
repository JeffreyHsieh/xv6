
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
    1011:	c7 04 24 50 1b 00 00 	movl   $0x1b50,(%esp)
    1018:	e8 9b 03 00 00       	call   13b8 <open>
    101d:	85 c0                	test   %eax,%eax
    101f:	79 30                	jns    1051 <main+0x51>
    mknod("console", 1, 1);
    1021:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1028:	00 
    1029:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1030:	00 
    1031:	c7 04 24 50 1b 00 00 	movl   $0x1b50,(%esp)
    1038:	e8 83 03 00 00       	call   13c0 <mknod>
    open("console", O_RDWR);
    103d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 50 1b 00 00 	movl   $0x1b50,(%esp)
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
    1069:	c7 44 24 04 58 1b 00 	movl   $0x1b58,0x4(%esp)
    1070:	00 
    1071:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1078:	e8 9b 04 00 00       	call   1518 <printf>
    pid = fork();
    107d:	e8 ee 02 00 00       	call   1370 <fork>
    1082:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
    1086:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    108b:	79 19                	jns    10a6 <main+0xa6>
      printf(1, "init: fork failed\n");
    108d:	c7 44 24 04 6b 1b 00 	movl   $0x1b6b,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109c:	e8 77 04 00 00       	call   1518 <printf>
      exit();
    10a1:	e8 d2 02 00 00       	call   1378 <exit>
    }
    if(pid == 0){
    10a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10ab:	75 2d                	jne    10da <main+0xda>
      exec("sh", argv);
    10ad:	c7 44 24 04 f4 1e 00 	movl   $0x1ef4,0x4(%esp)
    10b4:	00 
    10b5:	c7 04 24 4d 1b 00 00 	movl   $0x1b4d,(%esp)
    10bc:	e8 ef 02 00 00       	call   13b0 <exec>
      printf(1, "init: exec sh failed\n");
    10c1:	c7 44 24 04 7e 1b 00 	movl   $0x1b7e,0x4(%esp)
    10c8:	00 
    10c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d0:	e8 43 04 00 00       	call   1518 <printf>
      exit();
    10d5:	e8 9e 02 00 00       	call   1378 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    10da:	eb 14                	jmp    10f0 <main+0xf0>
      printf(1, "zombie!\n");
    10dc:	c7 44 24 04 94 1b 00 	movl   $0x1b94,0x4(%esp)
    10e3:	00 
    10e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10eb:	e8 28 04 00 00       	call   1518 <printf>
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
    1370:	b8 01 00 00 00       	mov    $0x1,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <exit>:
    1378:	b8 02 00 00 00       	mov    $0x2,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <wait>:
    1380:	b8 03 00 00 00       	mov    $0x3,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <pipe>:
    1388:	b8 04 00 00 00       	mov    $0x4,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <read>:
    1390:	b8 05 00 00 00       	mov    $0x5,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <write>:
    1398:	b8 10 00 00 00       	mov    $0x10,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <close>:
    13a0:	b8 15 00 00 00       	mov    $0x15,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <kill>:
    13a8:	b8 06 00 00 00       	mov    $0x6,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <exec>:
    13b0:	b8 07 00 00 00       	mov    $0x7,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <open>:
    13b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <mknod>:
    13c0:	b8 11 00 00 00       	mov    $0x11,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <unlink>:
    13c8:	b8 12 00 00 00       	mov    $0x12,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <fstat>:
    13d0:	b8 08 00 00 00       	mov    $0x8,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <link>:
    13d8:	b8 13 00 00 00       	mov    $0x13,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <mkdir>:
    13e0:	b8 14 00 00 00       	mov    $0x14,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <chdir>:
    13e8:	b8 09 00 00 00       	mov    $0x9,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <dup>:
    13f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <getpid>:
    13f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <sbrk>:
    1400:	b8 0c 00 00 00       	mov    $0xc,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <sleep>:
    1408:	b8 0d 00 00 00       	mov    $0xd,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <uptime>:
    1410:	b8 0e 00 00 00       	mov    $0xe,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <clone>:
    1418:	b8 16 00 00 00       	mov    $0x16,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <texit>:
    1420:	b8 17 00 00 00       	mov    $0x17,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <tsleep>:
    1428:	b8 18 00 00 00       	mov    $0x18,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <twakeup>:
    1430:	b8 19 00 00 00       	mov    $0x19,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	83 ec 18             	sub    $0x18,%esp
    143e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1441:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1444:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    144b:	00 
    144c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    144f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1453:	8b 45 08             	mov    0x8(%ebp),%eax
    1456:	89 04 24             	mov    %eax,(%esp)
    1459:	e8 3a ff ff ff       	call   1398 <write>
}
    145e:	c9                   	leave  
    145f:	c3                   	ret    

00001460 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	56                   	push   %esi
    1464:	53                   	push   %ebx
    1465:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1468:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    146f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1473:	74 17                	je     148c <printint+0x2c>
    1475:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1479:	79 11                	jns    148c <printint+0x2c>
    neg = 1;
    147b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1482:	8b 45 0c             	mov    0xc(%ebp),%eax
    1485:	f7 d8                	neg    %eax
    1487:	89 45 ec             	mov    %eax,-0x14(%ebp)
    148a:	eb 06                	jmp    1492 <printint+0x32>
  } else {
    x = xx;
    148c:	8b 45 0c             	mov    0xc(%ebp),%eax
    148f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1492:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1499:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    149c:	8d 41 01             	lea    0x1(%ecx),%eax
    149f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14a2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14a8:	ba 00 00 00 00       	mov    $0x0,%edx
    14ad:	f7 f3                	div    %ebx
    14af:	89 d0                	mov    %edx,%eax
    14b1:	0f b6 80 fc 1e 00 00 	movzbl 0x1efc(%eax),%eax
    14b8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    14bc:	8b 75 10             	mov    0x10(%ebp),%esi
    14bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14c2:	ba 00 00 00 00       	mov    $0x0,%edx
    14c7:	f7 f6                	div    %esi
    14c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14d0:	75 c7                	jne    1499 <printint+0x39>
  if(neg)
    14d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14d6:	74 10                	je     14e8 <printint+0x88>
    buf[i++] = '-';
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	8d 50 01             	lea    0x1(%eax),%edx
    14de:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14e1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14e6:	eb 1f                	jmp    1507 <printint+0xa7>
    14e8:	eb 1d                	jmp    1507 <printint+0xa7>
    putc(fd, buf[i]);
    14ea:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f0:	01 d0                	add    %edx,%eax
    14f2:	0f b6 00             	movzbl (%eax),%eax
    14f5:	0f be c0             	movsbl %al,%eax
    14f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fc:	8b 45 08             	mov    0x8(%ebp),%eax
    14ff:	89 04 24             	mov    %eax,(%esp)
    1502:	e8 31 ff ff ff       	call   1438 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1507:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    150b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    150f:	79 d9                	jns    14ea <printint+0x8a>
    putc(fd, buf[i]);
}
    1511:	83 c4 30             	add    $0x30,%esp
    1514:	5b                   	pop    %ebx
    1515:	5e                   	pop    %esi
    1516:	5d                   	pop    %ebp
    1517:	c3                   	ret    

00001518 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1518:	55                   	push   %ebp
    1519:	89 e5                	mov    %esp,%ebp
    151b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    151e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1525:	8d 45 0c             	lea    0xc(%ebp),%eax
    1528:	83 c0 04             	add    $0x4,%eax
    152b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    152e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1535:	e9 7c 01 00 00       	jmp    16b6 <printf+0x19e>
    c = fmt[i] & 0xff;
    153a:	8b 55 0c             	mov    0xc(%ebp),%edx
    153d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1540:	01 d0                	add    %edx,%eax
    1542:	0f b6 00             	movzbl (%eax),%eax
    1545:	0f be c0             	movsbl %al,%eax
    1548:	25 ff 00 00 00       	and    $0xff,%eax
    154d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1550:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1554:	75 2c                	jne    1582 <printf+0x6a>
      if(c == '%'){
    1556:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    155a:	75 0c                	jne    1568 <printf+0x50>
        state = '%';
    155c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1563:	e9 4a 01 00 00       	jmp    16b2 <printf+0x19a>
      } else {
        putc(fd, c);
    1568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    156b:	0f be c0             	movsbl %al,%eax
    156e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1572:	8b 45 08             	mov    0x8(%ebp),%eax
    1575:	89 04 24             	mov    %eax,(%esp)
    1578:	e8 bb fe ff ff       	call   1438 <putc>
    157d:	e9 30 01 00 00       	jmp    16b2 <printf+0x19a>
      }
    } else if(state == '%'){
    1582:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1586:	0f 85 26 01 00 00    	jne    16b2 <printf+0x19a>
      if(c == 'd'){
    158c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1590:	75 2d                	jne    15bf <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1592:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1595:	8b 00                	mov    (%eax),%eax
    1597:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    159e:	00 
    159f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    15a6:	00 
    15a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ab:	8b 45 08             	mov    0x8(%ebp),%eax
    15ae:	89 04 24             	mov    %eax,(%esp)
    15b1:	e8 aa fe ff ff       	call   1460 <printint>
        ap++;
    15b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15ba:	e9 ec 00 00 00       	jmp    16ab <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    15bf:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15c3:	74 06                	je     15cb <printf+0xb3>
    15c5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15c9:	75 2d                	jne    15f8 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    15cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ce:	8b 00                	mov    (%eax),%eax
    15d0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15d7:	00 
    15d8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15df:	00 
    15e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e4:	8b 45 08             	mov    0x8(%ebp),%eax
    15e7:	89 04 24             	mov    %eax,(%esp)
    15ea:	e8 71 fe ff ff       	call   1460 <printint>
        ap++;
    15ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15f3:	e9 b3 00 00 00       	jmp    16ab <printf+0x193>
      } else if(c == 's'){
    15f8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    15fc:	75 45                	jne    1643 <printf+0x12b>
        s = (char*)*ap;
    15fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1601:	8b 00                	mov    (%eax),%eax
    1603:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1606:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    160a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    160e:	75 09                	jne    1619 <printf+0x101>
          s = "(null)";
    1610:	c7 45 f4 9d 1b 00 00 	movl   $0x1b9d,-0xc(%ebp)
        while(*s != 0){
    1617:	eb 1e                	jmp    1637 <printf+0x11f>
    1619:	eb 1c                	jmp    1637 <printf+0x11f>
          putc(fd, *s);
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	0f b6 00             	movzbl (%eax),%eax
    1621:	0f be c0             	movsbl %al,%eax
    1624:	89 44 24 04          	mov    %eax,0x4(%esp)
    1628:	8b 45 08             	mov    0x8(%ebp),%eax
    162b:	89 04 24             	mov    %eax,(%esp)
    162e:	e8 05 fe ff ff       	call   1438 <putc>
          s++;
    1633:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	0f b6 00             	movzbl (%eax),%eax
    163d:	84 c0                	test   %al,%al
    163f:	75 da                	jne    161b <printf+0x103>
    1641:	eb 68                	jmp    16ab <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1643:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1647:	75 1d                	jne    1666 <printf+0x14e>
        putc(fd, *ap);
    1649:	8b 45 e8             	mov    -0x18(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	0f be c0             	movsbl %al,%eax
    1651:	89 44 24 04          	mov    %eax,0x4(%esp)
    1655:	8b 45 08             	mov    0x8(%ebp),%eax
    1658:	89 04 24             	mov    %eax,(%esp)
    165b:	e8 d8 fd ff ff       	call   1438 <putc>
        ap++;
    1660:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1664:	eb 45                	jmp    16ab <printf+0x193>
      } else if(c == '%'){
    1666:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    166a:	75 17                	jne    1683 <printf+0x16b>
        putc(fd, c);
    166c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    166f:	0f be c0             	movsbl %al,%eax
    1672:	89 44 24 04          	mov    %eax,0x4(%esp)
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	89 04 24             	mov    %eax,(%esp)
    167c:	e8 b7 fd ff ff       	call   1438 <putc>
    1681:	eb 28                	jmp    16ab <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1683:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    168a:	00 
    168b:	8b 45 08             	mov    0x8(%ebp),%eax
    168e:	89 04 24             	mov    %eax,(%esp)
    1691:	e8 a2 fd ff ff       	call   1438 <putc>
        putc(fd, c);
    1696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1699:	0f be c0             	movsbl %al,%eax
    169c:	89 44 24 04          	mov    %eax,0x4(%esp)
    16a0:	8b 45 08             	mov    0x8(%ebp),%eax
    16a3:	89 04 24             	mov    %eax,(%esp)
    16a6:	e8 8d fd ff ff       	call   1438 <putc>
      }
      state = 0;
    16ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16b2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    16b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16bc:	01 d0                	add    %edx,%eax
    16be:	0f b6 00             	movzbl (%eax),%eax
    16c1:	84 c0                	test   %al,%al
    16c3:	0f 85 71 fe ff ff    	jne    153a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    16c9:	c9                   	leave  
    16ca:	c3                   	ret    
    16cb:	90                   	nop

000016cc <free>:
    16cc:	55                   	push   %ebp
    16cd:	89 e5                	mov    %esp,%ebp
    16cf:	83 ec 10             	sub    $0x10,%esp
    16d2:	8b 45 08             	mov    0x8(%ebp),%eax
    16d5:	83 e8 08             	sub    $0x8,%eax
    16d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    16db:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    16e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16e3:	eb 24                	jmp    1709 <free+0x3d>
    16e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e8:	8b 00                	mov    (%eax),%eax
    16ea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16ed:	77 12                	ja     1701 <free+0x35>
    16ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16f5:	77 24                	ja     171b <free+0x4f>
    16f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fa:	8b 00                	mov    (%eax),%eax
    16fc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ff:	77 1a                	ja     171b <free+0x4f>
    1701:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1704:	8b 00                	mov    (%eax),%eax
    1706:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1709:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    170f:	76 d4                	jbe    16e5 <free+0x19>
    1711:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1714:	8b 00                	mov    (%eax),%eax
    1716:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1719:	76 ca                	jbe    16e5 <free+0x19>
    171b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171e:	8b 40 04             	mov    0x4(%eax),%eax
    1721:	c1 e0 03             	shl    $0x3,%eax
    1724:	89 c2                	mov    %eax,%edx
    1726:	03 55 f8             	add    -0x8(%ebp),%edx
    1729:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172c:	8b 00                	mov    (%eax),%eax
    172e:	39 c2                	cmp    %eax,%edx
    1730:	75 24                	jne    1756 <free+0x8a>
    1732:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1735:	8b 50 04             	mov    0x4(%eax),%edx
    1738:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173b:	8b 00                	mov    (%eax),%eax
    173d:	8b 40 04             	mov    0x4(%eax),%eax
    1740:	01 c2                	add    %eax,%edx
    1742:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1745:	89 50 04             	mov    %edx,0x4(%eax)
    1748:	8b 45 fc             	mov    -0x4(%ebp),%eax
    174b:	8b 00                	mov    (%eax),%eax
    174d:	8b 10                	mov    (%eax),%edx
    174f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1752:	89 10                	mov    %edx,(%eax)
    1754:	eb 0a                	jmp    1760 <free+0x94>
    1756:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1759:	8b 10                	mov    (%eax),%edx
    175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175e:	89 10                	mov    %edx,(%eax)
    1760:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1763:	8b 40 04             	mov    0x4(%eax),%eax
    1766:	c1 e0 03             	shl    $0x3,%eax
    1769:	03 45 fc             	add    -0x4(%ebp),%eax
    176c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    176f:	75 20                	jne    1791 <free+0xc5>
    1771:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1774:	8b 50 04             	mov    0x4(%eax),%edx
    1777:	8b 45 f8             	mov    -0x8(%ebp),%eax
    177a:	8b 40 04             	mov    0x4(%eax),%eax
    177d:	01 c2                	add    %eax,%edx
    177f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1782:	89 50 04             	mov    %edx,0x4(%eax)
    1785:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1788:	8b 10                	mov    (%eax),%edx
    178a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178d:	89 10                	mov    %edx,(%eax)
    178f:	eb 08                	jmp    1799 <free+0xcd>
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1797:	89 10                	mov    %edx,(%eax)
    1799:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179c:	a3 1c 1f 00 00       	mov    %eax,0x1f1c
    17a1:	c9                   	leave  
    17a2:	c3                   	ret    

000017a3 <morecore>:
    17a3:	55                   	push   %ebp
    17a4:	89 e5                	mov    %esp,%ebp
    17a6:	83 ec 28             	sub    $0x28,%esp
    17a9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17b0:	77 07                	ja     17b9 <morecore+0x16>
    17b2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    17b9:	8b 45 08             	mov    0x8(%ebp),%eax
    17bc:	c1 e0 03             	shl    $0x3,%eax
    17bf:	89 04 24             	mov    %eax,(%esp)
    17c2:	e8 39 fc ff ff       	call   1400 <sbrk>
    17c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17ca:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    17ce:	75 07                	jne    17d7 <morecore+0x34>
    17d0:	b8 00 00 00 00       	mov    $0x0,%eax
    17d5:	eb 22                	jmp    17f9 <morecore+0x56>
    17d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e0:	8b 55 08             	mov    0x8(%ebp),%edx
    17e3:	89 50 04             	mov    %edx,0x4(%eax)
    17e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e9:	83 c0 08             	add    $0x8,%eax
    17ec:	89 04 24             	mov    %eax,(%esp)
    17ef:	e8 d8 fe ff ff       	call   16cc <free>
    17f4:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    17f9:	c9                   	leave  
    17fa:	c3                   	ret    

000017fb <malloc>:
    17fb:	55                   	push   %ebp
    17fc:	89 e5                	mov    %esp,%ebp
    17fe:	83 ec 28             	sub    $0x28,%esp
    1801:	8b 45 08             	mov    0x8(%ebp),%eax
    1804:	83 c0 07             	add    $0x7,%eax
    1807:	c1 e8 03             	shr    $0x3,%eax
    180a:	83 c0 01             	add    $0x1,%eax
    180d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1810:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    1815:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1818:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    181c:	75 23                	jne    1841 <malloc+0x46>
    181e:	c7 45 f0 14 1f 00 00 	movl   $0x1f14,-0x10(%ebp)
    1825:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1828:	a3 1c 1f 00 00       	mov    %eax,0x1f1c
    182d:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    1832:	a3 14 1f 00 00       	mov    %eax,0x1f14
    1837:	c7 05 18 1f 00 00 00 	movl   $0x0,0x1f18
    183e:	00 00 00 
    1841:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1844:	8b 00                	mov    (%eax),%eax
    1846:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1849:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184c:	8b 40 04             	mov    0x4(%eax),%eax
    184f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1852:	72 4d                	jb     18a1 <malloc+0xa6>
    1854:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1857:	8b 40 04             	mov    0x4(%eax),%eax
    185a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    185d:	75 0c                	jne    186b <malloc+0x70>
    185f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1862:	8b 10                	mov    (%eax),%edx
    1864:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1867:	89 10                	mov    %edx,(%eax)
    1869:	eb 26                	jmp    1891 <malloc+0x96>
    186b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    186e:	8b 40 04             	mov    0x4(%eax),%eax
    1871:	89 c2                	mov    %eax,%edx
    1873:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1876:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1879:	89 50 04             	mov    %edx,0x4(%eax)
    187c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    187f:	8b 40 04             	mov    0x4(%eax),%eax
    1882:	c1 e0 03             	shl    $0x3,%eax
    1885:	01 45 ec             	add    %eax,-0x14(%ebp)
    1888:	8b 45 ec             	mov    -0x14(%ebp),%eax
    188b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    188e:	89 50 04             	mov    %edx,0x4(%eax)
    1891:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1894:	a3 1c 1f 00 00       	mov    %eax,0x1f1c
    1899:	8b 45 ec             	mov    -0x14(%ebp),%eax
    189c:	83 c0 08             	add    $0x8,%eax
    189f:	eb 38                	jmp    18d9 <malloc+0xde>
    18a1:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    18a6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    18a9:	75 1b                	jne    18c6 <malloc+0xcb>
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	89 04 24             	mov    %eax,(%esp)
    18b1:	e8 ed fe ff ff       	call   17a3 <morecore>
    18b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18bd:	75 07                	jne    18c6 <malloc+0xcb>
    18bf:	b8 00 00 00 00       	mov    $0x0,%eax
    18c4:	eb 13                	jmp    18d9 <malloc+0xde>
    18c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18cf:	8b 00                	mov    (%eax),%eax
    18d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18d4:	e9 70 ff ff ff       	jmp    1849 <malloc+0x4e>
    18d9:	c9                   	leave  
    18da:	c3                   	ret    
    18db:	90                   	nop

000018dc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18dc:	55                   	push   %ebp
    18dd:	89 e5                	mov    %esp,%ebp
    18df:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18e2:	8b 55 08             	mov    0x8(%ebp),%edx
    18e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18eb:	f0 87 02             	lock xchg %eax,(%edx)
    18ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18f4:	c9                   	leave  
    18f5:	c3                   	ret    

000018f6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18f6:	55                   	push   %ebp
    18f7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1902:	5d                   	pop    %ebp
    1903:	c3                   	ret    

00001904 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1904:	55                   	push   %ebp
    1905:	89 e5                	mov    %esp,%ebp
    1907:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    190a:	90                   	nop
    190b:	8b 45 08             	mov    0x8(%ebp),%eax
    190e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1915:	00 
    1916:	89 04 24             	mov    %eax,(%esp)
    1919:	e8 be ff ff ff       	call   18dc <xchg>
    191e:	85 c0                	test   %eax,%eax
    1920:	75 e9                	jne    190b <lock_acquire+0x7>
}
    1922:	c9                   	leave  
    1923:	c3                   	ret    

00001924 <lock_release>:
void lock_release(lock_t *lock){
    1924:	55                   	push   %ebp
    1925:	89 e5                	mov    %esp,%ebp
    1927:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    192a:	8b 45 08             	mov    0x8(%ebp),%eax
    192d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1934:	00 
    1935:	89 04 24             	mov    %eax,(%esp)
    1938:	e8 9f ff ff ff       	call   18dc <xchg>
}
    193d:	c9                   	leave  
    193e:	c3                   	ret    

0000193f <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    193f:	55                   	push   %ebp
    1940:	89 e5                	mov    %esp,%ebp
    1942:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1945:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    194c:	e8 aa fe ff ff       	call   17fb <malloc>
    1951:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1954:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1957:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1962:	85 c0                	test   %eax,%eax
    1964:	74 14                	je     197a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	25 ff 0f 00 00       	and    $0xfff,%eax
    196e:	89 c2                	mov    %eax,%edx
    1970:	b8 00 10 00 00       	mov    $0x1000,%eax
    1975:	29 d0                	sub    %edx,%eax
    1977:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    197a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    197e:	75 1b                	jne    199b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1980:	c7 44 24 04 a4 1b 00 	movl   $0x1ba4,0x4(%esp)
    1987:	00 
    1988:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198f:	e8 84 fb ff ff       	call   1518 <printf>
        return 0;
    1994:	b8 00 00 00 00       	mov    $0x0,%eax
    1999:	eb 6f                	jmp    1a0a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    199b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    199e:	8b 55 08             	mov    0x8(%ebp),%edx
    19a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    19a8:	89 54 24 08          	mov    %edx,0x8(%esp)
    19ac:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    19b3:	00 
    19b4:	89 04 24             	mov    %eax,(%esp)
    19b7:	e8 5c fa ff ff       	call   1418 <clone>
    19bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    19bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19c3:	79 1b                	jns    19e0 <thread_create+0xa1>
        printf(1,"clone fails\n");
    19c5:	c7 44 24 04 b2 1b 00 	movl   $0x1bb2,0x4(%esp)
    19cc:	00 
    19cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19d4:	e8 3f fb ff ff       	call   1518 <printf>
        return 0;
    19d9:	b8 00 00 00 00       	mov    $0x0,%eax
    19de:	eb 2a                	jmp    1a0a <thread_create+0xcb>
    }
    if(tid > 0){
    19e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19e4:	7e 05                	jle    19eb <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    19e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e9:	eb 1f                	jmp    1a0a <thread_create+0xcb>
    }
    if(tid == 0){
    19eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19ef:	75 14                	jne    1a05 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    19f1:	c7 44 24 04 bf 1b 00 	movl   $0x1bbf,0x4(%esp)
    19f8:	00 
    19f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a00:	e8 13 fb ff ff       	call   1518 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1a05:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a0a:	c9                   	leave  
    1a0b:	c3                   	ret    

00001a0c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1a0c:	55                   	push   %ebp
    1a0d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1a0f:	a1 10 1f 00 00       	mov    0x1f10,%eax
    1a14:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a1a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a1f:	a3 10 1f 00 00       	mov    %eax,0x1f10
    return (int)(rands % max);
    1a24:	a1 10 1f 00 00       	mov    0x1f10,%eax
    1a29:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a2c:	ba 00 00 00 00       	mov    $0x0,%edx
    1a31:	f7 f1                	div    %ecx
    1a33:	89 d0                	mov    %edx,%eax
}
    1a35:	5d                   	pop    %ebp
    1a36:	c3                   	ret    
    1a37:	90                   	nop

00001a38 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a38:	55                   	push   %ebp
    1a39:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a44:	8b 45 08             	mov    0x8(%ebp),%eax
    1a47:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a51:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a58:	5d                   	pop    %ebp
    1a59:	c3                   	ret    

00001a5a <add_q>:

void add_q(struct queue *q, int v){
    1a5a:	55                   	push   %ebp
    1a5b:	89 e5                	mov    %esp,%ebp
    1a5d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a60:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a67:	e8 8f fd ff ff       	call   17fb <malloc>
    1a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a72:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a7f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a81:	8b 45 08             	mov    0x8(%ebp),%eax
    1a84:	8b 40 04             	mov    0x4(%eax),%eax
    1a87:	85 c0                	test   %eax,%eax
    1a89:	75 0b                	jne    1a96 <add_q+0x3c>
        q->head = n;
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a91:	89 50 04             	mov    %edx,0x4(%eax)
    1a94:	eb 0c                	jmp    1aa2 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	8b 40 08             	mov    0x8(%eax),%eax
    1a9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a9f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1aa2:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1aa8:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1aab:	8b 45 08             	mov    0x8(%ebp),%eax
    1aae:	8b 00                	mov    (%eax),%eax
    1ab0:	8d 50 01             	lea    0x1(%eax),%edx
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	89 10                	mov    %edx,(%eax)
}
    1ab8:	c9                   	leave  
    1ab9:	c3                   	ret    

00001aba <empty_q>:

int empty_q(struct queue *q){
    1aba:	55                   	push   %ebp
    1abb:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1abd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac0:	8b 00                	mov    (%eax),%eax
    1ac2:	85 c0                	test   %eax,%eax
    1ac4:	75 07                	jne    1acd <empty_q+0x13>
        return 1;
    1ac6:	b8 01 00 00 00       	mov    $0x1,%eax
    1acb:	eb 05                	jmp    1ad2 <empty_q+0x18>
    else
        return 0;
    1acd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1ad2:	5d                   	pop    %ebp
    1ad3:	c3                   	ret    

00001ad4 <pop_q>:
int pop_q(struct queue *q){
    1ad4:	55                   	push   %ebp
    1ad5:	89 e5                	mov    %esp,%ebp
    1ad7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1ada:	8b 45 08             	mov    0x8(%ebp),%eax
    1add:	89 04 24             	mov    %eax,(%esp)
    1ae0:	e8 d5 ff ff ff       	call   1aba <empty_q>
    1ae5:	85 c0                	test   %eax,%eax
    1ae7:	75 5d                	jne    1b46 <pop_q+0x72>
       val = q->head->value; 
    1ae9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aec:	8b 40 04             	mov    0x4(%eax),%eax
    1aef:	8b 00                	mov    (%eax),%eax
    1af1:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	8b 40 04             	mov    0x4(%eax),%eax
    1afa:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1afd:	8b 45 08             	mov    0x8(%ebp),%eax
    1b00:	8b 40 04             	mov    0x4(%eax),%eax
    1b03:	8b 50 04             	mov    0x4(%eax),%edx
    1b06:	8b 45 08             	mov    0x8(%ebp),%eax
    1b09:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b0f:	89 04 24             	mov    %eax,(%esp)
    1b12:	e8 b5 fb ff ff       	call   16cc <free>
       q->size--;
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	8b 00                	mov    (%eax),%eax
    1b1c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b22:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1b24:	8b 45 08             	mov    0x8(%ebp),%eax
    1b27:	8b 00                	mov    (%eax),%eax
    1b29:	85 c0                	test   %eax,%eax
    1b2b:	75 14                	jne    1b41 <pop_q+0x6d>
            q->head = 0;
    1b2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b30:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b37:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b44:	eb 05                	jmp    1b4b <pop_q+0x77>
    }
    return -1;
    1b46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b4b:	c9                   	leave  
    1b4c:	c3                   	ret    
