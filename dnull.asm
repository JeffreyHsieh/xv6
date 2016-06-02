
_dnull:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int *null = 0;
    1009:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1010:	00 
  printf(1,"Dereferencing Null Pointer\n");
    1011:	c7 44 24 04 85 1a 00 	movl   $0x1a85,0x4(%esp)
    1018:	00 
    1019:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1020:	e8 2b 04 00 00       	call   1450 <printf>
  printf(1,"%d\n", *null);
    1025:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1029:	8b 00                	mov    (%eax),%eax
    102b:	89 44 24 08          	mov    %eax,0x8(%esp)
    102f:	c7 44 24 04 a1 1a 00 	movl   $0x1aa1,0x4(%esp)
    1036:	00 
    1037:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103e:	e8 0d 04 00 00       	call   1450 <printf>

  exit();
    1043:	e8 68 02 00 00       	call   12b0 <exit>

00001048 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1048:	55                   	push   %ebp
    1049:	89 e5                	mov    %esp,%ebp
    104b:	57                   	push   %edi
    104c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    104d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1050:	8b 55 10             	mov    0x10(%ebp),%edx
    1053:	8b 45 0c             	mov    0xc(%ebp),%eax
    1056:	89 cb                	mov    %ecx,%ebx
    1058:	89 df                	mov    %ebx,%edi
    105a:	89 d1                	mov    %edx,%ecx
    105c:	fc                   	cld    
    105d:	f3 aa                	rep stos %al,%es:(%edi)
    105f:	89 ca                	mov    %ecx,%edx
    1061:	89 fb                	mov    %edi,%ebx
    1063:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1066:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1069:	5b                   	pop    %ebx
    106a:	5f                   	pop    %edi
    106b:	5d                   	pop    %ebp
    106c:	c3                   	ret    

0000106d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    106d:	55                   	push   %ebp
    106e:	89 e5                	mov    %esp,%ebp
    1070:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1073:	8b 45 08             	mov    0x8(%ebp),%eax
    1076:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1079:	90                   	nop
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	8d 50 01             	lea    0x1(%eax),%edx
    1080:	89 55 08             	mov    %edx,0x8(%ebp)
    1083:	8b 55 0c             	mov    0xc(%ebp),%edx
    1086:	8d 4a 01             	lea    0x1(%edx),%ecx
    1089:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    108c:	0f b6 12             	movzbl (%edx),%edx
    108f:	88 10                	mov    %dl,(%eax)
    1091:	0f b6 00             	movzbl (%eax),%eax
    1094:	84 c0                	test   %al,%al
    1096:	75 e2                	jne    107a <strcpy+0xd>
    ;
  return os;
    1098:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    109b:	c9                   	leave  
    109c:	c3                   	ret    

0000109d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    109d:	55                   	push   %ebp
    109e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10a0:	eb 08                	jmp    10aa <strcmp+0xd>
    p++, q++;
    10a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10a6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10aa:	8b 45 08             	mov    0x8(%ebp),%eax
    10ad:	0f b6 00             	movzbl (%eax),%eax
    10b0:	84 c0                	test   %al,%al
    10b2:	74 10                	je     10c4 <strcmp+0x27>
    10b4:	8b 45 08             	mov    0x8(%ebp),%eax
    10b7:	0f b6 10             	movzbl (%eax),%edx
    10ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    10bd:	0f b6 00             	movzbl (%eax),%eax
    10c0:	38 c2                	cmp    %al,%dl
    10c2:	74 de                	je     10a2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	0f b6 00             	movzbl (%eax),%eax
    10ca:	0f b6 d0             	movzbl %al,%edx
    10cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d0:	0f b6 00             	movzbl (%eax),%eax
    10d3:	0f b6 c0             	movzbl %al,%eax
    10d6:	29 c2                	sub    %eax,%edx
    10d8:	89 d0                	mov    %edx,%eax
}
    10da:	5d                   	pop    %ebp
    10db:	c3                   	ret    

000010dc <strlen>:

uint
strlen(char *s)
{
    10dc:	55                   	push   %ebp
    10dd:	89 e5                	mov    %esp,%ebp
    10df:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10e9:	eb 04                	jmp    10ef <strlen+0x13>
    10eb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	01 d0                	add    %edx,%eax
    10f7:	0f b6 00             	movzbl (%eax),%eax
    10fa:	84 c0                	test   %al,%al
    10fc:	75 ed                	jne    10eb <strlen+0xf>
    ;
  return n;
    10fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1109:	8b 45 10             	mov    0x10(%ebp),%eax
    110c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1110:	8b 45 0c             	mov    0xc(%ebp),%eax
    1113:	89 44 24 04          	mov    %eax,0x4(%esp)
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	89 04 24             	mov    %eax,(%esp)
    111d:	e8 26 ff ff ff       	call   1048 <stosb>
  return dst;
    1122:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1125:	c9                   	leave  
    1126:	c3                   	ret    

00001127 <strchr>:

char*
strchr(const char *s, char c)
{
    1127:	55                   	push   %ebp
    1128:	89 e5                	mov    %esp,%ebp
    112a:	83 ec 04             	sub    $0x4,%esp
    112d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1130:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1133:	eb 14                	jmp    1149 <strchr+0x22>
    if(*s == c)
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	0f b6 00             	movzbl (%eax),%eax
    113b:	3a 45 fc             	cmp    -0x4(%ebp),%al
    113e:	75 05                	jne    1145 <strchr+0x1e>
      return (char*)s;
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	eb 13                	jmp    1158 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1145:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	0f b6 00             	movzbl (%eax),%eax
    114f:	84 c0                	test   %al,%al
    1151:	75 e2                	jne    1135 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1153:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1158:	c9                   	leave  
    1159:	c3                   	ret    

0000115a <gets>:

char*
gets(char *buf, int max)
{
    115a:	55                   	push   %ebp
    115b:	89 e5                	mov    %esp,%ebp
    115d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1160:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1167:	eb 4c                	jmp    11b5 <gets+0x5b>
    cc = read(0, &c, 1);
    1169:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1170:	00 
    1171:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1174:	89 44 24 04          	mov    %eax,0x4(%esp)
    1178:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    117f:	e8 44 01 00 00       	call   12c8 <read>
    1184:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1187:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    118b:	7f 02                	jg     118f <gets+0x35>
      break;
    118d:	eb 31                	jmp    11c0 <gets+0x66>
    buf[i++] = c;
    118f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1192:	8d 50 01             	lea    0x1(%eax),%edx
    1195:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1198:	89 c2                	mov    %eax,%edx
    119a:	8b 45 08             	mov    0x8(%ebp),%eax
    119d:	01 c2                	add    %eax,%edx
    119f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a9:	3c 0a                	cmp    $0xa,%al
    11ab:	74 13                	je     11c0 <gets+0x66>
    11ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b1:	3c 0d                	cmp    $0xd,%al
    11b3:	74 0b                	je     11c0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b8:	83 c0 01             	add    $0x1,%eax
    11bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11be:	7c a9                	jl     1169 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11c3:	8b 45 08             	mov    0x8(%ebp),%eax
    11c6:	01 d0                	add    %edx,%eax
    11c8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ce:	c9                   	leave  
    11cf:	c3                   	ret    

000011d0 <stat>:

int
stat(char *n, struct stat *st)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11dd:	00 
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	89 04 24             	mov    %eax,(%esp)
    11e4:	e8 07 01 00 00       	call   12f0 <open>
    11e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11f0:	79 07                	jns    11f9 <stat+0x29>
    return -1;
    11f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11f7:	eb 23                	jmp    121c <stat+0x4c>
  r = fstat(fd, st);
    11f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1200:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1203:	89 04 24             	mov    %eax,(%esp)
    1206:	e8 fd 00 00 00       	call   1308 <fstat>
    120b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    120e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1211:	89 04 24             	mov    %eax,(%esp)
    1214:	e8 bf 00 00 00       	call   12d8 <close>
  return r;
    1219:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    121c:	c9                   	leave  
    121d:	c3                   	ret    

0000121e <atoi>:

int
atoi(const char *s)
{
    121e:	55                   	push   %ebp
    121f:	89 e5                	mov    %esp,%ebp
    1221:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1224:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    122b:	eb 25                	jmp    1252 <atoi+0x34>
    n = n*10 + *s++ - '0';
    122d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1230:	89 d0                	mov    %edx,%eax
    1232:	c1 e0 02             	shl    $0x2,%eax
    1235:	01 d0                	add    %edx,%eax
    1237:	01 c0                	add    %eax,%eax
    1239:	89 c1                	mov    %eax,%ecx
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	8d 50 01             	lea    0x1(%eax),%edx
    1241:	89 55 08             	mov    %edx,0x8(%ebp)
    1244:	0f b6 00             	movzbl (%eax),%eax
    1247:	0f be c0             	movsbl %al,%eax
    124a:	01 c8                	add    %ecx,%eax
    124c:	83 e8 30             	sub    $0x30,%eax
    124f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1252:	8b 45 08             	mov    0x8(%ebp),%eax
    1255:	0f b6 00             	movzbl (%eax),%eax
    1258:	3c 2f                	cmp    $0x2f,%al
    125a:	7e 0a                	jle    1266 <atoi+0x48>
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	0f b6 00             	movzbl (%eax),%eax
    1262:	3c 39                	cmp    $0x39,%al
    1264:	7e c7                	jle    122d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1266:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1269:	c9                   	leave  
    126a:	c3                   	ret    

0000126b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    126b:	55                   	push   %ebp
    126c:	89 e5                	mov    %esp,%ebp
    126e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1271:	8b 45 08             	mov    0x8(%ebp),%eax
    1274:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1277:	8b 45 0c             	mov    0xc(%ebp),%eax
    127a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    127d:	eb 17                	jmp    1296 <memmove+0x2b>
    *dst++ = *src++;
    127f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1282:	8d 50 01             	lea    0x1(%eax),%edx
    1285:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1288:	8b 55 f8             	mov    -0x8(%ebp),%edx
    128b:	8d 4a 01             	lea    0x1(%edx),%ecx
    128e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1291:	0f b6 12             	movzbl (%edx),%edx
    1294:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1296:	8b 45 10             	mov    0x10(%ebp),%eax
    1299:	8d 50 ff             	lea    -0x1(%eax),%edx
    129c:	89 55 10             	mov    %edx,0x10(%ebp)
    129f:	85 c0                	test   %eax,%eax
    12a1:	7f dc                	jg     127f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a6:	c9                   	leave  
    12a7:	c3                   	ret    

000012a8 <fork>:
    12a8:	b8 01 00 00 00       	mov    $0x1,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <exit>:
    12b0:	b8 02 00 00 00       	mov    $0x2,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <wait>:
    12b8:	b8 03 00 00 00       	mov    $0x3,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <pipe>:
    12c0:	b8 04 00 00 00       	mov    $0x4,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <read>:
    12c8:	b8 05 00 00 00       	mov    $0x5,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <write>:
    12d0:	b8 10 00 00 00       	mov    $0x10,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <close>:
    12d8:	b8 15 00 00 00       	mov    $0x15,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <kill>:
    12e0:	b8 06 00 00 00       	mov    $0x6,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <exec>:
    12e8:	b8 07 00 00 00       	mov    $0x7,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <open>:
    12f0:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <mknod>:
    12f8:	b8 11 00 00 00       	mov    $0x11,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <unlink>:
    1300:	b8 12 00 00 00       	mov    $0x12,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <fstat>:
    1308:	b8 08 00 00 00       	mov    $0x8,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <link>:
    1310:	b8 13 00 00 00       	mov    $0x13,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <mkdir>:
    1318:	b8 14 00 00 00       	mov    $0x14,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <chdir>:
    1320:	b8 09 00 00 00       	mov    $0x9,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <dup>:
    1328:	b8 0a 00 00 00       	mov    $0xa,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <getpid>:
    1330:	b8 0b 00 00 00       	mov    $0xb,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <sbrk>:
    1338:	b8 0c 00 00 00       	mov    $0xc,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <sleep>:
    1340:	b8 0d 00 00 00       	mov    $0xd,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <uptime>:
    1348:	b8 0e 00 00 00       	mov    $0xe,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <clone>:
    1350:	b8 16 00 00 00       	mov    $0x16,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <texit>:
    1358:	b8 17 00 00 00       	mov    $0x17,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <tsleep>:
    1360:	b8 18 00 00 00       	mov    $0x18,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <twakeup>:
    1368:	b8 19 00 00 00       	mov    $0x19,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	83 ec 18             	sub    $0x18,%esp
    1376:	8b 45 0c             	mov    0xc(%ebp),%eax
    1379:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    137c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1383:	00 
    1384:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1387:	89 44 24 04          	mov    %eax,0x4(%esp)
    138b:	8b 45 08             	mov    0x8(%ebp),%eax
    138e:	89 04 24             	mov    %eax,(%esp)
    1391:	e8 3a ff ff ff       	call   12d0 <write>
}
    1396:	c9                   	leave  
    1397:	c3                   	ret    

00001398 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1398:	55                   	push   %ebp
    1399:	89 e5                	mov    %esp,%ebp
    139b:	56                   	push   %esi
    139c:	53                   	push   %ebx
    139d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13a7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ab:	74 17                	je     13c4 <printint+0x2c>
    13ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13b1:	79 11                	jns    13c4 <printint+0x2c>
    neg = 1;
    13b3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    13bd:	f7 d8                	neg    %eax
    13bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13c2:	eb 06                	jmp    13ca <printint+0x32>
  } else {
    x = xx;
    13c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13d1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13d4:	8d 41 01             	lea    0x1(%ecx),%eax
    13d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13da:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e0:	ba 00 00 00 00       	mov    $0x0,%edx
    13e5:	f7 f3                	div    %ebx
    13e7:	89 d0                	mov    %edx,%eax
    13e9:	0f b6 80 fc 1d 00 00 	movzbl 0x1dfc(%eax),%eax
    13f0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    13f4:	8b 75 10             	mov    0x10(%ebp),%esi
    13f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13fa:	ba 00 00 00 00       	mov    $0x0,%edx
    13ff:	f7 f6                	div    %esi
    1401:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1404:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1408:	75 c7                	jne    13d1 <printint+0x39>
  if(neg)
    140a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    140e:	74 10                	je     1420 <printint+0x88>
    buf[i++] = '-';
    1410:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1413:	8d 50 01             	lea    0x1(%eax),%edx
    1416:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1419:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    141e:	eb 1f                	jmp    143f <printint+0xa7>
    1420:	eb 1d                	jmp    143f <printint+0xa7>
    putc(fd, buf[i]);
    1422:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1425:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1428:	01 d0                	add    %edx,%eax
    142a:	0f b6 00             	movzbl (%eax),%eax
    142d:	0f be c0             	movsbl %al,%eax
    1430:	89 44 24 04          	mov    %eax,0x4(%esp)
    1434:	8b 45 08             	mov    0x8(%ebp),%eax
    1437:	89 04 24             	mov    %eax,(%esp)
    143a:	e8 31 ff ff ff       	call   1370 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    143f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1443:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1447:	79 d9                	jns    1422 <printint+0x8a>
    putc(fd, buf[i]);
}
    1449:	83 c4 30             	add    $0x30,%esp
    144c:	5b                   	pop    %ebx
    144d:	5e                   	pop    %esi
    144e:	5d                   	pop    %ebp
    144f:	c3                   	ret    

00001450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1456:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    145d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1460:	83 c0 04             	add    $0x4,%eax
    1463:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1466:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    146d:	e9 7c 01 00 00       	jmp    15ee <printf+0x19e>
    c = fmt[i] & 0xff;
    1472:	8b 55 0c             	mov    0xc(%ebp),%edx
    1475:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1478:	01 d0                	add    %edx,%eax
    147a:	0f b6 00             	movzbl (%eax),%eax
    147d:	0f be c0             	movsbl %al,%eax
    1480:	25 ff 00 00 00       	and    $0xff,%eax
    1485:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1488:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    148c:	75 2c                	jne    14ba <printf+0x6a>
      if(c == '%'){
    148e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1492:	75 0c                	jne    14a0 <printf+0x50>
        state = '%';
    1494:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    149b:	e9 4a 01 00 00       	jmp    15ea <printf+0x19a>
      } else {
        putc(fd, c);
    14a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14a3:	0f be c0             	movsbl %al,%eax
    14a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    14aa:	8b 45 08             	mov    0x8(%ebp),%eax
    14ad:	89 04 24             	mov    %eax,(%esp)
    14b0:	e8 bb fe ff ff       	call   1370 <putc>
    14b5:	e9 30 01 00 00       	jmp    15ea <printf+0x19a>
      }
    } else if(state == '%'){
    14ba:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14be:	0f 85 26 01 00 00    	jne    15ea <printf+0x19a>
      if(c == 'd'){
    14c4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14c8:	75 2d                	jne    14f7 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    14ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14cd:	8b 00                	mov    (%eax),%eax
    14cf:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14d6:	00 
    14d7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14de:	00 
    14df:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e3:	8b 45 08             	mov    0x8(%ebp),%eax
    14e6:	89 04 24             	mov    %eax,(%esp)
    14e9:	e8 aa fe ff ff       	call   1398 <printint>
        ap++;
    14ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f2:	e9 ec 00 00 00       	jmp    15e3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    14f7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14fb:	74 06                	je     1503 <printf+0xb3>
    14fd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1501:	75 2d                	jne    1530 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1503:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1506:	8b 00                	mov    (%eax),%eax
    1508:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    150f:	00 
    1510:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1517:	00 
    1518:	89 44 24 04          	mov    %eax,0x4(%esp)
    151c:	8b 45 08             	mov    0x8(%ebp),%eax
    151f:	89 04 24             	mov    %eax,(%esp)
    1522:	e8 71 fe ff ff       	call   1398 <printint>
        ap++;
    1527:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    152b:	e9 b3 00 00 00       	jmp    15e3 <printf+0x193>
      } else if(c == 's'){
    1530:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1534:	75 45                	jne    157b <printf+0x12b>
        s = (char*)*ap;
    1536:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1539:	8b 00                	mov    (%eax),%eax
    153b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    153e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1542:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1546:	75 09                	jne    1551 <printf+0x101>
          s = "(null)";
    1548:	c7 45 f4 a5 1a 00 00 	movl   $0x1aa5,-0xc(%ebp)
        while(*s != 0){
    154f:	eb 1e                	jmp    156f <printf+0x11f>
    1551:	eb 1c                	jmp    156f <printf+0x11f>
          putc(fd, *s);
    1553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1556:	0f b6 00             	movzbl (%eax),%eax
    1559:	0f be c0             	movsbl %al,%eax
    155c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1560:	8b 45 08             	mov    0x8(%ebp),%eax
    1563:	89 04 24             	mov    %eax,(%esp)
    1566:	e8 05 fe ff ff       	call   1370 <putc>
          s++;
    156b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    156f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1572:	0f b6 00             	movzbl (%eax),%eax
    1575:	84 c0                	test   %al,%al
    1577:	75 da                	jne    1553 <printf+0x103>
    1579:	eb 68                	jmp    15e3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    157b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    157f:	75 1d                	jne    159e <printf+0x14e>
        putc(fd, *ap);
    1581:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1584:	8b 00                	mov    (%eax),%eax
    1586:	0f be c0             	movsbl %al,%eax
    1589:	89 44 24 04          	mov    %eax,0x4(%esp)
    158d:	8b 45 08             	mov    0x8(%ebp),%eax
    1590:	89 04 24             	mov    %eax,(%esp)
    1593:	e8 d8 fd ff ff       	call   1370 <putc>
        ap++;
    1598:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    159c:	eb 45                	jmp    15e3 <printf+0x193>
      } else if(c == '%'){
    159e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15a2:	75 17                	jne    15bb <printf+0x16b>
        putc(fd, c);
    15a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15a7:	0f be c0             	movsbl %al,%eax
    15aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ae:	8b 45 08             	mov    0x8(%ebp),%eax
    15b1:	89 04 24             	mov    %eax,(%esp)
    15b4:	e8 b7 fd ff ff       	call   1370 <putc>
    15b9:	eb 28                	jmp    15e3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15bb:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15c2:	00 
    15c3:	8b 45 08             	mov    0x8(%ebp),%eax
    15c6:	89 04 24             	mov    %eax,(%esp)
    15c9:	e8 a2 fd ff ff       	call   1370 <putc>
        putc(fd, c);
    15ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d1:	0f be c0             	movsbl %al,%eax
    15d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	89 04 24             	mov    %eax,(%esp)
    15de:	e8 8d fd ff ff       	call   1370 <putc>
      }
      state = 0;
    15e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15ea:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15ee:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f4:	01 d0                	add    %edx,%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	84 c0                	test   %al,%al
    15fb:	0f 85 71 fe ff ff    	jne    1472 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1601:	c9                   	leave  
    1602:	c3                   	ret    
    1603:	90                   	nop

00001604 <free>:
    1604:	55                   	push   %ebp
    1605:	89 e5                	mov    %esp,%ebp
    1607:	83 ec 10             	sub    $0x10,%esp
    160a:	8b 45 08             	mov    0x8(%ebp),%eax
    160d:	83 e8 08             	sub    $0x8,%eax
    1610:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1613:	a1 1c 1e 00 00       	mov    0x1e1c,%eax
    1618:	89 45 fc             	mov    %eax,-0x4(%ebp)
    161b:	eb 24                	jmp    1641 <free+0x3d>
    161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1620:	8b 00                	mov    (%eax),%eax
    1622:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1625:	77 12                	ja     1639 <free+0x35>
    1627:	8b 45 f8             	mov    -0x8(%ebp),%eax
    162a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    162d:	77 24                	ja     1653 <free+0x4f>
    162f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1632:	8b 00                	mov    (%eax),%eax
    1634:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1637:	77 1a                	ja     1653 <free+0x4f>
    1639:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163c:	8b 00                	mov    (%eax),%eax
    163e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1641:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1644:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1647:	76 d4                	jbe    161d <free+0x19>
    1649:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1651:	76 ca                	jbe    161d <free+0x19>
    1653:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1656:	8b 40 04             	mov    0x4(%eax),%eax
    1659:	c1 e0 03             	shl    $0x3,%eax
    165c:	89 c2                	mov    %eax,%edx
    165e:	03 55 f8             	add    -0x8(%ebp),%edx
    1661:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	39 c2                	cmp    %eax,%edx
    1668:	75 24                	jne    168e <free+0x8a>
    166a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166d:	8b 50 04             	mov    0x4(%eax),%edx
    1670:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1673:	8b 00                	mov    (%eax),%eax
    1675:	8b 40 04             	mov    0x4(%eax),%eax
    1678:	01 c2                	add    %eax,%edx
    167a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167d:	89 50 04             	mov    %edx,0x4(%eax)
    1680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1683:	8b 00                	mov    (%eax),%eax
    1685:	8b 10                	mov    (%eax),%edx
    1687:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168a:	89 10                	mov    %edx,(%eax)
    168c:	eb 0a                	jmp    1698 <free+0x94>
    168e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1691:	8b 10                	mov    (%eax),%edx
    1693:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1696:	89 10                	mov    %edx,(%eax)
    1698:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169b:	8b 40 04             	mov    0x4(%eax),%eax
    169e:	c1 e0 03             	shl    $0x3,%eax
    16a1:	03 45 fc             	add    -0x4(%ebp),%eax
    16a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16a7:	75 20                	jne    16c9 <free+0xc5>
    16a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ac:	8b 50 04             	mov    0x4(%eax),%edx
    16af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b2:	8b 40 04             	mov    0x4(%eax),%eax
    16b5:	01 c2                	add    %eax,%edx
    16b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ba:	89 50 04             	mov    %edx,0x4(%eax)
    16bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c0:	8b 10                	mov    (%eax),%edx
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	89 10                	mov    %edx,(%eax)
    16c7:	eb 08                	jmp    16d1 <free+0xcd>
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16cf:	89 10                	mov    %edx,(%eax)
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	a3 1c 1e 00 00       	mov    %eax,0x1e1c
    16d9:	c9                   	leave  
    16da:	c3                   	ret    

000016db <morecore>:
    16db:	55                   	push   %ebp
    16dc:	89 e5                	mov    %esp,%ebp
    16de:	83 ec 28             	sub    $0x28,%esp
    16e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e8:	77 07                	ja     16f1 <morecore+0x16>
    16ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	c1 e0 03             	shl    $0x3,%eax
    16f7:	89 04 24             	mov    %eax,(%esp)
    16fa:	e8 39 fc ff ff       	call   1338 <sbrk>
    16ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1702:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1706:	75 07                	jne    170f <morecore+0x34>
    1708:	b8 00 00 00 00       	mov    $0x0,%eax
    170d:	eb 22                	jmp    1731 <morecore+0x56>
    170f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1712:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1715:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1718:	8b 55 08             	mov    0x8(%ebp),%edx
    171b:	89 50 04             	mov    %edx,0x4(%eax)
    171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1721:	83 c0 08             	add    $0x8,%eax
    1724:	89 04 24             	mov    %eax,(%esp)
    1727:	e8 d8 fe ff ff       	call   1604 <free>
    172c:	a1 1c 1e 00 00       	mov    0x1e1c,%eax
    1731:	c9                   	leave  
    1732:	c3                   	ret    

00001733 <malloc>:
    1733:	55                   	push   %ebp
    1734:	89 e5                	mov    %esp,%ebp
    1736:	83 ec 28             	sub    $0x28,%esp
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	83 c0 07             	add    $0x7,%eax
    173f:	c1 e8 03             	shr    $0x3,%eax
    1742:	83 c0 01             	add    $0x1,%eax
    1745:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1748:	a1 1c 1e 00 00       	mov    0x1e1c,%eax
    174d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1750:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1754:	75 23                	jne    1779 <malloc+0x46>
    1756:	c7 45 f0 14 1e 00 00 	movl   $0x1e14,-0x10(%ebp)
    175d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1760:	a3 1c 1e 00 00       	mov    %eax,0x1e1c
    1765:	a1 1c 1e 00 00       	mov    0x1e1c,%eax
    176a:	a3 14 1e 00 00       	mov    %eax,0x1e14
    176f:	c7 05 18 1e 00 00 00 	movl   $0x0,0x1e18
    1776:	00 00 00 
    1779:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177c:	8b 00                	mov    (%eax),%eax
    177e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1781:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1784:	8b 40 04             	mov    0x4(%eax),%eax
    1787:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    178a:	72 4d                	jb     17d9 <malloc+0xa6>
    178c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178f:	8b 40 04             	mov    0x4(%eax),%eax
    1792:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1795:	75 0c                	jne    17a3 <malloc+0x70>
    1797:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179a:	8b 10                	mov    (%eax),%edx
    179c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179f:	89 10                	mov    %edx,(%eax)
    17a1:	eb 26                	jmp    17c9 <malloc+0x96>
    17a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a6:	8b 40 04             	mov    0x4(%eax),%eax
    17a9:	89 c2                	mov    %eax,%edx
    17ab:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b1:	89 50 04             	mov    %edx,0x4(%eax)
    17b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b7:	8b 40 04             	mov    0x4(%eax),%eax
    17ba:	c1 e0 03             	shl    $0x3,%eax
    17bd:	01 45 ec             	add    %eax,-0x14(%ebp)
    17c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17c6:	89 50 04             	mov    %edx,0x4(%eax)
    17c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cc:	a3 1c 1e 00 00       	mov    %eax,0x1e1c
    17d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d4:	83 c0 08             	add    $0x8,%eax
    17d7:	eb 38                	jmp    1811 <malloc+0xde>
    17d9:	a1 1c 1e 00 00       	mov    0x1e1c,%eax
    17de:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17e1:	75 1b                	jne    17fe <malloc+0xcb>
    17e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e6:	89 04 24             	mov    %eax,(%esp)
    17e9:	e8 ed fe ff ff       	call   16db <morecore>
    17ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17f5:	75 07                	jne    17fe <malloc+0xcb>
    17f7:	b8 00 00 00 00       	mov    $0x0,%eax
    17fc:	eb 13                	jmp    1811 <malloc+0xde>
    17fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1801:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1804:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1807:	8b 00                	mov    (%eax),%eax
    1809:	89 45 ec             	mov    %eax,-0x14(%ebp)
    180c:	e9 70 ff ff ff       	jmp    1781 <malloc+0x4e>
    1811:	c9                   	leave  
    1812:	c3                   	ret    
    1813:	90                   	nop

00001814 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1814:	55                   	push   %ebp
    1815:	89 e5                	mov    %esp,%ebp
    1817:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    181a:	8b 55 08             	mov    0x8(%ebp),%edx
    181d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1820:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1823:	f0 87 02             	lock xchg %eax,(%edx)
    1826:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1829:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    182c:	c9                   	leave  
    182d:	c3                   	ret    

0000182e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    182e:	55                   	push   %ebp
    182f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1831:	8b 45 08             	mov    0x8(%ebp),%eax
    1834:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    183a:	5d                   	pop    %ebp
    183b:	c3                   	ret    

0000183c <lock_acquire>:
void lock_acquire(lock_t *lock){
    183c:	55                   	push   %ebp
    183d:	89 e5                	mov    %esp,%ebp
    183f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1842:	90                   	nop
    1843:	8b 45 08             	mov    0x8(%ebp),%eax
    1846:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    184d:	00 
    184e:	89 04 24             	mov    %eax,(%esp)
    1851:	e8 be ff ff ff       	call   1814 <xchg>
    1856:	85 c0                	test   %eax,%eax
    1858:	75 e9                	jne    1843 <lock_acquire+0x7>
}
    185a:	c9                   	leave  
    185b:	c3                   	ret    

0000185c <lock_release>:
void lock_release(lock_t *lock){
    185c:	55                   	push   %ebp
    185d:	89 e5                	mov    %esp,%ebp
    185f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    186c:	00 
    186d:	89 04 24             	mov    %eax,(%esp)
    1870:	e8 9f ff ff ff       	call   1814 <xchg>
}
    1875:	c9                   	leave  
    1876:	c3                   	ret    

00001877 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1877:	55                   	push   %ebp
    1878:	89 e5                	mov    %esp,%ebp
    187a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    187d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1884:	e8 aa fe ff ff       	call   1733 <malloc>
    1889:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    188c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1892:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1895:	25 ff 0f 00 00       	and    $0xfff,%eax
    189a:	85 c0                	test   %eax,%eax
    189c:	74 14                	je     18b2 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a1:	25 ff 0f 00 00       	and    $0xfff,%eax
    18a6:	89 c2                	mov    %eax,%edx
    18a8:	b8 00 10 00 00       	mov    $0x1000,%eax
    18ad:	29 d0                	sub    %edx,%eax
    18af:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    18b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18b6:	75 1b                	jne    18d3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    18b8:	c7 44 24 04 ac 1a 00 	movl   $0x1aac,0x4(%esp)
    18bf:	00 
    18c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18c7:	e8 84 fb ff ff       	call   1450 <printf>
        return 0;
    18cc:	b8 00 00 00 00       	mov    $0x0,%eax
    18d1:	eb 6f                	jmp    1942 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18d6:	8b 55 08             	mov    0x8(%ebp),%edx
    18d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18dc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18e0:	89 54 24 08          	mov    %edx,0x8(%esp)
    18e4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18eb:	00 
    18ec:	89 04 24             	mov    %eax,(%esp)
    18ef:	e8 5c fa ff ff       	call   1350 <clone>
    18f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18fb:	79 1b                	jns    1918 <thread_create+0xa1>
        printf(1,"clone fails\n");
    18fd:	c7 44 24 04 ba 1a 00 	movl   $0x1aba,0x4(%esp)
    1904:	00 
    1905:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190c:	e8 3f fb ff ff       	call   1450 <printf>
        return 0;
    1911:	b8 00 00 00 00       	mov    $0x0,%eax
    1916:	eb 2a                	jmp    1942 <thread_create+0xcb>
    }
    if(tid > 0){
    1918:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191c:	7e 05                	jle    1923 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    191e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1921:	eb 1f                	jmp    1942 <thread_create+0xcb>
    }
    if(tid == 0){
    1923:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1927:	75 14                	jne    193d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1929:	c7 44 24 04 c7 1a 00 	movl   $0x1ac7,0x4(%esp)
    1930:	00 
    1931:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1938:	e8 13 fb ff ff       	call   1450 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    193d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1942:	c9                   	leave  
    1943:	c3                   	ret    

00001944 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1944:	55                   	push   %ebp
    1945:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1947:	a1 10 1e 00 00       	mov    0x1e10,%eax
    194c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1952:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1957:	a3 10 1e 00 00       	mov    %eax,0x1e10
    return (int)(rands % max);
    195c:	a1 10 1e 00 00       	mov    0x1e10,%eax
    1961:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1964:	ba 00 00 00 00       	mov    $0x0,%edx
    1969:	f7 f1                	div    %ecx
    196b:	89 d0                	mov    %edx,%eax
}
    196d:	5d                   	pop    %ebp
    196e:	c3                   	ret    
    196f:	90                   	nop

00001970 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1973:	8b 45 08             	mov    0x8(%ebp),%eax
    1976:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    197c:	8b 45 08             	mov    0x8(%ebp),%eax
    197f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1986:	8b 45 08             	mov    0x8(%ebp),%eax
    1989:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1990:	5d                   	pop    %ebp
    1991:	c3                   	ret    

00001992 <add_q>:

void add_q(struct queue *q, int v){
    1992:	55                   	push   %ebp
    1993:	89 e5                	mov    %esp,%ebp
    1995:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1998:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    199f:	e8 8f fd ff ff       	call   1733 <malloc>
    19a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    19a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19aa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19b7:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19b9:	8b 45 08             	mov    0x8(%ebp),%eax
    19bc:	8b 40 04             	mov    0x4(%eax),%eax
    19bf:	85 c0                	test   %eax,%eax
    19c1:	75 0b                	jne    19ce <add_q+0x3c>
        q->head = n;
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19c9:	89 50 04             	mov    %edx,0x4(%eax)
    19cc:	eb 0c                	jmp    19da <add_q+0x48>
    }else{
        q->tail->next = n;
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	8b 40 08             	mov    0x8(%eax),%eax
    19d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19d7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19da:	8b 45 08             	mov    0x8(%ebp),%eax
    19dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19e0:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	8b 00                	mov    (%eax),%eax
    19e8:	8d 50 01             	lea    0x1(%eax),%edx
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	89 10                	mov    %edx,(%eax)
}
    19f0:	c9                   	leave  
    19f1:	c3                   	ret    

000019f2 <empty_q>:

int empty_q(struct queue *q){
    19f2:	55                   	push   %ebp
    19f3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19f5:	8b 45 08             	mov    0x8(%ebp),%eax
    19f8:	8b 00                	mov    (%eax),%eax
    19fa:	85 c0                	test   %eax,%eax
    19fc:	75 07                	jne    1a05 <empty_q+0x13>
        return 1;
    19fe:	b8 01 00 00 00       	mov    $0x1,%eax
    1a03:	eb 05                	jmp    1a0a <empty_q+0x18>
    else
        return 0;
    1a05:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a0a:	5d                   	pop    %ebp
    1a0b:	c3                   	ret    

00001a0c <pop_q>:
int pop_q(struct queue *q){
    1a0c:	55                   	push   %ebp
    1a0d:	89 e5                	mov    %esp,%ebp
    1a0f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	89 04 24             	mov    %eax,(%esp)
    1a18:	e8 d5 ff ff ff       	call   19f2 <empty_q>
    1a1d:	85 c0                	test   %eax,%eax
    1a1f:	75 5d                	jne    1a7e <pop_q+0x72>
       val = q->head->value; 
    1a21:	8b 45 08             	mov    0x8(%ebp),%eax
    1a24:	8b 40 04             	mov    0x4(%eax),%eax
    1a27:	8b 00                	mov    (%eax),%eax
    1a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	8b 40 04             	mov    0x4(%eax),%eax
    1a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	8b 40 04             	mov    0x4(%eax),%eax
    1a3b:	8b 50 04             	mov    0x4(%eax),%edx
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a47:	89 04 24             	mov    %eax,(%esp)
    1a4a:	e8 b5 fb ff ff       	call   1604 <free>
       q->size--;
    1a4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a52:	8b 00                	mov    (%eax),%eax
    1a54:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a57:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5f:	8b 00                	mov    (%eax),%eax
    1a61:	85 c0                	test   %eax,%eax
    1a63:	75 14                	jne    1a79 <pop_q+0x6d>
            q->head = 0;
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7c:	eb 05                	jmp    1a83 <pop_q+0x77>
    }
    return -1;
    1a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a83:	c9                   	leave  
    1a84:	c3                   	ret    
