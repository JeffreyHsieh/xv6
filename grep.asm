
_grep:     file format elf32-i386


Disassembly of section .text:

00001000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
    1006:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    100d:	e9 bb 00 00 00       	jmp    10cd <grep+0xcd>
    m += n;
    1012:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1015:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
    1018:	c7 45 f0 e0 21 00 00 	movl   $0x21e0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
    101f:	eb 51                	jmp    1072 <grep+0x72>
      *q = 0;
    1021:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1024:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
    1027:	8b 45 f0             	mov    -0x10(%ebp),%eax
    102a:	89 44 24 04          	mov    %eax,0x4(%esp)
    102e:	8b 45 08             	mov    0x8(%ebp),%eax
    1031:	89 04 24             	mov    %eax,(%esp)
    1034:	e8 bc 01 00 00       	call   11f5 <match>
    1039:	85 c0                	test   %eax,%eax
    103b:	74 2c                	je     1069 <grep+0x69>
        *q = '\n';
    103d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1040:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
    1043:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1046:	83 c0 01             	add    $0x1,%eax
    1049:	89 c2                	mov    %eax,%edx
    104b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    104e:	29 c2                	sub    %eax,%edx
    1050:	89 d0                	mov    %edx,%eax
    1052:	89 44 24 08          	mov    %eax,0x8(%esp)
    1056:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1059:	89 44 24 04          	mov    %eax,0x4(%esp)
    105d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1064:	e8 77 05 00 00       	call   15e0 <write>
      }
      p = q+1;
    1069:	8b 45 e8             	mov    -0x18(%ebp),%eax
    106c:	83 c0 01             	add    $0x1,%eax
    106f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
    1072:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
    1079:	00 
    107a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    107d:	89 04 24             	mov    %eax,(%esp)
    1080:	e8 b2 03 00 00       	call   1437 <strchr>
    1085:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1088:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    108c:	75 93                	jne    1021 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
    108e:	81 7d f0 e0 21 00 00 	cmpl   $0x21e0,-0x10(%ebp)
    1095:	75 07                	jne    109e <grep+0x9e>
      m = 0;
    1097:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
    109e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10a2:	7e 29                	jle    10cd <grep+0xcd>
      m -= p - buf;
    10a4:	ba e0 21 00 00       	mov    $0x21e0,%edx
    10a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ac:	29 c2                	sub    %eax,%edx
    10ae:	89 d0                	mov    %edx,%eax
    10b0:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
    10b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b6:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10bd:	89 44 24 04          	mov    %eax,0x4(%esp)
    10c1:	c7 04 24 e0 21 00 00 	movl   $0x21e0,(%esp)
    10c8:	e8 ae 04 00 00       	call   157b <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    10cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d0:	ba 00 04 00 00       	mov    $0x400,%edx
    10d5:	29 c2                	sub    %eax,%edx
    10d7:	89 d0                	mov    %edx,%eax
    10d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10dc:	81 c2 e0 21 00 00    	add    $0x21e0,%edx
    10e2:	89 44 24 08          	mov    %eax,0x8(%esp)
    10e6:	89 54 24 04          	mov    %edx,0x4(%esp)
    10ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ed:	89 04 24             	mov    %eax,(%esp)
    10f0:	e8 e3 04 00 00       	call   15d8 <read>
    10f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10fc:	0f 8f 10 ff ff ff    	jg     1012 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
    1102:	c9                   	leave  
    1103:	c3                   	ret    

00001104 <main>:

int
main(int argc, char *argv[])
{
    1104:	55                   	push   %ebp
    1105:	89 e5                	mov    %esp,%ebp
    1107:	83 e4 f0             	and    $0xfffffff0,%esp
    110a:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
    110d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1111:	7f 19                	jg     112c <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
    1113:	c7 44 24 04 98 1d 00 	movl   $0x1d98,0x4(%esp)
    111a:	00 
    111b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1122:	e8 39 06 00 00       	call   1760 <printf>
    exit();
    1127:	e8 94 04 00 00       	call   15c0 <exit>
  }
  pattern = argv[1];
    112c:	8b 45 0c             	mov    0xc(%ebp),%eax
    112f:	8b 40 04             	mov    0x4(%eax),%eax
    1132:	89 44 24 18          	mov    %eax,0x18(%esp)
  
  if(argc <= 2){
    1136:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    113a:	7f 19                	jg     1155 <main+0x51>
    grep(pattern, 0);
    113c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1143:	00 
    1144:	8b 44 24 18          	mov    0x18(%esp),%eax
    1148:	89 04 24             	mov    %eax,(%esp)
    114b:	e8 b0 fe ff ff       	call   1000 <grep>
    exit();
    1150:	e8 6b 04 00 00       	call   15c0 <exit>
  }

  for(i = 2; i < argc; i++){
    1155:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
    115c:	00 
    115d:	e9 81 00 00 00       	jmp    11e3 <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
    1162:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1166:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    116d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1170:	01 d0                	add    %edx,%eax
    1172:	8b 00                	mov    (%eax),%eax
    1174:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    117b:	00 
    117c:	89 04 24             	mov    %eax,(%esp)
    117f:	e8 7c 04 00 00       	call   1600 <open>
    1184:	89 44 24 14          	mov    %eax,0x14(%esp)
    1188:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    118d:	79 2f                	jns    11be <main+0xba>
      printf(1, "grep: cannot open %s\n", argv[i]);
    118f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1193:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    119a:	8b 45 0c             	mov    0xc(%ebp),%eax
    119d:	01 d0                	add    %edx,%eax
    119f:	8b 00                	mov    (%eax),%eax
    11a1:	89 44 24 08          	mov    %eax,0x8(%esp)
    11a5:	c7 44 24 04 b8 1d 00 	movl   $0x1db8,0x4(%esp)
    11ac:	00 
    11ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11b4:	e8 a7 05 00 00       	call   1760 <printf>
      exit();
    11b9:	e8 02 04 00 00       	call   15c0 <exit>
    }
    grep(pattern, fd);
    11be:	8b 44 24 14          	mov    0x14(%esp),%eax
    11c2:	89 44 24 04          	mov    %eax,0x4(%esp)
    11c6:	8b 44 24 18          	mov    0x18(%esp),%eax
    11ca:	89 04 24             	mov    %eax,(%esp)
    11cd:	e8 2e fe ff ff       	call   1000 <grep>
    close(fd);
    11d2:	8b 44 24 14          	mov    0x14(%esp),%eax
    11d6:	89 04 24             	mov    %eax,(%esp)
    11d9:	e8 0a 04 00 00       	call   15e8 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    11de:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    11e3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    11e7:	3b 45 08             	cmp    0x8(%ebp),%eax
    11ea:	0f 8c 72 ff ff ff    	jl     1162 <main+0x5e>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
    11f0:	e8 cb 03 00 00       	call   15c0 <exit>

000011f5 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    11f5:	55                   	push   %ebp
    11f6:	89 e5                	mov    %esp,%ebp
    11f8:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	0f b6 00             	movzbl (%eax),%eax
    1201:	3c 5e                	cmp    $0x5e,%al
    1203:	75 17                	jne    121c <match+0x27>
    return matchhere(re+1, text);
    1205:	8b 45 08             	mov    0x8(%ebp),%eax
    1208:	8d 50 01             	lea    0x1(%eax),%edx
    120b:	8b 45 0c             	mov    0xc(%ebp),%eax
    120e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1212:	89 14 24             	mov    %edx,(%esp)
    1215:	e8 36 00 00 00       	call   1250 <matchhere>
    121a:	eb 32                	jmp    124e <match+0x59>
  do{  // must look at empty string
    if(matchhere(re, text))
    121c:	8b 45 0c             	mov    0xc(%ebp),%eax
    121f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1223:	8b 45 08             	mov    0x8(%ebp),%eax
    1226:	89 04 24             	mov    %eax,(%esp)
    1229:	e8 22 00 00 00       	call   1250 <matchhere>
    122e:	85 c0                	test   %eax,%eax
    1230:	74 07                	je     1239 <match+0x44>
      return 1;
    1232:	b8 01 00 00 00       	mov    $0x1,%eax
    1237:	eb 15                	jmp    124e <match+0x59>
  }while(*text++ != '\0');
    1239:	8b 45 0c             	mov    0xc(%ebp),%eax
    123c:	8d 50 01             	lea    0x1(%eax),%edx
    123f:	89 55 0c             	mov    %edx,0xc(%ebp)
    1242:	0f b6 00             	movzbl (%eax),%eax
    1245:	84 c0                	test   %al,%al
    1247:	75 d3                	jne    121c <match+0x27>
  return 0;
    1249:	b8 00 00 00 00       	mov    $0x0,%eax
}
    124e:	c9                   	leave  
    124f:	c3                   	ret    

00001250 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	0f b6 00             	movzbl (%eax),%eax
    125c:	84 c0                	test   %al,%al
    125e:	75 0a                	jne    126a <matchhere+0x1a>
    return 1;
    1260:	b8 01 00 00 00       	mov    $0x1,%eax
    1265:	e9 9b 00 00 00       	jmp    1305 <matchhere+0xb5>
  if(re[1] == '*')
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	83 c0 01             	add    $0x1,%eax
    1270:	0f b6 00             	movzbl (%eax),%eax
    1273:	3c 2a                	cmp    $0x2a,%al
    1275:	75 24                	jne    129b <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	8d 48 02             	lea    0x2(%eax),%ecx
    127d:	8b 45 08             	mov    0x8(%ebp),%eax
    1280:	0f b6 00             	movzbl (%eax),%eax
    1283:	0f be c0             	movsbl %al,%eax
    1286:	8b 55 0c             	mov    0xc(%ebp),%edx
    1289:	89 54 24 08          	mov    %edx,0x8(%esp)
    128d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1291:	89 04 24             	mov    %eax,(%esp)
    1294:	e8 6e 00 00 00       	call   1307 <matchstar>
    1299:	eb 6a                	jmp    1305 <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	0f b6 00             	movzbl (%eax),%eax
    12a1:	3c 24                	cmp    $0x24,%al
    12a3:	75 1d                	jne    12c2 <matchhere+0x72>
    12a5:	8b 45 08             	mov    0x8(%ebp),%eax
    12a8:	83 c0 01             	add    $0x1,%eax
    12ab:	0f b6 00             	movzbl (%eax),%eax
    12ae:	84 c0                	test   %al,%al
    12b0:	75 10                	jne    12c2 <matchhere+0x72>
    return *text == '\0';
    12b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b5:	0f b6 00             	movzbl (%eax),%eax
    12b8:	84 c0                	test   %al,%al
    12ba:	0f 94 c0             	sete   %al
    12bd:	0f b6 c0             	movzbl %al,%eax
    12c0:	eb 43                	jmp    1305 <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    12c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c5:	0f b6 00             	movzbl (%eax),%eax
    12c8:	84 c0                	test   %al,%al
    12ca:	74 34                	je     1300 <matchhere+0xb0>
    12cc:	8b 45 08             	mov    0x8(%ebp),%eax
    12cf:	0f b6 00             	movzbl (%eax),%eax
    12d2:	3c 2e                	cmp    $0x2e,%al
    12d4:	74 10                	je     12e6 <matchhere+0x96>
    12d6:	8b 45 08             	mov    0x8(%ebp),%eax
    12d9:	0f b6 10             	movzbl (%eax),%edx
    12dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12df:	0f b6 00             	movzbl (%eax),%eax
    12e2:	38 c2                	cmp    %al,%dl
    12e4:	75 1a                	jne    1300 <matchhere+0xb0>
    return matchhere(re+1, text+1);
    12e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e9:	8d 50 01             	lea    0x1(%eax),%edx
    12ec:	8b 45 08             	mov    0x8(%ebp),%eax
    12ef:	83 c0 01             	add    $0x1,%eax
    12f2:	89 54 24 04          	mov    %edx,0x4(%esp)
    12f6:	89 04 24             	mov    %eax,(%esp)
    12f9:	e8 52 ff ff ff       	call   1250 <matchhere>
    12fe:	eb 05                	jmp    1305 <matchhere+0xb5>
  return 0;
    1300:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1305:	c9                   	leave  
    1306:	c3                   	ret    

00001307 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    1307:	55                   	push   %ebp
    1308:	89 e5                	mov    %esp,%ebp
    130a:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    130d:	8b 45 10             	mov    0x10(%ebp),%eax
    1310:	89 44 24 04          	mov    %eax,0x4(%esp)
    1314:	8b 45 0c             	mov    0xc(%ebp),%eax
    1317:	89 04 24             	mov    %eax,(%esp)
    131a:	e8 31 ff ff ff       	call   1250 <matchhere>
    131f:	85 c0                	test   %eax,%eax
    1321:	74 07                	je     132a <matchstar+0x23>
      return 1;
    1323:	b8 01 00 00 00       	mov    $0x1,%eax
    1328:	eb 29                	jmp    1353 <matchstar+0x4c>
  }while(*text!='\0' && (*text++==c || c=='.'));
    132a:	8b 45 10             	mov    0x10(%ebp),%eax
    132d:	0f b6 00             	movzbl (%eax),%eax
    1330:	84 c0                	test   %al,%al
    1332:	74 1a                	je     134e <matchstar+0x47>
    1334:	8b 45 10             	mov    0x10(%ebp),%eax
    1337:	8d 50 01             	lea    0x1(%eax),%edx
    133a:	89 55 10             	mov    %edx,0x10(%ebp)
    133d:	0f b6 00             	movzbl (%eax),%eax
    1340:	0f be c0             	movsbl %al,%eax
    1343:	3b 45 08             	cmp    0x8(%ebp),%eax
    1346:	74 c5                	je     130d <matchstar+0x6>
    1348:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
    134c:	74 bf                	je     130d <matchstar+0x6>
  return 0;
    134e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1353:	c9                   	leave  
    1354:	c3                   	ret    
    1355:	66 90                	xchg   %ax,%ax
    1357:	90                   	nop

00001358 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1358:	55                   	push   %ebp
    1359:	89 e5                	mov    %esp,%ebp
    135b:	57                   	push   %edi
    135c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    135d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1360:	8b 55 10             	mov    0x10(%ebp),%edx
    1363:	8b 45 0c             	mov    0xc(%ebp),%eax
    1366:	89 cb                	mov    %ecx,%ebx
    1368:	89 df                	mov    %ebx,%edi
    136a:	89 d1                	mov    %edx,%ecx
    136c:	fc                   	cld    
    136d:	f3 aa                	rep stos %al,%es:(%edi)
    136f:	89 ca                	mov    %ecx,%edx
    1371:	89 fb                	mov    %edi,%ebx
    1373:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1376:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1379:	5b                   	pop    %ebx
    137a:	5f                   	pop    %edi
    137b:	5d                   	pop    %ebp
    137c:	c3                   	ret    

0000137d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    137d:	55                   	push   %ebp
    137e:	89 e5                	mov    %esp,%ebp
    1380:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1383:	8b 45 08             	mov    0x8(%ebp),%eax
    1386:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1389:	90                   	nop
    138a:	8b 45 08             	mov    0x8(%ebp),%eax
    138d:	8d 50 01             	lea    0x1(%eax),%edx
    1390:	89 55 08             	mov    %edx,0x8(%ebp)
    1393:	8b 55 0c             	mov    0xc(%ebp),%edx
    1396:	8d 4a 01             	lea    0x1(%edx),%ecx
    1399:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    139c:	0f b6 12             	movzbl (%edx),%edx
    139f:	88 10                	mov    %dl,(%eax)
    13a1:	0f b6 00             	movzbl (%eax),%eax
    13a4:	84 c0                	test   %al,%al
    13a6:	75 e2                	jne    138a <strcpy+0xd>
    ;
  return os;
    13a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13ab:	c9                   	leave  
    13ac:	c3                   	ret    

000013ad <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13ad:	55                   	push   %ebp
    13ae:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13b0:	eb 08                	jmp    13ba <strcmp+0xd>
    p++, q++;
    13b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13b6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13ba:	8b 45 08             	mov    0x8(%ebp),%eax
    13bd:	0f b6 00             	movzbl (%eax),%eax
    13c0:	84 c0                	test   %al,%al
    13c2:	74 10                	je     13d4 <strcmp+0x27>
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
    13c7:	0f b6 10             	movzbl (%eax),%edx
    13ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cd:	0f b6 00             	movzbl (%eax),%eax
    13d0:	38 c2                	cmp    %al,%dl
    13d2:	74 de                	je     13b2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	0f b6 00             	movzbl (%eax),%eax
    13da:	0f b6 d0             	movzbl %al,%edx
    13dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e0:	0f b6 00             	movzbl (%eax),%eax
    13e3:	0f b6 c0             	movzbl %al,%eax
    13e6:	29 c2                	sub    %eax,%edx
    13e8:	89 d0                	mov    %edx,%eax
}
    13ea:	5d                   	pop    %ebp
    13eb:	c3                   	ret    

000013ec <strlen>:

uint
strlen(char *s)
{
    13ec:	55                   	push   %ebp
    13ed:	89 e5                	mov    %esp,%ebp
    13ef:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13f9:	eb 04                	jmp    13ff <strlen+0x13>
    13fb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1402:	8b 45 08             	mov    0x8(%ebp),%eax
    1405:	01 d0                	add    %edx,%eax
    1407:	0f b6 00             	movzbl (%eax),%eax
    140a:	84 c0                	test   %al,%al
    140c:	75 ed                	jne    13fb <strlen+0xf>
    ;
  return n;
    140e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1411:	c9                   	leave  
    1412:	c3                   	ret    

00001413 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1413:	55                   	push   %ebp
    1414:	89 e5                	mov    %esp,%ebp
    1416:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1419:	8b 45 10             	mov    0x10(%ebp),%eax
    141c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1420:	8b 45 0c             	mov    0xc(%ebp),%eax
    1423:	89 44 24 04          	mov    %eax,0x4(%esp)
    1427:	8b 45 08             	mov    0x8(%ebp),%eax
    142a:	89 04 24             	mov    %eax,(%esp)
    142d:	e8 26 ff ff ff       	call   1358 <stosb>
  return dst;
    1432:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1435:	c9                   	leave  
    1436:	c3                   	ret    

00001437 <strchr>:

char*
strchr(const char *s, char c)
{
    1437:	55                   	push   %ebp
    1438:	89 e5                	mov    %esp,%ebp
    143a:	83 ec 04             	sub    $0x4,%esp
    143d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1440:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1443:	eb 14                	jmp    1459 <strchr+0x22>
    if(*s == c)
    1445:	8b 45 08             	mov    0x8(%ebp),%eax
    1448:	0f b6 00             	movzbl (%eax),%eax
    144b:	3a 45 fc             	cmp    -0x4(%ebp),%al
    144e:	75 05                	jne    1455 <strchr+0x1e>
      return (char*)s;
    1450:	8b 45 08             	mov    0x8(%ebp),%eax
    1453:	eb 13                	jmp    1468 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1455:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	0f b6 00             	movzbl (%eax),%eax
    145f:	84 c0                	test   %al,%al
    1461:	75 e2                	jne    1445 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1463:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1468:	c9                   	leave  
    1469:	c3                   	ret    

0000146a <gets>:

char*
gets(char *buf, int max)
{
    146a:	55                   	push   %ebp
    146b:	89 e5                	mov    %esp,%ebp
    146d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1477:	eb 4c                	jmp    14c5 <gets+0x5b>
    cc = read(0, &c, 1);
    1479:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1480:	00 
    1481:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1484:	89 44 24 04          	mov    %eax,0x4(%esp)
    1488:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    148f:	e8 44 01 00 00       	call   15d8 <read>
    1494:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1497:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    149b:	7f 02                	jg     149f <gets+0x35>
      break;
    149d:	eb 31                	jmp    14d0 <gets+0x66>
    buf[i++] = c;
    149f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a2:	8d 50 01             	lea    0x1(%eax),%edx
    14a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14a8:	89 c2                	mov    %eax,%edx
    14aa:	8b 45 08             	mov    0x8(%ebp),%eax
    14ad:	01 c2                	add    %eax,%edx
    14af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    14b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b9:	3c 0a                	cmp    $0xa,%al
    14bb:	74 13                	je     14d0 <gets+0x66>
    14bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14c1:	3c 0d                	cmp    $0xd,%al
    14c3:	74 0b                	je     14d0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c8:	83 c0 01             	add    $0x1,%eax
    14cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14ce:	7c a9                	jl     1479 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    14d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14d3:	8b 45 08             	mov    0x8(%ebp),%eax
    14d6:	01 d0                	add    %edx,%eax
    14d8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    14db:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14de:	c9                   	leave  
    14df:	c3                   	ret    

000014e0 <stat>:

int
stat(char *n, struct stat *st)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14e6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14ed:	00 
    14ee:	8b 45 08             	mov    0x8(%ebp),%eax
    14f1:	89 04 24             	mov    %eax,(%esp)
    14f4:	e8 07 01 00 00       	call   1600 <open>
    14f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    14fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1500:	79 07                	jns    1509 <stat+0x29>
    return -1;
    1502:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1507:	eb 23                	jmp    152c <stat+0x4c>
  r = fstat(fd, st);
    1509:	8b 45 0c             	mov    0xc(%ebp),%eax
    150c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1513:	89 04 24             	mov    %eax,(%esp)
    1516:	e8 fd 00 00 00       	call   1618 <fstat>
    151b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	89 04 24             	mov    %eax,(%esp)
    1524:	e8 bf 00 00 00       	call   15e8 <close>
  return r;
    1529:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    152c:	c9                   	leave  
    152d:	c3                   	ret    

0000152e <atoi>:

int
atoi(const char *s)
{
    152e:	55                   	push   %ebp
    152f:	89 e5                	mov    %esp,%ebp
    1531:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1534:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    153b:	eb 25                	jmp    1562 <atoi+0x34>
    n = n*10 + *s++ - '0';
    153d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1540:	89 d0                	mov    %edx,%eax
    1542:	c1 e0 02             	shl    $0x2,%eax
    1545:	01 d0                	add    %edx,%eax
    1547:	01 c0                	add    %eax,%eax
    1549:	89 c1                	mov    %eax,%ecx
    154b:	8b 45 08             	mov    0x8(%ebp),%eax
    154e:	8d 50 01             	lea    0x1(%eax),%edx
    1551:	89 55 08             	mov    %edx,0x8(%ebp)
    1554:	0f b6 00             	movzbl (%eax),%eax
    1557:	0f be c0             	movsbl %al,%eax
    155a:	01 c8                	add    %ecx,%eax
    155c:	83 e8 30             	sub    $0x30,%eax
    155f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	0f b6 00             	movzbl (%eax),%eax
    1568:	3c 2f                	cmp    $0x2f,%al
    156a:	7e 0a                	jle    1576 <atoi+0x48>
    156c:	8b 45 08             	mov    0x8(%ebp),%eax
    156f:	0f b6 00             	movzbl (%eax),%eax
    1572:	3c 39                	cmp    $0x39,%al
    1574:	7e c7                	jle    153d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1576:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1579:	c9                   	leave  
    157a:	c3                   	ret    

0000157b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    157b:	55                   	push   %ebp
    157c:	89 e5                	mov    %esp,%ebp
    157e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1581:	8b 45 08             	mov    0x8(%ebp),%eax
    1584:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1587:	8b 45 0c             	mov    0xc(%ebp),%eax
    158a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    158d:	eb 17                	jmp    15a6 <memmove+0x2b>
    *dst++ = *src++;
    158f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1592:	8d 50 01             	lea    0x1(%eax),%edx
    1595:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1598:	8b 55 f8             	mov    -0x8(%ebp),%edx
    159b:	8d 4a 01             	lea    0x1(%edx),%ecx
    159e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    15a1:	0f b6 12             	movzbl (%edx),%edx
    15a4:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    15a6:	8b 45 10             	mov    0x10(%ebp),%eax
    15a9:	8d 50 ff             	lea    -0x1(%eax),%edx
    15ac:	89 55 10             	mov    %edx,0x10(%ebp)
    15af:	85 c0                	test   %eax,%eax
    15b1:	7f dc                	jg     158f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    15b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15b6:	c9                   	leave  
    15b7:	c3                   	ret    

000015b8 <fork>:
    15b8:	b8 01 00 00 00       	mov    $0x1,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <exit>:
    15c0:	b8 02 00 00 00       	mov    $0x2,%eax
    15c5:	cd 40                	int    $0x40
    15c7:	c3                   	ret    

000015c8 <wait>:
    15c8:	b8 03 00 00 00       	mov    $0x3,%eax
    15cd:	cd 40                	int    $0x40
    15cf:	c3                   	ret    

000015d0 <pipe>:
    15d0:	b8 04 00 00 00       	mov    $0x4,%eax
    15d5:	cd 40                	int    $0x40
    15d7:	c3                   	ret    

000015d8 <read>:
    15d8:	b8 05 00 00 00       	mov    $0x5,%eax
    15dd:	cd 40                	int    $0x40
    15df:	c3                   	ret    

000015e0 <write>:
    15e0:	b8 10 00 00 00       	mov    $0x10,%eax
    15e5:	cd 40                	int    $0x40
    15e7:	c3                   	ret    

000015e8 <close>:
    15e8:	b8 15 00 00 00       	mov    $0x15,%eax
    15ed:	cd 40                	int    $0x40
    15ef:	c3                   	ret    

000015f0 <kill>:
    15f0:	b8 06 00 00 00       	mov    $0x6,%eax
    15f5:	cd 40                	int    $0x40
    15f7:	c3                   	ret    

000015f8 <exec>:
    15f8:	b8 07 00 00 00       	mov    $0x7,%eax
    15fd:	cd 40                	int    $0x40
    15ff:	c3                   	ret    

00001600 <open>:
    1600:	b8 0f 00 00 00       	mov    $0xf,%eax
    1605:	cd 40                	int    $0x40
    1607:	c3                   	ret    

00001608 <mknod>:
    1608:	b8 11 00 00 00       	mov    $0x11,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <unlink>:
    1610:	b8 12 00 00 00       	mov    $0x12,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <fstat>:
    1618:	b8 08 00 00 00       	mov    $0x8,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <link>:
    1620:	b8 13 00 00 00       	mov    $0x13,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <mkdir>:
    1628:	b8 14 00 00 00       	mov    $0x14,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <chdir>:
    1630:	b8 09 00 00 00       	mov    $0x9,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <dup>:
    1638:	b8 0a 00 00 00       	mov    $0xa,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <getpid>:
    1640:	b8 0b 00 00 00       	mov    $0xb,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    

00001648 <sbrk>:
    1648:	b8 0c 00 00 00       	mov    $0xc,%eax
    164d:	cd 40                	int    $0x40
    164f:	c3                   	ret    

00001650 <sleep>:
    1650:	b8 0d 00 00 00       	mov    $0xd,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    

00001658 <uptime>:
    1658:	b8 0e 00 00 00       	mov    $0xe,%eax
    165d:	cd 40                	int    $0x40
    165f:	c3                   	ret    

00001660 <clone>:
    1660:	b8 16 00 00 00       	mov    $0x16,%eax
    1665:	cd 40                	int    $0x40
    1667:	c3                   	ret    

00001668 <texit>:
    1668:	b8 17 00 00 00       	mov    $0x17,%eax
    166d:	cd 40                	int    $0x40
    166f:	c3                   	ret    

00001670 <tsleep>:
    1670:	b8 18 00 00 00       	mov    $0x18,%eax
    1675:	cd 40                	int    $0x40
    1677:	c3                   	ret    

00001678 <twakeup>:
    1678:	b8 19 00 00 00       	mov    $0x19,%eax
    167d:	cd 40                	int    $0x40
    167f:	c3                   	ret    

00001680 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	83 ec 18             	sub    $0x18,%esp
    1686:	8b 45 0c             	mov    0xc(%ebp),%eax
    1689:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    168c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1693:	00 
    1694:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1697:	89 44 24 04          	mov    %eax,0x4(%esp)
    169b:	8b 45 08             	mov    0x8(%ebp),%eax
    169e:	89 04 24             	mov    %eax,(%esp)
    16a1:	e8 3a ff ff ff       	call   15e0 <write>
}
    16a6:	c9                   	leave  
    16a7:	c3                   	ret    

000016a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	56                   	push   %esi
    16ac:	53                   	push   %ebx
    16ad:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16b7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16bb:	74 17                	je     16d4 <printint+0x2c>
    16bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16c1:	79 11                	jns    16d4 <printint+0x2c>
    neg = 1;
    16c3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    16ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    16cd:	f7 d8                	neg    %eax
    16cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16d2:	eb 06                	jmp    16da <printint+0x32>
  } else {
    x = xx;
    16d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    16da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    16e1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16e4:	8d 41 01             	lea    0x1(%ecx),%eax
    16e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16ea:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16f0:	ba 00 00 00 00       	mov    $0x0,%edx
    16f5:	f7 f3                	div    %ebx
    16f7:	89 d0                	mov    %edx,%eax
    16f9:	0f b6 80 a8 21 00 00 	movzbl 0x21a8(%eax),%eax
    1700:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1704:	8b 75 10             	mov    0x10(%ebp),%esi
    1707:	8b 45 ec             	mov    -0x14(%ebp),%eax
    170a:	ba 00 00 00 00       	mov    $0x0,%edx
    170f:	f7 f6                	div    %esi
    1711:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1714:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1718:	75 c7                	jne    16e1 <printint+0x39>
  if(neg)
    171a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    171e:	74 10                	je     1730 <printint+0x88>
    buf[i++] = '-';
    1720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1723:	8d 50 01             	lea    0x1(%eax),%edx
    1726:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1729:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    172e:	eb 1f                	jmp    174f <printint+0xa7>
    1730:	eb 1d                	jmp    174f <printint+0xa7>
    putc(fd, buf[i]);
    1732:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	01 d0                	add    %edx,%eax
    173a:	0f b6 00             	movzbl (%eax),%eax
    173d:	0f be c0             	movsbl %al,%eax
    1740:	89 44 24 04          	mov    %eax,0x4(%esp)
    1744:	8b 45 08             	mov    0x8(%ebp),%eax
    1747:	89 04 24             	mov    %eax,(%esp)
    174a:	e8 31 ff ff ff       	call   1680 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    174f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1753:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1757:	79 d9                	jns    1732 <printint+0x8a>
    putc(fd, buf[i]);
}
    1759:	83 c4 30             	add    $0x30,%esp
    175c:	5b                   	pop    %ebx
    175d:	5e                   	pop    %esi
    175e:	5d                   	pop    %ebp
    175f:	c3                   	ret    

00001760 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1760:	55                   	push   %ebp
    1761:	89 e5                	mov    %esp,%ebp
    1763:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    176d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1770:	83 c0 04             	add    $0x4,%eax
    1773:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1776:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    177d:	e9 7c 01 00 00       	jmp    18fe <printf+0x19e>
    c = fmt[i] & 0xff;
    1782:	8b 55 0c             	mov    0xc(%ebp),%edx
    1785:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1788:	01 d0                	add    %edx,%eax
    178a:	0f b6 00             	movzbl (%eax),%eax
    178d:	0f be c0             	movsbl %al,%eax
    1790:	25 ff 00 00 00       	and    $0xff,%eax
    1795:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1798:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    179c:	75 2c                	jne    17ca <printf+0x6a>
      if(c == '%'){
    179e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17a2:	75 0c                	jne    17b0 <printf+0x50>
        state = '%';
    17a4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    17ab:	e9 4a 01 00 00       	jmp    18fa <printf+0x19a>
      } else {
        putc(fd, c);
    17b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17b3:	0f be c0             	movsbl %al,%eax
    17b6:	89 44 24 04          	mov    %eax,0x4(%esp)
    17ba:	8b 45 08             	mov    0x8(%ebp),%eax
    17bd:	89 04 24             	mov    %eax,(%esp)
    17c0:	e8 bb fe ff ff       	call   1680 <putc>
    17c5:	e9 30 01 00 00       	jmp    18fa <printf+0x19a>
      }
    } else if(state == '%'){
    17ca:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    17ce:	0f 85 26 01 00 00    	jne    18fa <printf+0x19a>
      if(c == 'd'){
    17d4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    17d8:	75 2d                	jne    1807 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    17da:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17dd:	8b 00                	mov    (%eax),%eax
    17df:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    17e6:	00 
    17e7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    17ee:	00 
    17ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f3:	8b 45 08             	mov    0x8(%ebp),%eax
    17f6:	89 04 24             	mov    %eax,(%esp)
    17f9:	e8 aa fe ff ff       	call   16a8 <printint>
        ap++;
    17fe:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1802:	e9 ec 00 00 00       	jmp    18f3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1807:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    180b:	74 06                	je     1813 <printf+0xb3>
    180d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1811:	75 2d                	jne    1840 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1813:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1816:	8b 00                	mov    (%eax),%eax
    1818:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    181f:	00 
    1820:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1827:	00 
    1828:	89 44 24 04          	mov    %eax,0x4(%esp)
    182c:	8b 45 08             	mov    0x8(%ebp),%eax
    182f:	89 04 24             	mov    %eax,(%esp)
    1832:	e8 71 fe ff ff       	call   16a8 <printint>
        ap++;
    1837:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    183b:	e9 b3 00 00 00       	jmp    18f3 <printf+0x193>
      } else if(c == 's'){
    1840:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1844:	75 45                	jne    188b <printf+0x12b>
        s = (char*)*ap;
    1846:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1849:	8b 00                	mov    (%eax),%eax
    184b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    184e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1852:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1856:	75 09                	jne    1861 <printf+0x101>
          s = "(null)";
    1858:	c7 45 f4 ce 1d 00 00 	movl   $0x1dce,-0xc(%ebp)
        while(*s != 0){
    185f:	eb 1e                	jmp    187f <printf+0x11f>
    1861:	eb 1c                	jmp    187f <printf+0x11f>
          putc(fd, *s);
    1863:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1866:	0f b6 00             	movzbl (%eax),%eax
    1869:	0f be c0             	movsbl %al,%eax
    186c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1870:	8b 45 08             	mov    0x8(%ebp),%eax
    1873:	89 04 24             	mov    %eax,(%esp)
    1876:	e8 05 fe ff ff       	call   1680 <putc>
          s++;
    187b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    187f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1882:	0f b6 00             	movzbl (%eax),%eax
    1885:	84 c0                	test   %al,%al
    1887:	75 da                	jne    1863 <printf+0x103>
    1889:	eb 68                	jmp    18f3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    188b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    188f:	75 1d                	jne    18ae <printf+0x14e>
        putc(fd, *ap);
    1891:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1894:	8b 00                	mov    (%eax),%eax
    1896:	0f be c0             	movsbl %al,%eax
    1899:	89 44 24 04          	mov    %eax,0x4(%esp)
    189d:	8b 45 08             	mov    0x8(%ebp),%eax
    18a0:	89 04 24             	mov    %eax,(%esp)
    18a3:	e8 d8 fd ff ff       	call   1680 <putc>
        ap++;
    18a8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18ac:	eb 45                	jmp    18f3 <printf+0x193>
      } else if(c == '%'){
    18ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    18b2:	75 17                	jne    18cb <printf+0x16b>
        putc(fd, c);
    18b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18b7:	0f be c0             	movsbl %al,%eax
    18ba:	89 44 24 04          	mov    %eax,0x4(%esp)
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	89 04 24             	mov    %eax,(%esp)
    18c4:	e8 b7 fd ff ff       	call   1680 <putc>
    18c9:	eb 28                	jmp    18f3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18cb:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    18d2:	00 
    18d3:	8b 45 08             	mov    0x8(%ebp),%eax
    18d6:	89 04 24             	mov    %eax,(%esp)
    18d9:	e8 a2 fd ff ff       	call   1680 <putc>
        putc(fd, c);
    18de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18e1:	0f be c0             	movsbl %al,%eax
    18e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    18e8:	8b 45 08             	mov    0x8(%ebp),%eax
    18eb:	89 04 24             	mov    %eax,(%esp)
    18ee:	e8 8d fd ff ff       	call   1680 <putc>
      }
      state = 0;
    18f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    18fa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    18fe:	8b 55 0c             	mov    0xc(%ebp),%edx
    1901:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1904:	01 d0                	add    %edx,%eax
    1906:	0f b6 00             	movzbl (%eax),%eax
    1909:	84 c0                	test   %al,%al
    190b:	0f 85 71 fe ff ff    	jne    1782 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1911:	c9                   	leave  
    1912:	c3                   	ret    
    1913:	90                   	nop

00001914 <free>:
    1914:	55                   	push   %ebp
    1915:	89 e5                	mov    %esp,%ebp
    1917:	83 ec 10             	sub    $0x10,%esp
    191a:	8b 45 08             	mov    0x8(%ebp),%eax
    191d:	83 e8 08             	sub    $0x8,%eax
    1920:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1923:	a1 c8 21 00 00       	mov    0x21c8,%eax
    1928:	89 45 fc             	mov    %eax,-0x4(%ebp)
    192b:	eb 24                	jmp    1951 <free+0x3d>
    192d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1930:	8b 00                	mov    (%eax),%eax
    1932:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1935:	77 12                	ja     1949 <free+0x35>
    1937:	8b 45 f8             	mov    -0x8(%ebp),%eax
    193a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    193d:	77 24                	ja     1963 <free+0x4f>
    193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1942:	8b 00                	mov    (%eax),%eax
    1944:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1947:	77 1a                	ja     1963 <free+0x4f>
    1949:	8b 45 fc             	mov    -0x4(%ebp),%eax
    194c:	8b 00                	mov    (%eax),%eax
    194e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1951:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1954:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1957:	76 d4                	jbe    192d <free+0x19>
    1959:	8b 45 fc             	mov    -0x4(%ebp),%eax
    195c:	8b 00                	mov    (%eax),%eax
    195e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1961:	76 ca                	jbe    192d <free+0x19>
    1963:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1966:	8b 40 04             	mov    0x4(%eax),%eax
    1969:	c1 e0 03             	shl    $0x3,%eax
    196c:	89 c2                	mov    %eax,%edx
    196e:	03 55 f8             	add    -0x8(%ebp),%edx
    1971:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1974:	8b 00                	mov    (%eax),%eax
    1976:	39 c2                	cmp    %eax,%edx
    1978:	75 24                	jne    199e <free+0x8a>
    197a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    197d:	8b 50 04             	mov    0x4(%eax),%edx
    1980:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1983:	8b 00                	mov    (%eax),%eax
    1985:	8b 40 04             	mov    0x4(%eax),%eax
    1988:	01 c2                	add    %eax,%edx
    198a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    198d:	89 50 04             	mov    %edx,0x4(%eax)
    1990:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1993:	8b 00                	mov    (%eax),%eax
    1995:	8b 10                	mov    (%eax),%edx
    1997:	8b 45 f8             	mov    -0x8(%ebp),%eax
    199a:	89 10                	mov    %edx,(%eax)
    199c:	eb 0a                	jmp    19a8 <free+0x94>
    199e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a1:	8b 10                	mov    (%eax),%edx
    19a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a6:	89 10                	mov    %edx,(%eax)
    19a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ab:	8b 40 04             	mov    0x4(%eax),%eax
    19ae:	c1 e0 03             	shl    $0x3,%eax
    19b1:	03 45 fc             	add    -0x4(%ebp),%eax
    19b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19b7:	75 20                	jne    19d9 <free+0xc5>
    19b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19bc:	8b 50 04             	mov    0x4(%eax),%edx
    19bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19c2:	8b 40 04             	mov    0x4(%eax),%eax
    19c5:	01 c2                	add    %eax,%edx
    19c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ca:	89 50 04             	mov    %edx,0x4(%eax)
    19cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19d0:	8b 10                	mov    (%eax),%edx
    19d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d5:	89 10                	mov    %edx,(%eax)
    19d7:	eb 08                	jmp    19e1 <free+0xcd>
    19d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19df:	89 10                	mov    %edx,(%eax)
    19e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e4:	a3 c8 21 00 00       	mov    %eax,0x21c8
    19e9:	c9                   	leave  
    19ea:	c3                   	ret    

000019eb <morecore>:
    19eb:	55                   	push   %ebp
    19ec:	89 e5                	mov    %esp,%ebp
    19ee:	83 ec 28             	sub    $0x28,%esp
    19f1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19f8:	77 07                	ja     1a01 <morecore+0x16>
    19fa:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	c1 e0 03             	shl    $0x3,%eax
    1a07:	89 04 24             	mov    %eax,(%esp)
    1a0a:	e8 39 fc ff ff       	call   1648 <sbrk>
    1a0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a12:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a16:	75 07                	jne    1a1f <morecore+0x34>
    1a18:	b8 00 00 00 00       	mov    $0x0,%eax
    1a1d:	eb 22                	jmp    1a41 <morecore+0x56>
    1a1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a22:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a28:	8b 55 08             	mov    0x8(%ebp),%edx
    1a2b:	89 50 04             	mov    %edx,0x4(%eax)
    1a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a31:	83 c0 08             	add    $0x8,%eax
    1a34:	89 04 24             	mov    %eax,(%esp)
    1a37:	e8 d8 fe ff ff       	call   1914 <free>
    1a3c:	a1 c8 21 00 00       	mov    0x21c8,%eax
    1a41:	c9                   	leave  
    1a42:	c3                   	ret    

00001a43 <malloc>:
    1a43:	55                   	push   %ebp
    1a44:	89 e5                	mov    %esp,%ebp
    1a46:	83 ec 28             	sub    $0x28,%esp
    1a49:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4c:	83 c0 07             	add    $0x7,%eax
    1a4f:	c1 e8 03             	shr    $0x3,%eax
    1a52:	83 c0 01             	add    $0x1,%eax
    1a55:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a58:	a1 c8 21 00 00       	mov    0x21c8,%eax
    1a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a60:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a64:	75 23                	jne    1a89 <malloc+0x46>
    1a66:	c7 45 f0 c0 21 00 00 	movl   $0x21c0,-0x10(%ebp)
    1a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a70:	a3 c8 21 00 00       	mov    %eax,0x21c8
    1a75:	a1 c8 21 00 00       	mov    0x21c8,%eax
    1a7a:	a3 c0 21 00 00       	mov    %eax,0x21c0
    1a7f:	c7 05 c4 21 00 00 00 	movl   $0x0,0x21c4
    1a86:	00 00 00 
    1a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a8c:	8b 00                	mov    (%eax),%eax
    1a8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a91:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a94:	8b 40 04             	mov    0x4(%eax),%eax
    1a97:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a9a:	72 4d                	jb     1ae9 <malloc+0xa6>
    1a9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a9f:	8b 40 04             	mov    0x4(%eax),%eax
    1aa2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1aa5:	75 0c                	jne    1ab3 <malloc+0x70>
    1aa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aaa:	8b 10                	mov    (%eax),%edx
    1aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aaf:	89 10                	mov    %edx,(%eax)
    1ab1:	eb 26                	jmp    1ad9 <malloc+0x96>
    1ab3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ab6:	8b 40 04             	mov    0x4(%eax),%eax
    1ab9:	89 c2                	mov    %eax,%edx
    1abb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1abe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ac1:	89 50 04             	mov    %edx,0x4(%eax)
    1ac4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ac7:	8b 40 04             	mov    0x4(%eax),%eax
    1aca:	c1 e0 03             	shl    $0x3,%eax
    1acd:	01 45 ec             	add    %eax,-0x14(%ebp)
    1ad0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ad3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ad6:	89 50 04             	mov    %edx,0x4(%eax)
    1ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1adc:	a3 c8 21 00 00       	mov    %eax,0x21c8
    1ae1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae4:	83 c0 08             	add    $0x8,%eax
    1ae7:	eb 38                	jmp    1b21 <malloc+0xde>
    1ae9:	a1 c8 21 00 00       	mov    0x21c8,%eax
    1aee:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1af1:	75 1b                	jne    1b0e <malloc+0xcb>
    1af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af6:	89 04 24             	mov    %eax,(%esp)
    1af9:	e8 ed fe ff ff       	call   19eb <morecore>
    1afe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b01:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b05:	75 07                	jne    1b0e <malloc+0xcb>
    1b07:	b8 00 00 00 00       	mov    $0x0,%eax
    1b0c:	eb 13                	jmp    1b21 <malloc+0xde>
    1b0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b11:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b14:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b17:	8b 00                	mov    (%eax),%eax
    1b19:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b1c:	e9 70 ff ff ff       	jmp    1a91 <malloc+0x4e>
    1b21:	c9                   	leave  
    1b22:	c3                   	ret    
    1b23:	90                   	nop

00001b24 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b24:	55                   	push   %ebp
    1b25:	89 e5                	mov    %esp,%ebp
    1b27:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b2a:	8b 55 08             	mov    0x8(%ebp),%edx
    1b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b30:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b33:	f0 87 02             	lock xchg %eax,(%edx)
    1b36:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b39:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b3c:	c9                   	leave  
    1b3d:	c3                   	ret    

00001b3e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b3e:	55                   	push   %ebp
    1b3f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b41:	8b 45 08             	mov    0x8(%ebp),%eax
    1b44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1b4a:	5d                   	pop    %ebp
    1b4b:	c3                   	ret    

00001b4c <lock_acquire>:
void lock_acquire(lock_t *lock){
    1b4c:	55                   	push   %ebp
    1b4d:	89 e5                	mov    %esp,%ebp
    1b4f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1b52:	90                   	nop
    1b53:	8b 45 08             	mov    0x8(%ebp),%eax
    1b56:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b5d:	00 
    1b5e:	89 04 24             	mov    %eax,(%esp)
    1b61:	e8 be ff ff ff       	call   1b24 <xchg>
    1b66:	85 c0                	test   %eax,%eax
    1b68:	75 e9                	jne    1b53 <lock_acquire+0x7>
}
    1b6a:	c9                   	leave  
    1b6b:	c3                   	ret    

00001b6c <lock_release>:
void lock_release(lock_t *lock){
    1b6c:	55                   	push   %ebp
    1b6d:	89 e5                	mov    %esp,%ebp
    1b6f:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1b72:	8b 45 08             	mov    0x8(%ebp),%eax
    1b75:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b7c:	00 
    1b7d:	89 04 24             	mov    %eax,(%esp)
    1b80:	e8 9f ff ff ff       	call   1b24 <xchg>
}
    1b85:	c9                   	leave  
    1b86:	c3                   	ret    

00001b87 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1b87:	55                   	push   %ebp
    1b88:	89 e5                	mov    %esp,%ebp
    1b8a:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1b8d:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1b94:	e8 aa fe ff ff       	call   1a43 <malloc>
    1b99:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba5:	25 ff 0f 00 00       	and    $0xfff,%eax
    1baa:	85 c0                	test   %eax,%eax
    1bac:	74 14                	je     1bc2 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb1:	25 ff 0f 00 00       	and    $0xfff,%eax
    1bb6:	89 c2                	mov    %eax,%edx
    1bb8:	b8 00 10 00 00       	mov    $0x1000,%eax
    1bbd:	29 d0                	sub    %edx,%eax
    1bbf:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1bc2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bc6:	75 1b                	jne    1be3 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1bc8:	c7 44 24 04 d5 1d 00 	movl   $0x1dd5,0x4(%esp)
    1bcf:	00 
    1bd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bd7:	e8 84 fb ff ff       	call   1760 <printf>
        return 0;
    1bdc:	b8 00 00 00 00       	mov    $0x0,%eax
    1be1:	eb 6f                	jmp    1c52 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1be3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1be6:	8b 55 08             	mov    0x8(%ebp),%edx
    1be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bec:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1bf0:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bf4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1bfb:	00 
    1bfc:	89 04 24             	mov    %eax,(%esp)
    1bff:	e8 5c fa ff ff       	call   1660 <clone>
    1c04:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1c07:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c0b:	79 1b                	jns    1c28 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1c0d:	c7 44 24 04 e3 1d 00 	movl   $0x1de3,0x4(%esp)
    1c14:	00 
    1c15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c1c:	e8 3f fb ff ff       	call   1760 <printf>
        return 0;
    1c21:	b8 00 00 00 00       	mov    $0x0,%eax
    1c26:	eb 2a                	jmp    1c52 <thread_create+0xcb>
    }
    if(tid > 0){
    1c28:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c2c:	7e 05                	jle    1c33 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1c2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c31:	eb 1f                	jmp    1c52 <thread_create+0xcb>
    }
    if(tid == 0){
    1c33:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c37:	75 14                	jne    1c4d <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1c39:	c7 44 24 04 f0 1d 00 	movl   $0x1df0,0x4(%esp)
    1c40:	00 
    1c41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c48:	e8 13 fb ff ff       	call   1760 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1c4d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1c52:	c9                   	leave  
    1c53:	c3                   	ret    

00001c54 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1c54:	55                   	push   %ebp
    1c55:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1c57:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1c5c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1c62:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1c67:	a3 bc 21 00 00       	mov    %eax,0x21bc
    return (int)(rands % max);
    1c6c:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1c71:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c74:	ba 00 00 00 00       	mov    $0x0,%edx
    1c79:	f7 f1                	div    %ecx
    1c7b:	89 d0                	mov    %edx,%eax
}
    1c7d:	5d                   	pop    %ebp
    1c7e:	c3                   	ret    
    1c7f:	90                   	nop

00001c80 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1c80:	55                   	push   %ebp
    1c81:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1c83:	8b 45 08             	mov    0x8(%ebp),%eax
    1c86:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1c8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1c96:	8b 45 08             	mov    0x8(%ebp),%eax
    1c99:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1ca0:	5d                   	pop    %ebp
    1ca1:	c3                   	ret    

00001ca2 <add_q>:

void add_q(struct queue *q, int v){
    1ca2:	55                   	push   %ebp
    1ca3:	89 e5                	mov    %esp,%ebp
    1ca5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1ca8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1caf:	e8 8f fd ff ff       	call   1a43 <malloc>
    1cb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cba:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cc7:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1cc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccc:	8b 40 04             	mov    0x4(%eax),%eax
    1ccf:	85 c0                	test   %eax,%eax
    1cd1:	75 0b                	jne    1cde <add_q+0x3c>
        q->head = n;
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cd9:	89 50 04             	mov    %edx,0x4(%eax)
    1cdc:	eb 0c                	jmp    1cea <add_q+0x48>
    }else{
        q->tail->next = n;
    1cde:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce1:	8b 40 08             	mov    0x8(%eax),%eax
    1ce4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ce7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1cea:	8b 45 08             	mov    0x8(%ebp),%eax
    1ced:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cf0:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	8b 00                	mov    (%eax),%eax
    1cf8:	8d 50 01             	lea    0x1(%eax),%edx
    1cfb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfe:	89 10                	mov    %edx,(%eax)
}
    1d00:	c9                   	leave  
    1d01:	c3                   	ret    

00001d02 <empty_q>:

int empty_q(struct queue *q){
    1d02:	55                   	push   %ebp
    1d03:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1d05:	8b 45 08             	mov    0x8(%ebp),%eax
    1d08:	8b 00                	mov    (%eax),%eax
    1d0a:	85 c0                	test   %eax,%eax
    1d0c:	75 07                	jne    1d15 <empty_q+0x13>
        return 1;
    1d0e:	b8 01 00 00 00       	mov    $0x1,%eax
    1d13:	eb 05                	jmp    1d1a <empty_q+0x18>
    else
        return 0;
    1d15:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d1a:	5d                   	pop    %ebp
    1d1b:	c3                   	ret    

00001d1c <pop_q>:
int pop_q(struct queue *q){
    1d1c:	55                   	push   %ebp
    1d1d:	89 e5                	mov    %esp,%ebp
    1d1f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d22:	8b 45 08             	mov    0x8(%ebp),%eax
    1d25:	89 04 24             	mov    %eax,(%esp)
    1d28:	e8 d5 ff ff ff       	call   1d02 <empty_q>
    1d2d:	85 c0                	test   %eax,%eax
    1d2f:	75 5d                	jne    1d8e <pop_q+0x72>
       val = q->head->value; 
    1d31:	8b 45 08             	mov    0x8(%ebp),%eax
    1d34:	8b 40 04             	mov    0x4(%eax),%eax
    1d37:	8b 00                	mov    (%eax),%eax
    1d39:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1d3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3f:	8b 40 04             	mov    0x4(%eax),%eax
    1d42:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 40 04             	mov    0x4(%eax),%eax
    1d4b:	8b 50 04             	mov    0x4(%eax),%edx
    1d4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d51:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1d54:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d57:	89 04 24             	mov    %eax,(%esp)
    1d5a:	e8 b5 fb ff ff       	call   1914 <free>
       q->size--;
    1d5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d62:	8b 00                	mov    (%eax),%eax
    1d64:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d67:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1d6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6f:	8b 00                	mov    (%eax),%eax
    1d71:	85 c0                	test   %eax,%eax
    1d73:	75 14                	jne    1d89 <pop_q+0x6d>
            q->head = 0;
    1d75:	8b 45 08             	mov    0x8(%ebp),%eax
    1d78:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1d7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d82:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d8c:	eb 05                	jmp    1d93 <pop_q+0x77>
    }
    return -1;
    1d8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d93:	c9                   	leave  
    1d94:	c3                   	ret    
