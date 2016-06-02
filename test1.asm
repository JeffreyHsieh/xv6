
_test1:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

int n = 1;

void test_func(void *arg_ptr);

int main(int argc, char *argv[]){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp


   int pid = fork();
    1009:	e8 e2 04 00 00       	call   14f0 <fork>
    100e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid == 0){
    1012:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1017:	0f 85 44 01 00 00    	jne    1161 <main+0x161>
        void *tid = thread_create(test_func,(void *)0);
    101d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1024:	00 
    1025:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    102c:	e8 8e 0a 00 00       	call   1abf <thread_create>
    1031:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    1035:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    103a:	75 19                	jne    1055 <main+0x55>
            printf(1,"thread_create fails\n");
    103c:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1043:	00 
    1044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104b:	e8 48 06 00 00       	call   1698 <printf>
            exit();
    1050:	e8 a3 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1055:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    105c:	00 
    105d:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    1064:	e8 56 0a 00 00       	call   1abf <thread_create>
    1069:	89 44 24 18          	mov    %eax,0x18(%esp)
        if(tid == 0){
    106d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1072:	75 19                	jne    108d <main+0x8d>
            printf(1,"thread_create fails\n");
    1074:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    107b:	00 
    107c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1083:	e8 10 06 00 00       	call   1698 <printf>
            exit();
    1088:	e8 6b 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    108d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    109c:	e8 1e 0a 00 00       	call   1abf <thread_create>
    10a1:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    10a5:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10aa:	75 19                	jne    10c5 <main+0xc5>
            printf(1,"thread_create fails\n");
    10ac:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    10b3:	00 
    10b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10bb:	e8 d8 05 00 00       	call   1698 <printf>
            exit();
    10c0:	e8 33 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    10c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10cc:	00 
    10cd:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    10d4:	e8 e6 09 00 00       	call   1abf <thread_create>
    10d9:	89 44 24 18          	mov    %eax,0x18(%esp)
          if(tid == 0){
    10dd:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10e2:	75 19                	jne    10fd <main+0xfd>
            printf(1,"thread_create fails\n");
    10e4:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    10eb:	00 
    10ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f3:	e8 a0 05 00 00       	call   1698 <printf>
            exit();
    10f8:	e8 fb 03 00 00       	call   14f8 <exit>
        }
       tid = thread_create(test_func,(void *)0);
    10fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1104:	00 
    1105:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    110c:	e8 ae 09 00 00       	call   1abf <thread_create>
    1111:	89 44 24 18          	mov    %eax,0x18(%esp)
           if(tid == 0){
    1115:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    111a:	75 19                	jne    1135 <main+0x135>
            printf(1,"thread_create fails\n");
    111c:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1123:	00 
    1124:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112b:	e8 68 05 00 00       	call   1698 <printf>
            exit();
    1130:	e8 c3 03 00 00       	call   14f8 <exit>
        }
      while(wait()>=0);
    1135:	90                   	nop
    1136:	e8 c5 03 00 00       	call   1500 <wait>
    113b:	85 c0                	test   %eax,%eax
    113d:	79 f7                	jns    1136 <main+0x136>
        printf(1,"I am child, [6] n = %d\n",n);
    113f:	a1 88 20 00 00       	mov    0x2088,%eax
    1144:	89 44 24 08          	mov    %eax,0x8(%esp)
    1148:	c7 44 24 04 e2 1c 00 	movl   $0x1ce2,0x4(%esp)
    114f:	00 
    1150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1157:	e8 3c 05 00 00       	call   1698 <printf>
    115c:	e9 12 01 00 00       	jmp    1273 <main+0x273>
    }else if(pid > 0){
    1161:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1166:	0f 8e 07 01 00 00    	jle    1273 <main+0x273>
        void *tid = thread_create(test_func,(void *)0);
    116c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1173:	00 
    1174:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    117b:	e8 3f 09 00 00       	call   1abf <thread_create>
    1180:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    1184:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1189:	75 19                	jne    11a4 <main+0x1a4>
            printf(1,"thread_create fails\n");
    118b:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1192:	00 
    1193:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    119a:	e8 f9 04 00 00       	call   1698 <printf>
            exit();
    119f:	e8 54 03 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11ab:	00 
    11ac:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    11b3:	e8 07 09 00 00       	call   1abf <thread_create>
    11b8:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    11bc:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    11c1:	75 19                	jne    11dc <main+0x1dc>
            printf(1,"thread_create fails\n");
    11c3:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    11ca:	00 
    11cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d2:	e8 c1 04 00 00       	call   1698 <printf>
            exit();
    11d7:	e8 1c 03 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11e3:	00 
    11e4:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    11eb:	e8 cf 08 00 00       	call   1abf <thread_create>
    11f0:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    11f4:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    11f9:	75 19                	jne    1214 <main+0x214>
            printf(1,"thread_create fails\n");
    11fb:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1202:	00 
    1203:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    120a:	e8 89 04 00 00       	call   1698 <printf>
            exit();
    120f:	e8 e4 02 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1214:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    121b:	00 
    121c:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    1223:	e8 97 08 00 00       	call   1abf <thread_create>
    1228:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    122c:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1231:	75 19                	jne    124c <main+0x24c>
            printf(1,"thread_create fails\n");
    1233:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    123a:	00 
    123b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1242:	e8 51 04 00 00       	call   1698 <printf>
            exit();
    1247:	e8 ac 02 00 00       	call   14f8 <exit>
        }
        while(wait()>=0);
    124c:	90                   	nop
    124d:	e8 ae 02 00 00       	call   1500 <wait>
    1252:	85 c0                	test   %eax,%eax
    1254:	79 f7                	jns    124d <main+0x24d>
        printf(1,"I am parent, [5] n = %d\n",n);
    1256:	a1 88 20 00 00       	mov    0x2088,%eax
    125b:	89 44 24 08          	mov    %eax,0x8(%esp)
    125f:	c7 44 24 04 fa 1c 00 	movl   $0x1cfa,0x4(%esp)
    1266:	00 
    1267:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    126e:	e8 25 04 00 00       	call   1698 <printf>
    }

   exit();
    1273:	e8 80 02 00 00       	call   14f8 <exit>

00001278 <test_func>:
}

void test_func(void *arg_ptr){
    1278:	55                   	push   %ebp
    1279:	89 e5                	mov    %esp,%ebp
    127b:	83 ec 08             	sub    $0x8,%esp
//    printf(1,"\n n = %d\n",n);
    n++;
    127e:	a1 88 20 00 00       	mov    0x2088,%eax
    1283:	83 c0 01             	add    $0x1,%eax
    1286:	a3 88 20 00 00       	mov    %eax,0x2088
   // printf(1,"after increase by 1 , n = %d\n\n",n);
    texit();
    128b:	e8 10 03 00 00       	call   15a0 <texit>

00001290 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	57                   	push   %edi
    1294:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1295:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1298:	8b 55 10             	mov    0x10(%ebp),%edx
    129b:	8b 45 0c             	mov    0xc(%ebp),%eax
    129e:	89 cb                	mov    %ecx,%ebx
    12a0:	89 df                	mov    %ebx,%edi
    12a2:	89 d1                	mov    %edx,%ecx
    12a4:	fc                   	cld    
    12a5:	f3 aa                	rep stos %al,%es:(%edi)
    12a7:	89 ca                	mov    %ecx,%edx
    12a9:	89 fb                	mov    %edi,%ebx
    12ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
    12ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    12b1:	5b                   	pop    %ebx
    12b2:	5f                   	pop    %edi
    12b3:	5d                   	pop    %ebp
    12b4:	c3                   	ret    

000012b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    12b5:	55                   	push   %ebp
    12b6:	89 e5                	mov    %esp,%ebp
    12b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    12bb:	8b 45 08             	mov    0x8(%ebp),%eax
    12be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    12c1:	90                   	nop
    12c2:	8b 45 08             	mov    0x8(%ebp),%eax
    12c5:	8d 50 01             	lea    0x1(%eax),%edx
    12c8:	89 55 08             	mov    %edx,0x8(%ebp)
    12cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    12ce:	8d 4a 01             	lea    0x1(%edx),%ecx
    12d1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    12d4:	0f b6 12             	movzbl (%edx),%edx
    12d7:	88 10                	mov    %dl,(%eax)
    12d9:	0f b6 00             	movzbl (%eax),%eax
    12dc:	84 c0                	test   %al,%al
    12de:	75 e2                	jne    12c2 <strcpy+0xd>
    ;
  return os;
    12e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12e3:	c9                   	leave  
    12e4:	c3                   	ret    

000012e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12e5:	55                   	push   %ebp
    12e6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    12e8:	eb 08                	jmp    12f2 <strcmp+0xd>
    p++, q++;
    12ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    12f2:	8b 45 08             	mov    0x8(%ebp),%eax
    12f5:	0f b6 00             	movzbl (%eax),%eax
    12f8:	84 c0                	test   %al,%al
    12fa:	74 10                	je     130c <strcmp+0x27>
    12fc:	8b 45 08             	mov    0x8(%ebp),%eax
    12ff:	0f b6 10             	movzbl (%eax),%edx
    1302:	8b 45 0c             	mov    0xc(%ebp),%eax
    1305:	0f b6 00             	movzbl (%eax),%eax
    1308:	38 c2                	cmp    %al,%dl
    130a:	74 de                	je     12ea <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    130c:	8b 45 08             	mov    0x8(%ebp),%eax
    130f:	0f b6 00             	movzbl (%eax),%eax
    1312:	0f b6 d0             	movzbl %al,%edx
    1315:	8b 45 0c             	mov    0xc(%ebp),%eax
    1318:	0f b6 00             	movzbl (%eax),%eax
    131b:	0f b6 c0             	movzbl %al,%eax
    131e:	29 c2                	sub    %eax,%edx
    1320:	89 d0                	mov    %edx,%eax
}
    1322:	5d                   	pop    %ebp
    1323:	c3                   	ret    

00001324 <strlen>:

uint
strlen(char *s)
{
    1324:	55                   	push   %ebp
    1325:	89 e5                	mov    %esp,%ebp
    1327:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    132a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1331:	eb 04                	jmp    1337 <strlen+0x13>
    1333:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1337:	8b 55 fc             	mov    -0x4(%ebp),%edx
    133a:	8b 45 08             	mov    0x8(%ebp),%eax
    133d:	01 d0                	add    %edx,%eax
    133f:	0f b6 00             	movzbl (%eax),%eax
    1342:	84 c0                	test   %al,%al
    1344:	75 ed                	jne    1333 <strlen+0xf>
    ;
  return n;
    1346:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1349:	c9                   	leave  
    134a:	c3                   	ret    

0000134b <memset>:

void*
memset(void *dst, int c, uint n)
{
    134b:	55                   	push   %ebp
    134c:	89 e5                	mov    %esp,%ebp
    134e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1351:	8b 45 10             	mov    0x10(%ebp),%eax
    1354:	89 44 24 08          	mov    %eax,0x8(%esp)
    1358:	8b 45 0c             	mov    0xc(%ebp),%eax
    135b:	89 44 24 04          	mov    %eax,0x4(%esp)
    135f:	8b 45 08             	mov    0x8(%ebp),%eax
    1362:	89 04 24             	mov    %eax,(%esp)
    1365:	e8 26 ff ff ff       	call   1290 <stosb>
  return dst;
    136a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    136d:	c9                   	leave  
    136e:	c3                   	ret    

0000136f <strchr>:

char*
strchr(const char *s, char c)
{
    136f:	55                   	push   %ebp
    1370:	89 e5                	mov    %esp,%ebp
    1372:	83 ec 04             	sub    $0x4,%esp
    1375:	8b 45 0c             	mov    0xc(%ebp),%eax
    1378:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    137b:	eb 14                	jmp    1391 <strchr+0x22>
    if(*s == c)
    137d:	8b 45 08             	mov    0x8(%ebp),%eax
    1380:	0f b6 00             	movzbl (%eax),%eax
    1383:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1386:	75 05                	jne    138d <strchr+0x1e>
      return (char*)s;
    1388:	8b 45 08             	mov    0x8(%ebp),%eax
    138b:	eb 13                	jmp    13a0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    138d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1391:	8b 45 08             	mov    0x8(%ebp),%eax
    1394:	0f b6 00             	movzbl (%eax),%eax
    1397:	84 c0                	test   %al,%al
    1399:	75 e2                	jne    137d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    139b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13a0:	c9                   	leave  
    13a1:	c3                   	ret    

000013a2 <gets>:

char*
gets(char *buf, int max)
{
    13a2:	55                   	push   %ebp
    13a3:	89 e5                	mov    %esp,%ebp
    13a5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13af:	eb 4c                	jmp    13fd <gets+0x5b>
    cc = read(0, &c, 1);
    13b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13b8:	00 
    13b9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    13bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    13c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13c7:	e8 44 01 00 00       	call   1510 <read>
    13cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    13cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13d3:	7f 02                	jg     13d7 <gets+0x35>
      break;
    13d5:	eb 31                	jmp    1408 <gets+0x66>
    buf[i++] = c;
    13d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13da:	8d 50 01             	lea    0x1(%eax),%edx
    13dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13e0:	89 c2                	mov    %eax,%edx
    13e2:	8b 45 08             	mov    0x8(%ebp),%eax
    13e5:	01 c2                	add    %eax,%edx
    13e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    13ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13f1:	3c 0a                	cmp    $0xa,%al
    13f3:	74 13                	je     1408 <gets+0x66>
    13f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13f9:	3c 0d                	cmp    $0xd,%al
    13fb:	74 0b                	je     1408 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1400:	83 c0 01             	add    $0x1,%eax
    1403:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1406:	7c a9                	jl     13b1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1408:	8b 55 f4             	mov    -0xc(%ebp),%edx
    140b:	8b 45 08             	mov    0x8(%ebp),%eax
    140e:	01 d0                	add    %edx,%eax
    1410:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1416:	c9                   	leave  
    1417:	c3                   	ret    

00001418 <stat>:

int
stat(char *n, struct stat *st)
{
    1418:	55                   	push   %ebp
    1419:	89 e5                	mov    %esp,%ebp
    141b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    141e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1425:	00 
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	89 04 24             	mov    %eax,(%esp)
    142c:	e8 07 01 00 00       	call   1538 <open>
    1431:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1434:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1438:	79 07                	jns    1441 <stat+0x29>
    return -1;
    143a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    143f:	eb 23                	jmp    1464 <stat+0x4c>
  r = fstat(fd, st);
    1441:	8b 45 0c             	mov    0xc(%ebp),%eax
    1444:	89 44 24 04          	mov    %eax,0x4(%esp)
    1448:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144b:	89 04 24             	mov    %eax,(%esp)
    144e:	e8 fd 00 00 00       	call   1550 <fstat>
    1453:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1456:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1459:	89 04 24             	mov    %eax,(%esp)
    145c:	e8 bf 00 00 00       	call   1520 <close>
  return r;
    1461:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1464:	c9                   	leave  
    1465:	c3                   	ret    

00001466 <atoi>:

int
atoi(const char *s)
{
    1466:	55                   	push   %ebp
    1467:	89 e5                	mov    %esp,%ebp
    1469:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    146c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1473:	eb 25                	jmp    149a <atoi+0x34>
    n = n*10 + *s++ - '0';
    1475:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1478:	89 d0                	mov    %edx,%eax
    147a:	c1 e0 02             	shl    $0x2,%eax
    147d:	01 d0                	add    %edx,%eax
    147f:	01 c0                	add    %eax,%eax
    1481:	89 c1                	mov    %eax,%ecx
    1483:	8b 45 08             	mov    0x8(%ebp),%eax
    1486:	8d 50 01             	lea    0x1(%eax),%edx
    1489:	89 55 08             	mov    %edx,0x8(%ebp)
    148c:	0f b6 00             	movzbl (%eax),%eax
    148f:	0f be c0             	movsbl %al,%eax
    1492:	01 c8                	add    %ecx,%eax
    1494:	83 e8 30             	sub    $0x30,%eax
    1497:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	0f b6 00             	movzbl (%eax),%eax
    14a0:	3c 2f                	cmp    $0x2f,%al
    14a2:	7e 0a                	jle    14ae <atoi+0x48>
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	0f b6 00             	movzbl (%eax),%eax
    14aa:	3c 39                	cmp    $0x39,%al
    14ac:	7e c7                	jle    1475 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    14ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14b1:	c9                   	leave  
    14b2:	c3                   	ret    

000014b3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14b3:	55                   	push   %ebp
    14b4:	89 e5                	mov    %esp,%ebp
    14b6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
    14bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    14bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    14c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    14c5:	eb 17                	jmp    14de <memmove+0x2b>
    *dst++ = *src++;
    14c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14ca:	8d 50 01             	lea    0x1(%eax),%edx
    14cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
    14d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14d3:	8d 4a 01             	lea    0x1(%edx),%ecx
    14d6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    14d9:	0f b6 12             	movzbl (%edx),%edx
    14dc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14de:	8b 45 10             	mov    0x10(%ebp),%eax
    14e1:	8d 50 ff             	lea    -0x1(%eax),%edx
    14e4:	89 55 10             	mov    %edx,0x10(%ebp)
    14e7:	85 c0                	test   %eax,%eax
    14e9:	7f dc                	jg     14c7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    14eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14ee:	c9                   	leave  
    14ef:	c3                   	ret    

000014f0 <fork>:
    14f0:	b8 01 00 00 00       	mov    $0x1,%eax
    14f5:	cd 40                	int    $0x40
    14f7:	c3                   	ret    

000014f8 <exit>:
    14f8:	b8 02 00 00 00       	mov    $0x2,%eax
    14fd:	cd 40                	int    $0x40
    14ff:	c3                   	ret    

00001500 <wait>:
    1500:	b8 03 00 00 00       	mov    $0x3,%eax
    1505:	cd 40                	int    $0x40
    1507:	c3                   	ret    

00001508 <pipe>:
    1508:	b8 04 00 00 00       	mov    $0x4,%eax
    150d:	cd 40                	int    $0x40
    150f:	c3                   	ret    

00001510 <read>:
    1510:	b8 05 00 00 00       	mov    $0x5,%eax
    1515:	cd 40                	int    $0x40
    1517:	c3                   	ret    

00001518 <write>:
    1518:	b8 10 00 00 00       	mov    $0x10,%eax
    151d:	cd 40                	int    $0x40
    151f:	c3                   	ret    

00001520 <close>:
    1520:	b8 15 00 00 00       	mov    $0x15,%eax
    1525:	cd 40                	int    $0x40
    1527:	c3                   	ret    

00001528 <kill>:
    1528:	b8 06 00 00 00       	mov    $0x6,%eax
    152d:	cd 40                	int    $0x40
    152f:	c3                   	ret    

00001530 <exec>:
    1530:	b8 07 00 00 00       	mov    $0x7,%eax
    1535:	cd 40                	int    $0x40
    1537:	c3                   	ret    

00001538 <open>:
    1538:	b8 0f 00 00 00       	mov    $0xf,%eax
    153d:	cd 40                	int    $0x40
    153f:	c3                   	ret    

00001540 <mknod>:
    1540:	b8 11 00 00 00       	mov    $0x11,%eax
    1545:	cd 40                	int    $0x40
    1547:	c3                   	ret    

00001548 <unlink>:
    1548:	b8 12 00 00 00       	mov    $0x12,%eax
    154d:	cd 40                	int    $0x40
    154f:	c3                   	ret    

00001550 <fstat>:
    1550:	b8 08 00 00 00       	mov    $0x8,%eax
    1555:	cd 40                	int    $0x40
    1557:	c3                   	ret    

00001558 <link>:
    1558:	b8 13 00 00 00       	mov    $0x13,%eax
    155d:	cd 40                	int    $0x40
    155f:	c3                   	ret    

00001560 <mkdir>:
    1560:	b8 14 00 00 00       	mov    $0x14,%eax
    1565:	cd 40                	int    $0x40
    1567:	c3                   	ret    

00001568 <chdir>:
    1568:	b8 09 00 00 00       	mov    $0x9,%eax
    156d:	cd 40                	int    $0x40
    156f:	c3                   	ret    

00001570 <dup>:
    1570:	b8 0a 00 00 00       	mov    $0xa,%eax
    1575:	cd 40                	int    $0x40
    1577:	c3                   	ret    

00001578 <getpid>:
    1578:	b8 0b 00 00 00       	mov    $0xb,%eax
    157d:	cd 40                	int    $0x40
    157f:	c3                   	ret    

00001580 <sbrk>:
    1580:	b8 0c 00 00 00       	mov    $0xc,%eax
    1585:	cd 40                	int    $0x40
    1587:	c3                   	ret    

00001588 <sleep>:
    1588:	b8 0d 00 00 00       	mov    $0xd,%eax
    158d:	cd 40                	int    $0x40
    158f:	c3                   	ret    

00001590 <uptime>:
    1590:	b8 0e 00 00 00       	mov    $0xe,%eax
    1595:	cd 40                	int    $0x40
    1597:	c3                   	ret    

00001598 <clone>:
    1598:	b8 16 00 00 00       	mov    $0x16,%eax
    159d:	cd 40                	int    $0x40
    159f:	c3                   	ret    

000015a0 <texit>:
    15a0:	b8 17 00 00 00       	mov    $0x17,%eax
    15a5:	cd 40                	int    $0x40
    15a7:	c3                   	ret    

000015a8 <tsleep>:
    15a8:	b8 18 00 00 00       	mov    $0x18,%eax
    15ad:	cd 40                	int    $0x40
    15af:	c3                   	ret    

000015b0 <twakeup>:
    15b0:	b8 19 00 00 00       	mov    $0x19,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15b8:	55                   	push   %ebp
    15b9:	89 e5                	mov    %esp,%ebp
    15bb:	83 ec 18             	sub    $0x18,%esp
    15be:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15cb:	00 
    15cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d3:	8b 45 08             	mov    0x8(%ebp),%eax
    15d6:	89 04 24             	mov    %eax,(%esp)
    15d9:	e8 3a ff ff ff       	call   1518 <write>
}
    15de:	c9                   	leave  
    15df:	c3                   	ret    

000015e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	56                   	push   %esi
    15e4:	53                   	push   %ebx
    15e5:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    15e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    15ef:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    15f3:	74 17                	je     160c <printint+0x2c>
    15f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15f9:	79 11                	jns    160c <printint+0x2c>
    neg = 1;
    15fb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1602:	8b 45 0c             	mov    0xc(%ebp),%eax
    1605:	f7 d8                	neg    %eax
    1607:	89 45 ec             	mov    %eax,-0x14(%ebp)
    160a:	eb 06                	jmp    1612 <printint+0x32>
  } else {
    x = xx;
    160c:	8b 45 0c             	mov    0xc(%ebp),%eax
    160f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1612:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1619:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    161c:	8d 41 01             	lea    0x1(%ecx),%eax
    161f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1622:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1625:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1628:	ba 00 00 00 00       	mov    $0x0,%edx
    162d:	f7 f3                	div    %ebx
    162f:	89 d0                	mov    %edx,%eax
    1631:	0f b6 80 8c 20 00 00 	movzbl 0x208c(%eax),%eax
    1638:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    163c:	8b 75 10             	mov    0x10(%ebp),%esi
    163f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1642:	ba 00 00 00 00       	mov    $0x0,%edx
    1647:	f7 f6                	div    %esi
    1649:	89 45 ec             	mov    %eax,-0x14(%ebp)
    164c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1650:	75 c7                	jne    1619 <printint+0x39>
  if(neg)
    1652:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1656:	74 10                	je     1668 <printint+0x88>
    buf[i++] = '-';
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	8d 50 01             	lea    0x1(%eax),%edx
    165e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1661:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1666:	eb 1f                	jmp    1687 <printint+0xa7>
    1668:	eb 1d                	jmp    1687 <printint+0xa7>
    putc(fd, buf[i]);
    166a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	01 d0                	add    %edx,%eax
    1672:	0f b6 00             	movzbl (%eax),%eax
    1675:	0f be c0             	movsbl %al,%eax
    1678:	89 44 24 04          	mov    %eax,0x4(%esp)
    167c:	8b 45 08             	mov    0x8(%ebp),%eax
    167f:	89 04 24             	mov    %eax,(%esp)
    1682:	e8 31 ff ff ff       	call   15b8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1687:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    168b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    168f:	79 d9                	jns    166a <printint+0x8a>
    putc(fd, buf[i]);
}
    1691:	83 c4 30             	add    $0x30,%esp
    1694:	5b                   	pop    %ebx
    1695:	5e                   	pop    %esi
    1696:	5d                   	pop    %ebp
    1697:	c3                   	ret    

00001698 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1698:	55                   	push   %ebp
    1699:	89 e5                	mov    %esp,%ebp
    169b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    169e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16a5:	8d 45 0c             	lea    0xc(%ebp),%eax
    16a8:	83 c0 04             	add    $0x4,%eax
    16ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    16ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16b5:	e9 7c 01 00 00       	jmp    1836 <printf+0x19e>
    c = fmt[i] & 0xff;
    16ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    16bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c0:	01 d0                	add    %edx,%eax
    16c2:	0f b6 00             	movzbl (%eax),%eax
    16c5:	0f be c0             	movsbl %al,%eax
    16c8:	25 ff 00 00 00       	and    $0xff,%eax
    16cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    16d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16d4:	75 2c                	jne    1702 <printf+0x6a>
      if(c == '%'){
    16d6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16da:	75 0c                	jne    16e8 <printf+0x50>
        state = '%';
    16dc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    16e3:	e9 4a 01 00 00       	jmp    1832 <printf+0x19a>
      } else {
        putc(fd, c);
    16e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16eb:	0f be c0             	movsbl %al,%eax
    16ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f2:	8b 45 08             	mov    0x8(%ebp),%eax
    16f5:	89 04 24             	mov    %eax,(%esp)
    16f8:	e8 bb fe ff ff       	call   15b8 <putc>
    16fd:	e9 30 01 00 00       	jmp    1832 <printf+0x19a>
      }
    } else if(state == '%'){
    1702:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1706:	0f 85 26 01 00 00    	jne    1832 <printf+0x19a>
      if(c == 'd'){
    170c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1710:	75 2d                	jne    173f <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1712:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1715:	8b 00                	mov    (%eax),%eax
    1717:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    171e:	00 
    171f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1726:	00 
    1727:	89 44 24 04          	mov    %eax,0x4(%esp)
    172b:	8b 45 08             	mov    0x8(%ebp),%eax
    172e:	89 04 24             	mov    %eax,(%esp)
    1731:	e8 aa fe ff ff       	call   15e0 <printint>
        ap++;
    1736:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    173a:	e9 ec 00 00 00       	jmp    182b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    173f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1743:	74 06                	je     174b <printf+0xb3>
    1745:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1749:	75 2d                	jne    1778 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    174b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    174e:	8b 00                	mov    (%eax),%eax
    1750:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1757:	00 
    1758:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    175f:	00 
    1760:	89 44 24 04          	mov    %eax,0x4(%esp)
    1764:	8b 45 08             	mov    0x8(%ebp),%eax
    1767:	89 04 24             	mov    %eax,(%esp)
    176a:	e8 71 fe ff ff       	call   15e0 <printint>
        ap++;
    176f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1773:	e9 b3 00 00 00       	jmp    182b <printf+0x193>
      } else if(c == 's'){
    1778:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    177c:	75 45                	jne    17c3 <printf+0x12b>
        s = (char*)*ap;
    177e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1781:	8b 00                	mov    (%eax),%eax
    1783:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1786:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    178a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    178e:	75 09                	jne    1799 <printf+0x101>
          s = "(null)";
    1790:	c7 45 f4 13 1d 00 00 	movl   $0x1d13,-0xc(%ebp)
        while(*s != 0){
    1797:	eb 1e                	jmp    17b7 <printf+0x11f>
    1799:	eb 1c                	jmp    17b7 <printf+0x11f>
          putc(fd, *s);
    179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179e:	0f b6 00             	movzbl (%eax),%eax
    17a1:	0f be c0             	movsbl %al,%eax
    17a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    17a8:	8b 45 08             	mov    0x8(%ebp),%eax
    17ab:	89 04 24             	mov    %eax,(%esp)
    17ae:	e8 05 fe ff ff       	call   15b8 <putc>
          s++;
    17b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ba:	0f b6 00             	movzbl (%eax),%eax
    17bd:	84 c0                	test   %al,%al
    17bf:	75 da                	jne    179b <printf+0x103>
    17c1:	eb 68                	jmp    182b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    17c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    17c7:	75 1d                	jne    17e6 <printf+0x14e>
        putc(fd, *ap);
    17c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17cc:	8b 00                	mov    (%eax),%eax
    17ce:	0f be c0             	movsbl %al,%eax
    17d1:	89 44 24 04          	mov    %eax,0x4(%esp)
    17d5:	8b 45 08             	mov    0x8(%ebp),%eax
    17d8:	89 04 24             	mov    %eax,(%esp)
    17db:	e8 d8 fd ff ff       	call   15b8 <putc>
        ap++;
    17e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17e4:	eb 45                	jmp    182b <printf+0x193>
      } else if(c == '%'){
    17e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17ea:	75 17                	jne    1803 <printf+0x16b>
        putc(fd, c);
    17ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17ef:	0f be c0             	movsbl %al,%eax
    17f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	89 04 24             	mov    %eax,(%esp)
    17fc:	e8 b7 fd ff ff       	call   15b8 <putc>
    1801:	eb 28                	jmp    182b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1803:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    180a:	00 
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	89 04 24             	mov    %eax,(%esp)
    1811:	e8 a2 fd ff ff       	call   15b8 <putc>
        putc(fd, c);
    1816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1819:	0f be c0             	movsbl %al,%eax
    181c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1820:	8b 45 08             	mov    0x8(%ebp),%eax
    1823:	89 04 24             	mov    %eax,(%esp)
    1826:	e8 8d fd ff ff       	call   15b8 <putc>
      }
      state = 0;
    182b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1832:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1836:	8b 55 0c             	mov    0xc(%ebp),%edx
    1839:	8b 45 f0             	mov    -0x10(%ebp),%eax
    183c:	01 d0                	add    %edx,%eax
    183e:	0f b6 00             	movzbl (%eax),%eax
    1841:	84 c0                	test   %al,%al
    1843:	0f 85 71 fe ff ff    	jne    16ba <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1849:	c9                   	leave  
    184a:	c3                   	ret    
    184b:	90                   	nop

0000184c <free>:
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 10             	sub    $0x10,%esp
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	83 e8 08             	sub    $0x8,%eax
    1858:	89 45 f8             	mov    %eax,-0x8(%ebp)
    185b:	a1 ac 20 00 00       	mov    0x20ac,%eax
    1860:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1863:	eb 24                	jmp    1889 <free+0x3d>
    1865:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1868:	8b 00                	mov    (%eax),%eax
    186a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    186d:	77 12                	ja     1881 <free+0x35>
    186f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1872:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1875:	77 24                	ja     189b <free+0x4f>
    1877:	8b 45 fc             	mov    -0x4(%ebp),%eax
    187a:	8b 00                	mov    (%eax),%eax
    187c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    187f:	77 1a                	ja     189b <free+0x4f>
    1881:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1884:	8b 00                	mov    (%eax),%eax
    1886:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1889:	8b 45 f8             	mov    -0x8(%ebp),%eax
    188c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    188f:	76 d4                	jbe    1865 <free+0x19>
    1891:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1894:	8b 00                	mov    (%eax),%eax
    1896:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1899:	76 ca                	jbe    1865 <free+0x19>
    189b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    189e:	8b 40 04             	mov    0x4(%eax),%eax
    18a1:	c1 e0 03             	shl    $0x3,%eax
    18a4:	89 c2                	mov    %eax,%edx
    18a6:	03 55 f8             	add    -0x8(%ebp),%edx
    18a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ac:	8b 00                	mov    (%eax),%eax
    18ae:	39 c2                	cmp    %eax,%edx
    18b0:	75 24                	jne    18d6 <free+0x8a>
    18b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b5:	8b 50 04             	mov    0x4(%eax),%edx
    18b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18bb:	8b 00                	mov    (%eax),%eax
    18bd:	8b 40 04             	mov    0x4(%eax),%eax
    18c0:	01 c2                	add    %eax,%edx
    18c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c5:	89 50 04             	mov    %edx,0x4(%eax)
    18c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18cb:	8b 00                	mov    (%eax),%eax
    18cd:	8b 10                	mov    (%eax),%edx
    18cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18d2:	89 10                	mov    %edx,(%eax)
    18d4:	eb 0a                	jmp    18e0 <free+0x94>
    18d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d9:	8b 10                	mov    (%eax),%edx
    18db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18de:	89 10                	mov    %edx,(%eax)
    18e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e3:	8b 40 04             	mov    0x4(%eax),%eax
    18e6:	c1 e0 03             	shl    $0x3,%eax
    18e9:	03 45 fc             	add    -0x4(%ebp),%eax
    18ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18ef:	75 20                	jne    1911 <free+0xc5>
    18f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f4:	8b 50 04             	mov    0x4(%eax),%edx
    18f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18fa:	8b 40 04             	mov    0x4(%eax),%eax
    18fd:	01 c2                	add    %eax,%edx
    18ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1902:	89 50 04             	mov    %edx,0x4(%eax)
    1905:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1908:	8b 10                	mov    (%eax),%edx
    190a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    190d:	89 10                	mov    %edx,(%eax)
    190f:	eb 08                	jmp    1919 <free+0xcd>
    1911:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1914:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1917:	89 10                	mov    %edx,(%eax)
    1919:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191c:	a3 ac 20 00 00       	mov    %eax,0x20ac
    1921:	c9                   	leave  
    1922:	c3                   	ret    

00001923 <morecore>:
    1923:	55                   	push   %ebp
    1924:	89 e5                	mov    %esp,%ebp
    1926:	83 ec 28             	sub    $0x28,%esp
    1929:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1930:	77 07                	ja     1939 <morecore+0x16>
    1932:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1939:	8b 45 08             	mov    0x8(%ebp),%eax
    193c:	c1 e0 03             	shl    $0x3,%eax
    193f:	89 04 24             	mov    %eax,(%esp)
    1942:	e8 39 fc ff ff       	call   1580 <sbrk>
    1947:	89 45 f0             	mov    %eax,-0x10(%ebp)
    194a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    194e:	75 07                	jne    1957 <morecore+0x34>
    1950:	b8 00 00 00 00       	mov    $0x0,%eax
    1955:	eb 22                	jmp    1979 <morecore+0x56>
    1957:	8b 45 f0             	mov    -0x10(%ebp),%eax
    195a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    195d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1960:	8b 55 08             	mov    0x8(%ebp),%edx
    1963:	89 50 04             	mov    %edx,0x4(%eax)
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	83 c0 08             	add    $0x8,%eax
    196c:	89 04 24             	mov    %eax,(%esp)
    196f:	e8 d8 fe ff ff       	call   184c <free>
    1974:	a1 ac 20 00 00       	mov    0x20ac,%eax
    1979:	c9                   	leave  
    197a:	c3                   	ret    

0000197b <malloc>:
    197b:	55                   	push   %ebp
    197c:	89 e5                	mov    %esp,%ebp
    197e:	83 ec 28             	sub    $0x28,%esp
    1981:	8b 45 08             	mov    0x8(%ebp),%eax
    1984:	83 c0 07             	add    $0x7,%eax
    1987:	c1 e8 03             	shr    $0x3,%eax
    198a:	83 c0 01             	add    $0x1,%eax
    198d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1990:	a1 ac 20 00 00       	mov    0x20ac,%eax
    1995:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1998:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    199c:	75 23                	jne    19c1 <malloc+0x46>
    199e:	c7 45 f0 a4 20 00 00 	movl   $0x20a4,-0x10(%ebp)
    19a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19a8:	a3 ac 20 00 00       	mov    %eax,0x20ac
    19ad:	a1 ac 20 00 00       	mov    0x20ac,%eax
    19b2:	a3 a4 20 00 00       	mov    %eax,0x20a4
    19b7:	c7 05 a8 20 00 00 00 	movl   $0x0,0x20a8
    19be:	00 00 00 
    19c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19c4:	8b 00                	mov    (%eax),%eax
    19c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19cc:	8b 40 04             	mov    0x4(%eax),%eax
    19cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19d2:	72 4d                	jb     1a21 <malloc+0xa6>
    19d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19d7:	8b 40 04             	mov    0x4(%eax),%eax
    19da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19dd:	75 0c                	jne    19eb <malloc+0x70>
    19df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19e2:	8b 10                	mov    (%eax),%edx
    19e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e7:	89 10                	mov    %edx,(%eax)
    19e9:	eb 26                	jmp    1a11 <malloc+0x96>
    19eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19ee:	8b 40 04             	mov    0x4(%eax),%eax
    19f1:	89 c2                	mov    %eax,%edx
    19f3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    19f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19f9:	89 50 04             	mov    %edx,0x4(%eax)
    19fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19ff:	8b 40 04             	mov    0x4(%eax),%eax
    1a02:	c1 e0 03             	shl    $0x3,%eax
    1a05:	01 45 ec             	add    %eax,-0x14(%ebp)
    1a08:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0e:	89 50 04             	mov    %edx,0x4(%eax)
    1a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a14:	a3 ac 20 00 00       	mov    %eax,0x20ac
    1a19:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a1c:	83 c0 08             	add    $0x8,%eax
    1a1f:	eb 38                	jmp    1a59 <malloc+0xde>
    1a21:	a1 ac 20 00 00       	mov    0x20ac,%eax
    1a26:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a29:	75 1b                	jne    1a46 <malloc+0xcb>
    1a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2e:	89 04 24             	mov    %eax,(%esp)
    1a31:	e8 ed fe ff ff       	call   1923 <morecore>
    1a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a3d:	75 07                	jne    1a46 <malloc+0xcb>
    1a3f:	b8 00 00 00 00       	mov    $0x0,%eax
    1a44:	eb 13                	jmp    1a59 <malloc+0xde>
    1a46:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a4f:	8b 00                	mov    (%eax),%eax
    1a51:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a54:	e9 70 ff ff ff       	jmp    19c9 <malloc+0x4e>
    1a59:	c9                   	leave  
    1a5a:	c3                   	ret    
    1a5b:	90                   	nop

00001a5c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1a5c:	55                   	push   %ebp
    1a5d:	89 e5                	mov    %esp,%ebp
    1a5f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1a62:	8b 55 08             	mov    0x8(%ebp),%edx
    1a65:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a68:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a6b:	f0 87 02             	lock xchg %eax,(%edx)
    1a6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1a71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1a74:	c9                   	leave  
    1a75:	c3                   	ret    

00001a76 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1a76:	55                   	push   %ebp
    1a77:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1a79:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1a82:	5d                   	pop    %ebp
    1a83:	c3                   	ret    

00001a84 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1a84:	55                   	push   %ebp
    1a85:	89 e5                	mov    %esp,%ebp
    1a87:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1a8a:	90                   	nop
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1a95:	00 
    1a96:	89 04 24             	mov    %eax,(%esp)
    1a99:	e8 be ff ff ff       	call   1a5c <xchg>
    1a9e:	85 c0                	test   %eax,%eax
    1aa0:	75 e9                	jne    1a8b <lock_acquire+0x7>
}
    1aa2:	c9                   	leave  
    1aa3:	c3                   	ret    

00001aa4 <lock_release>:
void lock_release(lock_t *lock){
    1aa4:	55                   	push   %ebp
    1aa5:	89 e5                	mov    %esp,%ebp
    1aa7:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    1aad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ab4:	00 
    1ab5:	89 04 24             	mov    %eax,(%esp)
    1ab8:	e8 9f ff ff ff       	call   1a5c <xchg>
}
    1abd:	c9                   	leave  
    1abe:	c3                   	ret    

00001abf <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1abf:	55                   	push   %ebp
    1ac0:	89 e5                	mov    %esp,%ebp
    1ac2:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1ac5:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1acc:	e8 aa fe ff ff       	call   197b <malloc>
    1ad1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1add:	25 ff 0f 00 00       	and    $0xfff,%eax
    1ae2:	85 c0                	test   %eax,%eax
    1ae4:	74 14                	je     1afa <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae9:	25 ff 0f 00 00       	and    $0xfff,%eax
    1aee:	89 c2                	mov    %eax,%edx
    1af0:	b8 00 10 00 00       	mov    $0x1000,%eax
    1af5:	29 d0                	sub    %edx,%eax
    1af7:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1afa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1afe:	75 1b                	jne    1b1b <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1b00:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    1b07:	00 
    1b08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b0f:	e8 84 fb ff ff       	call   1698 <printf>
        return 0;
    1b14:	b8 00 00 00 00       	mov    $0x0,%eax
    1b19:	eb 6f                	jmp    1b8a <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1b1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b1e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b24:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1b28:	89 54 24 08          	mov    %edx,0x8(%esp)
    1b2c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1b33:	00 
    1b34:	89 04 24             	mov    %eax,(%esp)
    1b37:	e8 5c fa ff ff       	call   1598 <clone>
    1b3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1b3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b43:	79 1b                	jns    1b60 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1b45:	c7 44 24 04 28 1d 00 	movl   $0x1d28,0x4(%esp)
    1b4c:	00 
    1b4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b54:	e8 3f fb ff ff       	call   1698 <printf>
        return 0;
    1b59:	b8 00 00 00 00       	mov    $0x0,%eax
    1b5e:	eb 2a                	jmp    1b8a <thread_create+0xcb>
    }
    if(tid > 0){
    1b60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b64:	7e 05                	jle    1b6b <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1b66:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b69:	eb 1f                	jmp    1b8a <thread_create+0xcb>
    }
    if(tid == 0){
    1b6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b6f:	75 14                	jne    1b85 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1b71:	c7 44 24 04 35 1d 00 	movl   $0x1d35,0x4(%esp)
    1b78:	00 
    1b79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b80:	e8 13 fb ff ff       	call   1698 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1b85:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b8a:	c9                   	leave  
    1b8b:	c3                   	ret    

00001b8c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1b8c:	55                   	push   %ebp
    1b8d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1b8f:	a1 a0 20 00 00       	mov    0x20a0,%eax
    1b94:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1b9a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1b9f:	a3 a0 20 00 00       	mov    %eax,0x20a0
    return (int)(rands % max);
    1ba4:	a1 a0 20 00 00       	mov    0x20a0,%eax
    1ba9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bac:	ba 00 00 00 00       	mov    $0x0,%edx
    1bb1:	f7 f1                	div    %ecx
    1bb3:	89 d0                	mov    %edx,%eax
}
    1bb5:	5d                   	pop    %ebp
    1bb6:	c3                   	ret    
    1bb7:	90                   	nop

00001bb8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1bb8:	55                   	push   %ebp
    1bb9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1bbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1bc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1bce:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1bd8:	5d                   	pop    %ebp
    1bd9:	c3                   	ret    

00001bda <add_q>:

void add_q(struct queue *q, int v){
    1bda:	55                   	push   %ebp
    1bdb:	89 e5                	mov    %esp,%ebp
    1bdd:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1be0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1be7:	e8 8f fd ff ff       	call   197b <malloc>
    1bec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1bef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bfc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bff:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1c01:	8b 45 08             	mov    0x8(%ebp),%eax
    1c04:	8b 40 04             	mov    0x4(%eax),%eax
    1c07:	85 c0                	test   %eax,%eax
    1c09:	75 0b                	jne    1c16 <add_q+0x3c>
        q->head = n;
    1c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c11:	89 50 04             	mov    %edx,0x4(%eax)
    1c14:	eb 0c                	jmp    1c22 <add_q+0x48>
    }else{
        q->tail->next = n;
    1c16:	8b 45 08             	mov    0x8(%ebp),%eax
    1c19:	8b 40 08             	mov    0x8(%eax),%eax
    1c1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c1f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1c22:	8b 45 08             	mov    0x8(%ebp),%eax
    1c25:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c28:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2e:	8b 00                	mov    (%eax),%eax
    1c30:	8d 50 01             	lea    0x1(%eax),%edx
    1c33:	8b 45 08             	mov    0x8(%ebp),%eax
    1c36:	89 10                	mov    %edx,(%eax)
}
    1c38:	c9                   	leave  
    1c39:	c3                   	ret    

00001c3a <empty_q>:

int empty_q(struct queue *q){
    1c3a:	55                   	push   %ebp
    1c3b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c40:	8b 00                	mov    (%eax),%eax
    1c42:	85 c0                	test   %eax,%eax
    1c44:	75 07                	jne    1c4d <empty_q+0x13>
        return 1;
    1c46:	b8 01 00 00 00       	mov    $0x1,%eax
    1c4b:	eb 05                	jmp    1c52 <empty_q+0x18>
    else
        return 0;
    1c4d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1c52:	5d                   	pop    %ebp
    1c53:	c3                   	ret    

00001c54 <pop_q>:
int pop_q(struct queue *q){
    1c54:	55                   	push   %ebp
    1c55:	89 e5                	mov    %esp,%ebp
    1c57:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1c5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5d:	89 04 24             	mov    %eax,(%esp)
    1c60:	e8 d5 ff ff ff       	call   1c3a <empty_q>
    1c65:	85 c0                	test   %eax,%eax
    1c67:	75 5d                	jne    1cc6 <pop_q+0x72>
       val = q->head->value; 
    1c69:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6c:	8b 40 04             	mov    0x4(%eax),%eax
    1c6f:	8b 00                	mov    (%eax),%eax
    1c71:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1c74:	8b 45 08             	mov    0x8(%ebp),%eax
    1c77:	8b 40 04             	mov    0x4(%eax),%eax
    1c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c80:	8b 40 04             	mov    0x4(%eax),%eax
    1c83:	8b 50 04             	mov    0x4(%eax),%edx
    1c86:	8b 45 08             	mov    0x8(%ebp),%eax
    1c89:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1c8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c8f:	89 04 24             	mov    %eax,(%esp)
    1c92:	e8 b5 fb ff ff       	call   184c <free>
       q->size--;
    1c97:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9a:	8b 00                	mov    (%eax),%eax
    1c9c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ca4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca7:	8b 00                	mov    (%eax),%eax
    1ca9:	85 c0                	test   %eax,%eax
    1cab:	75 14                	jne    1cc1 <pop_q+0x6d>
            q->head = 0;
    1cad:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1cb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cba:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc4:	eb 05                	jmp    1ccb <pop_q+0x77>
    }
    return -1;
    1cc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ccb:	c9                   	leave  
    1ccc:	c3                   	ret    
