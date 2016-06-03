
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 48             	sub    $0x48,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
    1006:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    100d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1010:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1013:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1016:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
    1019:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1020:	eb 68                	jmp    108a <wc+0x8a>
    for(i=0; i<n; i++){
    1022:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1029:	eb 57                	jmp    1082 <wc+0x82>
      c++;
    102b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
    102f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1032:	05 80 20 00 00       	add    $0x2080,%eax
    1037:	0f b6 00             	movzbl (%eax),%eax
    103a:	3c 0a                	cmp    $0xa,%al
    103c:	75 04                	jne    1042 <wc+0x42>
        l++;
    103e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
    1042:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1045:	05 80 20 00 00       	add    $0x2080,%eax
    104a:	0f b6 00             	movzbl (%eax),%eax
    104d:	0f be c0             	movsbl %al,%eax
    1050:	89 44 24 04          	mov    %eax,0x4(%esp)
    1054:	c7 04 24 2d 1c 00 00 	movl   $0x1c2d,(%esp)
    105b:	e8 5b 02 00 00       	call   12bb <strchr>
    1060:	85 c0                	test   %eax,%eax
    1062:	74 09                	je     106d <wc+0x6d>
        inword = 0;
    1064:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    106b:	eb 11                	jmp    107e <wc+0x7e>
      else if(!inword){
    106d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1071:	75 0b                	jne    107e <wc+0x7e>
        w++;
    1073:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
    1077:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
    107e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1082:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1085:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    1088:	7c a1                	jl     102b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    108a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1091:	00 
    1092:	c7 44 24 04 80 20 00 	movl   $0x2080,0x4(%esp)
    1099:	00 
    109a:	8b 45 08             	mov    0x8(%ebp),%eax
    109d:	89 04 24             	mov    %eax,(%esp)
    10a0:	e8 b7 03 00 00       	call   145c <read>
    10a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10ac:	0f 8f 70 ff ff ff    	jg     1022 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
    10b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10b6:	79 19                	jns    10d1 <wc+0xd1>
    printf(1, "wc: read error\n");
    10b8:	c7 44 24 04 33 1c 00 	movl   $0x1c33,0x4(%esp)
    10bf:	00 
    10c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c7:	e8 20 05 00 00       	call   15ec <printf>
    exit();
    10cc:	e8 73 03 00 00       	call   1444 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    10d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d4:	89 44 24 14          	mov    %eax,0x14(%esp)
    10d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10db:	89 44 24 10          	mov    %eax,0x10(%esp)
    10df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10e9:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ed:	c7 44 24 04 43 1c 00 	movl   $0x1c43,0x4(%esp)
    10f4:	00 
    10f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10fc:	e8 eb 04 00 00       	call   15ec <printf>
}
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <main>:

int
main(int argc, char *argv[])
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 e4 f0             	and    $0xfffffff0,%esp
    1109:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
    110c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1110:	7f 19                	jg     112b <main+0x28>
    wc(0, "");
    1112:	c7 44 24 04 50 1c 00 	movl   $0x1c50,0x4(%esp)
    1119:	00 
    111a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1121:	e8 da fe ff ff       	call   1000 <wc>
    exit();
    1126:	e8 19 03 00 00       	call   1444 <exit>
  }

  for(i = 1; i < argc; i++){
    112b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1132:	00 
    1133:	e9 8f 00 00 00       	jmp    11c7 <main+0xc4>
    if((fd = open(argv[i], 0)) < 0){
    1138:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    113c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1143:	8b 45 0c             	mov    0xc(%ebp),%eax
    1146:	01 d0                	add    %edx,%eax
    1148:	8b 00                	mov    (%eax),%eax
    114a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1151:	00 
    1152:	89 04 24             	mov    %eax,(%esp)
    1155:	e8 2a 03 00 00       	call   1484 <open>
    115a:	89 44 24 18          	mov    %eax,0x18(%esp)
    115e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1163:	79 2f                	jns    1194 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
    1165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1169:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1170:	8b 45 0c             	mov    0xc(%ebp),%eax
    1173:	01 d0                	add    %edx,%eax
    1175:	8b 00                	mov    (%eax),%eax
    1177:	89 44 24 08          	mov    %eax,0x8(%esp)
    117b:	c7 44 24 04 51 1c 00 	movl   $0x1c51,0x4(%esp)
    1182:	00 
    1183:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    118a:	e8 5d 04 00 00       	call   15ec <printf>
      exit();
    118f:	e8 b0 02 00 00       	call   1444 <exit>
    }
    wc(fd, argv[i]);
    1194:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    119f:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a2:	01 d0                	add    %edx,%eax
    11a4:	8b 00                	mov    (%eax),%eax
    11a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    11aa:	8b 44 24 18          	mov    0x18(%esp),%eax
    11ae:	89 04 24             	mov    %eax,(%esp)
    11b1:	e8 4a fe ff ff       	call   1000 <wc>
    close(fd);
    11b6:	8b 44 24 18          	mov    0x18(%esp),%eax
    11ba:	89 04 24             	mov    %eax,(%esp)
    11bd:	e8 aa 02 00 00       	call   146c <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    11c2:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    11c7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    11cb:	3b 45 08             	cmp    0x8(%ebp),%eax
    11ce:	0f 8c 64 ff ff ff    	jl     1138 <main+0x35>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
    11d4:	e8 6b 02 00 00       	call   1444 <exit>
    11d9:	66 90                	xchg   %ax,%ax
    11db:	90                   	nop

000011dc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11dc:	55                   	push   %ebp
    11dd:	89 e5                	mov    %esp,%ebp
    11df:	57                   	push   %edi
    11e0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11e4:	8b 55 10             	mov    0x10(%ebp),%edx
    11e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ea:	89 cb                	mov    %ecx,%ebx
    11ec:	89 df                	mov    %ebx,%edi
    11ee:	89 d1                	mov    %edx,%ecx
    11f0:	fc                   	cld    
    11f1:	f3 aa                	rep stos %al,%es:(%edi)
    11f3:	89 ca                	mov    %ecx,%edx
    11f5:	89 fb                	mov    %edi,%ebx
    11f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11fa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11fd:	5b                   	pop    %ebx
    11fe:	5f                   	pop    %edi
    11ff:	5d                   	pop    %ebp
    1200:	c3                   	ret    

00001201 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1201:	55                   	push   %ebp
    1202:	89 e5                	mov    %esp,%ebp
    1204:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    120d:	90                   	nop
    120e:	8b 45 08             	mov    0x8(%ebp),%eax
    1211:	8d 50 01             	lea    0x1(%eax),%edx
    1214:	89 55 08             	mov    %edx,0x8(%ebp)
    1217:	8b 55 0c             	mov    0xc(%ebp),%edx
    121a:	8d 4a 01             	lea    0x1(%edx),%ecx
    121d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1220:	0f b6 12             	movzbl (%edx),%edx
    1223:	88 10                	mov    %dl,(%eax)
    1225:	0f b6 00             	movzbl (%eax),%eax
    1228:	84 c0                	test   %al,%al
    122a:	75 e2                	jne    120e <strcpy+0xd>
    ;
  return os;
    122c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1234:	eb 08                	jmp    123e <strcmp+0xd>
    p++, q++;
    1236:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    123a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    123e:	8b 45 08             	mov    0x8(%ebp),%eax
    1241:	0f b6 00             	movzbl (%eax),%eax
    1244:	84 c0                	test   %al,%al
    1246:	74 10                	je     1258 <strcmp+0x27>
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	0f b6 10             	movzbl (%eax),%edx
    124e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1251:	0f b6 00             	movzbl (%eax),%eax
    1254:	38 c2                	cmp    %al,%dl
    1256:	74 de                	je     1236 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1258:	8b 45 08             	mov    0x8(%ebp),%eax
    125b:	0f b6 00             	movzbl (%eax),%eax
    125e:	0f b6 d0             	movzbl %al,%edx
    1261:	8b 45 0c             	mov    0xc(%ebp),%eax
    1264:	0f b6 00             	movzbl (%eax),%eax
    1267:	0f b6 c0             	movzbl %al,%eax
    126a:	29 c2                	sub    %eax,%edx
    126c:	89 d0                	mov    %edx,%eax
}
    126e:	5d                   	pop    %ebp
    126f:	c3                   	ret    

00001270 <strlen>:

uint
strlen(char *s)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1276:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    127d:	eb 04                	jmp    1283 <strlen+0x13>
    127f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1283:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	01 d0                	add    %edx,%eax
    128b:	0f b6 00             	movzbl (%eax),%eax
    128e:	84 c0                	test   %al,%al
    1290:	75 ed                	jne    127f <strlen+0xf>
    ;
  return n;
    1292:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1295:	c9                   	leave  
    1296:	c3                   	ret    

00001297 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1297:	55                   	push   %ebp
    1298:	89 e5                	mov    %esp,%ebp
    129a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    129d:	8b 45 10             	mov    0x10(%ebp),%eax
    12a0:	89 44 24 08          	mov    %eax,0x8(%esp)
    12a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    12ab:	8b 45 08             	mov    0x8(%ebp),%eax
    12ae:	89 04 24             	mov    %eax,(%esp)
    12b1:	e8 26 ff ff ff       	call   11dc <stosb>
  return dst;
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12b9:	c9                   	leave  
    12ba:	c3                   	ret    

000012bb <strchr>:

char*
strchr(const char *s, char c)
{
    12bb:	55                   	push   %ebp
    12bc:	89 e5                	mov    %esp,%ebp
    12be:	83 ec 04             	sub    $0x4,%esp
    12c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12c7:	eb 14                	jmp    12dd <strchr+0x22>
    if(*s == c)
    12c9:	8b 45 08             	mov    0x8(%ebp),%eax
    12cc:	0f b6 00             	movzbl (%eax),%eax
    12cf:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12d2:	75 05                	jne    12d9 <strchr+0x1e>
      return (char*)s;
    12d4:	8b 45 08             	mov    0x8(%ebp),%eax
    12d7:	eb 13                	jmp    12ec <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12dd:	8b 45 08             	mov    0x8(%ebp),%eax
    12e0:	0f b6 00             	movzbl (%eax),%eax
    12e3:	84 c0                	test   %al,%al
    12e5:	75 e2                	jne    12c9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12ec:	c9                   	leave  
    12ed:	c3                   	ret    

000012ee <gets>:

char*
gets(char *buf, int max)
{
    12ee:	55                   	push   %ebp
    12ef:	89 e5                	mov    %esp,%ebp
    12f1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12fb:	eb 4c                	jmp    1349 <gets+0x5b>
    cc = read(0, &c, 1);
    12fd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1304:	00 
    1305:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1308:	89 44 24 04          	mov    %eax,0x4(%esp)
    130c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1313:	e8 44 01 00 00       	call   145c <read>
    1318:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    131b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    131f:	7f 02                	jg     1323 <gets+0x35>
      break;
    1321:	eb 31                	jmp    1354 <gets+0x66>
    buf[i++] = c;
    1323:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1326:	8d 50 01             	lea    0x1(%eax),%edx
    1329:	89 55 f4             	mov    %edx,-0xc(%ebp)
    132c:	89 c2                	mov    %eax,%edx
    132e:	8b 45 08             	mov    0x8(%ebp),%eax
    1331:	01 c2                	add    %eax,%edx
    1333:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1337:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1339:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    133d:	3c 0a                	cmp    $0xa,%al
    133f:	74 13                	je     1354 <gets+0x66>
    1341:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1345:	3c 0d                	cmp    $0xd,%al
    1347:	74 0b                	je     1354 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1349:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134c:	83 c0 01             	add    $0x1,%eax
    134f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1352:	7c a9                	jl     12fd <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1354:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1357:	8b 45 08             	mov    0x8(%ebp),%eax
    135a:	01 d0                	add    %edx,%eax
    135c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    135f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1362:	c9                   	leave  
    1363:	c3                   	ret    

00001364 <stat>:

int
stat(char *n, struct stat *st)
{
    1364:	55                   	push   %ebp
    1365:	89 e5                	mov    %esp,%ebp
    1367:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    136a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1371:	00 
    1372:	8b 45 08             	mov    0x8(%ebp),%eax
    1375:	89 04 24             	mov    %eax,(%esp)
    1378:	e8 07 01 00 00       	call   1484 <open>
    137d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1380:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1384:	79 07                	jns    138d <stat+0x29>
    return -1;
    1386:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    138b:	eb 23                	jmp    13b0 <stat+0x4c>
  r = fstat(fd, st);
    138d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1390:	89 44 24 04          	mov    %eax,0x4(%esp)
    1394:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1397:	89 04 24             	mov    %eax,(%esp)
    139a:	e8 fd 00 00 00       	call   149c <fstat>
    139f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    13a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a5:	89 04 24             	mov    %eax,(%esp)
    13a8:	e8 bf 00 00 00       	call   146c <close>
  return r;
    13ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    13b0:	c9                   	leave  
    13b1:	c3                   	ret    

000013b2 <atoi>:

int
atoi(const char *s)
{
    13b2:	55                   	push   %ebp
    13b3:	89 e5                	mov    %esp,%ebp
    13b5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13bf:	eb 25                	jmp    13e6 <atoi+0x34>
    n = n*10 + *s++ - '0';
    13c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13c4:	89 d0                	mov    %edx,%eax
    13c6:	c1 e0 02             	shl    $0x2,%eax
    13c9:	01 d0                	add    %edx,%eax
    13cb:	01 c0                	add    %eax,%eax
    13cd:	89 c1                	mov    %eax,%ecx
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	8d 50 01             	lea    0x1(%eax),%edx
    13d5:	89 55 08             	mov    %edx,0x8(%ebp)
    13d8:	0f b6 00             	movzbl (%eax),%eax
    13db:	0f be c0             	movsbl %al,%eax
    13de:	01 c8                	add    %ecx,%eax
    13e0:	83 e8 30             	sub    $0x30,%eax
    13e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13e6:	8b 45 08             	mov    0x8(%ebp),%eax
    13e9:	0f b6 00             	movzbl (%eax),%eax
    13ec:	3c 2f                	cmp    $0x2f,%al
    13ee:	7e 0a                	jle    13fa <atoi+0x48>
    13f0:	8b 45 08             	mov    0x8(%ebp),%eax
    13f3:	0f b6 00             	movzbl (%eax),%eax
    13f6:	3c 39                	cmp    $0x39,%al
    13f8:	7e c7                	jle    13c1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    13fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13fd:	c9                   	leave  
    13fe:	c3                   	ret    

000013ff <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13ff:	55                   	push   %ebp
    1400:	89 e5                	mov    %esp,%ebp
    1402:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1405:	8b 45 08             	mov    0x8(%ebp),%eax
    1408:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    140b:	8b 45 0c             	mov    0xc(%ebp),%eax
    140e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1411:	eb 17                	jmp    142a <memmove+0x2b>
    *dst++ = *src++;
    1413:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1416:	8d 50 01             	lea    0x1(%eax),%edx
    1419:	89 55 fc             	mov    %edx,-0x4(%ebp)
    141c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    141f:	8d 4a 01             	lea    0x1(%edx),%ecx
    1422:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1425:	0f b6 12             	movzbl (%edx),%edx
    1428:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    142a:	8b 45 10             	mov    0x10(%ebp),%eax
    142d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1430:	89 55 10             	mov    %edx,0x10(%ebp)
    1433:	85 c0                	test   %eax,%eax
    1435:	7f dc                	jg     1413 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1437:	8b 45 08             	mov    0x8(%ebp),%eax
}
    143a:	c9                   	leave  
    143b:	c3                   	ret    

0000143c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    143c:	b8 01 00 00 00       	mov    $0x1,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <exit>:
SYSCALL(exit)
    1444:	b8 02 00 00 00       	mov    $0x2,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <wait>:
SYSCALL(wait)
    144c:	b8 03 00 00 00       	mov    $0x3,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <pipe>:
SYSCALL(pipe)
    1454:	b8 04 00 00 00       	mov    $0x4,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <read>:
SYSCALL(read)
    145c:	b8 05 00 00 00       	mov    $0x5,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <write>:
SYSCALL(write)
    1464:	b8 10 00 00 00       	mov    $0x10,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <close>:
SYSCALL(close)
    146c:	b8 15 00 00 00       	mov    $0x15,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <kill>:
SYSCALL(kill)
    1474:	b8 06 00 00 00       	mov    $0x6,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <exec>:
SYSCALL(exec)
    147c:	b8 07 00 00 00       	mov    $0x7,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <open>:
SYSCALL(open)
    1484:	b8 0f 00 00 00       	mov    $0xf,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <mknod>:
SYSCALL(mknod)
    148c:	b8 11 00 00 00       	mov    $0x11,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <unlink>:
SYSCALL(unlink)
    1494:	b8 12 00 00 00       	mov    $0x12,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <fstat>:
SYSCALL(fstat)
    149c:	b8 08 00 00 00       	mov    $0x8,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <link>:
SYSCALL(link)
    14a4:	b8 13 00 00 00       	mov    $0x13,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <mkdir>:
SYSCALL(mkdir)
    14ac:	b8 14 00 00 00       	mov    $0x14,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <chdir>:
SYSCALL(chdir)
    14b4:	b8 09 00 00 00       	mov    $0x9,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <dup>:
SYSCALL(dup)
    14bc:	b8 0a 00 00 00       	mov    $0xa,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <getpid>:
SYSCALL(getpid)
    14c4:	b8 0b 00 00 00       	mov    $0xb,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <sbrk>:
SYSCALL(sbrk)
    14cc:	b8 0c 00 00 00       	mov    $0xc,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <sleep>:
SYSCALL(sleep)
    14d4:	b8 0d 00 00 00       	mov    $0xd,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <uptime>:
SYSCALL(uptime)
    14dc:	b8 0e 00 00 00       	mov    $0xe,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <clone>:
SYSCALL(clone)
    14e4:	b8 16 00 00 00       	mov    $0x16,%eax
    14e9:	cd 40                	int    $0x40
    14eb:	c3                   	ret    

000014ec <texit>:
SYSCALL(texit)
    14ec:	b8 17 00 00 00       	mov    $0x17,%eax
    14f1:	cd 40                	int    $0x40
    14f3:	c3                   	ret    

000014f4 <tsleep>:
SYSCALL(tsleep)
    14f4:	b8 18 00 00 00       	mov    $0x18,%eax
    14f9:	cd 40                	int    $0x40
    14fb:	c3                   	ret    

000014fc <twakeup>:
SYSCALL(twakeup)
    14fc:	b8 19 00 00 00       	mov    $0x19,%eax
    1501:	cd 40                	int    $0x40
    1503:	c3                   	ret    

00001504 <thread_yield>:
SYSCALL(thread_yield)
    1504:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1509:	cd 40                	int    $0x40
    150b:	c3                   	ret    

0000150c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    150c:	55                   	push   %ebp
    150d:	89 e5                	mov    %esp,%ebp
    150f:	83 ec 18             	sub    $0x18,%esp
    1512:	8b 45 0c             	mov    0xc(%ebp),%eax
    1515:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1518:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    151f:	00 
    1520:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1523:	89 44 24 04          	mov    %eax,0x4(%esp)
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	89 04 24             	mov    %eax,(%esp)
    152d:	e8 32 ff ff ff       	call   1464 <write>
}
    1532:	c9                   	leave  
    1533:	c3                   	ret    

00001534 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1534:	55                   	push   %ebp
    1535:	89 e5                	mov    %esp,%ebp
    1537:	56                   	push   %esi
    1538:	53                   	push   %ebx
    1539:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    153c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1543:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1547:	74 17                	je     1560 <printint+0x2c>
    1549:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    154d:	79 11                	jns    1560 <printint+0x2c>
    neg = 1;
    154f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1556:	8b 45 0c             	mov    0xc(%ebp),%eax
    1559:	f7 d8                	neg    %eax
    155b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    155e:	eb 06                	jmp    1566 <printint+0x32>
  } else {
    x = xx;
    1560:	8b 45 0c             	mov    0xc(%ebp),%eax
    1563:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1566:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    156d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1570:	8d 41 01             	lea    0x1(%ecx),%eax
    1573:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1576:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1579:	8b 45 ec             	mov    -0x14(%ebp),%eax
    157c:	ba 00 00 00 00       	mov    $0x0,%edx
    1581:	f7 f3                	div    %ebx
    1583:	89 d0                	mov    %edx,%eax
    1585:	0f b6 80 3c 20 00 00 	movzbl 0x203c(%eax),%eax
    158c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1590:	8b 75 10             	mov    0x10(%ebp),%esi
    1593:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1596:	ba 00 00 00 00       	mov    $0x0,%edx
    159b:	f7 f6                	div    %esi
    159d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15a4:	75 c7                	jne    156d <printint+0x39>
  if(neg)
    15a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15aa:	74 10                	je     15bc <printint+0x88>
    buf[i++] = '-';
    15ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15af:	8d 50 01             	lea    0x1(%eax),%edx
    15b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15b5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    15ba:	eb 1f                	jmp    15db <printint+0xa7>
    15bc:	eb 1d                	jmp    15db <printint+0xa7>
    putc(fd, buf[i]);
    15be:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	0f be c0             	movsbl %al,%eax
    15cc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	89 04 24             	mov    %eax,(%esp)
    15d6:	e8 31 ff ff ff       	call   150c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15db:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15e3:	79 d9                	jns    15be <printint+0x8a>
    putc(fd, buf[i]);
}
    15e5:	83 c4 30             	add    $0x30,%esp
    15e8:	5b                   	pop    %ebx
    15e9:	5e                   	pop    %esi
    15ea:	5d                   	pop    %ebp
    15eb:	c3                   	ret    

000015ec <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15ec:	55                   	push   %ebp
    15ed:	89 e5                	mov    %esp,%ebp
    15ef:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15f9:	8d 45 0c             	lea    0xc(%ebp),%eax
    15fc:	83 c0 04             	add    $0x4,%eax
    15ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1602:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1609:	e9 7c 01 00 00       	jmp    178a <printf+0x19e>
    c = fmt[i] & 0xff;
    160e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1611:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1614:	01 d0                	add    %edx,%eax
    1616:	0f b6 00             	movzbl (%eax),%eax
    1619:	0f be c0             	movsbl %al,%eax
    161c:	25 ff 00 00 00       	and    $0xff,%eax
    1621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1624:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1628:	75 2c                	jne    1656 <printf+0x6a>
      if(c == '%'){
    162a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    162e:	75 0c                	jne    163c <printf+0x50>
        state = '%';
    1630:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1637:	e9 4a 01 00 00       	jmp    1786 <printf+0x19a>
      } else {
        putc(fd, c);
    163c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    163f:	0f be c0             	movsbl %al,%eax
    1642:	89 44 24 04          	mov    %eax,0x4(%esp)
    1646:	8b 45 08             	mov    0x8(%ebp),%eax
    1649:	89 04 24             	mov    %eax,(%esp)
    164c:	e8 bb fe ff ff       	call   150c <putc>
    1651:	e9 30 01 00 00       	jmp    1786 <printf+0x19a>
      }
    } else if(state == '%'){
    1656:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    165a:	0f 85 26 01 00 00    	jne    1786 <printf+0x19a>
      if(c == 'd'){
    1660:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1664:	75 2d                	jne    1693 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1666:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1669:	8b 00                	mov    (%eax),%eax
    166b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1672:	00 
    1673:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    167a:	00 
    167b:	89 44 24 04          	mov    %eax,0x4(%esp)
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	89 04 24             	mov    %eax,(%esp)
    1685:	e8 aa fe ff ff       	call   1534 <printint>
        ap++;
    168a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    168e:	e9 ec 00 00 00       	jmp    177f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1693:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1697:	74 06                	je     169f <printf+0xb3>
    1699:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    169d:	75 2d                	jne    16cc <printf+0xe0>
        printint(fd, *ap, 16, 0);
    169f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a2:	8b 00                	mov    (%eax),%eax
    16a4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16ab:	00 
    16ac:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    16b3:	00 
    16b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	89 04 24             	mov    %eax,(%esp)
    16be:	e8 71 fe ff ff       	call   1534 <printint>
        ap++;
    16c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16c7:	e9 b3 00 00 00       	jmp    177f <printf+0x193>
      } else if(c == 's'){
    16cc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16d0:	75 45                	jne    1717 <printf+0x12b>
        s = (char*)*ap;
    16d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d5:	8b 00                	mov    (%eax),%eax
    16d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16da:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16e2:	75 09                	jne    16ed <printf+0x101>
          s = "(null)";
    16e4:	c7 45 f4 65 1c 00 00 	movl   $0x1c65,-0xc(%ebp)
        while(*s != 0){
    16eb:	eb 1e                	jmp    170b <printf+0x11f>
    16ed:	eb 1c                	jmp    170b <printf+0x11f>
          putc(fd, *s);
    16ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f2:	0f b6 00             	movzbl (%eax),%eax
    16f5:	0f be c0             	movsbl %al,%eax
    16f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 04 24             	mov    %eax,(%esp)
    1702:	e8 05 fe ff ff       	call   150c <putc>
          s++;
    1707:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170e:	0f b6 00             	movzbl (%eax),%eax
    1711:	84 c0                	test   %al,%al
    1713:	75 da                	jne    16ef <printf+0x103>
    1715:	eb 68                	jmp    177f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1717:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    171b:	75 1d                	jne    173a <printf+0x14e>
        putc(fd, *ap);
    171d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1720:	8b 00                	mov    (%eax),%eax
    1722:	0f be c0             	movsbl %al,%eax
    1725:	89 44 24 04          	mov    %eax,0x4(%esp)
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	89 04 24             	mov    %eax,(%esp)
    172f:	e8 d8 fd ff ff       	call   150c <putc>
        ap++;
    1734:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1738:	eb 45                	jmp    177f <printf+0x193>
      } else if(c == '%'){
    173a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    173e:	75 17                	jne    1757 <printf+0x16b>
        putc(fd, c);
    1740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1743:	0f be c0             	movsbl %al,%eax
    1746:	89 44 24 04          	mov    %eax,0x4(%esp)
    174a:	8b 45 08             	mov    0x8(%ebp),%eax
    174d:	89 04 24             	mov    %eax,(%esp)
    1750:	e8 b7 fd ff ff       	call   150c <putc>
    1755:	eb 28                	jmp    177f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1757:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    175e:	00 
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	89 04 24             	mov    %eax,(%esp)
    1765:	e8 a2 fd ff ff       	call   150c <putc>
        putc(fd, c);
    176a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    176d:	0f be c0             	movsbl %al,%eax
    1770:	89 44 24 04          	mov    %eax,0x4(%esp)
    1774:	8b 45 08             	mov    0x8(%ebp),%eax
    1777:	89 04 24             	mov    %eax,(%esp)
    177a:	e8 8d fd ff ff       	call   150c <putc>
      }
      state = 0;
    177f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1786:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    178a:	8b 55 0c             	mov    0xc(%ebp),%edx
    178d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1790:	01 d0                	add    %edx,%eax
    1792:	0f b6 00             	movzbl (%eax),%eax
    1795:	84 c0                	test   %al,%al
    1797:	0f 85 71 fe ff ff    	jne    160e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    179d:	c9                   	leave  
    179e:	c3                   	ret    
    179f:	90                   	nop

000017a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17a0:	55                   	push   %ebp
    17a1:	89 e5                	mov    %esp,%ebp
    17a3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17a6:	8b 45 08             	mov    0x8(%ebp),%eax
    17a9:	83 e8 08             	sub    $0x8,%eax
    17ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17af:	a1 68 20 00 00       	mov    0x2068,%eax
    17b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17b7:	eb 24                	jmp    17dd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17bc:	8b 00                	mov    (%eax),%eax
    17be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c1:	77 12                	ja     17d5 <free+0x35>
    17c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c9:	77 24                	ja     17ef <free+0x4f>
    17cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ce:	8b 00                	mov    (%eax),%eax
    17d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17d3:	77 1a                	ja     17ef <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d8:	8b 00                	mov    (%eax),%eax
    17da:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17e3:	76 d4                	jbe    17b9 <free+0x19>
    17e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e8:	8b 00                	mov    (%eax),%eax
    17ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17ed:	76 ca                	jbe    17b9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    17ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f2:	8b 40 04             	mov    0x4(%eax),%eax
    17f5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    17fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ff:	01 c2                	add    %eax,%edx
    1801:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1804:	8b 00                	mov    (%eax),%eax
    1806:	39 c2                	cmp    %eax,%edx
    1808:	75 24                	jne    182e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    180a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180d:	8b 50 04             	mov    0x4(%eax),%edx
    1810:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1813:	8b 00                	mov    (%eax),%eax
    1815:	8b 40 04             	mov    0x4(%eax),%eax
    1818:	01 c2                	add    %eax,%edx
    181a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1820:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1823:	8b 00                	mov    (%eax),%eax
    1825:	8b 10                	mov    (%eax),%edx
    1827:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182a:	89 10                	mov    %edx,(%eax)
    182c:	eb 0a                	jmp    1838 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1831:	8b 10                	mov    (%eax),%edx
    1833:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1836:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1838:	8b 45 fc             	mov    -0x4(%ebp),%eax
    183b:	8b 40 04             	mov    0x4(%eax),%eax
    183e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	01 d0                	add    %edx,%eax
    184a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    184d:	75 20                	jne    186f <free+0xcf>
    p->s.size += bp->s.size;
    184f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1852:	8b 50 04             	mov    0x4(%eax),%edx
    1855:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1858:	8b 40 04             	mov    0x4(%eax),%eax
    185b:	01 c2                	add    %eax,%edx
    185d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1860:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1863:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1866:	8b 10                	mov    (%eax),%edx
    1868:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186b:	89 10                	mov    %edx,(%eax)
    186d:	eb 08                	jmp    1877 <free+0xd7>
  } else
    p->s.ptr = bp;
    186f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1872:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1875:	89 10                	mov    %edx,(%eax)
  freep = p;
    1877:	8b 45 fc             	mov    -0x4(%ebp),%eax
    187a:	a3 68 20 00 00       	mov    %eax,0x2068
}
    187f:	c9                   	leave  
    1880:	c3                   	ret    

00001881 <morecore>:

static Header*
morecore(uint nu)
{
    1881:	55                   	push   %ebp
    1882:	89 e5                	mov    %esp,%ebp
    1884:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1887:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    188e:	77 07                	ja     1897 <morecore+0x16>
    nu = 4096;
    1890:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1897:	8b 45 08             	mov    0x8(%ebp),%eax
    189a:	c1 e0 03             	shl    $0x3,%eax
    189d:	89 04 24             	mov    %eax,(%esp)
    18a0:	e8 27 fc ff ff       	call   14cc <sbrk>
    18a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    18a8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    18ac:	75 07                	jne    18b5 <morecore+0x34>
    return 0;
    18ae:	b8 00 00 00 00       	mov    $0x0,%eax
    18b3:	eb 22                	jmp    18d7 <morecore+0x56>
  hp = (Header*)p;
    18b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    18bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18be:	8b 55 08             	mov    0x8(%ebp),%edx
    18c1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c7:	83 c0 08             	add    $0x8,%eax
    18ca:	89 04 24             	mov    %eax,(%esp)
    18cd:	e8 ce fe ff ff       	call   17a0 <free>
  return freep;
    18d2:	a1 68 20 00 00       	mov    0x2068,%eax
}
    18d7:	c9                   	leave  
    18d8:	c3                   	ret    

000018d9 <malloc>:

void*
malloc(uint nbytes)
{
    18d9:	55                   	push   %ebp
    18da:	89 e5                	mov    %esp,%ebp
    18dc:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18df:	8b 45 08             	mov    0x8(%ebp),%eax
    18e2:	83 c0 07             	add    $0x7,%eax
    18e5:	c1 e8 03             	shr    $0x3,%eax
    18e8:	83 c0 01             	add    $0x1,%eax
    18eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    18ee:	a1 68 20 00 00       	mov    0x2068,%eax
    18f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18fa:	75 23                	jne    191f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    18fc:	c7 45 f0 60 20 00 00 	movl   $0x2060,-0x10(%ebp)
    1903:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1906:	a3 68 20 00 00       	mov    %eax,0x2068
    190b:	a1 68 20 00 00       	mov    0x2068,%eax
    1910:	a3 60 20 00 00       	mov    %eax,0x2060
    base.s.size = 0;
    1915:	c7 05 64 20 00 00 00 	movl   $0x0,0x2064
    191c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    191f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1922:	8b 00                	mov    (%eax),%eax
    1924:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1927:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192a:	8b 40 04             	mov    0x4(%eax),%eax
    192d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1930:	72 4d                	jb     197f <malloc+0xa6>
      if(p->s.size == nunits)
    1932:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1935:	8b 40 04             	mov    0x4(%eax),%eax
    1938:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    193b:	75 0c                	jne    1949 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    193d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1940:	8b 10                	mov    (%eax),%edx
    1942:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1945:	89 10                	mov    %edx,(%eax)
    1947:	eb 26                	jmp    196f <malloc+0x96>
      else {
        p->s.size -= nunits;
    1949:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194c:	8b 40 04             	mov    0x4(%eax),%eax
    194f:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1952:	89 c2                	mov    %eax,%edx
    1954:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1957:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195d:	8b 40 04             	mov    0x4(%eax),%eax
    1960:	c1 e0 03             	shl    $0x3,%eax
    1963:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	8b 55 ec             	mov    -0x14(%ebp),%edx
    196c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    196f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1972:	a3 68 20 00 00       	mov    %eax,0x2068
      return (void*)(p + 1);
    1977:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197a:	83 c0 08             	add    $0x8,%eax
    197d:	eb 38                	jmp    19b7 <malloc+0xde>
    }
    if(p == freep)
    197f:	a1 68 20 00 00       	mov    0x2068,%eax
    1984:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1987:	75 1b                	jne    19a4 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1989:	8b 45 ec             	mov    -0x14(%ebp),%eax
    198c:	89 04 24             	mov    %eax,(%esp)
    198f:	e8 ed fe ff ff       	call   1881 <morecore>
    1994:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1997:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    199b:	75 07                	jne    19a4 <malloc+0xcb>
        return 0;
    199d:	b8 00 00 00 00       	mov    $0x0,%eax
    19a2:	eb 13                	jmp    19b7 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ad:	8b 00                	mov    (%eax),%eax
    19af:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    19b2:	e9 70 ff ff ff       	jmp    1927 <malloc+0x4e>
}
    19b7:	c9                   	leave  
    19b8:	c3                   	ret    
    19b9:	66 90                	xchg   %ax,%ax
    19bb:	90                   	nop

000019bc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    19bc:	55                   	push   %ebp
    19bd:	89 e5                	mov    %esp,%ebp
    19bf:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    19c2:	8b 55 08             	mov    0x8(%ebp),%edx
    19c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    19c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19cb:	f0 87 02             	lock xchg %eax,(%edx)
    19ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19d4:	c9                   	leave  
    19d5:	c3                   	ret    

000019d6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19d6:	55                   	push   %ebp
    19d7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19d9:	8b 45 08             	mov    0x8(%ebp),%eax
    19dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19e2:	5d                   	pop    %ebp
    19e3:	c3                   	ret    

000019e4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19e4:	55                   	push   %ebp
    19e5:	89 e5                	mov    %esp,%ebp
    19e7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19ea:	90                   	nop
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19f5:	00 
    19f6:	89 04 24             	mov    %eax,(%esp)
    19f9:	e8 be ff ff ff       	call   19bc <xchg>
    19fe:	85 c0                	test   %eax,%eax
    1a00:	75 e9                	jne    19eb <lock_acquire+0x7>
}
    1a02:	c9                   	leave  
    1a03:	c3                   	ret    

00001a04 <lock_release>:
void lock_release(lock_t *lock){
    1a04:	55                   	push   %ebp
    1a05:	89 e5                	mov    %esp,%ebp
    1a07:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1a0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a14:	00 
    1a15:	89 04 24             	mov    %eax,(%esp)
    1a18:	e8 9f ff ff ff       	call   19bc <xchg>
}
    1a1d:	c9                   	leave  
    1a1e:	c3                   	ret    

00001a1f <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1a1f:	55                   	push   %ebp
    1a20:	89 e5                	mov    %esp,%ebp
    1a22:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1a25:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a2c:	e8 a8 fe ff ff       	call   18d9 <malloc>
    1a31:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a37:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a42:	85 c0                	test   %eax,%eax
    1a44:	74 14                	je     1a5a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a49:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a4e:	89 c2                	mov    %eax,%edx
    1a50:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a55:	29 d0                	sub    %edx,%eax
    1a57:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1a5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a5e:	75 1b                	jne    1a7b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1a60:	c7 44 24 04 6c 1c 00 	movl   $0x1c6c,0x4(%esp)
    1a67:	00 
    1a68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a6f:	e8 78 fb ff ff       	call   15ec <printf>
        return 0;
    1a74:	b8 00 00 00 00       	mov    $0x0,%eax
    1a79:	eb 6f                	jmp    1aea <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a7b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a7e:	8b 55 08             	mov    0x8(%ebp),%edx
    1a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a84:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a88:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a8c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a93:	00 
    1a94:	89 04 24             	mov    %eax,(%esp)
    1a97:	e8 48 fa ff ff       	call   14e4 <clone>
    1a9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a9f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa3:	79 1b                	jns    1ac0 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1aa5:	c7 44 24 04 7a 1c 00 	movl   $0x1c7a,0x4(%esp)
    1aac:	00 
    1aad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab4:	e8 33 fb ff ff       	call   15ec <printf>
        return 0;
    1ab9:	b8 00 00 00 00       	mov    $0x0,%eax
    1abe:	eb 2a                	jmp    1aea <thread_create+0xcb>
    }
    if(tid > 0){
    1ac0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ac4:	7e 05                	jle    1acb <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ac9:	eb 1f                	jmp    1aea <thread_create+0xcb>
    }
    if(tid == 0){
    1acb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1acf:	75 14                	jne    1ae5 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1ad1:	c7 44 24 04 87 1c 00 	movl   $0x1c87,0x4(%esp)
    1ad8:	00 
    1ad9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae0:	e8 07 fb ff ff       	call   15ec <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ae5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1aea:	c9                   	leave  
    1aeb:	c3                   	ret    

00001aec <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1aec:	55                   	push   %ebp
    1aed:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1aef:	a1 50 20 00 00       	mov    0x2050,%eax
    1af4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1afa:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1aff:	a3 50 20 00 00       	mov    %eax,0x2050
    return (int)(rands % max);
    1b04:	a1 50 20 00 00       	mov    0x2050,%eax
    1b09:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b0c:	ba 00 00 00 00       	mov    $0x0,%edx
    1b11:	f7 f1                	div    %ecx
    1b13:	89 d0                	mov    %edx,%eax
}
    1b15:	5d                   	pop    %ebp
    1b16:	c3                   	ret    
    1b17:	90                   	nop

00001b18 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1b18:	55                   	push   %ebp
    1b19:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1b1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1b24:	8b 45 08             	mov    0x8(%ebp),%eax
    1b27:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b31:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b38:	5d                   	pop    %ebp
    1b39:	c3                   	ret    

00001b3a <add_q>:

void add_q(struct queue *q, int v){
    1b3a:	55                   	push   %ebp
    1b3b:	89 e5                	mov    %esp,%ebp
    1b3d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b40:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b47:	e8 8d fd ff ff       	call   18d9 <malloc>
    1b4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b52:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b5f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b61:	8b 45 08             	mov    0x8(%ebp),%eax
    1b64:	8b 40 04             	mov    0x4(%eax),%eax
    1b67:	85 c0                	test   %eax,%eax
    1b69:	75 0b                	jne    1b76 <add_q+0x3c>
        q->head = n;
    1b6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b71:	89 50 04             	mov    %edx,0x4(%eax)
    1b74:	eb 0c                	jmp    1b82 <add_q+0x48>
    }else{
        q->tail->next = n;
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	8b 40 08             	mov    0x8(%eax),%eax
    1b7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b7f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b88:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	8b 00                	mov    (%eax),%eax
    1b90:	8d 50 01             	lea    0x1(%eax),%edx
    1b93:	8b 45 08             	mov    0x8(%ebp),%eax
    1b96:	89 10                	mov    %edx,(%eax)
}
    1b98:	c9                   	leave  
    1b99:	c3                   	ret    

00001b9a <empty_q>:

int empty_q(struct queue *q){
    1b9a:	55                   	push   %ebp
    1b9b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba0:	8b 00                	mov    (%eax),%eax
    1ba2:	85 c0                	test   %eax,%eax
    1ba4:	75 07                	jne    1bad <empty_q+0x13>
        return 1;
    1ba6:	b8 01 00 00 00       	mov    $0x1,%eax
    1bab:	eb 05                	jmp    1bb2 <empty_q+0x18>
    else
        return 0;
    1bad:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1bb2:	5d                   	pop    %ebp
    1bb3:	c3                   	ret    

00001bb4 <pop_q>:
int pop_q(struct queue *q){
    1bb4:	55                   	push   %ebp
    1bb5:	89 e5                	mov    %esp,%ebp
    1bb7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1bba:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbd:	89 04 24             	mov    %eax,(%esp)
    1bc0:	e8 d5 ff ff ff       	call   1b9a <empty_q>
    1bc5:	85 c0                	test   %eax,%eax
    1bc7:	75 5d                	jne    1c26 <pop_q+0x72>
       val = q->head->value; 
    1bc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcc:	8b 40 04             	mov    0x4(%eax),%eax
    1bcf:	8b 00                	mov    (%eax),%eax
    1bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1bd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd7:	8b 40 04             	mov    0x4(%eax),%eax
    1bda:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1bdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1be0:	8b 40 04             	mov    0x4(%eax),%eax
    1be3:	8b 50 04             	mov    0x4(%eax),%edx
    1be6:	8b 45 08             	mov    0x8(%ebp),%eax
    1be9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bef:	89 04 24             	mov    %eax,(%esp)
    1bf2:	e8 a9 fb ff ff       	call   17a0 <free>
       q->size--;
    1bf7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfa:	8b 00                	mov    (%eax),%eax
    1bfc:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bff:	8b 45 08             	mov    0x8(%ebp),%eax
    1c02:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1c04:	8b 45 08             	mov    0x8(%ebp),%eax
    1c07:	8b 00                	mov    (%eax),%eax
    1c09:	85 c0                	test   %eax,%eax
    1c0b:	75 14                	jne    1c21 <pop_q+0x6d>
            q->head = 0;
    1c0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c10:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1c17:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c24:	eb 05                	jmp    1c2b <pop_q+0x77>
    }
    return -1;
    1c26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c2b:	c9                   	leave  
    1c2c:	c3                   	ret    
