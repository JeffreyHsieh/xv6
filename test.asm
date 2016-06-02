
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
    1018:	e8 cb 04 00 00       	call   14e8 <printf>

   printf(1,"before thread_create n = %d\n",n);
    101d:	a1 04 1f 00 00       	mov    0x1f04,%eax
    1022:	89 44 24 08          	mov    %eax,0x8(%esp)
    1026:	c7 44 24 04 38 1b 00 	movl   $0x1b38,0x4(%esp)
    102d:	00 
    102e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1035:	e8 ae 04 00 00       	call   14e8 <printf>

   int arg = 10;
    103a:	c7 44 24 18 0a 00 00 	movl   $0xa,0x18(%esp)
    1041:	00 
   void *tid = thread_create(test_func, (void *)&arg);
    1042:	8d 44 24 18          	lea    0x18(%esp),%eax
    1046:	89 44 24 04          	mov    %eax,0x4(%esp)
    104a:	c7 04 24 a7 10 00 00 	movl   $0x10a7,(%esp)
    1051:	e8 b9 08 00 00       	call   190f <thread_create>
    1056:	89 44 24 1c          	mov    %eax,0x1c(%esp)
   if(tid <= 0){
    105a:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    105f:	75 19                	jne    107a <main+0x7a>
       printf(1,"wrong happen");
    1061:	c7 44 24 04 55 1b 00 	movl   $0x1b55,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 73 04 00 00       	call   14e8 <printf>
       exit();
    1075:	e8 ce 02 00 00       	call   1348 <exit>
   } 
   while(wait()>= 0)
    107a:	eb 1d                	jmp    1099 <main+0x99>
   printf(1,"\nback to parent n = %d\n",n);
    107c:	a1 04 1f 00 00       	mov    0x1f04,%eax
    1081:	89 44 24 08          	mov    %eax,0x8(%esp)
    1085:	c7 44 24 04 62 1b 00 	movl   $0x1b62,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 4f 04 00 00       	call   14e8 <printf>
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
    10b8:	a3 04 1f 00 00       	mov    %eax,0x1f04
    printf(1,"\n n is updated as %d\n",*num);
    10bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c0:	8b 00                	mov    (%eax),%eax
    10c2:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c6:	c7 44 24 04 7a 1b 00 	movl   $0x1b7a,0x4(%esp)
    10cd:	00 
    10ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d5:	e8 0e 04 00 00       	call   14e8 <printf>
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
    1340:	b8 01 00 00 00       	mov    $0x1,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <exit>:
    1348:	b8 02 00 00 00       	mov    $0x2,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <wait>:
    1350:	b8 03 00 00 00       	mov    $0x3,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <pipe>:
    1358:	b8 04 00 00 00       	mov    $0x4,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <read>:
    1360:	b8 05 00 00 00       	mov    $0x5,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <write>:
    1368:	b8 10 00 00 00       	mov    $0x10,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <close>:
    1370:	b8 15 00 00 00       	mov    $0x15,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <kill>:
    1378:	b8 06 00 00 00       	mov    $0x6,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <exec>:
    1380:	b8 07 00 00 00       	mov    $0x7,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <open>:
    1388:	b8 0f 00 00 00       	mov    $0xf,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <mknod>:
    1390:	b8 11 00 00 00       	mov    $0x11,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <unlink>:
    1398:	b8 12 00 00 00       	mov    $0x12,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <fstat>:
    13a0:	b8 08 00 00 00       	mov    $0x8,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <link>:
    13a8:	b8 13 00 00 00       	mov    $0x13,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <mkdir>:
    13b0:	b8 14 00 00 00       	mov    $0x14,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <chdir>:
    13b8:	b8 09 00 00 00       	mov    $0x9,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <dup>:
    13c0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <getpid>:
    13c8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <sbrk>:
    13d0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <sleep>:
    13d8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <uptime>:
    13e0:	b8 0e 00 00 00       	mov    $0xe,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <clone>:
    13e8:	b8 16 00 00 00       	mov    $0x16,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <texit>:
    13f0:	b8 17 00 00 00       	mov    $0x17,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <tsleep>:
    13f8:	b8 18 00 00 00       	mov    $0x18,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <twakeup>:
    1400:	b8 19 00 00 00       	mov    $0x19,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1408:	55                   	push   %ebp
    1409:	89 e5                	mov    %esp,%ebp
    140b:	83 ec 18             	sub    $0x18,%esp
    140e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1411:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1414:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    141b:	00 
    141c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    141f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	89 04 24             	mov    %eax,(%esp)
    1429:	e8 3a ff ff ff       	call   1368 <write>
}
    142e:	c9                   	leave  
    142f:	c3                   	ret    

00001430 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
    1435:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1438:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    143f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1443:	74 17                	je     145c <printint+0x2c>
    1445:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1449:	79 11                	jns    145c <printint+0x2c>
    neg = 1;
    144b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1452:	8b 45 0c             	mov    0xc(%ebp),%eax
    1455:	f7 d8                	neg    %eax
    1457:	89 45 ec             	mov    %eax,-0x14(%ebp)
    145a:	eb 06                	jmp    1462 <printint+0x32>
  } else {
    x = xx;
    145c:	8b 45 0c             	mov    0xc(%ebp),%eax
    145f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1462:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1469:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    146c:	8d 41 01             	lea    0x1(%ecx),%eax
    146f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1472:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1475:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1478:	ba 00 00 00 00       	mov    $0x0,%edx
    147d:	f7 f3                	div    %ebx
    147f:	89 d0                	mov    %edx,%eax
    1481:	0f b6 80 08 1f 00 00 	movzbl 0x1f08(%eax),%eax
    1488:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    148c:	8b 75 10             	mov    0x10(%ebp),%esi
    148f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1492:	ba 00 00 00 00       	mov    $0x0,%edx
    1497:	f7 f6                	div    %esi
    1499:	89 45 ec             	mov    %eax,-0x14(%ebp)
    149c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14a0:	75 c7                	jne    1469 <printint+0x39>
  if(neg)
    14a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14a6:	74 10                	je     14b8 <printint+0x88>
    buf[i++] = '-';
    14a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ab:	8d 50 01             	lea    0x1(%eax),%edx
    14ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14b1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14b6:	eb 1f                	jmp    14d7 <printint+0xa7>
    14b8:	eb 1d                	jmp    14d7 <printint+0xa7>
    putc(fd, buf[i]);
    14ba:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c0:	01 d0                	add    %edx,%eax
    14c2:	0f b6 00             	movzbl (%eax),%eax
    14c5:	0f be c0             	movsbl %al,%eax
    14c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14cc:	8b 45 08             	mov    0x8(%ebp),%eax
    14cf:	89 04 24             	mov    %eax,(%esp)
    14d2:	e8 31 ff ff ff       	call   1408 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14d7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    14db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14df:	79 d9                	jns    14ba <printint+0x8a>
    putc(fd, buf[i]);
}
    14e1:	83 c4 30             	add    $0x30,%esp
    14e4:	5b                   	pop    %ebx
    14e5:	5e                   	pop    %esi
    14e6:	5d                   	pop    %ebp
    14e7:	c3                   	ret    

000014e8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14e8:	55                   	push   %ebp
    14e9:	89 e5                	mov    %esp,%ebp
    14eb:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14f5:	8d 45 0c             	lea    0xc(%ebp),%eax
    14f8:	83 c0 04             	add    $0x4,%eax
    14fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1505:	e9 7c 01 00 00       	jmp    1686 <printf+0x19e>
    c = fmt[i] & 0xff;
    150a:	8b 55 0c             	mov    0xc(%ebp),%edx
    150d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1510:	01 d0                	add    %edx,%eax
    1512:	0f b6 00             	movzbl (%eax),%eax
    1515:	0f be c0             	movsbl %al,%eax
    1518:	25 ff 00 00 00       	and    $0xff,%eax
    151d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1520:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1524:	75 2c                	jne    1552 <printf+0x6a>
      if(c == '%'){
    1526:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    152a:	75 0c                	jne    1538 <printf+0x50>
        state = '%';
    152c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1533:	e9 4a 01 00 00       	jmp    1682 <printf+0x19a>
      } else {
        putc(fd, c);
    1538:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    153b:	0f be c0             	movsbl %al,%eax
    153e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	89 04 24             	mov    %eax,(%esp)
    1548:	e8 bb fe ff ff       	call   1408 <putc>
    154d:	e9 30 01 00 00       	jmp    1682 <printf+0x19a>
      }
    } else if(state == '%'){
    1552:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1556:	0f 85 26 01 00 00    	jne    1682 <printf+0x19a>
      if(c == 'd'){
    155c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1560:	75 2d                	jne    158f <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1562:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1565:	8b 00                	mov    (%eax),%eax
    1567:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    156e:	00 
    156f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1576:	00 
    1577:	89 44 24 04          	mov    %eax,0x4(%esp)
    157b:	8b 45 08             	mov    0x8(%ebp),%eax
    157e:	89 04 24             	mov    %eax,(%esp)
    1581:	e8 aa fe ff ff       	call   1430 <printint>
        ap++;
    1586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    158a:	e9 ec 00 00 00       	jmp    167b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    158f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1593:	74 06                	je     159b <printf+0xb3>
    1595:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1599:	75 2d                	jne    15c8 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    159b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    159e:	8b 00                	mov    (%eax),%eax
    15a0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15a7:	00 
    15a8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15af:	00 
    15b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b4:	8b 45 08             	mov    0x8(%ebp),%eax
    15b7:	89 04 24             	mov    %eax,(%esp)
    15ba:	e8 71 fe ff ff       	call   1430 <printint>
        ap++;
    15bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15c3:	e9 b3 00 00 00       	jmp    167b <printf+0x193>
      } else if(c == 's'){
    15c8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    15cc:	75 45                	jne    1613 <printf+0x12b>
        s = (char*)*ap;
    15ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d1:	8b 00                	mov    (%eax),%eax
    15d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    15d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    15da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15de:	75 09                	jne    15e9 <printf+0x101>
          s = "(null)";
    15e0:	c7 45 f4 90 1b 00 00 	movl   $0x1b90,-0xc(%ebp)
        while(*s != 0){
    15e7:	eb 1e                	jmp    1607 <printf+0x11f>
    15e9:	eb 1c                	jmp    1607 <printf+0x11f>
          putc(fd, *s);
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	0f b6 00             	movzbl (%eax),%eax
    15f1:	0f be c0             	movsbl %al,%eax
    15f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f8:	8b 45 08             	mov    0x8(%ebp),%eax
    15fb:	89 04 24             	mov    %eax,(%esp)
    15fe:	e8 05 fe ff ff       	call   1408 <putc>
          s++;
    1603:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	0f b6 00             	movzbl (%eax),%eax
    160d:	84 c0                	test   %al,%al
    160f:	75 da                	jne    15eb <printf+0x103>
    1611:	eb 68                	jmp    167b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1613:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1617:	75 1d                	jne    1636 <printf+0x14e>
        putc(fd, *ap);
    1619:	8b 45 e8             	mov    -0x18(%ebp),%eax
    161c:	8b 00                	mov    (%eax),%eax
    161e:	0f be c0             	movsbl %al,%eax
    1621:	89 44 24 04          	mov    %eax,0x4(%esp)
    1625:	8b 45 08             	mov    0x8(%ebp),%eax
    1628:	89 04 24             	mov    %eax,(%esp)
    162b:	e8 d8 fd ff ff       	call   1408 <putc>
        ap++;
    1630:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1634:	eb 45                	jmp    167b <printf+0x193>
      } else if(c == '%'){
    1636:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    163a:	75 17                	jne    1653 <printf+0x16b>
        putc(fd, c);
    163c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    163f:	0f be c0             	movsbl %al,%eax
    1642:	89 44 24 04          	mov    %eax,0x4(%esp)
    1646:	8b 45 08             	mov    0x8(%ebp),%eax
    1649:	89 04 24             	mov    %eax,(%esp)
    164c:	e8 b7 fd ff ff       	call   1408 <putc>
    1651:	eb 28                	jmp    167b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1653:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    165a:	00 
    165b:	8b 45 08             	mov    0x8(%ebp),%eax
    165e:	89 04 24             	mov    %eax,(%esp)
    1661:	e8 a2 fd ff ff       	call   1408 <putc>
        putc(fd, c);
    1666:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1669:	0f be c0             	movsbl %al,%eax
    166c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1670:	8b 45 08             	mov    0x8(%ebp),%eax
    1673:	89 04 24             	mov    %eax,(%esp)
    1676:	e8 8d fd ff ff       	call   1408 <putc>
      }
      state = 0;
    167b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1682:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1686:	8b 55 0c             	mov    0xc(%ebp),%edx
    1689:	8b 45 f0             	mov    -0x10(%ebp),%eax
    168c:	01 d0                	add    %edx,%eax
    168e:	0f b6 00             	movzbl (%eax),%eax
    1691:	84 c0                	test   %al,%al
    1693:	0f 85 71 fe ff ff    	jne    150a <printf+0x22>
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
    169c:	55                   	push   %ebp
    169d:	89 e5                	mov    %esp,%ebp
    169f:	83 ec 10             	sub    $0x10,%esp
    16a2:	8b 45 08             	mov    0x8(%ebp),%eax
    16a5:	83 e8 08             	sub    $0x8,%eax
    16a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    16ab:	a1 28 1f 00 00       	mov    0x1f28,%eax
    16b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16b3:	eb 24                	jmp    16d9 <free+0x3d>
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
    16eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ee:	8b 40 04             	mov    0x4(%eax),%eax
    16f1:	c1 e0 03             	shl    $0x3,%eax
    16f4:	89 c2                	mov    %eax,%edx
    16f6:	03 55 f8             	add    -0x8(%ebp),%edx
    16f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fc:	8b 00                	mov    (%eax),%eax
    16fe:	39 c2                	cmp    %eax,%edx
    1700:	75 24                	jne    1726 <free+0x8a>
    1702:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1705:	8b 50 04             	mov    0x4(%eax),%edx
    1708:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170b:	8b 00                	mov    (%eax),%eax
    170d:	8b 40 04             	mov    0x4(%eax),%eax
    1710:	01 c2                	add    %eax,%edx
    1712:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1715:	89 50 04             	mov    %edx,0x4(%eax)
    1718:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171b:	8b 00                	mov    (%eax),%eax
    171d:	8b 10                	mov    (%eax),%edx
    171f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1722:	89 10                	mov    %edx,(%eax)
    1724:	eb 0a                	jmp    1730 <free+0x94>
    1726:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1729:	8b 10                	mov    (%eax),%edx
    172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    172e:	89 10                	mov    %edx,(%eax)
    1730:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1733:	8b 40 04             	mov    0x4(%eax),%eax
    1736:	c1 e0 03             	shl    $0x3,%eax
    1739:	03 45 fc             	add    -0x4(%ebp),%eax
    173c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    173f:	75 20                	jne    1761 <free+0xc5>
    1741:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1744:	8b 50 04             	mov    0x4(%eax),%edx
    1747:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174a:	8b 40 04             	mov    0x4(%eax),%eax
    174d:	01 c2                	add    %eax,%edx
    174f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1752:	89 50 04             	mov    %edx,0x4(%eax)
    1755:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1758:	8b 10                	mov    (%eax),%edx
    175a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175d:	89 10                	mov    %edx,(%eax)
    175f:	eb 08                	jmp    1769 <free+0xcd>
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1764:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1767:	89 10                	mov    %edx,(%eax)
    1769:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176c:	a3 28 1f 00 00       	mov    %eax,0x1f28
    1771:	c9                   	leave  
    1772:	c3                   	ret    

00001773 <morecore>:
    1773:	55                   	push   %ebp
    1774:	89 e5                	mov    %esp,%ebp
    1776:	83 ec 28             	sub    $0x28,%esp
    1779:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1780:	77 07                	ja     1789 <morecore+0x16>
    1782:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1789:	8b 45 08             	mov    0x8(%ebp),%eax
    178c:	c1 e0 03             	shl    $0x3,%eax
    178f:	89 04 24             	mov    %eax,(%esp)
    1792:	e8 39 fc ff ff       	call   13d0 <sbrk>
    1797:	89 45 f0             	mov    %eax,-0x10(%ebp)
    179a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    179e:	75 07                	jne    17a7 <morecore+0x34>
    17a0:	b8 00 00 00 00       	mov    $0x0,%eax
    17a5:	eb 22                	jmp    17c9 <morecore+0x56>
    17a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	8b 55 08             	mov    0x8(%ebp),%edx
    17b3:	89 50 04             	mov    %edx,0x4(%eax)
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b9:	83 c0 08             	add    $0x8,%eax
    17bc:	89 04 24             	mov    %eax,(%esp)
    17bf:	e8 d8 fe ff ff       	call   169c <free>
    17c4:	a1 28 1f 00 00       	mov    0x1f28,%eax
    17c9:	c9                   	leave  
    17ca:	c3                   	ret    

000017cb <malloc>:
    17cb:	55                   	push   %ebp
    17cc:	89 e5                	mov    %esp,%ebp
    17ce:	83 ec 28             	sub    $0x28,%esp
    17d1:	8b 45 08             	mov    0x8(%ebp),%eax
    17d4:	83 c0 07             	add    $0x7,%eax
    17d7:	c1 e8 03             	shr    $0x3,%eax
    17da:	83 c0 01             	add    $0x1,%eax
    17dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17e0:	a1 28 1f 00 00       	mov    0x1f28,%eax
    17e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17ec:	75 23                	jne    1811 <malloc+0x46>
    17ee:	c7 45 f0 20 1f 00 00 	movl   $0x1f20,-0x10(%ebp)
    17f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f8:	a3 28 1f 00 00       	mov    %eax,0x1f28
    17fd:	a1 28 1f 00 00       	mov    0x1f28,%eax
    1802:	a3 20 1f 00 00       	mov    %eax,0x1f20
    1807:	c7 05 24 1f 00 00 00 	movl   $0x0,0x1f24
    180e:	00 00 00 
    1811:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1814:	8b 00                	mov    (%eax),%eax
    1816:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1819:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181c:	8b 40 04             	mov    0x4(%eax),%eax
    181f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1822:	72 4d                	jb     1871 <malloc+0xa6>
    1824:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1827:	8b 40 04             	mov    0x4(%eax),%eax
    182a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    182d:	75 0c                	jne    183b <malloc+0x70>
    182f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1832:	8b 10                	mov    (%eax),%edx
    1834:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1837:	89 10                	mov    %edx,(%eax)
    1839:	eb 26                	jmp    1861 <malloc+0x96>
    183b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183e:	8b 40 04             	mov    0x4(%eax),%eax
    1841:	89 c2                	mov    %eax,%edx
    1843:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1846:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1849:	89 50 04             	mov    %edx,0x4(%eax)
    184c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184f:	8b 40 04             	mov    0x4(%eax),%eax
    1852:	c1 e0 03             	shl    $0x3,%eax
    1855:	01 45 ec             	add    %eax,-0x14(%ebp)
    1858:	8b 45 ec             	mov    -0x14(%ebp),%eax
    185b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    185e:	89 50 04             	mov    %edx,0x4(%eax)
    1861:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1864:	a3 28 1f 00 00       	mov    %eax,0x1f28
    1869:	8b 45 ec             	mov    -0x14(%ebp),%eax
    186c:	83 c0 08             	add    $0x8,%eax
    186f:	eb 38                	jmp    18a9 <malloc+0xde>
    1871:	a1 28 1f 00 00       	mov    0x1f28,%eax
    1876:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1879:	75 1b                	jne    1896 <malloc+0xcb>
    187b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187e:	89 04 24             	mov    %eax,(%esp)
    1881:	e8 ed fe ff ff       	call   1773 <morecore>
    1886:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1889:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    188d:	75 07                	jne    1896 <malloc+0xcb>
    188f:	b8 00 00 00 00       	mov    $0x0,%eax
    1894:	eb 13                	jmp    18a9 <malloc+0xde>
    1896:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1899:	89 45 f0             	mov    %eax,-0x10(%ebp)
    189c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    189f:	8b 00                	mov    (%eax),%eax
    18a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18a4:	e9 70 ff ff ff       	jmp    1819 <malloc+0x4e>
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
    18da:	90                   	nop
    18db:	8b 45 08             	mov    0x8(%ebp),%eax
    18de:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18e5:	00 
    18e6:	89 04 24             	mov    %eax,(%esp)
    18e9:	e8 be ff ff ff       	call   18ac <xchg>
    18ee:	85 c0                	test   %eax,%eax
    18f0:	75 e9                	jne    18db <lock_acquire+0x7>
}
    18f2:	c9                   	leave  
    18f3:	c3                   	ret    

000018f4 <lock_release>:
void lock_release(lock_t *lock){
    18f4:	55                   	push   %ebp
    18f5:	89 e5                	mov    %esp,%ebp
    18f7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    18fa:	8b 45 08             	mov    0x8(%ebp),%eax
    18fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1904:	00 
    1905:	89 04 24             	mov    %eax,(%esp)
    1908:	e8 9f ff ff ff       	call   18ac <xchg>
}
    190d:	c9                   	leave  
    190e:	c3                   	ret    

0000190f <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    190f:	55                   	push   %ebp
    1910:	89 e5                	mov    %esp,%ebp
    1912:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1915:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    191c:	e8 aa fe ff ff       	call   17cb <malloc>
    1921:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1924:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1927:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192d:	25 ff 0f 00 00       	and    $0xfff,%eax
    1932:	85 c0                	test   %eax,%eax
    1934:	74 14                	je     194a <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1936:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1939:	25 ff 0f 00 00       	and    $0xfff,%eax
    193e:	89 c2                	mov    %eax,%edx
    1940:	b8 00 10 00 00       	mov    $0x1000,%eax
    1945:	29 d0                	sub    %edx,%eax
    1947:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    194a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    194e:	75 1b                	jne    196b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1950:	c7 44 24 04 97 1b 00 	movl   $0x1b97,0x4(%esp)
    1957:	00 
    1958:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    195f:	e8 84 fb ff ff       	call   14e8 <printf>
        return 0;
    1964:	b8 00 00 00 00       	mov    $0x0,%eax
    1969:	eb 6f                	jmp    19da <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    196b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    196e:	8b 55 08             	mov    0x8(%ebp),%edx
    1971:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1974:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1978:	89 54 24 08          	mov    %edx,0x8(%esp)
    197c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1983:	00 
    1984:	89 04 24             	mov    %eax,(%esp)
    1987:	e8 5c fa ff ff       	call   13e8 <clone>
    198c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    198f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1993:	79 1b                	jns    19b0 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1995:	c7 44 24 04 a5 1b 00 	movl   $0x1ba5,0x4(%esp)
    199c:	00 
    199d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19a4:	e8 3f fb ff ff       	call   14e8 <printf>
        return 0;
    19a9:	b8 00 00 00 00       	mov    $0x0,%eax
    19ae:	eb 2a                	jmp    19da <thread_create+0xcb>
    }
    if(tid > 0){
    19b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19b4:	7e 05                	jle    19bb <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    19b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b9:	eb 1f                	jmp    19da <thread_create+0xcb>
    }
    if(tid == 0){
    19bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19bf:	75 14                	jne    19d5 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    19c1:	c7 44 24 04 b2 1b 00 	movl   $0x1bb2,0x4(%esp)
    19c8:	00 
    19c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19d0:	e8 13 fb ff ff       	call   14e8 <printf>
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
    19df:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
    19e4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    19ea:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    19ef:	a3 1c 1f 00 00       	mov    %eax,0x1f1c
    return (int)(rands % max);
    19f4:	a1 1c 1f 00 00       	mov    0x1f1c,%eax
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
    1ac1:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1ac4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac7:	8b 40 04             	mov    0x4(%eax),%eax
    1aca:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1acd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad0:	8b 40 04             	mov    0x4(%eax),%eax
    1ad3:	8b 50 04             	mov    0x4(%eax),%edx
    1ad6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1adc:	8b 45 f0             	mov    -0x10(%ebp),%eax
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
    1b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b14:	eb 05                	jmp    1b1b <pop_q+0x77>
    }
    return -1;
    1b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b1b:	c9                   	leave  
    1b1c:	c3                   	ret    
