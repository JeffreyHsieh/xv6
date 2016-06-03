
_cat:     file format elf32-i386


Disassembly of section .text:

00001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    1006:	eb 1b                	jmp    1023 <cat+0x23>
    write(1, buf, n);
    1008:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100b:	89 44 24 08          	mov    %eax,0x8(%esp)
    100f:	c7 44 24 04 c0 1f 00 	movl   $0x1fc0,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    101e:	e8 85 03 00 00       	call   13a8 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    1023:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    102a:	00 
    102b:	c7 44 24 04 c0 1f 00 	movl   $0x1fc0,0x4(%esp)
    1032:	00 
    1033:	8b 45 08             	mov    0x8(%ebp),%eax
    1036:	89 04 24             	mov    %eax,(%esp)
    1039:	e8 62 03 00 00       	call   13a0 <read>
    103e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1041:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1045:	7f c1                	jg     1008 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
    1047:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    104b:	79 19                	jns    1066 <cat+0x66>
    printf(1, "cat: read error\n");
    104d:	c7 44 24 04 71 1b 00 	movl   $0x1b71,0x4(%esp)
    1054:	00 
    1055:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    105c:	e8 cf 04 00 00       	call   1530 <printf>
    exit();
    1061:	e8 22 03 00 00       	call   1388 <exit>
  }
}
    1066:	c9                   	leave  
    1067:	c3                   	ret    

00001068 <main>:

int
main(int argc, char *argv[])
{
    1068:	55                   	push   %ebp
    1069:	89 e5                	mov    %esp,%ebp
    106b:	83 e4 f0             	and    $0xfffffff0,%esp
    106e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
    1071:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1075:	7f 11                	jg     1088 <main+0x20>
    cat(0);
    1077:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    107e:	e8 7d ff ff ff       	call   1000 <cat>
    exit();
    1083:	e8 00 03 00 00       	call   1388 <exit>
  }

  for(i = 1; i < argc; i++){
    1088:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    108f:	00 
    1090:	eb 79                	jmp    110b <main+0xa3>
    if((fd = open(argv[i], 0)) < 0){
    1092:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1096:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    109d:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a0:	01 d0                	add    %edx,%eax
    10a2:	8b 00                	mov    (%eax),%eax
    10a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ab:	00 
    10ac:	89 04 24             	mov    %eax,(%esp)
    10af:	e8 14 03 00 00       	call   13c8 <open>
    10b4:	89 44 24 18          	mov    %eax,0x18(%esp)
    10b8:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10bd:	79 2f                	jns    10ee <main+0x86>
      printf(1, "cat: cannot open %s\n", argv[i]);
    10bf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    10c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    10ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cd:	01 d0                	add    %edx,%eax
    10cf:	8b 00                	mov    (%eax),%eax
    10d1:	89 44 24 08          	mov    %eax,0x8(%esp)
    10d5:	c7 44 24 04 82 1b 00 	movl   $0x1b82,0x4(%esp)
    10dc:	00 
    10dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10e4:	e8 47 04 00 00       	call   1530 <printf>
      exit();
    10e9:	e8 9a 02 00 00       	call   1388 <exit>
    }
    cat(fd);
    10ee:	8b 44 24 18          	mov    0x18(%esp),%eax
    10f2:	89 04 24             	mov    %eax,(%esp)
    10f5:	e8 06 ff ff ff       	call   1000 <cat>
    close(fd);
    10fa:	8b 44 24 18          	mov    0x18(%esp),%eax
    10fe:	89 04 24             	mov    %eax,(%esp)
    1101:	e8 aa 02 00 00       	call   13b0 <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    1106:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    110b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    110f:	3b 45 08             	cmp    0x8(%ebp),%eax
    1112:	0f 8c 7a ff ff ff    	jl     1092 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
    1118:	e8 6b 02 00 00       	call   1388 <exit>
    111d:	66 90                	xchg   %ax,%ax
    111f:	90                   	nop

00001120 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1125:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1128:	8b 55 10             	mov    0x10(%ebp),%edx
    112b:	8b 45 0c             	mov    0xc(%ebp),%eax
    112e:	89 cb                	mov    %ecx,%ebx
    1130:	89 df                	mov    %ebx,%edi
    1132:	89 d1                	mov    %edx,%ecx
    1134:	fc                   	cld    
    1135:	f3 aa                	rep stos %al,%es:(%edi)
    1137:	89 ca                	mov    %ecx,%edx
    1139:	89 fb                	mov    %edi,%ebx
    113b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    113e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1141:	5b                   	pop    %ebx
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    

00001145 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1145:	55                   	push   %ebp
    1146:	89 e5                	mov    %esp,%ebp
    1148:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1151:	90                   	nop
    1152:	8b 45 08             	mov    0x8(%ebp),%eax
    1155:	8d 50 01             	lea    0x1(%eax),%edx
    1158:	89 55 08             	mov    %edx,0x8(%ebp)
    115b:	8b 55 0c             	mov    0xc(%ebp),%edx
    115e:	8d 4a 01             	lea    0x1(%edx),%ecx
    1161:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1164:	0f b6 12             	movzbl (%edx),%edx
    1167:	88 10                	mov    %dl,(%eax)
    1169:	0f b6 00             	movzbl (%eax),%eax
    116c:	84 c0                	test   %al,%al
    116e:	75 e2                	jne    1152 <strcpy+0xd>
    ;
  return os;
    1170:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1173:	c9                   	leave  
    1174:	c3                   	ret    

00001175 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1175:	55                   	push   %ebp
    1176:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1178:	eb 08                	jmp    1182 <strcmp+0xd>
    p++, q++;
    117a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    117e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1182:	8b 45 08             	mov    0x8(%ebp),%eax
    1185:	0f b6 00             	movzbl (%eax),%eax
    1188:	84 c0                	test   %al,%al
    118a:	74 10                	je     119c <strcmp+0x27>
    118c:	8b 45 08             	mov    0x8(%ebp),%eax
    118f:	0f b6 10             	movzbl (%eax),%edx
    1192:	8b 45 0c             	mov    0xc(%ebp),%eax
    1195:	0f b6 00             	movzbl (%eax),%eax
    1198:	38 c2                	cmp    %al,%dl
    119a:	74 de                	je     117a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	0f b6 00             	movzbl (%eax),%eax
    11a2:	0f b6 d0             	movzbl %al,%edx
    11a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a8:	0f b6 00             	movzbl (%eax),%eax
    11ab:	0f b6 c0             	movzbl %al,%eax
    11ae:	29 c2                	sub    %eax,%edx
    11b0:	89 d0                	mov    %edx,%eax
}
    11b2:	5d                   	pop    %ebp
    11b3:	c3                   	ret    

000011b4 <strlen>:

uint
strlen(char *s)
{
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
    11b7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11c1:	eb 04                	jmp    11c7 <strlen+0x13>
    11c3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	01 d0                	add    %edx,%eax
    11cf:	0f b6 00             	movzbl (%eax),%eax
    11d2:	84 c0                	test   %al,%al
    11d4:	75 ed                	jne    11c3 <strlen+0xf>
    ;
  return n;
    11d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11d9:	c9                   	leave  
    11da:	c3                   	ret    

000011db <memset>:

void*
memset(void *dst, int c, uint n)
{
    11db:	55                   	push   %ebp
    11dc:	89 e5                	mov    %esp,%ebp
    11de:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    11e1:	8b 45 10             	mov    0x10(%ebp),%eax
    11e4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11eb:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	89 04 24             	mov    %eax,(%esp)
    11f5:	e8 26 ff ff ff       	call   1120 <stosb>
  return dst;
    11fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11fd:	c9                   	leave  
    11fe:	c3                   	ret    

000011ff <strchr>:

char*
strchr(const char *s, char c)
{
    11ff:	55                   	push   %ebp
    1200:	89 e5                	mov    %esp,%ebp
    1202:	83 ec 04             	sub    $0x4,%esp
    1205:	8b 45 0c             	mov    0xc(%ebp),%eax
    1208:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    120b:	eb 14                	jmp    1221 <strchr+0x22>
    if(*s == c)
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	0f b6 00             	movzbl (%eax),%eax
    1213:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1216:	75 05                	jne    121d <strchr+0x1e>
      return (char*)s;
    1218:	8b 45 08             	mov    0x8(%ebp),%eax
    121b:	eb 13                	jmp    1230 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    121d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1221:	8b 45 08             	mov    0x8(%ebp),%eax
    1224:	0f b6 00             	movzbl (%eax),%eax
    1227:	84 c0                	test   %al,%al
    1229:	75 e2                	jne    120d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    122b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1230:	c9                   	leave  
    1231:	c3                   	ret    

00001232 <gets>:

char*
gets(char *buf, int max)
{
    1232:	55                   	push   %ebp
    1233:	89 e5                	mov    %esp,%ebp
    1235:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    123f:	eb 4c                	jmp    128d <gets+0x5b>
    cc = read(0, &c, 1);
    1241:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1248:	00 
    1249:	8d 45 ef             	lea    -0x11(%ebp),%eax
    124c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1250:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1257:	e8 44 01 00 00       	call   13a0 <read>
    125c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    125f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1263:	7f 02                	jg     1267 <gets+0x35>
      break;
    1265:	eb 31                	jmp    1298 <gets+0x66>
    buf[i++] = c;
    1267:	8b 45 f4             	mov    -0xc(%ebp),%eax
    126a:	8d 50 01             	lea    0x1(%eax),%edx
    126d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1270:	89 c2                	mov    %eax,%edx
    1272:	8b 45 08             	mov    0x8(%ebp),%eax
    1275:	01 c2                	add    %eax,%edx
    1277:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    127b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    127d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1281:	3c 0a                	cmp    $0xa,%al
    1283:	74 13                	je     1298 <gets+0x66>
    1285:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1289:	3c 0d                	cmp    $0xd,%al
    128b:	74 0b                	je     1298 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    128d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1290:	83 c0 01             	add    $0x1,%eax
    1293:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1296:	7c a9                	jl     1241 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1298:	8b 55 f4             	mov    -0xc(%ebp),%edx
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	01 d0                	add    %edx,%eax
    12a0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a6:	c9                   	leave  
    12a7:	c3                   	ret    

000012a8 <stat>:

int
stat(char *n, struct stat *st)
{
    12a8:	55                   	push   %ebp
    12a9:	89 e5                	mov    %esp,%ebp
    12ab:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12b5:	00 
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
    12b9:	89 04 24             	mov    %eax,(%esp)
    12bc:	e8 07 01 00 00       	call   13c8 <open>
    12c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    12c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12c8:	79 07                	jns    12d1 <stat+0x29>
    return -1;
    12ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12cf:	eb 23                	jmp    12f4 <stat+0x4c>
  r = fstat(fd, st);
    12d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    12d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12db:	89 04 24             	mov    %eax,(%esp)
    12de:	e8 fd 00 00 00       	call   13e0 <fstat>
    12e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    12e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e9:	89 04 24             	mov    %eax,(%esp)
    12ec:	e8 bf 00 00 00       	call   13b0 <close>
  return r;
    12f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    12f4:	c9                   	leave  
    12f5:	c3                   	ret    

000012f6 <atoi>:

int
atoi(const char *s)
{
    12f6:	55                   	push   %ebp
    12f7:	89 e5                	mov    %esp,%ebp
    12f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1303:	eb 25                	jmp    132a <atoi+0x34>
    n = n*10 + *s++ - '0';
    1305:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1308:	89 d0                	mov    %edx,%eax
    130a:	c1 e0 02             	shl    $0x2,%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	01 c0                	add    %eax,%eax
    1311:	89 c1                	mov    %eax,%ecx
    1313:	8b 45 08             	mov    0x8(%ebp),%eax
    1316:	8d 50 01             	lea    0x1(%eax),%edx
    1319:	89 55 08             	mov    %edx,0x8(%ebp)
    131c:	0f b6 00             	movzbl (%eax),%eax
    131f:	0f be c0             	movsbl %al,%eax
    1322:	01 c8                	add    %ecx,%eax
    1324:	83 e8 30             	sub    $0x30,%eax
    1327:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    132a:	8b 45 08             	mov    0x8(%ebp),%eax
    132d:	0f b6 00             	movzbl (%eax),%eax
    1330:	3c 2f                	cmp    $0x2f,%al
    1332:	7e 0a                	jle    133e <atoi+0x48>
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
    1337:	0f b6 00             	movzbl (%eax),%eax
    133a:	3c 39                	cmp    $0x39,%al
    133c:	7e c7                	jle    1305 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    133e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1341:	c9                   	leave  
    1342:	c3                   	ret    

00001343 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1343:	55                   	push   %ebp
    1344:	89 e5                	mov    %esp,%ebp
    1346:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1349:	8b 45 08             	mov    0x8(%ebp),%eax
    134c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    134f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1352:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1355:	eb 17                	jmp    136e <memmove+0x2b>
    *dst++ = *src++;
    1357:	8b 45 fc             	mov    -0x4(%ebp),%eax
    135a:	8d 50 01             	lea    0x1(%eax),%edx
    135d:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1360:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1363:	8d 4a 01             	lea    0x1(%edx),%ecx
    1366:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1369:	0f b6 12             	movzbl (%edx),%edx
    136c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    136e:	8b 45 10             	mov    0x10(%ebp),%eax
    1371:	8d 50 ff             	lea    -0x1(%eax),%edx
    1374:	89 55 10             	mov    %edx,0x10(%ebp)
    1377:	85 c0                	test   %eax,%eax
    1379:	7f dc                	jg     1357 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    137e:	c9                   	leave  
    137f:	c3                   	ret    

00001380 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1380:	b8 01 00 00 00       	mov    $0x1,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <exit>:
SYSCALL(exit)
    1388:	b8 02 00 00 00       	mov    $0x2,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <wait>:
SYSCALL(wait)
    1390:	b8 03 00 00 00       	mov    $0x3,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <pipe>:
SYSCALL(pipe)
    1398:	b8 04 00 00 00       	mov    $0x4,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <read>:
SYSCALL(read)
    13a0:	b8 05 00 00 00       	mov    $0x5,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <write>:
SYSCALL(write)
    13a8:	b8 10 00 00 00       	mov    $0x10,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <close>:
SYSCALL(close)
    13b0:	b8 15 00 00 00       	mov    $0x15,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <kill>:
SYSCALL(kill)
    13b8:	b8 06 00 00 00       	mov    $0x6,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <exec>:
SYSCALL(exec)
    13c0:	b8 07 00 00 00       	mov    $0x7,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <open>:
SYSCALL(open)
    13c8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <mknod>:
SYSCALL(mknod)
    13d0:	b8 11 00 00 00       	mov    $0x11,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <unlink>:
SYSCALL(unlink)
    13d8:	b8 12 00 00 00       	mov    $0x12,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <fstat>:
SYSCALL(fstat)
    13e0:	b8 08 00 00 00       	mov    $0x8,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <link>:
SYSCALL(link)
    13e8:	b8 13 00 00 00       	mov    $0x13,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <mkdir>:
SYSCALL(mkdir)
    13f0:	b8 14 00 00 00       	mov    $0x14,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <chdir>:
SYSCALL(chdir)
    13f8:	b8 09 00 00 00       	mov    $0x9,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <dup>:
SYSCALL(dup)
    1400:	b8 0a 00 00 00       	mov    $0xa,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <getpid>:
SYSCALL(getpid)
    1408:	b8 0b 00 00 00       	mov    $0xb,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <sbrk>:
SYSCALL(sbrk)
    1410:	b8 0c 00 00 00       	mov    $0xc,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <sleep>:
SYSCALL(sleep)
    1418:	b8 0d 00 00 00       	mov    $0xd,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <uptime>:
SYSCALL(uptime)
    1420:	b8 0e 00 00 00       	mov    $0xe,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <clone>:
SYSCALL(clone)
    1428:	b8 16 00 00 00       	mov    $0x16,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <texit>:
SYSCALL(texit)
    1430:	b8 17 00 00 00       	mov    $0x17,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <tsleep>:
SYSCALL(tsleep)
    1438:	b8 18 00 00 00       	mov    $0x18,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <twakeup>:
SYSCALL(twakeup)
    1440:	b8 19 00 00 00       	mov    $0x19,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <thread_yield>:
SYSCALL(thread_yield)
    1448:	b8 1a 00 00 00       	mov    $0x1a,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	83 ec 18             	sub    $0x18,%esp
    1456:	8b 45 0c             	mov    0xc(%ebp),%eax
    1459:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    145c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1463:	00 
    1464:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1467:	89 44 24 04          	mov    %eax,0x4(%esp)
    146b:	8b 45 08             	mov    0x8(%ebp),%eax
    146e:	89 04 24             	mov    %eax,(%esp)
    1471:	e8 32 ff ff ff       	call   13a8 <write>
}
    1476:	c9                   	leave  
    1477:	c3                   	ret    

00001478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1478:	55                   	push   %ebp
    1479:	89 e5                	mov    %esp,%ebp
    147b:	56                   	push   %esi
    147c:	53                   	push   %ebx
    147d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1487:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    148b:	74 17                	je     14a4 <printint+0x2c>
    148d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1491:	79 11                	jns    14a4 <printint+0x2c>
    neg = 1;
    1493:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    149a:	8b 45 0c             	mov    0xc(%ebp),%eax
    149d:	f7 d8                	neg    %eax
    149f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14a2:	eb 06                	jmp    14aa <printint+0x32>
  } else {
    x = xx;
    14a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    14a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    14aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    14b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14b4:	8d 41 01             	lea    0x1(%ecx),%eax
    14b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14c0:	ba 00 00 00 00       	mov    $0x0,%edx
    14c5:	f7 f3                	div    %ebx
    14c7:	89 d0                	mov    %edx,%eax
    14c9:	0f b6 80 70 1f 00 00 	movzbl 0x1f70(%eax),%eax
    14d0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    14d4:	8b 75 10             	mov    0x10(%ebp),%esi
    14d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14da:	ba 00 00 00 00       	mov    $0x0,%edx
    14df:	f7 f6                	div    %esi
    14e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14e8:	75 c7                	jne    14b1 <printint+0x39>
  if(neg)
    14ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14ee:	74 10                	je     1500 <printint+0x88>
    buf[i++] = '-';
    14f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f3:	8d 50 01             	lea    0x1(%eax),%edx
    14f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14f9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14fe:	eb 1f                	jmp    151f <printint+0xa7>
    1500:	eb 1d                	jmp    151f <printint+0xa7>
    putc(fd, buf[i]);
    1502:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1505:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1508:	01 d0                	add    %edx,%eax
    150a:	0f b6 00             	movzbl (%eax),%eax
    150d:	0f be c0             	movsbl %al,%eax
    1510:	89 44 24 04          	mov    %eax,0x4(%esp)
    1514:	8b 45 08             	mov    0x8(%ebp),%eax
    1517:	89 04 24             	mov    %eax,(%esp)
    151a:	e8 31 ff ff ff       	call   1450 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    151f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1523:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1527:	79 d9                	jns    1502 <printint+0x8a>
    putc(fd, buf[i]);
}
    1529:	83 c4 30             	add    $0x30,%esp
    152c:	5b                   	pop    %ebx
    152d:	5e                   	pop    %esi
    152e:	5d                   	pop    %ebp
    152f:	c3                   	ret    

00001530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1536:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    153d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1540:	83 c0 04             	add    $0x4,%eax
    1543:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    154d:	e9 7c 01 00 00       	jmp    16ce <printf+0x19e>
    c = fmt[i] & 0xff;
    1552:	8b 55 0c             	mov    0xc(%ebp),%edx
    1555:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1558:	01 d0                	add    %edx,%eax
    155a:	0f b6 00             	movzbl (%eax),%eax
    155d:	0f be c0             	movsbl %al,%eax
    1560:	25 ff 00 00 00       	and    $0xff,%eax
    1565:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1568:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    156c:	75 2c                	jne    159a <printf+0x6a>
      if(c == '%'){
    156e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1572:	75 0c                	jne    1580 <printf+0x50>
        state = '%';
    1574:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    157b:	e9 4a 01 00 00       	jmp    16ca <printf+0x19a>
      } else {
        putc(fd, c);
    1580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1583:	0f be c0             	movsbl %al,%eax
    1586:	89 44 24 04          	mov    %eax,0x4(%esp)
    158a:	8b 45 08             	mov    0x8(%ebp),%eax
    158d:	89 04 24             	mov    %eax,(%esp)
    1590:	e8 bb fe ff ff       	call   1450 <putc>
    1595:	e9 30 01 00 00       	jmp    16ca <printf+0x19a>
      }
    } else if(state == '%'){
    159a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    159e:	0f 85 26 01 00 00    	jne    16ca <printf+0x19a>
      if(c == 'd'){
    15a4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    15a8:	75 2d                	jne    15d7 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    15aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ad:	8b 00                	mov    (%eax),%eax
    15af:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    15b6:	00 
    15b7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    15be:	00 
    15bf:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c3:	8b 45 08             	mov    0x8(%ebp),%eax
    15c6:	89 04 24             	mov    %eax,(%esp)
    15c9:	e8 aa fe ff ff       	call   1478 <printint>
        ap++;
    15ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15d2:	e9 ec 00 00 00       	jmp    16c3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    15d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15db:	74 06                	je     15e3 <printf+0xb3>
    15dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15e1:	75 2d                	jne    1610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    15e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15e6:	8b 00                	mov    (%eax),%eax
    15e8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15ef:	00 
    15f0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15f7:	00 
    15f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15fc:	8b 45 08             	mov    0x8(%ebp),%eax
    15ff:	89 04 24             	mov    %eax,(%esp)
    1602:	e8 71 fe ff ff       	call   1478 <printint>
        ap++;
    1607:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    160b:	e9 b3 00 00 00       	jmp    16c3 <printf+0x193>
      } else if(c == 's'){
    1610:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1614:	75 45                	jne    165b <printf+0x12b>
        s = (char*)*ap;
    1616:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1619:	8b 00                	mov    (%eax),%eax
    161b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    161e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1622:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1626:	75 09                	jne    1631 <printf+0x101>
          s = "(null)";
    1628:	c7 45 f4 97 1b 00 00 	movl   $0x1b97,-0xc(%ebp)
        while(*s != 0){
    162f:	eb 1e                	jmp    164f <printf+0x11f>
    1631:	eb 1c                	jmp    164f <printf+0x11f>
          putc(fd, *s);
    1633:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1636:	0f b6 00             	movzbl (%eax),%eax
    1639:	0f be c0             	movsbl %al,%eax
    163c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1640:	8b 45 08             	mov    0x8(%ebp),%eax
    1643:	89 04 24             	mov    %eax,(%esp)
    1646:	e8 05 fe ff ff       	call   1450 <putc>
          s++;
    164b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    164f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1652:	0f b6 00             	movzbl (%eax),%eax
    1655:	84 c0                	test   %al,%al
    1657:	75 da                	jne    1633 <printf+0x103>
    1659:	eb 68                	jmp    16c3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    165b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    165f:	75 1d                	jne    167e <printf+0x14e>
        putc(fd, *ap);
    1661:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	0f be c0             	movsbl %al,%eax
    1669:	89 44 24 04          	mov    %eax,0x4(%esp)
    166d:	8b 45 08             	mov    0x8(%ebp),%eax
    1670:	89 04 24             	mov    %eax,(%esp)
    1673:	e8 d8 fd ff ff       	call   1450 <putc>
        ap++;
    1678:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    167c:	eb 45                	jmp    16c3 <printf+0x193>
      } else if(c == '%'){
    167e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1682:	75 17                	jne    169b <printf+0x16b>
        putc(fd, c);
    1684:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1687:	0f be c0             	movsbl %al,%eax
    168a:	89 44 24 04          	mov    %eax,0x4(%esp)
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	89 04 24             	mov    %eax,(%esp)
    1694:	e8 b7 fd ff ff       	call   1450 <putc>
    1699:	eb 28                	jmp    16c3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    169b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    16a2:	00 
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	89 04 24             	mov    %eax,(%esp)
    16a9:	e8 a2 fd ff ff       	call   1450 <putc>
        putc(fd, c);
    16ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16b1:	0f be c0             	movsbl %al,%eax
    16b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	89 04 24             	mov    %eax,(%esp)
    16be:	e8 8d fd ff ff       	call   1450 <putc>
      }
      state = 0;
    16c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16ca:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16ce:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16d4:	01 d0                	add    %edx,%eax
    16d6:	0f b6 00             	movzbl (%eax),%eax
    16d9:	84 c0                	test   %al,%al
    16db:	0f 85 71 fe ff ff    	jne    1552 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    16e1:	c9                   	leave  
    16e2:	c3                   	ret    
    16e3:	90                   	nop

000016e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16e4:	55                   	push   %ebp
    16e5:	89 e5                	mov    %esp,%ebp
    16e7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	83 e8 08             	sub    $0x8,%eax
    16f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f3:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    16f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16fb:	eb 24                	jmp    1721 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1700:	8b 00                	mov    (%eax),%eax
    1702:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1705:	77 12                	ja     1719 <free+0x35>
    1707:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    170d:	77 24                	ja     1733 <free+0x4f>
    170f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1712:	8b 00                	mov    (%eax),%eax
    1714:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1717:	77 1a                	ja     1733 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1721:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1724:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1727:	76 d4                	jbe    16fd <free+0x19>
    1729:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172c:	8b 00                	mov    (%eax),%eax
    172e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1731:	76 ca                	jbe    16fd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1733:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1736:	8b 40 04             	mov    0x4(%eax),%eax
    1739:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1740:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1743:	01 c2                	add    %eax,%edx
    1745:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1748:	8b 00                	mov    (%eax),%eax
    174a:	39 c2                	cmp    %eax,%edx
    174c:	75 24                	jne    1772 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    174e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1751:	8b 50 04             	mov    0x4(%eax),%edx
    1754:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1757:	8b 00                	mov    (%eax),%eax
    1759:	8b 40 04             	mov    0x4(%eax),%eax
    175c:	01 c2                	add    %eax,%edx
    175e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1761:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1764:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1767:	8b 00                	mov    (%eax),%eax
    1769:	8b 10                	mov    (%eax),%edx
    176b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176e:	89 10                	mov    %edx,(%eax)
    1770:	eb 0a                	jmp    177c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1772:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1775:	8b 10                	mov    (%eax),%edx
    1777:	8b 45 f8             	mov    -0x8(%ebp),%eax
    177a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    177c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177f:	8b 40 04             	mov    0x4(%eax),%eax
    1782:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1789:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178c:	01 d0                	add    %edx,%eax
    178e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1791:	75 20                	jne    17b3 <free+0xcf>
    p->s.size += bp->s.size;
    1793:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1796:	8b 50 04             	mov    0x4(%eax),%edx
    1799:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179c:	8b 40 04             	mov    0x4(%eax),%eax
    179f:	01 c2                	add    %eax,%edx
    17a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17aa:	8b 10                	mov    (%eax),%edx
    17ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17af:	89 10                	mov    %edx,(%eax)
    17b1:	eb 08                	jmp    17bb <free+0xd7>
  } else
    p->s.ptr = bp;
    17b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17b9:	89 10                	mov    %edx,(%eax)
  freep = p;
    17bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17be:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
}
    17c3:	c9                   	leave  
    17c4:	c3                   	ret    

000017c5 <morecore>:

static Header*
morecore(uint nu)
{
    17c5:	55                   	push   %ebp
    17c6:	89 e5                	mov    %esp,%ebp
    17c8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    17cb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17d2:	77 07                	ja     17db <morecore+0x16>
    nu = 4096;
    17d4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17db:	8b 45 08             	mov    0x8(%ebp),%eax
    17de:	c1 e0 03             	shl    $0x3,%eax
    17e1:	89 04 24             	mov    %eax,(%esp)
    17e4:	e8 27 fc ff ff       	call   1410 <sbrk>
    17e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    17ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    17f0:	75 07                	jne    17f9 <morecore+0x34>
    return 0;
    17f2:	b8 00 00 00 00       	mov    $0x0,%eax
    17f7:	eb 22                	jmp    181b <morecore+0x56>
  hp = (Header*)p;
    17f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1802:	8b 55 08             	mov    0x8(%ebp),%edx
    1805:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1808:	8b 45 f0             	mov    -0x10(%ebp),%eax
    180b:	83 c0 08             	add    $0x8,%eax
    180e:	89 04 24             	mov    %eax,(%esp)
    1811:	e8 ce fe ff ff       	call   16e4 <free>
  return freep;
    1816:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
}
    181b:	c9                   	leave  
    181c:	c3                   	ret    

0000181d <malloc>:

void*
malloc(uint nbytes)
{
    181d:	55                   	push   %ebp
    181e:	89 e5                	mov    %esp,%ebp
    1820:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1823:	8b 45 08             	mov    0x8(%ebp),%eax
    1826:	83 c0 07             	add    $0x7,%eax
    1829:	c1 e8 03             	shr    $0x3,%eax
    182c:	83 c0 01             	add    $0x1,%eax
    182f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1832:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    1837:	89 45 f0             	mov    %eax,-0x10(%ebp)
    183a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    183e:	75 23                	jne    1863 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1840:	c7 45 f0 a0 1f 00 00 	movl   $0x1fa0,-0x10(%ebp)
    1847:	8b 45 f0             	mov    -0x10(%ebp),%eax
    184a:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
    184f:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    1854:	a3 a0 1f 00 00       	mov    %eax,0x1fa0
    base.s.size = 0;
    1859:	c7 05 a4 1f 00 00 00 	movl   $0x0,0x1fa4
    1860:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1863:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1866:	8b 00                	mov    (%eax),%eax
    1868:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    186b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186e:	8b 40 04             	mov    0x4(%eax),%eax
    1871:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1874:	72 4d                	jb     18c3 <malloc+0xa6>
      if(p->s.size == nunits)
    1876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1879:	8b 40 04             	mov    0x4(%eax),%eax
    187c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    187f:	75 0c                	jne    188d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1881:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1884:	8b 10                	mov    (%eax),%edx
    1886:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1889:	89 10                	mov    %edx,(%eax)
    188b:	eb 26                	jmp    18b3 <malloc+0x96>
      else {
        p->s.size -= nunits;
    188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1890:	8b 40 04             	mov    0x4(%eax),%eax
    1893:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1896:	89 c2                	mov    %eax,%edx
    1898:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a1:	8b 40 04             	mov    0x4(%eax),%eax
    18a4:	c1 e0 03             	shl    $0x3,%eax
    18a7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18b0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    18b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b6:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
      return (void*)(p + 1);
    18bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18be:	83 c0 08             	add    $0x8,%eax
    18c1:	eb 38                	jmp    18fb <malloc+0xde>
    }
    if(p == freep)
    18c3:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    18c8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    18cb:	75 1b                	jne    18e8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    18cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18d0:	89 04 24             	mov    %eax,(%esp)
    18d3:	e8 ed fe ff ff       	call   17c5 <morecore>
    18d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18df:	75 07                	jne    18e8 <malloc+0xcb>
        return 0;
    18e1:	b8 00 00 00 00       	mov    $0x0,%eax
    18e6:	eb 13                	jmp    18fb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f1:	8b 00                	mov    (%eax),%eax
    18f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    18f6:	e9 70 ff ff ff       	jmp    186b <malloc+0x4e>
}
    18fb:	c9                   	leave  
    18fc:	c3                   	ret    
    18fd:	66 90                	xchg   %ax,%ax
    18ff:	90                   	nop

00001900 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1900:	55                   	push   %ebp
    1901:	89 e5                	mov    %esp,%ebp
    1903:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1906:	8b 55 08             	mov    0x8(%ebp),%edx
    1909:	8b 45 0c             	mov    0xc(%ebp),%eax
    190c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    190f:	f0 87 02             	lock xchg %eax,(%edx)
    1912:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1915:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1918:	c9                   	leave  
    1919:	c3                   	ret    

0000191a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    191a:	55                   	push   %ebp
    191b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    191d:	8b 45 08             	mov    0x8(%ebp),%eax
    1920:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1926:	5d                   	pop    %ebp
    1927:	c3                   	ret    

00001928 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1928:	55                   	push   %ebp
    1929:	89 e5                	mov    %esp,%ebp
    192b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    192e:	90                   	nop
    192f:	8b 45 08             	mov    0x8(%ebp),%eax
    1932:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1939:	00 
    193a:	89 04 24             	mov    %eax,(%esp)
    193d:	e8 be ff ff ff       	call   1900 <xchg>
    1942:	85 c0                	test   %eax,%eax
    1944:	75 e9                	jne    192f <lock_acquire+0x7>
}
    1946:	c9                   	leave  
    1947:	c3                   	ret    

00001948 <lock_release>:
void lock_release(lock_t *lock){
    1948:	55                   	push   %ebp
    1949:	89 e5                	mov    %esp,%ebp
    194b:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    194e:	8b 45 08             	mov    0x8(%ebp),%eax
    1951:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1958:	00 
    1959:	89 04 24             	mov    %eax,(%esp)
    195c:	e8 9f ff ff ff       	call   1900 <xchg>
}
    1961:	c9                   	leave  
    1962:	c3                   	ret    

00001963 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1963:	55                   	push   %ebp
    1964:	89 e5                	mov    %esp,%ebp
    1966:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1969:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1970:	e8 a8 fe ff ff       	call   181d <malloc>
    1975:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1978:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1981:	25 ff 0f 00 00       	and    $0xfff,%eax
    1986:	85 c0                	test   %eax,%eax
    1988:	74 14                	je     199e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    198a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1992:	89 c2                	mov    %eax,%edx
    1994:	b8 00 10 00 00       	mov    $0x1000,%eax
    1999:	29 d0                	sub    %edx,%eax
    199b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    199e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19a2:	75 1b                	jne    19bf <thread_create+0x5c>

        printf(1,"malloc fail \n");
    19a4:	c7 44 24 04 9e 1b 00 	movl   $0x1b9e,0x4(%esp)
    19ab:	00 
    19ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19b3:	e8 78 fb ff ff       	call   1530 <printf>
        return 0;
    19b8:	b8 00 00 00 00       	mov    $0x0,%eax
    19bd:	eb 6f                	jmp    1a2e <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    19bf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    19c2:	8b 55 08             	mov    0x8(%ebp),%edx
    19c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    19cc:	89 54 24 08          	mov    %edx,0x8(%esp)
    19d0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    19d7:	00 
    19d8:	89 04 24             	mov    %eax,(%esp)
    19db:	e8 48 fa ff ff       	call   1428 <clone>
    19e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    19e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19e7:	79 1b                	jns    1a04 <thread_create+0xa1>
        printf(1,"clone fails\n");
    19e9:	c7 44 24 04 ac 1b 00 	movl   $0x1bac,0x4(%esp)
    19f0:	00 
    19f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19f8:	e8 33 fb ff ff       	call   1530 <printf>
        return 0;
    19fd:	b8 00 00 00 00       	mov    $0x0,%eax
    1a02:	eb 2a                	jmp    1a2e <thread_create+0xcb>
    }
    if(tid > 0){
    1a04:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a08:	7e 05                	jle    1a0f <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1a0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a0d:	eb 1f                	jmp    1a2e <thread_create+0xcb>
    }
    if(tid == 0){
    1a0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a13:	75 14                	jne    1a29 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1a15:	c7 44 24 04 b9 1b 00 	movl   $0x1bb9,0x4(%esp)
    1a1c:	00 
    1a1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a24:	e8 07 fb ff ff       	call   1530 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1a29:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a2e:	c9                   	leave  
    1a2f:	c3                   	ret    

00001a30 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1a30:	55                   	push   %ebp
    1a31:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1a33:	a1 84 1f 00 00       	mov    0x1f84,%eax
    1a38:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a3e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a43:	a3 84 1f 00 00       	mov    %eax,0x1f84
    return (int)(rands % max);
    1a48:	a1 84 1f 00 00       	mov    0x1f84,%eax
    1a4d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a50:	ba 00 00 00 00       	mov    $0x0,%edx
    1a55:	f7 f1                	div    %ecx
    1a57:	89 d0                	mov    %edx,%eax
}
    1a59:	5d                   	pop    %ebp
    1a5a:	c3                   	ret    
    1a5b:	90                   	nop

00001a5c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a5c:	55                   	push   %ebp
    1a5d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a62:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a68:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a7c:	5d                   	pop    %ebp
    1a7d:	c3                   	ret    

00001a7e <add_q>:

void add_q(struct queue *q, int v){
    1a7e:	55                   	push   %ebp
    1a7f:	89 e5                	mov    %esp,%ebp
    1a81:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a84:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a8b:	e8 8d fd ff ff       	call   181d <malloc>
    1a90:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a96:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1aa3:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1aa5:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa8:	8b 40 04             	mov    0x4(%eax),%eax
    1aab:	85 c0                	test   %eax,%eax
    1aad:	75 0b                	jne    1aba <add_q+0x3c>
        q->head = n;
    1aaf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ab5:	89 50 04             	mov    %edx,0x4(%eax)
    1ab8:	eb 0c                	jmp    1ac6 <add_q+0x48>
    }else{
        q->tail->next = n;
    1aba:	8b 45 08             	mov    0x8(%ebp),%eax
    1abd:	8b 40 08             	mov    0x8(%eax),%eax
    1ac0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ac3:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1ac6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1acc:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1acf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad2:	8b 00                	mov    (%eax),%eax
    1ad4:	8d 50 01             	lea    0x1(%eax),%edx
    1ad7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ada:	89 10                	mov    %edx,(%eax)
}
    1adc:	c9                   	leave  
    1add:	c3                   	ret    

00001ade <empty_q>:

int empty_q(struct queue *q){
    1ade:	55                   	push   %ebp
    1adf:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1ae1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae4:	8b 00                	mov    (%eax),%eax
    1ae6:	85 c0                	test   %eax,%eax
    1ae8:	75 07                	jne    1af1 <empty_q+0x13>
        return 1;
    1aea:	b8 01 00 00 00       	mov    $0x1,%eax
    1aef:	eb 05                	jmp    1af6 <empty_q+0x18>
    else
        return 0;
    1af1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1af6:	5d                   	pop    %ebp
    1af7:	c3                   	ret    

00001af8 <pop_q>:
int pop_q(struct queue *q){
    1af8:	55                   	push   %ebp
    1af9:	89 e5                	mov    %esp,%ebp
    1afb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1afe:	8b 45 08             	mov    0x8(%ebp),%eax
    1b01:	89 04 24             	mov    %eax,(%esp)
    1b04:	e8 d5 ff ff ff       	call   1ade <empty_q>
    1b09:	85 c0                	test   %eax,%eax
    1b0b:	75 5d                	jne    1b6a <pop_q+0x72>
       val = q->head->value; 
    1b0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b10:	8b 40 04             	mov    0x4(%eax),%eax
    1b13:	8b 00                	mov    (%eax),%eax
    1b15:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1b18:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1b:	8b 40 04             	mov    0x4(%eax),%eax
    1b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1b21:	8b 45 08             	mov    0x8(%ebp),%eax
    1b24:	8b 40 04             	mov    0x4(%eax),%eax
    1b27:	8b 50 04             	mov    0x4(%eax),%edx
    1b2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1b30:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b33:	89 04 24             	mov    %eax,(%esp)
    1b36:	e8 a9 fb ff ff       	call   16e4 <free>
       q->size--;
    1b3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3e:	8b 00                	mov    (%eax),%eax
    1b40:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b43:	8b 45 08             	mov    0x8(%ebp),%eax
    1b46:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1b48:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4b:	8b 00                	mov    (%eax),%eax
    1b4d:	85 c0                	test   %eax,%eax
    1b4f:	75 14                	jne    1b65 <pop_q+0x6d>
            q->head = 0;
    1b51:	8b 45 08             	mov    0x8(%ebp),%eax
    1b54:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b68:	eb 05                	jmp    1b6f <pop_q+0x77>
    }
    return -1;
    1b6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b6f:	c9                   	leave  
    1b70:	c3                   	ret    
