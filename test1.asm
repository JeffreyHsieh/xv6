
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
    1009:	e8 de 04 00 00       	call   14ec <fork>
    100e:	89 44 24 14          	mov    %eax,0x14(%esp)
    if(pid == 0){
    1012:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1017:	0f 85 43 01 00 00    	jne    1160 <main+0x160>
        void *tid = thread_create(test_func,(void *)0);
    101d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1024:	00 
    1025:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    102c:	e8 8d 0a 00 00       	call   1abe <thread_create>
    1031:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    1035:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    103a:	75 19                	jne    1055 <main+0x55>
            printf(1,"thread_create fails\n");
    103c:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1043:	00 
    1044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104b:	e8 45 06 00 00       	call   1695 <printf>
            exit();
    1050:	e8 9f 04 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1055:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    105c:	00 
    105d:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    1064:	e8 55 0a 00 00       	call   1abe <thread_create>
    1069:	89 44 24 18          	mov    %eax,0x18(%esp)
        if(tid == 0){
    106d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1072:	75 19                	jne    108d <main+0x8d>
            printf(1,"thread_create fails\n");
    1074:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    107b:	00 
    107c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1083:	e8 0d 06 00 00       	call   1695 <printf>
            exit();
    1088:	e8 67 04 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    108d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    109c:	e8 1d 0a 00 00       	call   1abe <thread_create>
    10a1:	89 44 24 18          	mov    %eax,0x18(%esp)
         if(tid == 0){
    10a5:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10aa:	75 19                	jne    10c5 <main+0xc5>
            printf(1,"thread_create fails\n");
    10ac:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    10b3:	00 
    10b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10bb:	e8 d5 05 00 00       	call   1695 <printf>
            exit();
    10c0:	e8 2f 04 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    10c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10cc:	00 
    10cd:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    10d4:	e8 e5 09 00 00       	call   1abe <thread_create>
    10d9:	89 44 24 18          	mov    %eax,0x18(%esp)
          if(tid == 0){
    10dd:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10e2:	75 19                	jne    10fd <main+0xfd>
            printf(1,"thread_create fails\n");
    10e4:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    10eb:	00 
    10ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f3:	e8 9d 05 00 00       	call   1695 <printf>
            exit();
    10f8:	e8 f7 03 00 00       	call   14f4 <exit>
        }
       tid = thread_create(test_func,(void *)0);
    10fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1104:	00 
    1105:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    110c:	e8 ad 09 00 00       	call   1abe <thread_create>
    1111:	89 44 24 18          	mov    %eax,0x18(%esp)
           if(tid == 0){
    1115:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    111a:	75 19                	jne    1135 <main+0x135>
            printf(1,"thread_create fails\n");
    111c:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1123:	00 
    1124:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112b:	e8 65 05 00 00       	call   1695 <printf>
            exit();
    1130:	e8 bf 03 00 00       	call   14f4 <exit>
        }
      while(wait()>=0);
    1135:	e8 c2 03 00 00       	call   14fc <wait>
    113a:	85 c0                	test   %eax,%eax
    113c:	79 f7                	jns    1135 <main+0x135>
        printf(1,"I am child, [6] n = %d\n",n);
    113e:	a1 48 1d 00 00       	mov    0x1d48,%eax
    1143:	89 44 24 08          	mov    %eax,0x8(%esp)
    1147:	c7 44 24 04 e2 1c 00 	movl   $0x1ce2,0x4(%esp)
    114e:	00 
    114f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1156:	e8 3a 05 00 00       	call   1695 <printf>
    115b:	e9 11 01 00 00       	jmp    1271 <main+0x271>
    }else if(pid > 0){
    1160:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1165:	0f 8e 06 01 00 00    	jle    1271 <main+0x271>
        void *tid = thread_create(test_func,(void *)0);
    116b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1172:	00 
    1173:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    117a:	e8 3f 09 00 00       	call   1abe <thread_create>
    117f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
         if(tid == 0){
    1183:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1188:	75 19                	jne    11a3 <main+0x1a3>
            printf(1,"thread_create fails\n");
    118a:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1191:	00 
    1192:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1199:	e8 f7 04 00 00       	call   1695 <printf>
            exit();
    119e:	e8 51 03 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11a3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11aa:	00 
    11ab:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    11b2:	e8 07 09 00 00       	call   1abe <thread_create>
    11b7:	89 44 24 1c          	mov    %eax,0x1c(%esp)
         if(tid == 0){
    11bb:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    11c0:	75 19                	jne    11db <main+0x1db>
            printf(1,"thread_create fails\n");
    11c2:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    11c9:	00 
    11ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d1:	e8 bf 04 00 00       	call   1695 <printf>
            exit();
    11d6:	e8 19 03 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    11db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11e2:	00 
    11e3:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    11ea:	e8 cf 08 00 00       	call   1abe <thread_create>
    11ef:	89 44 24 1c          	mov    %eax,0x1c(%esp)
         if(tid == 0){
    11f3:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    11f8:	75 19                	jne    1213 <main+0x213>
            printf(1,"thread_create fails\n");
    11fa:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1201:	00 
    1202:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1209:	e8 87 04 00 00       	call   1695 <printf>
            exit();
    120e:	e8 e1 02 00 00       	call   14f4 <exit>
        }
        tid = thread_create(test_func,(void *)0);
    1213:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    121a:	00 
    121b:	c7 04 24 76 12 00 00 	movl   $0x1276,(%esp)
    1222:	e8 97 08 00 00       	call   1abe <thread_create>
    1227:	89 44 24 1c          	mov    %eax,0x1c(%esp)
         if(tid == 0){
    122b:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1230:	75 19                	jne    124b <main+0x24b>
            printf(1,"thread_create fails\n");
    1232:	c7 44 24 04 cd 1c 00 	movl   $0x1ccd,0x4(%esp)
    1239:	00 
    123a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1241:	e8 4f 04 00 00       	call   1695 <printf>
            exit();
    1246:	e8 a9 02 00 00       	call   14f4 <exit>
        }
        while(wait()>=0);
    124b:	e8 ac 02 00 00       	call   14fc <wait>
    1250:	85 c0                	test   %eax,%eax
    1252:	79 f7                	jns    124b <main+0x24b>
        printf(1,"I am parent, [5] n = %d\n",n);
    1254:	a1 48 1d 00 00       	mov    0x1d48,%eax
    1259:	89 44 24 08          	mov    %eax,0x8(%esp)
    125d:	c7 44 24 04 fa 1c 00 	movl   $0x1cfa,0x4(%esp)
    1264:	00 
    1265:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    126c:	e8 24 04 00 00       	call   1695 <printf>
    }

   exit();
    1271:	e8 7e 02 00 00       	call   14f4 <exit>

00001276 <test_func>:
}

void test_func(void *arg_ptr){
    1276:	55                   	push   %ebp
    1277:	89 e5                	mov    %esp,%ebp
    1279:	83 ec 08             	sub    $0x8,%esp
//    printf(1,"\n n = %d\n",n);
    n++;
    127c:	a1 48 1d 00 00       	mov    0x1d48,%eax
    1281:	83 c0 01             	add    $0x1,%eax
    1284:	a3 48 1d 00 00       	mov    %eax,0x1d48
   // printf(1,"after increase by 1 , n = %d\n\n",n);
    texit();
    1289:	e8 0e 03 00 00       	call   159c <texit>
    128e:	90                   	nop
    128f:	90                   	nop

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
    12c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c4:	0f b6 10             	movzbl (%eax),%edx
    12c7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ca:	88 10                	mov    %dl,(%eax)
    12cc:	8b 45 08             	mov    0x8(%ebp),%eax
    12cf:	0f b6 00             	movzbl (%eax),%eax
    12d2:	84 c0                	test   %al,%al
    12d4:	0f 95 c0             	setne  %al
    12d7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12db:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    12df:	84 c0                	test   %al,%al
    12e1:	75 de                	jne    12c1 <strcpy+0xc>
    ;
  return os;
    12e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12e6:	c9                   	leave  
    12e7:	c3                   	ret    

000012e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12e8:	55                   	push   %ebp
    12e9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    12eb:	eb 08                	jmp    12f5 <strcmp+0xd>
    p++, q++;
    12ed:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12f1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    12f5:	8b 45 08             	mov    0x8(%ebp),%eax
    12f8:	0f b6 00             	movzbl (%eax),%eax
    12fb:	84 c0                	test   %al,%al
    12fd:	74 10                	je     130f <strcmp+0x27>
    12ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1302:	0f b6 10             	movzbl (%eax),%edx
    1305:	8b 45 0c             	mov    0xc(%ebp),%eax
    1308:	0f b6 00             	movzbl (%eax),%eax
    130b:	38 c2                	cmp    %al,%dl
    130d:	74 de                	je     12ed <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	0f b6 00             	movzbl (%eax),%eax
    1315:	0f b6 d0             	movzbl %al,%edx
    1318:	8b 45 0c             	mov    0xc(%ebp),%eax
    131b:	0f b6 00             	movzbl (%eax),%eax
    131e:	0f b6 c0             	movzbl %al,%eax
    1321:	89 d1                	mov    %edx,%ecx
    1323:	29 c1                	sub    %eax,%ecx
    1325:	89 c8                	mov    %ecx,%eax
}
    1327:	5d                   	pop    %ebp
    1328:	c3                   	ret    

00001329 <strlen>:

uint
strlen(char *s)
{
    1329:	55                   	push   %ebp
    132a:	89 e5                	mov    %esp,%ebp
    132c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    132f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1336:	eb 04                	jmp    133c <strlen+0x13>
    1338:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    133c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    133f:	03 45 08             	add    0x8(%ebp),%eax
    1342:	0f b6 00             	movzbl (%eax),%eax
    1345:	84 c0                	test   %al,%al
    1347:	75 ef                	jne    1338 <strlen+0xf>
    ;
  return n;
    1349:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    134c:	c9                   	leave  
    134d:	c3                   	ret    

0000134e <memset>:

void*
memset(void *dst, int c, uint n)
{
    134e:	55                   	push   %ebp
    134f:	89 e5                	mov    %esp,%ebp
    1351:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1354:	8b 45 10             	mov    0x10(%ebp),%eax
    1357:	89 44 24 08          	mov    %eax,0x8(%esp)
    135b:	8b 45 0c             	mov    0xc(%ebp),%eax
    135e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1362:	8b 45 08             	mov    0x8(%ebp),%eax
    1365:	89 04 24             	mov    %eax,(%esp)
    1368:	e8 23 ff ff ff       	call   1290 <stosb>
  return dst;
    136d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1370:	c9                   	leave  
    1371:	c3                   	ret    

00001372 <strchr>:

char*
strchr(const char *s, char c)
{
    1372:	55                   	push   %ebp
    1373:	89 e5                	mov    %esp,%ebp
    1375:	83 ec 04             	sub    $0x4,%esp
    1378:	8b 45 0c             	mov    0xc(%ebp),%eax
    137b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    137e:	eb 14                	jmp    1394 <strchr+0x22>
    if(*s == c)
    1380:	8b 45 08             	mov    0x8(%ebp),%eax
    1383:	0f b6 00             	movzbl (%eax),%eax
    1386:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1389:	75 05                	jne    1390 <strchr+0x1e>
      return (char*)s;
    138b:	8b 45 08             	mov    0x8(%ebp),%eax
    138e:	eb 13                	jmp    13a3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1390:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1394:	8b 45 08             	mov    0x8(%ebp),%eax
    1397:	0f b6 00             	movzbl (%eax),%eax
    139a:	84 c0                	test   %al,%al
    139c:	75 e2                	jne    1380 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    139e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13a3:	c9                   	leave  
    13a4:	c3                   	ret    

000013a5 <gets>:

char*
gets(char *buf, int max)
{
    13a5:	55                   	push   %ebp
    13a6:	89 e5                	mov    %esp,%ebp
    13a8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13b2:	eb 44                	jmp    13f8 <gets+0x53>
    cc = read(0, &c, 1);
    13b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13bb:	00 
    13bc:	8d 45 ef             	lea    -0x11(%ebp),%eax
    13bf:	89 44 24 04          	mov    %eax,0x4(%esp)
    13c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13ca:	e8 3d 01 00 00       	call   150c <read>
    13cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    13d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13d6:	7e 2d                	jle    1405 <gets+0x60>
      break;
    buf[i++] = c;
    13d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13db:	03 45 08             	add    0x8(%ebp),%eax
    13de:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    13e2:	88 10                	mov    %dl,(%eax)
    13e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    13e8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13ec:	3c 0a                	cmp    $0xa,%al
    13ee:	74 16                	je     1406 <gets+0x61>
    13f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13f4:	3c 0d                	cmp    $0xd,%al
    13f6:	74 0e                	je     1406 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13fb:	83 c0 01             	add    $0x1,%eax
    13fe:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1401:	7c b1                	jl     13b4 <gets+0xf>
    1403:	eb 01                	jmp    1406 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1405:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1406:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1409:	03 45 08             	add    0x8(%ebp),%eax
    140c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1412:	c9                   	leave  
    1413:	c3                   	ret    

00001414 <stat>:

int
stat(char *n, struct stat *st)
{
    1414:	55                   	push   %ebp
    1415:	89 e5                	mov    %esp,%ebp
    1417:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    141a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1421:	00 
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	89 04 24             	mov    %eax,(%esp)
    1428:	e8 07 01 00 00       	call   1534 <open>
    142d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1430:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1434:	79 07                	jns    143d <stat+0x29>
    return -1;
    1436:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    143b:	eb 23                	jmp    1460 <stat+0x4c>
  r = fstat(fd, st);
    143d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1440:	89 44 24 04          	mov    %eax,0x4(%esp)
    1444:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1447:	89 04 24             	mov    %eax,(%esp)
    144a:	e8 fd 00 00 00       	call   154c <fstat>
    144f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1452:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1455:	89 04 24             	mov    %eax,(%esp)
    1458:	e8 bf 00 00 00       	call   151c <close>
  return r;
    145d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1460:	c9                   	leave  
    1461:	c3                   	ret    

00001462 <atoi>:

int
atoi(const char *s)
{
    1462:	55                   	push   %ebp
    1463:	89 e5                	mov    %esp,%ebp
    1465:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1468:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    146f:	eb 24                	jmp    1495 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1471:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1474:	89 d0                	mov    %edx,%eax
    1476:	c1 e0 02             	shl    $0x2,%eax
    1479:	01 d0                	add    %edx,%eax
    147b:	01 c0                	add    %eax,%eax
    147d:	89 c2                	mov    %eax,%edx
    147f:	8b 45 08             	mov    0x8(%ebp),%eax
    1482:	0f b6 00             	movzbl (%eax),%eax
    1485:	0f be c0             	movsbl %al,%eax
    1488:	8d 04 02             	lea    (%edx,%eax,1),%eax
    148b:	83 e8 30             	sub    $0x30,%eax
    148e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1491:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1495:	8b 45 08             	mov    0x8(%ebp),%eax
    1498:	0f b6 00             	movzbl (%eax),%eax
    149b:	3c 2f                	cmp    $0x2f,%al
    149d:	7e 0a                	jle    14a9 <atoi+0x47>
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	0f b6 00             	movzbl (%eax),%eax
    14a5:	3c 39                	cmp    $0x39,%al
    14a7:	7e c8                	jle    1471 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    14a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14ac:	c9                   	leave  
    14ad:	c3                   	ret    

000014ae <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14ae:	55                   	push   %ebp
    14af:	89 e5                	mov    %esp,%ebp
    14b1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    14b4:	8b 45 08             	mov    0x8(%ebp),%eax
    14b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    14ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    14bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    14c0:	eb 13                	jmp    14d5 <memmove+0x27>
    *dst++ = *src++;
    14c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14c5:	0f b6 10             	movzbl (%eax),%edx
    14c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14cb:	88 10                	mov    %dl,(%eax)
    14cd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    14d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14d9:	0f 9f c0             	setg   %al
    14dc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    14e0:	84 c0                	test   %al,%al
    14e2:	75 de                	jne    14c2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14e7:	c9                   	leave  
    14e8:	c3                   	ret    
    14e9:	90                   	nop
    14ea:	90                   	nop
    14eb:	90                   	nop

000014ec <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    14ec:	b8 01 00 00 00       	mov    $0x1,%eax
    14f1:	cd 40                	int    $0x40
    14f3:	c3                   	ret    

000014f4 <exit>:
SYSCALL(exit)
    14f4:	b8 02 00 00 00       	mov    $0x2,%eax
    14f9:	cd 40                	int    $0x40
    14fb:	c3                   	ret    

000014fc <wait>:
SYSCALL(wait)
    14fc:	b8 03 00 00 00       	mov    $0x3,%eax
    1501:	cd 40                	int    $0x40
    1503:	c3                   	ret    

00001504 <pipe>:
SYSCALL(pipe)
    1504:	b8 04 00 00 00       	mov    $0x4,%eax
    1509:	cd 40                	int    $0x40
    150b:	c3                   	ret    

0000150c <read>:
SYSCALL(read)
    150c:	b8 05 00 00 00       	mov    $0x5,%eax
    1511:	cd 40                	int    $0x40
    1513:	c3                   	ret    

00001514 <write>:
SYSCALL(write)
    1514:	b8 10 00 00 00       	mov    $0x10,%eax
    1519:	cd 40                	int    $0x40
    151b:	c3                   	ret    

0000151c <close>:
SYSCALL(close)
    151c:	b8 15 00 00 00       	mov    $0x15,%eax
    1521:	cd 40                	int    $0x40
    1523:	c3                   	ret    

00001524 <kill>:
SYSCALL(kill)
    1524:	b8 06 00 00 00       	mov    $0x6,%eax
    1529:	cd 40                	int    $0x40
    152b:	c3                   	ret    

0000152c <exec>:
SYSCALL(exec)
    152c:	b8 07 00 00 00       	mov    $0x7,%eax
    1531:	cd 40                	int    $0x40
    1533:	c3                   	ret    

00001534 <open>:
SYSCALL(open)
    1534:	b8 0f 00 00 00       	mov    $0xf,%eax
    1539:	cd 40                	int    $0x40
    153b:	c3                   	ret    

0000153c <mknod>:
SYSCALL(mknod)
    153c:	b8 11 00 00 00       	mov    $0x11,%eax
    1541:	cd 40                	int    $0x40
    1543:	c3                   	ret    

00001544 <unlink>:
SYSCALL(unlink)
    1544:	b8 12 00 00 00       	mov    $0x12,%eax
    1549:	cd 40                	int    $0x40
    154b:	c3                   	ret    

0000154c <fstat>:
SYSCALL(fstat)
    154c:	b8 08 00 00 00       	mov    $0x8,%eax
    1551:	cd 40                	int    $0x40
    1553:	c3                   	ret    

00001554 <link>:
SYSCALL(link)
    1554:	b8 13 00 00 00       	mov    $0x13,%eax
    1559:	cd 40                	int    $0x40
    155b:	c3                   	ret    

0000155c <mkdir>:
SYSCALL(mkdir)
    155c:	b8 14 00 00 00       	mov    $0x14,%eax
    1561:	cd 40                	int    $0x40
    1563:	c3                   	ret    

00001564 <chdir>:
SYSCALL(chdir)
    1564:	b8 09 00 00 00       	mov    $0x9,%eax
    1569:	cd 40                	int    $0x40
    156b:	c3                   	ret    

0000156c <dup>:
SYSCALL(dup)
    156c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1571:	cd 40                	int    $0x40
    1573:	c3                   	ret    

00001574 <getpid>:
SYSCALL(getpid)
    1574:	b8 0b 00 00 00       	mov    $0xb,%eax
    1579:	cd 40                	int    $0x40
    157b:	c3                   	ret    

0000157c <sbrk>:
SYSCALL(sbrk)
    157c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1581:	cd 40                	int    $0x40
    1583:	c3                   	ret    

00001584 <sleep>:
SYSCALL(sleep)
    1584:	b8 0d 00 00 00       	mov    $0xd,%eax
    1589:	cd 40                	int    $0x40
    158b:	c3                   	ret    

0000158c <uptime>:
SYSCALL(uptime)
    158c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1591:	cd 40                	int    $0x40
    1593:	c3                   	ret    

00001594 <clone>:
SYSCALL(clone)
    1594:	b8 16 00 00 00       	mov    $0x16,%eax
    1599:	cd 40                	int    $0x40
    159b:	c3                   	ret    

0000159c <texit>:
SYSCALL(texit)
    159c:	b8 17 00 00 00       	mov    $0x17,%eax
    15a1:	cd 40                	int    $0x40
    15a3:	c3                   	ret    

000015a4 <tsleep>:
SYSCALL(tsleep)
    15a4:	b8 18 00 00 00       	mov    $0x18,%eax
    15a9:	cd 40                	int    $0x40
    15ab:	c3                   	ret    

000015ac <twakeup>:
SYSCALL(twakeup)
    15ac:	b8 19 00 00 00       	mov    $0x19,%eax
    15b1:	cd 40                	int    $0x40
    15b3:	c3                   	ret    

000015b4 <thread_yield>:
SYSCALL(thread_yield)
    15b4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    15b9:	cd 40                	int    $0x40
    15bb:	c3                   	ret    

000015bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15bc:	55                   	push   %ebp
    15bd:	89 e5                	mov    %esp,%ebp
    15bf:	83 ec 28             	sub    $0x28,%esp
    15c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15cf:	00 
    15d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15d3:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d7:	8b 45 08             	mov    0x8(%ebp),%eax
    15da:	89 04 24             	mov    %eax,(%esp)
    15dd:	e8 32 ff ff ff       	call   1514 <write>
}
    15e2:	c9                   	leave  
    15e3:	c3                   	ret    

000015e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    15e4:	55                   	push   %ebp
    15e5:	89 e5                	mov    %esp,%ebp
    15e7:	53                   	push   %ebx
    15e8:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    15eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    15f2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    15f6:	74 17                	je     160f <printint+0x2b>
    15f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15fc:	79 11                	jns    160f <printint+0x2b>
    neg = 1;
    15fe:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1605:	8b 45 0c             	mov    0xc(%ebp),%eax
    1608:	f7 d8                	neg    %eax
    160a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    160d:	eb 06                	jmp    1615 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    160f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1612:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1615:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    161c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    161f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	ba 00 00 00 00       	mov    $0x0,%edx
    162a:	f7 f3                	div    %ebx
    162c:	89 d0                	mov    %edx,%eax
    162e:	0f b6 80 4c 1d 00 00 	movzbl 0x1d4c(%eax),%eax
    1635:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1639:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    163d:	8b 45 10             	mov    0x10(%ebp),%eax
    1640:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1643:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1646:	ba 00 00 00 00       	mov    $0x0,%edx
    164b:	f7 75 d4             	divl   -0x2c(%ebp)
    164e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1651:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1655:	75 c5                	jne    161c <printint+0x38>
  if(neg)
    1657:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    165b:	74 28                	je     1685 <printint+0xa1>
    buf[i++] = '-';
    165d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1660:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1665:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1669:	eb 1a                	jmp    1685 <printint+0xa1>
    putc(fd, buf[i]);
    166b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    166e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1673:	0f be c0             	movsbl %al,%eax
    1676:	89 44 24 04          	mov    %eax,0x4(%esp)
    167a:	8b 45 08             	mov    0x8(%ebp),%eax
    167d:	89 04 24             	mov    %eax,(%esp)
    1680:	e8 37 ff ff ff       	call   15bc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1685:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1689:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    168d:	79 dc                	jns    166b <printint+0x87>
    putc(fd, buf[i]);
}
    168f:	83 c4 44             	add    $0x44,%esp
    1692:	5b                   	pop    %ebx
    1693:	5d                   	pop    %ebp
    1694:	c3                   	ret    

00001695 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1695:	55                   	push   %ebp
    1696:	89 e5                	mov    %esp,%ebp
    1698:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    169b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16a2:	8d 45 0c             	lea    0xc(%ebp),%eax
    16a5:	83 c0 04             	add    $0x4,%eax
    16a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    16ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16b2:	e9 7e 01 00 00       	jmp    1835 <printf+0x1a0>
    c = fmt[i] & 0xff;
    16b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    16ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16bd:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16c0:	0f b6 00             	movzbl (%eax),%eax
    16c3:	0f be c0             	movsbl %al,%eax
    16c6:	25 ff 00 00 00       	and    $0xff,%eax
    16cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    16ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    16d2:	75 2c                	jne    1700 <printf+0x6b>
      if(c == '%'){
    16d4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    16d8:	75 0c                	jne    16e6 <printf+0x51>
        state = '%';
    16da:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    16e1:	e9 4b 01 00 00       	jmp    1831 <printf+0x19c>
      } else {
        putc(fd, c);
    16e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16e9:	0f be c0             	movsbl %al,%eax
    16ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f0:	8b 45 08             	mov    0x8(%ebp),%eax
    16f3:	89 04 24             	mov    %eax,(%esp)
    16f6:	e8 c1 fe ff ff       	call   15bc <putc>
    16fb:	e9 31 01 00 00       	jmp    1831 <printf+0x19c>
      }
    } else if(state == '%'){
    1700:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1704:	0f 85 27 01 00 00    	jne    1831 <printf+0x19c>
      if(c == 'd'){
    170a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    170e:	75 2d                	jne    173d <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	8b 00                	mov    (%eax),%eax
    1715:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    171c:	00 
    171d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1724:	00 
    1725:	89 44 24 04          	mov    %eax,0x4(%esp)
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	89 04 24             	mov    %eax,(%esp)
    172f:	e8 b0 fe ff ff       	call   15e4 <printint>
        ap++;
    1734:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1738:	e9 ed 00 00 00       	jmp    182a <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    173d:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1741:	74 06                	je     1749 <printf+0xb4>
    1743:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1747:	75 2d                	jne    1776 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174c:	8b 00                	mov    (%eax),%eax
    174e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1755:	00 
    1756:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    175d:	00 
    175e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1762:	8b 45 08             	mov    0x8(%ebp),%eax
    1765:	89 04 24             	mov    %eax,(%esp)
    1768:	e8 77 fe ff ff       	call   15e4 <printint>
        ap++;
    176d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1771:	e9 b4 00 00 00       	jmp    182a <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1776:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    177a:	75 46                	jne    17c2 <printf+0x12d>
        s = (char*)*ap;
    177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177f:	8b 00                	mov    (%eax),%eax
    1781:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1784:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1788:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    178c:	75 27                	jne    17b5 <printf+0x120>
          s = "(null)";
    178e:	c7 45 e4 13 1d 00 00 	movl   $0x1d13,-0x1c(%ebp)
        while(*s != 0){
    1795:	eb 1f                	jmp    17b6 <printf+0x121>
          putc(fd, *s);
    1797:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    179a:	0f b6 00             	movzbl (%eax),%eax
    179d:	0f be c0             	movsbl %al,%eax
    17a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    17a4:	8b 45 08             	mov    0x8(%ebp),%eax
    17a7:	89 04 24             	mov    %eax,(%esp)
    17aa:	e8 0d fe ff ff       	call   15bc <putc>
          s++;
    17af:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    17b3:	eb 01                	jmp    17b6 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17b5:	90                   	nop
    17b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17b9:	0f b6 00             	movzbl (%eax),%eax
    17bc:	84 c0                	test   %al,%al
    17be:	75 d7                	jne    1797 <printf+0x102>
    17c0:	eb 68                	jmp    182a <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    17c2:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    17c6:	75 1d                	jne    17e5 <printf+0x150>
        putc(fd, *ap);
    17c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cb:	8b 00                	mov    (%eax),%eax
    17cd:	0f be c0             	movsbl %al,%eax
    17d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    17d4:	8b 45 08             	mov    0x8(%ebp),%eax
    17d7:	89 04 24             	mov    %eax,(%esp)
    17da:	e8 dd fd ff ff       	call   15bc <putc>
        ap++;
    17df:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    17e3:	eb 45                	jmp    182a <printf+0x195>
      } else if(c == '%'){
    17e5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    17e9:	75 17                	jne    1802 <printf+0x16d>
        putc(fd, c);
    17eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17ee:	0f be c0             	movsbl %al,%eax
    17f1:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f5:	8b 45 08             	mov    0x8(%ebp),%eax
    17f8:	89 04 24             	mov    %eax,(%esp)
    17fb:	e8 bc fd ff ff       	call   15bc <putc>
    1800:	eb 28                	jmp    182a <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1802:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1809:	00 
    180a:	8b 45 08             	mov    0x8(%ebp),%eax
    180d:	89 04 24             	mov    %eax,(%esp)
    1810:	e8 a7 fd ff ff       	call   15bc <putc>
        putc(fd, c);
    1815:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1818:	0f be c0             	movsbl %al,%eax
    181b:	89 44 24 04          	mov    %eax,0x4(%esp)
    181f:	8b 45 08             	mov    0x8(%ebp),%eax
    1822:	89 04 24             	mov    %eax,(%esp)
    1825:	e8 92 fd ff ff       	call   15bc <putc>
      }
      state = 0;
    182a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1831:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1835:	8b 55 0c             	mov    0xc(%ebp),%edx
    1838:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183b:	8d 04 02             	lea    (%edx,%eax,1),%eax
    183e:	0f b6 00             	movzbl (%eax),%eax
    1841:	84 c0                	test   %al,%al
    1843:	0f 85 6e fe ff ff    	jne    16b7 <printf+0x22>
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
static Header base;
static Header *freep;

void
free(void *ap)
{
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	83 e8 08             	sub    $0x8,%eax
    1858:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    185b:	a1 6c 1d 00 00       	mov    0x1d6c,%eax
    1860:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1863:	eb 24                	jmp    1889 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
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
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
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
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    189b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    189e:	8b 40 04             	mov    0x4(%eax),%eax
    18a1:	c1 e0 03             	shl    $0x3,%eax
    18a4:	89 c2                	mov    %eax,%edx
    18a6:	03 55 f8             	add    -0x8(%ebp),%edx
    18a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ac:	8b 00                	mov    (%eax),%eax
    18ae:	39 c2                	cmp    %eax,%edx
    18b0:	75 24                	jne    18d6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    18b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b5:	8b 50 04             	mov    0x4(%eax),%edx
    18b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18bb:	8b 00                	mov    (%eax),%eax
    18bd:	8b 40 04             	mov    0x4(%eax),%eax
    18c0:	01 c2                	add    %eax,%edx
    18c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    18c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18cb:	8b 00                	mov    (%eax),%eax
    18cd:	8b 10                	mov    (%eax),%edx
    18cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18d2:	89 10                	mov    %edx,(%eax)
    18d4:	eb 0a                	jmp    18e0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    18d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d9:	8b 10                	mov    (%eax),%edx
    18db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    18e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e3:	8b 40 04             	mov    0x4(%eax),%eax
    18e6:	c1 e0 03             	shl    $0x3,%eax
    18e9:	03 45 fc             	add    -0x4(%ebp),%eax
    18ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18ef:	75 20                	jne    1911 <free+0xc5>
    p->s.size += bp->s.size;
    18f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f4:	8b 50 04             	mov    0x4(%eax),%edx
    18f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18fa:	8b 40 04             	mov    0x4(%eax),%eax
    18fd:	01 c2                	add    %eax,%edx
    18ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1902:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1905:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1908:	8b 10                	mov    (%eax),%edx
    190a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    190d:	89 10                	mov    %edx,(%eax)
    190f:	eb 08                	jmp    1919 <free+0xcd>
  } else
    p->s.ptr = bp;
    1911:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1914:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1917:	89 10                	mov    %edx,(%eax)
  freep = p;
    1919:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191c:	a3 6c 1d 00 00       	mov    %eax,0x1d6c
}
    1921:	c9                   	leave  
    1922:	c3                   	ret    

00001923 <morecore>:

static Header*
morecore(uint nu)
{
    1923:	55                   	push   %ebp
    1924:	89 e5                	mov    %esp,%ebp
    1926:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1929:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1930:	77 07                	ja     1939 <morecore+0x16>
    nu = 4096;
    1932:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1939:	8b 45 08             	mov    0x8(%ebp),%eax
    193c:	c1 e0 03             	shl    $0x3,%eax
    193f:	89 04 24             	mov    %eax,(%esp)
    1942:	e8 35 fc ff ff       	call   157c <sbrk>
    1947:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    194a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    194e:	75 07                	jne    1957 <morecore+0x34>
    return 0;
    1950:	b8 00 00 00 00       	mov    $0x0,%eax
    1955:	eb 22                	jmp    1979 <morecore+0x56>
  hp = (Header*)p;
    1957:	8b 45 f0             	mov    -0x10(%ebp),%eax
    195a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    195d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1960:	8b 55 08             	mov    0x8(%ebp),%edx
    1963:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	83 c0 08             	add    $0x8,%eax
    196c:	89 04 24             	mov    %eax,(%esp)
    196f:	e8 d8 fe ff ff       	call   184c <free>
  return freep;
    1974:	a1 6c 1d 00 00       	mov    0x1d6c,%eax
}
    1979:	c9                   	leave  
    197a:	c3                   	ret    

0000197b <malloc>:

void*
malloc(uint nbytes)
{
    197b:	55                   	push   %ebp
    197c:	89 e5                	mov    %esp,%ebp
    197e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1981:	8b 45 08             	mov    0x8(%ebp),%eax
    1984:	83 c0 07             	add    $0x7,%eax
    1987:	c1 e8 03             	shr    $0x3,%eax
    198a:	83 c0 01             	add    $0x1,%eax
    198d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1990:	a1 6c 1d 00 00       	mov    0x1d6c,%eax
    1995:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1998:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    199c:	75 23                	jne    19c1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    199e:	c7 45 f0 64 1d 00 00 	movl   $0x1d64,-0x10(%ebp)
    19a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19a8:	a3 6c 1d 00 00       	mov    %eax,0x1d6c
    19ad:	a1 6c 1d 00 00       	mov    0x1d6c,%eax
    19b2:	a3 64 1d 00 00       	mov    %eax,0x1d64
    base.s.size = 0;
    19b7:	c7 05 68 1d 00 00 00 	movl   $0x0,0x1d68
    19be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19c4:	8b 00                	mov    (%eax),%eax
    19c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    19c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19cc:	8b 40 04             	mov    0x4(%eax),%eax
    19cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19d2:	72 4d                	jb     1a21 <malloc+0xa6>
      if(p->s.size == nunits)
    19d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19d7:	8b 40 04             	mov    0x4(%eax),%eax
    19da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19dd:	75 0c                	jne    19eb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    19df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19e2:	8b 10                	mov    (%eax),%edx
    19e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e7:	89 10                	mov    %edx,(%eax)
    19e9:	eb 26                	jmp    1a11 <malloc+0x96>
      else {
        p->s.size -= nunits;
    19eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19ee:	8b 40 04             	mov    0x4(%eax),%eax
    19f1:	89 c2                	mov    %eax,%edx
    19f3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    19f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    19fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19ff:	8b 40 04             	mov    0x4(%eax),%eax
    1a02:	c1 e0 03             	shl    $0x3,%eax
    1a05:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1a08:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a14:	a3 6c 1d 00 00       	mov    %eax,0x1d6c
      return (void*)(p + 1);
    1a19:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a1c:	83 c0 08             	add    $0x8,%eax
    1a1f:	eb 38                	jmp    1a59 <malloc+0xde>
    }
    if(p == freep)
    1a21:	a1 6c 1d 00 00       	mov    0x1d6c,%eax
    1a26:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a29:	75 1b                	jne    1a46 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2e:	89 04 24             	mov    %eax,(%esp)
    1a31:	e8 ed fe ff ff       	call   1923 <morecore>
    1a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a3d:	75 07                	jne    1a46 <malloc+0xcb>
        return 0;
    1a3f:	b8 00 00 00 00       	mov    $0x0,%eax
    1a44:	eb 13                	jmp    1a59 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a46:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a4f:	8b 00                	mov    (%eax),%eax
    1a51:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1a54:	e9 70 ff ff ff       	jmp    19c9 <malloc+0x4e>
}
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
    1a8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1a94:	00 
    1a95:	89 04 24             	mov    %eax,(%esp)
    1a98:	e8 bf ff ff ff       	call   1a5c <xchg>
    1a9d:	85 c0                	test   %eax,%eax
    1a9f:	75 e9                	jne    1a8a <lock_acquire+0x6>
}
    1aa1:	c9                   	leave  
    1aa2:	c3                   	ret    

00001aa3 <lock_release>:
void lock_release(lock_t *lock){
    1aa3:	55                   	push   %ebp
    1aa4:	89 e5                	mov    %esp,%ebp
    1aa6:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ab3:	00 
    1ab4:	89 04 24             	mov    %eax,(%esp)
    1ab7:	e8 a0 ff ff ff       	call   1a5c <xchg>
}
    1abc:	c9                   	leave  
    1abd:	c3                   	ret    

00001abe <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1abe:	55                   	push   %ebp
    1abf:	89 e5                	mov    %esp,%ebp
    1ac1:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1ac4:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1acb:	e8 ab fe ff ff       	call   197b <malloc>
    1ad0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad6:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1adc:	25 ff 0f 00 00       	and    $0xfff,%eax
    1ae1:	85 c0                	test   %eax,%eax
    1ae3:	74 15                	je     1afa <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ae8:	89 c2                	mov    %eax,%edx
    1aea:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1af0:	b8 00 10 00 00       	mov    $0x1000,%eax
    1af5:	29 d0                	sub    %edx,%eax
    1af7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1afa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1afe:	75 1b                	jne    1b1b <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1b00:	c7 44 24 04 1a 1d 00 	movl   $0x1d1a,0x4(%esp)
    1b07:	00 
    1b08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b0f:	e8 81 fb ff ff       	call   1695 <printf>
        return 0;
    1b14:	b8 00 00 00 00       	mov    $0x0,%eax
    1b19:	eb 6f                	jmp    1b8a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1b1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b1e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b24:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1b28:	89 54 24 08          	mov    %edx,0x8(%esp)
    1b2c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1b33:	00 
    1b34:	89 04 24             	mov    %eax,(%esp)
    1b37:	e8 58 fa ff ff       	call   1594 <clone>
    1b3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1b3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b43:	79 1b                	jns    1b60 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1b45:	c7 44 24 04 28 1d 00 	movl   $0x1d28,0x4(%esp)
    1b4c:	00 
    1b4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b54:	e8 3c fb ff ff       	call   1695 <printf>
        return 0;
    1b59:	b8 00 00 00 00       	mov    $0x0,%eax
    1b5e:	eb 2a                	jmp    1b8a <thread_create+0xcc>
    }
    if(tid > 0){
    1b60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b64:	7e 05                	jle    1b6b <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b69:	eb 1f                	jmp    1b8a <thread_create+0xcc>
    }
    if(tid == 0){
    1b6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b6f:	75 14                	jne    1b85 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1b71:	c7 44 24 04 35 1d 00 	movl   $0x1d35,0x4(%esp)
    1b78:	00 
    1b79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b80:	e8 10 fb ff ff       	call   1695 <printf>
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
    1b8f:	a1 60 1d 00 00       	mov    0x1d60,%eax
    1b94:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1b9a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1b9f:	a3 60 1d 00 00       	mov    %eax,0x1d60
    return (int)(rands % max);
    1ba4:	a1 60 1d 00 00       	mov    0x1d60,%eax
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
    1c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1c74:	8b 45 08             	mov    0x8(%ebp),%eax
    1c77:	8b 40 04             	mov    0x4(%eax),%eax
    1c7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c80:	8b 40 04             	mov    0x4(%eax),%eax
    1c83:	8b 50 04             	mov    0x4(%eax),%edx
    1c86:	8b 45 08             	mov    0x8(%ebp),%eax
    1c89:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
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
    1cc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc4:	eb 05                	jmp    1ccb <pop_q+0x77>
    }
    return -1;
    1cc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ccb:	c9                   	leave  
    1ccc:	c3                   	ret    
