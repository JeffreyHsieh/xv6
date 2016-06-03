
_ln:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
    1009:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    100d:	74 19                	je     1028 <main+0x28>
    100f:	c7 44 24 04 b9 1a 00 	movl   $0x1ab9,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 5e 04 00 00       	call   1481 <printf>
    1023:	e8 b8 02 00 00       	call   12e0 <exit>
    1028:	8b 45 0c             	mov    0xc(%ebp),%eax
    102b:	83 c0 08             	add    $0x8,%eax
    102e:	8b 10                	mov    (%eax),%edx
    1030:	8b 45 0c             	mov    0xc(%ebp),%eax
    1033:	83 c0 04             	add    $0x4,%eax
    1036:	8b 00                	mov    (%eax),%eax
    1038:	89 54 24 04          	mov    %edx,0x4(%esp)
    103c:	89 04 24             	mov    %eax,(%esp)
    103f:	e8 fc 02 00 00       	call   1340 <link>
    1044:	85 c0                	test   %eax,%eax
    1046:	79 2c                	jns    1074 <main+0x74>
    1048:	8b 45 0c             	mov    0xc(%ebp),%eax
    104b:	83 c0 08             	add    $0x8,%eax
    104e:	8b 10                	mov    (%eax),%edx
    1050:	8b 45 0c             	mov    0xc(%ebp),%eax
    1053:	83 c0 04             	add    $0x4,%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	89 54 24 0c          	mov    %edx,0xc(%esp)
    105c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1060:	c7 44 24 04 cc 1a 00 	movl   $0x1acc,0x4(%esp)
    1067:	00 
    1068:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    106f:	e8 0d 04 00 00       	call   1481 <printf>
    1074:	e8 67 02 00 00       	call   12e0 <exit>
    1079:	90                   	nop
    107a:	90                   	nop
    107b:	90                   	nop

0000107c <stosb>:
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	57                   	push   %edi
    1080:	53                   	push   %ebx
    1081:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1084:	8b 55 10             	mov    0x10(%ebp),%edx
    1087:	8b 45 0c             	mov    0xc(%ebp),%eax
    108a:	89 cb                	mov    %ecx,%ebx
    108c:	89 df                	mov    %ebx,%edi
    108e:	89 d1                	mov    %edx,%ecx
    1090:	fc                   	cld    
    1091:	f3 aa                	rep stos %al,%es:(%edi)
    1093:	89 ca                	mov    %ecx,%edx
    1095:	89 fb                	mov    %edi,%ebx
    1097:	89 5d 08             	mov    %ebx,0x8(%ebp)
    109a:	89 55 10             	mov    %edx,0x10(%ebp)
    109d:	5b                   	pop    %ebx
    109e:	5f                   	pop    %edi
    109f:	5d                   	pop    %ebp
    10a0:	c3                   	ret    

000010a1 <strcpy>:
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	83 ec 10             	sub    $0x10,%esp
    10a7:	8b 45 08             	mov    0x8(%ebp),%eax
    10aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    10ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b0:	0f b6 10             	movzbl (%eax),%edx
    10b3:	8b 45 08             	mov    0x8(%ebp),%eax
    10b6:	88 10                	mov    %dl,(%eax)
    10b8:	8b 45 08             	mov    0x8(%ebp),%eax
    10bb:	0f b6 00             	movzbl (%eax),%eax
    10be:	84 c0                	test   %al,%al
    10c0:	0f 95 c0             	setne  %al
    10c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10cb:	84 c0                	test   %al,%al
    10cd:	75 de                	jne    10ad <strcpy+0xc>
    10cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10d2:	c9                   	leave  
    10d3:	c3                   	ret    

000010d4 <strcmp>:
    10d4:	55                   	push   %ebp
    10d5:	89 e5                	mov    %esp,%ebp
    10d7:	eb 08                	jmp    10e1 <strcmp+0xd>
    10d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10dd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10e1:	8b 45 08             	mov    0x8(%ebp),%eax
    10e4:	0f b6 00             	movzbl (%eax),%eax
    10e7:	84 c0                	test   %al,%al
    10e9:	74 10                	je     10fb <strcmp+0x27>
    10eb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ee:	0f b6 10             	movzbl (%eax),%edx
    10f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f4:	0f b6 00             	movzbl (%eax),%eax
    10f7:	38 c2                	cmp    %al,%dl
    10f9:	74 de                	je     10d9 <strcmp+0x5>
    10fb:	8b 45 08             	mov    0x8(%ebp),%eax
    10fe:	0f b6 00             	movzbl (%eax),%eax
    1101:	0f b6 d0             	movzbl %al,%edx
    1104:	8b 45 0c             	mov    0xc(%ebp),%eax
    1107:	0f b6 00             	movzbl (%eax),%eax
    110a:	0f b6 c0             	movzbl %al,%eax
    110d:	89 d1                	mov    %edx,%ecx
    110f:	29 c1                	sub    %eax,%ecx
    1111:	89 c8                	mov    %ecx,%eax
    1113:	5d                   	pop    %ebp
    1114:	c3                   	ret    

00001115 <strlen>:
    1115:	55                   	push   %ebp
    1116:	89 e5                	mov    %esp,%ebp
    1118:	83 ec 10             	sub    $0x10,%esp
    111b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1122:	eb 04                	jmp    1128 <strlen+0x13>
    1124:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1128:	8b 45 fc             	mov    -0x4(%ebp),%eax
    112b:	03 45 08             	add    0x8(%ebp),%eax
    112e:	0f b6 00             	movzbl (%eax),%eax
    1131:	84 c0                	test   %al,%al
    1133:	75 ef                	jne    1124 <strlen+0xf>
    1135:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1138:	c9                   	leave  
    1139:	c3                   	ret    

0000113a <memset>:
    113a:	55                   	push   %ebp
    113b:	89 e5                	mov    %esp,%ebp
    113d:	83 ec 0c             	sub    $0xc,%esp
    1140:	8b 45 10             	mov    0x10(%ebp),%eax
    1143:	89 44 24 08          	mov    %eax,0x8(%esp)
    1147:	8b 45 0c             	mov    0xc(%ebp),%eax
    114a:	89 44 24 04          	mov    %eax,0x4(%esp)
    114e:	8b 45 08             	mov    0x8(%ebp),%eax
    1151:	89 04 24             	mov    %eax,(%esp)
    1154:	e8 23 ff ff ff       	call   107c <stosb>
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	c9                   	leave  
    115d:	c3                   	ret    

0000115e <strchr>:
    115e:	55                   	push   %ebp
    115f:	89 e5                	mov    %esp,%ebp
    1161:	83 ec 04             	sub    $0x4,%esp
    1164:	8b 45 0c             	mov    0xc(%ebp),%eax
    1167:	88 45 fc             	mov    %al,-0x4(%ebp)
    116a:	eb 14                	jmp    1180 <strchr+0x22>
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	0f b6 00             	movzbl (%eax),%eax
    1172:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1175:	75 05                	jne    117c <strchr+0x1e>
    1177:	8b 45 08             	mov    0x8(%ebp),%eax
    117a:	eb 13                	jmp    118f <strchr+0x31>
    117c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1180:	8b 45 08             	mov    0x8(%ebp),%eax
    1183:	0f b6 00             	movzbl (%eax),%eax
    1186:	84 c0                	test   %al,%al
    1188:	75 e2                	jne    116c <strchr+0xe>
    118a:	b8 00 00 00 00       	mov    $0x0,%eax
    118f:	c9                   	leave  
    1190:	c3                   	ret    

00001191 <gets>:
    1191:	55                   	push   %ebp
    1192:	89 e5                	mov    %esp,%ebp
    1194:	83 ec 28             	sub    $0x28,%esp
    1197:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    119e:	eb 44                	jmp    11e4 <gets+0x53>
    11a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11a7:	00 
    11a8:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    11af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11b6:	e8 3d 01 00 00       	call   12f8 <read>
    11bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    11be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11c2:	7e 2d                	jle    11f1 <gets+0x60>
    11c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11c7:	03 45 08             	add    0x8(%ebp),%eax
    11ca:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11ce:	88 10                	mov    %dl,(%eax)
    11d0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d8:	3c 0a                	cmp    $0xa,%al
    11da:	74 16                	je     11f2 <gets+0x61>
    11dc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e0:	3c 0d                	cmp    $0xd,%al
    11e2:	74 0e                	je     11f2 <gets+0x61>
    11e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e7:	83 c0 01             	add    $0x1,%eax
    11ea:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11ed:	7c b1                	jl     11a0 <gets+0xf>
    11ef:	eb 01                	jmp    11f2 <gets+0x61>
    11f1:	90                   	nop
    11f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f5:	03 45 08             	add    0x8(%ebp),%eax
    11f8:	c6 00 00             	movb   $0x0,(%eax)
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	c9                   	leave  
    11ff:	c3                   	ret    

00001200 <stat>:
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	83 ec 28             	sub    $0x28,%esp
    1206:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    120d:	00 
    120e:	8b 45 08             	mov    0x8(%ebp),%eax
    1211:	89 04 24             	mov    %eax,(%esp)
    1214:	e8 07 01 00 00       	call   1320 <open>
    1219:	89 45 f0             	mov    %eax,-0x10(%ebp)
    121c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1220:	79 07                	jns    1229 <stat+0x29>
    1222:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1227:	eb 23                	jmp    124c <stat+0x4c>
    1229:	8b 45 0c             	mov    0xc(%ebp),%eax
    122c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1230:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1233:	89 04 24             	mov    %eax,(%esp)
    1236:	e8 fd 00 00 00       	call   1338 <fstat>
    123b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    123e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1241:	89 04 24             	mov    %eax,(%esp)
    1244:	e8 bf 00 00 00       	call   1308 <close>
    1249:	8b 45 f4             	mov    -0xc(%ebp),%eax
    124c:	c9                   	leave  
    124d:	c3                   	ret    

0000124e <atoi>:
    124e:	55                   	push   %ebp
    124f:	89 e5                	mov    %esp,%ebp
    1251:	83 ec 10             	sub    $0x10,%esp
    1254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    125b:	eb 24                	jmp    1281 <atoi+0x33>
    125d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1260:	89 d0                	mov    %edx,%eax
    1262:	c1 e0 02             	shl    $0x2,%eax
    1265:	01 d0                	add    %edx,%eax
    1267:	01 c0                	add    %eax,%eax
    1269:	89 c2                	mov    %eax,%edx
    126b:	8b 45 08             	mov    0x8(%ebp),%eax
    126e:	0f b6 00             	movzbl (%eax),%eax
    1271:	0f be c0             	movsbl %al,%eax
    1274:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1277:	83 e8 30             	sub    $0x30,%eax
    127a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    127d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	0f b6 00             	movzbl (%eax),%eax
    1287:	3c 2f                	cmp    $0x2f,%al
    1289:	7e 0a                	jle    1295 <atoi+0x47>
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	0f b6 00             	movzbl (%eax),%eax
    1291:	3c 39                	cmp    $0x39,%al
    1293:	7e c8                	jle    125d <atoi+0xf>
    1295:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1298:	c9                   	leave  
    1299:	c3                   	ret    

0000129a <memmove>:
    129a:	55                   	push   %ebp
    129b:	89 e5                	mov    %esp,%ebp
    129d:	83 ec 10             	sub    $0x10,%esp
    12a0:	8b 45 08             	mov    0x8(%ebp),%eax
    12a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12ac:	eb 13                	jmp    12c1 <memmove+0x27>
    12ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b1:	0f b6 10             	movzbl (%eax),%edx
    12b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12b7:	88 10                	mov    %dl,(%eax)
    12b9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12bd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12c5:	0f 9f c0             	setg   %al
    12c8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12cc:	84 c0                	test   %al,%al
    12ce:	75 de                	jne    12ae <memmove+0x14>
    12d0:	8b 45 08             	mov    0x8(%ebp),%eax
    12d3:	c9                   	leave  
    12d4:	c3                   	ret    
    12d5:	90                   	nop
    12d6:	90                   	nop
    12d7:	90                   	nop

000012d8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12d8:	b8 01 00 00 00       	mov    $0x1,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <exit>:
SYSCALL(exit)
    12e0:	b8 02 00 00 00       	mov    $0x2,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <wait>:
SYSCALL(wait)
    12e8:	b8 03 00 00 00       	mov    $0x3,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <pipe>:
SYSCALL(pipe)
    12f0:	b8 04 00 00 00       	mov    $0x4,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <read>:
SYSCALL(read)
    12f8:	b8 05 00 00 00       	mov    $0x5,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <write>:
SYSCALL(write)
    1300:	b8 10 00 00 00       	mov    $0x10,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <close>:
SYSCALL(close)
    1308:	b8 15 00 00 00       	mov    $0x15,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <kill>:
SYSCALL(kill)
    1310:	b8 06 00 00 00       	mov    $0x6,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <exec>:
SYSCALL(exec)
    1318:	b8 07 00 00 00       	mov    $0x7,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <open>:
SYSCALL(open)
    1320:	b8 0f 00 00 00       	mov    $0xf,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <mknod>:
SYSCALL(mknod)
    1328:	b8 11 00 00 00       	mov    $0x11,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <unlink>:
SYSCALL(unlink)
    1330:	b8 12 00 00 00       	mov    $0x12,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <fstat>:
SYSCALL(fstat)
    1338:	b8 08 00 00 00       	mov    $0x8,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <link>:
SYSCALL(link)
    1340:	b8 13 00 00 00       	mov    $0x13,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <mkdir>:
SYSCALL(mkdir)
    1348:	b8 14 00 00 00       	mov    $0x14,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <chdir>:
SYSCALL(chdir)
    1350:	b8 09 00 00 00       	mov    $0x9,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <dup>:
SYSCALL(dup)
    1358:	b8 0a 00 00 00       	mov    $0xa,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <getpid>:
SYSCALL(getpid)
    1360:	b8 0b 00 00 00       	mov    $0xb,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <sbrk>:
SYSCALL(sbrk)
    1368:	b8 0c 00 00 00       	mov    $0xc,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <sleep>:
SYSCALL(sleep)
    1370:	b8 0d 00 00 00       	mov    $0xd,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <uptime>:
SYSCALL(uptime)
    1378:	b8 0e 00 00 00       	mov    $0xe,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <clone>:
SYSCALL(clone)
    1380:	b8 16 00 00 00       	mov    $0x16,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <texit>:
SYSCALL(texit)
    1388:	b8 17 00 00 00       	mov    $0x17,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <tsleep>:
SYSCALL(tsleep)
    1390:	b8 18 00 00 00       	mov    $0x18,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <twakeup>:
SYSCALL(twakeup)
    1398:	b8 19 00 00 00       	mov    $0x19,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <thread_yield>:
SYSCALL(thread_yield)
    13a0:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <putc>:
    13a8:	55                   	push   %ebp
    13a9:	89 e5                	mov    %esp,%ebp
    13ab:	83 ec 28             	sub    $0x28,%esp
    13ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b1:	88 45 f4             	mov    %al,-0xc(%ebp)
    13b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13bb:	00 
    13bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13bf:	89 44 24 04          	mov    %eax,0x4(%esp)
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	89 04 24             	mov    %eax,(%esp)
    13c9:	e8 32 ff ff ff       	call   1300 <write>
    13ce:	c9                   	leave  
    13cf:	c3                   	ret    

000013d0 <printint>:
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	53                   	push   %ebx
    13d4:	83 ec 44             	sub    $0x44,%esp
    13d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13de:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13e2:	74 17                	je     13fb <printint+0x2b>
    13e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13e8:	79 11                	jns    13fb <printint+0x2b>
    13ea:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    13f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f4:	f7 d8                	neg    %eax
    13f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13f9:	eb 06                	jmp    1401 <printint+0x31>
    13fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1401:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1408:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    140b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    140e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1411:	ba 00 00 00 00       	mov    $0x0,%edx
    1416:	f7 f3                	div    %ebx
    1418:	89 d0                	mov    %edx,%eax
    141a:	0f b6 80 14 1b 00 00 	movzbl 0x1b14(%eax),%eax
    1421:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1425:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1429:	8b 45 10             	mov    0x10(%ebp),%eax
    142c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    142f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1432:	ba 00 00 00 00       	mov    $0x0,%edx
    1437:	f7 75 d4             	divl   -0x2c(%ebp)
    143a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    143d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1441:	75 c5                	jne    1408 <printint+0x38>
    1443:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1447:	74 28                	je     1471 <printint+0xa1>
    1449:	8b 45 ec             	mov    -0x14(%ebp),%eax
    144c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1451:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1455:	eb 1a                	jmp    1471 <printint+0xa1>
    1457:	8b 45 ec             	mov    -0x14(%ebp),%eax
    145a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    145f:	0f be c0             	movsbl %al,%eax
    1462:	89 44 24 04          	mov    %eax,0x4(%esp)
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	89 04 24             	mov    %eax,(%esp)
    146c:	e8 37 ff ff ff       	call   13a8 <putc>
    1471:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1475:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1479:	79 dc                	jns    1457 <printint+0x87>
    147b:	83 c4 44             	add    $0x44,%esp
    147e:	5b                   	pop    %ebx
    147f:	5d                   	pop    %ebp
    1480:	c3                   	ret    

00001481 <printf>:
    1481:	55                   	push   %ebp
    1482:	89 e5                	mov    %esp,%ebp
    1484:	83 ec 38             	sub    $0x38,%esp
    1487:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    148e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1491:	83 c0 04             	add    $0x4,%eax
    1494:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1497:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    149e:	e9 7e 01 00 00       	jmp    1621 <printf+0x1a0>
    14a3:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14a9:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14ac:	0f b6 00             	movzbl (%eax),%eax
    14af:	0f be c0             	movsbl %al,%eax
    14b2:	25 ff 00 00 00       	and    $0xff,%eax
    14b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14be:	75 2c                	jne    14ec <printf+0x6b>
    14c0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14c4:	75 0c                	jne    14d2 <printf+0x51>
    14c6:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14cd:	e9 4b 01 00 00       	jmp    161d <printf+0x19c>
    14d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14d5:	0f be c0             	movsbl %al,%eax
    14d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14dc:	8b 45 08             	mov    0x8(%ebp),%eax
    14df:	89 04 24             	mov    %eax,(%esp)
    14e2:	e8 c1 fe ff ff       	call   13a8 <putc>
    14e7:	e9 31 01 00 00       	jmp    161d <printf+0x19c>
    14ec:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14f0:	0f 85 27 01 00 00    	jne    161d <printf+0x19c>
    14f6:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14fa:	75 2d                	jne    1529 <printf+0xa8>
    14fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ff:	8b 00                	mov    (%eax),%eax
    1501:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1508:	00 
    1509:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1510:	00 
    1511:	89 44 24 04          	mov    %eax,0x4(%esp)
    1515:	8b 45 08             	mov    0x8(%ebp),%eax
    1518:	89 04 24             	mov    %eax,(%esp)
    151b:	e8 b0 fe ff ff       	call   13d0 <printint>
    1520:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1524:	e9 ed 00 00 00       	jmp    1616 <printf+0x195>
    1529:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    152d:	74 06                	je     1535 <printf+0xb4>
    152f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1533:	75 2d                	jne    1562 <printf+0xe1>
    1535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1538:	8b 00                	mov    (%eax),%eax
    153a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1541:	00 
    1542:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1549:	00 
    154a:	89 44 24 04          	mov    %eax,0x4(%esp)
    154e:	8b 45 08             	mov    0x8(%ebp),%eax
    1551:	89 04 24             	mov    %eax,(%esp)
    1554:	e8 77 fe ff ff       	call   13d0 <printint>
    1559:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    155d:	e9 b4 00 00 00       	jmp    1616 <printf+0x195>
    1562:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1566:	75 46                	jne    15ae <printf+0x12d>
    1568:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156b:	8b 00                	mov    (%eax),%eax
    156d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1570:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1574:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1578:	75 27                	jne    15a1 <printf+0x120>
    157a:	c7 45 e4 e0 1a 00 00 	movl   $0x1ae0,-0x1c(%ebp)
    1581:	eb 1f                	jmp    15a2 <printf+0x121>
    1583:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1586:	0f b6 00             	movzbl (%eax),%eax
    1589:	0f be c0             	movsbl %al,%eax
    158c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1590:	8b 45 08             	mov    0x8(%ebp),%eax
    1593:	89 04 24             	mov    %eax,(%esp)
    1596:	e8 0d fe ff ff       	call   13a8 <putc>
    159b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    159f:	eb 01                	jmp    15a2 <printf+0x121>
    15a1:	90                   	nop
    15a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15a5:	0f b6 00             	movzbl (%eax),%eax
    15a8:	84 c0                	test   %al,%al
    15aa:	75 d7                	jne    1583 <printf+0x102>
    15ac:	eb 68                	jmp    1616 <printf+0x195>
    15ae:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15b2:	75 1d                	jne    15d1 <printf+0x150>
    15b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b7:	8b 00                	mov    (%eax),%eax
    15b9:	0f be c0             	movsbl %al,%eax
    15bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c0:	8b 45 08             	mov    0x8(%ebp),%eax
    15c3:	89 04 24             	mov    %eax,(%esp)
    15c6:	e8 dd fd ff ff       	call   13a8 <putc>
    15cb:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15cf:	eb 45                	jmp    1616 <printf+0x195>
    15d1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15d5:	75 17                	jne    15ee <printf+0x16d>
    15d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15da:	0f be c0             	movsbl %al,%eax
    15dd:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e1:	8b 45 08             	mov    0x8(%ebp),%eax
    15e4:	89 04 24             	mov    %eax,(%esp)
    15e7:	e8 bc fd ff ff       	call   13a8 <putc>
    15ec:	eb 28                	jmp    1616 <printf+0x195>
    15ee:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15f5:	00 
    15f6:	8b 45 08             	mov    0x8(%ebp),%eax
    15f9:	89 04 24             	mov    %eax,(%esp)
    15fc:	e8 a7 fd ff ff       	call   13a8 <putc>
    1601:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1604:	0f be c0             	movsbl %al,%eax
    1607:	89 44 24 04          	mov    %eax,0x4(%esp)
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	89 04 24             	mov    %eax,(%esp)
    1611:	e8 92 fd ff ff       	call   13a8 <putc>
    1616:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    161d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1621:	8b 55 0c             	mov    0xc(%ebp),%edx
    1624:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1627:	8d 04 02             	lea    (%edx,%eax,1),%eax
    162a:	0f b6 00             	movzbl (%eax),%eax
    162d:	84 c0                	test   %al,%al
    162f:	0f 85 6e fe ff ff    	jne    14a3 <printf+0x22>
    1635:	c9                   	leave  
    1636:	c3                   	ret    
    1637:	90                   	nop

00001638 <free>:
    1638:	55                   	push   %ebp
    1639:	89 e5                	mov    %esp,%ebp
    163b:	83 ec 10             	sub    $0x10,%esp
    163e:	8b 45 08             	mov    0x8(%ebp),%eax
    1641:	83 e8 08             	sub    $0x8,%eax
    1644:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1647:	a1 34 1b 00 00       	mov    0x1b34,%eax
    164c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    164f:	eb 24                	jmp    1675 <free+0x3d>
    1651:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1654:	8b 00                	mov    (%eax),%eax
    1656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1659:	77 12                	ja     166d <free+0x35>
    165b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1661:	77 24                	ja     1687 <free+0x4f>
    1663:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1666:	8b 00                	mov    (%eax),%eax
    1668:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    166b:	77 1a                	ja     1687 <free+0x4f>
    166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1675:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1678:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    167b:	76 d4                	jbe    1651 <free+0x19>
    167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1685:	76 ca                	jbe    1651 <free+0x19>
    1687:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168a:	8b 40 04             	mov    0x4(%eax),%eax
    168d:	c1 e0 03             	shl    $0x3,%eax
    1690:	89 c2                	mov    %eax,%edx
    1692:	03 55 f8             	add    -0x8(%ebp),%edx
    1695:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1698:	8b 00                	mov    (%eax),%eax
    169a:	39 c2                	cmp    %eax,%edx
    169c:	75 24                	jne    16c2 <free+0x8a>
    169e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a1:	8b 50 04             	mov    0x4(%eax),%edx
    16a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a7:	8b 00                	mov    (%eax),%eax
    16a9:	8b 40 04             	mov    0x4(%eax),%eax
    16ac:	01 c2                	add    %eax,%edx
    16ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b1:	89 50 04             	mov    %edx,0x4(%eax)
    16b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b7:	8b 00                	mov    (%eax),%eax
    16b9:	8b 10                	mov    (%eax),%edx
    16bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16be:	89 10                	mov    %edx,(%eax)
    16c0:	eb 0a                	jmp    16cc <free+0x94>
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	8b 10                	mov    (%eax),%edx
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	89 10                	mov    %edx,(%eax)
    16cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cf:	8b 40 04             	mov    0x4(%eax),%eax
    16d2:	c1 e0 03             	shl    $0x3,%eax
    16d5:	03 45 fc             	add    -0x4(%ebp),%eax
    16d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16db:	75 20                	jne    16fd <free+0xc5>
    16dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e0:	8b 50 04             	mov    0x4(%eax),%edx
    16e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e6:	8b 40 04             	mov    0x4(%eax),%eax
    16e9:	01 c2                	add    %eax,%edx
    16eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ee:	89 50 04             	mov    %edx,0x4(%eax)
    16f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f4:	8b 10                	mov    (%eax),%edx
    16f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f9:	89 10                	mov    %edx,(%eax)
    16fb:	eb 08                	jmp    1705 <free+0xcd>
    16fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1700:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1703:	89 10                	mov    %edx,(%eax)
    1705:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1708:	a3 34 1b 00 00       	mov    %eax,0x1b34
    170d:	c9                   	leave  
    170e:	c3                   	ret    

0000170f <morecore>:
    170f:	55                   	push   %ebp
    1710:	89 e5                	mov    %esp,%ebp
    1712:	83 ec 28             	sub    $0x28,%esp
    1715:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    171c:	77 07                	ja     1725 <morecore+0x16>
    171e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1725:	8b 45 08             	mov    0x8(%ebp),%eax
    1728:	c1 e0 03             	shl    $0x3,%eax
    172b:	89 04 24             	mov    %eax,(%esp)
    172e:	e8 35 fc ff ff       	call   1368 <sbrk>
    1733:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1736:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    173a:	75 07                	jne    1743 <morecore+0x34>
    173c:	b8 00 00 00 00       	mov    $0x0,%eax
    1741:	eb 22                	jmp    1765 <morecore+0x56>
    1743:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1746:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174c:	8b 55 08             	mov    0x8(%ebp),%edx
    174f:	89 50 04             	mov    %edx,0x4(%eax)
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	83 c0 08             	add    $0x8,%eax
    1758:	89 04 24             	mov    %eax,(%esp)
    175b:	e8 d8 fe ff ff       	call   1638 <free>
    1760:	a1 34 1b 00 00       	mov    0x1b34,%eax
    1765:	c9                   	leave  
    1766:	c3                   	ret    

00001767 <malloc>:
    1767:	55                   	push   %ebp
    1768:	89 e5                	mov    %esp,%ebp
    176a:	83 ec 28             	sub    $0x28,%esp
    176d:	8b 45 08             	mov    0x8(%ebp),%eax
    1770:	83 c0 07             	add    $0x7,%eax
    1773:	c1 e8 03             	shr    $0x3,%eax
    1776:	83 c0 01             	add    $0x1,%eax
    1779:	89 45 f4             	mov    %eax,-0xc(%ebp)
    177c:	a1 34 1b 00 00       	mov    0x1b34,%eax
    1781:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1784:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1788:	75 23                	jne    17ad <malloc+0x46>
    178a:	c7 45 f0 2c 1b 00 00 	movl   $0x1b2c,-0x10(%ebp)
    1791:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1794:	a3 34 1b 00 00       	mov    %eax,0x1b34
    1799:	a1 34 1b 00 00       	mov    0x1b34,%eax
    179e:	a3 2c 1b 00 00       	mov    %eax,0x1b2c
    17a3:	c7 05 30 1b 00 00 00 	movl   $0x0,0x1b30
    17aa:	00 00 00 
    17ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b0:	8b 00                	mov    (%eax),%eax
    17b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b8:	8b 40 04             	mov    0x4(%eax),%eax
    17bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17be:	72 4d                	jb     180d <malloc+0xa6>
    17c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c3:	8b 40 04             	mov    0x4(%eax),%eax
    17c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17c9:	75 0c                	jne    17d7 <malloc+0x70>
    17cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ce:	8b 10                	mov    (%eax),%edx
    17d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d3:	89 10                	mov    %edx,(%eax)
    17d5:	eb 26                	jmp    17fd <malloc+0x96>
    17d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17da:	8b 40 04             	mov    0x4(%eax),%eax
    17dd:	89 c2                	mov    %eax,%edx
    17df:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e5:	89 50 04             	mov    %edx,0x4(%eax)
    17e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17eb:	8b 40 04             	mov    0x4(%eax),%eax
    17ee:	c1 e0 03             	shl    $0x3,%eax
    17f1:	01 45 ec             	add    %eax,-0x14(%ebp)
    17f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17fa:	89 50 04             	mov    %edx,0x4(%eax)
    17fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1800:	a3 34 1b 00 00       	mov    %eax,0x1b34
    1805:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1808:	83 c0 08             	add    $0x8,%eax
    180b:	eb 38                	jmp    1845 <malloc+0xde>
    180d:	a1 34 1b 00 00       	mov    0x1b34,%eax
    1812:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1815:	75 1b                	jne    1832 <malloc+0xcb>
    1817:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181a:	89 04 24             	mov    %eax,(%esp)
    181d:	e8 ed fe ff ff       	call   170f <morecore>
    1822:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1825:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1829:	75 07                	jne    1832 <malloc+0xcb>
    182b:	b8 00 00 00 00       	mov    $0x0,%eax
    1830:	eb 13                	jmp    1845 <malloc+0xde>
    1832:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1835:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1838:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183b:	8b 00                	mov    (%eax),%eax
    183d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1840:	e9 70 ff ff ff       	jmp    17b5 <malloc+0x4e>
    1845:	c9                   	leave  
    1846:	c3                   	ret    
    1847:	90                   	nop

00001848 <xchg>:
    1848:	55                   	push   %ebp
    1849:	89 e5                	mov    %esp,%ebp
    184b:	83 ec 10             	sub    $0x10,%esp
    184e:	8b 55 08             	mov    0x8(%ebp),%edx
    1851:	8b 45 0c             	mov    0xc(%ebp),%eax
    1854:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1857:	f0 87 02             	lock xchg %eax,(%edx)
    185a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    185d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1860:	c9                   	leave  
    1861:	c3                   	ret    

00001862 <lock_init>:
    1862:	55                   	push   %ebp
    1863:	89 e5                	mov    %esp,%ebp
    1865:	8b 45 08             	mov    0x8(%ebp),%eax
    1868:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    186e:	5d                   	pop    %ebp
    186f:	c3                   	ret    

00001870 <lock_acquire>:
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 08             	sub    $0x8,%esp
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1880:	00 
    1881:	89 04 24             	mov    %eax,(%esp)
    1884:	e8 bf ff ff ff       	call   1848 <xchg>
    1889:	85 c0                	test   %eax,%eax
    188b:	75 e9                	jne    1876 <lock_acquire+0x6>
    188d:	c9                   	leave  
    188e:	c3                   	ret    

0000188f <lock_release>:
    188f:	55                   	push   %ebp
    1890:	89 e5                	mov    %esp,%ebp
    1892:	83 ec 08             	sub    $0x8,%esp
    1895:	8b 45 08             	mov    0x8(%ebp),%eax
    1898:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    189f:	00 
    18a0:	89 04 24             	mov    %eax,(%esp)
    18a3:	e8 a0 ff ff ff       	call   1848 <xchg>
    18a8:	c9                   	leave  
    18a9:	c3                   	ret    

000018aa <thread_create>:
    18aa:	55                   	push   %ebp
    18ab:	89 e5                	mov    %esp,%ebp
    18ad:	83 ec 28             	sub    $0x28,%esp
    18b0:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18b7:	e8 ab fe ff ff       	call   1767 <malloc>
    18bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c8:	25 ff 0f 00 00       	and    $0xfff,%eax
    18cd:	85 c0                	test   %eax,%eax
    18cf:	74 15                	je     18e6 <thread_create+0x3c>
    18d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d4:	89 c2                	mov    %eax,%edx
    18d6:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18dc:	b8 00 10 00 00       	mov    $0x1000,%eax
    18e1:	29 d0                	sub    %edx,%eax
    18e3:	01 45 f0             	add    %eax,-0x10(%ebp)
    18e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18ea:	75 1b                	jne    1907 <thread_create+0x5d>
    18ec:	c7 44 24 04 e7 1a 00 	movl   $0x1ae7,0x4(%esp)
    18f3:	00 
    18f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fb:	e8 81 fb ff ff       	call   1481 <printf>
    1900:	b8 00 00 00 00       	mov    $0x0,%eax
    1905:	eb 6f                	jmp    1976 <thread_create+0xcc>
    1907:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    190a:	8b 55 08             	mov    0x8(%ebp),%edx
    190d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1910:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1914:	89 54 24 08          	mov    %edx,0x8(%esp)
    1918:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    191f:	00 
    1920:	89 04 24             	mov    %eax,(%esp)
    1923:	e8 58 fa ff ff       	call   1380 <clone>
    1928:	89 45 ec             	mov    %eax,-0x14(%ebp)
    192b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    192f:	79 1b                	jns    194c <thread_create+0xa2>
    1931:	c7 44 24 04 f5 1a 00 	movl   $0x1af5,0x4(%esp)
    1938:	00 
    1939:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1940:	e8 3c fb ff ff       	call   1481 <printf>
    1945:	b8 00 00 00 00       	mov    $0x0,%eax
    194a:	eb 2a                	jmp    1976 <thread_create+0xcc>
    194c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1950:	7e 05                	jle    1957 <thread_create+0xad>
    1952:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1955:	eb 1f                	jmp    1976 <thread_create+0xcc>
    1957:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    195b:	75 14                	jne    1971 <thread_create+0xc7>
    195d:	c7 44 24 04 02 1b 00 	movl   $0x1b02,0x4(%esp)
    1964:	00 
    1965:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    196c:	e8 10 fb ff ff       	call   1481 <printf>
    1971:	b8 00 00 00 00       	mov    $0x0,%eax
    1976:	c9                   	leave  
    1977:	c3                   	ret    

00001978 <random>:
    1978:	55                   	push   %ebp
    1979:	89 e5                	mov    %esp,%ebp
    197b:	a1 28 1b 00 00       	mov    0x1b28,%eax
    1980:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1986:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    198b:	a3 28 1b 00 00       	mov    %eax,0x1b28
    1990:	a1 28 1b 00 00       	mov    0x1b28,%eax
    1995:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1998:	ba 00 00 00 00       	mov    $0x0,%edx
    199d:	f7 f1                	div    %ecx
    199f:	89 d0                	mov    %edx,%eax
    19a1:	5d                   	pop    %ebp
    19a2:	c3                   	ret    
    19a3:	90                   	nop

000019a4 <init_q>:
    19a4:	55                   	push   %ebp
    19a5:	89 e5                	mov    %esp,%ebp
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    19b0:	8b 45 08             	mov    0x8(%ebp),%eax
    19b3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19ba:	8b 45 08             	mov    0x8(%ebp),%eax
    19bd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    19c4:	5d                   	pop    %ebp
    19c5:	c3                   	ret    

000019c6 <add_q>:
    19c6:	55                   	push   %ebp
    19c7:	89 e5                	mov    %esp,%ebp
    19c9:	83 ec 28             	sub    $0x28,%esp
    19cc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19d3:	e8 8f fd ff ff       	call   1767 <malloc>
    19d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19de:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19eb:	89 10                	mov    %edx,(%eax)
    19ed:	8b 45 08             	mov    0x8(%ebp),%eax
    19f0:	8b 40 04             	mov    0x4(%eax),%eax
    19f3:	85 c0                	test   %eax,%eax
    19f5:	75 0b                	jne    1a02 <add_q+0x3c>
    19f7:	8b 45 08             	mov    0x8(%ebp),%eax
    19fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19fd:	89 50 04             	mov    %edx,0x4(%eax)
    1a00:	eb 0c                	jmp    1a0e <add_q+0x48>
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	8b 40 08             	mov    0x8(%eax),%eax
    1a08:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0b:	89 50 04             	mov    %edx,0x4(%eax)
    1a0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a11:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a14:	89 50 08             	mov    %edx,0x8(%eax)
    1a17:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1a:	8b 00                	mov    (%eax),%eax
    1a1c:	8d 50 01             	lea    0x1(%eax),%edx
    1a1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a22:	89 10                	mov    %edx,(%eax)
    1a24:	c9                   	leave  
    1a25:	c3                   	ret    

00001a26 <empty_q>:
    1a26:	55                   	push   %ebp
    1a27:	89 e5                	mov    %esp,%ebp
    1a29:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2c:	8b 00                	mov    (%eax),%eax
    1a2e:	85 c0                	test   %eax,%eax
    1a30:	75 07                	jne    1a39 <empty_q+0x13>
    1a32:	b8 01 00 00 00       	mov    $0x1,%eax
    1a37:	eb 05                	jmp    1a3e <empty_q+0x18>
    1a39:	b8 00 00 00 00       	mov    $0x0,%eax
    1a3e:	5d                   	pop    %ebp
    1a3f:	c3                   	ret    

00001a40 <pop_q>:
    1a40:	55                   	push   %ebp
    1a41:	89 e5                	mov    %esp,%ebp
    1a43:	83 ec 28             	sub    $0x28,%esp
    1a46:	8b 45 08             	mov    0x8(%ebp),%eax
    1a49:	89 04 24             	mov    %eax,(%esp)
    1a4c:	e8 d5 ff ff ff       	call   1a26 <empty_q>
    1a51:	85 c0                	test   %eax,%eax
    1a53:	75 5d                	jne    1ab2 <pop_q+0x72>
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	8b 40 04             	mov    0x4(%eax),%eax
    1a5b:	8b 00                	mov    (%eax),%eax
    1a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a60:	8b 45 08             	mov    0x8(%ebp),%eax
    1a63:	8b 40 04             	mov    0x4(%eax),%eax
    1a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8b 40 04             	mov    0x4(%eax),%eax
    1a6f:	8b 50 04             	mov    0x4(%eax),%edx
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	89 50 04             	mov    %edx,0x4(%eax)
    1a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7b:	89 04 24             	mov    %eax,(%esp)
    1a7e:	e8 b5 fb ff ff       	call   1638 <free>
    1a83:	8b 45 08             	mov    0x8(%ebp),%eax
    1a86:	8b 00                	mov    (%eax),%eax
    1a88:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	89 10                	mov    %edx,(%eax)
    1a90:	8b 45 08             	mov    0x8(%ebp),%eax
    1a93:	8b 00                	mov    (%eax),%eax
    1a95:	85 c0                	test   %eax,%eax
    1a97:	75 14                	jne    1aad <pop_q+0x6d>
    1a99:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ab0:	eb 05                	jmp    1ab7 <pop_q+0x77>
    1ab2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ab7:	c9                   	leave  
    1ab8:	c3                   	ret    
