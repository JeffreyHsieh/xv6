
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
    1011:	c7 44 24 04 7d 1a 00 	movl   $0x1a7d,0x4(%esp)
    1018:	00 
    1019:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1020:	e8 20 04 00 00       	call   1445 <printf>
  printf(1,"%d\n", *null);
    1025:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1029:	8b 00                	mov    (%eax),%eax
    102b:	89 44 24 08          	mov    %eax,0x8(%esp)
    102f:	c7 44 24 04 99 1a 00 	movl   $0x1a99,0x4(%esp)
    1036:	00 
    1037:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103e:	e8 02 04 00 00       	call   1445 <printf>

  exit();
    1043:	e8 64 02 00 00       	call   12ac <exit>

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
    1079:	8b 45 0c             	mov    0xc(%ebp),%eax
    107c:	0f b6 10             	movzbl (%eax),%edx
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
    1082:	88 10                	mov    %dl,(%eax)
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	0f b6 00             	movzbl (%eax),%eax
    108a:	84 c0                	test   %al,%al
    108c:	0f 95 c0             	setne  %al
    108f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1093:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1097:	84 c0                	test   %al,%al
    1099:	75 de                	jne    1079 <strcpy+0xc>
    ;
  return os;
    109b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    109e:	c9                   	leave  
    109f:	c3                   	ret    

000010a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10a3:	eb 08                	jmp    10ad <strcmp+0xd>
    p++, q++;
    10a5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10a9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10ad:	8b 45 08             	mov    0x8(%ebp),%eax
    10b0:	0f b6 00             	movzbl (%eax),%eax
    10b3:	84 c0                	test   %al,%al
    10b5:	74 10                	je     10c7 <strcmp+0x27>
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	0f b6 10             	movzbl (%eax),%edx
    10bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c0:	0f b6 00             	movzbl (%eax),%eax
    10c3:	38 c2                	cmp    %al,%dl
    10c5:	74 de                	je     10a5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10c7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ca:	0f b6 00             	movzbl (%eax),%eax
    10cd:	0f b6 d0             	movzbl %al,%edx
    10d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d3:	0f b6 00             	movzbl (%eax),%eax
    10d6:	0f b6 c0             	movzbl %al,%eax
    10d9:	89 d1                	mov    %edx,%ecx
    10db:	29 c1                	sub    %eax,%ecx
    10dd:	89 c8                	mov    %ecx,%eax
}
    10df:	5d                   	pop    %ebp
    10e0:	c3                   	ret    

000010e1 <strlen>:

uint
strlen(char *s)
{
    10e1:	55                   	push   %ebp
    10e2:	89 e5                	mov    %esp,%ebp
    10e4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10ee:	eb 04                	jmp    10f4 <strlen+0x13>
    10f0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10f7:	03 45 08             	add    0x8(%ebp),%eax
    10fa:	0f b6 00             	movzbl (%eax),%eax
    10fd:	84 c0                	test   %al,%al
    10ff:	75 ef                	jne    10f0 <strlen+0xf>
    ;
  return n;
    1101:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1104:	c9                   	leave  
    1105:	c3                   	ret    

00001106 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1106:	55                   	push   %ebp
    1107:	89 e5                	mov    %esp,%ebp
    1109:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    110c:	8b 45 10             	mov    0x10(%ebp),%eax
    110f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1113:	8b 45 0c             	mov    0xc(%ebp),%eax
    1116:	89 44 24 04          	mov    %eax,0x4(%esp)
    111a:	8b 45 08             	mov    0x8(%ebp),%eax
    111d:	89 04 24             	mov    %eax,(%esp)
    1120:	e8 23 ff ff ff       	call   1048 <stosb>
  return dst;
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1128:	c9                   	leave  
    1129:	c3                   	ret    

0000112a <strchr>:

char*
strchr(const char *s, char c)
{
    112a:	55                   	push   %ebp
    112b:	89 e5                	mov    %esp,%ebp
    112d:	83 ec 04             	sub    $0x4,%esp
    1130:	8b 45 0c             	mov    0xc(%ebp),%eax
    1133:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1136:	eb 14                	jmp    114c <strchr+0x22>
    if(*s == c)
    1138:	8b 45 08             	mov    0x8(%ebp),%eax
    113b:	0f b6 00             	movzbl (%eax),%eax
    113e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1141:	75 05                	jne    1148 <strchr+0x1e>
      return (char*)s;
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	eb 13                	jmp    115b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1148:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    114c:	8b 45 08             	mov    0x8(%ebp),%eax
    114f:	0f b6 00             	movzbl (%eax),%eax
    1152:	84 c0                	test   %al,%al
    1154:	75 e2                	jne    1138 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1156:	b8 00 00 00 00       	mov    $0x0,%eax
}
    115b:	c9                   	leave  
    115c:	c3                   	ret    

0000115d <gets>:

char*
gets(char *buf, int max)
{
    115d:	55                   	push   %ebp
    115e:	89 e5                	mov    %esp,%ebp
    1160:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1163:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    116a:	eb 44                	jmp    11b0 <gets+0x53>
    cc = read(0, &c, 1);
    116c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1173:	00 
    1174:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1177:	89 44 24 04          	mov    %eax,0x4(%esp)
    117b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1182:	e8 3d 01 00 00       	call   12c4 <read>
    1187:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    118a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    118e:	7e 2d                	jle    11bd <gets+0x60>
      break;
    buf[i++] = c;
    1190:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1193:	03 45 08             	add    0x8(%ebp),%eax
    1196:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    119a:	88 10                	mov    %dl,(%eax)
    119c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    11a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a4:	3c 0a                	cmp    $0xa,%al
    11a6:	74 16                	je     11be <gets+0x61>
    11a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ac:	3c 0d                	cmp    $0xd,%al
    11ae:	74 0e                	je     11be <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b3:	83 c0 01             	add    $0x1,%eax
    11b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b9:	7c b1                	jl     116c <gets+0xf>
    11bb:	eb 01                	jmp    11be <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    11bd:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11c1:	03 45 08             	add    0x8(%ebp),%eax
    11c4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ca:	c9                   	leave  
    11cb:	c3                   	ret    

000011cc <stat>:

int
stat(char *n, struct stat *st)
{
    11cc:	55                   	push   %ebp
    11cd:	89 e5                	mov    %esp,%ebp
    11cf:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11d9:	00 
    11da:	8b 45 08             	mov    0x8(%ebp),%eax
    11dd:	89 04 24             	mov    %eax,(%esp)
    11e0:	e8 07 01 00 00       	call   12ec <open>
    11e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    11e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11ec:	79 07                	jns    11f5 <stat+0x29>
    return -1;
    11ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11f3:	eb 23                	jmp    1218 <stat+0x4c>
  r = fstat(fd, st);
    11f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ff:	89 04 24             	mov    %eax,(%esp)
    1202:	e8 fd 00 00 00       	call   1304 <fstat>
    1207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    120a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 bf 00 00 00       	call   12d4 <close>
  return r;
    1215:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1218:	c9                   	leave  
    1219:	c3                   	ret    

0000121a <atoi>:

int
atoi(const char *s)
{
    121a:	55                   	push   %ebp
    121b:	89 e5                	mov    %esp,%ebp
    121d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1220:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1227:	eb 24                	jmp    124d <atoi+0x33>
    n = n*10 + *s++ - '0';
    1229:	8b 55 fc             	mov    -0x4(%ebp),%edx
    122c:	89 d0                	mov    %edx,%eax
    122e:	c1 e0 02             	shl    $0x2,%eax
    1231:	01 d0                	add    %edx,%eax
    1233:	01 c0                	add    %eax,%eax
    1235:	89 c2                	mov    %eax,%edx
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
    123a:	0f b6 00             	movzbl (%eax),%eax
    123d:	0f be c0             	movsbl %al,%eax
    1240:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1243:	83 e8 30             	sub    $0x30,%eax
    1246:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1249:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	0f b6 00             	movzbl (%eax),%eax
    1253:	3c 2f                	cmp    $0x2f,%al
    1255:	7e 0a                	jle    1261 <atoi+0x47>
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	0f b6 00             	movzbl (%eax),%eax
    125d:	3c 39                	cmp    $0x39,%al
    125f:	7e c8                	jle    1229 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1261:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1264:	c9                   	leave  
    1265:	c3                   	ret    

00001266 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    126c:	8b 45 08             	mov    0x8(%ebp),%eax
    126f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1272:	8b 45 0c             	mov    0xc(%ebp),%eax
    1275:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1278:	eb 13                	jmp    128d <memmove+0x27>
    *dst++ = *src++;
    127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127d:	0f b6 10             	movzbl (%eax),%edx
    1280:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1283:	88 10                	mov    %dl,(%eax)
    1285:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1289:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    128d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1291:	0f 9f c0             	setg   %al
    1294:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1298:	84 c0                	test   %al,%al
    129a:	75 de                	jne    127a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    129c:	8b 45 08             	mov    0x8(%ebp),%eax
}
    129f:	c9                   	leave  
    12a0:	c3                   	ret    
    12a1:	90                   	nop
    12a2:	90                   	nop
    12a3:	90                   	nop

000012a4 <fork>:
    12a4:	b8 01 00 00 00       	mov    $0x1,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <exit>:
    12ac:	b8 02 00 00 00       	mov    $0x2,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <wait>:
    12b4:	b8 03 00 00 00       	mov    $0x3,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <pipe>:
    12bc:	b8 04 00 00 00       	mov    $0x4,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <read>:
    12c4:	b8 05 00 00 00       	mov    $0x5,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <write>:
    12cc:	b8 10 00 00 00       	mov    $0x10,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <close>:
    12d4:	b8 15 00 00 00       	mov    $0x15,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <kill>:
    12dc:	b8 06 00 00 00       	mov    $0x6,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <exec>:
    12e4:	b8 07 00 00 00       	mov    $0x7,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <open>:
    12ec:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <mknod>:
    12f4:	b8 11 00 00 00       	mov    $0x11,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <unlink>:
    12fc:	b8 12 00 00 00       	mov    $0x12,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <fstat>:
    1304:	b8 08 00 00 00       	mov    $0x8,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <link>:
    130c:	b8 13 00 00 00       	mov    $0x13,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <mkdir>:
    1314:	b8 14 00 00 00       	mov    $0x14,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <chdir>:
    131c:	b8 09 00 00 00       	mov    $0x9,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <dup>:
    1324:	b8 0a 00 00 00       	mov    $0xa,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <getpid>:
    132c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <sbrk>:
    1334:	b8 0c 00 00 00       	mov    $0xc,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <sleep>:
    133c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <uptime>:
    1344:	b8 0e 00 00 00       	mov    $0xe,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <clone>:
    134c:	b8 16 00 00 00       	mov    $0x16,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <texit>:
    1354:	b8 17 00 00 00       	mov    $0x17,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <tsleep>:
    135c:	b8 18 00 00 00       	mov    $0x18,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <twakeup>:
    1364:	b8 19 00 00 00       	mov    $0x19,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    136c:	55                   	push   %ebp
    136d:	89 e5                	mov    %esp,%ebp
    136f:	83 ec 28             	sub    $0x28,%esp
    1372:	8b 45 0c             	mov    0xc(%ebp),%eax
    1375:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1378:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    137f:	00 
    1380:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1383:	89 44 24 04          	mov    %eax,0x4(%esp)
    1387:	8b 45 08             	mov    0x8(%ebp),%eax
    138a:	89 04 24             	mov    %eax,(%esp)
    138d:	e8 3a ff ff ff       	call   12cc <write>
}
    1392:	c9                   	leave  
    1393:	c3                   	ret    

00001394 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1394:	55                   	push   %ebp
    1395:	89 e5                	mov    %esp,%ebp
    1397:	53                   	push   %ebx
    1398:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    139b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13a2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13a6:	74 17                	je     13bf <printint+0x2b>
    13a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13ac:	79 11                	jns    13bf <printint+0x2b>
    neg = 1;
    13ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b8:	f7 d8                	neg    %eax
    13ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13bd:	eb 06                	jmp    13c5 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    13c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    13cc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d5:	ba 00 00 00 00       	mov    $0x0,%edx
    13da:	f7 f3                	div    %ebx
    13dc:	89 d0                	mov    %edx,%eax
    13de:	0f b6 80 d0 1a 00 00 	movzbl 0x1ad0(%eax),%eax
    13e5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    13e9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    13ed:	8b 45 10             	mov    0x10(%ebp),%eax
    13f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    13f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f6:	ba 00 00 00 00       	mov    $0x0,%edx
    13fb:	f7 75 d4             	divl   -0x2c(%ebp)
    13fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1401:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1405:	75 c5                	jne    13cc <printint+0x38>
  if(neg)
    1407:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    140b:	74 28                	je     1435 <printint+0xa1>
    buf[i++] = '-';
    140d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1410:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1415:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1419:	eb 1a                	jmp    1435 <printint+0xa1>
    putc(fd, buf[i]);
    141b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1423:	0f be c0             	movsbl %al,%eax
    1426:	89 44 24 04          	mov    %eax,0x4(%esp)
    142a:	8b 45 08             	mov    0x8(%ebp),%eax
    142d:	89 04 24             	mov    %eax,(%esp)
    1430:	e8 37 ff ff ff       	call   136c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1435:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1439:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    143d:	79 dc                	jns    141b <printint+0x87>
    putc(fd, buf[i]);
}
    143f:	83 c4 44             	add    $0x44,%esp
    1442:	5b                   	pop    %ebx
    1443:	5d                   	pop    %ebp
    1444:	c3                   	ret    

00001445 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1445:	55                   	push   %ebp
    1446:	89 e5                	mov    %esp,%ebp
    1448:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    144b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1452:	8d 45 0c             	lea    0xc(%ebp),%eax
    1455:	83 c0 04             	add    $0x4,%eax
    1458:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    145b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1462:	e9 7e 01 00 00       	jmp    15e5 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1467:	8b 55 0c             	mov    0xc(%ebp),%edx
    146a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    146d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1470:	0f b6 00             	movzbl (%eax),%eax
    1473:	0f be c0             	movsbl %al,%eax
    1476:	25 ff 00 00 00       	and    $0xff,%eax
    147b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    147e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1482:	75 2c                	jne    14b0 <printf+0x6b>
      if(c == '%'){
    1484:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1488:	75 0c                	jne    1496 <printf+0x51>
        state = '%';
    148a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1491:	e9 4b 01 00 00       	jmp    15e1 <printf+0x19c>
      } else {
        putc(fd, c);
    1496:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1499:	0f be c0             	movsbl %al,%eax
    149c:	89 44 24 04          	mov    %eax,0x4(%esp)
    14a0:	8b 45 08             	mov    0x8(%ebp),%eax
    14a3:	89 04 24             	mov    %eax,(%esp)
    14a6:	e8 c1 fe ff ff       	call   136c <putc>
    14ab:	e9 31 01 00 00       	jmp    15e1 <printf+0x19c>
      }
    } else if(state == '%'){
    14b0:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14b4:	0f 85 27 01 00 00    	jne    15e1 <printf+0x19c>
      if(c == 'd'){
    14ba:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14be:	75 2d                	jne    14ed <printf+0xa8>
        printint(fd, *ap, 10, 1);
    14c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c3:	8b 00                	mov    (%eax),%eax
    14c5:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14cc:	00 
    14cd:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14d4:	00 
    14d5:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d9:	8b 45 08             	mov    0x8(%ebp),%eax
    14dc:	89 04 24             	mov    %eax,(%esp)
    14df:	e8 b0 fe ff ff       	call   1394 <printint>
        ap++;
    14e4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    14e8:	e9 ed 00 00 00       	jmp    15da <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    14ed:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    14f1:	74 06                	je     14f9 <printf+0xb4>
    14f3:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    14f7:	75 2d                	jne    1526 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    14f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fc:	8b 00                	mov    (%eax),%eax
    14fe:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1505:	00 
    1506:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    150d:	00 
    150e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1512:	8b 45 08             	mov    0x8(%ebp),%eax
    1515:	89 04 24             	mov    %eax,(%esp)
    1518:	e8 77 fe ff ff       	call   1394 <printint>
        ap++;
    151d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1521:	e9 b4 00 00 00       	jmp    15da <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1526:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    152a:	75 46                	jne    1572 <printf+0x12d>
        s = (char*)*ap;
    152c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152f:	8b 00                	mov    (%eax),%eax
    1531:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1534:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1538:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    153c:	75 27                	jne    1565 <printf+0x120>
          s = "(null)";
    153e:	c7 45 e4 9d 1a 00 00 	movl   $0x1a9d,-0x1c(%ebp)
        while(*s != 0){
    1545:	eb 1f                	jmp    1566 <printf+0x121>
          putc(fd, *s);
    1547:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    154a:	0f b6 00             	movzbl (%eax),%eax
    154d:	0f be c0             	movsbl %al,%eax
    1550:	89 44 24 04          	mov    %eax,0x4(%esp)
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
    1557:	89 04 24             	mov    %eax,(%esp)
    155a:	e8 0d fe ff ff       	call   136c <putc>
          s++;
    155f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1563:	eb 01                	jmp    1566 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1565:	90                   	nop
    1566:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1569:	0f b6 00             	movzbl (%eax),%eax
    156c:	84 c0                	test   %al,%al
    156e:	75 d7                	jne    1547 <printf+0x102>
    1570:	eb 68                	jmp    15da <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1572:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1576:	75 1d                	jne    1595 <printf+0x150>
        putc(fd, *ap);
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	8b 00                	mov    (%eax),%eax
    157d:	0f be c0             	movsbl %al,%eax
    1580:	89 44 24 04          	mov    %eax,0x4(%esp)
    1584:	8b 45 08             	mov    0x8(%ebp),%eax
    1587:	89 04 24             	mov    %eax,(%esp)
    158a:	e8 dd fd ff ff       	call   136c <putc>
        ap++;
    158f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1593:	eb 45                	jmp    15da <printf+0x195>
      } else if(c == '%'){
    1595:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1599:	75 17                	jne    15b2 <printf+0x16d>
        putc(fd, c);
    159b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    159e:	0f be c0             	movsbl %al,%eax
    15a1:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a5:	8b 45 08             	mov    0x8(%ebp),%eax
    15a8:	89 04 24             	mov    %eax,(%esp)
    15ab:	e8 bc fd ff ff       	call   136c <putc>
    15b0:	eb 28                	jmp    15da <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15b2:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15b9:	00 
    15ba:	8b 45 08             	mov    0x8(%ebp),%eax
    15bd:	89 04 24             	mov    %eax,(%esp)
    15c0:	e8 a7 fd ff ff       	call   136c <putc>
        putc(fd, c);
    15c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c8:	0f be c0             	movsbl %al,%eax
    15cb:	89 44 24 04          	mov    %eax,0x4(%esp)
    15cf:	8b 45 08             	mov    0x8(%ebp),%eax
    15d2:	89 04 24             	mov    %eax,(%esp)
    15d5:	e8 92 fd ff ff       	call   136c <putc>
      }
      state = 0;
    15da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15e1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15eb:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15ee:	0f b6 00             	movzbl (%eax),%eax
    15f1:	84 c0                	test   %al,%al
    15f3:	0f 85 6e fe ff ff    	jne    1467 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15f9:	c9                   	leave  
    15fa:	c3                   	ret    
    15fb:	90                   	nop

000015fc <free>:
    15fc:	55                   	push   %ebp
    15fd:	89 e5                	mov    %esp,%ebp
    15ff:	83 ec 10             	sub    $0x10,%esp
    1602:	8b 45 08             	mov    0x8(%ebp),%eax
    1605:	83 e8 08             	sub    $0x8,%eax
    1608:	89 45 f8             	mov    %eax,-0x8(%ebp)
    160b:	a1 f0 1a 00 00       	mov    0x1af0,%eax
    1610:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1613:	eb 24                	jmp    1639 <free+0x3d>
    1615:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1618:	8b 00                	mov    (%eax),%eax
    161a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161d:	77 12                	ja     1631 <free+0x35>
    161f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1622:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1625:	77 24                	ja     164b <free+0x4f>
    1627:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162a:	8b 00                	mov    (%eax),%eax
    162c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    162f:	77 1a                	ja     164b <free+0x4f>
    1631:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1634:	8b 00                	mov    (%eax),%eax
    1636:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1639:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    163f:	76 d4                	jbe    1615 <free+0x19>
    1641:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1644:	8b 00                	mov    (%eax),%eax
    1646:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1649:	76 ca                	jbe    1615 <free+0x19>
    164b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164e:	8b 40 04             	mov    0x4(%eax),%eax
    1651:	c1 e0 03             	shl    $0x3,%eax
    1654:	89 c2                	mov    %eax,%edx
    1656:	03 55 f8             	add    -0x8(%ebp),%edx
    1659:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165c:	8b 00                	mov    (%eax),%eax
    165e:	39 c2                	cmp    %eax,%edx
    1660:	75 24                	jne    1686 <free+0x8a>
    1662:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1665:	8b 50 04             	mov    0x4(%eax),%edx
    1668:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166b:	8b 00                	mov    (%eax),%eax
    166d:	8b 40 04             	mov    0x4(%eax),%eax
    1670:	01 c2                	add    %eax,%edx
    1672:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1675:	89 50 04             	mov    %edx,0x4(%eax)
    1678:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167b:	8b 00                	mov    (%eax),%eax
    167d:	8b 10                	mov    (%eax),%edx
    167f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1682:	89 10                	mov    %edx,(%eax)
    1684:	eb 0a                	jmp    1690 <free+0x94>
    1686:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1689:	8b 10                	mov    (%eax),%edx
    168b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168e:	89 10                	mov    %edx,(%eax)
    1690:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1693:	8b 40 04             	mov    0x4(%eax),%eax
    1696:	c1 e0 03             	shl    $0x3,%eax
    1699:	03 45 fc             	add    -0x4(%ebp),%eax
    169c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    169f:	75 20                	jne    16c1 <free+0xc5>
    16a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a4:	8b 50 04             	mov    0x4(%eax),%edx
    16a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16aa:	8b 40 04             	mov    0x4(%eax),%eax
    16ad:	01 c2                	add    %eax,%edx
    16af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b2:	89 50 04             	mov    %edx,0x4(%eax)
    16b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b8:	8b 10                	mov    (%eax),%edx
    16ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bd:	89 10                	mov    %edx,(%eax)
    16bf:	eb 08                	jmp    16c9 <free+0xcd>
    16c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16c7:	89 10                	mov    %edx,(%eax)
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	a3 f0 1a 00 00       	mov    %eax,0x1af0
    16d1:	c9                   	leave  
    16d2:	c3                   	ret    

000016d3 <morecore>:
    16d3:	55                   	push   %ebp
    16d4:	89 e5                	mov    %esp,%ebp
    16d6:	83 ec 28             	sub    $0x28,%esp
    16d9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e0:	77 07                	ja     16e9 <morecore+0x16>
    16e2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    16e9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ec:	c1 e0 03             	shl    $0x3,%eax
    16ef:	89 04 24             	mov    %eax,(%esp)
    16f2:	e8 3d fc ff ff       	call   1334 <sbrk>
    16f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    16fa:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    16fe:	75 07                	jne    1707 <morecore+0x34>
    1700:	b8 00 00 00 00       	mov    $0x0,%eax
    1705:	eb 22                	jmp    1729 <morecore+0x56>
    1707:	8b 45 f0             	mov    -0x10(%ebp),%eax
    170a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    170d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1710:	8b 55 08             	mov    0x8(%ebp),%edx
    1713:	89 50 04             	mov    %edx,0x4(%eax)
    1716:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1719:	83 c0 08             	add    $0x8,%eax
    171c:	89 04 24             	mov    %eax,(%esp)
    171f:	e8 d8 fe ff ff       	call   15fc <free>
    1724:	a1 f0 1a 00 00       	mov    0x1af0,%eax
    1729:	c9                   	leave  
    172a:	c3                   	ret    

0000172b <malloc>:
    172b:	55                   	push   %ebp
    172c:	89 e5                	mov    %esp,%ebp
    172e:	83 ec 28             	sub    $0x28,%esp
    1731:	8b 45 08             	mov    0x8(%ebp),%eax
    1734:	83 c0 07             	add    $0x7,%eax
    1737:	c1 e8 03             	shr    $0x3,%eax
    173a:	83 c0 01             	add    $0x1,%eax
    173d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1740:	a1 f0 1a 00 00       	mov    0x1af0,%eax
    1745:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1748:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    174c:	75 23                	jne    1771 <malloc+0x46>
    174e:	c7 45 f0 e8 1a 00 00 	movl   $0x1ae8,-0x10(%ebp)
    1755:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1758:	a3 f0 1a 00 00       	mov    %eax,0x1af0
    175d:	a1 f0 1a 00 00       	mov    0x1af0,%eax
    1762:	a3 e8 1a 00 00       	mov    %eax,0x1ae8
    1767:	c7 05 ec 1a 00 00 00 	movl   $0x0,0x1aec
    176e:	00 00 00 
    1771:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1774:	8b 00                	mov    (%eax),%eax
    1776:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1779:	8b 45 ec             	mov    -0x14(%ebp),%eax
    177c:	8b 40 04             	mov    0x4(%eax),%eax
    177f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1782:	72 4d                	jb     17d1 <malloc+0xa6>
    1784:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1787:	8b 40 04             	mov    0x4(%eax),%eax
    178a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    178d:	75 0c                	jne    179b <malloc+0x70>
    178f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1792:	8b 10                	mov    (%eax),%edx
    1794:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1797:	89 10                	mov    %edx,(%eax)
    1799:	eb 26                	jmp    17c1 <malloc+0x96>
    179b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179e:	8b 40 04             	mov    0x4(%eax),%eax
    17a1:	89 c2                	mov    %eax,%edx
    17a3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a9:	89 50 04             	mov    %edx,0x4(%eax)
    17ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17af:	8b 40 04             	mov    0x4(%eax),%eax
    17b2:	c1 e0 03             	shl    $0x3,%eax
    17b5:	01 45 ec             	add    %eax,-0x14(%ebp)
    17b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17be:	89 50 04             	mov    %edx,0x4(%eax)
    17c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c4:	a3 f0 1a 00 00       	mov    %eax,0x1af0
    17c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17cc:	83 c0 08             	add    $0x8,%eax
    17cf:	eb 38                	jmp    1809 <malloc+0xde>
    17d1:	a1 f0 1a 00 00       	mov    0x1af0,%eax
    17d6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17d9:	75 1b                	jne    17f6 <malloc+0xcb>
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	89 04 24             	mov    %eax,(%esp)
    17e1:	e8 ed fe ff ff       	call   16d3 <morecore>
    17e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17ed:	75 07                	jne    17f6 <malloc+0xcb>
    17ef:	b8 00 00 00 00       	mov    $0x0,%eax
    17f4:	eb 13                	jmp    1809 <malloc+0xde>
    17f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ff:	8b 00                	mov    (%eax),%eax
    1801:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1804:	e9 70 ff ff ff       	jmp    1779 <malloc+0x4e>
    1809:	c9                   	leave  
    180a:	c3                   	ret    
    180b:	90                   	nop

0000180c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    180c:	55                   	push   %ebp
    180d:	89 e5                	mov    %esp,%ebp
    180f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1812:	8b 55 08             	mov    0x8(%ebp),%edx
    1815:	8b 45 0c             	mov    0xc(%ebp),%eax
    1818:	8b 4d 08             	mov    0x8(%ebp),%ecx
    181b:	f0 87 02             	lock xchg %eax,(%edx)
    181e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1821:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1824:	c9                   	leave  
    1825:	c3                   	ret    

00001826 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1826:	55                   	push   %ebp
    1827:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1829:	8b 45 08             	mov    0x8(%ebp),%eax
    182c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1832:	5d                   	pop    %ebp
    1833:	c3                   	ret    

00001834 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1834:	55                   	push   %ebp
    1835:	89 e5                	mov    %esp,%ebp
    1837:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    183a:	8b 45 08             	mov    0x8(%ebp),%eax
    183d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1844:	00 
    1845:	89 04 24             	mov    %eax,(%esp)
    1848:	e8 bf ff ff ff       	call   180c <xchg>
    184d:	85 c0                	test   %eax,%eax
    184f:	75 e9                	jne    183a <lock_acquire+0x6>
}
    1851:	c9                   	leave  
    1852:	c3                   	ret    

00001853 <lock_release>:
void lock_release(lock_t *lock){
    1853:	55                   	push   %ebp
    1854:	89 e5                	mov    %esp,%ebp
    1856:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1859:	8b 45 08             	mov    0x8(%ebp),%eax
    185c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1863:	00 
    1864:	89 04 24             	mov    %eax,(%esp)
    1867:	e8 a0 ff ff ff       	call   180c <xchg>
}
    186c:	c9                   	leave  
    186d:	c3                   	ret    

0000186e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    186e:	55                   	push   %ebp
    186f:	89 e5                	mov    %esp,%ebp
    1871:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1874:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    187b:	e8 ab fe ff ff       	call   172b <malloc>
    1880:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1883:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1886:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1889:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1891:	85 c0                	test   %eax,%eax
    1893:	74 15                	je     18aa <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1895:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1898:	89 c2                	mov    %eax,%edx
    189a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18a0:	b8 00 10 00 00       	mov    $0x1000,%eax
    18a5:	29 d0                	sub    %edx,%eax
    18a7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    18aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18ae:	75 1b                	jne    18cb <thread_create+0x5d>

        printf(1,"malloc fail \n");
    18b0:	c7 44 24 04 a4 1a 00 	movl   $0x1aa4,0x4(%esp)
    18b7:	00 
    18b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18bf:	e8 81 fb ff ff       	call   1445 <printf>
        return 0;
    18c4:	b8 00 00 00 00       	mov    $0x0,%eax
    18c9:	eb 6f                	jmp    193a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18cb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18ce:	8b 55 08             	mov    0x8(%ebp),%edx
    18d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18d8:	89 54 24 08          	mov    %edx,0x8(%esp)
    18dc:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18e3:	00 
    18e4:	89 04 24             	mov    %eax,(%esp)
    18e7:	e8 60 fa ff ff       	call   134c <clone>
    18ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18f3:	79 1b                	jns    1910 <thread_create+0xa2>
        printf(1,"clone fails\n");
    18f5:	c7 44 24 04 b2 1a 00 	movl   $0x1ab2,0x4(%esp)
    18fc:	00 
    18fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1904:	e8 3c fb ff ff       	call   1445 <printf>
        return 0;
    1909:	b8 00 00 00 00       	mov    $0x0,%eax
    190e:	eb 2a                	jmp    193a <thread_create+0xcc>
    }
    if(tid > 0){
    1910:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1914:	7e 05                	jle    191b <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1916:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1919:	eb 1f                	jmp    193a <thread_create+0xcc>
    }
    if(tid == 0){
    191b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191f:	75 14                	jne    1935 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1921:	c7 44 24 04 bf 1a 00 	movl   $0x1abf,0x4(%esp)
    1928:	00 
    1929:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1930:	e8 10 fb ff ff       	call   1445 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1935:	b8 00 00 00 00       	mov    $0x0,%eax
}
    193a:	c9                   	leave  
    193b:	c3                   	ret    

0000193c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    193c:	55                   	push   %ebp
    193d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    193f:	a1 e4 1a 00 00       	mov    0x1ae4,%eax
    1944:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    194a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    194f:	a3 e4 1a 00 00       	mov    %eax,0x1ae4
    return (int)(rands % max);
    1954:	a1 e4 1a 00 00       	mov    0x1ae4,%eax
    1959:	8b 4d 08             	mov    0x8(%ebp),%ecx
    195c:	ba 00 00 00 00       	mov    $0x0,%edx
    1961:	f7 f1                	div    %ecx
    1963:	89 d0                	mov    %edx,%eax
}
    1965:	5d                   	pop    %ebp
    1966:	c3                   	ret    
    1967:	90                   	nop

00001968 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1968:	55                   	push   %ebp
    1969:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    196b:	8b 45 08             	mov    0x8(%ebp),%eax
    196e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1974:	8b 45 08             	mov    0x8(%ebp),%eax
    1977:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    197e:	8b 45 08             	mov    0x8(%ebp),%eax
    1981:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1988:	5d                   	pop    %ebp
    1989:	c3                   	ret    

0000198a <add_q>:

void add_q(struct queue *q, int v){
    198a:	55                   	push   %ebp
    198b:	89 e5                	mov    %esp,%ebp
    198d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1990:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1997:	e8 8f fd ff ff       	call   172b <malloc>
    199c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    199f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    19a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    19af:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    19b1:	8b 45 08             	mov    0x8(%ebp),%eax
    19b4:	8b 40 04             	mov    0x4(%eax),%eax
    19b7:	85 c0                	test   %eax,%eax
    19b9:	75 0b                	jne    19c6 <add_q+0x3c>
        q->head = n;
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19c1:	89 50 04             	mov    %edx,0x4(%eax)
    19c4:	eb 0c                	jmp    19d2 <add_q+0x48>
    }else{
        q->tail->next = n;
    19c6:	8b 45 08             	mov    0x8(%ebp),%eax
    19c9:	8b 40 08             	mov    0x8(%eax),%eax
    19cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19cf:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19d8:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19db:	8b 45 08             	mov    0x8(%ebp),%eax
    19de:	8b 00                	mov    (%eax),%eax
    19e0:	8d 50 01             	lea    0x1(%eax),%edx
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	89 10                	mov    %edx,(%eax)
}
    19e8:	c9                   	leave  
    19e9:	c3                   	ret    

000019ea <empty_q>:

int empty_q(struct queue *q){
    19ea:	55                   	push   %ebp
    19eb:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19ed:	8b 45 08             	mov    0x8(%ebp),%eax
    19f0:	8b 00                	mov    (%eax),%eax
    19f2:	85 c0                	test   %eax,%eax
    19f4:	75 07                	jne    19fd <empty_q+0x13>
        return 1;
    19f6:	b8 01 00 00 00       	mov    $0x1,%eax
    19fb:	eb 05                	jmp    1a02 <empty_q+0x18>
    else
        return 0;
    19fd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1a02:	5d                   	pop    %ebp
    1a03:	c3                   	ret    

00001a04 <pop_q>:
int pop_q(struct queue *q){
    1a04:	55                   	push   %ebp
    1a05:	89 e5                	mov    %esp,%ebp
    1a07:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1a0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0d:	89 04 24             	mov    %eax,(%esp)
    1a10:	e8 d5 ff ff ff       	call   19ea <empty_q>
    1a15:	85 c0                	test   %eax,%eax
    1a17:	75 5d                	jne    1a76 <pop_q+0x72>
       val = q->head->value; 
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1c:	8b 40 04             	mov    0x4(%eax),%eax
    1a1f:	8b 00                	mov    (%eax),%eax
    1a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1a24:	8b 45 08             	mov    0x8(%ebp),%eax
    1a27:	8b 40 04             	mov    0x4(%eax),%eax
    1a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a30:	8b 40 04             	mov    0x4(%eax),%eax
    1a33:	8b 50 04             	mov    0x4(%eax),%edx
    1a36:	8b 45 08             	mov    0x8(%ebp),%eax
    1a39:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3f:	89 04 24             	mov    %eax,(%esp)
    1a42:	e8 b5 fb ff ff       	call   15fc <free>
       q->size--;
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	8b 00                	mov    (%eax),%eax
    1a4c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a52:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a54:	8b 45 08             	mov    0x8(%ebp),%eax
    1a57:	8b 00                	mov    (%eax),%eax
    1a59:	85 c0                	test   %eax,%eax
    1a5b:	75 14                	jne    1a71 <pop_q+0x6d>
            q->head = 0;
    1a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a60:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a67:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a74:	eb 05                	jmp    1a7b <pop_q+0x77>
    }
    return -1;
    1a76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a7b:	c9                   	leave  
    1a7c:	c3                   	ret    
