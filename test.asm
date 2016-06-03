
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
    1009:	c7 44 24 04 31 1b 00 	movl   $0x1b31,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 d3 04 00 00       	call   14f0 <printf>

   printf(1,"before thread_create n = %d\n",n);
    101d:	a1 78 1f 00 00       	mov    0x1f78,%eax
    1022:	89 44 24 08          	mov    %eax,0x8(%esp)
    1026:	c7 44 24 04 4c 1b 00 	movl   $0x1b4c,0x4(%esp)
    102d:	00 
    102e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1035:	e8 b6 04 00 00       	call   14f0 <printf>

   int arg = 10;
    103a:	c7 44 24 18 0a 00 00 	movl   $0xa,0x18(%esp)
    1041:	00 
   void *tid = thread_create(test_func, (void *)&arg);
    1042:	8d 44 24 18          	lea    0x18(%esp),%eax
    1046:	89 44 24 04          	mov    %eax,0x4(%esp)
    104a:	c7 04 24 a7 10 00 00 	movl   $0x10a7,(%esp)
    1051:	e8 cd 08 00 00       	call   1923 <thread_create>
    1056:	89 44 24 1c          	mov    %eax,0x1c(%esp)
   if(tid <= 0){
    105a:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    105f:	75 19                	jne    107a <main+0x7a>
       printf(1,"wrong happen");
    1061:	c7 44 24 04 69 1b 00 	movl   $0x1b69,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 7b 04 00 00       	call   14f0 <printf>
       exit();
    1075:	e8 ce 02 00 00       	call   1348 <exit>
   } 
   while(wait()>= 0)
    107a:	eb 1d                	jmp    1099 <main+0x99>
   printf(1,"\nback to parent n = %d\n",n);
    107c:	a1 78 1f 00 00       	mov    0x1f78,%eax
    1081:	89 44 24 08          	mov    %eax,0x8(%esp)
    1085:	c7 44 24 04 76 1b 00 	movl   $0x1b76,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 57 04 00 00       	call   14f0 <printf>
   void *tid = thread_create(test_func, (void *)&arg);
   if(tid <= 0){
       printf(1,"wrong happen");
       exit();
   } 
   while(wait()>= 0)
    1099:	e8 b2 02 00 00       	call   1350 <wait>
    109e:	85 c0                	test   %eax,%eax
    10a0:	79 da                	jns    107c <main+0x7c>
   printf(1,"\nback to parent n = %d\n",n);
   
   exit();
    10a2:	e8 a1 02 00 00       	call   1348 <exit>

000010a7 <test_func>:
}

//void test_func(void *arg_ptr){
void test_func(void *arg_ptr){
    10a7:	55                   	push   %ebp
    10a8:	89 e5                	mov    %esp,%ebp
    10aa:	83 ec 28             	sub    $0x28,%esp
    int * num = (int *)arg_ptr;
    10ad:	8b 45 08             	mov    0x8(%ebp),%eax
    10b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n = *num; 
    10b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b6:	8b 00                	mov    (%eax),%eax
    10b8:	a3 78 1f 00 00       	mov    %eax,0x1f78
    printf(1,"\n n is updated as %d\n",*num);
    10bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c0:	8b 00                	mov    (%eax),%eax
    10c2:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c6:	c7 44 24 04 8e 1b 00 	movl   $0x1b8e,0x4(%esp)
    10cd:	00 
    10ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d5:	e8 16 04 00 00       	call   14f0 <printf>
    texit();
    10da:	e8 11 03 00 00       	call   13f0 <texit>
    10df:	90                   	nop

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
    1111:	90                   	nop
    1112:	8b 45 08             	mov    0x8(%ebp),%eax
    1115:	8d 50 01             	lea    0x1(%eax),%edx
    1118:	89 55 08             	mov    %edx,0x8(%ebp)
    111b:	8b 55 0c             	mov    0xc(%ebp),%edx
    111e:	8d 4a 01             	lea    0x1(%edx),%ecx
    1121:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1124:	0f b6 12             	movzbl (%edx),%edx
    1127:	88 10                	mov    %dl,(%eax)
    1129:	0f b6 00             	movzbl (%eax),%eax
    112c:	84 c0                	test   %al,%al
    112e:	75 e2                	jne    1112 <strcpy+0xd>
    ;
  return os;
    1130:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1133:	c9                   	leave  
    1134:	c3                   	ret    

00001135 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1135:	55                   	push   %ebp
    1136:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1138:	eb 08                	jmp    1142 <strcmp+0xd>
    p++, q++;
    113a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    113e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1142:	8b 45 08             	mov    0x8(%ebp),%eax
    1145:	0f b6 00             	movzbl (%eax),%eax
    1148:	84 c0                	test   %al,%al
    114a:	74 10                	je     115c <strcmp+0x27>
    114c:	8b 45 08             	mov    0x8(%ebp),%eax
    114f:	0f b6 10             	movzbl (%eax),%edx
    1152:	8b 45 0c             	mov    0xc(%ebp),%eax
    1155:	0f b6 00             	movzbl (%eax),%eax
    1158:	38 c2                	cmp    %al,%dl
    115a:	74 de                	je     113a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    115c:	8b 45 08             	mov    0x8(%ebp),%eax
    115f:	0f b6 00             	movzbl (%eax),%eax
    1162:	0f b6 d0             	movzbl %al,%edx
    1165:	8b 45 0c             	mov    0xc(%ebp),%eax
    1168:	0f b6 00             	movzbl (%eax),%eax
    116b:	0f b6 c0             	movzbl %al,%eax
    116e:	29 c2                	sub    %eax,%edx
    1170:	89 d0                	mov    %edx,%eax
}
    1172:	5d                   	pop    %ebp
    1173:	c3                   	ret    

00001174 <strlen>:

uint
strlen(char *s)
{
    1174:	55                   	push   %ebp
    1175:	89 e5                	mov    %esp,%ebp
    1177:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    117a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1181:	eb 04                	jmp    1187 <strlen+0x13>
    1183:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1187:	8b 55 fc             	mov    -0x4(%ebp),%edx
    118a:	8b 45 08             	mov    0x8(%ebp),%eax
    118d:	01 d0                	add    %edx,%eax
    118f:	0f b6 00             	movzbl (%eax),%eax
    1192:	84 c0                	test   %al,%al
    1194:	75 ed                	jne    1183 <strlen+0xf>
    ;
  return n;
    1196:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1199:	c9                   	leave  
    119a:	c3                   	ret    

0000119b <memset>:

void*
memset(void *dst, int c, uint n)
{
    119b:	55                   	push   %ebp
    119c:	89 e5                	mov    %esp,%ebp
    119e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    11a1:	8b 45 10             	mov    0x10(%ebp),%eax
    11a4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    11af:	8b 45 08             	mov    0x8(%ebp),%eax
    11b2:	89 04 24             	mov    %eax,(%esp)
    11b5:	e8 26 ff ff ff       	call   10e0 <stosb>
  return dst;
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11bd:	c9                   	leave  
    11be:	c3                   	ret    

000011bf <strchr>:

char*
strchr(const char *s, char c)
{
    11bf:	55                   	push   %ebp
    11c0:	89 e5                	mov    %esp,%ebp
    11c2:	83 ec 04             	sub    $0x4,%esp
    11c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11cb:	eb 14                	jmp    11e1 <strchr+0x22>
    if(*s == c)
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
    11d0:	0f b6 00             	movzbl (%eax),%eax
    11d3:	3a 45 fc             	cmp    -0x4(%ebp),%al
    11d6:	75 05                	jne    11dd <strchr+0x1e>
      return (char*)s;
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	eb 13                	jmp    11f0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11dd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11e1:	8b 45 08             	mov    0x8(%ebp),%eax
    11e4:	0f b6 00             	movzbl (%eax),%eax
    11e7:	84 c0                	test   %al,%al
    11e9:	75 e2                	jne    11cd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    11eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11f0:	c9                   	leave  
    11f1:	c3                   	ret    

000011f2 <gets>:

char*
gets(char *buf, int max)
{
    11f2:	55                   	push   %ebp
    11f3:	89 e5                	mov    %esp,%ebp
    11f5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11ff:	eb 4c                	jmp    124d <gets+0x5b>
    cc = read(0, &c, 1);
    1201:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1208:	00 
    1209:	8d 45 ef             	lea    -0x11(%ebp),%eax
    120c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1210:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1217:	e8 44 01 00 00       	call   1360 <read>
    121c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    121f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1223:	7f 02                	jg     1227 <gets+0x35>
      break;
    1225:	eb 31                	jmp    1258 <gets+0x66>
    buf[i++] = c;
    1227:	8b 45 f4             	mov    -0xc(%ebp),%eax
    122a:	8d 50 01             	lea    0x1(%eax),%edx
    122d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1230:	89 c2                	mov    %eax,%edx
    1232:	8b 45 08             	mov    0x8(%ebp),%eax
    1235:	01 c2                	add    %eax,%edx
    1237:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    123b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    123d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1241:	3c 0a                	cmp    $0xa,%al
    1243:	74 13                	je     1258 <gets+0x66>
    1245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1249:	3c 0d                	cmp    $0xd,%al
    124b:	74 0b                	je     1258 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    124d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1250:	83 c0 01             	add    $0x1,%eax
    1253:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1256:	7c a9                	jl     1201 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1258:	8b 55 f4             	mov    -0xc(%ebp),%edx
    125b:	8b 45 08             	mov    0x8(%ebp),%eax
    125e:	01 d0                	add    %edx,%eax
    1260:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1263:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1266:	c9                   	leave  
    1267:	c3                   	ret    

00001268 <stat>:

int
stat(char *n, struct stat *st)
{
    1268:	55                   	push   %ebp
    1269:	89 e5                	mov    %esp,%ebp
    126b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    126e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1275:	00 
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	89 04 24             	mov    %eax,(%esp)
    127c:	e8 07 01 00 00       	call   1388 <open>
    1281:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1284:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1288:	79 07                	jns    1291 <stat+0x29>
    return -1;
    128a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    128f:	eb 23                	jmp    12b4 <stat+0x4c>
  r = fstat(fd, st);
    1291:	8b 45 0c             	mov    0xc(%ebp),%eax
    1294:	89 44 24 04          	mov    %eax,0x4(%esp)
    1298:	8b 45 f4             	mov    -0xc(%ebp),%eax
    129b:	89 04 24             	mov    %eax,(%esp)
    129e:	e8 fd 00 00 00       	call   13a0 <fstat>
    12a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    12a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12a9:	89 04 24             	mov    %eax,(%esp)
    12ac:	e8 bf 00 00 00       	call   1370 <close>
  return r;
    12b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    12b4:	c9                   	leave  
    12b5:	c3                   	ret    

000012b6 <atoi>:

int
atoi(const char *s)
{
    12b6:	55                   	push   %ebp
    12b7:	89 e5                	mov    %esp,%ebp
    12b9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12c3:	eb 25                	jmp    12ea <atoi+0x34>
    n = n*10 + *s++ - '0';
    12c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12c8:	89 d0                	mov    %edx,%eax
    12ca:	c1 e0 02             	shl    $0x2,%eax
    12cd:	01 d0                	add    %edx,%eax
    12cf:	01 c0                	add    %eax,%eax
    12d1:	89 c1                	mov    %eax,%ecx
    12d3:	8b 45 08             	mov    0x8(%ebp),%eax
    12d6:	8d 50 01             	lea    0x1(%eax),%edx
    12d9:	89 55 08             	mov    %edx,0x8(%ebp)
    12dc:	0f b6 00             	movzbl (%eax),%eax
    12df:	0f be c0             	movsbl %al,%eax
    12e2:	01 c8                	add    %ecx,%eax
    12e4:	83 e8 30             	sub    $0x30,%eax
    12e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12ea:	8b 45 08             	mov    0x8(%ebp),%eax
    12ed:	0f b6 00             	movzbl (%eax),%eax
    12f0:	3c 2f                	cmp    $0x2f,%al
    12f2:	7e 0a                	jle    12fe <atoi+0x48>
    12f4:	8b 45 08             	mov    0x8(%ebp),%eax
    12f7:	0f b6 00             	movzbl (%eax),%eax
    12fa:	3c 39                	cmp    $0x39,%al
    12fc:	7e c7                	jle    12c5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1301:	c9                   	leave  
    1302:	c3                   	ret    

00001303 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1303:	55                   	push   %ebp
    1304:	89 e5                	mov    %esp,%ebp
    1306:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1309:	8b 45 08             	mov    0x8(%ebp),%eax
    130c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    130f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1312:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1315:	eb 17                	jmp    132e <memmove+0x2b>
    *dst++ = *src++;
    1317:	8b 45 fc             	mov    -0x4(%ebp),%eax
    131a:	8d 50 01             	lea    0x1(%eax),%edx
    131d:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1320:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1323:	8d 4a 01             	lea    0x1(%edx),%ecx
    1326:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1329:	0f b6 12             	movzbl (%edx),%edx
    132c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    132e:	8b 45 10             	mov    0x10(%ebp),%eax
    1331:	8d 50 ff             	lea    -0x1(%eax),%edx
    1334:	89 55 10             	mov    %edx,0x10(%ebp)
    1337:	85 c0                	test   %eax,%eax
    1339:	7f dc                	jg     1317 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    133b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    133e:	c9                   	leave  
    133f:	c3                   	ret    

00001340 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1340:	b8 01 00 00 00       	mov    $0x1,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <exit>:
SYSCALL(exit)
    1348:	b8 02 00 00 00       	mov    $0x2,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <wait>:
SYSCALL(wait)
    1350:	b8 03 00 00 00       	mov    $0x3,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <pipe>:
SYSCALL(pipe)
    1358:	b8 04 00 00 00       	mov    $0x4,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <read>:
SYSCALL(read)
    1360:	b8 05 00 00 00       	mov    $0x5,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <write>:
SYSCALL(write)
    1368:	b8 10 00 00 00       	mov    $0x10,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <close>:
SYSCALL(close)
    1370:	b8 15 00 00 00       	mov    $0x15,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <kill>:
SYSCALL(kill)
    1378:	b8 06 00 00 00       	mov    $0x6,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <exec>:
SYSCALL(exec)
    1380:	b8 07 00 00 00       	mov    $0x7,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <open>:
SYSCALL(open)
    1388:	b8 0f 00 00 00       	mov    $0xf,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <mknod>:
SYSCALL(mknod)
    1390:	b8 11 00 00 00       	mov    $0x11,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <unlink>:
SYSCALL(unlink)
    1398:	b8 12 00 00 00       	mov    $0x12,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <fstat>:
SYSCALL(fstat)
    13a0:	b8 08 00 00 00       	mov    $0x8,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <link>:
SYSCALL(link)
    13a8:	b8 13 00 00 00       	mov    $0x13,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <mkdir>:
SYSCALL(mkdir)
    13b0:	b8 14 00 00 00       	mov    $0x14,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <chdir>:
SYSCALL(chdir)
    13b8:	b8 09 00 00 00       	mov    $0x9,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <dup>:
SYSCALL(dup)
    13c0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <getpid>:
SYSCALL(getpid)
    13c8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <sbrk>:
SYSCALL(sbrk)
    13d0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <sleep>:
SYSCALL(sleep)
    13d8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <uptime>:
SYSCALL(uptime)
    13e0:	b8 0e 00 00 00       	mov    $0xe,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <clone>:
SYSCALL(clone)
    13e8:	b8 16 00 00 00       	mov    $0x16,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <texit>:
SYSCALL(texit)
    13f0:	b8 17 00 00 00       	mov    $0x17,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <tsleep>:
SYSCALL(tsleep)
    13f8:	b8 18 00 00 00       	mov    $0x18,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <twakeup>:
SYSCALL(twakeup)
    1400:	b8 19 00 00 00       	mov    $0x19,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <thread_yield>:
SYSCALL(thread_yield)
    1408:	b8 1a 00 00 00       	mov    $0x1a,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	83 ec 18             	sub    $0x18,%esp
    1416:	8b 45 0c             	mov    0xc(%ebp),%eax
    1419:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    141c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1423:	00 
    1424:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1427:	89 44 24 04          	mov    %eax,0x4(%esp)
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	89 04 24             	mov    %eax,(%esp)
    1431:	e8 32 ff ff ff       	call   1368 <write>
}
    1436:	c9                   	leave  
    1437:	c3                   	ret    

00001438 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	56                   	push   %esi
    143c:	53                   	push   %ebx
    143d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1440:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1447:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    144b:	74 17                	je     1464 <printint+0x2c>
    144d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1451:	79 11                	jns    1464 <printint+0x2c>
    neg = 1;
    1453:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    145a:	8b 45 0c             	mov    0xc(%ebp),%eax
    145d:	f7 d8                	neg    %eax
    145f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1462:	eb 06                	jmp    146a <printint+0x32>
  } else {
    x = xx;
    1464:	8b 45 0c             	mov    0xc(%ebp),%eax
    1467:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    146a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1471:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1474:	8d 41 01             	lea    0x1(%ecx),%eax
    1477:	89 45 f4             	mov    %eax,-0xc(%ebp)
    147a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    147d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1480:	ba 00 00 00 00       	mov    $0x0,%edx
    1485:	f7 f3                	div    %ebx
    1487:	89 d0                	mov    %edx,%eax
    1489:	0f b6 80 7c 1f 00 00 	movzbl 0x1f7c(%eax),%eax
    1490:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1494:	8b 75 10             	mov    0x10(%ebp),%esi
    1497:	8b 45 ec             	mov    -0x14(%ebp),%eax
    149a:	ba 00 00 00 00       	mov    $0x0,%edx
    149f:	f7 f6                	div    %esi
    14a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14a8:	75 c7                	jne    1471 <printint+0x39>
  if(neg)
    14aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14ae:	74 10                	je     14c0 <printint+0x88>
    buf[i++] = '-';
    14b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b3:	8d 50 01             	lea    0x1(%eax),%edx
    14b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14b9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14be:	eb 1f                	jmp    14df <printint+0xa7>
    14c0:	eb 1d                	jmp    14df <printint+0xa7>
    putc(fd, buf[i]);
    14c2:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c8:	01 d0                	add    %edx,%eax
    14ca:	0f b6 00             	movzbl (%eax),%eax
    14cd:	0f be c0             	movsbl %al,%eax
    14d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d4:	8b 45 08             	mov    0x8(%ebp),%eax
    14d7:	89 04 24             	mov    %eax,(%esp)
    14da:	e8 31 ff ff ff       	call   1410 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14df:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    14e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14e7:	79 d9                	jns    14c2 <printint+0x8a>
    putc(fd, buf[i]);
}
    14e9:	83 c4 30             	add    $0x30,%esp
    14ec:	5b                   	pop    %ebx
    14ed:	5e                   	pop    %esi
    14ee:	5d                   	pop    %ebp
    14ef:	c3                   	ret    

000014f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14fd:	8d 45 0c             	lea    0xc(%ebp),%eax
    1500:	83 c0 04             	add    $0x4,%eax
    1503:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1506:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    150d:	e9 7c 01 00 00       	jmp    168e <printf+0x19e>
    c = fmt[i] & 0xff;
    1512:	8b 55 0c             	mov    0xc(%ebp),%edx
    1515:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1518:	01 d0                	add    %edx,%eax
    151a:	0f b6 00             	movzbl (%eax),%eax
    151d:	0f be c0             	movsbl %al,%eax
    1520:	25 ff 00 00 00       	and    $0xff,%eax
    1525:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1528:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    152c:	75 2c                	jne    155a <printf+0x6a>
      if(c == '%'){
    152e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1532:	75 0c                	jne    1540 <printf+0x50>
        state = '%';
    1534:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    153b:	e9 4a 01 00 00       	jmp    168a <printf+0x19a>
      } else {
        putc(fd, c);
    1540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1543:	0f be c0             	movsbl %al,%eax
    1546:	89 44 24 04          	mov    %eax,0x4(%esp)
    154a:	8b 45 08             	mov    0x8(%ebp),%eax
    154d:	89 04 24             	mov    %eax,(%esp)
    1550:	e8 bb fe ff ff       	call   1410 <putc>
    1555:	e9 30 01 00 00       	jmp    168a <printf+0x19a>
      }
    } else if(state == '%'){
    155a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    155e:	0f 85 26 01 00 00    	jne    168a <printf+0x19a>
      if(c == 'd'){
    1564:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1568:	75 2d                	jne    1597 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    156a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    156d:	8b 00                	mov    (%eax),%eax
    156f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1576:	00 
    1577:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    157e:	00 
    157f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1583:	8b 45 08             	mov    0x8(%ebp),%eax
    1586:	89 04 24             	mov    %eax,(%esp)
    1589:	e8 aa fe ff ff       	call   1438 <printint>
        ap++;
    158e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1592:	e9 ec 00 00 00       	jmp    1683 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1597:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    159b:	74 06                	je     15a3 <printf+0xb3>
    159d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15a1:	75 2d                	jne    15d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    15a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a6:	8b 00                	mov    (%eax),%eax
    15a8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15af:	00 
    15b0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15b7:	00 
    15b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
    15bf:	89 04 24             	mov    %eax,(%esp)
    15c2:	e8 71 fe ff ff       	call   1438 <printint>
        ap++;
    15c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15cb:	e9 b3 00 00 00       	jmp    1683 <printf+0x193>
      } else if(c == 's'){
    15d0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    15d4:	75 45                	jne    161b <printf+0x12b>
        s = (char*)*ap;
    15d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d9:	8b 00                	mov    (%eax),%eax
    15db:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    15de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    15e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15e6:	75 09                	jne    15f1 <printf+0x101>
          s = "(null)";
    15e8:	c7 45 f4 a4 1b 00 00 	movl   $0x1ba4,-0xc(%ebp)
        while(*s != 0){
    15ef:	eb 1e                	jmp    160f <printf+0x11f>
    15f1:	eb 1c                	jmp    160f <printf+0x11f>
          putc(fd, *s);
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	89 04 24             	mov    %eax,(%esp)
    1606:	e8 05 fe ff ff       	call   1410 <putc>
          s++;
    160b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    160f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1612:	0f b6 00             	movzbl (%eax),%eax
    1615:	84 c0                	test   %al,%al
    1617:	75 da                	jne    15f3 <printf+0x103>
    1619:	eb 68                	jmp    1683 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    161b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    161f:	75 1d                	jne    163e <printf+0x14e>
        putc(fd, *ap);
    1621:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1624:	8b 00                	mov    (%eax),%eax
    1626:	0f be c0             	movsbl %al,%eax
    1629:	89 44 24 04          	mov    %eax,0x4(%esp)
    162d:	8b 45 08             	mov    0x8(%ebp),%eax
    1630:	89 04 24             	mov    %eax,(%esp)
    1633:	e8 d8 fd ff ff       	call   1410 <putc>
        ap++;
    1638:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    163c:	eb 45                	jmp    1683 <printf+0x193>
      } else if(c == '%'){
    163e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1642:	75 17                	jne    165b <printf+0x16b>
        putc(fd, c);
    1644:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1647:	0f be c0             	movsbl %al,%eax
    164a:	89 44 24 04          	mov    %eax,0x4(%esp)
    164e:	8b 45 08             	mov    0x8(%ebp),%eax
    1651:	89 04 24             	mov    %eax,(%esp)
    1654:	e8 b7 fd ff ff       	call   1410 <putc>
    1659:	eb 28                	jmp    1683 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    165b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1662:	00 
    1663:	8b 45 08             	mov    0x8(%ebp),%eax
    1666:	89 04 24             	mov    %eax,(%esp)
    1669:	e8 a2 fd ff ff       	call   1410 <putc>
        putc(fd, c);
    166e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1671:	0f be c0             	movsbl %al,%eax
    1674:	89 44 24 04          	mov    %eax,0x4(%esp)
    1678:	8b 45 08             	mov    0x8(%ebp),%eax
    167b:	89 04 24             	mov    %eax,(%esp)
    167e:	e8 8d fd ff ff       	call   1410 <putc>
      }
      state = 0;
    1683:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    168a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    168e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1691:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1694:	01 d0                	add    %edx,%eax
    1696:	0f b6 00             	movzbl (%eax),%eax
    1699:	84 c0                	test   %al,%al
    169b:	0f 85 71 fe ff ff    	jne    1512 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    16a1:	c9                   	leave  
    16a2:	c3                   	ret    
    16a3:	90                   	nop

000016a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16a4:	55                   	push   %ebp
    16a5:	89 e5                	mov    %esp,%ebp
    16a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16aa:	8b 45 08             	mov    0x8(%ebp),%eax
    16ad:	83 e8 08             	sub    $0x8,%eax
    16b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b3:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    16b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16bb:	eb 24                	jmp    16e1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c0:	8b 00                	mov    (%eax),%eax
    16c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16c5:	77 12                	ja     16d9 <free+0x35>
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16cd:	77 24                	ja     16f3 <free+0x4f>
    16cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d2:	8b 00                	mov    (%eax),%eax
    16d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16d7:	77 1a                	ja     16f3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16dc:	8b 00                	mov    (%eax),%eax
    16de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16e7:	76 d4                	jbe    16bd <free+0x19>
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	8b 00                	mov    (%eax),%eax
    16ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16f1:	76 ca                	jbe    16bd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f6:	8b 40 04             	mov    0x4(%eax),%eax
    16f9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1700:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1703:	01 c2                	add    %eax,%edx
    1705:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1708:	8b 00                	mov    (%eax),%eax
    170a:	39 c2                	cmp    %eax,%edx
    170c:	75 24                	jne    1732 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    170e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1711:	8b 50 04             	mov    0x4(%eax),%edx
    1714:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1717:	8b 00                	mov    (%eax),%eax
    1719:	8b 40 04             	mov    0x4(%eax),%eax
    171c:	01 c2                	add    %eax,%edx
    171e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1721:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1724:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1727:	8b 00                	mov    (%eax),%eax
    1729:	8b 10                	mov    (%eax),%edx
    172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    172e:	89 10                	mov    %edx,(%eax)
    1730:	eb 0a                	jmp    173c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1732:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1735:	8b 10                	mov    (%eax),%edx
    1737:	8b 45 f8             	mov    -0x8(%ebp),%eax
    173a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    173c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173f:	8b 40 04             	mov    0x4(%eax),%eax
    1742:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1749:	8b 45 fc             	mov    -0x4(%ebp),%eax
    174c:	01 d0                	add    %edx,%eax
    174e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1751:	75 20                	jne    1773 <free+0xcf>
    p->s.size += bp->s.size;
    1753:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1756:	8b 50 04             	mov    0x4(%eax),%edx
    1759:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175c:	8b 40 04             	mov    0x4(%eax),%eax
    175f:	01 c2                	add    %eax,%edx
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1764:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1767:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176a:	8b 10                	mov    (%eax),%edx
    176c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176f:	89 10                	mov    %edx,(%eax)
    1771:	eb 08                	jmp    177b <free+0xd7>
  } else
    p->s.ptr = bp;
    1773:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1776:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1779:	89 10                	mov    %edx,(%eax)
  freep = p;
    177b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177e:	a3 9c 1f 00 00       	mov    %eax,0x1f9c
}
    1783:	c9                   	leave  
    1784:	c3                   	ret    

00001785 <morecore>:

static Header*
morecore(uint nu)
{
    1785:	55                   	push   %ebp
    1786:	89 e5                	mov    %esp,%ebp
    1788:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    178b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1792:	77 07                	ja     179b <morecore+0x16>
    nu = 4096;
    1794:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    179b:	8b 45 08             	mov    0x8(%ebp),%eax
    179e:	c1 e0 03             	shl    $0x3,%eax
    17a1:	89 04 24             	mov    %eax,(%esp)
    17a4:	e8 27 fc ff ff       	call   13d0 <sbrk>
    17a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    17ac:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    17b0:	75 07                	jne    17b9 <morecore+0x34>
    return 0;
    17b2:	b8 00 00 00 00       	mov    $0x0,%eax
    17b7:	eb 22                	jmp    17db <morecore+0x56>
  hp = (Header*)p;
    17b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c2:	8b 55 08             	mov    0x8(%ebp),%edx
    17c5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cb:	83 c0 08             	add    $0x8,%eax
    17ce:	89 04 24             	mov    %eax,(%esp)
    17d1:	e8 ce fe ff ff       	call   16a4 <free>
  return freep;
    17d6:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
}
    17db:	c9                   	leave  
    17dc:	c3                   	ret    

000017dd <malloc>:

void*
malloc(uint nbytes)
{
    17dd:	55                   	push   %ebp
    17de:	89 e5                	mov    %esp,%ebp
    17e0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17e3:	8b 45 08             	mov    0x8(%ebp),%eax
    17e6:	83 c0 07             	add    $0x7,%eax
    17e9:	c1 e8 03             	shr    $0x3,%eax
    17ec:	83 c0 01             	add    $0x1,%eax
    17ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    17f2:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    17f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17fe:	75 23                	jne    1823 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1800:	c7 45 f0 94 1f 00 00 	movl   $0x1f94,-0x10(%ebp)
    1807:	8b 45 f0             	mov    -0x10(%ebp),%eax
    180a:	a3 9c 1f 00 00       	mov    %eax,0x1f9c
    180f:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    1814:	a3 94 1f 00 00       	mov    %eax,0x1f94
    base.s.size = 0;
    1819:	c7 05 98 1f 00 00 00 	movl   $0x0,0x1f98
    1820:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1823:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1826:	8b 00                	mov    (%eax),%eax
    1828:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182e:	8b 40 04             	mov    0x4(%eax),%eax
    1831:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1834:	72 4d                	jb     1883 <malloc+0xa6>
      if(p->s.size == nunits)
    1836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1839:	8b 40 04             	mov    0x4(%eax),%eax
    183c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    183f:	75 0c                	jne    184d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1841:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1844:	8b 10                	mov    (%eax),%edx
    1846:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1849:	89 10                	mov    %edx,(%eax)
    184b:	eb 26                	jmp    1873 <malloc+0x96>
      else {
        p->s.size -= nunits;
    184d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1850:	8b 40 04             	mov    0x4(%eax),%eax
    1853:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1856:	89 c2                	mov    %eax,%edx
    1858:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1861:	8b 40 04             	mov    0x4(%eax),%eax
    1864:	c1 e0 03             	shl    $0x3,%eax
    1867:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    186a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1870:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1873:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1876:	a3 9c 1f 00 00       	mov    %eax,0x1f9c
      return (void*)(p + 1);
    187b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187e:	83 c0 08             	add    $0x8,%eax
    1881:	eb 38                	jmp    18bb <malloc+0xde>
    }
    if(p == freep)
    1883:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    1888:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    188b:	75 1b                	jne    18a8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    188d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1890:	89 04 24             	mov    %eax,(%esp)
    1893:	e8 ed fe ff ff       	call   1785 <morecore>
    1898:	89 45 f4             	mov    %eax,-0xc(%ebp)
    189b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    189f:	75 07                	jne    18a8 <malloc+0xcb>
        return 0;
    18a1:	b8 00 00 00 00       	mov    $0x0,%eax
    18a6:	eb 13                	jmp    18bb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b1:	8b 00                	mov    (%eax),%eax
    18b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    18b6:	e9 70 ff ff ff       	jmp    182b <malloc+0x4e>
}
    18bb:	c9                   	leave  
    18bc:	c3                   	ret    
    18bd:	66 90                	xchg   %ax,%ax
    18bf:	90                   	nop

000018c0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18c0:	55                   	push   %ebp
    18c1:	89 e5                	mov    %esp,%ebp
    18c3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18c6:	8b 55 08             	mov    0x8(%ebp),%edx
    18c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    18cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18cf:	f0 87 02             	lock xchg %eax,(%edx)
    18d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18d8:	c9                   	leave  
    18d9:	c3                   	ret    

000018da <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18da:	55                   	push   %ebp
    18db:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18dd:	8b 45 08             	mov    0x8(%ebp),%eax
    18e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18e6:	5d                   	pop    %ebp
    18e7:	c3                   	ret    

000018e8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    18e8:	55                   	push   %ebp
    18e9:	89 e5                	mov    %esp,%ebp
    18eb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18ee:	90                   	nop
    18ef:	8b 45 08             	mov    0x8(%ebp),%eax
    18f2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18f9:	00 
    18fa:	89 04 24             	mov    %eax,(%esp)
    18fd:	e8 be ff ff ff       	call   18c0 <xchg>
    1902:	85 c0                	test   %eax,%eax
    1904:	75 e9                	jne    18ef <lock_acquire+0x7>
}
    1906:	c9                   	leave  
    1907:	c3                   	ret    

00001908 <lock_release>:
void lock_release(lock_t *lock){
    1908:	55                   	push   %ebp
    1909:	89 e5                	mov    %esp,%ebp
    190b:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    190e:	8b 45 08             	mov    0x8(%ebp),%eax
    1911:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1918:	00 
    1919:	89 04 24             	mov    %eax,(%esp)
    191c:	e8 9f ff ff ff       	call   18c0 <xchg>
}
    1921:	c9                   	leave  
    1922:	c3                   	ret    

00001923 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1923:	55                   	push   %ebp
    1924:	89 e5                	mov    %esp,%ebp
    1926:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1929:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1930:	e8 a8 fe ff ff       	call   17dd <malloc>
    1935:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1938:	8b 45 f4             	mov    -0xc(%ebp),%eax
    193b:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    193e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1941:	25 ff 0f 00 00       	and    $0xfff,%eax
    1946:	85 c0                	test   %eax,%eax
    1948:	74 14                	je     195e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    194a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1952:	89 c2                	mov    %eax,%edx
    1954:	b8 00 10 00 00       	mov    $0x1000,%eax
    1959:	29 d0                	sub    %edx,%eax
    195b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    195e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1962:	75 1b                	jne    197f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1964:	c7 44 24 04 ab 1b 00 	movl   $0x1bab,0x4(%esp)
    196b:	00 
    196c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1973:	e8 78 fb ff ff       	call   14f0 <printf>
        return 0;
    1978:	b8 00 00 00 00       	mov    $0x0,%eax
    197d:	eb 6f                	jmp    19ee <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    197f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1982:	8b 55 08             	mov    0x8(%ebp),%edx
    1985:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1988:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    198c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1990:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1997:	00 
    1998:	89 04 24             	mov    %eax,(%esp)
    199b:	e8 48 fa ff ff       	call   13e8 <clone>
    19a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    19a3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19a7:	79 1b                	jns    19c4 <thread_create+0xa1>
        printf(1,"clone fails\n");
    19a9:	c7 44 24 04 b9 1b 00 	movl   $0x1bb9,0x4(%esp)
    19b0:	00 
    19b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19b8:	e8 33 fb ff ff       	call   14f0 <printf>
        return 0;
    19bd:	b8 00 00 00 00       	mov    $0x0,%eax
    19c2:	eb 2a                	jmp    19ee <thread_create+0xcb>
    }
    if(tid > 0){
    19c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19c8:	7e 05                	jle    19cf <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    19ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19cd:	eb 1f                	jmp    19ee <thread_create+0xcb>
    }
    if(tid == 0){
    19cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19d3:	75 14                	jne    19e9 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    19d5:	c7 44 24 04 c6 1b 00 	movl   $0x1bc6,0x4(%esp)
    19dc:	00 
    19dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19e4:	e8 07 fb ff ff       	call   14f0 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19e9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19ee:	c9                   	leave  
    19ef:	c3                   	ret    

000019f0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19f0:	55                   	push   %ebp
    19f1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19f3:	a1 90 1f 00 00       	mov    0x1f90,%eax
    19f8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19fe:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a03:	a3 90 1f 00 00       	mov    %eax,0x1f90
    return (int)(rands % max);
    1a08:	a1 90 1f 00 00       	mov    0x1f90,%eax
    1a0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a10:	ba 00 00 00 00       	mov    $0x0,%edx
    1a15:	f7 f1                	div    %ecx
    1a17:	89 d0                	mov    %edx,%eax
}
    1a19:	5d                   	pop    %ebp
    1a1a:	c3                   	ret    
    1a1b:	90                   	nop

00001a1c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a1c:	55                   	push   %ebp
    1a1d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a22:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a28:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a3c:	5d                   	pop    %ebp
    1a3d:	c3                   	ret    

00001a3e <add_q>:

void add_q(struct queue *q, int v){
    1a3e:	55                   	push   %ebp
    1a3f:	89 e5                	mov    %esp,%ebp
    1a41:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a44:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a4b:	e8 8d fd ff ff       	call   17dd <malloc>
    1a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a56:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a60:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a63:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	8b 40 04             	mov    0x4(%eax),%eax
    1a6b:	85 c0                	test   %eax,%eax
    1a6d:	75 0b                	jne    1a7a <add_q+0x3c>
        q->head = n;
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a75:	89 50 04             	mov    %edx,0x4(%eax)
    1a78:	eb 0c                	jmp    1a86 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7d:	8b 40 08             	mov    0x8(%eax),%eax
    1a80:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a83:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a8c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	8b 00                	mov    (%eax),%eax
    1a94:	8d 50 01             	lea    0x1(%eax),%edx
    1a97:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9a:	89 10                	mov    %edx,(%eax)
}
    1a9c:	c9                   	leave  
    1a9d:	c3                   	ret    

00001a9e <empty_q>:

int empty_q(struct queue *q){
    1a9e:	55                   	push   %ebp
    1a9f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1aa1:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa4:	8b 00                	mov    (%eax),%eax
    1aa6:	85 c0                	test   %eax,%eax
    1aa8:	75 07                	jne    1ab1 <empty_q+0x13>
        return 1;
    1aaa:	b8 01 00 00 00       	mov    $0x1,%eax
    1aaf:	eb 05                	jmp    1ab6 <empty_q+0x18>
    else
        return 0;
    1ab1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1ab6:	5d                   	pop    %ebp
    1ab7:	c3                   	ret    

00001ab8 <pop_q>:
int pop_q(struct queue *q){
    1ab8:	55                   	push   %ebp
    1ab9:	89 e5                	mov    %esp,%ebp
    1abb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1abe:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac1:	89 04 24             	mov    %eax,(%esp)
    1ac4:	e8 d5 ff ff ff       	call   1a9e <empty_q>
    1ac9:	85 c0                	test   %eax,%eax
    1acb:	75 5d                	jne    1b2a <pop_q+0x72>
       val = q->head->value; 
    1acd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad0:	8b 40 04             	mov    0x4(%eax),%eax
    1ad3:	8b 00                	mov    (%eax),%eax
    1ad5:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    1adb:	8b 40 04             	mov    0x4(%eax),%eax
    1ade:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1ae1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae4:	8b 40 04             	mov    0x4(%eax),%eax
    1ae7:	8b 50 04             	mov    0x4(%eax),%edx
    1aea:	8b 45 08             	mov    0x8(%ebp),%eax
    1aed:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1af3:	89 04 24             	mov    %eax,(%esp)
    1af6:	e8 a9 fb ff ff       	call   16a4 <free>
       q->size--;
    1afb:	8b 45 08             	mov    0x8(%ebp),%eax
    1afe:	8b 00                	mov    (%eax),%eax
    1b00:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b03:	8b 45 08             	mov    0x8(%ebp),%eax
    1b06:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1b08:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0b:	8b 00                	mov    (%eax),%eax
    1b0d:	85 c0                	test   %eax,%eax
    1b0f:	75 14                	jne    1b25 <pop_q+0x6d>
            q->head = 0;
    1b11:	8b 45 08             	mov    0x8(%ebp),%eax
    1b14:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b28:	eb 05                	jmp    1b2f <pop_q+0x77>
    }
    return -1;
    1b2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b2f:	c9                   	leave  
    1b30:	c3                   	ret    
