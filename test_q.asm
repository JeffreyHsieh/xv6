
_test_q:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    1009:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    1010:	e8 62 07 00 00       	call   1777 <malloc>
    1015:	89 44 24 18          	mov    %eax,0x18(%esp)
    1019:	8b 44 24 18          	mov    0x18(%esp),%eax
    101d:	89 04 24             	mov    %eax,(%esp)
    1020:	e8 8f 09 00 00       	call   19b4 <init_q>
    1025:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    102c:	00 
    102d:	eb 19                	jmp    1048 <main+0x48>
    102f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1033:	89 44 24 04          	mov    %eax,0x4(%esp)
    1037:	8b 44 24 18          	mov    0x18(%esp),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 93 09 00 00       	call   19d6 <add_q>
    1043:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1048:	83 7c 24 1c 09       	cmpl   $0x9,0x1c(%esp)
    104d:	7e e0                	jle    102f <main+0x2f>
    104f:	eb 24                	jmp    1075 <main+0x75>
    1051:	8b 44 24 18          	mov    0x18(%esp),%eax
    1055:	89 04 24             	mov    %eax,(%esp)
    1058:	e8 f3 09 00 00       	call   1a50 <pop_q>
    105d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1061:	c7 44 24 04 c9 1a 00 	movl   $0x1ac9,0x4(%esp)
    1068:	00 
    1069:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1070:	e8 1c 04 00 00       	call   1491 <printf>
    1075:	8b 44 24 18          	mov    0x18(%esp),%eax
    1079:	89 04 24             	mov    %eax,(%esp)
    107c:	e8 b5 09 00 00       	call   1a36 <empty_q>
    1081:	85 c0                	test   %eax,%eax
    1083:	74 cc                	je     1051 <main+0x51>
    1085:	e8 66 02 00 00       	call   12f0 <exit>
    108a:	90                   	nop
    108b:	90                   	nop

0000108c <stosb>:
    108c:	55                   	push   %ebp
    108d:	89 e5                	mov    %esp,%ebp
    108f:	57                   	push   %edi
    1090:	53                   	push   %ebx
    1091:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1094:	8b 55 10             	mov    0x10(%ebp),%edx
    1097:	8b 45 0c             	mov    0xc(%ebp),%eax
    109a:	89 cb                	mov    %ecx,%ebx
    109c:	89 df                	mov    %ebx,%edi
    109e:	89 d1                	mov    %edx,%ecx
    10a0:	fc                   	cld    
    10a1:	f3 aa                	rep stos %al,%es:(%edi)
    10a3:	89 ca                	mov    %ecx,%edx
    10a5:	89 fb                	mov    %edi,%ebx
    10a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10aa:	89 55 10             	mov    %edx,0x10(%ebp)
    10ad:	5b                   	pop    %ebx
    10ae:	5f                   	pop    %edi
    10af:	5d                   	pop    %ebp
    10b0:	c3                   	ret    

000010b1 <strcpy>:
    10b1:	55                   	push   %ebp
    10b2:	89 e5                	mov    %esp,%ebp
    10b4:	83 ec 10             	sub    $0x10,%esp
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
    10bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c0:	0f b6 10             	movzbl (%eax),%edx
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	88 10                	mov    %dl,(%eax)
    10c8:	8b 45 08             	mov    0x8(%ebp),%eax
    10cb:	0f b6 00             	movzbl (%eax),%eax
    10ce:	84 c0                	test   %al,%al
    10d0:	0f 95 c0             	setne  %al
    10d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10d7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10db:	84 c0                	test   %al,%al
    10dd:	75 de                	jne    10bd <strcpy+0xc>
    10df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10e2:	c9                   	leave  
    10e3:	c3                   	ret    

000010e4 <strcmp>:
    10e4:	55                   	push   %ebp
    10e5:	89 e5                	mov    %esp,%ebp
    10e7:	eb 08                	jmp    10f1 <strcmp+0xd>
    10e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ed:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10f1:	8b 45 08             	mov    0x8(%ebp),%eax
    10f4:	0f b6 00             	movzbl (%eax),%eax
    10f7:	84 c0                	test   %al,%al
    10f9:	74 10                	je     110b <strcmp+0x27>
    10fb:	8b 45 08             	mov    0x8(%ebp),%eax
    10fe:	0f b6 10             	movzbl (%eax),%edx
    1101:	8b 45 0c             	mov    0xc(%ebp),%eax
    1104:	0f b6 00             	movzbl (%eax),%eax
    1107:	38 c2                	cmp    %al,%dl
    1109:	74 de                	je     10e9 <strcmp+0x5>
    110b:	8b 45 08             	mov    0x8(%ebp),%eax
    110e:	0f b6 00             	movzbl (%eax),%eax
    1111:	0f b6 d0             	movzbl %al,%edx
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	0f b6 00             	movzbl (%eax),%eax
    111a:	0f b6 c0             	movzbl %al,%eax
    111d:	89 d1                	mov    %edx,%ecx
    111f:	29 c1                	sub    %eax,%ecx
    1121:	89 c8                	mov    %ecx,%eax
    1123:	5d                   	pop    %ebp
    1124:	c3                   	ret    

00001125 <strlen>:
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
    1128:	83 ec 10             	sub    $0x10,%esp
    112b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1132:	eb 04                	jmp    1138 <strlen+0x13>
    1134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1138:	8b 45 fc             	mov    -0x4(%ebp),%eax
    113b:	03 45 08             	add    0x8(%ebp),%eax
    113e:	0f b6 00             	movzbl (%eax),%eax
    1141:	84 c0                	test   %al,%al
    1143:	75 ef                	jne    1134 <strlen+0xf>
    1145:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1148:	c9                   	leave  
    1149:	c3                   	ret    

0000114a <memset>:
    114a:	55                   	push   %ebp
    114b:	89 e5                	mov    %esp,%ebp
    114d:	83 ec 0c             	sub    $0xc,%esp
    1150:	8b 45 10             	mov    0x10(%ebp),%eax
    1153:	89 44 24 08          	mov    %eax,0x8(%esp)
    1157:	8b 45 0c             	mov    0xc(%ebp),%eax
    115a:	89 44 24 04          	mov    %eax,0x4(%esp)
    115e:	8b 45 08             	mov    0x8(%ebp),%eax
    1161:	89 04 24             	mov    %eax,(%esp)
    1164:	e8 23 ff ff ff       	call   108c <stosb>
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	c9                   	leave  
    116d:	c3                   	ret    

0000116e <strchr>:
    116e:	55                   	push   %ebp
    116f:	89 e5                	mov    %esp,%ebp
    1171:	83 ec 04             	sub    $0x4,%esp
    1174:	8b 45 0c             	mov    0xc(%ebp),%eax
    1177:	88 45 fc             	mov    %al,-0x4(%ebp)
    117a:	eb 14                	jmp    1190 <strchr+0x22>
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	0f b6 00             	movzbl (%eax),%eax
    1182:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1185:	75 05                	jne    118c <strchr+0x1e>
    1187:	8b 45 08             	mov    0x8(%ebp),%eax
    118a:	eb 13                	jmp    119f <strchr+0x31>
    118c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1190:	8b 45 08             	mov    0x8(%ebp),%eax
    1193:	0f b6 00             	movzbl (%eax),%eax
    1196:	84 c0                	test   %al,%al
    1198:	75 e2                	jne    117c <strchr+0xe>
    119a:	b8 00 00 00 00       	mov    $0x0,%eax
    119f:	c9                   	leave  
    11a0:	c3                   	ret    

000011a1 <gets>:
    11a1:	55                   	push   %ebp
    11a2:	89 e5                	mov    %esp,%ebp
    11a4:	83 ec 28             	sub    $0x28,%esp
    11a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11ae:	eb 44                	jmp    11f4 <gets+0x53>
    11b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11b7:	00 
    11b8:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    11bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11c6:	e8 3d 01 00 00       	call   1308 <read>
    11cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    11ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11d2:	7e 2d                	jle    1201 <gets+0x60>
    11d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11d7:	03 45 08             	add    0x8(%ebp),%eax
    11da:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11de:	88 10                	mov    %dl,(%eax)
    11e0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11e4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e8:	3c 0a                	cmp    $0xa,%al
    11ea:	74 16                	je     1202 <gets+0x61>
    11ec:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f0:	3c 0d                	cmp    $0xd,%al
    11f2:	74 0e                	je     1202 <gets+0x61>
    11f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f7:	83 c0 01             	add    $0x1,%eax
    11fa:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11fd:	7c b1                	jl     11b0 <gets+0xf>
    11ff:	eb 01                	jmp    1202 <gets+0x61>
    1201:	90                   	nop
    1202:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1205:	03 45 08             	add    0x8(%ebp),%eax
    1208:	c6 00 00             	movb   $0x0,(%eax)
    120b:	8b 45 08             	mov    0x8(%ebp),%eax
    120e:	c9                   	leave  
    120f:	c3                   	ret    

00001210 <stat>:
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	83 ec 28             	sub    $0x28,%esp
    1216:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    121d:	00 
    121e:	8b 45 08             	mov    0x8(%ebp),%eax
    1221:	89 04 24             	mov    %eax,(%esp)
    1224:	e8 07 01 00 00       	call   1330 <open>
    1229:	89 45 f0             	mov    %eax,-0x10(%ebp)
    122c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1230:	79 07                	jns    1239 <stat+0x29>
    1232:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1237:	eb 23                	jmp    125c <stat+0x4c>
    1239:	8b 45 0c             	mov    0xc(%ebp),%eax
    123c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1240:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1243:	89 04 24             	mov    %eax,(%esp)
    1246:	e8 fd 00 00 00       	call   1348 <fstat>
    124b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    124e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1251:	89 04 24             	mov    %eax,(%esp)
    1254:	e8 bf 00 00 00       	call   1318 <close>
    1259:	8b 45 f4             	mov    -0xc(%ebp),%eax
    125c:	c9                   	leave  
    125d:	c3                   	ret    

0000125e <atoi>:
    125e:	55                   	push   %ebp
    125f:	89 e5                	mov    %esp,%ebp
    1261:	83 ec 10             	sub    $0x10,%esp
    1264:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    126b:	eb 24                	jmp    1291 <atoi+0x33>
    126d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1270:	89 d0                	mov    %edx,%eax
    1272:	c1 e0 02             	shl    $0x2,%eax
    1275:	01 d0                	add    %edx,%eax
    1277:	01 c0                	add    %eax,%eax
    1279:	89 c2                	mov    %eax,%edx
    127b:	8b 45 08             	mov    0x8(%ebp),%eax
    127e:	0f b6 00             	movzbl (%eax),%eax
    1281:	0f be c0             	movsbl %al,%eax
    1284:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1287:	83 e8 30             	sub    $0x30,%eax
    128a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    128d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b6 00             	movzbl (%eax),%eax
    1297:	3c 2f                	cmp    $0x2f,%al
    1299:	7e 0a                	jle    12a5 <atoi+0x47>
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	0f b6 00             	movzbl (%eax),%eax
    12a1:	3c 39                	cmp    $0x39,%al
    12a3:	7e c8                	jle    126d <atoi+0xf>
    12a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a8:	c9                   	leave  
    12a9:	c3                   	ret    

000012aa <memmove>:
    12aa:	55                   	push   %ebp
    12ab:	89 e5                	mov    %esp,%ebp
    12ad:	83 ec 10             	sub    $0x10,%esp
    12b0:	8b 45 08             	mov    0x8(%ebp),%eax
    12b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12bc:	eb 13                	jmp    12d1 <memmove+0x27>
    12be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c1:	0f b6 10             	movzbl (%eax),%edx
    12c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12c7:	88 10                	mov    %dl,(%eax)
    12c9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12d5:	0f 9f c0             	setg   %al
    12d8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12dc:	84 c0                	test   %al,%al
    12de:	75 de                	jne    12be <memmove+0x14>
    12e0:	8b 45 08             	mov    0x8(%ebp),%eax
    12e3:	c9                   	leave  
    12e4:	c3                   	ret    
    12e5:	90                   	nop
    12e6:	90                   	nop
    12e7:	90                   	nop

000012e8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12e8:	b8 01 00 00 00       	mov    $0x1,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <exit>:
SYSCALL(exit)
    12f0:	b8 02 00 00 00       	mov    $0x2,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <wait>:
SYSCALL(wait)
    12f8:	b8 03 00 00 00       	mov    $0x3,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <pipe>:
SYSCALL(pipe)
    1300:	b8 04 00 00 00       	mov    $0x4,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <read>:
SYSCALL(read)
    1308:	b8 05 00 00 00       	mov    $0x5,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <write>:
SYSCALL(write)
    1310:	b8 10 00 00 00       	mov    $0x10,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <close>:
SYSCALL(close)
    1318:	b8 15 00 00 00       	mov    $0x15,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <kill>:
SYSCALL(kill)
    1320:	b8 06 00 00 00       	mov    $0x6,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <exec>:
SYSCALL(exec)
    1328:	b8 07 00 00 00       	mov    $0x7,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <open>:
SYSCALL(open)
    1330:	b8 0f 00 00 00       	mov    $0xf,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <mknod>:
SYSCALL(mknod)
    1338:	b8 11 00 00 00       	mov    $0x11,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <unlink>:
SYSCALL(unlink)
    1340:	b8 12 00 00 00       	mov    $0x12,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <fstat>:
SYSCALL(fstat)
    1348:	b8 08 00 00 00       	mov    $0x8,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <link>:
SYSCALL(link)
    1350:	b8 13 00 00 00       	mov    $0x13,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <mkdir>:
SYSCALL(mkdir)
    1358:	b8 14 00 00 00       	mov    $0x14,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <chdir>:
SYSCALL(chdir)
    1360:	b8 09 00 00 00       	mov    $0x9,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <dup>:
SYSCALL(dup)
    1368:	b8 0a 00 00 00       	mov    $0xa,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <getpid>:
SYSCALL(getpid)
    1370:	b8 0b 00 00 00       	mov    $0xb,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <sbrk>:
SYSCALL(sbrk)
    1378:	b8 0c 00 00 00       	mov    $0xc,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <sleep>:
SYSCALL(sleep)
    1380:	b8 0d 00 00 00       	mov    $0xd,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <uptime>:
SYSCALL(uptime)
    1388:	b8 0e 00 00 00       	mov    $0xe,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <clone>:
SYSCALL(clone)
    1390:	b8 16 00 00 00       	mov    $0x16,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <texit>:
SYSCALL(texit)
    1398:	b8 17 00 00 00       	mov    $0x17,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <tsleep>:
SYSCALL(tsleep)
    13a0:	b8 18 00 00 00       	mov    $0x18,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <twakeup>:
SYSCALL(twakeup)
    13a8:	b8 19 00 00 00       	mov    $0x19,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <thread_yield>:
SYSCALL(thread_yield)
    13b0:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <putc>:
    13b8:	55                   	push   %ebp
    13b9:	89 e5                	mov    %esp,%ebp
    13bb:	83 ec 28             	sub    $0x28,%esp
    13be:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c1:	88 45 f4             	mov    %al,-0xc(%ebp)
    13c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13cb:	00 
    13cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	89 04 24             	mov    %eax,(%esp)
    13d9:	e8 32 ff ff ff       	call   1310 <write>
    13de:	c9                   	leave  
    13df:	c3                   	ret    

000013e0 <printint>:
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	53                   	push   %ebx
    13e4:	83 ec 44             	sub    $0x44,%esp
    13e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ee:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13f2:	74 17                	je     140b <printint+0x2b>
    13f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f8:	79 11                	jns    140b <printint+0x2b>
    13fa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    1401:	8b 45 0c             	mov    0xc(%ebp),%eax
    1404:	f7 d8                	neg    %eax
    1406:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1409:	eb 06                	jmp    1411 <printint+0x31>
    140b:	8b 45 0c             	mov    0xc(%ebp),%eax
    140e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1411:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1418:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    141b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    141e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1421:	ba 00 00 00 00       	mov    $0x0,%edx
    1426:	f7 f3                	div    %ebx
    1428:	89 d0                	mov    %edx,%eax
    142a:	0f b6 80 04 1b 00 00 	movzbl 0x1b04(%eax),%eax
    1431:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1435:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1439:	8b 45 10             	mov    0x10(%ebp),%eax
    143c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    143f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1442:	ba 00 00 00 00       	mov    $0x0,%edx
    1447:	f7 75 d4             	divl   -0x2c(%ebp)
    144a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    144d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1451:	75 c5                	jne    1418 <printint+0x38>
    1453:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1457:	74 28                	je     1481 <printint+0xa1>
    1459:	8b 45 ec             	mov    -0x14(%ebp),%eax
    145c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1461:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1465:	eb 1a                	jmp    1481 <printint+0xa1>
    1467:	8b 45 ec             	mov    -0x14(%ebp),%eax
    146a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    146f:	0f be c0             	movsbl %al,%eax
    1472:	89 44 24 04          	mov    %eax,0x4(%esp)
    1476:	8b 45 08             	mov    0x8(%ebp),%eax
    1479:	89 04 24             	mov    %eax,(%esp)
    147c:	e8 37 ff ff ff       	call   13b8 <putc>
    1481:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1485:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1489:	79 dc                	jns    1467 <printint+0x87>
    148b:	83 c4 44             	add    $0x44,%esp
    148e:	5b                   	pop    %ebx
    148f:	5d                   	pop    %ebp
    1490:	c3                   	ret    

00001491 <printf>:
    1491:	55                   	push   %ebp
    1492:	89 e5                	mov    %esp,%ebp
    1494:	83 ec 38             	sub    $0x38,%esp
    1497:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    149e:	8d 45 0c             	lea    0xc(%ebp),%eax
    14a1:	83 c0 04             	add    $0x4,%eax
    14a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    14ae:	e9 7e 01 00 00       	jmp    1631 <printf+0x1a0>
    14b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b9:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14bc:	0f b6 00             	movzbl (%eax),%eax
    14bf:	0f be c0             	movsbl %al,%eax
    14c2:	25 ff 00 00 00       	and    $0xff,%eax
    14c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14ce:	75 2c                	jne    14fc <printf+0x6b>
    14d0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14d4:	75 0c                	jne    14e2 <printf+0x51>
    14d6:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14dd:	e9 4b 01 00 00       	jmp    162d <printf+0x19c>
    14e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14e5:	0f be c0             	movsbl %al,%eax
    14e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ec:	8b 45 08             	mov    0x8(%ebp),%eax
    14ef:	89 04 24             	mov    %eax,(%esp)
    14f2:	e8 c1 fe ff ff       	call   13b8 <putc>
    14f7:	e9 31 01 00 00       	jmp    162d <printf+0x19c>
    14fc:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1500:	0f 85 27 01 00 00    	jne    162d <printf+0x19c>
    1506:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    150a:	75 2d                	jne    1539 <printf+0xa8>
    150c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150f:	8b 00                	mov    (%eax),%eax
    1511:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1518:	00 
    1519:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1520:	00 
    1521:	89 44 24 04          	mov    %eax,0x4(%esp)
    1525:	8b 45 08             	mov    0x8(%ebp),%eax
    1528:	89 04 24             	mov    %eax,(%esp)
    152b:	e8 b0 fe ff ff       	call   13e0 <printint>
    1530:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1534:	e9 ed 00 00 00       	jmp    1626 <printf+0x195>
    1539:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    153d:	74 06                	je     1545 <printf+0xb4>
    153f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1543:	75 2d                	jne    1572 <printf+0xe1>
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	8b 00                	mov    (%eax),%eax
    154a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1551:	00 
    1552:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1559:	00 
    155a:	89 44 24 04          	mov    %eax,0x4(%esp)
    155e:	8b 45 08             	mov    0x8(%ebp),%eax
    1561:	89 04 24             	mov    %eax,(%esp)
    1564:	e8 77 fe ff ff       	call   13e0 <printint>
    1569:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    156d:	e9 b4 00 00 00       	jmp    1626 <printf+0x195>
    1572:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1576:	75 46                	jne    15be <printf+0x12d>
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	8b 00                	mov    (%eax),%eax
    157d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1580:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1584:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1588:	75 27                	jne    15b1 <printf+0x120>
    158a:	c7 45 e4 d1 1a 00 00 	movl   $0x1ad1,-0x1c(%ebp)
    1591:	eb 1f                	jmp    15b2 <printf+0x121>
    1593:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1596:	0f b6 00             	movzbl (%eax),%eax
    1599:	0f be c0             	movsbl %al,%eax
    159c:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a0:	8b 45 08             	mov    0x8(%ebp),%eax
    15a3:	89 04 24             	mov    %eax,(%esp)
    15a6:	e8 0d fe ff ff       	call   13b8 <putc>
    15ab:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    15af:	eb 01                	jmp    15b2 <printf+0x121>
    15b1:	90                   	nop
    15b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15b5:	0f b6 00             	movzbl (%eax),%eax
    15b8:	84 c0                	test   %al,%al
    15ba:	75 d7                	jne    1593 <printf+0x102>
    15bc:	eb 68                	jmp    1626 <printf+0x195>
    15be:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    15c2:	75 1d                	jne    15e1 <printf+0x150>
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	8b 00                	mov    (%eax),%eax
    15c9:	0f be c0             	movsbl %al,%eax
    15cc:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	89 04 24             	mov    %eax,(%esp)
    15d6:	e8 dd fd ff ff       	call   13b8 <putc>
    15db:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15df:	eb 45                	jmp    1626 <printf+0x195>
    15e1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15e5:	75 17                	jne    15fe <printf+0x16d>
    15e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ea:	0f be c0             	movsbl %al,%eax
    15ed:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f1:	8b 45 08             	mov    0x8(%ebp),%eax
    15f4:	89 04 24             	mov    %eax,(%esp)
    15f7:	e8 bc fd ff ff       	call   13b8 <putc>
    15fc:	eb 28                	jmp    1626 <printf+0x195>
    15fe:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1605:	00 
    1606:	8b 45 08             	mov    0x8(%ebp),%eax
    1609:	89 04 24             	mov    %eax,(%esp)
    160c:	e8 a7 fd ff ff       	call   13b8 <putc>
    1611:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1614:	0f be c0             	movsbl %al,%eax
    1617:	89 44 24 04          	mov    %eax,0x4(%esp)
    161b:	8b 45 08             	mov    0x8(%ebp),%eax
    161e:	89 04 24             	mov    %eax,(%esp)
    1621:	e8 92 fd ff ff       	call   13b8 <putc>
    1626:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    162d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1631:	8b 55 0c             	mov    0xc(%ebp),%edx
    1634:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1637:	8d 04 02             	lea    (%edx,%eax,1),%eax
    163a:	0f b6 00             	movzbl (%eax),%eax
    163d:	84 c0                	test   %al,%al
    163f:	0f 85 6e fe ff ff    	jne    14b3 <printf+0x22>
    1645:	c9                   	leave  
    1646:	c3                   	ret    
    1647:	90                   	nop

00001648 <free>:
    1648:	55                   	push   %ebp
    1649:	89 e5                	mov    %esp,%ebp
    164b:	83 ec 10             	sub    $0x10,%esp
    164e:	8b 45 08             	mov    0x8(%ebp),%eax
    1651:	83 e8 08             	sub    $0x8,%eax
    1654:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1657:	a1 24 1b 00 00       	mov    0x1b24,%eax
    165c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    165f:	eb 24                	jmp    1685 <free+0x3d>
    1661:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1669:	77 12                	ja     167d <free+0x35>
    166b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1671:	77 24                	ja     1697 <free+0x4f>
    1673:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1676:	8b 00                	mov    (%eax),%eax
    1678:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    167b:	77 1a                	ja     1697 <free+0x4f>
    167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1685:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1688:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    168b:	76 d4                	jbe    1661 <free+0x19>
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	8b 00                	mov    (%eax),%eax
    1692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1695:	76 ca                	jbe    1661 <free+0x19>
    1697:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169a:	8b 40 04             	mov    0x4(%eax),%eax
    169d:	c1 e0 03             	shl    $0x3,%eax
    16a0:	89 c2                	mov    %eax,%edx
    16a2:	03 55 f8             	add    -0x8(%ebp),%edx
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 00                	mov    (%eax),%eax
    16aa:	39 c2                	cmp    %eax,%edx
    16ac:	75 24                	jne    16d2 <free+0x8a>
    16ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b1:	8b 50 04             	mov    0x4(%eax),%edx
    16b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b7:	8b 00                	mov    (%eax),%eax
    16b9:	8b 40 04             	mov    0x4(%eax),%eax
    16bc:	01 c2                	add    %eax,%edx
    16be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c1:	89 50 04             	mov    %edx,0x4(%eax)
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	8b 00                	mov    (%eax),%eax
    16c9:	8b 10                	mov    (%eax),%edx
    16cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ce:	89 10                	mov    %edx,(%eax)
    16d0:	eb 0a                	jmp    16dc <free+0x94>
    16d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d5:	8b 10                	mov    (%eax),%edx
    16d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16da:	89 10                	mov    %edx,(%eax)
    16dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16df:	8b 40 04             	mov    0x4(%eax),%eax
    16e2:	c1 e0 03             	shl    $0x3,%eax
    16e5:	03 45 fc             	add    -0x4(%ebp),%eax
    16e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16eb:	75 20                	jne    170d <free+0xc5>
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 50 04             	mov    0x4(%eax),%edx
    16f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f6:	8b 40 04             	mov    0x4(%eax),%eax
    16f9:	01 c2                	add    %eax,%edx
    16fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fe:	89 50 04             	mov    %edx,0x4(%eax)
    1701:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1704:	8b 10                	mov    (%eax),%edx
    1706:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1709:	89 10                	mov    %edx,(%eax)
    170b:	eb 08                	jmp    1715 <free+0xcd>
    170d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1710:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1713:	89 10                	mov    %edx,(%eax)
    1715:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1718:	a3 24 1b 00 00       	mov    %eax,0x1b24
    171d:	c9                   	leave  
    171e:	c3                   	ret    

0000171f <morecore>:
    171f:	55                   	push   %ebp
    1720:	89 e5                	mov    %esp,%ebp
    1722:	83 ec 28             	sub    $0x28,%esp
    1725:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    172c:	77 07                	ja     1735 <morecore+0x16>
    172e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1735:	8b 45 08             	mov    0x8(%ebp),%eax
    1738:	c1 e0 03             	shl    $0x3,%eax
    173b:	89 04 24             	mov    %eax,(%esp)
    173e:	e8 35 fc ff ff       	call   1378 <sbrk>
    1743:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1746:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    174a:	75 07                	jne    1753 <morecore+0x34>
    174c:	b8 00 00 00 00       	mov    $0x0,%eax
    1751:	eb 22                	jmp    1775 <morecore+0x56>
    1753:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1756:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 55 08             	mov    0x8(%ebp),%edx
    175f:	89 50 04             	mov    %edx,0x4(%eax)
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	83 c0 08             	add    $0x8,%eax
    1768:	89 04 24             	mov    %eax,(%esp)
    176b:	e8 d8 fe ff ff       	call   1648 <free>
    1770:	a1 24 1b 00 00       	mov    0x1b24,%eax
    1775:	c9                   	leave  
    1776:	c3                   	ret    

00001777 <malloc>:
    1777:	55                   	push   %ebp
    1778:	89 e5                	mov    %esp,%ebp
    177a:	83 ec 28             	sub    $0x28,%esp
    177d:	8b 45 08             	mov    0x8(%ebp),%eax
    1780:	83 c0 07             	add    $0x7,%eax
    1783:	c1 e8 03             	shr    $0x3,%eax
    1786:	83 c0 01             	add    $0x1,%eax
    1789:	89 45 f4             	mov    %eax,-0xc(%ebp)
    178c:	a1 24 1b 00 00       	mov    0x1b24,%eax
    1791:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1794:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1798:	75 23                	jne    17bd <malloc+0x46>
    179a:	c7 45 f0 1c 1b 00 00 	movl   $0x1b1c,-0x10(%ebp)
    17a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a4:	a3 24 1b 00 00       	mov    %eax,0x1b24
    17a9:	a1 24 1b 00 00       	mov    0x1b24,%eax
    17ae:	a3 1c 1b 00 00       	mov    %eax,0x1b1c
    17b3:	c7 05 20 1b 00 00 00 	movl   $0x0,0x1b20
    17ba:	00 00 00 
    17bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c0:	8b 00                	mov    (%eax),%eax
    17c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c8:	8b 40 04             	mov    0x4(%eax),%eax
    17cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17ce:	72 4d                	jb     181d <malloc+0xa6>
    17d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d3:	8b 40 04             	mov    0x4(%eax),%eax
    17d6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17d9:	75 0c                	jne    17e7 <malloc+0x70>
    17db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17de:	8b 10                	mov    (%eax),%edx
    17e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e3:	89 10                	mov    %edx,(%eax)
    17e5:	eb 26                	jmp    180d <malloc+0x96>
    17e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ea:	8b 40 04             	mov    0x4(%eax),%eax
    17ed:	89 c2                	mov    %eax,%edx
    17ef:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f5:	89 50 04             	mov    %edx,0x4(%eax)
    17f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17fb:	8b 40 04             	mov    0x4(%eax),%eax
    17fe:	c1 e0 03             	shl    $0x3,%eax
    1801:	01 45 ec             	add    %eax,-0x14(%ebp)
    1804:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1807:	8b 55 f4             	mov    -0xc(%ebp),%edx
    180a:	89 50 04             	mov    %edx,0x4(%eax)
    180d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1810:	a3 24 1b 00 00       	mov    %eax,0x1b24
    1815:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1818:	83 c0 08             	add    $0x8,%eax
    181b:	eb 38                	jmp    1855 <malloc+0xde>
    181d:	a1 24 1b 00 00       	mov    0x1b24,%eax
    1822:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1825:	75 1b                	jne    1842 <malloc+0xcb>
    1827:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182a:	89 04 24             	mov    %eax,(%esp)
    182d:	e8 ed fe ff ff       	call   171f <morecore>
    1832:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1835:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1839:	75 07                	jne    1842 <malloc+0xcb>
    183b:	b8 00 00 00 00       	mov    $0x0,%eax
    1840:	eb 13                	jmp    1855 <malloc+0xde>
    1842:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1845:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1848:	8b 45 ec             	mov    -0x14(%ebp),%eax
    184b:	8b 00                	mov    (%eax),%eax
    184d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1850:	e9 70 ff ff ff       	jmp    17c5 <malloc+0x4e>
    1855:	c9                   	leave  
    1856:	c3                   	ret    
    1857:	90                   	nop

00001858 <xchg>:
    1858:	55                   	push   %ebp
    1859:	89 e5                	mov    %esp,%ebp
    185b:	83 ec 10             	sub    $0x10,%esp
    185e:	8b 55 08             	mov    0x8(%ebp),%edx
    1861:	8b 45 0c             	mov    0xc(%ebp),%eax
    1864:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1867:	f0 87 02             	lock xchg %eax,(%edx)
    186a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    186d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1870:	c9                   	leave  
    1871:	c3                   	ret    

00001872 <lock_init>:
    1872:	55                   	push   %ebp
    1873:	89 e5                	mov    %esp,%ebp
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    187e:	5d                   	pop    %ebp
    187f:	c3                   	ret    

00001880 <lock_acquire>:
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1890:	00 
    1891:	89 04 24             	mov    %eax,(%esp)
    1894:	e8 bf ff ff ff       	call   1858 <xchg>
    1899:	85 c0                	test   %eax,%eax
    189b:	75 e9                	jne    1886 <lock_acquire+0x6>
    189d:	c9                   	leave  
    189e:	c3                   	ret    

0000189f <lock_release>:
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    18a2:	83 ec 08             	sub    $0x8,%esp
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    18af:	00 
    18b0:	89 04 24             	mov    %eax,(%esp)
    18b3:	e8 a0 ff ff ff       	call   1858 <xchg>
    18b8:	c9                   	leave  
    18b9:	c3                   	ret    

000018ba <thread_create>:
    18ba:	55                   	push   %ebp
    18bb:	89 e5                	mov    %esp,%ebp
    18bd:	83 ec 28             	sub    $0x28,%esp
    18c0:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18c7:	e8 ab fe ff ff       	call   1777 <malloc>
    18cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d8:	25 ff 0f 00 00       	and    $0xfff,%eax
    18dd:	85 c0                	test   %eax,%eax
    18df:	74 15                	je     18f6 <thread_create+0x3c>
    18e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e4:	89 c2                	mov    %eax,%edx
    18e6:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18ec:	b8 00 10 00 00       	mov    $0x1000,%eax
    18f1:	29 d0                	sub    %edx,%eax
    18f3:	01 45 f0             	add    %eax,-0x10(%ebp)
    18f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18fa:	75 1b                	jne    1917 <thread_create+0x5d>
    18fc:	c7 44 24 04 d8 1a 00 	movl   $0x1ad8,0x4(%esp)
    1903:	00 
    1904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190b:	e8 81 fb ff ff       	call   1491 <printf>
    1910:	b8 00 00 00 00       	mov    $0x0,%eax
    1915:	eb 6f                	jmp    1986 <thread_create+0xcc>
    1917:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    191a:	8b 55 08             	mov    0x8(%ebp),%edx
    191d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1920:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1924:	89 54 24 08          	mov    %edx,0x8(%esp)
    1928:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    192f:	00 
    1930:	89 04 24             	mov    %eax,(%esp)
    1933:	e8 58 fa ff ff       	call   1390 <clone>
    1938:	89 45 ec             	mov    %eax,-0x14(%ebp)
    193b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193f:	79 1b                	jns    195c <thread_create+0xa2>
    1941:	c7 44 24 04 e6 1a 00 	movl   $0x1ae6,0x4(%esp)
    1948:	00 
    1949:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1950:	e8 3c fb ff ff       	call   1491 <printf>
    1955:	b8 00 00 00 00       	mov    $0x0,%eax
    195a:	eb 2a                	jmp    1986 <thread_create+0xcc>
    195c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1960:	7e 05                	jle    1967 <thread_create+0xad>
    1962:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1965:	eb 1f                	jmp    1986 <thread_create+0xcc>
    1967:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    196b:	75 14                	jne    1981 <thread_create+0xc7>
    196d:	c7 44 24 04 f3 1a 00 	movl   $0x1af3,0x4(%esp)
    1974:	00 
    1975:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197c:	e8 10 fb ff ff       	call   1491 <printf>
    1981:	b8 00 00 00 00       	mov    $0x0,%eax
    1986:	c9                   	leave  
    1987:	c3                   	ret    

00001988 <random>:
    1988:	55                   	push   %ebp
    1989:	89 e5                	mov    %esp,%ebp
    198b:	a1 18 1b 00 00       	mov    0x1b18,%eax
    1990:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1996:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    199b:	a3 18 1b 00 00       	mov    %eax,0x1b18
    19a0:	a1 18 1b 00 00       	mov    0x1b18,%eax
    19a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19a8:	ba 00 00 00 00       	mov    $0x0,%edx
    19ad:	f7 f1                	div    %ecx
    19af:	89 d0                	mov    %edx,%eax
    19b1:	5d                   	pop    %ebp
    19b2:	c3                   	ret    
    19b3:	90                   	nop

000019b4 <init_q>:
    19b4:	55                   	push   %ebp
    19b5:	89 e5                	mov    %esp,%ebp
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    19c0:	8b 45 08             	mov    0x8(%ebp),%eax
    19c3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    19d4:	5d                   	pop    %ebp
    19d5:	c3                   	ret    

000019d6 <add_q>:
    19d6:	55                   	push   %ebp
    19d7:	89 e5                	mov    %esp,%ebp
    19d9:	83 ec 28             	sub    $0x28,%esp
    19dc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19e3:	e8 8f fd ff ff       	call   1777 <malloc>
    19e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ee:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    19fb:	89 10                	mov    %edx,(%eax)
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	8b 40 04             	mov    0x4(%eax),%eax
    1a03:	85 c0                	test   %eax,%eax
    1a05:	75 0b                	jne    1a12 <add_q+0x3c>
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a0d:	89 50 04             	mov    %edx,0x4(%eax)
    1a10:	eb 0c                	jmp    1a1e <add_q+0x48>
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	8b 40 08             	mov    0x8(%eax),%eax
    1a18:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a1b:	89 50 04             	mov    %edx,0x4(%eax)
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a24:	89 50 08             	mov    %edx,0x8(%eax)
    1a27:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2a:	8b 00                	mov    (%eax),%eax
    1a2c:	8d 50 01             	lea    0x1(%eax),%edx
    1a2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a32:	89 10                	mov    %edx,(%eax)
    1a34:	c9                   	leave  
    1a35:	c3                   	ret    

00001a36 <empty_q>:
    1a36:	55                   	push   %ebp
    1a37:	89 e5                	mov    %esp,%ebp
    1a39:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3c:	8b 00                	mov    (%eax),%eax
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	75 07                	jne    1a49 <empty_q+0x13>
    1a42:	b8 01 00 00 00       	mov    $0x1,%eax
    1a47:	eb 05                	jmp    1a4e <empty_q+0x18>
    1a49:	b8 00 00 00 00       	mov    $0x0,%eax
    1a4e:	5d                   	pop    %ebp
    1a4f:	c3                   	ret    

00001a50 <pop_q>:
    1a50:	55                   	push   %ebp
    1a51:	89 e5                	mov    %esp,%ebp
    1a53:	83 ec 28             	sub    $0x28,%esp
    1a56:	8b 45 08             	mov    0x8(%ebp),%eax
    1a59:	89 04 24             	mov    %eax,(%esp)
    1a5c:	e8 d5 ff ff ff       	call   1a36 <empty_q>
    1a61:	85 c0                	test   %eax,%eax
    1a63:	75 5d                	jne    1ac2 <pop_q+0x72>
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	8b 40 04             	mov    0x4(%eax),%eax
    1a6b:	8b 00                	mov    (%eax),%eax
    1a6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 40 04             	mov    0x4(%eax),%eax
    1a76:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a79:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7c:	8b 40 04             	mov    0x4(%eax),%eax
    1a7f:	8b 50 04             	mov    0x4(%eax),%edx
    1a82:	8b 45 08             	mov    0x8(%ebp),%eax
    1a85:	89 50 04             	mov    %edx,0x4(%eax)
    1a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8b:	89 04 24             	mov    %eax,(%esp)
    1a8e:	e8 b5 fb ff ff       	call   1648 <free>
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	8b 00                	mov    (%eax),%eax
    1a98:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	89 10                	mov    %edx,(%eax)
    1aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa3:	8b 00                	mov    (%eax),%eax
    1aa5:	85 c0                	test   %eax,%eax
    1aa7:	75 14                	jne    1abd <pop_q+0x6d>
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1abd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ac0:	eb 05                	jmp    1ac7 <pop_q+0x77>
    1ac2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ac7:	c9                   	leave  
    1ac8:	c3                   	ret    
