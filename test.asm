
_test:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

int n = 1;

void test_func(void * arg_ptr);

int main(int argc, char *argv[]){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp

   printf(1,"thread_create test begin\n\n");
    1009:	c7 44 24 04 1d 1b 00 	movl   $0x1b1d,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 c8 04 00 00       	call   14e5 <printf>

   printf(1,"before thread_create n = %d\n",n);
    101d:	a1 c4 1b 00 00       	mov    0x1bc4,%eax
    1022:	89 44 24 08          	mov    %eax,0x8(%esp)
    1026:	c7 44 24 04 38 1b 00 	movl   $0x1b38,0x4(%esp)
    102d:	00 
    102e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1035:	e8 ab 04 00 00       	call   14e5 <printf>

   int arg = 10;
    103a:	c7 44 24 18 0a 00 00 	movl   $0xa,0x18(%esp)
    1041:	00 
   void *tid = thread_create(test_func, (void *)&arg);
    1042:	8d 44 24 18          	lea    0x18(%esp),%eax
    1046:	89 44 24 04          	mov    %eax,0x4(%esp)
    104a:	c7 04 24 a8 10 00 00 	movl   $0x10a8,(%esp)
    1051:	e8 b8 08 00 00       	call   190e <thread_create>
    1056:	89 44 24 1c          	mov    %eax,0x1c(%esp)
   if(tid <= 0){
    105a:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    105f:	75 38                	jne    1099 <main+0x99>
       printf(1,"wrong happen");
    1061:	c7 44 24 04 55 1b 00 	movl   $0x1b55,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 70 04 00 00       	call   14e5 <printf>
       exit();
    1075:	e8 ca 02 00 00       	call   1344 <exit>
   } 
   while(wait()>= 0)
   printf(1,"\nback to parent n = %d\n",n);
    107a:	a1 c4 1b 00 00       	mov    0x1bc4,%eax
    107f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1083:	c7 44 24 04 62 1b 00 	movl   $0x1b62,0x4(%esp)
    108a:	00 
    108b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1092:	e8 4e 04 00 00       	call   14e5 <printf>
    1097:	eb 01                	jmp    109a <main+0x9a>
   void *tid = thread_create(test_func, (void *)&arg);
   if(tid <= 0){
       printf(1,"wrong happen");
       exit();
   } 
   while(wait()>= 0)
    1099:	90                   	nop
    109a:	e8 ad 02 00 00       	call   134c <wait>
    109f:	85 c0                	test   %eax,%eax
    10a1:	79 d7                	jns    107a <main+0x7a>
   printf(1,"\nback to parent n = %d\n",n);
   
   exit();
    10a3:	e8 9c 02 00 00       	call   1344 <exit>

000010a8 <test_func>:
}

//void test_func(void *arg_ptr){
void test_func(void *arg_ptr){
    10a8:	55                   	push   %ebp
    10a9:	89 e5                	mov    %esp,%ebp
    10ab:	83 ec 28             	sub    $0x28,%esp
    int * num = (int *)arg_ptr;
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n = *num; 
    10b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b7:	8b 00                	mov    (%eax),%eax
    10b9:	a3 c4 1b 00 00       	mov    %eax,0x1bc4
    printf(1,"\n n is updated as %d\n",*num);
    10be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c1:	8b 00                	mov    (%eax),%eax
    10c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c7:	c7 44 24 04 7a 1b 00 	movl   $0x1b7a,0x4(%esp)
    10ce:	00 
    10cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d6:	e8 0a 04 00 00       	call   14e5 <printf>
    texit();
    10db:	e8 0c 03 00 00       	call   13ec <texit>

000010e0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    10e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10e8:	8b 55 10             	mov    0x10(%ebp),%edx
    10eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ee:	89 cb                	mov    %ecx,%ebx
    10f0:	89 df                	mov    %ebx,%edi
    10f2:	89 d1                	mov    %edx,%ecx
    10f4:	fc                   	cld    
    10f5:	f3 aa                	rep stos %al,%es:(%edi)
    10f7:	89 ca                	mov    %ecx,%edx
    10f9:	89 fb                	mov    %edi,%ebx
    10fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10fe:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1101:	5b                   	pop    %ebx
    1102:	5f                   	pop    %edi
    1103:	5d                   	pop    %ebp
    1104:	c3                   	ret    

00001105 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1105:	55                   	push   %ebp
    1106:	89 e5                	mov    %esp,%ebp
    1108:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    110b:	8b 45 08             	mov    0x8(%ebp),%eax
    110e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1111:	8b 45 0c             	mov    0xc(%ebp),%eax
    1114:	0f b6 10             	movzbl (%eax),%edx
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	88 10                	mov    %dl,(%eax)
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	0f b6 00             	movzbl (%eax),%eax
    1122:	84 c0                	test   %al,%al
    1124:	0f 95 c0             	setne  %al
    1127:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    112b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    112f:	84 c0                	test   %al,%al
    1131:	75 de                	jne    1111 <strcpy+0xc>
    ;
  return os;
    1133:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1136:	c9                   	leave  
    1137:	c3                   	ret    

00001138 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1138:	55                   	push   %ebp
    1139:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    113b:	eb 08                	jmp    1145 <strcmp+0xd>
    p++, q++;
    113d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1141:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	0f b6 00             	movzbl (%eax),%eax
    114b:	84 c0                	test   %al,%al
    114d:	74 10                	je     115f <strcmp+0x27>
    114f:	8b 45 08             	mov    0x8(%ebp),%eax
    1152:	0f b6 10             	movzbl (%eax),%edx
    1155:	8b 45 0c             	mov    0xc(%ebp),%eax
    1158:	0f b6 00             	movzbl (%eax),%eax
    115b:	38 c2                	cmp    %al,%dl
    115d:	74 de                	je     113d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    115f:	8b 45 08             	mov    0x8(%ebp),%eax
    1162:	0f b6 00             	movzbl (%eax),%eax
    1165:	0f b6 d0             	movzbl %al,%edx
    1168:	8b 45 0c             	mov    0xc(%ebp),%eax
    116b:	0f b6 00             	movzbl (%eax),%eax
    116e:	0f b6 c0             	movzbl %al,%eax
    1171:	89 d1                	mov    %edx,%ecx
    1173:	29 c1                	sub    %eax,%ecx
    1175:	89 c8                	mov    %ecx,%eax
}
    1177:	5d                   	pop    %ebp
    1178:	c3                   	ret    

00001179 <strlen>:

uint
strlen(char *s)
{
    1179:	55                   	push   %ebp
    117a:	89 e5                	mov    %esp,%ebp
    117c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    117f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1186:	eb 04                	jmp    118c <strlen+0x13>
    1188:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    118c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    118f:	03 45 08             	add    0x8(%ebp),%eax
    1192:	0f b6 00             	movzbl (%eax),%eax
    1195:	84 c0                	test   %al,%al
    1197:	75 ef                	jne    1188 <strlen+0xf>
    ;
  return n;
    1199:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    119c:	c9                   	leave  
    119d:	c3                   	ret    

0000119e <memset>:

void*
memset(void *dst, int c, uint n)
{
    119e:	55                   	push   %ebp
    119f:	89 e5                	mov    %esp,%ebp
    11a1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    11a4:	8b 45 10             	mov    0x10(%ebp),%eax
    11a7:	89 44 24 08          	mov    %eax,0x8(%esp)
    11ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ae:	89 44 24 04          	mov    %eax,0x4(%esp)
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	89 04 24             	mov    %eax,(%esp)
    11b8:	e8 23 ff ff ff       	call   10e0 <stosb>
  return dst;
    11bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11c0:	c9                   	leave  
    11c1:	c3                   	ret    

000011c2 <strchr>:

char*
strchr(const char *s, char c)
{
    11c2:	55                   	push   %ebp
    11c3:	89 e5                	mov    %esp,%ebp
    11c5:	83 ec 04             	sub    $0x4,%esp
    11c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11ce:	eb 14                	jmp    11e4 <strchr+0x22>
    if(*s == c)
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	0f b6 00             	movzbl (%eax),%eax
    11d6:	3a 45 fc             	cmp    -0x4(%ebp),%al
    11d9:	75 05                	jne    11e0 <strchr+0x1e>
      return (char*)s;
    11db:	8b 45 08             	mov    0x8(%ebp),%eax
    11de:	eb 13                	jmp    11f3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11e4:	8b 45 08             	mov    0x8(%ebp),%eax
    11e7:	0f b6 00             	movzbl (%eax),%eax
    11ea:	84 c0                	test   %al,%al
    11ec:	75 e2                	jne    11d0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    11ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11f3:	c9                   	leave  
    11f4:	c3                   	ret    

000011f5 <gets>:

char*
gets(char *buf, int max)
{
    11f5:	55                   	push   %ebp
    11f6:	89 e5                	mov    %esp,%ebp
    11f8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1202:	eb 44                	jmp    1248 <gets+0x53>
    cc = read(0, &c, 1);
    1204:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    120b:	00 
    120c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    120f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1213:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    121a:	e8 3d 01 00 00       	call   135c <read>
    121f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1222:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1226:	7e 2d                	jle    1255 <gets+0x60>
      break;
    buf[i++] = c;
    1228:	8b 45 f0             	mov    -0x10(%ebp),%eax
    122b:	03 45 08             	add    0x8(%ebp),%eax
    122e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1232:	88 10                	mov    %dl,(%eax)
    1234:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1238:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    123c:	3c 0a                	cmp    $0xa,%al
    123e:	74 16                	je     1256 <gets+0x61>
    1240:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1244:	3c 0d                	cmp    $0xd,%al
    1246:	74 0e                	je     1256 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1248:	8b 45 f0             	mov    -0x10(%ebp),%eax
    124b:	83 c0 01             	add    $0x1,%eax
    124e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1251:	7c b1                	jl     1204 <gets+0xf>
    1253:	eb 01                	jmp    1256 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1255:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1256:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1259:	03 45 08             	add    0x8(%ebp),%eax
    125c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    125f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1262:	c9                   	leave  
    1263:	c3                   	ret    

00001264 <stat>:

int
stat(char *n, struct stat *st)
{
    1264:	55                   	push   %ebp
    1265:	89 e5                	mov    %esp,%ebp
    1267:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    126a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1271:	00 
    1272:	8b 45 08             	mov    0x8(%ebp),%eax
    1275:	89 04 24             	mov    %eax,(%esp)
    1278:	e8 07 01 00 00       	call   1384 <open>
    127d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1284:	79 07                	jns    128d <stat+0x29>
    return -1;
    1286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    128b:	eb 23                	jmp    12b0 <stat+0x4c>
  r = fstat(fd, st);
    128d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1290:	89 44 24 04          	mov    %eax,0x4(%esp)
    1294:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1297:	89 04 24             	mov    %eax,(%esp)
    129a:	e8 fd 00 00 00       	call   139c <fstat>
    129f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    12a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12a5:	89 04 24             	mov    %eax,(%esp)
    12a8:	e8 bf 00 00 00       	call   136c <close>
  return r;
    12ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12b0:	c9                   	leave  
    12b1:	c3                   	ret    

000012b2 <atoi>:

int
atoi(const char *s)
{
    12b2:	55                   	push   %ebp
    12b3:	89 e5                	mov    %esp,%ebp
    12b5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12bf:	eb 24                	jmp    12e5 <atoi+0x33>
    n = n*10 + *s++ - '0';
    12c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12c4:	89 d0                	mov    %edx,%eax
    12c6:	c1 e0 02             	shl    $0x2,%eax
    12c9:	01 d0                	add    %edx,%eax
    12cb:	01 c0                	add    %eax,%eax
    12cd:	89 c2                	mov    %eax,%edx
    12cf:	8b 45 08             	mov    0x8(%ebp),%eax
    12d2:	0f b6 00             	movzbl (%eax),%eax
    12d5:	0f be c0             	movsbl %al,%eax
    12d8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    12db:	83 e8 30             	sub    $0x30,%eax
    12de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12e5:	8b 45 08             	mov    0x8(%ebp),%eax
    12e8:	0f b6 00             	movzbl (%eax),%eax
    12eb:	3c 2f                	cmp    $0x2f,%al
    12ed:	7e 0a                	jle    12f9 <atoi+0x47>
    12ef:	8b 45 08             	mov    0x8(%ebp),%eax
    12f2:	0f b6 00             	movzbl (%eax),%eax
    12f5:	3c 39                	cmp    $0x39,%al
    12f7:	7e c8                	jle    12c1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12fc:	c9                   	leave  
    12fd:	c3                   	ret    

000012fe <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12fe:	55                   	push   %ebp
    12ff:	89 e5                	mov    %esp,%ebp
    1301:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1304:	8b 45 08             	mov    0x8(%ebp),%eax
    1307:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    130a:	8b 45 0c             	mov    0xc(%ebp),%eax
    130d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1310:	eb 13                	jmp    1325 <memmove+0x27>
    *dst++ = *src++;
    1312:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1315:	0f b6 10             	movzbl (%eax),%edx
    1318:	8b 45 f8             	mov    -0x8(%ebp),%eax
    131b:	88 10                	mov    %dl,(%eax)
    131d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1321:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1325:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1329:	0f 9f c0             	setg   %al
    132c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1330:	84 c0                	test   %al,%al
    1332:	75 de                	jne    1312 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1337:	c9                   	leave  
    1338:	c3                   	ret    
    1339:	90                   	nop
    133a:	90                   	nop
    133b:	90                   	nop

0000133c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    133c:	b8 01 00 00 00       	mov    $0x1,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <exit>:
SYSCALL(exit)
    1344:	b8 02 00 00 00       	mov    $0x2,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <wait>:
SYSCALL(wait)
    134c:	b8 03 00 00 00       	mov    $0x3,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <pipe>:
SYSCALL(pipe)
    1354:	b8 04 00 00 00       	mov    $0x4,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <read>:
SYSCALL(read)
    135c:	b8 05 00 00 00       	mov    $0x5,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <write>:
SYSCALL(write)
    1364:	b8 10 00 00 00       	mov    $0x10,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <close>:
SYSCALL(close)
    136c:	b8 15 00 00 00       	mov    $0x15,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <kill>:
SYSCALL(kill)
    1374:	b8 06 00 00 00       	mov    $0x6,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <exec>:
SYSCALL(exec)
    137c:	b8 07 00 00 00       	mov    $0x7,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <open>:
SYSCALL(open)
    1384:	b8 0f 00 00 00       	mov    $0xf,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <mknod>:
SYSCALL(mknod)
    138c:	b8 11 00 00 00       	mov    $0x11,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <unlink>:
SYSCALL(unlink)
    1394:	b8 12 00 00 00       	mov    $0x12,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <fstat>:
SYSCALL(fstat)
    139c:	b8 08 00 00 00       	mov    $0x8,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <link>:
SYSCALL(link)
    13a4:	b8 13 00 00 00       	mov    $0x13,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <mkdir>:
SYSCALL(mkdir)
    13ac:	b8 14 00 00 00       	mov    $0x14,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <chdir>:
SYSCALL(chdir)
    13b4:	b8 09 00 00 00       	mov    $0x9,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <dup>:
SYSCALL(dup)
    13bc:	b8 0a 00 00 00       	mov    $0xa,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <getpid>:
SYSCALL(getpid)
    13c4:	b8 0b 00 00 00       	mov    $0xb,%eax
    13c9:	cd 40                	int    $0x40
    13cb:	c3                   	ret    

000013cc <sbrk>:
SYSCALL(sbrk)
    13cc:	b8 0c 00 00 00       	mov    $0xc,%eax
    13d1:	cd 40                	int    $0x40
    13d3:	c3                   	ret    

000013d4 <sleep>:
SYSCALL(sleep)
    13d4:	b8 0d 00 00 00       	mov    $0xd,%eax
    13d9:	cd 40                	int    $0x40
    13db:	c3                   	ret    

000013dc <uptime>:
SYSCALL(uptime)
    13dc:	b8 0e 00 00 00       	mov    $0xe,%eax
    13e1:	cd 40                	int    $0x40
    13e3:	c3                   	ret    

000013e4 <clone>:
SYSCALL(clone)
    13e4:	b8 16 00 00 00       	mov    $0x16,%eax
    13e9:	cd 40                	int    $0x40
    13eb:	c3                   	ret    

000013ec <texit>:
SYSCALL(texit)
    13ec:	b8 17 00 00 00       	mov    $0x17,%eax
    13f1:	cd 40                	int    $0x40
    13f3:	c3                   	ret    

000013f4 <tsleep>:
SYSCALL(tsleep)
    13f4:	b8 18 00 00 00       	mov    $0x18,%eax
    13f9:	cd 40                	int    $0x40
    13fb:	c3                   	ret    

000013fc <twakeup>:
SYSCALL(twakeup)
    13fc:	b8 19 00 00 00       	mov    $0x19,%eax
    1401:	cd 40                	int    $0x40
    1403:	c3                   	ret    

00001404 <thread_yield>:
SYSCALL(thread_yield)
    1404:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1409:	cd 40                	int    $0x40
    140b:	c3                   	ret    

0000140c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    140c:	55                   	push   %ebp
    140d:	89 e5                	mov    %esp,%ebp
    140f:	83 ec 28             	sub    $0x28,%esp
    1412:	8b 45 0c             	mov    0xc(%ebp),%eax
    1415:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1418:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    141f:	00 
    1420:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1423:	89 44 24 04          	mov    %eax,0x4(%esp)
    1427:	8b 45 08             	mov    0x8(%ebp),%eax
    142a:	89 04 24             	mov    %eax,(%esp)
    142d:	e8 32 ff ff ff       	call   1364 <write>
}
    1432:	c9                   	leave  
    1433:	c3                   	ret    

00001434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1434:	55                   	push   %ebp
    1435:	89 e5                	mov    %esp,%ebp
    1437:	53                   	push   %ebx
    1438:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    143b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1442:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1446:	74 17                	je     145f <printint+0x2b>
    1448:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    144c:	79 11                	jns    145f <printint+0x2b>
    neg = 1;
    144e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1455:	8b 45 0c             	mov    0xc(%ebp),%eax
    1458:	f7 d8                	neg    %eax
    145a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    145d:	eb 06                	jmp    1465 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    145f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1462:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1465:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    146c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    146f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1472:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1475:	ba 00 00 00 00       	mov    $0x0,%edx
    147a:	f7 f3                	div    %ebx
    147c:	89 d0                	mov    %edx,%eax
    147e:	0f b6 80 c8 1b 00 00 	movzbl 0x1bc8(%eax),%eax
    1485:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1489:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    148d:	8b 45 10             	mov    0x10(%ebp),%eax
    1490:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1496:	ba 00 00 00 00       	mov    $0x0,%edx
    149b:	f7 75 d4             	divl   -0x2c(%ebp)
    149e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14a5:	75 c5                	jne    146c <printint+0x38>
  if(neg)
    14a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14ab:	74 28                	je     14d5 <printint+0xa1>
    buf[i++] = '-';
    14ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    14b5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    14b9:	eb 1a                	jmp    14d5 <printint+0xa1>
    putc(fd, buf[i]);
    14bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14be:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    14c3:	0f be c0             	movsbl %al,%eax
    14c6:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ca:	8b 45 08             	mov    0x8(%ebp),%eax
    14cd:	89 04 24             	mov    %eax,(%esp)
    14d0:	e8 37 ff ff ff       	call   140c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14d5:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    14d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14dd:	79 dc                	jns    14bb <printint+0x87>
    putc(fd, buf[i]);
}
    14df:	83 c4 44             	add    $0x44,%esp
    14e2:	5b                   	pop    %ebx
    14e3:	5d                   	pop    %ebp
    14e4:	c3                   	ret    

000014e5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14e5:	55                   	push   %ebp
    14e6:	89 e5                	mov    %esp,%ebp
    14e8:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14f2:	8d 45 0c             	lea    0xc(%ebp),%eax
    14f5:	83 c0 04             	add    $0x4,%eax
    14f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    14fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1502:	e9 7e 01 00 00       	jmp    1685 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1507:	8b 55 0c             	mov    0xc(%ebp),%edx
    150a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    150d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1510:	0f b6 00             	movzbl (%eax),%eax
    1513:	0f be c0             	movsbl %al,%eax
    1516:	25 ff 00 00 00       	and    $0xff,%eax
    151b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    151e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1522:	75 2c                	jne    1550 <printf+0x6b>
      if(c == '%'){
    1524:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1528:	75 0c                	jne    1536 <printf+0x51>
        state = '%';
    152a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1531:	e9 4b 01 00 00       	jmp    1681 <printf+0x19c>
      } else {
        putc(fd, c);
    1536:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1539:	0f be c0             	movsbl %al,%eax
    153c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1540:	8b 45 08             	mov    0x8(%ebp),%eax
    1543:	89 04 24             	mov    %eax,(%esp)
    1546:	e8 c1 fe ff ff       	call   140c <putc>
    154b:	e9 31 01 00 00       	jmp    1681 <printf+0x19c>
      }
    } else if(state == '%'){
    1550:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1554:	0f 85 27 01 00 00    	jne    1681 <printf+0x19c>
      if(c == 'd'){
    155a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    155e:	75 2d                	jne    158d <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1560:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1563:	8b 00                	mov    (%eax),%eax
    1565:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    156c:	00 
    156d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1574:	00 
    1575:	89 44 24 04          	mov    %eax,0x4(%esp)
    1579:	8b 45 08             	mov    0x8(%ebp),%eax
    157c:	89 04 24             	mov    %eax,(%esp)
    157f:	e8 b0 fe ff ff       	call   1434 <printint>
        ap++;
    1584:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1588:	e9 ed 00 00 00       	jmp    167a <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    158d:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1591:	74 06                	je     1599 <printf+0xb4>
    1593:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1597:	75 2d                	jne    15c6 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1599:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159c:	8b 00                	mov    (%eax),%eax
    159e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15a5:	00 
    15a6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15ad:	00 
    15ae:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b2:	8b 45 08             	mov    0x8(%ebp),%eax
    15b5:	89 04 24             	mov    %eax,(%esp)
    15b8:	e8 77 fe ff ff       	call   1434 <printint>
        ap++;
    15bd:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15c1:	e9 b4 00 00 00       	jmp    167a <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15c6:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    15ca:	75 46                	jne    1612 <printf+0x12d>
        s = (char*)*ap;
    15cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cf:	8b 00                	mov    (%eax),%eax
    15d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    15d4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    15d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    15dc:	75 27                	jne    1605 <printf+0x120>
          s = "(null)";
    15de:	c7 45 e4 90 1b 00 00 	movl   $0x1b90,-0x1c(%ebp)
        while(*s != 0){
    15e5:	eb 1f                	jmp    1606 <printf+0x121>
          putc(fd, *s);
    15e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ea:	0f b6 00             	movzbl (%eax),%eax
    15ed:	0f be c0             	movsbl %al,%eax
    15f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f4:	8b 45 08             	mov    0x8(%ebp),%eax
    15f7:	89 04 24             	mov    %eax,(%esp)
    15fa:	e8 0d fe ff ff       	call   140c <putc>
          s++;
    15ff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1603:	eb 01                	jmp    1606 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1605:	90                   	nop
    1606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1609:	0f b6 00             	movzbl (%eax),%eax
    160c:	84 c0                	test   %al,%al
    160e:	75 d7                	jne    15e7 <printf+0x102>
    1610:	eb 68                	jmp    167a <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1612:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1616:	75 1d                	jne    1635 <printf+0x150>
        putc(fd, *ap);
    1618:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161b:	8b 00                	mov    (%eax),%eax
    161d:	0f be c0             	movsbl %al,%eax
    1620:	89 44 24 04          	mov    %eax,0x4(%esp)
    1624:	8b 45 08             	mov    0x8(%ebp),%eax
    1627:	89 04 24             	mov    %eax,(%esp)
    162a:	e8 dd fd ff ff       	call   140c <putc>
        ap++;
    162f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1633:	eb 45                	jmp    167a <printf+0x195>
      } else if(c == '%'){
    1635:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1639:	75 17                	jne    1652 <printf+0x16d>
        putc(fd, c);
    163b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    163e:	0f be c0             	movsbl %al,%eax
    1641:	89 44 24 04          	mov    %eax,0x4(%esp)
    1645:	8b 45 08             	mov    0x8(%ebp),%eax
    1648:	89 04 24             	mov    %eax,(%esp)
    164b:	e8 bc fd ff ff       	call   140c <putc>
    1650:	eb 28                	jmp    167a <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1652:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1659:	00 
    165a:	8b 45 08             	mov    0x8(%ebp),%eax
    165d:	89 04 24             	mov    %eax,(%esp)
    1660:	e8 a7 fd ff ff       	call   140c <putc>
        putc(fd, c);
    1665:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1668:	0f be c0             	movsbl %al,%eax
    166b:	89 44 24 04          	mov    %eax,0x4(%esp)
    166f:	8b 45 08             	mov    0x8(%ebp),%eax
    1672:	89 04 24             	mov    %eax,(%esp)
    1675:	e8 92 fd ff ff       	call   140c <putc>
      }
      state = 0;
    167a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1681:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1685:	8b 55 0c             	mov    0xc(%ebp),%edx
    1688:	8b 45 ec             	mov    -0x14(%ebp),%eax
    168b:	8d 04 02             	lea    (%edx,%eax,1),%eax
    168e:	0f b6 00             	movzbl (%eax),%eax
    1691:	84 c0                	test   %al,%al
    1693:	0f 85 6e fe ff ff    	jne    1507 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1699:	c9                   	leave  
    169a:	c3                   	ret    
    169b:	90                   	nop

0000169c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    169c:	55                   	push   %ebp
    169d:	89 e5                	mov    %esp,%ebp
    169f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16a2:	8b 45 08             	mov    0x8(%ebp),%eax
    16a5:	83 e8 08             	sub    $0x8,%eax
    16a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16ab:	a1 e8 1b 00 00       	mov    0x1be8,%eax
    16b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16b3:	eb 24                	jmp    16d9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16bd:	77 12                	ja     16d1 <free+0x35>
    16bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16c5:	77 24                	ja     16eb <free+0x4f>
    16c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ca:	8b 00                	mov    (%eax),%eax
    16cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16cf:	77 1a                	ja     16eb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	8b 00                	mov    (%eax),%eax
    16d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16df:	76 d4                	jbe    16b5 <free+0x19>
    16e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e4:	8b 00                	mov    (%eax),%eax
    16e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16e9:	76 ca                	jbe    16b5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ee:	8b 40 04             	mov    0x4(%eax),%eax
    16f1:	c1 e0 03             	shl    $0x3,%eax
    16f4:	89 c2                	mov    %eax,%edx
    16f6:	03 55 f8             	add    -0x8(%ebp),%edx
    16f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fc:	8b 00                	mov    (%eax),%eax
    16fe:	39 c2                	cmp    %eax,%edx
    1700:	75 24                	jne    1726 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1702:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1705:	8b 50 04             	mov    0x4(%eax),%edx
    1708:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170b:	8b 00                	mov    (%eax),%eax
    170d:	8b 40 04             	mov    0x4(%eax),%eax
    1710:	01 c2                	add    %eax,%edx
    1712:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1715:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1718:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171b:	8b 00                	mov    (%eax),%eax
    171d:	8b 10                	mov    (%eax),%edx
    171f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1722:	89 10                	mov    %edx,(%eax)
    1724:	eb 0a                	jmp    1730 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1726:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1729:	8b 10                	mov    (%eax),%edx
    172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    172e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1730:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1733:	8b 40 04             	mov    0x4(%eax),%eax
    1736:	c1 e0 03             	shl    $0x3,%eax
    1739:	03 45 fc             	add    -0x4(%ebp),%eax
    173c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    173f:	75 20                	jne    1761 <free+0xc5>
    p->s.size += bp->s.size;
    1741:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1744:	8b 50 04             	mov    0x4(%eax),%edx
    1747:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174a:	8b 40 04             	mov    0x4(%eax),%eax
    174d:	01 c2                	add    %eax,%edx
    174f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1752:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1755:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1758:	8b 10                	mov    (%eax),%edx
    175a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175d:	89 10                	mov    %edx,(%eax)
    175f:	eb 08                	jmp    1769 <free+0xcd>
  } else
    p->s.ptr = bp;
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1764:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1767:	89 10                	mov    %edx,(%eax)
  freep = p;
    1769:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176c:	a3 e8 1b 00 00       	mov    %eax,0x1be8
}
    1771:	c9                   	leave  
    1772:	c3                   	ret    

00001773 <morecore>:

static Header*
morecore(uint nu)
{
    1773:	55                   	push   %ebp
    1774:	89 e5                	mov    %esp,%ebp
    1776:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1779:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1780:	77 07                	ja     1789 <morecore+0x16>
    nu = 4096;
    1782:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1789:	8b 45 08             	mov    0x8(%ebp),%eax
    178c:	c1 e0 03             	shl    $0x3,%eax
    178f:	89 04 24             	mov    %eax,(%esp)
    1792:	e8 35 fc ff ff       	call   13cc <sbrk>
    1797:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    179a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    179e:	75 07                	jne    17a7 <morecore+0x34>
    return 0;
    17a0:	b8 00 00 00 00       	mov    $0x0,%eax
    17a5:	eb 22                	jmp    17c9 <morecore+0x56>
  hp = (Header*)p;
    17a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	8b 55 08             	mov    0x8(%ebp),%edx
    17b3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b9:	83 c0 08             	add    $0x8,%eax
    17bc:	89 04 24             	mov    %eax,(%esp)
    17bf:	e8 d8 fe ff ff       	call   169c <free>
  return freep;
    17c4:	a1 e8 1b 00 00       	mov    0x1be8,%eax
}
    17c9:	c9                   	leave  
    17ca:	c3                   	ret    

000017cb <malloc>:

void*
malloc(uint nbytes)
{
    17cb:	55                   	push   %ebp
    17cc:	89 e5                	mov    %esp,%ebp
    17ce:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17d1:	8b 45 08             	mov    0x8(%ebp),%eax
    17d4:	83 c0 07             	add    $0x7,%eax
    17d7:	c1 e8 03             	shr    $0x3,%eax
    17da:	83 c0 01             	add    $0x1,%eax
    17dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    17e0:	a1 e8 1b 00 00       	mov    0x1be8,%eax
    17e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17ec:	75 23                	jne    1811 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    17ee:	c7 45 f0 e0 1b 00 00 	movl   $0x1be0,-0x10(%ebp)
    17f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f8:	a3 e8 1b 00 00       	mov    %eax,0x1be8
    17fd:	a1 e8 1b 00 00       	mov    0x1be8,%eax
    1802:	a3 e0 1b 00 00       	mov    %eax,0x1be0
    base.s.size = 0;
    1807:	c7 05 e4 1b 00 00 00 	movl   $0x0,0x1be4
    180e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1811:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1814:	8b 00                	mov    (%eax),%eax
    1816:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1819:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181c:	8b 40 04             	mov    0x4(%eax),%eax
    181f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1822:	72 4d                	jb     1871 <malloc+0xa6>
      if(p->s.size == nunits)
    1824:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1827:	8b 40 04             	mov    0x4(%eax),%eax
    182a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    182d:	75 0c                	jne    183b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    182f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1832:	8b 10                	mov    (%eax),%edx
    1834:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1837:	89 10                	mov    %edx,(%eax)
    1839:	eb 26                	jmp    1861 <malloc+0x96>
      else {
        p->s.size -= nunits;
    183b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183e:	8b 40 04             	mov    0x4(%eax),%eax
    1841:	89 c2                	mov    %eax,%edx
    1843:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1846:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1849:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    184c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184f:	8b 40 04             	mov    0x4(%eax),%eax
    1852:	c1 e0 03             	shl    $0x3,%eax
    1855:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1858:	8b 45 ec             	mov    -0x14(%ebp),%eax
    185b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    185e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1861:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1864:	a3 e8 1b 00 00       	mov    %eax,0x1be8
      return (void*)(p + 1);
    1869:	8b 45 ec             	mov    -0x14(%ebp),%eax
    186c:	83 c0 08             	add    $0x8,%eax
    186f:	eb 38                	jmp    18a9 <malloc+0xde>
    }
    if(p == freep)
    1871:	a1 e8 1b 00 00       	mov    0x1be8,%eax
    1876:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1879:	75 1b                	jne    1896 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    187b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187e:	89 04 24             	mov    %eax,(%esp)
    1881:	e8 ed fe ff ff       	call   1773 <morecore>
    1886:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1889:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    188d:	75 07                	jne    1896 <malloc+0xcb>
        return 0;
    188f:	b8 00 00 00 00       	mov    $0x0,%eax
    1894:	eb 13                	jmp    18a9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1896:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1899:	89 45 f0             	mov    %eax,-0x10(%ebp)
    189c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    189f:	8b 00                	mov    (%eax),%eax
    18a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    18a4:	e9 70 ff ff ff       	jmp    1819 <malloc+0x4e>
}
    18a9:	c9                   	leave  
    18aa:	c3                   	ret    
    18ab:	90                   	nop

000018ac <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18ac:	55                   	push   %ebp
    18ad:	89 e5                	mov    %esp,%ebp
    18af:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18b2:	8b 55 08             	mov    0x8(%ebp),%edx
    18b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18bb:	f0 87 02             	lock xchg %eax,(%edx)
    18be:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18c4:	c9                   	leave  
    18c5:	c3                   	ret    

000018c6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18c6:	55                   	push   %ebp
    18c7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18c9:	8b 45 08             	mov    0x8(%ebp),%eax
    18cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18d2:	5d                   	pop    %ebp
    18d3:	c3                   	ret    

000018d4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    18d4:	55                   	push   %ebp
    18d5:	89 e5                	mov    %esp,%ebp
    18d7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18da:	8b 45 08             	mov    0x8(%ebp),%eax
    18dd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18e4:	00 
    18e5:	89 04 24             	mov    %eax,(%esp)
    18e8:	e8 bf ff ff ff       	call   18ac <xchg>
    18ed:	85 c0                	test   %eax,%eax
    18ef:	75 e9                	jne    18da <lock_acquire+0x6>
}
    18f1:	c9                   	leave  
    18f2:	c3                   	ret    

000018f3 <lock_release>:
void lock_release(lock_t *lock){
    18f3:	55                   	push   %ebp
    18f4:	89 e5                	mov    %esp,%ebp
    18f6:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1903:	00 
    1904:	89 04 24             	mov    %eax,(%esp)
    1907:	e8 a0 ff ff ff       	call   18ac <xchg>
}
    190c:	c9                   	leave  
    190d:	c3                   	ret    

0000190e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    190e:	55                   	push   %ebp
    190f:	89 e5                	mov    %esp,%ebp
    1911:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1914:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    191b:	e8 ab fe ff ff       	call   17cb <malloc>
    1920:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1923:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1926:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1929:	8b 45 f0             	mov    -0x10(%ebp),%eax
    192c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1931:	85 c0                	test   %eax,%eax
    1933:	74 15                	je     194a <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1935:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1938:	89 c2                	mov    %eax,%edx
    193a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1940:	b8 00 10 00 00       	mov    $0x1000,%eax
    1945:	29 d0                	sub    %edx,%eax
    1947:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    194a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    194e:	75 1b                	jne    196b <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1950:	c7 44 24 04 97 1b 00 	movl   $0x1b97,0x4(%esp)
    1957:	00 
    1958:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    195f:	e8 81 fb ff ff       	call   14e5 <printf>
        return 0;
    1964:	b8 00 00 00 00       	mov    $0x0,%eax
    1969:	eb 6f                	jmp    19da <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    196b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    196e:	8b 55 08             	mov    0x8(%ebp),%edx
    1971:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1974:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1978:	89 54 24 08          	mov    %edx,0x8(%esp)
    197c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1983:	00 
    1984:	89 04 24             	mov    %eax,(%esp)
    1987:	e8 58 fa ff ff       	call   13e4 <clone>
    198c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    198f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1993:	79 1b                	jns    19b0 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1995:	c7 44 24 04 a5 1b 00 	movl   $0x1ba5,0x4(%esp)
    199c:	00 
    199d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19a4:	e8 3c fb ff ff       	call   14e5 <printf>
        return 0;
    19a9:	b8 00 00 00 00       	mov    $0x0,%eax
    19ae:	eb 2a                	jmp    19da <thread_create+0xcc>
    }
    if(tid > 0){
    19b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19b4:	7e 05                	jle    19bb <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    19b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b9:	eb 1f                	jmp    19da <thread_create+0xcc>
    }
    if(tid == 0){
    19bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19bf:	75 14                	jne    19d5 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    19c1:	c7 44 24 04 b2 1b 00 	movl   $0x1bb2,0x4(%esp)
    19c8:	00 
    19c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19d0:	e8 10 fb ff ff       	call   14e5 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19da:	c9                   	leave  
    19db:	c3                   	ret    

000019dc <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19dc:	55                   	push   %ebp
    19dd:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19df:	a1 dc 1b 00 00       	mov    0x1bdc,%eax
    19e4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19ea:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19ef:	a3 dc 1b 00 00       	mov    %eax,0x1bdc
    return (int)(rands % max);
    19f4:	a1 dc 1b 00 00       	mov    0x1bdc,%eax
    19f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19fc:	ba 00 00 00 00       	mov    $0x0,%edx
    1a01:	f7 f1                	div    %ecx
    1a03:	89 d0                	mov    %edx,%eax
}
    1a05:	5d                   	pop    %ebp
    1a06:	c3                   	ret    
    1a07:	90                   	nop

00001a08 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a08:	55                   	push   %ebp
    1a09:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a14:	8b 45 08             	mov    0x8(%ebp),%eax
    1a17:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a28:	5d                   	pop    %ebp
    1a29:	c3                   	ret    

00001a2a <add_q>:

void add_q(struct queue *q, int v){
    1a2a:	55                   	push   %ebp
    1a2b:	89 e5                	mov    %esp,%ebp
    1a2d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a30:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a37:	e8 8f fd ff ff       	call   17cb <malloc>
    1a3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a42:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a4f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a51:	8b 45 08             	mov    0x8(%ebp),%eax
    1a54:	8b 40 04             	mov    0x4(%eax),%eax
    1a57:	85 c0                	test   %eax,%eax
    1a59:	75 0b                	jne    1a66 <add_q+0x3c>
        q->head = n;
    1a5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a61:	89 50 04             	mov    %edx,0x4(%eax)
    1a64:	eb 0c                	jmp    1a72 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a66:	8b 45 08             	mov    0x8(%ebp),%eax
    1a69:	8b 40 08             	mov    0x8(%eax),%eax
    1a6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a6f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a78:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	8b 00                	mov    (%eax),%eax
    1a80:	8d 50 01             	lea    0x1(%eax),%edx
    1a83:	8b 45 08             	mov    0x8(%ebp),%eax
    1a86:	89 10                	mov    %edx,(%eax)
}
    1a88:	c9                   	leave  
    1a89:	c3                   	ret    

00001a8a <empty_q>:

int empty_q(struct queue *q){
    1a8a:	55                   	push   %ebp
    1a8b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	8b 00                	mov    (%eax),%eax
    1a92:	85 c0                	test   %eax,%eax
    1a94:	75 07                	jne    1a9d <empty_q+0x13>
        return 1;
    1a96:	b8 01 00 00 00       	mov    $0x1,%eax
    1a9b:	eb 05                	jmp    1aa2 <empty_q+0x18>
    else
        return 0;
    1a9d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1aa2:	5d                   	pop    %ebp
    1aa3:	c3                   	ret    

00001aa4 <pop_q>:
int pop_q(struct queue *q){
    1aa4:	55                   	push   %ebp
    1aa5:	89 e5                	mov    %esp,%ebp
    1aa7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    1aad:	89 04 24             	mov    %eax,(%esp)
    1ab0:	e8 d5 ff ff ff       	call   1a8a <empty_q>
    1ab5:	85 c0                	test   %eax,%eax
    1ab7:	75 5d                	jne    1b16 <pop_q+0x72>
       val = q->head->value; 
    1ab9:	8b 45 08             	mov    0x8(%ebp),%eax
    1abc:	8b 40 04             	mov    0x4(%eax),%eax
    1abf:	8b 00                	mov    (%eax),%eax
    1ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1ac4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac7:	8b 40 04             	mov    0x4(%eax),%eax
    1aca:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1acd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad0:	8b 40 04             	mov    0x4(%eax),%eax
    1ad3:	8b 50 04             	mov    0x4(%eax),%edx
    1ad6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1adc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1adf:	89 04 24             	mov    %eax,(%esp)
    1ae2:	e8 b5 fb ff ff       	call   169c <free>
       q->size--;
    1ae7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aea:	8b 00                	mov    (%eax),%eax
    1aec:	8d 50 ff             	lea    -0x1(%eax),%edx
    1aef:	8b 45 08             	mov    0x8(%ebp),%eax
    1af2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	8b 00                	mov    (%eax),%eax
    1af9:	85 c0                	test   %eax,%eax
    1afb:	75 14                	jne    1b11 <pop_q+0x6d>
            q->head = 0;
    1afd:	8b 45 08             	mov    0x8(%ebp),%eax
    1b00:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b07:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b14:	eb 05                	jmp    1b1b <pop_q+0x77>
    }
    return -1;
    1b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b1b:	c9                   	leave  
    1b1c:	c3                   	ret    
