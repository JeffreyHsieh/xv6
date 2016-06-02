
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
    100f:	c7 44 24 04 a5 1a 00 	movl   $0x1aa5,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 4d 04 00 00       	call   1470 <printf>
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
    12c8:	b8 01 00 00 00       	mov    $0x1,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <exit>:
    12d0:	b8 02 00 00 00       	mov    $0x2,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <wait>:
    12d8:	b8 03 00 00 00       	mov    $0x3,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <pipe>:
    12e0:	b8 04 00 00 00       	mov    $0x4,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <read>:
    12e8:	b8 05 00 00 00       	mov    $0x5,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <write>:
    12f0:	b8 10 00 00 00       	mov    $0x10,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <close>:
    12f8:	b8 15 00 00 00       	mov    $0x15,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <kill>:
    1300:	b8 06 00 00 00       	mov    $0x6,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <exec>:
    1308:	b8 07 00 00 00       	mov    $0x7,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <open>:
    1310:	b8 0f 00 00 00       	mov    $0xf,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <mknod>:
    1318:	b8 11 00 00 00       	mov    $0x11,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <unlink>:
    1320:	b8 12 00 00 00       	mov    $0x12,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <fstat>:
    1328:	b8 08 00 00 00       	mov    $0x8,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <link>:
    1330:	b8 13 00 00 00       	mov    $0x13,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <mkdir>:
    1338:	b8 14 00 00 00       	mov    $0x14,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <chdir>:
    1340:	b8 09 00 00 00       	mov    $0x9,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <dup>:
    1348:	b8 0a 00 00 00       	mov    $0xa,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <getpid>:
    1350:	b8 0b 00 00 00       	mov    $0xb,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <sbrk>:
    1358:	b8 0c 00 00 00       	mov    $0xc,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <sleep>:
    1360:	b8 0d 00 00 00       	mov    $0xd,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <uptime>:
    1368:	b8 0e 00 00 00       	mov    $0xe,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <clone>:
    1370:	b8 16 00 00 00       	mov    $0x16,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <texit>:
    1378:	b8 17 00 00 00       	mov    $0x17,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <tsleep>:
    1380:	b8 18 00 00 00       	mov    $0x18,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <twakeup>:
    1388:	b8 19 00 00 00       	mov    $0x19,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	83 ec 18             	sub    $0x18,%esp
    1396:	8b 45 0c             	mov    0xc(%ebp),%eax
    1399:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    139c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13a3:	00 
    13a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ab:	8b 45 08             	mov    0x8(%ebp),%eax
    13ae:	89 04 24             	mov    %eax,(%esp)
    13b1:	e8 3a ff ff ff       	call   12f0 <write>
}
    13b6:	c9                   	leave  
    13b7:	c3                   	ret    

000013b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13b8:	55                   	push   %ebp
    13b9:	89 e5                	mov    %esp,%ebp
    13bb:	56                   	push   %esi
    13bc:	53                   	push   %ebx
    13bd:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13c7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13cb:	74 17                	je     13e4 <printint+0x2c>
    13cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d1:	79 11                	jns    13e4 <printint+0x2c>
    neg = 1;
    13d3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13da:	8b 45 0c             	mov    0xc(%ebp),%eax
    13dd:	f7 d8                	neg    %eax
    13df:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e2:	eb 06                	jmp    13ea <printint+0x32>
  } else {
    x = xx;
    13e4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13f4:	8d 41 01             	lea    0x1(%ecx),%eax
    13f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1400:	ba 00 00 00 00       	mov    $0x0,%edx
    1405:	f7 f3                	div    %ebx
    1407:	89 d0                	mov    %edx,%eax
    1409:	0f b6 80 10 1e 00 00 	movzbl 0x1e10(%eax),%eax
    1410:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1414:	8b 75 10             	mov    0x10(%ebp),%esi
    1417:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141a:	ba 00 00 00 00       	mov    $0x0,%edx
    141f:	f7 f6                	div    %esi
    1421:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1424:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1428:	75 c7                	jne    13f1 <printint+0x39>
  if(neg)
    142a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    142e:	74 10                	je     1440 <printint+0x88>
    buf[i++] = '-';
    1430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1433:	8d 50 01             	lea    0x1(%eax),%edx
    1436:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1439:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    143e:	eb 1f                	jmp    145f <printint+0xa7>
    1440:	eb 1d                	jmp    145f <printint+0xa7>
    putc(fd, buf[i]);
    1442:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1445:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1448:	01 d0                	add    %edx,%eax
    144a:	0f b6 00             	movzbl (%eax),%eax
    144d:	0f be c0             	movsbl %al,%eax
    1450:	89 44 24 04          	mov    %eax,0x4(%esp)
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	89 04 24             	mov    %eax,(%esp)
    145a:	e8 31 ff ff ff       	call   1390 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    145f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1467:	79 d9                	jns    1442 <printint+0x8a>
    putc(fd, buf[i]);
}
    1469:	83 c4 30             	add    $0x30,%esp
    146c:	5b                   	pop    %ebx
    146d:	5e                   	pop    %esi
    146e:	5d                   	pop    %ebp
    146f:	c3                   	ret    

00001470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1476:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    147d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1480:	83 c0 04             	add    $0x4,%eax
    1483:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    148d:	e9 7c 01 00 00       	jmp    160e <printf+0x19e>
    c = fmt[i] & 0xff;
    1492:	8b 55 0c             	mov    0xc(%ebp),%edx
    1495:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1498:	01 d0                	add    %edx,%eax
    149a:	0f b6 00             	movzbl (%eax),%eax
    149d:	0f be c0             	movsbl %al,%eax
    14a0:	25 ff 00 00 00       	and    $0xff,%eax
    14a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14ac:	75 2c                	jne    14da <printf+0x6a>
      if(c == '%'){
    14ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14b2:	75 0c                	jne    14c0 <printf+0x50>
        state = '%';
    14b4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14bb:	e9 4a 01 00 00       	jmp    160a <printf+0x19a>
      } else {
        putc(fd, c);
    14c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14c3:	0f be c0             	movsbl %al,%eax
    14c6:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ca:	8b 45 08             	mov    0x8(%ebp),%eax
    14cd:	89 04 24             	mov    %eax,(%esp)
    14d0:	e8 bb fe ff ff       	call   1390 <putc>
    14d5:	e9 30 01 00 00       	jmp    160a <printf+0x19a>
      }
    } else if(state == '%'){
    14da:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14de:	0f 85 26 01 00 00    	jne    160a <printf+0x19a>
      if(c == 'd'){
    14e4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14e8:	75 2d                	jne    1517 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ed:	8b 00                	mov    (%eax),%eax
    14ef:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14f6:	00 
    14f7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14fe:	00 
    14ff:	89 44 24 04          	mov    %eax,0x4(%esp)
    1503:	8b 45 08             	mov    0x8(%ebp),%eax
    1506:	89 04 24             	mov    %eax,(%esp)
    1509:	e8 aa fe ff ff       	call   13b8 <printint>
        ap++;
    150e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1512:	e9 ec 00 00 00       	jmp    1603 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1517:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    151b:	74 06                	je     1523 <printf+0xb3>
    151d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1521:	75 2d                	jne    1550 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1523:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1526:	8b 00                	mov    (%eax),%eax
    1528:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    152f:	00 
    1530:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1537:	00 
    1538:	89 44 24 04          	mov    %eax,0x4(%esp)
    153c:	8b 45 08             	mov    0x8(%ebp),%eax
    153f:	89 04 24             	mov    %eax,(%esp)
    1542:	e8 71 fe ff ff       	call   13b8 <printint>
        ap++;
    1547:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    154b:	e9 b3 00 00 00       	jmp    1603 <printf+0x193>
      } else if(c == 's'){
    1550:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1554:	75 45                	jne    159b <printf+0x12b>
        s = (char*)*ap;
    1556:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1559:	8b 00                	mov    (%eax),%eax
    155b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    155e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1562:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1566:	75 09                	jne    1571 <printf+0x101>
          s = "(null)";
    1568:	c7 45 f4 b9 1a 00 00 	movl   $0x1ab9,-0xc(%ebp)
        while(*s != 0){
    156f:	eb 1e                	jmp    158f <printf+0x11f>
    1571:	eb 1c                	jmp    158f <printf+0x11f>
          putc(fd, *s);
    1573:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1576:	0f b6 00             	movzbl (%eax),%eax
    1579:	0f be c0             	movsbl %al,%eax
    157c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
    1583:	89 04 24             	mov    %eax,(%esp)
    1586:	e8 05 fe ff ff       	call   1390 <putc>
          s++;
    158b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    158f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1592:	0f b6 00             	movzbl (%eax),%eax
    1595:	84 c0                	test   %al,%al
    1597:	75 da                	jne    1573 <printf+0x103>
    1599:	eb 68                	jmp    1603 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    159b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    159f:	75 1d                	jne    15be <printf+0x14e>
        putc(fd, *ap);
    15a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a4:	8b 00                	mov    (%eax),%eax
    15a6:	0f be c0             	movsbl %al,%eax
    15a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	89 04 24             	mov    %eax,(%esp)
    15b3:	e8 d8 fd ff ff       	call   1390 <putc>
        ap++;
    15b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15bc:	eb 45                	jmp    1603 <printf+0x193>
      } else if(c == '%'){
    15be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15c2:	75 17                	jne    15db <printf+0x16b>
        putc(fd, c);
    15c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15c7:	0f be c0             	movsbl %al,%eax
    15ca:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ce:	8b 45 08             	mov    0x8(%ebp),%eax
    15d1:	89 04 24             	mov    %eax,(%esp)
    15d4:	e8 b7 fd ff ff       	call   1390 <putc>
    15d9:	eb 28                	jmp    1603 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15db:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15e2:	00 
    15e3:	8b 45 08             	mov    0x8(%ebp),%eax
    15e6:	89 04 24             	mov    %eax,(%esp)
    15e9:	e8 a2 fd ff ff       	call   1390 <putc>
        putc(fd, c);
    15ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f1:	0f be c0             	movsbl %al,%eax
    15f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f8:	8b 45 08             	mov    0x8(%ebp),%eax
    15fb:	89 04 24             	mov    %eax,(%esp)
    15fe:	e8 8d fd ff ff       	call   1390 <putc>
      }
      state = 0;
    1603:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    160a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    160e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1611:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1614:	01 d0                	add    %edx,%eax
    1616:	0f b6 00             	movzbl (%eax),%eax
    1619:	84 c0                	test   %al,%al
    161b:	0f 85 71 fe ff ff    	jne    1492 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1621:	c9                   	leave  
    1622:	c3                   	ret    
    1623:	90                   	nop

00001624 <free>:
    1624:	55                   	push   %ebp
    1625:	89 e5                	mov    %esp,%ebp
    1627:	83 ec 10             	sub    $0x10,%esp
    162a:	8b 45 08             	mov    0x8(%ebp),%eax
    162d:	83 e8 08             	sub    $0x8,%eax
    1630:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1633:	a1 30 1e 00 00       	mov    0x1e30,%eax
    1638:	89 45 fc             	mov    %eax,-0x4(%ebp)
    163b:	eb 24                	jmp    1661 <free+0x3d>
    163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1640:	8b 00                	mov    (%eax),%eax
    1642:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1645:	77 12                	ja     1659 <free+0x35>
    1647:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    164d:	77 24                	ja     1673 <free+0x4f>
    164f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1652:	8b 00                	mov    (%eax),%eax
    1654:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1657:	77 1a                	ja     1673 <free+0x4f>
    1659:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165c:	8b 00                	mov    (%eax),%eax
    165e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1661:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1664:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1667:	76 d4                	jbe    163d <free+0x19>
    1669:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166c:	8b 00                	mov    (%eax),%eax
    166e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1671:	76 ca                	jbe    163d <free+0x19>
    1673:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1676:	8b 40 04             	mov    0x4(%eax),%eax
    1679:	c1 e0 03             	shl    $0x3,%eax
    167c:	89 c2                	mov    %eax,%edx
    167e:	03 55 f8             	add    -0x8(%ebp),%edx
    1681:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1684:	8b 00                	mov    (%eax),%eax
    1686:	39 c2                	cmp    %eax,%edx
    1688:	75 24                	jne    16ae <free+0x8a>
    168a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168d:	8b 50 04             	mov    0x4(%eax),%edx
    1690:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1693:	8b 00                	mov    (%eax),%eax
    1695:	8b 40 04             	mov    0x4(%eax),%eax
    1698:	01 c2                	add    %eax,%edx
    169a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169d:	89 50 04             	mov    %edx,0x4(%eax)
    16a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a3:	8b 00                	mov    (%eax),%eax
    16a5:	8b 10                	mov    (%eax),%edx
    16a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16aa:	89 10                	mov    %edx,(%eax)
    16ac:	eb 0a                	jmp    16b8 <free+0x94>
    16ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b1:	8b 10                	mov    (%eax),%edx
    16b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b6:	89 10                	mov    %edx,(%eax)
    16b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bb:	8b 40 04             	mov    0x4(%eax),%eax
    16be:	c1 e0 03             	shl    $0x3,%eax
    16c1:	03 45 fc             	add    -0x4(%ebp),%eax
    16c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16c7:	75 20                	jne    16e9 <free+0xc5>
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	8b 50 04             	mov    0x4(%eax),%edx
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	8b 40 04             	mov    0x4(%eax),%eax
    16d5:	01 c2                	add    %eax,%edx
    16d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16da:	89 50 04             	mov    %edx,0x4(%eax)
    16dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e0:	8b 10                	mov    (%eax),%edx
    16e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e5:	89 10                	mov    %edx,(%eax)
    16e7:	eb 08                	jmp    16f1 <free+0xcd>
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ef:	89 10                	mov    %edx,(%eax)
    16f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f4:	a3 30 1e 00 00       	mov    %eax,0x1e30
    16f9:	c9                   	leave  
    16fa:	c3                   	ret    

000016fb <morecore>:
    16fb:	55                   	push   %ebp
    16fc:	89 e5                	mov    %esp,%ebp
    16fe:	83 ec 28             	sub    $0x28,%esp
    1701:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1708:	77 07                	ja     1711 <morecore+0x16>
    170a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1711:	8b 45 08             	mov    0x8(%ebp),%eax
    1714:	c1 e0 03             	shl    $0x3,%eax
    1717:	89 04 24             	mov    %eax,(%esp)
    171a:	e8 39 fc ff ff       	call   1358 <sbrk>
    171f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1722:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1726:	75 07                	jne    172f <morecore+0x34>
    1728:	b8 00 00 00 00       	mov    $0x0,%eax
    172d:	eb 22                	jmp    1751 <morecore+0x56>
    172f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1732:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	8b 55 08             	mov    0x8(%ebp),%edx
    173b:	89 50 04             	mov    %edx,0x4(%eax)
    173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1741:	83 c0 08             	add    $0x8,%eax
    1744:	89 04 24             	mov    %eax,(%esp)
    1747:	e8 d8 fe ff ff       	call   1624 <free>
    174c:	a1 30 1e 00 00       	mov    0x1e30,%eax
    1751:	c9                   	leave  
    1752:	c3                   	ret    

00001753 <malloc>:
    1753:	55                   	push   %ebp
    1754:	89 e5                	mov    %esp,%ebp
    1756:	83 ec 28             	sub    $0x28,%esp
    1759:	8b 45 08             	mov    0x8(%ebp),%eax
    175c:	83 c0 07             	add    $0x7,%eax
    175f:	c1 e8 03             	shr    $0x3,%eax
    1762:	83 c0 01             	add    $0x1,%eax
    1765:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1768:	a1 30 1e 00 00       	mov    0x1e30,%eax
    176d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1770:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1774:	75 23                	jne    1799 <malloc+0x46>
    1776:	c7 45 f0 28 1e 00 00 	movl   $0x1e28,-0x10(%ebp)
    177d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1780:	a3 30 1e 00 00       	mov    %eax,0x1e30
    1785:	a1 30 1e 00 00       	mov    0x1e30,%eax
    178a:	a3 28 1e 00 00       	mov    %eax,0x1e28
    178f:	c7 05 2c 1e 00 00 00 	movl   $0x0,0x1e2c
    1796:	00 00 00 
    1799:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179c:	8b 00                	mov    (%eax),%eax
    179e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a4:	8b 40 04             	mov    0x4(%eax),%eax
    17a7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17aa:	72 4d                	jb     17f9 <malloc+0xa6>
    17ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17af:	8b 40 04             	mov    0x4(%eax),%eax
    17b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17b5:	75 0c                	jne    17c3 <malloc+0x70>
    17b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ba:	8b 10                	mov    (%eax),%edx
    17bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17bf:	89 10                	mov    %edx,(%eax)
    17c1:	eb 26                	jmp    17e9 <malloc+0x96>
    17c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c6:	8b 40 04             	mov    0x4(%eax),%eax
    17c9:	89 c2                	mov    %eax,%edx
    17cb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d1:	89 50 04             	mov    %edx,0x4(%eax)
    17d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d7:	8b 40 04             	mov    0x4(%eax),%eax
    17da:	c1 e0 03             	shl    $0x3,%eax
    17dd:	01 45 ec             	add    %eax,-0x14(%ebp)
    17e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17e6:	89 50 04             	mov    %edx,0x4(%eax)
    17e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ec:	a3 30 1e 00 00       	mov    %eax,0x1e30
    17f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f4:	83 c0 08             	add    $0x8,%eax
    17f7:	eb 38                	jmp    1831 <malloc+0xde>
    17f9:	a1 30 1e 00 00       	mov    0x1e30,%eax
    17fe:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1801:	75 1b                	jne    181e <malloc+0xcb>
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	89 04 24             	mov    %eax,(%esp)
    1809:	e8 ed fe ff ff       	call   16fb <morecore>
    180e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1811:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1815:	75 07                	jne    181e <malloc+0xcb>
    1817:	b8 00 00 00 00       	mov    $0x0,%eax
    181c:	eb 13                	jmp    1831 <malloc+0xde>
    181e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1821:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1824:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1827:	8b 00                	mov    (%eax),%eax
    1829:	89 45 ec             	mov    %eax,-0x14(%ebp)
    182c:	e9 70 ff ff ff       	jmp    17a1 <malloc+0x4e>
    1831:	c9                   	leave  
    1832:	c3                   	ret    
    1833:	90                   	nop

00001834 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1834:	55                   	push   %ebp
    1835:	89 e5                	mov    %esp,%ebp
    1837:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    183a:	8b 55 08             	mov    0x8(%ebp),%edx
    183d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1840:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1843:	f0 87 02             	lock xchg %eax,(%edx)
    1846:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1849:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    184c:	c9                   	leave  
    184d:	c3                   	ret    

0000184e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    184e:	55                   	push   %ebp
    184f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1851:	8b 45 08             	mov    0x8(%ebp),%eax
    1854:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    185a:	5d                   	pop    %ebp
    185b:	c3                   	ret    

0000185c <lock_acquire>:
void lock_acquire(lock_t *lock){
    185c:	55                   	push   %ebp
    185d:	89 e5                	mov    %esp,%ebp
    185f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1862:	90                   	nop
    1863:	8b 45 08             	mov    0x8(%ebp),%eax
    1866:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    186d:	00 
    186e:	89 04 24             	mov    %eax,(%esp)
    1871:	e8 be ff ff ff       	call   1834 <xchg>
    1876:	85 c0                	test   %eax,%eax
    1878:	75 e9                	jne    1863 <lock_acquire+0x7>
}
    187a:	c9                   	leave  
    187b:	c3                   	ret    

0000187c <lock_release>:
void lock_release(lock_t *lock){
    187c:	55                   	push   %ebp
    187d:	89 e5                	mov    %esp,%ebp
    187f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1882:	8b 45 08             	mov    0x8(%ebp),%eax
    1885:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    188c:	00 
    188d:	89 04 24             	mov    %eax,(%esp)
    1890:	e8 9f ff ff ff       	call   1834 <xchg>
}
    1895:	c9                   	leave  
    1896:	c3                   	ret    

00001897 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1897:	55                   	push   %ebp
    1898:	89 e5                	mov    %esp,%ebp
    189a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    189d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18a4:	e8 aa fe ff ff       	call   1753 <malloc>
    18a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    18ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18af:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    18b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b5:	25 ff 0f 00 00       	and    $0xfff,%eax
    18ba:	85 c0                	test   %eax,%eax
    18bc:	74 14                	je     18d2 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    18be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c1:	25 ff 0f 00 00       	and    $0xfff,%eax
    18c6:	89 c2                	mov    %eax,%edx
    18c8:	b8 00 10 00 00       	mov    $0x1000,%eax
    18cd:	29 d0                	sub    %edx,%eax
    18cf:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18d6:	75 1b                	jne    18f3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18d8:	c7 44 24 04 c0 1a 00 	movl   $0x1ac0,0x4(%esp)
    18df:	00 
    18e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e7:	e8 84 fb ff ff       	call   1470 <printf>
        return 0;
    18ec:	b8 00 00 00 00       	mov    $0x0,%eax
    18f1:	eb 6f                	jmp    1962 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18f6:	8b 55 08             	mov    0x8(%ebp),%edx
    18f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1900:	89 54 24 08          	mov    %edx,0x8(%esp)
    1904:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    190b:	00 
    190c:	89 04 24             	mov    %eax,(%esp)
    190f:	e8 5c fa ff ff       	call   1370 <clone>
    1914:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1917:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191b:	79 1b                	jns    1938 <thread_create+0xa1>
        printf(1,"clone fails\n");
    191d:	c7 44 24 04 ce 1a 00 	movl   $0x1ace,0x4(%esp)
    1924:	00 
    1925:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    192c:	e8 3f fb ff ff       	call   1470 <printf>
        return 0;
    1931:	b8 00 00 00 00       	mov    $0x0,%eax
    1936:	eb 2a                	jmp    1962 <thread_create+0xcb>
    }
    if(tid > 0){
    1938:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193c:	7e 05                	jle    1943 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    193e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1941:	eb 1f                	jmp    1962 <thread_create+0xcb>
    }
    if(tid == 0){
    1943:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1947:	75 14                	jne    195d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1949:	c7 44 24 04 db 1a 00 	movl   $0x1adb,0x4(%esp)
    1950:	00 
    1951:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1958:	e8 13 fb ff ff       	call   1470 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    195d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1962:	c9                   	leave  
    1963:	c3                   	ret    

00001964 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1964:	55                   	push   %ebp
    1965:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1967:	a1 24 1e 00 00       	mov    0x1e24,%eax
    196c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1972:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1977:	a3 24 1e 00 00       	mov    %eax,0x1e24
    return (int)(rands % max);
    197c:	a1 24 1e 00 00       	mov    0x1e24,%eax
    1981:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1984:	ba 00 00 00 00       	mov    $0x0,%edx
    1989:	f7 f1                	div    %ecx
    198b:	89 d0                	mov    %edx,%eax
}
    198d:	5d                   	pop    %ebp
    198e:	c3                   	ret    
    198f:	90                   	nop

00001990 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1993:	8b 45 08             	mov    0x8(%ebp),%eax
    1996:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    199c:	8b 45 08             	mov    0x8(%ebp),%eax
    199f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    19a6:	8b 45 08             	mov    0x8(%ebp),%eax
    19a9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    19b0:	5d                   	pop    %ebp
    19b1:	c3                   	ret    

000019b2 <add_q>:

void add_q(struct queue *q, int v){
    19b2:	55                   	push   %ebp
    19b3:	89 e5                	mov    %esp,%ebp
    19b5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    19b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19bf:	e8 8f fd ff ff       	call   1753 <malloc>
    19c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19d7:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19d9:	8b 45 08             	mov    0x8(%ebp),%eax
    19dc:	8b 40 04             	mov    0x4(%eax),%eax
    19df:	85 c0                	test   %eax,%eax
    19e1:	75 0b                	jne    19ee <add_q+0x3c>
        q->head = n;
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19e9:	89 50 04             	mov    %edx,0x4(%eax)
    19ec:	eb 0c                	jmp    19fa <add_q+0x48>
    }else{
        q->tail->next = n;
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	8b 40 08             	mov    0x8(%eax),%eax
    19f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19f7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19fa:	8b 45 08             	mov    0x8(%ebp),%eax
    19fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a00:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a03:	8b 45 08             	mov    0x8(%ebp),%eax
    1a06:	8b 00                	mov    (%eax),%eax
    1a08:	8d 50 01             	lea    0x1(%eax),%edx
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	89 10                	mov    %edx,(%eax)
}
    1a10:	c9                   	leave  
    1a11:	c3                   	ret    

00001a12 <empty_q>:

int empty_q(struct queue *q){
    1a12:	55                   	push   %ebp
    1a13:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a15:	8b 45 08             	mov    0x8(%ebp),%eax
    1a18:	8b 00                	mov    (%eax),%eax
    1a1a:	85 c0                	test   %eax,%eax
    1a1c:	75 07                	jne    1a25 <empty_q+0x13>
        return 1;
    1a1e:	b8 01 00 00 00       	mov    $0x1,%eax
    1a23:	eb 05                	jmp    1a2a <empty_q+0x18>
    else
        return 0;
    1a25:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a2a:	5d                   	pop    %ebp
    1a2b:	c3                   	ret    

00001a2c <pop_q>:
int pop_q(struct queue *q){
    1a2c:	55                   	push   %ebp
    1a2d:	89 e5                	mov    %esp,%ebp
    1a2f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	89 04 24             	mov    %eax,(%esp)
    1a38:	e8 d5 ff ff ff       	call   1a12 <empty_q>
    1a3d:	85 c0                	test   %eax,%eax
    1a3f:	75 5d                	jne    1a9e <pop_q+0x72>
       val = q->head->value; 
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	8b 40 04             	mov    0x4(%eax),%eax
    1a47:	8b 00                	mov    (%eax),%eax
    1a49:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	8b 40 04             	mov    0x4(%eax),%eax
    1a52:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	8b 40 04             	mov    0x4(%eax),%eax
    1a5b:	8b 50 04             	mov    0x4(%eax),%edx
    1a5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a61:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a64:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a67:	89 04 24             	mov    %eax,(%esp)
    1a6a:	e8 b5 fb ff ff       	call   1624 <free>
       q->size--;
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	8b 00                	mov    (%eax),%eax
    1a74:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a77:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7f:	8b 00                	mov    (%eax),%eax
    1a81:	85 c0                	test   %eax,%eax
    1a83:	75 14                	jne    1a99 <pop_q+0x6d>
            q->head = 0;
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9c:	eb 05                	jmp    1aa3 <pop_q+0x77>
    }
    return -1;
    1a9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1aa3:	c9                   	leave  
    1aa4:	c3                   	ret    
