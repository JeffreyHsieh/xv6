
_tyield:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

// Test functions for yielding, prints "beep" and "boop".
void beep(void * arg_ptr);
void boop(void * arg_ptr);

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int arg = 10;
    1009:	c7 44 24 18 0a 00 00 	movl   $0xa,0x18(%esp)
    1010:	00 
  void *tid = thread_create(beep, (void *) &arg);
    1011:	8d 44 24 18          	lea    0x18(%esp),%eax
    1015:	89 44 24 04          	mov    %eax,0x4(%esp)
    1019:	c7 04 24 57 10 00 00 	movl   $0x1057,(%esp)
    1020:	e8 a1 08 00 00       	call   18c6 <thread_create>
    1025:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if(tid <= 0){
    1029:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    102e:	75 19                	jne    1049 <main+0x49>
    printf(1, "Thread Creation Failed\n");
    1030:	c7 44 24 04 d5 1a 00 	movl   $0x1ad5,0x4(%esp)
    1037:	00 
    1038:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103f:	e8 59 04 00 00       	call   149d <printf>
    exit();
    1044:	e8 b3 02 00 00       	call   12fc <exit>
  }
  while(wait()>=0);
    1049:	e8 b6 02 00 00       	call   1304 <wait>
    104e:	85 c0                	test   %eax,%eax
    1050:	79 f7                	jns    1049 <main+0x49>

  exit();
    1052:	e8 a5 02 00 00       	call   12fc <exit>

00001057 <beep>:
  return 0;
}

// Beep
void beep(void *arg_ptr){
    1057:	55                   	push   %ebp
    1058:	89 e5                	mov    %esp,%ebp
    105a:	83 ec 18             	sub    $0x18,%esp
  printf(1, "beep\n");
    105d:	c7 44 24 04 ed 1a 00 	movl   $0x1aed,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    106c:	e8 2c 04 00 00       	call   149d <printf>
  texit();
    1071:	e8 2e 03 00 00       	call   13a4 <texit>

00001076 <boop>:
}

// Boop
void boop(void *arg_ptr){
    1076:	55                   	push   %ebp
    1077:	89 e5                	mov    %esp,%ebp
    1079:	83 ec 18             	sub    $0x18,%esp
  printf(1, "boop\n");
    107c:	c7 44 24 04 f3 1a 00 	movl   $0x1af3,0x4(%esp)
    1083:	00 
    1084:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    108b:	e8 0d 04 00 00       	call   149d <printf>
  texit();
    1090:	e8 0f 03 00 00       	call   13a4 <texit>
    1095:	90                   	nop
    1096:	90                   	nop
    1097:	90                   	nop

00001098 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1098:	55                   	push   %ebp
    1099:	89 e5                	mov    %esp,%ebp
    109b:	57                   	push   %edi
    109c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    109d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a0:	8b 55 10             	mov    0x10(%ebp),%edx
    10a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a6:	89 cb                	mov    %ecx,%ebx
    10a8:	89 df                	mov    %ebx,%edi
    10aa:	89 d1                	mov    %edx,%ecx
    10ac:	fc                   	cld    
    10ad:	f3 aa                	rep stos %al,%es:(%edi)
    10af:	89 ca                	mov    %ecx,%edx
    10b1:	89 fb                	mov    %edi,%ebx
    10b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10b9:	5b                   	pop    %ebx
    10ba:	5f                   	pop    %edi
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    

000010bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
    10c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cc:	0f b6 10             	movzbl (%eax),%edx
    10cf:	8b 45 08             	mov    0x8(%ebp),%eax
    10d2:	88 10                	mov    %dl,(%eax)
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	0f b6 00             	movzbl (%eax),%eax
    10da:	84 c0                	test   %al,%al
    10dc:	0f 95 c0             	setne  %al
    10df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10e3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10e7:	84 c0                	test   %al,%al
    10e9:	75 de                	jne    10c9 <strcpy+0xc>
    ;
  return os;
    10eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10ee:	c9                   	leave  
    10ef:	c3                   	ret    

000010f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10f3:	eb 08                	jmp    10fd <strcmp+0xd>
    p++, q++;
    10f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10f9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	0f b6 00             	movzbl (%eax),%eax
    1103:	84 c0                	test   %al,%al
    1105:	74 10                	je     1117 <strcmp+0x27>
    1107:	8b 45 08             	mov    0x8(%ebp),%eax
    110a:	0f b6 10             	movzbl (%eax),%edx
    110d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1110:	0f b6 00             	movzbl (%eax),%eax
    1113:	38 c2                	cmp    %al,%dl
    1115:	74 de                	je     10f5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	0f b6 00             	movzbl (%eax),%eax
    111d:	0f b6 d0             	movzbl %al,%edx
    1120:	8b 45 0c             	mov    0xc(%ebp),%eax
    1123:	0f b6 00             	movzbl (%eax),%eax
    1126:	0f b6 c0             	movzbl %al,%eax
    1129:	89 d1                	mov    %edx,%ecx
    112b:	29 c1                	sub    %eax,%ecx
    112d:	89 c8                	mov    %ecx,%eax
}
    112f:	5d                   	pop    %ebp
    1130:	c3                   	ret    

00001131 <strlen>:

uint
strlen(char *s)
{
    1131:	55                   	push   %ebp
    1132:	89 e5                	mov    %esp,%ebp
    1134:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1137:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    113e:	eb 04                	jmp    1144 <strlen+0x13>
    1140:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1144:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1147:	03 45 08             	add    0x8(%ebp),%eax
    114a:	0f b6 00             	movzbl (%eax),%eax
    114d:	84 c0                	test   %al,%al
    114f:	75 ef                	jne    1140 <strlen+0xf>
    ;
  return n;
    1151:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1154:	c9                   	leave  
    1155:	c3                   	ret    

00001156 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1156:	55                   	push   %ebp
    1157:	89 e5                	mov    %esp,%ebp
    1159:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    115c:	8b 45 10             	mov    0x10(%ebp),%eax
    115f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1163:	8b 45 0c             	mov    0xc(%ebp),%eax
    1166:	89 44 24 04          	mov    %eax,0x4(%esp)
    116a:	8b 45 08             	mov    0x8(%ebp),%eax
    116d:	89 04 24             	mov    %eax,(%esp)
    1170:	e8 23 ff ff ff       	call   1098 <stosb>
  return dst;
    1175:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1178:	c9                   	leave  
    1179:	c3                   	ret    

0000117a <strchr>:

char*
strchr(const char *s, char c)
{
    117a:	55                   	push   %ebp
    117b:	89 e5                	mov    %esp,%ebp
    117d:	83 ec 04             	sub    $0x4,%esp
    1180:	8b 45 0c             	mov    0xc(%ebp),%eax
    1183:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1186:	eb 14                	jmp    119c <strchr+0x22>
    if(*s == c)
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	0f b6 00             	movzbl (%eax),%eax
    118e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1191:	75 05                	jne    1198 <strchr+0x1e>
      return (char*)s;
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	eb 13                	jmp    11ab <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1198:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	0f b6 00             	movzbl (%eax),%eax
    11a2:	84 c0                	test   %al,%al
    11a4:	75 e2                	jne    1188 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    11a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11ab:	c9                   	leave  
    11ac:	c3                   	ret    

000011ad <gets>:

char*
gets(char *buf, int max)
{
    11ad:	55                   	push   %ebp
    11ae:	89 e5                	mov    %esp,%ebp
    11b0:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11ba:	eb 44                	jmp    1200 <gets+0x53>
    cc = read(0, &c, 1);
    11bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11c3:	00 
    11c4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11c7:	89 44 24 04          	mov    %eax,0x4(%esp)
    11cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11d2:	e8 3d 01 00 00       	call   1314 <read>
    11d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    11da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11de:	7e 2d                	jle    120d <gets+0x60>
      break;
    buf[i++] = c;
    11e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e3:	03 45 08             	add    0x8(%ebp),%eax
    11e6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11ea:	88 10                	mov    %dl,(%eax)
    11ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    11f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f4:	3c 0a                	cmp    $0xa,%al
    11f6:	74 16                	je     120e <gets+0x61>
    11f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11fc:	3c 0d                	cmp    $0xd,%al
    11fe:	74 0e                	je     120e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1200:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1203:	83 c0 01             	add    $0x1,%eax
    1206:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1209:	7c b1                	jl     11bc <gets+0xf>
    120b:	eb 01                	jmp    120e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    120d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    120e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1211:	03 45 08             	add    0x8(%ebp),%eax
    1214:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
}
    121a:	c9                   	leave  
    121b:	c3                   	ret    

0000121c <stat>:

int
stat(char *n, struct stat *st)
{
    121c:	55                   	push   %ebp
    121d:	89 e5                	mov    %esp,%ebp
    121f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1222:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1229:	00 
    122a:	8b 45 08             	mov    0x8(%ebp),%eax
    122d:	89 04 24             	mov    %eax,(%esp)
    1230:	e8 07 01 00 00       	call   133c <open>
    1235:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1238:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    123c:	79 07                	jns    1245 <stat+0x29>
    return -1;
    123e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1243:	eb 23                	jmp    1268 <stat+0x4c>
  r = fstat(fd, st);
    1245:	8b 45 0c             	mov    0xc(%ebp),%eax
    1248:	89 44 24 04          	mov    %eax,0x4(%esp)
    124c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    124f:	89 04 24             	mov    %eax,(%esp)
    1252:	e8 fd 00 00 00       	call   1354 <fstat>
    1257:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    125a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    125d:	89 04 24             	mov    %eax,(%esp)
    1260:	e8 bf 00 00 00       	call   1324 <close>
  return r;
    1265:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1268:	c9                   	leave  
    1269:	c3                   	ret    

0000126a <atoi>:

int
atoi(const char *s)
{
    126a:	55                   	push   %ebp
    126b:	89 e5                	mov    %esp,%ebp
    126d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1277:	eb 24                	jmp    129d <atoi+0x33>
    n = n*10 + *s++ - '0';
    1279:	8b 55 fc             	mov    -0x4(%ebp),%edx
    127c:	89 d0                	mov    %edx,%eax
    127e:	c1 e0 02             	shl    $0x2,%eax
    1281:	01 d0                	add    %edx,%eax
    1283:	01 c0                	add    %eax,%eax
    1285:	89 c2                	mov    %eax,%edx
    1287:	8b 45 08             	mov    0x8(%ebp),%eax
    128a:	0f b6 00             	movzbl (%eax),%eax
    128d:	0f be c0             	movsbl %al,%eax
    1290:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1293:	83 e8 30             	sub    $0x30,%eax
    1296:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1299:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
    12a0:	0f b6 00             	movzbl (%eax),%eax
    12a3:	3c 2f                	cmp    $0x2f,%al
    12a5:	7e 0a                	jle    12b1 <atoi+0x47>
    12a7:	8b 45 08             	mov    0x8(%ebp),%eax
    12aa:	0f b6 00             	movzbl (%eax),%eax
    12ad:	3c 39                	cmp    $0x39,%al
    12af:	7e c8                	jle    1279 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12b4:	c9                   	leave  
    12b5:	c3                   	ret    

000012b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12b6:	55                   	push   %ebp
    12b7:	89 e5                	mov    %esp,%ebp
    12b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    12c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    12c8:	eb 13                	jmp    12dd <memmove+0x27>
    *dst++ = *src++;
    12ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12cd:	0f b6 10             	movzbl (%eax),%edx
    12d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12d3:	88 10                	mov    %dl,(%eax)
    12d5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12e1:	0f 9f c0             	setg   %al
    12e4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12e8:	84 c0                	test   %al,%al
    12ea:	75 de                	jne    12ca <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ef:	c9                   	leave  
    12f0:	c3                   	ret    
    12f1:	90                   	nop
    12f2:	90                   	nop
    12f3:	90                   	nop

000012f4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12f4:	b8 01 00 00 00       	mov    $0x1,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <exit>:
SYSCALL(exit)
    12fc:	b8 02 00 00 00       	mov    $0x2,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <wait>:
SYSCALL(wait)
    1304:	b8 03 00 00 00       	mov    $0x3,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <pipe>:
SYSCALL(pipe)
    130c:	b8 04 00 00 00       	mov    $0x4,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <read>:
SYSCALL(read)
    1314:	b8 05 00 00 00       	mov    $0x5,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <write>:
SYSCALL(write)
    131c:	b8 10 00 00 00       	mov    $0x10,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <close>:
SYSCALL(close)
    1324:	b8 15 00 00 00       	mov    $0x15,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <kill>:
SYSCALL(kill)
    132c:	b8 06 00 00 00       	mov    $0x6,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <exec>:
SYSCALL(exec)
    1334:	b8 07 00 00 00       	mov    $0x7,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <open>:
SYSCALL(open)
    133c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <mknod>:
SYSCALL(mknod)
    1344:	b8 11 00 00 00       	mov    $0x11,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <unlink>:
SYSCALL(unlink)
    134c:	b8 12 00 00 00       	mov    $0x12,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <fstat>:
SYSCALL(fstat)
    1354:	b8 08 00 00 00       	mov    $0x8,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <link>:
SYSCALL(link)
    135c:	b8 13 00 00 00       	mov    $0x13,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <mkdir>:
SYSCALL(mkdir)
    1364:	b8 14 00 00 00       	mov    $0x14,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <chdir>:
SYSCALL(chdir)
    136c:	b8 09 00 00 00       	mov    $0x9,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <dup>:
SYSCALL(dup)
    1374:	b8 0a 00 00 00       	mov    $0xa,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <getpid>:
SYSCALL(getpid)
    137c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <sbrk>:
SYSCALL(sbrk)
    1384:	b8 0c 00 00 00       	mov    $0xc,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <sleep>:
SYSCALL(sleep)
    138c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <uptime>:
SYSCALL(uptime)
    1394:	b8 0e 00 00 00       	mov    $0xe,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <clone>:
SYSCALL(clone)
    139c:	b8 16 00 00 00       	mov    $0x16,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <texit>:
SYSCALL(texit)
    13a4:	b8 17 00 00 00       	mov    $0x17,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <tsleep>:
SYSCALL(tsleep)
    13ac:	b8 18 00 00 00       	mov    $0x18,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <twakeup>:
SYSCALL(twakeup)
    13b4:	b8 19 00 00 00       	mov    $0x19,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <thread_yield>:
SYSCALL(thread_yield)
    13bc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13c4:	55                   	push   %ebp
    13c5:	89 e5                	mov    %esp,%ebp
    13c7:	83 ec 28             	sub    $0x28,%esp
    13ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13d7:	00 
    13d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13db:	89 44 24 04          	mov    %eax,0x4(%esp)
    13df:	8b 45 08             	mov    0x8(%ebp),%eax
    13e2:	89 04 24             	mov    %eax,(%esp)
    13e5:	e8 32 ff ff ff       	call   131c <write>
}
    13ea:	c9                   	leave  
    13eb:	c3                   	ret    

000013ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13ec:	55                   	push   %ebp
    13ed:	89 e5                	mov    %esp,%ebp
    13ef:	53                   	push   %ebx
    13f0:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13fe:	74 17                	je     1417 <printint+0x2b>
    1400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1404:	79 11                	jns    1417 <printint+0x2b>
    neg = 1;
    1406:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    140d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1410:	f7 d8                	neg    %eax
    1412:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1415:	eb 06                	jmp    141d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1417:	8b 45 0c             	mov    0xc(%ebp),%eax
    141a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    141d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1424:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1427:	8b 5d 10             	mov    0x10(%ebp),%ebx
    142a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142d:	ba 00 00 00 00       	mov    $0x0,%edx
    1432:	f7 f3                	div    %ebx
    1434:	89 d0                	mov    %edx,%eax
    1436:	0f b6 80 2c 1b 00 00 	movzbl 0x1b2c(%eax),%eax
    143d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1441:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1445:	8b 45 10             	mov    0x10(%ebp),%eax
    1448:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    144b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144e:	ba 00 00 00 00       	mov    $0x0,%edx
    1453:	f7 75 d4             	divl   -0x2c(%ebp)
    1456:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1459:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    145d:	75 c5                	jne    1424 <printint+0x38>
  if(neg)
    145f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1463:	74 28                	je     148d <printint+0xa1>
    buf[i++] = '-';
    1465:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1468:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    146d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1471:	eb 1a                	jmp    148d <printint+0xa1>
    putc(fd, buf[i]);
    1473:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1476:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    147b:	0f be c0             	movsbl %al,%eax
    147e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1482:	8b 45 08             	mov    0x8(%ebp),%eax
    1485:	89 04 24             	mov    %eax,(%esp)
    1488:	e8 37 ff ff ff       	call   13c4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    148d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1491:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1495:	79 dc                	jns    1473 <printint+0x87>
    putc(fd, buf[i]);
}
    1497:	83 c4 44             	add    $0x44,%esp
    149a:	5b                   	pop    %ebx
    149b:	5d                   	pop    %ebp
    149c:	c3                   	ret    

0000149d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    149d:	55                   	push   %ebp
    149e:	89 e5                	mov    %esp,%ebp
    14a0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14aa:	8d 45 0c             	lea    0xc(%ebp),%eax
    14ad:	83 c0 04             	add    $0x4,%eax
    14b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    14b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14ba:	e9 7e 01 00 00       	jmp    163d <printf+0x1a0>
    c = fmt[i] & 0xff;
    14bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14c5:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14c8:	0f b6 00             	movzbl (%eax),%eax
    14cb:	0f be c0             	movsbl %al,%eax
    14ce:	25 ff 00 00 00       	and    $0xff,%eax
    14d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    14d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14da:	75 2c                	jne    1508 <printf+0x6b>
      if(c == '%'){
    14dc:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14e0:	75 0c                	jne    14ee <printf+0x51>
        state = '%';
    14e2:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14e9:	e9 4b 01 00 00       	jmp    1639 <printf+0x19c>
      } else {
        putc(fd, c);
    14ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f1:	0f be c0             	movsbl %al,%eax
    14f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f8:	8b 45 08             	mov    0x8(%ebp),%eax
    14fb:	89 04 24             	mov    %eax,(%esp)
    14fe:	e8 c1 fe ff ff       	call   13c4 <putc>
    1503:	e9 31 01 00 00       	jmp    1639 <printf+0x19c>
      }
    } else if(state == '%'){
    1508:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    150c:	0f 85 27 01 00 00    	jne    1639 <printf+0x19c>
      if(c == 'd'){
    1512:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1516:	75 2d                	jne    1545 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	8b 00                	mov    (%eax),%eax
    151d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1524:	00 
    1525:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    152c:	00 
    152d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1531:	8b 45 08             	mov    0x8(%ebp),%eax
    1534:	89 04 24             	mov    %eax,(%esp)
    1537:	e8 b0 fe ff ff       	call   13ec <printint>
        ap++;
    153c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1540:	e9 ed 00 00 00       	jmp    1632 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1545:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1549:	74 06                	je     1551 <printf+0xb4>
    154b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    154f:	75 2d                	jne    157e <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1551:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1554:	8b 00                	mov    (%eax),%eax
    1556:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    155d:	00 
    155e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1565:	00 
    1566:	89 44 24 04          	mov    %eax,0x4(%esp)
    156a:	8b 45 08             	mov    0x8(%ebp),%eax
    156d:	89 04 24             	mov    %eax,(%esp)
    1570:	e8 77 fe ff ff       	call   13ec <printint>
        ap++;
    1575:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1579:	e9 b4 00 00 00       	jmp    1632 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    157e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1582:	75 46                	jne    15ca <printf+0x12d>
        s = (char*)*ap;
    1584:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1587:	8b 00                	mov    (%eax),%eax
    1589:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    158c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1590:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1594:	75 27                	jne    15bd <printf+0x120>
          s = "(null)";
    1596:	c7 45 e4 f9 1a 00 00 	movl   $0x1af9,-0x1c(%ebp)
        while(*s != 0){
    159d:	eb 1f                	jmp    15be <printf+0x121>
          putc(fd, *s);
    159f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15a2:	0f b6 00             	movzbl (%eax),%eax
    15a5:	0f be c0             	movsbl %al,%eax
    15a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
    15af:	89 04 24             	mov    %eax,(%esp)
    15b2:	e8 0d fe ff ff       	call   13c4 <putc>
          s++;
    15b7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    15bb:	eb 01                	jmp    15be <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15bd:	90                   	nop
    15be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15c1:	0f b6 00             	movzbl (%eax),%eax
    15c4:	84 c0                	test   %al,%al
    15c6:	75 d7                	jne    159f <printf+0x102>
    15c8:	eb 68                	jmp    1632 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15ca:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15ce:	75 1d                	jne    15ed <printf+0x150>
        putc(fd, *ap);
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	8b 00                	mov    (%eax),%eax
    15d5:	0f be c0             	movsbl %al,%eax
    15d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15dc:	8b 45 08             	mov    0x8(%ebp),%eax
    15df:	89 04 24             	mov    %eax,(%esp)
    15e2:	e8 dd fd ff ff       	call   13c4 <putc>
        ap++;
    15e7:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15eb:	eb 45                	jmp    1632 <printf+0x195>
      } else if(c == '%'){
    15ed:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15f1:	75 17                	jne    160a <printf+0x16d>
        putc(fd, c);
    15f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15f6:	0f be c0             	movsbl %al,%eax
    15f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    15fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1600:	89 04 24             	mov    %eax,(%esp)
    1603:	e8 bc fd ff ff       	call   13c4 <putc>
    1608:	eb 28                	jmp    1632 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    160a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1611:	00 
    1612:	8b 45 08             	mov    0x8(%ebp),%eax
    1615:	89 04 24             	mov    %eax,(%esp)
    1618:	e8 a7 fd ff ff       	call   13c4 <putc>
        putc(fd, c);
    161d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1620:	0f be c0             	movsbl %al,%eax
    1623:	89 44 24 04          	mov    %eax,0x4(%esp)
    1627:	8b 45 08             	mov    0x8(%ebp),%eax
    162a:	89 04 24             	mov    %eax,(%esp)
    162d:	e8 92 fd ff ff       	call   13c4 <putc>
      }
      state = 0;
    1632:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1639:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    163d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1640:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1643:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1646:	0f b6 00             	movzbl (%eax),%eax
    1649:	84 c0                	test   %al,%al
    164b:	0f 85 6e fe ff ff    	jne    14bf <printf+0x22>
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
    1663:	a1 4c 1b 00 00       	mov    0x1b4c,%eax
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
    16a9:	c1 e0 03             	shl    $0x3,%eax
    16ac:	89 c2                	mov    %eax,%edx
    16ae:	03 55 f8             	add    -0x8(%ebp),%edx
    16b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b4:	8b 00                	mov    (%eax),%eax
    16b6:	39 c2                	cmp    %eax,%edx
    16b8:	75 24                	jne    16de <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    16ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bd:	8b 50 04             	mov    0x4(%eax),%edx
    16c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c3:	8b 00                	mov    (%eax),%eax
    16c5:	8b 40 04             	mov    0x4(%eax),%eax
    16c8:	01 c2                	add    %eax,%edx
    16ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d3:	8b 00                	mov    (%eax),%eax
    16d5:	8b 10                	mov    (%eax),%edx
    16d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16da:	89 10                	mov    %edx,(%eax)
    16dc:	eb 0a                	jmp    16e8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    16de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e1:	8b 10                	mov    (%eax),%edx
    16e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16eb:	8b 40 04             	mov    0x4(%eax),%eax
    16ee:	c1 e0 03             	shl    $0x3,%eax
    16f1:	03 45 fc             	add    -0x4(%ebp),%eax
    16f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16f7:	75 20                	jne    1719 <free+0xc5>
    p->s.size += bp->s.size;
    16f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fc:	8b 50 04             	mov    0x4(%eax),%edx
    16ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1702:	8b 40 04             	mov    0x4(%eax),%eax
    1705:	01 c2                	add    %eax,%edx
    1707:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    170d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1710:	8b 10                	mov    (%eax),%edx
    1712:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1715:	89 10                	mov    %edx,(%eax)
    1717:	eb 08                	jmp    1721 <free+0xcd>
  } else
    p->s.ptr = bp;
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    171f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1721:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1724:	a3 4c 1b 00 00       	mov    %eax,0x1b4c
}
    1729:	c9                   	leave  
    172a:	c3                   	ret    

0000172b <morecore>:

static Header*
morecore(uint nu)
{
    172b:	55                   	push   %ebp
    172c:	89 e5                	mov    %esp,%ebp
    172e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1731:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1738:	77 07                	ja     1741 <morecore+0x16>
    nu = 4096;
    173a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1741:	8b 45 08             	mov    0x8(%ebp),%eax
    1744:	c1 e0 03             	shl    $0x3,%eax
    1747:	89 04 24             	mov    %eax,(%esp)
    174a:	e8 35 fc ff ff       	call   1384 <sbrk>
    174f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1752:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1756:	75 07                	jne    175f <morecore+0x34>
    return 0;
    1758:	b8 00 00 00 00       	mov    $0x0,%eax
    175d:	eb 22                	jmp    1781 <morecore+0x56>
  hp = (Header*)p;
    175f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1762:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1765:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1768:	8b 55 08             	mov    0x8(%ebp),%edx
    176b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    176e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1771:	83 c0 08             	add    $0x8,%eax
    1774:	89 04 24             	mov    %eax,(%esp)
    1777:	e8 d8 fe ff ff       	call   1654 <free>
  return freep;
    177c:	a1 4c 1b 00 00       	mov    0x1b4c,%eax
}
    1781:	c9                   	leave  
    1782:	c3                   	ret    

00001783 <malloc>:

void*
malloc(uint nbytes)
{
    1783:	55                   	push   %ebp
    1784:	89 e5                	mov    %esp,%ebp
    1786:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1789:	8b 45 08             	mov    0x8(%ebp),%eax
    178c:	83 c0 07             	add    $0x7,%eax
    178f:	c1 e8 03             	shr    $0x3,%eax
    1792:	83 c0 01             	add    $0x1,%eax
    1795:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1798:	a1 4c 1b 00 00       	mov    0x1b4c,%eax
    179d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17a4:	75 23                	jne    17c9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17a6:	c7 45 f0 44 1b 00 00 	movl   $0x1b44,-0x10(%ebp)
    17ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b0:	a3 4c 1b 00 00       	mov    %eax,0x1b4c
    17b5:	a1 4c 1b 00 00       	mov    0x1b4c,%eax
    17ba:	a3 44 1b 00 00       	mov    %eax,0x1b44
    base.s.size = 0;
    17bf:	c7 05 48 1b 00 00 00 	movl   $0x0,0x1b48
    17c6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cc:	8b 00                	mov    (%eax),%eax
    17ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    17d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d4:	8b 40 04             	mov    0x4(%eax),%eax
    17d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17da:	72 4d                	jb     1829 <malloc+0xa6>
      if(p->s.size == nunits)
    17dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17df:	8b 40 04             	mov    0x4(%eax),%eax
    17e2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17e5:	75 0c                	jne    17f3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ea:	8b 10                	mov    (%eax),%edx
    17ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ef:	89 10                	mov    %edx,(%eax)
    17f1:	eb 26                	jmp    1819 <malloc+0x96>
      else {
        p->s.size -= nunits;
    17f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f6:	8b 40 04             	mov    0x4(%eax),%eax
    17f9:	89 c2                	mov    %eax,%edx
    17fb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1801:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1804:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1807:	8b 40 04             	mov    0x4(%eax),%eax
    180a:	c1 e0 03             	shl    $0x3,%eax
    180d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1810:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1813:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1816:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1819:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181c:	a3 4c 1b 00 00       	mov    %eax,0x1b4c
      return (void*)(p + 1);
    1821:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1824:	83 c0 08             	add    $0x8,%eax
    1827:	eb 38                	jmp    1861 <malloc+0xde>
    }
    if(p == freep)
    1829:	a1 4c 1b 00 00       	mov    0x1b4c,%eax
    182e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1831:	75 1b                	jne    184e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1833:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1836:	89 04 24             	mov    %eax,(%esp)
    1839:	e8 ed fe ff ff       	call   172b <morecore>
    183e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1841:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1845:	75 07                	jne    184e <malloc+0xcb>
        return 0;
    1847:	b8 00 00 00 00       	mov    $0x0,%eax
    184c:	eb 13                	jmp    1861 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    184e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1851:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1854:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1857:	8b 00                	mov    (%eax),%eax
    1859:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    185c:	e9 70 ff ff ff       	jmp    17d1 <malloc+0x4e>
}
    1861:	c9                   	leave  
    1862:	c3                   	ret    
    1863:	90                   	nop

00001864 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1864:	55                   	push   %ebp
    1865:	89 e5                	mov    %esp,%ebp
    1867:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    186a:	8b 55 08             	mov    0x8(%ebp),%edx
    186d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1870:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1873:	f0 87 02             	lock xchg %eax,(%edx)
    1876:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1879:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    187c:	c9                   	leave  
    187d:	c3                   	ret    

0000187e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    187e:	55                   	push   %ebp
    187f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1881:	8b 45 08             	mov    0x8(%ebp),%eax
    1884:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    188a:	5d                   	pop    %ebp
    188b:	c3                   	ret    

0000188c <lock_acquire>:
void lock_acquire(lock_t *lock){
    188c:	55                   	push   %ebp
    188d:	89 e5                	mov    %esp,%ebp
    188f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1892:	8b 45 08             	mov    0x8(%ebp),%eax
    1895:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    189c:	00 
    189d:	89 04 24             	mov    %eax,(%esp)
    18a0:	e8 bf ff ff ff       	call   1864 <xchg>
    18a5:	85 c0                	test   %eax,%eax
    18a7:	75 e9                	jne    1892 <lock_acquire+0x6>
}
    18a9:	c9                   	leave  
    18aa:	c3                   	ret    

000018ab <lock_release>:
void lock_release(lock_t *lock){
    18ab:	55                   	push   %ebp
    18ac:	89 e5                	mov    %esp,%ebp
    18ae:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18b1:	8b 45 08             	mov    0x8(%ebp),%eax
    18b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18bb:	00 
    18bc:	89 04 24             	mov    %eax,(%esp)
    18bf:	e8 a0 ff ff ff       	call   1864 <xchg>
}
    18c4:	c9                   	leave  
    18c5:	c3                   	ret    

000018c6 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18c6:	55                   	push   %ebp
    18c7:	89 e5                	mov    %esp,%ebp
    18c9:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18cc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18d3:	e8 ab fe ff ff       	call   1783 <malloc>
    18d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    18db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18de:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e4:	25 ff 0f 00 00       	and    $0xfff,%eax
    18e9:	85 c0                	test   %eax,%eax
    18eb:	74 15                	je     1902 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    18ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f0:	89 c2                	mov    %eax,%edx
    18f2:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18f8:	b8 00 10 00 00       	mov    $0x1000,%eax
    18fd:	29 d0                	sub    %edx,%eax
    18ff:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1902:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1906:	75 1b                	jne    1923 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1908:	c7 44 24 04 00 1b 00 	movl   $0x1b00,0x4(%esp)
    190f:	00 
    1910:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1917:	e8 81 fb ff ff       	call   149d <printf>
        return 0;
    191c:	b8 00 00 00 00       	mov    $0x0,%eax
    1921:	eb 6f                	jmp    1992 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1923:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1926:	8b 55 08             	mov    0x8(%ebp),%edx
    1929:	8b 45 f0             	mov    -0x10(%ebp),%eax
    192c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1930:	89 54 24 08          	mov    %edx,0x8(%esp)
    1934:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    193b:	00 
    193c:	89 04 24             	mov    %eax,(%esp)
    193f:	e8 58 fa ff ff       	call   139c <clone>
    1944:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1947:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    194b:	79 1b                	jns    1968 <thread_create+0xa2>
        printf(1,"clone fails\n");
    194d:	c7 44 24 04 0e 1b 00 	movl   $0x1b0e,0x4(%esp)
    1954:	00 
    1955:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    195c:	e8 3c fb ff ff       	call   149d <printf>
        return 0;
    1961:	b8 00 00 00 00       	mov    $0x0,%eax
    1966:	eb 2a                	jmp    1992 <thread_create+0xcc>
    }
    if(tid > 0){
    1968:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    196c:	7e 05                	jle    1973 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1971:	eb 1f                	jmp    1992 <thread_create+0xcc>
    }
    if(tid == 0){
    1973:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1977:	75 14                	jne    198d <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1979:	c7 44 24 04 1b 1b 00 	movl   $0x1b1b,0x4(%esp)
    1980:	00 
    1981:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1988:	e8 10 fb ff ff       	call   149d <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    198d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1992:	c9                   	leave  
    1993:	c3                   	ret    

00001994 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1994:	55                   	push   %ebp
    1995:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1997:	a1 40 1b 00 00       	mov    0x1b40,%eax
    199c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19a2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19a7:	a3 40 1b 00 00       	mov    %eax,0x1b40
    return (int)(rands % max);
    19ac:	a1 40 1b 00 00       	mov    0x1b40,%eax
    19b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19b4:	ba 00 00 00 00       	mov    $0x0,%edx
    19b9:	f7 f1                	div    %ecx
    19bb:	89 d0                	mov    %edx,%eax
}
    19bd:	5d                   	pop    %ebp
    19be:	c3                   	ret    
    19bf:	90                   	nop

000019c0 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19cc:	8b 45 08             	mov    0x8(%ebp),%eax
    19cf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19d6:	8b 45 08             	mov    0x8(%ebp),%eax
    19d9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19e0:	5d                   	pop    %ebp
    19e1:	c3                   	ret    

000019e2 <add_q>:

void add_q(struct queue *q, int v){
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    19e5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19e8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19ef:	e8 8f fd ff ff       	call   1783 <malloc>
    19f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a04:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a07:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a09:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0c:	8b 40 04             	mov    0x4(%eax),%eax
    1a0f:	85 c0                	test   %eax,%eax
    1a11:	75 0b                	jne    1a1e <add_q+0x3c>
        q->head = n;
    1a13:	8b 45 08             	mov    0x8(%ebp),%eax
    1a16:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a19:	89 50 04             	mov    %edx,0x4(%eax)
    1a1c:	eb 0c                	jmp    1a2a <add_q+0x48>
    }else{
        q->tail->next = n;
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8b 40 08             	mov    0x8(%eax),%eax
    1a24:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a27:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a30:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	8b 00                	mov    (%eax),%eax
    1a38:	8d 50 01             	lea    0x1(%eax),%edx
    1a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3e:	89 10                	mov    %edx,(%eax)
}
    1a40:	c9                   	leave  
    1a41:	c3                   	ret    

00001a42 <empty_q>:

int empty_q(struct queue *q){
    1a42:	55                   	push   %ebp
    1a43:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	8b 00                	mov    (%eax),%eax
    1a4a:	85 c0                	test   %eax,%eax
    1a4c:	75 07                	jne    1a55 <empty_q+0x13>
        return 1;
    1a4e:	b8 01 00 00 00       	mov    $0x1,%eax
    1a53:	eb 05                	jmp    1a5a <empty_q+0x18>
    else
        return 0;
    1a55:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a5a:	5d                   	pop    %ebp
    1a5b:	c3                   	ret    

00001a5c <pop_q>:
int pop_q(struct queue *q){
    1a5c:	55                   	push   %ebp
    1a5d:	89 e5                	mov    %esp,%ebp
    1a5f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a62:	8b 45 08             	mov    0x8(%ebp),%eax
    1a65:	89 04 24             	mov    %eax,(%esp)
    1a68:	e8 d5 ff ff ff       	call   1a42 <empty_q>
    1a6d:	85 c0                	test   %eax,%eax
    1a6f:	75 5d                	jne    1ace <pop_q+0x72>
       val = q->head->value; 
    1a71:	8b 45 08             	mov    0x8(%ebp),%eax
    1a74:	8b 40 04             	mov    0x4(%eax),%eax
    1a77:	8b 00                	mov    (%eax),%eax
    1a79:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1a7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7f:	8b 40 04             	mov    0x4(%eax),%eax
    1a82:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	8b 40 04             	mov    0x4(%eax),%eax
    1a8b:	8b 50 04             	mov    0x4(%eax),%edx
    1a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a91:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a97:	89 04 24             	mov    %eax,(%esp)
    1a9a:	e8 b5 fb ff ff       	call   1654 <free>
       q->size--;
    1a9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa2:	8b 00                	mov    (%eax),%eax
    1aa4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1aa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaa:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1aac:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaf:	8b 00                	mov    (%eax),%eax
    1ab1:	85 c0                	test   %eax,%eax
    1ab3:	75 14                	jne    1ac9 <pop_q+0x6d>
            q->head = 0;
    1ab5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1abf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1acc:	eb 05                	jmp    1ad3 <pop_q+0x77>
    }
    return -1;
    1ace:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ad3:	c9                   	leave  
    1ad4:	c3                   	ret    
