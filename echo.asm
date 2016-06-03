
_echo:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    1009:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1010:	00 
    1011:	eb 45                	jmp    1058 <main+0x58>
    1013:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1017:	83 c0 01             	add    $0x1,%eax
    101a:	3b 45 08             	cmp    0x8(%ebp),%eax
    101d:	7d 07                	jge    1026 <main+0x26>
    101f:	b8 a5 1a 00 00       	mov    $0x1aa5,%eax
    1024:	eb 05                	jmp    102b <main+0x2b>
    1026:	b8 a7 1a 00 00       	mov    $0x1aa7,%eax
    102b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    102f:	c1 e2 02             	shl    $0x2,%edx
    1032:	03 55 0c             	add    0xc(%ebp),%edx
    1035:	8b 12                	mov    (%edx),%edx
    1037:	89 44 24 0c          	mov    %eax,0xc(%esp)
    103b:	89 54 24 08          	mov    %edx,0x8(%esp)
    103f:	c7 44 24 04 a9 1a 00 	movl   $0x1aa9,0x4(%esp)
    1046:	00 
    1047:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104e:	e8 1a 04 00 00       	call   146d <printf>
    1053:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1058:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    105c:	3b 45 08             	cmp    0x8(%ebp),%eax
    105f:	7c b2                	jl     1013 <main+0x13>
    1061:	e8 66 02 00 00       	call   12cc <exit>
    1066:	90                   	nop
    1067:	90                   	nop

00001068 <stosb>:
    1068:	55                   	push   %ebp
    1069:	89 e5                	mov    %esp,%ebp
    106b:	57                   	push   %edi
    106c:	53                   	push   %ebx
    106d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1070:	8b 55 10             	mov    0x10(%ebp),%edx
    1073:	8b 45 0c             	mov    0xc(%ebp),%eax
    1076:	89 cb                	mov    %ecx,%ebx
    1078:	89 df                	mov    %ebx,%edi
    107a:	89 d1                	mov    %edx,%ecx
    107c:	fc                   	cld    
    107d:	f3 aa                	rep stos %al,%es:(%edi)
    107f:	89 ca                	mov    %ecx,%edx
    1081:	89 fb                	mov    %edi,%ebx
    1083:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1086:	89 55 10             	mov    %edx,0x10(%ebp)
    1089:	5b                   	pop    %ebx
    108a:	5f                   	pop    %edi
    108b:	5d                   	pop    %ebp
    108c:	c3                   	ret    

0000108d <strcpy>:
    108d:	55                   	push   %ebp
    108e:	89 e5                	mov    %esp,%ebp
    1090:	83 ec 10             	sub    $0x10,%esp
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1099:	8b 45 0c             	mov    0xc(%ebp),%eax
    109c:	0f b6 10             	movzbl (%eax),%edx
    109f:	8b 45 08             	mov    0x8(%ebp),%eax
    10a2:	88 10                	mov    %dl,(%eax)
    10a4:	8b 45 08             	mov    0x8(%ebp),%eax
    10a7:	0f b6 00             	movzbl (%eax),%eax
    10aa:	84 c0                	test   %al,%al
    10ac:	0f 95 c0             	setne  %al
    10af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10b3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10b7:	84 c0                	test   %al,%al
    10b9:	75 de                	jne    1099 <strcpy+0xc>
    10bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10be:	c9                   	leave  
    10bf:	c3                   	ret    

000010c0 <strcmp>:
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	eb 08                	jmp    10cd <strcmp+0xd>
    10c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10cd:	8b 45 08             	mov    0x8(%ebp),%eax
    10d0:	0f b6 00             	movzbl (%eax),%eax
    10d3:	84 c0                	test   %al,%al
    10d5:	74 10                	je     10e7 <strcmp+0x27>
    10d7:	8b 45 08             	mov    0x8(%ebp),%eax
    10da:	0f b6 10             	movzbl (%eax),%edx
    10dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e0:	0f b6 00             	movzbl (%eax),%eax
    10e3:	38 c2                	cmp    %al,%dl
    10e5:	74 de                	je     10c5 <strcmp+0x5>
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	0f b6 00             	movzbl (%eax),%eax
    10ed:	0f b6 d0             	movzbl %al,%edx
    10f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f3:	0f b6 00             	movzbl (%eax),%eax
    10f6:	0f b6 c0             	movzbl %al,%eax
    10f9:	89 d1                	mov    %edx,%ecx
    10fb:	29 c1                	sub    %eax,%ecx
    10fd:	89 c8                	mov    %ecx,%eax
    10ff:	5d                   	pop    %ebp
    1100:	c3                   	ret    

00001101 <strlen>:
    1101:	55                   	push   %ebp
    1102:	89 e5                	mov    %esp,%ebp
    1104:	83 ec 10             	sub    $0x10,%esp
    1107:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    110e:	eb 04                	jmp    1114 <strlen+0x13>
    1110:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1114:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1117:	03 45 08             	add    0x8(%ebp),%eax
    111a:	0f b6 00             	movzbl (%eax),%eax
    111d:	84 c0                	test   %al,%al
    111f:	75 ef                	jne    1110 <strlen+0xf>
    1121:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1124:	c9                   	leave  
    1125:	c3                   	ret    

00001126 <memset>:
    1126:	55                   	push   %ebp
    1127:	89 e5                	mov    %esp,%ebp
    1129:	83 ec 0c             	sub    $0xc,%esp
    112c:	8b 45 10             	mov    0x10(%ebp),%eax
    112f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1133:	8b 45 0c             	mov    0xc(%ebp),%eax
    1136:	89 44 24 04          	mov    %eax,0x4(%esp)
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
    113d:	89 04 24             	mov    %eax,(%esp)
    1140:	e8 23 ff ff ff       	call   1068 <stosb>
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	c9                   	leave  
    1149:	c3                   	ret    

0000114a <strchr>:
    114a:	55                   	push   %ebp
    114b:	89 e5                	mov    %esp,%ebp
    114d:	83 ec 04             	sub    $0x4,%esp
    1150:	8b 45 0c             	mov    0xc(%ebp),%eax
    1153:	88 45 fc             	mov    %al,-0x4(%ebp)
    1156:	eb 14                	jmp    116c <strchr+0x22>
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	0f b6 00             	movzbl (%eax),%eax
    115e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1161:	75 05                	jne    1168 <strchr+0x1e>
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	eb 13                	jmp    117b <strchr+0x31>
    1168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	0f b6 00             	movzbl (%eax),%eax
    1172:	84 c0                	test   %al,%al
    1174:	75 e2                	jne    1158 <strchr+0xe>
    1176:	b8 00 00 00 00       	mov    $0x0,%eax
    117b:	c9                   	leave  
    117c:	c3                   	ret    

0000117d <gets>:
    117d:	55                   	push   %ebp
    117e:	89 e5                	mov    %esp,%ebp
    1180:	83 ec 28             	sub    $0x28,%esp
    1183:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    118a:	eb 44                	jmp    11d0 <gets+0x53>
    118c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1193:	00 
    1194:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1197:	89 44 24 04          	mov    %eax,0x4(%esp)
    119b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11a2:	e8 3d 01 00 00       	call   12e4 <read>
    11a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    11aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ae:	7e 2d                	jle    11dd <gets+0x60>
    11b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b3:	03 45 08             	add    0x8(%ebp),%eax
    11b6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11ba:	88 10                	mov    %dl,(%eax)
    11bc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c4:	3c 0a                	cmp    $0xa,%al
    11c6:	74 16                	je     11de <gets+0x61>
    11c8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11cc:	3c 0d                	cmp    $0xd,%al
    11ce:	74 0e                	je     11de <gets+0x61>
    11d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11d3:	83 c0 01             	add    $0x1,%eax
    11d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11d9:	7c b1                	jl     118c <gets+0xf>
    11db:	eb 01                	jmp    11de <gets+0x61>
    11dd:	90                   	nop
    11de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e1:	03 45 08             	add    0x8(%ebp),%eax
    11e4:	c6 00 00             	movb   $0x0,(%eax)
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	c9                   	leave  
    11eb:	c3                   	ret    

000011ec <stat>:
    11ec:	55                   	push   %ebp
    11ed:	89 e5                	mov    %esp,%ebp
    11ef:	83 ec 28             	sub    $0x28,%esp
    11f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11f9:	00 
    11fa:	8b 45 08             	mov    0x8(%ebp),%eax
    11fd:	89 04 24             	mov    %eax,(%esp)
    1200:	e8 07 01 00 00       	call   130c <open>
    1205:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1208:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    120c:	79 07                	jns    1215 <stat+0x29>
    120e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1213:	eb 23                	jmp    1238 <stat+0x4c>
    1215:	8b 45 0c             	mov    0xc(%ebp),%eax
    1218:	89 44 24 04          	mov    %eax,0x4(%esp)
    121c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    121f:	89 04 24             	mov    %eax,(%esp)
    1222:	e8 fd 00 00 00       	call   1324 <fstat>
    1227:	89 45 f4             	mov    %eax,-0xc(%ebp)
    122a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    122d:	89 04 24             	mov    %eax,(%esp)
    1230:	e8 bf 00 00 00       	call   12f4 <close>
    1235:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1238:	c9                   	leave  
    1239:	c3                   	ret    

0000123a <atoi>:
    123a:	55                   	push   %ebp
    123b:	89 e5                	mov    %esp,%ebp
    123d:	83 ec 10             	sub    $0x10,%esp
    1240:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1247:	eb 24                	jmp    126d <atoi+0x33>
    1249:	8b 55 fc             	mov    -0x4(%ebp),%edx
    124c:	89 d0                	mov    %edx,%eax
    124e:	c1 e0 02             	shl    $0x2,%eax
    1251:	01 d0                	add    %edx,%eax
    1253:	01 c0                	add    %eax,%eax
    1255:	89 c2                	mov    %eax,%edx
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	0f b6 00             	movzbl (%eax),%eax
    125d:	0f be c0             	movsbl %al,%eax
    1260:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1263:	83 e8 30             	sub    $0x30,%eax
    1266:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1269:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    126d:	8b 45 08             	mov    0x8(%ebp),%eax
    1270:	0f b6 00             	movzbl (%eax),%eax
    1273:	3c 2f                	cmp    $0x2f,%al
    1275:	7e 0a                	jle    1281 <atoi+0x47>
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	0f b6 00             	movzbl (%eax),%eax
    127d:	3c 39                	cmp    $0x39,%al
    127f:	7e c8                	jle    1249 <atoi+0xf>
    1281:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1284:	c9                   	leave  
    1285:	c3                   	ret    

00001286 <memmove>:
    1286:	55                   	push   %ebp
    1287:	89 e5                	mov    %esp,%ebp
    1289:	83 ec 10             	sub    $0x10,%esp
    128c:	8b 45 08             	mov    0x8(%ebp),%eax
    128f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1292:	8b 45 0c             	mov    0xc(%ebp),%eax
    1295:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1298:	eb 13                	jmp    12ad <memmove+0x27>
    129a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    129d:	0f b6 10             	movzbl (%eax),%edx
    12a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12a3:	88 10                	mov    %dl,(%eax)
    12a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12a9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12b1:	0f 9f c0             	setg   %al
    12b4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12b8:	84 c0                	test   %al,%al
    12ba:	75 de                	jne    129a <memmove+0x14>
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	c9                   	leave  
    12c0:	c3                   	ret    
    12c1:	90                   	nop
    12c2:	90                   	nop
    12c3:	90                   	nop

000012c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c4:	b8 01 00 00 00       	mov    $0x1,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <exit>:
SYSCALL(exit)
    12cc:	b8 02 00 00 00       	mov    $0x2,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <wait>:
SYSCALL(wait)
    12d4:	b8 03 00 00 00       	mov    $0x3,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <pipe>:
SYSCALL(pipe)
    12dc:	b8 04 00 00 00       	mov    $0x4,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <read>:
SYSCALL(read)
    12e4:	b8 05 00 00 00       	mov    $0x5,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <write>:
SYSCALL(write)
    12ec:	b8 10 00 00 00       	mov    $0x10,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <close>:
SYSCALL(close)
    12f4:	b8 15 00 00 00       	mov    $0x15,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <kill>:
SYSCALL(kill)
    12fc:	b8 06 00 00 00       	mov    $0x6,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <exec>:
SYSCALL(exec)
    1304:	b8 07 00 00 00       	mov    $0x7,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <open>:
SYSCALL(open)
    130c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <mknod>:
SYSCALL(mknod)
    1314:	b8 11 00 00 00       	mov    $0x11,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <unlink>:
SYSCALL(unlink)
    131c:	b8 12 00 00 00       	mov    $0x12,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <fstat>:
SYSCALL(fstat)
    1324:	b8 08 00 00 00       	mov    $0x8,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <link>:
SYSCALL(link)
    132c:	b8 13 00 00 00       	mov    $0x13,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <mkdir>:
SYSCALL(mkdir)
    1334:	b8 14 00 00 00       	mov    $0x14,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <chdir>:
SYSCALL(chdir)
    133c:	b8 09 00 00 00       	mov    $0x9,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <dup>:
SYSCALL(dup)
    1344:	b8 0a 00 00 00       	mov    $0xa,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <getpid>:
SYSCALL(getpid)
    134c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <sbrk>:
SYSCALL(sbrk)
    1354:	b8 0c 00 00 00       	mov    $0xc,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <sleep>:
SYSCALL(sleep)
    135c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <uptime>:
SYSCALL(uptime)
    1364:	b8 0e 00 00 00       	mov    $0xe,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <clone>:
SYSCALL(clone)
    136c:	b8 16 00 00 00       	mov    $0x16,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <texit>:
SYSCALL(texit)
    1374:	b8 17 00 00 00       	mov    $0x17,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <tsleep>:
SYSCALL(tsleep)
    137c:	b8 18 00 00 00       	mov    $0x18,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <twakeup>:
SYSCALL(twakeup)
    1384:	b8 19 00 00 00       	mov    $0x19,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <thread_yield>:
SYSCALL(thread_yield)
    138c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <putc>:
    1394:	55                   	push   %ebp
    1395:	89 e5                	mov    %esp,%ebp
    1397:	83 ec 28             	sub    $0x28,%esp
    139a:	8b 45 0c             	mov    0xc(%ebp),%eax
    139d:	88 45 f4             	mov    %al,-0xc(%ebp)
    13a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13a7:	00 
    13a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    13af:	8b 45 08             	mov    0x8(%ebp),%eax
    13b2:	89 04 24             	mov    %eax,(%esp)
    13b5:	e8 32 ff ff ff       	call   12ec <write>
    13ba:	c9                   	leave  
    13bb:	c3                   	ret    

000013bc <printint>:
    13bc:	55                   	push   %ebp
    13bd:	89 e5                	mov    %esp,%ebp
    13bf:	53                   	push   %ebx
    13c0:	83 ec 44             	sub    $0x44,%esp
    13c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ca:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ce:	74 17                	je     13e7 <printint+0x2b>
    13d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d4:	79 11                	jns    13e7 <printint+0x2b>
    13d6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    13dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e0:	f7 d8                	neg    %eax
    13e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e5:	eb 06                	jmp    13ed <printint+0x31>
    13e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    13f4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fd:	ba 00 00 00 00       	mov    $0x0,%edx
    1402:	f7 f3                	div    %ebx
    1404:	89 d0                	mov    %edx,%eax
    1406:	0f b6 80 e4 1a 00 00 	movzbl 0x1ae4(%eax),%eax
    140d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1411:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1415:	8b 45 10             	mov    0x10(%ebp),%eax
    1418:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    141b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141e:	ba 00 00 00 00       	mov    $0x0,%edx
    1423:	f7 75 d4             	divl   -0x2c(%ebp)
    1426:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1429:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    142d:	75 c5                	jne    13f4 <printint+0x38>
    142f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1433:	74 28                	je     145d <printint+0xa1>
    1435:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1438:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    143d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1441:	eb 1a                	jmp    145d <printint+0xa1>
    1443:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1446:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    144b:	0f be c0             	movsbl %al,%eax
    144e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1452:	8b 45 08             	mov    0x8(%ebp),%eax
    1455:	89 04 24             	mov    %eax,(%esp)
    1458:	e8 37 ff ff ff       	call   1394 <putc>
    145d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1465:	79 dc                	jns    1443 <printint+0x87>
    1467:	83 c4 44             	add    $0x44,%esp
    146a:	5b                   	pop    %ebx
    146b:	5d                   	pop    %ebp
    146c:	c3                   	ret    

0000146d <printf>:
    146d:	55                   	push   %ebp
    146e:	89 e5                	mov    %esp,%ebp
    1470:	83 ec 38             	sub    $0x38,%esp
    1473:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    147a:	8d 45 0c             	lea    0xc(%ebp),%eax
    147d:	83 c0 04             	add    $0x4,%eax
    1480:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1483:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    148a:	e9 7e 01 00 00       	jmp    160d <printf+0x1a0>
    148f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1492:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1495:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1498:	0f b6 00             	movzbl (%eax),%eax
    149b:	0f be c0             	movsbl %al,%eax
    149e:	25 ff 00 00 00       	and    $0xff,%eax
    14a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14aa:	75 2c                	jne    14d8 <printf+0x6b>
    14ac:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14b0:	75 0c                	jne    14be <printf+0x51>
    14b2:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14b9:	e9 4b 01 00 00       	jmp    1609 <printf+0x19c>
    14be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14c1:	0f be c0             	movsbl %al,%eax
    14c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    14c8:	8b 45 08             	mov    0x8(%ebp),%eax
    14cb:	89 04 24             	mov    %eax,(%esp)
    14ce:	e8 c1 fe ff ff       	call   1394 <putc>
    14d3:	e9 31 01 00 00       	jmp    1609 <printf+0x19c>
    14d8:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14dc:	0f 85 27 01 00 00    	jne    1609 <printf+0x19c>
    14e2:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14e6:	75 2d                	jne    1515 <printf+0xa8>
    14e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14eb:	8b 00                	mov    (%eax),%eax
    14ed:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14f4:	00 
    14f5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14fc:	00 
    14fd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1501:	8b 45 08             	mov    0x8(%ebp),%eax
    1504:	89 04 24             	mov    %eax,(%esp)
    1507:	e8 b0 fe ff ff       	call   13bc <printint>
    150c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1510:	e9 ed 00 00 00       	jmp    1602 <printf+0x195>
    1515:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1519:	74 06                	je     1521 <printf+0xb4>
    151b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    151f:	75 2d                	jne    154e <printf+0xe1>
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	8b 00                	mov    (%eax),%eax
    1526:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    152d:	00 
    152e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1535:	00 
    1536:	89 44 24 04          	mov    %eax,0x4(%esp)
    153a:	8b 45 08             	mov    0x8(%ebp),%eax
    153d:	89 04 24             	mov    %eax,(%esp)
    1540:	e8 77 fe ff ff       	call   13bc <printint>
    1545:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1549:	e9 b4 00 00 00       	jmp    1602 <printf+0x195>
    154e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1552:	75 46                	jne    159a <printf+0x12d>
    1554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1557:	8b 00                	mov    (%eax),%eax
    1559:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    155c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1560:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1564:	75 27                	jne    158d <printf+0x120>
    1566:	c7 45 e4 ae 1a 00 00 	movl   $0x1aae,-0x1c(%ebp)
    156d:	eb 1f                	jmp    158e <printf+0x121>
    156f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1572:	0f b6 00             	movzbl (%eax),%eax
    1575:	0f be c0             	movsbl %al,%eax
    1578:	89 44 24 04          	mov    %eax,0x4(%esp)
    157c:	8b 45 08             	mov    0x8(%ebp),%eax
    157f:	89 04 24             	mov    %eax,(%esp)
    1582:	e8 0d fe ff ff       	call   1394 <putc>
    1587:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    158b:	eb 01                	jmp    158e <printf+0x121>
    158d:	90                   	nop
    158e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1591:	0f b6 00             	movzbl (%eax),%eax
    1594:	84 c0                	test   %al,%al
    1596:	75 d7                	jne    156f <printf+0x102>
    1598:	eb 68                	jmp    1602 <printf+0x195>
    159a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    159e:	75 1d                	jne    15bd <printf+0x150>
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	8b 00                	mov    (%eax),%eax
    15a5:	0f be c0             	movsbl %al,%eax
    15a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
    15af:	89 04 24             	mov    %eax,(%esp)
    15b2:	e8 dd fd ff ff       	call   1394 <putc>
    15b7:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15bb:	eb 45                	jmp    1602 <printf+0x195>
    15bd:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15c1:	75 17                	jne    15da <printf+0x16d>
    15c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c6:	0f be c0             	movsbl %al,%eax
    15c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    15cd:	8b 45 08             	mov    0x8(%ebp),%eax
    15d0:	89 04 24             	mov    %eax,(%esp)
    15d3:	e8 bc fd ff ff       	call   1394 <putc>
    15d8:	eb 28                	jmp    1602 <printf+0x195>
    15da:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15e1:	00 
    15e2:	8b 45 08             	mov    0x8(%ebp),%eax
    15e5:	89 04 24             	mov    %eax,(%esp)
    15e8:	e8 a7 fd ff ff       	call   1394 <putc>
    15ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15f0:	0f be c0             	movsbl %al,%eax
    15f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f7:	8b 45 08             	mov    0x8(%ebp),%eax
    15fa:	89 04 24             	mov    %eax,(%esp)
    15fd:	e8 92 fd ff ff       	call   1394 <putc>
    1602:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1609:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    160d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1610:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1613:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1616:	0f b6 00             	movzbl (%eax),%eax
    1619:	84 c0                	test   %al,%al
    161b:	0f 85 6e fe ff ff    	jne    148f <printf+0x22>
    1621:	c9                   	leave  
    1622:	c3                   	ret    
    1623:	90                   	nop

00001624 <free>:
    1624:	55                   	push   %ebp
    1625:	89 e5                	mov    %esp,%ebp
    1627:	83 ec 10             	sub    $0x10,%esp
    162a:	8b 45 08             	mov    0x8(%ebp),%eax
    162d:	83 e8 08             	sub    $0x8,%eax
    1630:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1633:	a1 04 1b 00 00       	mov    0x1b04,%eax
    1638:	89 45 fc             	mov    %eax,-0x4(%ebp)
    163b:	eb 24                	jmp    1661 <free+0x3d>
    163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1640:	8b 00                	mov    (%eax),%eax
    1642:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1645:	77 12                	ja     1659 <free+0x35>
    1647:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    164d:	77 24                	ja     1673 <free+0x4f>
    164f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1652:	8b 00                	mov    (%eax),%eax
    1654:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1657:	77 1a                	ja     1673 <free+0x4f>
    1659:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165c:	8b 00                	mov    (%eax),%eax
    165e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1661:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1664:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1667:	76 d4                	jbe    163d <free+0x19>
    1669:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166c:	8b 00                	mov    (%eax),%eax
    166e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1671:	76 ca                	jbe    163d <free+0x19>
    1673:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1676:	8b 40 04             	mov    0x4(%eax),%eax
    1679:	c1 e0 03             	shl    $0x3,%eax
    167c:	89 c2                	mov    %eax,%edx
    167e:	03 55 f8             	add    -0x8(%ebp),%edx
    1681:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1684:	8b 00                	mov    (%eax),%eax
    1686:	39 c2                	cmp    %eax,%edx
    1688:	75 24                	jne    16ae <free+0x8a>
    168a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168d:	8b 50 04             	mov    0x4(%eax),%edx
    1690:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1693:	8b 00                	mov    (%eax),%eax
    1695:	8b 40 04             	mov    0x4(%eax),%eax
    1698:	01 c2                	add    %eax,%edx
    169a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    169d:	89 50 04             	mov    %edx,0x4(%eax)
    16a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a3:	8b 00                	mov    (%eax),%eax
    16a5:	8b 10                	mov    (%eax),%edx
    16a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16aa:	89 10                	mov    %edx,(%eax)
    16ac:	eb 0a                	jmp    16b8 <free+0x94>
    16ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b1:	8b 10                	mov    (%eax),%edx
    16b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b6:	89 10                	mov    %edx,(%eax)
    16b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bb:	8b 40 04             	mov    0x4(%eax),%eax
    16be:	c1 e0 03             	shl    $0x3,%eax
    16c1:	03 45 fc             	add    -0x4(%ebp),%eax
    16c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16c7:	75 20                	jne    16e9 <free+0xc5>
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	8b 50 04             	mov    0x4(%eax),%edx
    16cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d2:	8b 40 04             	mov    0x4(%eax),%eax
    16d5:	01 c2                	add    %eax,%edx
    16d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16da:	89 50 04             	mov    %edx,0x4(%eax)
    16dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e0:	8b 10                	mov    (%eax),%edx
    16e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e5:	89 10                	mov    %edx,(%eax)
    16e7:	eb 08                	jmp    16f1 <free+0xcd>
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ef:	89 10                	mov    %edx,(%eax)
    16f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f4:	a3 04 1b 00 00       	mov    %eax,0x1b04
    16f9:	c9                   	leave  
    16fa:	c3                   	ret    

000016fb <morecore>:
    16fb:	55                   	push   %ebp
    16fc:	89 e5                	mov    %esp,%ebp
    16fe:	83 ec 28             	sub    $0x28,%esp
    1701:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1708:	77 07                	ja     1711 <morecore+0x16>
    170a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1711:	8b 45 08             	mov    0x8(%ebp),%eax
    1714:	c1 e0 03             	shl    $0x3,%eax
    1717:	89 04 24             	mov    %eax,(%esp)
    171a:	e8 35 fc ff ff       	call   1354 <sbrk>
    171f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1722:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1726:	75 07                	jne    172f <morecore+0x34>
    1728:	b8 00 00 00 00       	mov    $0x0,%eax
    172d:	eb 22                	jmp    1751 <morecore+0x56>
    172f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1732:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	8b 55 08             	mov    0x8(%ebp),%edx
    173b:	89 50 04             	mov    %edx,0x4(%eax)
    173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1741:	83 c0 08             	add    $0x8,%eax
    1744:	89 04 24             	mov    %eax,(%esp)
    1747:	e8 d8 fe ff ff       	call   1624 <free>
    174c:	a1 04 1b 00 00       	mov    0x1b04,%eax
    1751:	c9                   	leave  
    1752:	c3                   	ret    

00001753 <malloc>:
    1753:	55                   	push   %ebp
    1754:	89 e5                	mov    %esp,%ebp
    1756:	83 ec 28             	sub    $0x28,%esp
    1759:	8b 45 08             	mov    0x8(%ebp),%eax
    175c:	83 c0 07             	add    $0x7,%eax
    175f:	c1 e8 03             	shr    $0x3,%eax
    1762:	83 c0 01             	add    $0x1,%eax
    1765:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1768:	a1 04 1b 00 00       	mov    0x1b04,%eax
    176d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1770:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1774:	75 23                	jne    1799 <malloc+0x46>
    1776:	c7 45 f0 fc 1a 00 00 	movl   $0x1afc,-0x10(%ebp)
    177d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1780:	a3 04 1b 00 00       	mov    %eax,0x1b04
    1785:	a1 04 1b 00 00       	mov    0x1b04,%eax
    178a:	a3 fc 1a 00 00       	mov    %eax,0x1afc
    178f:	c7 05 00 1b 00 00 00 	movl   $0x0,0x1b00
    1796:	00 00 00 
    1799:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179c:	8b 00                	mov    (%eax),%eax
    179e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a4:	8b 40 04             	mov    0x4(%eax),%eax
    17a7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17aa:	72 4d                	jb     17f9 <malloc+0xa6>
    17ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17af:	8b 40 04             	mov    0x4(%eax),%eax
    17b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17b5:	75 0c                	jne    17c3 <malloc+0x70>
    17b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ba:	8b 10                	mov    (%eax),%edx
    17bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17bf:	89 10                	mov    %edx,(%eax)
    17c1:	eb 26                	jmp    17e9 <malloc+0x96>
    17c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c6:	8b 40 04             	mov    0x4(%eax),%eax
    17c9:	89 c2                	mov    %eax,%edx
    17cb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d1:	89 50 04             	mov    %edx,0x4(%eax)
    17d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d7:	8b 40 04             	mov    0x4(%eax),%eax
    17da:	c1 e0 03             	shl    $0x3,%eax
    17dd:	01 45 ec             	add    %eax,-0x14(%ebp)
    17e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17e6:	89 50 04             	mov    %edx,0x4(%eax)
    17e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ec:	a3 04 1b 00 00       	mov    %eax,0x1b04
    17f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f4:	83 c0 08             	add    $0x8,%eax
    17f7:	eb 38                	jmp    1831 <malloc+0xde>
    17f9:	a1 04 1b 00 00       	mov    0x1b04,%eax
    17fe:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1801:	75 1b                	jne    181e <malloc+0xcb>
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	89 04 24             	mov    %eax,(%esp)
    1809:	e8 ed fe ff ff       	call   16fb <morecore>
    180e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1811:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1815:	75 07                	jne    181e <malloc+0xcb>
    1817:	b8 00 00 00 00       	mov    $0x0,%eax
    181c:	eb 13                	jmp    1831 <malloc+0xde>
    181e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1821:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1824:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1827:	8b 00                	mov    (%eax),%eax
    1829:	89 45 ec             	mov    %eax,-0x14(%ebp)
    182c:	e9 70 ff ff ff       	jmp    17a1 <malloc+0x4e>
    1831:	c9                   	leave  
    1832:	c3                   	ret    
    1833:	90                   	nop

00001834 <xchg>:
    1834:	55                   	push   %ebp
    1835:	89 e5                	mov    %esp,%ebp
    1837:	83 ec 10             	sub    $0x10,%esp
    183a:	8b 55 08             	mov    0x8(%ebp),%edx
    183d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1840:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1843:	f0 87 02             	lock xchg %eax,(%edx)
    1846:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1849:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184c:	c9                   	leave  
    184d:	c3                   	ret    

0000184e <lock_init>:
    184e:	55                   	push   %ebp
    184f:	89 e5                	mov    %esp,%ebp
    1851:	8b 45 08             	mov    0x8(%ebp),%eax
    1854:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    185a:	5d                   	pop    %ebp
    185b:	c3                   	ret    

0000185c <lock_acquire>:
    185c:	55                   	push   %ebp
    185d:	89 e5                	mov    %esp,%ebp
    185f:	83 ec 08             	sub    $0x8,%esp
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    186c:	00 
    186d:	89 04 24             	mov    %eax,(%esp)
    1870:	e8 bf ff ff ff       	call   1834 <xchg>
    1875:	85 c0                	test   %eax,%eax
    1877:	75 e9                	jne    1862 <lock_acquire+0x6>
    1879:	c9                   	leave  
    187a:	c3                   	ret    

0000187b <lock_release>:
    187b:	55                   	push   %ebp
    187c:	89 e5                	mov    %esp,%ebp
    187e:	83 ec 08             	sub    $0x8,%esp
    1881:	8b 45 08             	mov    0x8(%ebp),%eax
    1884:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    188b:	00 
    188c:	89 04 24             	mov    %eax,(%esp)
    188f:	e8 a0 ff ff ff       	call   1834 <xchg>
    1894:	c9                   	leave  
    1895:	c3                   	ret    

00001896 <thread_create>:
    1896:	55                   	push   %ebp
    1897:	89 e5                	mov    %esp,%ebp
    1899:	83 ec 28             	sub    $0x28,%esp
    189c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    18a3:	e8 ab fe ff ff       	call   1753 <malloc>
    18a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b4:	25 ff 0f 00 00       	and    $0xfff,%eax
    18b9:	85 c0                	test   %eax,%eax
    18bb:	74 15                	je     18d2 <thread_create+0x3c>
    18bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c0:	89 c2                	mov    %eax,%edx
    18c2:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18c8:	b8 00 10 00 00       	mov    $0x1000,%eax
    18cd:	29 d0                	sub    %edx,%eax
    18cf:	01 45 f0             	add    %eax,-0x10(%ebp)
    18d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d6:	75 1b                	jne    18f3 <thread_create+0x5d>
    18d8:	c7 44 24 04 b5 1a 00 	movl   $0x1ab5,0x4(%esp)
    18df:	00 
    18e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e7:	e8 81 fb ff ff       	call   146d <printf>
    18ec:	b8 00 00 00 00       	mov    $0x0,%eax
    18f1:	eb 6f                	jmp    1962 <thread_create+0xcc>
    18f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18f6:	8b 55 08             	mov    0x8(%ebp),%edx
    18f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18fc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1900:	89 54 24 08          	mov    %edx,0x8(%esp)
    1904:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    190b:	00 
    190c:	89 04 24             	mov    %eax,(%esp)
    190f:	e8 58 fa ff ff       	call   136c <clone>
    1914:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1917:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191b:	79 1b                	jns    1938 <thread_create+0xa2>
    191d:	c7 44 24 04 c3 1a 00 	movl   $0x1ac3,0x4(%esp)
    1924:	00 
    1925:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    192c:	e8 3c fb ff ff       	call   146d <printf>
    1931:	b8 00 00 00 00       	mov    $0x0,%eax
    1936:	eb 2a                	jmp    1962 <thread_create+0xcc>
    1938:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193c:	7e 05                	jle    1943 <thread_create+0xad>
    193e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1941:	eb 1f                	jmp    1962 <thread_create+0xcc>
    1943:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1947:	75 14                	jne    195d <thread_create+0xc7>
    1949:	c7 44 24 04 d0 1a 00 	movl   $0x1ad0,0x4(%esp)
    1950:	00 
    1951:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1958:	e8 10 fb ff ff       	call   146d <printf>
    195d:	b8 00 00 00 00       	mov    $0x0,%eax
    1962:	c9                   	leave  
    1963:	c3                   	ret    

00001964 <random>:
    1964:	55                   	push   %ebp
    1965:	89 e5                	mov    %esp,%ebp
    1967:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    196c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1972:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1977:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    197c:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    1981:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1984:	ba 00 00 00 00       	mov    $0x0,%edx
    1989:	f7 f1                	div    %ecx
    198b:	89 d0                	mov    %edx,%eax
    198d:	5d                   	pop    %ebp
    198e:	c3                   	ret    
    198f:	90                   	nop

00001990 <init_q>:
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    1993:	8b 45 08             	mov    0x8(%ebp),%eax
    1996:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    199c:	8b 45 08             	mov    0x8(%ebp),%eax
    199f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19a6:	8b 45 08             	mov    0x8(%ebp),%eax
    19a9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    19b0:	5d                   	pop    %ebp
    19b1:	c3                   	ret    

000019b2 <add_q>:
    19b2:	55                   	push   %ebp
    19b3:	89 e5                	mov    %esp,%ebp
    19b5:	83 ec 28             	sub    $0x28,%esp
    19b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19bf:	e8 8f fd ff ff       	call   1753 <malloc>
    19c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19d7:	89 10                	mov    %edx,(%eax)
    19d9:	8b 45 08             	mov    0x8(%ebp),%eax
    19dc:	8b 40 04             	mov    0x4(%eax),%eax
    19df:	85 c0                	test   %eax,%eax
    19e1:	75 0b                	jne    19ee <add_q+0x3c>
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19e9:	89 50 04             	mov    %edx,0x4(%eax)
    19ec:	eb 0c                	jmp    19fa <add_q+0x48>
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	8b 40 08             	mov    0x8(%eax),%eax
    19f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19f7:	89 50 04             	mov    %edx,0x4(%eax)
    19fa:	8b 45 08             	mov    0x8(%ebp),%eax
    19fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a00:	89 50 08             	mov    %edx,0x8(%eax)
    1a03:	8b 45 08             	mov    0x8(%ebp),%eax
    1a06:	8b 00                	mov    (%eax),%eax
    1a08:	8d 50 01             	lea    0x1(%eax),%edx
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	89 10                	mov    %edx,(%eax)
    1a10:	c9                   	leave  
    1a11:	c3                   	ret    

00001a12 <empty_q>:
    1a12:	55                   	push   %ebp
    1a13:	89 e5                	mov    %esp,%ebp
    1a15:	8b 45 08             	mov    0x8(%ebp),%eax
    1a18:	8b 00                	mov    (%eax),%eax
    1a1a:	85 c0                	test   %eax,%eax
    1a1c:	75 07                	jne    1a25 <empty_q+0x13>
    1a1e:	b8 01 00 00 00       	mov    $0x1,%eax
    1a23:	eb 05                	jmp    1a2a <empty_q+0x18>
    1a25:	b8 00 00 00 00       	mov    $0x0,%eax
    1a2a:	5d                   	pop    %ebp
    1a2b:	c3                   	ret    

00001a2c <pop_q>:
    1a2c:	55                   	push   %ebp
    1a2d:	89 e5                	mov    %esp,%ebp
    1a2f:	83 ec 28             	sub    $0x28,%esp
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	89 04 24             	mov    %eax,(%esp)
    1a38:	e8 d5 ff ff ff       	call   1a12 <empty_q>
    1a3d:	85 c0                	test   %eax,%eax
    1a3f:	75 5d                	jne    1a9e <pop_q+0x72>
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	8b 40 04             	mov    0x4(%eax),%eax
    1a47:	8b 00                	mov    (%eax),%eax
    1a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	8b 40 04             	mov    0x4(%eax),%eax
    1a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	8b 40 04             	mov    0x4(%eax),%eax
    1a5b:	8b 50 04             	mov    0x4(%eax),%edx
    1a5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a61:	89 50 04             	mov    %edx,0x4(%eax)
    1a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a67:	89 04 24             	mov    %eax,(%esp)
    1a6a:	e8 b5 fb ff ff       	call   1624 <free>
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	8b 00                	mov    (%eax),%eax
    1a74:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a77:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7a:	89 10                	mov    %edx,(%eax)
    1a7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7f:	8b 00                	mov    (%eax),%eax
    1a81:	85 c0                	test   %eax,%eax
    1a83:	75 14                	jne    1a99 <pop_q+0x6d>
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1a99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a9c:	eb 05                	jmp    1aa3 <pop_q+0x77>
    1a9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1aa3:	c9                   	leave  
    1aa4:	c3                   	ret    
