
_tyield:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

// Test functions for yielding, prints "beep" and "boop".
void one(void * arg_ptr);
void two(void * arg_ptr);

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int arg = 10;
    1009:	c7 44 24 14 0a 00 00 	movl   $0xa,0x14(%esp)
    1010:	00 
  void *tid;
  int i;

	tid = thread_create(one, (void *) &arg);
    1011:	8d 44 24 14          	lea    0x14(%esp),%eax
    1015:	89 44 24 04          	mov    %eax,0x4(%esp)
    1019:	c7 04 24 c2 10 00 00 	movl   $0x10c2,(%esp)
    1020:	e8 ca 0a 00 00       	call   1aef <thread_create>
    1025:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(tid <= 0){
    1029:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    102e:	75 19                	jne    1049 <main+0x49>
		printf(1, "Thread Creation Failed\n");
    1030:	c7 44 24 04 fd 1c 00 	movl   $0x1cfd,0x4(%esp)
    1037:	00 
    1038:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103f:	e8 78 06 00 00       	call   16bc <printf>
		exit();
    1044:	e8 cb 04 00 00       	call   1514 <exit>
	}
	for(i = 0; i < 2999999; i++);
    1049:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1050:	00 
    1051:	eb 05                	jmp    1058 <main+0x58>
    1053:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1058:	81 7c 24 1c be c6 2d 	cmpl   $0x2dc6be,0x1c(%esp)
    105f:	00 
    1060:	7e f1                	jle    1053 <main+0x53>
	tid = thread_create(two, (void *) &arg);
    1062:	8d 44 24 14          	lea    0x14(%esp),%eax
    1066:	89 44 24 04          	mov    %eax,0x4(%esp)
    106a:	c7 04 24 b8 11 00 00 	movl   $0x11b8,(%esp)
    1071:	e8 79 0a 00 00       	call   1aef <thread_create>
    1076:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(tid <= 0){
    107a:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    107f:	75 19                	jne    109a <main+0x9a>
		printf(1, "Thread Creation Failed\n");
    1081:	c7 44 24 04 fd 1c 00 	movl   $0x1cfd,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1090:	e8 27 06 00 00       	call   16bc <printf>
		exit();
    1095:	e8 7a 04 00 00       	call   1514 <exit>
	}
	for(i = 0; i < 2999999; i++);
    109a:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    10a1:	00 
    10a2:	eb 05                	jmp    10a9 <main+0xa9>
    10a4:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    10a9:	81 7c 24 1c be c6 2d 	cmpl   $0x2dc6be,0x1c(%esp)
    10b0:	00 
    10b1:	7e f1                	jle    10a4 <main+0xa4>
  while(wait()>=0);
    10b3:	90                   	nop
    10b4:	e8 63 04 00 00       	call   151c <wait>
    10b9:	85 c0                	test   %eax,%eax
    10bb:	79 f7                	jns    10b4 <main+0xb4>

  exit();
    10bd:	e8 52 04 00 00       	call   1514 <exit>

000010c2 <one>:
  return 0;
}

void one(void *arg_ptr){
    10c2:	55                   	push   %ebp
    10c3:	89 e5                	mov    %esp,%ebp
    10c5:	83 ec 28             	sub    $0x28,%esp
	int j;
	
	for(j = 0; j < 2999999; j++);
    10c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10cf:	eb 04                	jmp    10d5 <one+0x13>
    10d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10d5:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    10dc:	7e f3                	jle    10d1 <one+0xf>
	thread_yield();
    10de:	e8 f1 04 00 00       	call   15d4 <thread_yield>
	printf(1, "one\n");
    10e3:	c7 44 24 04 15 1d 00 	movl   $0x1d15,0x4(%esp)
    10ea:	00 
    10eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f2:	e8 c5 05 00 00       	call   16bc <printf>
	
	for(j = 0; j < 2999999; j++);
    10f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10fe:	eb 04                	jmp    1104 <one+0x42>
    1100:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1104:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    110b:	7e f3                	jle    1100 <one+0x3e>
	thread_yield();
    110d:	e8 c2 04 00 00       	call   15d4 <thread_yield>
	printf(1, "one\n");
    1112:	c7 44 24 04 15 1d 00 	movl   $0x1d15,0x4(%esp)
    1119:	00 
    111a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1121:	e8 96 05 00 00       	call   16bc <printf>
	
	for(j = 0; j < 2999999; j++);
    1126:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    112d:	eb 04                	jmp    1133 <one+0x71>
    112f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1133:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    113a:	7e f3                	jle    112f <one+0x6d>
	thread_yield();
    113c:	e8 93 04 00 00       	call   15d4 <thread_yield>
	printf(1, "one\n");
    1141:	c7 44 24 04 15 1d 00 	movl   $0x1d15,0x4(%esp)
    1148:	00 
    1149:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1150:	e8 67 05 00 00       	call   16bc <printf>
	
	for(j = 0; j < 2999999; j++);
    1155:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    115c:	eb 04                	jmp    1162 <one+0xa0>
    115e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1162:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1169:	7e f3                	jle    115e <one+0x9c>
	thread_yield();
    116b:	e8 64 04 00 00       	call   15d4 <thread_yield>
	printf(1, "one\n");
    1170:	c7 44 24 04 15 1d 00 	movl   $0x1d15,0x4(%esp)
    1177:	00 
    1178:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    117f:	e8 38 05 00 00       	call   16bc <printf>
	
	for(j = 0; j < 2999999; j++);
    1184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    118b:	eb 04                	jmp    1191 <one+0xcf>
    118d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1191:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1198:	7e f3                	jle    118d <one+0xcb>
	thread_yield();
    119a:	e8 35 04 00 00       	call   15d4 <thread_yield>
	printf(1, "one\n");
    119f:	c7 44 24 04 15 1d 00 	movl   $0x1d15,0x4(%esp)
    11a6:	00 
    11a7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11ae:	e8 09 05 00 00       	call   16bc <printf>
	
  texit();
    11b3:	e8 04 04 00 00       	call   15bc <texit>

000011b8 <two>:
}

void two(void *arg_ptr){
    11b8:	55                   	push   %ebp
    11b9:	89 e5                	mov    %esp,%ebp
    11bb:	83 ec 28             	sub    $0x28,%esp
	int j;
	
	for(j = 0; j < 2999999; j++);
    11be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11c5:	eb 04                	jmp    11cb <two+0x13>
    11c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11cb:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    11d2:	7e f3                	jle    11c7 <two+0xf>
	printf(1, "two\n");
    11d4:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    11db:	00 
    11dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11e3:	e8 d4 04 00 00       	call   16bc <printf>
	thread_yield();
    11e8:	e8 e7 03 00 00       	call   15d4 <thread_yield>
	
	for(j = 0; j < 2999999; j++);
    11ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11f4:	eb 04                	jmp    11fa <two+0x42>
    11f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11fa:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1201:	7e f3                	jle    11f6 <two+0x3e>
	printf(1, "two\n");
    1203:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    120a:	00 
    120b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1212:	e8 a5 04 00 00       	call   16bc <printf>
	thread_yield();
    1217:	e8 b8 03 00 00       	call   15d4 <thread_yield>
	
	for(j = 0; j < 2999999; j++);
    121c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1223:	eb 04                	jmp    1229 <two+0x71>
    1225:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1229:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    1230:	7e f3                	jle    1225 <two+0x6d>
	printf(1, "two\n");
    1232:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    1239:	00 
    123a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1241:	e8 76 04 00 00       	call   16bc <printf>
	thread_yield();
    1246:	e8 89 03 00 00       	call   15d4 <thread_yield>
	
	for(j = 0; j < 2999999; j++);
    124b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1252:	eb 04                	jmp    1258 <two+0xa0>
    1254:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1258:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    125f:	7e f3                	jle    1254 <two+0x9c>
	printf(1, "two\n");
    1261:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    1268:	00 
    1269:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1270:	e8 47 04 00 00       	call   16bc <printf>
	thread_yield();
    1275:	e8 5a 03 00 00       	call   15d4 <thread_yield>
	
	for(j = 0; j < 2999999; j++);
    127a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1281:	eb 04                	jmp    1287 <two+0xcf>
    1283:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1287:	81 7d f4 be c6 2d 00 	cmpl   $0x2dc6be,-0xc(%ebp)
    128e:	7e f3                	jle    1283 <two+0xcb>
	printf(1, "two\n");
    1290:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    1297:	00 
    1298:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129f:	e8 18 04 00 00       	call   16bc <printf>
	
  texit();
    12a4:	e8 13 03 00 00       	call   15bc <texit>
    12a9:	66 90                	xchg   %ax,%ax
    12ab:	90                   	nop

000012ac <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    12ac:	55                   	push   %ebp
    12ad:	89 e5                	mov    %esp,%ebp
    12af:	57                   	push   %edi
    12b0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    12b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12b4:	8b 55 10             	mov    0x10(%ebp),%edx
    12b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ba:	89 cb                	mov    %ecx,%ebx
    12bc:	89 df                	mov    %ebx,%edi
    12be:	89 d1                	mov    %edx,%ecx
    12c0:	fc                   	cld    
    12c1:	f3 aa                	rep stos %al,%es:(%edi)
    12c3:	89 ca                	mov    %ecx,%edx
    12c5:	89 fb                	mov    %edi,%ebx
    12c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    12ca:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    12cd:	5b                   	pop    %ebx
    12ce:	5f                   	pop    %edi
    12cf:	5d                   	pop    %ebp
    12d0:	c3                   	ret    

000012d1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    12d1:	55                   	push   %ebp
    12d2:	89 e5                	mov    %esp,%ebp
    12d4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    12d7:	8b 45 08             	mov    0x8(%ebp),%eax
    12da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    12dd:	90                   	nop
    12de:	8b 45 08             	mov    0x8(%ebp),%eax
    12e1:	8d 50 01             	lea    0x1(%eax),%edx
    12e4:	89 55 08             	mov    %edx,0x8(%ebp)
    12e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    12ea:	8d 4a 01             	lea    0x1(%edx),%ecx
    12ed:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    12f0:	0f b6 12             	movzbl (%edx),%edx
    12f3:	88 10                	mov    %dl,(%eax)
    12f5:	0f b6 00             	movzbl (%eax),%eax
    12f8:	84 c0                	test   %al,%al
    12fa:	75 e2                	jne    12de <strcpy+0xd>
    ;
  return os;
    12fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12ff:	c9                   	leave  
    1300:	c3                   	ret    

00001301 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1301:	55                   	push   %ebp
    1302:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1304:	eb 08                	jmp    130e <strcmp+0xd>
    p++, q++;
    1306:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    130a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    130e:	8b 45 08             	mov    0x8(%ebp),%eax
    1311:	0f b6 00             	movzbl (%eax),%eax
    1314:	84 c0                	test   %al,%al
    1316:	74 10                	je     1328 <strcmp+0x27>
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	0f b6 10             	movzbl (%eax),%edx
    131e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1321:	0f b6 00             	movzbl (%eax),%eax
    1324:	38 c2                	cmp    %al,%dl
    1326:	74 de                	je     1306 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1328:	8b 45 08             	mov    0x8(%ebp),%eax
    132b:	0f b6 00             	movzbl (%eax),%eax
    132e:	0f b6 d0             	movzbl %al,%edx
    1331:	8b 45 0c             	mov    0xc(%ebp),%eax
    1334:	0f b6 00             	movzbl (%eax),%eax
    1337:	0f b6 c0             	movzbl %al,%eax
    133a:	29 c2                	sub    %eax,%edx
    133c:	89 d0                	mov    %edx,%eax
}
    133e:	5d                   	pop    %ebp
    133f:	c3                   	ret    

00001340 <strlen>:

uint
strlen(char *s)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1346:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    134d:	eb 04                	jmp    1353 <strlen+0x13>
    134f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1353:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1356:	8b 45 08             	mov    0x8(%ebp),%eax
    1359:	01 d0                	add    %edx,%eax
    135b:	0f b6 00             	movzbl (%eax),%eax
    135e:	84 c0                	test   %al,%al
    1360:	75 ed                	jne    134f <strlen+0xf>
    ;
  return n;
    1362:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1365:	c9                   	leave  
    1366:	c3                   	ret    

00001367 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1367:	55                   	push   %ebp
    1368:	89 e5                	mov    %esp,%ebp
    136a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    136d:	8b 45 10             	mov    0x10(%ebp),%eax
    1370:	89 44 24 08          	mov    %eax,0x8(%esp)
    1374:	8b 45 0c             	mov    0xc(%ebp),%eax
    1377:	89 44 24 04          	mov    %eax,0x4(%esp)
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
    137e:	89 04 24             	mov    %eax,(%esp)
    1381:	e8 26 ff ff ff       	call   12ac <stosb>
  return dst;
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1389:	c9                   	leave  
    138a:	c3                   	ret    

0000138b <strchr>:

char*
strchr(const char *s, char c)
{
    138b:	55                   	push   %ebp
    138c:	89 e5                	mov    %esp,%ebp
    138e:	83 ec 04             	sub    $0x4,%esp
    1391:	8b 45 0c             	mov    0xc(%ebp),%eax
    1394:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1397:	eb 14                	jmp    13ad <strchr+0x22>
    if(*s == c)
    1399:	8b 45 08             	mov    0x8(%ebp),%eax
    139c:	0f b6 00             	movzbl (%eax),%eax
    139f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    13a2:	75 05                	jne    13a9 <strchr+0x1e>
      return (char*)s;
    13a4:	8b 45 08             	mov    0x8(%ebp),%eax
    13a7:	eb 13                	jmp    13bc <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    13a9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13ad:	8b 45 08             	mov    0x8(%ebp),%eax
    13b0:	0f b6 00             	movzbl (%eax),%eax
    13b3:	84 c0                	test   %al,%al
    13b5:	75 e2                	jne    1399 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    13b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13bc:	c9                   	leave  
    13bd:	c3                   	ret    

000013be <gets>:

char*
gets(char *buf, int max)
{
    13be:	55                   	push   %ebp
    13bf:	89 e5                	mov    %esp,%ebp
    13c1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13cb:	eb 4c                	jmp    1419 <gets+0x5b>
    cc = read(0, &c, 1);
    13cd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13d4:	00 
    13d5:	8d 45 ef             	lea    -0x11(%ebp),%eax
    13d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    13dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13e3:	e8 44 01 00 00       	call   152c <read>
    13e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    13eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13ef:	7f 02                	jg     13f3 <gets+0x35>
      break;
    13f1:	eb 31                	jmp    1424 <gets+0x66>
    buf[i++] = c;
    13f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f6:	8d 50 01             	lea    0x1(%eax),%edx
    13f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13fc:	89 c2                	mov    %eax,%edx
    13fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1401:	01 c2                	add    %eax,%edx
    1403:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1407:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1409:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    140d:	3c 0a                	cmp    $0xa,%al
    140f:	74 13                	je     1424 <gets+0x66>
    1411:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1415:	3c 0d                	cmp    $0xd,%al
    1417:	74 0b                	je     1424 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141c:	83 c0 01             	add    $0x1,%eax
    141f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1422:	7c a9                	jl     13cd <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1424:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1427:	8b 45 08             	mov    0x8(%ebp),%eax
    142a:	01 d0                	add    %edx,%eax
    142c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1432:	c9                   	leave  
    1433:	c3                   	ret    

00001434 <stat>:

int
stat(char *n, struct stat *st)
{
    1434:	55                   	push   %ebp
    1435:	89 e5                	mov    %esp,%ebp
    1437:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    143a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1441:	00 
    1442:	8b 45 08             	mov    0x8(%ebp),%eax
    1445:	89 04 24             	mov    %eax,(%esp)
    1448:	e8 07 01 00 00       	call   1554 <open>
    144d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1450:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1454:	79 07                	jns    145d <stat+0x29>
    return -1;
    1456:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    145b:	eb 23                	jmp    1480 <stat+0x4c>
  r = fstat(fd, st);
    145d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1460:	89 44 24 04          	mov    %eax,0x4(%esp)
    1464:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1467:	89 04 24             	mov    %eax,(%esp)
    146a:	e8 fd 00 00 00       	call   156c <fstat>
    146f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1472:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1475:	89 04 24             	mov    %eax,(%esp)
    1478:	e8 bf 00 00 00       	call   153c <close>
  return r;
    147d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1480:	c9                   	leave  
    1481:	c3                   	ret    

00001482 <atoi>:

int
atoi(const char *s)
{
    1482:	55                   	push   %ebp
    1483:	89 e5                	mov    %esp,%ebp
    1485:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1488:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    148f:	eb 25                	jmp    14b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1491:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1494:	89 d0                	mov    %edx,%eax
    1496:	c1 e0 02             	shl    $0x2,%eax
    1499:	01 d0                	add    %edx,%eax
    149b:	01 c0                	add    %eax,%eax
    149d:	89 c1                	mov    %eax,%ecx
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	8d 50 01             	lea    0x1(%eax),%edx
    14a5:	89 55 08             	mov    %edx,0x8(%ebp)
    14a8:	0f b6 00             	movzbl (%eax),%eax
    14ab:	0f be c0             	movsbl %al,%eax
    14ae:	01 c8                	add    %ecx,%eax
    14b0:	83 e8 30             	sub    $0x30,%eax
    14b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    14b6:	8b 45 08             	mov    0x8(%ebp),%eax
    14b9:	0f b6 00             	movzbl (%eax),%eax
    14bc:	3c 2f                	cmp    $0x2f,%al
    14be:	7e 0a                	jle    14ca <atoi+0x48>
    14c0:	8b 45 08             	mov    0x8(%ebp),%eax
    14c3:	0f b6 00             	movzbl (%eax),%eax
    14c6:	3c 39                	cmp    $0x39,%al
    14c8:	7e c7                	jle    1491 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    14ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14cd:	c9                   	leave  
    14ce:	c3                   	ret    

000014cf <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14cf:	55                   	push   %ebp
    14d0:	89 e5                	mov    %esp,%ebp
    14d2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    14d5:	8b 45 08             	mov    0x8(%ebp),%eax
    14d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    14db:	8b 45 0c             	mov    0xc(%ebp),%eax
    14de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    14e1:	eb 17                	jmp    14fa <memmove+0x2b>
    *dst++ = *src++;
    14e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14e6:	8d 50 01             	lea    0x1(%eax),%edx
    14e9:	89 55 fc             	mov    %edx,-0x4(%ebp)
    14ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14ef:	8d 4a 01             	lea    0x1(%edx),%ecx
    14f2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    14f5:	0f b6 12             	movzbl (%edx),%edx
    14f8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14fa:	8b 45 10             	mov    0x10(%ebp),%eax
    14fd:	8d 50 ff             	lea    -0x1(%eax),%edx
    1500:	89 55 10             	mov    %edx,0x10(%ebp)
    1503:	85 c0                	test   %eax,%eax
    1505:	7f dc                	jg     14e3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1507:	8b 45 08             	mov    0x8(%ebp),%eax
}
    150a:	c9                   	leave  
    150b:	c3                   	ret    

0000150c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    150c:	b8 01 00 00 00       	mov    $0x1,%eax
    1511:	cd 40                	int    $0x40
    1513:	c3                   	ret    

00001514 <exit>:
SYSCALL(exit)
    1514:	b8 02 00 00 00       	mov    $0x2,%eax
    1519:	cd 40                	int    $0x40
    151b:	c3                   	ret    

0000151c <wait>:
SYSCALL(wait)
    151c:	b8 03 00 00 00       	mov    $0x3,%eax
    1521:	cd 40                	int    $0x40
    1523:	c3                   	ret    

00001524 <pipe>:
SYSCALL(pipe)
    1524:	b8 04 00 00 00       	mov    $0x4,%eax
    1529:	cd 40                	int    $0x40
    152b:	c3                   	ret    

0000152c <read>:
SYSCALL(read)
    152c:	b8 05 00 00 00       	mov    $0x5,%eax
    1531:	cd 40                	int    $0x40
    1533:	c3                   	ret    

00001534 <write>:
SYSCALL(write)
    1534:	b8 10 00 00 00       	mov    $0x10,%eax
    1539:	cd 40                	int    $0x40
    153b:	c3                   	ret    

0000153c <close>:
SYSCALL(close)
    153c:	b8 15 00 00 00       	mov    $0x15,%eax
    1541:	cd 40                	int    $0x40
    1543:	c3                   	ret    

00001544 <kill>:
SYSCALL(kill)
    1544:	b8 06 00 00 00       	mov    $0x6,%eax
    1549:	cd 40                	int    $0x40
    154b:	c3                   	ret    

0000154c <exec>:
SYSCALL(exec)
    154c:	b8 07 00 00 00       	mov    $0x7,%eax
    1551:	cd 40                	int    $0x40
    1553:	c3                   	ret    

00001554 <open>:
SYSCALL(open)
    1554:	b8 0f 00 00 00       	mov    $0xf,%eax
    1559:	cd 40                	int    $0x40
    155b:	c3                   	ret    

0000155c <mknod>:
SYSCALL(mknod)
    155c:	b8 11 00 00 00       	mov    $0x11,%eax
    1561:	cd 40                	int    $0x40
    1563:	c3                   	ret    

00001564 <unlink>:
SYSCALL(unlink)
    1564:	b8 12 00 00 00       	mov    $0x12,%eax
    1569:	cd 40                	int    $0x40
    156b:	c3                   	ret    

0000156c <fstat>:
SYSCALL(fstat)
    156c:	b8 08 00 00 00       	mov    $0x8,%eax
    1571:	cd 40                	int    $0x40
    1573:	c3                   	ret    

00001574 <link>:
SYSCALL(link)
    1574:	b8 13 00 00 00       	mov    $0x13,%eax
    1579:	cd 40                	int    $0x40
    157b:	c3                   	ret    

0000157c <mkdir>:
SYSCALL(mkdir)
    157c:	b8 14 00 00 00       	mov    $0x14,%eax
    1581:	cd 40                	int    $0x40
    1583:	c3                   	ret    

00001584 <chdir>:
SYSCALL(chdir)
    1584:	b8 09 00 00 00       	mov    $0x9,%eax
    1589:	cd 40                	int    $0x40
    158b:	c3                   	ret    

0000158c <dup>:
SYSCALL(dup)
    158c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1591:	cd 40                	int    $0x40
    1593:	c3                   	ret    

00001594 <getpid>:
SYSCALL(getpid)
    1594:	b8 0b 00 00 00       	mov    $0xb,%eax
    1599:	cd 40                	int    $0x40
    159b:	c3                   	ret    

0000159c <sbrk>:
SYSCALL(sbrk)
    159c:	b8 0c 00 00 00       	mov    $0xc,%eax
    15a1:	cd 40                	int    $0x40
    15a3:	c3                   	ret    

000015a4 <sleep>:
SYSCALL(sleep)
    15a4:	b8 0d 00 00 00       	mov    $0xd,%eax
    15a9:	cd 40                	int    $0x40
    15ab:	c3                   	ret    

000015ac <uptime>:
SYSCALL(uptime)
    15ac:	b8 0e 00 00 00       	mov    $0xe,%eax
    15b1:	cd 40                	int    $0x40
    15b3:	c3                   	ret    

000015b4 <clone>:
SYSCALL(clone)
    15b4:	b8 16 00 00 00       	mov    $0x16,%eax
    15b9:	cd 40                	int    $0x40
    15bb:	c3                   	ret    

000015bc <texit>:
SYSCALL(texit)
    15bc:	b8 17 00 00 00       	mov    $0x17,%eax
    15c1:	cd 40                	int    $0x40
    15c3:	c3                   	ret    

000015c4 <tsleep>:
SYSCALL(tsleep)
    15c4:	b8 18 00 00 00       	mov    $0x18,%eax
    15c9:	cd 40                	int    $0x40
    15cb:	c3                   	ret    

000015cc <twakeup>:
SYSCALL(twakeup)
    15cc:	b8 19 00 00 00       	mov    $0x19,%eax
    15d1:	cd 40                	int    $0x40
    15d3:	c3                   	ret    

000015d4 <thread_yield>:
SYSCALL(thread_yield)
    15d4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    15d9:	cd 40                	int    $0x40
    15db:	c3                   	ret    

000015dc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15dc:	55                   	push   %ebp
    15dd:	89 e5                	mov    %esp,%ebp
    15df:	83 ec 18             	sub    $0x18,%esp
    15e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15ef:	00 
    15f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f7:	8b 45 08             	mov    0x8(%ebp),%eax
    15fa:	89 04 24             	mov    %eax,(%esp)
    15fd:	e8 32 ff ff ff       	call   1534 <write>
}
    1602:	c9                   	leave  
    1603:	c3                   	ret    

00001604 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1604:	55                   	push   %ebp
    1605:	89 e5                	mov    %esp,%ebp
    1607:	56                   	push   %esi
    1608:	53                   	push   %ebx
    1609:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    160c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1613:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1617:	74 17                	je     1630 <printint+0x2c>
    1619:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    161d:	79 11                	jns    1630 <printint+0x2c>
    neg = 1;
    161f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1626:	8b 45 0c             	mov    0xc(%ebp),%eax
    1629:	f7 d8                	neg    %eax
    162b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    162e:	eb 06                	jmp    1636 <printint+0x32>
  } else {
    x = xx;
    1630:	8b 45 0c             	mov    0xc(%ebp),%eax
    1633:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1636:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    163d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1640:	8d 41 01             	lea    0x1(%ecx),%eax
    1643:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1646:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1649:	8b 45 ec             	mov    -0x14(%ebp),%eax
    164c:	ba 00 00 00 00       	mov    $0x0,%edx
    1651:	f7 f3                	div    %ebx
    1653:	89 d0                	mov    %edx,%eax
    1655:	0f b6 80 10 21 00 00 	movzbl 0x2110(%eax),%eax
    165c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1660:	8b 75 10             	mov    0x10(%ebp),%esi
    1663:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1666:	ba 00 00 00 00       	mov    $0x0,%edx
    166b:	f7 f6                	div    %esi
    166d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1670:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1674:	75 c7                	jne    163d <printint+0x39>
  if(neg)
    1676:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    167a:	74 10                	je     168c <printint+0x88>
    buf[i++] = '-';
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8d 50 01             	lea    0x1(%eax),%edx
    1682:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1685:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    168a:	eb 1f                	jmp    16ab <printint+0xa7>
    168c:	eb 1d                	jmp    16ab <printint+0xa7>
    putc(fd, buf[i]);
    168e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	01 d0                	add    %edx,%eax
    1696:	0f b6 00             	movzbl (%eax),%eax
    1699:	0f be c0             	movsbl %al,%eax
    169c:	89 44 24 04          	mov    %eax,0x4(%esp)
    16a0:	8b 45 08             	mov    0x8(%ebp),%eax
    16a3:	89 04 24             	mov    %eax,(%esp)
    16a6:	e8 31 ff ff ff       	call   15dc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16ab:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    16af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16b3:	79 d9                	jns    168e <printint+0x8a>
    putc(fd, buf[i]);
}
    16b5:	83 c4 30             	add    $0x30,%esp
    16b8:	5b                   	pop    %ebx
    16b9:	5e                   	pop    %esi
    16ba:	5d                   	pop    %ebp
    16bb:	c3                   	ret    

000016bc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16bc:	55                   	push   %ebp
    16bd:	89 e5                	mov    %esp,%ebp
    16bf:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    16c2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16c9:	8d 45 0c             	lea    0xc(%ebp),%eax
    16cc:	83 c0 04             	add    $0x4,%eax
    16cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    16d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16d9:	e9 7c 01 00 00       	jmp    185a <printf+0x19e>
    c = fmt[i] & 0xff;
    16de:	8b 55 0c             	mov    0xc(%ebp),%edx
    16e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16e4:	01 d0                	add    %edx,%eax
    16e6:	0f b6 00             	movzbl (%eax),%eax
    16e9:	0f be c0             	movsbl %al,%eax
    16ec:	25 ff 00 00 00       	and    $0xff,%eax
    16f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    16f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16f8:	75 2c                	jne    1726 <printf+0x6a>
      if(c == '%'){
    16fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16fe:	75 0c                	jne    170c <printf+0x50>
        state = '%';
    1700:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1707:	e9 4a 01 00 00       	jmp    1856 <printf+0x19a>
      } else {
        putc(fd, c);
    170c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    170f:	0f be c0             	movsbl %al,%eax
    1712:	89 44 24 04          	mov    %eax,0x4(%esp)
    1716:	8b 45 08             	mov    0x8(%ebp),%eax
    1719:	89 04 24             	mov    %eax,(%esp)
    171c:	e8 bb fe ff ff       	call   15dc <putc>
    1721:	e9 30 01 00 00       	jmp    1856 <printf+0x19a>
      }
    } else if(state == '%'){
    1726:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    172a:	0f 85 26 01 00 00    	jne    1856 <printf+0x19a>
      if(c == 'd'){
    1730:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1734:	75 2d                	jne    1763 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1736:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1739:	8b 00                	mov    (%eax),%eax
    173b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1742:	00 
    1743:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    174a:	00 
    174b:	89 44 24 04          	mov    %eax,0x4(%esp)
    174f:	8b 45 08             	mov    0x8(%ebp),%eax
    1752:	89 04 24             	mov    %eax,(%esp)
    1755:	e8 aa fe ff ff       	call   1604 <printint>
        ap++;
    175a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    175e:	e9 ec 00 00 00       	jmp    184f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1763:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1767:	74 06                	je     176f <printf+0xb3>
    1769:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    176d:	75 2d                	jne    179c <printf+0xe0>
        printint(fd, *ap, 16, 0);
    176f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1772:	8b 00                	mov    (%eax),%eax
    1774:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    177b:	00 
    177c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1783:	00 
    1784:	89 44 24 04          	mov    %eax,0x4(%esp)
    1788:	8b 45 08             	mov    0x8(%ebp),%eax
    178b:	89 04 24             	mov    %eax,(%esp)
    178e:	e8 71 fe ff ff       	call   1604 <printint>
        ap++;
    1793:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1797:	e9 b3 00 00 00       	jmp    184f <printf+0x193>
      } else if(c == 's'){
    179c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    17a0:	75 45                	jne    17e7 <printf+0x12b>
        s = (char*)*ap;
    17a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17a5:	8b 00                	mov    (%eax),%eax
    17a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    17aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    17ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17b2:	75 09                	jne    17bd <printf+0x101>
          s = "(null)";
    17b4:	c7 45 f4 1f 1d 00 00 	movl   $0x1d1f,-0xc(%ebp)
        while(*s != 0){
    17bb:	eb 1e                	jmp    17db <printf+0x11f>
    17bd:	eb 1c                	jmp    17db <printf+0x11f>
          putc(fd, *s);
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	0f b6 00             	movzbl (%eax),%eax
    17c5:	0f be c0             	movsbl %al,%eax
    17c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    17cc:	8b 45 08             	mov    0x8(%ebp),%eax
    17cf:	89 04 24             	mov    %eax,(%esp)
    17d2:	e8 05 fe ff ff       	call   15dc <putc>
          s++;
    17d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	0f b6 00             	movzbl (%eax),%eax
    17e1:	84 c0                	test   %al,%al
    17e3:	75 da                	jne    17bf <printf+0x103>
    17e5:	eb 68                	jmp    184f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    17e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    17eb:	75 1d                	jne    180a <printf+0x14e>
        putc(fd, *ap);
    17ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17f0:	8b 00                	mov    (%eax),%eax
    17f2:	0f be c0             	movsbl %al,%eax
    17f5:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f9:	8b 45 08             	mov    0x8(%ebp),%eax
    17fc:	89 04 24             	mov    %eax,(%esp)
    17ff:	e8 d8 fd ff ff       	call   15dc <putc>
        ap++;
    1804:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1808:	eb 45                	jmp    184f <printf+0x193>
      } else if(c == '%'){
    180a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    180e:	75 17                	jne    1827 <printf+0x16b>
        putc(fd, c);
    1810:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1813:	0f be c0             	movsbl %al,%eax
    1816:	89 44 24 04          	mov    %eax,0x4(%esp)
    181a:	8b 45 08             	mov    0x8(%ebp),%eax
    181d:	89 04 24             	mov    %eax,(%esp)
    1820:	e8 b7 fd ff ff       	call   15dc <putc>
    1825:	eb 28                	jmp    184f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1827:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    182e:	00 
    182f:	8b 45 08             	mov    0x8(%ebp),%eax
    1832:	89 04 24             	mov    %eax,(%esp)
    1835:	e8 a2 fd ff ff       	call   15dc <putc>
        putc(fd, c);
    183a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    183d:	0f be c0             	movsbl %al,%eax
    1840:	89 44 24 04          	mov    %eax,0x4(%esp)
    1844:	8b 45 08             	mov    0x8(%ebp),%eax
    1847:	89 04 24             	mov    %eax,(%esp)
    184a:	e8 8d fd ff ff       	call   15dc <putc>
      }
      state = 0;
    184f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1856:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    185a:	8b 55 0c             	mov    0xc(%ebp),%edx
    185d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1860:	01 d0                	add    %edx,%eax
    1862:	0f b6 00             	movzbl (%eax),%eax
    1865:	84 c0                	test   %al,%al
    1867:	0f 85 71 fe ff ff    	jne    16de <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    186d:	c9                   	leave  
    186e:	c3                   	ret    
    186f:	90                   	nop

00001870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	83 e8 08             	sub    $0x8,%eax
    187c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    187f:	a1 30 21 00 00       	mov    0x2130,%eax
    1884:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1887:	eb 24                	jmp    18ad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1889:	8b 45 fc             	mov    -0x4(%ebp),%eax
    188c:	8b 00                	mov    (%eax),%eax
    188e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1891:	77 12                	ja     18a5 <free+0x35>
    1893:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1896:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1899:	77 24                	ja     18bf <free+0x4f>
    189b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    189e:	8b 00                	mov    (%eax),%eax
    18a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18a3:	77 1a                	ja     18bf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18a8:	8b 00                	mov    (%eax),%eax
    18aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18b3:	76 d4                	jbe    1889 <free+0x19>
    18b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18b8:	8b 00                	mov    (%eax),%eax
    18ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18bd:	76 ca                	jbe    1889 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    18bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c2:	8b 40 04             	mov    0x4(%eax),%eax
    18c5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18cf:	01 c2                	add    %eax,%edx
    18d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d4:	8b 00                	mov    (%eax),%eax
    18d6:	39 c2                	cmp    %eax,%edx
    18d8:	75 24                	jne    18fe <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    18da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18dd:	8b 50 04             	mov    0x4(%eax),%edx
    18e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e3:	8b 00                	mov    (%eax),%eax
    18e5:	8b 40 04             	mov    0x4(%eax),%eax
    18e8:	01 c2                	add    %eax,%edx
    18ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18ed:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    18f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f3:	8b 00                	mov    (%eax),%eax
    18f5:	8b 10                	mov    (%eax),%edx
    18f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18fa:	89 10                	mov    %edx,(%eax)
    18fc:	eb 0a                	jmp    1908 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    18fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1901:	8b 10                	mov    (%eax),%edx
    1903:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1906:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1908:	8b 45 fc             	mov    -0x4(%ebp),%eax
    190b:	8b 40 04             	mov    0x4(%eax),%eax
    190e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1915:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1918:	01 d0                	add    %edx,%eax
    191a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    191d:	75 20                	jne    193f <free+0xcf>
    p->s.size += bp->s.size;
    191f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1922:	8b 50 04             	mov    0x4(%eax),%edx
    1925:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1928:	8b 40 04             	mov    0x4(%eax),%eax
    192b:	01 c2                	add    %eax,%edx
    192d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1930:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1933:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1936:	8b 10                	mov    (%eax),%edx
    1938:	8b 45 fc             	mov    -0x4(%ebp),%eax
    193b:	89 10                	mov    %edx,(%eax)
    193d:	eb 08                	jmp    1947 <free+0xd7>
  } else
    p->s.ptr = bp;
    193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1942:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1945:	89 10                	mov    %edx,(%eax)
  freep = p;
    1947:	8b 45 fc             	mov    -0x4(%ebp),%eax
    194a:	a3 30 21 00 00       	mov    %eax,0x2130
}
    194f:	c9                   	leave  
    1950:	c3                   	ret    

00001951 <morecore>:

static Header*
morecore(uint nu)
{
    1951:	55                   	push   %ebp
    1952:	89 e5                	mov    %esp,%ebp
    1954:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1957:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    195e:	77 07                	ja     1967 <morecore+0x16>
    nu = 4096;
    1960:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1967:	8b 45 08             	mov    0x8(%ebp),%eax
    196a:	c1 e0 03             	shl    $0x3,%eax
    196d:	89 04 24             	mov    %eax,(%esp)
    1970:	e8 27 fc ff ff       	call   159c <sbrk>
    1975:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1978:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    197c:	75 07                	jne    1985 <morecore+0x34>
    return 0;
    197e:	b8 00 00 00 00       	mov    $0x0,%eax
    1983:	eb 22                	jmp    19a7 <morecore+0x56>
  hp = (Header*)p;
    1985:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1988:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    198b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    198e:	8b 55 08             	mov    0x8(%ebp),%edx
    1991:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1994:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1997:	83 c0 08             	add    $0x8,%eax
    199a:	89 04 24             	mov    %eax,(%esp)
    199d:	e8 ce fe ff ff       	call   1870 <free>
  return freep;
    19a2:	a1 30 21 00 00       	mov    0x2130,%eax
}
    19a7:	c9                   	leave  
    19a8:	c3                   	ret    

000019a9 <malloc>:

void*
malloc(uint nbytes)
{
    19a9:	55                   	push   %ebp
    19aa:	89 e5                	mov    %esp,%ebp
    19ac:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	83 c0 07             	add    $0x7,%eax
    19b5:	c1 e8 03             	shr    $0x3,%eax
    19b8:	83 c0 01             	add    $0x1,%eax
    19bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    19be:	a1 30 21 00 00       	mov    0x2130,%eax
    19c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19ca:	75 23                	jne    19ef <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    19cc:	c7 45 f0 28 21 00 00 	movl   $0x2128,-0x10(%ebp)
    19d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19d6:	a3 30 21 00 00       	mov    %eax,0x2130
    19db:	a1 30 21 00 00       	mov    0x2130,%eax
    19e0:	a3 28 21 00 00       	mov    %eax,0x2128
    base.s.size = 0;
    19e5:	c7 05 2c 21 00 00 00 	movl   $0x0,0x212c
    19ec:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19f2:	8b 00                	mov    (%eax),%eax
    19f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fa:	8b 40 04             	mov    0x4(%eax),%eax
    19fd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a00:	72 4d                	jb     1a4f <malloc+0xa6>
      if(p->s.size == nunits)
    1a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a05:	8b 40 04             	mov    0x4(%eax),%eax
    1a08:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a0b:	75 0c                	jne    1a19 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a10:	8b 10                	mov    (%eax),%edx
    1a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a15:	89 10                	mov    %edx,(%eax)
    1a17:	eb 26                	jmp    1a3f <malloc+0x96>
      else {
        p->s.size -= nunits;
    1a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1c:	8b 40 04             	mov    0x4(%eax),%eax
    1a1f:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a22:	89 c2                	mov    %eax,%edx
    1a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a27:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2d:	8b 40 04             	mov    0x4(%eax),%eax
    1a30:	c1 e0 03             	shl    $0x3,%eax
    1a33:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a39:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a3c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a42:	a3 30 21 00 00       	mov    %eax,0x2130
      return (void*)(p + 1);
    1a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4a:	83 c0 08             	add    $0x8,%eax
    1a4d:	eb 38                	jmp    1a87 <malloc+0xde>
    }
    if(p == freep)
    1a4f:	a1 30 21 00 00       	mov    0x2130,%eax
    1a54:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1a57:	75 1b                	jne    1a74 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1a59:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a5c:	89 04 24             	mov    %eax,(%esp)
    1a5f:	e8 ed fe ff ff       	call   1951 <morecore>
    1a64:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a67:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a6b:	75 07                	jne    1a74 <malloc+0xcb>
        return 0;
    1a6d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a72:	eb 13                	jmp    1a87 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a77:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7d:	8b 00                	mov    (%eax),%eax
    1a7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1a82:	e9 70 ff ff ff       	jmp    19f7 <malloc+0x4e>
}
    1a87:	c9                   	leave  
    1a88:	c3                   	ret    
    1a89:	66 90                	xchg   %ax,%ax
    1a8b:	90                   	nop

00001a8c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1a8c:	55                   	push   %ebp
    1a8d:	89 e5                	mov    %esp,%ebp
    1a8f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1a92:	8b 55 08             	mov    0x8(%ebp),%edx
    1a95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a98:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a9b:	f0 87 02             	lock xchg %eax,(%edx)
    1a9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1aa1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1aa4:	c9                   	leave  
    1aa5:	c3                   	ret    

00001aa6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1aa6:	55                   	push   %ebp
    1aa7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1ab2:	5d                   	pop    %ebp
    1ab3:	c3                   	ret    

00001ab4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1ab4:	55                   	push   %ebp
    1ab5:	89 e5                	mov    %esp,%ebp
    1ab7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1aba:	90                   	nop
    1abb:	8b 45 08             	mov    0x8(%ebp),%eax
    1abe:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1ac5:	00 
    1ac6:	89 04 24             	mov    %eax,(%esp)
    1ac9:	e8 be ff ff ff       	call   1a8c <xchg>
    1ace:	85 c0                	test   %eax,%eax
    1ad0:	75 e9                	jne    1abb <lock_acquire+0x7>
}
    1ad2:	c9                   	leave  
    1ad3:	c3                   	ret    

00001ad4 <lock_release>:
void lock_release(lock_t *lock){
    1ad4:	55                   	push   %ebp
    1ad5:	89 e5                	mov    %esp,%ebp
    1ad7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1ada:	8b 45 08             	mov    0x8(%ebp),%eax
    1add:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ae4:	00 
    1ae5:	89 04 24             	mov    %eax,(%esp)
    1ae8:	e8 9f ff ff ff       	call   1a8c <xchg>
}
    1aed:	c9                   	leave  
    1aee:	c3                   	ret    

00001aef <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1aef:	55                   	push   %ebp
    1af0:	89 e5                	mov    %esp,%ebp
    1af2:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1af5:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1afc:	e8 a8 fe ff ff       	call   19a9 <malloc>
    1b01:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b07:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b0d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1b12:	85 c0                	test   %eax,%eax
    1b14:	74 14                	je     1b2a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b19:	25 ff 0f 00 00       	and    $0xfff,%eax
    1b1e:	89 c2                	mov    %eax,%edx
    1b20:	b8 00 10 00 00       	mov    $0x1000,%eax
    1b25:	29 d0                	sub    %edx,%eax
    1b27:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1b2a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b2e:	75 1b                	jne    1b4b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1b30:	c7 44 24 04 26 1d 00 	movl   $0x1d26,0x4(%esp)
    1b37:	00 
    1b38:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b3f:	e8 78 fb ff ff       	call   16bc <printf>
        return 0;
    1b44:	b8 00 00 00 00       	mov    $0x0,%eax
    1b49:	eb 6f                	jmp    1bba <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1b4b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b4e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b54:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1b58:	89 54 24 08          	mov    %edx,0x8(%esp)
    1b5c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1b63:	00 
    1b64:	89 04 24             	mov    %eax,(%esp)
    1b67:	e8 48 fa ff ff       	call   15b4 <clone>
    1b6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1b6f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b73:	79 1b                	jns    1b90 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1b75:	c7 44 24 04 34 1d 00 	movl   $0x1d34,0x4(%esp)
    1b7c:	00 
    1b7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b84:	e8 33 fb ff ff       	call   16bc <printf>
        return 0;
    1b89:	b8 00 00 00 00       	mov    $0x0,%eax
    1b8e:	eb 2a                	jmp    1bba <thread_create+0xcb>
    }
    if(tid > 0){
    1b90:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b94:	7e 05                	jle    1b9b <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b99:	eb 1f                	jmp    1bba <thread_create+0xcb>
    }
    if(tid == 0){
    1b9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b9f:	75 14                	jne    1bb5 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1ba1:	c7 44 24 04 41 1d 00 	movl   $0x1d41,0x4(%esp)
    1ba8:	00 
    1ba9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bb0:	e8 07 fb ff ff       	call   16bc <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1bb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1bba:	c9                   	leave  
    1bbb:	c3                   	ret    

00001bbc <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1bbc:	55                   	push   %ebp
    1bbd:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1bbf:	a1 24 21 00 00       	mov    0x2124,%eax
    1bc4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1bca:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1bcf:	a3 24 21 00 00       	mov    %eax,0x2124
    return (int)(rands % max);
    1bd4:	a1 24 21 00 00       	mov    0x2124,%eax
    1bd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bdc:	ba 00 00 00 00       	mov    $0x0,%edx
    1be1:	f7 f1                	div    %ecx
    1be3:	89 d0                	mov    %edx,%eax
}
    1be5:	5d                   	pop    %ebp
    1be6:	c3                   	ret    
    1be7:	90                   	nop

00001be8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1be8:	55                   	push   %ebp
    1be9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1beb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1bf4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1bfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1c01:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1c08:	5d                   	pop    %ebp
    1c09:	c3                   	ret    

00001c0a <add_q>:

void add_q(struct queue *q, int v){
    1c0a:	55                   	push   %ebp
    1c0b:	89 e5                	mov    %esp,%ebp
    1c0d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1c10:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1c17:	e8 8d fd ff ff       	call   19a9 <malloc>
    1c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c22:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c2f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1c31:	8b 45 08             	mov    0x8(%ebp),%eax
    1c34:	8b 40 04             	mov    0x4(%eax),%eax
    1c37:	85 c0                	test   %eax,%eax
    1c39:	75 0b                	jne    1c46 <add_q+0x3c>
        q->head = n;
    1c3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c41:	89 50 04             	mov    %edx,0x4(%eax)
    1c44:	eb 0c                	jmp    1c52 <add_q+0x48>
    }else{
        q->tail->next = n;
    1c46:	8b 45 08             	mov    0x8(%ebp),%eax
    1c49:	8b 40 08             	mov    0x8(%eax),%eax
    1c4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c4f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1c52:	8b 45 08             	mov    0x8(%ebp),%eax
    1c55:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c58:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1c5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5e:	8b 00                	mov    (%eax),%eax
    1c60:	8d 50 01             	lea    0x1(%eax),%edx
    1c63:	8b 45 08             	mov    0x8(%ebp),%eax
    1c66:	89 10                	mov    %edx,(%eax)
}
    1c68:	c9                   	leave  
    1c69:	c3                   	ret    

00001c6a <empty_q>:

int empty_q(struct queue *q){
    1c6a:	55                   	push   %ebp
    1c6b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1c6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c70:	8b 00                	mov    (%eax),%eax
    1c72:	85 c0                	test   %eax,%eax
    1c74:	75 07                	jne    1c7d <empty_q+0x13>
        return 1;
    1c76:	b8 01 00 00 00       	mov    $0x1,%eax
    1c7b:	eb 05                	jmp    1c82 <empty_q+0x18>
    else
        return 0;
    1c7d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1c82:	5d                   	pop    %ebp
    1c83:	c3                   	ret    

00001c84 <pop_q>:
int pop_q(struct queue *q){
    1c84:	55                   	push   %ebp
    1c85:	89 e5                	mov    %esp,%ebp
    1c87:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1c8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8d:	89 04 24             	mov    %eax,(%esp)
    1c90:	e8 d5 ff ff ff       	call   1c6a <empty_q>
    1c95:	85 c0                	test   %eax,%eax
    1c97:	75 5d                	jne    1cf6 <pop_q+0x72>
       val = q->head->value; 
    1c99:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9c:	8b 40 04             	mov    0x4(%eax),%eax
    1c9f:	8b 00                	mov    (%eax),%eax
    1ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1ca4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca7:	8b 40 04             	mov    0x4(%eax),%eax
    1caa:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1cad:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb0:	8b 40 04             	mov    0x4(%eax),%eax
    1cb3:	8b 50 04             	mov    0x4(%eax),%edx
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1cbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cbf:	89 04 24             	mov    %eax,(%esp)
    1cc2:	e8 a9 fb ff ff       	call   1870 <free>
       q->size--;
    1cc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cca:	8b 00                	mov    (%eax),%eax
    1ccc:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ccf:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1cd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd7:	8b 00                	mov    (%eax),%eax
    1cd9:	85 c0                	test   %eax,%eax
    1cdb:	75 14                	jne    1cf1 <pop_q+0x6d>
            q->head = 0;
    1cdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ce7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cea:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cf4:	eb 05                	jmp    1cfb <pop_q+0x77>
    }
    return -1;
    1cf6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1cfb:	c9                   	leave  
    1cfc:	c3                   	ret    
