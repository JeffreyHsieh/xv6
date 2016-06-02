
_mkdir:     file format elf32-i386


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

  if(argc < 2){
    1009:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    100d:	7f 19                	jg     1028 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
    100f:	c7 44 24 04 cd 1a 00 	movl   $0x1acd,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 75 04 00 00       	call   1498 <printf>
    exit();
    1023:	e8 d0 02 00 00       	call   12f8 <exit>
  }

  for(i = 1; i < argc; i++){
    1028:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    102f:	00 
    1030:	eb 4f                	jmp    1081 <main+0x81>
    if(mkdir(argv[i]) < 0){
    1032:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1036:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    103d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1040:	01 d0                	add    %edx,%eax
    1042:	8b 00                	mov    (%eax),%eax
    1044:	89 04 24             	mov    %eax,(%esp)
    1047:	e8 14 03 00 00       	call   1360 <mkdir>
    104c:	85 c0                	test   %eax,%eax
    104e:	79 2c                	jns    107c <main+0x7c>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
    1050:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1054:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    105b:	8b 45 0c             	mov    0xc(%ebp),%eax
    105e:	01 d0                	add    %edx,%eax
    1060:	8b 00                	mov    (%eax),%eax
    1062:	89 44 24 08          	mov    %eax,0x8(%esp)
    1066:	c7 44 24 04 e4 1a 00 	movl   $0x1ae4,0x4(%esp)
    106d:	00 
    106e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1075:	e8 1e 04 00 00       	call   1498 <printf>
      break;
    107a:	eb 0e                	jmp    108a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    107c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1081:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1085:	3b 45 08             	cmp    0x8(%ebp),%eax
    1088:	7c a8                	jl     1032 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
    108a:	e8 69 02 00 00       	call   12f8 <exit>
    108f:	90                   	nop

00001090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	57                   	push   %edi
    1094:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1095:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1098:	8b 55 10             	mov    0x10(%ebp),%edx
    109b:	8b 45 0c             	mov    0xc(%ebp),%eax
    109e:	89 cb                	mov    %ecx,%ebx
    10a0:	89 df                	mov    %ebx,%edi
    10a2:	89 d1                	mov    %edx,%ecx
    10a4:	fc                   	cld    
    10a5:	f3 aa                	rep stos %al,%es:(%edi)
    10a7:	89 ca                	mov    %ecx,%edx
    10a9:	89 fb                	mov    %edi,%ebx
    10ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10b1:	5b                   	pop    %ebx
    10b2:	5f                   	pop    %edi
    10b3:	5d                   	pop    %ebp
    10b4:	c3                   	ret    

000010b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10b5:	55                   	push   %ebp
    10b6:	89 e5                	mov    %esp,%ebp
    10b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10bb:	8b 45 08             	mov    0x8(%ebp),%eax
    10be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10c1:	90                   	nop
    10c2:	8b 45 08             	mov    0x8(%ebp),%eax
    10c5:	8d 50 01             	lea    0x1(%eax),%edx
    10c8:	89 55 08             	mov    %edx,0x8(%ebp)
    10cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ce:	8d 4a 01             	lea    0x1(%edx),%ecx
    10d1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10d4:	0f b6 12             	movzbl (%edx),%edx
    10d7:	88 10                	mov    %dl,(%eax)
    10d9:	0f b6 00             	movzbl (%eax),%eax
    10dc:	84 c0                	test   %al,%al
    10de:	75 e2                	jne    10c2 <strcpy+0xd>
    ;
  return os;
    10e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10e3:	c9                   	leave  
    10e4:	c3                   	ret    

000010e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10e5:	55                   	push   %ebp
    10e6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10e8:	eb 08                	jmp    10f2 <strcmp+0xd>
    p++, q++;
    10ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	0f b6 00             	movzbl (%eax),%eax
    10f8:	84 c0                	test   %al,%al
    10fa:	74 10                	je     110c <strcmp+0x27>
    10fc:	8b 45 08             	mov    0x8(%ebp),%eax
    10ff:	0f b6 10             	movzbl (%eax),%edx
    1102:	8b 45 0c             	mov    0xc(%ebp),%eax
    1105:	0f b6 00             	movzbl (%eax),%eax
    1108:	38 c2                	cmp    %al,%dl
    110a:	74 de                	je     10ea <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    110c:	8b 45 08             	mov    0x8(%ebp),%eax
    110f:	0f b6 00             	movzbl (%eax),%eax
    1112:	0f b6 d0             	movzbl %al,%edx
    1115:	8b 45 0c             	mov    0xc(%ebp),%eax
    1118:	0f b6 00             	movzbl (%eax),%eax
    111b:	0f b6 c0             	movzbl %al,%eax
    111e:	29 c2                	sub    %eax,%edx
    1120:	89 d0                	mov    %edx,%eax
}
    1122:	5d                   	pop    %ebp
    1123:	c3                   	ret    

00001124 <strlen>:

uint
strlen(char *s)
{
    1124:	55                   	push   %ebp
    1125:	89 e5                	mov    %esp,%ebp
    1127:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    112a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1131:	eb 04                	jmp    1137 <strlen+0x13>
    1133:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1137:	8b 55 fc             	mov    -0x4(%ebp),%edx
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
    113d:	01 d0                	add    %edx,%eax
    113f:	0f b6 00             	movzbl (%eax),%eax
    1142:	84 c0                	test   %al,%al
    1144:	75 ed                	jne    1133 <strlen+0xf>
    ;
  return n;
    1146:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1149:	c9                   	leave  
    114a:	c3                   	ret    

0000114b <memset>:

void*
memset(void *dst, int c, uint n)
{
    114b:	55                   	push   %ebp
    114c:	89 e5                	mov    %esp,%ebp
    114e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1151:	8b 45 10             	mov    0x10(%ebp),%eax
    1154:	89 44 24 08          	mov    %eax,0x8(%esp)
    1158:	8b 45 0c             	mov    0xc(%ebp),%eax
    115b:	89 44 24 04          	mov    %eax,0x4(%esp)
    115f:	8b 45 08             	mov    0x8(%ebp),%eax
    1162:	89 04 24             	mov    %eax,(%esp)
    1165:	e8 26 ff ff ff       	call   1090 <stosb>
  return dst;
    116a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    116d:	c9                   	leave  
    116e:	c3                   	ret    

0000116f <strchr>:

char*
strchr(const char *s, char c)
{
    116f:	55                   	push   %ebp
    1170:	89 e5                	mov    %esp,%ebp
    1172:	83 ec 04             	sub    $0x4,%esp
    1175:	8b 45 0c             	mov    0xc(%ebp),%eax
    1178:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    117b:	eb 14                	jmp    1191 <strchr+0x22>
    if(*s == c)
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1186:	75 05                	jne    118d <strchr+0x1e>
      return (char*)s;
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	eb 13                	jmp    11a0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    118d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1191:	8b 45 08             	mov    0x8(%ebp),%eax
    1194:	0f b6 00             	movzbl (%eax),%eax
    1197:	84 c0                	test   %al,%al
    1199:	75 e2                	jne    117d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    119b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11a0:	c9                   	leave  
    11a1:	c3                   	ret    

000011a2 <gets>:

char*
gets(char *buf, int max)
{
    11a2:	55                   	push   %ebp
    11a3:	89 e5                	mov    %esp,%ebp
    11a5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11af:	eb 4c                	jmp    11fd <gets+0x5b>
    cc = read(0, &c, 1);
    11b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11b8:	00 
    11b9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    11c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11c7:	e8 44 01 00 00       	call   1310 <read>
    11cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11d3:	7f 02                	jg     11d7 <gets+0x35>
      break;
    11d5:	eb 31                	jmp    1208 <gets+0x66>
    buf[i++] = c;
    11d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11da:	8d 50 01             	lea    0x1(%eax),%edx
    11dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11e0:	89 c2                	mov    %eax,%edx
    11e2:	8b 45 08             	mov    0x8(%ebp),%eax
    11e5:	01 c2                	add    %eax,%edx
    11e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f1:	3c 0a                	cmp    $0xa,%al
    11f3:	74 13                	je     1208 <gets+0x66>
    11f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f9:	3c 0d                	cmp    $0xd,%al
    11fb:	74 0b                	je     1208 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1200:	83 c0 01             	add    $0x1,%eax
    1203:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1206:	7c a9                	jl     11b1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1208:	8b 55 f4             	mov    -0xc(%ebp),%edx
    120b:	8b 45 08             	mov    0x8(%ebp),%eax
    120e:	01 d0                	add    %edx,%eax
    1210:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1216:	c9                   	leave  
    1217:	c3                   	ret    

00001218 <stat>:

int
stat(char *n, struct stat *st)
{
    1218:	55                   	push   %ebp
    1219:	89 e5                	mov    %esp,%ebp
    121b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    121e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1225:	00 
    1226:	8b 45 08             	mov    0x8(%ebp),%eax
    1229:	89 04 24             	mov    %eax,(%esp)
    122c:	e8 07 01 00 00       	call   1338 <open>
    1231:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1234:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1238:	79 07                	jns    1241 <stat+0x29>
    return -1;
    123a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    123f:	eb 23                	jmp    1264 <stat+0x4c>
  r = fstat(fd, st);
    1241:	8b 45 0c             	mov    0xc(%ebp),%eax
    1244:	89 44 24 04          	mov    %eax,0x4(%esp)
    1248:	8b 45 f4             	mov    -0xc(%ebp),%eax
    124b:	89 04 24             	mov    %eax,(%esp)
    124e:	e8 fd 00 00 00       	call   1350 <fstat>
    1253:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1256:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1259:	89 04 24             	mov    %eax,(%esp)
    125c:	e8 bf 00 00 00       	call   1320 <close>
  return r;
    1261:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1264:	c9                   	leave  
    1265:	c3                   	ret    

00001266 <atoi>:

int
atoi(const char *s)
{
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    126c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1273:	eb 25                	jmp    129a <atoi+0x34>
    n = n*10 + *s++ - '0';
    1275:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1278:	89 d0                	mov    %edx,%eax
    127a:	c1 e0 02             	shl    $0x2,%eax
    127d:	01 d0                	add    %edx,%eax
    127f:	01 c0                	add    %eax,%eax
    1281:	89 c1                	mov    %eax,%ecx
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
    1286:	8d 50 01             	lea    0x1(%eax),%edx
    1289:	89 55 08             	mov    %edx,0x8(%ebp)
    128c:	0f b6 00             	movzbl (%eax),%eax
    128f:	0f be c0             	movsbl %al,%eax
    1292:	01 c8                	add    %ecx,%eax
    1294:	83 e8 30             	sub    $0x30,%eax
    1297:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    129a:	8b 45 08             	mov    0x8(%ebp),%eax
    129d:	0f b6 00             	movzbl (%eax),%eax
    12a0:	3c 2f                	cmp    $0x2f,%al
    12a2:	7e 0a                	jle    12ae <atoi+0x48>
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	0f b6 00             	movzbl (%eax),%eax
    12aa:	3c 39                	cmp    $0x39,%al
    12ac:	7e c7                	jle    1275 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12b1:	c9                   	leave  
    12b2:	c3                   	ret    

000012b3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12b3:	55                   	push   %ebp
    12b4:	89 e5                	mov    %esp,%ebp
    12b6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12b9:	8b 45 08             	mov    0x8(%ebp),%eax
    12bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12c5:	eb 17                	jmp    12de <memmove+0x2b>
    *dst++ = *src++;
    12c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ca:	8d 50 01             	lea    0x1(%eax),%edx
    12cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12d3:	8d 4a 01             	lea    0x1(%edx),%ecx
    12d6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12d9:	0f b6 12             	movzbl (%edx),%edx
    12dc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12de:	8b 45 10             	mov    0x10(%ebp),%eax
    12e1:	8d 50 ff             	lea    -0x1(%eax),%edx
    12e4:	89 55 10             	mov    %edx,0x10(%ebp)
    12e7:	85 c0                	test   %eax,%eax
    12e9:	7f dc                	jg     12c7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ee:	c9                   	leave  
    12ef:	c3                   	ret    

000012f0 <fork>:
    12f0:	b8 01 00 00 00       	mov    $0x1,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <exit>:
    12f8:	b8 02 00 00 00       	mov    $0x2,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <wait>:
    1300:	b8 03 00 00 00       	mov    $0x3,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <pipe>:
    1308:	b8 04 00 00 00       	mov    $0x4,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <read>:
    1310:	b8 05 00 00 00       	mov    $0x5,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <write>:
    1318:	b8 10 00 00 00       	mov    $0x10,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <close>:
    1320:	b8 15 00 00 00       	mov    $0x15,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <kill>:
    1328:	b8 06 00 00 00       	mov    $0x6,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <exec>:
    1330:	b8 07 00 00 00       	mov    $0x7,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <open>:
    1338:	b8 0f 00 00 00       	mov    $0xf,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <mknod>:
    1340:	b8 11 00 00 00       	mov    $0x11,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <unlink>:
    1348:	b8 12 00 00 00       	mov    $0x12,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <fstat>:
    1350:	b8 08 00 00 00       	mov    $0x8,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <link>:
    1358:	b8 13 00 00 00       	mov    $0x13,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <mkdir>:
    1360:	b8 14 00 00 00       	mov    $0x14,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <chdir>:
    1368:	b8 09 00 00 00       	mov    $0x9,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <dup>:
    1370:	b8 0a 00 00 00       	mov    $0xa,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <getpid>:
    1378:	b8 0b 00 00 00       	mov    $0xb,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <sbrk>:
    1380:	b8 0c 00 00 00       	mov    $0xc,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <sleep>:
    1388:	b8 0d 00 00 00       	mov    $0xd,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <uptime>:
    1390:	b8 0e 00 00 00       	mov    $0xe,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <clone>:
    1398:	b8 16 00 00 00       	mov    $0x16,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <texit>:
    13a0:	b8 17 00 00 00       	mov    $0x17,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <tsleep>:
    13a8:	b8 18 00 00 00       	mov    $0x18,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <twakeup>:
    13b0:	b8 19 00 00 00       	mov    $0x19,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13b8:	55                   	push   %ebp
    13b9:	89 e5                	mov    %esp,%ebp
    13bb:	83 ec 18             	sub    $0x18,%esp
    13be:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13cb:	00 
    13cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	89 04 24             	mov    %eax,(%esp)
    13d9:	e8 3a ff ff ff       	call   1318 <write>
}
    13de:	c9                   	leave  
    13df:	c3                   	ret    

000013e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	56                   	push   %esi
    13e4:	53                   	push   %ebx
    13e5:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13ef:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13f3:	74 17                	je     140c <printint+0x2c>
    13f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f9:	79 11                	jns    140c <printint+0x2c>
    neg = 1;
    13fb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1402:	8b 45 0c             	mov    0xc(%ebp),%eax
    1405:	f7 d8                	neg    %eax
    1407:	89 45 ec             	mov    %eax,-0x14(%ebp)
    140a:	eb 06                	jmp    1412 <printint+0x32>
  } else {
    x = xx;
    140c:	8b 45 0c             	mov    0xc(%ebp),%eax
    140f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1412:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1419:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    141c:	8d 41 01             	lea    0x1(%ecx),%eax
    141f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1422:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1425:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1428:	ba 00 00 00 00       	mov    $0x0,%edx
    142d:	f7 f3                	div    %ebx
    142f:	89 d0                	mov    %edx,%eax
    1431:	0f b6 80 58 1e 00 00 	movzbl 0x1e58(%eax),%eax
    1438:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    143c:	8b 75 10             	mov    0x10(%ebp),%esi
    143f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1442:	ba 00 00 00 00       	mov    $0x0,%edx
    1447:	f7 f6                	div    %esi
    1449:	89 45 ec             	mov    %eax,-0x14(%ebp)
    144c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1450:	75 c7                	jne    1419 <printint+0x39>
  if(neg)
    1452:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1456:	74 10                	je     1468 <printint+0x88>
    buf[i++] = '-';
    1458:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145b:	8d 50 01             	lea    0x1(%eax),%edx
    145e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1461:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1466:	eb 1f                	jmp    1487 <printint+0xa7>
    1468:	eb 1d                	jmp    1487 <printint+0xa7>
    putc(fd, buf[i]);
    146a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	01 d0                	add    %edx,%eax
    1472:	0f b6 00             	movzbl (%eax),%eax
    1475:	0f be c0             	movsbl %al,%eax
    1478:	89 44 24 04          	mov    %eax,0x4(%esp)
    147c:	8b 45 08             	mov    0x8(%ebp),%eax
    147f:	89 04 24             	mov    %eax,(%esp)
    1482:	e8 31 ff ff ff       	call   13b8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1487:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    148b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    148f:	79 d9                	jns    146a <printint+0x8a>
    putc(fd, buf[i]);
}
    1491:	83 c4 30             	add    $0x30,%esp
    1494:	5b                   	pop    %ebx
    1495:	5e                   	pop    %esi
    1496:	5d                   	pop    %ebp
    1497:	c3                   	ret    

00001498 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1498:	55                   	push   %ebp
    1499:	89 e5                	mov    %esp,%ebp
    149b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    149e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14a5:	8d 45 0c             	lea    0xc(%ebp),%eax
    14a8:	83 c0 04             	add    $0x4,%eax
    14ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b5:	e9 7c 01 00 00       	jmp    1636 <printf+0x19e>
    c = fmt[i] & 0xff;
    14ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    14bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c0:	01 d0                	add    %edx,%eax
    14c2:	0f b6 00             	movzbl (%eax),%eax
    14c5:	0f be c0             	movsbl %al,%eax
    14c8:	25 ff 00 00 00       	and    $0xff,%eax
    14cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14d4:	75 2c                	jne    1502 <printf+0x6a>
      if(c == '%'){
    14d6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14da:	75 0c                	jne    14e8 <printf+0x50>
        state = '%';
    14dc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14e3:	e9 4a 01 00 00       	jmp    1632 <printf+0x19a>
      } else {
        putc(fd, c);
    14e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14eb:	0f be c0             	movsbl %al,%eax
    14ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f2:	8b 45 08             	mov    0x8(%ebp),%eax
    14f5:	89 04 24             	mov    %eax,(%esp)
    14f8:	e8 bb fe ff ff       	call   13b8 <putc>
    14fd:	e9 30 01 00 00       	jmp    1632 <printf+0x19a>
      }
    } else if(state == '%'){
    1502:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1506:	0f 85 26 01 00 00    	jne    1632 <printf+0x19a>
      if(c == 'd'){
    150c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1510:	75 2d                	jne    153f <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1512:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1515:	8b 00                	mov    (%eax),%eax
    1517:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    151e:	00 
    151f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1526:	00 
    1527:	89 44 24 04          	mov    %eax,0x4(%esp)
    152b:	8b 45 08             	mov    0x8(%ebp),%eax
    152e:	89 04 24             	mov    %eax,(%esp)
    1531:	e8 aa fe ff ff       	call   13e0 <printint>
        ap++;
    1536:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    153a:	e9 ec 00 00 00       	jmp    162b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    153f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1543:	74 06                	je     154b <printf+0xb3>
    1545:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1549:	75 2d                	jne    1578 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    154b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154e:	8b 00                	mov    (%eax),%eax
    1550:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1557:	00 
    1558:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    155f:	00 
    1560:	89 44 24 04          	mov    %eax,0x4(%esp)
    1564:	8b 45 08             	mov    0x8(%ebp),%eax
    1567:	89 04 24             	mov    %eax,(%esp)
    156a:	e8 71 fe ff ff       	call   13e0 <printint>
        ap++;
    156f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1573:	e9 b3 00 00 00       	jmp    162b <printf+0x193>
      } else if(c == 's'){
    1578:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    157c:	75 45                	jne    15c3 <printf+0x12b>
        s = (char*)*ap;
    157e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1581:	8b 00                	mov    (%eax),%eax
    1583:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    158a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    158e:	75 09                	jne    1599 <printf+0x101>
          s = "(null)";
    1590:	c7 45 f4 00 1b 00 00 	movl   $0x1b00,-0xc(%ebp)
        while(*s != 0){
    1597:	eb 1e                	jmp    15b7 <printf+0x11f>
    1599:	eb 1c                	jmp    15b7 <printf+0x11f>
          putc(fd, *s);
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	0f b6 00             	movzbl (%eax),%eax
    15a1:	0f be c0             	movsbl %al,%eax
    15a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	89 04 24             	mov    %eax,(%esp)
    15ae:	e8 05 fe ff ff       	call   13b8 <putc>
          s++;
    15b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	0f b6 00             	movzbl (%eax),%eax
    15bd:	84 c0                	test   %al,%al
    15bf:	75 da                	jne    159b <printf+0x103>
    15c1:	eb 68                	jmp    162b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15c7:	75 1d                	jne    15e6 <printf+0x14e>
        putc(fd, *ap);
    15c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15cc:	8b 00                	mov    (%eax),%eax
    15ce:	0f be c0             	movsbl %al,%eax
    15d1:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d5:	8b 45 08             	mov    0x8(%ebp),%eax
    15d8:	89 04 24             	mov    %eax,(%esp)
    15db:	e8 d8 fd ff ff       	call   13b8 <putc>
        ap++;
    15e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15e4:	eb 45                	jmp    162b <printf+0x193>
      } else if(c == '%'){
    15e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15ea:	75 17                	jne    1603 <printf+0x16b>
        putc(fd, c);
    15ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ef:	0f be c0             	movsbl %al,%eax
    15f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f6:	8b 45 08             	mov    0x8(%ebp),%eax
    15f9:	89 04 24             	mov    %eax,(%esp)
    15fc:	e8 b7 fd ff ff       	call   13b8 <putc>
    1601:	eb 28                	jmp    162b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1603:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    160a:	00 
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	89 04 24             	mov    %eax,(%esp)
    1611:	e8 a2 fd ff ff       	call   13b8 <putc>
        putc(fd, c);
    1616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1619:	0f be c0             	movsbl %al,%eax
    161c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1620:	8b 45 08             	mov    0x8(%ebp),%eax
    1623:	89 04 24             	mov    %eax,(%esp)
    1626:	e8 8d fd ff ff       	call   13b8 <putc>
      }
      state = 0;
    162b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1632:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1636:	8b 55 0c             	mov    0xc(%ebp),%edx
    1639:	8b 45 f0             	mov    -0x10(%ebp),%eax
    163c:	01 d0                	add    %edx,%eax
    163e:	0f b6 00             	movzbl (%eax),%eax
    1641:	84 c0                	test   %al,%al
    1643:	0f 85 71 fe ff ff    	jne    14ba <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1649:	c9                   	leave  
    164a:	c3                   	ret    
    164b:	90                   	nop

0000164c <free>:
    164c:	55                   	push   %ebp
    164d:	89 e5                	mov    %esp,%ebp
    164f:	83 ec 10             	sub    $0x10,%esp
    1652:	8b 45 08             	mov    0x8(%ebp),%eax
    1655:	83 e8 08             	sub    $0x8,%eax
    1658:	89 45 f8             	mov    %eax,-0x8(%ebp)
    165b:	a1 78 1e 00 00       	mov    0x1e78,%eax
    1660:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1663:	eb 24                	jmp    1689 <free+0x3d>
    1665:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1668:	8b 00                	mov    (%eax),%eax
    166a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    166d:	77 12                	ja     1681 <free+0x35>
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1675:	77 24                	ja     169b <free+0x4f>
    1677:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167a:	8b 00                	mov    (%eax),%eax
    167c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    167f:	77 1a                	ja     169b <free+0x4f>
    1681:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1684:	8b 00                	mov    (%eax),%eax
    1686:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1689:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    168f:	76 d4                	jbe    1665 <free+0x19>
    1691:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1699:	76 ca                	jbe    1665 <free+0x19>
    169b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169e:	8b 40 04             	mov    0x4(%eax),%eax
    16a1:	c1 e0 03             	shl    $0x3,%eax
    16a4:	89 c2                	mov    %eax,%edx
    16a6:	03 55 f8             	add    -0x8(%ebp),%edx
    16a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ac:	8b 00                	mov    (%eax),%eax
    16ae:	39 c2                	cmp    %eax,%edx
    16b0:	75 24                	jne    16d6 <free+0x8a>
    16b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b5:	8b 50 04             	mov    0x4(%eax),%edx
    16b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bb:	8b 00                	mov    (%eax),%eax
    16bd:	8b 40 04             	mov    0x4(%eax),%eax
    16c0:	01 c2                	add    %eax,%edx
    16c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c5:	89 50 04             	mov    %edx,0x4(%eax)
    16c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cb:	8b 00                	mov    (%eax),%eax
    16cd:	8b 10                	mov    (%eax),%edx
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	89 10                	mov    %edx,(%eax)
    16d4:	eb 0a                	jmp    16e0 <free+0x94>
    16d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d9:	8b 10                	mov    (%eax),%edx
    16db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16de:	89 10                	mov    %edx,(%eax)
    16e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e3:	8b 40 04             	mov    0x4(%eax),%eax
    16e6:	c1 e0 03             	shl    $0x3,%eax
    16e9:	03 45 fc             	add    -0x4(%ebp),%eax
    16ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ef:	75 20                	jne    1711 <free+0xc5>
    16f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f4:	8b 50 04             	mov    0x4(%eax),%edx
    16f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fa:	8b 40 04             	mov    0x4(%eax),%eax
    16fd:	01 c2                	add    %eax,%edx
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	89 50 04             	mov    %edx,0x4(%eax)
    1705:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1708:	8b 10                	mov    (%eax),%edx
    170a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170d:	89 10                	mov    %edx,(%eax)
    170f:	eb 08                	jmp    1719 <free+0xcd>
    1711:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1714:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1717:	89 10                	mov    %edx,(%eax)
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	a3 78 1e 00 00       	mov    %eax,0x1e78
    1721:	c9                   	leave  
    1722:	c3                   	ret    

00001723 <morecore>:
    1723:	55                   	push   %ebp
    1724:	89 e5                	mov    %esp,%ebp
    1726:	83 ec 28             	sub    $0x28,%esp
    1729:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1730:	77 07                	ja     1739 <morecore+0x16>
    1732:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	c1 e0 03             	shl    $0x3,%eax
    173f:	89 04 24             	mov    %eax,(%esp)
    1742:	e8 39 fc ff ff       	call   1380 <sbrk>
    1747:	89 45 f0             	mov    %eax,-0x10(%ebp)
    174a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    174e:	75 07                	jne    1757 <morecore+0x34>
    1750:	b8 00 00 00 00       	mov    $0x0,%eax
    1755:	eb 22                	jmp    1779 <morecore+0x56>
    1757:	8b 45 f0             	mov    -0x10(%ebp),%eax
    175a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    175d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1760:	8b 55 08             	mov    0x8(%ebp),%edx
    1763:	89 50 04             	mov    %edx,0x4(%eax)
    1766:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1769:	83 c0 08             	add    $0x8,%eax
    176c:	89 04 24             	mov    %eax,(%esp)
    176f:	e8 d8 fe ff ff       	call   164c <free>
    1774:	a1 78 1e 00 00       	mov    0x1e78,%eax
    1779:	c9                   	leave  
    177a:	c3                   	ret    

0000177b <malloc>:
    177b:	55                   	push   %ebp
    177c:	89 e5                	mov    %esp,%ebp
    177e:	83 ec 28             	sub    $0x28,%esp
    1781:	8b 45 08             	mov    0x8(%ebp),%eax
    1784:	83 c0 07             	add    $0x7,%eax
    1787:	c1 e8 03             	shr    $0x3,%eax
    178a:	83 c0 01             	add    $0x1,%eax
    178d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1790:	a1 78 1e 00 00       	mov    0x1e78,%eax
    1795:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1798:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    179c:	75 23                	jne    17c1 <malloc+0x46>
    179e:	c7 45 f0 70 1e 00 00 	movl   $0x1e70,-0x10(%ebp)
    17a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a8:	a3 78 1e 00 00       	mov    %eax,0x1e78
    17ad:	a1 78 1e 00 00       	mov    0x1e78,%eax
    17b2:	a3 70 1e 00 00       	mov    %eax,0x1e70
    17b7:	c7 05 74 1e 00 00 00 	movl   $0x0,0x1e74
    17be:	00 00 00 
    17c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c4:	8b 00                	mov    (%eax),%eax
    17c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17cc:	8b 40 04             	mov    0x4(%eax),%eax
    17cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17d2:	72 4d                	jb     1821 <malloc+0xa6>
    17d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d7:	8b 40 04             	mov    0x4(%eax),%eax
    17da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17dd:	75 0c                	jne    17eb <malloc+0x70>
    17df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e2:	8b 10                	mov    (%eax),%edx
    17e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e7:	89 10                	mov    %edx,(%eax)
    17e9:	eb 26                	jmp    1811 <malloc+0x96>
    17eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ee:	8b 40 04             	mov    0x4(%eax),%eax
    17f1:	89 c2                	mov    %eax,%edx
    17f3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f9:	89 50 04             	mov    %edx,0x4(%eax)
    17fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ff:	8b 40 04             	mov    0x4(%eax),%eax
    1802:	c1 e0 03             	shl    $0x3,%eax
    1805:	01 45 ec             	add    %eax,-0x14(%ebp)
    1808:	8b 45 ec             	mov    -0x14(%ebp),%eax
    180b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    180e:	89 50 04             	mov    %edx,0x4(%eax)
    1811:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1814:	a3 78 1e 00 00       	mov    %eax,0x1e78
    1819:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181c:	83 c0 08             	add    $0x8,%eax
    181f:	eb 38                	jmp    1859 <malloc+0xde>
    1821:	a1 78 1e 00 00       	mov    0x1e78,%eax
    1826:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1829:	75 1b                	jne    1846 <malloc+0xcb>
    182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182e:	89 04 24             	mov    %eax,(%esp)
    1831:	e8 ed fe ff ff       	call   1723 <morecore>
    1836:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1839:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    183d:	75 07                	jne    1846 <malloc+0xcb>
    183f:	b8 00 00 00 00       	mov    $0x0,%eax
    1844:	eb 13                	jmp    1859 <malloc+0xde>
    1846:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1849:	89 45 f0             	mov    %eax,-0x10(%ebp)
    184c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184f:	8b 00                	mov    (%eax),%eax
    1851:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1854:	e9 70 ff ff ff       	jmp    17c9 <malloc+0x4e>
    1859:	c9                   	leave  
    185a:	c3                   	ret    
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
    18cc:	e8 aa fe ff ff       	call   177b <malloc>
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
    1900:	c7 44 24 04 07 1b 00 	movl   $0x1b07,0x4(%esp)
    1907:	00 
    1908:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190f:	e8 84 fb ff ff       	call   1498 <printf>
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
    1937:	e8 5c fa ff ff       	call   1398 <clone>
    193c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    193f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1943:	79 1b                	jns    1960 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1945:	c7 44 24 04 15 1b 00 	movl   $0x1b15,0x4(%esp)
    194c:	00 
    194d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1954:	e8 3f fb ff ff       	call   1498 <printf>
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
    1971:	c7 44 24 04 22 1b 00 	movl   $0x1b22,0x4(%esp)
    1978:	00 
    1979:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1980:	e8 13 fb ff ff       	call   1498 <printf>
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
    198f:	a1 6c 1e 00 00       	mov    0x1e6c,%eax
    1994:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    199a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    199f:	a3 6c 1e 00 00       	mov    %eax,0x1e6c
    return (int)(rands % max);
    19a4:	a1 6c 1e 00 00       	mov    0x1e6c,%eax
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
    19e7:	e8 8f fd ff ff       	call   177b <malloc>
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
    1a92:	e8 b5 fb ff ff       	call   164c <free>
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
