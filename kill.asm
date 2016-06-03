
_kill:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 1){
    1009:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    100d:	7f 19                	jg     1028 <main+0x28>
    printf(2, "usage: kill pid...\n");
    100f:	c7 44 24 04 b9 1a 00 	movl   $0x1ab9,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 55 04 00 00       	call   1478 <printf>
    exit();
    1023:	e8 a8 02 00 00       	call   12d0 <exit>
  }
  for(i=1; i<argc; i++)
    1028:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    102f:	00 
    1030:	eb 27                	jmp    1059 <main+0x59>
    kill(atoi(argv[i]));
    1032:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1036:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    103d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1040:	01 d0                	add    %edx,%eax
    1042:	8b 00                	mov    (%eax),%eax
    1044:	89 04 24             	mov    %eax,(%esp)
    1047:	e8 f2 01 00 00       	call   123e <atoi>
    104c:	89 04 24             	mov    %eax,(%esp)
    104f:	e8 ac 02 00 00       	call   1300 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    1054:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1059:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    105d:	3b 45 08             	cmp    0x8(%ebp),%eax
    1060:	7c d0                	jl     1032 <main+0x32>
    kill(atoi(argv[i]));
  exit();
    1062:	e8 69 02 00 00       	call   12d0 <exit>
    1067:	90                   	nop

00001068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1068:	55                   	push   %ebp
    1069:	89 e5                	mov    %esp,%ebp
    106b:	57                   	push   %edi
    106c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    106d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1070:	8b 55 10             	mov    0x10(%ebp),%edx
    1073:	8b 45 0c             	mov    0xc(%ebp),%eax
    1076:	89 cb                	mov    %ecx,%ebx
    1078:	89 df                	mov    %ebx,%edi
    107a:	89 d1                	mov    %edx,%ecx
    107c:	fc                   	cld    
    107d:	f3 aa                	rep stos %al,%es:(%edi)
    107f:	89 ca                	mov    %ecx,%edx
    1081:	89 fb                	mov    %edi,%ebx
    1083:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1086:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1089:	5b                   	pop    %ebx
    108a:	5f                   	pop    %edi
    108b:	5d                   	pop    %ebp
    108c:	c3                   	ret    

0000108d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    108d:	55                   	push   %ebp
    108e:	89 e5                	mov    %esp,%ebp
    1090:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1099:	90                   	nop
    109a:	8b 45 08             	mov    0x8(%ebp),%eax
    109d:	8d 50 01             	lea    0x1(%eax),%edx
    10a0:	89 55 08             	mov    %edx,0x8(%ebp)
    10a3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a6:	8d 4a 01             	lea    0x1(%edx),%ecx
    10a9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10ac:	0f b6 12             	movzbl (%edx),%edx
    10af:	88 10                	mov    %dl,(%eax)
    10b1:	0f b6 00             	movzbl (%eax),%eax
    10b4:	84 c0                	test   %al,%al
    10b6:	75 e2                	jne    109a <strcpy+0xd>
    ;
  return os;
    10b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10bb:	c9                   	leave  
    10bc:	c3                   	ret    

000010bd <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10c0:	eb 08                	jmp    10ca <strcmp+0xd>
    p++, q++;
    10c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	0f b6 00             	movzbl (%eax),%eax
    10d0:	84 c0                	test   %al,%al
    10d2:	74 10                	je     10e4 <strcmp+0x27>
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	0f b6 10             	movzbl (%eax),%edx
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dd:	0f b6 00             	movzbl (%eax),%eax
    10e0:	38 c2                	cmp    %al,%dl
    10e2:	74 de                	je     10c2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10e4:	8b 45 08             	mov    0x8(%ebp),%eax
    10e7:	0f b6 00             	movzbl (%eax),%eax
    10ea:	0f b6 d0             	movzbl %al,%edx
    10ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f0:	0f b6 00             	movzbl (%eax),%eax
    10f3:	0f b6 c0             	movzbl %al,%eax
    10f6:	29 c2                	sub    %eax,%edx
    10f8:	89 d0                	mov    %edx,%eax
}
    10fa:	5d                   	pop    %ebp
    10fb:	c3                   	ret    

000010fc <strlen>:

uint
strlen(char *s)
{
    10fc:	55                   	push   %ebp
    10fd:	89 e5                	mov    %esp,%ebp
    10ff:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1109:	eb 04                	jmp    110f <strlen+0x13>
    110b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    110f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1112:	8b 45 08             	mov    0x8(%ebp),%eax
    1115:	01 d0                	add    %edx,%eax
    1117:	0f b6 00             	movzbl (%eax),%eax
    111a:	84 c0                	test   %al,%al
    111c:	75 ed                	jne    110b <strlen+0xf>
    ;
  return n;
    111e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1121:	c9                   	leave  
    1122:	c3                   	ret    

00001123 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1123:	55                   	push   %ebp
    1124:	89 e5                	mov    %esp,%ebp
    1126:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1129:	8b 45 10             	mov    0x10(%ebp),%eax
    112c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1130:	8b 45 0c             	mov    0xc(%ebp),%eax
    1133:	89 44 24 04          	mov    %eax,0x4(%esp)
    1137:	8b 45 08             	mov    0x8(%ebp),%eax
    113a:	89 04 24             	mov    %eax,(%esp)
    113d:	e8 26 ff ff ff       	call   1068 <stosb>
  return dst;
    1142:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1145:	c9                   	leave  
    1146:	c3                   	ret    

00001147 <strchr>:

char*
strchr(const char *s, char c)
{
    1147:	55                   	push   %ebp
    1148:	89 e5                	mov    %esp,%ebp
    114a:	83 ec 04             	sub    $0x4,%esp
    114d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1153:	eb 14                	jmp    1169 <strchr+0x22>
    if(*s == c)
    1155:	8b 45 08             	mov    0x8(%ebp),%eax
    1158:	0f b6 00             	movzbl (%eax),%eax
    115b:	3a 45 fc             	cmp    -0x4(%ebp),%al
    115e:	75 05                	jne    1165 <strchr+0x1e>
      return (char*)s;
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	eb 13                	jmp    1178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	0f b6 00             	movzbl (%eax),%eax
    116f:	84 c0                	test   %al,%al
    1171:	75 e2                	jne    1155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1173:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1178:	c9                   	leave  
    1179:	c3                   	ret    

0000117a <gets>:

char*
gets(char *buf, int max)
{
    117a:	55                   	push   %ebp
    117b:	89 e5                	mov    %esp,%ebp
    117d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1187:	eb 4c                	jmp    11d5 <gets+0x5b>
    cc = read(0, &c, 1);
    1189:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1190:	00 
    1191:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1194:	89 44 24 04          	mov    %eax,0x4(%esp)
    1198:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    119f:	e8 44 01 00 00       	call   12e8 <read>
    11a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11ab:	7f 02                	jg     11af <gets+0x35>
      break;
    11ad:	eb 31                	jmp    11e0 <gets+0x66>
    buf[i++] = c;
    11af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b2:	8d 50 01             	lea    0x1(%eax),%edx
    11b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11b8:	89 c2                	mov    %eax,%edx
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	01 c2                	add    %eax,%edx
    11bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c9:	3c 0a                	cmp    $0xa,%al
    11cb:	74 13                	je     11e0 <gets+0x66>
    11cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d1:	3c 0d                	cmp    $0xd,%al
    11d3:	74 0b                	je     11e0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11d8:	83 c0 01             	add    $0x1,%eax
    11db:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11de:	7c a9                	jl     1189 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	01 d0                	add    %edx,%eax
    11e8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ee:	c9                   	leave  
    11ef:	c3                   	ret    

000011f0 <stat>:

int
stat(char *n, struct stat *st)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11fd:	00 
    11fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1201:	89 04 24             	mov    %eax,(%esp)
    1204:	e8 07 01 00 00       	call   1310 <open>
    1209:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    120c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1210:	79 07                	jns    1219 <stat+0x29>
    return -1;
    1212:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1217:	eb 23                	jmp    123c <stat+0x4c>
  r = fstat(fd, st);
    1219:	8b 45 0c             	mov    0xc(%ebp),%eax
    121c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1220:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1223:	89 04 24             	mov    %eax,(%esp)
    1226:	e8 fd 00 00 00       	call   1328 <fstat>
    122b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    122e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1231:	89 04 24             	mov    %eax,(%esp)
    1234:	e8 bf 00 00 00       	call   12f8 <close>
  return r;
    1239:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    123c:	c9                   	leave  
    123d:	c3                   	ret    

0000123e <atoi>:

int
atoi(const char *s)
{
    123e:	55                   	push   %ebp
    123f:	89 e5                	mov    %esp,%ebp
    1241:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1244:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    124b:	eb 25                	jmp    1272 <atoi+0x34>
    n = n*10 + *s++ - '0';
    124d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1250:	89 d0                	mov    %edx,%eax
    1252:	c1 e0 02             	shl    $0x2,%eax
    1255:	01 d0                	add    %edx,%eax
    1257:	01 c0                	add    %eax,%eax
    1259:	89 c1                	mov    %eax,%ecx
    125b:	8b 45 08             	mov    0x8(%ebp),%eax
    125e:	8d 50 01             	lea    0x1(%eax),%edx
    1261:	89 55 08             	mov    %edx,0x8(%ebp)
    1264:	0f b6 00             	movzbl (%eax),%eax
    1267:	0f be c0             	movsbl %al,%eax
    126a:	01 c8                	add    %ecx,%eax
    126c:	83 e8 30             	sub    $0x30,%eax
    126f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1272:	8b 45 08             	mov    0x8(%ebp),%eax
    1275:	0f b6 00             	movzbl (%eax),%eax
    1278:	3c 2f                	cmp    $0x2f,%al
    127a:	7e 0a                	jle    1286 <atoi+0x48>
    127c:	8b 45 08             	mov    0x8(%ebp),%eax
    127f:	0f b6 00             	movzbl (%eax),%eax
    1282:	3c 39                	cmp    $0x39,%al
    1284:	7e c7                	jle    124d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1286:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1289:	c9                   	leave  
    128a:	c3                   	ret    

0000128b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    128b:	55                   	push   %ebp
    128c:	89 e5                	mov    %esp,%ebp
    128e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1297:	8b 45 0c             	mov    0xc(%ebp),%eax
    129a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    129d:	eb 17                	jmp    12b6 <memmove+0x2b>
    *dst++ = *src++;
    129f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a2:	8d 50 01             	lea    0x1(%eax),%edx
    12a5:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12ab:	8d 4a 01             	lea    0x1(%edx),%ecx
    12ae:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12b1:	0f b6 12             	movzbl (%edx),%edx
    12b4:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12b6:	8b 45 10             	mov    0x10(%ebp),%eax
    12b9:	8d 50 ff             	lea    -0x1(%eax),%edx
    12bc:	89 55 10             	mov    %edx,0x10(%ebp)
    12bf:	85 c0                	test   %eax,%eax
    12c1:	7f dc                	jg     129f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c6:	c9                   	leave  
    12c7:	c3                   	ret    

000012c8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c8:	b8 01 00 00 00       	mov    $0x1,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <exit>:
SYSCALL(exit)
    12d0:	b8 02 00 00 00       	mov    $0x2,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <wait>:
SYSCALL(wait)
    12d8:	b8 03 00 00 00       	mov    $0x3,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <pipe>:
SYSCALL(pipe)
    12e0:	b8 04 00 00 00       	mov    $0x4,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <read>:
SYSCALL(read)
    12e8:	b8 05 00 00 00       	mov    $0x5,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <write>:
SYSCALL(write)
    12f0:	b8 10 00 00 00       	mov    $0x10,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <close>:
SYSCALL(close)
    12f8:	b8 15 00 00 00       	mov    $0x15,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <kill>:
SYSCALL(kill)
    1300:	b8 06 00 00 00       	mov    $0x6,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <exec>:
SYSCALL(exec)
    1308:	b8 07 00 00 00       	mov    $0x7,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <open>:
SYSCALL(open)
    1310:	b8 0f 00 00 00       	mov    $0xf,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <mknod>:
SYSCALL(mknod)
    1318:	b8 11 00 00 00       	mov    $0x11,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <unlink>:
SYSCALL(unlink)
    1320:	b8 12 00 00 00       	mov    $0x12,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <fstat>:
SYSCALL(fstat)
    1328:	b8 08 00 00 00       	mov    $0x8,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <link>:
SYSCALL(link)
    1330:	b8 13 00 00 00       	mov    $0x13,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <mkdir>:
SYSCALL(mkdir)
    1338:	b8 14 00 00 00       	mov    $0x14,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <chdir>:
SYSCALL(chdir)
    1340:	b8 09 00 00 00       	mov    $0x9,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <dup>:
SYSCALL(dup)
    1348:	b8 0a 00 00 00       	mov    $0xa,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <getpid>:
SYSCALL(getpid)
    1350:	b8 0b 00 00 00       	mov    $0xb,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <sbrk>:
SYSCALL(sbrk)
    1358:	b8 0c 00 00 00       	mov    $0xc,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <sleep>:
SYSCALL(sleep)
    1360:	b8 0d 00 00 00       	mov    $0xd,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <uptime>:
SYSCALL(uptime)
    1368:	b8 0e 00 00 00       	mov    $0xe,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <clone>:
SYSCALL(clone)
    1370:	b8 16 00 00 00       	mov    $0x16,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <texit>:
SYSCALL(texit)
    1378:	b8 17 00 00 00       	mov    $0x17,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <tsleep>:
SYSCALL(tsleep)
    1380:	b8 18 00 00 00       	mov    $0x18,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <twakeup>:
SYSCALL(twakeup)
    1388:	b8 19 00 00 00       	mov    $0x19,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <thread_yield>:
SYSCALL(thread_yield)
    1390:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1398:	55                   	push   %ebp
    1399:	89 e5                	mov    %esp,%ebp
    139b:	83 ec 18             	sub    $0x18,%esp
    139e:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13ab:	00 
    13ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13af:	89 44 24 04          	mov    %eax,0x4(%esp)
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	89 04 24             	mov    %eax,(%esp)
    13b9:	e8 32 ff ff ff       	call   12f0 <write>
}
    13be:	c9                   	leave  
    13bf:	c3                   	ret    

000013c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	56                   	push   %esi
    13c4:	53                   	push   %ebx
    13c5:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13cf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13d3:	74 17                	je     13ec <printint+0x2c>
    13d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d9:	79 11                	jns    13ec <printint+0x2c>
    neg = 1;
    13db:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e5:	f7 d8                	neg    %eax
    13e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13ea:	eb 06                	jmp    13f2 <printint+0x32>
  } else {
    x = xx;
    13ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13f9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13fc:	8d 41 01             	lea    0x1(%ecx),%eax
    13ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1402:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1405:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1408:	ba 00 00 00 00       	mov    $0x0,%edx
    140d:	f7 f3                	div    %ebx
    140f:	89 d0                	mov    %edx,%eax
    1411:	0f b6 80 84 1e 00 00 	movzbl 0x1e84(%eax),%eax
    1418:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    141c:	8b 75 10             	mov    0x10(%ebp),%esi
    141f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1422:	ba 00 00 00 00       	mov    $0x0,%edx
    1427:	f7 f6                	div    %esi
    1429:	89 45 ec             	mov    %eax,-0x14(%ebp)
    142c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1430:	75 c7                	jne    13f9 <printint+0x39>
  if(neg)
    1432:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1436:	74 10                	je     1448 <printint+0x88>
    buf[i++] = '-';
    1438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143b:	8d 50 01             	lea    0x1(%eax),%edx
    143e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1441:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1446:	eb 1f                	jmp    1467 <printint+0xa7>
    1448:	eb 1d                	jmp    1467 <printint+0xa7>
    putc(fd, buf[i]);
    144a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    144d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1450:	01 d0                	add    %edx,%eax
    1452:	0f b6 00             	movzbl (%eax),%eax
    1455:	0f be c0             	movsbl %al,%eax
    1458:	89 44 24 04          	mov    %eax,0x4(%esp)
    145c:	8b 45 08             	mov    0x8(%ebp),%eax
    145f:	89 04 24             	mov    %eax,(%esp)
    1462:	e8 31 ff ff ff       	call   1398 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1467:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    146b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    146f:	79 d9                	jns    144a <printint+0x8a>
    putc(fd, buf[i]);
}
    1471:	83 c4 30             	add    $0x30,%esp
    1474:	5b                   	pop    %ebx
    1475:	5e                   	pop    %esi
    1476:	5d                   	pop    %ebp
    1477:	c3                   	ret    

00001478 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1478:	55                   	push   %ebp
    1479:	89 e5                	mov    %esp,%ebp
    147b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    147e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1485:	8d 45 0c             	lea    0xc(%ebp),%eax
    1488:	83 c0 04             	add    $0x4,%eax
    148b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    148e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1495:	e9 7c 01 00 00       	jmp    1616 <printf+0x19e>
    c = fmt[i] & 0xff;
    149a:	8b 55 0c             	mov    0xc(%ebp),%edx
    149d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14a0:	01 d0                	add    %edx,%eax
    14a2:	0f b6 00             	movzbl (%eax),%eax
    14a5:	0f be c0             	movsbl %al,%eax
    14a8:	25 ff 00 00 00       	and    $0xff,%eax
    14ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b4:	75 2c                	jne    14e2 <printf+0x6a>
      if(c == '%'){
    14b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14ba:	75 0c                	jne    14c8 <printf+0x50>
        state = '%';
    14bc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14c3:	e9 4a 01 00 00       	jmp    1612 <printf+0x19a>
      } else {
        putc(fd, c);
    14c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14cb:	0f be c0             	movsbl %al,%eax
    14ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d2:	8b 45 08             	mov    0x8(%ebp),%eax
    14d5:	89 04 24             	mov    %eax,(%esp)
    14d8:	e8 bb fe ff ff       	call   1398 <putc>
    14dd:	e9 30 01 00 00       	jmp    1612 <printf+0x19a>
      }
    } else if(state == '%'){
    14e2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14e6:	0f 85 26 01 00 00    	jne    1612 <printf+0x19a>
      if(c == 'd'){
    14ec:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14f0:	75 2d                	jne    151f <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f5:	8b 00                	mov    (%eax),%eax
    14f7:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14fe:	00 
    14ff:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1506:	00 
    1507:	89 44 24 04          	mov    %eax,0x4(%esp)
    150b:	8b 45 08             	mov    0x8(%ebp),%eax
    150e:	89 04 24             	mov    %eax,(%esp)
    1511:	e8 aa fe ff ff       	call   13c0 <printint>
        ap++;
    1516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    151a:	e9 ec 00 00 00       	jmp    160b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    151f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1523:	74 06                	je     152b <printf+0xb3>
    1525:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1529:	75 2d                	jne    1558 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    152b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152e:	8b 00                	mov    (%eax),%eax
    1530:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1537:	00 
    1538:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    153f:	00 
    1540:	89 44 24 04          	mov    %eax,0x4(%esp)
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	89 04 24             	mov    %eax,(%esp)
    154a:	e8 71 fe ff ff       	call   13c0 <printint>
        ap++;
    154f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1553:	e9 b3 00 00 00       	jmp    160b <printf+0x193>
      } else if(c == 's'){
    1558:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    155c:	75 45                	jne    15a3 <printf+0x12b>
        s = (char*)*ap;
    155e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1561:	8b 00                	mov    (%eax),%eax
    1563:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1566:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    156a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    156e:	75 09                	jne    1579 <printf+0x101>
          s = "(null)";
    1570:	c7 45 f4 cd 1a 00 00 	movl   $0x1acd,-0xc(%ebp)
        while(*s != 0){
    1577:	eb 1e                	jmp    1597 <printf+0x11f>
    1579:	eb 1c                	jmp    1597 <printf+0x11f>
          putc(fd, *s);
    157b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157e:	0f b6 00             	movzbl (%eax),%eax
    1581:	0f be c0             	movsbl %al,%eax
    1584:	89 44 24 04          	mov    %eax,0x4(%esp)
    1588:	8b 45 08             	mov    0x8(%ebp),%eax
    158b:	89 04 24             	mov    %eax,(%esp)
    158e:	e8 05 fe ff ff       	call   1398 <putc>
          s++;
    1593:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1597:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159a:	0f b6 00             	movzbl (%eax),%eax
    159d:	84 c0                	test   %al,%al
    159f:	75 da                	jne    157b <printf+0x103>
    15a1:	eb 68                	jmp    160b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15a3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15a7:	75 1d                	jne    15c6 <printf+0x14e>
        putc(fd, *ap);
    15a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ac:	8b 00                	mov    (%eax),%eax
    15ae:	0f be c0             	movsbl %al,%eax
    15b1:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b5:	8b 45 08             	mov    0x8(%ebp),%eax
    15b8:	89 04 24             	mov    %eax,(%esp)
    15bb:	e8 d8 fd ff ff       	call   1398 <putc>
        ap++;
    15c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15c4:	eb 45                	jmp    160b <printf+0x193>
      } else if(c == '%'){
    15c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15ca:	75 17                	jne    15e3 <printf+0x16b>
        putc(fd, c);
    15cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15cf:	0f be c0             	movsbl %al,%eax
    15d2:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d6:	8b 45 08             	mov    0x8(%ebp),%eax
    15d9:	89 04 24             	mov    %eax,(%esp)
    15dc:	e8 b7 fd ff ff       	call   1398 <putc>
    15e1:	eb 28                	jmp    160b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15e3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15ea:	00 
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	89 04 24             	mov    %eax,(%esp)
    15f1:	e8 a2 fd ff ff       	call   1398 <putc>
        putc(fd, c);
    15f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	89 04 24             	mov    %eax,(%esp)
    1606:	e8 8d fd ff ff       	call   1398 <putc>
      }
      state = 0;
    160b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1612:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1616:	8b 55 0c             	mov    0xc(%ebp),%edx
    1619:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161c:	01 d0                	add    %edx,%eax
    161e:	0f b6 00             	movzbl (%eax),%eax
    1621:	84 c0                	test   %al,%al
    1623:	0f 85 71 fe ff ff    	jne    149a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1629:	c9                   	leave  
    162a:	c3                   	ret    
    162b:	90                   	nop

0000162c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    162c:	55                   	push   %ebp
    162d:	89 e5                	mov    %esp,%ebp
    162f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1632:	8b 45 08             	mov    0x8(%ebp),%eax
    1635:	83 e8 08             	sub    $0x8,%eax
    1638:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    163b:	a1 a4 1e 00 00       	mov    0x1ea4,%eax
    1640:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1643:	eb 24                	jmp    1669 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1645:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1648:	8b 00                	mov    (%eax),%eax
    164a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    164d:	77 12                	ja     1661 <free+0x35>
    164f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1652:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1655:	77 24                	ja     167b <free+0x4f>
    1657:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165a:	8b 00                	mov    (%eax),%eax
    165c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    165f:	77 1a                	ja     167b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1661:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1669:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    166f:	76 d4                	jbe    1645 <free+0x19>
    1671:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1674:	8b 00                	mov    (%eax),%eax
    1676:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1679:	76 ca                	jbe    1645 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    167b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167e:	8b 40 04             	mov    0x4(%eax),%eax
    1681:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1688:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168b:	01 c2                	add    %eax,%edx
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	8b 00                	mov    (%eax),%eax
    1692:	39 c2                	cmp    %eax,%edx
    1694:	75 24                	jne    16ba <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1696:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1699:	8b 50 04             	mov    0x4(%eax),%edx
    169c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169f:	8b 00                	mov    (%eax),%eax
    16a1:	8b 40 04             	mov    0x4(%eax),%eax
    16a4:	01 c2                	add    %eax,%edx
    16a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16af:	8b 00                	mov    (%eax),%eax
    16b1:	8b 10                	mov    (%eax),%edx
    16b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b6:	89 10                	mov    %edx,(%eax)
    16b8:	eb 0a                	jmp    16c4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    16ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bd:	8b 10                	mov    (%eax),%edx
    16bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	8b 40 04             	mov    0x4(%eax),%eax
    16ca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	01 d0                	add    %edx,%eax
    16d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16d9:	75 20                	jne    16fb <free+0xcf>
    p->s.size += bp->s.size;
    16db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16de:	8b 50 04             	mov    0x4(%eax),%edx
    16e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e4:	8b 40 04             	mov    0x4(%eax),%eax
    16e7:	01 c2                	add    %eax,%edx
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f2:	8b 10                	mov    (%eax),%edx
    16f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f7:	89 10                	mov    %edx,(%eax)
    16f9:	eb 08                	jmp    1703 <free+0xd7>
  } else
    p->s.ptr = bp;
    16fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1701:	89 10                	mov    %edx,(%eax)
  freep = p;
    1703:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1706:	a3 a4 1e 00 00       	mov    %eax,0x1ea4
}
    170b:	c9                   	leave  
    170c:	c3                   	ret    

0000170d <morecore>:

static Header*
morecore(uint nu)
{
    170d:	55                   	push   %ebp
    170e:	89 e5                	mov    %esp,%ebp
    1710:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1713:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    171a:	77 07                	ja     1723 <morecore+0x16>
    nu = 4096;
    171c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1723:	8b 45 08             	mov    0x8(%ebp),%eax
    1726:	c1 e0 03             	shl    $0x3,%eax
    1729:	89 04 24             	mov    %eax,(%esp)
    172c:	e8 27 fc ff ff       	call   1358 <sbrk>
    1731:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1734:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1738:	75 07                	jne    1741 <morecore+0x34>
    return 0;
    173a:	b8 00 00 00 00       	mov    $0x0,%eax
    173f:	eb 22                	jmp    1763 <morecore+0x56>
  hp = (Header*)p;
    1741:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1747:	8b 45 f0             	mov    -0x10(%ebp),%eax
    174a:	8b 55 08             	mov    0x8(%ebp),%edx
    174d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1750:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1753:	83 c0 08             	add    $0x8,%eax
    1756:	89 04 24             	mov    %eax,(%esp)
    1759:	e8 ce fe ff ff       	call   162c <free>
  return freep;
    175e:	a1 a4 1e 00 00       	mov    0x1ea4,%eax
}
    1763:	c9                   	leave  
    1764:	c3                   	ret    

00001765 <malloc>:

void*
malloc(uint nbytes)
{
    1765:	55                   	push   %ebp
    1766:	89 e5                	mov    %esp,%ebp
    1768:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    176b:	8b 45 08             	mov    0x8(%ebp),%eax
    176e:	83 c0 07             	add    $0x7,%eax
    1771:	c1 e8 03             	shr    $0x3,%eax
    1774:	83 c0 01             	add    $0x1,%eax
    1777:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    177a:	a1 a4 1e 00 00       	mov    0x1ea4,%eax
    177f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1782:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1786:	75 23                	jne    17ab <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1788:	c7 45 f0 9c 1e 00 00 	movl   $0x1e9c,-0x10(%ebp)
    178f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1792:	a3 a4 1e 00 00       	mov    %eax,0x1ea4
    1797:	a1 a4 1e 00 00       	mov    0x1ea4,%eax
    179c:	a3 9c 1e 00 00       	mov    %eax,0x1e9c
    base.s.size = 0;
    17a1:	c7 05 a0 1e 00 00 00 	movl   $0x0,0x1ea0
    17a8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ae:	8b 00                	mov    (%eax),%eax
    17b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b6:	8b 40 04             	mov    0x4(%eax),%eax
    17b9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17bc:	72 4d                	jb     180b <malloc+0xa6>
      if(p->s.size == nunits)
    17be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c1:	8b 40 04             	mov    0x4(%eax),%eax
    17c4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17c7:	75 0c                	jne    17d5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	8b 10                	mov    (%eax),%edx
    17ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d1:	89 10                	mov    %edx,(%eax)
    17d3:	eb 26                	jmp    17fb <malloc+0x96>
      else {
        p->s.size -= nunits;
    17d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d8:	8b 40 04             	mov    0x4(%eax),%eax
    17db:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17de:	89 c2                	mov    %eax,%edx
    17e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e9:	8b 40 04             	mov    0x4(%eax),%eax
    17ec:	c1 e0 03             	shl    $0x3,%eax
    17ef:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17f8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fe:	a3 a4 1e 00 00       	mov    %eax,0x1ea4
      return (void*)(p + 1);
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	83 c0 08             	add    $0x8,%eax
    1809:	eb 38                	jmp    1843 <malloc+0xde>
    }
    if(p == freep)
    180b:	a1 a4 1e 00 00       	mov    0x1ea4,%eax
    1810:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1813:	75 1b                	jne    1830 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1815:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1818:	89 04 24             	mov    %eax,(%esp)
    181b:	e8 ed fe ff ff       	call   170d <morecore>
    1820:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1823:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1827:	75 07                	jne    1830 <malloc+0xcb>
        return 0;
    1829:	b8 00 00 00 00       	mov    $0x0,%eax
    182e:	eb 13                	jmp    1843 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1833:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1839:	8b 00                	mov    (%eax),%eax
    183b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    183e:	e9 70 ff ff ff       	jmp    17b3 <malloc+0x4e>
}
    1843:	c9                   	leave  
    1844:	c3                   	ret    
    1845:	66 90                	xchg   %ax,%ax
    1847:	90                   	nop

00001848 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1848:	55                   	push   %ebp
    1849:	89 e5                	mov    %esp,%ebp
    184b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    184e:	8b 55 08             	mov    0x8(%ebp),%edx
    1851:	8b 45 0c             	mov    0xc(%ebp),%eax
    1854:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1857:	f0 87 02             	lock xchg %eax,(%edx)
    185a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    185d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1860:	c9                   	leave  
    1861:	c3                   	ret    

00001862 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1862:	55                   	push   %ebp
    1863:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1865:	8b 45 08             	mov    0x8(%ebp),%eax
    1868:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    186e:	5d                   	pop    %ebp
    186f:	c3                   	ret    

00001870 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1876:	90                   	nop
    1877:	8b 45 08             	mov    0x8(%ebp),%eax
    187a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1881:	00 
    1882:	89 04 24             	mov    %eax,(%esp)
    1885:	e8 be ff ff ff       	call   1848 <xchg>
    188a:	85 c0                	test   %eax,%eax
    188c:	75 e9                	jne    1877 <lock_acquire+0x7>
}
    188e:	c9                   	leave  
    188f:	c3                   	ret    

00001890 <lock_release>:
void lock_release(lock_t *lock){
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1896:	8b 45 08             	mov    0x8(%ebp),%eax
    1899:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18a0:	00 
    18a1:	89 04 24             	mov    %eax,(%esp)
    18a4:	e8 9f ff ff ff       	call   1848 <xchg>
}
    18a9:	c9                   	leave  
    18aa:	c3                   	ret    

000018ab <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    18ab:	55                   	push   %ebp
    18ac:	89 e5                	mov    %esp,%ebp
    18ae:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    18b1:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18b8:	e8 a8 fe ff ff       	call   1765 <malloc>
    18bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c9:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ce:	85 c0                	test   %eax,%eax
    18d0:	74 14                	je     18e6 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d5:	25 ff 0f 00 00       	and    $0xfff,%eax
    18da:	89 c2                	mov    %eax,%edx
    18dc:	b8 00 10 00 00       	mov    $0x1000,%eax
    18e1:	29 d0                	sub    %edx,%eax
    18e3:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18ea:	75 1b                	jne    1907 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18ec:	c7 44 24 04 d4 1a 00 	movl   $0x1ad4,0x4(%esp)
    18f3:	00 
    18f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fb:	e8 78 fb ff ff       	call   1478 <printf>
        return 0;
    1900:	b8 00 00 00 00       	mov    $0x0,%eax
    1905:	eb 6f                	jmp    1976 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1907:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    190a:	8b 55 08             	mov    0x8(%ebp),%edx
    190d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1910:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1914:	89 54 24 08          	mov    %edx,0x8(%esp)
    1918:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    191f:	00 
    1920:	89 04 24             	mov    %eax,(%esp)
    1923:	e8 48 fa ff ff       	call   1370 <clone>
    1928:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    192b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    192f:	79 1b                	jns    194c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1931:	c7 44 24 04 e2 1a 00 	movl   $0x1ae2,0x4(%esp)
    1938:	00 
    1939:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1940:	e8 33 fb ff ff       	call   1478 <printf>
        return 0;
    1945:	b8 00 00 00 00       	mov    $0x0,%eax
    194a:	eb 2a                	jmp    1976 <thread_create+0xcb>
    }
    if(tid > 0){
    194c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1950:	7e 05                	jle    1957 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1952:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1955:	eb 1f                	jmp    1976 <thread_create+0xcb>
    }
    if(tid == 0){
    1957:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    195b:	75 14                	jne    1971 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    195d:	c7 44 24 04 ef 1a 00 	movl   $0x1aef,0x4(%esp)
    1964:	00 
    1965:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    196c:	e8 07 fb ff ff       	call   1478 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1971:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1976:	c9                   	leave  
    1977:	c3                   	ret    

00001978 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1978:	55                   	push   %ebp
    1979:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    197b:	a1 98 1e 00 00       	mov    0x1e98,%eax
    1980:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1986:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    198b:	a3 98 1e 00 00       	mov    %eax,0x1e98
    return (int)(rands % max);
    1990:	a1 98 1e 00 00       	mov    0x1e98,%eax
    1995:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1998:	ba 00 00 00 00       	mov    $0x0,%edx
    199d:	f7 f1                	div    %ecx
    199f:	89 d0                	mov    %edx,%eax
}
    19a1:	5d                   	pop    %ebp
    19a2:	c3                   	ret    
    19a3:	90                   	nop

000019a4 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    19a4:	55                   	push   %ebp
    19a5:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    19b0:	8b 45 08             	mov    0x8(%ebp),%eax
    19b3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19ba:	8b 45 08             	mov    0x8(%ebp),%eax
    19bd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19c4:	5d                   	pop    %ebp
    19c5:	c3                   	ret    

000019c6 <add_q>:

void add_q(struct queue *q, int v){
    19c6:	55                   	push   %ebp
    19c7:	89 e5                	mov    %esp,%ebp
    19c9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19cc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19d3:	e8 8d fd ff ff       	call   1765 <malloc>
    19d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19de:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19eb:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19ed:	8b 45 08             	mov    0x8(%ebp),%eax
    19f0:	8b 40 04             	mov    0x4(%eax),%eax
    19f3:	85 c0                	test   %eax,%eax
    19f5:	75 0b                	jne    1a02 <add_q+0x3c>
        q->head = n;
    19f7:	8b 45 08             	mov    0x8(%ebp),%eax
    19fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19fd:	89 50 04             	mov    %edx,0x4(%eax)
    1a00:	eb 0c                	jmp    1a0e <add_q+0x48>
    }else{
        q->tail->next = n;
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	8b 40 08             	mov    0x8(%eax),%eax
    1a08:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a11:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a14:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a17:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1a:	8b 00                	mov    (%eax),%eax
    1a1c:	8d 50 01             	lea    0x1(%eax),%edx
    1a1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a22:	89 10                	mov    %edx,(%eax)
}
    1a24:	c9                   	leave  
    1a25:	c3                   	ret    

00001a26 <empty_q>:

int empty_q(struct queue *q){
    1a26:	55                   	push   %ebp
    1a27:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a29:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2c:	8b 00                	mov    (%eax),%eax
    1a2e:	85 c0                	test   %eax,%eax
    1a30:	75 07                	jne    1a39 <empty_q+0x13>
        return 1;
    1a32:	b8 01 00 00 00       	mov    $0x1,%eax
    1a37:	eb 05                	jmp    1a3e <empty_q+0x18>
    else
        return 0;
    1a39:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a3e:	5d                   	pop    %ebp
    1a3f:	c3                   	ret    

00001a40 <pop_q>:
int pop_q(struct queue *q){
    1a40:	55                   	push   %ebp
    1a41:	89 e5                	mov    %esp,%ebp
    1a43:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a46:	8b 45 08             	mov    0x8(%ebp),%eax
    1a49:	89 04 24             	mov    %eax,(%esp)
    1a4c:	e8 d5 ff ff ff       	call   1a26 <empty_q>
    1a51:	85 c0                	test   %eax,%eax
    1a53:	75 5d                	jne    1ab2 <pop_q+0x72>
       val = q->head->value; 
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	8b 40 04             	mov    0x4(%eax),%eax
    1a5b:	8b 00                	mov    (%eax),%eax
    1a5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a60:	8b 45 08             	mov    0x8(%ebp),%eax
    1a63:	8b 40 04             	mov    0x4(%eax),%eax
    1a66:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8b 40 04             	mov    0x4(%eax),%eax
    1a6f:	8b 50 04             	mov    0x4(%eax),%edx
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a78:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7b:	89 04 24             	mov    %eax,(%esp)
    1a7e:	e8 a9 fb ff ff       	call   162c <free>
       q->size--;
    1a83:	8b 45 08             	mov    0x8(%ebp),%eax
    1a86:	8b 00                	mov    (%eax),%eax
    1a88:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a90:	8b 45 08             	mov    0x8(%ebp),%eax
    1a93:	8b 00                	mov    (%eax),%eax
    1a95:	85 c0                	test   %eax,%eax
    1a97:	75 14                	jne    1aad <pop_q+0x6d>
            q->head = 0;
    1a99:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab0:	eb 05                	jmp    1ab7 <pop_q+0x77>
    }
    return -1;
    1ab2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ab7:	c9                   	leave  
    1ab8:	c3                   	ret    
