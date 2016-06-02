
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
    102c:	e8 a2 0a 00 00       	call   1ad3 <thread_create>
    1031:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    1035:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    103a:	75 19                	jne    1055 <main+0x55>
            printf(1,"thread_create fails\n");
    103c:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    1043:	00 
    1044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104b:	e8 50 06 00 00       	call   16a0 <printf>
            exit();
    1050:	e8 a3 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1055:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    105c:	00 
    105d:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    1064:	e8 6a 0a 00 00       	call   1ad3 <thread_create>
    1069:	89 44 24 18          	mov    %eax,0x18(%esp)
        if(tid == 0){
    106d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1072:	75 19                	jne    108d <main+0x8d>
            printf(1,"thread_create fails\n");
    1074:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    107b:	00 
    107c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1083:	e8 18 06 00 00       	call   16a0 <printf>
            exit();
    1088:	e8 6b 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    108d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    109c:	e8 32 0a 00 00       	call   1ad3 <thread_create>
    10a1:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    10a5:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10aa:	75 19                	jne    10c5 <main+0xc5>
            printf(1,"thread_create fails\n");
    10ac:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    10b3:	00 
    10b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10bb:	e8 e0 05 00 00       	call   16a0 <printf>
            exit();
    10c0:	e8 33 04 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    10c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10cc:	00 
    10cd:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    10d4:	e8 fa 09 00 00       	call   1ad3 <thread_create>
    10d9:	89 44 24 18          	mov    %eax,0x18(%esp)
          if(tid == 0){
    10dd:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10e2:	75 19                	jne    10fd <main+0xfd>
            printf(1,"thread_create fails\n");
    10e4:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    10eb:	00 
    10ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f3:	e8 a8 05 00 00       	call   16a0 <printf>
            exit();
    10f8:	e8 fb 03 00 00       	call   14f8 <exit>
        }
       tid = thread_create(test_func,(void *)0);
    10fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1104:	00 
    1105:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    110c:	e8 c2 09 00 00       	call   1ad3 <thread_create>
    1111:	89 44 24 18          	mov    %eax,0x18(%esp)
           if(tid == 0){
    1115:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    111a:	75 19                	jne    1135 <main+0x135>
            printf(1,"thread_create fails\n");
    111c:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    1123:	00 
    1124:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112b:	e8 70 05 00 00       	call   16a0 <printf>
            exit();
    1130:	e8 c3 03 00 00       	call   14f8 <exit>
        }
      while(wait()>=0);
    1135:	90                   	nop
    1136:	e8 c5 03 00 00       	call   1500 <wait>
    113b:	85 c0                	test   %eax,%eax
    113d:	79 f7                	jns    1136 <main+0x136>
        printf(1,"I am child, [6] n = %d\n",n);
    113f:	a1 fc 20 00 00       	mov    0x20fc,%eax
    1144:	89 44 24 08          	mov    %eax,0x8(%esp)
    1148:	c7 44 24 04 f6 1c 00 	movl   $0x1cf6,0x4(%esp)
    114f:	00 
    1150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1157:	e8 44 05 00 00       	call   16a0 <printf>
    115c:	e9 12 01 00 00       	jmp    1273 <main+0x273>
    }else if(pid > 0){
    1161:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1166:	0f 8e 07 01 00 00    	jle    1273 <main+0x273>
        void *tid = thread_create(test_func,(void *)0);
    116c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1173:	00 
    1174:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    117b:	e8 53 09 00 00       	call   1ad3 <thread_create>
    1180:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    1184:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1189:	75 19                	jne    11a4 <main+0x1a4>
            printf(1,"thread_create fails\n");
    118b:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    1192:	00 
    1193:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    119a:	e8 01 05 00 00       	call   16a0 <printf>
            exit();
    119f:	e8 54 03 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11ab:	00 
    11ac:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    11b3:	e8 1b 09 00 00       	call   1ad3 <thread_create>
    11b8:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    11bc:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    11c1:	75 19                	jne    11dc <main+0x1dc>
            printf(1,"thread_create fails\n");
    11c3:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    11ca:	00 
    11cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d2:	e8 c9 04 00 00       	call   16a0 <printf>
            exit();
    11d7:	e8 1c 03 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11e3:	00 
    11e4:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    11eb:	e8 e3 08 00 00       	call   1ad3 <thread_create>
    11f0:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    11f4:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    11f9:	75 19                	jne    1214 <main+0x214>
            printf(1,"thread_create fails\n");
    11fb:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    1202:	00 
    1203:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    120a:	e8 91 04 00 00       	call   16a0 <printf>
            exit();
    120f:	e8 e4 02 00 00       	call   14f8 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1214:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    121b:	00 
    121c:	c7 04 24 78 12 00 00 	movl   $0x1278,(%esp)
    1223:	e8 ab 08 00 00       	call   1ad3 <thread_create>
    1228:	89 44 24 14          	mov    %eax,0x14(%esp)
         if(tid == 0){
    122c:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1231:	75 19                	jne    124c <main+0x24c>
            printf(1,"thread_create fails\n");
    1233:	c7 44 24 04 e1 1c 00 	movl   $0x1ce1,0x4(%esp)
    123a:	00 
    123b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1242:	e8 59 04 00 00       	call   16a0 <printf>
            exit();
    1247:	e8 ac 02 00 00       	call   14f8 <exit>
        }
        while(wait()>=0);
    124c:	90                   	nop
    124d:	e8 ae 02 00 00       	call   1500 <wait>
    1252:	85 c0                	test   %eax,%eax
    1254:	79 f7                	jns    124d <main+0x24d>
        printf(1,"I am parent, [5] n = %d\n",n);
    1256:	a1 fc 20 00 00       	mov    0x20fc,%eax
    125b:	89 44 24 08          	mov    %eax,0x8(%esp)
    125f:	c7 44 24 04 0e 1d 00 	movl   $0x1d0e,0x4(%esp)
    1266:	00 
    1267:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    126e:	e8 2d 04 00 00       	call   16a0 <printf>
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
    127e:	a1 fc 20 00 00       	mov    0x20fc,%eax
    1283:	83 c0 01             	add    $0x1,%eax
    1286:	a3 fc 20 00 00       	mov    %eax,0x20fc
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
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    14f0:	b8 01 00 00 00       	mov    $0x1,%eax
    14f5:	cd 40                	int    $0x40
    14f7:	c3                   	ret    

000014f8 <exit>:
SYSCALL(exit)
    14f8:	b8 02 00 00 00       	mov    $0x2,%eax
    14fd:	cd 40                	int    $0x40
    14ff:	c3                   	ret    

00001500 <wait>:
SYSCALL(wait)
    1500:	b8 03 00 00 00       	mov    $0x3,%eax
    1505:	cd 40                	int    $0x40
    1507:	c3                   	ret    

00001508 <pipe>:
SYSCALL(pipe)
    1508:	b8 04 00 00 00       	mov    $0x4,%eax
    150d:	cd 40                	int    $0x40
    150f:	c3                   	ret    

00001510 <read>:
SYSCALL(read)
    1510:	b8 05 00 00 00       	mov    $0x5,%eax
    1515:	cd 40                	int    $0x40
    1517:	c3                   	ret    

00001518 <write>:
SYSCALL(write)
    1518:	b8 10 00 00 00       	mov    $0x10,%eax
    151d:	cd 40                	int    $0x40
    151f:	c3                   	ret    

00001520 <close>:
SYSCALL(close)
    1520:	b8 15 00 00 00       	mov    $0x15,%eax
    1525:	cd 40                	int    $0x40
    1527:	c3                   	ret    

00001528 <kill>:
SYSCALL(kill)
    1528:	b8 06 00 00 00       	mov    $0x6,%eax
    152d:	cd 40                	int    $0x40
    152f:	c3                   	ret    

00001530 <exec>:
SYSCALL(exec)
    1530:	b8 07 00 00 00       	mov    $0x7,%eax
    1535:	cd 40                	int    $0x40
    1537:	c3                   	ret    

00001538 <open>:
SYSCALL(open)
    1538:	b8 0f 00 00 00       	mov    $0xf,%eax
    153d:	cd 40                	int    $0x40
    153f:	c3                   	ret    

00001540 <mknod>:
SYSCALL(mknod)
    1540:	b8 11 00 00 00       	mov    $0x11,%eax
    1545:	cd 40                	int    $0x40
    1547:	c3                   	ret    

00001548 <unlink>:
SYSCALL(unlink)
    1548:	b8 12 00 00 00       	mov    $0x12,%eax
    154d:	cd 40                	int    $0x40
    154f:	c3                   	ret    

00001550 <fstat>:
SYSCALL(fstat)
    1550:	b8 08 00 00 00       	mov    $0x8,%eax
    1555:	cd 40                	int    $0x40
    1557:	c3                   	ret    

00001558 <link>:
SYSCALL(link)
    1558:	b8 13 00 00 00       	mov    $0x13,%eax
    155d:	cd 40                	int    $0x40
    155f:	c3                   	ret    

00001560 <mkdir>:
SYSCALL(mkdir)
    1560:	b8 14 00 00 00       	mov    $0x14,%eax
    1565:	cd 40                	int    $0x40
    1567:	c3                   	ret    

00001568 <chdir>:
SYSCALL(chdir)
    1568:	b8 09 00 00 00       	mov    $0x9,%eax
    156d:	cd 40                	int    $0x40
    156f:	c3                   	ret    

00001570 <dup>:
SYSCALL(dup)
    1570:	b8 0a 00 00 00       	mov    $0xa,%eax
    1575:	cd 40                	int    $0x40
    1577:	c3                   	ret    

00001578 <getpid>:
SYSCALL(getpid)
    1578:	b8 0b 00 00 00       	mov    $0xb,%eax
    157d:	cd 40                	int    $0x40
    157f:	c3                   	ret    

00001580 <sbrk>:
SYSCALL(sbrk)
    1580:	b8 0c 00 00 00       	mov    $0xc,%eax
    1585:	cd 40                	int    $0x40
    1587:	c3                   	ret    

00001588 <sleep>:
SYSCALL(sleep)
    1588:	b8 0d 00 00 00       	mov    $0xd,%eax
    158d:	cd 40                	int    $0x40
    158f:	c3                   	ret    

00001590 <uptime>:
SYSCALL(uptime)
    1590:	b8 0e 00 00 00       	mov    $0xe,%eax
    1595:	cd 40                	int    $0x40
    1597:	c3                   	ret    

00001598 <clone>:
SYSCALL(clone)
    1598:	b8 16 00 00 00       	mov    $0x16,%eax
    159d:	cd 40                	int    $0x40
    159f:	c3                   	ret    

000015a0 <texit>:
SYSCALL(texit)
    15a0:	b8 17 00 00 00       	mov    $0x17,%eax
    15a5:	cd 40                	int    $0x40
    15a7:	c3                   	ret    

000015a8 <tsleep>:
SYSCALL(tsleep)
    15a8:	b8 18 00 00 00       	mov    $0x18,%eax
    15ad:	cd 40                	int    $0x40
    15af:	c3                   	ret    

000015b0 <twakeup>:
SYSCALL(twakeup)
    15b0:	b8 19 00 00 00       	mov    $0x19,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <thread_yield>:
SYSCALL(thread_yield)
    15b8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	83 ec 18             	sub    $0x18,%esp
    15c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15d3:	00 
    15d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15d7:	89 44 24 04          	mov    %eax,0x4(%esp)
    15db:	8b 45 08             	mov    0x8(%ebp),%eax
    15de:	89 04 24             	mov    %eax,(%esp)
    15e1:	e8 32 ff ff ff       	call   1518 <write>
}
    15e6:	c9                   	leave  
    15e7:	c3                   	ret    

000015e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    15e8:	55                   	push   %ebp
    15e9:	89 e5                	mov    %esp,%ebp
    15eb:	56                   	push   %esi
    15ec:	53                   	push   %ebx
    15ed:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    15f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    15f7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    15fb:	74 17                	je     1614 <printint+0x2c>
    15fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1601:	79 11                	jns    1614 <printint+0x2c>
    neg = 1;
    1603:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    160a:	8b 45 0c             	mov    0xc(%ebp),%eax
    160d:	f7 d8                	neg    %eax
    160f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1612:	eb 06                	jmp    161a <printint+0x32>
  } else {
    x = xx;
    1614:	8b 45 0c             	mov    0xc(%ebp),%eax
    1617:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    161a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1621:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1624:	8d 41 01             	lea    0x1(%ecx),%eax
    1627:	89 45 f4             	mov    %eax,-0xc(%ebp)
    162a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    162d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1630:	ba 00 00 00 00       	mov    $0x0,%edx
    1635:	f7 f3                	div    %ebx
    1637:	89 d0                	mov    %edx,%eax
    1639:	0f b6 80 00 21 00 00 	movzbl 0x2100(%eax),%eax
    1640:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1644:	8b 75 10             	mov    0x10(%ebp),%esi
    1647:	8b 45 ec             	mov    -0x14(%ebp),%eax
    164a:	ba 00 00 00 00       	mov    $0x0,%edx
    164f:	f7 f6                	div    %esi
    1651:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1654:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1658:	75 c7                	jne    1621 <printint+0x39>
  if(neg)
    165a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    165e:	74 10                	je     1670 <printint+0x88>
    buf[i++] = '-';
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	8d 50 01             	lea    0x1(%eax),%edx
    1666:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1669:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    166e:	eb 1f                	jmp    168f <printint+0xa7>
    1670:	eb 1d                	jmp    168f <printint+0xa7>
    putc(fd, buf[i]);
    1672:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1675:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1678:	01 d0                	add    %edx,%eax
    167a:	0f b6 00             	movzbl (%eax),%eax
    167d:	0f be c0             	movsbl %al,%eax
    1680:	89 44 24 04          	mov    %eax,0x4(%esp)
    1684:	8b 45 08             	mov    0x8(%ebp),%eax
    1687:	89 04 24             	mov    %eax,(%esp)
    168a:	e8 31 ff ff ff       	call   15c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    168f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1693:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1697:	79 d9                	jns    1672 <printint+0x8a>
    putc(fd, buf[i]);
}
    1699:	83 c4 30             	add    $0x30,%esp
    169c:	5b                   	pop    %ebx
    169d:	5e                   	pop    %esi
    169e:	5d                   	pop    %ebp
    169f:	c3                   	ret    

000016a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16a0:	55                   	push   %ebp
    16a1:	89 e5                	mov    %esp,%ebp
    16a3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    16a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16ad:	8d 45 0c             	lea    0xc(%ebp),%eax
    16b0:	83 c0 04             	add    $0x4,%eax
    16b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    16b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16bd:	e9 7c 01 00 00       	jmp    183e <printf+0x19e>
    c = fmt[i] & 0xff;
    16c2:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c8:	01 d0                	add    %edx,%eax
    16ca:	0f b6 00             	movzbl (%eax),%eax
    16cd:	0f be c0             	movsbl %al,%eax
    16d0:	25 ff 00 00 00       	and    $0xff,%eax
    16d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    16d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16dc:	75 2c                	jne    170a <printf+0x6a>
      if(c == '%'){
    16de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16e2:	75 0c                	jne    16f0 <printf+0x50>
        state = '%';
    16e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    16eb:	e9 4a 01 00 00       	jmp    183a <printf+0x19a>
      } else {
        putc(fd, c);
    16f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16f3:	0f be c0             	movsbl %al,%eax
    16f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fa:	8b 45 08             	mov    0x8(%ebp),%eax
    16fd:	89 04 24             	mov    %eax,(%esp)
    1700:	e8 bb fe ff ff       	call   15c0 <putc>
    1705:	e9 30 01 00 00       	jmp    183a <printf+0x19a>
      }
    } else if(state == '%'){
    170a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    170e:	0f 85 26 01 00 00    	jne    183a <printf+0x19a>
      if(c == 'd'){
    1714:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1718:	75 2d                	jne    1747 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    171a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    171d:	8b 00                	mov    (%eax),%eax
    171f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1726:	00 
    1727:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    172e:	00 
    172f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1733:	8b 45 08             	mov    0x8(%ebp),%eax
    1736:	89 04 24             	mov    %eax,(%esp)
    1739:	e8 aa fe ff ff       	call   15e8 <printint>
        ap++;
    173e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1742:	e9 ec 00 00 00       	jmp    1833 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    1747:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    174b:	74 06                	je     1753 <printf+0xb3>
    174d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1751:	75 2d                	jne    1780 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1753:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1756:	8b 00                	mov    (%eax),%eax
    1758:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    175f:	00 
    1760:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1767:	00 
    1768:	89 44 24 04          	mov    %eax,0x4(%esp)
    176c:	8b 45 08             	mov    0x8(%ebp),%eax
    176f:	89 04 24             	mov    %eax,(%esp)
    1772:	e8 71 fe ff ff       	call   15e8 <printint>
        ap++;
    1777:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    177b:	e9 b3 00 00 00       	jmp    1833 <printf+0x193>
      } else if(c == 's'){
    1780:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1784:	75 45                	jne    17cb <printf+0x12b>
        s = (char*)*ap;
    1786:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1789:	8b 00                	mov    (%eax),%eax
    178b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    178e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1792:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1796:	75 09                	jne    17a1 <printf+0x101>
          s = "(null)";
    1798:	c7 45 f4 27 1d 00 00 	movl   $0x1d27,-0xc(%ebp)
        while(*s != 0){
    179f:	eb 1e                	jmp    17bf <printf+0x11f>
    17a1:	eb 1c                	jmp    17bf <printf+0x11f>
          putc(fd, *s);
    17a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a6:	0f b6 00             	movzbl (%eax),%eax
    17a9:	0f be c0             	movsbl %al,%eax
    17ac:	89 44 24 04          	mov    %eax,0x4(%esp)
    17b0:	8b 45 08             	mov    0x8(%ebp),%eax
    17b3:	89 04 24             	mov    %eax,(%esp)
    17b6:	e8 05 fe ff ff       	call   15c0 <putc>
          s++;
    17bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	0f b6 00             	movzbl (%eax),%eax
    17c5:	84 c0                	test   %al,%al
    17c7:	75 da                	jne    17a3 <printf+0x103>
    17c9:	eb 68                	jmp    1833 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    17cb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    17cf:	75 1d                	jne    17ee <printf+0x14e>
        putc(fd, *ap);
    17d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17d4:	8b 00                	mov    (%eax),%eax
    17d6:	0f be c0             	movsbl %al,%eax
    17d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    17dd:	8b 45 08             	mov    0x8(%ebp),%eax
    17e0:	89 04 24             	mov    %eax,(%esp)
    17e3:	e8 d8 fd ff ff       	call   15c0 <putc>
        ap++;
    17e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17ec:	eb 45                	jmp    1833 <printf+0x193>
      } else if(c == '%'){
    17ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17f2:	75 17                	jne    180b <printf+0x16b>
        putc(fd, c);
    17f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17f7:	0f be c0             	movsbl %al,%eax
    17fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    17fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1801:	89 04 24             	mov    %eax,(%esp)
    1804:	e8 b7 fd ff ff       	call   15c0 <putc>
    1809:	eb 28                	jmp    1833 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    180b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1812:	00 
    1813:	8b 45 08             	mov    0x8(%ebp),%eax
    1816:	89 04 24             	mov    %eax,(%esp)
    1819:	e8 a2 fd ff ff       	call   15c0 <putc>
        putc(fd, c);
    181e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1821:	0f be c0             	movsbl %al,%eax
    1824:	89 44 24 04          	mov    %eax,0x4(%esp)
    1828:	8b 45 08             	mov    0x8(%ebp),%eax
    182b:	89 04 24             	mov    %eax,(%esp)
    182e:	e8 8d fd ff ff       	call   15c0 <putc>
      }
      state = 0;
    1833:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    183a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    183e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1841:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1844:	01 d0                	add    %edx,%eax
    1846:	0f b6 00             	movzbl (%eax),%eax
    1849:	84 c0                	test   %al,%al
    184b:	0f 85 71 fe ff ff    	jne    16c2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1851:	c9                   	leave  
    1852:	c3                   	ret    
    1853:	90                   	nop

00001854 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    185a:	8b 45 08             	mov    0x8(%ebp),%eax
    185d:	83 e8 08             	sub    $0x8,%eax
    1860:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1863:	a1 20 21 00 00       	mov    0x2120,%eax
    1868:	89 45 fc             	mov    %eax,-0x4(%ebp)
    186b:	eb 24                	jmp    1891 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    186d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1870:	8b 00                	mov    (%eax),%eax
    1872:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1875:	77 12                	ja     1889 <free+0x35>
    1877:	8b 45 f8             	mov    -0x8(%ebp),%eax
    187a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    187d:	77 24                	ja     18a3 <free+0x4f>
    187f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1882:	8b 00                	mov    (%eax),%eax
    1884:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1887:	77 1a                	ja     18a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1889:	8b 45 fc             	mov    -0x4(%ebp),%eax
    188c:	8b 00                	mov    (%eax),%eax
    188e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1891:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1894:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1897:	76 d4                	jbe    186d <free+0x19>
    1899:	8b 45 fc             	mov    -0x4(%ebp),%eax
    189c:	8b 00                	mov    (%eax),%eax
    189e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18a1:	76 ca                	jbe    186d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    18a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18a6:	8b 40 04             	mov    0x4(%eax),%eax
    18a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b3:	01 c2                	add    %eax,%edx
    18b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18b8:	8b 00                	mov    (%eax),%eax
    18ba:	39 c2                	cmp    %eax,%edx
    18bc:	75 24                	jne    18e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    18be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c1:	8b 50 04             	mov    0x4(%eax),%edx
    18c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18c7:	8b 00                	mov    (%eax),%eax
    18c9:	8b 40 04             	mov    0x4(%eax),%eax
    18cc:	01 c2                	add    %eax,%edx
    18ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    18d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d7:	8b 00                	mov    (%eax),%eax
    18d9:	8b 10                	mov    (%eax),%edx
    18db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18de:	89 10                	mov    %edx,(%eax)
    18e0:	eb 0a                	jmp    18ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    18e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e5:	8b 10                	mov    (%eax),%edx
    18e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    18ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ef:	8b 40 04             	mov    0x4(%eax),%eax
    18f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18fc:	01 d0                	add    %edx,%eax
    18fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1901:	75 20                	jne    1923 <free+0xcf>
    p->s.size += bp->s.size;
    1903:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1906:	8b 50 04             	mov    0x4(%eax),%edx
    1909:	8b 45 f8             	mov    -0x8(%ebp),%eax
    190c:	8b 40 04             	mov    0x4(%eax),%eax
    190f:	01 c2                	add    %eax,%edx
    1911:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1914:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1917:	8b 45 f8             	mov    -0x8(%ebp),%eax
    191a:	8b 10                	mov    (%eax),%edx
    191c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191f:	89 10                	mov    %edx,(%eax)
    1921:	eb 08                	jmp    192b <free+0xd7>
  } else
    p->s.ptr = bp;
    1923:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1926:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1929:	89 10                	mov    %edx,(%eax)
  freep = p;
    192b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    192e:	a3 20 21 00 00       	mov    %eax,0x2120
}
    1933:	c9                   	leave  
    1934:	c3                   	ret    

00001935 <morecore>:

static Header*
morecore(uint nu)
{
    1935:	55                   	push   %ebp
    1936:	89 e5                	mov    %esp,%ebp
    1938:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    193b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1942:	77 07                	ja     194b <morecore+0x16>
    nu = 4096;
    1944:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    194b:	8b 45 08             	mov    0x8(%ebp),%eax
    194e:	c1 e0 03             	shl    $0x3,%eax
    1951:	89 04 24             	mov    %eax,(%esp)
    1954:	e8 27 fc ff ff       	call   1580 <sbrk>
    1959:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    195c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1960:	75 07                	jne    1969 <morecore+0x34>
    return 0;
    1962:	b8 00 00 00 00       	mov    $0x0,%eax
    1967:	eb 22                	jmp    198b <morecore+0x56>
  hp = (Header*)p;
    1969:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    196f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1972:	8b 55 08             	mov    0x8(%ebp),%edx
    1975:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1978:	8b 45 f0             	mov    -0x10(%ebp),%eax
    197b:	83 c0 08             	add    $0x8,%eax
    197e:	89 04 24             	mov    %eax,(%esp)
    1981:	e8 ce fe ff ff       	call   1854 <free>
  return freep;
    1986:	a1 20 21 00 00       	mov    0x2120,%eax
}
    198b:	c9                   	leave  
    198c:	c3                   	ret    

0000198d <malloc>:

void*
malloc(uint nbytes)
{
    198d:	55                   	push   %ebp
    198e:	89 e5                	mov    %esp,%ebp
    1990:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1993:	8b 45 08             	mov    0x8(%ebp),%eax
    1996:	83 c0 07             	add    $0x7,%eax
    1999:	c1 e8 03             	shr    $0x3,%eax
    199c:	83 c0 01             	add    $0x1,%eax
    199f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    19a2:	a1 20 21 00 00       	mov    0x2120,%eax
    19a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19ae:	75 23                	jne    19d3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    19b0:	c7 45 f0 18 21 00 00 	movl   $0x2118,-0x10(%ebp)
    19b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19ba:	a3 20 21 00 00       	mov    %eax,0x2120
    19bf:	a1 20 21 00 00       	mov    0x2120,%eax
    19c4:	a3 18 21 00 00       	mov    %eax,0x2118
    base.s.size = 0;
    19c9:	c7 05 1c 21 00 00 00 	movl   $0x0,0x211c
    19d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19d6:	8b 00                	mov    (%eax),%eax
    19d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19de:	8b 40 04             	mov    0x4(%eax),%eax
    19e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    19e4:	72 4d                	jb     1a33 <malloc+0xa6>
      if(p->s.size == nunits)
    19e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e9:	8b 40 04             	mov    0x4(%eax),%eax
    19ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    19ef:	75 0c                	jne    19fd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    19f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f4:	8b 10                	mov    (%eax),%edx
    19f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19f9:	89 10                	mov    %edx,(%eax)
    19fb:	eb 26                	jmp    1a23 <malloc+0x96>
      else {
        p->s.size -= nunits;
    19fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a00:	8b 40 04             	mov    0x4(%eax),%eax
    1a03:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a06:	89 c2                	mov    %eax,%edx
    1a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a11:	8b 40 04             	mov    0x4(%eax),%eax
    1a14:	c1 e0 03             	shl    $0x3,%eax
    1a17:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a20:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a26:	a3 20 21 00 00       	mov    %eax,0x2120
      return (void*)(p + 1);
    1a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2e:	83 c0 08             	add    $0x8,%eax
    1a31:	eb 38                	jmp    1a6b <malloc+0xde>
    }
    if(p == freep)
    1a33:	a1 20 21 00 00       	mov    0x2120,%eax
    1a38:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1a3b:	75 1b                	jne    1a58 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1a3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a40:	89 04 24             	mov    %eax,(%esp)
    1a43:	e8 ed fe ff ff       	call   1935 <morecore>
    1a48:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a4b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a4f:	75 07                	jne    1a58 <malloc+0xcb>
        return 0;
    1a51:	b8 00 00 00 00       	mov    $0x0,%eax
    1a56:	eb 13                	jmp    1a6b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a61:	8b 00                	mov    (%eax),%eax
    1a63:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1a66:	e9 70 ff ff ff       	jmp    19db <malloc+0x4e>
}
    1a6b:	c9                   	leave  
    1a6c:	c3                   	ret    
    1a6d:	66 90                	xchg   %ax,%ax
    1a6f:	90                   	nop

00001a70 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1a70:	55                   	push   %ebp
    1a71:	89 e5                	mov    %esp,%ebp
    1a73:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1a76:	8b 55 08             	mov    0x8(%ebp),%edx
    1a79:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a7c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a7f:	f0 87 02             	lock xchg %eax,(%edx)
    1a82:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1a85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1a88:	c9                   	leave  
    1a89:	c3                   	ret    

00001a8a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1a8a:	55                   	push   %ebp
    1a8b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1a96:	5d                   	pop    %ebp
    1a97:	c3                   	ret    

00001a98 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1a98:	55                   	push   %ebp
    1a99:	89 e5                	mov    %esp,%ebp
    1a9b:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1a9e:	90                   	nop
    1a9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1aa9:	00 
    1aaa:	89 04 24             	mov    %eax,(%esp)
    1aad:	e8 be ff ff ff       	call   1a70 <xchg>
    1ab2:	85 c0                	test   %eax,%eax
    1ab4:	75 e9                	jne    1a9f <lock_acquire+0x7>
}
    1ab6:	c9                   	leave  
    1ab7:	c3                   	ret    

00001ab8 <lock_release>:
void lock_release(lock_t *lock){
    1ab8:	55                   	push   %ebp
    1ab9:	89 e5                	mov    %esp,%ebp
    1abb:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1abe:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ac8:	00 
    1ac9:	89 04 24             	mov    %eax,(%esp)
    1acc:	e8 9f ff ff ff       	call   1a70 <xchg>
}
    1ad1:	c9                   	leave  
    1ad2:	c3                   	ret    

00001ad3 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1ad3:	55                   	push   %ebp
    1ad4:	89 e5                	mov    %esp,%ebp
    1ad6:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1ad9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1ae0:	e8 a8 fe ff ff       	call   198d <malloc>
    1ae5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1ae8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1aee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af1:	25 ff 0f 00 00       	and    $0xfff,%eax
    1af6:	85 c0                	test   %eax,%eax
    1af8:	74 14                	je     1b0e <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1afd:	25 ff 0f 00 00       	and    $0xfff,%eax
    1b02:	89 c2                	mov    %eax,%edx
    1b04:	b8 00 10 00 00       	mov    $0x1000,%eax
    1b09:	29 d0                	sub    %edx,%eax
    1b0b:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1b0e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b12:	75 1b                	jne    1b2f <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1b14:	c7 44 24 04 2e 1d 00 	movl   $0x1d2e,0x4(%esp)
    1b1b:	00 
    1b1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b23:	e8 78 fb ff ff       	call   16a0 <printf>
        return 0;
    1b28:	b8 00 00 00 00       	mov    $0x0,%eax
    1b2d:	eb 6f                	jmp    1b9e <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1b2f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b32:	8b 55 08             	mov    0x8(%ebp),%edx
    1b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b38:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1b3c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1b40:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1b47:	00 
    1b48:	89 04 24             	mov    %eax,(%esp)
    1b4b:	e8 48 fa ff ff       	call   1598 <clone>
    1b50:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1b53:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b57:	79 1b                	jns    1b74 <thread_create+0xa1>
        printf(1,"clone fails\n");
    1b59:	c7 44 24 04 3c 1d 00 	movl   $0x1d3c,0x4(%esp)
    1b60:	00 
    1b61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b68:	e8 33 fb ff ff       	call   16a0 <printf>
        return 0;
    1b6d:	b8 00 00 00 00       	mov    $0x0,%eax
    1b72:	eb 2a                	jmp    1b9e <thread_create+0xcb>
    }
    if(tid > 0){
    1b74:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b78:	7e 05                	jle    1b7f <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b7d:	eb 1f                	jmp    1b9e <thread_create+0xcb>
    }
    if(tid == 0){
    1b7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b83:	75 14                	jne    1b99 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1b85:	c7 44 24 04 49 1d 00 	movl   $0x1d49,0x4(%esp)
    1b8c:	00 
    1b8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b94:	e8 07 fb ff ff       	call   16a0 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1b99:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b9e:	c9                   	leave  
    1b9f:	c3                   	ret    

00001ba0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ba0:	55                   	push   %ebp
    1ba1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ba3:	a1 14 21 00 00       	mov    0x2114,%eax
    1ba8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1bae:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1bb3:	a3 14 21 00 00       	mov    %eax,0x2114
    return (int)(rands % max);
    1bb8:	a1 14 21 00 00       	mov    0x2114,%eax
    1bbd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bc0:	ba 00 00 00 00       	mov    $0x0,%edx
    1bc5:	f7 f1                	div    %ecx
    1bc7:	89 d0                	mov    %edx,%eax
}
    1bc9:	5d                   	pop    %ebp
    1bca:	c3                   	ret    
    1bcb:	90                   	nop

00001bcc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1bcc:	55                   	push   %ebp
    1bcd:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1bcf:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1be2:	8b 45 08             	mov    0x8(%ebp),%eax
    1be5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1bec:	5d                   	pop    %ebp
    1bed:	c3                   	ret    

00001bee <add_q>:

void add_q(struct queue *q, int v){
    1bee:	55                   	push   %ebp
    1bef:	89 e5                	mov    %esp,%ebp
    1bf1:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1bf4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1bfb:	e8 8d fd ff ff       	call   198d <malloc>
    1c00:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c06:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c10:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c13:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1c15:	8b 45 08             	mov    0x8(%ebp),%eax
    1c18:	8b 40 04             	mov    0x4(%eax),%eax
    1c1b:	85 c0                	test   %eax,%eax
    1c1d:	75 0b                	jne    1c2a <add_q+0x3c>
        q->head = n;
    1c1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c22:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c25:	89 50 04             	mov    %edx,0x4(%eax)
    1c28:	eb 0c                	jmp    1c36 <add_q+0x48>
    }else{
        q->tail->next = n;
    1c2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2d:	8b 40 08             	mov    0x8(%eax),%eax
    1c30:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c33:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1c36:	8b 45 08             	mov    0x8(%ebp),%eax
    1c39:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c3c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1c3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c42:	8b 00                	mov    (%eax),%eax
    1c44:	8d 50 01             	lea    0x1(%eax),%edx
    1c47:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4a:	89 10                	mov    %edx,(%eax)
}
    1c4c:	c9                   	leave  
    1c4d:	c3                   	ret    

00001c4e <empty_q>:

int empty_q(struct queue *q){
    1c4e:	55                   	push   %ebp
    1c4f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1c51:	8b 45 08             	mov    0x8(%ebp),%eax
    1c54:	8b 00                	mov    (%eax),%eax
    1c56:	85 c0                	test   %eax,%eax
    1c58:	75 07                	jne    1c61 <empty_q+0x13>
        return 1;
    1c5a:	b8 01 00 00 00       	mov    $0x1,%eax
    1c5f:	eb 05                	jmp    1c66 <empty_q+0x18>
    else
        return 0;
    1c61:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1c66:	5d                   	pop    %ebp
    1c67:	c3                   	ret    

00001c68 <pop_q>:
int pop_q(struct queue *q){
    1c68:	55                   	push   %ebp
    1c69:	89 e5                	mov    %esp,%ebp
    1c6b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c71:	89 04 24             	mov    %eax,(%esp)
    1c74:	e8 d5 ff ff ff       	call   1c4e <empty_q>
    1c79:	85 c0                	test   %eax,%eax
    1c7b:	75 5d                	jne    1cda <pop_q+0x72>
       val = q->head->value; 
    1c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c80:	8b 40 04             	mov    0x4(%eax),%eax
    1c83:	8b 00                	mov    (%eax),%eax
    1c85:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1c88:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8b:	8b 40 04             	mov    0x4(%eax),%eax
    1c8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1c91:	8b 45 08             	mov    0x8(%ebp),%eax
    1c94:	8b 40 04             	mov    0x4(%eax),%eax
    1c97:	8b 50 04             	mov    0x4(%eax),%edx
    1c9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9d:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ca3:	89 04 24             	mov    %eax,(%esp)
    1ca6:	e8 a9 fb ff ff       	call   1854 <free>
       q->size--;
    1cab:	8b 45 08             	mov    0x8(%ebp),%eax
    1cae:	8b 00                	mov    (%eax),%eax
    1cb0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1cb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbb:	8b 00                	mov    (%eax),%eax
    1cbd:	85 c0                	test   %eax,%eax
    1cbf:	75 14                	jne    1cd5 <pop_q+0x6d>
            q->head = 0;
    1cc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cce:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cd8:	eb 05                	jmp    1cdf <pop_q+0x77>
    }
    return -1;
    1cda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1cdf:	c9                   	leave  
    1ce0:	c3                   	ret    
