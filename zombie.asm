
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
    1009:	e8 76 02 00 00       	call   1284 <fork>
    100e:	85 c0                	test   %eax,%eax
    1010:	7e 0c                	jle    101e <main+0x1e>
    1012:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1019:	e8 fe 02 00 00       	call   131c <sleep>
    101e:	e8 69 02 00 00       	call   128c <exit>
    1023:	90                   	nop

00001024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1024:	55                   	push   %ebp
    1025:	89 e5                	mov    %esp,%ebp
    1027:	57                   	push   %edi
    1028:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1029:	8b 4d 08             	mov    0x8(%ebp),%ecx
    102c:	8b 55 10             	mov    0x10(%ebp),%edx
    102f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1032:	89 cb                	mov    %ecx,%ebx
    1034:	89 df                	mov    %ebx,%edi
    1036:	89 d1                	mov    %edx,%ecx
    1038:	fc                   	cld    
    1039:	f3 aa                	rep stos %al,%es:(%edi)
    103b:	89 ca                	mov    %ecx,%edx
    103d:	89 fb                	mov    %edi,%ebx
    103f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1042:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1045:	5b                   	pop    %ebx
    1046:	5f                   	pop    %edi
    1047:	5d                   	pop    %ebp
    1048:	c3                   	ret    

00001049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1049:	55                   	push   %ebp
    104a:	89 e5                	mov    %esp,%ebp
    104c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    104f:	8b 45 08             	mov    0x8(%ebp),%eax
    1052:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1055:	90                   	nop
    1056:	8b 45 08             	mov    0x8(%ebp),%eax
    1059:	8d 50 01             	lea    0x1(%eax),%edx
    105c:	89 55 08             	mov    %edx,0x8(%ebp)
    105f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1062:	8d 4a 01             	lea    0x1(%edx),%ecx
    1065:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1068:	0f b6 12             	movzbl (%edx),%edx
    106b:	88 10                	mov    %dl,(%eax)
    106d:	0f b6 00             	movzbl (%eax),%eax
    1070:	84 c0                	test   %al,%al
    1072:	75 e2                	jne    1056 <strcpy+0xd>
    ;
  return os;
    1074:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1077:	c9                   	leave  
    1078:	c3                   	ret    

00001079 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1079:	55                   	push   %ebp
    107a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    107c:	eb 08                	jmp    1086 <strcmp+0xd>
    p++, q++;
    107e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1082:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	0f b6 00             	movzbl (%eax),%eax
    108c:	84 c0                	test   %al,%al
    108e:	74 10                	je     10a0 <strcmp+0x27>
    1090:	8b 45 08             	mov    0x8(%ebp),%eax
    1093:	0f b6 10             	movzbl (%eax),%edx
    1096:	8b 45 0c             	mov    0xc(%ebp),%eax
    1099:	0f b6 00             	movzbl (%eax),%eax
    109c:	38 c2                	cmp    %al,%dl
    109e:	74 de                	je     107e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10a0:	8b 45 08             	mov    0x8(%ebp),%eax
    10a3:	0f b6 00             	movzbl (%eax),%eax
    10a6:	0f b6 d0             	movzbl %al,%edx
    10a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ac:	0f b6 00             	movzbl (%eax),%eax
    10af:	0f b6 c0             	movzbl %al,%eax
    10b2:	29 c2                	sub    %eax,%edx
    10b4:	89 d0                	mov    %edx,%eax
}
    10b6:	5d                   	pop    %ebp
    10b7:	c3                   	ret    

000010b8 <strlen>:

uint
strlen(char *s)
{
    10b8:	55                   	push   %ebp
    10b9:	89 e5                	mov    %esp,%ebp
    10bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10c5:	eb 04                	jmp    10cb <strlen+0x13>
    10c7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	01 d0                	add    %edx,%eax
    10d3:	0f b6 00             	movzbl (%eax),%eax
    10d6:	84 c0                	test   %al,%al
    10d8:	75 ed                	jne    10c7 <strlen+0xf>
    ;
  return n;
    10da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10dd:	c9                   	leave  
    10de:	c3                   	ret    

000010df <memset>:

void*
memset(void *dst, int c, uint n)
{
    10df:	55                   	push   %ebp
    10e0:	89 e5                	mov    %esp,%ebp
    10e2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    10e5:	8b 45 10             	mov    0x10(%ebp),%eax
    10e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	89 04 24             	mov    %eax,(%esp)
    10f9:	e8 26 ff ff ff       	call   1024 <stosb>
  return dst;
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <strchr>:

char*
strchr(const char *s, char c)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 ec 04             	sub    $0x4,%esp
    1109:	8b 45 0c             	mov    0xc(%ebp),%eax
    110c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    110f:	eb 14                	jmp    1125 <strchr+0x22>
    if(*s == c)
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	0f b6 00             	movzbl (%eax),%eax
    1117:	3a 45 fc             	cmp    -0x4(%ebp),%al
    111a:	75 05                	jne    1121 <strchr+0x1e>
      return (char*)s;
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	eb 13                	jmp    1134 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	0f b6 00             	movzbl (%eax),%eax
    112b:	84 c0                	test   %al,%al
    112d:	75 e2                	jne    1111 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    112f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1134:	c9                   	leave  
    1135:	c3                   	ret    

00001136 <gets>:

char*
gets(char *buf, int max)
{
    1136:	55                   	push   %ebp
    1137:	89 e5                	mov    %esp,%ebp
    1139:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    113c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1143:	eb 4c                	jmp    1191 <gets+0x5b>
    cc = read(0, &c, 1);
    1145:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    114c:	00 
    114d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1150:	89 44 24 04          	mov    %eax,0x4(%esp)
    1154:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115b:	e8 44 01 00 00       	call   12a4 <read>
    1160:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1163:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1167:	7f 02                	jg     116b <gets+0x35>
      break;
    1169:	eb 31                	jmp    119c <gets+0x66>
    buf[i++] = c;
    116b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116e:	8d 50 01             	lea    0x1(%eax),%edx
    1171:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1174:	89 c2                	mov    %eax,%edx
    1176:	8b 45 08             	mov    0x8(%ebp),%eax
    1179:	01 c2                	add    %eax,%edx
    117b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    117f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1181:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1185:	3c 0a                	cmp    $0xa,%al
    1187:	74 13                	je     119c <gets+0x66>
    1189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    118d:	3c 0d                	cmp    $0xd,%al
    118f:	74 0b                	je     119c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1191:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1194:	83 c0 01             	add    $0x1,%eax
    1197:	3b 45 0c             	cmp    0xc(%ebp),%eax
    119a:	7c a9                	jl     1145 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    119c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
    11a2:	01 d0                	add    %edx,%eax
    11a4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11aa:	c9                   	leave  
    11ab:	c3                   	ret    

000011ac <stat>:

int
stat(char *n, struct stat *st)
{
    11ac:	55                   	push   %ebp
    11ad:	89 e5                	mov    %esp,%ebp
    11af:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11b2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11b9:	00 
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	89 04 24             	mov    %eax,(%esp)
    11c0:	e8 07 01 00 00       	call   12cc <open>
    11c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11cc:	79 07                	jns    11d5 <stat+0x29>
    return -1;
    11ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11d3:	eb 23                	jmp    11f8 <stat+0x4c>
  r = fstat(fd, st);
    11d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11df:	89 04 24             	mov    %eax,(%esp)
    11e2:	e8 fd 00 00 00       	call   12e4 <fstat>
    11e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    11ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ed:	89 04 24             	mov    %eax,(%esp)
    11f0:	e8 bf 00 00 00       	call   12b4 <close>
  return r;
    11f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    11f8:	c9                   	leave  
    11f9:	c3                   	ret    

000011fa <atoi>:

int
atoi(const char *s)
{
    11fa:	55                   	push   %ebp
    11fb:	89 e5                	mov    %esp,%ebp
    11fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1200:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1207:	eb 25                	jmp    122e <atoi+0x34>
    n = n*10 + *s++ - '0';
    1209:	8b 55 fc             	mov    -0x4(%ebp),%edx
    120c:	89 d0                	mov    %edx,%eax
    120e:	c1 e0 02             	shl    $0x2,%eax
    1211:	01 d0                	add    %edx,%eax
    1213:	01 c0                	add    %eax,%eax
    1215:	89 c1                	mov    %eax,%ecx
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	8d 50 01             	lea    0x1(%eax),%edx
    121d:	89 55 08             	mov    %edx,0x8(%ebp)
    1220:	0f b6 00             	movzbl (%eax),%eax
    1223:	0f be c0             	movsbl %al,%eax
    1226:	01 c8                	add    %ecx,%eax
    1228:	83 e8 30             	sub    $0x30,%eax
    122b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    122e:	8b 45 08             	mov    0x8(%ebp),%eax
    1231:	0f b6 00             	movzbl (%eax),%eax
    1234:	3c 2f                	cmp    $0x2f,%al
    1236:	7e 0a                	jle    1242 <atoi+0x48>
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	0f b6 00             	movzbl (%eax),%eax
    123e:	3c 39                	cmp    $0x39,%al
    1240:	7e c7                	jle    1209 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1242:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1245:	c9                   	leave  
    1246:	c3                   	ret    

00001247 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1247:	55                   	push   %ebp
    1248:	89 e5                	mov    %esp,%ebp
    124a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1253:	8b 45 0c             	mov    0xc(%ebp),%eax
    1256:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1259:	eb 17                	jmp    1272 <memmove+0x2b>
    *dst++ = *src++;
    125b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125e:	8d 50 01             	lea    0x1(%eax),%edx
    1261:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1264:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1267:	8d 4a 01             	lea    0x1(%edx),%ecx
    126a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    126d:	0f b6 12             	movzbl (%edx),%edx
    1270:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1272:	8b 45 10             	mov    0x10(%ebp),%eax
    1275:	8d 50 ff             	lea    -0x1(%eax),%edx
    1278:	89 55 10             	mov    %edx,0x10(%ebp)
    127b:	85 c0                	test   %eax,%eax
    127d:	7f dc                	jg     125b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1282:	c9                   	leave  
    1283:	c3                   	ret    

00001284 <fork>:
    1284:	b8 01 00 00 00       	mov    $0x1,%eax
    1289:	cd 40                	int    $0x40
    128b:	c3                   	ret    

0000128c <exit>:
    128c:	b8 02 00 00 00       	mov    $0x2,%eax
    1291:	cd 40                	int    $0x40
    1293:	c3                   	ret    

00001294 <wait>:
    1294:	b8 03 00 00 00       	mov    $0x3,%eax
    1299:	cd 40                	int    $0x40
    129b:	c3                   	ret    

0000129c <pipe>:
    129c:	b8 04 00 00 00       	mov    $0x4,%eax
    12a1:	cd 40                	int    $0x40
    12a3:	c3                   	ret    

000012a4 <read>:
    12a4:	b8 05 00 00 00       	mov    $0x5,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <write>:
    12ac:	b8 10 00 00 00       	mov    $0x10,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <close>:
    12b4:	b8 15 00 00 00       	mov    $0x15,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <kill>:
    12bc:	b8 06 00 00 00       	mov    $0x6,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <exec>:
    12c4:	b8 07 00 00 00       	mov    $0x7,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <open>:
    12cc:	b8 0f 00 00 00       	mov    $0xf,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <mknod>:
    12d4:	b8 11 00 00 00       	mov    $0x11,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <unlink>:
    12dc:	b8 12 00 00 00       	mov    $0x12,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <fstat>:
    12e4:	b8 08 00 00 00       	mov    $0x8,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <link>:
    12ec:	b8 13 00 00 00       	mov    $0x13,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <mkdir>:
    12f4:	b8 14 00 00 00       	mov    $0x14,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <chdir>:
    12fc:	b8 09 00 00 00       	mov    $0x9,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <dup>:
    1304:	b8 0a 00 00 00       	mov    $0xa,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <getpid>:
    130c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <sbrk>:
    1314:	b8 0c 00 00 00       	mov    $0xc,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <sleep>:
    131c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <uptime>:
    1324:	b8 0e 00 00 00       	mov    $0xe,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <clone>:
    132c:	b8 16 00 00 00       	mov    $0x16,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <texit>:
    1334:	b8 17 00 00 00       	mov    $0x17,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <tsleep>:
    133c:	b8 18 00 00 00       	mov    $0x18,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <twakeup>:
    1344:	b8 19 00 00 00       	mov    $0x19,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    134c:	55                   	push   %ebp
    134d:	89 e5                	mov    %esp,%ebp
    134f:	83 ec 18             	sub    $0x18,%esp
    1352:	8b 45 0c             	mov    0xc(%ebp),%eax
    1355:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1358:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    135f:	00 
    1360:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1363:	89 44 24 04          	mov    %eax,0x4(%esp)
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
    136a:	89 04 24             	mov    %eax,(%esp)
    136d:	e8 3a ff ff ff       	call   12ac <write>
}
    1372:	c9                   	leave  
    1373:	c3                   	ret    

00001374 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1374:	55                   	push   %ebp
    1375:	89 e5                	mov    %esp,%ebp
    1377:	56                   	push   %esi
    1378:	53                   	push   %ebx
    1379:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    137c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1383:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1387:	74 17                	je     13a0 <printint+0x2c>
    1389:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    138d:	79 11                	jns    13a0 <printint+0x2c>
    neg = 1;
    138f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1396:	8b 45 0c             	mov    0xc(%ebp),%eax
    1399:	f7 d8                	neg    %eax
    139b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    139e:	eb 06                	jmp    13a6 <printint+0x32>
  } else {
    x = xx;
    13a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13ad:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b0:	8d 41 01             	lea    0x1(%ecx),%eax
    13b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13bc:	ba 00 00 00 00       	mov    $0x0,%edx
    13c1:	f7 f3                	div    %ebx
    13c3:	89 d0                	mov    %edx,%eax
    13c5:	0f b6 80 9c 1d 00 00 	movzbl 0x1d9c(%eax),%eax
    13cc:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    13d0:	8b 75 10             	mov    0x10(%ebp),%esi
    13d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13d6:	ba 00 00 00 00       	mov    $0x0,%edx
    13db:	f7 f6                	div    %esi
    13dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13e4:	75 c7                	jne    13ad <printint+0x39>
  if(neg)
    13e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13ea:	74 10                	je     13fc <printint+0x88>
    buf[i++] = '-';
    13ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ef:	8d 50 01             	lea    0x1(%eax),%edx
    13f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13f5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    13fa:	eb 1f                	jmp    141b <printint+0xa7>
    13fc:	eb 1d                	jmp    141b <printint+0xa7>
    putc(fd, buf[i]);
    13fe:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1401:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1404:	01 d0                	add    %edx,%eax
    1406:	0f b6 00             	movzbl (%eax),%eax
    1409:	0f be c0             	movsbl %al,%eax
    140c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1410:	8b 45 08             	mov    0x8(%ebp),%eax
    1413:	89 04 24             	mov    %eax,(%esp)
    1416:	e8 31 ff ff ff       	call   134c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    141b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    141f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1423:	79 d9                	jns    13fe <printint+0x8a>
    putc(fd, buf[i]);
}
    1425:	83 c4 30             	add    $0x30,%esp
    1428:	5b                   	pop    %ebx
    1429:	5e                   	pop    %esi
    142a:	5d                   	pop    %ebp
    142b:	c3                   	ret    

0000142c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    142c:	55                   	push   %ebp
    142d:	89 e5                	mov    %esp,%ebp
    142f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1432:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1439:	8d 45 0c             	lea    0xc(%ebp),%eax
    143c:	83 c0 04             	add    $0x4,%eax
    143f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1442:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1449:	e9 7c 01 00 00       	jmp    15ca <printf+0x19e>
    c = fmt[i] & 0xff;
    144e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1451:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1454:	01 d0                	add    %edx,%eax
    1456:	0f b6 00             	movzbl (%eax),%eax
    1459:	0f be c0             	movsbl %al,%eax
    145c:	25 ff 00 00 00       	and    $0xff,%eax
    1461:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1464:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1468:	75 2c                	jne    1496 <printf+0x6a>
      if(c == '%'){
    146a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    146e:	75 0c                	jne    147c <printf+0x50>
        state = '%';
    1470:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1477:	e9 4a 01 00 00       	jmp    15c6 <printf+0x19a>
      } else {
        putc(fd, c);
    147c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    147f:	0f be c0             	movsbl %al,%eax
    1482:	89 44 24 04          	mov    %eax,0x4(%esp)
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	89 04 24             	mov    %eax,(%esp)
    148c:	e8 bb fe ff ff       	call   134c <putc>
    1491:	e9 30 01 00 00       	jmp    15c6 <printf+0x19a>
      }
    } else if(state == '%'){
    1496:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    149a:	0f 85 26 01 00 00    	jne    15c6 <printf+0x19a>
      if(c == 'd'){
    14a0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14a4:	75 2d                	jne    14d3 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14a9:	8b 00                	mov    (%eax),%eax
    14ab:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14b2:	00 
    14b3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14ba:	00 
    14bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    14bf:	8b 45 08             	mov    0x8(%ebp),%eax
    14c2:	89 04 24             	mov    %eax,(%esp)
    14c5:	e8 aa fe ff ff       	call   1374 <printint>
        ap++;
    14ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14ce:	e9 ec 00 00 00       	jmp    15bf <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    14d3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14d7:	74 06                	je     14df <printf+0xb3>
    14d9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    14dd:	75 2d                	jne    150c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    14df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14e2:	8b 00                	mov    (%eax),%eax
    14e4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14eb:	00 
    14ec:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    14f3:	00 
    14f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    14f8:	8b 45 08             	mov    0x8(%ebp),%eax
    14fb:	89 04 24             	mov    %eax,(%esp)
    14fe:	e8 71 fe ff ff       	call   1374 <printint>
        ap++;
    1503:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1507:	e9 b3 00 00 00       	jmp    15bf <printf+0x193>
      } else if(c == 's'){
    150c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1510:	75 45                	jne    1557 <printf+0x12b>
        s = (char*)*ap;
    1512:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1515:	8b 00                	mov    (%eax),%eax
    1517:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    151a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    151e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1522:	75 09                	jne    152d <printf+0x101>
          s = "(null)";
    1524:	c7 45 f4 61 1a 00 00 	movl   $0x1a61,-0xc(%ebp)
        while(*s != 0){
    152b:	eb 1e                	jmp    154b <printf+0x11f>
    152d:	eb 1c                	jmp    154b <printf+0x11f>
          putc(fd, *s);
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	0f b6 00             	movzbl (%eax),%eax
    1535:	0f be c0             	movsbl %al,%eax
    1538:	89 44 24 04          	mov    %eax,0x4(%esp)
    153c:	8b 45 08             	mov    0x8(%ebp),%eax
    153f:	89 04 24             	mov    %eax,(%esp)
    1542:	e8 05 fe ff ff       	call   134c <putc>
          s++;
    1547:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    154b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154e:	0f b6 00             	movzbl (%eax),%eax
    1551:	84 c0                	test   %al,%al
    1553:	75 da                	jne    152f <printf+0x103>
    1555:	eb 68                	jmp    15bf <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1557:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    155b:	75 1d                	jne    157a <printf+0x14e>
        putc(fd, *ap);
    155d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1560:	8b 00                	mov    (%eax),%eax
    1562:	0f be c0             	movsbl %al,%eax
    1565:	89 44 24 04          	mov    %eax,0x4(%esp)
    1569:	8b 45 08             	mov    0x8(%ebp),%eax
    156c:	89 04 24             	mov    %eax,(%esp)
    156f:	e8 d8 fd ff ff       	call   134c <putc>
        ap++;
    1574:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1578:	eb 45                	jmp    15bf <printf+0x193>
      } else if(c == '%'){
    157a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    157e:	75 17                	jne    1597 <printf+0x16b>
        putc(fd, c);
    1580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1583:	0f be c0             	movsbl %al,%eax
    1586:	89 44 24 04          	mov    %eax,0x4(%esp)
    158a:	8b 45 08             	mov    0x8(%ebp),%eax
    158d:	89 04 24             	mov    %eax,(%esp)
    1590:	e8 b7 fd ff ff       	call   134c <putc>
    1595:	eb 28                	jmp    15bf <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1597:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    159e:	00 
    159f:	8b 45 08             	mov    0x8(%ebp),%eax
    15a2:	89 04 24             	mov    %eax,(%esp)
    15a5:	e8 a2 fd ff ff       	call   134c <putc>
        putc(fd, c);
    15aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ad:	0f be c0             	movsbl %al,%eax
    15b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b4:	8b 45 08             	mov    0x8(%ebp),%eax
    15b7:	89 04 24             	mov    %eax,(%esp)
    15ba:	e8 8d fd ff ff       	call   134c <putc>
      }
      state = 0;
    15bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15c6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15ca:	8b 55 0c             	mov    0xc(%ebp),%edx
    15cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d0:	01 d0                	add    %edx,%eax
    15d2:	0f b6 00             	movzbl (%eax),%eax
    15d5:	84 c0                	test   %al,%al
    15d7:	0f 85 71 fe ff ff    	jne    144e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15dd:	c9                   	leave  
    15de:	c3                   	ret    
    15df:	90                   	nop

000015e0 <free>:
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	83 ec 10             	sub    $0x10,%esp
    15e6:	8b 45 08             	mov    0x8(%ebp),%eax
    15e9:	83 e8 08             	sub    $0x8,%eax
    15ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
    15ef:	a1 bc 1d 00 00       	mov    0x1dbc,%eax
    15f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15f7:	eb 24                	jmp    161d <free+0x3d>
    15f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15fc:	8b 00                	mov    (%eax),%eax
    15fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1601:	77 12                	ja     1615 <free+0x35>
    1603:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1609:	77 24                	ja     162f <free+0x4f>
    160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    160e:	8b 00                	mov    (%eax),%eax
    1610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1613:	77 1a                	ja     162f <free+0x4f>
    1615:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1618:	8b 00                	mov    (%eax),%eax
    161a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    161d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1623:	76 d4                	jbe    15f9 <free+0x19>
    1625:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1628:	8b 00                	mov    (%eax),%eax
    162a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    162d:	76 ca                	jbe    15f9 <free+0x19>
    162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1632:	8b 40 04             	mov    0x4(%eax),%eax
    1635:	c1 e0 03             	shl    $0x3,%eax
    1638:	89 c2                	mov    %eax,%edx
    163a:	03 55 f8             	add    -0x8(%ebp),%edx
    163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1640:	8b 00                	mov    (%eax),%eax
    1642:	39 c2                	cmp    %eax,%edx
    1644:	75 24                	jne    166a <free+0x8a>
    1646:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1649:	8b 50 04             	mov    0x4(%eax),%edx
    164c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164f:	8b 00                	mov    (%eax),%eax
    1651:	8b 40 04             	mov    0x4(%eax),%eax
    1654:	01 c2                	add    %eax,%edx
    1656:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1659:	89 50 04             	mov    %edx,0x4(%eax)
    165c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165f:	8b 00                	mov    (%eax),%eax
    1661:	8b 10                	mov    (%eax),%edx
    1663:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1666:	89 10                	mov    %edx,(%eax)
    1668:	eb 0a                	jmp    1674 <free+0x94>
    166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166d:	8b 10                	mov    (%eax),%edx
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	89 10                	mov    %edx,(%eax)
    1674:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1677:	8b 40 04             	mov    0x4(%eax),%eax
    167a:	c1 e0 03             	shl    $0x3,%eax
    167d:	03 45 fc             	add    -0x4(%ebp),%eax
    1680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1683:	75 20                	jne    16a5 <free+0xc5>
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	8b 50 04             	mov    0x4(%eax),%edx
    168b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168e:	8b 40 04             	mov    0x4(%eax),%eax
    1691:	01 c2                	add    %eax,%edx
    1693:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1696:	89 50 04             	mov    %edx,0x4(%eax)
    1699:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169c:	8b 10                	mov    (%eax),%edx
    169e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a1:	89 10                	mov    %edx,(%eax)
    16a3:	eb 08                	jmp    16ad <free+0xcd>
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ab:	89 10                	mov    %edx,(%eax)
    16ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b0:	a3 bc 1d 00 00       	mov    %eax,0x1dbc
    16b5:	c9                   	leave  
    16b6:	c3                   	ret    

000016b7 <morecore>:
    16b7:	55                   	push   %ebp
    16b8:	89 e5                	mov    %esp,%ebp
    16ba:	83 ec 28             	sub    $0x28,%esp
    16bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16c4:	77 07                	ja     16cd <morecore+0x16>
    16c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
    16d0:	c1 e0 03             	shl    $0x3,%eax
    16d3:	89 04 24             	mov    %eax,(%esp)
    16d6:	e8 39 fc ff ff       	call   1314 <sbrk>
    16db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    16de:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    16e2:	75 07                	jne    16eb <morecore+0x34>
    16e4:	b8 00 00 00 00       	mov    $0x0,%eax
    16e9:	eb 22                	jmp    170d <morecore+0x56>
    16eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f4:	8b 55 08             	mov    0x8(%ebp),%edx
    16f7:	89 50 04             	mov    %edx,0x4(%eax)
    16fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fd:	83 c0 08             	add    $0x8,%eax
    1700:	89 04 24             	mov    %eax,(%esp)
    1703:	e8 d8 fe ff ff       	call   15e0 <free>
    1708:	a1 bc 1d 00 00       	mov    0x1dbc,%eax
    170d:	c9                   	leave  
    170e:	c3                   	ret    

0000170f <malloc>:
    170f:	55                   	push   %ebp
    1710:	89 e5                	mov    %esp,%ebp
    1712:	83 ec 28             	sub    $0x28,%esp
    1715:	8b 45 08             	mov    0x8(%ebp),%eax
    1718:	83 c0 07             	add    $0x7,%eax
    171b:	c1 e8 03             	shr    $0x3,%eax
    171e:	83 c0 01             	add    $0x1,%eax
    1721:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1724:	a1 bc 1d 00 00       	mov    0x1dbc,%eax
    1729:	89 45 f0             	mov    %eax,-0x10(%ebp)
    172c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1730:	75 23                	jne    1755 <malloc+0x46>
    1732:	c7 45 f0 b4 1d 00 00 	movl   $0x1db4,-0x10(%ebp)
    1739:	8b 45 f0             	mov    -0x10(%ebp),%eax
    173c:	a3 bc 1d 00 00       	mov    %eax,0x1dbc
    1741:	a1 bc 1d 00 00       	mov    0x1dbc,%eax
    1746:	a3 b4 1d 00 00       	mov    %eax,0x1db4
    174b:	c7 05 b8 1d 00 00 00 	movl   $0x0,0x1db8
    1752:	00 00 00 
    1755:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1758:	8b 00                	mov    (%eax),%eax
    175a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    175d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1760:	8b 40 04             	mov    0x4(%eax),%eax
    1763:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1766:	72 4d                	jb     17b5 <malloc+0xa6>
    1768:	8b 45 ec             	mov    -0x14(%ebp),%eax
    176b:	8b 40 04             	mov    0x4(%eax),%eax
    176e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1771:	75 0c                	jne    177f <malloc+0x70>
    1773:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1776:	8b 10                	mov    (%eax),%edx
    1778:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177b:	89 10                	mov    %edx,(%eax)
    177d:	eb 26                	jmp    17a5 <malloc+0x96>
    177f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1782:	8b 40 04             	mov    0x4(%eax),%eax
    1785:	89 c2                	mov    %eax,%edx
    1787:	2b 55 f4             	sub    -0xc(%ebp),%edx
    178a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178d:	89 50 04             	mov    %edx,0x4(%eax)
    1790:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1793:	8b 40 04             	mov    0x4(%eax),%eax
    1796:	c1 e0 03             	shl    $0x3,%eax
    1799:	01 45 ec             	add    %eax,-0x14(%ebp)
    179c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17a2:	89 50 04             	mov    %edx,0x4(%eax)
    17a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a8:	a3 bc 1d 00 00       	mov    %eax,0x1dbc
    17ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b0:	83 c0 08             	add    $0x8,%eax
    17b3:	eb 38                	jmp    17ed <malloc+0xde>
    17b5:	a1 bc 1d 00 00       	mov    0x1dbc,%eax
    17ba:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17bd:	75 1b                	jne    17da <malloc+0xcb>
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	89 04 24             	mov    %eax,(%esp)
    17c5:	e8 ed fe ff ff       	call   16b7 <morecore>
    17ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17d1:	75 07                	jne    17da <malloc+0xcb>
    17d3:	b8 00 00 00 00       	mov    $0x0,%eax
    17d8:	eb 13                	jmp    17ed <malloc+0xde>
    17da:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e3:	8b 00                	mov    (%eax),%eax
    17e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17e8:	e9 70 ff ff ff       	jmp    175d <malloc+0x4e>
    17ed:	c9                   	leave  
    17ee:	c3                   	ret    
    17ef:	90                   	nop

000017f0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    17f6:	8b 55 08             	mov    0x8(%ebp),%edx
    17f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    17fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    17ff:	f0 87 02             	lock xchg %eax,(%edx)
    1802:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1805:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1808:	c9                   	leave  
    1809:	c3                   	ret    

0000180a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    180a:	55                   	push   %ebp
    180b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    180d:	8b 45 08             	mov    0x8(%ebp),%eax
    1810:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1816:	5d                   	pop    %ebp
    1817:	c3                   	ret    

00001818 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1818:	55                   	push   %ebp
    1819:	89 e5                	mov    %esp,%ebp
    181b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    181e:	90                   	nop
    181f:	8b 45 08             	mov    0x8(%ebp),%eax
    1822:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1829:	00 
    182a:	89 04 24             	mov    %eax,(%esp)
    182d:	e8 be ff ff ff       	call   17f0 <xchg>
    1832:	85 c0                	test   %eax,%eax
    1834:	75 e9                	jne    181f <lock_acquire+0x7>
}
    1836:	c9                   	leave  
    1837:	c3                   	ret    

00001838 <lock_release>:
void lock_release(lock_t *lock){
    1838:	55                   	push   %ebp
    1839:	89 e5                	mov    %esp,%ebp
    183b:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    183e:	8b 45 08             	mov    0x8(%ebp),%eax
    1841:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1848:	00 
    1849:	89 04 24             	mov    %eax,(%esp)
    184c:	e8 9f ff ff ff       	call   17f0 <xchg>
}
    1851:	c9                   	leave  
    1852:	c3                   	ret    

00001853 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1853:	55                   	push   %ebp
    1854:	89 e5                	mov    %esp,%ebp
    1856:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1859:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1860:	e8 aa fe ff ff       	call   170f <malloc>
    1865:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1868:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1871:	25 ff 0f 00 00       	and    $0xfff,%eax
    1876:	85 c0                	test   %eax,%eax
    1878:	74 14                	je     188e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    187a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1882:	89 c2                	mov    %eax,%edx
    1884:	b8 00 10 00 00       	mov    $0x1000,%eax
    1889:	29 d0                	sub    %edx,%eax
    188b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    188e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1892:	75 1b                	jne    18af <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1894:	c7 44 24 04 68 1a 00 	movl   $0x1a68,0x4(%esp)
    189b:	00 
    189c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18a3:	e8 84 fb ff ff       	call   142c <printf>
        return 0;
    18a8:	b8 00 00 00 00       	mov    $0x0,%eax
    18ad:	eb 6f                	jmp    191e <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18af:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18b2:	8b 55 08             	mov    0x8(%ebp),%edx
    18b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18bc:	89 54 24 08          	mov    %edx,0x8(%esp)
    18c0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18c7:	00 
    18c8:	89 04 24             	mov    %eax,(%esp)
    18cb:	e8 5c fa ff ff       	call   132c <clone>
    18d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18d7:	79 1b                	jns    18f4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    18d9:	c7 44 24 04 76 1a 00 	movl   $0x1a76,0x4(%esp)
    18e0:	00 
    18e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e8:	e8 3f fb ff ff       	call   142c <printf>
        return 0;
    18ed:	b8 00 00 00 00       	mov    $0x0,%eax
    18f2:	eb 2a                	jmp    191e <thread_create+0xcb>
    }
    if(tid > 0){
    18f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18f8:	7e 05                	jle    18ff <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    18fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18fd:	eb 1f                	jmp    191e <thread_create+0xcb>
    }
    if(tid == 0){
    18ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1903:	75 14                	jne    1919 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1905:	c7 44 24 04 83 1a 00 	movl   $0x1a83,0x4(%esp)
    190c:	00 
    190d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1914:	e8 13 fb ff ff       	call   142c <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1919:	b8 00 00 00 00       	mov    $0x0,%eax
}
    191e:	c9                   	leave  
    191f:	c3                   	ret    

00001920 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1923:	a1 b0 1d 00 00       	mov    0x1db0,%eax
    1928:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    192e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1933:	a3 b0 1d 00 00       	mov    %eax,0x1db0
    return (int)(rands % max);
    1938:	a1 b0 1d 00 00       	mov    0x1db0,%eax
    193d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1940:	ba 00 00 00 00       	mov    $0x0,%edx
    1945:	f7 f1                	div    %ecx
    1947:	89 d0                	mov    %edx,%eax
}
    1949:	5d                   	pop    %ebp
    194a:	c3                   	ret    
    194b:	90                   	nop

0000194c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    194c:	55                   	push   %ebp
    194d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    194f:	8b 45 08             	mov    0x8(%ebp),%eax
    1952:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1958:	8b 45 08             	mov    0x8(%ebp),%eax
    195b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1962:	8b 45 08             	mov    0x8(%ebp),%eax
    1965:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    196c:	5d                   	pop    %ebp
    196d:	c3                   	ret    

0000196e <add_q>:

void add_q(struct queue *q, int v){
    196e:	55                   	push   %ebp
    196f:	89 e5                	mov    %esp,%ebp
    1971:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1974:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    197b:	e8 8f fd ff ff       	call   170f <malloc>
    1980:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1983:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1986:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    198d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1990:	8b 55 0c             	mov    0xc(%ebp),%edx
    1993:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1995:	8b 45 08             	mov    0x8(%ebp),%eax
    1998:	8b 40 04             	mov    0x4(%eax),%eax
    199b:	85 c0                	test   %eax,%eax
    199d:	75 0b                	jne    19aa <add_q+0x3c>
        q->head = n;
    199f:	8b 45 08             	mov    0x8(%ebp),%eax
    19a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19a5:	89 50 04             	mov    %edx,0x4(%eax)
    19a8:	eb 0c                	jmp    19b6 <add_q+0x48>
    }else{
        q->tail->next = n;
    19aa:	8b 45 08             	mov    0x8(%ebp),%eax
    19ad:	8b 40 08             	mov    0x8(%eax),%eax
    19b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19b3:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19bc:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19bf:	8b 45 08             	mov    0x8(%ebp),%eax
    19c2:	8b 00                	mov    (%eax),%eax
    19c4:	8d 50 01             	lea    0x1(%eax),%edx
    19c7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ca:	89 10                	mov    %edx,(%eax)
}
    19cc:	c9                   	leave  
    19cd:	c3                   	ret    

000019ce <empty_q>:

int empty_q(struct queue *q){
    19ce:	55                   	push   %ebp
    19cf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	8b 00                	mov    (%eax),%eax
    19d6:	85 c0                	test   %eax,%eax
    19d8:	75 07                	jne    19e1 <empty_q+0x13>
        return 1;
    19da:	b8 01 00 00 00       	mov    $0x1,%eax
    19df:	eb 05                	jmp    19e6 <empty_q+0x18>
    else
        return 0;
    19e1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    19e6:	5d                   	pop    %ebp
    19e7:	c3                   	ret    

000019e8 <pop_q>:
int pop_q(struct queue *q){
    19e8:	55                   	push   %ebp
    19e9:	89 e5                	mov    %esp,%ebp
    19eb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	89 04 24             	mov    %eax,(%esp)
    19f4:	e8 d5 ff ff ff       	call   19ce <empty_q>
    19f9:	85 c0                	test   %eax,%eax
    19fb:	75 5d                	jne    1a5a <pop_q+0x72>
       val = q->head->value; 
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	8b 40 04             	mov    0x4(%eax),%eax
    1a03:	8b 00                	mov    (%eax),%eax
    1a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a08:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0b:	8b 40 04             	mov    0x4(%eax),%eax
    1a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 40 04             	mov    0x4(%eax),%eax
    1a17:	8b 50 04             	mov    0x4(%eax),%edx
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a23:	89 04 24             	mov    %eax,(%esp)
    1a26:	e8 b5 fb ff ff       	call   15e0 <free>
       q->size--;
    1a2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2e:	8b 00                	mov    (%eax),%eax
    1a30:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a38:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3b:	8b 00                	mov    (%eax),%eax
    1a3d:	85 c0                	test   %eax,%eax
    1a3f:	75 14                	jne    1a55 <pop_q+0x6d>
            q->head = 0;
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a58:	eb 05                	jmp    1a5f <pop_q+0x77>
    }
    return -1;
    1a5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a5f:	c9                   	leave  
    1a60:	c3                   	ret    
