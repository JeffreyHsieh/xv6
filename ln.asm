
_ln:     file format elf32-i386


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
    1006:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
    1009:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    100d:	74 19                	je     1028 <main+0x28>
    printf(2, "Usage: ln old new\n");
    100f:	c7 44 24 04 b9 1a 00 	movl   $0x1ab9,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 61 04 00 00       	call   1484 <printf>
    exit();
    1023:	e8 bc 02 00 00       	call   12e4 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
    1028:	8b 45 0c             	mov    0xc(%ebp),%eax
    102b:	83 c0 08             	add    $0x8,%eax
    102e:	8b 10                	mov    (%eax),%edx
    1030:	8b 45 0c             	mov    0xc(%ebp),%eax
    1033:	83 c0 04             	add    $0x4,%eax
    1036:	8b 00                	mov    (%eax),%eax
    1038:	89 54 24 04          	mov    %edx,0x4(%esp)
    103c:	89 04 24             	mov    %eax,(%esp)
    103f:	e8 00 03 00 00       	call   1344 <link>
    1044:	85 c0                	test   %eax,%eax
    1046:	79 2c                	jns    1074 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1048:	8b 45 0c             	mov    0xc(%ebp),%eax
    104b:	83 c0 08             	add    $0x8,%eax
    104e:	8b 10                	mov    (%eax),%edx
    1050:	8b 45 0c             	mov    0xc(%ebp),%eax
    1053:	83 c0 04             	add    $0x4,%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	89 54 24 0c          	mov    %edx,0xc(%esp)
    105c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1060:	c7 44 24 04 cc 1a 00 	movl   $0x1acc,0x4(%esp)
    1067:	00 
    1068:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    106f:	e8 10 04 00 00       	call   1484 <printf>
  exit();
    1074:	e8 6b 02 00 00       	call   12e4 <exit>
    1079:	66 90                	xchg   %ax,%ax
    107b:	90                   	nop

0000107c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	57                   	push   %edi
    1080:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1081:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1084:	8b 55 10             	mov    0x10(%ebp),%edx
    1087:	8b 45 0c             	mov    0xc(%ebp),%eax
    108a:	89 cb                	mov    %ecx,%ebx
    108c:	89 df                	mov    %ebx,%edi
    108e:	89 d1                	mov    %edx,%ecx
    1090:	fc                   	cld    
    1091:	f3 aa                	rep stos %al,%es:(%edi)
    1093:	89 ca                	mov    %ecx,%edx
    1095:	89 fb                	mov    %edi,%ebx
    1097:	89 5d 08             	mov    %ebx,0x8(%ebp)
    109a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    109d:	5b                   	pop    %ebx
    109e:	5f                   	pop    %edi
    109f:	5d                   	pop    %ebp
    10a0:	c3                   	ret    

000010a1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10a7:	8b 45 08             	mov    0x8(%ebp),%eax
    10aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10ad:	90                   	nop
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	8d 50 01             	lea    0x1(%eax),%edx
    10b4:	89 55 08             	mov    %edx,0x8(%ebp)
    10b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ba:	8d 4a 01             	lea    0x1(%edx),%ecx
    10bd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10c0:	0f b6 12             	movzbl (%edx),%edx
    10c3:	88 10                	mov    %dl,(%eax)
    10c5:	0f b6 00             	movzbl (%eax),%eax
    10c8:	84 c0                	test   %al,%al
    10ca:	75 e2                	jne    10ae <strcpy+0xd>
    ;
  return os;
    10cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10cf:	c9                   	leave  
    10d0:	c3                   	ret    

000010d1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d1:	55                   	push   %ebp
    10d2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10d4:	eb 08                	jmp    10de <strcmp+0xd>
    p++, q++;
    10d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10da:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10de:	8b 45 08             	mov    0x8(%ebp),%eax
    10e1:	0f b6 00             	movzbl (%eax),%eax
    10e4:	84 c0                	test   %al,%al
    10e6:	74 10                	je     10f8 <strcmp+0x27>
    10e8:	8b 45 08             	mov    0x8(%ebp),%eax
    10eb:	0f b6 10             	movzbl (%eax),%edx
    10ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f1:	0f b6 00             	movzbl (%eax),%eax
    10f4:	38 c2                	cmp    %al,%dl
    10f6:	74 de                	je     10d6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10f8:	8b 45 08             	mov    0x8(%ebp),%eax
    10fb:	0f b6 00             	movzbl (%eax),%eax
    10fe:	0f b6 d0             	movzbl %al,%edx
    1101:	8b 45 0c             	mov    0xc(%ebp),%eax
    1104:	0f b6 00             	movzbl (%eax),%eax
    1107:	0f b6 c0             	movzbl %al,%eax
    110a:	29 c2                	sub    %eax,%edx
    110c:	89 d0                	mov    %edx,%eax
}
    110e:	5d                   	pop    %ebp
    110f:	c3                   	ret    

00001110 <strlen>:

uint
strlen(char *s)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    111d:	eb 04                	jmp    1123 <strlen+0x13>
    111f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1123:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	01 d0                	add    %edx,%eax
    112b:	0f b6 00             	movzbl (%eax),%eax
    112e:	84 c0                	test   %al,%al
    1130:	75 ed                	jne    111f <strlen+0xf>
    ;
  return n;
    1132:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1135:	c9                   	leave  
    1136:	c3                   	ret    

00001137 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1137:	55                   	push   %ebp
    1138:	89 e5                	mov    %esp,%ebp
    113a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    113d:	8b 45 10             	mov    0x10(%ebp),%eax
    1140:	89 44 24 08          	mov    %eax,0x8(%esp)
    1144:	8b 45 0c             	mov    0xc(%ebp),%eax
    1147:	89 44 24 04          	mov    %eax,0x4(%esp)
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	89 04 24             	mov    %eax,(%esp)
    1151:	e8 26 ff ff ff       	call   107c <stosb>
  return dst;
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1159:	c9                   	leave  
    115a:	c3                   	ret    

0000115b <strchr>:

char*
strchr(const char *s, char c)
{
    115b:	55                   	push   %ebp
    115c:	89 e5                	mov    %esp,%ebp
    115e:	83 ec 04             	sub    $0x4,%esp
    1161:	8b 45 0c             	mov    0xc(%ebp),%eax
    1164:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1167:	eb 14                	jmp    117d <strchr+0x22>
    if(*s == c)
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	0f b6 00             	movzbl (%eax),%eax
    116f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1172:	75 05                	jne    1179 <strchr+0x1e>
      return (char*)s;
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	eb 13                	jmp    118c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1179:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	84 c0                	test   %al,%al
    1185:	75 e2                	jne    1169 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1187:	b8 00 00 00 00       	mov    $0x0,%eax
}
    118c:	c9                   	leave  
    118d:	c3                   	ret    

0000118e <gets>:

char*
gets(char *buf, int max)
{
    118e:	55                   	push   %ebp
    118f:	89 e5                	mov    %esp,%ebp
    1191:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    119b:	eb 4c                	jmp    11e9 <gets+0x5b>
    cc = read(0, &c, 1);
    119d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11a4:	00 
    11a5:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11b3:	e8 44 01 00 00       	call   12fc <read>
    11b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11bf:	7f 02                	jg     11c3 <gets+0x35>
      break;
    11c1:	eb 31                	jmp    11f4 <gets+0x66>
    buf[i++] = c;
    11c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c6:	8d 50 01             	lea    0x1(%eax),%edx
    11c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11cc:	89 c2                	mov    %eax,%edx
    11ce:	8b 45 08             	mov    0x8(%ebp),%eax
    11d1:	01 c2                	add    %eax,%edx
    11d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11dd:	3c 0a                	cmp    $0xa,%al
    11df:	74 13                	je     11f4 <gets+0x66>
    11e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e5:	3c 0d                	cmp    $0xd,%al
    11e7:	74 0b                	je     11f4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ec:	83 c0 01             	add    $0x1,%eax
    11ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f2:	7c a9                	jl     119d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f7:	8b 45 08             	mov    0x8(%ebp),%eax
    11fa:	01 d0                	add    %edx,%eax
    11fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1202:	c9                   	leave  
    1203:	c3                   	ret    

00001204 <stat>:

int
stat(char *n, struct stat *st)
{
    1204:	55                   	push   %ebp
    1205:	89 e5                	mov    %esp,%ebp
    1207:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    120a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1211:	00 
    1212:	8b 45 08             	mov    0x8(%ebp),%eax
    1215:	89 04 24             	mov    %eax,(%esp)
    1218:	e8 07 01 00 00       	call   1324 <open>
    121d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1220:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1224:	79 07                	jns    122d <stat+0x29>
    return -1;
    1226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    122b:	eb 23                	jmp    1250 <stat+0x4c>
  r = fstat(fd, st);
    122d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1230:	89 44 24 04          	mov    %eax,0x4(%esp)
    1234:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1237:	89 04 24             	mov    %eax,(%esp)
    123a:	e8 fd 00 00 00       	call   133c <fstat>
    123f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1242:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1245:	89 04 24             	mov    %eax,(%esp)
    1248:	e8 bf 00 00 00       	call   130c <close>
  return r;
    124d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1250:	c9                   	leave  
    1251:	c3                   	ret    

00001252 <atoi>:

int
atoi(const char *s)
{
    1252:	55                   	push   %ebp
    1253:	89 e5                	mov    %esp,%ebp
    1255:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    125f:	eb 25                	jmp    1286 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1261:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1264:	89 d0                	mov    %edx,%eax
    1266:	c1 e0 02             	shl    $0x2,%eax
    1269:	01 d0                	add    %edx,%eax
    126b:	01 c0                	add    %eax,%eax
    126d:	89 c1                	mov    %eax,%ecx
    126f:	8b 45 08             	mov    0x8(%ebp),%eax
    1272:	8d 50 01             	lea    0x1(%eax),%edx
    1275:	89 55 08             	mov    %edx,0x8(%ebp)
    1278:	0f b6 00             	movzbl (%eax),%eax
    127b:	0f be c0             	movsbl %al,%eax
    127e:	01 c8                	add    %ecx,%eax
    1280:	83 e8 30             	sub    $0x30,%eax
    1283:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	0f b6 00             	movzbl (%eax),%eax
    128c:	3c 2f                	cmp    $0x2f,%al
    128e:	7e 0a                	jle    129a <atoi+0x48>
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	0f b6 00             	movzbl (%eax),%eax
    1296:	3c 39                	cmp    $0x39,%al
    1298:	7e c7                	jle    1261 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    129a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    129d:	c9                   	leave  
    129e:	c3                   	ret    

0000129f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    129f:	55                   	push   %ebp
    12a0:	89 e5                	mov    %esp,%ebp
    12a2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12a5:	8b 45 08             	mov    0x8(%ebp),%eax
    12a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12b1:	eb 17                	jmp    12ca <memmove+0x2b>
    *dst++ = *src++;
    12b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b6:	8d 50 01             	lea    0x1(%eax),%edx
    12b9:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12bf:	8d 4a 01             	lea    0x1(%edx),%ecx
    12c2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12c5:	0f b6 12             	movzbl (%edx),%edx
    12c8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ca:	8b 45 10             	mov    0x10(%ebp),%eax
    12cd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12d0:	89 55 10             	mov    %edx,0x10(%ebp)
    12d3:	85 c0                	test   %eax,%eax
    12d5:	7f dc                	jg     12b3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12da:	c9                   	leave  
    12db:	c3                   	ret    

000012dc <fork>:
    12dc:	b8 01 00 00 00       	mov    $0x1,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <exit>:
    12e4:	b8 02 00 00 00       	mov    $0x2,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <wait>:
    12ec:	b8 03 00 00 00       	mov    $0x3,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <pipe>:
    12f4:	b8 04 00 00 00       	mov    $0x4,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <read>:
    12fc:	b8 05 00 00 00       	mov    $0x5,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <write>:
    1304:	b8 10 00 00 00       	mov    $0x10,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <close>:
    130c:	b8 15 00 00 00       	mov    $0x15,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <kill>:
    1314:	b8 06 00 00 00       	mov    $0x6,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <exec>:
    131c:	b8 07 00 00 00       	mov    $0x7,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <open>:
    1324:	b8 0f 00 00 00       	mov    $0xf,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <mknod>:
    132c:	b8 11 00 00 00       	mov    $0x11,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <unlink>:
    1334:	b8 12 00 00 00       	mov    $0x12,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <fstat>:
    133c:	b8 08 00 00 00       	mov    $0x8,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <link>:
    1344:	b8 13 00 00 00       	mov    $0x13,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <mkdir>:
    134c:	b8 14 00 00 00       	mov    $0x14,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <chdir>:
    1354:	b8 09 00 00 00       	mov    $0x9,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <dup>:
    135c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <getpid>:
    1364:	b8 0b 00 00 00       	mov    $0xb,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <sbrk>:
    136c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <sleep>:
    1374:	b8 0d 00 00 00       	mov    $0xd,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <uptime>:
    137c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <clone>:
    1384:	b8 16 00 00 00       	mov    $0x16,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <texit>:
    138c:	b8 17 00 00 00       	mov    $0x17,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <tsleep>:
    1394:	b8 18 00 00 00       	mov    $0x18,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <twakeup>:
    139c:	b8 19 00 00 00       	mov    $0x19,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13a4:	55                   	push   %ebp
    13a5:	89 e5                	mov    %esp,%ebp
    13a7:	83 ec 18             	sub    $0x18,%esp
    13aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ad:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13b7:	00 
    13b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    13bf:	8b 45 08             	mov    0x8(%ebp),%eax
    13c2:	89 04 24             	mov    %eax,(%esp)
    13c5:	e8 3a ff ff ff       	call   1304 <write>
}
    13ca:	c9                   	leave  
    13cb:	c3                   	ret    

000013cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13cc:	55                   	push   %ebp
    13cd:	89 e5                	mov    %esp,%ebp
    13cf:	56                   	push   %esi
    13d0:	53                   	push   %ebx
    13d1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13db:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13df:	74 17                	je     13f8 <printint+0x2c>
    13e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13e5:	79 11                	jns    13f8 <printint+0x2c>
    neg = 1;
    13e7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f1:	f7 d8                	neg    %eax
    13f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13f6:	eb 06                	jmp    13fe <printint+0x32>
  } else {
    x = xx;
    13f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1405:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1408:	8d 41 01             	lea    0x1(%ecx),%eax
    140b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    140e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1411:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1414:	ba 00 00 00 00       	mov    $0x0,%edx
    1419:	f7 f3                	div    %ebx
    141b:	89 d0                	mov    %edx,%eax
    141d:	0f b6 80 38 1e 00 00 	movzbl 0x1e38(%eax),%eax
    1424:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1428:	8b 75 10             	mov    0x10(%ebp),%esi
    142b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    142e:	ba 00 00 00 00       	mov    $0x0,%edx
    1433:	f7 f6                	div    %esi
    1435:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1438:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    143c:	75 c7                	jne    1405 <printint+0x39>
  if(neg)
    143e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1442:	74 10                	je     1454 <printint+0x88>
    buf[i++] = '-';
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	8d 50 01             	lea    0x1(%eax),%edx
    144a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    144d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1452:	eb 1f                	jmp    1473 <printint+0xa7>
    1454:	eb 1d                	jmp    1473 <printint+0xa7>
    putc(fd, buf[i]);
    1456:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145c:	01 d0                	add    %edx,%eax
    145e:	0f b6 00             	movzbl (%eax),%eax
    1461:	0f be c0             	movsbl %al,%eax
    1464:	89 44 24 04          	mov    %eax,0x4(%esp)
    1468:	8b 45 08             	mov    0x8(%ebp),%eax
    146b:	89 04 24             	mov    %eax,(%esp)
    146e:	e8 31 ff ff ff       	call   13a4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1473:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1477:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    147b:	79 d9                	jns    1456 <printint+0x8a>
    putc(fd, buf[i]);
}
    147d:	83 c4 30             	add    $0x30,%esp
    1480:	5b                   	pop    %ebx
    1481:	5e                   	pop    %esi
    1482:	5d                   	pop    %ebp
    1483:	c3                   	ret    

00001484 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1484:	55                   	push   %ebp
    1485:	89 e5                	mov    %esp,%ebp
    1487:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    148a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1491:	8d 45 0c             	lea    0xc(%ebp),%eax
    1494:	83 c0 04             	add    $0x4,%eax
    1497:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    149a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14a1:	e9 7c 01 00 00       	jmp    1622 <printf+0x19e>
    c = fmt[i] & 0xff;
    14a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ac:	01 d0                	add    %edx,%eax
    14ae:	0f b6 00             	movzbl (%eax),%eax
    14b1:	0f be c0             	movsbl %al,%eax
    14b4:	25 ff 00 00 00       	and    $0xff,%eax
    14b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14c0:	75 2c                	jne    14ee <printf+0x6a>
      if(c == '%'){
    14c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14c6:	75 0c                	jne    14d4 <printf+0x50>
        state = '%';
    14c8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14cf:	e9 4a 01 00 00       	jmp    161e <printf+0x19a>
      } else {
        putc(fd, c);
    14d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14d7:	0f be c0             	movsbl %al,%eax
    14da:	89 44 24 04          	mov    %eax,0x4(%esp)
    14de:	8b 45 08             	mov    0x8(%ebp),%eax
    14e1:	89 04 24             	mov    %eax,(%esp)
    14e4:	e8 bb fe ff ff       	call   13a4 <putc>
    14e9:	e9 30 01 00 00       	jmp    161e <printf+0x19a>
      }
    } else if(state == '%'){
    14ee:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14f2:	0f 85 26 01 00 00    	jne    161e <printf+0x19a>
      if(c == 'd'){
    14f8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14fc:	75 2d                	jne    152b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1501:	8b 00                	mov    (%eax),%eax
    1503:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    150a:	00 
    150b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1512:	00 
    1513:	89 44 24 04          	mov    %eax,0x4(%esp)
    1517:	8b 45 08             	mov    0x8(%ebp),%eax
    151a:	89 04 24             	mov    %eax,(%esp)
    151d:	e8 aa fe ff ff       	call   13cc <printint>
        ap++;
    1522:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1526:	e9 ec 00 00 00       	jmp    1617 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    152b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    152f:	74 06                	je     1537 <printf+0xb3>
    1531:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1535:	75 2d                	jne    1564 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1537:	8b 45 e8             	mov    -0x18(%ebp),%eax
    153a:	8b 00                	mov    (%eax),%eax
    153c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1543:	00 
    1544:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    154b:	00 
    154c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1550:	8b 45 08             	mov    0x8(%ebp),%eax
    1553:	89 04 24             	mov    %eax,(%esp)
    1556:	e8 71 fe ff ff       	call   13cc <printint>
        ap++;
    155b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    155f:	e9 b3 00 00 00       	jmp    1617 <printf+0x193>
      } else if(c == 's'){
    1564:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1568:	75 45                	jne    15af <printf+0x12b>
        s = (char*)*ap;
    156a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    156d:	8b 00                	mov    (%eax),%eax
    156f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1572:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1576:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    157a:	75 09                	jne    1585 <printf+0x101>
          s = "(null)";
    157c:	c7 45 f4 e0 1a 00 00 	movl   $0x1ae0,-0xc(%ebp)
        while(*s != 0){
    1583:	eb 1e                	jmp    15a3 <printf+0x11f>
    1585:	eb 1c                	jmp    15a3 <printf+0x11f>
          putc(fd, *s);
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	0f b6 00             	movzbl (%eax),%eax
    158d:	0f be c0             	movsbl %al,%eax
    1590:	89 44 24 04          	mov    %eax,0x4(%esp)
    1594:	8b 45 08             	mov    0x8(%ebp),%eax
    1597:	89 04 24             	mov    %eax,(%esp)
    159a:	e8 05 fe ff ff       	call   13a4 <putc>
          s++;
    159f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	84 c0                	test   %al,%al
    15ab:	75 da                	jne    1587 <printf+0x103>
    15ad:	eb 68                	jmp    1617 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15af:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15b3:	75 1d                	jne    15d2 <printf+0x14e>
        putc(fd, *ap);
    15b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b8:	8b 00                	mov    (%eax),%eax
    15ba:	0f be c0             	movsbl %al,%eax
    15bd:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c1:	8b 45 08             	mov    0x8(%ebp),%eax
    15c4:	89 04 24             	mov    %eax,(%esp)
    15c7:	e8 d8 fd ff ff       	call   13a4 <putc>
        ap++;
    15cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15d0:	eb 45                	jmp    1617 <printf+0x193>
      } else if(c == '%'){
    15d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15d6:	75 17                	jne    15ef <printf+0x16b>
        putc(fd, c);
    15d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15db:	0f be c0             	movsbl %al,%eax
    15de:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e2:	8b 45 08             	mov    0x8(%ebp),%eax
    15e5:	89 04 24             	mov    %eax,(%esp)
    15e8:	e8 b7 fd ff ff       	call   13a4 <putc>
    15ed:	eb 28                	jmp    1617 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ef:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15f6:	00 
    15f7:	8b 45 08             	mov    0x8(%ebp),%eax
    15fa:	89 04 24             	mov    %eax,(%esp)
    15fd:	e8 a2 fd ff ff       	call   13a4 <putc>
        putc(fd, c);
    1602:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1605:	0f be c0             	movsbl %al,%eax
    1608:	89 44 24 04          	mov    %eax,0x4(%esp)
    160c:	8b 45 08             	mov    0x8(%ebp),%eax
    160f:	89 04 24             	mov    %eax,(%esp)
    1612:	e8 8d fd ff ff       	call   13a4 <putc>
      }
      state = 0;
    1617:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    161e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1622:	8b 55 0c             	mov    0xc(%ebp),%edx
    1625:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1628:	01 d0                	add    %edx,%eax
    162a:	0f b6 00             	movzbl (%eax),%eax
    162d:	84 c0                	test   %al,%al
    162f:	0f 85 71 fe ff ff    	jne    14a6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1635:	c9                   	leave  
    1636:	c3                   	ret    
    1637:	90                   	nop

00001638 <free>:
    1638:	55                   	push   %ebp
    1639:	89 e5                	mov    %esp,%ebp
    163b:	83 ec 10             	sub    $0x10,%esp
    163e:	8b 45 08             	mov    0x8(%ebp),%eax
    1641:	83 e8 08             	sub    $0x8,%eax
    1644:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1647:	a1 58 1e 00 00       	mov    0x1e58,%eax
    164c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    164f:	eb 24                	jmp    1675 <free+0x3d>
    1651:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1654:	8b 00                	mov    (%eax),%eax
    1656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1659:	77 12                	ja     166d <free+0x35>
    165b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1661:	77 24                	ja     1687 <free+0x4f>
    1663:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1666:	8b 00                	mov    (%eax),%eax
    1668:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    166b:	77 1a                	ja     1687 <free+0x4f>
    166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1675:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1678:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    167b:	76 d4                	jbe    1651 <free+0x19>
    167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1685:	76 ca                	jbe    1651 <free+0x19>
    1687:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168a:	8b 40 04             	mov    0x4(%eax),%eax
    168d:	c1 e0 03             	shl    $0x3,%eax
    1690:	89 c2                	mov    %eax,%edx
    1692:	03 55 f8             	add    -0x8(%ebp),%edx
    1695:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1698:	8b 00                	mov    (%eax),%eax
    169a:	39 c2                	cmp    %eax,%edx
    169c:	75 24                	jne    16c2 <free+0x8a>
    169e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a1:	8b 50 04             	mov    0x4(%eax),%edx
    16a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a7:	8b 00                	mov    (%eax),%eax
    16a9:	8b 40 04             	mov    0x4(%eax),%eax
    16ac:	01 c2                	add    %eax,%edx
    16ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b1:	89 50 04             	mov    %edx,0x4(%eax)
    16b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b7:	8b 00                	mov    (%eax),%eax
    16b9:	8b 10                	mov    (%eax),%edx
    16bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16be:	89 10                	mov    %edx,(%eax)
    16c0:	eb 0a                	jmp    16cc <free+0x94>
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	8b 10                	mov    (%eax),%edx
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	89 10                	mov    %edx,(%eax)
    16cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cf:	8b 40 04             	mov    0x4(%eax),%eax
    16d2:	c1 e0 03             	shl    $0x3,%eax
    16d5:	03 45 fc             	add    -0x4(%ebp),%eax
    16d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16db:	75 20                	jne    16fd <free+0xc5>
    16dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e0:	8b 50 04             	mov    0x4(%eax),%edx
    16e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e6:	8b 40 04             	mov    0x4(%eax),%eax
    16e9:	01 c2                	add    %eax,%edx
    16eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ee:	89 50 04             	mov    %edx,0x4(%eax)
    16f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f4:	8b 10                	mov    (%eax),%edx
    16f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f9:	89 10                	mov    %edx,(%eax)
    16fb:	eb 08                	jmp    1705 <free+0xcd>
    16fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1700:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1703:	89 10                	mov    %edx,(%eax)
    1705:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1708:	a3 58 1e 00 00       	mov    %eax,0x1e58
    170d:	c9                   	leave  
    170e:	c3                   	ret    

0000170f <morecore>:
    170f:	55                   	push   %ebp
    1710:	89 e5                	mov    %esp,%ebp
    1712:	83 ec 28             	sub    $0x28,%esp
    1715:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    171c:	77 07                	ja     1725 <morecore+0x16>
    171e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1725:	8b 45 08             	mov    0x8(%ebp),%eax
    1728:	c1 e0 03             	shl    $0x3,%eax
    172b:	89 04 24             	mov    %eax,(%esp)
    172e:	e8 39 fc ff ff       	call   136c <sbrk>
    1733:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1736:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    173a:	75 07                	jne    1743 <morecore+0x34>
    173c:	b8 00 00 00 00       	mov    $0x0,%eax
    1741:	eb 22                	jmp    1765 <morecore+0x56>
    1743:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1746:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174c:	8b 55 08             	mov    0x8(%ebp),%edx
    174f:	89 50 04             	mov    %edx,0x4(%eax)
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	83 c0 08             	add    $0x8,%eax
    1758:	89 04 24             	mov    %eax,(%esp)
    175b:	e8 d8 fe ff ff       	call   1638 <free>
    1760:	a1 58 1e 00 00       	mov    0x1e58,%eax
    1765:	c9                   	leave  
    1766:	c3                   	ret    

00001767 <malloc>:
    1767:	55                   	push   %ebp
    1768:	89 e5                	mov    %esp,%ebp
    176a:	83 ec 28             	sub    $0x28,%esp
    176d:	8b 45 08             	mov    0x8(%ebp),%eax
    1770:	83 c0 07             	add    $0x7,%eax
    1773:	c1 e8 03             	shr    $0x3,%eax
    1776:	83 c0 01             	add    $0x1,%eax
    1779:	89 45 f4             	mov    %eax,-0xc(%ebp)
    177c:	a1 58 1e 00 00       	mov    0x1e58,%eax
    1781:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1784:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1788:	75 23                	jne    17ad <malloc+0x46>
    178a:	c7 45 f0 50 1e 00 00 	movl   $0x1e50,-0x10(%ebp)
    1791:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1794:	a3 58 1e 00 00       	mov    %eax,0x1e58
    1799:	a1 58 1e 00 00       	mov    0x1e58,%eax
    179e:	a3 50 1e 00 00       	mov    %eax,0x1e50
    17a3:	c7 05 54 1e 00 00 00 	movl   $0x0,0x1e54
    17aa:	00 00 00 
    17ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b0:	8b 00                	mov    (%eax),%eax
    17b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b8:	8b 40 04             	mov    0x4(%eax),%eax
    17bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17be:	72 4d                	jb     180d <malloc+0xa6>
    17c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c3:	8b 40 04             	mov    0x4(%eax),%eax
    17c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17c9:	75 0c                	jne    17d7 <malloc+0x70>
    17cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ce:	8b 10                	mov    (%eax),%edx
    17d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d3:	89 10                	mov    %edx,(%eax)
    17d5:	eb 26                	jmp    17fd <malloc+0x96>
    17d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17da:	8b 40 04             	mov    0x4(%eax),%eax
    17dd:	89 c2                	mov    %eax,%edx
    17df:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e5:	89 50 04             	mov    %edx,0x4(%eax)
    17e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17eb:	8b 40 04             	mov    0x4(%eax),%eax
    17ee:	c1 e0 03             	shl    $0x3,%eax
    17f1:	01 45 ec             	add    %eax,-0x14(%ebp)
    17f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17fa:	89 50 04             	mov    %edx,0x4(%eax)
    17fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1800:	a3 58 1e 00 00       	mov    %eax,0x1e58
    1805:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1808:	83 c0 08             	add    $0x8,%eax
    180b:	eb 38                	jmp    1845 <malloc+0xde>
    180d:	a1 58 1e 00 00       	mov    0x1e58,%eax
    1812:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1815:	75 1b                	jne    1832 <malloc+0xcb>
    1817:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181a:	89 04 24             	mov    %eax,(%esp)
    181d:	e8 ed fe ff ff       	call   170f <morecore>
    1822:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1825:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1829:	75 07                	jne    1832 <malloc+0xcb>
    182b:	b8 00 00 00 00       	mov    $0x0,%eax
    1830:	eb 13                	jmp    1845 <malloc+0xde>
    1832:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1835:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1838:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183b:	8b 00                	mov    (%eax),%eax
    183d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1840:	e9 70 ff ff ff       	jmp    17b5 <malloc+0x4e>
    1845:	c9                   	leave  
    1846:	c3                   	ret    
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
    18b8:	e8 aa fe ff ff       	call   1767 <malloc>
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
    18ec:	c7 44 24 04 e7 1a 00 	movl   $0x1ae7,0x4(%esp)
    18f3:	00 
    18f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fb:	e8 84 fb ff ff       	call   1484 <printf>
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
    1923:	e8 5c fa ff ff       	call   1384 <clone>
    1928:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    192b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    192f:	79 1b                	jns    194c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1931:	c7 44 24 04 f5 1a 00 	movl   $0x1af5,0x4(%esp)
    1938:	00 
    1939:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1940:	e8 3f fb ff ff       	call   1484 <printf>
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
    195d:	c7 44 24 04 02 1b 00 	movl   $0x1b02,0x4(%esp)
    1964:	00 
    1965:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    196c:	e8 13 fb ff ff       	call   1484 <printf>
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
    197b:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    1980:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1986:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    198b:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
    return (int)(rands % max);
    1990:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
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
    19d3:	e8 8f fd ff ff       	call   1767 <malloc>
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
    1a7e:	e8 b5 fb ff ff       	call   1638 <free>
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
