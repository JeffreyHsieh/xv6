
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    1009:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 58 1b 00 00 	movl   $0x1b58,(%esp)
    1018:	e8 9f 03 00 00       	call   13bc <open>
    101d:	85 c0                	test   %eax,%eax
    101f:	79 30                	jns    1051 <main+0x51>
    1021:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1028:	00 
    1029:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1030:	00 
    1031:	c7 04 24 58 1b 00 00 	movl   $0x1b58,(%esp)
    1038:	e8 87 03 00 00       	call   13c4 <mknod>
    103d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1044:	00 
    1045:	c7 04 24 58 1b 00 00 	movl   $0x1b58,(%esp)
    104c:	e8 6b 03 00 00       	call   13bc <open>
    1051:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1058:	e8 97 03 00 00       	call   13f4 <dup>
    105d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1064:	e8 8b 03 00 00       	call   13f4 <dup>
    1069:	eb 01                	jmp    106c <main+0x6c>
    106b:	90                   	nop
    106c:	c7 44 24 04 60 1b 00 	movl   $0x1b60,0x4(%esp)
    1073:	00 
    1074:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107b:	e8 9d 04 00 00       	call   151d <printf>
    1080:	e8 ef 02 00 00       	call   1374 <fork>
    1085:	89 44 24 18          	mov    %eax,0x18(%esp)
    1089:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    108e:	79 19                	jns    10a9 <main+0xa9>
    1090:	c7 44 24 04 73 1b 00 	movl   $0x1b73,0x4(%esp)
    1097:	00 
    1098:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109f:	e8 79 04 00 00       	call   151d <printf>
    10a4:	e8 d3 02 00 00       	call   137c <exit>
    10a9:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    10ae:	75 43                	jne    10f3 <main+0xf3>
    10b0:	c7 44 24 04 d8 1b 00 	movl   $0x1bd8,0x4(%esp)
    10b7:	00 
    10b8:	c7 04 24 55 1b 00 00 	movl   $0x1b55,(%esp)
    10bf:	e8 f0 02 00 00       	call   13b4 <exec>
    10c4:	c7 44 24 04 86 1b 00 	movl   $0x1b86,0x4(%esp)
    10cb:	00 
    10cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d3:	e8 45 04 00 00       	call   151d <printf>
    10d8:	e8 9f 02 00 00       	call   137c <exit>
    10dd:	c7 44 24 04 9c 1b 00 	movl   $0x1b9c,0x4(%esp)
    10e4:	00 
    10e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ec:	e8 2c 04 00 00       	call   151d <printf>
    10f1:	eb 01                	jmp    10f4 <main+0xf4>
    10f3:	90                   	nop
    10f4:	e8 8b 02 00 00       	call   1384 <wait>
    10f9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    10fd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1102:	0f 88 63 ff ff ff    	js     106b <main+0x6b>
    1108:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    110c:	3b 44 24 18          	cmp    0x18(%esp),%eax
    1110:	75 cb                	jne    10dd <main+0xdd>
    1112:	e9 55 ff ff ff       	jmp    106c <main+0x6c>
    1117:	90                   	nop

00001118 <stosb>:
    1118:	55                   	push   %ebp
    1119:	89 e5                	mov    %esp,%ebp
    111b:	57                   	push   %edi
    111c:	53                   	push   %ebx
    111d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1120:	8b 55 10             	mov    0x10(%ebp),%edx
    1123:	8b 45 0c             	mov    0xc(%ebp),%eax
    1126:	89 cb                	mov    %ecx,%ebx
    1128:	89 df                	mov    %ebx,%edi
    112a:	89 d1                	mov    %edx,%ecx
    112c:	fc                   	cld    
    112d:	f3 aa                	rep stos %al,%es:(%edi)
    112f:	89 ca                	mov    %ecx,%edx
    1131:	89 fb                	mov    %edi,%ebx
    1133:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1136:	89 55 10             	mov    %edx,0x10(%ebp)
    1139:	5b                   	pop    %ebx
    113a:	5f                   	pop    %edi
    113b:	5d                   	pop    %ebp
    113c:	c3                   	ret    

0000113d <strcpy>:
    113d:	55                   	push   %ebp
    113e:	89 e5                	mov    %esp,%ebp
    1140:	83 ec 10             	sub    $0x10,%esp
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1149:	8b 45 0c             	mov    0xc(%ebp),%eax
    114c:	0f b6 10             	movzbl (%eax),%edx
    114f:	8b 45 08             	mov    0x8(%ebp),%eax
    1152:	88 10                	mov    %dl,(%eax)
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	0f b6 00             	movzbl (%eax),%eax
    115a:	84 c0                	test   %al,%al
    115c:	0f 95 c0             	setne  %al
    115f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1163:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1167:	84 c0                	test   %al,%al
    1169:	75 de                	jne    1149 <strcpy+0xc>
    116b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    116e:	c9                   	leave  
    116f:	c3                   	ret    

00001170 <strcmp>:
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	eb 08                	jmp    117d <strcmp+0xd>
    1175:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1179:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	84 c0                	test   %al,%al
    1185:	74 10                	je     1197 <strcmp+0x27>
    1187:	8b 45 08             	mov    0x8(%ebp),%eax
    118a:	0f b6 10             	movzbl (%eax),%edx
    118d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1190:	0f b6 00             	movzbl (%eax),%eax
    1193:	38 c2                	cmp    %al,%dl
    1195:	74 de                	je     1175 <strcmp+0x5>
    1197:	8b 45 08             	mov    0x8(%ebp),%eax
    119a:	0f b6 00             	movzbl (%eax),%eax
    119d:	0f b6 d0             	movzbl %al,%edx
    11a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a3:	0f b6 00             	movzbl (%eax),%eax
    11a6:	0f b6 c0             	movzbl %al,%eax
    11a9:	89 d1                	mov    %edx,%ecx
    11ab:	29 c1                	sub    %eax,%ecx
    11ad:	89 c8                	mov    %ecx,%eax
    11af:	5d                   	pop    %ebp
    11b0:	c3                   	ret    

000011b1 <strlen>:
    11b1:	55                   	push   %ebp
    11b2:	89 e5                	mov    %esp,%ebp
    11b4:	83 ec 10             	sub    $0x10,%esp
    11b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11be:	eb 04                	jmp    11c4 <strlen+0x13>
    11c0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11c7:	03 45 08             	add    0x8(%ebp),%eax
    11ca:	0f b6 00             	movzbl (%eax),%eax
    11cd:	84 c0                	test   %al,%al
    11cf:	75 ef                	jne    11c0 <strlen+0xf>
    11d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11d4:	c9                   	leave  
    11d5:	c3                   	ret    

000011d6 <memset>:
    11d6:	55                   	push   %ebp
    11d7:	89 e5                	mov    %esp,%ebp
    11d9:	83 ec 0c             	sub    $0xc,%esp
    11dc:	8b 45 10             	mov    0x10(%ebp),%eax
    11df:	89 44 24 08          	mov    %eax,0x8(%esp)
    11e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ea:	8b 45 08             	mov    0x8(%ebp),%eax
    11ed:	89 04 24             	mov    %eax,(%esp)
    11f0:	e8 23 ff ff ff       	call   1118 <stosb>
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	c9                   	leave  
    11f9:	c3                   	ret    

000011fa <strchr>:
    11fa:	55                   	push   %ebp
    11fb:	89 e5                	mov    %esp,%ebp
    11fd:	83 ec 04             	sub    $0x4,%esp
    1200:	8b 45 0c             	mov    0xc(%ebp),%eax
    1203:	88 45 fc             	mov    %al,-0x4(%ebp)
    1206:	eb 14                	jmp    121c <strchr+0x22>
    1208:	8b 45 08             	mov    0x8(%ebp),%eax
    120b:	0f b6 00             	movzbl (%eax),%eax
    120e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1211:	75 05                	jne    1218 <strchr+0x1e>
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	eb 13                	jmp    122b <strchr+0x31>
    1218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    121c:	8b 45 08             	mov    0x8(%ebp),%eax
    121f:	0f b6 00             	movzbl (%eax),%eax
    1222:	84 c0                	test   %al,%al
    1224:	75 e2                	jne    1208 <strchr+0xe>
    1226:	b8 00 00 00 00       	mov    $0x0,%eax
    122b:	c9                   	leave  
    122c:	c3                   	ret    

0000122d <gets>:
    122d:	55                   	push   %ebp
    122e:	89 e5                	mov    %esp,%ebp
    1230:	83 ec 28             	sub    $0x28,%esp
    1233:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    123a:	eb 44                	jmp    1280 <gets+0x53>
    123c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1243:	00 
    1244:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1247:	89 44 24 04          	mov    %eax,0x4(%esp)
    124b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1252:	e8 3d 01 00 00       	call   1394 <read>
    1257:	89 45 f4             	mov    %eax,-0xc(%ebp)
    125a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    125e:	7e 2d                	jle    128d <gets+0x60>
    1260:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1263:	03 45 08             	add    0x8(%ebp),%eax
    1266:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    126a:	88 10                	mov    %dl,(%eax)
    126c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1270:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1274:	3c 0a                	cmp    $0xa,%al
    1276:	74 16                	je     128e <gets+0x61>
    1278:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    127c:	3c 0d                	cmp    $0xd,%al
    127e:	74 0e                	je     128e <gets+0x61>
    1280:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1283:	83 c0 01             	add    $0x1,%eax
    1286:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1289:	7c b1                	jl     123c <gets+0xf>
    128b:	eb 01                	jmp    128e <gets+0x61>
    128d:	90                   	nop
    128e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1291:	03 45 08             	add    0x8(%ebp),%eax
    1294:	c6 00 00             	movb   $0x0,(%eax)
    1297:	8b 45 08             	mov    0x8(%ebp),%eax
    129a:	c9                   	leave  
    129b:	c3                   	ret    

0000129c <stat>:
    129c:	55                   	push   %ebp
    129d:	89 e5                	mov    %esp,%ebp
    129f:	83 ec 28             	sub    $0x28,%esp
    12a2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12a9:	00 
    12aa:	8b 45 08             	mov    0x8(%ebp),%eax
    12ad:	89 04 24             	mov    %eax,(%esp)
    12b0:	e8 07 01 00 00       	call   13bc <open>
    12b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    12b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12bc:	79 07                	jns    12c5 <stat+0x29>
    12be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12c3:	eb 23                	jmp    12e8 <stat+0x4c>
    12c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    12cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12cf:	89 04 24             	mov    %eax,(%esp)
    12d2:	e8 fd 00 00 00       	call   13d4 <fstat>
    12d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12dd:	89 04 24             	mov    %eax,(%esp)
    12e0:	e8 bf 00 00 00       	call   13a4 <close>
    12e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e8:	c9                   	leave  
    12e9:	c3                   	ret    

000012ea <atoi>:
    12ea:	55                   	push   %ebp
    12eb:	89 e5                	mov    %esp,%ebp
    12ed:	83 ec 10             	sub    $0x10,%esp
    12f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    12f7:	eb 24                	jmp    131d <atoi+0x33>
    12f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12fc:	89 d0                	mov    %edx,%eax
    12fe:	c1 e0 02             	shl    $0x2,%eax
    1301:	01 d0                	add    %edx,%eax
    1303:	01 c0                	add    %eax,%eax
    1305:	89 c2                	mov    %eax,%edx
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
    130a:	0f b6 00             	movzbl (%eax),%eax
    130d:	0f be c0             	movsbl %al,%eax
    1310:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1313:	83 e8 30             	sub    $0x30,%eax
    1316:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1319:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	0f b6 00             	movzbl (%eax),%eax
    1323:	3c 2f                	cmp    $0x2f,%al
    1325:	7e 0a                	jle    1331 <atoi+0x47>
    1327:	8b 45 08             	mov    0x8(%ebp),%eax
    132a:	0f b6 00             	movzbl (%eax),%eax
    132d:	3c 39                	cmp    $0x39,%al
    132f:	7e c8                	jle    12f9 <atoi+0xf>
    1331:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1334:	c9                   	leave  
    1335:	c3                   	ret    

00001336 <memmove>:
    1336:	55                   	push   %ebp
    1337:	89 e5                	mov    %esp,%ebp
    1339:	83 ec 10             	sub    $0x10,%esp
    133c:	8b 45 08             	mov    0x8(%ebp),%eax
    133f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1342:	8b 45 0c             	mov    0xc(%ebp),%eax
    1345:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1348:	eb 13                	jmp    135d <memmove+0x27>
    134a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    134d:	0f b6 10             	movzbl (%eax),%edx
    1350:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1353:	88 10                	mov    %dl,(%eax)
    1355:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1359:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    135d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1361:	0f 9f c0             	setg   %al
    1364:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1368:	84 c0                	test   %al,%al
    136a:	75 de                	jne    134a <memmove+0x14>
    136c:	8b 45 08             	mov    0x8(%ebp),%eax
    136f:	c9                   	leave  
    1370:	c3                   	ret    
    1371:	90                   	nop
    1372:	90                   	nop
    1373:	90                   	nop

00001374 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1374:	b8 01 00 00 00       	mov    $0x1,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <exit>:
SYSCALL(exit)
    137c:	b8 02 00 00 00       	mov    $0x2,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <wait>:
SYSCALL(wait)
    1384:	b8 03 00 00 00       	mov    $0x3,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <pipe>:
SYSCALL(pipe)
    138c:	b8 04 00 00 00       	mov    $0x4,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <read>:
SYSCALL(read)
    1394:	b8 05 00 00 00       	mov    $0x5,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <write>:
SYSCALL(write)
    139c:	b8 10 00 00 00       	mov    $0x10,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <close>:
SYSCALL(close)
    13a4:	b8 15 00 00 00       	mov    $0x15,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <kill>:
SYSCALL(kill)
    13ac:	b8 06 00 00 00       	mov    $0x6,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <exec>:
SYSCALL(exec)
    13b4:	b8 07 00 00 00       	mov    $0x7,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <open>:
SYSCALL(open)
    13bc:	b8 0f 00 00 00       	mov    $0xf,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <mknod>:
SYSCALL(mknod)
    13c4:	b8 11 00 00 00       	mov    $0x11,%eax
    13c9:	cd 40                	int    $0x40
    13cb:	c3                   	ret    

000013cc <unlink>:
SYSCALL(unlink)
    13cc:	b8 12 00 00 00       	mov    $0x12,%eax
    13d1:	cd 40                	int    $0x40
    13d3:	c3                   	ret    

000013d4 <fstat>:
SYSCALL(fstat)
    13d4:	b8 08 00 00 00       	mov    $0x8,%eax
    13d9:	cd 40                	int    $0x40
    13db:	c3                   	ret    

000013dc <link>:
SYSCALL(link)
    13dc:	b8 13 00 00 00       	mov    $0x13,%eax
    13e1:	cd 40                	int    $0x40
    13e3:	c3                   	ret    

000013e4 <mkdir>:
SYSCALL(mkdir)
    13e4:	b8 14 00 00 00       	mov    $0x14,%eax
    13e9:	cd 40                	int    $0x40
    13eb:	c3                   	ret    

000013ec <chdir>:
SYSCALL(chdir)
    13ec:	b8 09 00 00 00       	mov    $0x9,%eax
    13f1:	cd 40                	int    $0x40
    13f3:	c3                   	ret    

000013f4 <dup>:
SYSCALL(dup)
    13f4:	b8 0a 00 00 00       	mov    $0xa,%eax
    13f9:	cd 40                	int    $0x40
    13fb:	c3                   	ret    

000013fc <getpid>:
SYSCALL(getpid)
    13fc:	b8 0b 00 00 00       	mov    $0xb,%eax
    1401:	cd 40                	int    $0x40
    1403:	c3                   	ret    

00001404 <sbrk>:
SYSCALL(sbrk)
    1404:	b8 0c 00 00 00       	mov    $0xc,%eax
    1409:	cd 40                	int    $0x40
    140b:	c3                   	ret    

0000140c <sleep>:
SYSCALL(sleep)
    140c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1411:	cd 40                	int    $0x40
    1413:	c3                   	ret    

00001414 <uptime>:
SYSCALL(uptime)
    1414:	b8 0e 00 00 00       	mov    $0xe,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <clone>:
SYSCALL(clone)
    141c:	b8 16 00 00 00       	mov    $0x16,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <texit>:
SYSCALL(texit)
    1424:	b8 17 00 00 00       	mov    $0x17,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <tsleep>:
SYSCALL(tsleep)
    142c:	b8 18 00 00 00       	mov    $0x18,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <twakeup>:
SYSCALL(twakeup)
    1434:	b8 19 00 00 00       	mov    $0x19,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <thread_yield>:
SYSCALL(thread_yield)
    143c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <putc>:
    1444:	55                   	push   %ebp
    1445:	89 e5                	mov    %esp,%ebp
    1447:	83 ec 28             	sub    $0x28,%esp
    144a:	8b 45 0c             	mov    0xc(%ebp),%eax
    144d:	88 45 f4             	mov    %al,-0xc(%ebp)
    1450:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1457:	00 
    1458:	8d 45 f4             	lea    -0xc(%ebp),%eax
    145b:	89 44 24 04          	mov    %eax,0x4(%esp)
    145f:	8b 45 08             	mov    0x8(%ebp),%eax
    1462:	89 04 24             	mov    %eax,(%esp)
    1465:	e8 32 ff ff ff       	call   139c <write>
    146a:	c9                   	leave  
    146b:	c3                   	ret    

0000146c <printint>:
    146c:	55                   	push   %ebp
    146d:	89 e5                	mov    %esp,%ebp
    146f:	53                   	push   %ebx
    1470:	83 ec 44             	sub    $0x44,%esp
    1473:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    147a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    147e:	74 17                	je     1497 <printint+0x2b>
    1480:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1484:	79 11                	jns    1497 <printint+0x2b>
    1486:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    148d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1490:	f7 d8                	neg    %eax
    1492:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1495:	eb 06                	jmp    149d <printint+0x31>
    1497:	8b 45 0c             	mov    0xc(%ebp),%eax
    149a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    149d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14a4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    14a7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ad:	ba 00 00 00 00       	mov    $0x0,%edx
    14b2:	f7 f3                	div    %ebx
    14b4:	89 d0                	mov    %edx,%eax
    14b6:	0f b6 80 e0 1b 00 00 	movzbl 0x1be0(%eax),%eax
    14bd:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    14c1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14c5:	8b 45 10             	mov    0x10(%ebp),%eax
    14c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ce:	ba 00 00 00 00       	mov    $0x0,%edx
    14d3:	f7 75 d4             	divl   -0x2c(%ebp)
    14d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14dd:	75 c5                	jne    14a4 <printint+0x38>
    14df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14e3:	74 28                	je     150d <printint+0xa1>
    14e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    14ed:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14f1:	eb 1a                	jmp    150d <printint+0xa1>
    14f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14f6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    14fb:	0f be c0             	movsbl %al,%eax
    14fe:	89 44 24 04          	mov    %eax,0x4(%esp)
    1502:	8b 45 08             	mov    0x8(%ebp),%eax
    1505:	89 04 24             	mov    %eax,(%esp)
    1508:	e8 37 ff ff ff       	call   1444 <putc>
    150d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1511:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1515:	79 dc                	jns    14f3 <printint+0x87>
    1517:	83 c4 44             	add    $0x44,%esp
    151a:	5b                   	pop    %ebx
    151b:	5d                   	pop    %ebp
    151c:	c3                   	ret    

0000151d <printf>:
    151d:	55                   	push   %ebp
    151e:	89 e5                	mov    %esp,%ebp
    1520:	83 ec 38             	sub    $0x38,%esp
    1523:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    152a:	8d 45 0c             	lea    0xc(%ebp),%eax
    152d:	83 c0 04             	add    $0x4,%eax
    1530:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1533:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    153a:	e9 7e 01 00 00       	jmp    16bd <printf+0x1a0>
    153f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1542:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1545:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1548:	0f b6 00             	movzbl (%eax),%eax
    154b:	0f be c0             	movsbl %al,%eax
    154e:	25 ff 00 00 00       	and    $0xff,%eax
    1553:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1556:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    155a:	75 2c                	jne    1588 <printf+0x6b>
    155c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1560:	75 0c                	jne    156e <printf+0x51>
    1562:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1569:	e9 4b 01 00 00       	jmp    16b9 <printf+0x19c>
    156e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1571:	0f be c0             	movsbl %al,%eax
    1574:	89 44 24 04          	mov    %eax,0x4(%esp)
    1578:	8b 45 08             	mov    0x8(%ebp),%eax
    157b:	89 04 24             	mov    %eax,(%esp)
    157e:	e8 c1 fe ff ff       	call   1444 <putc>
    1583:	e9 31 01 00 00       	jmp    16b9 <printf+0x19c>
    1588:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    158c:	0f 85 27 01 00 00    	jne    16b9 <printf+0x19c>
    1592:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1596:	75 2d                	jne    15c5 <printf+0xa8>
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	8b 00                	mov    (%eax),%eax
    159d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    15a4:	00 
    15a5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    15ac:	00 
    15ad:	89 44 24 04          	mov    %eax,0x4(%esp)
    15b1:	8b 45 08             	mov    0x8(%ebp),%eax
    15b4:	89 04 24             	mov    %eax,(%esp)
    15b7:	e8 b0 fe ff ff       	call   146c <printint>
    15bc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15c0:	e9 ed 00 00 00       	jmp    16b2 <printf+0x195>
    15c5:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    15c9:	74 06                	je     15d1 <printf+0xb4>
    15cb:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    15cf:	75 2d                	jne    15fe <printf+0xe1>
    15d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d4:	8b 00                	mov    (%eax),%eax
    15d6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15dd:	00 
    15de:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15e5:	00 
    15e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ea:	8b 45 08             	mov    0x8(%ebp),%eax
    15ed:	89 04 24             	mov    %eax,(%esp)
    15f0:	e8 77 fe ff ff       	call   146c <printint>
    15f5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15f9:	e9 b4 00 00 00       	jmp    16b2 <printf+0x195>
    15fe:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1602:	75 46                	jne    164a <printf+0x12d>
    1604:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1607:	8b 00                	mov    (%eax),%eax
    1609:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    160c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1610:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1614:	75 27                	jne    163d <printf+0x120>
    1616:	c7 45 e4 a5 1b 00 00 	movl   $0x1ba5,-0x1c(%ebp)
    161d:	eb 1f                	jmp    163e <printf+0x121>
    161f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1622:	0f b6 00             	movzbl (%eax),%eax
    1625:	0f be c0             	movsbl %al,%eax
    1628:	89 44 24 04          	mov    %eax,0x4(%esp)
    162c:	8b 45 08             	mov    0x8(%ebp),%eax
    162f:	89 04 24             	mov    %eax,(%esp)
    1632:	e8 0d fe ff ff       	call   1444 <putc>
    1637:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    163b:	eb 01                	jmp    163e <printf+0x121>
    163d:	90                   	nop
    163e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1641:	0f b6 00             	movzbl (%eax),%eax
    1644:	84 c0                	test   %al,%al
    1646:	75 d7                	jne    161f <printf+0x102>
    1648:	eb 68                	jmp    16b2 <printf+0x195>
    164a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    164e:	75 1d                	jne    166d <printf+0x150>
    1650:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1653:	8b 00                	mov    (%eax),%eax
    1655:	0f be c0             	movsbl %al,%eax
    1658:	89 44 24 04          	mov    %eax,0x4(%esp)
    165c:	8b 45 08             	mov    0x8(%ebp),%eax
    165f:	89 04 24             	mov    %eax,(%esp)
    1662:	e8 dd fd ff ff       	call   1444 <putc>
    1667:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    166b:	eb 45                	jmp    16b2 <printf+0x195>
    166d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1671:	75 17                	jne    168a <printf+0x16d>
    1673:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1676:	0f be c0             	movsbl %al,%eax
    1679:	89 44 24 04          	mov    %eax,0x4(%esp)
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	89 04 24             	mov    %eax,(%esp)
    1683:	e8 bc fd ff ff       	call   1444 <putc>
    1688:	eb 28                	jmp    16b2 <printf+0x195>
    168a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1691:	00 
    1692:	8b 45 08             	mov    0x8(%ebp),%eax
    1695:	89 04 24             	mov    %eax,(%esp)
    1698:	e8 a7 fd ff ff       	call   1444 <putc>
    169d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a0:	0f be c0             	movsbl %al,%eax
    16a3:	89 44 24 04          	mov    %eax,0x4(%esp)
    16a7:	8b 45 08             	mov    0x8(%ebp),%eax
    16aa:	89 04 24             	mov    %eax,(%esp)
    16ad:	e8 92 fd ff ff       	call   1444 <putc>
    16b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16b9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    16bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16c3:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16c6:	0f b6 00             	movzbl (%eax),%eax
    16c9:	84 c0                	test   %al,%al
    16cb:	0f 85 6e fe ff ff    	jne    153f <printf+0x22>
    16d1:	c9                   	leave  
    16d2:	c3                   	ret    
    16d3:	90                   	nop

000016d4 <free>:
    16d4:	55                   	push   %ebp
    16d5:	89 e5                	mov    %esp,%ebp
    16d7:	83 ec 10             	sub    $0x10,%esp
    16da:	8b 45 08             	mov    0x8(%ebp),%eax
    16dd:	83 e8 08             	sub    $0x8,%eax
    16e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    16e3:	a1 00 1c 00 00       	mov    0x1c00,%eax
    16e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16eb:	eb 24                	jmp    1711 <free+0x3d>
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 00                	mov    (%eax),%eax
    16f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16f5:	77 12                	ja     1709 <free+0x35>
    16f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16fd:	77 24                	ja     1723 <free+0x4f>
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	8b 00                	mov    (%eax),%eax
    1704:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1707:	77 1a                	ja     1723 <free+0x4f>
    1709:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170c:	8b 00                	mov    (%eax),%eax
    170e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1711:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1714:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1717:	76 d4                	jbe    16ed <free+0x19>
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1721:	76 ca                	jbe    16ed <free+0x19>
    1723:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1726:	8b 40 04             	mov    0x4(%eax),%eax
    1729:	c1 e0 03             	shl    $0x3,%eax
    172c:	89 c2                	mov    %eax,%edx
    172e:	03 55 f8             	add    -0x8(%ebp),%edx
    1731:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1734:	8b 00                	mov    (%eax),%eax
    1736:	39 c2                	cmp    %eax,%edx
    1738:	75 24                	jne    175e <free+0x8a>
    173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    173d:	8b 50 04             	mov    0x4(%eax),%edx
    1740:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1743:	8b 00                	mov    (%eax),%eax
    1745:	8b 40 04             	mov    0x4(%eax),%eax
    1748:	01 c2                	add    %eax,%edx
    174a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174d:	89 50 04             	mov    %edx,0x4(%eax)
    1750:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1753:	8b 00                	mov    (%eax),%eax
    1755:	8b 10                	mov    (%eax),%edx
    1757:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175a:	89 10                	mov    %edx,(%eax)
    175c:	eb 0a                	jmp    1768 <free+0x94>
    175e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1761:	8b 10                	mov    (%eax),%edx
    1763:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1766:	89 10                	mov    %edx,(%eax)
    1768:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176b:	8b 40 04             	mov    0x4(%eax),%eax
    176e:	c1 e0 03             	shl    $0x3,%eax
    1771:	03 45 fc             	add    -0x4(%ebp),%eax
    1774:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1777:	75 20                	jne    1799 <free+0xc5>
    1779:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177c:	8b 50 04             	mov    0x4(%eax),%edx
    177f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1782:	8b 40 04             	mov    0x4(%eax),%eax
    1785:	01 c2                	add    %eax,%edx
    1787:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178a:	89 50 04             	mov    %edx,0x4(%eax)
    178d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1790:	8b 10                	mov    (%eax),%edx
    1792:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1795:	89 10                	mov    %edx,(%eax)
    1797:	eb 08                	jmp    17a1 <free+0xcd>
    1799:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    179f:	89 10                	mov    %edx,(%eax)
    17a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a4:	a3 00 1c 00 00       	mov    %eax,0x1c00
    17a9:	c9                   	leave  
    17aa:	c3                   	ret    

000017ab <morecore>:
    17ab:	55                   	push   %ebp
    17ac:	89 e5                	mov    %esp,%ebp
    17ae:	83 ec 28             	sub    $0x28,%esp
    17b1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17b8:	77 07                	ja     17c1 <morecore+0x16>
    17ba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	c1 e0 03             	shl    $0x3,%eax
    17c7:	89 04 24             	mov    %eax,(%esp)
    17ca:	e8 35 fc ff ff       	call   1404 <sbrk>
    17cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17d2:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    17d6:	75 07                	jne    17df <morecore+0x34>
    17d8:	b8 00 00 00 00       	mov    $0x0,%eax
    17dd:	eb 22                	jmp    1801 <morecore+0x56>
    17df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e8:	8b 55 08             	mov    0x8(%ebp),%edx
    17eb:	89 50 04             	mov    %edx,0x4(%eax)
    17ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f1:	83 c0 08             	add    $0x8,%eax
    17f4:	89 04 24             	mov    %eax,(%esp)
    17f7:	e8 d8 fe ff ff       	call   16d4 <free>
    17fc:	a1 00 1c 00 00       	mov    0x1c00,%eax
    1801:	c9                   	leave  
    1802:	c3                   	ret    

00001803 <malloc>:
    1803:	55                   	push   %ebp
    1804:	89 e5                	mov    %esp,%ebp
    1806:	83 ec 28             	sub    $0x28,%esp
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
    180c:	83 c0 07             	add    $0x7,%eax
    180f:	c1 e8 03             	shr    $0x3,%eax
    1812:	83 c0 01             	add    $0x1,%eax
    1815:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1818:	a1 00 1c 00 00       	mov    0x1c00,%eax
    181d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1820:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1824:	75 23                	jne    1849 <malloc+0x46>
    1826:	c7 45 f0 f8 1b 00 00 	movl   $0x1bf8,-0x10(%ebp)
    182d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1830:	a3 00 1c 00 00       	mov    %eax,0x1c00
    1835:	a1 00 1c 00 00       	mov    0x1c00,%eax
    183a:	a3 f8 1b 00 00       	mov    %eax,0x1bf8
    183f:	c7 05 fc 1b 00 00 00 	movl   $0x0,0x1bfc
    1846:	00 00 00 
    1849:	8b 45 f0             	mov    -0x10(%ebp),%eax
    184c:	8b 00                	mov    (%eax),%eax
    184e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1851:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1854:	8b 40 04             	mov    0x4(%eax),%eax
    1857:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    185a:	72 4d                	jb     18a9 <malloc+0xa6>
    185c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    185f:	8b 40 04             	mov    0x4(%eax),%eax
    1862:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1865:	75 0c                	jne    1873 <malloc+0x70>
    1867:	8b 45 ec             	mov    -0x14(%ebp),%eax
    186a:	8b 10                	mov    (%eax),%edx
    186c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    186f:	89 10                	mov    %edx,(%eax)
    1871:	eb 26                	jmp    1899 <malloc+0x96>
    1873:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1876:	8b 40 04             	mov    0x4(%eax),%eax
    1879:	89 c2                	mov    %eax,%edx
    187b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    187e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1881:	89 50 04             	mov    %edx,0x4(%eax)
    1884:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1887:	8b 40 04             	mov    0x4(%eax),%eax
    188a:	c1 e0 03             	shl    $0x3,%eax
    188d:	01 45 ec             	add    %eax,-0x14(%ebp)
    1890:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1893:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1896:	89 50 04             	mov    %edx,0x4(%eax)
    1899:	8b 45 f0             	mov    -0x10(%ebp),%eax
    189c:	a3 00 1c 00 00       	mov    %eax,0x1c00
    18a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18a4:	83 c0 08             	add    $0x8,%eax
    18a7:	eb 38                	jmp    18e1 <malloc+0xde>
    18a9:	a1 00 1c 00 00       	mov    0x1c00,%eax
    18ae:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    18b1:	75 1b                	jne    18ce <malloc+0xcb>
    18b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b6:	89 04 24             	mov    %eax,(%esp)
    18b9:	e8 ed fe ff ff       	call   17ab <morecore>
    18be:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18c5:	75 07                	jne    18ce <malloc+0xcb>
    18c7:	b8 00 00 00 00       	mov    $0x0,%eax
    18cc:	eb 13                	jmp    18e1 <malloc+0xde>
    18ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18d7:	8b 00                	mov    (%eax),%eax
    18d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18dc:	e9 70 ff ff ff       	jmp    1851 <malloc+0x4e>
    18e1:	c9                   	leave  
    18e2:	c3                   	ret    
    18e3:	90                   	nop

000018e4 <xchg>:
    18e4:	55                   	push   %ebp
    18e5:	89 e5                	mov    %esp,%ebp
    18e7:	83 ec 10             	sub    $0x10,%esp
    18ea:	8b 55 08             	mov    0x8(%ebp),%edx
    18ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    18f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18f3:	f0 87 02             	lock xchg %eax,(%edx)
    18f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18fc:	c9                   	leave  
    18fd:	c3                   	ret    

000018fe <lock_init>:
    18fe:	55                   	push   %ebp
    18ff:	89 e5                	mov    %esp,%ebp
    1901:	8b 45 08             	mov    0x8(%ebp),%eax
    1904:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    190a:	5d                   	pop    %ebp
    190b:	c3                   	ret    

0000190c <lock_acquire>:
    190c:	55                   	push   %ebp
    190d:	89 e5                	mov    %esp,%ebp
    190f:	83 ec 08             	sub    $0x8,%esp
    1912:	8b 45 08             	mov    0x8(%ebp),%eax
    1915:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    191c:	00 
    191d:	89 04 24             	mov    %eax,(%esp)
    1920:	e8 bf ff ff ff       	call   18e4 <xchg>
    1925:	85 c0                	test   %eax,%eax
    1927:	75 e9                	jne    1912 <lock_acquire+0x6>
    1929:	c9                   	leave  
    192a:	c3                   	ret    

0000192b <lock_release>:
    192b:	55                   	push   %ebp
    192c:	89 e5                	mov    %esp,%ebp
    192e:	83 ec 08             	sub    $0x8,%esp
    1931:	8b 45 08             	mov    0x8(%ebp),%eax
    1934:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    193b:	00 
    193c:	89 04 24             	mov    %eax,(%esp)
    193f:	e8 a0 ff ff ff       	call   18e4 <xchg>
    1944:	c9                   	leave  
    1945:	c3                   	ret    

00001946 <thread_create>:
    1946:	55                   	push   %ebp
    1947:	89 e5                	mov    %esp,%ebp
    1949:	83 ec 28             	sub    $0x28,%esp
    194c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1953:	e8 ab fe ff ff       	call   1803 <malloc>
    1958:	89 45 f0             	mov    %eax,-0x10(%ebp)
    195b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    195e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1961:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1964:	25 ff 0f 00 00       	and    $0xfff,%eax
    1969:	85 c0                	test   %eax,%eax
    196b:	74 15                	je     1982 <thread_create+0x3c>
    196d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1970:	89 c2                	mov    %eax,%edx
    1972:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1978:	b8 00 10 00 00       	mov    $0x1000,%eax
    197d:	29 d0                	sub    %edx,%eax
    197f:	01 45 f0             	add    %eax,-0x10(%ebp)
    1982:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1986:	75 1b                	jne    19a3 <thread_create+0x5d>
    1988:	c7 44 24 04 ac 1b 00 	movl   $0x1bac,0x4(%esp)
    198f:	00 
    1990:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1997:	e8 81 fb ff ff       	call   151d <printf>
    199c:	b8 00 00 00 00       	mov    $0x0,%eax
    19a1:	eb 6f                	jmp    1a12 <thread_create+0xcc>
    19a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    19a6:	8b 55 08             	mov    0x8(%ebp),%edx
    19a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19ac:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    19b0:	89 54 24 08          	mov    %edx,0x8(%esp)
    19b4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    19bb:	00 
    19bc:	89 04 24             	mov    %eax,(%esp)
    19bf:	e8 58 fa ff ff       	call   141c <clone>
    19c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19cb:	79 1b                	jns    19e8 <thread_create+0xa2>
    19cd:	c7 44 24 04 ba 1b 00 	movl   $0x1bba,0x4(%esp)
    19d4:	00 
    19d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19dc:	e8 3c fb ff ff       	call   151d <printf>
    19e1:	b8 00 00 00 00       	mov    $0x0,%eax
    19e6:	eb 2a                	jmp    1a12 <thread_create+0xcc>
    19e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19ec:	7e 05                	jle    19f3 <thread_create+0xad>
    19ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f1:	eb 1f                	jmp    1a12 <thread_create+0xcc>
    19f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19f7:	75 14                	jne    1a0d <thread_create+0xc7>
    19f9:	c7 44 24 04 c7 1b 00 	movl   $0x1bc7,0x4(%esp)
    1a00:	00 
    1a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a08:	e8 10 fb ff ff       	call   151d <printf>
    1a0d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a12:	c9                   	leave  
    1a13:	c3                   	ret    

00001a14 <random>:
    1a14:	55                   	push   %ebp
    1a15:	89 e5                	mov    %esp,%ebp
    1a17:	a1 f4 1b 00 00       	mov    0x1bf4,%eax
    1a1c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a22:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a27:	a3 f4 1b 00 00       	mov    %eax,0x1bf4
    1a2c:	a1 f4 1b 00 00       	mov    0x1bf4,%eax
    1a31:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a34:	ba 00 00 00 00       	mov    $0x0,%edx
    1a39:	f7 f1                	div    %ecx
    1a3b:	89 d0                	mov    %edx,%eax
    1a3d:	5d                   	pop    %ebp
    1a3e:	c3                   	ret    
    1a3f:	90                   	nop

00001a40 <init_q>:
    1a40:	55                   	push   %ebp
    1a41:	89 e5                	mov    %esp,%ebp
    1a43:	8b 45 08             	mov    0x8(%ebp),%eax
    1a46:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1a56:	8b 45 08             	mov    0x8(%ebp),%eax
    1a59:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1a60:	5d                   	pop    %ebp
    1a61:	c3                   	ret    

00001a62 <add_q>:
    1a62:	55                   	push   %ebp
    1a63:	89 e5                	mov    %esp,%ebp
    1a65:	83 ec 28             	sub    $0x28,%esp
    1a68:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a6f:	e8 8f fd ff ff       	call   1803 <malloc>
    1a74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a84:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a87:	89 10                	mov    %edx,(%eax)
    1a89:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8c:	8b 40 04             	mov    0x4(%eax),%eax
    1a8f:	85 c0                	test   %eax,%eax
    1a91:	75 0b                	jne    1a9e <add_q+0x3c>
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a99:	89 50 04             	mov    %edx,0x4(%eax)
    1a9c:	eb 0c                	jmp    1aaa <add_q+0x48>
    1a9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa1:	8b 40 08             	mov    0x8(%eax),%eax
    1aa4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1aa7:	89 50 04             	mov    %edx,0x4(%eax)
    1aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    1aad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ab0:	89 50 08             	mov    %edx,0x8(%eax)
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	8b 00                	mov    (%eax),%eax
    1ab8:	8d 50 01             	lea    0x1(%eax),%edx
    1abb:	8b 45 08             	mov    0x8(%ebp),%eax
    1abe:	89 10                	mov    %edx,(%eax)
    1ac0:	c9                   	leave  
    1ac1:	c3                   	ret    

00001ac2 <empty_q>:
    1ac2:	55                   	push   %ebp
    1ac3:	89 e5                	mov    %esp,%ebp
    1ac5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac8:	8b 00                	mov    (%eax),%eax
    1aca:	85 c0                	test   %eax,%eax
    1acc:	75 07                	jne    1ad5 <empty_q+0x13>
    1ace:	b8 01 00 00 00       	mov    $0x1,%eax
    1ad3:	eb 05                	jmp    1ada <empty_q+0x18>
    1ad5:	b8 00 00 00 00       	mov    $0x0,%eax
    1ada:	5d                   	pop    %ebp
    1adb:	c3                   	ret    

00001adc <pop_q>:
    1adc:	55                   	push   %ebp
    1add:	89 e5                	mov    %esp,%ebp
    1adf:	83 ec 28             	sub    $0x28,%esp
    1ae2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae5:	89 04 24             	mov    %eax,(%esp)
    1ae8:	e8 d5 ff ff ff       	call   1ac2 <empty_q>
    1aed:	85 c0                	test   %eax,%eax
    1aef:	75 5d                	jne    1b4e <pop_q+0x72>
    1af1:	8b 45 08             	mov    0x8(%ebp),%eax
    1af4:	8b 40 04             	mov    0x4(%eax),%eax
    1af7:	8b 00                	mov    (%eax),%eax
    1af9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1afc:	8b 45 08             	mov    0x8(%ebp),%eax
    1aff:	8b 40 04             	mov    0x4(%eax),%eax
    1b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b05:	8b 45 08             	mov    0x8(%ebp),%eax
    1b08:	8b 40 04             	mov    0x4(%eax),%eax
    1b0b:	8b 50 04             	mov    0x4(%eax),%edx
    1b0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b11:	89 50 04             	mov    %edx,0x4(%eax)
    1b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b17:	89 04 24             	mov    %eax,(%esp)
    1b1a:	e8 b5 fb ff ff       	call   16d4 <free>
    1b1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b22:	8b 00                	mov    (%eax),%eax
    1b24:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b27:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2a:	89 10                	mov    %edx,(%eax)
    1b2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2f:	8b 00                	mov    (%eax),%eax
    1b31:	85 c0                	test   %eax,%eax
    1b33:	75 14                	jne    1b49 <pop_q+0x6d>
    1b35:	8b 45 08             	mov    0x8(%ebp),%eax
    1b38:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1b3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b42:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b4c:	eb 05                	jmp    1b53 <pop_q+0x77>
    1b4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1b53:	c9                   	leave  
    1b54:	c3                   	ret    
