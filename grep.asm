
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
    1006:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    100d:	e9 bf 00 00 00       	jmp    10d1 <grep+0xd1>
    m += n;
    1012:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1015:	01 45 ec             	add    %eax,-0x14(%ebp)
    p = buf;
    1018:	c7 45 f0 40 1e 00 00 	movl   $0x1e40,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
    101f:	eb 53                	jmp    1074 <grep+0x74>
      *q = 0;
    1021:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1024:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
    1027:	8b 45 f0             	mov    -0x10(%ebp),%eax
    102a:	89 44 24 04          	mov    %eax,0x4(%esp)
    102e:	8b 45 08             	mov    0x8(%ebp),%eax
    1031:	89 04 24             	mov    %eax,(%esp)
    1034:	e8 b1 01 00 00       	call   11ea <match>
    1039:	85 c0                	test   %eax,%eax
    103b:	74 2e                	je     106b <grep+0x6b>
        *q = '\n';
    103d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1040:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
    1043:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1046:	83 c0 01             	add    $0x1,%eax
    1049:	89 c2                	mov    %eax,%edx
    104b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    104e:	89 d1                	mov    %edx,%ecx
    1050:	29 c1                	sub    %eax,%ecx
    1052:	89 c8                	mov    %ecx,%eax
    1054:	89 44 24 08          	mov    %eax,0x8(%esp)
    1058:	8b 45 f0             	mov    -0x10(%ebp),%eax
    105b:	89 44 24 04          	mov    %eax,0x4(%esp)
    105f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1066:	e8 69 05 00 00       	call   15d4 <write>
      }
      p = q+1;
    106b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106e:	83 c0 01             	add    $0x1,%eax
    1071:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
    1074:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
    107b:	00 
    107c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    107f:	89 04 24             	mov    %eax,(%esp)
    1082:	e8 ab 03 00 00       	call   1432 <strchr>
    1087:	89 45 f4             	mov    %eax,-0xc(%ebp)
    108a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    108e:	75 91                	jne    1021 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
    1090:	81 7d f0 40 1e 00 00 	cmpl   $0x1e40,-0x10(%ebp)
    1097:	75 07                	jne    10a0 <grep+0xa0>
      m = 0;
    1099:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if(m > 0){
    10a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10a4:	7e 2b                	jle    10d1 <grep+0xd1>
      m -= p - buf;
    10a6:	ba 40 1e 00 00       	mov    $0x1e40,%edx
    10ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ae:	89 d1                	mov    %edx,%ecx
    10b0:	29 c1                	sub    %eax,%ecx
    10b2:	89 c8                	mov    %ecx,%eax
    10b4:	01 45 ec             	add    %eax,-0x14(%ebp)
      memmove(buf, p, m);
    10b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10ba:	89 44 24 08          	mov    %eax,0x8(%esp)
    10be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c1:	89 44 24 04          	mov    %eax,0x4(%esp)
    10c5:	c7 04 24 40 1e 00 00 	movl   $0x1e40,(%esp)
    10cc:	e8 9d 04 00 00       	call   156e <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    10d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d4:	ba 00 04 00 00       	mov    $0x400,%edx
    10d9:	89 d1                	mov    %edx,%ecx
    10db:	29 c1                	sub    %eax,%ecx
    10dd:	89 c8                	mov    %ecx,%eax
    10df:	8b 55 ec             	mov    -0x14(%ebp),%edx
    10e2:	81 c2 40 1e 00 00    	add    $0x1e40,%edx
    10e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ec:	89 54 24 04          	mov    %edx,0x4(%esp)
    10f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f3:	89 04 24             	mov    %eax,(%esp)
    10f6:	e8 d1 04 00 00       	call   15cc <read>
    10fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    10fe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1102:	0f 8f 0a ff ff ff    	jg     1012 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
    1108:	c9                   	leave  
    1109:	c3                   	ret    

0000110a <main>:

int
main(int argc, char *argv[])
{
    110a:	55                   	push   %ebp
    110b:	89 e5                	mov    %esp,%ebp
    110d:	83 e4 f0             	and    $0xfffffff0,%esp
    1110:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
    1113:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1117:	7f 19                	jg     1132 <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
    1119:	c7 44 24 04 90 1d 00 	movl   $0x1d90,0x4(%esp)
    1120:	00 
    1121:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1128:	e8 28 06 00 00       	call   1755 <printf>
    exit();
    112d:	e8 82 04 00 00       	call   15b4 <exit>
  }
  pattern = argv[1];
    1132:	8b 45 0c             	mov    0xc(%ebp),%eax
    1135:	83 c0 04             	add    $0x4,%eax
    1138:	8b 00                	mov    (%eax),%eax
    113a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  
  if(argc <= 2){
    113e:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    1142:	7f 19                	jg     115d <main+0x53>
    grep(pattern, 0);
    1144:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    114b:	00 
    114c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1150:	89 04 24             	mov    %eax,(%esp)
    1153:	e8 a8 fe ff ff       	call   1000 <grep>
    exit();
    1158:	e8 57 04 00 00       	call   15b4 <exit>
  }

  for(i = 2; i < argc; i++){
    115d:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    1164:	00 
    1165:	eb 75                	jmp    11dc <main+0xd2>
    if((fd = open(argv[i], 0)) < 0){
    1167:	8b 44 24 18          	mov    0x18(%esp),%eax
    116b:	c1 e0 02             	shl    $0x2,%eax
    116e:	03 45 0c             	add    0xc(%ebp),%eax
    1171:	8b 00                	mov    (%eax),%eax
    1173:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    117a:	00 
    117b:	89 04 24             	mov    %eax,(%esp)
    117e:	e8 71 04 00 00       	call   15f4 <open>
    1183:	89 44 24 14          	mov    %eax,0x14(%esp)
    1187:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    118c:	79 29                	jns    11b7 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
    118e:	8b 44 24 18          	mov    0x18(%esp),%eax
    1192:	c1 e0 02             	shl    $0x2,%eax
    1195:	03 45 0c             	add    0xc(%ebp),%eax
    1198:	8b 00                	mov    (%eax),%eax
    119a:	89 44 24 08          	mov    %eax,0x8(%esp)
    119e:	c7 44 24 04 b0 1d 00 	movl   $0x1db0,0x4(%esp)
    11a5:	00 
    11a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11ad:	e8 a3 05 00 00       	call   1755 <printf>
      exit();
    11b2:	e8 fd 03 00 00       	call   15b4 <exit>
    }
    grep(pattern, fd);
    11b7:	8b 44 24 14          	mov    0x14(%esp),%eax
    11bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    11bf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    11c3:	89 04 24             	mov    %eax,(%esp)
    11c6:	e8 35 fe ff ff       	call   1000 <grep>
    close(fd);
    11cb:	8b 44 24 14          	mov    0x14(%esp),%eax
    11cf:	89 04 24             	mov    %eax,(%esp)
    11d2:	e8 05 04 00 00       	call   15dc <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    11d7:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
    11dc:	8b 44 24 18          	mov    0x18(%esp),%eax
    11e0:	3b 45 08             	cmp    0x8(%ebp),%eax
    11e3:	7c 82                	jl     1167 <main+0x5d>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
    11e5:	e8 ca 03 00 00       	call   15b4 <exit>

000011ea <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    11ea:	55                   	push   %ebp
    11eb:	89 e5                	mov    %esp,%ebp
    11ed:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	0f b6 00             	movzbl (%eax),%eax
    11f6:	3c 5e                	cmp    $0x5e,%al
    11f8:	75 17                	jne    1211 <match+0x27>
    return matchhere(re+1, text);
    11fa:	8b 45 08             	mov    0x8(%ebp),%eax
    11fd:	8d 50 01             	lea    0x1(%eax),%edx
    1200:	8b 45 0c             	mov    0xc(%ebp),%eax
    1203:	89 44 24 04          	mov    %eax,0x4(%esp)
    1207:	89 14 24             	mov    %edx,(%esp)
    120a:	e8 39 00 00 00       	call   1248 <matchhere>
    120f:	eb 35                	jmp    1246 <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
    1211:	8b 45 0c             	mov    0xc(%ebp),%eax
    1214:	89 44 24 04          	mov    %eax,0x4(%esp)
    1218:	8b 45 08             	mov    0x8(%ebp),%eax
    121b:	89 04 24             	mov    %eax,(%esp)
    121e:	e8 25 00 00 00       	call   1248 <matchhere>
    1223:	85 c0                	test   %eax,%eax
    1225:	74 07                	je     122e <match+0x44>
      return 1;
    1227:	b8 01 00 00 00       	mov    $0x1,%eax
    122c:	eb 18                	jmp    1246 <match+0x5c>
  }while(*text++ != '\0');
    122e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1231:	0f b6 00             	movzbl (%eax),%eax
    1234:	84 c0                	test   %al,%al
    1236:	0f 95 c0             	setne  %al
    1239:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    123d:	84 c0                	test   %al,%al
    123f:	75 d0                	jne    1211 <match+0x27>
  return 0;
    1241:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1246:	c9                   	leave  
    1247:	c3                   	ret    

00001248 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1248:	55                   	push   %ebp
    1249:	89 e5                	mov    %esp,%ebp
    124b:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
    124e:	8b 45 08             	mov    0x8(%ebp),%eax
    1251:	0f b6 00             	movzbl (%eax),%eax
    1254:	84 c0                	test   %al,%al
    1256:	75 0a                	jne    1262 <matchhere+0x1a>
    return 1;
    1258:	b8 01 00 00 00       	mov    $0x1,%eax
    125d:	e9 9b 00 00 00       	jmp    12fd <matchhere+0xb5>
  if(re[1] == '*')
    1262:	8b 45 08             	mov    0x8(%ebp),%eax
    1265:	83 c0 01             	add    $0x1,%eax
    1268:	0f b6 00             	movzbl (%eax),%eax
    126b:	3c 2a                	cmp    $0x2a,%al
    126d:	75 24                	jne    1293 <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
    126f:	8b 45 08             	mov    0x8(%ebp),%eax
    1272:	8d 48 02             	lea    0x2(%eax),%ecx
    1275:	8b 45 08             	mov    0x8(%ebp),%eax
    1278:	0f b6 00             	movzbl (%eax),%eax
    127b:	0f be c0             	movsbl %al,%eax
    127e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1281:	89 54 24 08          	mov    %edx,0x8(%esp)
    1285:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1289:	89 04 24             	mov    %eax,(%esp)
    128c:	e8 6e 00 00 00       	call   12ff <matchstar>
    1291:	eb 6a                	jmp    12fd <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	0f b6 00             	movzbl (%eax),%eax
    1299:	3c 24                	cmp    $0x24,%al
    129b:	75 1d                	jne    12ba <matchhere+0x72>
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
    12a0:	83 c0 01             	add    $0x1,%eax
    12a3:	0f b6 00             	movzbl (%eax),%eax
    12a6:	84 c0                	test   %al,%al
    12a8:	75 10                	jne    12ba <matchhere+0x72>
    return *text == '\0';
    12aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ad:	0f b6 00             	movzbl (%eax),%eax
    12b0:	84 c0                	test   %al,%al
    12b2:	0f 94 c0             	sete   %al
    12b5:	0f b6 c0             	movzbl %al,%eax
    12b8:	eb 43                	jmp    12fd <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    12ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    12bd:	0f b6 00             	movzbl (%eax),%eax
    12c0:	84 c0                	test   %al,%al
    12c2:	74 34                	je     12f8 <matchhere+0xb0>
    12c4:	8b 45 08             	mov    0x8(%ebp),%eax
    12c7:	0f b6 00             	movzbl (%eax),%eax
    12ca:	3c 2e                	cmp    $0x2e,%al
    12cc:	74 10                	je     12de <matchhere+0x96>
    12ce:	8b 45 08             	mov    0x8(%ebp),%eax
    12d1:	0f b6 10             	movzbl (%eax),%edx
    12d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d7:	0f b6 00             	movzbl (%eax),%eax
    12da:	38 c2                	cmp    %al,%dl
    12dc:	75 1a                	jne    12f8 <matchhere+0xb0>
    return matchhere(re+1, text+1);
    12de:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e1:	8d 50 01             	lea    0x1(%eax),%edx
    12e4:	8b 45 08             	mov    0x8(%ebp),%eax
    12e7:	83 c0 01             	add    $0x1,%eax
    12ea:	89 54 24 04          	mov    %edx,0x4(%esp)
    12ee:	89 04 24             	mov    %eax,(%esp)
    12f1:	e8 52 ff ff ff       	call   1248 <matchhere>
    12f6:	eb 05                	jmp    12fd <matchhere+0xb5>
  return 0;
    12f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12fd:	c9                   	leave  
    12fe:	c3                   	ret    

000012ff <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    12ff:	55                   	push   %ebp
    1300:	89 e5                	mov    %esp,%ebp
    1302:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    1305:	8b 45 10             	mov    0x10(%ebp),%eax
    1308:	89 44 24 04          	mov    %eax,0x4(%esp)
    130c:	8b 45 0c             	mov    0xc(%ebp),%eax
    130f:	89 04 24             	mov    %eax,(%esp)
    1312:	e8 31 ff ff ff       	call   1248 <matchhere>
    1317:	85 c0                	test   %eax,%eax
    1319:	74 07                	je     1322 <matchstar+0x23>
      return 1;
    131b:	b8 01 00 00 00       	mov    $0x1,%eax
    1320:	eb 2c                	jmp    134e <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
    1322:	8b 45 10             	mov    0x10(%ebp),%eax
    1325:	0f b6 00             	movzbl (%eax),%eax
    1328:	84 c0                	test   %al,%al
    132a:	74 1d                	je     1349 <matchstar+0x4a>
    132c:	8b 45 10             	mov    0x10(%ebp),%eax
    132f:	0f b6 00             	movzbl (%eax),%eax
    1332:	0f be c0             	movsbl %al,%eax
    1335:	3b 45 08             	cmp    0x8(%ebp),%eax
    1338:	0f 94 c0             	sete   %al
    133b:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    133f:	84 c0                	test   %al,%al
    1341:	75 c2                	jne    1305 <matchstar+0x6>
    1343:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
    1347:	74 bc                	je     1305 <matchstar+0x6>
  return 0;
    1349:	b8 00 00 00 00       	mov    $0x0,%eax
}
    134e:	c9                   	leave  
    134f:	c3                   	ret    

00001350 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	57                   	push   %edi
    1354:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1355:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1358:	8b 55 10             	mov    0x10(%ebp),%edx
    135b:	8b 45 0c             	mov    0xc(%ebp),%eax
    135e:	89 cb                	mov    %ecx,%ebx
    1360:	89 df                	mov    %ebx,%edi
    1362:	89 d1                	mov    %edx,%ecx
    1364:	fc                   	cld    
    1365:	f3 aa                	rep stos %al,%es:(%edi)
    1367:	89 ca                	mov    %ecx,%edx
    1369:	89 fb                	mov    %edi,%ebx
    136b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    136e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1371:	5b                   	pop    %ebx
    1372:	5f                   	pop    %edi
    1373:	5d                   	pop    %ebp
    1374:	c3                   	ret    

00001375 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1375:	55                   	push   %ebp
    1376:	89 e5                	mov    %esp,%ebp
    1378:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
    137e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1381:	8b 45 0c             	mov    0xc(%ebp),%eax
    1384:	0f b6 10             	movzbl (%eax),%edx
    1387:	8b 45 08             	mov    0x8(%ebp),%eax
    138a:	88 10                	mov    %dl,(%eax)
    138c:	8b 45 08             	mov    0x8(%ebp),%eax
    138f:	0f b6 00             	movzbl (%eax),%eax
    1392:	84 c0                	test   %al,%al
    1394:	0f 95 c0             	setne  %al
    1397:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    139b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    139f:	84 c0                	test   %al,%al
    13a1:	75 de                	jne    1381 <strcpy+0xc>
    ;
  return os;
    13a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13a6:	c9                   	leave  
    13a7:	c3                   	ret    

000013a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13a8:	55                   	push   %ebp
    13a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13ab:	eb 08                	jmp    13b5 <strcmp+0xd>
    p++, q++;
    13ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13b5:	8b 45 08             	mov    0x8(%ebp),%eax
    13b8:	0f b6 00             	movzbl (%eax),%eax
    13bb:	84 c0                	test   %al,%al
    13bd:	74 10                	je     13cf <strcmp+0x27>
    13bf:	8b 45 08             	mov    0x8(%ebp),%eax
    13c2:	0f b6 10             	movzbl (%eax),%edx
    13c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c8:	0f b6 00             	movzbl (%eax),%eax
    13cb:	38 c2                	cmp    %al,%dl
    13cd:	74 de                	je     13ad <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	0f b6 00             	movzbl (%eax),%eax
    13d5:	0f b6 d0             	movzbl %al,%edx
    13d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13db:	0f b6 00             	movzbl (%eax),%eax
    13de:	0f b6 c0             	movzbl %al,%eax
    13e1:	89 d1                	mov    %edx,%ecx
    13e3:	29 c1                	sub    %eax,%ecx
    13e5:	89 c8                	mov    %ecx,%eax
}
    13e7:	5d                   	pop    %ebp
    13e8:	c3                   	ret    

000013e9 <strlen>:

uint
strlen(char *s)
{
    13e9:	55                   	push   %ebp
    13ea:	89 e5                	mov    %esp,%ebp
    13ec:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13f6:	eb 04                	jmp    13fc <strlen+0x13>
    13f8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ff:	03 45 08             	add    0x8(%ebp),%eax
    1402:	0f b6 00             	movzbl (%eax),%eax
    1405:	84 c0                	test   %al,%al
    1407:	75 ef                	jne    13f8 <strlen+0xf>
    ;
  return n;
    1409:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    140c:	c9                   	leave  
    140d:	c3                   	ret    

0000140e <memset>:

void*
memset(void *dst, int c, uint n)
{
    140e:	55                   	push   %ebp
    140f:	89 e5                	mov    %esp,%ebp
    1411:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1414:	8b 45 10             	mov    0x10(%ebp),%eax
    1417:	89 44 24 08          	mov    %eax,0x8(%esp)
    141b:	8b 45 0c             	mov    0xc(%ebp),%eax
    141e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	89 04 24             	mov    %eax,(%esp)
    1428:	e8 23 ff ff ff       	call   1350 <stosb>
  return dst;
    142d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1430:	c9                   	leave  
    1431:	c3                   	ret    

00001432 <strchr>:

char*
strchr(const char *s, char c)
{
    1432:	55                   	push   %ebp
    1433:	89 e5                	mov    %esp,%ebp
    1435:	83 ec 04             	sub    $0x4,%esp
    1438:	8b 45 0c             	mov    0xc(%ebp),%eax
    143b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    143e:	eb 14                	jmp    1454 <strchr+0x22>
    if(*s == c)
    1440:	8b 45 08             	mov    0x8(%ebp),%eax
    1443:	0f b6 00             	movzbl (%eax),%eax
    1446:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1449:	75 05                	jne    1450 <strchr+0x1e>
      return (char*)s;
    144b:	8b 45 08             	mov    0x8(%ebp),%eax
    144e:	eb 13                	jmp    1463 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1450:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	0f b6 00             	movzbl (%eax),%eax
    145a:	84 c0                	test   %al,%al
    145c:	75 e2                	jne    1440 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    145e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1463:	c9                   	leave  
    1464:	c3                   	ret    

00001465 <gets>:

char*
gets(char *buf, int max)
{
    1465:	55                   	push   %ebp
    1466:	89 e5                	mov    %esp,%ebp
    1468:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    146b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1472:	eb 44                	jmp    14b8 <gets+0x53>
    cc = read(0, &c, 1);
    1474:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    147b:	00 
    147c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    147f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1483:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    148a:	e8 3d 01 00 00       	call   15cc <read>
    148f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1492:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1496:	7e 2d                	jle    14c5 <gets+0x60>
      break;
    buf[i++] = c;
    1498:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149b:	03 45 08             	add    0x8(%ebp),%eax
    149e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    14a2:	88 10                	mov    %dl,(%eax)
    14a4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    14a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14ac:	3c 0a                	cmp    $0xa,%al
    14ae:	74 16                	je     14c6 <gets+0x61>
    14b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b4:	3c 0d                	cmp    $0xd,%al
    14b6:	74 0e                	je     14c6 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14bb:	83 c0 01             	add    $0x1,%eax
    14be:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14c1:	7c b1                	jl     1474 <gets+0xf>
    14c3:	eb 01                	jmp    14c6 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    14c5:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    14c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c9:	03 45 08             	add    0x8(%ebp),%eax
    14cc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    14cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14d2:	c9                   	leave  
    14d3:	c3                   	ret    

000014d4 <stat>:

int
stat(char *n, struct stat *st)
{
    14d4:	55                   	push   %ebp
    14d5:	89 e5                	mov    %esp,%ebp
    14d7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14da:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14e1:	00 
    14e2:	8b 45 08             	mov    0x8(%ebp),%eax
    14e5:	89 04 24             	mov    %eax,(%esp)
    14e8:	e8 07 01 00 00       	call   15f4 <open>
    14ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    14f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14f4:	79 07                	jns    14fd <stat+0x29>
    return -1;
    14f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14fb:	eb 23                	jmp    1520 <stat+0x4c>
  r = fstat(fd, st);
    14fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1500:	89 44 24 04          	mov    %eax,0x4(%esp)
    1504:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1507:	89 04 24             	mov    %eax,(%esp)
    150a:	e8 fd 00 00 00       	call   160c <fstat>
    150f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1512:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1515:	89 04 24             	mov    %eax,(%esp)
    1518:	e8 bf 00 00 00       	call   15dc <close>
  return r;
    151d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1520:	c9                   	leave  
    1521:	c3                   	ret    

00001522 <atoi>:

int
atoi(const char *s)
{
    1522:	55                   	push   %ebp
    1523:	89 e5                	mov    %esp,%ebp
    1525:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1528:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    152f:	eb 24                	jmp    1555 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1531:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1534:	89 d0                	mov    %edx,%eax
    1536:	c1 e0 02             	shl    $0x2,%eax
    1539:	01 d0                	add    %edx,%eax
    153b:	01 c0                	add    %eax,%eax
    153d:	89 c2                	mov    %eax,%edx
    153f:	8b 45 08             	mov    0x8(%ebp),%eax
    1542:	0f b6 00             	movzbl (%eax),%eax
    1545:	0f be c0             	movsbl %al,%eax
    1548:	8d 04 02             	lea    (%edx,%eax,1),%eax
    154b:	83 e8 30             	sub    $0x30,%eax
    154e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1551:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1555:	8b 45 08             	mov    0x8(%ebp),%eax
    1558:	0f b6 00             	movzbl (%eax),%eax
    155b:	3c 2f                	cmp    $0x2f,%al
    155d:	7e 0a                	jle    1569 <atoi+0x47>
    155f:	8b 45 08             	mov    0x8(%ebp),%eax
    1562:	0f b6 00             	movzbl (%eax),%eax
    1565:	3c 39                	cmp    $0x39,%al
    1567:	7e c8                	jle    1531 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1569:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    156c:	c9                   	leave  
    156d:	c3                   	ret    

0000156e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    156e:	55                   	push   %ebp
    156f:	89 e5                	mov    %esp,%ebp
    1571:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1574:	8b 45 08             	mov    0x8(%ebp),%eax
    1577:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    157a:	8b 45 0c             	mov    0xc(%ebp),%eax
    157d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1580:	eb 13                	jmp    1595 <memmove+0x27>
    *dst++ = *src++;
    1582:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1585:	0f b6 10             	movzbl (%eax),%edx
    1588:	8b 45 f8             	mov    -0x8(%ebp),%eax
    158b:	88 10                	mov    %dl,(%eax)
    158d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1591:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1595:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1599:	0f 9f c0             	setg   %al
    159c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    15a0:	84 c0                	test   %al,%al
    15a2:	75 de                	jne    1582 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    15a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15a7:	c9                   	leave  
    15a8:	c3                   	ret    
    15a9:	90                   	nop
    15aa:	90                   	nop
    15ab:	90                   	nop

000015ac <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    15ac:	b8 01 00 00 00       	mov    $0x1,%eax
    15b1:	cd 40                	int    $0x40
    15b3:	c3                   	ret    

000015b4 <exit>:
SYSCALL(exit)
    15b4:	b8 02 00 00 00       	mov    $0x2,%eax
    15b9:	cd 40                	int    $0x40
    15bb:	c3                   	ret    

000015bc <wait>:
SYSCALL(wait)
    15bc:	b8 03 00 00 00       	mov    $0x3,%eax
    15c1:	cd 40                	int    $0x40
    15c3:	c3                   	ret    

000015c4 <pipe>:
SYSCALL(pipe)
    15c4:	b8 04 00 00 00       	mov    $0x4,%eax
    15c9:	cd 40                	int    $0x40
    15cb:	c3                   	ret    

000015cc <read>:
SYSCALL(read)
    15cc:	b8 05 00 00 00       	mov    $0x5,%eax
    15d1:	cd 40                	int    $0x40
    15d3:	c3                   	ret    

000015d4 <write>:
SYSCALL(write)
    15d4:	b8 10 00 00 00       	mov    $0x10,%eax
    15d9:	cd 40                	int    $0x40
    15db:	c3                   	ret    

000015dc <close>:
SYSCALL(close)
    15dc:	b8 15 00 00 00       	mov    $0x15,%eax
    15e1:	cd 40                	int    $0x40
    15e3:	c3                   	ret    

000015e4 <kill>:
SYSCALL(kill)
    15e4:	b8 06 00 00 00       	mov    $0x6,%eax
    15e9:	cd 40                	int    $0x40
    15eb:	c3                   	ret    

000015ec <exec>:
SYSCALL(exec)
    15ec:	b8 07 00 00 00       	mov    $0x7,%eax
    15f1:	cd 40                	int    $0x40
    15f3:	c3                   	ret    

000015f4 <open>:
SYSCALL(open)
    15f4:	b8 0f 00 00 00       	mov    $0xf,%eax
    15f9:	cd 40                	int    $0x40
    15fb:	c3                   	ret    

000015fc <mknod>:
SYSCALL(mknod)
    15fc:	b8 11 00 00 00       	mov    $0x11,%eax
    1601:	cd 40                	int    $0x40
    1603:	c3                   	ret    

00001604 <unlink>:
SYSCALL(unlink)
    1604:	b8 12 00 00 00       	mov    $0x12,%eax
    1609:	cd 40                	int    $0x40
    160b:	c3                   	ret    

0000160c <fstat>:
SYSCALL(fstat)
    160c:	b8 08 00 00 00       	mov    $0x8,%eax
    1611:	cd 40                	int    $0x40
    1613:	c3                   	ret    

00001614 <link>:
SYSCALL(link)
    1614:	b8 13 00 00 00       	mov    $0x13,%eax
    1619:	cd 40                	int    $0x40
    161b:	c3                   	ret    

0000161c <mkdir>:
SYSCALL(mkdir)
    161c:	b8 14 00 00 00       	mov    $0x14,%eax
    1621:	cd 40                	int    $0x40
    1623:	c3                   	ret    

00001624 <chdir>:
SYSCALL(chdir)
    1624:	b8 09 00 00 00       	mov    $0x9,%eax
    1629:	cd 40                	int    $0x40
    162b:	c3                   	ret    

0000162c <dup>:
SYSCALL(dup)
    162c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1631:	cd 40                	int    $0x40
    1633:	c3                   	ret    

00001634 <getpid>:
SYSCALL(getpid)
    1634:	b8 0b 00 00 00       	mov    $0xb,%eax
    1639:	cd 40                	int    $0x40
    163b:	c3                   	ret    

0000163c <sbrk>:
SYSCALL(sbrk)
    163c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1641:	cd 40                	int    $0x40
    1643:	c3                   	ret    

00001644 <sleep>:
SYSCALL(sleep)
    1644:	b8 0d 00 00 00       	mov    $0xd,%eax
    1649:	cd 40                	int    $0x40
    164b:	c3                   	ret    

0000164c <uptime>:
SYSCALL(uptime)
    164c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1651:	cd 40                	int    $0x40
    1653:	c3                   	ret    

00001654 <clone>:
SYSCALL(clone)
    1654:	b8 16 00 00 00       	mov    $0x16,%eax
    1659:	cd 40                	int    $0x40
    165b:	c3                   	ret    

0000165c <texit>:
SYSCALL(texit)
    165c:	b8 17 00 00 00       	mov    $0x17,%eax
    1661:	cd 40                	int    $0x40
    1663:	c3                   	ret    

00001664 <tsleep>:
SYSCALL(tsleep)
    1664:	b8 18 00 00 00       	mov    $0x18,%eax
    1669:	cd 40                	int    $0x40
    166b:	c3                   	ret    

0000166c <twakeup>:
SYSCALL(twakeup)
    166c:	b8 19 00 00 00       	mov    $0x19,%eax
    1671:	cd 40                	int    $0x40
    1673:	c3                   	ret    

00001674 <thread_yield>:
SYSCALL(thread_yield)
    1674:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1679:	cd 40                	int    $0x40
    167b:	c3                   	ret    

0000167c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    167c:	55                   	push   %ebp
    167d:	89 e5                	mov    %esp,%ebp
    167f:	83 ec 28             	sub    $0x28,%esp
    1682:	8b 45 0c             	mov    0xc(%ebp),%eax
    1685:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1688:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    168f:	00 
    1690:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1693:	89 44 24 04          	mov    %eax,0x4(%esp)
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	89 04 24             	mov    %eax,(%esp)
    169d:	e8 32 ff ff ff       	call   15d4 <write>
}
    16a2:	c9                   	leave  
    16a3:	c3                   	ret    

000016a4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16a4:	55                   	push   %ebp
    16a5:	89 e5                	mov    %esp,%ebp
    16a7:	53                   	push   %ebx
    16a8:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16b2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16b6:	74 17                	je     16cf <printint+0x2b>
    16b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16bc:	79 11                	jns    16cf <printint+0x2b>
    neg = 1;
    16be:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    16c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    16c8:	f7 d8                	neg    %eax
    16ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    16cd:	eb 06                	jmp    16d5 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    16cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    16d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    16dc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    16df:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e5:	ba 00 00 00 00       	mov    $0x0,%edx
    16ea:	f7 f3                	div    %ebx
    16ec:	89 d0                	mov    %edx,%eax
    16ee:	0f b6 80 fc 1d 00 00 	movzbl 0x1dfc(%eax),%eax
    16f5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    16f9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    16fd:	8b 45 10             	mov    0x10(%ebp),%eax
    1700:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1703:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1706:	ba 00 00 00 00       	mov    $0x0,%edx
    170b:	f7 75 d4             	divl   -0x2c(%ebp)
    170e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1711:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1715:	75 c5                	jne    16dc <printint+0x38>
  if(neg)
    1717:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    171b:	74 28                	je     1745 <printint+0xa1>
    buf[i++] = '-';
    171d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1720:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1725:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1729:	eb 1a                	jmp    1745 <printint+0xa1>
    putc(fd, buf[i]);
    172b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    172e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1733:	0f be c0             	movsbl %al,%eax
    1736:	89 44 24 04          	mov    %eax,0x4(%esp)
    173a:	8b 45 08             	mov    0x8(%ebp),%eax
    173d:	89 04 24             	mov    %eax,(%esp)
    1740:	e8 37 ff ff ff       	call   167c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1745:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1749:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    174d:	79 dc                	jns    172b <printint+0x87>
    putc(fd, buf[i]);
}
    174f:	83 c4 44             	add    $0x44,%esp
    1752:	5b                   	pop    %ebx
    1753:	5d                   	pop    %ebp
    1754:	c3                   	ret    

00001755 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1755:	55                   	push   %ebp
    1756:	89 e5                	mov    %esp,%ebp
    1758:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    175b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1762:	8d 45 0c             	lea    0xc(%ebp),%eax
    1765:	83 c0 04             	add    $0x4,%eax
    1768:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    176b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1772:	e9 7e 01 00 00       	jmp    18f5 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1777:	8b 55 0c             	mov    0xc(%ebp),%edx
    177a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    177d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1780:	0f b6 00             	movzbl (%eax),%eax
    1783:	0f be c0             	movsbl %al,%eax
    1786:	25 ff 00 00 00       	and    $0xff,%eax
    178b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    178e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1792:	75 2c                	jne    17c0 <printf+0x6b>
      if(c == '%'){
    1794:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1798:	75 0c                	jne    17a6 <printf+0x51>
        state = '%';
    179a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    17a1:	e9 4b 01 00 00       	jmp    18f1 <printf+0x19c>
      } else {
        putc(fd, c);
    17a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17a9:	0f be c0             	movsbl %al,%eax
    17ac:	89 44 24 04          	mov    %eax,0x4(%esp)
    17b0:	8b 45 08             	mov    0x8(%ebp),%eax
    17b3:	89 04 24             	mov    %eax,(%esp)
    17b6:	e8 c1 fe ff ff       	call   167c <putc>
    17bb:	e9 31 01 00 00       	jmp    18f1 <printf+0x19c>
      }
    } else if(state == '%'){
    17c0:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    17c4:	0f 85 27 01 00 00    	jne    18f1 <printf+0x19c>
      if(c == 'd'){
    17ca:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    17ce:	75 2d                	jne    17fd <printf+0xa8>
        printint(fd, *ap, 10, 1);
    17d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d3:	8b 00                	mov    (%eax),%eax
    17d5:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    17dc:	00 
    17dd:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    17e4:	00 
    17e5:	89 44 24 04          	mov    %eax,0x4(%esp)
    17e9:	8b 45 08             	mov    0x8(%ebp),%eax
    17ec:	89 04 24             	mov    %eax,(%esp)
    17ef:	e8 b0 fe ff ff       	call   16a4 <printint>
        ap++;
    17f4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    17f8:	e9 ed 00 00 00       	jmp    18ea <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    17fd:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1801:	74 06                	je     1809 <printf+0xb4>
    1803:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1807:	75 2d                	jne    1836 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1809:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180c:	8b 00                	mov    (%eax),%eax
    180e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1815:	00 
    1816:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    181d:	00 
    181e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1822:	8b 45 08             	mov    0x8(%ebp),%eax
    1825:	89 04 24             	mov    %eax,(%esp)
    1828:	e8 77 fe ff ff       	call   16a4 <printint>
        ap++;
    182d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1831:	e9 b4 00 00 00       	jmp    18ea <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1836:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    183a:	75 46                	jne    1882 <printf+0x12d>
        s = (char*)*ap;
    183c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183f:	8b 00                	mov    (%eax),%eax
    1841:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1844:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1848:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    184c:	75 27                	jne    1875 <printf+0x120>
          s = "(null)";
    184e:	c7 45 e4 c6 1d 00 00 	movl   $0x1dc6,-0x1c(%ebp)
        while(*s != 0){
    1855:	eb 1f                	jmp    1876 <printf+0x121>
          putc(fd, *s);
    1857:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    185a:	0f b6 00             	movzbl (%eax),%eax
    185d:	0f be c0             	movsbl %al,%eax
    1860:	89 44 24 04          	mov    %eax,0x4(%esp)
    1864:	8b 45 08             	mov    0x8(%ebp),%eax
    1867:	89 04 24             	mov    %eax,(%esp)
    186a:	e8 0d fe ff ff       	call   167c <putc>
          s++;
    186f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1873:	eb 01                	jmp    1876 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1875:	90                   	nop
    1876:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1879:	0f b6 00             	movzbl (%eax),%eax
    187c:	84 c0                	test   %al,%al
    187e:	75 d7                	jne    1857 <printf+0x102>
    1880:	eb 68                	jmp    18ea <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1882:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1886:	75 1d                	jne    18a5 <printf+0x150>
        putc(fd, *ap);
    1888:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188b:	8b 00                	mov    (%eax),%eax
    188d:	0f be c0             	movsbl %al,%eax
    1890:	89 44 24 04          	mov    %eax,0x4(%esp)
    1894:	8b 45 08             	mov    0x8(%ebp),%eax
    1897:	89 04 24             	mov    %eax,(%esp)
    189a:	e8 dd fd ff ff       	call   167c <putc>
        ap++;
    189f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    18a3:	eb 45                	jmp    18ea <printf+0x195>
      } else if(c == '%'){
    18a5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    18a9:	75 17                	jne    18c2 <printf+0x16d>
        putc(fd, c);
    18ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18ae:	0f be c0             	movsbl %al,%eax
    18b1:	89 44 24 04          	mov    %eax,0x4(%esp)
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	89 04 24             	mov    %eax,(%esp)
    18bb:	e8 bc fd ff ff       	call   167c <putc>
    18c0:	eb 28                	jmp    18ea <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18c2:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    18c9:	00 
    18ca:	8b 45 08             	mov    0x8(%ebp),%eax
    18cd:	89 04 24             	mov    %eax,(%esp)
    18d0:	e8 a7 fd ff ff       	call   167c <putc>
        putc(fd, c);
    18d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18d8:	0f be c0             	movsbl %al,%eax
    18db:	89 44 24 04          	mov    %eax,0x4(%esp)
    18df:	8b 45 08             	mov    0x8(%ebp),%eax
    18e2:	89 04 24             	mov    %eax,(%esp)
    18e5:	e8 92 fd ff ff       	call   167c <putc>
      }
      state = 0;
    18ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    18f1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    18f5:	8b 55 0c             	mov    0xc(%ebp),%edx
    18f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18fb:	8d 04 02             	lea    (%edx,%eax,1),%eax
    18fe:	0f b6 00             	movzbl (%eax),%eax
    1901:	84 c0                	test   %al,%al
    1903:	0f 85 6e fe ff ff    	jne    1777 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1909:	c9                   	leave  
    190a:	c3                   	ret    
    190b:	90                   	nop

0000190c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    190c:	55                   	push   %ebp
    190d:	89 e5                	mov    %esp,%ebp
    190f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1912:	8b 45 08             	mov    0x8(%ebp),%eax
    1915:	83 e8 08             	sub    $0x8,%eax
    1918:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    191b:	a1 28 1e 00 00       	mov    0x1e28,%eax
    1920:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1923:	eb 24                	jmp    1949 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1925:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1928:	8b 00                	mov    (%eax),%eax
    192a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    192d:	77 12                	ja     1941 <free+0x35>
    192f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1932:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1935:	77 24                	ja     195b <free+0x4f>
    1937:	8b 45 fc             	mov    -0x4(%ebp),%eax
    193a:	8b 00                	mov    (%eax),%eax
    193c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    193f:	77 1a                	ja     195b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1941:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1944:	8b 00                	mov    (%eax),%eax
    1946:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1949:	8b 45 f8             	mov    -0x8(%ebp),%eax
    194c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    194f:	76 d4                	jbe    1925 <free+0x19>
    1951:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1954:	8b 00                	mov    (%eax),%eax
    1956:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1959:	76 ca                	jbe    1925 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    195b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    195e:	8b 40 04             	mov    0x4(%eax),%eax
    1961:	c1 e0 03             	shl    $0x3,%eax
    1964:	89 c2                	mov    %eax,%edx
    1966:	03 55 f8             	add    -0x8(%ebp),%edx
    1969:	8b 45 fc             	mov    -0x4(%ebp),%eax
    196c:	8b 00                	mov    (%eax),%eax
    196e:	39 c2                	cmp    %eax,%edx
    1970:	75 24                	jne    1996 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1972:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1975:	8b 50 04             	mov    0x4(%eax),%edx
    1978:	8b 45 fc             	mov    -0x4(%ebp),%eax
    197b:	8b 00                	mov    (%eax),%eax
    197d:	8b 40 04             	mov    0x4(%eax),%eax
    1980:	01 c2                	add    %eax,%edx
    1982:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1985:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1988:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198b:	8b 00                	mov    (%eax),%eax
    198d:	8b 10                	mov    (%eax),%edx
    198f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1992:	89 10                	mov    %edx,(%eax)
    1994:	eb 0a                	jmp    19a0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1996:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1999:	8b 10                	mov    (%eax),%edx
    199b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    199e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    19a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a3:	8b 40 04             	mov    0x4(%eax),%eax
    19a6:	c1 e0 03             	shl    $0x3,%eax
    19a9:	03 45 fc             	add    -0x4(%ebp),%eax
    19ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19af:	75 20                	jne    19d1 <free+0xc5>
    p->s.size += bp->s.size;
    19b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b4:	8b 50 04             	mov    0x4(%eax),%edx
    19b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19ba:	8b 40 04             	mov    0x4(%eax),%eax
    19bd:	01 c2                	add    %eax,%edx
    19bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    19c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19c8:	8b 10                	mov    (%eax),%edx
    19ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19cd:	89 10                	mov    %edx,(%eax)
    19cf:	eb 08                	jmp    19d9 <free+0xcd>
  } else
    p->s.ptr = bp;
    19d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19d7:	89 10                	mov    %edx,(%eax)
  freep = p;
    19d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19dc:	a3 28 1e 00 00       	mov    %eax,0x1e28
}
    19e1:	c9                   	leave  
    19e2:	c3                   	ret    

000019e3 <morecore>:

static Header*
morecore(uint nu)
{
    19e3:	55                   	push   %ebp
    19e4:	89 e5                	mov    %esp,%ebp
    19e6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    19e9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19f0:	77 07                	ja     19f9 <morecore+0x16>
    nu = 4096;
    19f2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    19f9:	8b 45 08             	mov    0x8(%ebp),%eax
    19fc:	c1 e0 03             	shl    $0x3,%eax
    19ff:	89 04 24             	mov    %eax,(%esp)
    1a02:	e8 35 fc ff ff       	call   163c <sbrk>
    1a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1a0a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a0e:	75 07                	jne    1a17 <morecore+0x34>
    return 0;
    1a10:	b8 00 00 00 00       	mov    $0x0,%eax
    1a15:	eb 22                	jmp    1a39 <morecore+0x56>
  hp = (Header*)p;
    1a17:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a20:	8b 55 08             	mov    0x8(%ebp),%edx
    1a23:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a29:	83 c0 08             	add    $0x8,%eax
    1a2c:	89 04 24             	mov    %eax,(%esp)
    1a2f:	e8 d8 fe ff ff       	call   190c <free>
  return freep;
    1a34:	a1 28 1e 00 00       	mov    0x1e28,%eax
}
    1a39:	c9                   	leave  
    1a3a:	c3                   	ret    

00001a3b <malloc>:

void*
malloc(uint nbytes)
{
    1a3b:	55                   	push   %ebp
    1a3c:	89 e5                	mov    %esp,%ebp
    1a3e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	83 c0 07             	add    $0x7,%eax
    1a47:	c1 e8 03             	shr    $0x3,%eax
    1a4a:	83 c0 01             	add    $0x1,%eax
    1a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1a50:	a1 28 1e 00 00       	mov    0x1e28,%eax
    1a55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a5c:	75 23                	jne    1a81 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1a5e:	c7 45 f0 20 1e 00 00 	movl   $0x1e20,-0x10(%ebp)
    1a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a68:	a3 28 1e 00 00       	mov    %eax,0x1e28
    1a6d:	a1 28 1e 00 00       	mov    0x1e28,%eax
    1a72:	a3 20 1e 00 00       	mov    %eax,0x1e20
    base.s.size = 0;
    1a77:	c7 05 24 1e 00 00 00 	movl   $0x0,0x1e24
    1a7e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a84:	8b 00                	mov    (%eax),%eax
    1a86:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1a89:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a8c:	8b 40 04             	mov    0x4(%eax),%eax
    1a8f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a92:	72 4d                	jb     1ae1 <malloc+0xa6>
      if(p->s.size == nunits)
    1a94:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a97:	8b 40 04             	mov    0x4(%eax),%eax
    1a9a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a9d:	75 0c                	jne    1aab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1a9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aa2:	8b 10                	mov    (%eax),%edx
    1aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aa7:	89 10                	mov    %edx,(%eax)
    1aa9:	eb 26                	jmp    1ad1 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aae:	8b 40 04             	mov    0x4(%eax),%eax
    1ab1:	89 c2                	mov    %eax,%edx
    1ab3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1ab6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ab9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1abc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1abf:	8b 40 04             	mov    0x4(%eax),%eax
    1ac2:	c1 e0 03             	shl    $0x3,%eax
    1ac5:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1acb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ace:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad4:	a3 28 1e 00 00       	mov    %eax,0x1e28
      return (void*)(p + 1);
    1ad9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1adc:	83 c0 08             	add    $0x8,%eax
    1adf:	eb 38                	jmp    1b19 <malloc+0xde>
    }
    if(p == freep)
    1ae1:	a1 28 1e 00 00       	mov    0x1e28,%eax
    1ae6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1ae9:	75 1b                	jne    1b06 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aee:	89 04 24             	mov    %eax,(%esp)
    1af1:	e8 ed fe ff ff       	call   19e3 <morecore>
    1af6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1af9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1afd:	75 07                	jne    1b06 <malloc+0xcb>
        return 0;
    1aff:	b8 00 00 00 00       	mov    $0x0,%eax
    1b04:	eb 13                	jmp    1b19 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b06:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b09:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b0f:	8b 00                	mov    (%eax),%eax
    1b11:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1b14:	e9 70 ff ff ff       	jmp    1a89 <malloc+0x4e>
}
    1b19:	c9                   	leave  
    1b1a:	c3                   	ret    
    1b1b:	90                   	nop

00001b1c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b1c:	55                   	push   %ebp
    1b1d:	89 e5                	mov    %esp,%ebp
    1b1f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b22:	8b 55 08             	mov    0x8(%ebp),%edx
    1b25:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b28:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2b:	f0 87 02             	lock xchg %eax,(%edx)
    1b2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b34:	c9                   	leave  
    1b35:	c3                   	ret    

00001b36 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b36:	55                   	push   %ebp
    1b37:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b39:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1b42:	5d                   	pop    %ebp
    1b43:	c3                   	ret    

00001b44 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1b44:	55                   	push   %ebp
    1b45:	89 e5                	mov    %esp,%ebp
    1b47:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1b4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b54:	00 
    1b55:	89 04 24             	mov    %eax,(%esp)
    1b58:	e8 bf ff ff ff       	call   1b1c <xchg>
    1b5d:	85 c0                	test   %eax,%eax
    1b5f:	75 e9                	jne    1b4a <lock_acquire+0x6>
}
    1b61:	c9                   	leave  
    1b62:	c3                   	ret    

00001b63 <lock_release>:
void lock_release(lock_t *lock){
    1b63:	55                   	push   %ebp
    1b64:	89 e5                	mov    %esp,%ebp
    1b66:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1b69:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b73:	00 
    1b74:	89 04 24             	mov    %eax,(%esp)
    1b77:	e8 a0 ff ff ff       	call   1b1c <xchg>
}
    1b7c:	c9                   	leave  
    1b7d:	c3                   	ret    

00001b7e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1b7e:	55                   	push   %ebp
    1b7f:	89 e5                	mov    %esp,%ebp
    1b81:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1b84:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1b8b:	e8 ab fe ff ff       	call   1a3b <malloc>
    1b90:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1b93:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b96:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1ba1:	85 c0                	test   %eax,%eax
    1ba3:	74 15                	je     1bba <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1ba5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ba8:	89 c2                	mov    %eax,%edx
    1baa:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1bb0:	b8 00 10 00 00       	mov    $0x1000,%eax
    1bb5:	29 d0                	sub    %edx,%eax
    1bb7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1bba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bbe:	75 1b                	jne    1bdb <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1bc0:	c7 44 24 04 cd 1d 00 	movl   $0x1dcd,0x4(%esp)
    1bc7:	00 
    1bc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bcf:	e8 81 fb ff ff       	call   1755 <printf>
        return 0;
    1bd4:	b8 00 00 00 00       	mov    $0x0,%eax
    1bd9:	eb 6f                	jmp    1c4a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1bdb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1bde:	8b 55 08             	mov    0x8(%ebp),%edx
    1be1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1be8:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bec:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1bf3:	00 
    1bf4:	89 04 24             	mov    %eax,(%esp)
    1bf7:	e8 58 fa ff ff       	call   1654 <clone>
    1bfc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1bff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c03:	79 1b                	jns    1c20 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1c05:	c7 44 24 04 db 1d 00 	movl   $0x1ddb,0x4(%esp)
    1c0c:	00 
    1c0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c14:	e8 3c fb ff ff       	call   1755 <printf>
        return 0;
    1c19:	b8 00 00 00 00       	mov    $0x0,%eax
    1c1e:	eb 2a                	jmp    1c4a <thread_create+0xcc>
    }
    if(tid > 0){
    1c20:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c24:	7e 05                	jle    1c2b <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1c26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c29:	eb 1f                	jmp    1c4a <thread_create+0xcc>
    }
    if(tid == 0){
    1c2b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c2f:	75 14                	jne    1c45 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1c31:	c7 44 24 04 e8 1d 00 	movl   $0x1de8,0x4(%esp)
    1c38:	00 
    1c39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c40:	e8 10 fb ff ff       	call   1755 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1c45:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1c4a:	c9                   	leave  
    1c4b:	c3                   	ret    

00001c4c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1c4c:	55                   	push   %ebp
    1c4d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1c4f:	a1 10 1e 00 00       	mov    0x1e10,%eax
    1c54:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1c5a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1c5f:	a3 10 1e 00 00       	mov    %eax,0x1e10
    return (int)(rands % max);
    1c64:	a1 10 1e 00 00       	mov    0x1e10,%eax
    1c69:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c6c:	ba 00 00 00 00       	mov    $0x0,%edx
    1c71:	f7 f1                	div    %ecx
    1c73:	89 d0                	mov    %edx,%eax
}
    1c75:	5d                   	pop    %ebp
    1c76:	c3                   	ret    
    1c77:	90                   	nop

00001c78 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1c78:	55                   	push   %ebp
    1c79:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1c7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1c84:	8b 45 08             	mov    0x8(%ebp),%eax
    1c87:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1c8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c91:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1c98:	5d                   	pop    %ebp
    1c99:	c3                   	ret    

00001c9a <add_q>:

void add_q(struct queue *q, int v){
    1c9a:	55                   	push   %ebp
    1c9b:	89 e5                	mov    %esp,%ebp
    1c9d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1ca0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ca7:	e8 8f fd ff ff       	call   1a3b <malloc>
    1cac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1caf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cbc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cbf:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1cc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc4:	8b 40 04             	mov    0x4(%eax),%eax
    1cc7:	85 c0                	test   %eax,%eax
    1cc9:	75 0b                	jne    1cd6 <add_q+0x3c>
        q->head = n;
    1ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cce:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cd1:	89 50 04             	mov    %edx,0x4(%eax)
    1cd4:	eb 0c                	jmp    1ce2 <add_q+0x48>
    }else{
        q->tail->next = n;
    1cd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd9:	8b 40 08             	mov    0x8(%eax),%eax
    1cdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cdf:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1ce2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ce8:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1ceb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cee:	8b 00                	mov    (%eax),%eax
    1cf0:	8d 50 01             	lea    0x1(%eax),%edx
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	89 10                	mov    %edx,(%eax)
}
    1cf8:	c9                   	leave  
    1cf9:	c3                   	ret    

00001cfa <empty_q>:

int empty_q(struct queue *q){
    1cfa:	55                   	push   %ebp
    1cfb:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1cfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1d00:	8b 00                	mov    (%eax),%eax
    1d02:	85 c0                	test   %eax,%eax
    1d04:	75 07                	jne    1d0d <empty_q+0x13>
        return 1;
    1d06:	b8 01 00 00 00       	mov    $0x1,%eax
    1d0b:	eb 05                	jmp    1d12 <empty_q+0x18>
    else
        return 0;
    1d0d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d12:	5d                   	pop    %ebp
    1d13:	c3                   	ret    

00001d14 <pop_q>:
int pop_q(struct queue *q){
    1d14:	55                   	push   %ebp
    1d15:	89 e5                	mov    %esp,%ebp
    1d17:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1d:	89 04 24             	mov    %eax,(%esp)
    1d20:	e8 d5 ff ff ff       	call   1cfa <empty_q>
    1d25:	85 c0                	test   %eax,%eax
    1d27:	75 5d                	jne    1d86 <pop_q+0x72>
       val = q->head->value; 
    1d29:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2c:	8b 40 04             	mov    0x4(%eax),%eax
    1d2f:	8b 00                	mov    (%eax),%eax
    1d31:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1d34:	8b 45 08             	mov    0x8(%ebp),%eax
    1d37:	8b 40 04             	mov    0x4(%eax),%eax
    1d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1d3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d40:	8b 40 04             	mov    0x4(%eax),%eax
    1d43:	8b 50 04             	mov    0x4(%eax),%edx
    1d46:	8b 45 08             	mov    0x8(%ebp),%eax
    1d49:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1d4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d4f:	89 04 24             	mov    %eax,(%esp)
    1d52:	e8 b5 fb ff ff       	call   190c <free>
       q->size--;
    1d57:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5a:	8b 00                	mov    (%eax),%eax
    1d5c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d62:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1d64:	8b 45 08             	mov    0x8(%ebp),%eax
    1d67:	8b 00                	mov    (%eax),%eax
    1d69:	85 c0                	test   %eax,%eax
    1d6b:	75 14                	jne    1d81 <pop_q+0x6d>
            q->head = 0;
    1d6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d70:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1d77:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d84:	eb 05                	jmp    1d8b <pop_q+0x77>
    }
    return -1;
    1d86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d8b:	c9                   	leave  
    1d8c:	c3                   	ret    
