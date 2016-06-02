
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1007:	8b 45 08             	mov    0x8(%ebp),%eax
    100a:	89 04 24             	mov    %eax,(%esp)
    100d:	e8 de 03 00 00       	call   13f0 <strlen>
    1012:	8b 55 08             	mov    0x8(%ebp),%edx
    1015:	01 d0                	add    %edx,%eax
    1017:	89 45 f4             	mov    %eax,-0xc(%ebp)
    101a:	eb 04                	jmp    1020 <fmtname+0x20>
    101c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1020:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1023:	3b 45 08             	cmp    0x8(%ebp),%eax
    1026:	72 0a                	jb     1032 <fmtname+0x32>
    1028:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102b:	0f b6 00             	movzbl (%eax),%eax
    102e:	3c 2f                	cmp    $0x2f,%al
    1030:	75 ea                	jne    101c <fmtname+0x1c>
    ;
  p++;
    1032:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    1036:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1039:	89 04 24             	mov    %eax,(%esp)
    103c:	e8 af 03 00 00       	call   13f0 <strlen>
    1041:	83 f8 0d             	cmp    $0xd,%eax
    1044:	76 05                	jbe    104b <fmtname+0x4b>
    return p;
    1046:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1049:	eb 5f                	jmp    10aa <fmtname+0xaa>
  memmove(buf, p, strlen(p));
    104b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104e:	89 04 24             	mov    %eax,(%esp)
    1051:	e8 9a 03 00 00       	call   13f0 <strlen>
    1056:	89 44 24 08          	mov    %eax,0x8(%esp)
    105a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    105d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1061:	c7 04 24 a8 21 00 00 	movl   $0x21a8,(%esp)
    1068:	e8 12 05 00 00       	call   157f <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    106d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1070:	89 04 24             	mov    %eax,(%esp)
    1073:	e8 78 03 00 00       	call   13f0 <strlen>
    1078:	ba 0e 00 00 00       	mov    $0xe,%edx
    107d:	89 d3                	mov    %edx,%ebx
    107f:	29 c3                	sub    %eax,%ebx
    1081:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1084:	89 04 24             	mov    %eax,(%esp)
    1087:	e8 64 03 00 00       	call   13f0 <strlen>
    108c:	05 a8 21 00 00       	add    $0x21a8,%eax
    1091:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1095:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
    109c:	00 
    109d:	89 04 24             	mov    %eax,(%esp)
    10a0:	e8 72 03 00 00       	call   1417 <memset>
  return buf;
    10a5:	b8 a8 21 00 00       	mov    $0x21a8,%eax
}
    10aa:	83 c4 24             	add    $0x24,%esp
    10ad:	5b                   	pop    %ebx
    10ae:	5d                   	pop    %ebp
    10af:	c3                   	ret    

000010b0 <ls>:

void
ls(char *path)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    10bc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10c3:	00 
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	89 04 24             	mov    %eax,(%esp)
    10ca:	e8 35 05 00 00       	call   1604 <open>
    10cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10d6:	79 20                	jns    10f8 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
    10d8:	8b 45 08             	mov    0x8(%ebp),%eax
    10db:	89 44 24 08          	mov    %eax,0x8(%esp)
    10df:	c7 44 24 04 99 1d 00 	movl   $0x1d99,0x4(%esp)
    10e6:	00 
    10e7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    10ee:	e8 71 06 00 00       	call   1764 <printf>
    return;
    10f3:	e9 01 02 00 00       	jmp    12f9 <ls+0x249>
  }
  
  if(fstat(fd, &st) < 0){
    10f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    10fe:	89 44 24 04          	mov    %eax,0x4(%esp)
    1102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1105:	89 04 24             	mov    %eax,(%esp)
    1108:	e8 0f 05 00 00       	call   161c <fstat>
    110d:	85 c0                	test   %eax,%eax
    110f:	79 2b                	jns    113c <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	89 44 24 08          	mov    %eax,0x8(%esp)
    1118:	c7 44 24 04 ad 1d 00 	movl   $0x1dad,0x4(%esp)
    111f:	00 
    1120:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1127:	e8 38 06 00 00       	call   1764 <printf>
    close(fd);
    112c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    112f:	89 04 24             	mov    %eax,(%esp)
    1132:	e8 b5 04 00 00       	call   15ec <close>
    return;
    1137:	e9 bd 01 00 00       	jmp    12f9 <ls+0x249>
  }
  
  switch(st.type){
    113c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1143:	98                   	cwtl   
    1144:	83 f8 01             	cmp    $0x1,%eax
    1147:	74 53                	je     119c <ls+0xec>
    1149:	83 f8 02             	cmp    $0x2,%eax
    114c:	0f 85 9c 01 00 00    	jne    12ee <ls+0x23e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1152:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    1158:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    115e:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1165:	0f bf d8             	movswl %ax,%ebx
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
    116b:	89 04 24             	mov    %eax,(%esp)
    116e:	e8 8d fe ff ff       	call   1000 <fmtname>
    1173:	89 7c 24 14          	mov    %edi,0x14(%esp)
    1177:	89 74 24 10          	mov    %esi,0x10(%esp)
    117b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    117f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1183:	c7 44 24 04 c1 1d 00 	movl   $0x1dc1,0x4(%esp)
    118a:	00 
    118b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1192:	e8 cd 05 00 00       	call   1764 <printf>
    break;
    1197:	e9 52 01 00 00       	jmp    12ee <ls+0x23e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	89 04 24             	mov    %eax,(%esp)
    11a2:	e8 49 02 00 00       	call   13f0 <strlen>
    11a7:	83 c0 10             	add    $0x10,%eax
    11aa:	3d 00 02 00 00       	cmp    $0x200,%eax
    11af:	76 19                	jbe    11ca <ls+0x11a>
      printf(1, "ls: path too long\n");
    11b1:	c7 44 24 04 ce 1d 00 	movl   $0x1dce,0x4(%esp)
    11b8:	00 
    11b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c0:	e8 9f 05 00 00       	call   1764 <printf>
      break;
    11c5:	e9 24 01 00 00       	jmp    12ee <ls+0x23e>
    }
    strcpy(buf, path);
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d1:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11d7:	89 04 24             	mov    %eax,(%esp)
    11da:	e8 a2 01 00 00       	call   1381 <strcpy>
    p = buf+strlen(buf);
    11df:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11e5:	89 04 24             	mov    %eax,(%esp)
    11e8:	e8 03 02 00 00       	call   13f0 <strlen>
    11ed:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
    11f3:	01 d0                	add    %edx,%eax
    11f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
    11f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11fb:	8d 50 01             	lea    0x1(%eax),%edx
    11fe:	89 55 e0             	mov    %edx,-0x20(%ebp)
    1201:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    1204:	e9 be 00 00 00       	jmp    12c7 <ls+0x217>
      if(de.inum == 0)
    1209:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
    1210:	66 85 c0             	test   %ax,%ax
    1213:	75 05                	jne    121a <ls+0x16a>
        continue;
    1215:	e9 ad 00 00 00       	jmp    12c7 <ls+0x217>
      memmove(p, de.name, DIRSIZ);
    121a:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    1221:	00 
    1222:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    1228:	83 c0 02             	add    $0x2,%eax
    122b:	89 44 24 04          	mov    %eax,0x4(%esp)
    122f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1232:	89 04 24             	mov    %eax,(%esp)
    1235:	e8 45 03 00 00       	call   157f <memmove>
      p[DIRSIZ] = 0;
    123a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    123d:	83 c0 0e             	add    $0xe,%eax
    1240:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
    1243:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    1249:	89 44 24 04          	mov    %eax,0x4(%esp)
    124d:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1253:	89 04 24             	mov    %eax,(%esp)
    1256:	e8 89 02 00 00       	call   14e4 <stat>
    125b:	85 c0                	test   %eax,%eax
    125d:	79 20                	jns    127f <ls+0x1cf>
        printf(1, "ls: cannot stat %s\n", buf);
    125f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1265:	89 44 24 08          	mov    %eax,0x8(%esp)
    1269:	c7 44 24 04 ad 1d 00 	movl   $0x1dad,0x4(%esp)
    1270:	00 
    1271:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1278:	e8 e7 04 00 00       	call   1764 <printf>
        continue;
    127d:	eb 48                	jmp    12c7 <ls+0x217>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    127f:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    1285:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    128b:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1292:	0f bf d8             	movswl %ax,%ebx
    1295:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    129b:	89 04 24             	mov    %eax,(%esp)
    129e:	e8 5d fd ff ff       	call   1000 <fmtname>
    12a3:	89 7c 24 14          	mov    %edi,0x14(%esp)
    12a7:	89 74 24 10          	mov    %esi,0x10(%esp)
    12ab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    12af:	89 44 24 08          	mov    %eax,0x8(%esp)
    12b3:	c7 44 24 04 c1 1d 00 	movl   $0x1dc1,0x4(%esp)
    12ba:	00 
    12bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12c2:	e8 9d 04 00 00       	call   1764 <printf>
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    12c7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    12ce:	00 
    12cf:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    12d5:	89 44 24 04          	mov    %eax,0x4(%esp)
    12d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12dc:	89 04 24             	mov    %eax,(%esp)
    12df:	e8 f8 02 00 00       	call   15dc <read>
    12e4:	83 f8 10             	cmp    $0x10,%eax
    12e7:	0f 84 1c ff ff ff    	je     1209 <ls+0x159>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
    12ed:	90                   	nop
  }
  close(fd);
    12ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12f1:	89 04 24             	mov    %eax,(%esp)
    12f4:	e8 f3 02 00 00       	call   15ec <close>
}
    12f9:	81 c4 5c 02 00 00    	add    $0x25c,%esp
    12ff:	5b                   	pop    %ebx
    1300:	5e                   	pop    %esi
    1301:	5f                   	pop    %edi
    1302:	5d                   	pop    %ebp
    1303:	c3                   	ret    

00001304 <main>:

int
main(int argc, char *argv[])
{
    1304:	55                   	push   %ebp
    1305:	89 e5                	mov    %esp,%ebp
    1307:	83 e4 f0             	and    $0xfffffff0,%esp
    130a:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
    130d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1311:	7f 11                	jg     1324 <main+0x20>
    ls(".");
    1313:	c7 04 24 e1 1d 00 00 	movl   $0x1de1,(%esp)
    131a:	e8 91 fd ff ff       	call   10b0 <ls>
    exit();
    131f:	e8 a0 02 00 00       	call   15c4 <exit>
  }
  for(i=1; i<argc; i++)
    1324:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    132b:	00 
    132c:	eb 1f                	jmp    134d <main+0x49>
    ls(argv[i]);
    132e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1339:	8b 45 0c             	mov    0xc(%ebp),%eax
    133c:	01 d0                	add    %edx,%eax
    133e:	8b 00                	mov    (%eax),%eax
    1340:	89 04 24             	mov    %eax,(%esp)
    1343:	e8 68 fd ff ff       	call   10b0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    1348:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    134d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1351:	3b 45 08             	cmp    0x8(%ebp),%eax
    1354:	7c d8                	jl     132e <main+0x2a>
    ls(argv[i]);
  exit();
    1356:	e8 69 02 00 00       	call   15c4 <exit>
    135b:	90                   	nop

0000135c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    135c:	55                   	push   %ebp
    135d:	89 e5                	mov    %esp,%ebp
    135f:	57                   	push   %edi
    1360:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1361:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1364:	8b 55 10             	mov    0x10(%ebp),%edx
    1367:	8b 45 0c             	mov    0xc(%ebp),%eax
    136a:	89 cb                	mov    %ecx,%ebx
    136c:	89 df                	mov    %ebx,%edi
    136e:	89 d1                	mov    %edx,%ecx
    1370:	fc                   	cld    
    1371:	f3 aa                	rep stos %al,%es:(%edi)
    1373:	89 ca                	mov    %ecx,%edx
    1375:	89 fb                	mov    %edi,%ebx
    1377:	89 5d 08             	mov    %ebx,0x8(%ebp)
    137a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    137d:	5b                   	pop    %ebx
    137e:	5f                   	pop    %edi
    137f:	5d                   	pop    %ebp
    1380:	c3                   	ret    

00001381 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1381:	55                   	push   %ebp
    1382:	89 e5                	mov    %esp,%ebp
    1384:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1387:	8b 45 08             	mov    0x8(%ebp),%eax
    138a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    138d:	90                   	nop
    138e:	8b 45 08             	mov    0x8(%ebp),%eax
    1391:	8d 50 01             	lea    0x1(%eax),%edx
    1394:	89 55 08             	mov    %edx,0x8(%ebp)
    1397:	8b 55 0c             	mov    0xc(%ebp),%edx
    139a:	8d 4a 01             	lea    0x1(%edx),%ecx
    139d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    13a0:	0f b6 12             	movzbl (%edx),%edx
    13a3:	88 10                	mov    %dl,(%eax)
    13a5:	0f b6 00             	movzbl (%eax),%eax
    13a8:	84 c0                	test   %al,%al
    13aa:	75 e2                	jne    138e <strcpy+0xd>
    ;
  return os;
    13ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13af:	c9                   	leave  
    13b0:	c3                   	ret    

000013b1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13b1:	55                   	push   %ebp
    13b2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13b4:	eb 08                	jmp    13be <strcmp+0xd>
    p++, q++;
    13b6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13ba:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
    13c1:	0f b6 00             	movzbl (%eax),%eax
    13c4:	84 c0                	test   %al,%al
    13c6:	74 10                	je     13d8 <strcmp+0x27>
    13c8:	8b 45 08             	mov    0x8(%ebp),%eax
    13cb:	0f b6 10             	movzbl (%eax),%edx
    13ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d1:	0f b6 00             	movzbl (%eax),%eax
    13d4:	38 c2                	cmp    %al,%dl
    13d6:	74 de                	je     13b6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	0f b6 00             	movzbl (%eax),%eax
    13de:	0f b6 d0             	movzbl %al,%edx
    13e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e4:	0f b6 00             	movzbl (%eax),%eax
    13e7:	0f b6 c0             	movzbl %al,%eax
    13ea:	29 c2                	sub    %eax,%edx
    13ec:	89 d0                	mov    %edx,%eax
}
    13ee:	5d                   	pop    %ebp
    13ef:	c3                   	ret    

000013f0 <strlen>:

uint
strlen(char *s)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13fd:	eb 04                	jmp    1403 <strlen+0x13>
    13ff:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1403:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	01 d0                	add    %edx,%eax
    140b:	0f b6 00             	movzbl (%eax),%eax
    140e:	84 c0                	test   %al,%al
    1410:	75 ed                	jne    13ff <strlen+0xf>
    ;
  return n;
    1412:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1415:	c9                   	leave  
    1416:	c3                   	ret    

00001417 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1417:	55                   	push   %ebp
    1418:	89 e5                	mov    %esp,%ebp
    141a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    141d:	8b 45 10             	mov    0x10(%ebp),%eax
    1420:	89 44 24 08          	mov    %eax,0x8(%esp)
    1424:	8b 45 0c             	mov    0xc(%ebp),%eax
    1427:	89 44 24 04          	mov    %eax,0x4(%esp)
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	89 04 24             	mov    %eax,(%esp)
    1431:	e8 26 ff ff ff       	call   135c <stosb>
  return dst;
    1436:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1439:	c9                   	leave  
    143a:	c3                   	ret    

0000143b <strchr>:

char*
strchr(const char *s, char c)
{
    143b:	55                   	push   %ebp
    143c:	89 e5                	mov    %esp,%ebp
    143e:	83 ec 04             	sub    $0x4,%esp
    1441:	8b 45 0c             	mov    0xc(%ebp),%eax
    1444:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1447:	eb 14                	jmp    145d <strchr+0x22>
    if(*s == c)
    1449:	8b 45 08             	mov    0x8(%ebp),%eax
    144c:	0f b6 00             	movzbl (%eax),%eax
    144f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1452:	75 05                	jne    1459 <strchr+0x1e>
      return (char*)s;
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	eb 13                	jmp    146c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1459:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	0f b6 00             	movzbl (%eax),%eax
    1463:	84 c0                	test   %al,%al
    1465:	75 e2                	jne    1449 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1467:	b8 00 00 00 00       	mov    $0x0,%eax
}
    146c:	c9                   	leave  
    146d:	c3                   	ret    

0000146e <gets>:

char*
gets(char *buf, int max)
{
    146e:	55                   	push   %ebp
    146f:	89 e5                	mov    %esp,%ebp
    1471:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    147b:	eb 4c                	jmp    14c9 <gets+0x5b>
    cc = read(0, &c, 1);
    147d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1484:	00 
    1485:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1488:	89 44 24 04          	mov    %eax,0x4(%esp)
    148c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1493:	e8 44 01 00 00       	call   15dc <read>
    1498:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    149b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    149f:	7f 02                	jg     14a3 <gets+0x35>
      break;
    14a1:	eb 31                	jmp    14d4 <gets+0x66>
    buf[i++] = c;
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	8d 50 01             	lea    0x1(%eax),%edx
    14a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14ac:	89 c2                	mov    %eax,%edx
    14ae:	8b 45 08             	mov    0x8(%ebp),%eax
    14b1:	01 c2                	add    %eax,%edx
    14b3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    14b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14bd:	3c 0a                	cmp    $0xa,%al
    14bf:	74 13                	je     14d4 <gets+0x66>
    14c1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14c5:	3c 0d                	cmp    $0xd,%al
    14c7:	74 0b                	je     14d4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cc:	83 c0 01             	add    $0x1,%eax
    14cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14d2:	7c a9                	jl     147d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    14d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14d7:	8b 45 08             	mov    0x8(%ebp),%eax
    14da:	01 d0                	add    %edx,%eax
    14dc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    14df:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14e2:	c9                   	leave  
    14e3:	c3                   	ret    

000014e4 <stat>:

int
stat(char *n, struct stat *st)
{
    14e4:	55                   	push   %ebp
    14e5:	89 e5                	mov    %esp,%ebp
    14e7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14ea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14f1:	00 
    14f2:	8b 45 08             	mov    0x8(%ebp),%eax
    14f5:	89 04 24             	mov    %eax,(%esp)
    14f8:	e8 07 01 00 00       	call   1604 <open>
    14fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1500:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1504:	79 07                	jns    150d <stat+0x29>
    return -1;
    1506:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    150b:	eb 23                	jmp    1530 <stat+0x4c>
  r = fstat(fd, st);
    150d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1510:	89 44 24 04          	mov    %eax,0x4(%esp)
    1514:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1517:	89 04 24             	mov    %eax,(%esp)
    151a:	e8 fd 00 00 00       	call   161c <fstat>
    151f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1522:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1525:	89 04 24             	mov    %eax,(%esp)
    1528:	e8 bf 00 00 00       	call   15ec <close>
  return r;
    152d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1530:	c9                   	leave  
    1531:	c3                   	ret    

00001532 <atoi>:

int
atoi(const char *s)
{
    1532:	55                   	push   %ebp
    1533:	89 e5                	mov    %esp,%ebp
    1535:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1538:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    153f:	eb 25                	jmp    1566 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1541:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1544:	89 d0                	mov    %edx,%eax
    1546:	c1 e0 02             	shl    $0x2,%eax
    1549:	01 d0                	add    %edx,%eax
    154b:	01 c0                	add    %eax,%eax
    154d:	89 c1                	mov    %eax,%ecx
    154f:	8b 45 08             	mov    0x8(%ebp),%eax
    1552:	8d 50 01             	lea    0x1(%eax),%edx
    1555:	89 55 08             	mov    %edx,0x8(%ebp)
    1558:	0f b6 00             	movzbl (%eax),%eax
    155b:	0f be c0             	movsbl %al,%eax
    155e:	01 c8                	add    %ecx,%eax
    1560:	83 e8 30             	sub    $0x30,%eax
    1563:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1566:	8b 45 08             	mov    0x8(%ebp),%eax
    1569:	0f b6 00             	movzbl (%eax),%eax
    156c:	3c 2f                	cmp    $0x2f,%al
    156e:	7e 0a                	jle    157a <atoi+0x48>
    1570:	8b 45 08             	mov    0x8(%ebp),%eax
    1573:	0f b6 00             	movzbl (%eax),%eax
    1576:	3c 39                	cmp    $0x39,%al
    1578:	7e c7                	jle    1541 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    157a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    157d:	c9                   	leave  
    157e:	c3                   	ret    

0000157f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    157f:	55                   	push   %ebp
    1580:	89 e5                	mov    %esp,%ebp
    1582:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1585:	8b 45 08             	mov    0x8(%ebp),%eax
    1588:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    158b:	8b 45 0c             	mov    0xc(%ebp),%eax
    158e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1591:	eb 17                	jmp    15aa <memmove+0x2b>
    *dst++ = *src++;
    1593:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1596:	8d 50 01             	lea    0x1(%eax),%edx
    1599:	89 55 fc             	mov    %edx,-0x4(%ebp)
    159c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    159f:	8d 4a 01             	lea    0x1(%edx),%ecx
    15a2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    15a5:	0f b6 12             	movzbl (%edx),%edx
    15a8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    15aa:	8b 45 10             	mov    0x10(%ebp),%eax
    15ad:	8d 50 ff             	lea    -0x1(%eax),%edx
    15b0:	89 55 10             	mov    %edx,0x10(%ebp)
    15b3:	85 c0                	test   %eax,%eax
    15b5:	7f dc                	jg     1593 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    15b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15ba:	c9                   	leave  
    15bb:	c3                   	ret    

000015bc <fork>:
    15bc:	b8 01 00 00 00       	mov    $0x1,%eax
    15c1:	cd 40                	int    $0x40
    15c3:	c3                   	ret    

000015c4 <exit>:
    15c4:	b8 02 00 00 00       	mov    $0x2,%eax
    15c9:	cd 40                	int    $0x40
    15cb:	c3                   	ret    

000015cc <wait>:
    15cc:	b8 03 00 00 00       	mov    $0x3,%eax
    15d1:	cd 40                	int    $0x40
    15d3:	c3                   	ret    

000015d4 <pipe>:
    15d4:	b8 04 00 00 00       	mov    $0x4,%eax
    15d9:	cd 40                	int    $0x40
    15db:	c3                   	ret    

000015dc <read>:
    15dc:	b8 05 00 00 00       	mov    $0x5,%eax
    15e1:	cd 40                	int    $0x40
    15e3:	c3                   	ret    

000015e4 <write>:
    15e4:	b8 10 00 00 00       	mov    $0x10,%eax
    15e9:	cd 40                	int    $0x40
    15eb:	c3                   	ret    

000015ec <close>:
    15ec:	b8 15 00 00 00       	mov    $0x15,%eax
    15f1:	cd 40                	int    $0x40
    15f3:	c3                   	ret    

000015f4 <kill>:
    15f4:	b8 06 00 00 00       	mov    $0x6,%eax
    15f9:	cd 40                	int    $0x40
    15fb:	c3                   	ret    

000015fc <exec>:
    15fc:	b8 07 00 00 00       	mov    $0x7,%eax
    1601:	cd 40                	int    $0x40
    1603:	c3                   	ret    

00001604 <open>:
    1604:	b8 0f 00 00 00       	mov    $0xf,%eax
    1609:	cd 40                	int    $0x40
    160b:	c3                   	ret    

0000160c <mknod>:
    160c:	b8 11 00 00 00       	mov    $0x11,%eax
    1611:	cd 40                	int    $0x40
    1613:	c3                   	ret    

00001614 <unlink>:
    1614:	b8 12 00 00 00       	mov    $0x12,%eax
    1619:	cd 40                	int    $0x40
    161b:	c3                   	ret    

0000161c <fstat>:
    161c:	b8 08 00 00 00       	mov    $0x8,%eax
    1621:	cd 40                	int    $0x40
    1623:	c3                   	ret    

00001624 <link>:
    1624:	b8 13 00 00 00       	mov    $0x13,%eax
    1629:	cd 40                	int    $0x40
    162b:	c3                   	ret    

0000162c <mkdir>:
    162c:	b8 14 00 00 00       	mov    $0x14,%eax
    1631:	cd 40                	int    $0x40
    1633:	c3                   	ret    

00001634 <chdir>:
    1634:	b8 09 00 00 00       	mov    $0x9,%eax
    1639:	cd 40                	int    $0x40
    163b:	c3                   	ret    

0000163c <dup>:
    163c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1641:	cd 40                	int    $0x40
    1643:	c3                   	ret    

00001644 <getpid>:
    1644:	b8 0b 00 00 00       	mov    $0xb,%eax
    1649:	cd 40                	int    $0x40
    164b:	c3                   	ret    

0000164c <sbrk>:
    164c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1651:	cd 40                	int    $0x40
    1653:	c3                   	ret    

00001654 <sleep>:
    1654:	b8 0d 00 00 00       	mov    $0xd,%eax
    1659:	cd 40                	int    $0x40
    165b:	c3                   	ret    

0000165c <uptime>:
    165c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1661:	cd 40                	int    $0x40
    1663:	c3                   	ret    

00001664 <clone>:
    1664:	b8 16 00 00 00       	mov    $0x16,%eax
    1669:	cd 40                	int    $0x40
    166b:	c3                   	ret    

0000166c <texit>:
    166c:	b8 17 00 00 00       	mov    $0x17,%eax
    1671:	cd 40                	int    $0x40
    1673:	c3                   	ret    

00001674 <tsleep>:
    1674:	b8 18 00 00 00       	mov    $0x18,%eax
    1679:	cd 40                	int    $0x40
    167b:	c3                   	ret    

0000167c <twakeup>:
    167c:	b8 19 00 00 00       	mov    $0x19,%eax
    1681:	cd 40                	int    $0x40
    1683:	c3                   	ret    

00001684 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1684:	55                   	push   %ebp
    1685:	89 e5                	mov    %esp,%ebp
    1687:	83 ec 18             	sub    $0x18,%esp
    168a:	8b 45 0c             	mov    0xc(%ebp),%eax
    168d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1690:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1697:	00 
    1698:	8d 45 f4             	lea    -0xc(%ebp),%eax
    169b:	89 44 24 04          	mov    %eax,0x4(%esp)
    169f:	8b 45 08             	mov    0x8(%ebp),%eax
    16a2:	89 04 24             	mov    %eax,(%esp)
    16a5:	e8 3a ff ff ff       	call   15e4 <write>
}
    16aa:	c9                   	leave  
    16ab:	c3                   	ret    

000016ac <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16ac:	55                   	push   %ebp
    16ad:	89 e5                	mov    %esp,%ebp
    16af:	56                   	push   %esi
    16b0:	53                   	push   %ebx
    16b1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16bb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16bf:	74 17                	je     16d8 <printint+0x2c>
    16c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16c5:	79 11                	jns    16d8 <printint+0x2c>
    neg = 1;
    16c7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    16ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d1:	f7 d8                	neg    %eax
    16d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16d6:	eb 06                	jmp    16de <printint+0x32>
  } else {
    x = xx;
    16d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16db:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    16de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    16e5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16e8:	8d 41 01             	lea    0x1(%ecx),%eax
    16eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16ee:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16f4:	ba 00 00 00 00       	mov    $0x0,%edx
    16f9:	f7 f3                	div    %ebx
    16fb:	89 d0                	mov    %edx,%eax
    16fd:	0f b6 80 90 21 00 00 	movzbl 0x2190(%eax),%eax
    1704:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1708:	8b 75 10             	mov    0x10(%ebp),%esi
    170b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    170e:	ba 00 00 00 00       	mov    $0x0,%edx
    1713:	f7 f6                	div    %esi
    1715:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1718:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    171c:	75 c7                	jne    16e5 <printint+0x39>
  if(neg)
    171e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1722:	74 10                	je     1734 <printint+0x88>
    buf[i++] = '-';
    1724:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1727:	8d 50 01             	lea    0x1(%eax),%edx
    172a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    172d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1732:	eb 1f                	jmp    1753 <printint+0xa7>
    1734:	eb 1d                	jmp    1753 <printint+0xa7>
    putc(fd, buf[i]);
    1736:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1739:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173c:	01 d0                	add    %edx,%eax
    173e:	0f b6 00             	movzbl (%eax),%eax
    1741:	0f be c0             	movsbl %al,%eax
    1744:	89 44 24 04          	mov    %eax,0x4(%esp)
    1748:	8b 45 08             	mov    0x8(%ebp),%eax
    174b:	89 04 24             	mov    %eax,(%esp)
    174e:	e8 31 ff ff ff       	call   1684 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1753:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1757:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    175b:	79 d9                	jns    1736 <printint+0x8a>
    putc(fd, buf[i]);
}
    175d:	83 c4 30             	add    $0x30,%esp
    1760:	5b                   	pop    %ebx
    1761:	5e                   	pop    %esi
    1762:	5d                   	pop    %ebp
    1763:	c3                   	ret    

00001764 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1764:	55                   	push   %ebp
    1765:	89 e5                	mov    %esp,%ebp
    1767:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    176a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1771:	8d 45 0c             	lea    0xc(%ebp),%eax
    1774:	83 c0 04             	add    $0x4,%eax
    1777:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    177a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1781:	e9 7c 01 00 00       	jmp    1902 <printf+0x19e>
    c = fmt[i] & 0xff;
    1786:	8b 55 0c             	mov    0xc(%ebp),%edx
    1789:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178c:	01 d0                	add    %edx,%eax
    178e:	0f b6 00             	movzbl (%eax),%eax
    1791:	0f be c0             	movsbl %al,%eax
    1794:	25 ff 00 00 00       	and    $0xff,%eax
    1799:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    179c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17a0:	75 2c                	jne    17ce <printf+0x6a>
      if(c == '%'){
    17a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17a6:	75 0c                	jne    17b4 <printf+0x50>
        state = '%';
    17a8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    17af:	e9 4a 01 00 00       	jmp    18fe <printf+0x19a>
      } else {
        putc(fd, c);
    17b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17b7:	0f be c0             	movsbl %al,%eax
    17ba:	89 44 24 04          	mov    %eax,0x4(%esp)
    17be:	8b 45 08             	mov    0x8(%ebp),%eax
    17c1:	89 04 24             	mov    %eax,(%esp)
    17c4:	e8 bb fe ff ff       	call   1684 <putc>
    17c9:	e9 30 01 00 00       	jmp    18fe <printf+0x19a>
      }
    } else if(state == '%'){
    17ce:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    17d2:	0f 85 26 01 00 00    	jne    18fe <printf+0x19a>
      if(c == 'd'){
    17d8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    17dc:	75 2d                	jne    180b <printf+0xa7>
        printint(fd, *ap, 10, 1);
    17de:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17e1:	8b 00                	mov    (%eax),%eax
    17e3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    17ea:	00 
    17eb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    17f2:	00 
    17f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f7:	8b 45 08             	mov    0x8(%ebp),%eax
    17fa:	89 04 24             	mov    %eax,(%esp)
    17fd:	e8 aa fe ff ff       	call   16ac <printint>
        ap++;
    1802:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1806:	e9 ec 00 00 00       	jmp    18f7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    180b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    180f:	74 06                	je     1817 <printf+0xb3>
    1811:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1815:	75 2d                	jne    1844 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    1817:	8b 45 e8             	mov    -0x18(%ebp),%eax
    181a:	8b 00                	mov    (%eax),%eax
    181c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1823:	00 
    1824:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    182b:	00 
    182c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1830:	8b 45 08             	mov    0x8(%ebp),%eax
    1833:	89 04 24             	mov    %eax,(%esp)
    1836:	e8 71 fe ff ff       	call   16ac <printint>
        ap++;
    183b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    183f:	e9 b3 00 00 00       	jmp    18f7 <printf+0x193>
      } else if(c == 's'){
    1844:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1848:	75 45                	jne    188f <printf+0x12b>
        s = (char*)*ap;
    184a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    184d:	8b 00                	mov    (%eax),%eax
    184f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1852:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1856:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    185a:	75 09                	jne    1865 <printf+0x101>
          s = "(null)";
    185c:	c7 45 f4 e3 1d 00 00 	movl   $0x1de3,-0xc(%ebp)
        while(*s != 0){
    1863:	eb 1e                	jmp    1883 <printf+0x11f>
    1865:	eb 1c                	jmp    1883 <printf+0x11f>
          putc(fd, *s);
    1867:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186a:	0f b6 00             	movzbl (%eax),%eax
    186d:	0f be c0             	movsbl %al,%eax
    1870:	89 44 24 04          	mov    %eax,0x4(%esp)
    1874:	8b 45 08             	mov    0x8(%ebp),%eax
    1877:	89 04 24             	mov    %eax,(%esp)
    187a:	e8 05 fe ff ff       	call   1684 <putc>
          s++;
    187f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1883:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1886:	0f b6 00             	movzbl (%eax),%eax
    1889:	84 c0                	test   %al,%al
    188b:	75 da                	jne    1867 <printf+0x103>
    188d:	eb 68                	jmp    18f7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    188f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1893:	75 1d                	jne    18b2 <printf+0x14e>
        putc(fd, *ap);
    1895:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1898:	8b 00                	mov    (%eax),%eax
    189a:	0f be c0             	movsbl %al,%eax
    189d:	89 44 24 04          	mov    %eax,0x4(%esp)
    18a1:	8b 45 08             	mov    0x8(%ebp),%eax
    18a4:	89 04 24             	mov    %eax,(%esp)
    18a7:	e8 d8 fd ff ff       	call   1684 <putc>
        ap++;
    18ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18b0:	eb 45                	jmp    18f7 <printf+0x193>
      } else if(c == '%'){
    18b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    18b6:	75 17                	jne    18cf <printf+0x16b>
        putc(fd, c);
    18b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18bb:	0f be c0             	movsbl %al,%eax
    18be:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c2:	8b 45 08             	mov    0x8(%ebp),%eax
    18c5:	89 04 24             	mov    %eax,(%esp)
    18c8:	e8 b7 fd ff ff       	call   1684 <putc>
    18cd:	eb 28                	jmp    18f7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18cf:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    18d6:	00 
    18d7:	8b 45 08             	mov    0x8(%ebp),%eax
    18da:	89 04 24             	mov    %eax,(%esp)
    18dd:	e8 a2 fd ff ff       	call   1684 <putc>
        putc(fd, c);
    18e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18e5:	0f be c0             	movsbl %al,%eax
    18e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    18ec:	8b 45 08             	mov    0x8(%ebp),%eax
    18ef:	89 04 24             	mov    %eax,(%esp)
    18f2:	e8 8d fd ff ff       	call   1684 <putc>
      }
      state = 0;
    18f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    18fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1902:	8b 55 0c             	mov    0xc(%ebp),%edx
    1905:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1908:	01 d0                	add    %edx,%eax
    190a:	0f b6 00             	movzbl (%eax),%eax
    190d:	84 c0                	test   %al,%al
    190f:	0f 85 71 fe ff ff    	jne    1786 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1915:	c9                   	leave  
    1916:	c3                   	ret    
    1917:	90                   	nop

00001918 <free>:
    1918:	55                   	push   %ebp
    1919:	89 e5                	mov    %esp,%ebp
    191b:	83 ec 10             	sub    $0x10,%esp
    191e:	8b 45 08             	mov    0x8(%ebp),%eax
    1921:	83 e8 08             	sub    $0x8,%eax
    1924:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1927:	a1 c0 21 00 00       	mov    0x21c0,%eax
    192c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    192f:	eb 24                	jmp    1955 <free+0x3d>
    1931:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1934:	8b 00                	mov    (%eax),%eax
    1936:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1939:	77 12                	ja     194d <free+0x35>
    193b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    193e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1941:	77 24                	ja     1967 <free+0x4f>
    1943:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1946:	8b 00                	mov    (%eax),%eax
    1948:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    194b:	77 1a                	ja     1967 <free+0x4f>
    194d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1950:	8b 00                	mov    (%eax),%eax
    1952:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1955:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1958:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    195b:	76 d4                	jbe    1931 <free+0x19>
    195d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1960:	8b 00                	mov    (%eax),%eax
    1962:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1965:	76 ca                	jbe    1931 <free+0x19>
    1967:	8b 45 f8             	mov    -0x8(%ebp),%eax
    196a:	8b 40 04             	mov    0x4(%eax),%eax
    196d:	c1 e0 03             	shl    $0x3,%eax
    1970:	89 c2                	mov    %eax,%edx
    1972:	03 55 f8             	add    -0x8(%ebp),%edx
    1975:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1978:	8b 00                	mov    (%eax),%eax
    197a:	39 c2                	cmp    %eax,%edx
    197c:	75 24                	jne    19a2 <free+0x8a>
    197e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1981:	8b 50 04             	mov    0x4(%eax),%edx
    1984:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1987:	8b 00                	mov    (%eax),%eax
    1989:	8b 40 04             	mov    0x4(%eax),%eax
    198c:	01 c2                	add    %eax,%edx
    198e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1991:	89 50 04             	mov    %edx,0x4(%eax)
    1994:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1997:	8b 00                	mov    (%eax),%eax
    1999:	8b 10                	mov    (%eax),%edx
    199b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    199e:	89 10                	mov    %edx,(%eax)
    19a0:	eb 0a                	jmp    19ac <free+0x94>
    19a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a5:	8b 10                	mov    (%eax),%edx
    19a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19aa:	89 10                	mov    %edx,(%eax)
    19ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19af:	8b 40 04             	mov    0x4(%eax),%eax
    19b2:	c1 e0 03             	shl    $0x3,%eax
    19b5:	03 45 fc             	add    -0x4(%ebp),%eax
    19b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19bb:	75 20                	jne    19dd <free+0xc5>
    19bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c0:	8b 50 04             	mov    0x4(%eax),%edx
    19c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19c6:	8b 40 04             	mov    0x4(%eax),%eax
    19c9:	01 c2                	add    %eax,%edx
    19cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ce:	89 50 04             	mov    %edx,0x4(%eax)
    19d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19d4:	8b 10                	mov    (%eax),%edx
    19d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d9:	89 10                	mov    %edx,(%eax)
    19db:	eb 08                	jmp    19e5 <free+0xcd>
    19dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19e3:	89 10                	mov    %edx,(%eax)
    19e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e8:	a3 c0 21 00 00       	mov    %eax,0x21c0
    19ed:	c9                   	leave  
    19ee:	c3                   	ret    

000019ef <morecore>:
    19ef:	55                   	push   %ebp
    19f0:	89 e5                	mov    %esp,%ebp
    19f2:	83 ec 28             	sub    $0x28,%esp
    19f5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19fc:	77 07                	ja     1a05 <morecore+0x16>
    19fe:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1a05:	8b 45 08             	mov    0x8(%ebp),%eax
    1a08:	c1 e0 03             	shl    $0x3,%eax
    1a0b:	89 04 24             	mov    %eax,(%esp)
    1a0e:	e8 39 fc ff ff       	call   164c <sbrk>
    1a13:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a16:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a1a:	75 07                	jne    1a23 <morecore+0x34>
    1a1c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a21:	eb 22                	jmp    1a45 <morecore+0x56>
    1a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a26:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2c:	8b 55 08             	mov    0x8(%ebp),%edx
    1a2f:	89 50 04             	mov    %edx,0x4(%eax)
    1a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a35:	83 c0 08             	add    $0x8,%eax
    1a38:	89 04 24             	mov    %eax,(%esp)
    1a3b:	e8 d8 fe ff ff       	call   1918 <free>
    1a40:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1a45:	c9                   	leave  
    1a46:	c3                   	ret    

00001a47 <malloc>:
    1a47:	55                   	push   %ebp
    1a48:	89 e5                	mov    %esp,%ebp
    1a4a:	83 ec 28             	sub    $0x28,%esp
    1a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a50:	83 c0 07             	add    $0x7,%eax
    1a53:	c1 e8 03             	shr    $0x3,%eax
    1a56:	83 c0 01             	add    $0x1,%eax
    1a59:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a5c:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1a61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a68:	75 23                	jne    1a8d <malloc+0x46>
    1a6a:	c7 45 f0 b8 21 00 00 	movl   $0x21b8,-0x10(%ebp)
    1a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a74:	a3 c0 21 00 00       	mov    %eax,0x21c0
    1a79:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1a7e:	a3 b8 21 00 00       	mov    %eax,0x21b8
    1a83:	c7 05 bc 21 00 00 00 	movl   $0x0,0x21bc
    1a8a:	00 00 00 
    1a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a90:	8b 00                	mov    (%eax),%eax
    1a92:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a95:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a98:	8b 40 04             	mov    0x4(%eax),%eax
    1a9b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a9e:	72 4d                	jb     1aed <malloc+0xa6>
    1aa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aa3:	8b 40 04             	mov    0x4(%eax),%eax
    1aa6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1aa9:	75 0c                	jne    1ab7 <malloc+0x70>
    1aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aae:	8b 10                	mov    (%eax),%edx
    1ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ab3:	89 10                	mov    %edx,(%eax)
    1ab5:	eb 26                	jmp    1add <malloc+0x96>
    1ab7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aba:	8b 40 04             	mov    0x4(%eax),%eax
    1abd:	89 c2                	mov    %eax,%edx
    1abf:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1ac2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ac5:	89 50 04             	mov    %edx,0x4(%eax)
    1ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1acb:	8b 40 04             	mov    0x4(%eax),%eax
    1ace:	c1 e0 03             	shl    $0x3,%eax
    1ad1:	01 45 ec             	add    %eax,-0x14(%ebp)
    1ad4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ad7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ada:	89 50 04             	mov    %edx,0x4(%eax)
    1add:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ae0:	a3 c0 21 00 00       	mov    %eax,0x21c0
    1ae5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae8:	83 c0 08             	add    $0x8,%eax
    1aeb:	eb 38                	jmp    1b25 <malloc+0xde>
    1aed:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1af2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1af5:	75 1b                	jne    1b12 <malloc+0xcb>
    1af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1afa:	89 04 24             	mov    %eax,(%esp)
    1afd:	e8 ed fe ff ff       	call   19ef <morecore>
    1b02:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b05:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b09:	75 07                	jne    1b12 <malloc+0xcb>
    1b0b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b10:	eb 13                	jmp    1b25 <malloc+0xde>
    1b12:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b18:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b1b:	8b 00                	mov    (%eax),%eax
    1b1d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b20:	e9 70 ff ff ff       	jmp    1a95 <malloc+0x4e>
    1b25:	c9                   	leave  
    1b26:	c3                   	ret    
    1b27:	90                   	nop

00001b28 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b28:	55                   	push   %ebp
    1b29:	89 e5                	mov    %esp,%ebp
    1b2b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b2e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b31:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b34:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b37:	f0 87 02             	lock xchg %eax,(%edx)
    1b3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b40:	c9                   	leave  
    1b41:	c3                   	ret    

00001b42 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b42:	55                   	push   %ebp
    1b43:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b45:	8b 45 08             	mov    0x8(%ebp),%eax
    1b48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1b4e:	5d                   	pop    %ebp
    1b4f:	c3                   	ret    

00001b50 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1b50:	55                   	push   %ebp
    1b51:	89 e5                	mov    %esp,%ebp
    1b53:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1b56:	90                   	nop
    1b57:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b61:	00 
    1b62:	89 04 24             	mov    %eax,(%esp)
    1b65:	e8 be ff ff ff       	call   1b28 <xchg>
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	75 e9                	jne    1b57 <lock_acquire+0x7>
}
    1b6e:	c9                   	leave  
    1b6f:	c3                   	ret    

00001b70 <lock_release>:
void lock_release(lock_t *lock){
    1b70:	55                   	push   %ebp
    1b71:	89 e5                	mov    %esp,%ebp
    1b73:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b80:	00 
    1b81:	89 04 24             	mov    %eax,(%esp)
    1b84:	e8 9f ff ff ff       	call   1b28 <xchg>
}
    1b89:	c9                   	leave  
    1b8a:	c3                   	ret    

00001b8b <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1b8b:	55                   	push   %ebp
    1b8c:	89 e5                	mov    %esp,%ebp
    1b8e:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1b91:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1b98:	e8 aa fe ff ff       	call   1a47 <malloc>
    1b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    void *garbage_stack = stack; 
    1ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba9:	25 ff 0f 00 00       	and    $0xfff,%eax
    1bae:	85 c0                	test   %eax,%eax
    1bb0:	74 14                	je     1bc6 <thread_create+0x3b>
        stack = stack + (4096 - (uint)stack % 4096);
    1bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb5:	25 ff 0f 00 00       	and    $0xfff,%eax
    1bba:	89 c2                	mov    %eax,%edx
    1bbc:	b8 00 10 00 00       	mov    $0x1000,%eax
    1bc1:	29 d0                	sub    %edx,%eax
    1bc3:	01 45 f4             	add    %eax,-0xc(%ebp)
    }
    if (stack == 0){
    1bc6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bca:	75 1b                	jne    1be7 <thread_create+0x5c>

        printf(1,"malloc fail \n");
    1bcc:	c7 44 24 04 ea 1d 00 	movl   $0x1dea,0x4(%esp)
    1bd3:	00 
    1bd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bdb:	e8 84 fb ff ff       	call   1764 <printf>
        return 0;
    1be0:	b8 00 00 00 00       	mov    $0x0,%eax
    1be5:	eb 6f                	jmp    1c56 <thread_create+0xcb>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1be7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1bea:	8b 55 08             	mov    0x8(%ebp),%edx
    1bed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1bf4:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bf8:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1bff:	00 
    1c00:	89 04 24             	mov    %eax,(%esp)
    1c03:	e8 5c fa ff ff       	call   1664 <clone>
    1c08:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1c0b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c0f:	79 1b                	jns    1c2c <thread_create+0xa1>
        printf(1,"clone fails\n");
    1c11:	c7 44 24 04 f8 1d 00 	movl   $0x1df8,0x4(%esp)
    1c18:	00 
    1c19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c20:	e8 3f fb ff ff       	call   1764 <printf>
        return 0;
    1c25:	b8 00 00 00 00       	mov    $0x0,%eax
    1c2a:	eb 2a                	jmp    1c56 <thread_create+0xcb>
    }
    if(tid > 0){
    1c2c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c30:	7e 05                	jle    1c37 <thread_create+0xac>
        //store threads on thread table
        return garbage_stack;
    1c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c35:	eb 1f                	jmp    1c56 <thread_create+0xcb>
    }
    if(tid == 0){
    1c37:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c3b:	75 14                	jne    1c51 <thread_create+0xc6>
        printf(1,"tid = 0 return \n");
    1c3d:	c7 44 24 04 05 1e 00 	movl   $0x1e05,0x4(%esp)
    1c44:	00 
    1c45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c4c:	e8 13 fb ff ff       	call   1764 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1c51:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1c56:	c9                   	leave  
    1c57:	c3                   	ret    

00001c58 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1c58:	55                   	push   %ebp
    1c59:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1c5b:	a1 a4 21 00 00       	mov    0x21a4,%eax
    1c60:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1c66:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1c6b:	a3 a4 21 00 00       	mov    %eax,0x21a4
    return (int)(rands % max);
    1c70:	a1 a4 21 00 00       	mov    0x21a4,%eax
    1c75:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c78:	ba 00 00 00 00       	mov    $0x0,%edx
    1c7d:	f7 f1                	div    %ecx
    1c7f:	89 d0                	mov    %edx,%eax
}
    1c81:	5d                   	pop    %ebp
    1c82:	c3                   	ret    
    1c83:	90                   	nop

00001c84 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1c84:	55                   	push   %ebp
    1c85:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1c87:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1c90:	8b 45 08             	mov    0x8(%ebp),%eax
    1c93:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1c9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1ca4:	5d                   	pop    %ebp
    1ca5:	c3                   	ret    

00001ca6 <add_q>:

void add_q(struct queue *q, int v){
    1ca6:	55                   	push   %ebp
    1ca7:	89 e5                	mov    %esp,%ebp
    1ca9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1cac:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1cb3:	e8 8f fd ff ff       	call   1a47 <malloc>
    1cb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1cbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cbe:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ccb:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1ccd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd0:	8b 40 04             	mov    0x4(%eax),%eax
    1cd3:	85 c0                	test   %eax,%eax
    1cd5:	75 0b                	jne    1ce2 <add_q+0x3c>
        q->head = n;
    1cd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cda:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cdd:	89 50 04             	mov    %edx,0x4(%eax)
    1ce0:	eb 0c                	jmp    1cee <add_q+0x48>
    }else{
        q->tail->next = n;
    1ce2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce5:	8b 40 08             	mov    0x8(%eax),%eax
    1ce8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ceb:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1cee:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cf4:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1cf7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfa:	8b 00                	mov    (%eax),%eax
    1cfc:	8d 50 01             	lea    0x1(%eax),%edx
    1cff:	8b 45 08             	mov    0x8(%ebp),%eax
    1d02:	89 10                	mov    %edx,(%eax)
}
    1d04:	c9                   	leave  
    1d05:	c3                   	ret    

00001d06 <empty_q>:

int empty_q(struct queue *q){
    1d06:	55                   	push   %ebp
    1d07:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1d09:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0c:	8b 00                	mov    (%eax),%eax
    1d0e:	85 c0                	test   %eax,%eax
    1d10:	75 07                	jne    1d19 <empty_q+0x13>
        return 1;
    1d12:	b8 01 00 00 00       	mov    $0x1,%eax
    1d17:	eb 05                	jmp    1d1e <empty_q+0x18>
    else
        return 0;
    1d19:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d1e:	5d                   	pop    %ebp
    1d1f:	c3                   	ret    

00001d20 <pop_q>:
int pop_q(struct queue *q){
    1d20:	55                   	push   %ebp
    1d21:	89 e5                	mov    %esp,%ebp
    1d23:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d26:	8b 45 08             	mov    0x8(%ebp),%eax
    1d29:	89 04 24             	mov    %eax,(%esp)
    1d2c:	e8 d5 ff ff ff       	call   1d06 <empty_q>
    1d31:	85 c0                	test   %eax,%eax
    1d33:	75 5d                	jne    1d92 <pop_q+0x72>
       val = q->head->value; 
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	8b 40 04             	mov    0x4(%eax),%eax
    1d3b:	8b 00                	mov    (%eax),%eax
    1d3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
       destroy = q->head;
    1d40:	8b 45 08             	mov    0x8(%ebp),%eax
    1d43:	8b 40 04             	mov    0x4(%eax),%eax
    1d46:	89 45 f0             	mov    %eax,-0x10(%ebp)
       q->head = q->head->next;
    1d49:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4c:	8b 40 04             	mov    0x4(%eax),%eax
    1d4f:	8b 50 04             	mov    0x4(%eax),%edx
    1d52:	8b 45 08             	mov    0x8(%ebp),%eax
    1d55:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1d58:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d5b:	89 04 24             	mov    %eax,(%esp)
    1d5e:	e8 b5 fb ff ff       	call   1918 <free>
       q->size--;
    1d63:	8b 45 08             	mov    0x8(%ebp),%eax
    1d66:	8b 00                	mov    (%eax),%eax
    1d68:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1d70:	8b 45 08             	mov    0x8(%ebp),%eax
    1d73:	8b 00                	mov    (%eax),%eax
    1d75:	85 c0                	test   %eax,%eax
    1d77:	75 14                	jne    1d8d <pop_q+0x6d>
            q->head = 0;
    1d79:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1d83:	8b 45 08             	mov    0x8(%ebp),%eax
    1d86:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1d8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d90:	eb 05                	jmp    1d97 <pop_q+0x77>
    }
    return -1;
    1d92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d97:	c9                   	leave  
    1d98:	c3                   	ret    
